Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8667F207E4
	for <e@80x24.org>; Sat, 29 Apr 2017 00:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165475AbdD2Axt (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 20:53:49 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33842 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163856AbdD2Axr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 20:53:47 -0400
Received: by mail-pf0-f172.google.com with SMTP id e64so17930197pfd.1
        for <git@vger.kernel.org>; Fri, 28 Apr 2017 17:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=67LhRlTMA0LeBTJvNodhjX0yOw7GqSh/lk5sPuXQic4=;
        b=Tr2fXbwzd5sG/txAHmLz6Fr+CGz3YPjqm+l+ePPLIRiBxb4d5EtmcQZFhdjaEKF/rS
         b8xcEOzYn3zGVVjEd2qUVrX/zqZoCOzjA32/0LirGYN/jq3WiESVj6ITjPiZpJdqfxwn
         Vc65rFgxzXZoYd+QVoFYEBFvN+q5xrYToT0MgPvQT/30kFVMMstOibNfukTnOgWRX7zl
         YSXcHuRkqbt+L9PI4CuvDAimlq0dBDr+M0eTvLpOAmnrmecBZtfUm7BWEd7QL9xj1chA
         XebOosfA95dDK3dCkH3hdREscIoEp7Hc50BbrtD+Opl1sRLQkxlN8Va12yv0pL7gFI6R
         d7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=67LhRlTMA0LeBTJvNodhjX0yOw7GqSh/lk5sPuXQic4=;
        b=ENu4nGtyFMwvfCVXZkK11pI6pJHzPgN9wAPAkqLs/udVmsMq1O7S7Ev3vU2UCQlLCB
         nOKww2nwYWA5vNXzW6ou9/IAFvuuJ0CKWGMnDHOa6a9rhdHfx8popI6R14huKn+fMP1D
         QfyyPknR/+ziwTka4Bds0/MD6EdRja+qNTtazgGbeVZfH9AznqALutnhWYDtmOLQODBC
         S4lPuHP6dsoluwEcvSP4e9Eiufj9FpGOj1y9DfFwXlrVEiHUmC/enHiaGEmMJIDaShXJ
         6OOlt+qf+nS45rZSB/voYhmBqCiJB+X//0UERSriefDQ3uqrUAbkuwbyvZMhCNb9T8Vh
         IWmA==
X-Gm-Message-State: AN3rC/4A2Axvg4gc8ay3TUujmR/lipVUmRzVa+9x0Ho0G1kiZdBAlaj4
        /l7lf+uki6pSqkNLImX+xtTe9N80qOYT
X-Received: by 10.98.24.195 with SMTP id 186mr14802419pfy.35.1493427226443;
 Fri, 28 Apr 2017 17:53:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Fri, 28 Apr 2017 17:53:46 -0700 (PDT)
In-Reply-To: <20170428235402.162251-7-bmwill@google.com>
References: <20170428235402.162251-1-bmwill@google.com> <20170428235402.162251-7-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 28 Apr 2017 17:53:46 -0700
Message-ID: <CAGZ79kYqiSyxtpux77RSGx56Bzj3YA7Tu180=oFbPb1fMgEMkA@mail.gmail.com>
Subject: Re: [PATCH 6/6] submodule: refactor logic to determine changed submodules
To:     Brandon Williams <bmwill@google.com>,
        Heiko Voigt <hvoigt@hvoigt.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+ Heiko, who touched the pushing code end of last year.

On Fri, Apr 28, 2017 at 4:54 PM, Brandon Williams <bmwill@google.com> wrote:
> There are currently two instances (fetch and push) where we want to
> determine if submodules have changed given some revision specification.
> These two instances don't use the same logic to generate a list of
> changed submodules and as a result there is a fair amount of code
> duplication.
>
> This patch refactors these two code paths such that they both use the
> same logic to generate a list of changed submodules.  This also makes it
> easier for future callers to be able to reuse this logic as they only
> need to create an argv_array with the revision specification to be using
> during the revision walk.

Thanks for doing some refactoring. :)

> -static struct oid_array *submodule_commits(struct string_list *submodules,
> -                                           const char *path)
> ...

> -static void free_submodules_oids(struct string_list *submodules)
> -{
> ...

These are just moved north, no change in code.
If you want to be extra nice to reviewers this could have been an extra patch,
as it makes reviewing easier if you just have to look at the lines of code with
one goal ("shuffling code around, no change intended" vs "make a change
to improve things with no bad side effects")



> +
> +static void collect_changed_submodules_cb(struct diff_queue_struct *q,
> +                                         struct diff_options *options,
> +                                         void *data)
> +{

This one combines both collect_submodules_from_diff and
submodule_collect_changed_cb ?

> @@ -921,61 +948,6 @@ int push_unpushed_submodules(struct oid_array *commits,
>         return ret;
>  }
>
> -static int is_submodule_commit_present(const char *path, unsigned char sha1[20])
> -{
> -       int is_present = 0;
> -       if (!add_submodule_odb(path) && lookup_commit_reference(sha1)) {
> -               /* Even if the submodule is checked out and the commit is
> -                * present, make sure it is reachable from a ref. */
> -               struct child_process cp = CHILD_PROCESS_INIT;
> -               const char *argv[] = {"rev-list", "-n", "1", NULL, "--not", "--all", NULL};
> -               struct strbuf buf = STRBUF_INIT;
> -
> -               argv[3] = sha1_to_hex(sha1);
> -               cp.argv = argv;
> -               prepare_submodule_repo_env(&cp.env_array);
> -               cp.git_cmd = 1;
> -               cp.no_stdin = 1;
> -               cp.dir = path;
> -               if (!capture_command(&cp, &buf, 1024) && !buf.len)
> -                       is_present = 1;

Oh, I see where the nit in patch 5/6 is coming from. Another note
on that: The hint is way off. The hint should be on the order of
GIT_SHA1_HEXSZ

>  int find_unpushed_submodules(struct oid_array *commits,
>                 const char *remotes_name, struct string_list *needs_pushing)
> ...

>  static void calculate_changed_submodule_paths(void)
> ...

These are both nicely clean now.

Thanks,
Stefan
