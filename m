Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00FC5208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 17:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbeHHTyR (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 15:54:17 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:43158 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbeHHTyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 15:54:16 -0400
Received: by mail-yw1-f67.google.com with SMTP id l189-v6so2133957ywb.10
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 10:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X6CXh0dQl0AjBdwSTUf3L9PZAq4WDlB1NPedVdk3avM=;
        b=L29mAf1pYZRO71ocEy+0c2jhQjuw9Cw1EB6EYRsjBVdGUkTayFcoiCKcXkOIXr41OZ
         LdWAd1YsFtUGLrT4JkHIxOMye+AmRKgi8oxtBeuOJAP2a0eXmxXOEm26ZTxP9KSM+y9p
         DOA5uPh9IqzAzjWxzNV432QyAFqUSfp/ip0dJHIkYO69vxwj0tjVYZzlBePHp+Tg8tQV
         /9KKR69cWxGYJGwXU7CP0PB/ArQuAOZ7Dom7pZVTk/sTnpo1ZsQ+whHSfh8+R1GQ2Nzs
         Yjl5E4O2xwQxxjgujl4XUocC5pY5oxjQFaZoluogDWfN4qIEcQaqvK8uYP14M3IBzK6b
         SPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X6CXh0dQl0AjBdwSTUf3L9PZAq4WDlB1NPedVdk3avM=;
        b=qEHQNkl5Gi43U7/wCB99rpnBCwhn1BbRLd5nvwi08s9TKlQxSFYiP6cpIXgyKIixZN
         2jelePcYRSNYqMNfcBrQXyci2TyY7fAGsg9FL9NJmzcPoMbEPod7OpML+dO9FGmd7NJ7
         RQ1IWyF4FQJs0wjT+E898dNqeXUBC1CGoAu7GKjt03GDj4blJiSixdEd8LzktzkTO8ox
         7JCtmG8yam+2H0dE6q3Hqwox0uz4jIEkM8IgeX/Gwc17yCtBggVlERnqOqOcEoYVJn97
         JYIRB6SV+0kJW9C+fx8ZGSV6RH29jpeY7UZEq2lRDcRxQlJIvqKyWD5V3yZzgnN1LHZu
         cHhA==
X-Gm-Message-State: AOUpUlEG+GE7zHzTRhn74HGStQFw2fQDVaY9ytT1u0d+k/StK4fByIyX
        0XaGO6LfpWAj3vOc5vvHE/1sgOKkQSuUnO62hWI44yMufmiANA==
X-Google-Smtp-Source: AA+uWPyQhrvtEue7w1s82FovTbIdKYbzzIOXul/BY50lhvKuZRp9+BcrXKpPgByDwjKzOvlVU5H/gFXsOMxgiMERIZw=
X-Received: by 2002:a81:a9c4:: with SMTP id g187-v6mr1993262ywh.238.1533749614350;
 Wed, 08 Aug 2018 10:33:34 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1.v3.git.gitgitgadget@gmail.com> <pull.1.v4.git.gitgitgadget@gmail.com>
 <CAGZ79kb4ki0cXLnJHeqzRvWaGWki1_epWOdCy49s_v9cy_tJ2A@mail.gmail.com> <nycvar.QRO.7.76.6.1808081422160.71@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1808081422160.71@tvgsbejvaqbjf.bet>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 8 Aug 2018 10:33:23 -0700
Message-ID: <CAGZ79kbj2sgKOmouvLDuXic3vq9RG1LZ_retOqMwX_YZtMP+1Q@mail.gmail.com>
Subject: Re: [PATCH v4 00/21] Add `range-diff`, a `tbdiff` lookalike
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     gitgitgadget@gmail.com, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 8, 2018 at 6:05 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> > [...]
> > >       diff --git a/Makefile b/Makefile
> > >       --- a/Makefile
> > >       +++ b/Makefile
> >
> > The line starting with --- is red (default removed color) and the line
> > with +++ is green (default add color).
> >
> > Ideally these two lines and the third line above starting with "diff --git"
> > would render in GIT_COLOR_BOLD ("METAINFO").
>
> I agree that is not the best coloring here, but as you remarked elsewhere,
> it would require content-aware dual coloring, and I am loathe to try to
> implement that for two reasons: 1) it would take most likely a long time
> to design and implement that, and 2) I don't have that time.
>
> So I would like to declare that good enough is good enough in this case.

I anticipated this answer, so I wrote some patches myself, starting at
https://public-inbox.org/git/20180804015317.182683-1-sbeller@google.com/
specifically
https://public-inbox.org/git/20180804015317.182683-5-sbeller@google.com/

I plan on resending these on top of your resend (if any) at a later convenient
time for both you and Junio, as noted in
https://public-inbox.org/git/CAGZ79kZnVEsvpicNu7LXkRcHuRqGvESfvG3DL5O_2kPVYrW-Gg@mail.gmail.com/


>
> > >   3:  076e1192d !  3:  4e3fb47a1 range-diff: first rudimentary implementation
> > >      @@ -4,7 +4,7 @@
> > >
> > >           At this stage, `git range-diff` can determine corresponding commits
> > >           of two related commit ranges. This makes use of the recently introduced
> > >      -    implementation of the Hungarian algorithm.
> > >      +    implementation of the linear assignment algorithm.
> > >
> > >           The core of this patch is a straight port of the ideas of tbdiff, the
> > >           apparently dormant project at https://github.com/trast/tbdiff.
> > >      @@ -51,19 +51,17 @@
> > >       + int res = 0;
> > >       + struct strbuf range1 = STRBUF_INIT, range2 = STRBUF_INIT;
> > >
> > >      -- argc = parse_options(argc, argv, NULL, options,
> > >      --                      builtin_range_diff_usage, 0);
> > >      -+ argc = parse_options(argc, argv, NULL, options, builtin_range_diff_usage,
> > >      -+                      0);
> > >      +  argc = parse_options(argc, argv, NULL, options,
> > >      +                       builtin_range_diff_usage, 0);
> >
> > This is really nice in colors when viewed locally.
> >
> > >  16:  dfa7b1e71 <  -:  --------- range-diff --dual-color: work around bogus white-space warning
> > >   -:  --------- > 16:  f4252f2b2 range-diff --dual-color: fix bogus white-space warning
> >
> > Ah; here my initial assumption of only reviewing the range-diff breaks down now.
> > I'll dig into patch 16 separately.
>
> Right. This was an almost complete rewrite, and then next iteration will
> hopefully bring another complete rewrite: disabling whitespace warnings in
> dual color mode.
>
> > Maybe it is worth having an option to expand all "new" patches.
>
> Sure.
>
> And I also have a use case for --left-only/--right-only.
>
> And I also have a strong use case (and so does Junio, it seems, or for
> that matter, anybody contributing to Git due to Junio's insistence on
> signing off on each patch, rather than on the merge commit) for something
> like --ignore-lines=<regex>.
>
> And you probably guess what I will say next: these features will make for
> really fantastic patch series *on top* of mine. There really is no good
> reason to delay the current patch series just to cram more features into
> it that had not been planned in the first place.

Yes, I agree. I am unsure about the current state of your series, though;

Junio thinks (expects?) a resend, whereas you seem to call it good enough
but also said (some time back) that you want to resend due to Thomas
feedback.

I do have 2 series on top of the current range-diff.
* The first (queued by Junio as origin/sb/range-diff-colors)
   adds a basic test for colors and improves diff.c readability
* The second (linked above) changes colors for some lines.

I do not want to build more on top as long as I do not know if
you resend (and how much it'll change)

Thanks,
Stefan
