Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABE5C433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 20:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352605AbiETUFf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 16:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236170AbiETUFe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 16:05:34 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BD819CB55
        for <git@vger.kernel.org>; Fri, 20 May 2022 13:05:32 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id n145so250366iod.3
        for <git@vger.kernel.org>; Fri, 20 May 2022 13:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+f5frLtBYu5G8ILhSlrVy+3QnjFoc2zSFu9hcXDjfuo=;
        b=XklvFUXPlErGDBxXU94kpbylaFb2j8XPuB95H8QKw4RAR5YQ1sK0uUCYRgewo5SM6T
         HpjazvAtm+GG0X1YeA4hD+RIM55vjm2TXldgLeXWSfzqjoZ0zz4CIAkHzPpLrWe6P7PT
         M1alYq0Tx0PVsbEqKkOSn/teBRRAFc5zviKGwFJarqKMGba5xq3LfsVPzbWe8LPgqD64
         tmXr7kTQ+kJIZAmAYGosMXZqYSOuzHy1P2/efLSrP8mW28bhOM7ykM/o8LVGr/dFFbWp
         0JpOufcDNLca4rFo/24YzfKeWmNNnhmjz64rrrB/YpZdGECxuLBpO8P6Y98Eoqw5YapK
         U9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+f5frLtBYu5G8ILhSlrVy+3QnjFoc2zSFu9hcXDjfuo=;
        b=LG8wLWOGgt67hggNcHeSIXKy90mWys9tNEwnU2mHzRRaIE23goZMg2vUK266cca0/H
         5coUUoApRWKGgmmOYHm1r9uPeFfTfmYifa7UKlIgkwwHq8ZMCRfCiFYMEzFn0pXNuUKV
         5/m5+WahAsQhiVdvbu2JNPqb4yY9uC4FS45PtPJlJ84gQVDGi3PuULFdTJzx9oBxNLVL
         5syt5PdmjYd8fQ0VE/JpexnNsTgLgzFslDZlLbT4fbljNRD2f+fj/Mgj5XedgQleu8a2
         xJLtnG6KEE8/tQ0d1Bx6PrRZsHlJF6J00g1YxseRjm0tbM6Zcr1bPneEZJEdi3R3Q1DF
         JVrQ==
X-Gm-Message-State: AOAM532hQoA5Due9guEkKpYYclOd0qiIINQXznbfNgZ4e05OehXSWOkd
        hx2nsRh+YPcSdZTk39jU6ral
X-Google-Smtp-Source: ABdhPJxIWNx7ogtomTl2TKiiftlEBNfj2b56OCKso/YwTxDhgUK8wtmgfnwGVdMiqqesSaRvA9WBTA==
X-Received: by 2002:a05:6638:411f:b0:32e:a114:54e with SMTP id ay31-20020a056638411f00b0032ea114054emr2075147jab.82.1653077131529;
        Fri, 20 May 2022 13:05:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:34b9:84ab:204:3752? ([2600:1700:e72:80a0:34b9:84ab:204:3752])
        by smtp.gmail.com with ESMTPSA id y21-20020a027315000000b0032e2e27cd93sm911796jab.82.2022.05.20.13.05.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 13:05:31 -0700 (PDT)
Message-ID: <b151f2bb-bdc7-e004-f1d4-e1a83c2b73db@github.com>
Date:   Fri, 20 May 2022 16:05:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 0/3] repack: handle --keep-pack, --max-pack-size for
 geometric repacks
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com
References: <cover.1653073280.git.me@ttaylorr.com>
 <5517f0f8-871c-a155-7d8c-d0d6086bb7d2@github.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <5517f0f8-871c-a155-7d8c-d0d6086bb7d2@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/20/2022 3:46 PM, Victoria Dye wrote:
> Taylor Blau wrote:
>> This series fixes two issues that Victoria and I noticed while working on an
>> unrelated issue yesterday.
>>
>>   - The first patch comes from Victoria's earlier submission[1], and addresses
>>     an issue where packs specified as kept via the `--keep-pack` option could
>>     potentially be removed (without rewriting their objects) during a
>>     `--geometric` repack.
>>
>>     The first patch is Victoria's alone, with some minor fixups applied from my
>>     review in [2]. It's included in this series since it's related, and avoids
>>     any conflicts when merging.
>>
> 
> I'm happy with the fixes you applied here and don't have anything else I'd
> like to add this patch.
> 
>>   - The latter two patches are mine, and address an issue where specifying a
>>     `--max-pack-size` value during a `--geometric` repack could result in object
>>     loss because of a false positive in our "did we write a pack with this
>>     name?" check (which can occur when the list of packs we wrote isn't sorted).
>>
>>     The first of these two patches demonstrates the issue (done in a separate
>>     patch, since the scenario is quite involved), and the second patch fixes the
>>     bug.
>>
> 
> I was worried about the robustness of the test, but some deeper diving
> revealed that it should produce consistent results. Otherwise, the fix
> itself is a straightforward (albeit hard to find in the first place). These
> two patches look good to me!
> 
>> Thanks in advance for your review.

I'm chiming in to say that I also read these patches and think they
are good. Couldn't find a way to improve them.

Thanks,
-Stolee
