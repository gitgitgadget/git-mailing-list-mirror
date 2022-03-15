Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BFBC433FE
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 10:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345505AbiCOKxv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 06:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347837AbiCOKxE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 06:53:04 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E373A70F
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 03:50:55 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id p9so28280921wra.12
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 03:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=eFfrVPlfEcSQsXQgVc1DV+Q4hVvCVkDbqULAr9ly9+k=;
        b=mh4ez+ytQAMzWfd3cM/RxHA8GhhIKs4FWEFlZyUBJpVtdnwhJEw5q1q0CWnbyXGQT7
         NpCnptT356NlEU7iuUbgCkv1pANfJ16yCvxk2YPqtqK1lgL4TCdExPhc2EfbXxGvTnmG
         jbd2ZuERS69QKIJSX+uYmfKGJT2vYv0uRL2H2a+4yVBydBFdrqxdU6CDUJeTRR31xHpP
         G8R8O0aOibfD3al+F+W5E6HN2zmjSc039JzB19KhoVPWq/ZaBh58Lh51VDmzsvZ3x/Zh
         V8fbQiorpDoZEVl4JQKCrDuTQs+YvflWxB2YArSiHDay+EViFtBRzsvGx8TOP3KcnlfZ
         EgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=eFfrVPlfEcSQsXQgVc1DV+Q4hVvCVkDbqULAr9ly9+k=;
        b=PlmpfOyfD9Q/0/lcU99g7eFJxDeFw4JDatl6UNqDXuCwmQBBG9g6bsKxzbyJn8p4kf
         as3vxppWAyZKwabsTGuwqaub2CnF4w8jzOgsNlIZ7SQKg62WjB+N8JV4BkzBBNVo6ExA
         PAQ2rOwSbxJ81ZCs9ew+ZZJbxcQPXCINCVwL+L8N/JIAGKPS/7TMvlcBW/iIvErHBaHh
         XNsH/+swVQXp9g2gQgNEXvw0U6l0ynSHWCiE72RC42NSS+E8q+SQAYaIos571j0eqeuw
         PKbGhsmqqZl7Xyj7K88fm5xqfrqypp7IE4yjLQp0QRUkS+8oMwqzzm9MVk0BA16hu5L/
         1UYg==
X-Gm-Message-State: AOAM533m6fOyuqwcIa8C1FJVCA2BuhqczFwPnrA5Nc/KKLI/oljNEiNv
        e9Qh9Xk+i/srDu3ifmz78kCeKGgbRTPLnA==
X-Google-Smtp-Source: ABdhPJziPvWZs0hQBJpDZrUHQgI/Q9o03znfqdqYJ3uxLvRQf68s+X5c42pNa05G7cZ7/UVut9sdPA==
X-Received: by 2002:a05:6000:1786:b0:1f0:4c5f:63ba with SMTP id e6-20020a056000178600b001f04c5f63bamr19479942wrg.377.1647341453756;
        Tue, 15 Mar 2022 03:50:53 -0700 (PDT)
Received: from [192.168.1.201] (217.2.7.51.dyn.plus.net. [51.7.2.217])
        by smtp.googlemail.com with ESMTPSA id e18-20020adfdbd2000000b001e4bbbe5b92sm16699864wrj.76.2022.03.15.03.50.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 03:50:53 -0700 (PDT)
Message-ID: <2e5b6c09-b0eb-4e97-0eea-a150e30ad493@gmail.com>
Date:   Tue, 15 Mar 2022 10:50:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 4/6] builtin/stash: provide a way to export stashes to a
 ref
Content-Language: en-US
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
 <20220310173236.4165310-5-sandals@crustytoothpaste.net>
 <220311.86bkydi65v.gmgdl@evledraar.gmail.com>
 <2422376f-79aa-2d35-2646-c3611e2ef8d6@gmail.com>
In-Reply-To: <2422376f-79aa-2d35-2646-c3611e2ef8d6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/03/2022 21:19, Phillip Wood wrote:
> Hi Brian and Ævar

Sorry brian, I forgot you prefer a lowercase "b"

> Firstly I think this is a useful feature to add to git stash, thanks for 
> working on it Brian
> 
> On 11/03/2022 02:08, Ævar Arnfjörð Bjarmason wrote:
>>
>> On Thu, Mar 10 2022, brian m. carlson wrote:
>>
>>> +    size_t author_len, committer_len;
>>> +    struct commit *this = NULL;
>>> +    const char *orig_author = NULL, *orig_committer = NULL;
>>> +    char *author = NULL, *committer = NULL;
>>> +    const char *buffer = NULL;
>>> +    unsigned long bufsize;
>>> +    const char *p;
>>> +    char *msg = NULL;
>>
>> These shouldn't be initialized unless they really need to..
>>
>>> +    this = lookup_commit_reference(the_repository, &info->w_commit);
>>
>> ..and some are clobbered right away here, so all of these should not 
>> be initializzed.
>>
>>> +    buffer = get_commit_buffer(this, &bufsize);
>>> +    orig_author = find_commit_header(buffer, "author", &author_len);
>>> +    orig_committer = find_commit_header(buffer, "committer", 
>>> &committer_len);
>>> +    p = memmem(buffer, bufsize, "\n\n", 2);
> 
> You could start searching from orig_committer rather than buffer but I'm 
> sure it doesn't make any real difference. The sequencer does something 
> similar to this to replay commits when rebasing - is there any scope for 
> sharing code between the two?

I had a look at sequencer.c this morning and I think the answer is "not 
easily". In principle it would be nice to have a split_commit_header() 
function that filled a struct of pointer, length pairs for the author, 
committer, message and optionally the subject that could be used here, 
in the sequencer and in fast-export but I think that is more work than 
is reasonable for this series.

Best Wishes

Phillip
