Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18CE2200B9
	for <e@80x24.org>; Fri,  4 May 2018 02:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751240AbeEDCvK (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 22:51:10 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34904 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751214AbeEDCvJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 22:51:09 -0400
Received: by mail-qt0-f195.google.com with SMTP id f5-v6so12321280qth.2
        for <git@vger.kernel.org>; Thu, 03 May 2018 19:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=kmOtW6V95Z12sj8xBq//dZSwsGeuIy5+eTUDOAHb7z8=;
        b=bN5GLCL6NQRx+sDKcmgummmuhqwVkDaCppOjEBt/5nuEIzAs6/804DsuOhZlTatuhs
         IPPdOw+B/aF2VqpInAwZ9P8RdgXYRvY8c4XTbVF/dEtuVWRW0w9hjak9eO24LQLTmkZm
         z27ObjTFV4hacYtnrCsOl5+UVFH+H6AFM4mUhLtE/pPdUhjblFVGDuKLnAqilAN5VyMi
         RWwyONFpuWrF9Pqqd+nGWTKEHhcsBm9BgABMJQETsOpQaVcOBwSLTB/92fLqrayo8ITm
         pquJZsYAJXKYE/LumYz5uFeVWilTcLy2EL3J1vmOYivE3caH3DTO70tyuE8w8mQeZIJo
         pQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=kmOtW6V95Z12sj8xBq//dZSwsGeuIy5+eTUDOAHb7z8=;
        b=KrKpyjYmCnSiuG+VO64O9DjiUmyrdANAuIg41zyxhUyzVqhqLSIxxPSqDM0qQlPve4
         PyZGuPCudsKlGdOqRb8DgtzIznGWx6tZyTKPVbUUbI8Xdhi26j/dg6rOOOvvZCnmff0O
         RKNrW19NYZhcP1vNjaNntiO+67fNcvs2DD6FYCA6Nt9Ndq2KRvfEyWVc/1hsTgPfb6Ky
         tQYFsD/4sw+nlzlVVCSddBRNFj9/AzYF2uy8m3WDSHAHtHZkDnXVi64nXXUgERKyApmU
         fbzPL9S8UgSmAY/nO6hZb/2/PHEb/RncTEGDSsE1uiVTZPg9VY7su8zUV1/DTZ39pWDr
         Ks5g==
X-Gm-Message-State: ALQs6tANubux6ctyttg0u6XFpBLVal6A4EU0uox8RGvL8LFDU/POdY9R
        EV/O5JH5sCV0mMgIcg3UtVUxAPx62jCZcPB0ayg=
X-Google-Smtp-Source: AB8JxZrrdOSOyw9doAViL+uocOoX18aUaOpA04eifk5h0GBzv9SJaSmCirRf1uhJmyB8a/c8mC53JfZhrqpV/k8HPkM=
X-Received: by 2002:ac8:1204:: with SMTP id x4-v6mr23071246qti.35.1525402268411;
 Thu, 03 May 2018 19:51:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.170.75 with HTTP; Thu, 3 May 2018 19:51:07 -0700 (PDT)
In-Reply-To: <141e5b63e4511c13380216fad9b8601d2bc6051e.1525361419.git.johannes.schindelin@gmx.de>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <141e5b63e4511c13380216fad9b8601d2bc6051e.1525361419.git.johannes.schindelin@gmx.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 3 May 2018 22:51:07 -0400
X-Google-Sender-Auth: _jx1LfZVbQjfO6V2KiaZkr2pcyc
Message-ID: <CAPig+cQc-FXyZv=61GO7-6apu_avA-DhPkqJLC_1a5hKmq=bZg@mail.gmail.com>
Subject: Re: [PATCH 05/18] branch-diff: also show the diff between patches
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 3, 2018 at 11:30 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Just like tbdiff, we now show the diff between matching patches. This is
> a "diff of two diffs", so it can be a bit daunting to read for the
> beginnger.

s/beginnger/beginner/

> This brings branch-diff closer to be feature-complete with regard to

s/be feature-complete/feature parity/

> tbdiff.
>
> An alternative would be to display an interdiff, i.e. the hypothetical
> diff which is the result of first reverting the old diff and then
> applying the new diff.
>
> Especially when rebasing often, an interdiff is often not feasible,
> though: if the old diff cannot be applied in reverse (due to a moving
> upstream), an interdiff can simply not be inferred.
>
> Note: while we now parse diff options such as --color, the effect is not
> yet the same as in tbdiff, where also the commit pairs would be colored.

"... tbdiff, in which the commit pairs would also be colored."

However, I don't see the --color option being parsed by this patch, so
perhaps this "Note" can be dropped?

> This is left for a later commit.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/builtin/branch-diff.c b/builtin/branch-diff.c
> @@ -319,24 +348,37 @@ static void output(struct string_list *a, struct string_list *b)
>  int cmd_branch_diff(int argc, const char **argv, const char *prefix)
>  {
> -       int no_patches = 0;
> +       struct diff_options diffopt = { 0 };
>         double creation_weight = 0.6;
>         struct option options[] = {
> -               OPT_BOOL(0, "no-patches", &no_patches,
> -                        N_("short format (no diffs)")),

This was added in 2/18 but never used...

> +               OPT_SET_INT(0, "no-patches", &diffopt.output_format,
> +                           N_("short format (no diffs)"),
> +                           DIFF_FORMAT_NO_OUTPUT),

... and is then replaced in its entirety by this. Perhaps just drop
the original --no-patches from 2/18 and let it be introduced for the
first time here?

>                 { OPTION_CALLBACK,
>                         0, "creation-weight", &creation_weight, N_("factor"),
>                         N_("Fudge factor by which creation is weighted [0.6]"),
>                         0, parse_creation_weight },
>                 OPT_END()
>         };
