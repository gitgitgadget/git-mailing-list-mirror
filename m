From: Junio C Hamano <junkio@cox.net>
Subject: Re: diff against a tag ?
Date: Thu, 28 Apr 2005 14:28:38 -0700
Message-ID: <7vwtqm616h.fsf@assigned-by-dhcp.cox.net>
References: <20050428200953.GD8514@redhat.com>
	<7vpswe7hvj.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504281358060.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dave Jones <davej@redhat.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 23:23:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRGTU-00046N-4G
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 23:23:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262209AbVD1V2l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 17:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262218AbVD1V2l
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 17:28:41 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:34182 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S262209AbVD1V2k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 17:28:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050428212839.TYYQ7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 28 Apr 2005 17:28:39 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504281358060.18901@ppc970.osdl.org> (Linus
 Torvalds's message of "Thu, 28 Apr 2005 14:01:40 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> Right now fsck is the only thing that reports tags that aren't referenced 
LT> some other way. Once you know the tag, things are easy - even without 
LT> Junio's patch you can just do
LT> 	object=$(cat-file tag $tag | sed 's/object //;q')
LT> and then you can just do
LT> 	diff-tree $object $(cat .git/HEAD)
LT> or whatever you want to do.

Of course you are right.  The patch is about skipping the first
step and requiring you to know what you have is a tag not a
commit.

LT> Dave: do a "fsck --tags" in your tree, and it will talk about the tags it
LT> finds. Then you can create files like .git/refs/tags/v2.6.12-rc2 that
LT> contain pointers to those tags..

Arrrrrrrrrgh!  I just did "fsck --tags" blindly X-<.  Good thing
I was not root.

Of course you meant "fsck-cache --tags" ;-).

