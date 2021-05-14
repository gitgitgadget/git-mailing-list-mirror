Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D172C433B4
	for <git@archiver.kernel.org>; Fri, 14 May 2021 15:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E480E6144C
	for <git@archiver.kernel.org>; Fri, 14 May 2021 15:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbhENPgU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 11:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbhENPgU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 11:36:20 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3225C061574
        for <git@vger.kernel.org>; Fri, 14 May 2021 08:35:06 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id q2so24791610pfh.13
        for <git@vger.kernel.org>; Fri, 14 May 2021 08:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oX2JLxS/nbUqKy+F8PIh4ng73O0+cu+6kDfPV5Jfbrc=;
        b=VgF0aMGzcIFcDyA9wEcy8qGn6YqwzjRqIvONXvheRB3QDobct0HYSI2oJzZmWjXrbw
         sVBL9I/JztaZ1ipe/OQX3JGbZ7W67oUZ3sBtc8dmfMXWqJrrxcqdvIqde576HobCAHk/
         88BYHc3XMGD07VJ8diqSs4bUEY4jfqsjsZ3QuTUEPQ9ahpfHk3i7cM6R6cQB1J5V1Ubu
         mXKNdXlW3Elp6+rJep1tPLEqq0WKgdz5TnQikleL8bkidNClb3Mj03PIewmp0+PoTYgD
         vaVNN/VmGzyP7QFCh+T8bwjfUp6nnWlhnSk2d3MJRQThvrhsrDywQRk4uMzA91qbiUqV
         Uvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oX2JLxS/nbUqKy+F8PIh4ng73O0+cu+6kDfPV5Jfbrc=;
        b=foebQL+8QOc8WBrVNx21VHB7Q2B/oWMlOTHkA0MxNo+Z1bHHTuYNFcAv72Hl2rH/zQ
         eIGYGHB9ohSq41i2ZP3HD18q41l++iFbiDWc8SQYZTQkU+Wt7nOBD8G2St91jgBSmKqR
         IprM+VWGP4rGcDL9wuQZDGAmdb3NzoUUr7J5MR0A9fIqOr57O5N3g0kMuzfCKbyOWzTm
         n03SLf9UnXSlrIjS1iTkIHUVVQO5qWwDFHpj/PaZQZha72AHlVRJC7uEdd2rtWRcjpLH
         uHCe4HF4dnzB5uqTUxdwjnBbZANJaQWSwSiR8eqC1DZW8W7WGqvWLswbxaZrFbN9vZAN
         nDww==
X-Gm-Message-State: AOAM530ITSBGT/9Dq4tvGLLA/8EaSZCC10Bo9GOk54tytTZBnjAVc2V9
        q3HpdkUGanpe4m+S7oT/6MRz/8+75X1vhzU5Jfw1pj/1Um4=
X-Google-Smtp-Source: ABdhPJxpo7WHsXN3ryYmevscUiLs8wXFmkIykPGpS1vYP0vYBazWY158xRSmL4nV7fvI35zV7HWmB5X8R8TXNRh3Xe0=
X-Received: by 2002:aa7:8ac3:0:b029:28e:df57:991b with SMTP id
 b3-20020aa78ac30000b029028edf57991bmr46172183pfd.38.1621006506420; Fri, 14
 May 2021 08:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <609b2828309fc_678ff2082@natae.notmuch> <20210512021138.63598-1-sandals@crustytoothpaste.net>
 <YJt0Dv7HP2VnLLwv@coredump.intra.peff.net> <YJt1/DO1cXNTRNxK@coredump.intra.peff.net>
In-Reply-To: <YJt1/DO1cXNTRNxK@coredump.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 14 May 2021 17:34:54 +0200
Message-ID: <CAN0heSpQz3mAe6vS__rKSfj8wCh+H3pRqauQA5TpjZkYhMBGrA@mail.gmail.com>
Subject: Re: [PATCH 1/2] doc: add an option to have Asciidoctor build man
 pages directly
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 12 May 2021 at 08:30, Jeff King <peff@peff.net> wrote:
>
> On Wed, May 12, 2021 at 02:22:06AM -0400, Jeff King wrote:
>
> > With that change, plus a patch I'll send in a minute, it's easy to run
> > doc-diff on the result.
>
> Feel free to add it to your series if it helps (I had originally thought
> it would just be a one-off to look at the output, but there are enough
> changes, both correctness and style, that it may be useful to have this
> option around).

I agree that this would be useful to have longer-term.

> -- >8 --
> Subject: [PATCH] doc-diff: support --asciidoctor-direct mode

FWIW: Reviewed-by: Martin =C3=85gren <martin.agren@gmail.com>
