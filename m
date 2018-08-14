Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 570A31F404
	for <e@80x24.org>; Tue, 14 Aug 2018 21:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbeHNX7p (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 19:59:45 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:36198 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727997AbeHNX7o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 19:59:44 -0400
Received: by mail-yw1-f68.google.com with SMTP id v197-v6so17320132ywg.3
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 14:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pIn/IR3v2OYbmUlllFWd6U+OFslKeNzmwZGd2aY4jPg=;
        b=s0OrKAvxVVFy2ZRcfh2Y0/S5wq4aTK2xWVhiPghx825Z4gJ+8wXpggYEKy5EGncqId
         gNdu9nc6ZctuhaOynYJfGxtHYXs9/T1ndSqHDqH1FY5ePNp4HhYkWG+9a51OYIDJjxQO
         EZI5VzMD9BlbzYvOcI9Na65NWuyC/kV1tojyRXoD1qlse92sJQ1Ckda8We/Viz7j/QZI
         FxeRugMC5L0dOlQLRBJYC22LUxzmBQgo7+h6PvhGqrDbTntR+5p4Hh6abgbmm3mMLsbW
         YwUcW95sGKt2mKh4vQsjryUjb+4ZflP35ecLlHF8xfFmmPW3nQfAPtT4N9CIzeGFLk5P
         FVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pIn/IR3v2OYbmUlllFWd6U+OFslKeNzmwZGd2aY4jPg=;
        b=qccl6hfbvP4mO6dH2qBW6f6Ca5mA74SSQ97rr2FtPbx0Dna/yQzph0VVW3kqql/fo6
         O1Cy7nmDwtKp+Assafxv4iB0oITAvhawv8c9lIqxgThKaxXRbX2y3ZkxBi+J4Ir1tXd/
         JdRGQ4keSfKnEyyub28G5MsqJXmrEf7KL+l1S6GkICD6Jt4w6AHwssvhEBCtQ4diwE4V
         o4Pnz3oIyh5x6L6OfUVruiDxGk0oJlpa4TLXouKK29dccFRxLRlyOFRd0+8NWLEk0oUY
         qwItqVNgvbeDUVxgRlhPgm/GDJ7cffTza1ELugn8xv3vjtbYtOXBz97UMV6p8oJ3YKJU
         UvGw==
X-Gm-Message-State: AOUpUlHggxs6vWuphVCG15ssrNZ/BMzj0s+wKokkk7rpSW7WP/Xxy4WM
        P2IekiqUNPtLeb8AJ1PhDIWmsfcdF358ZenOeYJy9Bli
X-Google-Smtp-Source: AA+uWPwJI26Sbs7bppQokWKDMIa9Vr66oyk1dey3VqwuAYao6fCyUJ0lwPinWJBQntDMpQ/1xlUgh74/G/gOzyq4BxE=
X-Received: by 2002:a25:3c45:: with SMTP id j66-v6mr1966052yba.247.1534281042844;
 Tue, 14 Aug 2018 14:10:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180814185906.2680-1-avarab@gmail.com> <CAGZ79kaK8Wt0TGvo-PyDZRLWr9PU0BRo4=DiYUXvv8c8nZ+M8A@mail.gmail.com>
 <87d0ukhd5g.fsf@evledraar.gmail.com>
In-Reply-To: <87d0ukhd5g.fsf@evledraar.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 14 Aug 2018 14:10:31 -0700
Message-ID: <CAGZ79kZuH8DKkoNb3AgHFxwYccOGHeVWOE7ov5QvavtomSxyAQ@mail.gmail.com>
Subject: Re: [PATCH] submodule: add more exhaustive up-path testing
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 14, 2018 at 2:05 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:

> > So ideally we'd also error out as soon as the host name is touched?
>
> Do we have some utility function that'll take whatever we have in
> remote.<name>.url and spew out the username / host / path? We must,
> since the clone protocol needs it, but I haven't found it.

Nope. Welcome to the wonderful world of submodules.
As submodules are in the transition state towards "in C",
we could do some refactorings that would allow for easy access to
these properties, but the transition is done via faithful conversion from
shell to C, which did not have these functions either, but could just
do some string hackery. And that is how we ended up with this
function in the first place.
