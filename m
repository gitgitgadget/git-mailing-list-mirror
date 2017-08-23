Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6353620899
	for <e@80x24.org>; Wed, 23 Aug 2017 20:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754172AbdHWUpy (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 16:45:54 -0400
Received: from mail-yw0-f182.google.com ([209.85.161.182]:35445 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751774AbdHWUpx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 16:45:53 -0400
Received: by mail-yw0-f182.google.com with SMTP id s187so7753171ywf.2
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 13:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aMaSZrbWHtLiaNUxQRGnrvlizO0Um7dh/B4SOol/zmc=;
        b=DE8MBbMgTakUI5Thq00MKgrrIMkBeAA20IiWBlJeR+/wjNO0RhwwSK8oY2laN/muT/
         xxg/QtNE6Blav0GIvCvC7Iv8WW+GM2XZkI5D2VOSKb1wtG5+XxjH/hi7opAe6Ggc5VDo
         LqIlojzpQ2NZVziQOyZqmIshoJEIlW3HR+lvkDKs3IEBhnc8SnMk4ukLeoRDMGCctQ3I
         cH1lN2cMqFhc0WOuy1fdzH9MD14h1bux89xPdCLNBHNQLtoohRKtWq96bNA/dFtL62NP
         Z5IkjMpq4ovA/0ZSQfR8iOvFuRmggjgHTTPNNZbKh4NaUj+bTp69XEOb7crftitTbaL1
         ZpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aMaSZrbWHtLiaNUxQRGnrvlizO0Um7dh/B4SOol/zmc=;
        b=dHMNz+n5BSi52fuP88MMGkNRmPK2tmQeObFLawvUSEToTJw4NQ5I4wPmeyNerqDe2X
         8zf0nEUqsqm2t2c5b9/IrDbOhbvNUVry6s5etoXzBm/m85ayWmcw6Ob5HvtcUROlO333
         X41H8OlA8s0mLsTb8rVcxfLPZFCvFIcphKEgja//Ye5U7MdnrBFEJNoVEVILEdN8MUbS
         FJH+X4WK9tjyqmh84rq1F0yKvBSaJVpjauurXmTQEAH8tv3aPVVEPWnmEIICmzFu774D
         N9Q2aKUzTKVFcndUuqk2o7oZuvpFlfjqNI2/K7vST3ZNTaaOhHE2T9VlR/t3urZnukCz
         2zlg==
X-Gm-Message-State: AHYfb5jdAiXwfgFOAoFqO6Yhu5pwqh9omZNvRL9Ai0cuer5IBdzFiJPn
        aJ/pR0tKWSkg4RRxSal5WDhoM5jD2XIj
X-Google-Smtp-Source: ADKCNb4SVHVPoHyD60ey+mQnxjeSW//MMmOz5W/JWJTHv5vdE5UOYbrMAUzcs98zL/mo/8hhUtepsNTwyRpKw3tD2GE=
X-Received: by 10.37.51.7 with SMTP id z7mr3202380ybz.145.1503521152264; Wed,
 23 Aug 2017 13:45:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.214.133 with HTTP; Wed, 23 Aug 2017 13:45:51 -0700 (PDT)
In-Reply-To: <20170823123704.16518-15-pclouds@gmail.com>
References: <20170823123704.16518-1-pclouds@gmail.com> <20170823123704.16518-15-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 23 Aug 2017 13:45:51 -0700
Message-ID: <CAGZ79kadXiwY9R4e0jYSanTmQJgR7axbEoDP2WcVQTxkDhq_Sg@mail.gmail.com>
Subject: Re: [PATCH v4 14/16] rev-list: expose and document --single-worktree
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 23, 2017 at 5:37 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  Documentation/rev-list-options.txt | 8 ++++++++
>  revision.c                         | 2 ++
>  2 files changed, 10 insertions(+)
>
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-=
options.txt
> index a6cf9eb380..7d860bfca1 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -184,6 +184,14 @@ explicitly.
>         Pretend as if all objects mentioned by reflogs are listed on the
>         command line as `<commit>`.
>
> +--single-worktree::
> +       By default, all working trees will be examined by the
> +       following options when there are more than one (see
> +       linkgit:git-worktree[1]): `--all`, `--reflog` and
> +       `--indexed-objects`.
> +       This option forces them to examine the current working tree
> +       only.
> +
>  --ignore-missing::
>         Upon seeing an invalid object name in the input, pretend as if
>         the bad input was not given.
> diff --git a/revision.c b/revision.c
> index d100b3a3be..6eba4131b4 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2251,6 +2251,8 @@ static int handle_revision_pseudo_opt(const char *s=
ubmodule,
>                         return error("invalid argument to --no-walk");
>         } else if (!strcmp(arg, "--do-walk")) {
>                 revs->no_walk =3D 0;
> +       } else if (!strcmp(arg, "--single-worktree")) {
> +               revs->single_worktree =3D 1;

This is in handle_revision_pseudo_opt, that has the note

/*
* NOTE!
*
* Commands like "git shortlog" will not accept the options below
* unless parse_revision_opt queues them (as opposed to erroring
* out).
*
* When implementing your new pseudo-option, remember to
* register it in the list at the top of handle_revision_opt.
*/

The registration needs to be done at around line 1700.

But come to think of it, is it really a pseudo opt?
Could it be a "real" (non pseudo) opt in handle_revision_opt?
The reasoning (either way) would be of interest in the
commit message, IMHO.
