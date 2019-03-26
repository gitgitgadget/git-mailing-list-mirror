Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E6A520248
	for <e@80x24.org>; Tue, 26 Mar 2019 19:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732232AbfCZTnh (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 15:43:37 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:56022 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730449AbfCZTng (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 15:43:36 -0400
Received: by mail-it1-f194.google.com with SMTP id z126so21647701itd.5
        for <git@vger.kernel.org>; Tue, 26 Mar 2019 12:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5t9yFjQ8B11USEaKroAr+5Sg3UAXP6ts+Zd09VTq/BY=;
        b=n9C1ebzWUh7IKulbNrzHbv8nrD+klV9am7covg0GxTfUKckhTcozPOvPLav9S8DXDn
         AdtSNg9Vva7/qA6FBUpSDF1PKQ+TsHx4JIiKn2k93wsrL3ZPjfBIRTQ5FFiCVMHRMsAc
         ugTcznkon4ZMZLJrQKLMxfEdQFRNSBYlxvWkhUDoqkGhxNQ5DGAtYHCudTjyG+VDtbXE
         KjX7AimkMuEkNpyXEzsckd3hk08QJAy5m6rEI+tUMJ/rAKlBFXIU7X4JaePrI72gfr4x
         ZuLN7O5GMz8lBg95CWswGDde2g/lY697yysSWuvIauj+b9Jb5w387O/QNpIW7cEoXxWP
         fbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5t9yFjQ8B11USEaKroAr+5Sg3UAXP6ts+Zd09VTq/BY=;
        b=lRTV/KXtLDlM8sgMRiGb2X6K4DjYTdJmn4BbUYenBVf98lNeo4AW110KvaHmPVr7N0
         FcWGxMDYkkrB40/keMvsvFSLaavp0JTQNFywsdYRSPdxfO4J2cnOkH9uFDgKn6NzYpwt
         oX/x6NLoOLYivKq57EL7Bbi5bBiKWySNz0iAtGgHClp3fY0w9Q8YTJyvoSnRtujrwQrM
         khEIvYSfJISqgVHL7lWQ87dXF7Sl/EXs6mCKPfiC7AzQdWA+XcOCttQafvzjm5tUbhJI
         PbgKDuV7DNorr2RRVNTX9vCQfKVLiWc9Z4BNvHHvPB0xeGImTO1ucRQtXHQRA1Oe7bJm
         25Uw==
X-Gm-Message-State: APjAAAWIkDzCNL/FNPv6+FnuMNXDKWduy9BUsDHt4/eNXF1ivJwhzgz6
        zTDYTmLqiy2kNryVYHkPWga1Mxu0/3nMgpGsKZ4zFQ==
X-Google-Smtp-Source: APXvYqy9Z2wSpv4gHAkLsEWgSeKqyRdSLKX9n1L31q1FfcsnFfnQMgIEuFFZX07aJxxKmKbctdaIb/1GXiJ0cZ0a8Ak=
X-Received: by 2002:a24:e4c6:: with SMTP id o189mr521868ith.4.1553629415150;
 Tue, 26 Mar 2019 12:43:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190226122829.19178-1-avarab@gmail.com> <20190322232237.13293-1-matheus.bernardino@usp.br>
 <20190322232237.13293-2-matheus.bernardino@usp.br> <20190324205624.GJ22459@szeder.dev>
In-Reply-To: <20190324205624.GJ22459@szeder.dev>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 26 Mar 2019 16:43:24 -0300
Message-ID: <CAHd-oW4qZWhHJVnnOpdUnN1J9r9V=LZ+dEdceWD=o==OwTwFRg@mail.gmail.com>
Subject: Re: [GSoC][PATCH v4 1/7] clone: test for our behavior on odd
 objects/* content
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Kernel USP <kernel-usp@googlegroups.com>,
        Alex Riesen <raa.lkml@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 24, 2019 at 5:56 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> On Fri, Mar 22, 2019 at 08:22:31PM -0300, Matheus Tavares wrote:
> > From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> >
> > Add tests for what happens when we perform a local clone on a repo
> > containing odd files at .git/object directory, such as symlinks to othe=
r
> > dirs, or unknown files.
> >
> > I'm bending over backwards here to avoid a SHA1 dependency. See [1]
>
> s/SHA1/SHA-1/
>

Thanks, nice catch.

> > for an earlier and simpler version that hardcoded a SHA-1s.
>
> s/SHA-1s/SHA-1/ or s/a SHA-1s/SHA-1s/, depending on what you consider
> multiple occurrances of the same SHA-1.
>

Yes, I think it should be just "SHA-1s". Thanks.

> > This behavior has been the same for a *long* time, but hasn't been
> > tested for.
> >
> > There's a good post-hoc argument to be made for copying over unknown
> > things, e.g. I'd like a git version that doesn't know about the
> > commit-graph to copy it under "clone --local" so a newer git version
> > can make use of it.
> >
> > In follow-up commits we'll look at changing some of this behavior, but
> > for now let's just assert it as-is so we'll notice what we'll change
> > later.
> >
> > 1. https://public-inbox.org/git/20190226002625.13022-5-avarab@gmail.com=
/
> >
> > Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> > Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> > Helped-by: Matheus Tavares <matheus.bernardino@usp.br>
>
>
> > +test_expect_success SYMLINKS 'setup repo with manually symlinked dirs =
and unknown files at objects/' '
> > +     git init T &&
> > +     (
> > +             cd T &&
> > +             test_commit A &&
> > +             git gc &&
> > +             (
> > +                     cd .git/objects &&
> > +                     mv pack packs &&
> > +                     ln -s packs pack
> > +             ) &&
> > +             test_commit B &&
> > +             (
> > +                     cd .git/objects &&
> > +                     find ?? -type d >loose-dirs &&
> > +                     last_loose=3D$(tail -n 1 loose-dirs) &&
> > +                     rm -f loose-dirs &&
> > +                     mv $last_loose a-loose-dir &&
> > +                     ln -s a-loose-dir $last_loose &&
> > +                     find . -type f | sort >../../../T.objects-files.r=
aw &&
> > +                     echo unknown_content> unknown_file
> > +             )
>
> Please drop these inner subshells.  They are unnecessary, because the
> outer subshell alone is sufficient to ensure that the test script
> returns to the original directory if one of the commands were to fail.

Ok!

> > +     ) &&
> > +     git -C T fsck &&
> > +     git -C T rev-list --all --objects >T.objects
> > +'
> > +
> > +
> > +test_expect_success SYMLINKS 'clone repo with symlinked dirs and unkno=
wn files at objects/' '
> > +     for option in --local --no-hardlinks --shared --dissociate
> > +     do
> > +             git clone $option T T$option || return 1 &&
> > +             git -C T$option fsck || return 1 &&
> > +             git -C T$option rev-list --all --objects >T$option.object=
s &&
> > +             test_cmp T.objects T$option.objects &&
> > +             (
> > +                     cd T$option/.git/objects &&
> > +                     find . -type f | sort >../../../T$option.objects-=
files.raw
> > +             )
>
> Nit: this might be a bit easier on the eyes when written as
>
>   (
>         cd T$option/.git/objects &&
>         find . -type f
>   ) | sort >T$option.objects-files.raw
>
> because it would avoid that '../../../'.

Sounds good, but in the next patch of this series, another 'find'
statement will be added inside this subshell, so I think that change
is not really possible, unfortunately.

> > +     done &&
> > +
> > +     for raw in $(ls T*.raw)
> > +     do
> > +             sed -e "s!/..\$!/X!; s!/../!/Y/!; s![0-9a-f]\{38,\}!Z!" \
> > +                 -e "/multi-pack-index/d" -e "/commit-graph/d" <$raw >=
$raw.de-sha || return 1
> > +     done &&
> > +
> > +     cat >expected-files <<-EOF &&
> > +     ./Y/Z
> > +     ./Y/Z
> > +     ./a-loose-dir/Z
> > +     ./Y/Z
> > +     ./info/packs
> > +     ./pack/pack-Z.idx
> > +     ./pack/pack-Z.pack
> > +     ./packs/pack-Z.idx
> > +     ./packs/pack-Z.pack
> > +     ./unknown_file
> > +     EOF
> > +
> > +     for option in --local --dissociate --no-hardlinks
> > +     do
> > +             test_cmp expected-files T$option.objects-files.raw.de-sha=
 || return 1
> > +     done &&
> > +
> > +     cat >expected-files <<-EOF &&
> > +     ./info/alternates
> > +     EOF
>
> Perhaps
>
>   echo ./info/alternates >expected-files

Indeed, much simpler. Thanks.

> > +     test_cmp expected-files T--shared.objects-files.raw
> > +'
> > +
> >  test_done
> > --
> > 2.20.1
> >
