Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 878862055E
	for <e@80x24.org>; Sun, 29 Oct 2017 01:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751821AbdJ2BoJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 21:44:09 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:56700 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751524AbdJ2BoI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Oct 2017 21:44:08 -0400
Received: by mail-qt0-f195.google.com with SMTP id z28so12566620qtz.13
        for <git@vger.kernel.org>; Sat, 28 Oct 2017 18:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Dkxw0pA22SWxDQH+q+5NAV8105ONdX2cGwfDee9XXso=;
        b=u89VPg4kwB5owBa/AnD19MhIqybceqonjR/IWhLKGyLCpS+U3qBsSxNc/A3+Z+Wd8P
         UG0JIwSOTUkKy2eyTP5wHUpc92t39tQg8GzAHkNK4SGAs/EgzfOM9GtL5Ttz2qX8ZzC8
         0CsgZR2UW1+nB2NRFVAxc6/AoTvyahxGlxZHaVmZb+uU7jyJ8+XEvsnWVUKwrrJjUy53
         64gsANV8QHPkdJRY5O4d8h+DIfIzK+O5TDeQ7tkd6dhSLT4rNcV0d/SkhdxpPqpZ0nzV
         Mf0bS8dVP8GX/PTSiDd+qjZwa68mvE+JtYyKl8navAg/tYerb4Q+c95ODA/CPQbCI+R/
         3jMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Dkxw0pA22SWxDQH+q+5NAV8105ONdX2cGwfDee9XXso=;
        b=kbYd3/8Ma7KPl/I5pwGpBHWgfjx0lyusmVeS8mhbjxxP2lLJBlngc2lukd1hpd0HX2
         vkuQF0apO5zVSkYV+bkEqYQCkbOquebKvGdg+LAEvQqeXwKyelfMfjj+eaqRAKreB4zF
         QOF9xaFa046lkxs/d2oZ4mnyvfW9oYoSq/UHLZztyBE8+jS9Bcnm8K7pTMKB877A586d
         BeUg6B7OqfhmGKgPdsGPADqI9zOYNooQpohLvAo0nJQIW4NUPKHsTHqJo6ulOpc35Wak
         PstXEozAJsGIBbc3Rxuajo9wsRDYG2CYb/sgU5FAfF5GbTqUpVlflXeBWXk+RN4sSGFs
         gCxQ==
X-Gm-Message-State: AMCzsaVK/XPOWUCxjA8Q/N6U/J/c7/yg0+lVnYGPIlXlW+Yt5lXb8MbC
        XY+PMq90/qepuPO908oFFUx78sWRrIgn/LuG/CQ=
X-Google-Smtp-Source: ABhQp+QQS6VU7d+QdxNfJHndnpeZpqFT4F3IMsbCX93uOXOwA85GSzUj8Ffdt0GtCCDvmrWUEFpjWwuUkA1McB85WM0=
X-Received: by 10.200.56.83 with SMTP id r19mr7725860qtb.293.1509241447911;
 Sat, 28 Oct 2017 18:44:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.146.118 with HTTP; Sat, 28 Oct 2017 18:44:07 -0700 (PDT)
In-Reply-To: <20171028181239.59458-4-sandals@crustytoothpaste.net>
References: <20171028181239.59458-1-sandals@crustytoothpaste.net> <20171028181239.59458-4-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 28 Oct 2017 21:44:07 -0400
X-Google-Sender-Auth: RfQmEngpXlSqKEOey0K5_9dbCtE
Message-ID: <CAPig+cTrAxWczJ5qX2qE-hqoo6hA2QCom25HYB7v48rVnPgTow@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] Integrate hash algorithm support with repo setup
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 28, 2017 at 2:12 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> In future versions of Git, we plan to support an additional hash
> algorithm.  Integrate the enumeration of hash algorithms with repository
> setup, and store a pointer to the enumerated data in struct repository.
> Of course, we currently only support SHA-1, so hard-code this value in
> read_repository_format.  In the future, we'll enumerate this value from
> the configuration.
> [...]
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/cache.h b/cache.h
> @@ -132,6 +133,8 @@ struct git_hash_algo {
>  extern const struct git_hash_algo hash_algos[GIT_HASH_NALGOS];
>
> +#define current_hash the_repository->hash_algo

The all-lowercase name "current_hash" seems likely to conflict with a
variable name some day; the fact that it is also a #define makes such
a collision even more worrisome. Although it is retrieving the "hash
algorithm", when reading the terse name "current_hash", one may
instead intuitively think it is referring to a hash _value_ (not an
algorithm).

> diff --git a/repository.c b/repository.c
> @@ -64,6 +64,11 @@ void repo_set_gitdir(struct repository *repo, const char *path)
> +void repo_set_hash_algo(struct repository *repo, int hash_algo)
> +{
> +       repo->hash_algo = &hash_algos[hash_algo];
> +}
> +
>  /*
>   * Attempt to resolve and set the provided 'gitdir' for repository 'repo'.
>   * Return 0 upon success and a non-zero value upon failure.
> @@ -136,6 +141,8 @@ int repo_init(struct repository *repo, const char *gitdir, const char *worktree)
>         if (read_and_verify_repository_format(&format, repo->commondir))
>                 goto error;
>
> +       repo->hash_algo = &hash_algos[format.hash_algo];

Should this be instead invoking repo_set_hash_algo()?

>         if (worktree)
>                 repo_set_worktree(repo, worktree);
