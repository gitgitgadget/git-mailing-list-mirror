From: Junio C Hamano <junkio@cox.net>
Subject: Re: Complete http-pull; where should it go?
Date: Sun, 01 May 2005 19:03:28 -0700
Message-ID: <7v4qdmqt8v.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.21.0505011656270.30848-100000@iabervon.org>
	<Pine.LNX.4.58.0505011616230.22864@ppc970.osdl.org>
	<Pine.LNX.4.58.0505011638370.22864@ppc970.osdl.org>
	<7vsm16qyia.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505011840590.2162@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org,
	Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Mon May 02 04:01:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSQEq-0001dv-2B
	for gcvg-git@gmane.org; Mon, 02 May 2005 04:00:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbVEBCET (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 22:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261698AbVEBCEB
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 22:04:01 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:28912 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261741AbVEBCDf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2005 22:03:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050502020328.ZLVF7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 1 May 2005 22:03:28 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505011840590.2162@ppc970.osdl.org> (Linus
 Torvalds's message of "Sun, 1 May 2005 18:50:13 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> Hmm.. I actually implemented it, because it's simple to
LT> implement, but now that I've tried using it, I just find it
LT> to be too much like line noise to do

LT> 	git-diff-tree -p 0-HEAD HEAD

LT> for "parent to current". The notation "-HEAD" also works,
LT> but since that looks like a command line flag, it's usually
LT> not useful, except when combined with other stuff, ie
LT> "0---HEAD" is "three parents up".

That's why I said I do not think this belongs to the Plumbing.

JIT command-line would do just "jit-diff" to get the diff
between the work tree and the commit (or snapshot) it is based
upon, without parameter.  Fully spelled out, it would be
"jit-diff -1:1".  This kind of syntax, although is quite useful
in JIT context (e.g. saying "jit-patch --2" to mean "apply
changes between snnapshot 2 and two parents up of it to my
current work tree"), I tend to agree that it is a bit too weird
for the core Plumbing layer, for which Unixy syntax is more
suitable.

