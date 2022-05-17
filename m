Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08FAC433FE
	for <git@archiver.kernel.org>; Tue, 17 May 2022 13:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347213AbiEQNKa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 May 2022 09:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234407AbiEQNK2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 May 2022 09:10:28 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5589F3526B
        for <git@vger.kernel.org>; Tue, 17 May 2022 06:10:27 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id j6so14461180qkp.9
        for <git@vger.kernel.org>; Tue, 17 May 2022 06:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=FsXg5iOMlyDmAKw8/id/7+BSZb/uSjPHpCAzyRaMMic=;
        b=C9Ws6iulba3PAMyG0RkziLV4ZP7vkwKq8zHsenmNxOZcOVbAxP4VdkEs9+2CYYxD2+
         vZMeUwYi2YiOC7dykTdEWE3p0LSp+ViKk8U1fRca5lSbPfj85k62+D5BuV1/gC9M9wm+
         YucGH47KTwSRUCrez/sw4wpSgLdRV7f1YYjSGRHYzxgsxMZUGwANGv93KgEIiCPxr5Gc
         2Fu4QmQCZGAwqtlIhrlAw9/MMptkaFjk9X5plVNLNAGyfjzNL/T/cVfQlVCndnw2uNpE
         Q9R40z/0NapOl2+LEj3aPApkOSys/nilR4qjK+ucYYZ/F/ip0O98TpDNzrOe43iCotKl
         2KRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FsXg5iOMlyDmAKw8/id/7+BSZb/uSjPHpCAzyRaMMic=;
        b=mifbldRQMQ2e2aMMqz9dEkGBxT8SUmaCXnVpxDjq3RPsn+5Ju5AJYYC9Un7rdMMzWS
         FRdQMv62YRlBUcIXlL8ukFPQgnhS2LJxPIdGSzKvfNINdWUSRBKeUYA4cnbPzF128hKY
         GYokQpAZzxZcuw1as18HVrMepZUHz7X9TXk5xqILaGwyb8jwoJO5mJ5zxB2UYijOucsv
         1CYhCujR9j8pGQ8I7E6xgqdNxfKg/mgsyBAsXKf2aMETNmGE4PhK3Gkc63lecknYSu1Z
         npdjMaLrYsgPNt/ErM+/wtPQbQriLAIF6VstBo/H3HW2gPRM0CE8rRP0eoaJOH/KlxE+
         PgAA==
X-Gm-Message-State: AOAM531RJedyGnaA59iKYi9IrrfsnM/fxK0sUgQIrn697HHVMctdHXNa
        l51XXgenSJOn8DLjHA229DwA
X-Google-Smtp-Source: ABdhPJwbl4g8laBYJeqxhxHop6HZAqV7j6wOI1FMM68bxwpGZ8cK76Bhbl8TFc2awxayGdPxxDNpEg==
X-Received: by 2002:a05:620a:404d:b0:6a0:54c9:1e3f with SMTP id i13-20020a05620a404d00b006a054c91e3fmr16041681qko.726.1652793026394;
        Tue, 17 May 2022 06:10:26 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:d51:acba:6df0:5bea? ([2600:1700:e72:80a0:d51:acba:6df0:5bea])
        by smtp.gmail.com with ESMTPSA id w10-20020a37620a000000b0069fc13ce1f7sm7582530qkb.40.2022.05.17.06.10.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 06:10:25 -0700 (PDT)
Message-ID: <789a0510-63b3-b297-ff35-de752d4f64d6@github.com>
Date:   Tue, 17 May 2022 09:10:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: What's cooking in git.git (May 2022, #05; Mon, 16)
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>
References: <xmqq5ym4zpmn.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqq5ym4zpmn.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/17/2022 1:37 AM, Junio C Hamano wrote:

> * tb/midx-race-in-pack-objects (2022-05-13) 2 commits
>  - builtin/pack-objects.c: ensure pack validity from MIDX bitmap objects
>  - pack-bitmap: check preferred pack validity when opening MIDX bitmap
> 
>  The multi-pack-index code did not protect the packfile it is going
>  to depend on from getting removed while in use, which has been
>  corrected.
> 
>  Will merge to 'next'?
>  source: <cover.1652458395.git.me@ttaylorr.com>

Looking at the conversation here, I would change this to
"expecting a re-roll".
> * ab/valgrind-fixes (2022-05-12) 4 commits
>   (merged to 'next' on 2022-05-16 at 75d760528f)
>  + commit-graph.c: don't assume that stat() succeeds
>  + object-file: fix a unpack_loose_header() regression in 3b6a8db3b03
>  + log test: skip a failing mkstemp() test under valgrind
>  + tests: using custom GIT_EXEC_PATH breaks --valgrind tests
>  (this branch is used by ds/object-file-unpack-loose-header-fix.)
> 
>  A bit of test framework fixes with a few fixes to issues found by
>  valgrind.
> 
>  Will merge to 'master'.
>  source: <20220512223218.237544-1-gitster@pobox.com>
...
> * ds/object-file-unpack-loose-header-fix (2022-05-16) 1 commit
>  - object-file: convert 'switch' back to 'if'
>  (this branch uses ab/valgrind-fixes.)
> 
>  Coding style fix.
> 
>  Will merge to 'next'?
>  source: <377be0e9-8a0f-4a86-0a66-3b08c0284dae@github.com>

With ab/valgrind-fixes in 'next', I think this is an easy one
to merge. I'm calling it out here since the patch was hidden
in the review of ab/valgrind-fixes.

Thanks,
-Stolee
