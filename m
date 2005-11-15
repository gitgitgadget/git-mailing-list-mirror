From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] GIT commit statistics.
Date: Mon, 14 Nov 2005 19:00:08 -0800
Message-ID: <7vy83qty2v.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org>
	<7v4q6ilt3m.fsf@assigned-by-dhcp.cox.net>
	<43758D21.3060107@michonline.com>
	<7v7jbeia3v.fsf_-_@assigned-by-dhcp.cox.net>
	<46a038f90511120419v70166c60t93d58b7544e03e3b@mail.gmail.com>
	<7vy83s95k0.fsf@assigned-by-dhcp.cox.net>
	<46a038f90511131242p4692c74fn20c015998620b9f4@mail.gmail.com>
	<7vlkzr6gzz.fsf@assigned-by-dhcp.cox.net>
	<46a038f90511132001x6a9109fk17593b7ceaf3177e@mail.gmail.com>
	<7vwtjb4vc4.fsf@assigned-by-dhcp.cox.net>
	<46a038f90511140051o1fa5ef7cyb9dd723fb8161ef9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 04:02:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ebr3Q-0004LS-4s
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 04:00:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbVKODAM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 22:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbVKODAM
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 22:00:12 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:59361 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932302AbVKODAK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 22:00:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051115025913.ZWIJ26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 14 Nov 2005 21:59:13 -0500
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90511140051o1fa5ef7cyb9dd723fb8161ef9@mail.gmail.com>
	(Martin Langhoff's message of "Mon, 14 Nov 2005 21:51:29 +1300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11873>

Martin Langhoff <martin.langhoff@gmail.com> writes:

>> I've never felt need to "merge" the binary files myself and had
>> never got around doing this, but if you are interested, it would
>> go something like this:
>
> That's quite a bit of C hacking...

I'll be pushing out something along the lines I said in the
proposed updates branch tonight.  I've even run 1 (one) test
;-).  The relevant commits are these:

+  [pu~5^2] rebase: make it usable for binary files as well.
+  [pu~5^2^] diff: --full-index
+  [pu~5^2~2] apply: allow-binary-replacement.
+  [pu~5^2~3] Rewrite rebase to use git-format-patch piped to git-am.

Note that this does not make generated "binary patch" usable
across repositories yet.  Since our patches are reversible out
of principle, making it usable across repositories involves
recording both the pre- and post-image of binary blobs in the
patch output, which may be a useful option in some cases but not
necessary for the immediate application of intra-repo rebasing.
