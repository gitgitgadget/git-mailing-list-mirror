Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B917B1F403
	for <e@80x24.org>; Tue, 19 Jun 2018 11:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965437AbeFSLsH (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 07:48:07 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:42517 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965187AbeFSLsG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 07:48:06 -0400
Received: by mail-qt0-f196.google.com with SMTP id y31-v6so18000510qty.9
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 04:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=WD1sdq28MPhWUbnwLmGkQ04badVkjbucPpN6KqY2NiE=;
        b=lYKWDgQst4hylaX4T45103dNhv6M6WCpOrGLJ2orKt3jiMc/QhzzA+jTVv88r/E4Ty
         kDslOo+N2WmTo87Rj5VVJTJBIJCXNkiaz8cvAP339E5ldBJyW6Xkm7K+MW1Cfeu+mHSg
         i8WJMS3HoOMgxVVzgYzfSjdAcgtVf8pM7BsSKjho/y/hWFvJvhZmCtQaTRDy8Obblnax
         hdG3jJ2bghIA8v8tyB63WIee911xHpb2W8QySYu1/AX1U2WTBoHbKR9ZuWknHhI8QyUO
         rTrAfE1Zgt7M119ni2tvVAC6JhF+zRssvVvjgjI7VJc4HsSRMv5uKOym9RPQCuELcgQZ
         cPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=WD1sdq28MPhWUbnwLmGkQ04badVkjbucPpN6KqY2NiE=;
        b=YvsHRpEpDCm+jUPgrMHZqDWwYw84BEKrfxLu+q8zDCItJGHSRt1aOpzWoJd+YiAynp
         4YhFVz4bsWjIi4e32ZfJvqR/sInTQQuzuU6hyEalgXQ2D25ONIDnMqezvSx8LO6xJ6fn
         8xMr+vDNWJvFzvOyajSiu9ajCstYBlHaZTAdclAMmKCdOHSBP9f2rijmrvPgU4wZF9DQ
         uLE7NUBFM1sbkmWE99wGkIhb/GQifOqWFtqaaYO2TOgWzZqVQB+0cNO9r7wPLrMkeG0T
         EXzcpDWBDQrztL10UaPnYeVnt+kU2i7kg/ngHNNhWyp1DOKvEXLsVYkVFqijj91K9vNB
         F5EQ==
X-Gm-Message-State: APt69E1wi8tljKAJwO4a3A97GH1oATodBeN2flfEArUMt1ikBowiQBZE
        PRhcBU/IoSTyAWSie9OIiAFRh5K2
X-Google-Smtp-Source: ADUXVKKX17mloJjdAsTSsWdqoUN1MCYV2WjPwMGrMIkHx0FR3CWeehPGfHRnOj8DQNYryjlh8MCr1g==
X-Received: by 2002:ac8:120d:: with SMTP id x13-v6mr14420531qti.374.1529408885586;
        Tue, 19 Jun 2018 04:48:05 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:d807:51c7:6f48:91e4? ([2001:4898:8010:0:c13d:51c7:6f48:91e4])
        by smtp.gmail.com with ESMTPSA id z202-v6sm11431886qka.8.2018.06.19.04.48.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 04:48:04 -0700 (PDT)
Subject: Re: [PATCH 00/15] Kill the_index part 1, expose it
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20180616054157.32433-1-pclouds@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2c01d5ef-7b92-bf1f-75d0-147910feec08@gmail.com>
Date:   Tue, 19 Jun 2018 07:48:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180616054157.32433-1-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/16/2018 1:41 AM, Nguyễn Thái Ngọc Duy wrote:
> This is the beginning of the end of the_index. The problem with
> the_index is it lets library code anywhere access it freely. This is
> not good because from high level you may not realize that the_index is
> being used while you don't want to touch index at all, or you want to
> use a different index instead.
>
> This is a long series, 86 patches [1], so I'm going to split and
> submit it in 15-20 patches at a time. The first two parts are trivial
> though and could be safely fast tracked if needed.
>
> This is the first part, which kills the use of index compat macros
> outside builtin/ and expose the_index in all library code. Later on we
> will ban the_index from one file each time until it's gone for good.
>
> "struct index_state *" will be passed from builtin/ through the call
> chain to the function that needs it. In some cases, "struct
> repository *" will be passed instead when the whole operation spans
> more than just the index.  By the end, the_index becomes part of
> "index compat macros" and cannot be used outside builtin/
>
> Part one is mechanical conversion with the help of coccinelle. The
> only real patches are the first and the last one.
>
> [1] https://gitlab.com/pclouds/git/commits/really-kill-the-index

This is a good series, and a good goal!

Outside of dropping [PATCH 01/15] until all the changes are applied, 
this patch looks like a good, mechanical change.

There are a lot of cross-cutting changes happening right now, between 
this series of series and Stefan's series of series. Hopefully after 
2.18 is cut, a lot of these can graduate to master quickly. Personally, 
I find it difficult to base a patch off of multiple in-progress branches 
and would rather work off of a "known good" point like the tip of master.

Thanks,
-Stolee
