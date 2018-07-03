Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD94A1F516
	for <e@80x24.org>; Tue,  3 Jul 2018 07:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753903AbeGCHMq (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 03:12:46 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:39768 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752719AbeGCHMp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 03:12:45 -0400
Received: by mail-ua0-f193.google.com with SMTP id n4-v6so569113uad.6
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 00:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EpXxoTPKNQUzKQc0D8p5lELLWK24oJG8QcFir5IBHqA=;
        b=A1kBpjQ9YRZrPKOn+IG9MUcEDoCf+E4GBjjDyCC48a9Jx2G+9P3S7tVRtuGsUjmhOE
         jErc9XiMqLq12usfa5LzXupAoab0tmW+Ci3kUpN4RdTroWuRvjvYZsZ4IJIYBm/qJrr7
         V4+Sp9wL0xy/zMfpkt5iUwFGJfRpXe7R0iDAN4683G+Y2cr6z99c6G04En1vxYPvDFn7
         S959HHCsvxN2TiJRF8YEo3+TAmNBAZz0JKCE6txT6ENiykjjfEObGEVl3KTQgsunRcsc
         sSpwLg6Cze8Sm19aQ0GXYdfDKcBI8IyaORUZm7aFMXYj+eoJ1CSxfrMC0b7LdcEq+tB/
         1DCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EpXxoTPKNQUzKQc0D8p5lELLWK24oJG8QcFir5IBHqA=;
        b=Q/D5quImY5geP+HV70cO12RSozjN11EnkPFZYlpOD3MhLXq6tiF/67QOjwX9JH9Obc
         0as/LOmdRqfJ/7o2wJFZyU5mZqTBI1HARlSyHGOMTHdOd4mHMulkH4i7R9sr/zreEHxU
         ef8yCaBYrfQ8YwrXIIgCJIJqqFBfY4nHwly/6LImaSrn5RKEBxscdhQ1K7ZbVDiQ1N+x
         5qzcjoGL1AMk4i+JF1s8fYeyGhPBEg3sf/29mHA1ZCf5ZG30IfveIDSwuNARnNVlX7Lc
         KLQcZ6xNfjREmSuL097SdrKCeLitqfm6Bx89fapnzsDVSF/399+BBhmIOQi4liYUOrnv
         jX2w==
X-Gm-Message-State: APt69E1BwPmMoLH+i36z4b2GFs3kPa1zFWD0aCa+67iUAywLXjMcTOWv
        PHGyAdU9Wbm/lNrJOD41jzxgJeFNABZ2aeIfOmo=
X-Google-Smtp-Source: AAOMgpfDBJBmEdJEQVQzIRdEWesaVPyBNDRThRX8mSP5uw4ZAfY8xCVbVi3hON+cqj9Iu3uspRnkPbeRxF1zNyLF7Xw=
X-Received: by 2002:ab0:12e2:: with SMTP id o34-v6mr9746670uac.154.1530601964251;
 Tue, 03 Jul 2018 00:12:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:21c7:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 00:12:43 -0700 (PDT)
In-Reply-To: <20180703035802.24060-1-jyn514@gmail.com>
References: <20180703035802.24060-1-jyn514@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 3 Jul 2018 00:12:43 -0700
Message-ID: <CABPp-BFu+m-7Fyf4kj8hUO33vhAxKuAu5JnyL5Tzc7c6Kq+Hjg@mail.gmail.com>
Subject: Re: [PATCH 1/3] ls-tree: make <tree-ish> optional
To:     Joshua Nelson <jyn514@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 2, 2018 at 8:58 PM, Joshua Nelson <jyn514@gmail.com> wrote:
> use syntax similar to `git-checkout` to make <tree-ish> optional for
> `ls-tree`. if <tree-ish> is omitted, default to HEAD. infer arguments as
> follows:
>
> 1. if args start with --
>         assume <tree-ish> to be HEAD
> 2. if exactly one arg precedes --, treat the argument as <tree-ish>
> 3. if more than one arg precedes --, exit with an error
> 4. if -- is not in args
>         a) if args[0] is a valid <tree-ish> object, treat is as such
>         b) else, assume <tree-ish> to be HEAD
>
> in all cases, every argument besides <tree-ish> is treated as a <path>

Cool, this is something I've wanted a few times.  Thanks for
submitting.  A few minor issues:
  1. Could you start sentences with capitals?  Thus, 'Use syntax...',
'Infer arguments...', 'In all cases...', etc.
  2. Missing Signed-off-by on this commit (and commit 2); I notice you
correctly added it to commit 3.

Also, additional issues below...

> ---
>  builtin/ls-tree.c | 39 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 34 insertions(+), 5 deletions(-)
>
> diff --git builtin/ls-tree.c builtin/ls-tree.c
> index 409da4e83..14102b052 100644
> --- builtin/ls-tree.c
> +++ builtin/ls-tree.c

Do you have diff.noprefix set?  It took me a little bit to realize
that this was the reason your patches weren't applying for me.

> @@ -153,7 +153,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
>                 chomp_prefix = strlen(prefix);
>
>         argc = parse_options(argc, argv, prefix, ls_tree_options,
> -                            ls_tree_usage, 0);
> +                            ls_tree_usage, PARSE_OPT_KEEP_DASHDASH);
>         if (full_tree) {
>                 ls_tree_prefix = prefix = NULL;
>                 chomp_prefix = 0;
> @@ -163,10 +163,39 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
>             ((LS_TREE_ONLY|LS_RECURSIVE) & ls_options))
>                 ls_options |= LS_SHOW_TREES;
>
> +       const char *object;
> +       short initialized = 0;

This will fail to compile under 'make DEVELOPER=1' (ISO C90 forbids
mixed declarations and code).

>         if (argc < 1)
> -               usage_with_options(ls_tree_usage, ls_tree_options);
> -       if (get_oid(argv[0], &oid))
> -               die("Not a valid object name %s", argv[0]);
> +               object = "HEAD";
> +       else {
> +               /* taken from checkout.c;
> +                * we have a simpler case because we never create a branch */

/*
 * multi-line comment style in git utilizes puts the first word on the
 * second line, and terminates on its own line, like this.
 */

Also, I was going to ask if this code should be put into a utility
function or something, but it isn't taken verbatim from checkout.c,
just adopted from there.

> +               short dash_dash_pos = -1, i = 0;
> +               for (; i < argc; i++) {

Any reason you moved the i = 0 to the line before?  I thought 'i' was
uninitialized and almost commented to that effect before I noticed
where it was.

> +                       if (!strcmp(argv[i], "--")) {
> +                               dash_dash_pos = i;
> +                               break;
> +                       }
> +               }
> +               if (dash_dash_pos == 0) {
> +                       object = "HEAD";
> +                       argv++, argc++;
> +               } else if (dash_dash_pos == 1) {
> +                       object = argv[0];
> +                       argv += 2, argc += 2;
> +               } else if (dash_dash_pos >= 2)
> +                       die(_("only one reference expected, %d given."), dash_dash_pos);
> +               else if (get_oid(argv[0], &oid)) // not a valid object
> +                       object = "HEAD";
> +               else {
> +                       argv++, argc++;
> +                       initialized = 1;
> +               }
> +       }
> +
> +       if (!initialized) // if we've already run get_oid, don't run it again
> +               if (get_oid(object, &oid))
> +                       die("Not a valid object name %s", object);
>
>         /*
>          * show_recursive() rolls its own matching code and is
> @@ -177,7 +206,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
>         parse_pathspec(&pathspec, PATHSPEC_ALL_MAGIC &
>                                   ~(PATHSPEC_FROMTOP | PATHSPEC_LITERAL),
>                        PATHSPEC_PREFER_CWD,
> -                      prefix, argv + 1);
> +                      prefix, argv);
>         for (i = 0; i < pathspec.nr; i++)
>                 pathspec.items[i].nowildcard_len = pathspec.items[i].len;
>         pathspec.has_wildcard = 0;
> --
> 2.18.GIT
>
