Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C179320248
	for <e@80x24.org>; Sun, 24 Mar 2019 18:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfCXSJp (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 14:09:45 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43561 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfCXSJp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 14:09:45 -0400
Received: by mail-io1-f68.google.com with SMTP id x3so5795493iol.10
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 11:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oxm7P/avV+sNwQlGGybXV5bAOZu4llivXlSX+5YqAkU=;
        b=sI4ZOtKsd38um5eYi6zoLUjAhnxggdCDdP/T7kzHfEhhoMXOHxXYorUJD62vfCX68q
         SfVD4LjFAgzXYWIBi/9/MEFUNev17HOnC4l8CU5RNY7uV72m2bVscRGkYk1l2nH1Ersh
         bCSuVxM4hNqOZB0ZLWEw6x1Wtaln21kanyuSRPuyGLhgUiEuXFa1h3jjNfeqBhZKPNjt
         s33UWViiX1X+dRSmNj0JxySrWR6qOpEr+eZ9Lsp5ZHiqYJ1VsZA3l2dIGsfUPciLfHQP
         twhTGOx5sOAilgvjNPsaQJQFImewwinOAurJ0Nv1rUvDrYZzPEbxKU4+KWbKr9NUk91Q
         EKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oxm7P/avV+sNwQlGGybXV5bAOZu4llivXlSX+5YqAkU=;
        b=grR0d05v3xhugYAEmPpNncxV4toYSqcbcdFCZbxeadL30n/fckeOpP7pmHmgyFmw31
         ZcrxIY3lRtRbMNwUkqEl0HCVSF5WkWGrwAbEuGtkeHy8BkEmKG4/OQnlXYhf3lRAB1+N
         //L3TZQeYGWQJpmLlaQ14PwKPron3NSQ6RUsCif2hNwZqQl9GL5YSVtHxbd/oOzm8thJ
         tLLyZEdXEzQb0ezAG3qvDpxXgMU/Sa6fbkLgIpjwERZxLUPYLJun+J/sKBI7iD9+o5E4
         R0PjxyVKZ5JH1zWC48JswE4mOJCdhc1WnuKygDMYYDtUPbH4I5YVBy4jKMc3Ypze9O4I
         0gOg==
X-Gm-Message-State: APjAAAV3YsI+aaEbX7rXEo40JaO63XsfpmZbbJw+XrrYOOEATZQfuGdB
        SJGQkK8HtXORyMuKuK7dtfDdZQQbjlwD6bvVlbcy7A==
X-Google-Smtp-Source: APXvYqzcUSG+CmWlLd1yM7xjH5Oj/VGXT4omtsZc5eHsFgH79K9qAhuZZ9K6P7gck1ft5Oia96q5oAb1erQEOjQA2Wg=
X-Received: by 2002:a5e:d717:: with SMTP id v23mr15530113iom.66.1553450983892;
 Sun, 24 Mar 2019 11:09:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190226122829.19178-1-avarab@gmail.com> <20190322232237.13293-1-matheus.bernardino@usp.br>
 <20190322232237.13293-2-matheus.bernardino@usp.br>
In-Reply-To: <20190322232237.13293-2-matheus.bernardino@usp.br>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Sun, 24 Mar 2019 15:09:32 -0300
Message-ID: <CAHd-oW5Yg=dLfLhVmwkOLC=OW=SYRCXCq+pqn=bKNDY=qydfDg@mail.gmail.com>
Subject: Re: [GSoC][PATCH v4 1/7] clone: test for our behavior on odd
 objects/* content
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>,
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

On Fri, Mar 22, 2019 at 8:22 PM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
> From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>
> Add tests for what happens when we perform a local clone on a repo
> containing odd files at .git/object directory, such as symlinks to other
> dirs, or unknown files.
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
> In follow-up commits we'll look at changing some of this behavior, but
> for now let's just assert it as-is so we'll notice what we'll change
> later.
>
> 1. https://public-inbox.org/git/20190226002625.13022-5-avarab@gmail.com/
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> Helped-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>  t/t5604-clone-reference.sh | 116 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 116 insertions(+)
>
> diff --git a/t/t5604-clone-reference.sh b/t/t5604-clone-reference.sh
> index 4320082b1b..708b1a2c66 100755
> --- a/t/t5604-clone-reference.sh
> +++ b/t/t5604-clone-reference.sh
> @@ -221,4 +221,120 @@ test_expect_success 'clone, dissociate from alterna=
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
> +test_expect_success SYMLINKS 'setup repo with manually symlinked dirs an=
d unknown files at objects/' '
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
> +                       rm -f loose-dirs &&
> +                       mv $last_loose a-loose-dir &&
> +                       ln -s a-loose-dir $last_loose &&
> +                       find . -type f | sort >../../../T.objects-files.r=
aw &&
> +                       echo unknown_content> unknown_file
> +               )
> +       ) &&
> +       git -C T fsck &&
> +       git -C T rev-list --all --objects >T.objects
> +'
> +
> +
> +test_expect_success SYMLINKS 'clone repo with symlinked dirs and unknown=
 files at objects/' '
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
files.raw
> +               )
> +       done &&
> +
> +       for raw in $(ls T*.raw)
> +       do
> +               sed -e "s!/..\$!/X!; s!/../!/Y/!; s![0-9a-f]\{38,\}!Z!" \
> +                   -e "/multi-pack-index/d" -e "/commit-graph/d" <$raw >=
$raw.de-sha || return 1

=C3=86var, maybe I'm missing something here, but do we really need the
first sed command ("s!/..\$!/X!") ?


> +       done &&
> +
> +       cat >expected-files <<-EOF &&
> +       ./Y/Z
> +       ./Y/Z
> +       ./a-loose-dir/Z
> +       ./Y/Z
> +       ./info/packs
> +       ./pack/pack-Z.idx
> +       ./pack/pack-Z.pack
> +       ./packs/pack-Z.idx
> +       ./packs/pack-Z.pack
> +       ./unknown_file
> +       EOF
> +
> +       for option in --local --dissociate --no-hardlinks
> +       do
> +               test_cmp expected-files T$option.objects-files.raw.de-sha=
 || return 1
> +       done &&
> +
> +       cat >expected-files <<-EOF &&
> +       ./info/alternates
> +       EOF
> +       test_cmp expected-files T--shared.objects-files.raw
> +'
> +
>  test_done
> --
> 2.20.1
>
