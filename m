Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33D7C47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 17:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9513461029
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 17:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbhFGRXM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 13:23:12 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:34388 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbhFGRXL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 13:23:11 -0400
Received: by mail-oi1-f176.google.com with SMTP id u11so18822853oiv.1
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 10:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KIxsyhznWm96EIDPP8AiXRzKVlJ8Gz+v8bnNbU4x1dM=;
        b=Vw5yDjgV3kSOWuDFwhcgXGVGYguXrD1JigS4LGPVgfPck3Y4Ld/EeHPOiZlVcAO/Mu
         GxesfBEmon78d56cpr11FuKbJK8Qs9mIT8U6z6AGuZ6zx10ZHRx/A9nH9m3JpbHem2WU
         zsckWGZn5O4HmI2LCT6e8P0CAPQ6/54bPmVrIItqWHvKyaH21cr7QG7LUyO8Q1rlDnQd
         DE/l2AyqCg8+s56ipKGn8QvVSV04Rllz/YwVj7pjQa7tmK6SLeUWLNEHTNOT4MkvjHzd
         CT6aCL5VxhNdWwPI4OrEe6zp3o2CGYtzkcyHDUE3tb0R9emb1wGxTSmyIilG8KIux56J
         bB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KIxsyhznWm96EIDPP8AiXRzKVlJ8Gz+v8bnNbU4x1dM=;
        b=H/PN7ckX9KfkfN/i71vAiAyJauFXYkn64MnobbD7+QSyjrW3/tQ56mT7g/tgBJqjsY
         UcaIHFg1RGX3rBhDtgbOx4sLDcdrscA4C2M5Rf35gbZAQwoTyNYm+4I2NceO2mNCsLyk
         Ul9uT85Y7gXQRKs7RTWE7z2bDuIoFZz2tXW15L3odQ/uaE53vSIi4GcUZ+DULQvPWU4l
         8NidolReCnv5c4WdNmXqivW4gohFa0F7uaM8XxpMoi1BY3yyh152cAtl8m7V6Iq1leyP
         VA5TH0P89VzapuqWpAM4DvMpiZ5TbT+UWm2x2OSWlj6YssM3UDs++9GiODTpTrdOWIOP
         GqqQ==
X-Gm-Message-State: AOAM5336mciCfhCTepv6YBXICBtHqy1Nd+UcqecDdG58kUOmBz+tY0xR
        eVNtEaf9yRTuKlAtGfDcGqY=
X-Google-Smtp-Source: ABdhPJx022s1kHaa940JENADo7wWDP/lF9JpnHy6BPwzGZ/RBac7jFTZmJtjvCr+vWQHwrYOA9YVnQ==
X-Received: by 2002:a54:4e81:: with SMTP id c1mr185720oiy.119.1623086419595;
        Mon, 07 Jun 2021 10:20:19 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:58fa:fc7:3955:c1d5? ([2600:1700:e72:80a0:58fa:fc7:3955:c1d5])
        by smtp.gmail.com with ESMTPSA id 88sm2474490otb.7.2021.06.07.10.20.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 10:20:19 -0700 (PDT)
Subject: Re: [PATCH 2/4] *: use singular they in comments
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, jrnieder@gmail.com,
        emilyshaffer@google.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <b36e3f99716bf3976fc886df684c300e17566c79.1623085069.git.gitgitgadget@gmail.com>
 <87bl8h4n01.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ea3861c0-80cd-8bba-8de1-4c838721ab7f@gmail.com>
Date:   Mon, 7 Jun 2021 13:20:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87bl8h4n01.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/7/2021 1:12 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Jun 07 2021, Derrick Stolee via GitGitGadget wrote:
> 
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> Several comments in our code refer to an anonymous user with "he/him" or
>> "she/her" pronouns, and the choice between the two is arbitrary.
>>
>> Replace these uses with "they/them" which universally includes all
>> potential readers.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>  commit.c                                 | 2 +-
>>  config.h                                 | 2 +-
>>  contrib/hooks/multimail/git_multimail.py | 4 ++--
> 
> We should not change upstream projects we pull in like that, see
> README.Git in that directory +
> https://github.com/git-multimail/git-multimail.

Whoops. Thanks. I wasn't looking carefully enough
at the path.

-Stolee
