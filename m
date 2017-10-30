Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F26E202DD
	for <e@80x24.org>; Mon, 30 Oct 2017 20:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752136AbdJ3Ulc (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 16:41:32 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:43095 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751998AbdJ3Ulb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 16:41:31 -0400
Received: by mail-qk0-f193.google.com with SMTP id w134so17872501qkb.0
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 13:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=azc2cFVeYJJbTjnTuxHuXKyPdmhNnlB2+zMi8VldupU=;
        b=DNoQA0gdZHTTB6S4iKIke9LNPOmyv62QcVJLHi54xlC8FYZjXfed8YZ2JOCd+SLwbP
         PaZjcH7YXgAMeQFZ+Dswcog0Fx45wW3M8QH5Zmyhpb2X7lij+pUrHgWTqtjQugFe8nlp
         VT2Ybpva15xOH/Mg8Ev1adhweyaCFUovKevPQ504DaaF6hjhpFBOp6Dy1cQESdTV7rQr
         XySkpo/sL4EvqrZTRBOVVQIaIxo/jkiIXi1qjNcMrr87J3QChiMupSKlbNULfJBqC+M5
         NF2O5nCNjd8hmMBZ7sMNvt+TucqyR3MurmQpipkuA0vwS/6Qzbbo+6UBH0sTTuLMz4mD
         Y0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=azc2cFVeYJJbTjnTuxHuXKyPdmhNnlB2+zMi8VldupU=;
        b=f52fBDLTwRRpP7m2TVVlp5X6gadtFetuv5fc9qZhmolkjesmtUkKtKwQmtdUNGbEDr
         X3ZHkC5AZe8mmq+0E5NkYBmf+gil07pC7o8NlT30zggQH6L4MmdKrpZ3U9LXyQpkASpr
         CIWrwf69Lupgm5PUPbR6DAnwNxioBZqNyqp72SbK5c+Zcff5/haLLCIqnQY7rygQNvEt
         gIA2Z53rmEF+5Yxayaj5gCLdUjSYnFgQ0r2NOyNvsptr2h2ZwUwklvEnxkQbbD3ZFx34
         9M+JhZQcrttk4xw8bdepabeTe7r1TpNIF7xDAdDpKiIexG8uMupY7A4tY8MhZh7GQXBM
         Xw+Q==
X-Gm-Message-State: AMCzsaX3MwtXN5wep+rG24w5otdrJJ7D0PIONhUoEPgEfn/HQyyih4a6
        j+Hkr29nxx11mKGGgCyPGYqXCxPe3+q9ADyhtA3EMg==
X-Google-Smtp-Source: ABhQp+QwWPanh9fhZWJxI4OScfiQsDNvjwlLCPNtPH6o1l7BmyR+cklMNQ/TbMoZyBIf9RK0+78cI9OyzvBKSCYEDco=
X-Received: by 10.55.129.70 with SMTP id c67mr15779745qkd.230.1509396090253;
 Mon, 30 Oct 2017 13:41:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Mon, 30 Oct 2017 13:41:29 -0700 (PDT)
In-Reply-To: <20171030194646.27473-4-bmwill@google.com>
References: <20171027222853.180981-1-bmwill@google.com> <20171030194646.27473-1-bmwill@google.com>
 <20171030194646.27473-4-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 30 Oct 2017 13:41:29 -0700
Message-ID: <CAGZ79kaLX881vi3MJaOCE6h=h_eRGjJ+gYCUEV-2rNSg0exFOw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] diff: add flag to indicate textconv was set via cmdline
To:     Brandon Williams <bmwill@google.com>,
        Michael J Gruber <git@drmicha.warpmail.net>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 30, 2017 at 12:46 PM, Brandon Williams <bmwill@google.com> wrote:
> git-show is unique in that it wants to use textconv by default except
> for when it is showing blobs.  When asked to show a blob, show doesn't
> want to use textconv unless the user explicitly requested that it be
> used by providing the command line flag '--textconv'.
>
> Currently this is done by using a parallel set of 'touched' flags which
> get set every time a particular flag is set or cleared.  In a future
> patch we want to eliminate this parallel set of flags so instead of
> relying on if the textconv flag has been touched, add a new flag
> 'TEXTCONV_SET_VIA_CMDLINE' which is only set if textconv is requested
> via the command line.

Is it worth mentioning 4197361e39 (Merge branch 'mg/more-textconv',
2013-10-23), that introduced the touched_flags?
(+cc Michael Gruber FYI)

> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  builtin/log.c | 2 +-
>  diff.c        | 8 +++++---
>  diff.h        | 1 +
>  3 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index dc28d43eb..82131751d 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -485,7 +485,7 @@ static int show_blob_object(const struct object_id *oid, struct rev_info *rev, c
>         unsigned long size;
>
>         fflush(rev->diffopt.file);
> -       if (!DIFF_OPT_TOUCHED(&rev->diffopt, ALLOW_TEXTCONV) ||
> +       if (!DIFF_OPT_TST(&rev->diffopt, TEXTCONV_SET_VIA_CMDLINE) ||
>             !DIFF_OPT_TST(&rev->diffopt, ALLOW_TEXTCONV))
>                 return stream_blob_to_fd(1, oid, NULL, 0);
>
> diff --git a/diff.c b/diff.c
> index 3ad9c9b31..8b700b1bd 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4762,11 +4762,13 @@ int diff_opt_parse(struct diff_options *options,
>                 DIFF_OPT_SET(options, ALLOW_EXTERNAL);
>         else if (!strcmp(arg, "--no-ext-diff"))
>                 DIFF_OPT_CLR(options, ALLOW_EXTERNAL);
> -       else if (!strcmp(arg, "--textconv"))
> +       else if (!strcmp(arg, "--textconv")) {
>                 DIFF_OPT_SET(options, ALLOW_TEXTCONV);
> -       else if (!strcmp(arg, "--no-textconv"))
> +               DIFF_OPT_SET(options, TEXTCONV_SET_VIA_CMDLINE);
> +       } else if (!strcmp(arg, "--no-textconv")) {
>                 DIFF_OPT_CLR(options, ALLOW_TEXTCONV);

Also clear TEXTCONV_SET_VIA_CMDLINE here?
(`git show --textconv --no-textconv` might act funny?)

> -       else if (!strcmp(arg, "--ignore-submodules")) {
> +               DIFF_OPT_CLR(options, TEXTCONV_SET_VIA_CMDLINE);
> +       } else if (!strcmp(arg, "--ignore-submodules")) {
>                 DIFF_OPT_SET(options, OVERRIDE_SUBMODULE_CONFIG);
>                 handle_ignore_submodules_arg(options, "all");
>         } else if (skip_prefix(arg, "--ignore-submodules=", &arg)) {
> diff --git a/diff.h b/diff.h
> index 47e6d43cb..4eaf9b370 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -83,6 +83,7 @@ struct diff_flags {
>         unsigned DIRSTAT_CUMULATIVE:1;
>         unsigned DIRSTAT_BY_FILE:1;
>         unsigned ALLOW_TEXTCONV:1;
> +       unsigned TEXTCONV_SET_VIA_CMDLINE:1;
>         unsigned DIFF_FROM_CONTENTS:1;
>         unsigned DIRTY_SUBMODULES:1;
>         unsigned IGNORE_UNTRACKED_IN_SUBMODULES:1;
> --
> 2.15.0.403.gc27cc4dac6-goog
>
