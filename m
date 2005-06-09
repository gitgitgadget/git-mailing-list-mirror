From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] read-tree -m 3-way: handle more trivial merges
 internally
Date: Thu, 09 Jun 2005 10:26:35 -0700
Message-ID: <7v7jh3phkk.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0506081336080.2286@ppc970.osdl.org>
	<7vis0o30sc.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506081629370.2286@ppc970.osdl.org>
	<7voeagrp11.fsf_-_@assigned-by-dhcp.cox.net>
	<7v64woroui.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506090800580.2286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 19:27:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgQjh-0008FB-Hv
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 19:22:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262416AbVFIR0j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 13:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbVFIR0j
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 13:26:39 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:25066 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S262416AbVFIR0i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2005 13:26:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050609172637.ZSCS19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Jun 2005 13:26:37 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506090800580.2286@ppc970.osdl.org> (Linus
 Torvalds's message of "Thu, 9 Jun 2005 08:15:52 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> No, I think this is quite possibly wrong for several reasons.

I agree with everything you said.

I need to regurgitate other points you raised, but one immediate
comment on the "lost remove" case.  The current two-way code has
the same brokenness in that it does not unlink removed files
under "-u".  We either need the "list of files to be removed",
or we need to make two-way abort if we see these "remove" cases.

