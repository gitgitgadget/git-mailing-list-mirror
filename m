Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85B171F453
	for <e@80x24.org>; Thu, 25 Oct 2018 09:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbeJYRsV (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 13:48:21 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40813 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbeJYRsV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 13:48:21 -0400
Received: by mail-wm1-f66.google.com with SMTP id b203-v6so726613wme.5
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 02:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=emBZnYonONU9rs9OA18HXTrUyWL0mNGHSGp+G8PxG0c=;
        b=Ijk+C5f2WTplFc/mOWImf0zLYdiUNhCiDEsXAt+E0UssMCMCsv8fYI6fgYSx1Nl2pp
         uRwngRCvFGyBSfJMFEpfXt88VmYTT3bwMTKEqW65C0wdPsP+KpvJj5Aih/6Xe9HoYzMc
         L3bK6nzQVBPIi369XPywINr96ISjSCELAjFHCNihSeH7DvBSNeJSH9if9fU2zPCEfpTX
         zlO3HYAoRy16AqUYPvkAT4rJ4XBbO9BhZgmwQAOy5gxzUAQRmYeNLPNT+ggUN2LDLJbS
         1deIHe1WCCEmFaAG4GwmmJCRQupegUZksRGDDtg2d+6XHg6P/FqjZ0mYw/HXPjKJV06D
         dqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=emBZnYonONU9rs9OA18HXTrUyWL0mNGHSGp+G8PxG0c=;
        b=deVABXEs+SxR64d50CjQSOFDHJa1MQdqla3O/2H2NxMYU7coUZF5FzAmT/WzKXYAOn
         DtR9pgwN6Bb7vuZPsiW8yePFvs15b+ARXHiCTEaARyiBAa2LgsNydPP5GeLz2Wr2ZlIw
         +JVqtPWBL/qUdf2psPpeFOJv87Ag4U1GxycVGfPJIsrK5Wd7K9RGLHV9MTZXZZX9XyA7
         NR/vcADeVFFb/h94tMRccmboiHMJPVTuZOF12Z1/ZzO0fsEtXXCTg1JHHf6Yr7vFK23m
         7nbzclqJgIizGEUD6Ubd+jVkPLjPdJhsPuiBHznY0TQI34roAiBCb9xEaWTcBNvV9Tuo
         oD4w==
X-Gm-Message-State: AGRZ1gLLuZf6MbgXaxE9Z6K/jaDLtuWfpwmk8rSCTDfBd+GtcERAMnTK
        u0oB3JpfUUzQxjw8+El/asA=
X-Google-Smtp-Source: AJdET5dkEa/czjBCuHUyTt4GCH8UCbVmH/b9dTU9smIemrmIvGcmTJ5OH1BOZV0fIUWJ+LTD957/Fg==
X-Received: by 2002:a1c:adce:: with SMTP id w197-v6mr1036946wme.11.1540458987428;
        Thu, 25 Oct 2018 02:16:27 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x197-v6sm1055609wme.15.2018.10.25.02.16.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 02:16:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v4 2/2] worktree: add per-worktree config files
References: <20181002160658.15891-1-pclouds@gmail.com>
        <20181021140228.24941-1-pclouds@gmail.com>
        <20181021140228.24941-3-pclouds@gmail.com>
        <xmqqefciwphv.fsf@gitster-ct.c.googlers.com>
        <CACsJy8BYJKKdnbNYBR-XNeSE9jpWqby+epMKWo9-wGRjVE8Lfg@mail.gmail.com>
Date:   Thu, 25 Oct 2018 18:16:25 +0900
In-Reply-To: <CACsJy8BYJKKdnbNYBR-XNeSE9jpWqby+epMKWo9-wGRjVE8Lfg@mail.gmail.com>
        (Duy Nguyen's message of "Mon, 22 Oct 2018 16:32:37 +0200")
Message-ID: <xmqqftwugzdi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> > +extensions.worktreeConfig::
>> > +     If set, by default "git config" reads from both "config" and
>> > +     "config.worktree" file from GIT_DIR in that order. In
>> > +     multiple working directory mode, "config" file is shared while
>> > +     "config.worktree" is per-working directory (i.e., it's in
>> > +     GIT_COMMON_DIR/worktrees/<id>/config.worktree)
>> > +
>>
>> This obviously conflicts with your 59-patch series, but more
>> importantly
>>
>>  - I notice that this is the only description of extensions.* key in
>>    the configuration files.  Don't we have any other extension
>>    defined, and if so shouldn't we be describing them already (not
>>    as a part of this series, obviously)?
>
> Right. We have two extensions already but it's described in
> technical/repository-format.txt. I'll move this extension there
> because it's written "This document will serve as the master list for
> extensions." in that document.
>
>>  - If we are going to describe other extensions.* keys, do we want
>>    extensions-config.txt file to split this (and others) out and
>>    later rename it to config/extensions.txt?  Or do we want to
>>    collect related things together by logically not by name and have
>>    this extension described in config/worktree.txt instead, perhaps
>>    separate from other extensions.* keys?
>
> I think we would go with config/extensions.txt because if grouping
> logically, I'm not sure where extensions.preciousObjects and
> extensions.partialClone would go.

OK, that sounds sensible.

Other than that, I am getting the feeling that everybody agrees that
the problem this topic addresses is worth addressing, and the design
and the implementation of the solution presented here is sensible.

If so, let's move it forward to 'next' and plan to merge it down to
'master'.  The "extensions.*" description can happen incrementally,.
I'd think.

