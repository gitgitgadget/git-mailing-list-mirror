Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEEFC433F5
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 18:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236662AbiB1STd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 13:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240613AbiB1SR5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 13:17:57 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58233AA02A
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 09:54:32 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id k9-20020a056830242900b005ad25f8ebfdso10109131ots.7
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 09:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kUR4mQosTcLZobVF9Jlvq6ZdgUzvgVJsyJiZflqDtG0=;
        b=fW9mSoBEyDOTdQuFa7BfWjMOvV/mRB9RReLib0/+KkVpmNAVcu2+bH/qBECuiO2WEt
         I50Nw+ONT07oc133nbSM7MCPaHMG+XKA9PbgJSu+1+/pmCBAB5VviqKVBUuR4h1/yh0f
         JWqoqUv/2grVWEOUHi+wHzvmGJa8K0Igy44FVuHnjDp0OIYX4da6alwqQ5UtIQUsHfAg
         Txq6+fG4EgWR3eIrPUP3qQXdKHp5y2Jt6Zl/ZrvixU2NwpJaRnJohoNWXiM63KM7LBfF
         cRZXk/Zy8MMMVM+gNA/iYi4mmwKyM2GGTiQRyrzfRBUc2OnFXQHHKXqSj/28h1RoDvF4
         Uh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kUR4mQosTcLZobVF9Jlvq6ZdgUzvgVJsyJiZflqDtG0=;
        b=0hG2f+KMAy0mpikRLawj9d8p9zuGU3WGp/bCWJMVr0OdaW4Z93we7ydY948rzR9evU
         VJtbsweGXa2R//U0D04EFZb+mczcOAifs5kVPpaMO04bqB6+GT3NOJnjP4ImZiZklrxP
         Ct/NZayhEeezqjsbOrCl9M4EYo7+JFq/zpwmMQAS9PD+A5p8UzF6YCRFuY0oaKPjAGzn
         dQ+PyYBNRFC4ABybeM3Yb0x903m++HZACso/i/psRpgy2bLnZ2CBsN5yTN2aJD7QOpd+
         1MlK7+lsOYCB1bfWGGVJf6FJXLsRxBt+Rvilh6gKTJs+zPVKgTINf69GMCN2c4ZQpHEi
         EUVQ==
X-Gm-Message-State: AOAM533wtjEfOTHTqiCi+8NVG0XfGCAsaag/Afz/nawrkJDm7g0KtvQ+
        Y7UtyGpaNChuBv2zJXZxzRT2
X-Google-Smtp-Source: ABdhPJzb7YxM8uSlw64et/dT8SS0aUzdasekH0l52Mjcj48eR03Wb7Uo/OfW634+20AhiwXGiIk4fA==
X-Received: by 2002:a05:6830:23a6:b0:59e:59e0:b0a0 with SMTP id m6-20020a05683023a600b0059e59e0b0a0mr9812787ots.91.1646070869829;
        Mon, 28 Feb 2022 09:54:29 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id l10-20020a9d708a000000b005af3e65ce95sm5204603otj.70.2022.02.28.09.54.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 09:54:29 -0800 (PST)
Message-ID: <be99d6c1-7137-9661-6f2b-bc80732003b4@github.com>
Date:   Mon, 28 Feb 2022 12:54:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 00/11] Partial bundles
Content-Language: en-US
To:     Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     stolee@gmail.com, avarab@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
 <6af04989-835b-7fae-6862-002ecd411037@jeffhostetler.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <6af04989-835b-7fae-6862-002ecd411037@jeffhostetler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/28/2022 12:00 PM, Jeff Hostetler wrote:
> On 2/23/22 12:55 PM, Derrick Stolee via GitGitGadget wrote:
>> While discussing bundle-URIs [1], it came to my attention that bundles have
>> no way to specify an object filter, so bundles cannot be used with partial
>> clones.
>>
>> [1]
>> https://lore.kernel.org/git/7fab28bf-54e7-d0e9-110a-53fad6244cc9@gmail.com/
>>
>> This series provides a way to fix that by adding a 'filter' capability to
>> the bundle file format and allowing one to create a partial bundle with 'git
>> bundle create --filter=blob:none '.
> 
> Nicely done.  There's a lot of refactoring here to move the
> filtering code into a more usable place and get rid of some
> of the awkward limitations of my original code.  Sorry that
> you had to slog thru all of that.
> 
>>
>> There are a couple things that I want to point out about this implementation
>> that could use some high-level feedback:
>>
>>   1. I moved the '--filter' parsing into setup_revisions() instead of adding
>>      another place to parse it. This works for 'git bundle' but it also
>>      allows it to be parsed successfully in commands such as 'git diff' which
>>      doesn't make sense. Options such as '--objects' are already being parsed
>>      there, and they don't make sense either, so I want some thoughts on
>>      this.
> 
> This feels like something that can wait for another task.
> Let's keep this series focused on adding partial bundles.

What do you mean "can wait"? Do you recommend that I _don't_ do this
refactor and instead implement filter parsing directly in bundles?

Or, are you saying that we should not worry about these potential
side-effects of allowing (then ignoring) certain options in other
commands, at least until a later series?
 
>>   2. If someone uses 'git clone partial.bdl partial' where 'partial.bdl' is a
>>      filtered bundle, then the clone will fail with a message such as
>>
>> fatal: missing blob object '9444604d515c0b162e37e59accd54a0bac50ed2e' fatal:
>> remote did not send all necessary objects
>>
>> This might be fine. We don't expect users to clone partial bundles or fetch
>> partial bundles into an unfiltered repo and these failures are expected. It
>> is possible that we could put in custom logic to fail faster by reading the
>> bundle header for a filter.
>>
>> Generally, the idea is to open this up as a potential way to bootstrap a
>> clone of a partial clone using a set of precomputed partial bundles.
> 
> I think this is to be expected.
> 
> Would it help to have Git do a no-checkout clone when cloning
> from a partial bundle?  Maybe that would give the user a chance to set
> a real remote (and maybe set the partial clone/fetch config settings)
> and then backfill their local clone??   (That might be functional, but
> not very user-friendly....)
> 
> Or should we just consider this limitation as a placeholder while we
> wait for the Bundle URI effort?

It would be interesting to have another application of partial
bundles, such as cloning directly from a bundle, then allowing
a remote to be configured. It provides a "build-it-yourself"
approach to bundle URIs for partial clones.

I'm not sure if such an application is required for this series,
or if it could be delayed until after. I'm open to suggestions.

Thanks,
-Stolee
