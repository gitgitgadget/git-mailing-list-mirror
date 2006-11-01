X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Introduce git-mirror, a tool for exactly mirroring another repository.
Date: Tue, 31 Oct 2006 16:32:12 -0800
Message-ID: <7vac3covlf.fsf@assigned-by-dhcp.cox.net>
References: <20060925044641.GB15757@spearce.org>
	<20061031174225.3c7c1e77.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 1 Nov 2006 00:32:29 +0000 (UTC)
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Shawn Pearce <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061031174225.3c7c1e77.vsu@altlinux.ru> (Sergey Vlasov's
	message of "Tue, 31 Oct 2006 17:42:25 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30612>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gf41i-0002Z6-0G for gcvg-git@gmane.org; Wed, 01 Nov
 2006 01:32:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946245AbWKAAcP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 31 Oct 2006
 19:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946246AbWKAAcP
 (ORCPT <rfc822;git-outgoing>); Tue, 31 Oct 2006 19:32:15 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:207 "EHLO
 fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP id S1946245AbWKAAcO
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 31 Oct 2006 19:32:14 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061101003213.WCBZ18180.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>; Tue, 31
 Oct 2006 19:32:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id hCYH1V00M1kojtg0000000 Tue, 31 Oct 2006
 19:32:18 -0500
To: Sergey Vlasov <vsu@altlinux.ru>
Sender: git-owner@vger.kernel.org

Sergey Vlasov <vsu@altlinux.ru> writes:

> What is the current state of packed-refs implementation?

Scheduled for "master" probably tomorrow, with some disclaimers.

> BTW, I was thinking about the possibility to save removed refs under,
> e.g., refs/old/`date -I`/; maybe even non-fast-forward refs could be
> saved there - this will ensure that no object will ever disappear from
> the mirror, no matter what is done on the master side.  Obviously, in
> this case remote refs like refs/old/* should be filtered.

I do not think that belongs to git-mirror.  It might be better to
have that option in update-ref machinery so that you would even
be protected from a `git branch -d` ran by mistake.
