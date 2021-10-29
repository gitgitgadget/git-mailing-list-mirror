Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0ABC433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 10:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20FA860F0F
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 10:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhJ2K0c (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 06:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbhJ2K0b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 06:26:31 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D79C061570
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 03:24:03 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r8so2653172wra.7
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 03:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=400QdisWrAkcTsDyXejiOJiFkupbdN8eE+GWgA5dAp8=;
        b=MDZlhMREjGMfATOjMXrNpEjAc4puuUqzhvSrAcnZyjMWGwl5W9W8tp9bKOJUB2OJB3
         FfAAXnRX1185uYr56IVuH+kBUFPq64vej1e3m24f7EAJvV5DUgfv/uhXlBDujAzqqaQG
         QoR9rv/hhstMlnjnkR5bY/DiNEc43m9cNRVXsWNvOtixTti4+vjggpm3qR0rbgTpAw3B
         LzQv2eZJ1ScYzzCli8r49dp9izLyRDtijeH80Ds9bVf3RhZ1WPqxRODN9Osio9ia8QPs
         dIedgjTNUdRNakQrpR4fbch4lGCIt1LLOUjlvumzKXmDiBBI99KoAQTvQvlbrXj/DHdE
         n1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=400QdisWrAkcTsDyXejiOJiFkupbdN8eE+GWgA5dAp8=;
        b=5+CspB/chxefoULCTHjkfYinz6WPa7MXw5yjpgrvAA9ZnZBX+21Qju4eG34whCdnI1
         /e0CeZlRs4ga4pSZgWXXEEdduZt709dooxuULHC9ui1p9gyxUDHriA2JaJuaQnhzK37J
         JIOdntx++xE667rL6vhwO7vMUVEZe7E32kQBuMYVjJDGQ61sF4V1outEsQTl+QQsfiGR
         LoS9ask0jNHz1Wisv3hOJb28Rhv9j9uXE5zPST5IDrpxeqCYzq1kTKT8IZBqEtwUPbXK
         nEBfd+3QBbtLk4HdJTJiNohmLhjBM93F2w2EPzUdIsxHRDFoV5aHEmF1tLKvwrJybfNM
         2rtQ==
X-Gm-Message-State: AOAM5329wIZdPEPEdBSkZEpaQLtNA8xwTcUtejlnaEfG9gjlQCd01PRP
        4hUpZyuCQg66G4aRLguQ1p4=
X-Google-Smtp-Source: ABdhPJy1oAjIulYJxP+W0/wXOXHEj+uuyQBm1MVQXOXht/YaA0t+8VLTSbDvFJ2KvGWw96J0fa/5CA==
X-Received: by 2002:adf:da44:: with SMTP id r4mr13426728wrl.180.1635503042181;
        Fri, 29 Oct 2021 03:24:02 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id 9sm8090570wmi.46.2021.10.29.03.24.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 03:24:01 -0700 (PDT)
Message-ID: <b6f57fc3-75d9-d7d5-7153-28dde066a101@gmail.com>
Date:   Fri, 29 Oct 2021 11:24:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 01/15] diff --color-moved: add perf tests
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.981.v2.git.1626777393.gitgitgadget@gmail.com>
 <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>
 <8fc8914a37b3c343cd92bb0255088f7b000ff7f7.1635336262.git.gitgitgadget@gmail.com>
 <xmqqsfwkq1h4.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqsfwkq1h4.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 28/10/2021 22:32, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Add some tests so we can monitor changes to the performance of the
>> move detection code. The tests record the performance of a single
>> large diff and a sequence of smaller diffs.
> 
> "A single large diff" meaning...?

The diff of two commits that are far apart in the history so have lots 
of changes between them

>> +if ! git rev-parse --verify v2.29.0^{commit} >/dev/null
>> +then
>> +	skip_all='skipping because tag v2.29.0 was not found'
>> +	test_done
>> +fi
> 
> Hmph.  So this is designed only to be run in a clone of git.git with
> that tag (and a bit of history, at least to v2.28.0 and 1000 commits)?
> 
> I am asking primarily because this seems to be the first instance of
> a test that hardcodes the dependency on our history, instead of
> allowing the tester to use their favourite history by using the
> GIT_PERF_LARGE_REPO and GIT_PERF_REPO environment variables.

p3404-rebase-interactive does the same thing. The aim is to have a 
repeatable test rather than just using whatever commit HEAD happens to 
be pointing at when the test is run as the starting point, if you have 
any ideas for doing that another way I'm happy to change it.

> The intention of the tests themselves looks quite clear.  Thanks.

Thanks

Phillip

>> +GIT_PAGER_IN_USE=1
>> +test_export GIT_PAGER_IN_USE
>> +
>> +test_perf 'diff --no-color-moved --no-color-moved-ws large change' '
>> +	git diff --no-color-moved --no-color-moved-ws v2.28.0 v2.29.0
>> +'
>> +
>> +test_perf 'diff --color-moved --no-color-moved-ws large change' '
>> +	git diff --color-moved=zebra --no-color-moved-ws v2.28.0 v2.29.0
>> +'
>> +
>> +test_perf 'diff --color-moved-ws=allow-indentation-change large change' '
>> +	git diff --color-moved=zebra --color-moved-ws=allow-indentation-change \
>> +		v2.28.0 v2.29.0
>> +'
>> +
>> +test_perf 'log --no-color-moved --no-color-moved-ws' '
>> +	git log --no-color-moved --no-color-moved-ws --no-merges --patch \
>> +		-n1000 v2.29.0
>> +'
>> +
>> +test_perf 'log --color-moved --no-color-moved-ws' '
>> +	git log --color-moved=zebra --no-color-moved-ws --no-merges --patch \
>> +		-n1000 v2.29.0
>> +'
>> +
>> +test_perf 'log --color-moved-ws=allow-indentation-change' '
>> +	git log --color-moved=zebra --color-moved-ws=allow-indentation-change \
>> +		--no-merges --patch -n1000 v2.29.0
>> +'
>> +
>> +test_done

