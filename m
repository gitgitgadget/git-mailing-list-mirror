Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01E291F462
	for <e@80x24.org>; Tue, 21 May 2019 11:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfEULqt (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 07:46:49 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:52810 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfEULqs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 07:46:48 -0400
Received: by mail-it1-f195.google.com with SMTP id t184so4416511itf.2
        for <git@vger.kernel.org>; Tue, 21 May 2019 04:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=q/9F+G+ySK618OuPxRQroKdTyhZhfsCmlPogpieHVSU=;
        b=fhHEwAivEzBpiapds3X2WUBOWxDzVou7ZfqbjnSO+iNKmY8C9BGLmExpdRWarykrlH
         ix2SX+jkNx+nrgvVWx6Dctjr/lcDVzpvObTW56PqsIdBovlP/jZIx82MK4k+r2et2cnE
         OYYZ1MfHCCoa4dOt2PPywLfDBChE8lXUNs8MTc/aPPwunFBNaFzO3wQoryvf2jyzAYIo
         TfVksTiWMtpgRNGxpoKZWResTVsGUTQO35BEZFCAEN3cDNOaFFiXs152NUZ+0JPWjHLq
         eLvk5BB3j7N8MX89UnfnU0b3gFE11CEkmeCb1UEIUjzS0PptLPDJrYN7w5XRxiJHLNrr
         o04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=q/9F+G+ySK618OuPxRQroKdTyhZhfsCmlPogpieHVSU=;
        b=Tjuwf2MZQ/T+8tQCadgvq+6swiFaClJ7FxskWftneXppLlpbje7/cutTkXE3YrH7bZ
         OoKIqAZswBju2Qa6UxN/+aCB2alnL0/8tCN11ma+9Tc5CPGFkZ70C0xj6yWD3EfxUcfo
         fo+t58508XX9yz1Q9m4tLBdEcQyCrtz6VyG+Hz1dcyH8tYbNmMWlM5wCz9q6rMddGyYA
         o1SSR+Fa8wbhdsHXQ2oGhSxUr5xO0o2oNau8Vg6MM+Q+0NoYOkEXwTiImTXfoszW/ApC
         fwE4fd+HCVtCnPS5iXyyz0huRdsuyCZaNfn2vH1zrNHb2/R0Tp4odXMqiIxOeX8Ep66J
         cd6g==
X-Gm-Message-State: APjAAAV8kFSZRXGMpr2YADGqDaUI2qUD2E/vNH6l2Tgw2iyZHfyAEiAG
        Sul9Ajdq4AYY2mWL+L5yfoukU4Uj5j2Nza4nRXo=
X-Google-Smtp-Source: APXvYqwrHdfmcP17Jpwov154D3KgvxwbtWoDq8WH6wuZw+ompNVlC6WNr4ZEpmpe4zEHxuraTjIizLyShC+wUVmuHXE=
X-Received: by 2002:a02:3002:: with SMTP id q2mr12860492jaq.30.1558439207602;
 Tue, 21 May 2019 04:46:47 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq36la24t1.fsf@gitster-ct.c.googlers.com> <CAGyf7-F-d-n39fJmjYc_2rjqQa4d7PFCx63LwW3m7PFetEgzEw@mail.gmail.com>
 <87ef4svk1k.fsf@evledraar.gmail.com> <CACsJy8AdhQH25NeDKKdSBctXcU=oyGcJ05XaNryj22GUQH5Btw@mail.gmail.com>
 <CACsJy8AU7=N_npgTuLES3r8VBMw+6kS+7D-B5MY0eghdD8O=AQ@mail.gmail.com> <87blzwuk1t.fsf@evledraar.gmail.com>
In-Reply-To: <87blzwuk1t.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 21 May 2019 18:46:21 +0700
Message-ID: <CACsJy8CfGnZgn1VjaEQYeRRa3BOT9vqcp73RcVbjHBOw3R1vMQ@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.22.0-rc1
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Bryan Turner <bturner@atlassian.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 21, 2019 at 6:24 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Tue, May 21 2019, Duy Nguyen wrote:
>
> > (dropping lkml and git-packagers)
> >
> > On Tue, May 21, 2019 at 3:31 PM Duy Nguyen <pclouds@gmail.com> wrote:
> >> > The bug there is that the old opt_arg() code would be torelant to em=
pty
> >> > values. I noticed a similar change the other day with the --abbrev
> >> > option, but didn't think it was worth noting. Maybe it's a more gene=
ral
> >> > problem, in both cases we had a blindspot in our tests.
> >>
> >> Hmm.. this one is different (at least it does not use opt_arg()). But
> >> I'll double check.
> >
> > What is wrong with --abbrev? The code is simple enough for me to just
> > compare line by line, and the only difference I can see is that if you
> > pass --abbrev=3D12a, then the old code accepts "12" while the new one
> > rejects.
> >
> > Granted, I said "no behavior change", but this may be pushing the
> > limits a bit. But maybe you're seeing something else?
> >
> > Note that "git diff --abbrev" still uses the old, but different,
> > parser in revision.c. parse_options() is only used for --abbrev with
> > --no-index.
>
> Before d877418390 ("diff-parseopt: convert --[no-]abbrev", 2019-03-24):
>
>     $ ~/g/git/git --exec-path=3D$PWD diff --raw --abbrev=3D --no-index {c=
olor,column}.c
>     :100644 100644 00000 00000 M    color.c
>
> after:
>
>     $ ~/g/git/git --exec-path=3D$PWD diff --raw --abbrev=3D --no-index {c=
olor,column}.c
>     :100644 100644 0000000000000000000000000000000000000000 0000000000000=
000000000000000000000000000 M      color.c
>
> This patch brings back the old behavior, but will break tests for
> describe/branch (we have no tests on this for the diff behavior, but I'm
> hoping to re-submit those after 2.22):
>
>     diff --git a/parse-options-cb.c b/parse-options-cb.c
>     index 6e2e8d6273..0a3c8bd565 100644
>     --- a/parse-options-cb.c
>     +++ b/parse-options-cb.c
>     @@ -23 +23 @@ int parse_opt_abbrev_cb(const struct option *opt, const=
 char *arg, int unset)
>     -               if (v && v < MINIMUM_ABBREV)
>     +               if (v < MINIMUM_ABBREV)
>
> I discovered this the other day because I was rebasing my "relative
> abbrev" series and some of the tests I'd added here failed:
> https://public-inbox.org/git/20180608224136.20220-5-avarab@gmail.com/
>
> Now, in that case I think the change is fine, and is what we should do,
> and when I found this I couldn't imagine anyone relied on this
> empty-value '--abbrev=3D' behavior so I didn't bother to send an E-Mail
> about it. It also brought diff.c in line with what we did with
> empty-value '--abbrev=3D' elsewhere.

OK.

> I'm just noting it because it might be indicative of some logic errors
> in this conversion for other options, e.g. argument-less -U, and since
> we didn't test for (or --abbrev=3D) perhaps we have other blind spots.
> such a case.
>
> Unrelated to any potential bugs in yoeur changes, I just noticed that we
> should probably do this too:
>
>     diff --git a/parse-options-cb.c b/parse-options-cb.c
>     index 4b95d04a37..1216a71f4b 100644
>     --- a/parse-options-cb.c
>     +++ b/parse-options-cb.c
>     @@ -16,6 +16,9 @@ int parse_opt_abbrev_cb(const struct option *opt, c=
onst char *arg, int unset)
>             if (!arg) {
>                     v =3D unset ? 0 : DEFAULT_ABBREV;
>             } else {
>     +               if (!*arg)
>     +                       return error(_("option `%s' expects a value")=
,
>     +                                    opt->long_name);
>                     v =3D strtol(arg, (char **)&arg, 10);
>                     if (*arg)
>                             return error(_("option `%s' expects a numeric=
al value"),
>
> I.e. we support and document --abbrev=3D0, but now we conflate it with
> --abbrev=3D for no good reason.

This is funny because the old --inter-hunk-context=3D (no argument)
would error out but the new one does not, and I'm making a change to
make all OPT_INTEGER (which is also the new --inter-hunk-context) to
error out to avoid regression. I'm not sure if we should do the same
for --abbrev now, but since we're already half way there, I'll include
this too and see how people react.
--=20
Duy
