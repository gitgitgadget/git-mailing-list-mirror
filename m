Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E27201F404
	for <e@80x24.org>; Mon, 26 Feb 2018 19:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751811AbeBZT2F (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 14:28:05 -0500
Received: from mail-yb0-f178.google.com ([209.85.213.178]:42097 "EHLO
        mail-yb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751788AbeBZT2E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 14:28:04 -0500
Received: by mail-yb0-f178.google.com with SMTP id i13-v6so5700917ybl.9
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 11:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UOHPUE4PhJkLSXVr0XcIxk0+56dW5sjsJHGUhM8Yal8=;
        b=mVA3o06SJeLSHpoQlyYR1KoZT/5p0Xo+ndluRruCxVqzXwAZlwYOWhFU8716aaDMZf
         TC6tnv97gpmh/Wqjn23vTF2R+vxeO8BIKCf1pfJYAEwnzEq8SGSC2rVEiEGgk0FbOkGG
         hdCVlXOLHOexX0QKevUY3ZIgNOK3P8ILsQBItak5dhuTsK1FfbmGur/vk2WnBPX9x0JY
         PL5emsSbxHCP5VoSv04U9jm+7k5x7UwmhmNLXw2moBdMYsdanrbCzYq/I4Ip9i9aCwkM
         2olO6VuiFm9HYe4oQ0QM9BY0qfRs9jZcPfFkeXiXsTx4lFc8cvD1KYRq1JGM0+wOGQMR
         Rl5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UOHPUE4PhJkLSXVr0XcIxk0+56dW5sjsJHGUhM8Yal8=;
        b=R9RkQKNF3wxYRU3jfwbNjVCfOIDdtJVsbbFfg+1Nk5zgqCME3Ex0BMJ/HP6kA1sE3J
         KVeO03tTXbVHJLOrLhwWIgp2SpJbrJLYX6qZQ1rTNDu/gf7x8oY7sHzmQSZ3cbxI+RnM
         zs+pd3euyTg4KNqRhONnIsUxx2smcjRvkUpRW3kBkJNMPW5mRCRf5a8vfr+RmSlKXGzw
         IoZPsZu+/TQz8HW9mUanfDJexl35BvQqlhCvbDf/iNYfkeSj/CSAUcQKanLwhlyh9nkG
         4PRPFAMNmZoXFyo7nxzcwY5eCGhF3y8iVlKajQbLb1yOqv2tpOsPoe1dXUgnHVArYy/a
         p/AQ==
X-Gm-Message-State: APf1xPBb9J9/HR/XpGMcIveGmiKNW8Fzatp9eALQhJPfRyntcTLCVHct
        o/AYAlX7Vi87YzEYnRIMRoN0Exrd398c4Fg2JNsLUVsf
X-Google-Smtp-Source: AG47ELu0SqhyFi1EGEBGpfQ3YT9StaZfQQjLQEnSD00MJYHrAEqQDLmSp//Tg67l6yf77knb5RG1HZNVQP2cAZ1Zoyw=
X-Received: by 2002:a25:d9d6:: with SMTP id q205-v6mr7621365ybg.515.1519673283234;
 Mon, 26 Feb 2018 11:28:03 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Mon, 26 Feb 2018 11:28:02
 -0800 (PST)
In-Reply-To: <20180226093040.GA10479@ash>
References: <20180221015430.96054-1-sbeller@google.com> <20180224004754.129721-1-sbeller@google.com>
 <20180224004754.129721-2-sbeller@google.com> <20180226093040.GA10479@ash>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 26 Feb 2018 11:28:02 -0800
Message-ID: <CAGZ79kZDhoWWPpoENwvE6esxzdJvTnL4EAxGX5HV=DwDtDOEgw@mail.gmail.com>
Subject: Re: [PATCHv4 01/27] repository: introduce raw object store field
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 26, 2018 at 1:30 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Fri, Feb 23, 2018 at 04:47:28PM -0800, Stefan Beller wrote:
>>  /* The main repository */
>>  static struct repository the_repo = {
>> -     NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, &the_index, &hash_algos[GIT_HASH_SHA1], 0, 0
>> +     NULL, NULL,
>> +     RAW_OBJECT_STORE_INIT,
>> +     NULL, NULL, NULL,
>> +     NULL, NULL, NULL,
>> +     &the_index,
>> +     &hash_algos[GIT_HASH_SHA1],
>> +     0, 0
>>  };
>>  struct repository *the_repository = &the_repo;
>
> I wonder if we should do something like this. It makes the_repo
> initialization easier to read and it helps unify the init code with
> submodule.
>
> No don't reroll. If you think it's a good idea, you can do something
> like this in the next series instead.
>
> -- 8< --
> diff --git a/check-racy.c b/check-racy.c
> index 24b6542352..47cbb4eb6d 100644
> --- a/check-racy.c
> +++ b/check-racy.c

totally offtopic: Do we want to move this file into t/helper?

> --- a/common-main.c
> +++ b/common-main.c
> @@ -1,6 +1,7 @@
>  #include "cache.h"
>  #include "exec_cmd.h"
>  #include "attr.h"
> +#include "repository.h"
>
>  /*
>   * Many parts of Git have subprograms communicate via pipe, expect the
> @@ -32,6 +33,8 @@ int main(int argc, const char **argv)
>          */
>         sanitize_stdfds();
>
> +       init_the_repository();
> +

So this is the real deal.

> -#define RAW_OBJECT_STORE_INIT { NULL }
>
> +void raw_object_store_init(struct raw_object_store *o);
>  void raw_object_store_clear(struct raw_object_store *o);
>
>  #endif /* OBJECT_STORE_H */
> diff --git a/object.c b/object.c
> index 11d904c033..8a4d01dd5f 100644
> --- a/object.c
> +++ b/object.c
> @@ -446,6 +446,11 @@ void clear_commit_marks_all(unsigned int flags)
>         }
>  }
>
> +void raw_object_store_init(struct raw_object_store *o)
> +{
> +       memset(o, 0, sizeof(*o));
> +}

We'll have to adapt this for the list that we use for packed_git_mru,
but that should be no problem.

> +
> +static void repo_pre_init(struct repository *repo)
> +{
> +       memset(repo, 0, sizeof(*repo));
> +       raw_object_store_init(&repo->objects);
> +}
> +
> +void init_the_repository(void)
> +{
> +       the_repository = &the_repo;
> +       repo_pre_init(the_repository);
> +       the_repository->index = &the_index;
> +       repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
> +}
>
>  static char *git_path_from_env(const char *envvar, const char *git_dir,
>                                const char *path, int fromenv)
> @@ -138,7 +144,8 @@ static int read_and_verify_repository_format(struct repository_format *format,
>  int repo_init(struct repository *repo, const char *gitdir, const char *worktree)
>  {
>         struct repository_format format;
> -       memset(repo, 0, sizeof(*repo));
> +
> +       repo_pre_init(repo);
>
>         repo->ignore_env = 1;
>

I like the approach. Though as you say, let's have it in the next series.

Thanks for the thoughts and guidance,
Stefan
