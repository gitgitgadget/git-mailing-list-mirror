Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EFBA1F597
	for <e@80x24.org>; Mon, 23 Jul 2018 13:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388189AbeGWO0c (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 10:26:32 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:42309 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388086AbeGWO0b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 10:26:31 -0400
Received: by mail-qt0-f195.google.com with SMTP id z8-v6so553508qto.9
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 06:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=r2GmAHRnRo/8rvLSR9SX/xSVIWNjQfH8Cp/zb8nD+o8=;
        b=ZmETGNg37beyZfupzjMx/IGP8xSBIBxJHve+oNLHu7H76AgoKvrLW43LSsvYcWew/B
         d5hYYFYo0QOZg6QwZufs6SAhEK4LDhtLE22DDuU8Svs9+DiXrm7lNHTmKuTr3lIL3Ps4
         zmBBsEp0INiJp1YuR68OevXqkf5FEvk/HfD/kjF7MKKIsW4hqKjZrIeRbXQjeoEiZCOB
         tbE+xZtCUi96DXWZhgbXpgTFF03KfkaLt++JDGjB/HAWnqwc7YjALQ1C5Ypu/8T8RcUl
         N1//HzYLRGNPkh/gfPOJfX8F0Z4LrM7mzZm4ZDTe4UY2SXAZ3B74sFDlsKFNWGdLIB7M
         gweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=r2GmAHRnRo/8rvLSR9SX/xSVIWNjQfH8Cp/zb8nD+o8=;
        b=d8nFaKFh5WmmwFWD9yxPyjKA8qdu99r0pjhnek+Lzx8MlWUihJRWEnM21ibYAerpmY
         ucKovrdAMfcOeBRc+vUuYiMIzVUM89XxNggUN81Yb0fqhXPuiCEP7cKe5FqHxfCSYkXx
         VmuI2EnL+PwvekEg1W9e+uSlI800ZXQkKzIwvQfpm4Us5/56WaR9IbeWAX49/d22fxdi
         s2yplrnoWMFXy0GYd4xgwnWS252opwBBTvW2OmoqJGXw1ZwigM2KOitKDrendqxvlkNE
         FcLnDRglHsA26Zw9LgR1R3G64OY6Kh/LF4BuKodZO/r51ZZsEyhbaPSq9zKOZvuTxRxI
         59Rg==
X-Gm-Message-State: AOUpUlFR/Y+GiNw6vET3zv8+IM91cUp8NWpiBZPTMHma+a+dmKJNasgj
        0f82GCj4w4TDgUoGSec9e+o=
X-Google-Smtp-Source: AAOMgpefrR0pVWlrkGulcOclIgMQj60zrw4oEUSHVrQ4T4KTKHBSbBf8wRdzrhtLGyykrav7vVPeVQ==
X-Received: by 2002:ac8:2541:: with SMTP id 1-v6mr11846528qtn.248.1532352317032;
        Mon, 23 Jul 2018 06:25:17 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:79ea:539c:969d:bb3c? ([2001:4898:8010:0:6320:539c:969d:bb3c])
        by smtp.gmail.com with ESMTPSA id q22-v6sm10900729qtc.33.2018.07.23.06.25.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 06:25:15 -0700 (PDT)
Subject: Re: [PATCH 0/2] travis-ci: fail if Coccinelle found something to
 transform
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <20180723130230.22491-1-szeder.dev@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <583d2499-c4f2-47a1-48b0-6beb2d4d9d9f@gmail.com>
Date:   Mon, 23 Jul 2018 09:25:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180723130230.22491-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/23/2018 9:02 AM, SZEDER Gábor wrote:
> The first patch makes the static analysis build job on Travis CI
> faster by running it with 'make -j2'.
>
> The second patch makes it more more useful by failing the build job if
> Coccinelle finds something to transform, thereby drawing our attention
> to undesired code patterns trying to enter the codebase.
>
>
> With these patches applied, the static analysis build job would fail
> on current 'pu' because of two small issues on two branches:
>
>    - js/range-diff: Dscho has sent out v4 of this series over the
>      weekend, which already incorporates Coccinelle's suggestion, so
>      it's basically done.
>    
>    - pb/bisect-helper-2: this topic has not seen an update in about 9
>      months, so I'll send a followup patch 3/2 to be applied on top or
>      squashed in, whichever is deemed better.
>
>
> SZEDER Gábor (2):
>    travis-ci: run Coccinelle static analysis with two parallel jobs
>    travis-ci: fail if Coccinelle static analysis found something to
>      transform
>
>   ci/run-static-analysis.sh | 21 ++++++++++++++++++++-
>   1 file changed, 20 insertions(+), 1 deletion(-)

Thanks, Szeder.

I agree that we should use all possible automation as part of CI to 
catch things early. I like the direction here.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>

