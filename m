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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D1E01F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 12:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730995AbfJHMiF (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 08:38:05 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34843 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730674AbfJHMiF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 08:38:05 -0400
Received: by mail-qk1-f196.google.com with SMTP id w2so16550232qkf.2
        for <git@vger.kernel.org>; Tue, 08 Oct 2019 05:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wN+EbvxKFWbDtjcT5LjLKbAkjKE2P5CWfmuc0+YBWgY=;
        b=HoqV8zb3Q//ddULePpMitXpolgtdSRyj0/NiNFwwVlGabzD5Zh4+H2fmhGw2MbW1nc
         DLarLxkeIT2xfh+ZYoS3/JMuqa5cD6QOPMYSrP4nK8ZfN5mtgYpppNAqB8L5842UoxLe
         6ZzHC077U/CqzaX9Ot5X+htnhyvRnCDExy+B0ruhqEMWKF3SYlM9Lmypc8s6FhoxxNsu
         /fDFfr3CORtM4Rm6/Xw6x7Sy++Ip8yHkqVNJbLGDfl/7AXcZaiEp5lj+4PQ4YibDgK6c
         BXtxkfmVp2yTNYqwZ3hD/x7XpD3ny7vs2mEWqCX2Kai0LyGa8YSTr9Bm/et6/AsHUfrc
         IiZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wN+EbvxKFWbDtjcT5LjLKbAkjKE2P5CWfmuc0+YBWgY=;
        b=AS2GTq7pSwQZbrEEdC6DzFwcn2ODTmChJ5m9u+RtzjQDxuqvZisPSxXwReukeJlPHK
         wNyyHI+5uZmnERyuTi0gK4qs++ojCqolkvyJAAObTnm8Vn3+/K1xfwFnkHlRiiwkNRE2
         bsUwTPc8nnTh/IPd535I+7foR3NOHSXf/u0F/Z3BpXBA1hMKPrtyKILdE+bPKtNUmxkH
         W1m/0ZNhoHehRdm8ZKR356z5ohCCeCdXsOTe/fHfdhVcB1im6dqOtXvH7OccPOH5AbOm
         qXKOBDG/GMbf70eLqEquPTr73t2BjhTIGCodLE6SAs4/pXmrRN3dVPv6HKV9GoiWRh8W
         lb0g==
X-Gm-Message-State: APjAAAWav4QPGVZRsfOJVU6cspRd/e1XgAGBB+C3kWZWi5FXch0vQTGr
        FoqBlUVDsTBxYhcW5Lx14DQ=
X-Google-Smtp-Source: APXvYqw4da73ejC58wbfn5HikhMiRQQTmBNP6QHAizV/9IbrzyYQsk1bi6mBJb9KjoVqWtL3OzItFg==
X-Received: by 2002:a37:642:: with SMTP id 63mr28803117qkg.29.1570538284299;
        Tue, 08 Oct 2019 05:38:04 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c988:3ed2:5e14:1c0f? ([2001:4898:a800:1012:7abc:3ed2:5e14:1c0f])
        by smtp.gmail.com with ESMTPSA id x15sm7119163qkh.44.2019.10.08.05.38.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2019 05:38:03 -0700 (PDT)
Subject: Re: [PATCH 07/15] t4011: abstract away SHA-1-specific constants
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20191005211209.18237-1-sandals@crustytoothpaste.net>
 <20191005211209.18237-8-sandals@crustytoothpaste.net>
 <4733b8a0-bfd9-a49a-01d2-1c9f2a48cdf8@gmail.com>
 <CAKPyHN3NaBv5s9aefb8fTDeGto2tLyTa0DxTjbWO9pGRY22pPQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <db17a07f-1edc-f55a-8dc6-ab41287afcc6@gmail.com>
Date:   Tue, 8 Oct 2019 08:38:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <CAKPyHN3NaBv5s9aefb8fTDeGto2tLyTa0DxTjbWO9pGRY22pPQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/8/2019 8:33 AM, Bert Wesarg wrote:
> On Tue, Oct 8, 2019 at 2:21 PM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 10/5/2019 5:12 PM, brian m. carlson wrote:
>>> Adjust the test so that it computes variables for object IDs instead of
>>> using hard-coded hashes.
>>
>> [snip]
>>
>>> @@ -137,14 +141,17 @@ test_expect_success SYMLINKS 'setup symlinks with attributes' '
>>>  '
>>>
>>>  test_expect_success SYMLINKS 'symlinks do not respect userdiff config by path' '
>>> -     cat >expect <<-\EOF &&
>>> +     file=$(git rev-parse --short $(git hash-object file.bin)) &&
>>> +     link=$(git rev-parse --short \
>>> +             $(printf file.bin | git hash-object --stdin)) &&
>>
>> Why this change from $(git hash-object file.bin) to
>> $(printf file.bin | git hash-object --stdin)?
> 
> thats two different things. The first hashes the content of file
> "file.bin". The second hashes the literal string "file.bin". To avoid
> this confusion, may I suggest to use 'printf "%s" "file.bin"', so that
> it is clear, that the literal string is meant in this context?

Ah, and because the resulting hash is for the contents of the symlink
(not the contents of the file), it makes sense to use printf here.

Thanks for the clarification!

-Stolee
