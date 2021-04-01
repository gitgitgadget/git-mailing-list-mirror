Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB05C43460
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 07:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD10A61002
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 07:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbhDAHWg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 03:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbhDAHWX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 03:22:23 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3CEC0613E6
        for <git@vger.kernel.org>; Thu,  1 Apr 2021 00:22:22 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id r12so1372523ejr.5
        for <git@vger.kernel.org>; Thu, 01 Apr 2021 00:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gaWVKEVO7+6XZZB3dJ8bZ8qHpSzaKE6KsOvhJhBK8jY=;
        b=aWisHPZLK4beJ1o4w936DzFDS0a2NySvHTz48iXXLtnuUVXfNTXZKxoZVuFd4QO/1Q
         bWC/IL+VNSQvWLgrjl1rzGn3B+1EOcOcnBnoL41PORwcrGWzRXaBkcfy4HN2T/e2r9ap
         QWRJ/oALxysVx2s5enzr/ZDXhVu4qIahrr0gh7lN4yKfk/U32Jxg9dXs4TqnOiXtnTqJ
         ioEdZTX3ci1f4N5ujAt7Vcs1KaTn/dveAiEcybARODLnd4zTK2yKzCIoYpugb+BxCL5g
         775RWodlbxfybx+/u/34bORAXAYp6rRJTExanXjjjLfZDEWLFlYw79/V2LIMbrX02Mtf
         0Txw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gaWVKEVO7+6XZZB3dJ8bZ8qHpSzaKE6KsOvhJhBK8jY=;
        b=b9Ojf3Q/UVtONlxlXw+i4OBRBjJ18BvELtrz5vNM3j/eVz4bxF+nkefKfg49NIa4XL
         h7XZHMaJz1wSxMiox7U/B33XLmHF1czF2yRU987GaP4z3gL+1++dbclqs6Ss4TACX0TO
         1pGbZ9NLuLGmXTNbvaRwydYKxaM7BHeriAO79XKu+Ncwy4zDrD1iEPfZpIiq6VG6lsUu
         2sfpXN3uVAj6BYnr2Lpkw9mzuBEOv8B+v2CX6QniNxQONFg4FopjQ88Rl7s5igCAAIZm
         F/XPHseFUisZ7SKwfYC7qkXzC//p3dhw2UaF6HHdTdOQke+6PdKHV47BSx4G3GiX8Bip
         TEZQ==
X-Gm-Message-State: AOAM531r6FjzOoujmzQ0JXHdyDEFqb5zPxiWM1zAY7+lPiQo3vceDWz6
        cRmKaDj6YJTiHgQA9BQ66zzRxaG+CdR4bVP3wo8=
X-Google-Smtp-Source: ABdhPJwHE9CHPgd79f5A2VZV+xQXjWoeQkdZV/DUHNROIQ9chxpkXxaO5a2bP+eNwuQ4Ffwxh1jIj84y6/QItaW8SWA=
X-Received: by 2002:a17:907:68a:: with SMTP id wn10mr7839957ejb.551.1617261741535;
 Thu, 01 Apr 2021 00:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <pull.913.v4.git.1616775185562.gitgitgadget@gmail.com>
 <pull.913.v5.git.1617185147.gitgitgadget@gmail.com> <4c59cab53a0d9bb7c9cccfaf5544ae5c904bb2ba.1617185147.git.gitgitgadget@gmail.com>
In-Reply-To: <4c59cab53a0d9bb7c9cccfaf5544ae5c904bb2ba.1617185147.git.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 1 Apr 2021 09:22:10 +0200
Message-ID: <CAP8UFD2tb6Fca58YPiFejqGKm3Mu+NaMA8YU3HQj+c2L-AH-Yw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] [GSOC] run-command: add shell_no_implicit_args option
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 31, 2021 at 12:05 PM ZheNing Hu via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: ZheNing Hu <adlternative@gmail.com>
>
> When we use subprocess to run a shell-script, if we have any

Maybe: s/subprocess/a subprocess/

> args, git will add extra $@ to the end of the shell-script,
> This can pass positional parameters correctly, But if we just
> want to use some of these passed parameters, git will still
> add an extra "$@", which contains all positional parameters we
> passed. This does not meet our expectations.

I am not sure explaining things using $@ is the best way to make this
as clear as possible. I don't have a clear alternative right now
though.

> E.g. our shell-script is:
> "echo \"\$1\""
> and pass $1 "abc",

Maybe: s/pass $1 "abc"/we pass "abc" as $1/

> git will change our script to:
> "echo \"\$1\" \"$@\""

Where will "abc" appear then?

> The positional parameters we entered will be printed
> repeatedly.

If you take us passing "abc" in $1 as an example, then I think it's a
good idea to show us the result of that.

> So let add a new `shell_no_implicit_args`

Maybe: s/`shell_no_implicit_args`/`shell_no_implicit_args` flag/

> to `struct child_process`, which can suppress the
> joining of $@ if `shell_no_implicit_args` is set to 1,
> this will allow us to use only few of positional args
> in multi-parameter shell script, instead of using all
> of them.

I think our goal is more to have each argument we pass be passed just once.
