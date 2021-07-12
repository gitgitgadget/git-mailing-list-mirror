Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B83C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 13:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A82856100B
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 13:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhGLN3T (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 09:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbhGLN3M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 09:29:12 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5564BC0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 06:26:24 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id t3so27957331edt.12
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 06:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PfdFElgOMFqqDA0cJGljfYdtHkzP34x2+14ZMli9r0Y=;
        b=ZZW5bXtD4q/sGrmulWpVceCP29XgqJQOox0IJ3nLKJZls5S9Sqe0ydR1rTnL7VSxFT
         P752jovqViN98p25a3duGQycfET57rbLf93SKD1RKJMPWE5D38lhFWzv4vXvATHgWwSQ
         /N5TWTMmASOdGCJaungNgT18T0i/T/u10rdbpaeL5FeEcjQNmz8pzvlnT9cu8y26wy+s
         WwmsySHIGmycS7VlDKhs1B+ng9P7RhJT7YBfawZLxU5j+CU8fdYv74UnMleAXg1iFMf2
         Zn5WQhHSyiCEc4xORROJkCnSXaOwXsOXQDxBd0NoAYAINBdtRU9Q5DTXvyTp4E8bYFTK
         4BSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PfdFElgOMFqqDA0cJGljfYdtHkzP34x2+14ZMli9r0Y=;
        b=Jn0wHkwC8a0wFChxc+WT96rmNJUNU7csH7DNylpHnme39JKOKznu13A12msOceUE1H
         /iq+MUlJTRWMbqREKRdjKtsC18uvZhsGt2ADRdQxs7y+kGn2xMy7ba7I4JUB5FonjLdZ
         czpBW/IXaVUnl3KX0kbomLwHS1N2C8+EuCM6xbiv4Isj7xNTRK2dz2LUtVlYXyYUrfBL
         9DLO6Nq2Gm2y7t+R0GREXf4Zik0k5Z2KTCgiZG+NtZCkUnVLOHs0PQqOfY2XsW41kI7W
         RBaGI07oMQcYAGoYgKKP28ZNfHpTzV7SNZqDI5uxTbzoceRSFTKywV2dbvYu8RCv2LMa
         vJew==
X-Gm-Message-State: AOAM533sUsRoSfF0fDSOMeHOE0kyG23xcgoUSMvDJehb2bxPIkhXUkDV
        bXs9eJdvZoN20z3QkBNYSku/UY1lzKpbzkFJeUM=
X-Google-Smtp-Source: ABdhPJzkpHwzmnDYCb7ZCK9IzahhyIKBMR+SbOO1aIIWWedUhnT+4lzzvYToIQSqMCut8QcUvT7BlUqiILxCbiaB10I=
X-Received: by 2002:a05:6402:4308:: with SMTP id m8mr65937905edc.237.1626096382981;
 Mon, 12 Jul 2021 06:26:22 -0700 (PDT)
MIME-Version: 1.0
References: <pull.993.git.1626090419.gitgitgadget@gmail.com>
 <70e83e4ba3cc8a55bb8d90cb2c581cd04ac116d4.1626090419.git.gitgitgadget@gmail.com>
 <CAP8UFD0vHw8cK90RbOUcrAcxNKiHVTMX0VEiK8+MNyHH0CNm4A@mail.gmail.com>
In-Reply-To: <CAP8UFD0vHw8cK90RbOUcrAcxNKiHVTMX0VEiK8+MNyHH0CNm4A@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 12 Jul 2021 15:26:11 +0200
Message-ID: <CAP8UFD1NfCXDVwaVWKvTWofFHbLee=JRzr4sQBecMMaqi0eWBw@mail.gmail.com>
Subject: Re: [PATCH 14/19] [GSOC] cat-file: reuse ref-filter logic
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 12, 2021 at 3:17 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Mon, Jul 12, 2021 at 1:47 PM ZheNing Hu via GitGitGadget
> <gitgitgadget@gmail.com> wrote:

> > +batch_test_atom() {
> > +       if test "$3" = "fail"
> > +       then
> > +               test_expect_${4:-success} $PREREQ "basic atom: $1 $2 must fail" "
> > +                       test_must_fail git cat-file --batch-check='$2' >bad <<-EOF
> > +                       $1
> > +                       EOF
> > +               "
> > +       else
> > +               test_expect_${4:-success} $PREREQ "basic atom: $1 $2" "
> > +                       git for-each-ref --format='$2' $1 >expected &&
> > +                       git cat-file --batch-check='$2' >actual <<-EOF &&
> > +                       $1
> > +                       EOF
> > +                       sanitize_pgp <actual >actual.clean &&
> > +                       cmp expected actual.clean
> > +               "
> > +       fi
> > +}
>
> I wonder if the above function and some of the tests below could be
> introduced in a preparatory patch before this one. It could help check
> that reusing ref-filter doesn't change the behavior with some atoms
> that were previously supported or rejected. Of course if some atoms
> are now failing or are now supported, then it's ok to add new tests
> for these atoms in this patch.

For example maybe some of the tests could be introduced earlier when
the reject_atom() function is introduced.
