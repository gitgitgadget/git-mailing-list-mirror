Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E3E01F42D
	for <e@80x24.org>; Sun, 25 Mar 2018 06:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751125AbeCYGoy (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 02:44:54 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:33365 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751029AbeCYGox (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 02:44:53 -0400
Received: by mail-qk0-f174.google.com with SMTP id d206so4715718qkb.0
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 23:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=cLESgqnv1kLKtCh+whroFiM6E12ZgqlyAEVbtHhoRMU=;
        b=HoVeTknW7fR4J+0UPBDZM+seRCjMpfizrYUuS69oW7FbWmRR8omGnhoOI0InlTpiKW
         2WRbCoJ86J6VNJfi/BCT78WxArIWEjUj0syIUeLryZzG38hMFN607k75hgYpP5HBvKfn
         idpq6KxOtz20HNeS244DiSwCbMQK6LWjNQTHNcbcFju1hWdfVyDwQa8u5kkFVBM2TOfk
         4vNd7UV4mRfIzWcSDjaCEg6mJrYYJ21xF4Ta0+Nh8PP0BMOaCTx0lGxXo2HX0Z1nyfN1
         saes4AO+eappXyfwqCJ2P/HYsPGRp+zCsxjyDK5zOUB23nTH1vGkxkoThQt3dbMJcMvM
         BzVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=cLESgqnv1kLKtCh+whroFiM6E12ZgqlyAEVbtHhoRMU=;
        b=QwdUI1Ag/HKgIeN58RyiMANQgOEZZwjhbYJSBYTtBNTvmskRsiDl0JDDoFR2MQ0fkj
         9aw1rhY2jbm+m0+LnD2KdvyS6h52npVCYjT35GqE4iPHbtxGJPrXHlXDaMiBAlfQ2ME1
         uEOSE0uCHe3v9IpdekDQMBLLu6+ko2ltP5Cl8ah78FmmfO7Y9hRY9l5uqW8fDMrLQD6K
         qPi4iAbV5jP1DqpE5dIfxxoDulpXSKP2u3JXa28O2i3H2WnY6QDNLzxEu9sOkt9gCRSa
         wnEue6QlO0zuWZrPQDKzf6EsPFs3ZwGFKegg4njeKSoFC+J21KU9zkxfnHiNPIVds77y
         f7+w==
X-Gm-Message-State: AElRT7EMZtAGMSnu5Z31qn48ENnuWcz5pXJtj9HPqibl3km6GIKMX1Hn
        mCD4xrTPa0PTptlNzdDVkzX7ZEbv2uvmPQopTK8=
X-Google-Smtp-Source: AG47ELszgHZCANvyAd2XASq7uosfu/8AMoJSQR+AKjq2U1YckHwi0C12fjT3mgOy6l/J8VNMdFM8srTYs2Zbpf+WTVo=
X-Received: by 10.55.22.28 with SMTP id g28mr48976705qkh.152.1521960292652;
 Sat, 24 Mar 2018 23:44:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Sat, 24 Mar 2018 23:44:52 -0700 (PDT)
In-Reply-To: <20180324173707.17699-3-joel@teichroeb.net>
References: <20180324173707.17699-1-joel@teichroeb.net> <20180324173707.17699-3-joel@teichroeb.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 25 Mar 2018 02:44:52 -0400
X-Google-Sender-Auth: PE_ECkulS_II3OTlB3ScfROHRtM
Message-ID: <CAPig+cRyoKZN9osXXXuqTVXn27twLy--BXsHE1jLqKqXJ6DwAA@mail.gmail.com>
Subject: Re: [PATCH 2/4] stash: convert branch to builtin
To:     Joel Teichroeb <joel@teichroeb.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 24, 2018 at 1:37 PM, Joel Teichroeb <joel@teichroeb.net> wrote:
> diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
> @@ -307,6 +313,42 @@ static int apply_stash(int argc, const char **argv, const char *prefix)
> +static int branch_stash(int argc, const char **argv, const char *prefix)
> +{
> +       const char *commit = NULL, *branch = NULL;
> +
> +       argc = parse_options(argc, argv, prefix, options,
> +                       git_stash_helper_branch_usage, 0);
> +
> +       if (argc != 0) {
> +               branch = argv[0];
> +               if (argc == 2)
> +                       commit = argv[1];
> +       }

This seems fragile. What happens if there are three args?

> +       if (get_stash_info(&info, commit))
> +               return -1;
> +
> +       argv_array_pushl(&args, "checkout", "-b", NULL);
> +       argv_array_push(&args, branch);
> +       argv_array_push(&args, sha1_to_hex(info.b_commit.hash));
> +       ret = cmd_checkout(args.argc, args.argv, prefix);
> +       if (ret)
> +               return -1;
> +
> +       ret = do_apply_stash(prefix, &info, 1);
> +       if (!ret && info.is_stash_ref)
> +               ret = do_drop_stash(prefix, &info);
> +
> +       return ret;
> +}
