Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02161201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 21:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754946AbdBVVF4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 16:05:56 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35945 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754853AbdBVVFx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 16:05:53 -0500
Received: by mail-pf0-f195.google.com with SMTP id c193so248610pfb.3
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 13:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=qbMKC2ywwQ02jBdY4BrkeJfTJHLgem5GLCCX6n1WX6Y=;
        b=uKJl4gdH1o9JCRCGOL1k+musjfM8pEmZsKPsZFNufoHqKXc4RPdcscvo6z3L/Qi7pY
         d23F/OfNNG5H9ndohNU8U0YannBeO5PWTfPfj0hSIlB885/3lnxebfzgX2W7+MRs6do4
         HqwWhW6q/l4LnGCdsy53fj5oYjEO6JBuWT8rSsKAUjbQliQ/ANk0y31eE/I2dxAgCDP8
         HfwitoyoCttGxl+8KKIB0F74PYtvXEWLUxQzIaaykzckY54P1aPQvwmbKkYiML1jgDwN
         oY7xRQLv4TdWnSksOa8c5vO4izujjj7MtfTT45oCPEgW5/bQxC2TYuDgMeRRrnbbg6to
         Q3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=qbMKC2ywwQ02jBdY4BrkeJfTJHLgem5GLCCX6n1WX6Y=;
        b=I9iUtb+GVrOiVwvlXcqsVbZFLd3dnpzeqhUcgKj8UoGaZ6dsgm4QyBcuGI7g6Q9+UJ
         pIIS4uVGisfy+tUkwwfRPOLT4to/X7oVSRg9FAaQIdN0hXYqE7Em7/btyQeKRND6wvSZ
         sbZOguT/bfmxi2BSiS/ybX2P1NW/5mWGuZnShlzAIql5fVg9d75tKfYXeLV1IHwKvP6g
         zF27i/3Y+gevor+WArbEG5t3Ah/RcdLANHptQVqPhQNSIzb5sy3XylfQf5Qu7+/vELLG
         UOzURrhDUTLg2pBzn2F88Mw1zgpUadA70r28Iq0lMQG2AYgl50aQeN/NzhVCY4Gomcrk
         hwMg==
X-Gm-Message-State: AMke39kmpF8LaBiuUqGGuVkFA2fgt8CluzF6OWQj09hn36EFHaRbhYZ/qBRqs7K2zBx70w==
X-Received: by 10.99.168.76 with SMTP id i12mr43704692pgp.73.1487797477910;
        Wed, 22 Feb 2017 13:04:37 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:21a0:716b:e013:d129])
        by smtp.gmail.com with ESMTPSA id b8sm5402754pgn.6.2017.02.22.13.04.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 22 Feb 2017 13:04:36 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org
Subject: Re: [PATCH v5 00/24] Remove submodule from files-backend.c
References: <20170218133303.3682-1-pclouds@gmail.com>
        <20170222140450.30886-1-pclouds@gmail.com>
        <xmqqlgsycfeu.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 22 Feb 2017 13:04:36 -0800
In-Reply-To: <xmqqlgsycfeu.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 22 Feb 2017 09:18:49 -0800")
Message-ID: <xmqqd1eaaqe3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:
>
>> v5 goes a bit longer than v4, basically:
>>
>>  - files_path() is broken down into three smaller functions,
>>    files_{packed_refs,reflog,refname}_path().
>>
>>  - most of store-based api is added because..
>>
>>  - test-ref-store.c is added with t1405 and t1406 for some basic tests
>>    I'm not aimimg for complete ref store coverage. But we can continue
>>    to improve from there.
>>
>>  - refs_store_init() now takes a "permission" flag, like open().
>>    Operations are allowed or forbidden based on this flag. The
>>    submodule_allowed flag is killed. files_assert_main.. remains.
>>
>>  - get_*_ref_store() remain public api because it's used by
>>    test-ref-store.c and pack-refs.c.
>>
>>  - files-backend.c should now make no function calls that implicitly
>>    target the main store. But this will have to be tested more to be
>>    sure. I'm tempted to add a tracing backend just for this purpose.
>
> OK.
>
>> Junio, if you take this on 'pu', you'll have to kick my other two
>> series out (they should not even compile). I'm not resending them
>> until I get a "looks mostly ok" from Michael. No point in updating
>> them when this series keeps moving.
>
> Thanks for a note.

As this round seems to have added conflicts with another topic that
is already in flight that the previous round did not conflict with,
I'll eject all three for now until this one solidifies a bit more.
