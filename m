Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0845BC433F5
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 19:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244937AbiDGTK1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 15:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240852AbiDGTKW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 15:10:22 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D262325FA
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 12:08:18 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id 125so7959222iov.10
        for <git@vger.kernel.org>; Thu, 07 Apr 2022 12:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=NGzvxBP0rI3BQfZywXoae6qEFCbzzQA3/bRQzPP7JPo=;
        b=Z60RQwOzlwNEf0FiKLHN61CTojkwo/3/iSjc+rx+He5h+YQoDdwQYTlbG+WzFxv3n+
         PJWL0ViPZyLvwVm6Om+WOKEhewlr1+t+qP5iggxzN0e+YpfS5qHVLW5G1mmEWIi6RvbU
         bQW7IBpHZtyvnYwxboEmw2PsHLudK8VVNLW/HYAOCHAMwk7rydbb43MFlul3WdcnSgXg
         WML0n4Le9H4AskG+Yj8cOlO0R5prCsYs0NqPzZZUF9kDA+ZvrU7NnjWInh7Q7fzG9Ia+
         ydtke07t2fgfEDwmyrdWOZ60f5vga+8t+nhQuemzvjMeEOLB48Bfb2C+QfNjbN42PObS
         uS1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=NGzvxBP0rI3BQfZywXoae6qEFCbzzQA3/bRQzPP7JPo=;
        b=4grgftDKVjOOLwSnoLL4Aa2qXYIZVyzmI6xUjCHBBgm4XnUtgNYqpp/zyTeTugAp6y
         wERbSvpzugYNnOCVDOr0++1/2MuBzGpPxppVcJMYqbXDyy64H2l+UDTS2Dmo3QCD5FEF
         Mn06UfqpRFQx1v8il2h8K4mqjsrS3hVzHnro4+bnG5e9Mgo1ZB2hJGnV7VY12GIIsO1q
         FtZ/PDDAGurHrew+H2hD/v33Vs/9rFvTzt56RaqXOkXRnTI0PQYROGt8uta+JnifxNl8
         tCH5c5MmHWums0PtXDtH74l3eu1IHQ4UBdPnk/5z0SLu2fjnBcKNx3PG+VOj0TiFsnsG
         EZTQ==
X-Gm-Message-State: AOAM5300yCVenhR/Pt2lH/kOgN4aw1dXn6R/B39+Y8o6JokzS8kWojVA
        KtR9Hn8GZrCc3ptEeZGe5wGS
X-Google-Smtp-Source: ABdhPJyL99949ls7KGqWTQ50Ulq98L64YD1cZjEeLKVpNtfQGo1kdMGVV5Ohck6wBlayzSaHPrI2ug==
X-Received: by 2002:a5d:8486:0:b0:64c:6c6b:4660 with SMTP id t6-20020a5d8486000000b0064c6c6b4660mr6709623iom.21.1649358498011;
        Thu, 07 Apr 2022 12:08:18 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id g1-20020a056e021a2100b002ca4271e759sm7974761ile.30.2022.04.07.12.08.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 12:08:17 -0700 (PDT)
Message-ID: <1b63a8eb-9a6d-a07e-9070-9cdc0c4d5a1c@github.com>
Date:   Thu, 7 Apr 2022 15:08:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 00/25] [RFC] Bundle URIs
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, "Robin H . Johnson" <robbat2@gentoo.org>,
        Teng Long <dyroneteng@gmail.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
References: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
 <220224.86czjdb22l.gmgdl@evledraar.gmail.com>
 <15aed4cc-2d16-0b3f-5235-f7858a705c52@github.com>
 <a6981d6e-16b0-b0e1-a94d-a87ec20871bd@github.com>
 <220304.86a6e5g44z.gmgdl@evledraar.gmail.com>
 <1469e420-63e5-e2db-21d5-c70674ab04d5@github.com>
 <ddebc223-1e13-e758-f9b1-d3f23961e459@github.com>
In-Reply-To: <ddebc223-1e13-e758-f9b1-d3f23961e459@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/8/2022 12:15 PM, Derrick Stolee wrote:
> On 3/4/2022 10:12 AM, Derrick Stolee wrote:
>> On 3/4/2022 9:49 AM, Ævar Arnfjörð Bjarmason wrote:
>>> Also, as noted in the upthread
>>> <220224.86czjdb22l.gmgdl@evledraar.gmail.com> it might be useful to chat
>>> in a more voice/video medium in parallel (maybe mid-next-week) about the
>>> high-level ideas & to get a feel for our goals, conflicts etc. Doing
>>> that over very long E-Mail exchanges (and the fault of "long" there is
>>> mostly on my side:) can be a bit harder...
>>
>> I agree. I we can work out a time in a private thread and I can send
>> you a video call invite.
> 
> Ævar and I just finished our chat and came away with these two
> action items:
> 
> 1. Ævar will finish prepping his RFC as-is and send it to the list.
>    It contains several deeply technical optimizations that are
>    critical to how his model works, but could also be used to
>    improve scenarios in the table of contents model.

Ævar: I'm still waiting on the full version of this. While you
updated [1] your original RFC [2], it was incomplete. I am still
looking forward to seeing your full vision of how it works with
incremental fetch and how your optimizations to download only the
headers of the bundles will work.

[1] [RFC PATCH v2 00/13] bundle-uri: a "dumb CDN" for git
    https://lore.kernel.org/git/RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com/

[2] [RFC PATCH 00/13] Add bundle-uri: resumably clones, static "dumb" CDN etc.
    https://lore.kernel.org/git/RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com/

> 2. Ævar will then do a round of taking both series and combining
>    them in a way that allows the union of possible functionality
>    to work.

Or perhaps you are jumping straight to this part?

> 3. As these things come out, I will make it a priority to read the
>    patches and provide feedback focusing on high-level concepts
>    and ways we can split the future, non-RFC series into chunks
>    that provide incremental functionality while keeping review
>    easier than reading the whole series.

I'm still looking forward to seeing progress in this area. Please
let me know what your plan is here.

Thanks,
-Stolee
