Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D7161F51C
	for <e@80x24.org>; Tue, 29 May 2018 11:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933491AbeE2L6I (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 07:58:08 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:37125 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933395AbeE2L6G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 07:58:06 -0400
Received: by mail-qk0-f193.google.com with SMTP id j12-v6so7848491qkk.4
        for <git@vger.kernel.org>; Tue, 29 May 2018 04:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=4jEoVAjvMHc4wnxko+oHNgWYjOcsq4NUsqSdtzwecss=;
        b=XoiKeBHmudHp/yEbWN88aZ/KNZ5nqvLWdq47Gz5AvRg4ETxDHBvCe9mPOCkYs/e4x8
         /vcyqLbC/MzW4NUpK2QnXexC1EJDJ+PG0bkL99K531TtZX4haYXJCps7ZTK4EaOx6fGD
         oTJUKNsK/plwIOSfUO5lsKcnrnvB7JaqooqVdwF4MVzrfRxCbaPP3yg5pLeDJ4wesY4q
         HIKo+h3l4Zmx2kPaziep8JaPsYqcWMmlamVnodEVByNIXMPOa2MFqf2Inl7lS8xdVQ/U
         YYwWIaKQdq1ULzy+AIusA/Sdf3Bp7IgGQSQav19L/u3aZRYhCqZAiqrw/xaXmMV4i3P4
         PBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4jEoVAjvMHc4wnxko+oHNgWYjOcsq4NUsqSdtzwecss=;
        b=j38Q9rvJLPU8OXMf47HKYgG6LBhikbtwGN3c6GJkvc8AKJ8CKBZ1ikGxFFW3qLstcF
         +Uk5Var70ZAIiw3zwW3op1t6ZbZiZGILnNRS/q/fJUMmXRhp34kCXadS7zeZXJo/vRy9
         5Iwn7zVpHO0J7J6j0sKRvLWpp5Q+2Kj3PejAuaYOwl3xSsMXvMaXouUNKKP67jpvnKMN
         SSTM652KQeWg9hfIrYoSk2ZtR7u3jsNfZqonOL8xMhNqE5yxBUj8iXlHxTSBt0xsjVhI
         8CtFJ4GYbIaqjsus9vfjAldGXqQDqLh5TgxivFYXEkCpY2jaHwX2FK2dXuMbDVJBeOxh
         1zlg==
X-Gm-Message-State: ALKqPwcqARwUorf/3H91y4GnJn5yIwdfgLQ61qhONtrHIIFgiGdcRf5z
        hxK3pcIo0YKBcG3OdoDIdAk=
X-Google-Smtp-Source: ADUXVKK1Syqt5jlukXZdXaNM1TxeHxvkddjoOOXzPXzyb/3U+5eo2EqRjcPd+9AKDzvOYEayQTqllA==
X-Received: by 2002:a37:a38c:: with SMTP id m134-v6mr11086149qke.57.1527595086000;
        Tue, 29 May 2018 04:58:06 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:85b8:1327:9ae7:c654? ([2001:4898:8010:0:6eee:1327:9ae7:c654])
        by smtp.gmail.com with ESMTPSA id x14-v6sm4669961qtk.33.2018.05.29.04.58.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 May 2018 04:58:05 -0700 (PDT)
Subject: Re: [PATCH] t990X: use '.git/objects' as 'deep inside .git' path
To:     mhagger@alum.mit.edu, Christian Couder <christian.couder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?Q?Carlos_Mart=c3=adn_Nieto?= <cmn@dwim.me>,
        David Turner <novalis@novalis.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        David Turner <dturner@twopensource.com>
References: <20180526064745.20199-1-chriscool@tuxfamily.org>
 <CAMy9T_H7OVJoDQGFNnM-GrCE9jhSqNDALFL1TM45TMcwPx5nnQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <50c85752-7000-880e-ebfd-44b8e7f71028@gmail.com>
Date:   Tue, 29 May 2018 07:58:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAMy9T_H7OVJoDQGFNnM-GrCE9jhSqNDALFL1TM45TMcwPx5nnQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/27/2018 12:49 AM, Michael Haggerty wrote:
> On Sat, May 26, 2018 at 8:47 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> Tests t9902-completion.sh and t9903-bash-prompt.sh each have tests
>> that check what happens when we are "in the '.git' directory" and
>> when we are "deep inside the '.git' directory".
>>
>> To test the case when we are "deep inside the '.git' directory" the
>> test scripts used to perform a `cd .git/refs/heads`.
>>
>> As there are plans to implement other ref storage systems, let's
>> use '.git/objects' instead of '.git/refs/heads' as the "deep inside
>> the '.git' directory" path.
> Seems reasonable to me. +1.
>
> Michael
Looks good to me, too.

Thanks,
-Stolee
