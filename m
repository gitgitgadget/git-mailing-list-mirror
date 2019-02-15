Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 695C91F453
	for <e@80x24.org>; Fri, 15 Feb 2019 06:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731712AbfBOGI7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Feb 2019 01:08:59 -0500
Received: from mail-lf1-f50.google.com ([209.85.167.50]:46637 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfBOGI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Feb 2019 01:08:59 -0500
Received: by mail-lf1-f50.google.com with SMTP id f5so6300168lfc.13
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 22:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fr4Qpf3vWED5MhhDBycNFcqOy9Atf4Nz8e8jpxr1dEs=;
        b=UEofHcQt2t48vu39rqkNAe9Fpw/N/24T+20+hPgsUg7FUXDn1GDT2qFxp738MVNGdt
         KfuSIFemUrUO5tbtdxB96l+jWMXokhMtS3ttt2laDXAOO0j4TNmFh+M5R6DVxp6Q/v/F
         FoIJNx3eJiJXOGfJE8NHbrsVeeKuPaZnLfyQeFIFdqEHT69i3E34D9qcUr2s+aVfDcFU
         pevDxeVhyZGp4bWZRNVe7Lyt0xBJPUkjtbOsgF4w+1e4I+L/F+F4EFG8qfeBY6rqUliK
         CQkj9M6aMASFBJ8Tg//BVJ2E+mioO+4N8zIYMCQAzjKV9lNnPhTPqicP7Kjd9LmBI5ba
         S5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fr4Qpf3vWED5MhhDBycNFcqOy9Atf4Nz8e8jpxr1dEs=;
        b=HFVfjNxcI5OE++M2R3/Y1UvaH9ASSOTaFxPD5Yl8gIOJ8OIFHGqTziBOui8TJdU2GN
         IkqIDn8oZDALWJOCwD2xkj/PMc/sfIr2oFe0bNll5E4waaWak+iWOqOaRjAmPFR4lerm
         D3XqxIBbHaZeCistc/yu2xRCtaB49aV86XGwTWjTrdfw7/85R+cmaSob5ZnvRGf2Jkuw
         IYWtszFy8gGJYg5JECtJW71zigsR7ZSd8YGXMpEqn1wh2VBMLU+07CorAbMGHd02N8tw
         UHGGr3C3uXSSBKlRvhJgrPffWXAezTD4E/wDz1GWIcigA1jAEBp5R9nvYbXUAo/w9VTI
         p2vg==
X-Gm-Message-State: AHQUAuZM2qaNJqzJk86OXiN2Lybxg2CHLVAYtGZhse69BW7j+b3mMVxV
        SpQ6YSm7sObYkaudn5WNvppKpfVaZ2gGl2AL29Q=
X-Google-Smtp-Source: AHgI3IbAvcQVzXyUffNfBap/X579Bqw1npKHuE5jusFhzofQe+CnsjIYlFRCEUI8fMPx83G3Okvcg793URxs0h2Zo2k=
X-Received: by 2002:a19:7613:: with SMTP id c19mr1211579lff.103.1550210937511;
 Thu, 14 Feb 2019 22:08:57 -0800 (PST)
MIME-Version: 1.0
References: <000801d4c174$05b76860$11263920$@nexbridge.com>
 <CACsJy8Bn+2zY6y_QqCjbB3qWM-F=3d0H5vgWj4az=md2FZ8RhA@mail.gmail.com>
 <xmqqftsughks.fsf@gitster-ct.c.googlers.com> <20190212002705.GD13301@sigill.intra.peff.net>
 <xmqqef8a86sr.fsf_-_@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqef8a86sr.fsf_-_@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 15 Feb 2019 07:08:45 +0100
Message-ID: <CAN0heSooOiJkkfr=sKn+dkMmU9knabeTnY90EJyEu2fNT8XMzw@mail.gmail.com>
Subject: Re: Re* [Breakage] 2.20.0-rc0 t1404: test_i18ngrep reports 1 instead
 of 0 on NonStop in one case
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 15 Feb 2019 at 03:13, Junio C Hamano <gitster@pobox.com> wrote:
>
> Subject: [PATCH] t1404: do not rely on the exact phrasing of strerror()
>
> Not even in C locale, it is wrong to expect that the exact phrasing
> "File exists" is used to show EEXIST.

s/Not even/Even/? Or s/wrong to expect that/portable to rely on/, or
something?


Martin
