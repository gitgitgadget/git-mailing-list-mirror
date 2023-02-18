Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A0AC05027
	for <git@archiver.kernel.org>; Sat, 18 Feb 2023 01:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjBRBg6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Feb 2023 20:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBRBg4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2023 20:36:56 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E7E656A2
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 17:36:55 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id o3so3793030lfo.3
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 17:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1etCIQeKqZUo2WuXBMgJBS4I3N5/M0YLGruJ9g2IDjo=;
        b=iBGJ58R4fd6xVxGoD/wQ6nKww8zosoHMtbt5L9GOW/ItZ+KM6uE26n7kHlbDmAFvCY
         gvS7v0fxm+r2Y5h3k1P7DwSDbICYPzMkxQagswWf9hzXGEY3U0d40NZqsRyt6g6q8FRQ
         71zL+ie+VxwgOb4YZuqkSHtPu/67j0RezqtR9opbN/KRR3ttcyX/+/2gYuVKHB1OilJG
         87kXvpsQ+eMeUntI3PwHndqT+uemzxi6VK7qOzXCLUsHv3RF/zLs0B2V7avMJcWB8KTS
         nAZU5lLOtMEp4ZXdKe2JRxXUdXrTb9vmH0bC/MkZO/vsJ4Deebl6JqmAFd0XFdWvnR72
         BYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1etCIQeKqZUo2WuXBMgJBS4I3N5/M0YLGruJ9g2IDjo=;
        b=oo7OeQ1gd7yz7JDQEHJKBu83ewH7KEjSmqd7UWHcUBAv1siwAlq6J9NqDZIK3s75kB
         RGHz2vnI/aRsJtu8Ft2f2vN2Zj9UPkyaKu8kjL12dqZvTCnVSgNk5shSoV0fQ+aVBibC
         3WKSiTqcjwP5gVIFNTNdCkBEUH+jIv0P7rxQgqh9HRydhmuqTSbcZ5iIu4VgWce25OLF
         2hckxVsc498Il6ahZEqma/bv94qwSNXU0ECh1SsjW7HIhY4KzvCmowcmPrNRuEikdNrM
         Di63z4BRArHwADPJurQ6cQmh17KbAzN0iWN0Bxd3wrzdIpWh1t7JUoQQyeM+JUXRcGEn
         rxgw==
X-Gm-Message-State: AO0yUKX8FJ/VC3qaFPOwMcmywWrzogORHBwI+jnxK/6YC3UYRql+c+ID
        nZKyWOXsXVKhs4Hv8PNCXPni3qd4W6sF2DzKVIE=
X-Google-Smtp-Source: AK7set97fUpSV78TF5QMZo/1kK4MNWL14xhVnZAyiirI7kzDWvL0Bc4/ArHTLy7Yfsuc+T6JqA3ZQdGP3AZuu/ZLFGY=
X-Received: by 2002:ac2:55a1:0:b0:4d5:ca32:9bd6 with SMTP id
 y1-20020ac255a1000000b004d5ca329bd6mr1028869lfg.2.1676684213322; Fri, 17 Feb
 2023 17:36:53 -0800 (PST)
MIME-Version: 1.0
References: <pull.1452.v2.git.git.1676410819.gitgitgadget@gmail.com>
 <pull.1452.v3.git.git.1676665285.gitgitgadget@gmail.com> <816c47aa414586e99aa762604396bd8be4fb11f4.1676665285.git.gitgitgadget@gmail.com>
In-Reply-To: <816c47aa414586e99aa762604396bd8be4fb11f4.1676665285.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 17 Feb 2023 17:36:00 -0800
Message-ID: <CABPp-BFv+=b0WN3rELib4snOnczveRcwb1b7hVJXh851BKWkvg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] diff: consolidate diff algorithm option parsing
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>, John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 17, 2023 at 12:21 PM John Cai via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: John Cai <johncai86@gmail.com>
>
> A subsequent commit will need the ability to tell if the diff algorithm
> was set through the command line through setting a new member of
> diff_options. While this logic can be added to the
> diff_opt_diff_algorithm() callback, the `--minimal` and `--histogram`
> options are handled via OPT_BIT without a callback.
>
> Remedy this by consolidating the options parsing logic for --minimal and
> --histogram into one callback. This way we can modify `diff_options` in
> that function.
>
> As an additional refactor, the logic that sets the diff algorithm in
> diff_opt_diff_algorithm() can be refactored into a helper that will
> allow multiple callsites to set the diff algorithm.
>
> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>  diff.c | 57 +++++++++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 43 insertions(+), 14 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 329eebf16a0..5efc22ca06b 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3437,6 +3437,22 @@ static int diff_filepair_is_phoney(struct diff_filespec *one,
>         return !DIFF_FILE_VALID(one) && !DIFF_FILE_VALID(two);
>  }
>
> +static int set_diff_algorithm(struct diff_options *opts,
> +                             const char *alg)
> +{
> +       long value = parse_algorithm_value(alg);
> +
> +       if (value < 0)
> +               return -1;
> +
> +       /* clear out previous settings */
> +       DIFF_XDL_CLR(opts, NEED_MINIMAL);
> +       opts->xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;
> +       opts->xdl_opts |= value;
> +
> +       return 0;
> +}
> +
>  static void builtin_diff(const char *name_a,
>                          const char *name_b,
>                          struct diff_filespec *one,
> @@ -5107,17 +5123,28 @@ static int diff_opt_diff_algorithm(const struct option *opt,
>                                    const char *arg, int unset)
>  {
>         struct diff_options *options = opt->value;
> -       long value = parse_algorithm_value(arg);
>
>         BUG_ON_OPT_NEG(unset);
> -       if (value < 0)
> +
> +       if (set_diff_algorithm(options, arg))
>                 return error(_("option diff-algorithm accepts \"myers\", "
>                                "\"minimal\", \"patience\" and \"histogram\""));
>
> -       /* clear out previous settings */
> -       DIFF_XDL_CLR(options, NEED_MINIMAL);
> -       options->xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;
> -       options->xdl_opts |= value;
> +       return 0;
> +}
> +
> +static int diff_opt_diff_algorithm_no_arg(const struct option *opt,
> +                                  const char *arg, int unset)
> +{
> +       struct diff_options *options = opt->value;
> +
> +       BUG_ON_OPT_NEG(unset);
> +       BUG_ON_OPT_ARG(arg);
> +
> +       if (set_diff_algorithm(options, opt->long_name))
> +               BUG("available diff algorithms include \"myers\", "
> +                              "\"minimal\", \"patience\" and \"histogram\"");
> +
>         return 0;
>  }
>
> @@ -5250,7 +5277,6 @@ static int diff_opt_patience(const struct option *opt,
>
>         BUG_ON_OPT_NEG(unset);
>         BUG_ON_OPT_ARG(arg);
> -       options->xdl_opts = DIFF_WITH_ALG(options, PATIENCE_DIFF);
>         /*
>          * Both --patience and --anchored use PATIENCE_DIFF
>          * internally, so remove any anchors previously
> @@ -5259,7 +5285,8 @@ static int diff_opt_patience(const struct option *opt,
>         for (i = 0; i < options->anchors_nr; i++)
>                 free(options->anchors[i]);
>         options->anchors_nr = 0;
> -       return 0;
> +
> +       return set_diff_algorithm(options, "patience");
>  }
>
>  static int diff_opt_ignore_regex(const struct option *opt,
> @@ -5562,9 +5589,10 @@ struct option *add_diff_options(const struct option *opts,
>                             N_("prevent rename/copy detection if the number of rename/copy targets exceeds given limit")),
>
>                 OPT_GROUP(N_("Diff algorithm options")),
> -               OPT_BIT(0, "minimal", &options->xdl_opts,
> -                       N_("produce the smallest possible diff"),
> -                       XDF_NEED_MINIMAL),
> +               OPT_CALLBACK_F(0, "minimal", options, NULL,
> +                              N_("produce the smallest possible diff"),
> +                              PARSE_OPT_NONEG | PARSE_OPT_NOARG,
> +                              diff_opt_diff_algorithm_no_arg),
>                 OPT_BIT_F('w', "ignore-all-space", &options->xdl_opts,
>                           N_("ignore whitespace when comparing lines"),
>                           XDF_IGNORE_WHITESPACE, PARSE_OPT_NONEG),
> @@ -5590,9 +5618,10 @@ struct option *add_diff_options(const struct option *opts,
>                                N_("generate diff using the \"patience diff\" algorithm"),
>                                PARSE_OPT_NONEG | PARSE_OPT_NOARG,
>                                diff_opt_patience),
> -               OPT_BITOP(0, "histogram", &options->xdl_opts,
> -                         N_("generate diff using the \"histogram diff\" algorithm"),
> -                         XDF_HISTOGRAM_DIFF, XDF_DIFF_ALGORITHM_MASK),
> +               OPT_CALLBACK_F(0, "histogram", options, NULL,
> +                              N_("generate diff using the \"histogram diff\" algorithm"),
> +                              PARSE_OPT_NONEG | PARSE_OPT_NOARG,
> +                              diff_opt_diff_algorithm_no_arg),
>                 OPT_CALLBACK_F(0, "diff-algorithm", options, N_("<algorithm>"),
>                                N_("choose a diff algorithm"),
>                                PARSE_OPT_NONEG, diff_opt_diff_algorithm),
> --
> gitgitgadget

This patch looks good to me.
