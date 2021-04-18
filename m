Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6B5C433B4
	for <git@archiver.kernel.org>; Sun, 18 Apr 2021 07:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27C1661245
	for <git@archiver.kernel.org>; Sun, 18 Apr 2021 07:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhDRHse (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Apr 2021 03:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbhDRHse (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Apr 2021 03:48:34 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC4CC06174A
        for <git@vger.kernel.org>; Sun, 18 Apr 2021 00:48:06 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id g125so3145548iof.3
        for <git@vger.kernel.org>; Sun, 18 Apr 2021 00:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UzCFdma/gF66wpykKBLtkiUupUJPkyNHBxH2XXX0joM=;
        b=JQjva/aI7ZMWcOaNGmP+wdzTHJittg79Wh5Xi6dkLWRNztfxzOv1aFzZkh6zvWBV7L
         SYvosAU7d/DnpTJxmsrKWeWhIjNvNafWPmHvd6mnSwxvOfc53zRBY8RjA53/FCmJNbwz
         Hhihdf1aVUXK7qB5Y8rYZQRmtVNChe57Fymi76Iipp+cVOoce0ud7+F3wqkc5wjrUYPy
         YruuIseWDSeC9z8g2sb5g98OO1fqpPTThCxV+fCw/R2xIIeTzfOXGGFDN3nOie7xIFhG
         uFSMQTL1AgyjBp5M621qFlt05NHilB5Nuya+ZY/uR860Ui4uz7XCKPdU0B5GMQ5K4RDy
         QFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UzCFdma/gF66wpykKBLtkiUupUJPkyNHBxH2XXX0joM=;
        b=Pb6sdUkz/ZqP2HSjiBUuB5DRuxUxHLUkJbu6wqpvOd8VachMnlPsBrcFdYfelF970P
         ZmVIe/y9MEohYwlk6PBwI+cdrcG7039sEqWv9Ti/GCZlOAv0mDjjSsHMCMUeYqfC865z
         zZQaVi6GP4f3/NNB8w7NYxu0Ol7pfZGg4FGgoaGw/oeKbu1YQIKYutq4K9jXb3GbgjDs
         Fr5cj4+9DkpbLoML1ICcSGk/zdBsNx8vWqQtrTJp5tgXHqAcHzKI9xslaWcT00Gac7b3
         /feiHjw/NnJtMYzJqvJKepIVyRqAn6Y1ZSrnFbJLn5/OFjxShxLniONRg0jXQo999tGb
         ideg==
X-Gm-Message-State: AOAM533tNNUGN+nueoLEk5JhbdkxTGLDlZYQwCJ+qXYqG82wQ9UX9bV6
        anbHVFQ6HEORnd/85d64Nga0UTMCgksrusnb8a4=
X-Google-Smtp-Source: ABdhPJwmPN759Y+j3wsa1qc05Pb8HrrMC48yJp33f/so7hFDohJ2ojalFozEUdiUIYJXaedE0BXZ+CwMwWLs9UECOm8=
X-Received: by 2002:a02:708e:: with SMTP id f136mr2964984jac.50.1618732085703;
 Sun, 18 Apr 2021 00:48:05 -0700 (PDT)
MIME-Version: 1.0
References: <pull.913.v10.git.1618562875.gitgitgadget@gmail.com>
 <pull.913.v11.git.1618672417.gitgitgadget@gmail.com> <xmqq5z0kbl8x.fsf@gitster.g>
In-Reply-To: <xmqq5z0kbl8x.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 18 Apr 2021 15:47:54 +0800
Message-ID: <CAOLTT8RKCV+Kpya-_AVjuVGWzs1WtGS8n_+sD0FVzwEpeXGwCw@mail.gmail.com>
Subject: Re: [PATCH v11 0/2] [GSOC] trailer: add new .cmd config option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=8818=E6=97=
=A5=E5=91=A8=E6=97=A5 =E4=B8=8A=E5=8D=886:26=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > In https://lore.kernel.org/git/xmqqv99i4ck2.fsf@gitster.g/ Junio and
> > Christian talked about the problem of using strbuf_replace() to replace
> > $ARG:
> >
> >  1. if the user's script has more than one $ARG, only the first one wil=
l be
> >     replaced, which is incorrected.
> >  2. $ARG is textually replaced without shell syntax, which may result a
> >     broken command when $ARG include some unmatching single quote, very
> >     unsafe.
> >
> > Now pass trailer value as $1 to the trailer command with another
> > trailer.<token>.cmd config, to solve these above problems.
> >
> > We are now writing documents that are more readable and correct than be=
fore.
>
> Here is a good spot to summarize what changed since the previous
> round.
>
> It seems that this now has "exit non-zero to tell the caller not to
> add the trailer for this execuation".  Is that the only change you
> made?
>

Yes, I think the more accurate one should be "exit non-zero to tell
the caller not to add the trailer for this implicit execuation", You also
said below, it may not be so good.

> I was hoping that we'd declare victory with what was in v10 (with
> possibly typos and minor stylistic fixes if needed---I no longer
> remember details), let it go through the usual course of cooking in
> 'next' and merged down to 'master', and then after the dust settles,
> we'd be adding this "by exiting with non-zero status, scripts can
> signal a trailer not to be added for a particular invocation" as a
> new feature, if it turns out to be necessary.
>

Thanks for your and Christian's help this month!

OK, I understand, then I can wait for a while until `trailer_cmd` merge
to master.

> But let's see what's new in this iteration.
>
>
> >       +#!/bin/sh
> >      -+test -n "$1" && git shortlog -s --author=3D"$1" HEAD || true
> >      ++if test "$#" !=3D 1
> >      ++then
> >      ++       exit 1
> >      ++else
> >      ++       test -n "$1" && git shortlog -s --author=3D"$1" HEAD || t=
rue
> >      ++fi
>
> I find this dubious.  Why not
>
>         if test "$#" !=3D 1 || test -z "$1"
>         then
>                 exit 1
>         else
>                 git shortlog -s --author=3D"$1" HEAD
>         fi
>
> That is, if you happened to give an empty string, your version gives
> "" to <value> and returns success, letting a trailer "cnt:" with
> empty value.  Is that what we really want?

If it's the user use `--trailer=3D"cnt:"` instread of command implict runni=
ng,
I think keep it is right.

In fact, it should be said that it is equivalent to exit(0) if the user use
`--trailer=3D"cnt:"`.

>
> >       +$ git config trailer.cnt.key "Commit-count: "
> >       +$ git config trailer.cnt.ifExists "addIfDifferentNeighbor"
> >       +$ git config trailer.cnt.cmd "~/bin/gcount"
> >       +$ git interpret-trailers --trailer=3D"cnt:Junio" --trailer=3D"cn=
t:Linus Torvalds"<<EOF
> >       +> subject
> >      -+>
> >      ++>
> >       +> message
> >      -+>
> >      ++>
> >       +> EOF
> >       +subject
> >       +
> >      @@ Documentation/git-interpret-trailers.txt: subject
> >       +------------
> >       +$ cat ~/bin/glog-grep
> >       +#!/bin/sh
> >      -+test -n "$1" && git log --grep "$1" --pretty=3Dreference -1 || t=
rue
> >      ++if test "$#" !=3D 1
> >      ++then
> >      ++       exit 1
> >      ++else
> >      ++       test -n "$1" && git log --grep "$1" --pretty=3Dreference =
-1 || true
> >      ++fi
>
> Ditto.
>
> >      +        if (capture_command(&cp, &buf, 1024)) {
> >      +-               error(_("running trailer command '%s' failed"), c=
md.buf);
> >      +                strbuf_release(&buf);
> >      +-               result =3D xstrdup("");
> >      ++               if (!conf->cmd || arg) {
> >      ++                       error(_("running trailer command '%s' fai=
led"), cmd.buf);
>
> I am not sure about this part.  If .cmd (the new style) exits with a
> non-zero status for user-supplied --trailer=3D<token>:<value> (because
> it did not like the <value>), is that "running failed"?  The script
> is expected to express yes/no with its exit status, so I would say it
> is not failing, but successfully expressed its displeasure and vetoed
> the particular trailer from getting added.  IOW, "|| arg" part in
> the condition feels iffy to me.
>

Well, you mean we can take advantage of non-zero exits instead of
just removing implicitly executed content. I argee with you, this
place is worth change.

> >      ++                       result =3D xstrdup("");
> >      ++               } else
> >      ++                       result =3D NULL;
> >      +        } else {
> >      +                strbuf_trim(&buf);
> >      +                result =3D strbuf_detach(&buf, NULL);
>
> OK.

Thanks.
--
ZheNing Hu
