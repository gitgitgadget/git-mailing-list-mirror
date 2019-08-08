Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 591061F731
	for <e@80x24.org>; Thu,  8 Aug 2019 20:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390340AbfHHUqb (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 16:46:31 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40714 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729780AbfHHUqb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 16:46:31 -0400
Received: by mail-qk1-f193.google.com with SMTP id s145so69994800qke.7
        for <git@vger.kernel.org>; Thu, 08 Aug 2019 13:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kly4NLBWcCAjh4nOMFuRxvtrSo++ghHO7cVfKNH9Z6c=;
        b=VvRyD6PXyiHv4hTTtrZsnS7qy3uSvkbw6OzIAZ2P8BvFzkJ0+lj02yTHpQ3U3lIPul
         N7RY0ff5qeAY+MOk2zaJNoGosRbS74wFpuVQPDtsQZvICgukbNi48pPgUueVtT1G5nt9
         mXd7ufxyjq/2rolH/YCC+Rx6sRVU/EOf+L/WaHlL+Ipgp4DtgzVEpyiV6GCC+TWI1419
         d41XMgRYSL+Bg2gZwr5H/ku6kI3XkXuubquq2xSqLKyiLkS5mHbEj5POI+nb66/nSlXz
         N4uLTzJWEui6OqiAaVnp8/XxTuv9lU2eU4tdgruj/zJ6XWXIKKOLlxcxCuG72kZmggX5
         iLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kly4NLBWcCAjh4nOMFuRxvtrSo++ghHO7cVfKNH9Z6c=;
        b=L5/ysoxbjxAFTgT2+NXRIPtuvZMiWJX3s24sJgl/NQwmjibiV1mUejt9V17+KhjX47
         gC6HNtsUKQgq9GMWqncjwiw/hf7zeQPrJRvQV8Hg1GPtgM7N5FXFkpuM04pkmgvCo38I
         Ahc1wh4kCfKaIE0dlyn4/txgf/DYE3NHGhzF/VLP9s88AjNwR++35t2hYiZeo0TbiSi/
         Td9gFoyiys50q4F3y68TGUa9Gekt0eSMN1x3dZzbSGz+dhF9zsGRe92JUABrRfo+yKoy
         awc+wEvHUm0cSUyVI/j7l/cx6JRqYZim6z2spZRc1pDgfwtk/vPuHgIOyEQ5SmhL+ITw
         Yamw==
X-Gm-Message-State: APjAAAWZd3TMF2VipwvksNWW/R9Y6IeQ9Yv2/shUacUtt84uL0f09JVv
        qWWH8cqyoEg+ncnLR5J4v1o=
X-Google-Smtp-Source: APXvYqyyPRb4id4VD8GXwWPyENDgdiHa61qYdChSWMBKbxmF0XJNykCQy4VZQG5BavpNDgtRdUucXw==
X-Received: by 2002:ae9:ea09:: with SMTP id f9mr15497256qkg.379.1565297190678;
        Thu, 08 Aug 2019 13:46:30 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:7487:521b:1543:4364? ([2001:4898:a800:1010:25bd:521b:1543:4364])
        by smtp.gmail.com with ESMTPSA id j50sm3009088qtj.30.2019.08.08.13.46.29
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 13:46:30 -0700 (PDT)
Subject: Re: [PATCH v3 5/5] repo-settings: create feature.experimental setting
To:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        carenas@gmail.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.292.v2.git.gitgitgadget@gmail.com>
 <pull.292.v3.git.gitgitgadget@gmail.com>
 <2e153fac22dc5c27fc85efc802785edc0c9d78ad.1564515324.git.gitgitgadget@gmail.com>
 <CABPp-BGppXSt9i4SXTizgPXap-YgHBwHTVrvwDpg98zvpYRwcQ@mail.gmail.com>
 <xmqqd0hffpoz.fsf@gitster-ct.c.googlers.com>
 <CABPp-BH2EHGEmOj3kpeTMV2PpKkRBpPn3FuBfNDHKA8=BkKxFQ@mail.gmail.com>
 <xmqqv9v7e7zf.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c2e8d473-b7fd-eed1-d73f-a9fcd9f73447@gmail.com>
Date:   Thu, 8 Aug 2019 16:46:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <xmqqv9v7e7zf.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/8/2019 4:07 PM, Junio C Hamano wrote:
> Elijah Newren <newren@gmail.com> writes:
> 
>> However, Stollee's commit message started with "The
>> 'feature.experimental' setting includes config options that are not
>> committed to become defaults".
>>
>> If these are settings that are "intended" but not "committed" to
>> become defaults, then yes, you're absolutely right.  (And in such a
>> case, it might be nice to add that distinction to the commit message.)
> 
> My understanding is that the only purpose of feature.experimental
> is: "we want to change the default of X this way, but we do not know
> if we missed an important use case that would be harmed by such a
> change, so let's see if those who volunteered to be guinea pigs by
> setting feature.experimental to true find glitches in our thinking
> that led us to think the change of the default is a good idea".

This is the basic idea. "Here are some new features that we think
are good, please opt-in to test them out and find corner cases."

Thanks,
-Stolee

