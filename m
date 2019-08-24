Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B42CC1F461
	for <e@80x24.org>; Sat, 24 Aug 2019 05:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbfHXFII (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Aug 2019 01:08:08 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:43339 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfHXFII (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Aug 2019 01:08:08 -0400
Received: by mail-vk1-f194.google.com with SMTP id b11so2860511vkk.10
        for <git@vger.kernel.org>; Fri, 23 Aug 2019 22:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=52N5An3H8lucwsGf71MKKYhTdpz0I/Ge09XsI3ocfxE=;
        b=ezryLrxv8c62Wx9VQjJKJhqQMReHWlYunRjQxxJ4zcImup2KgQJI3XDyIptBKoZutO
         uvalXM69tVDUApmHr+JeDFgb3KlCXPVQbak3qwWF8ml0VyUMt7vXeefeBGS8TAjgGmo1
         sht8a/KhYE33kz6UCwpqL6raLdkFZSJBppbKbO/ypXNKC5jFIWHBHieFTiSoYQ7wE023
         unk/VsTtHr4KGG6aHKO1LeeJvYvnRqQv01IIHKCkWX3jPoq3zCp/ZDfF9hWsx2g+CWZI
         o4SuBrvA9JjTwSrRt9xuF/GwyOErNVGpGvLXupTLQMJkaeLvNRGHFSmtBT0M+WYVR0I/
         SRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=52N5An3H8lucwsGf71MKKYhTdpz0I/Ge09XsI3ocfxE=;
        b=BQQVd06qTaM7jd5+PkEDebYv33glxtuGTOiCUotWrK/7I3QgZq/O7PHiYDYAxXeHHK
         GABOlcVI4SHpFUDsoC1Ui+oOey3yzMMPLOQAfjuko4T728DTwZgnQPCo5jmBKN0wsf6T
         GpuWI6eg4XgN6QeFIU6FJoWqOcYtmMxIfctu3GIGfARiiLREH8+rBOfDwJzzxeSw1vz7
         CSricU+ZBW9XxSp5nvmeEpx2f4iSqODzjaHvssDHOqXzZOahSHZ1gi8kNvtZFy70TaaF
         J32IhAD9FFifIkvRbm5n6D+quj/DW395jPmbugWvJtKIkx27EntEjsOYXEo3s3sZPNRJ
         fo4A==
X-Gm-Message-State: APjAAAVnXzigi9XhmhKmOayEAeNVQhrcuv1rXSsuOFnR4iG8GjO83qwN
        qOH899fteylZEaAQ2GHevspunsIqbDJMX/kOaiE=
X-Google-Smtp-Source: APXvYqx3erbe6Gtp8GHKFZ8VgypncuCA0oOMRucgIhkssFz5B6UL41q/+NOTFsf+pTF9ZBYMt+ST8hLTDb+ikqgO568=
X-Received: by 2002:a1f:5fc4:: with SMTP id t187mr4206502vkb.37.1566623286360;
 Fri, 23 Aug 2019 22:08:06 -0700 (PDT)
MIME-Version: 1.0
References: <pull.316.git.gitgitgadget@gmail.com> <568fda2d0395ae82e8b0c43f6e5757d45b50a508.1566313865.git.gitgitgadget@gmail.com>
In-Reply-To: <568fda2d0395ae82e8b0c43f6e5757d45b50a508.1566313865.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 23 Aug 2019 22:07:55 -0700
Message-ID: <CABPp-BH13XbNR3MQKE7cHO5e=pMY7kLtGhkX1SQg_o9it=uUug@mail.gmail.com>
Subject: Re: [PATCH 9/9] sparse-checkout: init and add in cone mode
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 20, 2019 at 8:12 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>

Perhaps "sparse-checkout: modify 'init' and 'add' for cone mode" for
the summary?

> From: Derrick Stolee <dstolee@microsoft.com>
>
> To make the cone pattern set easy to use, update the behavior of
> 'git sparse-checkout [init|add]'.

Maybe switch these phrases around (starting with "Update", ending with "use.")

> Add '--cone' flag to 'git sparse-checkout init' to set the config
> option 'core.sparseCheckout=cone'.
>
> When running 'git sparse-checkout add' in cone mode, a user only
> needs to supply a list of recursive folder matches. Git will
> automatically add the necessary parent matches for the leading
> directories.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/sparse-checkout.c          | 134 +++++++++++++++++++++++++++--
>  t/t1091-sparse-checkout-builtin.sh |  35 ++++++++
>  2 files changed, 164 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index 77e5235720..0a4e101ddd 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -6,15 +6,22 @@
>  #include "repository.h"
>  #include "run-command.h"
>  #include "strbuf.h"
> +#include "string-list.h"
>
>  static char const * const builtin_sparse_checkout_usage[] = {
>         N_("git sparse-checkout [init|add|list|disable]"),
>         NULL
>  };
>
> +static const char * const builtin_sparse_checkout_init_usage[] = {
> +       N_("git sparse-checkout init [--cone]"),
> +       NULL
> +};
> +
>  struct opts_sparse_checkout {
>         const char *subcommand;
>         int read_stdin;
> +       int cone;
>  } opts;
>
>  static char *get_sparse_checkout_filename(void)
> @@ -41,6 +48,60 @@ static void write_excludes_to_file(FILE *fp, struct exclude_list *el)
>         }
>  }
>
> +static void write_cone_to_file(FILE *fp, struct exclude_list *el)
> +{
> +       int i;
> +       struct exclude_entry *entry;
> +       struct hashmap_iter iter;
> +       struct string_list sl = STRING_LIST_INIT_DUP;
> +
> +       hashmap_iter_init(&el->parent_hashmap, &iter);
> +       while ((entry = hashmap_iter_next(&iter))) {
> +               char *pattern = xstrdup(entry->pattern);
> +               char *converted = pattern;
> +               if (pattern[0] == '/')
> +                       converted++;
> +               if (pattern[entry->patternlen - 1] == '/')
> +                       pattern[entry->patternlen - 1] = 0;
> +               string_list_insert(&sl, converted);
> +               free(pattern);
> +       }
> +
> +       string_list_sort(&sl);

I was worried that if someone had a directory named '(parenthetical)'
or '%looks_like_a_comment' that they wanted to include in cone mode,
that since '*' sorts after '(' and '%' that entries would appear in
sparse-checkout in the wrong order.  But you are comparing on the
directory name, not the full line that will be written to the
sparse-checkout file (i.e. without the trailing '/*'), so my worries
were unfounded and there's no actual problem here.

> +       string_list_remove_duplicates(&sl, 0);
> +
> +       for (i = 0; i < sl.nr; i++) {
> +               char *pattern = sl.items[i].string;
> +
> +               if (!strcmp(pattern, ""))
> +                       fprintf(fp, "/*\n!/*/*\n");
> +               else
> +                       fprintf(fp, "/%s/*\n!/%s/*/*\n", pattern, pattern);
> +       }
> +
> +       string_list_clear(&sl, 0);
> +
> +       hashmap_iter_init(&el->recursive_hashmap, &iter);
> +       while ((entry = hashmap_iter_next(&iter))) {
> +               char *pattern = xstrdup(entry->pattern);
> +               char *converted = pattern;
> +               if (pattern[0] == '/')
> +                       converted++;
> +               if (pattern[entry->patternlen - 1] == '/')
> +                       pattern[entry->patternlen - 1] = 0;
> +               string_list_insert(&sl, converted);
> +               free(pattern);
> +       }
> +
> +       string_list_sort(&sl);
> +       string_list_remove_duplicates(&sl, 0);
> +
> +       for (i = 0; i < sl.nr; i++) {
> +               char *pattern = sl.items[i].string;
> +               fprintf(fp, "/%s/*\n", pattern);
> +       }
> +}
> +
>  static int sparse_checkout_list(int argc, const char **argv)

Should the list mode in cone mode be modified to just show the
directories the user added?  It seems a little weird to show the
internal details of the implementation (all the parent directories and
negated entries and whatnot).  That's also not in a form that users
can pass along to future `sparse-checkout add` invocations.

In fact, maybe the implementation should be changed?  Perhaps we
should write out a .git/info/sparse-checkout-cone file instead with
just the wanted directories (with a trailing slash to permit future
addition of individual paths without bringing parents along)?  It'd be
easier on the parsing, and older git doesn't work with cone mode
anyway:

$ /usr/bin/git status
fatal: bad numeric config value 'cone' for 'core.sparsecheckout': invalid unit

Or, if we need to make old git work reasonably with cone mode, we
could write *both* .git/info/sparse-checkout-cone and
.git/info/sparse-checkout, but the latter begins with a comment
something akin to:

# DO NOT EDIT; auto-generated by 'git sparse-checkout' command and
only used by older git clients; see .git/info/sparse-checkout-clone
for active settings

>  {
>         struct exclude_list el;
> @@ -141,8 +202,21 @@ static int sparse_checkout_init(int argc, const char **argv)
>         char *sparse_filename;
>         FILE *fp;
>         int res;
> +       enum sparse_checkout_mode mode;
>
> -       if (sc_set_config(SPARSE_CHECKOUT_FULL))
> +       static struct option builtin_sparse_checkout_init_options[] = {
> +               OPT_BOOL(0, "cone", &opts.cone,
> +                        N_("initialize the sparse-checkout in cone mode")),
> +               OPT_END(),
> +       };
> +
> +       argc = parse_options(argc, argv, NULL,
> +                            builtin_sparse_checkout_init_options,
> +                            builtin_sparse_checkout_init_usage, 0);
> +
> +       mode = opts.cone ? SPARSE_CHECKOUT_CONE : SPARSE_CHECKOUT_FULL;
> +
> +       if (sc_set_config(mode))
>                 return 1;
>
>         memset(&el, 0, sizeof(el));
> @@ -183,6 +257,34 @@ static int sparse_checkout_init(int argc, const char **argv)
>         return sc_read_tree();
>  }
>
> +static void insert_recursive_pattern(struct exclude_list *el, struct strbuf *path)
> +{
> +       struct exclude_entry *e = xmalloc(sizeof(struct exclude_entry));
> +       e->patternlen = path->len;
> +       e->pattern = strbuf_detach(path, NULL);
> +       hashmap_entry_init(e, memhash(e->pattern, e->patternlen));
> +
> +       hashmap_add(&el->recursive_hashmap, e);
> +
> +       while (e->patternlen) {
> +               char *slash = strrchr(e->pattern, '/');
> +               char *oldpattern = e->pattern;
> +               size_t newlen;
> +
> +               if (!slash)
> +                       break;
> +
> +               newlen = slash - e->pattern;
> +               e = xmalloc(sizeof(struct exclude_entry));
> +               e->patternlen = newlen;
> +               e->pattern = xstrndup(oldpattern, newlen);
> +               hashmap_entry_init(e, memhash(e->pattern, e->patternlen));
> +
> +               if (!hashmap_get(&el->parent_hashmap, e, NULL))
> +                       hashmap_add(&el->parent_hashmap, e);
> +       }
> +}
> +
>  static int sparse_checkout_add(int argc, const char **argv)
>  {
>         struct exclude_list el;
> @@ -196,11 +298,33 @@ static int sparse_checkout_add(int argc, const char **argv)
>         add_excludes_from_file_to_list(sparse_filename, "", 0, &el, NULL);
>
>         fp = fopen(sparse_filename, "w");
> -       write_excludes_to_file(fp, &el);
>
> -       while (!strbuf_getline(&line, stdin)) {
> -               strbuf_trim(&line);
> -               fprintf(fp, "%s\n", line.buf);
> +       if (core_sparse_checkout == SPARSE_CHECKOUT_FULL) {
> +               write_excludes_to_file(fp, &el);
> +
> +               while (!strbuf_getline(&line, stdin)) {
> +                       strbuf_trim(&line);
> +                       fprintf(fp, "%s\n", line.buf);
> +               }
> +       } else if (core_sparse_checkout == SPARSE_CHECKOUT_CONE) {
> +               while (!strbuf_getline(&line, stdin)) {
> +                       strbuf_trim(&line);
> +
> +                       strbuf_trim_trailing_dir_sep(&line);
> +
> +                       if (!line.len)
> +                               continue;
> +
> +                       if (line.buf[0] == '/')
> +                               strbuf_remove(&line, 0, 1);
> +
> +                       if (!line.len)
> +                               continue;
> +
> +                       insert_recursive_pattern(&el, &line);
> +               }
> +
> +               write_cone_to_file(fp, &el);
>         }

No sanity checking that the user provided directory names rather than
globs or regexes?  Won't that silently do nothing, suggesting we need
to warn users?  Or are we just assuming that any 'glob' or 'regex'
characters they provide are actually meant as literal characters in a
pathname?

Also, what if they try to add an exclusion rule for a directory to
undo their add?  e.g.
  echo "!some/subdir/" | git sparse-checkout add
?

Is there a way to undo an add without undoing everything?  (Perhaps if
'git sparse-checkout list' showed just the added directories, it'd be
easy for users to take that output, delete one they don't want, and
then deal with undo and redoing.  Is that how we should handle it?)

>
>         fclose(fp);
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index 60f10864a1..3412bafdff 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -157,4 +157,39 @@ test_expect_success 'sparse-checkout disable' '
>         test_cmp expect dir
>  '
>
> +test_expect_success 'cone mode: init and add' '
> +       git -C repo sparse-checkout init --cone &&
> +       git -C repo config --list >config &&
> +       test_i18ngrep "core.sparsecheckout=cone" config &&
> +       ls repo >dir  &&
> +       echo a >expect &&
> +       test_cmp expect dir &&
> +       echo deep/deeper1/deepest | git -C repo sparse-checkout add &&
> +       ls repo >dir  &&
> +       cat >expect <<-EOF &&
> +               a
> +               deep
> +       EOF
> +       ls repo/deep >dir  &&
> +       cat >expect <<-EOF &&
> +               a
> +               deeper1
> +       EOF
> +       ls repo/deep/deeper1 >dir  &&
> +       cat >expect <<-EOF &&
> +               a
> +               deepest
> +       EOF
> +       test_cmp expect dir &&
> +       cat >expect <<-EOF &&
> +               /*
> +               !/*/*
> +               /deep/*
> +               !/deep/*/*
> +               /deep/deeper1/*
> +               !/deep/deeper1/*/*
> +               /deep/deeper1/deepest/*
> +       EOF
> +       test_cmp expect repo/.git/info/sparse-checkout
> +'
>  test_done
> \ No newline at end of file
> --
> gitgitgadget
