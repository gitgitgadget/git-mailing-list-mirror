Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22341C3404D
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 09:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14ED2464E
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 09:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ooD3pe9Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgBSJ7l (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 04:59:41 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43074 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgBSJ7l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 04:59:41 -0500
Received: by mail-ed1-f66.google.com with SMTP id dc19so28398454edb.10
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 01:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yimm2BhEbK9MhQCstY+HBIfm2nZ371bM8xbAkykJZz4=;
        b=ooD3pe9QkTosSrdX4bGLCk/h99PTItiqbBqvGBoK4m9Hd867V7tgMHGgG101+CmN/0
         n0qV8TFpzKF3hg+aeKnkTlEHvlgaa9bF6YYcz1ZFA1dC11jN8XTlqxfUhYyM2vmFVYw7
         0+CF+4/3+UxkJFRarFdWZXXl5CqVm+zD+neUp4yM6+T2Oo+FFdOh5SXodfMhxXOIPIUA
         zVT/Ypvaj/aLUoiO3YbpNCRIXksp6mExSNgJYQyDObkU1Xw931tNOXgtqbG5CmoL99ss
         Xd9Fapik0EiKMATjI37hFHS2Y9p9knkDNY+XchivRNLf+MujVLbfNTyXNdufyBWLx4wv
         uZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yimm2BhEbK9MhQCstY+HBIfm2nZ371bM8xbAkykJZz4=;
        b=LQmL7hDxifM7C9Th41OY/DFIXITAjqpw3HKN4vj4N3wta724wuKVdFv09qWiPnZPpw
         DaKf1o3WiAAeLUI3WkEKA6qy7MHPWSkkh/p/j2O+VJQEhiTk347MA4JzcI5Wo58kYGEg
         a11BXOK2U29ipMix3nZlAWj1gopFtFyhKVMLPJQd5WVnt+EvwJNS3G7xKZQ/v+buB2AH
         1JbvqFFh2tTo3Ki6ZnfZhMWfhUlryg53imqKiRy7JozQUfs8Vj3W2SBRv2hda8vE/k6W
         5csGPt40Zi1Z6QK4pLAswPOu7BiyVXnA3mo8u328qbkI80aPq19eQJGU7Dj4M2KthiRm
         65ag==
X-Gm-Message-State: APjAAAWzQ42Lvs2fbOe/Em0x7oWnoKrb/fMQPFTSPs95KD5KQsiC2whc
        B1JgtGfX1aPrww6KsDc4qfdy1XT3ul0aGQl6YAo=
X-Google-Smtp-Source: APXvYqxOnop6xJvxlYJxUc36GFlytZwOtfCNPYyCLEogVnf76UHNYyIqq2/LW6dOvPraU0H8g+CaGWwxHiUmpYZMZUE=
X-Received: by 2002:a17:906:7c5a:: with SMTP id g26mr22667250ejp.249.1582106379414;
 Wed, 19 Feb 2020 01:59:39 -0800 (PST)
MIME-Version: 1.0
References: <pull.548.git.1581311049547.gitgitgadget@gmail.com>
 <pull.548.v2.git.1581889150.gitgitgadget@gmail.com> <080d12b5c696d61ac1052d5863f7260a4005346e.1581889150.git.gitgitgadget@gmail.com>
In-Reply-To: <080d12b5c696d61ac1052d5863f7260a4005346e.1581889150.git.gitgitgadget@gmail.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Wed, 19 Feb 2020 22:59:28 +1300
Message-ID: <CACg5j25yoXi_aAwd0uf7ZgiCPE23Ej89bSnPiz1vxrhWNmkK3g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] advice: refactor advise API
To:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 17, 2020 at 10:39 AM Heba Waly via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> +int advice_enabled(enum advice_type type)
> +{
> +       int value = 1;
> +       char *key = xstrfmt("%s.%s", "advice", advice_config_keys[type]);
> +       git_config_get_bool(key, &value);
> +       return value;
> +}
> +
> +int advice_push_update_rejected_enabled(void)
> +{
> +       return advice_enabled(PUSH_UPDATE_REJECTED) ||
> +              advice_enabled(PUSH_UPDATE_REJECTED_ALIAS);
> +
> +}

I just realized that the return value in this function should be &&
instead of ||
(if any of the config variables is 0, then the advice should be
disabled), will fix that in the next round.

I'll probably remove this function and add a switch case to
advice_enabled() to handle this case as well as another one that I
came across while migrating the rest of the calls to the new helpers.
Will post an updated version soon.

> --
> gitgitgadget
>
