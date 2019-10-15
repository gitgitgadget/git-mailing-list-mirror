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
	by dcvr.yhbt.net (Postfix) with ESMTP id 82F831F4C1
	for <e@80x24.org>; Tue, 15 Oct 2019 12:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfJOMzC (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 08:55:02 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]:47062 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfJOMzC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 08:55:02 -0400
Received: by mail-qt1-f176.google.com with SMTP id u22so30328854qtq.13
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 05:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/Ql7653ctIE/HsWN7SxvK1Co8DZfECD01NXgqDwMxp8=;
        b=T9q+KzlHEzIz2j6ETdiuG8PBigHPl3q88DTsGpm5yy39Q5SR4A8qTfn3TfAxqfVNnY
         FXpedsUuqzIairXzjBkgfPS/8Y4FiYjm9ftYEUdXrrAj17XvLo8NNdaGEzhtboNtDONj
         83nCmxeREISMMmSnvzquRbjplnEQfk2zJv4rEec2bdMLdMDJmnoggoH4JIWo6iMBMrQd
         QPbG84sXMgYcW1IX+6J6QNjsPhOrm38MfzMMhtN/KtC5l9lhIT+CBCmNBFCdYVr9Qqfh
         rDaEL59doxY6wHmpwAec5QFlR0UyKOv8g4zNXsLJ6i1GJ7R25pQ8ZKTOo6G0AvczBxlx
         7+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/Ql7653ctIE/HsWN7SxvK1Co8DZfECD01NXgqDwMxp8=;
        b=E0yrRMHMBLhKyY8ZsvqutqofUYerx4zitoWHnsbo6Pl7dpplndJli2YlzXtRf8yTEf
         W3GcZx9zVJFzJdehhLiyYD/hFcnOCMpzusASKGKluh7GuKf+0th5NuSNb7WKJoS1gdGQ
         qTB8jLuFq9Ak7W/K+HyXa49hNzK8NH57zFx8vyXRC7p8rIheIzN9+iAaO6xvF6tg7XX6
         hbvBbe0KWPkT6kQrOCRzski+ygcwdhkc2ovy0VFCLDCjiJDrqAuLAuu1BJC2ZT+oBAO5
         hiMVstC8ULt1Xf/PuditpX9oskUOv+Ru3YEfnkSEQBGapE21OXxqfiH1kneDd84EHk0T
         pASQ==
X-Gm-Message-State: APjAAAUPHEPPYU450B0n7m2KfeYouEOlq46tCEMPDskxf/E3zK1ju06B
        7+zODECy90T1q9/mX5cJuQE+WA9alRw=
X-Google-Smtp-Source: APXvYqw4rtZLyO6AwoYFD0cAzQEYu6+Z554dIztSpUZKoUEtceQzZUgjSi1ane9dLVFgzkERGilrRQ==
X-Received: by 2002:a0c:fde6:: with SMTP id m6mr17324111qvu.173.1571144099054;
        Tue, 15 Oct 2019 05:54:59 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:889a:fc09:50a4:b190? ([2001:4898:a800:1012:39ce:fc09:50a4:b190])
        by smtp.gmail.com with ESMTPSA id o14sm14212134qtk.52.2019.10.15.05.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2019 05:54:58 -0700 (PDT)
Subject: Re: ds/sparse-cone, was Re: What's cooking in git.git (Oct 2019, #03;
 Fri, 11)
To:     Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
References: <xmqq8sprhgzc.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1910122327250.3272@tvgsbejvaqbjf.bet>
 <20191015015052.GA19636@dcvr> <xmqqzhi2bsp8.fsf@gitster-ct.c.googlers.com>
 <20191015071126.GA908@dcvr>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <fdea4b03-3810-1317-7fe3-5100482f7b34@gmail.com>
Date:   Tue, 15 Oct 2019 08:54:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <20191015071126.GA908@dcvr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/15/2019 3:11 AM, Eric Wong wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Wong <e@80x24.org> writes:
>>
>>> I just took a brief look, but that appears to leak memory.
>>>
>>> "hashmap_free(var, 1)" should be replaced with
>>> "hashmap_free_entries(var, struct foo, member)"
>>>
>>> Only "hashmap_free(var, 0)" can become "hashmap_free(var)"
>>
>> I deliberately avoided merge-time band-aid fixups on this topic and
>> ew/hashmap exactly because I was sure that I'd introduce a similar
>> bugs by doing so myself.  Using evil merges can be a great way to
>> help multiple topics polished independently at the same time, but
>> when overused, can hide this kind of gotchas quite easily.
>>
>> A reroll on top of ew/hashmap would be desirable, now that topic is
>> ready for 'master'.
> 
> Just to be clear, that reroll should come from Stolee (+Cc-ed), right?
> I'll be around to help answer questions, but also pretty busy
> with other stuff and I think Stolee knows this API pretty well :>

I'm working on the re-roll, yes. I was waiting for ew/hashmap to merge
with history that included ds/include-exclude. Now the current 'master'
has both, so I can rebase and check everything carefully. v4 should
have every commit compile with the new hashmap API.

Thanks for pointing out the bugs with the suggested fixups. I'll
be careful as I adapt the new API.

-Stolee

