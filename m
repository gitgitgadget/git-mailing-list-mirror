Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D5AC3DA78
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 08:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjANIHv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 03:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjANIHs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 03:07:48 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552313AA7
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 00:07:47 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-4d4303c9de6so164342937b3.2
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 00:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=am9kpXX4Ung85EDfiBAOuyhbL7mkpu2KqopOIrOxJHE=;
        b=ONo5qszYKldA8buO+UznOnWMP6ifcgwvKifHMIEpLmH6197eKVQ52zYQBCR8wog8UG
         vtQxua3te8TbFZQR2lQoqpZ0JDPKxFfr+STIQpUf+9Vfclrjmy2rIBozNiWhRQ7fbNQ9
         Ia0tH/pz33Jm1BAS6OymCAQaDUdv0kL+TTCBUYAAXaGGzS0JcIp8QBdhEyoyU4aoulXz
         1hDNJDf445XLzl+06ZywYdA/W6dr6/WIxkwAAfr0zhz9X5Ax6l4nrEq3QudQlqOSnoCr
         Ak+/dZz2gPqA+6ZLolBJS1FB9mXLLRv9frJiDLSfdcgdCrKHxSISjyjNkYTpcQ/SZdXR
         S+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=am9kpXX4Ung85EDfiBAOuyhbL7mkpu2KqopOIrOxJHE=;
        b=x6FN1VcHH1wspwdHUrIQ4dUrGqEnHm2bbctevvrXbkdaNrXNcj1EQ3gQearmtL0jkH
         Ca422mvbG00Q6sZyJOPsS3lx0YCUHs+ZU4BdkV2wQpMGm0b3SsOATrBnIseVaYHHvDBL
         HCJTrPPC9y59b8Jl07rIEhxVCf1KUIu1ZByz+xlCo+GWhc+PKyT43P5sRiwSRF51v8Uq
         3826J8P86o3p0vg5z+RcJMKTuoMV0RCbJoqqpmupE1bRrUdx88bmgZJ7Sn2GCrRJY/KK
         yLnNzBHSm70KgGCqHheYsHU8hArCWywK5SIGxZeJ0KafMX6N9pMNWFd4HgpxifzjDZFC
         6Qtw==
X-Gm-Message-State: AFqh2kovJLIVsZXM2n3kztp/h5pOiH/pM2DKEVSLGAjnvN5T6ldPrzJM
        ipdDstPSwrhNpd07d7yVYnHKhiNdKKwX88jFv2s=
X-Google-Smtp-Source: AMrXdXsDJssH+kVkzGC2r0Ji9MqVnG3i4Z+jBDUntCY0J03b7gZ0D12qnqvigQ8MBtG4HfcaOh3EOgdBOh2OMd30Wtw=
X-Received: by 2002:a0d:c201:0:b0:488:7800:3b03 with SMTP id
 e1-20020a0dc201000000b0048878003b03mr1553326ywd.209.1673683666524; Sat, 14
 Jan 2023 00:07:46 -0800 (PST)
MIME-Version: 1.0
References: <pull.1463.git.1673584914.gitgitgadget@gmail.com> <6bd92c51550c4960ee4de272d3b19451f1e337cc.1673584914.git.gitgitgadget@gmail.com>
In-Reply-To: <6bd92c51550c4960ee4de272d3b19451f1e337cc.1673584914.git.gitgitgadget@gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 14 Jan 2023 16:07:35 +0800
Message-ID: <CAOLTT8TS+8gM0c1WhZJTz22ZV=PzCSTwZTn4jYAgmjoNMVG=Hg@mail.gmail.com>
Subject: Re: [PATCH 1/4] ls-files: add missing documentation for
 --resolve-undo option
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren via GitGitGadget <gitgitgadget@gmail.com> =E4=BA=8E2023=E5=B9=
=B41=E6=9C=8813=E6=97=A5=E5=91=A8=E4=BA=94 12:41=E5=86=99=E9=81=93=EF=BC=9A

>
> From: Elijah Newren <newren@gmail.com>
>
> ls-files' --resolve-undo option has existed ever since 9d9a2f4aba
> ("resolve-undo: basic tests", 2009-12-25), but was never documented.
> However, the option has been referred to in the ls-files manual itself
> ever since ce74de931d ("ls-files: introduce "--format" option",
> 2022-07-23), making its omission a bit jarring.  Document this option.
>

I checked this should be the only option that git ls-files forgot to
document, thanks.

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  Documentation/git-ls-files.txt | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.=
txt
> index 440043cdb8e..cb071583f8b 100644
> --- a/Documentation/git-ls-files.txt
> +++ b/Documentation/git-ls-files.txt
> @@ -12,6 +12,7 @@ SYNOPSIS
>  'git ls-files' [-z] [-t] [-v] [-f]
>                 [-c|--cached] [-d|--deleted] [-o|--others] [-i|--ignored]
>                 [-s|--stage] [-u|--unmerged] [-k|--killed] [-m|--modified=
]
> +               [--resolve-undo]
>                 [--directory [--no-empty-directory]] [--eol]
>                 [--deduplicate]
>                 [-x <pattern>|--exclude=3D<pattern>]
> @@ -77,6 +78,13 @@ OPTIONS
>         to file/directory conflicts for checkout-index to
>         succeed.
>
> +--resolve-undo::
> +       Show files having resolve-undo information in the index
> +       together with their resolve-undo information.  (resolve-undo
> +       information is what is used to implement "git checkout -m
> +       $PATH", i.e. to recreate merge conflicts that were
> +       accidentally resolved)
> +
>  -z::
>         \0 line termination on output and do not quote filenames.
>         See OUTPUT below for more information.
> @@ -136,6 +144,7 @@ a space) at the start of each line:
>         C::     modified/changed
>         K::     to be killed
>         ?::     other
> +       U::     resolve-undo
>  --
>
>  -v::
> --
> gitgitgadget
>
