Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9D1D1F453
	for <e@80x24.org>; Wed, 20 Feb 2019 01:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbfBTBgJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 20:36:09 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:56248 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfBTBgJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 20:36:09 -0500
Received: by mail-it1-f195.google.com with SMTP id z131so11431088itf.5
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 17:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QBJDWOGi6MINvI/ganTCCnzcoVkVHwBJwWJ5HOOExjo=;
        b=Epokzg05hwGex2SGfUvaSficu3dKVWnYGEhsxfJTbyVOlrOpCqqv7fulaGjHYcPjsD
         cqMSmOchKaxicB7zNX7diU4NUN3yEGLAfAfriNbIi1ucDA+Hh3GM+Mp6oXowHutOkhRB
         u8/kSranGAaN769HxjchehJwcbCCjmKuXZEc/xYvsEb6Vj/OXLjWeC3vfPYDUZHq4uiB
         wbbOhVqU7TzLjMCvvHX0uTE861U97lwPLImSg7+RlOkp3KYzOofMmIm9olzMYCnI/NMN
         x91BWaaf1utGOO0nvALTggVZ9Avi8AmFB29jzxFNOhBMiST/UEWh4t/JhM6DRJV8EY4B
         sjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QBJDWOGi6MINvI/ganTCCnzcoVkVHwBJwWJ5HOOExjo=;
        b=fFfvH19WybwCNNtzcxQKmDM541vqx4l3VejKkLeWl70DHpwuyb4rOFYl5RPPS0EtsG
         2hWK7MZF3esu7gf1FwZQCmhRBY/iB2VYYZgpnCHHBTY3+KQVuxw5kHolDJ+Kvo7N/RzF
         jdWCgB3OibU+WaPT8Rekd4vE2Ckl1DpTbb99KEH0VU+SzFpp/ahoMfYzf9dtPyk5UAuQ
         rdrtKqK5DKnndYLTQ1FZyUNjBC0nugcboUG1N04Vb/Xa4cbcHamlT+kkW0msCIaWf9wr
         a7rUtA9Ak+U/LYXazrgN5wAeHJeCh/w1bli9M6pk4whVknNNM+T5FhXJPA1LT3CLu1uE
         7exw==
X-Gm-Message-State: AHQUAubWc33Yoty9RW2MYQy6A+xgU7PrO6l4uZ0H1krgcgytISIIOCiJ
        BLZVWvfKKZdm4X+E+kjA1vyZJxUfMqkbDq7ygJ4=
X-Google-Smtp-Source: AHgI3Iaz6xzjM05r7PNNNRd/OH3vdMLBCOgwZlnLpFzd4Vm43+Mg60E2kU3aats+dxncvOti2O+N5jSqInpYYDmCW2U=
X-Received: by 2002:a24:c056:: with SMTP id u83mr3540164itf.10.1550626568407;
 Tue, 19 Feb 2019 17:36:08 -0800 (PST)
MIME-Version: 1.0
References: <20190216114938.18843-1-pclouds@gmail.com> <20190216114938.18843-2-pclouds@gmail.com>
 <87wolzo7a1.fsf@evledraar.gmail.com> <CACsJy8CR7VGp7htC_wKC9BUCaQsmkp5Zd4+M7bddPL-jKyfDMQ@mail.gmail.com>
 <xmqq8syb3b3j.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq8syb3b3j.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 20 Feb 2019 08:35:41 +0700
Message-ID: <CACsJy8Dq9_uFofs40XwjLkmiBNWXCpic96W1MK_tjLQyaF0+BA@mail.gmail.com>
Subject: Re: [PATCH 1/1] Introduce "precious" file concept
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Per Lundberg <per.lundberg@hibox.tv>,
        Steffen Jost <jost@tcs.ifi.lmu.de>,
        Joshua Jensen <jjensen@workspacewhiz.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Clemens Buchacher <drizzd@gmx.net>,
        Holger Hellmuth <hellmuth@ira.uka.de>,
        Kevin Ballard <kevin@sb.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 20, 2019 at 1:08 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Duy Nguyen <pclouds@gmail.com> writes:
>
> > On Sun, Feb 17, 2019 at 2:36 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> > <avarab@gmail.com> wrote:
> >>
> >>
> >> On Sat, Feb 16 2019, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> >>
> >> [Re-CC some people involved the last time around]
> >>
> >> > A new attribute "precious" is added to indicate that certain files
> >> > have valuable content and should not be easily discarded even if the=
y
> >> > are ignored or untracked.
> >> >
> >> > So far there are one part of Git that are made aware of precious
> >> > files: "git clean" will leave precious files alone.
> >>
> >> Thanks for bringing this up again. There were also some patches recent=
ly
> >> to save away clobbered files, do you/anyone else have any end goal in
> >> mind here that combines this & that, or some other thing I may not hav=
e
> >> kept up with?
> >
> > I assume you mean the clobbering untracked files by merge/checkout.
> > Those files will be backed up [1] if backup-log is implemented. Even
> > files deleted by "git clean" could be saved but that might go a little
> > too far.
>
> I agree with =C3=86var that it is a very good idea to ask what the
> endgame should look like.  I would have expected that, with an
> introduction of new "ignored but unexpendable" class of file
> (i.e. "precious" here), operations such as merge and checkout will
> be updated to keep them in situations where we would remove "ignored
> and expendable" files (i.e. "ignored").  And it is perfectly OK if
> the very first introduction of the "precious" support begins only
> with a single operation, such as "clean", as long as the end-goal is
> clear.

I think the sticking point is how to deal with the surprise factor and
"precious" will not help at all in this aspect. In my mind there are
three classes

 - total expectation, i know i want git to not touch some files, i
tell git so (e.g. with "precious")

 - surprises sometimes, but in known classes. This is the main use
case of backup log, where I may accidentally do "git commit
-amsomething" after carefully preparing the index. Saving overwritten
files by merge/checkout could be done here as an alternative to
"garbage" attribute.

> I personally do not believe in "backup log"; if we can screw up and
> can fail to stop an operation that must avoid losing info, then we
> can screw up the same way and fail to design and implement "backup"
> to save info before an operation loses it.  If we do a good job in
> supporting "precious" in various operations, we can rely less on
> "backup log" and still be safe ;-)

and this is the third class, something completely unexpected. Yes
backup-log can't help here, but I don't think "precious" can either.
And I have no good proposal for this case.
--=20
Duy
