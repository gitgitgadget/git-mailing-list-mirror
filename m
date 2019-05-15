Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF8DB1F461
	for <e@80x24.org>; Wed, 15 May 2019 06:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbfEOGPv (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 02:15:51 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:38174 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfEOGPv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 02:15:51 -0400
Received: by mail-yb1-f196.google.com with SMTP id a13so556957ybm.5
        for <git@vger.kernel.org>; Tue, 14 May 2019 23:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=connect-hku-hk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fm/iFzK+g9IY4I5E13iXe8AY0rPC8IxpkXY+n3LU/7I=;
        b=ZTRU8W+tZYAZGhqRtB6Nuwf7KZBSlPYqdnWHV+Zv2LlVAlcZebvVginsSY+39iUA3b
         Yx75THA2GhDdxANM4+sfhIL30mE0armTrAsIKMzd63azRnaHEnTvZyY00UCHoDmcNEH2
         Tek+hpvsCXB7aFRlFYkmX0R9O1uDRwOT1a6JPS5cQdIqbUit+0bevUaWYjs79RCD21yZ
         SKzsb/qbnRTuIHl5hM7G/5qNjE4IVzjOlci/t6fKNbnKtNfcAFWcyTBktgyF++qTFwOM
         lgQ3D4MvR6CzOV3U7Zs2o1Zj853SittevrDZaT5BfP9Pg2PJb/DyFVChi2EkVU4xb6DW
         DQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fm/iFzK+g9IY4I5E13iXe8AY0rPC8IxpkXY+n3LU/7I=;
        b=n52hpuEv/0XcuEEfVaLKlPv7pf7CIETA9VtRcGJ7RkbvNizqj6Bn1HS66wv9TR3bXk
         q/EM47Sayc+BA1fqnLFM+A0yqcCg896x8ldbzPvoO4H32POBCgn7JSVzsvtXOI3S1WRs
         I5+u0AXzC5Rcxv0LJuAxUc1ui+b4TRcyVvW9flQcSqYAHS/GClpf11e7Ek5QSbSuvqAm
         2KWzDaZqhQ79gKqvnORZH1sZX3cfhrTKyHJpo1djeUOtFYrvfgAAzAJNaVUYzFAt/NzP
         tKKUUqL11lfWblCWQVc15iO9rxGWuHY7aDwMDuyuFGXKTZ9Cqwsfsp9PPjcIVucp//uA
         NVTw==
X-Gm-Message-State: APjAAAWljmc8GUFWcH5GuMXf5EXBo4OAqY0puGSqVr8TdfLyfgiojCl2
        XJeUuQYwGHHpQ/+slAJUuvpgM16brsauOsDB98zFig==
X-Google-Smtp-Source: APXvYqylu1OzcapWa+E2OsjKFU+RaYslYJYfmC8Be5BcRAdbjmjuDdAMK9+MCx/d4YoSkdjqvTqeKv/+Rll+vEpBwCk=
X-Received: by 2002:a25:850e:: with SMTP id w14mr19521793ybk.13.1557900950387;
 Tue, 14 May 2019 23:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <CALM0=-mTLakSBW67vqHNX84p=uw990QDbpeUfh1HKq9N0CiiLA@mail.gmail.com>
 <20190511041331.51642-1-liboxuan@connect.hku.hk> <aa86f483-9c73-eb6d-1a73-80fd4894c093@kdbg.org>
In-Reply-To: <aa86f483-9c73-eb6d-1a73-80fd4894c093@kdbg.org>
From:   "LI, BO XUAN" <liboxuan@connect.hku.hk>
Date:   Wed, 15 May 2019 14:15:14 +0800
Message-ID: <CALM0=-n_=8K4RWE9MvwPFT26UwN-rAA09ryqdTfEF4GJ57YBjg@mail.gmail.com>
Subject: Re: [PATCH v3] userdiff.c & doc/gitattributes.txt: add Octave
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        philipoakley@iee.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 15, 2019 at 1:57 PM Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 11.05.19 um 06:13 schrieb Boxuan Li:
> > Octave pattern is almost the same as matlab. Besides,
> > octave also uses '%%%' or '##' to begin code sections.
> >
>
> > @@ -60,6 +60,11 @@ PATTERNS("java",
> >  PATTERNS("matlab",
> >        "^[[:space:]]*((classdef|function)[[:space:]].*)$|^%%[[:space:]].*$",
> >        "[a-zA-Z_][a-zA-Z0-9_]*|[-+0-9.e]+|[=~<>]=|\\.[*/\\^']|\\|\\||&&"),
> > +PATTERNS("octave",
> > +      /* Mostly the same as matlab. In addition, Octave
> > +       * supports '##' and '%%%' for code sections */
> > +      "^[[:space:]]*((classdef|function)[[:space:]].*)$|^(%%%?|##)[[:space:]].*$",
> > +      "[a-zA-Z_][a-zA-Z0-9_]*|[-+0-9.e]+|[=~<>]=|\\.[*/\\^']|\\|\\||&&"),
> >  PATTERNS("objc",
> >        /* Negate C statements that can look like functions */
> >        "!^[ \t]*(do|for|if|else|return|switch|while)\n"
> >
>
> In Matlab, are %%% and ## valid syntax? If not, instead of introducing a
> new language, please just extend the Matlab rule to treat %%% and ## as
> you need for Octave and mark your Octave files as Matlab.
>
> -- Hannes

Hi Hannes,

'##' is not valid syntax in Matlab scripts.

'%%%' is valid syntax in Matlab. However, it is not used as a section divider.

ref: https://www.mathworks.com/help/matlab/matlab_prog/run-sections-of-programs.html
ref: https://octave.org/doc/interpreter/Sections.html

Best regards,
Boxuan
