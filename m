Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65B8B1F516
	for <e@80x24.org>; Thu, 28 Jun 2018 18:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967959AbeF1StP (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 14:49:15 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:46863 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966880AbeF1StO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 14:49:14 -0400
Received: by mail-yw0-f195.google.com with SMTP id g123-v6so2512132ywf.13
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 11:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o6apYehDaPUZyg48N98XWth7ZE9Gx07x/RafeE7nBUo=;
        b=T4kshtMEYqH8uUsES1BS9+lNw8fRTDnhxAciOKLzIXf1Z5fLQsyVzT4oamo1HHBgzv
         ClPEd4vTtszO2B+sWns+imOTQsUUiTnP5vVvdMi/YegmFQW9xA/3X5pCeFpkdHLbOaow
         BTr95ot1FKq7hA0JRbNKq00SYE5T7JVfkB3V+IO9VUFWRLwC9A5ZF8XmGHr13hnZUhz7
         6NpzDxTOSmM1kwbQOPiY/AYxXUzu5KDoI4loYi6HQlirOWEaXMU0NItd+rODQ5YMYfxj
         EAshR9waYU7G8fUNQFIoPO2Q6mlxNg6pbgNtDidPuD4mUJMhRenu8iFaSKXWq3aamalX
         EgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o6apYehDaPUZyg48N98XWth7ZE9Gx07x/RafeE7nBUo=;
        b=YF/c0NshddG4oBuRtw/ashELEXJy5qCm/ylzp4jNZ2ZrPyrmZ+ZLZ4OQTKBeZCl4jt
         kch71Z8XJdOH0gVBeupFenZXtR4NBdhLQYLIIMwYQdvTG4uyoQYMhXgWHC8yvNZXRsEC
         mUQYovKcFe0Ui0+/HMPJ94R5LqhPZEyamkmyamQ6eZaKwco1DKtjv8gfOvZXYgCfvudH
         bZYuyP9RYfARgZopkkfpc9izUQqPq0d+vdZUxtQEyrPcODRFOwzINlvOk3ezy9v6VHwp
         ph+PfBwx+QWCKKh9deDq3MCLce9ArUj+3VrEAP1Msz4LX6a4E/diQRG/NkqIJcb38r7Q
         2s9g==
X-Gm-Message-State: APt69E2U1CkWbDHPclAuddjPo1A/jmVWWnRVJad9AzXkb2L+XGFyBIv9
        kDf/S8eZrMoY/sMmd7rFr9m4YFHHYbyO+bHPbpqexQ==
X-Google-Smtp-Source: AAOMgpcDUE4EBVHkrN8zobDfp9w4uU+gAmir2WQ7mJGDk+dXtfvtMTbHyXgxYknDxw9nqXdtZ7bK+95o6YtzxMrZbkg=
X-Received: by 2002:a81:b283:: with SMTP id q125-v6mr5688301ywh.414.1530211752853;
 Thu, 28 Jun 2018 11:49:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180628074655.5756-1-predatoramigo@gmail.com> <20180628074655.5756-3-predatoramigo@gmail.com>
In-Reply-To: <20180628074655.5756-3-predatoramigo@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 28 Jun 2018 11:49:01 -0700
Message-ID: <CAGZ79kZe46nkNd9yRZfwDG_-D-oBV5221qvB5zaj4Vw909U7fw@mail.gmail.com>
Subject: Re: [PATCH 2/5] rebase: start implementing it as a builtin
To:     Pratik Karki <predatoramigo@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alban Gruin <alban.gruin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 28, 2018 at 12:48 AM Pratik Karki <predatoramigo@gmail.com> wrote:
>
> This commit imitates the strategy that was used to convert the
> difftool to a builtin, see be8a90e (difftool: add a skeleton for the
> upcoming builtin, 2017-01-17) for details: This commit renames the
> shell script `git-rebase.sh` to `git-legacy-rebase.sh` and hands off to
> it by default.

That is a good way to start, imitating Johannes approach on rewriting
the difftool. Thanks for pointing this out.

> The current version of the builtin rebase does not, however, make full
> use of the internals but instead chooses to spawn a couple of Git
> processes to find out if we run the builtin or legacy rebase as that
> keeps the directory that we are in correct. There remains a lot
> of room for improvement, left for a later date. The following commits
> will recreate the functionality of the shell script, in pure C.
>
> We intentionally avoid reading the config directly to avoid
> messing up the GIT_* environment variables when we need to fall back to
> exec()ing the shell script.

Thanks for calling this out!

The test of builtin rebase can be done by
> `git -c rebase.useBuiltin=true rebase ...`
>
> Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
> ---
>  .gitignore                            |  1 +
>  Makefile                              |  3 +-
>  builtin.h                             |  1 +
>  builtin/rebase.c                      | 55 +++++++++++++++++++++++++++
>  git-rebase.sh => git-legacy-rebase.sh |  0
>  git.c                                 |  6 +++
>  6 files changed, 65 insertions(+), 1 deletion(-)
>  create mode 100644 builtin/rebase.c
>  rename git-rebase.sh => git-legacy-rebase.sh (100%)
>
> diff --git a/.gitignore b/.gitignore
> index 3284a1e9b..ec2395901 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -78,6 +78,7 @@
>  /git-init-db
>  /git-interpret-trailers
>  /git-instaweb
> +/git-legacy-rebase
>  /git-log
>  /git-ls-files
>  /git-ls-remote
> diff --git a/Makefile b/Makefile
> index 0cb6590f2..e88fe2e5f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -609,7 +609,7 @@ SCRIPT_SH += git-merge-one-file.sh
>  SCRIPT_SH += git-merge-resolve.sh
>  SCRIPT_SH += git-mergetool.sh
>  SCRIPT_SH += git-quiltimport.sh
> -SCRIPT_SH += git-rebase.sh
> +SCRIPT_SH += git-legacy-rebase.sh
>  SCRIPT_SH += git-remote-testgit.sh
>  SCRIPT_SH += git-request-pull.sh
>  SCRIPT_SH += git-stash.sh
> @@ -1059,6 +1059,7 @@ BUILTIN_OBJS += builtin/prune.o
>  BUILTIN_OBJS += builtin/pull.o
>  BUILTIN_OBJS += builtin/push.o
>  BUILTIN_OBJS += builtin/read-tree.o
> +BUILTIN_OBJS += builtin/rebase.o
>  BUILTIN_OBJS += builtin/rebase--helper.o
>  BUILTIN_OBJS += builtin/receive-pack.o
>  BUILTIN_OBJS += builtin/reflog.o
> diff --git a/builtin.h b/builtin.h
> index 0362f1ce2..44651a447 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -202,6 +202,7 @@ extern int cmd_prune_packed(int argc, const char **argv, const char *prefix);
>  extern int cmd_pull(int argc, const char **argv, const char *prefix);
>  extern int cmd_push(int argc, const char **argv, const char *prefix);
>  extern int cmd_read_tree(int argc, const char **argv, const char *prefix);
> +extern int cmd_rebase(int argc, const char **argv, const char *prefix);
>  extern int cmd_rebase__helper(int argc, const char **argv, const char *prefix);
>  extern int cmd_receive_pack(int argc, const char **argv, const char *prefix);
>  extern int cmd_reflog(int argc, const char **argv, const char *prefix);
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> new file mode 100644
> index 000000000..1152b7229
> --- /dev/null
> +++ b/builtin/rebase.c
> @@ -0,0 +1,55 @@
> +/*
> + * "git rebase" builtin command
> + *
> + * Copyright (c) 2018 Pratik Karki
> + */
> +
> +#include "builtin.h"
> +#include "run-command.h"
> +#include "exec-cmd.h"
> +#include "argv-array.h"
> +#include "dir.h"
> +
> +static int use_builtin_rebase(void)
> +{
> +       struct child_process cp = CHILD_PROCESS_INIT;
> +       struct strbuf out = STRBUF_INIT;
> +       int ret;
> +
> +       argv_array_pushl(&cp.args,
> +                        "config", "--bool", "rebase.usebuiltin", NULL);

--bool is documented as "Historical options for selecting
a type specifier. Prefer instead --type, (see: above)." in the
man page of git-config. But as this code will go away once
the conversion is done, this is not kept around for long.
So we should be fine using the --bool option.

> +       cp.git_cmd = 1;
> +       if (capture_command(&cp, &out, 6))
> +               return 0;
> +
> +       strbuf_trim(&out);
> +       ret = !strcmp("true", out.buf);

As --bool will make sure that the config command
prints "true" or "false", even when the user configured
0 or 1 instead, this is fine.

> +       if (argc != 2)
> +               die("Usage: %s <base>", argv[0]);
> +       prefix = setup_git_directory();
> +       trace_repo_setup(prefix);
> +       setup_work_tree();
> +
> +       die("TODO");

When reading the last sentence in the commit message
("This can be tested ...") I shortly wondered how we adapt the tests
but as this is really just the skeleton, there is no need to adapt any tests.

This patch looks fine to me except for the nit that Christian points out.

Thanks!
Stefan
