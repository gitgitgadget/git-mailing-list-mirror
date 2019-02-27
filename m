Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48B4B20248
	for <e@80x24.org>; Wed, 27 Feb 2019 11:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbfB0LIL (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Feb 2019 06:08:11 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:52478 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfB0LIL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Feb 2019 06:08:11 -0500
Received: by mail-it1-f196.google.com with SMTP id g17so552212ita.2
        for <git@vger.kernel.org>; Wed, 27 Feb 2019 03:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D/jN5c3LQVKuemRK7iO6NM6mQ2zB3zogN5Hu7wNpsLw=;
        b=lNMduY9tqW5/6cvXcL9Gn1jmZ67GM/TJQeLSTFS1F6FsbR2fOFT7UB2l7ybh2vQiGa
         2QJONXHN7jubBorvnlZ9psvRACwxgOCeODL2T46FJqvLr/46PGcuwDqr73gszdR+9rKp
         fwVrWBuQ/IX7ByjBFRdFmutK3JU/x3CYuFqbST0ZHHkATYKLtAnOAktb4yOj6waVCQw6
         F3GI1xAb0YlGstMV0ND11OhjA1lnvE0yCwp8U/u9T8MkAEGMJm7+GCPK2fStfEhmdFVl
         M3vAvuwDNCr1L/54yQnDt7/tckg04Kp35V7sOWmo0s+ZyyT9qEv9V+I2CjI3JQWegDMt
         DNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D/jN5c3LQVKuemRK7iO6NM6mQ2zB3zogN5Hu7wNpsLw=;
        b=MCheh5gCmhJtfZiCuEcx5nJueOTnTa9G/8QrhaRMBwdGiGa4fuJcfGiAifLySNUSCx
         uORTdSOmXCZQIJ4vwV8Dk6iagQae7tjwrNdQzatPX7hPj4NEwX+FyjO/suzPAfoA6v1E
         9KPFdZjKbGLlkhb0DZpqQn+WaXc+chcxHTohr28uocVuNhNs6w6p36NIuJ14LPzlqZLm
         +ghUml+PkXQPFU/cWGG/8AfsiSbyaNAzNdz8rj2sPVynWFtpsvKnvXdPFXFC6T1NT6PC
         44Lny+VuaFmSNGtE1VqrLDaSN6kGov3HDw1Frc+iF3B/1e6pKbwELkge41bUxH+qDu9p
         2GSw==
X-Gm-Message-State: AHQUAubqlYLbgIaCzMiGoOzh5L1eL/vJrSSj911pIf7mLgwy2Doki5uV
        tU9EPIshrc1bovhJrV/NdVy9nSCQeN1ocu7yHNU=
X-Google-Smtp-Source: APXvYqyAbghlnBJS0oTkSPo5rO+qoB4dSPt+Fr4BjO3T3ngwmGsHHmK0okRxX5Dk+SAbkV9fGFsmAyJhl5BX3LaumbU=
X-Received: by 2002:a24:7542:: with SMTP id y63mr1044334itc.70.1551265689432;
 Wed, 27 Feb 2019 03:08:09 -0800 (PST)
MIME-Version: 1.0
References: <20190226200952.33950-1-brandon1024.br@gmail.com>
In-Reply-To: <20190226200952.33950-1-brandon1024.br@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 27 Feb 2019 18:07:42 +0700
Message-ID: <CACsJy8Bgz6FiTqnq8pnebuyOr55Bqh67iRhr6J+WvzgxPSBLhw@mail.gmail.com>
Subject: Re: [PATCH] commit-tree: utilize parse-options api
To:     Brandon <brandon1024.br@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 27, 2019 at 3:10 AM Brandon <brandon1024.br@gmail.com> wrote:
>
> From: Brandon Richardson <brandon1024.br@gmail.com>
>
> Rather than parse options manually, which is both difficult to
> read and error prone, parse options supplied to commit-tree
> using the parse-options api.
>
> It was discovered that the --no-gpg-sign option was documented
> but not implemented in 55ca3f99, and the existing implementation

Most people refer to a commit with this format

55ca3f99ae (commit-tree: add and document --no-gpg-sign - 2013-12-13)

It gives the reader some context without actually looking at the
commit in question. And in the event that 55ca3f99 is ambiguous, it's
easier to find the correct one.


> would attempt to translate the option as a tree oid.It was also
> suggested in 55ca3f99 that commit-tree should be migrated to
> utilize the parse-options api, which could help prevent mistakes
> like this in the future. Hence this change.
>
> Signed-off-by: Brandon Richardson <brandon1024.br@gmail.com>
> ---
>
> Notes:
>     GitHub Pull Request: https://github.com/brandon1024/git/pull/1
>     Travis CI Results: https://travis-ci.com/brandon1024/git/builds/102337393
>
>  builtin/commit-tree.c | 162 ++++++++++++++++++++++++------------------
>  1 file changed, 92 insertions(+), 70 deletions(-)
>
> diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
> index 12cc403bd7..310f38d000 100644
> --- a/builtin/commit-tree.c
> +++ b/builtin/commit-tree.c
> @@ -12,8 +12,14 @@
>  #include "builtin.h"
>  #include "utf8.h"
>  #include "gpg-interface.h"
> +#include "parse-options.h"
> +#include "string-list.h"
>
> -static const char commit_tree_usage[] = "git commit-tree [(-p <sha1>)...] [-S[<keyid>]] [-m <message>] [-F <file>] <sha1>";
> +static const char * const builtin_commit_tree_usage[] = {
> +       N_("git commit-tree [(-p <parent>)...] [-S[<keyid>]] [(-m <message>)...] "
> +               "[(-F <file>)...] <tree>"),
> +       NULL
> +};
>
>  static const char *sign_commit;
>
> @@ -39,87 +45,103 @@ static int commit_tree_config(const char *var, const char *value, void *cb)
>         return git_default_config(var, value, cb);
>  }
>
> +static int parse_parent_arg_callback(const struct option *opt,
> +               const char *arg, int unset)
> +{
> +       struct object_id oid;
> +       struct commit_list **parents = opt->value;
> +
> +       BUG_ON_OPT_NEG(unset);
> +
> +       if (!arg)
> +               return 1;

This "return 1;" surprises me because I think we often just return 0
or -1. I know !arg cannot happen here, so maybe just drop it. Or if
you want t play absolutely safe, maybe add a new macro like

BUG_ON_NO_ARG(arg);

which conveys the intention much better.

> +       if (get_oid_commit(arg, &oid))
> +               die("Not a valid object name %s", arg);

I'm asking extra so feel free to ignore. But maybe you could mark this
string for translation as well while we're here? Also these die()
messages should start with a lowercase because when printed, it is
prefixed with "fatal: " so "Not" is not at the beginning of the
sentence anymore. So...

die(_("not a valid object name %s", arg);

The same comment for other error strings.

> +
> +       assert_oid_type(&oid, OBJ_COMMIT);
> +       new_parent(lookup_commit(the_repository, &oid), parents);
> +       return 0;
> +}
> +
> +static int parse_message_arg_callback(const struct option *opt,
> +               const char *arg, int unset)

In general we should try to avoid custom callbacks (more code, harder
to understand...). Could we just use OPT_STRING_LIST() for handling
-m?

If you do, then you'll collect all -m values in a string list and can
do the \n completion after parse_options().

> +{
> +       struct strbuf *buf = opt->value;
> +
> +       BUG_ON_OPT_NEG(unset);
> +
> +       if (!arg)
> +               return 1;
> +       if (buf->len)
> +               strbuf_addch(buf, '\n');
> +       strbuf_addstr(buf, arg);
> +       strbuf_complete_line(buf);
> +
> +       return 0;
> +}
> +
> +static int parse_file_arg_callback(const struct option *opt,
> +               const char *arg, int unset)

I would suggest you do the same for -F, i.e. collect a string list of
paths then do the heavy lifting afterwards _IF_ we don't support
mixing -m and -F. If we do, then we have to handle both in callbacks
to make sure we compose the message correctly.

> +{
> +       int fd;
> +       struct strbuf *buf = opt->value;
> +
> +       BUG_ON_OPT_NEG(unset);
> +
> +       if (!arg)
> +               return 1;
> +       if (buf->len)
> +               strbuf_addch(buf, '\n');
> +       if (!strcmp(arg, "-"))
> +               fd = 0;
> +       else {
> +               fd = open(arg, O_RDONLY);
> +               if (fd < 0)
> +                       die_errno("git commit-tree: failed to open '%s'", arg);
> +       }
> +       if (strbuf_read(buf, fd, 0) < 0)
> +               die_errno("git commit-tree: failed to read '%s'", arg);
> +       if (fd && close(fd))
> +               die_errno("git commit-tree: failed to close '%s'", arg);
> +
> +       return 0;
> +}
> +
>  int cmd_commit_tree(int argc, const char **argv, const char *prefix)
>  {
> -       int i, got_tree = 0;
> +       static struct strbuf buffer = STRBUF_INIT;
>         struct commit_list *parents = NULL;
>         struct object_id tree_oid;
>         struct object_id commit_oid;
> -       struct strbuf buffer = STRBUF_INIT;
> +
> +    struct option builtin_commit_tree_options[] = {

It's a local variable. I think we can just go with a shorter name like
"options". Less to type later. Shorter lines.

> +               { OPTION_CALLBACK, 'p', NULL, &parents, "parent",

Wrap N_() around "parent" so it can be translated.

> +                 N_("id of a parent commit object"), PARSE_OPT_NONEG,
> +                 parse_parent_arg_callback },
> +               { OPTION_CALLBACK, 'm', NULL, &buffer, N_("message"),
> +                 N_("commit message"), PARSE_OPT_NONEG,
> +                 parse_message_arg_callback },
> +               { OPTION_CALLBACK, 'F', NULL, &buffer, N_("file"),
> +                 N_("read commit log message from file"), PARSE_OPT_NONEG,
> +                 parse_file_arg_callback },
> +               { OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key-id"),
> +                 N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },

Avoid raw struct declaration if possible. Will OPT_STRING() macro work?

> +               OPT_END()
> +    };

I think you're using spaces here to indent instead of TABs.

>
>         git_config(commit_tree_config, NULL);
>
>         if (argc < 2 || !strcmp(argv[1], "-h"))
> -               usage(commit_tree_usage);
> -
> -       for (i = 1; i < argc; i++) {
> -               const char *arg = argv[i];
> -               if (!strcmp(arg, "-p")) {
> -                       struct object_id oid;
> -                       if (argc <= ++i)
> -                               usage(commit_tree_usage);
> -                       if (get_oid_commit(argv[i], &oid))
> -                               die("Not a valid object name %s", argv[i]);
> -                       assert_oid_type(&oid, OBJ_COMMIT);
> -                       new_parent(lookup_commit(the_repository, &oid),
> -                                                &parents);
> -                       continue;
> -               }
> +               usage_with_options(builtin_commit_tree_usage, builtin_commit_tree_options);
>
> -               if (!strcmp(arg, "--gpg-sign")) {
> -                   sign_commit = "";
> -                   continue;
> -               }
> -
> -               if (skip_prefix(arg, "-S", &sign_commit) ||
> -                       skip_prefix(arg, "--gpg-sign=", &sign_commit))
> -                       continue;
> -
> -               if (!strcmp(arg, "--no-gpg-sign")) {
> -                       sign_commit = NULL;
> -                       continue;
> -               }
> +       argc = parse_options(argc, argv, prefix, builtin_commit_tree_options,
> +                       builtin_commit_tree_usage, 0);
>
> -               if (!strcmp(arg, "-m")) {
> -                       if (argc <= ++i)
> -                               usage(commit_tree_usage);
> -                       if (buffer.len)
> -                               strbuf_addch(&buffer, '\n');
> -                       strbuf_addstr(&buffer, argv[i]);
> -                       strbuf_complete_line(&buffer);
> -                       continue;
> -               }
> -
> -               if (!strcmp(arg, "-F")) {
> -                       int fd;
> -
> -                       if (argc <= ++i)
> -                               usage(commit_tree_usage);
> -                       if (buffer.len)
> -                               strbuf_addch(&buffer, '\n');
> -                       if (!strcmp(argv[i], "-"))
> -                               fd = 0;
> -                       else {
> -                               fd = open(argv[i], O_RDONLY);
> -                               if (fd < 0)
> -                                       die_errno("git commit-tree: failed to open '%s'",
> -                                                 argv[i]);
> -                       }
> -                       if (strbuf_read(&buffer, fd, 0) < 0)
> -                               die_errno("git commit-tree: failed to read '%s'",
> -                                         argv[i]);
> -                       if (fd && close(fd))
> -                               die_errno("git commit-tree: failed to close '%s'",
> -                                         argv[i]);
> -                       continue;
> -               }
> +       if (argc != 1)
> +               die("Must give exactly one tree");
>
> -               if (get_oid_tree(arg, &tree_oid))
> -                       die("Not a valid object name %s", arg);
> -               if (got_tree)
> -                       die("Cannot give more than one trees");
> -               got_tree = 1;
> -       }
> +       if (get_oid_tree(argv[0], &tree_oid))
> +               die("Not a valid object name %s", argv[0]);
>
>         if (!buffer.len) {
>                 if (strbuf_read(&buffer, 0, 0) < 0)
> --
> 2.21.0
>


-- 
Duy
