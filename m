Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 274A01F576
	for <e@80x24.org>; Mon, 26 Feb 2018 11:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752567AbeBZLCZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 06:02:25 -0500
Received: from mail-oi0-f52.google.com ([209.85.218.52]:33715 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752379AbeBZLCV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 06:02:21 -0500
Received: by mail-oi0-f52.google.com with SMTP id j81so8376011oia.0
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 03:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=htFETnRcQpeb5dDZLhjCxUFuD8fUnRSgtNkXk4+0pgA=;
        b=ZVoRNvw6tji4dng2aIuvrgLA5Cat6opo8+4amLnJFu1mFbPvVpSjijPqaX73Z6ptnD
         m6NRfkw4Tx1GphDXmnyWzI0t5TsjNn0Qn+nY9NXIYCFvg4x2VyFuLd/fj/7ru0QNCTFe
         OVKICvSRngELVCH2k1Nf/IyP73DezhSKrKxINMVTY8oHELI7bK0PDdsLS+v8Nj8aZD3j
         5e80cOrxaeNGEbb3ldAa3fDoeHiE6F4a19890VgZj4mx2a8vfzkMYfcpzxVUaACmKNrk
         0anYJY7ZnqC2qpx8DSwDPPvz+7x+vYXG/SCzgpkF2JIpmnAnN+S4dv5Q3l0zfpGY+HpM
         vHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=htFETnRcQpeb5dDZLhjCxUFuD8fUnRSgtNkXk4+0pgA=;
        b=oJshFSprntDDf2jbJwhU1sVjStQVwgp22Z+Z1nWvSHhlv65z9vE2SzpIB5Ahc7S6Li
         LuT5vgumIvHyY89G1EzNWebbwzM+HbFBxZgjsfJB+QeQFpJZCgF5hSGfqmL3pNxGfAZA
         LorGEBUS21t1sg1S/p/kWfBibg5BF6QuaklC6G8fRoJF6FLX4H9xi0DBpKV0ueixFCfO
         UtZ3IXV8NxC5sKMrP1q9S2A07mH9Hv7DGtUkU6SVI1J+28bFmDthR3D/AUBQwBtKWPLh
         79PZXaUqW1Kt45QYTq9FsRCRmlOkd/JczgYQSWjV/osqH9JZqW8XXve6/rs7EftieoJ+
         SvEA==
X-Gm-Message-State: APf1xPDpRx6NlIXATYETQVf/J+98OVVHgx96KuxXTV5TACpEqoQanQtu
        K38EAwbmWZJEh3/hPU88cl0SKQLn8vfs6jGIz8U=
X-Google-Smtp-Source: AG47ELsk703FsCIRsiUuwtgv69DE+EqtkCW5jDZI9DjdIANHuhntNFm4COIl10PnhYixIcDYCndYHROtnM9VlQX3DHc=
X-Received: by 10.202.217.67 with SMTP id q64mr6533157oig.30.1519642941350;
 Mon, 26 Feb 2018 03:02:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Mon, 26 Feb 2018 03:01:50 -0800 (PST)
In-Reply-To: <20180225203537.28318-1-avarab@gmail.com>
References: <20180225203537.28318-1-avarab@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 26 Feb 2018 18:01:50 +0700
Message-ID: <CACsJy8COegzVZ99PqsfrDq=uPfQewEZKXF5WK3K6ah62QfQV9g@mail.gmail.com>
Subject: Re: [PATCH 0/2] wildmatch precompilation interface
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 26, 2018 at 3:35 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> My recently landed wildmatch test series was in preperation for some
> more major wildmatch changes.
>
> Here's another series that prepares for bigger changes in wildmatch,
> it adds an interface to pre-compile the patterns. Right now there's no
> point in doing this, and it's harmless since none of the codepaths are
> that performance sensitive, but down the line this'll save us time as
> we'll be able to skip re-parsing the pattern each time with a better
> wildmatch backend.

I don't see any big problem with this, but should this be a standalone
series? Some changes look harmless now, but I'd rather see the real
precompile implementation to see how it impacts (or benefits) the
converted call sites.
--=20
Duy
