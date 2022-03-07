Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D99C433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 14:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242994AbiCGOGn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 09:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243001AbiCGOGm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 09:06:42 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D044D65428
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 06:05:44 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id iv12so10590487qvb.6
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 06:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YraozYV+2YAbVmiksMWueRMGZI30GtmeDefHR5s99nQ=;
        b=gRR8KV2LSiwxFago6FreDLI2E6Dxl+12MPnDioPDL+3v8i0u7NVe1V82BcUqQlKn6G
         ouLdRf2mF4V3pbS65FMzYnwNW8BZQyJQNGfGtNU+r4ttynFg4w3q9IHW67wpyaAUu8dD
         KIdXpCgAxZmvw5f7bOcAo44uVmbxlVCkD6Zrj2EEnmdlfpmmO1mIGLxWmFQnQZhDhqO3
         PjlLdIE3Tt7sbk+JM98mQGmnoFkB8+SrsPPnjwDdNn50tSR2y00U7Bpz/WC/8MlVcdSh
         qn/XyQiEsdPZIP1ab4KR3LxolRljhUbfoJVSKWOnjpjTKIHQdO2oVh1Pb1mL4EvNTLGq
         vGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YraozYV+2YAbVmiksMWueRMGZI30GtmeDefHR5s99nQ=;
        b=Nd0i8prICdcuoDwMZejqJOLuoGH65FEBfdJdkEVnGKVfNyX5z0jyrWkmelweLUsxok
         jREJoBzfOYSTJR0MvpTXwQRgFI9l2pnHO4YBDdqPvFnN+GtAF1VqaL5oE0WDY7o6NNUa
         EtnCu739qLBOB5zOpUK26rhon4pIdewDXffhtbk5RoV6Tjh84ve2f1328D1L16yNTQpA
         Rw6aA6C//XS7AeQd3FFQRnguKT2GEqIhJEfWOW4keVQtzlHmrJH1ayPsb0Csh3B6UuGW
         jVftPOLuPt68AP4dTMeRJwoaE3J6DhcZxtzFlD9jUBs62nC9CzIs4qOX4STLvapDe8El
         dBsQ==
X-Gm-Message-State: AOAM531WzOrFs1nwhqwOyw4SYCcIOOJMJkGS9h3f+U8coBqZK86rFOYp
        RGB81x+9T+rTsFi7JkSx1FvS
X-Google-Smtp-Source: ABdhPJzB1+/srhSmVIj2jdVF7lFha1utSC9irhNAixS5/l0tzrbbGcCdRu1l6RTE+USaQ84z6GPbgw==
X-Received: by 2002:a05:6214:27e1:b0:435:8a67:fa25 with SMTP id jt1-20020a05621427e100b004358a67fa25mr4298916qvb.101.1646661943636;
        Mon, 07 Mar 2022 06:05:43 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id b8-20020a05620a088800b00648bfd00a41sm6149668qka.80.2022.03.07.06.05.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 06:05:43 -0800 (PST)
Message-ID: <e163a286-37cb-2568-1d96-0c7b7fba4e5a@github.com>
Date:   Mon, 7 Mar 2022 09:05:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 06/11] MyFirstObjectWalk: update recommended usage
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, avarab@gmail.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
 <355c503157ad02e6106179c2dc7228bdf63a6228.1645638911.git.gitgitgadget@gmail.com>
 <xmqqtucdxs8x.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqtucdxs8x.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/4/2022 5:33 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

>>  the name, these functions traverse all kinds of objects. Let's have a look at
>> -the arguments to `traverse_commit_list_filtered()`, which are a superset of the
>> -arguments to the unfiltered version.
>> +the arguments to `traverse_commit_list()`.
>>  
>> -- `struct list_objects_filter_options *filter_options`: This is a struct which
>> -  stores a filter-spec as outlined in `Documentation/rev-list-options.txt`.
>> -- `struct rev_info *revs`: This is the `rev_info` used for the walk.
>> +- `struct rev_info *revs`: This is the `rev_info` used for the walk. It
>> +  includes a `filter` member which contains information for how to filter
>> +  the object list.
> 
> Perhaps,
> 
>     "When its `filter` member is not NULL, it contains ..."
> 
> implying that it is valid for `filter` member to be NULL and none of
> the following things will happen in such a case.

Definitely room for improvement here. I got hung up on the two uses of
"it" so here is another attempt:

 If its `filter` member is not `NULL`, then `filter` contains
 information for how to filter the object list.

What do you think?

Thanks,
-Stolee
