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
	by dcvr.yhbt.net (Postfix) with ESMTP id 25D7A1F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 22:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfJ3WbW (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 18:31:22 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34893 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfJ3WbW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 18:31:22 -0400
Received: by mail-ot1-f68.google.com with SMTP id z6so3653112otb.2
        for <git@vger.kernel.org>; Wed, 30 Oct 2019 15:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L6gj9MX3Gj3BBWMtjvnuZTWaUpZlawyEblYZMF3HDf0=;
        b=TmfFeZIZ/tfRDzqLAu5z5muvCp+ZEkFdJaSilmwEhQ+vRSUoHo6coK7l7AjlQnc8Zg
         3mWHUCiOC4AnQ7GOBBOrVIwhlxR9nXl9UKNYAlPllt+3Pf3ZekFJuD9g2xOnHaB0Yony
         w8IiluueXoRwb+Ig0aEo5yQfAfaTJN3musNvq1AlMikbvOaGvJt2LLASvTTC9MRMb2gL
         g4DeKVkBMBta78iY5/kN9+E1G6ZD7g92P85LEwUMxJXdz0w7VMDLNQvq1op+1w6TmaZF
         Ing3OY+m1k5qcSQAWLDfuBjfdIEH9iaIsilAqLt9JKoKMErrR28ZTue9wfRwZa2H0PZE
         t5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L6gj9MX3Gj3BBWMtjvnuZTWaUpZlawyEblYZMF3HDf0=;
        b=Gy6gMElXjkhJXYiyGB/QYUDa4KM+mEK8BuD+eByjuUcR0vktS9whk/DDe5a4CFbL5+
         hPbdz6gfSPWkUTLEB59seOntQRhoWXRs9AvH4JOrR+T19BtWUftoQieRTBSgh1OKWmBk
         y2DsGSqVBSp9N67u6nH9B6TFbPJff7iIix3h0jVu2jl4YC+NWLxCSG0nY0Mr4cEk4liH
         G4XYRAomWVQ5UxBDvzi1DeDWg9SSA8y8WrC1JJ5w+JsLRnzT54gZPrnrtudB1biqTttC
         W4W6yq4sk8iuCtf5HAnqIjCnIR3VPaugIHc9b5AzzT/lOxh+o0pjAU1Gnz0OIK0lSuUd
         hLgA==
X-Gm-Message-State: APjAAAVip/3mm9+XJdHA25CosbJE74lTwNTVyw6hNWA13N7RGHWcR1D+
        76BUlWY52QRjR8iRptgX7Y9tk39P9JF2BT+QFPE=
X-Google-Smtp-Source: APXvYqz/BMiEBzFM+WejD3SDE/3aiQbWLxDOBD5soEzSwOGxV4fhNJ04jENwPLyxTqN9Jwnbg8C3ORQ2Q9m7+KWuOH4=
X-Received: by 2002:a9d:7a99:: with SMTP id l25mr1897579otn.316.1572474680910;
 Wed, 30 Oct 2019 15:31:20 -0700 (PDT)
MIME-Version: 1.0
References: <pull.390.git.gitgitgadget@gmail.com> <37aee862e14b1352eb08485f15ea06bab33679df.1570826543.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.1910122152210.3272@tvgsbejvaqbjf.bet> <CABPp-BFNCLJnt4NgFKVxURBGD1Z00gastc5q4ZPjcHmwS=kuFw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1910141211130.46@tvgsbejvaqbjf.bet> <CABPp-BFYWhyLqUktEnk6A7v6135k4TQHO20Wiy32mRQekt-3cg@mail.gmail.com>
 <nycvar.QRO.7.76.6.1910250020220.46@tvgsbejvaqbjf.bet> <CABPp-BHBUKq73Ru3D9HKp6ABo8eQNmkSkz6MjA+4J2a6xxtWjA@mail.gmail.com>
 <nycvar.QRO.7.76.6.1910251527440.46@tvgsbejvaqbjf.bet> <xmqqpnig8i0h.fsf@gitster-ct.c.googlers.com>
 <CABPp-BHPRrbCs2qM8-zBaiL5pO3+9k5cbjtk3YVhy9_k1d7t+w@mail.gmail.com> <nycvar.QRO.7.76.6.1910302315000.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1910302315000.46@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 30 Oct 2019 15:31:09 -0700
Message-ID: <CABPp-BG1ir2kXkxMmNQ2btDKvpSWg9QwcUnoy_5teuNO=JhAFA@mail.gmail.com>
Subject: Re: [PATCH 2/2] merge-recursive: fix merging a subdirectory into the
 root directory
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Wed, Oct 30, 2019 at 3:17 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> On Wed, 30 Oct 2019, Elijah Newren wrote:
>
> > On Mon, Oct 28, 2019 at 6:20 PM Junio C Hamano <gitster@pobox.com> wrote:
> > >
> > > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > >
> > > >> Still, I rely pretty heavily on t6036, t6042, t6043, and t6046 for
> > > >> sanity in the face of refactoring and rewriting -- and as mentioned
> > > >> before they have caught refactoring bugs in those areas that appear at
> > > >> first blush as "overzealous", ...
> > > >
> > > > One idea would be to try to guard those extra careful tests behind the
> > > > `EXPENSIVE` prereq.
> > >
> > > Yeah, I like that---I think it is perfectly in line with the spirit
> > > of EXPENSIVE, too.
> >
> > Or perhaps EXPENSIVE_ON_WINDOWS, since it's actually pretty cheap on
> > linux and not that bad on Mac
>
> Why the complexity? If you separate out the expensive tests (even if
> they are only expensive in terms of run time on Windows), it will make
> the regression tests so much more readable to the occasional reader
> (making them less expensive in terms of reading time...).

The "extra careful" things you were complaining about with the new
test I was adding to t6043 was true of every single test in that
file...and likely much of t6036, t6042, and perhaps even t6046 (though
those have fewer tests than t6043).  I have no clue where I'd even
begin to draw the line between them.  If it's possible, it sounds
extremely complex.  Just using the EXPENSIVE_ON_WINDOWS prereq that
already exists would be easy and simple.

Or did you mean you wanted me to duplicate every single test and
attempt to trim down the duplicates somehow?  That'd be a rather large
undertaking that sounds rather unappealing on a few fronts, but maybe
that's what you had in mind?

> > However, if we're going down that route, perhaps t9001-send-email.sh
> > could be wrapped in an EXPENSIVE prerequisite?  That single test file
> > takes an inordinate percentage of overall runtime.  One one box with a
> > few extra cpus, that test both starts first and finishes last...and
> > it's not far from that on even normal boxes.
>
> I would be okay with that.
>
> No, let me try that again. I would be _totally_ okay with that.

Ooh, sweet, sounds like I should propose it.
