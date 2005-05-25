From: Junio C Hamano <junkio@cox.net>
Subject: Re: change of git-diff-tree and symlinks
Date: Wed, 25 May 2005 15:43:14 -0700
Message-ID: <7v7jhnhqpp.fsf@assigned-by-dhcp.cox.net>
References: <20050525111711.GA27492@vrfy.org>
	<Pine.LNX.4.58.0505251054110.2307@ppc970.osdl.org>
	<20050525183546.GA4241@vrfy.org>
	<7vzmujjdq4.fsf@assigned-by-dhcp.cox.net>
	<20050525222622.GA8552@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 26 00:42:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Db4ZD-00027a-BV
	for gcvg-git@gmane.org; Thu, 26 May 2005 00:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbVEYWnV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 18:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbVEYWnV
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 18:43:21 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:24256 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261583AbVEYWnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2005 18:43:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050525224314.IAVS8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 25 May 2005 18:43:14 -0400
To: Kay Sievers <kay.sievers@vrfy.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "KS" == Kay Sievers <kay.sievers@vrfy.org> writes:

KS> If we introduce 'T', how is a content _and_ a type change represented
KS> if they happen at the same time?

If you have this pair in two trees:

    ln -s frotz xyzzy
    echo -n frotz >xyzzy

it is a 'T'.  If you instead have these in two trees:

    ln -s rezrov xyzzy
    echo -n frotz >xyzzy

it is also a 'T'.

I do not think we would want patch format to give us a diff
showing that string rezrov changing into frotz in the latter
example anyway.  When we have a type change, content change is
irrelevant.

