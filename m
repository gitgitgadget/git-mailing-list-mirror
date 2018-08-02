Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 979321F597
	for <e@80x24.org>; Thu,  2 Aug 2018 20:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbeHBV6k (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 17:58:40 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55730 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbeHBV6k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 17:58:40 -0400
Received: by mail-wm0-f65.google.com with SMTP id f21-v6so3854851wmc.5
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 13:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=8NdToFd16E0QvYpsB/AHGPFiMpOL2uKlCRBM4rllUJQ=;
        b=CnweVlRFExNoHq3nq/Az5dyVs6OWDGEn1X+xA2CgNTsZ2LUyFiNqdrrSqwBOagqs9a
         VYechB+xRWn9grpF0khqJkHsCZgrnhIaZS5s9VkVfI9VniiV/nwxx95ySWyl9HMYPDY0
         B+DHSgsUd1HAwQkQOOXhc8yTxHcKmHOv1hj0s67KAVDZI51vAoPoq2rEeReNUmTKJkge
         wF0auXf8gXxV6tu8AbN0vpDW6bhBeY0xlIWEtzS0QZW2/7LYJ5KBAVNlzBEQOwpxKoBr
         Xk3FAeC/nus/oBNKDJU2IaCglNQV3M9TMU0L9N19pEWEGvT5UIlHZRDVxJN0Hel3RacC
         rEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=8NdToFd16E0QvYpsB/AHGPFiMpOL2uKlCRBM4rllUJQ=;
        b=YkQ68CfKSg2JJqacGVZfWZWKx2SMRXYqZ9Dm733P2aeYeFzzAWKGQbinOwxMCTLaDa
         1GiZh5SpVntrIKKojO1EwyUNByJ/kB3NGYvK6FPqB+eDLpS7sxUMaiXow6ynDpXL++G9
         81H1TRnMRhWB93ljhTuZ6CBOV392ozaMJQSqnI+ToIpoOHX+Np61YRLI+MGnosDWtUHo
         gjQAfsP66l+rmWVG0bMS+TWZmN9XHU+JB4+qFGVSpgVPjTZKVSF5fNSAlIMj2M0Of76H
         35Z/Fgzcq7kI1SdqxnB6aV64okMxOOISQgMuYYtTnJfnLTl5IeKSXUSrifLgJpPfS6fO
         dYmw==
X-Gm-Message-State: AOUpUlENZCcWwG95RcqX7PQzJfqpxDe7coIEkhjIXi32xUdPTK/m1Z1u
        2VzeG4+IVOO1AtAUGnR1eEQes2tC
X-Google-Smtp-Source: AAOMgpfZSgAxOaZyK75ww9IWnOSzKK2Av9fPiPykylFdPU/pqUaoF8sCD+D5z/S476Jd4yNWQg1WOA==
X-Received: by 2002:a1c:c241:: with SMTP id s62-v6mr3040987wmf.146.1533240358427;
        Thu, 02 Aug 2018 13:05:58 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e137-v6sm4389112wma.20.2018.08.02.13.05.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 13:05:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 6/6] parse-options: automatically infer PARSE_OPT_LITERAL_ARGHELP
References: <xmqqh8ke6i7w.fsf@gitster-ct.c.googlers.com>
        <87k1p9u860.fsf@evledraar.gmail.com>
        <xmqqwot969mp.fsf@gitster-ct.c.googlers.com>
        <87h8kdu3ay.fsf@evledraar.gmail.com>
        <30a6105c-4cb7-b52f-0b0a-c4504b90a5b1@web.de>
        <xmqqftzw4weq.fsf@gitster-ct.c.googlers.com>
        <20180802165457.GC15984@sigill.intra.peff.net>
        <ad2d8f99-07a3-0191-88a2-c43081657988@web.de>
        <757ca573-3954-9c31-8a7b-56a2de8e3793@web.de>
Date:   Thu, 02 Aug 2018 13:05:57 -0700
In-Reply-To: <757ca573-3954-9c31-8a7b-56a2de8e3793@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 2 Aug 2018 21:18:14 +0200")
Message-ID: <xmqqva8szg7u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> diff --git a/parse-options.c b/parse-options.c
> index 7db84227ab..3b874a83a0 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -660,7 +660,8 @@ int parse_options(int argc, const char **argv, const char *prefix,
>  static int usage_argh(const struct option *opts, FILE *outfile)
>  {
>  	const char *s;
> -	int literal = (opts->flags & PARSE_OPT_LITERAL_ARGHELP) || !opts->argh;
> +	int literal = (opts->flags & PARSE_OPT_LITERAL_ARGHELP) ||
> +		!opts->argh || !!strpbrk(opts->argh, "()<>[]|");

Good that you did not include '-' in there, as that would have
broken a multi-word-placeholder.

All other changes in this patch looked sensible, too.
