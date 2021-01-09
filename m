Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B2BC433DB
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 14:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E7C123A1C
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 14:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbhAIOUO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jan 2021 09:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbhAIOUO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jan 2021 09:20:14 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567A9C06179F
        for <git@vger.kernel.org>; Sat,  9 Jan 2021 06:19:33 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id s26so29934609lfc.8
        for <git@vger.kernel.org>; Sat, 09 Jan 2021 06:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XqGdGHHhN1ckUeaYqDNBfnc9FlIu12uW3Z8yVCBJgbQ=;
        b=iw42J5CFNVgxjf/SUoJV5WhUOOHMV/X4tIOLr8aEsNsKo3xwyrHzzpVvY+blA5++Se
         NNFTy0q6eDUNGimrDSGuxemrGEU2H6hUxkMGdQhcS04tTJ/M4cFaLRLz9jczWsyUS9PV
         Ttquax9r59SuWMzxQd0xN08ege6l02x6JxlJDm/dztqudpXJZ2GBXIIGTAY3sXenZW2x
         p3le8M1w5WKWaGEUGfN8KHCF+G8dHIos22hrlihzvXgUSUDCR/lF7G7Cj9uYUbi1P8b/
         7HXFRY2TieHUu7Eq7KRBwIHqfAaKg24ZtrZTT91xWo1rRgZ+9U9aCijRSEwd7cS8AyY5
         2SSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XqGdGHHhN1ckUeaYqDNBfnc9FlIu12uW3Z8yVCBJgbQ=;
        b=DUXU6FA2lEu8GJ9cqXlhYJY3CneFWnKrCAyFYm6E3n+FAL0/yOdl2Svb/+42MfRcDC
         1qJWtrawYZNKQswA2U/EfGmReNlx/9vrrCvn7I1C2VSxAgx9dZlqTCsG5ccpJF1AZfE/
         ROVHwBhIfeg9UeXpuyW+7Jf9UXKGLCimFzUXJezkXo9x4hubwzhLvW4wndf83B18E0xz
         IDuUXnxrtQFaEK9D8FSv8vkc0tR9sBd3v4wEVbaYjGmUxML3t3F22iOySEnHxS3kjL4C
         QUdrD3vYLMGrPxiXC66SiR4AmWMQs1ZKbZ+cSUIXRThIUHxurqfMKvNOOJV3xgY770Ju
         75AQ==
X-Gm-Message-State: AOAM532osjbHjAw9GTIc14rWwqRq7fEwgbBdLW6AGNBSG3ARVXbsvnBj
        ZwxqdhvmM5na5FcTpSdW/bVoGM57CvV+pwnvXttzjw==
X-Google-Smtp-Source: ABdhPJxcrlYfNbVyN73HTJNjwH7dYdBIYLGV4pY1LjwB0YMY23xRzRtZlynfwkGTeLyRMVNDUKgM1QR6If50dX4sZWY=
X-Received: by 2002:a2e:8084:: with SMTP id i4mr3893796ljg.291.1610201971876;
 Sat, 09 Jan 2021 06:19:31 -0800 (PST)
MIME-Version: 1.0
References: <88398ff952a68e8d134dcd50ef0772bb6fc3b456.1609339792.git.matheus.bernardino@usp.br>
 <b734425e3235651e738e6eac47eae0db7db92e7e.1609861567.git.matheus.bernardino@usp.br>
 <xmqqlfd5obvx.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqlfd5obvx.fsf@gitster.c.googlers.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Sat, 9 Jan 2021 11:19:20 -0300
Message-ID: <CAHd-oW4Yus5E5U0dykUBfwYM7dryz94YZW_9OFUSZNA-6pp3UA@mail.gmail.com>
Subject: Re: [PATCH v2] t4129: don't fail if setgid is set in the test directory
To:     Junio C Hamano <gitster@pobox.com>
Cc:     me@ikke.info, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 6, 2021 at 8:59 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Matheus Tavares <matheus.bernardino@usp.br> writes:
>
> > +# Get the modebits from a file or directory, ignoring the setgid bit (g+s).
> > +# This bit is inherited by subdirectories at their creation. So we remove it
> > +# from the returning string to prevent callers from having to worry about the
> > +# state of the bit in the test directory.
> > +#
>
> We probably do not use "chmod g+s" manually on regular files, so I
> may be being overly "correct", but shouldn't these be done only for
> directories?
>
> >  test_modebits () {
> > -     ls -ld "$1" | sed -e 's|^\(..........\).*|\1|'
> > +     ls -ld "$1" | sed -e 's|^\(..........\).*|\1|' \
> > +                       -e 's|^\(......\)S|\1-|' -e 's|^\(......\)s|\1x|'
>
> That is,
>
>                           -e 's|^\(d.....\)S|\1-|' -e 's|^\(d.....\)s|\1x|'
>
> instead of applying the rule to any filetype.

Yeah, you're right. I ended up applying the rule on regular files as
well just for standardization. That is, if some day, for some reason,
a test script decides to use "chmod g+s" on a regular file and a
directory, test_modebits would treat them equally to avoid any
confusion. But I guess it's very unlikely that we will ever need to
set the setgid bit on a test, anyway...

> Will queue as-is, as the distinction probably would not matter in
> practice.
>
> Thanks.
