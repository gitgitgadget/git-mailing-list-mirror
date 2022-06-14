Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B33C433EF
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 14:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243075AbiFNOWQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 10:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236158AbiFNOWO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 10:22:14 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE7F5F53
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 07:22:13 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id z11so6667513ilq.6
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 07:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=j0lkwtKGZHBqmr0lfU3SNzYfgN1ht+svZvtpBFlkK6w=;
        b=CjJJTykHd3UxfcnK9alybj4DjKn5y5zjXYt+vU03XT7GLHGffzFXjz4JuBkICBM7Lx
         fGtF6lyrdx/smBUYy21fSd4d4vZy6LLIOMUpTF5sX/7AJm91Ivq8NrV66cSyUhT0lSTo
         rhzo/4lNqjqnfyZbQNWBCnCTIsAE3WnBFlHtdylIsFV86wTTXLdigbeHelCw2NSoNqT2
         ejjbPiSfQuC2UUkHT7cLvEK3bHmfWdo8/gk04nhkuYf0VsyCwwdD1SDKQvenZV+5IAci
         iOzIleEEdnxRTktdtbRkL/ddhCx1uj21AWdtONjbHBlO2dGX9JTPyKfwjs4BsF+bpwZg
         SSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=j0lkwtKGZHBqmr0lfU3SNzYfgN1ht+svZvtpBFlkK6w=;
        b=bRMztwubxK0jFMVdhnnkG9VhWQcWvtY4C/Yqyz8i/vfOa8+EOZgtxiewf1zSQxRHis
         n0Hd8bbc7QpZzIDaSwQqU7pshq5Ve020HgzLrDIdyAKVDxagqc5vr0QejRabkyGxre1S
         ERNaqZBklLJ0CDEIaoXU8Jsq65QjDFhR87f97lWmxZk3IHV+Rx1eHL2rLu12IsZDA9c4
         A9UfHae7JDrItCimKUdn8YoDEVtI3RzejPPDCcAxMjLSTph341quZ7WT7M6XEyvyX6m2
         l4jMknOhxZItKVBS6nRAt1Bjq4UbbOWZuPjpWUSrifnNv93ryVcJjQtRFiLqbuXmRz07
         ktJA==
X-Gm-Message-State: AJIora+dCoX9xWRbp9WHRmAADPrjgCzm8xV8tjdj8OEJZv5u2qdQlsFD
        oLYmTl88XflCXR9ox2ooLCHA6fv64Ofu
X-Google-Smtp-Source: AGRyM1vxc0R+gGNbFUgRY8SS3e6Ij+5h20wKw4bp9KhiBTFS2wgoZOWIE6ar9NHJWb2IMfc9IhrXqA==
X-Received: by 2002:a92:c24c:0:b0:2d1:cdd0:1959 with SMTP id k12-20020a92c24c000000b002d1cdd01959mr3061507ilo.39.1655216533039;
        Tue, 14 Jun 2022 07:22:13 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:508:3b97:7c0b:efc0? ([2600:1700:e72:80a0:508:3b97:7c0b:efc0])
        by smtp.gmail.com with ESMTPSA id r8-20020a02b108000000b0032b3a7817e9sm4891885jah.173.2022.06.14.07.22.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 07:22:12 -0700 (PDT)
Message-ID: <78ce313d-a93c-ca2a-12f9-a6afbd6f15a2@github.com>
Date:   Tue, 14 Jun 2022 10:22:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [Internet]Re: reachability-bitmap makes push performance worse ?
Content-Language: en-US
To:     =?UTF-8?B?a3lsZXpoYW8o6LW15p+v5a6HKQ==?= <kylezhao@tencent.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <b940e705fbe9454685757f2e3055e2ce@tencent.com>
 <220614.864k0nzkgp.gmgdl@evledraar.gmail.com>
 <d92e5a26e7664d7ab8ab1215ecaea6bf@tencent.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <d92e5a26e7664d7ab8ab1215ecaea6bf@tencent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/14/2022 7:00 AM, kylezhao(赵柯宇) wrote:
>> This is a known issue, I think you've found the same problem discussed in these past threads:
>>
>> https://lore.kernel.org/git/38b99459158a45b1bea09037f3dd092d@exmbdft7.ad.twosigma.com/
>> https://lore.kernel.org/git/87zhoz8b9o.fsf@evledraar.gmail.com/
> 
> Thanks.
> 
>> The latter one in particular has a lot of extra details. The former also
>> has the suggestion of a per-push bitmap configuration as a workaround.
>>
>> As your numbers show it's still an issue today, but those threads should
>> help you if you're looking to dig further into the root cause.
>>
>> Aside from the underlying root causes it would be very nice to fix the
>> progress code in that area, i.e. we "stall" on "Enumerating objects",
>> which is just a matter of us not having a separate progress bar for the
>> very expensive bitmap work we're doing.
> 
> It looks like optimizing the bitmap to solve the problem will be a long
> process. This requires developers to have a deep understanding of the
> algorithm.
> 
> A per-push bitmap configuration as a workaround can't completely solve the
> problem, but it works for me. After all, bitmap was not designed to optimize
> git push. Most of time, git push is not been called as frequently as git fetch.

I think the issue is that bitmaps are designed to support servers, which don't
exactly use "git push" but instead use "git upload-pack" with a very different
type of data (a lot of branches simultaneously from a large variety of bases).

In general, clients that use "git push" don't generally have bitmaps, so this
has not been a priority. For clients, it is faster to do a more focused object
walk. See these commits and blog post for more details:

* d5d2e93577 (revision: implement sparse algorithm, 2019-01-16)
* 3d036eb0d2 (pack-objects: create pack.useSparse setting, 2019-01-16)
* https://devblogs.microsoft.com/devops/exploring-new-frontiers-for-git-push-performance/

Hopefully that gives enough context as to why one would want to disable bitmaps
for most "git push" operations.

> The problem has been around for 3 years, has the community considered providing
> a config like "push.useBitmap" to prevent git push using bitmap? It would be
> appreciated if there is such a config, which can quickly solve my problem and
> doesn't seem like a lot of work.

I think this config would be a good idea, and I would even argue that we might
want to set it to "false" by default.

> If no one is interested in it, I can also try to submit a patch (although it
> may be a bit slow since all I am new to the git community).

We would welcome the contribution! I look forward to seeing it when you're
ready.

Thanks,
-Stolee
