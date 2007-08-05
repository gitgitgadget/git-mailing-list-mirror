From: Junio C Hamano <gitster@pobox.com>
Subject: Re: way to automatically add untracked files?
Date: Sat, 04 Aug 2007 22:04:55 -0700
Message-ID: <7vzm16h8qw.fsf@assigned-by-dhcp.cox.net>
References: <873ayymzc1.fsf@catnip.gol.com>
	<fc339e4a0708042100jdf0a0f1jd1fddfb5dc1c1052@mail.gmail.com>
	<20070805041320.GH9527@spearce.org> <87lkcqlif2.fsf@catnip.gol.com>
	<7v8x8qip7n.fsf@assigned-by-dhcp.cox.net>
	<87d4y2li2c.fsf@catnip.gol.com>
	<7v4pjeioi6.fsf@assigned-by-dhcp.cox.net>
	<874pjelgyz.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 07:05:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHYIZ-0005N1-NN
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 07:05:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360AbXHEFE5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 01:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752188AbXHEFE5
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 01:04:57 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:44278 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131AbXHEFE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 01:04:56 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070805050457.PWUL23215.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sun, 5 Aug 2007 01:04:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Y54v1X00E1kojtg0000000; Sun, 05 Aug 2007 01:04:56 -0400
In-Reply-To: <874pjelgyz.fsf@catnip.gol.com> (Miles Bader's message of "Sun,
	05 Aug 2007 13:53:40 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54947>

Miles Bader <miles@gnu.org> writes:

> Anyway, I wouldn't be complaining except that I _keep_ running into
> circumstances where I need to type "git-add NEWFILE1 NEWFILE2
> NEWFILE3...; git rm OLD_FILE1..." -- which is kind of annoying after
> seeing a list of _exactly_ the files I need to add/remove output just
> previously by git-status.  Thus my wish to have git "do it
> automatically."

As Linus explained in another thread, "git rm" is largely
unneeded.  Just work with the filesystem in normal UNIX way, and
be done with "git add -u" or even "git commit -a" and you will
be fine.

If you are more perfect than most other people in maintaining
the .gitignore file, you do not even have to name individual
files like "git add NEWFILE1..." -- you can always safely run
"git add .".

Most of us are not as perfect as you are, as you might have
noticed that Randal pointed out this morning that we missed a
new entry from our own .gitignore ;-) I highly suspect that we
will be hated by most of our users if we changed "git add -u" to
add everything in sight for this reason, and I also suspect they
will feel that "git add-remove --all" will be code bloat for
little gain.
