Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D5862079A
	for <e@80x24.org>; Sat, 12 Nov 2016 00:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938628AbcKLAWE (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 19:22:04 -0500
Received: from mail-qt0-f176.google.com ([209.85.216.176]:33515 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933797AbcKLAWC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 19:22:02 -0500
Received: by mail-qt0-f176.google.com with SMTP id p16so19095657qta.0
        for <git@vger.kernel.org>; Fri, 11 Nov 2016 16:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UERbp3YnH5Z9GESPqxJdwipFuP5JIzs82GnEQLgslzo=;
        b=LvOJGiuJkYyBOAanmdow3AO9V4RW+0qgeG4FhhHgxuH0hlgpaTcqatDzI2udgYL0p1
         1rg9vAimrU2T6nPavf7aZK8qZWjcXW+9fEIs3bKAH1yL5pBEn7JaxOoUHorNp7fe6/Sc
         shSQlqVt4oUn5hIUjKZ1981ghpvBqeAzSAnkFxKATvQf1x7wKZvXQWtSb5sL4kKTn+BK
         nJyg3RTfnegDJyANypp7p+8IRBeN+aqvDoVoCkD6G/04jb/B5lnEbdRjxV/gyjZ9Qs5M
         X2S6z5MdqjCGJhWS2NnlFDcEFWsV1kF7JOrtlyYfgMKD5ZwRm5831ik5Y/Bxlp9DFM5t
         DyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UERbp3YnH5Z9GESPqxJdwipFuP5JIzs82GnEQLgslzo=;
        b=dY644ENySwYtN/mGVH8IxBb80Kg1pJMsyKqBQUkA76S3ZrsODGbaTYQjYYHLXrEnKN
         IodSqE33H6B/nbWeJVPmyLh6Y/l59dW8Nc82Yg3Tli0ginhQJIOUFnvK1eL383elLc/Q
         i+d06KOIv2GI1ahwd2fUIgIajxiqYZ310SkiwSvzQ5LLGi4zJytt3U5PYF2Mva9MqLN1
         wrfEYwl3NASW63MzMFM4Vgrqv57SwSsbNwPcdtdkvOQlhAeK54lfnUoQVgSQ/6XlqYsl
         KZOQrT1kxrqV/R6TbLJGEIPEyee8Xj15zYJbNoGgn1sVZUz0tTwcU4xMCnLh+ok5kb0C
         Z1Ow==
X-Gm-Message-State: ABUngvdNng1GNqbdlk/VKDlrXHe0DIR1XbqrwWFfWIoCxrAJVpvqGCGueoVzC3Y7txV0bhESs3/RH4Cpm9pvXmQ6
X-Received: by 10.237.34.206 with SMTP id q14mr5212875qtc.101.1478910121758;
 Fri, 11 Nov 2016 16:22:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Fri, 11 Nov 2016 16:22:01 -0800 (PST)
In-Reply-To: <1478908273-190166-3-git-send-email-bmwill@google.com>
References: <1477953496-103596-1-git-send-email-bmwill@google.com>
 <1478908273-190166-1-git-send-email-bmwill@google.com> <1478908273-190166-3-git-send-email-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 11 Nov 2016 16:22:01 -0800
Message-ID: <CAGZ79kbyvN1tns2qpiOdTTPZvUtbLmENUEAFes-vhrA5R=DRQw@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] submodules: load gitmodules file from commit sha1
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 11, 2016 at 3:51 PM, Brandon Williams <bmwill@google.com> wrote:
> teach submodules to load a '.gitmodules' file from a commit sha1.  This
> enables the population of the submodule_cache to be based on the state
> of the '.gitmodules' file from a particular commit.

This is the actual implementation that lead to
https://public-inbox.org/git/20161102231722.15787-4-sbeller@google.com/
(part of origin/sb/submodule-config-cleanup)

To produce cleaner history, we may want to pick that commit into this patch?
That would allow to extend the documentation or just this commit message
to talk about raciness in case we ever want to go multi-threaded with this,
as the current API is not ready for threading, AFAICT this will be used as:

    gitmodules_config_sha1(&interested_sha1)

    struct submodule *sub = submodule_by_path(path, null_sha1);

and the reason you need this API for now is because the
two lines of code happen to called at very different places, such that it is
more convenient to have this API instead of calling submodule_from_path with
the correct sha1 in the first place. This is because the sha1 is not
available at
the place where you want to call submodule_by_path.

>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  cache.h            |  2 ++
>  config.c           |  8 ++++----
>  submodule-config.c |  6 +++---
>  submodule-config.h |  3 +++
>  submodule.c        | 12 ++++++++++++
>  submodule.h        |  1 +
>  6 files changed, 25 insertions(+), 7 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index 1be6526..559a461 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1690,6 +1690,8 @@ extern int git_default_config(const char *, const char *, void *);
>  extern int git_config_from_file(config_fn_t fn, const char *, void *);
>  extern int git_config_from_mem(config_fn_t fn, const enum config_origin_type,
>                                         const char *name, const char *buf, size_t len, void *data);
> +extern int git_config_from_blob_sha1(config_fn_t fn, const char *name,
> +                                    const unsigned char *sha1, void *data);
>  extern void git_config_push_parameter(const char *text);
>  extern int git_config_from_parameters(config_fn_t fn, void *data);
>  extern void git_config(config_fn_t fn, void *);
> diff --git a/config.c b/config.c
> index 83fdecb..4d78e72 100644
> --- a/config.c
> +++ b/config.c
> @@ -1214,10 +1214,10 @@ int git_config_from_mem(config_fn_t fn, const enum config_origin_type origin_typ
>         return do_config_from(&top, fn, data);
>  }
>
> -static int git_config_from_blob_sha1(config_fn_t fn,
> -                                    const char *name,
> -                                    const unsigned char *sha1,
> -                                    void *data)
> +int git_config_from_blob_sha1(config_fn_t fn,
> +                             const char *name,
> +                             const unsigned char *sha1,
> +                             void *data)
>  {
>         enum object_type type;
>         char *buf;
> diff --git a/submodule-config.c b/submodule-config.c
> index 098085b..8b9a2ef 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -379,9 +379,9 @@ static int parse_config(const char *var, const char *value, void *data)
>         return ret;
>  }
>
> -static int gitmodule_sha1_from_commit(const unsigned char *commit_sha1,
> -                                     unsigned char *gitmodules_sha1,
> -                                     struct strbuf *rev)
> +int gitmodule_sha1_from_commit(const unsigned char *commit_sha1,
> +                              unsigned char *gitmodules_sha1,
> +                              struct strbuf *rev)
>  {
>         int ret = 0;
>
> diff --git a/submodule-config.h b/submodule-config.h
> index d05c542..78584ba 100644
> --- a/submodule-config.h
> +++ b/submodule-config.h
> @@ -29,6 +29,9 @@ const struct submodule *submodule_from_name(const unsigned char *commit_sha1,
>                 const char *name);
>  const struct submodule *submodule_from_path(const unsigned char *commit_sha1,
>                 const char *path);
> +extern int gitmodule_sha1_from_commit(const unsigned char *commit_sha1,
> +                                     unsigned char *gitmodules_sha1,
> +                                     struct strbuf *rev);
>  void submodule_free(void);
>
>  #endif /* SUBMODULE_CONFIG_H */
> diff --git a/submodule.c b/submodule.c
> index f5107f0..062e58b 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -198,6 +198,18 @@ void gitmodules_config(void)
>         }
>  }
>
> +void gitmodules_config_sha1(const unsigned char *commit_sha1)
> +{
> +       struct strbuf rev = STRBUF_INIT;
> +       unsigned char sha1[20];
> +
> +       if (gitmodule_sha1_from_commit(commit_sha1, sha1, &rev)) {
> +               git_config_from_blob_sha1(submodule_config, rev.buf,
> +                                         sha1, NULL);
> +       }
> +       strbuf_release(&rev);
> +}
> +
>  /*
>   * Determine if a submodule has been initialized at a given 'path'
>   */
> diff --git a/submodule.h b/submodule.h
> index 6ec5f2f..9203d89 100644
> --- a/submodule.h
> +++ b/submodule.h
> @@ -37,6 +37,7 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
>                 const char *path);
>  int submodule_config(const char *var, const char *value, void *cb);
>  void gitmodules_config(void);
> +extern void gitmodules_config_sha1(const unsigned char *commit_sha1);
>  extern int is_submodule_initialized(const char *path);
>  extern int is_submodule_populated(const char *path);
>  int parse_submodule_update_strategy(const char *value,
> --
> 2.8.0.rc3.226.g39d4020
>
