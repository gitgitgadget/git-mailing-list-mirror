From: Junio C Hamano <gitster@pobox.com>
Subject: Re: problem after cvsimport
Date: Wed, 25 Jul 2007 20:07:32 -0700
Message-ID: <7vlkd3c16z.fsf@assigned-by-dhcp.cox.net>
References: <46A7FD99.9000305@tplogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bert Douglas <bertd@tplogic.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 05:07:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDthQ-0003ge-K1
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 05:07:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756550AbXGZDHe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 23:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756354AbXGZDHe
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 23:07:34 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:39359 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755549AbXGZDHd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 23:07:33 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070726030733.YQXG1349.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Wed, 25 Jul 2007 23:07:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id U37Y1X0041kojtg0000000; Wed, 25 Jul 2007 23:07:32 -0400
In-Reply-To: <46A7FD99.9000305@tplogic.com> (Bert Douglas's message of "Wed,
	25 Jul 2007 20:49:13 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53751>

Bert Douglas <bertd@tplogic.com> writes:

> I am new to git, so probably doing something wrong.
> Hope somebody can enlighten me.
> Here is what happened so far.
>
> Followed instructions here:
> http://www.kernel.org/pub/software/scm/git/docs/cvs-migration.html
>
> Did command like this:
>
> $ git cvsimport -C <destination> <module>
>
> This was done from top level of existing cvs working directory.
> Destination was new empty directory, outside the cvs tree.
>
> It worked for several hours and seemed to complete ok.
> I can look at history in destination git directory with gitk and git log.
> All the stuff in ".git" looks normal, as far as I can tell.
>
> But I have no files in the working directory.
> When I do command:
> $git checkout master
>
> I get a bunch of lines to console with "D" in front.
> Btw, what does that mean?  Nothing about it in "man git-checkout" or elsewhere that I can find.
> Then it says -- Already on branch "master"
>
> But working directory is still empty.

Have you tried "git checkout -f" after that?  With recent enough
git, "git cvsimport -C <destination> <module>" from the top
level of existing cvs working directory, with nonexistent
destination directory (that is, you let "git cvsimport -C" to
create that destination directory) would run "git checkout -f"
for you.
