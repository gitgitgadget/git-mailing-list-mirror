From: Junio C Hamano <junkio@cox.net>
Subject: Re: Recursive remove
Date: Fri, 13 Jan 2006 11:51:24 -0800
Message-ID: <7vslrr6h4z.fsf@assigned-by-dhcp.cox.net>
References: <20060113132119.GB23655@ebar091.ebar.dtu.dk>
	<7virso9ggd.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP08F3875A7636E18401E7B3AE260@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 20:53:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExUzM-0003Ls-Nw
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 20:53:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422908AbWAMTvd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jan 2006 14:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422914AbWAMTvc
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jan 2006 14:51:32 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:967 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1422908AbWAMTv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2006 14:51:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060113195034.CHNA3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 13 Jan 2006 14:50:34 -0500
To: sean <seanlkml@sympatico.ca>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14642>

sean <seanlkml@sympatico.ca> writes:

> On Fri, 13 Jan 2006 09:37:54 -0800
> Junio C Hamano <junkio@cox.net> wrote:
>> 
>> 	$ rm -fr Some/Dir; git commit -a -m 'Remove'
>> 
>> perhaps?
>
> Sigh, its been a humbling morning all around; can't get easier than that.

Perhaps this is because I did not do a good job in
Documentation/git-commit.txt.  Something like this?

-- >8 --
Documentation: git-commit -a

A bit more elaboration on what "update all paths" means.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index e0ff74f..e35984d 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -25,7 +25,9 @@ information.
 OPTIONS
 -------
 -a|--all::
-	Update all paths in the index file.
+	Update all paths in the index file.  The command with this flag
+	notices files that have been modified and deleted, but new files
+	you have not told about git are not affected.
 
 -c or -C <commit>::
 	Take existing commit object, and reuse the log message
