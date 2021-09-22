Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703D0C433F5
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 18:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CBC7610D1
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 18:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237080AbhIVSrH convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 22 Sep 2021 14:47:07 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:43925 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhIVSrH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 14:47:07 -0400
Received: by mail-lf1-f48.google.com with SMTP id e15so15647523lfr.10
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 11:45:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mqn19BI7LeqUTY02rDhvN0mnkMx0HnTycjN1O9fAMOw=;
        b=a5FYt9lynIznJUDUYelST6Ax6ieZNRSmGu+qYXuAZo4w9vdL1THQF4ReJaazsVJM5S
         fKJFXYTABrnYNqWcTKAGY6owQ9+daN8UDk1oWiT1NAfsG+pyk14dMDheLu6JQigypjWm
         XzvDiLdguJEvymJxvhygkB0kTUppeurPWoar2DAbuTtb/nwhuUOcdscKD6QL/cBcAmBG
         yzXyCtUeLrBG9MFZuC+EaRJPwCeWd7mXLL8Xnk6sChxi35M2KyM3HMyNfb5EhO9TMBTN
         IZ4zN/vdtf9atfR29ELV0omJnRAco36cQ144yniQK1AIiuWqIO4gjfdHjzb+WvCXg2Eg
         xQzQ==
X-Gm-Message-State: AOAM531jO1JXvFR4f+gDrWuLo3Z1V9PzqG3Mjg5I/SDGccyvh5pynKpd
        d23FOATxVjYXiRKT+x1pP5+jN/cL6RMHlIxYCT5M4QhHgw0=
X-Google-Smtp-Source: ABdhPJw2Z1BQTvB2bJU6B6nnMs+5Vp3Igp2zs9sDqCoykup+k2z8T2yqzaqMH4EOzTIpDzeGCOm8WP6Qea14BSqUasw=
X-Received: by 2002:a05:6512:33cc:: with SMTP id d12mr476617lfg.96.1632336335755;
 Wed, 22 Sep 2021 11:45:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210922183311.3766-1-carenas@gmail.com>
In-Reply-To: <20210922183311.3766-1-carenas@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 22 Sep 2021 14:45:24 -0400
Message-ID: <CAPig+cSTiM-NWLOnSeYEhW8j5POYZ034m-cbMGdROFHp3kWXxQ@mail.gmail.com>
Subject: Re: [PATCH] Makefile: avoid breaking compilation database generation
 with DEPELOPER
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 22, 2021 at 2:33 PM Carlo Marcelo Arenas Belón
<carenas@gmail.com> wrote:
> Makefile: avoid breaking compilation database generation with DEPELOPER

s/DEPELOPER/DEVELOPER/

> 3821c38068 (Makefile: add support for generating JSON compilation
> database, 2020-09-03), adds a feature to be used with clang to generate
> a compilation database by copying most of what was done before with the
> header dependency, but by doing so includes on its availability check
> the CFLAGS which became specially problematic once DEVELOPER=1 implied
> -pedantic as pointed out by Ævar[1].
>
> Remove the unnecessary flags in the availability test, so it will work
> regardless of which other warnings are enabled or if the compilers has

s/compilers/compiler/

> been told to error on them.
>
> [1] https://lore.kernel.org/git/patch-1.1-6b2e9af5e67-20210922T103749Z-avarab@gmail.com/
>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
