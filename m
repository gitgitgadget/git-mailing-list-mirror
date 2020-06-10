Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3626AC433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 04:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EF272072E
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 04:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbgFJEP1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 00:15:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33797 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgFJEP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 00:15:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id r7so634174wro.1
        for <git@vger.kernel.org>; Tue, 09 Jun 2020 21:15:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+yGr7oKNTsjJUSqxjwXCYzc5w0GQjQYFGpmRWgaj/QY=;
        b=nVdjVJlgmsmtrqCOcKzjmnrRwjbdXfHChrOvNmUBx9ksa8MwD7ZkzwZUWmmsfwiIv3
         iuoME4Eg9bPilPeNmnI/nAU9zNCQs44JLtaOnf0DR1Owmi793BPeaMscdewgP29UXOR8
         z9FpEaSVKJPN6lq/uOOqFrZtGwpUG9L7t51NJ9Jo0SVocxKQrqw/VybLKmp5AAQEF9zy
         yPcG6Bc2NkH/zq8WRpwK9K9Vqra9/zmnsT3/ooYKNs7ieV4RHO9QdtdUC6XZLEANP7A6
         K0JJbdBrCrfN89Z+eLHkV9D/bozjY/f0DHX+qVKSy2Gt23wrloCgPhw9baR6AN3w02a5
         QSoA==
X-Gm-Message-State: AOAM532i7dDKLInxXqTE55kqNRR2v1IeKkrviR4PaK8eaSjPrxeJTEks
        CdauC5MiAQu2c0CQu71iBeMN4LhAG04V5/IS1TJN8FrK
X-Google-Smtp-Source: ABdhPJx6WvOTLFpGi2nd9wfHCO3Yo9f/NBjuF6kobSCz/ms8Nqs3YEJuESa2jPQiV+te1gve2SyJn9KSQn7BG9bBVtI=
X-Received: by 2002:adf:fd48:: with SMTP id h8mr1360833wrs.226.1591762525672;
 Tue, 09 Jun 2020 21:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <89e22af5-227f-7a38-372a-af2fe7d42be2@ramsayjones.plus.com>
In-Reply-To: <89e22af5-227f-7a38-372a-af2fe7d42be2@ramsayjones.plus.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 10 Jun 2020 00:15:14 -0400
Message-ID: <CAPig+cTF+pwBasVCzmucXmMZcm1K0ctkGOavj7bMcGsw2MvoKw@mail.gmail.com>
Subject: Re: [PATCH] builtin/worktree.c: fix a sparse '0 as NULL pointer' warning
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 9, 2020 at 7:53 PM Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:
> If you need to re-roll your 'es/worktree-duplicate-paths' branch, could you
> please squash this into the relevant patch (commit 71806ee9e8 (worktree: prune
> linked worktree referencing main worktree path, 2020-06-08)).

Thanks, I'll apply this change when I re-roll.

> Note that this is based on top of the 'pu' branch, and Junio has a fixup
> patch (commit 4b01d684fe (SQUASH??? -Werror=main, 2020-06-08)) which also
> changes this line of code (s/main/main_path/).

Indeed, I saw Junio's SQUASH and was planning on applying that, as well.
