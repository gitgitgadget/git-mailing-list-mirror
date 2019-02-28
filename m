Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0E9E20248
	for <e@80x24.org>; Thu, 28 Feb 2019 21:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfB1VTd (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 16:19:33 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:42026 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbfB1VTc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Feb 2019 16:19:32 -0500
Received: by mail-io1-f66.google.com with SMTP id p196so17799663iod.9
        for <git@vger.kernel.org>; Thu, 28 Feb 2019 13:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4kRIcLdhpTkSw+E1XC9Sh4IW1UKXfaZ5Upy7s1/ZNiE=;
        b=dnb7oANpOOMz+JddrdTW35oN01ZUWhD1dH858LcTw0MvZ0J3y9hYDZPe/luBnlto5X
         45Fr6ffFz9bHQ9p3RpeBXWFG0+kKwb3XFdRZpEiXZ2KSP6Zws8xk+zBnJhmD+MH7JpXt
         JD45+io3890ApBRdNP8krgwuWhEiVfaxfiUcQRD+/K9C93ifwMfgsIvKesV7Y/lneq87
         SbSlL8amLY/44dvnJlED2AWB7TtGGwGLUkZg4yiO7O/M54LV59vASQ3WBPUR5/V/ZRAQ
         8n4bCAjkP5fnWNXkctgPmqU1/WShFJzWka7ubGDqqpIqTnKten/S+QXxqVa1yo0ZbXzb
         mB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4kRIcLdhpTkSw+E1XC9Sh4IW1UKXfaZ5Upy7s1/ZNiE=;
        b=t7T7T7P9rKw5GD+jRUuEEOByW19XAWISmzrEHNMJXORlDj5O9tIEjBjtEJaJA5dmGo
         NYcu3tq7jtkrS3Y8AzWBOjPwQYP+91DDK6oKZWgGNA5y3EbmEz4127YkM2uCmUmXuyJn
         BKdaf00N9J3jf20uWRjOk1h494bU/O6Ml6r62yESUulawiZcVQXBiV19owZ+/oWb3wIg
         UQe9MzhfxvgqhmlJBMw60Ek7fB+7v7GiylyA0R16LMDuF5GnuyN08Vcty16h6KAGWGEM
         GC61VI3t6z62Gp2zShG1c3bSTWA/sF5DQ7HTVeBMtYgymGw1v9X4TDD1BVFTYuDps3AA
         cCxA==
X-Gm-Message-State: APjAAAXqeaDOfjT/nFlHAM7czu32cr5BL0TXWFJYezi7uxMh5NK12AyK
        jIgre4vPEXCNJMvhxMm3QE4da9EDfaa3MlIBXfVf4z17xUM=
X-Google-Smtp-Source: APXvYqwSZLNT1vM/5SWMdiD1HZvLmJtQa4Ij4R5ypUpPMXhuSUK9oyYwz9gTHKsPijPMtKecS8vtfsigkOyq0GwMP7k=
X-Received: by 2002:a6b:c30d:: with SMTP id t13mr1009850iof.66.1551388771153;
 Thu, 28 Feb 2019 13:19:31 -0800 (PST)
MIME-Version: 1.0
References: <20190226051804.10631-1-matheus.bernardino@usp.br> <20190226122829.19178-2-avarab@gmail.com>
In-Reply-To: <20190226122829.19178-2-avarab@gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Thu, 28 Feb 2019 18:19:19 -0300
Message-ID: <CAHd-oW71N94vBvN4wYQVzXyUZjvVs3Ca9tM3VUEuqB66YNGDtA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/5] clone: test for our behavior on odd objects/* content
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, =C3=86var

I'm finishing the required changes in this series to send a v4, but
when submitting to travis ci, I got some errors on the
t5604-clone-reference test:
https://travis-ci.org/MatheusBernardino/git/builds/500007587

Do you have any idea why?

Best,
Matheus Tavares

On Tue, Feb 26, 2019 at 9:28 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> Add tests for what happens when we locally clone .git/objects
> directories where some of the loose objects or packs are symlinked, or
> when when there's unknown files there.
>
> I'm bending over backwards here to avoid a SHA1 dependency. See [1]
> for an earlier and simpler version that hardcoded a SHA-1s.
>
> This behavior has been the same for a *long* time, but hasn't been
> tested for.
>
> There's a good post-hoc argument to be made for copying over unknown
> things, e.g. I'd like a git version that doesn't know about the
> commit-graph to copy it under "clone --local" so a newer git version
> can make use of it.
>
> But the behavior showed where with symlinks seems pretty
> random. E.g. if "pack" is a symlink we end up with two copies of the
> contents, and only transfer some symlinks as-is.
>
> In follow-up commits we'll look at changing some of this behavior, but
> for now let's just assert it as-is so we'll notice what we'll change
> later.
>
> 1. https://public-inbox.org/git/20190226002625.13022-5-avarab@gmail.com/
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  t/t5604-clone-reference.sh | 142 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 142 insertions(+)
>
> diff --git a/t/t5604-clone-reference.sh b/t/t5604-clone-reference.sh
> index 4320082b1b..cb0dc22d14 100755
> --- a/t/t5604-clone-reference.sh
> +++ b/t/t5604-clone-reference.sh
> @@ -221,4 +221,146 @@ test_expect_success 'clone, dissociate from alterna=
tes' '
>         ( cd C && git fsck )
>  '
>
> +test_expect_success 'setup repo with garbage in objects/*' '
> +       git init S &&
> +       (
> +               cd S &&
> +               test_commit A &&
> +
> +               cd .git/objects &&
> +               >.some-hidden-file &&
> +               >some-file &&
> +               mkdir .some-hidden-dir &&
> +               >.some-hidden-dir/some-file &&
> +               >.some-hidden-dir/.some-dot-file &&
> +               mkdir some-dir &&
> +               >some-dir/some-file &&
> +               >some-dir/.some-dot-file
> +       )
> +'
> +
> +test_expect_success 'clone a repo with garbage in objects/*' '
> +       for option in --local --no-hardlinks --shared --dissociate
> +       do
> +               git clone $option S S$option || return 1 &&
> +               git -C S$option fsck || return 1
> +       done &&
> +       find S-* -name "*some*" | sort >actual &&
> +       cat >expected <<-EOF &&
> +       S--dissociate/.git/objects/.some-hidden-file
> +       S--dissociate/.git/objects/some-dir
> +       S--dissociate/.git/objects/some-dir/.some-dot-file
> +       S--dissociate/.git/objects/some-dir/some-file
> +       S--dissociate/.git/objects/some-file
> +       S--local/.git/objects/.some-hidden-file
> +       S--local/.git/objects/some-dir
> +       S--local/.git/objects/some-dir/.some-dot-file
> +       S--local/.git/objects/some-dir/some-file
> +       S--local/.git/objects/some-file
> +       S--no-hardlinks/.git/objects/.some-hidden-file
> +       S--no-hardlinks/.git/objects/some-dir
> +       S--no-hardlinks/.git/objects/some-dir/.some-dot-file
> +       S--no-hardlinks/.git/objects/some-dir/some-file
> +       S--no-hardlinks/.git/objects/some-file
> +       EOF
> +       test_cmp expected actual
> +'
> +
> +test_expect_success SYMLINKS 'setup repo with manually symlinked objects=
/*' '
> +       git init T &&
> +       (
> +               cd T &&
> +               test_commit A &&
> +               git gc &&
> +               (
> +                       cd .git/objects &&
> +                       mv pack packs &&
> +                       ln -s packs pack
> +               ) &&
> +               test_commit B &&
> +               (
> +                       cd .git/objects &&
> +                       find ?? -type d >loose-dirs &&
> +                       last_loose=3D$(tail -n 1 loose-dirs) &&
> +                       mv $last_loose a-loose-dir &&
> +                       ln -s a-loose-dir $last_loose &&
> +                       first_loose=3D$(head -n 1 loose-dirs) &&
> +                       (
> +                               cd $first_loose &&
> +                               obj=3D$(ls *) &&
> +                               mv $obj ../an-object &&
> +                               ln -s ../an-object $obj
> +                       ) &&
> +                       find . -type f | sort >../../../T.objects-files.r=
aw &&
> +                       find . -type l | sort >../../../T.objects-links.r=
aw
> +               )
> +       ) &&
> +       git -C T fsck &&
> +       git -C T rev-list --all --objects >T.objects
> +'
> +
> +
> +test_expect_success SYMLINKS 'clone repo with symlinked objects/*' '
> +       for option in --local --no-hardlinks --shared --dissociate
> +       do
> +               git clone $option T T$option || return 1 &&
> +               git -C T$option fsck || return 1 &&
> +               git -C T$option rev-list --all --objects >T$option.object=
s &&
> +               test_cmp T.objects T$option.objects &&
> +               (
> +                       cd T$option/.git/objects &&
> +                       find . -type f | sort >../../../T$option.objects-=
files.raw &&
> +                       find . -type l | sort >../../../T$option.objects-=
links.raw
> +               )
> +       done &&
> +
> +       for raw in $(ls T*.raw)
> +       do
> +               sed -e "s!/..\$!/X!; s!/../!/Y/!; s![0-9a-f]\{38,\}!Z!" <=
$raw >$raw.de-sha || return 1
> +       done &&
> +
> +       cat >expected-files <<-EOF &&
> +       ./Y/Z
> +       ./a-loose-dir/Z
> +       ./an-object
> +       ./Y/Z
> +       ./info/packs
> +       ./loose-dirs
> +       ./pack/pack-Z.idx
> +       ./pack/pack-Z.pack
> +       ./packs/pack-Z.idx
> +       ./packs/pack-Z.pack
> +       EOF
> +       cat >expected-links <<-EOF &&
> +       ./Y/Z
> +       EOF
> +       for option in --local --dissociate
> +       do
> +               test_cmp expected-files T$option.objects-files.raw.de-sha=
 || return 1 &&
> +               test_cmp expected-links T$option.objects-links.raw.de-sha=
 || return 1
> +       done &&
> +
> +       cat >expected-files <<-EOF &&
> +       ./Y/Z
> +       ./Y/Z
> +       ./a-loose-dir/Z
> +       ./an-object
> +       ./Y/Z
> +       ./info/packs
> +       ./loose-dirs
> +       ./pack/pack-Z.idx
> +       ./pack/pack-Z.pack
> +       ./packs/pack-Z.idx
> +       ./packs/pack-Z.pack
> +       EOF
> +       test_cmp expected-files T--no-hardlinks.objects-files.raw.de-sha =
&&
> +       test_must_be_empty T--no-hardlinks.objects-links.raw.de-sha &&
> +
> +       cat >expected-files <<-EOF &&
> +       ./info/alternates
> +       EOF
> +       test_cmp expected-files T--shared.objects-files.raw &&
> +       test_must_be_empty T--shared.objects-links.raw
> +'
> +
>  test_done
> --
> 2.21.0.rc2.261.ga7da99ff1b
>
