From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] git-commit: Reformat log messages provided on commandline
Date: Wed, 9 May 2007 16:24:26 +0200
Message-ID: <20070509142426.GV4489@pasky.or.cz>
References: <vpqwszm9bm9.fsf@bauges.imag.fr> <Pine.LNX.4.64.0705061851411.4015@racer.site> <vpqk5vlamav.fsf@bauges.imag.fr> <7vvef5c0fw.fsf@assigned-by-dhcp.cox.net> <20070509125225.GP4489@pasky.or.cz> <Pine.LNX.4.64.0705091513360.4167@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 09 16:24:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hln5l-0004PM-NT
	for gcvg-git@gmane.org; Wed, 09 May 2007 16:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754370AbXEIOY3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 10:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754868AbXEIOY3
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 10:24:29 -0400
Received: from w241.dkm.cz ([62.24.88.241]:38815 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754370AbXEIOY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 10:24:28 -0400
Received: (qmail 25356 invoked by uid 2001); 9 May 2007 16:24:26 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0705091513360.4167@racer.site>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46720>

  Hi,

On Wed, May 09, 2007 at 03:57:28PM CEST, Johannes Schindelin wrote:
> Another reason is that you can see how the end result will look like in an 
> editor. For example, you'll have a hard time making sure in the 
> command line that the lines are no longer than 76 characters.

  oh, indeed - good point. cg-commit uses fmt to format the message, I
think git-commit should do the same; let's see how controversial such a
change would be.

---
This makes git-commit filter log messages provided on commandline by fmt,
thus making nice paragraphs from them. This makes it possible to specify
even long commit messages on command line without worrying about this, akin
to cg-commit.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 git-commit.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-commit.sh b/git-commit.sh
index f28fc24..28cbb55 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -432,7 +432,7 @@ fi
 
 if test "$log_message" != ''
 then
-	echo "$log_message"
+	echo "$log_message" | fmt
 elif test "$logfile" != ""
 then
 	if test "$logfile" = -


-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
