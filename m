Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5F3C433DF
	for <git@archiver.kernel.org>; Mon, 18 May 2020 17:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D2A020715
	for <git@archiver.kernel.org>; Mon, 18 May 2020 17:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgERR3V (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 13:29:21 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37707 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgERR3V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 13:29:21 -0400
Received: by mail-wr1-f65.google.com with SMTP id l17so12843638wrr.4
        for <git@vger.kernel.org>; Mon, 18 May 2020 10:29:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U1yFP8r9BIJcLbNg0yPh1hTubCqn1+bnCPIzsrSKOoc=;
        b=RSFc9pYl7EElqHGNGfDBJLsbhy+FRmf4WA4t19DQ4LXjp1nj6wq15ky0cqF4j1FewI
         lru85Jg1CdxaLEdpwU6oW7Z0Tb9gh5A558REN9v9k31JvdvwArmU2tPHtoWMXLQgaI5M
         4ZRvrJT1VddIkgRlpnNounYX4Nw7khzRm48LlTgdAIaZt7B8HYfXiC8ysU9Q9iG/HyJn
         WIAv9fAqFbnPFYxsJdZ8jomMmWcV0Bu7Av9XUucnxyYdk97Xt/KmQfPK4sTQWrGTLBov
         pMj+c95vHj/aQ+WyOD+TaFAkUz8ALJ8SlLQWqz7Drw6Wrkwv+oeqamDdLgDwPhF2RDOQ
         09qg==
X-Gm-Message-State: AOAM533ef8mo6k0qPTaUCDydKwhNOL9Ti/hm/ePAsn/4cP7PgCVreTf8
        yztcYHFv5unnsKqsufBKpRz+ZSiY6YKQnvTDEDA=
X-Google-Smtp-Source: ABdhPJx6Vbpno+BW/9JYT97dDOOd0bxxob+Yn7WhRQyyqvv/cxvGqTF+r36hObQhUXcgF2lkb4R5O90sk4b8wzynUkc=
X-Received: by 2002:adf:fccd:: with SMTP id f13mr21621563wrs.386.1589822959893;
 Mon, 18 May 2020 10:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200516172837.2872-1-abhishekkumar8222@gmail.com>
 <20200518143023.14217-1-abhishekkumar8222@gmail.com> <xmqqsgfx415z.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqsgfx415z.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 18 May 2020 13:29:08 -0400
Message-ID: <CAPig+cTFp0rHkYUwxvRJUWLBsV8gt-qL=UNVBB=+oTCkpe0oyA@mail.gmail.com>
Subject: Re: [PATCH v2] commit-slab-decl.h: fix define guards
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 18, 2020 at 1:14 PM Junio C Hamano <gitster@pobox.com> wrote:
> From: Abhishek Kumar <abhishekkumar8222@gmail.com>
> Subject: [PATCH] commit-slab-decl.h: update include guard
>
> When a9f1f1f9f8 ("commit-slab.h: code split", 2018-05-19) split
> commit-slab.h into commit-slab-decl.h and commit-slab-impl.h header
> files, commit-slab-decl.h were left use "COMMIT_SLAB_HDR_H", while

s/were left use/was left using/

> commit-slab-impl.h gained its own macro, "COMMIT_SLAB_IMPL_H".
>
> As these two files use different include guards, there is nothing
> broken, but let's update commit-slab-decl.h to match the convention
> to name the include guard after the filename.
>
> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
