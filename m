Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C35421F453
	for <e@80x24.org>; Thu, 25 Apr 2019 11:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730089AbfDYLJO (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 07:09:14 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37921 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfDYLJO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 07:09:14 -0400
Received: by mail-qt1-f196.google.com with SMTP id d13so23868789qth.5
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 04:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mAX5GgZha2TcofiNJRRU4sF2hrfOy7RqzwNdwZvGNfc=;
        b=NqT9q3hCz/dRzw5ABgkry7TmZJV++gjuLMinOFeenief0+gBqZKtJqmNLeMPcAJO0c
         Q5YQx6K1mu6IKKTqcg7E/t9LxoqiHFG2qVJpJ6wrV594fZ+0UlDi700x4Hm6pFmEcBN9
         A5ft32nKNgpXbbe4kXc9h3fs5LKbAzcZAZQ0KV/kpOYd3pA0OatgjhDGVQ/oj4JLp0wB
         tfbScbCOqVOekEaXUAecV8AjOi1vTSBxAjRzA7BDGZYGshqL7KBPws+Ihsb90cjqylNU
         p+Yv+Lh9vFcG/lQRm4hhiJetTA7a6XcOhNfPB8rM1jBSNoyYzSbr7O461WTXz3bYvTsa
         TCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mAX5GgZha2TcofiNJRRU4sF2hrfOy7RqzwNdwZvGNfc=;
        b=THIeXot5sDp+HHZipMo9z/XCUSA2S3F4fRlV6FEvxQdrukKHgfb9rd4W0KuV8JgMA6
         aSP2H0yFf5cj6++Hd+XZ7epb+iUZgSM1mJJEEUNRvxMzt1vtZZJyJf37pP4rAIlSmtWa
         jyeYQ1UGlA36JU6s7EjaG3+MFBZhXrJgZaRQb5ucBzAw3Ad8Xwr9kZiwisUuTsJfDKah
         4hkiorHQzNvm0xcCADIVw1NmZHGa42DOSg7Nm8gLEyzNkhaU94yd/wTWD178NlQS3pNN
         9zxrqncMvd47eot37IE8qPmpcj10IXtbwTKEGfp04gbu9YpH0fe+cAlyozXcoKAaLsVv
         rt/Q==
X-Gm-Message-State: APjAAAXxcQrJghJCCGc7Pp3V1nHiTwi/eyA3vHeimacbHQuIc26GJ28+
        qD+UiTYEs5rweRmOEplgARc=
X-Google-Smtp-Source: APXvYqy64CrBGraGgm6BwQLPKs7K5YQ9eN2fW5fS8I4+jgLMQuN4WiGv0Z5AeQn/xRuNQ0vS82UdnQ==
X-Received: by 2002:ac8:1c7c:: with SMTP id j57mr11533078qtk.58.1556190553116;
        Thu, 25 Apr 2019 04:09:13 -0700 (PDT)
Received: from [10.0.1.5] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id u3sm10545737qkc.21.2019.04.25.04.09.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 04:09:12 -0700 (PDT)
Subject: Re: [PATCH v2 3/5] commit-graph: create new version flags
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        avarab@gmail.com, Derrick Stolee <dstolee@microsoft.com>
References: <pull.112.git.gitgitgadget@gmail.com>
 <pull.112.v2.git.gitgitgadget@gmail.com>
 <4ddb82916321f093d88282ef4bcab99993339fb5.1556135881.git.gitgitgadget@gmail.com>
 <xmqqftq6y7nv.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <eb1ec575-601c-d50e-dfd1-beab1debcc96@gmail.com>
Date:   Thu, 25 Apr 2019 07:09:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:66.0) Gecko/20100101
 Thunderbird/66.0
MIME-Version: 1.0
In-Reply-To: <xmqqftq6y7nv.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/25/2019 1:29 AM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +	int version = 0;
>> ...
>> +	if (flags & COMMIT_GRAPH_VERSION_1)
>> +		version = 1;
>> +	if (!version)
>> +		version = 1;
>> +	if (version != 1) {
>> +		error(_("unsupported commit-graph version %d"),
>> +		      version);
>> +		return 1;
>> +	}
> 
> The above sequence had a certain "Huh?" factor before 5/5 introduced
> the support for a later version that is in use by default.
> 
> Is it sensible to define VERSION_$N as if they are independent bits
> in a single flags variable?  What does it mean for the flags variable
> to have both GRAPH_VERSION_1 and GRAPH_VERSION_2 bits set?
>
> What I am getting at is if this is better done as a n-bit bitfield
> that represents a small unsigned integer (e.g. "unsigned char" that
> lets you play with up to 255 versions, or "unsigned version : 3"
> that limits you to up to 7 versions).
> 
> You use an 8-bit byte in the file format anyway, so it might not be
> so bad to have a separate version parameter that is not mixed with
> the flag bits, perhaps?

This is a reasonable idea, as this is a "pick exactly one" option.
It is still important to reduce the overall parameter count by combining
the other boolean options into flags.

Thanks,
-Stolee
 
