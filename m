Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BC3C433EF
	for <git@archiver.kernel.org>; Sat,  2 Apr 2022 07:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348016AbiDBHeD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Apr 2022 03:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345929AbiDBHeB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Apr 2022 03:34:01 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15C2174EBA
        for <git@vger.kernel.org>; Sat,  2 Apr 2022 00:32:10 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-df02f7e2c9so5046987fac.10
        for <git@vger.kernel.org>; Sat, 02 Apr 2022 00:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JbRmWRo7Oi4CFGfWE2N8lE242iB6KhTROt8/Npy/Li8=;
        b=ffPoiTHY1Yzk0+A6pF7dvib9bV3VY8f4v9DLv6x13MCMedzeRdOu0wnfhqFmUwQTV5
         Z8wQDOA11RR0ZmYoUcL/vEi357XDGmcpF1WKI9tPyt+0ZQ2ohpPWW3FYwTGidO42ObDQ
         xChguLW3GXlw1E93n6oTGv8iz24NErRgWog9avmp0Qx6/VayoIkQaVkVR7trI1+tREOf
         RYrGWN2OsI2z/RMXCi/MTwYPUKIp/us/JoVW/seOrtIXWm5aKcKSLKsYLTQBDf4NU4vZ
         UiOI2tx9GmU5qSsk1e5zNgCqBBtZ7CVdjkQ9Z2AEwI1kpJmJGr8LVdzwApTPrep0pS8+
         v7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JbRmWRo7Oi4CFGfWE2N8lE242iB6KhTROt8/Npy/Li8=;
        b=abFWB3ydsSsykrvhdJJ5enwii08eReIZCHH6dt/LxwBZQraAyOH9LiqjzXZf0dRilE
         hvFO3Ef0LoGxdHa/b98B2DvdmQ3BE6Q38DFb9pdyW8NZZNXy9LeJaMK1IMB5UtJLEtSK
         dnIaWvM5uHVHjfHC0v06L/Y4RHbAskYuzAM1uqAYMmwumXq/i/ewzARe3hMykDYfKbhd
         g3wBemDGa/EUAvmJ9q8FLZxPnPAsy5P/EeSwleRpb0QGRmcWC4PxMHPCZn8MtC8YZ5Ux
         XaW8qe9hazR7APEwUGdfv+Gsh/iB6haDkzxFbDzq0doh7YJFzazTg2VXu1mya7Zuq4EK
         pGAg==
X-Gm-Message-State: AOAM5324ycanYn8N+4kpIng4dQPdiQx4DfCXlnsHzCT8AXzTQ7pXULt6
        broI2sPMXLmTr2fQm1d2zFLWlrrhh3fMvfA8+lI=
X-Google-Smtp-Source: ABdhPJzjskAeb6IHehcbfp6VEvXhmev25/B3i1j4vulABQhudvD/kXehDHEmQXHX+ougbCvyqaxd8hQXSe9IDncj340=
X-Received: by 2002:a05:6870:1613:b0:de:29de:12cd with SMTP id
 b19-20020a056870161300b000de29de12cdmr6618577oae.197.1648884729468; Sat, 02
 Apr 2022 00:32:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220331175412.305968-1-gitter.spiros@gmail.com> <xmqqo81kva1j.fsf@gitster.g>
In-Reply-To: <xmqqo81kva1j.fsf@gitster.g>
From:   Elia Pinto <gitter.spiros@gmail.com>
Date:   Sat, 2 Apr 2022 09:32:03 +0200
Message-ID: <CA+EOSBmGkgi4EmEXnu8PQ6VhZ7jLoa_fjV03fYFeihdN3hCk_g@mail.gmail.com>
Subject: Re: [PATCH] t5510-fetch: upgrade to a more modern style
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Il giorno ven 1 apr 2022 alle ore 22:11 Junio C Hamano
<gitster@pobox.com> ha scritto:
>
> Elia Pinto <gitter.spiros@gmail.com> writes:
>
> > Clean up the code style so all the tests, and not just a few,
> > that chdir around isolate themselves in a subshell.
> >
> > Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> > ---
> > this patch was inspired by a Junio #leftoverbit
> > https://lore.kernel.org/git/xmqqmtjh0x5f.fsf@gitster.g/
> >  t/t5510-fetch.sh | 927 ++++++++++++++++++++++++-----------------------
> >  1 file changed, 477 insertions(+), 450 deletions(-)
> >
> > diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> > index 6f38a69fbb..d0b249d276 100755
> > --- a/t/t5510-fetch.sh
> > +++ b/t/t5510-fetch.sh
> > @@ -48,342 +48,349 @@ test_expect_success "clone and setup child repos" '
> >  '
> >
> >  test_expect_success "fetch test" '
> > -     cd "$D" &&
> > -     echo >file updated by origin &&
> > -     git commit -a -m "updated by origin" &&
> > -     cd two &&
> > -     git fetch &&
> > -     git rev-parse --verify refs/heads/one &&
> > -     mine=$(git rev-parse refs/heads/one) &&
> > -     his=$(cd ../one && git rev-parse refs/heads/main) &&
> > -     test "z$mine" = "z$his"
> > +     (
> > +             cd "$D" &&
> > +             echo >file updated by origin &&
> > +             git commit -a -m "updated by origin" &&
> > +             (
> > +                     cd two &&
> > +                     git fetch &&
> > +                     git rev-parse --verify refs/heads/one &&
> > +                     mine=$(git rev-parse refs/heads/one) &&
> > +                     his=$(cd ../one && git rev-parse refs/heads/main) &&
> > +                     test "z$mine" = "z$his"
> > +             )
> > +     )
> >  '
>
> I think the idea of the "first unconditionally go to $D and then do
> these things" pattern was that these tests anticipate that the step
> before them will leave the process in an unexpected directory when
> they begin.  If the original version of this test fails when we
> created the first commit "updated by origin", the next test piece
> will start in "$D" directory, and if we successfully run it to the
> end, the next test piece will start in "$D/ two".
>
> Now, the point of this patch is to make sure each test piece will
> not chdir around by isolating the parts that run in different
> directories inside subshells.  The purpose of doing so is?  It is to
> relieve later tests from having to worry about "going back to the
> known starting place".
>
> So, it is dubious that we want the subshell around the whole thing,
> whose first command is to go to "$D", after we apply this patch.
> Removal of that part was the primary reason why we are writing this
> patch.
That is fine. I had misinterpreted your answer here
https://lore.kernel.org/git/xmqqmtjh0x5f.fsf@gitster.g/

So the right thing to do is to leave "cd $ D" not in a subshell while
the actual test yes.
But at this point "cd $D" should be removed from subsequent tests, as
it is redundant.
In fact, if the first test of the chain fails, all the others would
always execute
with the current directory equal to $D for sure.
>
> So I'd expect that the above test piece would become more like
> in "git diff -w" output.
>
> It is important to notice that the reason why we had 'cd "$D"' in
> this test is *not* because the previous test has chdir'ed around,
> but to look similar to later tests in the series.
>
> Thanks.
>
>
> diff --git c/t/t5510-fetch.sh w/t/t5510-fetch.sh
> index 6f38a69fbb..1ed27607e2 100755
> --- c/t/t5510-fetch.sh
> +++ w/t/t5510-fetch.sh
> @@ -48,15 +48,16 @@ test_expect_success "clone and setup child repos" '
>  '
>
>  test_expect_success "fetch test" '
> -       cd "$D" &&
>         echo >file updated by origin &&
>         git commit -a -m "updated by origin" &&
> +       (
>                 cd two &&
>                 git fetch &&
>                 git rev-parse --verify refs/heads/one &&
>                 mine=$(git rev-parse refs/heads/one) &&
>                 his=$(cd ../one && git rev-parse refs/heads/main) &&
>                 test "z$mine" = "z$his"
> +       )
>  '
>
>  test_expect_success "fetch test for-merge" '
