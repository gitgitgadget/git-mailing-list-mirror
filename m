From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add -r flag to show-diff for diff-cache/diff-tree like
 output.
Date: Tue, 26 Apr 2005 17:05:46 -0700
Message-ID: <7vd5shkrs5.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0504232202340.19877@ppc970.osdl.org>
	<7v1x8zsamn.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504251832480.18901@ppc970.osdl.org>
	<7vy8b5mawy.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504261534590.18901@ppc970.osdl.org>
	<7vd5shm94l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504261639420.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 27 02:01:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQZz9-0004dx-N6
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 02:01:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261856AbVD0AF4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 20:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbVD0AF4
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 20:05:56 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:38650 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261856AbVD0AFs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2005 20:05:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050427000546.CVZH23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 26 Apr 2005 20:05:46 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504261639420.18901@ppc970.osdl.org> (Linus
 Torvalds's message of "Tue, 26 Apr 2005 16:44:38 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

>> Later I'll add -p flag to diff-cache and diff-tree, so the usage
>> of these three commands match.

LT> The thing is, "-p" is strictly weaker than doing the UNIX
LT> pipe way, since the latter trivially does the same time (add
LT> a simple script if you don't want to type it), but can also
LT> do things like "grep the filenames going past" or similar.

I do not disagree with that.  Having only "-p" and not having
diff-cache/tree output _is_ weaker, and I am _not_ advocating
for removing the diff-cache/tree like output format from these
three commands.

What I _am_ advocating for is to obsolete the diff-tree-helper
program.  What it does can be done, with the diff.[ch] change
you merged this morning, without going through a pipe to the
diff-tree-helper process but directly from these three commands,
once diff-cache/tree acquires the "-p" flag.

By the way, how about renaming show-diff to diff-file?

    diff-tree  : compares two trees.
    diff-cache : compares a tree and the cache, or a tree and files.
    diff-file  : compares the cache and files.

