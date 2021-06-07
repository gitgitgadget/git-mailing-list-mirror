Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E935C47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 14:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72FEB60FF0
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 14:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhFGONd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 10:13:33 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]:37630 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbhFGONc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 10:13:32 -0400
Received: by mail-qt1-f172.google.com with SMTP id z4so9625787qts.4
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 07:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=tAi5zFv8MAx3/2+cwrDLcwCNOy6A3pZLryFZf1K3fY0=;
        b=USrtQszKih5OpipZFPmGQbnB8yh9LudF20+biRxVpdXuIXVmjVIc9H4Whs88AwFA0l
         sn0BJEza5k+qOlNI7NZ3RsfbS/bDNq2XhyuksuV5y1i/yGQ4YIF2Ig68fJVr37QSq7uO
         C2LTrm7GoSylcGRw75U0Evthp9bUQVKy0jP8pwtLuyb7qykHvygcU05MqDnPVJXDmSet
         86nC/Iqx0lIRihfwurd30PupsioUW5Gzeo0uxTEjkR6Bey4/RSQv7zikaxYLleCYWNMH
         l+mlg+jAaAUcE/TS+NwfHbWXbm2+RnYT9XlMs/0Ly4zDruu7QbnP07WStKQnCKbpvshn
         714g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tAi5zFv8MAx3/2+cwrDLcwCNOy6A3pZLryFZf1K3fY0=;
        b=I/vQqVpSDq4fkYe4cvkiAWURfrwVkK4UaGSKkQL7I85ibP3g3ruH+lZ1+VOdU7q8Vt
         QFOQZV8+HHANav3CXsmHiCJ4dEvdkoTqLmeaxxutX+I+GXsFQlishvgNpGMMTOvWTjCo
         NwvB02NqyE260dIUg9VwOW/k0TOFNqXcGfRTwET2fQEI7FPEVUKD4xSVG+R2Xgn5H3wp
         QRUncrDE4zhJTPTVX4Holed2LWyncyxsz7jre69nZf5E89dAAfap1k+DZ3oW1lZzWjw9
         OdfdnTGnWeLM10CBeg3GkcqzVeb590tCPXRqngVP6PmU1hJouWrWSRGeEeJu2MXaTje+
         sr3w==
X-Gm-Message-State: AOAM531wcv3XB/Jh2IHHTGQqwHjStvhbe37OgzDOG2UzUw9kxL9TJimH
        cRIj0naf0Z3rKTtBIF+/qZNG5CyExIRc0A==
X-Google-Smtp-Source: ABdhPJwoodCMH+J2fU65rXDbKP/cZ/gSUHJhkSF0gv/DidlJ+L1jQ1ZiWUsbeUde7pO7vmELvhKjMA==
X-Received: by 2002:aed:30e6:: with SMTP id 93mr16565696qtf.41.1623075040143;
        Mon, 07 Jun 2021 07:10:40 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:58fa:fc7:3955:c1d5? ([2600:1700:e72:80a0:58fa:fc7:3955:c1d5])
        by smtp.gmail.com with ESMTPSA id y1sm10137483qkp.21.2021.06.07.07.10.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 07:10:38 -0700 (PDT)
Subject: Re: [PATCH] t: fix whitespace around &&
To:     Andrei Rybak <rybak.a.v@gmail.com>, git@vger.kernel.org
References: <20210607131320.982362-1-rybak.a.v@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <56915c33-10b8-2ecb-6862-6d56d791dff9@gmail.com>
Date:   Mon, 7 Jun 2021 10:10:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210607131320.982362-1-rybak.a.v@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/7/2021 9:13 AM, Andrei Rybak wrote:
> Add missing spaces before '&&' and switch tabs around '&&' to spaces.
> 
> These issues were found using `git grep '[^ ]&&$'` and
> `git grep -P '&&\t'`.

Thanks for this mostly-obvious cleanup, especially for fixing the
mistakes I made.

> -		set ${files} &&	file=$1 && shift && files="$*" &&
> +		set ${files} && file=$1 && shift && files="$*" &&

This is the one that is not obvious, but it is because of
an instance of "&&\t" in the middle of the line. Thanks for
catching it!

-Stolee
