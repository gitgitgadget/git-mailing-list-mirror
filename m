Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700ECC433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 22:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5250260FC1
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 22:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbhJ1WLx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 18:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbhJ1WLx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 18:11:53 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67C0C061570
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 15:09:25 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id h4so14455379uaw.1
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 15:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=REycalOhzgts91TuAfn/vmBN3wNj8zb8NL2F3XiN1gQ=;
        b=LiM0w6mIhQRnkgT63PldwH0VndQsNQspCZ9cqHn+zTLAqd5t/7OiGoH19l/1HU+7Ec
         eseL3WdN0VtdjlGbgPzXhr04G86R+WLduiZ9W4+QqJn8co6ubvv4lrEmHs+mwOXI5pak
         1cXHnj8r0z9Ge4Q3QWMPRs3DGoSqgv4G+daeUaveLm5qIDfGQ8azy20GIQ7Y34zJl2mK
         +zTRb0Nt+4ZuMRnkNpHbRAP2Mqi78AgagPW6ViERfhuMsjv5+GGVeGm9C2ZEH9HO+liW
         ZPhRgNN/56J16WDGBytZAGV5TwbHMa0+Vp28BQbydEtp8dNNbKm2wG+7gQB5rZ/Jjns8
         xAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=REycalOhzgts91TuAfn/vmBN3wNj8zb8NL2F3XiN1gQ=;
        b=2ktfPEC0dso5bOiWBg/tBOUzcb6CIPB1ljX99WhWwJExh2UhbKHnqc6QNA7SWgOOt6
         tZmKi4CI1Vr3uaG71fGjJMMUy9/Biqe6fYrVhMr288GDei8Odv5jI5Uj+y3YOTdBoJp6
         1lHgDD+qxUomLS/Yu9Vj3x35YCf60z/OC2y5+NtS1ayscq/lEOO3KvExOAbG0BYvnI6D
         kpoUW4rDXiUnikEK8apF5J+TSAT8SQnIfvFg08ux2ZUuHzcIITV2XZiVx7ryLIqGeYnV
         u5aPHaiyyqa0yRnuIlsL5VC7r6/QF05a7kWcoFo5B1ViBSEsJYqDcwMIX0ui+zu8vnGP
         ukTQ==
X-Gm-Message-State: AOAM533ZSU7JGsbx0sY2SGaroGYmgnisKO/iiKDpdIseblpK+f50J5dB
        +i73XqntFvNN+fdaDr7LShcesNylU0P5fByZl/Q=
X-Google-Smtp-Source: ABdhPJznN4hxrLquN2W2jOAG5AJSBJWYXibOiLbX2EC2EgSL0kfS3Ywf59DDPzsTO+xXvVwiUhPBpMmdRNlKl5PgeH0=
X-Received: by 2002:ab0:14a7:: with SMTP id d36mr7993434uae.96.1635458964854;
 Thu, 28 Oct 2021 15:09:24 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1068.git.1635320952.gitgitgadget@gmail.com>
 <20211028205649.84036-1-carenas@gmail.com> <20211028205649.84036-2-carenas@gmail.com>
 <nycvar.QRO.7.76.6.2110282344330.56@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2110282344330.56@tvgsbejvaqbjf.bet>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 28 Oct 2021 15:09:13 -0700
Message-ID: <CAPUEspj2B7M_-cbA2O3LickF7MeVYNtXjfJMBMeYkLag5K=Z3g@mail.gmail.com>
Subject: Re: [PATCH 1/3] test-lib: add prerequisite for 64-bit platforms
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, vtbassmatt@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 28, 2021 at 2:46 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> On Thu, 28 Oct 2021, Carlo Marcelo Arenas Bel=C3=B3n wrote:
>
> > Allow tests that assume a 64-bit size_t to be skipped in 32-bit platfor=
ms
> > and regardless of the size of long.
>
> Makes sense, but...
>
> >
> > Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> > ---
> >  t/test-lib.sh | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > index fc1e521519..5fa7fb5719 100644
> > --- a/t/test-lib.sh
> > +++ b/t/test-lib.sh
> > @@ -1687,6 +1687,10 @@ build_option () {
> >       sed -ne "s/^$1: //p"
> >  }
> >
> > +test_lazy_prereq IS_64BIT '
>
> This should be `SIZE_T_IS_64BIT`.

Fair point, but...

> > +     test 8 -eq "$(build_option sizeof-size_t)"
>
> Since this is clearly copied from `LONG_IS_64BIT`, why the change from
> `-le` to `-eq`? It is at least inconsistent to use anything different
> here.

My assumption is that the check for sizeof(size_t) we have is really
about finding the bit width of the platform, and we currently support
2 of them (32-bit and 64-bit), which is why the name I chose was
"IS_64BIT" and also why I was strict on it being exactly 8 bytes
(considering all platforms git supports have bytes with 8 bits).

It can go eitherway IMHO, and your point about being inconsistent
(with my lack of explanation in the commit) suggests we should instead
use your proposal, do you want me to resend or could adjust them in
your tree?

Carlo

PS. I think we should also add a "TODO" comment in the code, but other
than that could also take my "Reviewed-by" for the series
