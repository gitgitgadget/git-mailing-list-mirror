From: Junio C Hamano <gitster@pobox.com>
Subject: Re: way to automatically add untracked files?
Date: Sat, 04 Aug 2007 21:39:13 -0700
Message-ID: <7v4pjeioi6.fsf@assigned-by-dhcp.cox.net>
References: <873ayymzc1.fsf@catnip.gol.com>
	<fc339e4a0708042100jdf0a0f1jd1fddfb5dc1c1052@mail.gmail.com>
	<20070805041320.GH9527@spearce.org> <87lkcqlif2.fsf@catnip.gol.com>
	<7v8x8qip7n.fsf@assigned-by-dhcp.cox.net>
	<87d4y2li2c.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 06:39:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHXtg-00025b-FP
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 06:39:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640AbXHEEjS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 00:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751572AbXHEEjR
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 00:39:17 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:51641 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbXHEEjR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 00:39:17 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070805043917.HDUZ14885.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sun, 5 Aug 2007 00:39:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Y4fG1X00E1kojtg0000000; Sun, 05 Aug 2007 00:39:16 -0400
In-Reply-To: <87d4y2li2c.fsf@catnip.gol.com> (Miles Bader's message of "Sun,
	05 Aug 2007 13:30:03 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54942>

You are talking about two different operations.

Adding _new_ files, unless you are just beginning a new project,
are much more rare than updating modified files that you are
already tracking; and "git add new-file..." is what people
usually use for the former.  "git add ." is almost always the
"initial import" and not used later (after all you ought to know
what files you are creating and controlling ;-)).  You get into
an illusion that that is often used, only when you have just
started.  As your project progresses, that feeling will fade
away.

And that is natural, if you think about it for 5 seconds.

"Add everything in sight, although I do not know what they are",
which is essentially what "git add ." is, makes perfect sense
for the initial import and vendor drop (after perhaps rm -fr
?*).  If you are doing your own development, with your working
tree littered with build products and temporary notes files and
whatnot, "git add ." is usually the last thing you would want to
do.

Updating modified files, "git add -u", is more like "git commit
-a" (without creating commit).  You do not add _new_ files, and
that is quite deliberate.

You _could_ argue that people should be more disciplined and
write perfect .gitignore files so that "git add ." is always
safe, but the world does not work that way.
