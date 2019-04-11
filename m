Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8574C20248
	for <e@80x24.org>; Thu, 11 Apr 2019 00:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfDKA0h (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 20:26:37 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:54400 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfDKA0h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Apr 2019 20:26:37 -0400
Received: by mail-it1-f193.google.com with SMTP id a190so6734046ite.4
        for <git@vger.kernel.org>; Wed, 10 Apr 2019 17:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+49NB+Dqs7yhqoYRxknKnB93OPoOtQtJ2SFTObIxveY=;
        b=kCvirmuYpiGtSEgqERLgAKvmmKUjmexpPYgU/E0AzpAHhbCZAawZa2T3O3eNOppBVA
         9zBECfksg4Lapz16lBK+X42s0Xe+dnPCiFaGhLzJ5DeMiY+CXcgLlkmnXovoeYxJY6cB
         zEKe3YoO6fOAUqMk28k474suy7H6Dppc67KNwk/S89fb0Xl9GJV5Za0bvi1qBBPLT8hN
         zF5H1+8BGh4LjSEgE73ULbmUdvqd8OF/xQC3rqGfvjOeDYjfZzipYeS/34UUr4M/MKSX
         mR9WYOF7Lyjv2P+E1VE4DjR3vY0NW+m6MaITOj/QUK/rSyVDmtAV5YHo+YAOZQ95uT/p
         cUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+49NB+Dqs7yhqoYRxknKnB93OPoOtQtJ2SFTObIxveY=;
        b=jFo0b6C1q1HixnNcKSojQQNJs31/JK+dlTd7XxVWWKxznTCZTFcgd7LdB8ibg/QBQV
         hSAo6wOamLWpGF6yXayst11kNxkRNRe41fn8G99MYv0oFEDKVcdL6MFQI5pBJ2eK0lXG
         1OkS1yilvGwUTymz60nq/Luyr4HOhzNannDy3ciFND+yvMteP5+GtWoJsyPJ/CEPPHwM
         F9qxLsCaSym2BBHusFzdhNCrGDsMcSyO7Vhe3x3Z6DMfiH1eR6vbXAHOtT16egZXPRak
         vdpFCaFHkCod6CQzICzItnQqNIOZ6+F+fpz+H2MW34RumNj4Xbvor6B67626hwxWT5mN
         lr2w==
X-Gm-Message-State: APjAAAWNPPsWmK95yg4IN3t/C5aHJI8CffN07KquuHzjvPSzROEykQ+N
        wvRYI6VDoNqkMVZ737nNaI5efqRaaZlmSrQHd8U=
X-Google-Smtp-Source: APXvYqzmPue9+XjHvuaNukPaFdxBKmkcMHieDf8XGTki7TDZgrb8uViP9SC/g+gN09YFfW97ObgQM/gybJXJZ6j4pFo=
X-Received: by 2002:a02:711f:: with SMTP id n31mr31913765jac.126.1554942396553;
 Wed, 10 Apr 2019 17:26:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190403113457.20399-1-pclouds@gmail.com> <20190406113453.5149-1-pclouds@gmail.com>
 <nycvar.QRO.7.76.6.1904102254500.41@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1904102254500.41@tvgsbejvaqbjf.bet>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 11 Apr 2019 07:26:10 +0700
Message-ID: <CACsJy8AE1cOYCNDu7suQDJ0NYxeoG3w6e-+mZ-J1D5j_WNLWeg@mail.gmail.com>
Subject: Re: [PATCH v3 00/33] nd/sha1-name-c-wo-the-repository updates
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 11, 2019 at 3:56 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> >       @@
> >     + expression c;
> >     ++expression r;
> >     + expression s;
> >     + @@
> >     +-- get_commit_tree(c) = s
> >     ++- repo_get_commit_tree(r, c) = s
> >     + + c->maybe_tree = s
>
> I think this is wrong, and admittedly I had the very same version
> originally.
>
> When you have an arbitrary `r` in any `repo_get_commit_tree(r, c)` (as
> opposed to `the_repository`), the conversion to `c->maybe_tree` is most
> likely incorrect.

I did read the get_commit_tree() source code before doing this. struct
repository is only used to get commit graph to speed things up and we
can't change a thing there when maybe_tree is reassigned. To reassign
maybe_tree, commit-graph does not matter. Neither does the_repository
(vs arbitrary struct repo)

>
> Therefore, I don't think that we can do that.
>
> Ciao,
> Johannes



-- 
Duy
