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
	by dcvr.yhbt.net (Postfix) with ESMTP id F32D21F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 10:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407314AbfJXKSu (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 06:18:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34912 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392678AbfJXKSu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 06:18:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id l10so24993618wrb.2
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 03:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2HwCs4Df7LUfNnBOzVrfGzYvX0lquAm6OBNMkhuNGiw=;
        b=R9+Mrw/Pwm0sWtkBCye5o6Z+JgkWwEielu+9GtpLVcSET/DjtCseiZWo5pneQXZrQ1
         doAYQ2uEEQF/ReDIBB6aEw4PJtUkacG2BlpuozdunNCWkbN/t7GoFOAOyxTNYbG5BBEP
         a1KOGYwqBppIMDov2tpEqUA2cuzfmBjn1FKVoi+BGnDHd/cqg6+MuxsnbMe+gdkmunwm
         uqZseivDZTvdnr79k7mp5XjcS4K6u+w4TD003lToAM+4LWU1Fi52xj/0r0FQyiF8ra8J
         Qc7mDKyHnyApzMvr84bihr8WeVSauvbfg5+oucNIxl5r/W/VQZ0qzZ5Js0tuEguqWszq
         OC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2HwCs4Df7LUfNnBOzVrfGzYvX0lquAm6OBNMkhuNGiw=;
        b=PSzQetYMWR4X0Hehg4Jc6FCS5/GyBkrFvEv9qlyfxxhwZNF79Ou9WwkV3J32IkrmFX
         UsYGeMVZonkzpBc/0G+auA0Odtf6nB+K0Gbt34PwKiLneULEYUabQeABvrx3cZokFGp1
         e4anYgbT5zDxaS6oIX+EvlsX9fp6mAmGW9g2Cmhp5YRp0aITwyInHsxh05TQSvqANhiV
         vIwgPqChUBG9DHNbOnqJQaF7x2samDQd3DZlh61QgWYRixx8TFGKtUo5Ri3JA/js2HfU
         UKPAoR3m1QL7PPitCmLrssOQC744m85rAuTqULKVUvzXGxACNei8AWpitV/VEehqCFmR
         OW+A==
X-Gm-Message-State: APjAAAVZDOa1DlAwxQ0R0Ykx0w/mY+81ynyYrVd8ohWmlfhZWeUXAAvQ
        W9cdc+V//e23Li6/a/U2QoI=
X-Google-Smtp-Source: APXvYqx6ysHy0m30KIcWPIRz0SeqmWOo3+cRXM+4gSXclu79PhUZnPHwUcdLc56bqR5kQAj1I/Bq8w==
X-Received: by 2002:a5d:6785:: with SMTP id v5mr342331wru.174.1571912328156;
        Thu, 24 Oct 2019 03:18:48 -0700 (PDT)
Received: from [192.168.2.201] (host-92-22-20-250.as13285.net. [92.22.20.250])
        by smtp.googlemail.com with ESMTPSA id q6sm4834402wrx.30.2019.10.24.03.18.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2019 03:18:47 -0700 (PDT)
Subject: Re: [PATCH v5 13/17] read-tree: show progress by default
To:     Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     phillip.wood@dunelm.org.uk,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, newren@gmail.com, jon@jonsimons.org,
        szeder.dev@gmail.com, Derrick Stolee <dstolee@microsoft.com>
References: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
 <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
 <a229e1ee0cb96c5f8c2c5d430641c386bc082a2d.1571666187.git.gitgitgadget@gmail.com>
 <3de0f590-c75c-2470-232f-73a07876df88@gmail.com>
 <857e23df-c447-7297-df74-3546424386d9@gmail.com>
 <xmqqimogi0kq.fsf@gitster-ct.c.googlers.com>
 <07f6288a-21c3-bd61-ef74-fea129d12c76@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <6c6b9838-af7b-7212-199f-a0a3f3f2ac77@gmail.com>
Date:   Thu, 24 Oct 2019 11:18:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <07f6288a-21c3-bd61-ef74-fea129d12c76@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee

On 23/10/2019 13:50, Derrick Stolee wrote:
> On 10/22/2019 11:48 PM, Junio C Hamano wrote:
>> Derrick Stolee <stolee@gmail.com> writes:
>>
>>>> I'm slightly wary of changing the output of plumbing commands
>>>> like this. If a script wants progress output it can already get
>>>> it by passing --verbose. With this change a script that does not
>>>> want that output now has to pass --no-verbose.
>>>
>>> If a script is calling this, then won't stderr not be a terminal window, and
>>> isatty(2) return 0?
>>
>> Unless the script tries to capture the error output and react
>> differently depending on the error message from the plumbing (which
>> is not localized), iow most of the time, standard error stream is
>> left unredirected and likely to be connected to the terminal if the
>> script is driven from a terminal command line.
>>
>>> Or, if the script is run with stderr passing through to
>>> a terminal, then the user would see progress while running the script, which
>>> seems like a side-effect but not one that will cause a broken script.
>>
>> It will show unwanted output to the end users, no?  That is the
>> complaint about having to pass --no-verbose, if I understand
>> correctly, if the script does not want to show the progress output.
> 
> I'm happy to have attempted the change and start this discussion. It
> sounds like this one patch could be ejected to no loss to the full
> series.

Thanks.  Enabling --verbose by default on a tty might have made sense
originally but I'm worried doing it now will lead to confusing output
where read-tree is a small part of a larger operation and the script was
written on the assumption that read-tree will be quiet.

Best Wishes

Phillip

> Thanks,
> -Stolee
> 

