Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54AF7205C9
	for <e@80x24.org>; Tue,  3 Jan 2017 06:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756306AbdACGT2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 01:19:28 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:33282 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751960AbdACGT0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 01:19:26 -0500
Received: by mail-io0-f193.google.com with SMTP id j76so31591393ioe.0
        for <git@vger.kernel.org>; Mon, 02 Jan 2017 22:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=G6EaanM2Wz/9ftLhDC9BSCcWNcoAy5UmV4t7111Rc+4=;
        b=hoFI2EdbCMN4CjO9pu62/ujP7jRJLNkb0kO+xZdijn4TE3AXy2LMnPKXmtSy2qw0eD
         CuW/rnwO8BA6hny2q7lUJbNM2ITrJdvT+KIwKFSmiF3nc/rdAkFZYnFAGRqeYLWzUo0o
         UulaFft8a2bhBS+9RrWSXj1xO1bLyB9DxSWZBlkNFwhHFCcoJWAF7lY1vGs/vM5+dq/m
         O+yB1uR8Dcb4kwY7yNejtRircKo/Fey8w3SvxgiugSS2MLFONGtOGHlddhu3aOGbJO9q
         IaFaakk1USFMKp7aLLYJfyvvuKt+LjOQPB4Kpuc7f/OTOXkUHPJO4llsIbZK2cxZzrBv
         2Hdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G6EaanM2Wz/9ftLhDC9BSCcWNcoAy5UmV4t7111Rc+4=;
        b=ezEFPwbnaobDLM9rbUjOVaBO0RgMlG9uEdGunmajXW3/NIqO/xQfHSUTGZzHUVXRgh
         VFKP2OtqPC3VBbhgI8eKJjeub88Y0WN5gSb0mwRc846zviUuLxNjZeU+bKTvfP4lgohp
         qZ+hwpxP1f7Cds8h+/dhIFWlP9bgV6P/yuLJWQC3Yx6Zd9zBLWDC6Jvs9mXUWeSnTMRX
         wQoE/mssbKIzjT8Q0Xi1COUu9xeUoCKtv9TuRRsB30gr4Kv3Wo+jPVimQwozbsy4TAMT
         GV6hMe0BnSLH7L+WQbGImqUAZ5ybhezpwSW6xVKNL4ASroFRy/z1sZK7xDo8YtCbrB6m
         2l4g==
X-Gm-Message-State: AIkVDXKeR1izK/wVXHAx3mXp1lyRyziAL0EO9LhhyUGTj+5cf1nBbXO+xrhaUPyAuoMrm31Evr7PI4CAyKFCig==
X-Received: by 10.107.141.211 with SMTP id p202mr44030724iod.47.1483424365954;
 Mon, 02 Jan 2017 22:19:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.142.137 with HTTP; Mon, 2 Jan 2017 22:19:25 -0800 (PST)
In-Reply-To: <20170102233114.20778-1-vegard.nossum@oracle.com>
References: <20170102233114.20778-1-vegard.nossum@oracle.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Tue, 3 Jan 2017 11:49:25 +0530
Message-ID: <CAFZEwPMLk5KTeLR9zygU6ZH5zN7TLnQzmJVpyCNig8FrYcOazw@mail.gmail.com>
Subject: Re: [PATCH] diff: add interhunk context config option
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Vegard,

On Tue, Jan 3, 2017 at 5:01 AM, Vegard Nossum <vegard.nossum@oracle.com> wr=
ote:
> The --inter-hunk-context=3D option was added in commit 6d0e674a5754
> ("diff: add option to show context between close hunks"). This patch
> allows configuring a default for this option.
>
> Cc: Ren=C3=A9 Scharfe <l.s.r@web.de>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---
>  Documentation/diff-options.txt | 2 ++
>  diff.c                         | 8 ++++++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.=
txt
> index e6215c372..163b65444 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -511,6 +511,8 @@ endif::git-format-patch[]
>  --inter-hunk-context=3D<lines>::
>         Show the context between diff hunks, up to the specified number
>         of lines, thereby fusing hunks that are close to each other.
> +       Defaults to `diff.interhunkcontext` or 0 if the config option
> +       is unset.

Seems good. But I think you have missed adding the documentation of
this to Documentation/diff-config.txt . Generally whatever config
variable one adds, is added to Documentation/config.txt but in this
case, there exists a separate Documentation/diff-config.txt for all
"diff" related things which is included in Documentation/config.txt .
Also, you need to link the link both the parts of this documentation.
Please refer to commit id aaab84203 so as to know what I am talking
about.

>  -W::
>  --function-context::
> diff --git a/diff.c b/diff.c
> index 84dba60c4..40b4e6afe 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -33,6 +33,7 @@ static int diff_rename_limit_default =3D 400;
>  static int diff_suppress_blank_empty;
>  static int diff_use_color_default =3D -1;
>  static int diff_context_default =3D 3;
> +static int diff_interhunk_context_default =3D 0;
>  static const char *diff_word_regex_cfg;
>  static const char *external_diff_cmd_cfg;
>  static const char *diff_order_file_cfg;
> @@ -248,6 +249,12 @@ int git_diff_ui_config(const char *var, const char *=
value, void *cb)
>                         return -1;
>                 return 0;
>         }
> +       if (!strcmp(var, "diff.interhunkcontext")) {
> +               diff_interhunk_context_default =3D git_config_int(var, va=
lue);
> +               if (diff_interhunk_context_default < 0)
> +                       return -1;
> +               return 0;
> +       }
>         if (!strcmp(var, "diff.renames")) {
>                 diff_detect_rename_default =3D git_config_rename(var, val=
ue);
>                 return 0;
> @@ -3371,6 +3378,7 @@ void diff_setup(struct diff_options *options)
>         options->rename_limit =3D -1;
>         options->dirstat_permille =3D diff_dirstat_permille_default;
>         options->context =3D diff_context_default;
> +       options->interhunkcontext =3D diff_interhunk_context_default;
>         options->ws_error_highlight =3D ws_error_highlight_default;
>         DIFF_OPT_SET(options, RENAME_EMPTY);

On a first look, it seems that we can overwrite the default config
values by using a different command line argument which is good.

Also, tests are missing. It seems that t/t4032 might be a good place
to add those tests.

Rest all is quite good! :)

Regards,
Pranit Bauva
