Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 572032047F
	for <e@80x24.org>; Mon,  7 Aug 2017 18:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751775AbdHGSGg (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 14:06:36 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:59978 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751505AbdHGSGf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 14:06:35 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 3xR57r40GZz1qrMr;
        Mon,  7 Aug 2017 20:06:32 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 3xR57r34WRz3jgXr;
        Mon,  7 Aug 2017 20:06:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id I30-C7Kkyd8g; Mon,  7 Aug 2017 20:06:31 +0200 (CEST)
X-Auth-Info: Wwqb3djsdm0OGSzXtkIHyShXL/IYX+2rujdoyhFedQvLXhsLTdSDmbFJoXkxTRpP
Received: from igel.home (ppp-88-217-7-212.dynamic.mnet-online.de [88.217.7.212])
        (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon,  7 Aug 2017 20:06:31 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id C0D492C4005; Mon,  7 Aug 2017 20:06:28 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        David Coppa <dcoppa@openbsd.org>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH] tests: don't give unportable ">" to "test" built-in, use -gt
References: <20170806233850.14711-1-avarab@gmail.com>
X-Yow:  I've read SEVEN MILLION books!!
Date:   Mon, 07 Aug 2017 20:06:28 +0200
In-Reply-To: <20170806233850.14711-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sun, 6 Aug 2017 23:38:50 +0000")
Message-ID: <87h8xjfe1n.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Aug 06 2017, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:

> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index 0ef7b94394..0e2e57aa3d 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -1887,7 +1887,7 @@ EOF"
>  	run_with_limited_stack git tag --contains HEAD >actual &&
>  	test_cmp expect actual &&
>  	run_with_limited_stack git tag --no-contains HEAD >actual &&
> -	test_line_count ">" 10 actual
> +	test_line_count "-gt" 10 actual

Maybe also remove the quotes, they are no longer needed.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
