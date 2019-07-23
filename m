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
	by dcvr.yhbt.net (Postfix) with ESMTP id C0C7D1F461
	for <e@80x24.org>; Tue, 23 Jul 2019 03:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730938AbfGWDuk (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jul 2019 23:50:40 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39597 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbfGWDuj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jul 2019 23:50:39 -0400
Received: by mail-io1-f67.google.com with SMTP id f4so78845325ioh.6
        for <git@vger.kernel.org>; Mon, 22 Jul 2019 20:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tA6d2N6ApJAwzTUxPu+uAe8a6Czlg9t2x7Ng3fXSZJs=;
        b=BZ4kr3x774XHuQUb+6TFD6RXWQtMguA48PXLVB6WhtyNi2Be0ZuOqnezRV/o2yEd5z
         rsjMXUYyaDmEDfFluBu9h2iTtsKpDwtkP3emZo9CDx1uhX49yRl4Fwq2A8thTqXr8Rm3
         rzKArbT+ka6cFuNb7RAzzdikHs+Qf/+c0AD1ZwQSQoTXzBE2Y22PYoqlvYMGI0kD3GEs
         2T6tUvPugwuA5LcMyRfKtTSzOnabhyVkPsf/etGeS1aGGyUTAskooMoQcUti+4qW6zzd
         drX3zqcnjNEFG3MAMqk0el3orZtBLZAJA7Ixjf3wnyq73xsLKlIbVw1fqTnrqz3F84zI
         asvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tA6d2N6ApJAwzTUxPu+uAe8a6Czlg9t2x7Ng3fXSZJs=;
        b=rnnWlTjMTAPqC/GOOwDooxC/ztxMNic5LNduBiezdmUo9YDFp3nr+g71XmPZ4phI+L
         Xrh/Oi1/HvU/KXLL+gzuYwfqxnXefIOnG74Dp+7gLFV3Q/qIsvWexURlZtV9jK8SBcZe
         x2+NcFpJt9jx5K3zHylleKdLU4HAAwTjYy0LoYCTXo3cOKDJm2k1E6oE/Mnm9P+0uV0P
         yQqvFvZkwZeMQvfLedJ0f77sLaoBdNA4E8Ip9DIpyHrodpxoJjf/FSQ9GhH9YVJC/G5N
         moARLU4Ff8KEAT/ekjsLhfbycKcPIiYdHUwsQT1OTx4KhjtaBoWqGRtLf1ghScTcwCyh
         yWOQ==
X-Gm-Message-State: APjAAAVbMoVUcQMIIeop98LIYtpqugG2DSA9PwQAFc8KeJ/+sMFS+PhC
        eSy7/q19Nb//zL5mVFA/tmMf1/JxA2zSbQfBSpE=
X-Google-Smtp-Source: APXvYqzCwZ8lPUXXqTwbxJWOCwaSOBC75kF+CSoyLrTicGjFffTPf6Zt7km73AFSTqoUsUmLiPIflMVwOjjBpwlj9dQ=
X-Received: by 2002:a5d:968b:: with SMTP id m11mr21386648ion.16.1563853838500;
 Mon, 22 Jul 2019 20:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190721183115.14985-1-carenas@gmail.com> <nycvar.QRO.7.76.6.1907221340320.47@tvgsbejvaqbjf.bet>
 <87muh57t5r.fsf@evledraar.gmail.com>
In-Reply-To: <87muh57t5r.fsf@evledraar.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 22 Jul 2019 20:50:27 -0700
Message-ID: <CAPUEspg1nUoPApTk5J2r_-9psxTTSC7nRAPw_X9no+2sFVSxAA@mail.gmail.com>
Subject: Re: [PATCH] grep: skip UTF8 checks explicitally
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 22, 2019 at 12:42 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Mon, Jul 22 2019, Johannes Schindelin wrote:
>
> > So I am fine with this patch.
>
> I'm not, not because I dislike the approach. I haven't made up my mind
> yet.

my bad, I should had explained better the regression I was trying to
fix with this patch :

$ git version
git version 2.22.0.709.g102302147b.dirty
$ git grep "Nguy=E1=BB=85n Th=C3=A1i"
.mailmap:Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
fatal: pcre2_match failed with error code -22: UTF-8 error: isolated
byte with 0x80 bit set
$ git grep -I "Nguy=E1=BB=85n Th=C3=A1i"
.mailmap:Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
po/TEAMS:Members:       Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds =
AT gmail.com>
po/vi.po:# Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>, 2=
012.
t/t1302-repo-version.sh:# Copyright (c) 2007 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy
t/t2104-update-index-skip-worktree.sh:# Copyright (c) 2008 Nguy=E1=BB=85n T=
h=C3=A1i Ng=E1=BB=8Dc Duy
fatal: pcre2_match failed with error code -8: UTF-8 error: byte 2 top
bits not 0x80

> I stopped paying attention to this error-with-not-JIT discussion when I
> heard that some other series going into next for Windows fixed that
> issue[1]
>
> But now we have it again in some form? My ab/no-kwset has a lot of tests
> for encodings & locales combined with grep, don't some of those trigger
> this? If so we should make any such failure a test & part of this patch.

I don't have a windows environment to test, and I admit I wasn't
following clearly
the whole conversation but at least in my case, I never got any test
to fail, and I haven't
seen any test with broken UTF-8.

I apologize for not sending a test and will correct that, but I am
concerned that
according to PCRE documentation the behaviour is undefined and therefore th=
e
test might be flacky.

> Right now we don't have the info of whether we're really using the JIT
> or not, but that would be easy to add to grep's --debug mode for use in
> a test prereq.

I would think that extending testtool would be a better option, I have inde=
ed
a patch checking for UTF-8 support using git directly which I hadn't sent j=
ust
because I thought it looked too hacky, but agree it will be nice to have al=
l
those dependencies clear and the corresponding tests otherwise

It is interesting to note that because of the conservative way we enable UT=
F-8
then it will depend on several factors if the problematic code gets trigger=
ed

> As noted in [2] I'd be inclined to go the other way, if we indeed have
> some cases where PCRE skips its own checks does not dying actually give
> us anything useful? I'd think not, so just ignoring the issue seems like
> the wrong thing to do.

we could reenable the checks by moving out of the JIT fast path in pcre so
that pcre2_match is used for all matches (with JIT compiled as an optimizat=
ion)
and that might have the added benefit of solving the PCRE errors when JIT i=
s
broken[1]

$ git version
git version 2.22.0
$ git grep "Nguy=E1=BB=85n Th=C3=A1i"
.mailmap:Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
po/TEAMS:Members:       Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds =
AT gmail.com>
po/vi.po:# Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>, 2=
012.
t/t1302-repo-version.sh:# Copyright (c) 2007 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy
t/t2104-update-index-skip-worktree.sh:# Copyright (c) 2008 Nguy=E1=BB=85n T=
h=C3=A1i Ng=E1=BB=8Dc Duy
t/t7011-skip-worktree-reading.sh:# Copyright (c) 2008 Nguy=E1=BB=85n Th=C3=
=A1i Ng=E1=BB=8Dc Duy
t/t7012-skip-worktree-writing.sh:# Copyright (c) 2008 Nguy=E1=BB=85n Th=C3=
=A1i Ng=E1=BB=8Dc Duy

important to note that at least on my system (macOS 10.14.6) the output of =
all
engines for grep is the same for a UTF-8 pattern match, even if using inval=
id
UTF-8 in the corpus, and I would expect that to be a better indicative
of correctness

FWIW GNU grep (with -P) also ignores UTF-8 errors using the same flag and
even PCRE seems to be going in the other direction with the recent addition
of PCRE2_MATCH_INVALID_UTF[1]

$ od -b int.p
0000000   102 145 154 303 263 156 012 303
$ pcre2grep -U 'Bel=C3=B3' int.p
Bel=C3=B3n

Carlo

[1] https://public-inbox.org/git/20181209230024.43444-1-carenas@gmail.com/
[2] https://lists.exim.org/lurker/message/20190528.141422.2af1e386.gl.html
