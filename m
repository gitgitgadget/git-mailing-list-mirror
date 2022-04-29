Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D96CC433FE
	for <git@archiver.kernel.org>; Fri, 29 Apr 2022 16:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378941AbiD2QRS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Apr 2022 12:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378934AbiD2QRQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Apr 2022 12:17:16 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD91D76E6
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 09:13:58 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id h3so1512214qtn.4
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 09:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6ZKMt8Na9RoUZItbnP3GydNoVKYnhNkGJRg2jpK4Uus=;
        b=VtsMxAEoIwsXCI8qhjfWIPDpRo7bn3YuTrII93yTQ/WJaeBbv/03OdMw3fp0KA78LY
         E/Or0Uuq5qaSMrZYBoxOCkBkX4P17GIzbH7xKS6wQED32XgCAfUk+BbVjANCoamVR3ox
         suhyHZhj+ROSei33l0tmSHJBLe3rQ2/qUcP7+ZuoamUzbTj9hnTbNaUJ7dCahf4rhtbw
         d7w6biDqRJCumlGLfN07xNXZk/7/50tOLX59GHWtPRn9aoHJJ8MfyfufXI0MC3jueNGN
         1bm5Ej6g+Ir3zhctsE48QHetVzKYNviLg4VlmULwiXapgdZVspDO9Refal76XUMqccrI
         Ev5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6ZKMt8Na9RoUZItbnP3GydNoVKYnhNkGJRg2jpK4Uus=;
        b=P10FGB+TAhMhxA2saXIFqjoA9Ykz8fkv2qzeZc/91ocBQYXiXtKrXa5U2BiQju8auf
         7lnxRcLifJjhjwFhqQVlIcZaNcaxPRf+dT/s3+qPTGlS2QgzCn2hLiKmIakShDuDM6+f
         F8W2puzzZowYtb0tx5jn6yijnww/jlzhoxa/NUWjKPjDkr0R2+44ciO+TlrEYmh386IX
         KeyczMx4riM27B+kTLAre6fJmvBgLRoe9xURoSadbcP4uVKK7KneyytNutaT1o7fWn0y
         5ib9CPr3m/RS/KwLdmj/07aTMVxsCUpj8Ldn+f9tnLKTp9O0rsPIGyka/qbII7qmuNdW
         YzOw==
X-Gm-Message-State: AOAM530AWjaRjYD3sII7Cup+IXpH+kK2zmy8/sEAogsE7cusEs/Clfhk
        65vCGTpHfoSecLe7jeILNIvy13RNOpTx
X-Google-Smtp-Source: ABdhPJwaa3tTmynJf5G2QtMid8xQ9HQ3SbfyBW7bKrzFzxv9qflkeiovikk1C2Ua9ZMo+w0B5GcZBw==
X-Received: by 2002:a05:622a:130c:b0:2f3:645f:49c8 with SMTP id v12-20020a05622a130c00b002f3645f49c8mr115063qtk.487.1651248837237;
        Fri, 29 Apr 2022 09:13:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:20e7:8cbb:83bb:177d? ([2600:1700:e72:80a0:20e7:8cbb:83bb:177d])
        by smtp.gmail.com with ESMTPSA id z8-20020ac87f88000000b002e1cecad0e4sm1920670qtj.33.2022.04.29.09.13.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 09:13:57 -0700 (PDT)
Message-ID: <9b0cc160-2d7f-6a38-c2d2-66ed8619cd17@github.com>
Date:   Fri, 29 Apr 2022 12:13:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 3/3] safe.directory: document and check that it's ignored
 in the environment
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
References: <pull.1215.git.1649863951.gitgitgadget@gmail.com>
 <20220427170649.4949-1-szeder.dev@gmail.com>
 <20220427170649.4949-4-szeder.dev@gmail.com> <xmqqlevql0lj.fsf@gitster.g>
 <xmqqee1il09v.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqee1il09v.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/27/2022 4:49 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> If we had GIT_SAFE_DIRECTORIES that lists the safe directories (like
>> $PATH does), that would have been absolutely necessary to document
>> how it works, but GIT_CONFIG_* is merely an implementation detail of
>> how "git -c var=val" works and I am not sure if it is even a good
>> idea to hardcode how they happen to work like these tests.  The only
>> thing the users should know is that GIT_CONFIG_{KEY,VALUE}_* are
>> used internally by the implementation and they should not muck with
>> it, no?
> 
> I misremembered.  GIT_CONFIG_COUNT and stuff are usable by end user
> scripts, but then ...
> 
>> diff --git a/Documentation/config/safe.txt b/Documentation/config/safe.txt
>> index 6d764fe0cc..ae0e2e3bdb 100644
>> --- a/Documentation/config/safe.txt
>> +++ b/Documentation/config/safe.txt
>> @@ -13,8 +13,8 @@ override any such directories specified in the system config), add a
>>  `safe.directory` entry with an empty value.
>>  +
>>  This config setting is only respected when specified in a system or global
>> -config, not when it is specified in a repository config or via the command
>> -line option `-c safe.directory=<path>`.
>> +config, not when it is specified in a repository config, via the command
>> +line option `-c safe.directory=<path>`, or in environment variables.
> 
> ... this part must clarify what environment variables it is talking
> about.
> 
>     ... via the command line option `-c safe.directory=<path>`, or
>     via the GIT_CONFIG_{KEY,VALUE} mechanism.
> 
> or something, perhaps.  I actually do think it is a useful addition
> to have GIT_SAFE_DIRECTORIES environment variable that should NOT be
> ignored.

I agree on both points.

Thanks for working on this!
-Stolee
