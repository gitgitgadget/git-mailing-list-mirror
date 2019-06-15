Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CA7D1F462
	for <e@80x24.org>; Sat, 15 Jun 2019 09:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfFOJBo (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Jun 2019 05:01:44 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36568 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfFOJBo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jun 2019 05:01:44 -0400
Received: by mail-io1-f66.google.com with SMTP id h6so11071081ioh.3
        for <git@vger.kernel.org>; Sat, 15 Jun 2019 02:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LhhzuI1N4KCRPNm/xEbooG0u8BdPX+40qauY0BeQ3tU=;
        b=BBt6vZ3Qpzz/HXcl24GR3CqK/cHgeoa3EQrNcjbKoaeZtwGcrQUZBHJUjFfykIjx4r
         jMoywXmmyP8sesauA7U0Fi7L4WtXnMYQz8AvawEFZSkw7HMVCDOVkKFYL6bg/83hBfuq
         QxCMb9bBogo9PdZIhEzOGs4CZcQGvpiJ1h577akayEiOi/Sr5MHGnCW0LYl9P+v5FPrj
         XbFV4RXTeb/h3IFxldQfy0TQRusRI/7LJwRasgVgY7mitzPekKIe9EqY7WkFM6Tdiclu
         C7CnevX3/6Dc7brvNqNgMLgFuP98WxOpup5e7Sw00T1V0XYAUk+nSmge7ahTinGHubO3
         RM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LhhzuI1N4KCRPNm/xEbooG0u8BdPX+40qauY0BeQ3tU=;
        b=rTROlPRu2Wt/7I2lV4xeZZ4xFNjnGSrBN1Ji4nD22mAM33kFGNF3lKPQlAneSFCuZN
         S0Jt8BnVhQJEbuiQMmo5U2AgIOfE9D0UP/eAgtqsBOPtPanb2+uF+ms9rCgP7S/wbh4r
         uDitbPHFgS2NFWm7xvJJFbizxCC/2MUlNYfVY7qxrMVeq3PoWI1uY/GZKdIfwW31+m/K
         cKxQR3YCoEJGHnkvSlFXzmf4H89TTxxUhYc7gEZWVgP5r9hG+VXDfokLlNma0UMtEFYT
         SSu9jxiUJl7jhNI2jqLq6C7+PXYBrKU7UzSN2/7TQgzvpbSTZ1icTnr7+DYiHy0DUTZA
         rtGQ==
X-Gm-Message-State: APjAAAWF0MTv+u1w29o7EEi6klGz3fRfSU6YPf0N3Q228AvAKIj6av2D
        rrZ8pX7mV/Sd5LwNlM90e/k1wVC+4x5efHm5Rdw=
X-Google-Smtp-Source: APXvYqw1E/JIBRVTW9MdrT1uuYcCfTytz/CzAeLeKJ5LF8p8uPydQrCPR0x+1k0vbaM73kf4YQMybIUuPLL29ydm+sQ=
X-Received: by 2002:a6b:c38b:: with SMTP id t133mr18675410iof.162.1560589303341;
 Sat, 15 Jun 2019 02:01:43 -0700 (PDT)
MIME-Version: 1.0
References: <pull.265.git.gitgitgadget@gmail.com> <c1527a71672056859a4613f2318bcbfce31e8b50.1560426581.git.gitgitgadget@gmail.com>
 <87v9x793qi.fsf@evledraar.gmail.com>
In-Reply-To: <87v9x793qi.fsf@evledraar.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sat, 15 Jun 2019 02:01:32 -0700
Message-ID: <CAPUEspjKxQFiRgmfb2SuR_xpVu4=MN66kGEeBK1pHdBgXQbv7Q@mail.gmail.com>
Subject: Re: Can we just get rid of kwset & obstack in favor of optimistically
 using PCRE v2 JIT?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>, git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> It seems most packagers build with PCRE v2 now (CC:
> git-packagers@). I.e. we'd keep something like compile_fixed_regexp()
> (and as an aside just use PCRE's \Q...\E instead of our own escaping).

OpenBSD does PCRE v1 without JIT but HardenedBSD does and therefore
segfaults when calling: `git grep -P`.

A fix probably based on the old proposed patchset[1] will be needed in this case
with more urgency

Carlo

[1] https://public-inbox.org/git/20181209230024.43444-1-carenas@gmail.com/
