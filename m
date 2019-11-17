Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA6761F4B5
	for <e@80x24.org>; Sun, 17 Nov 2019 11:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbfKQLeO (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Nov 2019 06:34:14 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40384 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfKQLeO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Nov 2019 06:34:14 -0500
Received: by mail-ed1-f67.google.com with SMTP id p59so11187480edp.7
        for <git@vger.kernel.org>; Sun, 17 Nov 2019 03:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=inGFwM4PD6G7ThpR3Dyb6BjBb6HF01uJAd8EQOk42TI=;
        b=Jk2I5MFTgmsOGM63o/hDVkXRQA1BRx9oVJIkPxpIT2Hd9b6TTcMs2sj+Ls/QtXgset
         +3ciWg5bQkiK/WfpHjUHp/8piMDcQw5N2R/J56khiRCui+zhkhFr9RzqykYScBuAcMQz
         IMdk1g5WwwzkCwnRK09ceLgTLzSz5/XPRFeiJ3rlAPbyWDdSqIgWf9hKmrt62Xt68iT8
         iHwudSJqPwrKTg7J2+WiS9JgBsK/igAfqW7rIlcuksSt731z9wPzUN/E73AhNU8Llcld
         cizb4/UYCeWURm8oEOfucZT1lzl/whcT3t3J5gatOzeBEpC7ThqIvo0xaqTkOpnOuP5/
         dUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=inGFwM4PD6G7ThpR3Dyb6BjBb6HF01uJAd8EQOk42TI=;
        b=tpDm81aTQEMrKg8S53HvqoHm8mCL78Ut0pU2yIUrDHKZkkfX40CRdZxcMY0FohZka1
         lYwdFDpsFeRQBJT0Ol0d6M1qxWxtH4ZTXyW3Rm5HndfKsNkQxVbRypGw/CKSfdmgJUsj
         ZYnyn/N2jvWKULq+LpEl8xyTOhzdoTKpCUn/mCPyUQKxigJ3RFC21d8LWrCRVaN1j7h1
         wkivLBlBrnB3KrUOtRuuOLRAR4XoGuofqKUqBZLea0cj0Wc00iYbldqvu8WuJY0u7sXO
         G/iqqzW68Ck9+QE5C+jb8lVhUw9oSh0ksccVOEsCJztvEGAcdpx3XlgqSmNOZUX1mE8D
         AF5A==
X-Gm-Message-State: APjAAAWn2uZlPoaxf1PE6VSeHFxXFoiL7f9PUpq2roGvIM8KexOQzZqh
        +qBfWyFhOAnETIh9mHtP9Ybak0G7BRdA8QiN9gw=
X-Google-Smtp-Source: APXvYqxxxSURZADEKrq8ahQl/LlaZwlhTthdoRiMXQ2r9uyLy9FySDko7YFLuHlio2wgHIYQcjSd0t4d6fdFuyxsKU0=
X-Received: by 2002:a17:906:6dcf:: with SMTP id j15mr17613323ejt.104.1573990452712;
 Sun, 17 Nov 2019 03:34:12 -0800 (PST)
MIME-Version: 1.0
References: <pull.434.git.1572343246.gitgitgadget@gmail.com>
 <pull.434.v2.git.1573034387.gitgitgadget@gmail.com> <3d1e7e72efca06d18606b6f9dd8c3b6771dfde06.1573034387.git.gitgitgadget@gmail.com>
 <xmqqh83bi10h.fsf@gitster-ct.c.googlers.com> <CACg5j27=t_tC4AqNz6tSdsgbDKECq1p+OwS=ydak7d94q2PHZg@mail.gmail.com>
 <xmqqblthfxho.fsf@gitster-ct.c.googlers.com> <CACg5j25ZO3+=EHYm5-Yp_LKEQA00EH=FAhOeP_TqHw8anCUDEg@mail.gmail.com>
 <xmqqv9rl5q0w.fsf@gitster-ct.c.googlers.com> <20191115232805.GF22855@google.com>
In-Reply-To: <20191115232805.GF22855@google.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Mon, 18 Nov 2019 00:34:01 +1300
Message-ID: <CACg5j25C2ki_HjWvW7-yZtfmkohii1sx7BZTsV35+HH1otL6Hg@mail.gmail.com>
Subject: Re: [PATCH v2 15/20] parse-options: move doc to parse-options.h
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 16, 2019 at 12:28 PM Emily Shaffer <emilyshaffer@google.com> wrote:
>
> For now, maybe it's enough to add a link to api-parse-options.txt at the
> top of parse-options.h. Part of me wants to say maybe we should
> duplicate the per-function briefs into the header too, but then we have
> two sources, and a single one is easier to keep fresh.
>

Cool, I'll update this patch to keep the doc file and link to it in the header.

>  - Emily

Thanks,

Heba
