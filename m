X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Allow '-' in config variable names
Date: Mon, 30 Oct 2006 14:45:17 -0800
Message-ID: <7vodrtv2wy.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0610300823250.25218@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 30 Oct 2006 22:45:30 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0610300823250.25218@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 30 Oct 2006 08:25:36 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30543>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gefsg-0005Xq-Hv for gcvg-git@gmane.org; Mon, 30 Oct
 2006 23:45:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422726AbWJ3WpT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 17:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422728AbWJ3WpT
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 17:45:19 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:4815 "EHLO
 fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP id S1422726AbWJ3WpS
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 17:45:18 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061030224517.WUXA18985.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>; Mon, 30
 Oct 2006 17:45:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id gmky1V0091kojtg0000000 Mon, 30 Oct 2006
 17:44:58 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> I need this in order to allow aliases of the same form as "ls-tree", 
> "rev-parse" etc, so that I can use
>
> 	[alias]
> 		my-cat=--paginate cat-file -p
>
> to add a "git my-cat" command.

I do not have problem with this (and would perhaps also want to
add '_' to keychar set), but people who envisioned parsing
config from scripts (i.e. Perly git) might prefer if we stayed
within alnum, since I'd suspect then they may be able to reuse
existing .ini parsers.  I do not much care about that myself,
but I am bringing it up just in case other people might.

Other than that, this sounds nice.

By the way, everybody seems to do "alias.xxx = -p cat-file -p"
(I have it as "git less").  Maybe we would want to make a
built-in alias for that?
