Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D1DC20D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 19:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751078AbdFATxd (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 15:53:33 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36591 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751024AbdFATxc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 15:53:32 -0400
Received: by mail-pf0-f176.google.com with SMTP id m17so36055672pfg.3
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 12:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Jd8sRq7OLLVMW4TgX1fU1ZzX4LRIzsYiMGIX8Dm6fqs=;
        b=IcB+QhFUJKjaVpk5MYd7I+/dPh5jNZnCBfQ8e6nKkkqvSsNY1cJeWD44rAIQCtAVHe
         o0obTAU+Ft4hwsW6dXVJVN43Ghp9CtY3POAba0ejrzyQ2dT4DQjDHQOD/HuzyRJvYfnW
         Cg4Y9X1Fn2RPfDGNIkKMAUmkYEtC1F7/6k4xHdTNA5/do961JNzXpPGon5QLDVe6uFr/
         uuafS+xYn6aW4Wv3kWBWLhjeCPM5lw3nQx+xw7KBCwX3O5n97vPpAVoSfGtQiHuq2gV2
         Yiy52rs4oS4dAvrrxwoNKNLVQfhHA6eD2V4coI9H9EtrxLZ2PCcVKb8U++0aCxwrxcjg
         0Fnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Jd8sRq7OLLVMW4TgX1fU1ZzX4LRIzsYiMGIX8Dm6fqs=;
        b=l+e1UllubNhxYKrlNVlc0NsygQnFeqJV9fXMNDb21PJX3dmfNkCCgA5Jsq46zgu/S0
         nzeu61ZmFZKXacYoQVKDMWeOxscYHxW3FRAuoLdqhkNQIw0jXdJ3UK47b+CGcuq+7Ano
         sxk/oceaKe6jxnW0MCObcjt1xk1hnJI5VZ9Xe/bJRRwtN4+Ucfe/AgYuTWncCubDV3i9
         EcuMbVqKF471yJZgcezjD2gGm1xEAMcF3pCq3Fh4v3XuK3hROsHs593QYBo3ekkYAjoe
         Ak7o20qLlCEg4KhxrnSx/Mpvp2FXGXfhkM+uAKISg0s6XTLQkGMqcdpAwAJLA2pMr5Da
         LnNQ==
X-Gm-Message-State: AODbwcCboP25Es9/YMmchi3lz+w9KL+XI4rQJQu6JJHbIVoFnJUJ7KVT
        Ilqx845Fj3m2xV50Hs02qT7PeCcLJTSy
X-Received: by 10.98.91.5 with SMTP id p5mr2674748pfb.94.1496346811943; Thu,
 01 Jun 2017 12:53:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Thu, 1 Jun 2017 12:53:31 -0700 (PDT)
In-Reply-To: <20170531214417.38857-7-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com> <20170531214417.38857-7-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 1 Jun 2017 12:53:31 -0700
Message-ID: <CAGZ79kbqsvuBG21teO2kT=H6G-xP0wJbd0f0BTjd9obRMSaxGQ@mail.gmail.com>
Subject: Re: [PATCH 06/31] repo: introduce the repository object
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ben Peart <peartben@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 31, 2017 at 2:43 PM, Brandon Williams <bmwill@google.com> wrote:
> Introduce the repository object 'struct repo' which can be used hold all
> state pertaining to a git repository.
>
> The aim of object-ifying the repository is to (1) make the code base
> more readable and easier to reason about and (2) allow for working on
> multiple repositories, specifically submodules, within the same process.
>
> TODO: Add more motivating points for adding a repository object?

Yes please (or delete this line).
https://public-inbox.org/git/alpine.DEB.2.21.1.1705221501540.3610@virtualbox/

> +++ b/repo.c
> @@ -0,0 +1,124 @@
> +#include "cache.h"
> +#include "repo.h"
> +
> +/*
> + * This may be the wrong place for this.
> + * It may be better to go in env.c or setup for the time being?

In env.c we say:
/*
 * We put all the git config variables in this same object
 * file, so that programs can link against the config parser
 * without having to link against all the rest of git.
 *
 * In particular, no need to bring in libz etc unless needed,
 * even if you might want to know where the git directory etc
 * are.
 */

And setup.c only has a few variables that matter there locally.
So I would think having 'the_repository' in repo.c is acceptable.

> + */
> +struct repo the_repository;
> +
> +static char *git_path_from_env(const char *envvar, const char *git_dir,
> +                              const char *path, int fromenv)
> +{
> +       if (fromenv) {
> +               const char *value = getenv(envvar);
> +               if (value)
> +                       return xstrdup(value);
> +       }
> +
> +       return xstrfmt("%s/%s", git_dir, path);
> +}
> +
> +static int find_common_dir(struct strbuf *sb, const char *gitdir, int fromenv)
> +{
> +       if (fromenv) {
> +               const char *value = getenv(GIT_COMMON_DIR_ENVIRONMENT);
> +               if (value) {
> +                       strbuf_addstr(sb, value);
> +                       return 1;
> +               }
> +       }
> +
> +       return get_common_dir_noenv(sb, gitdir);
> +}
> +
> +/* called after setting gitdir */
> +static void repo_setup_env(struct repo *repo)
> +{
> +       struct strbuf sb = STRBUF_INIT;
> +
> +       if (!repo->gitdir)
> +               BUG("gitdir wasn't set before setting up the environment");
> +
> +       repo->different_commondir = find_common_dir(&sb, repo->gitdir,
> +                                                   !repo->ignore_env);
> +       repo->commondir = strbuf_detach(&sb, NULL);
> +       repo->objectdir = git_path_from_env(DB_ENVIRONMENT, repo->commondir,
> +                                           "objects", !repo->ignore_env);
> +       repo->index_file = git_path_from_env(INDEX_ENVIRONMENT, repo->gitdir,
> +                                            "index", !repo->ignore_env);
> +       repo->graft_file = git_path_from_env(GRAFT_ENVIRONMENT, repo->commondir,
> +                                            "info/grafts", !repo->ignore_env);
> +       repo->namespace = expand_namespace(repo->ignore_env ? NULL :
> +                                          getenv(GIT_NAMESPACE_ENVIRONMENT));
> +}
> +
> +static void repo_clear_env(struct repo *repo)
> +{
> +       free(repo->gitdir);
> +       repo->gitdir = NULL;
> +       free(repo->commondir);
> +       repo->commondir = NULL;
> +       free(repo->objectdir);
> +       repo->objectdir = NULL;
> +       free(repo->index_file);
> +       repo->index_file = NULL;
> +       free(repo->graft_file);
> +       repo->graft_file = NULL;
> +       free(repo->namespace);
> +       repo->namespace = NULL;

I wonder if we can defer the NULL assignments to
repo_clear, where we would just do a
memset(repo, 0, sizeof(struct repo));

> +
> +       repo_set_gitdir(repo, resolved_gitdir);
> +
> +       /* NEEDSWORK: Verify repository format version */

Care to elaborate on this? I do not understand why we would want
to check the format version here?

> +
> +extern void repo_set_gitdir(struct repo *repo, const char *path);
> +extern int repo_init(struct repo *repo, const char *path);
> +extern void repo_clear(struct repo *repo);

The init and clear method seem obvious to me, but what do we need the
repo_set_gitdir for externally? I would assume the repo auto-discovers its
gitdir on its own?
