Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE79C433DB
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 01:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F127B23436
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 01:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbhANBnM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 20:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbhANB35 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 20:29:57 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25602C061575
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 17:19:58 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id u25so5680572lfc.2
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 17:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GncFW9uu2mZmi93gyP/e+og7QwhRQXYncJET/3dk0b0=;
        b=KcFs/F30dvJRe9OnehvdxAbZ3S8fcCPtmpm+xjZDDXbaxBYHwWLf0IVuQzDCHE8as8
         q81w1IjwQw9t3+r0EWYyEWF3aIWaDoS5eNHyRT121r6s9iqcfSQwG5o/p7umAQrVbpEL
         Xk/7i/5pqteznC91YHaIA/fXBtF0tIyOaOEC3d31ghSfspenuZ4F3Pg5cNAFVBqglKlo
         vkR2arR722dS3B8HVzJ+MNOBKT/uuwyNqTLYwhbX9wWGcn4KSUvcuRz0r3cjSgfwZ2A+
         7DoA2hmCRWvdeHIGTiPr9lK81UiIZLqlFd1lWszjvDybMs7itCOTk4ggExvC0n9zB+By
         AF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GncFW9uu2mZmi93gyP/e+og7QwhRQXYncJET/3dk0b0=;
        b=s08FL9M3fK8kOEntEJX5X+4tPX3PF4oPAFW3FN0sjxXq4FEziadK6ujfl1f5xjY8pp
         G6iNmC+FoLUkxg2THUEqLsUdAgH6JLMhBMuCPJDtIY0b+JW4Ft6Z6PUU31m95hzU+jp6
         xjucUSR0o1TI0+T2SRxAc9eMSROYqqFj77k8R5fvEDmwX2gHWAhoTJb+NdCBoDUhkCe8
         6+WeiaOazdvGPJYm225E8SreeLFKhWfb6/Z0WdPCrnpnuhUdUDPj1F35zi5RK0pBga88
         VP5AzmEF4dNB1YQkcOwdIOJlYUZbsrOTJa/a/0IgQE5Zxa8cNx8375q54Kt5ktdpxZxN
         xQVg==
X-Gm-Message-State: AOAM531P8kyVyh6hQI9aWZpnCD+z0Ew+JYvsTAs+gFO3O/HcS5IE6jNq
        XgVpYwQR8vm8TdlM8M91mrKNHB1/77mlWAaxJO8=
X-Google-Smtp-Source: ABdhPJxAc56ybRQ3V5GyDghL/6AjLF1mFTbFavqaY4UREAwqneMCn3Eq2wHav2Dj1fNyG0V3i3pDtBdRmsyk2IPXzLQ=
X-Received: by 2002:a19:48e:: with SMTP id 136mr2039035lfe.357.1610587196684;
 Wed, 13 Jan 2021 17:19:56 -0800 (PST)
MIME-Version: 1.0
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
 <96268351ac66371a0998d189db619f357d2b71fa.1610465493.git.gitgitgadget@gmail.com>
 <X/7+YU16XrPFDYlN@coredump.intra.peff.net>
In-Reply-To: <X/7+YU16XrPFDYlN@coredump.intra.peff.net>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Wed, 13 Jan 2021 17:19:45 -0800
Message-ID: <CAPx1GvcpmLJzSpO9J4u8t+ZZ+MdZuVuJ2gPHP5ei0xng3cV9oQ@mail.gmail.com>
Subject: Re: [PATCH 07/10] unix-socket: create gentle version of unix_stream_listen()
To:     Jeff King <peff@peff.net>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I had saved this to comment on, but Peff beat me to it :-)

On Wed, Jan 13, 2021 at 6:07 AM Jeff King <peff@peff.net> wrote:
> There might be a solution using link() to have an atomic winner, but it
> gets tricky around unlinking the old name out of the way.

You definitely should be able to do this atomically with link(), but
the cleanup is indeed messy, and there's already existing locking
code, so it's probably better to press that into service here.

Chris
