Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E9491F859
	for <e@80x24.org>; Sun, 21 Aug 2016 11:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752609AbcHULOk (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Aug 2016 07:14:40 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:34113 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751694AbcHULOk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2016 07:14:40 -0400
Received: by mail-yw0-f195.google.com with SMTP id j12so2535397ywb.1
        for <git@vger.kernel.org>; Sun, 21 Aug 2016 04:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=78NH/8oFoxYoFXojw7+GDdIUXz/3Q1lFSM7W6xrODoc=;
        b=TwwH5d1WBtSnwYlhAhV15NjhMubh81HgJkOsBUCOv5dk50Sm4TKz+XptmiWLCwKqyx
         7zUDnm91NU7ARZLD0VZjKIicsFJ9J8e+3Ao9UTQcLWqHRdeWi0EL0rdVrvi5r9mRV7nz
         TqMuYYP4VLO4vaSkGB4lm7/9X0FNN+oJoyDMtMlKtUOF4UZnHBqErovDx/WzW68Aochp
         c5sM/498xXDjWdKCrJZRxnPWlwmR3GhmDNGfJZgRAuWIrahk2eFZgqv5GNN73RGQDCfz
         63jxE335d6G7+gt3ADONhrtskoD2YVaRQLpVeyu9rJfb0jfeAvlfX1mKxp+j8fbj5wh/
         5yuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=78NH/8oFoxYoFXojw7+GDdIUXz/3Q1lFSM7W6xrODoc=;
        b=RfDQk/6FpPzaK2lrOHTRG1gLjOFDrQiJ2UiVN+fYY8XIAOU5Rz3tlnPfAslstNzW8Z
         n1HHzDeXukUAbGTpSDtnkERx6DJX5DBDIBl3rMyAPBQnXdHmhRzTOsWGRHE+r3Gh3KQa
         GsGMGGW/npPI4bHBH0iICLIxnaSd6Bx2MwYNKkjmmvXPUham+XVQmrYA4NmNZHN0rIyD
         cDBy4fg8yVt9MU3e0pjdKwZXwi9Cadv0Qwx/jZiSjHW6L1B7904Jb3fo7JZLMFatTpZn
         FWwpAEEzEdQQ6tVrG5K77spxHg2cDW1nR5uu272N4Bgbt+E4KRvgmCAPWBWmeAlPktKp
         zwlA==
X-Gm-Message-State: AEkooutqymcDGdRQL6y6uSOsICt1f6dANZzlTJSyPwz8GCTQiK1XmHNbzxIhv4HKd8k6jJt1hR9DQ1esE6TRJw==
X-Received: by 10.129.76.79 with SMTP id z76mr12991229ywa.33.1471778079001;
 Sun, 21 Aug 2016 04:14:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.89.132 with HTTP; Sun, 21 Aug 2016 04:14:38 -0700 (PDT)
In-Reply-To: <01020156a48144f8-c0e127c1-8cd9-4295-ac16-449a54315cac-000000@eu-west-1.amazonses.com>
References: <010201567675adc1-17e27495-6b36-40d1-836d-814da029fcc4-000000@eu-west-1.amazonses.com>
 <01020156a48144f8-c0e127c1-8cd9-4295-ac16-449a54315cac-000000@eu-west-1.amazonses.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Sun, 21 Aug 2016 16:44:38 +0530
Message-ID: <CAFZEwPPmCyUC+mdHjYkgxhBvTwgTwyKz67T6YYJCEaBpmXyycw@mail.gmail.com>
Subject: Re: [PATCH v13 01/13] bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey everyone,

On Sat, Aug 20, 2016 at 2:02 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> `--next-all` is meant to be used as a subcommand to support multiple
> "operation mode" though the current implementation does not contain any
> other subcommand along side with `--next-all` but further commits will
> include some more subcommands.
>
> Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Mentored-by: Lars Schneider <larsxschneider@gmail.com>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
>  builtin/bisect--helper.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 3324229..8111c91 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -10,11 +10,11 @@ static const char * const git_bisect_helper_usage[] = {
>
>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  {
> -       int next_all = 0;
> +       enum { NEXT_ALL = 1 } cmdmode = 0;
>         int no_checkout = 0;
>         struct option options[] = {
> -               OPT_BOOL(0, "next-all", &next_all,
> -                        N_("perform 'git bisect next'")),
> +               OPT_CMDMODE(0, "next-all", &cmdmode,
> +                        N_("perform 'git bisect next'"), NEXT_ALL),
>                 OPT_BOOL(0, "no-checkout", &no_checkout,
>                          N_("update BISECT_HEAD instead of checking out the current commit")),
>                 OPT_END()
> @@ -23,9 +23,14 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>         argc = parse_options(argc, argv, prefix, options,
>                              git_bisect_helper_usage, 0);
>
> -       if (!next_all)
> +       if (!cmdmode)
>                 usage_with_options(git_bisect_helper_usage, options);
>
> -       /* next-all */
> -       return bisect_next_all(prefix, no_checkout);
> +       switch (cmdmode) {
> +       case NEXT_ALL:
> +               return bisect_next_all(prefix, no_checkout);
> +       default:
> +               die("BUG: unknown subcommand '%d'", cmdmode);
> +       }
> +       return 0;
>  }


This is the same series (except for patch 04/13) and rebased on v2.10-rc0.

Regards,
Pranit Bauva
