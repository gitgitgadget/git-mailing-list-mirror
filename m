Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC8C01F461
	for <e@80x24.org>; Tue, 14 May 2019 14:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfENOsY (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 10:48:24 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:36319 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbfENOsU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 10:48:20 -0400
Received: by mail-ot1-f52.google.com with SMTP id c3so15472439otr.3
        for <git@vger.kernel.org>; Tue, 14 May 2019 07:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Wdf0pLRXOZPMWfo4yBwksSFRBw0+nuUbfu0d68iWmo=;
        b=UNGC8H1gubKRqzaDVxrBmuFWcV7zxGgAtn0p1APCpxUNl7CHemloQo5U/Dtn4NE8Eb
         Zx4GlGb+HpfGkOC/ZI7agPhtIY0USDzSiizhx0WoYvh6jE8N+Gr0Z0ode/luxJHWXwIF
         /HGN8UI7bQ5nYCI3GDOtXmVTRz1EU6Wb+7dKEwKrOwS78KlCyDQVKo2K1uyf0mZexjXF
         2e6DQeauuZyGv7M91/acpFzAbaqYHq8YdTcTueh/SwyZ3GVxkERL+Sd3u7D0EKd20vII
         xl5J1j2Nw5R1W3V/A7x9dbNWGxLnULqMbquatBwJTH4P4ZxTnAoLCGfB0oiCoBZLpU5V
         CRvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Wdf0pLRXOZPMWfo4yBwksSFRBw0+nuUbfu0d68iWmo=;
        b=Q1gf7uDEmUWzl2A3E/WlTTXu0VQnCRnY7lT657IEFIg62rEn6cg2lPD/DlGRFqYfJS
         TXm9HDcEBn1eqsIz6Hnsp8EyHt91BTlITolqQHGWniq6Lv/v652RYKj4criyBBny9IS9
         U+pUBQfualGOGsdjd3z1yEPUCUeJ2RL1m/0l/erSC3qTWHO2EvrwENR4tWElK4HnlD2X
         ervUNdJG4O3Sf63ZnQuQt4LwRuG5hLIM0kef9ONzTC+0di8MoxeIx4f9Nb7CX3qJ8tl1
         UAN9qB/H6vXMKNHLYv1iyzUWqB3SH6Kr8AaLh4l93J6GotwZoPyulFp/ChJo9QWyamCE
         AXpQ==
X-Gm-Message-State: APjAAAWgTl5GYsfWvr08YgyFbe3L/FFC1D5rNxhIS6MIx8DSiEKyplR4
        BxcydAvfJT4bT5E/E2rFfqFCEfFvy0h0FWDavwimmm1n
X-Google-Smtp-Source: APXvYqy5dipnrGe3RWR1ScfHrcrbXIelhqXCihgux68DmrfeyFtDx1NcS40Af1k65/oo/x3xCemGGF4hwFDWFHH/zoY=
X-Received: by 2002:a9d:6c16:: with SMTP id f22mr17932219otq.182.1557845299758;
 Tue, 14 May 2019 07:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAHAc2je-Yz4oej-sqvp+G+2Wv+eBABeJWUMm4scRwF2z_diUXw@mail.gmail.com>
 <CACsJy8C++Ds4kfs_Wc8UiVQgni-ypbyJ+0bFg1m5brt+s0Tfig@mail.gmail.com>
 <CAHAc2jf2Ojve=NaEshXx9qk8rtD4NHxqLEpqZq8c9t0yE4m_Qw@mail.gmail.com> <CACsJy8DnmQxO+r3ybg2zpCSMZJaTwc_C8V3QMCDjvga09sBigw@mail.gmail.com>
In-Reply-To: <CACsJy8DnmQxO+r3ybg2zpCSMZJaTwc_C8V3QMCDjvga09sBigw@mail.gmail.com>
From:   Shaheed Haque <shaheedhaque@gmail.com>
Date:   Tue, 14 May 2019 15:48:08 +0100
Message-ID: <CAHAc2jfZ7QvZ_PTZo5q8orSStZL2y8GJ=ZPe2-+hcydjEZ0=Ew@mail.gmail.com>
Subject: Re: "add worktree" fails with "fatal: Invalid path" error
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 14 May 2019 at 13:34, Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Mon, May 13, 2019 at 7:55 PM Shaheed Haque <shaheedhaque@gmail.com> wrote:
> > The original code used the more obvious "git worktree remove" rather
> > than "git worktree prune" but I switched partly because remove seemed
> > slow (I cannot now quantify what caused me to think that), and partly
> > because I was having other issues which, I now realise, you probably
> > addressed in your recent "stat versus mkdir race" change.
>
> It should be as slow as "git status; rm -r". The first command _could_
> be slow. But if you find it significantly slower than that, I will be
> glad to receive another bug report.

After I wrote, I went back and checked, and I have no idea why I
thought it slow. It seems just fine (by the time I have spawned out of
Python and all), and so I have switched the code back to
(synchronous/predictable) "git worktree remove".

Thanks, Shaheed

> --
> Duy
