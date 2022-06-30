Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F02C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 16:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbiF3Qgj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 12:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235130AbiF3Qgi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 12:36:38 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A963B2A1
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 09:36:37 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id o9so27290933edt.12
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 09:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=KqfG8X3uFpVf8dAxrUTT1+rW87fS6/7ToksU4BZEXJM=;
        b=K0vnfsUemnm7/7r1uVRfuXBr57kcJe+C/FB4Qg6aPO0uJHFNy9QY8kMIkvMjBD0QdU
         h1vFvwYjy0OW9Ve07dMcaQ2qu5NPlxhx86f7tBcll5VLPcBlI4/tl03FJ6bextE/G7so
         FGOOjQd1L5IsbvFqyY8SEMthkkzGjtImXOn0pQJMmOCQBXrckQikrhq7TJS3oDtE8FOm
         a9eWLd/+E4gz61Nwba/8zKXe9nx9P3XVIbAYXnKrPxS29V+7ogY8hQi9Tzl+TQjkcnL1
         9vJIZDVAQyD3iEHl7Oyhg1J1erSVqgJH+hQ+GeS//hyAJ8YSlkzb980/9PnLsW3tsCJf
         XiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=KqfG8X3uFpVf8dAxrUTT1+rW87fS6/7ToksU4BZEXJM=;
        b=kINFI2YJIKtFMtUlqAH9DzMwjbhIfQ1s43PHj7AqXiEXxe/Ce9lZAtygHZw8TQp3A3
         U+hlyU4w3MlQpp5QlMp82ucNZIuzuMhc0soVXUAt8+OytqhLGMlemKsbnIW2vkpr14hR
         7IN6bNH1P1Cm2CIRRBm+ErbucAUnalnlzWqcUbn/Xvqnq2SJVvsPKcPOmF5TY8ctsPdp
         LZZufTv2syneDFHowVl7XquIND321fXhB5jLilusPXqFgHNjCWiYkOCJMCV61teiAor1
         cCisf7KOM0BYCL2LDr6/+bHRqNPe81lllU9Jn0/XaXiVTG9UIZ/zLGxGtu7fn0rUytrj
         3fKQ==
X-Gm-Message-State: AJIora87PQdEnaIwlK/RdNSawEDyaFTMWtiFI1F98KjK8DxsFdKS4R14
        M0s3o4rgJxJZePk7bRJtKlk=
X-Google-Smtp-Source: AGRyM1u5jePwUUoAGON8vevGCqESQ8deZVqz+Zjv8caV8OTWLbGL9NOVKRnapq1VAsG70RvMmcg2HA==
X-Received: by 2002:a05:6402:3707:b0:437:61f9:57a9 with SMTP id ek7-20020a056402370700b0043761f957a9mr12435503edb.1.1656606995760;
        Thu, 30 Jun 2022 09:36:35 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id d10-20020a17090648ca00b0070b8a467c82sm9273851ejt.22.2022.06.30.09.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 09:36:35 -0700 (PDT)
Message-ID: <9b33bbc3-1781-6655-d6ef-f0793bdd0951@gmail.com>
Date:   Thu, 30 Jun 2022 17:36:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/3] cat-file: add mailmap support
Content-Language: en-GB-large
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Siddharth Asthana <siddharthasthana31@gmail.com>,
        git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>
References: <20220630142444.651948-1-siddharthasthana31@gmail.com>
 <20220630142444.651948-4-siddharthasthana31@gmail.com>
 <61074b4c-c48f-da89-5d03-b280b9c4fedf@gmail.com>
In-Reply-To: <61074b4c-c48f-da89-5d03-b280b9c4fedf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30/06/2022 16:50, Phillip Wood wrote:
>> +char *replace_idents_using_mailmap(char *object_buf, size_t *size)
>> +{
>> +    struct strbuf sb = STRBUF_INIT;
>> +    strbuf_attach(&sb, object_buf, *size, *size + 1);
> 
> I'm worried by this as I don't think we really own the buffer returned 
> by read_object_file(). git maintains a cache of objects it has loaded 
> and if this strbuf grows when the author is rewritten then the pointer 
> stored in the cache will become invalid. If you look at the code in 
> revision.c you'll see that commit_rewrite_person() is called on a copy 
> of the original object.

Sorry ignore that, looking through the code again we do own object_buf 
so this is fine.

Sorry for the confusion

Phillip

>> +    rewrite_ident_line(&sb, "\nauthor ", &mailmap);
>> +    rewrite_ident_line(&sb, "\ncommitter ", &mailmap);
>> +    rewrite_ident_line(&sb, "\ntagger ", &mailmap);
>> +    *size = sb.len;
>> +    return strbuf_detach(&sb, NULL);
>> +}
>> [...]
>> +test_expect_success '--no-use-mailmap disables mailmap in cat-file' '
>> +    test_when_finished "rm .mailmap" &&
>> +    cat >.mailmap <<-EOF &&
>> +    A U Thor <author@example.com> Orig <orig@example.com>
>> +    EOF
>> +    cat >expect <<-EOF &&
>> +    author Orig <orig@example.com>
>> +    EOF
>> +    git cat-file --no-use-mailmap commit HEAD >log &&
>> +    grep author log >actual &&
>> +    sed -e "/^author/q" actual >log &&
> 
> This line does not have any effect on the contents of log
> 
>> +    sed -e "s/ [0-9][0-9]* [-+][0-9][0-9][0-9][0-9]$//" log >actual &&
> 
> I think you can simplify this series of commands to do
>      git cat-file ... >log
>      sed -n "/^author /s/\([^>]*>\).*/\1/p" log >actual
> 
> Best Wishes
> 
> Phillip
