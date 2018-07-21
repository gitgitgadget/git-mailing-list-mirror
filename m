Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CA531F597
	for <e@80x24.org>; Sat, 21 Jul 2018 07:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbeGUIBA (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 04:01:00 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:37603 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbeGUIA7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 04:00:59 -0400
Received: by mail-io0-f195.google.com with SMTP id z19-v6so11664279ioh.4
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 00:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N6jCkAzgNs2khZBps9k+9ScZVi60USqdFJm0T2RxxGk=;
        b=VsM8VdTxw28z4Q9cfiAp6F/kXE3EKcvuKLQulliyzb4BfddeRG/jJrIwLAHlLBkx7Y
         A0WFEx4zPiOcVqaLcrg3ICG/tvkVMVby5rR7HBiHHRlSeAq3CURWL+8ETifIokt3oWDI
         xkfiHLfIZcLsqgHyJJsqxmkhor39NJz+5ow9NzJ1w5T/wSmS2LxQrhU9y2viHm9gATrT
         4IMzWuE+i9H7QMewd4sHapOjSkFw5p8VfBCNxpM0b24KGgRn9zxra00quzrm6yvw+n91
         9dxLA6XksUN/gxVXNMRb4wgOk7QUi7ViB3v8LkqCcNrh70WDWteDlFFi2wtakM81p9x1
         Mkzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N6jCkAzgNs2khZBps9k+9ScZVi60USqdFJm0T2RxxGk=;
        b=NtIcsbVpwoJjCtG8awleqczoES5OO6BmxHQvdRCLnCt1++pT2kCniIfKvVvhejJn3P
         S9P9encf6KBdZyISbZFXUx/kspeQA1RSj2AIJvWbUxq5UxXWkMJulbXR5ikuKhFyL7Q3
         UHrUElT424oa5KYTUtsLAoLqsfsqzNurmdb6eCLJeTKYW66YNvB+tmI4diPzjQRv3IsH
         2w27HQISOcSqyOkkkbgP36GSmrkch/pohkWur6/6LarzBJSgxYvLwIBZR6SfLI60GTwD
         9clIKdbVjM+jmZ3gg8f5h/uj52vLt/zDDQ5p5KKyHaoVlUVmHLKqXE1mGokkJgsV8yM8
         OtJA==
X-Gm-Message-State: AOUpUlEDag4M203sqUNU9zm168TKtzyfw7OhhFDToE8bDMtlNSB8w5Es
        ejYNMozMZBcxhI1KSKwQYJ9rnvSS83wYRXCLUADzU3Li
X-Google-Smtp-Source: AAOMgpe3O6lcZXmH+sWFBy9ccMUk0c8OdN73DRgY47xpjFmyCUux0tdQCTQ9cm5E5Agr3fMjfHWdD61vT44OjQiEY90=
X-Received: by 2002:a6b:a2cf:: with SMTP id l198-v6mr3562079ioe.282.1532156958885;
 Sat, 21 Jul 2018 00:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180718225110.17639-1-newren@gmail.com> <20180720153943.575-1-pclouds@gmail.com>
 <CABPp-BGJAWXOCPsej=fWWDJkh-7BAV9m8yEDiy2NVkGTRCmk4A@mail.gmail.com>
 <CABPp-BF5O2-DQMSjN67HYsHHYHP_VH-N-C=k796NwPTvtwf7gQ@mail.gmail.com> <CACsJy8Ck7U3m8khFdiKDzYWKk1ZcKyi32RkQ=a=oFQYHd5bruQ@mail.gmail.com>
In-Reply-To: <CACsJy8Ck7U3m8khFdiKDzYWKk1ZcKyi32RkQ=a=oFQYHd5bruQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 21 Jul 2018 09:08:52 +0200
Message-ID: <CACsJy8C1+zVZTh4MZqezYfNzus8Aa2oBiyMn25Oph6cYg00+yg@mail.gmail.com>
Subject: Re: [PATCH] pack-objects: fix performance issues on packing large deltas
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 21, 2018 at 6:07 AM Duy Nguyen <pclouds@gmail.com> wrote:
> > However, I'm just concentrating on a beefy machine; it may be that v6
> > drastically outperforms v2 on weaker hardware?  Can others measure a
> > lower memory usage for v6 than v2?
>
> I'll try it with massif on linux.git, but this is a very weak laptop
> (4GB) so  it'll take a while....

OK massif reports are too big to upload so I only pastebin'd the peak
memory snapshot. fix-v2 uses 1.449 MB [1] (M = 1000) while my patch
uses 1.394 MB heap. The actual saving if we focus on packlist_alloc()
is 599,147,916B - 544,691,628B = roughly 50 MB or 8%.

It's not _that_ big saving, so if your test runs do not show
significant speedups, then fix-v2 is probably a better option.

[1] https://pastebin.com/8iDcm9M4
[2] https://pastebin.com/bXBjzPvN
-- 
Duy
