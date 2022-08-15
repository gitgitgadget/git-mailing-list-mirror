Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC16BC00140
	for <git@archiver.kernel.org>; Mon, 15 Aug 2022 13:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbiHONE5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Aug 2022 09:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbiHONEz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Aug 2022 09:04:55 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A27913F14
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 06:04:54 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id n4so8981096wrp.10
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 06:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc;
        bh=DnWRiDN4Qf5O//IvvGXEQ+ZC0ScFc8W4YVroE9qiZ7Q=;
        b=gqcumH44puluYczPK7c4XWdyQq1YHv0O9qAFHk2i1P9z4Fx+XvmR0TUp2Frhz7FcqL
         vH4l1WRaa0CJJhFzvW2WUxPmaIHRqvSChWH+3Zy19fa7V0Gx4EbcVxYPSt/aBiYlrY65
         ik5JaGRbOg1krlajLdnlgx7p5ksSxBW93GkMKKY4m/yC0U/S0kpJw+3vTk74VFfZJOV3
         WK/zCv+XZoui1Qcg1IsgARA4N/ZsDYTgCz2JwYxvqBHtR5h919guYqeJYVdg/orw6Vdz
         PMBOATxhTTSnZpOyOqfNmI/FCDqArdlEM0m3PEj4ML65UKq+phItLOgTQ/2o9k7V4E5U
         axug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=DnWRiDN4Qf5O//IvvGXEQ+ZC0ScFc8W4YVroE9qiZ7Q=;
        b=1vAh9UXlzRyRXrRIMCv0YSgc4e0M5cUmDPlfID5opfoTUyyJW6x67XgSkOgtzHZkSS
         zdvGmZCXqur6dtz11/mNaDLtIfb1i0j5Bw9npSwd1OqC/Goj/3myVguZpk0FDhs5RBDq
         2XKJ6VVDb6fzoBWtW55ctNMqrcWmD+he65QYZeE2U38czhVqWel0bwTQDHJMgmtNOikC
         DOT1WcHTASUZZz3PNj1OX2IcqNPlnGfcSNWMXaHIWng8MynI8CE/ATh64hriYMY8y+3s
         RGBSRWc1860go/QEnzcPvdR8WNugyuq9xwZSbUQOiDnwc7Q+u8MO04GYfxPV78PIzRSm
         +9fg==
X-Gm-Message-State: ACgBeo3BfnwbMo0MtdLb/VLp3i3VqBy6akvJtoDLnfwSl3fcol/ziPee
        v2ym+HmLVMKAgRRFq50+Kgs=
X-Google-Smtp-Source: AA6agR4ikSjnoJFpQhLHdQ0fs/3oMkIs9l8/7gzgJQYDJGcn1jFuzLNfAVgBJomMjS4ApYqtjM3hPQ==
X-Received: by 2002:a5d:47ab:0:b0:223:60ee:6c12 with SMTP id 11-20020a5d47ab000000b0022360ee6c12mr8496843wrb.315.1660568692837;
        Mon, 15 Aug 2022 06:04:52 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id g17-20020a5d5551000000b0021f0af83142sm7266995wrw.91.2022.08.15.06.04.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Aug 2022 06:04:52 -0700 (PDT)
Message-ID: <08a8e78d-7861-3da3-f6f6-bba466655071@gmail.com>
Date:   Mon, 15 Aug 2022 14:04:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] git-prompt: show presence of unresolved conflicts at
 command prompt
Content-Language: en-GB-large
To:     Junio C Hamano <gitster@pobox.com>,
        Justin Donnelly <justinrdonnelly@gmail.com>
Cc:     Justin Donnelly via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        newren@gmail.com, phillip.wood@dunelm.org.uk,
        Johannes.Schindelin@gmx.de
References: <pull.1302.git.1658798595633.gitgitgadget@gmail.com>
 <pull.1302.v2.git.1659132518935.gitgitgadget@gmail.com>
 <CAGTqyRw-SYDbQy9aktq5s3ZhoDhUOCf-pEopjH9m7v5+PH7Qqg@mail.gmail.com>
 <xmqqy1vq3zm3.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqy1vq3zm3.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

On 15/08/2022 05:22, Junio C Hamano wrote:
> Justin Donnelly <justinrdonnelly@gmail.com> writes:
> 
>> I hope this is against protocol/etiquette, but after some initial
>> feedback from Junio, I haven't gotten any more. I wasn't sure if
>> nobody had seen the patch, or if there just wasn't any interest.
> 
> It probably is a bit of both.  I personally did not see much point
> in adding the long "conflicts" marker to the shell prompt (I did
> worry about possible complaints by end users triggered by seeing
> them suddenly without asking, which was why I commented on the
> patch) and I was waiting for interested folks to speak out.
> 
> I do not know about other folks if they did see and did not find it
> interesting, they are not looking at others' work, or your second
> round came on a particularly bad day (busy with other topics, or
> weekend just before the list was swamped with many new topics at the
> beginning of a new week, or something).  Pinging on the thread like
> you did would be the right thing to do to "kick" those, who did see
> and who were in favor but who kept silent, into action ;-)

I had not commented as I don't use the prompt. I have just had a quick 
read and I wonder if it would be more efficient to use
     git diff --cached --quiet --diff-filter=U
rather than
     git ls-files --unmerged 2>/dev/null
to check if there are unmerged entries, but as we don't normally expect 
there to be that many unmerged entries it probably does not matter.

Best Wishes

Phillip
