Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B486B1F404
	for <e@80x24.org>; Sat, 17 Mar 2018 20:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751463AbeCQU31 (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 16:29:27 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:39531 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751236AbeCQU31 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 16:29:27 -0400
Received: by mail-it0-f51.google.com with SMTP id e98-v6so5936866itd.4
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 13:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UxupZ19T9+gsiBZnvnrzKxqlMOJ7hh4/eBxuoKeFsrQ=;
        b=poQnsaGXnw+Wtf2VmIxIyHxKRhsZNTvBJlnyEdB0udxUhtSy0X8q9OWiygmJS2GrA2
         Px+Enga20Bu/uodsqSKWZq/8wF4TZ8O4vwijeD8LXyLM1EDiOfsAeDO+8izXzf3Wp8Iu
         fVeD4ksuWDpqgisAUBVTj4jBFRvHQU9fnHdVOjYgrKYbza2TkfhSwJnp2Vn03kQAJjgR
         +u+AlEOTc7B+F3vmboBpiOHu5aTypjWHVNdM+ZPrchyVCtbniaEEvf/D0LxNdTb0MaBl
         0Y0TW+y2rmbzIP+Nn1zOgTePFQVuNw+A81HjoRfU48xNhBSLjbvdMMuKe+vXcRC3JZGY
         IrFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UxupZ19T9+gsiBZnvnrzKxqlMOJ7hh4/eBxuoKeFsrQ=;
        b=UAYyPWbVj5MyQQTS9LdzWC1DInmaRm1vGB8aXZzitMiMrwusQOgCNqGpMXjzfVnwmZ
         vaBVS/2kB2pI4gR4W/gN28xwYZu4mrqAhHxRXX4Zfjvl/Ik9n0mSQol65SUtMoD5oLuN
         SIGA88vLnyPqZ74LYtWjHAOwQtoEl+/Kr6pGHLL5suzW16Ffzw2+gmOXRmUPQUuux8oX
         u1dFZCUsdY7bZIlDlZ+330tvn14EQELwsfehcUS5HABnZo34qsKFd4v0gXowa7WtPxLs
         gAUQnlFw2Omr4FpBWCk5f1EgSxLu4gT9Sqasjq2s044a0i6UYykT7CpQgvpMtJyRMa14
         6+TQ==
X-Gm-Message-State: AElRT7G0GI0LDj65TX5FzkkpdZD5IlWaNKmfyqK8lj5QRG0QFTKdTLPY
        NQgVLiuOlHrnLUD29VNmHtJaxayDv3eV/lpKsws=
X-Google-Smtp-Source: AG47ELtxJqliBtXxES0xt36lzRUJgE1iuKKpAGtAFwnsuMIzQqo7NftfIRjvOoIy9oRFmyI6jQ9FIwG7XvNURYlOdxg=
X-Received: by 2002:a24:ac52:: with SMTP id m18-v6mr6623350iti.21.1521318566368;
 Sat, 17 Mar 2018 13:29:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.146.25 with HTTP; Sat, 17 Mar 2018 13:29:25 -0700 (PDT)
In-Reply-To: <2564070.6kGkNsz7Qa@andromeda>
References: <2564070.6kGkNsz7Qa@andromeda>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 17 Mar 2018 21:29:25 +0100
Message-ID: <CAP8UFD27rWmp5+y8dHgqag=uuU1G_kRFvv1x_XqXk+ur8-HauQ@mail.gmail.com>
Subject: Re: [RFC][GSoC] Project proposal: convert interactive rebase to C
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, Mar 17, 2018 at 8:14 PM, Alban Gruin <alban.gruin@gmail.com> wrote:
>
> Weeks 3 & 4 =E2=80=94 May 18, 2018 =E2=80=93 June 11, 2018
> Then, I would start to rewrite git-rebase--interactive, and get rid of gi=
t-
> rebase--helper.

Usually to rewrite a shell script in C, we first rewrite shell
functions into option arguments in a C builtin helper and make the
schell script call the builtin helper (instead of the original shell
functions). Eventually when the shell script is mostly only calling
the builtin helper, we add what is needed into the builtin helper and
we rename it to make it fully replace the shell script.

See for example 0cce4a2756 (rebase -i -x: add exec commands via the
rebase--helper, 2017-12-05) or b903674b35 (bisect--helper:
`is_expected_rev` & `check_expected_revs` shell function in C,
2017-09-29). These examples show that we can do step by step rewrites.

I would suggest planning to use the same approach, and describing in
your proposal which shell functions you would like to rewrite into the
C builtin helper in which order, before planning to fully replace the
current git-rebase--interactive.

Thanks,
Christian.
