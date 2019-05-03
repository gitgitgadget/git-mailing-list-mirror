Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 141841F453
	for <e@80x24.org>; Fri,  3 May 2019 08:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfECIhM (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 May 2019 04:37:12 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:46291 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfECIhL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 May 2019 04:37:11 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 48E9B3C00C1;
        Fri,  3 May 2019 10:37:10 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Iti5MGPYrklc; Fri,  3 May 2019 10:37:03 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 6EB373C0034;
        Fri,  3 May 2019 10:37:03 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 3 May 2019
 10:37:03 +0200
Date:   Fri, 3 May 2019 10:37:00 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [PATCH 2/2] diffcore-pickaxe: add --pickaxe-raw-diff for use
 with -G
Message-ID: <20190503083700.GA6115@vmlxhi-102.adit-jv.com>
References: <87o94vs9cp.fsf@evledraar.gmail.com>
 <20190424224539.GA23849@vmlxhi-102.adit-jv.com>
 <87mukfrnp3.fsf@evledraar.gmail.com>
 <xmqqsgu6zzev.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <xmqqsgu6zzev.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.93.184]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 25, 2019 at 09:44:40AM +0900, Junio C Hamano wrote:
[..]
> So the user would be able to say something like
> 
> 	git log -Ux --since=6.months |
> 	git patch-grep \
> 		--commit-names-only \
> 		--all-match \
> 		-e '+.*devm_request_threaded_irq(IRQF_SHARED)' \
>                 -e '-.*devm_request_threaded_irq(IRQF_ONESHOT)' |
> 	xargs git show --oneline -s
[..]

JFTR/FWIW, this looks quite user friendly to me, but I believe users
like me can (and likely do) already handcraft their own variants of
'git patch-grep', since the above model implies piping (as opposed to
in-git processing done by --pickaxe-raw-diff).

-- 
Best Regards,
Eugeniu.
