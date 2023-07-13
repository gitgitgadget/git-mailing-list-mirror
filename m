Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E388C001DF
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 20:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbjGMUoD convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 13 Jul 2023 16:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbjGMUnu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 16:43:50 -0400
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061FA2710
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 13:43:49 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-635decc135eso11590266d6.0
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 13:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689281028; x=1691873028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJKBYyexT+rn3qJIicNYj3JBgZSuWLeoR9qzaeBLDAQ=;
        b=aEZBO79jUolAAulcFLTwp4uaGFsZlr1VvgEXL+ed9OoLgcqbUmY0RpkwnQ3qRy+Swy
         Odil1scOq6PNqswHQkyuWMTr3MrTMRF9nM47d5RYJ01JN86G7yf2M+hzmLZu9xibzfmj
         7Zjc1dOcKv1AqEDB5610j0zJGSh3rtdpJuqLsTROO0WoAuqXeRxxoTl01UhfYDTpGTcM
         rSXOewGmuji4HcfOOklWscfJZCMxrdkpl2jV9Akbrku/n6K1siSWIRZRYXIfe/hRkEXO
         PiJFNiHc3wtp/ktP6zS0bzc5kteUx5jkbhY5oiyREr1IdExfaHm1wlGKOgczVcOjX5XX
         mToA==
X-Gm-Message-State: ABy/qLa7x1w3oVcwyIHL36Xr5QkroNdryJb9WMTb48Zqxx6prSz7jU12
        k1B4+TpN2n4Ga3geEPcEuoOvlXthVAHswNKDYNs=
X-Google-Smtp-Source: APBJJlHeadq9zfQxuXIwcit48HjKZ+oyP0Fuzm4HQBa38c8V8WD1Lc93MVLxrKhxaWjMf31Yd651qddGfUfvm6s+C7Y=
X-Received: by 2002:a05:6214:acd:b0:636:fbc3:d841 with SMTP id
 g13-20020a0562140acd00b00636fbc3d841mr961408qvi.30.1689281027919; Thu, 13 Jul
 2023 13:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <CALnO6CDryTsguLshcQxx97ZxyY42Twu2hC2y1bLOsS-9zbqXMA@mail.gmail.com>
 <CALnO6CCc-J+fe9qKaoyYUMM3xMEUnV5w7NKWSbn6xTgEjbac5w@mail.gmail.com> <xmqqfs5ro8v7.fsf@gitster.g>
In-Reply-To: <xmqqfs5ro8v7.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 13 Jul 2023 16:43:37 -0400
Message-ID: <CAPig+cQvr-HuJBQsjt0jW0G95SmyzTc74R6JiznNeKbHmfu9PQ@mail.gmail.com>
Subject: Re: t2400 on freebsd12
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "D. Ben Knoble" <ben.knoble@gmail.com>, Git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 13, 2023 at 4:31 PM Junio C Hamano <gitster@pobox.com> wrote:
> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
> > Bump: this bug seems to affect several GitGitGadget PRs in CI, which
> > also renders GGG unusable for sending mail, IIUC.
>
> By the way, is this really "blocking" use of GGG in any way?  I do
> recall seeing messages regarding gitk from Jens Lidestrom that are
> shown in https://github.com/gitgitgadget/git/pull/1551 but the CI
> run report at the end of that page does have a failing CirrusCI.

Failed CI doesn't block GGG (at least not last time I used it). You
can "/submit" the pull request to the Git mailing list even if CI
failed or is not yet finished running.
