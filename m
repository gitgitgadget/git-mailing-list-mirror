Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 829761F404
	for <e@80x24.org>; Tue, 27 Mar 2018 14:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751994AbeC0Ohj (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 10:37:39 -0400
Received: from mail-ot0-f170.google.com ([74.125.82.170]:43258 "EHLO
        mail-ot0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750944AbeC0Ohi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 10:37:38 -0400
Received: by mail-ot0-f170.google.com with SMTP id m22-v6so24733312otf.10
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 07:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IPAl+A18nGv8/T0ZUQM5I+9Qz7/uP1UElZK3xirgkrc=;
        b=IsH7n17QZIc3qr4X/vuEcTLIqhmcE/JZKxhSmZ4W5YkCZu9aMebGK8BXmXNdZoZ57X
         hlOLe13LNjyslsw+7JgBOQWZGYiIlC6a3N9sGNO2wqZRqk1nl+MXHvOVUxX5bFE+KUZ3
         S8aAGuCvXz9nANyFyPsVOv5bcEUOx1kIZtGfhSaqyPs9D0wUlWOBpWWmGRTj/jCJ3j1x
         jx97FMQ5FcEDdOye6obhjm4GMErGh++7XNBsDmCHu8+YV+0TXpiYVMmpv5GDzHqCyoES
         Xf4SsSoCjyfVZQvI11XF0znwEz9dnI3WI0xvTXM9Ayr6e5siqgu97TdK0WxXddEFYzf6
         rY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IPAl+A18nGv8/T0ZUQM5I+9Qz7/uP1UElZK3xirgkrc=;
        b=pK8gdfIAsDRFlbZw3VRfekQlXW7Q36yZLplF7x6fows6MNyniWHyvlSUYi6geqol+y
         2BZbNvXJ5YxwJXffRI1//kfxByY6iQ32kDafaG99DKtrOyG4GdMPSvyx5QFaGMtd8VHu
         bqbOaTVVPGaaTXkWa6LyHU078SQr4KzBVHLCQrL4Z2HbmAnSS/HjCnrZoSpCfXeWYIP7
         jjBOMU2UqdtQIf8uU+xyHXxJAi/HIc+SINGMh1gHSzTrR0wKalNc1M8ynaTvP5kBaQvW
         M+pMcucYQMfNj7Vn1FleWFwEVCiA+NT2HYmVHgHNj885ItIHTZ4t5KwViYjm1REfwfwh
         MHNA==
X-Gm-Message-State: AElRT7EYkydmyS+ay5sWzawapHPUske6BebVk2eaYBOF5U6uFoBFJ2Gn
        oqMW/g61BUmrDsGiiaTDMwZYNKB/WxGRpb9eB2NxwJqo
X-Google-Smtp-Source: AIpwx49FfGpiuGVq3NqPbwVWqdLoSthy7aOsD35L9Du3PNUVBNU/IIr9lFhNYIgKzbZje2a+zo84rg9PFVcGu2RtGTw=
X-Received: by 2002:a9d:6244:: with SMTP id i4-v6mr3397177otk.140.1522161457372;
 Tue, 27 Mar 2018 07:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180325205120.17730-1-dnj@google.com> <nycvar.QRO.7.76.6.1803262331040.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
In-Reply-To: <nycvar.QRO.7.76.6.1803262331040.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Daniel Jacques <dnj@google.com>
Date:   Tue, 27 Mar 2018 14:37:26 +0000
Message-ID: <CAD1RUU8jNudjCXN=-mucogmSFj2xqyYqyk-dfADhjceLsmBE2g@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add Windows support to the new RUNTIME_PREFIX design
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 26, 2018 at 5:31 PM Johannes Schindelin <
johannes.schindelin@gmx.de> wrote:

> Even if the RUNTIME_PREFIX feature originates from Git for Windows, the
> current patch series is different enough in its design that it leaves the
> Windows-specific RUNTIME_PREFIX handling in place: On Windows, we still
> have to override argv[0] with the absolute path of the current `git`
> executable.

> Let's just port the Windows-specific code over to the new design and get
> rid of that argv[0] overwriting.

> This also partially addresses a very obscure problem reported on the Git
> for Windows bug tracker, where misspelling a builtin command using a
> creative mIxEd-CaSe version could lead to an infinite ping-pong between
> git.exe and Git for Windows' "Git wrapper" (that we use in place of
> copies when on a file system without hard-links, most notably FAT).

> Dan, I would be delighted if you could adopt these patches into your patch
> series.

Great, I'm glad this patch set could be useful to you! I'm happy to apply
this to the patch series. They applied cleanly, so I'll push a new version
after Travis validates the candidate.

I don't have a Windows testing facility available, so I'm hoping that you
verified that this works locally. I suppose that's what the unstable branch
series is for.
