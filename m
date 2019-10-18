Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E44581F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 21:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634611AbfJRVfs (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 17:35:48 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35208 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729496AbfJRVfr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 17:35:47 -0400
Received: by mail-pf1-f193.google.com with SMTP id 205so4640708pfw.2
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 14:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oay/Q2+HxtI8QstPIPkv1ZEKlXEv9TrUQhyFzPAo2Yk=;
        b=JPSYuhr4Popg+oO/zPSquspW0gXvnW8PLkiX1XsYwtoaxWQVqPkKe5+kFJbVq6SlFK
         Ucw/7Esx6N8Uv8luoAPn4swwZ39ogGp424mnpHn6mNZcfo0YFp2UgN8c//h7Oufvp8Sw
         iFBXgHS51UJjExLkbCST8yaHDd1zJipTX107erl7+L+Zllejg1LzLMb34L+eaJNf0sEV
         Oix3MozJIz33Mf4Rt7ZLRM1DsNaSV7QDd7YNaYBqiRtz4Q25UPOvDgR6yy3MtYWqUU+X
         J9Y75VB4pQsvlgMjvDlVTvig6odnuVHYZnWcd+Bd4wqIOfFyCyvVd8HTw2AYgZbFeFV1
         gKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oay/Q2+HxtI8QstPIPkv1ZEKlXEv9TrUQhyFzPAo2Yk=;
        b=dAQTsAfkw7ZiAuDD0y2Z1yGr0Wg5lK3FAnaMaQAtt4Q1qEgDgNcsjzbJCjSKM+xVHc
         Hq9i8OqJV6OaT2QLvIhifnXygOhe6BnW0cL/nOdWsDm9On2KxyMMNmIwnMcmvZTK56XR
         7kgmfK1JhUE1PCPE8qDvi8pn9BMPvz8TppN6Zcp071PZOya7kkxqHH30sSfxdeODnBJi
         2x/Y6QKjIb64i4IzB3k/NPA5O5ybe3j5ZE6q8JxuGWBA0Ap/ZNwvl+TkOT/XxCpi5JWP
         BtCEteQr/DpNh7WW/kLIs6gZ69B9v5qwiWEiThz+FU/WFHnLof9mjZ0qber96c1m89FX
         onqQ==
X-Gm-Message-State: APjAAAVFDrtjeOi27MWosz9X7LHnALTea1kS+EQdzPlIu0hoI9MJVudZ
        MXevX/AdGKtN8ssh31CBNUE=
X-Google-Smtp-Source: APXvYqwo197XL57ot1Z8lWEThrXNgQyLLr5ck7d/kD6tpWRWxziJLjfQ7PKy6kzJn4AGOy8zmN0wsA==
X-Received: by 2002:a63:215c:: with SMTP id s28mr11046333pgm.302.1571434547088;
        Fri, 18 Oct 2019 14:35:47 -0700 (PDT)
Received: from GVFSs-MBP.guest.corp.microsoft.com ([2001:4898:80e8:2:7aeb:a117:de9a:c18d])
        by smtp.gmail.com with ESMTPSA id b22sm6945817pfo.85.2019.10.18.14.35.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2019 14:35:46 -0700 (PDT)
Subject: Re: [PATCH v2 1/6] midx: add MIDX_PROGRESS flag <snip>
From:   William Baker <williamtbakeremail@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        William Baker via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, jeffhost@microsoft.com,
        William Baker <William.Baker@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.337.git.gitgitgadget@gmail.com>
 <pull.337.v2.git.gitgitgadget@gmail.com>
 <6badd9ceaf4851b2984e78a5cfd0cb8ec0c810f5.1568998427.git.gitgitgadget@gmail.com>
 <20190921121104.GA6787@szeder.dev>
 <xmqqlfu9krzv.fsf@gitster-ct.c.googlers.com>
 <20191007172951.GC11529@szeder.dev>
 <xmqqk19fn9jp.fsf@gitster-ct.c.googlers.com>
 <20191009013231.GF29845@szeder.dev>
 <04342d12-fffc-afb6-fa4e-c2e2bf88d1b6@gmail.com>
 <xmqqh849a1b4.fsf@gitster-ct.c.googlers.com>
 <35cd8f8c-de66-819e-0a9f-c0905255721d@gmail.com>
Message-ID: <ca215a07-79b4-7b7f-7dbe-a0541120cde0@gmail.com>
Date:   Fri, 18 Oct 2019 14:35:45 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <35cd8f8c-de66-819e-0a9f-c0905255721d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/16/19 12:48 PM, William Baker wrote:>> I do not care too deeply either way, but if you wrote it in one way,
>> how about completing the series without changing it in the middle,
>> and leave the clean-ups to a follow-up series (if needed)?
> 
> 
> That plan sounds good to me.  The most recent series (v3) should be ready
> to go, I don't believe there is any outstanding feedback to address.

Follow-up question on this patch series.

I noticed there is a branch named 'wb/midx-progress' in
https://github.com/gitster/git but it does not appear to have the commits
from this patch series and I have not seen it mentioned in
"What's cooking in git.git" emails.

Is there anything else I should do to get these changes picked up in 'pu'?

Thanks again,
William
