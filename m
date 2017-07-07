Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D7AB20357
	for <e@80x24.org>; Fri,  7 Jul 2017 18:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751916AbdGGSuQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 14:50:16 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33508 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbdGGSuQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 14:50:16 -0400
Received: by mail-qk0-f193.google.com with SMTP id p21so5414033qke.0
        for <git@vger.kernel.org>; Fri, 07 Jul 2017 11:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NU111mRbEuiniGLJM49iEu9GmRM0GjFdGmCFIQ+ZVoE=;
        b=TZ4cSptjxlj7t3jBAXBmbE3vRExetv8cKEF4mTDgsQzxMYK4QMIhgpgov47UxR1pHh
         Gs1gNjoUW6vJa808SuxPEhXQXv52IWvw7vOeHgJlznY23+vhL8+/9NzhH92BDcgF4gEj
         7W6kyguqV447BSSgtpG5uEmiEz8/o1qfWRs89iEAfkGCW/kx7yjxcb3j/NNqmtW2onJb
         L8AxU26KUyCmZSO3AmqO0gS1ifFfTMe2q3cQNr7DGmecWom/AsYsxPgcKN/4RMRsk4Kj
         TZe3zf0WAWZC9lRSQrAQ8uvWaEMMa6Y6J8Gy4B6L0rAyITpPRHLzSIvxrAWRrkXw87pQ
         ab+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NU111mRbEuiniGLJM49iEu9GmRM0GjFdGmCFIQ+ZVoE=;
        b=D2CGQn/trlob9rpxC56kjkV5KZ9KUYKoVxjSUiLiS2msAvHk7yohBxYYdgBr6d63Or
         OvclNsZUxUBAXW6beLnXkW3L87Y1K1Nd+xW/oRhUIZKRglvjDXMQU4mzxGpIBQ0olzwB
         9qCuiOHxLLu4mC/y6w1qsnKLIJ8Mgxim/UJK0GmYXvekvnrBnqWhHTUoTHsVC0+qxHwr
         hfbLDv1RRYrytRXIUcm0BZLxh7AJFuGxmsNbob+6BQm+snTxxU3ndIwrOaKktZyBQ8Iq
         ybHQfHCsLVoVFxcg8sOMy3zsslVUJZV1xycVn1LTrCKx0axLsw3AJjSTA1bzmqdoRTZd
         kgsg==
X-Gm-Message-State: AKS2vOw+Pqm7jCbKXs2ZhMOppHAJPW1JDf16z7nMO6zdN/RTnEowDAJR
        x6nx4Zd85pZ85A==
X-Received: by 10.55.214.78 with SMTP id t75mr62447010qki.239.1499453415157;
        Fri, 07 Jul 2017 11:50:15 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id h68sm2860986qkb.47.2017.07.07.11.50.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jul 2017 11:50:14 -0700 (PDT)
Subject: Re: [PATCH v5 4/7] fsmonitor: add test cases for fsmonitor extension
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        David Turner <David.Turner@twosigma.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20170610134026.104552-1-benpeart@microsoft.com>
 <20170610134026.104552-5-benpeart@microsoft.com>
 <CAP8UFD3FtddFuaVY9qEyxbm6hiYhFR2TrZ32Cubp4GAEf9+vaQ@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <19e50acb-d4f0-b8f0-2966-0a33770296b1@gmail.com>
Date:   Fri, 7 Jul 2017 14:50:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAP8UFD3FtddFuaVY9qEyxbm6hiYhFR2TrZ32Cubp4GAEf9+vaQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/27/2017 12:20 PM, Christian Couder wrote:
> On Sat, Jun 10, 2017 at 3:40 PM, Ben Peart <peartben@gmail.com> wrote:
> 
>> +# fsmonitor works correctly with or without the untracked cache
>> +# but if it is available, we'll turn it on to ensure we test that
>> +# codepath as well.
>> +
>> +test_lazy_prereq UNTRACKED_CACHE '
>> +       { git update-index --test-untracked-cache; ret=$?; } &&
>> +       test $ret -ne 1
>> +'
>> +
>> +if test_have_prereq UNTRACKED_CACHE; then
>> +       git config core.untrackedcache true
>> +else
>> +       git config core.untrackedcache false
>> +fi
> 
> I wonder if it would be better to just do something like:

That is a good idea; I'll add that around the tests that aren't 
explicitly testing interop with and without the untracked cache.

Thanks!

> 
> =====================
> 
> test_expect_success 'setup' '
>          ....
> '
> 
> uc_values="false"
> test_have_prereq UNTRACKED_CACHE && uc_values="false true"
> 
> for uc_val in $uc_values
> do
> 
>      test_expect_success "setup untracked cache to $uc_val" '
>           git config core.untrackedcache $uc_val
>      '
> 
>      test_expect_success 'refresh_index() invalidates fsmonitor cache' '
>            ...
>      '
> 
>      test_expect_success "status doesn't detect unreported modifications" '
>            ...
>      '
> 
> ...
> 
> done
> 
> =====================
> 
