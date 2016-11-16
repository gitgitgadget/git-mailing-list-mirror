Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75EDE2021E
	for <e@80x24.org>; Wed, 16 Nov 2016 00:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753859AbcKPAHc (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 19:07:32 -0500
Received: from mail-qt0-f175.google.com ([209.85.216.175]:32872 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752194AbcKPAHb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 19:07:31 -0500
Received: by mail-qt0-f175.google.com with SMTP id p16so86608555qta.0
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 16:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YfmFHpz/YWxH/w34gxg9CnRCmrB69gANy8wCoTwgKIo=;
        b=JViSxQkUhzwuhJsgD/5S1YeoGQrHmtm58q1IF6lxZcgc5vH2goPCvtSMSjx1bEs1V1
         6IH/pcAB8pf3qkC5I+ihKMFz5jQwywvsSbtDeovVsrIXGTby23CTKwznz7jJgqM5dtlV
         PDkxH5pi2LyRVDo8Yfgx3G+k5z4kLtyt/PN55yPjp49OCcItiPSTO9q2UWDR98xLw+Ia
         Cp1/5OffMADR3KRBPDkmr30h9ErbYf23HDttqhPCe3Eosc7Piu11B1yF9hvIF9jirfWk
         dHKABiPmZ77XldW5YO38DyZj9kXHKKLNKAXoNaUq+HQaYur4c3wOpXrLH8diWKpKEKuT
         85aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YfmFHpz/YWxH/w34gxg9CnRCmrB69gANy8wCoTwgKIo=;
        b=cV+7h2mDBrwCnRRiIsYh9jj+kDvKBoxcJABV9B7mgg8kkac3JBtIZU9owcKJx+2wiO
         cVT6v4OKnXsnxVJoms2jmYP7VQWvBDczknWbCIvMc57H5oRajh/KVNrxUjL+kSFSyqfT
         gKJh4GGXvuwwV7Zp7cMiYNiRhoVv46dW6tuz1I8tKxlJC867hCAO+Mo82l6rd2PAUM0O
         TeWBJzxcxZli7zg9oqNlapFGlio74iu6xT+vNyxROYLI6o0xI3/6swKVxPUMs30flqG0
         uTVg+fEQXR1yzVXppseKsUxLWxcQE56uDqEekfBg/Yp5k8xHSve9Y/Y8uaztVq4vrLom
         D/ew==
X-Gm-Message-State: ABUngvdtY+9PhnggAiem5AAPezbiFeMjOI9LB49IvufDI7iPsqEfpk9+RiKE7xbyJwvfKFUBt76Y5FVnPTL/Fyr+
X-Received: by 10.237.34.206 with SMTP id q14mr51800qtc.101.1479254849887;
 Tue, 15 Nov 2016 16:07:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Tue, 15 Nov 2016 16:07:29 -0800 (PST)
In-Reply-To: <1478908273-190166-5-git-send-email-bmwill@google.com>
References: <1477953496-103596-1-git-send-email-bmwill@google.com>
 <1478908273-190166-1-git-send-email-bmwill@google.com> <1478908273-190166-5-git-send-email-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 15 Nov 2016 16:07:29 -0800
Message-ID: <CAGZ79kZiAWTySJrSvav6Yuj8v9PF0JzaSJHFTOdUo6eYFTS1+A@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] grep: optionally recurse into submodules
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
> Allow grep to recognize submodules and recursively search for patterns in
> each submodule.  This is done by forking off a process to recursively
> call grep on each submodule.  The top level --super-prefix option is
> used to pass a path to the submodule which can in turn be used to
> prepend to output or in pathspec matching logic.
>
> Recursion only occurs for submodules which have been initialized and
> checked out by the parent project.  If a submodule hasn't been
> initialized and checked out it is simply skipped.
>
> In order to support the existing multi-threading infrastructure in grep,
> output from each child process is captured in a strbuf so that it can be
> later printed to the console in an ordered fashion.
>
> To limit the number of theads that are created, each child process has
> half the number of threads as its parents (minimum of 1), otherwise we
> potentailly have a fork-bomb.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  Documentation/git-grep.txt         |   5 +
>  builtin/grep.c                     | 300 ++++++++++++++++++++++++++++++++++---
>  git.c                              |   2 +-
>  t/t7814-grep-recurse-submodules.sh |  99 ++++++++++++
>  4 files changed, 385 insertions(+), 21 deletions(-)
>  create mode 100755 t/t7814-grep-recurse-submodules.sh
>
> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> index 0ecea6e..17aa1ba 100644
> --- a/Documentation/git-grep.txt
> +++ b/Documentation/git-grep.txt
> @@ -26,6 +26,7 @@ SYNOPSIS
>            [--threads <num>]
>            [-f <file>] [-e] <pattern>
>            [--and|--or|--not|(|)|-e <pattern>...]
> +          [--recurse-submodules]
>            [ [--[no-]exclude-standard] [--cached | --no-index | --untracked] | <tree>...]
>            [--] [<pathspec>...]
>
> @@ -88,6 +89,10 @@ OPTIONS
>         mechanism.  Only useful when searching files in the current directory
>         with `--no-index`.
>
> +--recurse-submodules::
> +       Recursively search in each submodule that has been initialized and
> +       checked out in the repository.
> +
>  -a::
>  --text::
>         Process binary files as if they were text.
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 8887b6a..1fd292f 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -18,12 +18,20 @@
>  #include "quote.h"
>  #include "dir.h"
>  #include "pathspec.h"
> +#include "submodule.h"
>
>  static char const * const grep_usage[] = {
>         N_("git grep [<options>] [-e] <pattern> [<rev>...] [[--] <path>...]"),
>         NULL
>  };
>
> +static const char *super_prefix;
> +static int recurse_submodules;
> +static struct argv_array submodule_options = ARGV_ARRAY_INIT;
> +
> +static int grep_submodule_launch(struct grep_opt *opt,
> +                                const struct grep_source *gs);
> +
>  #define GREP_NUM_THREADS_DEFAULT 8
>  static int num_threads;
>
> @@ -174,7 +182,10 @@ static void *run(void *arg)
>                         break;
>
>                 opt->output_priv = w;
> -               hit |= grep_source(opt, &w->source);
> +               if (w->source.type == GREP_SOURCE_SUBMODULE)
> +                       hit |= grep_submodule_launch(opt, &w->source);
> +               else
> +                       hit |= grep_source(opt, &w->source);
>                 grep_source_clear_data(&w->source);
>                 work_done(w);
>         }
> @@ -300,6 +311,10 @@ static int grep_sha1(struct grep_opt *opt, const unsigned char *sha1,
>         if (opt->relative && opt->prefix_length) {
>                 quote_path_relative(filename + tree_name_len, opt->prefix, &pathbuf);
>                 strbuf_insert(&pathbuf, 0, filename, tree_name_len);
> +       } else if (super_prefix) {
> +               strbuf_add(&pathbuf, filename, tree_name_len);
> +               strbuf_addstr(&pathbuf, super_prefix);
> +               strbuf_addstr(&pathbuf, filename + tree_name_len);
>         } else {
>                 strbuf_addstr(&pathbuf, filename);
>         }
> @@ -328,10 +343,13 @@ static int grep_file(struct grep_opt *opt, const char *filename)
>  {
>         struct strbuf buf = STRBUF_INIT;
>
> -       if (opt->relative && opt->prefix_length)
> +       if (opt->relative && opt->prefix_length) {
>                 quote_path_relative(filename, opt->prefix, &buf);
> -       else
> +       } else {
> +               if (super_prefix)
> +                       strbuf_addstr(&buf, super_prefix);
>                 strbuf_addstr(&buf, filename);
> +       }
>
>  #ifndef NO_PTHREADS
>         if (num_threads) {
> @@ -378,31 +396,258 @@ static void run_pager(struct grep_opt *opt, const char *prefix)
>                 exit(status);
>  }
>
> -static int grep_cache(struct grep_opt *opt, const struct pathspec *pathspec, int cached)
> +static void compile_submodule_options(const struct grep_opt *opt,
> +                                     const struct pathspec *pathspec,
> +                                     int cached, int untracked,
> +                                     int opt_exclude, int use_index,
> +                                     int pattern_type_arg)
> +{
> +       struct grep_pat *pattern;
> +       int i;
> +
> +       if (recurse_submodules)
> +               argv_array_push(&submodule_options, "--recurse-submodules");
> +
> +       if (cached)
> +               argv_array_push(&submodule_options, "--cached");
> +       if (!use_index)
> +               argv_array_push(&submodule_options, "--no-index");
> +       if (untracked)
> +               argv_array_push(&submodule_options, "--untracked");
> +       if (opt_exclude > 0)
> +               argv_array_push(&submodule_options, "--exclude-standard");
> +
> +       if (opt->invert)
> +               argv_array_push(&submodule_options, "-v");
> +       if (opt->ignore_case)
> +               argv_array_push(&submodule_options, "-i");
> +       if (opt->word_regexp)
> +               argv_array_push(&submodule_options, "-w");
> +       switch (opt->binary) {
> +       case GREP_BINARY_NOMATCH:
> +               argv_array_push(&submodule_options, "-I");
> +               break;
> +       case GREP_BINARY_TEXT:
> +               argv_array_push(&submodule_options, "-a");
> +               break;
> +       default:
> +               break;
> +       }
> +       if (opt->allow_textconv)
> +               argv_array_push(&submodule_options, "--textconv");
> +       if (opt->max_depth != -1)
> +               argv_array_pushf(&submodule_options, "--max-depth=%d",
> +                                opt->max_depth);
> +       if (opt->linenum)
> +               argv_array_push(&submodule_options, "-n");
> +       if (!opt->pathname)
> +               argv_array_push(&submodule_options, "-h");
> +       if (!opt->relative)
> +               argv_array_push(&submodule_options, "--full-name");
> +       if (opt->name_only)
> +               argv_array_push(&submodule_options, "-l");
> +       if (opt->unmatch_name_only)
> +               argv_array_push(&submodule_options, "-L");
> +       if (opt->null_following_name)
> +               argv_array_push(&submodule_options, "-z");
> +       if (opt->count)
> +               argv_array_push(&submodule_options, "-c");
> +       if (opt->file_break)
> +               argv_array_push(&submodule_options, "--break");
> +       if (opt->heading)
> +               argv_array_push(&submodule_options, "--heading");
> +       if (opt->pre_context)
> +               argv_array_pushf(&submodule_options, "--before-context=%d",
> +                                opt->pre_context);
> +       if (opt->post_context)
> +               argv_array_pushf(&submodule_options, "--after-context=%d",
> +                                opt->post_context);
> +       if (opt->funcname)
> +               argv_array_push(&submodule_options, "-p");
> +       if (opt->funcbody)
> +               argv_array_push(&submodule_options, "-W");
> +       if (opt->all_match)
> +               argv_array_push(&submodule_options, "--all-match");
> +       if (opt->debug)
> +               argv_array_push(&submodule_options, "--debug");
> +       if (opt->status_only)
> +               argv_array_push(&submodule_options, "-q");
> +
> +       switch (pattern_type_arg) {
> +       case GREP_PATTERN_TYPE_BRE:
> +               argv_array_push(&submodule_options, "-G");
> +               break;
> +       case GREP_PATTERN_TYPE_ERE:
> +               argv_array_push(&submodule_options, "-E");
> +               break;
> +       case GREP_PATTERN_TYPE_FIXED:
> +               argv_array_push(&submodule_options, "-F");
> +               break;
> +       case GREP_PATTERN_TYPE_PCRE:
> +               argv_array_push(&submodule_options, "-P");
> +               break;
> +       case GREP_PATTERN_TYPE_UNSPECIFIED:
> +               break;
> +       }
> +
> +       for (pattern = opt->pattern_list; pattern != NULL;
> +            pattern = pattern->next) {
> +               switch (pattern->token) {
> +               case GREP_PATTERN:
> +                       argv_array_pushf(&submodule_options, "-e%s",
> +                                        pattern->pattern);
> +                       break;
> +               case GREP_AND:
> +               case GREP_OPEN_PAREN:
> +               case GREP_CLOSE_PAREN:
> +               case GREP_NOT:
> +               case GREP_OR:
> +                       argv_array_push(&submodule_options, pattern->pattern);
> +                       break;
> +               /* BODY and HEAD are not used by git-grep */
> +               case GREP_PATTERN_BODY:
> +               case GREP_PATTERN_HEAD:
> +                       break;
> +               }
> +       }
> +
> +       /*
> +        * Limit number of threads for child process to use.
> +        * This is to prevent potential fork-bomb behavior of git-grep as each
> +        * submodule process has its own thread pool.
> +        */
> +       if (num_threads)
> +               argv_array_pushf(&submodule_options, "--threads=%d",
> +                                (num_threads + 1) / 2);

I think you would want to pass --threads=%d unconditionally,
as it also serves as a weak defusal for fork bombs. Is it possible to come here
with num_threads=0? (i.e. what happens if the user doesn't specify the number
of threads or such, do we fall back to some default or is it just 0?)

I have seen some other places that check for num_threads unequal to 0,
as e.g. no mutex needs to be locked then (assuming we don't have any
thread but grep within the main process), but as you intend to use this also
as a helper to not blow up the number of threads recursively, we'd need to
pass at a number != 0 here?

> +
> +       git grep -e "bar" --and -e "foo" --recurse-submodules > actual &&

nit here and in the tests below:
We prefer to have no white space between > and the file piped to.

> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'grep and multiple patterns' '
> +       cat >expect <<-\EOF &&
> +       b/b:bar
> +       EOF
> +
> +       git grep -e "bar" --and --not -e "foo" --recurse-submodules > actual &&

Otherwise, this patch looks good.

Thanks,
Stefan
