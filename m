Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034C4C433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 19:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344392AbiCUTqo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 15:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351077AbiCUTqn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 15:46:43 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8217307E
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 12:45:16 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id g8so12521994qke.2
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 12:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kKaHIwYz4kbD9r5bv5BmKVPSeJ6b1zyEUK5HX69Vl90=;
        b=XS+bFiWzd6pMWB0dOlsuvRnS7LwHK86+BQnPnMgExpRIgL5lpejQ0d7wy7jYO3Y59q
         ipbqzWcRQNw9hO1/y6Vp98kLK183etsvkGuZKLboQ0cvBiGU8QPLcuYyMVmIVFUKjBMk
         0VzcSrKmq58g2UfWNFOsPdAw2XVG1JCTP5hOWW40bFsFk/NAJFBtBsvCOUnOsb7ZCtOH
         w7q2lkDbV0xqaeJpgQbs1MIxBPaCPIAyjqsyDUvqwR/KjeaG0QGjwN4CZ897Us8qKvbJ
         NBXlY9eAO5CrPXXc1F8t8tB0K8LF3venqRF0R+QVhgetZDu5L6y8kjF4gU4E2XRZSdOG
         6Uaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kKaHIwYz4kbD9r5bv5BmKVPSeJ6b1zyEUK5HX69Vl90=;
        b=hX+EiIY8ok7ZqsLbX42b+uF5LWqv2yPkCo1kzhhvH76F9U5hLZ8z3kQ1LsyFJ7ZMxo
         YKYU8Ffx/Ee+NoQs8SDDyqYRoGzNKjU+QsgDrNRqvkQWaOtZY/jkzQj8wvolqg/9Wl6V
         WMKweolD/8t+5KNUs+62f2rwrxWPUjTQTvkm3jlCMZ5FzSyW10s/hWGYpb4XE5E6Fpbo
         O4wuE4v+69KgtOdQIOGDUmxh6FIwgrECP/JCRLkG/anW4HPduQT8+WgVCQCuY8RnK3hV
         8Y0wRXor2GxC8v2zCkWZU1sFaIQ9PNBnMcGWszqUE9rzQ3eHIFxtDqQpU4menrc+i6CZ
         isoA==
X-Gm-Message-State: AOAM530C+cwyscEmiqK3thNmo2aIuUN3Jh5OJwwOh4UZGzJ/4iZAEZbk
        9e5b1p1HCCd8+5isrI0T/DCKxlXYM7/i
X-Google-Smtp-Source: ABdhPJzwQJycXRQCJ7M5IORe00bQAQnY7SUr15Mt9gqEXi6Xr8BgV852Xxw0l8afO4sJKFCQJ8+GmQ==
X-Received: by 2002:a05:620a:22cf:b0:67e:e43:239d with SMTP id o15-20020a05620a22cf00b0067e0e43239dmr13593560qki.299.1647891915774;
        Mon, 21 Mar 2022 12:45:15 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id m14-20020a05622a054e00b002e2072cffe6sm6618840qtx.5.2022.03.21.12.45.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 12:45:15 -0700 (PDT)
Message-ID: <b64c1805-dff9-3fd3-1e5e-84bd68d4b058@github.com>
Date:   Mon, 21 Mar 2022 15:45:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH 1/1] mv: integrate with sparse-index
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Victoria Dye <vdye@github.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
References: <20220315100145.214054-1-shaoxuan.yuan02@gmail.com>
 <20220315100145.214054-2-shaoxuan.yuan02@gmail.com>
 <1ab24e4b-1feb-e1bc-4ae4-c28a69f77e05@github.com>
 <CAJyCBORDOJUwTzOC+hYwGGPUBCXST0_mBdwRLh2N+cA=5k0d4A@mail.gmail.com>
 <675c7681-c495-727d-1262-ee8c6a5c8ce5@github.com>
 <CAJyCBORfAV_TV6DrOxgim4KtU9T-uTibOaQCsJZsi5_FQfci1Q@mail.gmail.com>
 <97a665fe-07c9-c4f6-4ab6-b6c0e1397c31@github.com>
 <xmqqo824cbxl.fsf@gitster.g>
 <e127dadb-7b44-55f8-16ea-9fcf94905db8@github.com>
 <xmqq8rt3xgmb.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqq8rt3xgmb.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/21/2022 3:14 PM, Junio C Hamano wrote:
> Derrick Stolee <derrickstolee@github.com> writes:
> 
>>>> Another tool that may help you here is 'git ls-files --sparse -t'. It lists
>>>> the files in the index and their "tags" ('H' is "normal" tracked files, 'S'
>>>> is SKIP_WORKTREE, etc. [4]), which can help identify when a file you'd
>>>> expect to be SKIP_WORKTREE is not and vice versa.
>>>
>>> Wonderful.
>>>
>>> Quite honestly, because the code will most likely compile correctly
>>> if you just remove the unconditional "we first expand the in-core
>>> index fully" code, and because the "sparse index" makes the existing
>>> index walking code fail in unexpected and surprising ways, I
>>> consider it unsuitably harder for people who are not yet familiar
>>> with the system.  Without a good test coverage (which is hard to
>>> give unless you are familiar with the code being tested X-<), one
>>> can easily get confused and lost.
>>
>> Certainly, 'git mv' is looking to be harder than expected, but there
>> is a lot of interesting exploration happening in the process.
> 
> Yeah, I know.
> 
> I am suprised that it is harder than expected *to* *you*, though.
> After having seen a few other topics, I thought that you should know
> how deceptively easy to lose "require-full" and how hard to audit
> the code that may expect "a flat list of paths" in the in-core index
> ;-).

I'm particularly surprised in how much 'git mv' doesn't work very
well in the sparse-checkout environment already, which makes things
more difficult than "just" doing the normal sparse index things.

It's good that we are discovering them and working to fix them.

Thanks,
-Stolee
