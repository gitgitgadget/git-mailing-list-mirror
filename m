Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82980C4363D
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 21:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F521206DD
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 21:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="UYpT60x8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725765AbgJBVkq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 17:40:46 -0400
Received: from mout.web.de ([212.227.15.4]:60363 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbgJBVkp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 17:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1601674842;
        bh=i++NfhhnzqMbkB1tzmnB/U2ZUiGHznpFypBQZP/euzM=;
        h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
        b=UYpT60x8hPz9hdGsHQ4Xp9GssFrdJJU3DJT1XwmPIs0Y1/wTjJReIT4Hy7bHmYLxY
         h7dYC3WTN5azpsQFWY6nYE96543j9BsCILWM/UHnaps1gN31AKX2R2MiZsSfbc5HRG
         enVGQpeaihjtg5W22IqVAs5u6euc47dAY1jhvLdw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.158.172]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M40zy-1kfRRg1T9e-00rXld; Fri, 02
 Oct 2020 23:40:42 +0200
Subject: Re: git blame --ignore-rev does not work
To:     Harrison McCullough <mccullough.harrison@gmail.com>,
        git@vger.kernel.org
References: <CAHLeu+x-z4ntmBezcVUWssZrCm03Md6ZR8-ZQmjkeB5YT89caQ@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     Barret Rhoden <brho@google.com>
Message-ID: <d805f025-fbfb-0249-a50c-ff857dc2e29d@web.de>
Date:   Fri, 2 Oct 2020 23:40:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAHLeu+x-z4ntmBezcVUWssZrCm03Md6ZR8-ZQmjkeB5YT89caQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1+eV1SqBDVK5d7i6IrF6Xc2YaPVQNk2fdTGT6PiWj+/y4asLXlK
 mUrRO65zEV8mK1qqBjn2p7nqqcnj3OMsVYjiK0Hq2MQsvg5crevDLPjqM1jktXBkZ02i0sx
 FvNzzBHbAH+NA/2TFb1u6BsxfwSle+QB4IPGW/thmFtI0GxXz0yl0Z2btinBAsDpbXtXyUs
 P8z3lRpzKKVajAORDZ/KA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cwDbZSfzGaw=:1Y4MD2b4vWxfgiW/zDrvRm
 kd1lazm4w6q/zu0AAlk3ZYnYFES7xT0qmlYAisrN0lgmms1/SWo6H5rkTC8aMGJ6/8dDD6jn0
 kFLSfTXikQz6HTeOJZVWRsBGFrBjHP+M4qCmutl9d1WxNIrIxdf8hntERouz1fliagxTwGr7u
 7o3gE2X5tCGs70hNEoO+7CWT3wbAsRasMDjSn3w63HxG5AcG+Baf3vH/PbNugMl+RGOaFGs2d
 DUyPM2a4ZqQk+4FeL3qQ53GHAXkV8o+qfhjqKMRkITTeeJAt8fVfE7mtPEUYqW5oThweLnWAV
 X39m74CRFSIJiQ60+p4LFLfNd9nCy884TZVQVxBKkXmIjZuJ18Spu5TXRfI21vnXe/VooRTuX
 BRpRYKdp0E2klcNMnqg2Z5o0JSNygxgiNS89RIaehTCqK8z6KtucXMcUXqQHPlat6dJ5Zx8F0
 23MDpErKiOlMtpZcyTEJGWb8J4LSzuDSLQjzJOaC8k7388lDprVoPEObaztdas6/khDhN6CC5
 lfXSaHo5+IYBYtOiYcKgFIKgvP0/APphqPcP5k7xdr2EYbcrpDf13s4zwR3iwA+UAMuONTAbY
 M332Ychd78wACm9Tm9qB/gueKQbr/C+VtYiC0lqsdwsrZLahbH5ZQyeT9f6XrrZpTinOXU/sO
 0Ix1QQvY7n9rQFVnXqz/702MAUMLPCXYQMx7wk5hAJ4rZnK8QNcts3LxG35AeyIS/gfgDqRiM
 PfK3+eGuSvJqk3moP9jCb9PkEaDus+T8NSNKg7w13pozxIQeOtYjIQzRf2GaWW4a61jLbT3cZ
 lo83vzRHd63zdN3Nzq74MyjJDN9RVMa0QSuM1+pGTqCGvKd0CUpjKetCdrNn469V8KXAuyUeV
 X8LzcfODBTA6wr/ryk0T087sVA8oAhgJNWDDSYQIINGLmTbeTlwdZts3VgE0MBeJ9HaCdl8Ar
 eDucA/87INSt/+W5kQQEfd79x4inTqG4x9Vt5fKv+togOcsGLx/iJuPa0FvZv7bj79cn+n3gL
 lfdJUMsBPzwmGKtalQrKhD3Eo/BU9LLBLi5Ojraz+sdSgM9eLzm3TwVXsRiBIJ/QahdJGMucC
 OJQb9/NOHux073uFpURW9JF2UXZ9THb4k0T8uQSR58IXyeHEtNt9xoaPOAFV//DyTOC4Xqbky
 eSRCnKgAnmquEDkDDW19WN8ocC9PSg/KtD5vlxZ+cp4Lgah/q+RXmy4lDs9HG+yGKqtbhnmEF
 /dvfYUBfv5pK7dPX+
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.09.20 um 23:15 schrieb Harrison McCullough:
> What did you do before the bug happened?
>
> 1. Commit changes to <FILE>
> 2. Observe that this commit has a hash of <HASH>, e.g. through git rev-p=
arse
>    HEAD
> 3. Run `echo <HASH> > .git-blame-ignore-revs`
> 4. Run `git config blame.ignoreRevsFile .git-blame-ignore-revs`
> 5. Run `git blame <FILE>`
> 6. Run `git blame --ignore-revs-file=3D.git-blame-ignore-revs <FILE>`
> 7. Run `git blame --ignore-rev=3D<HASH> <FILE>`
>
>
> What did you expect to happen? (Expected behavior)
>
> The three git blame commands should attribute each line of the source fi=
le to a
> commit, but none of those commits should be the one specified by <HASH>.
>
>
> What happened instead? (Actual behavior)
>
> All three git blame commands included lines attributed to <HASH>.
>
>
> What's different between what you expected and what actually happened?
>
> The commit identified by <HASH> was not ignored.

Well, your expectation sounds reasonable, but apparently it's not that
easy.  Consider this sentence from the description of --ignore-rev on
the manpage of git blame:

    If the `blame.markUnblamableLines` config option is set, then those
    lines touched by an ignored commit that we could not attribute to
    another revision are marked with a '*'.

So some commits just cannot be ignored by the current version of git
blame.  The commit message of ae3f36dea1 (blame: add the ability to
ignore commits and their changes, 2019-05-15), which introduced that
feature, mentions an example.  And this silly script finds that 365 of
the 765 commits blamed for Git's own Makefile are examples as well:

  file=3DMakefile
  rev=3Dv2.28.0
  hashes=3D$(git blame "$rev" "$file" | awk '{print $1}' | sort -u)
  echo "$hashes" | wc -l
  for hash in $hashes
  do
     if git blame --ignore-rev=3D$hash "$rev" "$file" | grep -q "^$hash "
     then
       echo $hash
     fi
  done | wc -l

I don't know if these revisions are not ignored due to bugs or because
the feature just isn't strong enough, yet, but I would expect your
particular case to be represented by at least one of these...

> Anything else you want to add:
>
> I tried this in a brand new repository and everything worked as expected=
. I do
> not know why it is only failing in this repository. It is a large reposi=
tory I
> use for work, but I'm using the same version of Git in both places.

... so this might not be a problem, as finding public examples seems
to be easy.

>
>
> [System Info]
> git version:
> git version 2.28.0
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Darwin 18.7.0 Darwin Kernel Version 18.7.0: Mon Apr 27 20:09:39
> PDT 2020; root:xnu-4903.278.35~1/RELEASE_X86_64 x86_64
> compiler info: clang: 11.0.0 (clang-1100.0.33.17)
> libc info: no libc information available
> $SHELL (typically, interactive shell): /usr/local/bin/bash
>
>
> [Enabled Hooks]
> post-commit
> post-checkout
> post-merge
> pre-push
>

