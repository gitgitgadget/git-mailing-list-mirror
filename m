Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16CCE1F597
	for <e@80x24.org>; Mon, 23 Jul 2018 14:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388279AbeGWPjr (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 11:39:47 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33235 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387910AbeGWPjr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 11:39:47 -0400
Received: by mail-qk0-f196.google.com with SMTP id 27-v6so542648qkv.0
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 07:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Z23/dm616L5G+Oq9ulUDLGxkmGJx1wDFtdYAjj5c1Tw=;
        b=vEb7A1+9lt/T0lfSwKRE7oJIw7Op8Dalc+zUbHmnavxRlbqxbPSI6Rv3C/sRf/J/qN
         Pwgn5NH7KNISK41bIUxpw0GO2DBdRIvj+YD/XItJfpCjWsv4ELY3ogiNk+f9vKJC8uGJ
         AVk68wbgdw5HFWy/mJNQIp/FDz69yxNFApmVVwbXAkY3AxYWpuQTasmk4tQNto4KTbxy
         BLjDQu1LiohQtEQ1AT3TH2eQNNpRYJOnFT1vlse/KkelJjK263f/l+zOWn2YTdinXC0U
         tyGTs4xga7mhyxr1skFpq0FXMYJXs+iTrhJwLdkNv0FsP527BJMZQhdZQGSXQMfqVQIz
         I7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Z23/dm616L5G+Oq9ulUDLGxkmGJx1wDFtdYAjj5c1Tw=;
        b=rG6MvC1IFfbYsKPpp4NdR3YLUmU+S2qit1qqJ16ptfNZlYCfAgHxUgBIDfBb0qFdsi
         YfZxAy5U4IDbCvj4WpNVJBVzE11imOBoaSYD6b6nCbjlRhQ0PpVA9jh4gMp6/K0/8yg7
         GggSv5FDNSmLehPA1VyOlpaQMZqBsh+Yb42P2GJDZNFDZCL8ewvRwUs0wN7KjFW0lW3u
         ad5IthySUCXbiaw58bygJZInnhbhrworJANoPLFUSW0qkswTpbADHo/78FVOWD4eZuIn
         7hRHGJyKWMLL0xtEYybfdqdqilTeyW/xnO9WFUMviv8EJNEiV7V+dfgDnPpmF+QxJtcY
         RvJw==
X-Gm-Message-State: AOUpUlHMRUkPA4TVIzAabzY/3sD7VfMkhixSM9ROKRTPIGVZg8t8DcbB
        OSoZ0TVHKiMznOh09Vl/zew=
X-Google-Smtp-Source: AAOMgpdgc+0j3j6dk7+mg3ErlsRcNoA+zB1U4NIYXRZb4JeB0R7Iy8khXH51G3NmdjDLa/tAMHGvHA==
X-Received: by 2002:a37:8f06:: with SMTP id r6-v6mr11747109qkd.409.1532356693646;
        Mon, 23 Jul 2018 07:38:13 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:79ea:539c:969d:bb3c? ([2001:4898:8010:0:6320:539c:969d:bb3c])
        by smtp.gmail.com with ESMTPSA id w79-v6sm8208884qkw.35.2018.07.23.07.38.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 07:38:13 -0700 (PDT)
Subject: Re: [PATCH 0/5] Misc Coccinelle-related improvements
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <20180723135100.24288-1-szeder.dev@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <fbf95215-a174-6917-256c-3ed71f960a6a@gmail.com>
Date:   Mon, 23 Jul 2018 10:38:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180723135100.24288-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/23/2018 9:50 AM, SZEDER Gábor wrote:
> Just a couple of minor Coccinelle-related improvements:
>
>    - The first two patches are small cleanups.
>
>    - The last three could make life perhaps just a tad bit easier for
>      devs running 'make coccicheck'.

I appreciate your focus on making 'make coccicheck' easier to use!

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>

