Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 231271F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 18:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390174AbeKQEnI (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 23:43:08 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55958 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbeKQEnI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 23:43:08 -0500
Received: by mail-wm1-f68.google.com with SMTP id y139so5646344wmc.5
        for <git@vger.kernel.org>; Fri, 16 Nov 2018 10:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DJhc0UcUnvdd+Ip4XGAjHNtjdtyW+zjVBNr44q2VBy0=;
        b=AdRXb50rN336zsLtI9XPHoZYrKwpZbKWtfOINLpcGwniGleGcg7JQqAXOWZc3GfWU4
         fiWLBLhXYUIK4jy2J0/uGC8Q7JBB1rYuZiUuttjkAXmpxbfVjsH4RZFSotJBU4Mtq9eV
         kqdT86B+fZxIyt8uNElxcz4O5gcs4MqGWk6W9A/5yKgqSYyCJjSD2m1FZWMxDxUCUr3q
         G8h53Nk+GOgGdLizQoW82rkVPmDHNvikiRkfZt7fMFAZz5ZrPKeH7aFrLn2+maW/w4dC
         Yr3Ni33Ht9uEfdksyHAEnLfu9O8BtFpuCMmFrQEsLp9r4RG+82mYYz+wswp23nm9+Z8t
         dLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DJhc0UcUnvdd+Ip4XGAjHNtjdtyW+zjVBNr44q2VBy0=;
        b=EmV6S/Jb1alCDaYoEXRoyy7QxUThQCrC45IJMWKN7JV3zXvdR5hOisloME1oL+B7YI
         oqf3YrkDTBFhOWd6z0hVePOYNo/TypnZD0WQN3H0p2V52oZIj8D0Tx1gqetnZBLMsIVv
         4QWlPSE8DGh56aTre9mUUwO12GFFeFsU0FI/cHGMU+3T3QdaOlo32Ij/szEn0gNLLp23
         wRoyPgFE1tBl2GRGh/TTJ2QJf0PboVMvB6aFCRaQOigx7P3QGaSmY/8noNwsQ6mR9JrT
         GVzBJ74bvhKJR/jNQYq3tdl0f9Ob6fmIzid79FEZXtmtfdh1mpCO0ETPnbReH5GDbH1N
         xjhg==
X-Gm-Message-State: AA+aEWZR9bZEfbC9bJu0lcA686/0AP0TkTjrY+L2pfkuY72nAG3+Vkko
        VwB/YKbcQBQ6RRhw5vj1g3c=
X-Google-Smtp-Source: AJdET5fnQlamIYdjBghpUOOTxGs6PeRqKZw/bSHMlnA17I+4iWjjYKysIXVoaG0XQRE2PzQr06DiwQ==
X-Received: by 2002:a1c:6a01:: with SMTP id f1mr2271996wmc.17.1542392977930;
        Fri, 16 Nov 2018 10:29:37 -0800 (PST)
Received: from szeder.dev (x4db1f8e7.dyn.telefonica.de. [77.177.248.231])
        by smtp.gmail.com with ESMTPSA id y185sm192210wmg.34.2018.11.16.10.29.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 10:29:37 -0800 (PST)
Date:   Fri, 16 Nov 2018 19:29:34 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] read-cache: write all indexes with the same
 permissions
Message-ID: <20181116182934.GN30222@szeder.dev>
References: <20181116173105.21784-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181116173105.21784-1-chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 16, 2018 at 06:31:05PM +0100, Christian Couder wrote:
> diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
> index 2ac47aa0e4..fa1d3d468b 100755
> --- a/t/t1700-split-index.sh
> +++ b/t/t1700-split-index.sh
> @@ -381,6 +381,26 @@ test_expect_success 'check splitIndex.sharedIndexExpire set to "never" and "now"
>  	test $(ls .git/sharedindex.* | wc -l) -le 2
>  '
>  
> +test_expect_success POSIXPERM 'same mode for index & split index' '
> +	git init same-mode &&
> +	(
> +		cd same-mode &&
> +		test_commit A &&
> +		test_modebits .git/index >index_mode &&
> +		test_must_fail git config core.sharedRepository &&
> +		git -c core.splitIndex=true status &&
> +		shared=$(ls .git/sharedindex.*) &&

I think the command substitution and 'ls' are unnecessary, and

  shared=.git/sharedindex.*

would work as well.

> +		case "$shared" in
> +		*" "*)
> +			# we have more than one???
> +			false ;;
> +		*)
> +			test_modebits "$shared" >split_index_mode &&
> +			test_cmp index_mode split_index_mode ;;
> +		esac
> +	)
> +'
> +
>  while read -r mode modebits
>  do
>  	test_expect_success POSIXPERM "split index respects core.sharedrepository $mode" '
> -- 
> 2.19.1.1053.g063ed687ac
> 
