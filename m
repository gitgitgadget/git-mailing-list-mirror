From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Wed, 15 Mar 2006 14:13:29 -0800
Message-ID: <7vk6avgxva.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Mar 15 23:13:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJeFL-0000KE-Vv
	for gcvg-git@gmane.org; Wed, 15 Mar 2006 23:13:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811AbWCOWNc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Mar 2006 17:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751823AbWCOWNc
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Mar 2006 17:13:32 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:50161 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751811AbWCOWNb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Mar 2006 17:13:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060315221209.PNYG3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 15 Mar 2006 17:12:09 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17619>

* The 'master' branch has these since the last announcement.

 - git-svn updates (Eric Wong)
 - git-blame knows about renames (Fredrik Kuivinen)
 - imap-send (Mike McCormack with fixes from Johannes Schindelin
   and Marco Roeland)
 - cvsimport only updates tracking branch (Matthias Urlichs)
 - repo-config fix (Jonas Fonseca)
 - fmt-merge-msg cleanup (Linus Torvalds)
 - format-patch attachments enhancements (Mike McCormack)
 - delitifier cleanup and performance fix (Nicolas Pitre)
 - remove end-of-line period from git-pull message (Olaf Hering)
 - http-push and fetch updates (Nick Hengeveld)
 - rev-list and revision walker performance fix (Matthias Urlichs)
 - annotate RPM packaging workaround (sean)
 - assorted doc fixes (Francis Daly, Fredrik Kuivinen)
 - assorted test fixes (Mark Wooding, me)
 - improve git wrapper --help output (Fredrik Kuivinen)
 - checkout-index --temp (Shawn Pearce)
 - no more --standalone to fsck-objects
 - rev-list path limiter fix at boundary
 - git-diff: -p disables rename detection

As you can see from the above, the core part does not have
drastic changes these days anymore.  Just some boring fixes with
a handful new and interesting developments.

In the "next" branch is the "insanely fast rename detection".
I've done some minor fixups to its hash function to be usable on
both 32-bit and 64-bit machines but otherwise it is what was
posted by Linus to the list.  It completes the rename detection
between v2.6.12 and v2.6.14 kernel source under 5 seconds on my
Duron 750 with slow disks, where the current "master" branch
version takes about 60 seconds.

Also I've been keeping ls-{tree,files} --abbrev patches and
refs/remotes patch from Eric Wong in 'next' and 'pu'.  I haven't
seen anybody jumps up and down to have them merged to "master",
nor have been asked to push them out sooner so that a widely
used Porcelain or two can take advantage of them, and that's the
only reason why they are not in "master".  In other words, while
I do not have much against them, it would be nicer to have a
convincing argument why they are must-have's or even
better-have's before they graduate.
