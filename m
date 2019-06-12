Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD3A01F462
	for <e@80x24.org>; Wed, 12 Jun 2019 09:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408714AbfFLJaA (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 05:30:00 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:36470 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731492AbfFLJ37 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 05:29:59 -0400
Received: by mail-it1-f194.google.com with SMTP id r135so9509707ith.1
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 02:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=30S35xSc0Ys3EBxtpxDaee2KkfrxVKeJVYFELUX86bs=;
        b=ZTqUAAzkp7KmA5xHIFD95/Q+ASY6XuLRl2N5aNuiMpQr1hAYitCPsJr7dhTx5cR4bw
         kGcVVeLBHqYkh1XTos7PYzbgrpiDVNFVU2uIeESXi9dhMZy1Mn3qpbv8D+Cg0OIu9fiS
         d0ARW/qbyYFhRooCa0UdaT7JgrzyqwZK+7rjrQ/y96nPZg5cdOCgyzm2VR1xekaIgyxe
         xV3uaM7VUj59Id6akasPA4PzzB1f0VvUCaBNSUodt9HmNI422HuBH8ngqGSBNSxq5bZN
         kttSVzp8ipiSbZ6rmpms2/DIZaRI54e8a/d0bwfqZCKa/AoHGdDaHbHjoZqL6dRN0fvD
         Grfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=30S35xSc0Ys3EBxtpxDaee2KkfrxVKeJVYFELUX86bs=;
        b=WAo5r40/r6/KI75F8TFt/SoKVnRIehBielgVjJbnwpyu1UBv/Mqqj/9l5uIELSlOt2
         mn6wSzhIlpXMJHP7upiy+hTv/OOMdG09gACvDBUozLLUVkRwt1yhoTX3blr6wHdZZMuc
         5IFP9ZLaMsuMu0ByqcCyXKdFX4dypUDk7pXMyswXW1BMUfacVg9jtyL5JtE0K9lb/Va2
         XC0bBBUuBIVhWbVO2vut0YigEgAWQRJnBz2b6n022nSexuibm6ilftKNATRy9botKCBZ
         TYTauW+87okcHyyPVkFv22Pk3RVzVwM1797AUdZYWJLIlNYYe+Xq8nGrkiYRuv4AAOmi
         OQGw==
X-Gm-Message-State: APjAAAXt98dA9BG0aa+ZjusBxYQibAWtu4vJ5sM9BX36rk7nbfqEDk5n
        eyAIurwaBwMKALaJlbsZAz5p1jgYD6GY5P60a80=
X-Google-Smtp-Source: APXvYqxy+ifvEATNRqXCnZEGY7A1hozmOzMo3e2WQmhBoRKENIIgVachVFPQ/I+r0X5aO1DAje3o3enF4+8MH1Yy964=
X-Received: by 2002:a02:13c3:: with SMTP id 186mr5829312jaz.30.1560331798842;
 Wed, 12 Jun 2019 02:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <21f1f334-755e-3283-d0da-ec0ab9231cfc@ucdenver.edu> <20190611234815.GB8616@genre.crustytoothpaste.net>
In-Reply-To: <20190611234815.GB8616@genre.crustytoothpaste.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 12 Jun 2019 16:29:32 +0700
Message-ID: <CACsJy8BxdvOrc28_JhAARzJdOqyqWZaFX8DoPjEr4BCe-sRqsg@mail.gmail.com>
Subject: Re: Reducing git size by building libgit.so
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Elmar Pruesse <p@ucdenver.edu>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 12, 2019 at 2:11 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2019-06-11 at 19:52:18, Elmar Pruesse wrote:
> > Hi!
> >
> > The total compiled size of libexec/git-core is currently somewhere
> > around 30 MB. This is largely due to a number of binaries linking
> > statically against libgit.a. For some folks, every byte counts. I
> > meddled with the Makefile briefly to make it build and use a libgit.so
> > instead, which dropped package size down to 5MB.
> >
> > Are there, beyond the ~20 ms in extra startup time and the slightly
> > bigger hassle with DSO locations, reasons for the choice to link statically?
>
> I think the reason is that libgit is not API stable and we definitely
> don't want people linking against it.

Having .so files does not mean it's stable API though. If we don't
ever install header files, there's no way for outside people to use it
(people who dlopen() it anyway deserve whatever they get). I do agree
with some hassles from .so files though.

If installation size is a problem I think we can still shrink it a bit
down. Some non-builtin commands (fast-import, sh-i18n--subst...) could
be merged back in "git" binary. Some other for remote side (or
background daemons) could also be bundled together unless there's
security concerns.

We could also have a look at function distribution in libgit.a. I'm
surprised git-credential-store is 5.6 MB on my machine. We probably
pull more stuff than needed somewhere due to dependency between .o
files.

> Before libgit2 existed, projects
> like cgit built their own libgit and it required pinning to a specific
> version of Git.
>
> Also, some people install Git into their home directories, and a shared
> library means that they'll have to use LD_LIBRARY_PATH (or equivalent)
> to run Git.
>
> Finally, we have support for a runtime relocatable Git which can be run
> out of any path and still automatically find its dependent binaries.
> That won't work with a shared library.
>
> So if we did allow for building a shared library, it would have to be an
> option that defaulted to off, I think.
> --
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204



-- 
Duy
