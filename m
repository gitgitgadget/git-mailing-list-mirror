Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F956208B4
	for <e@80x24.org>; Tue,  8 Aug 2017 06:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751913AbdHHGZ2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 02:25:28 -0400
Received: from vie01a-dmta-pe07-1.mx.upcmail.net ([84.116.36.17]:33824 "EHLO
        vie01a-dmta-pe05-1.mx.upcmail.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751698AbdHHGZ1 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 8 Aug 2017 02:25:27 -0400
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
        by vie01a-dmta-pe07.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <martin.koegler@chello.at>)
        id 1dexxF-0004yi-KT
        for git@vger.kernel.org; Tue, 08 Aug 2017 08:25:25 +0200
Received: from master.zuhause ([80.108.242.240])
        by vie01a-pemc-psmtp-pe02 with SMTP @ mailcloud.upcmail.net
        id uWRP1v00s5BuuEg01WRQZC; Tue, 08 Aug 2017 08:25:24 +0200
X-SourceIP: 80.108.242.240
Received: by master.zuhause (Postfix, from userid 1006)
        id 3EF7145D4512; Tue,  8 Aug 2017 08:25:23 +0200 (CEST)
Date:   Tue, 8 Aug 2017 08:25:23 +0200
From:   Martin Koegler <martin.koegler@chello.at>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Martin Koegler <martin.koegler@chello.at>, git@vger.kernel.org
Subject: Re: [PATCH] Fix delta integer overflows
Message-ID: <20170808062522.GB4091@mail.zuhause>
References: <1502129437-31226-1-git-send-email-martin@mail.zuhause>
 <xmqq1sonql76.fsf@gitster.mtv.corp.google.com>
 <xmqqvalyn89b.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqvalyn89b.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 07, 2017 at 06:44:16PM -0700, Junio C Hamano wrote:
> Having said that, I am a bit curious how you came to this patch.
> Was the issue found by code inspection, or did you actually have a
> real life use case to raise the core.bigFileThreshold configuration
> to a value above 4GB?

Real life use - tracking changes in larger files.

Raising the limit above 4GB suddenly resulted in a broken pack files in the repository and
aborts of various git commands.

Data is still recoverable with all size sanity checks disabled.

Regards,
Martin
