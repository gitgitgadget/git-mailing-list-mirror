Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BE021F991
	for <e@80x24.org>; Mon, 31 Jul 2017 22:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751227AbdGaWPn (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 18:15:43 -0400
Received: from mail-lf0-f52.google.com ([209.85.215.52]:34497 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751106AbdGaWPm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 18:15:42 -0400
Received: by mail-lf0-f52.google.com with SMTP id g25so115559948lfh.1
        for <git@vger.kernel.org>; Mon, 31 Jul 2017 15:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Q4L5k6rvb4QQQYvZkQX+M3chT8+g+/OyokIQ69FTnKc=;
        b=gvjulrjfF7I9pkPNXDBIm3UA8A1LmuM4PQie3Y9OgZYzBpV1iB5XvY0TzLKcgPP7c2
         NiydZLCni5OyCqIC7WsPylVvFG3UxVyWGNNkD9PdZD+RGVFp8mCEXs95bz+nO9Q1wcH4
         JSLa4zfi9WkcV56pyE6JzC5RYJApuQhVqs0ytIONeTRwwArzBq+1veufsipzZEZj4M0L
         zOuiH/NM2nI111sPAGVbDr68LU3b4HTCffkrz+wE1ICJGmyZAtW4stnU2Q/fLKZuL4sz
         p2AZzCwTA6Tp9+Up5H6qB1nYD6XHmjnbbcdd3yAzX/YBHPULo/WASkqlueiZQ9jY0Wjn
         feeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Q4L5k6rvb4QQQYvZkQX+M3chT8+g+/OyokIQ69FTnKc=;
        b=q8FD8+zcDgtlHxI+Ql1kkL87Q09BueWsRVUzjxN3D5E5NadXcBpldhVk4xdL8kOvyN
         YcuOTH7fdlGWxPh2hPsovOxuK1EmdfJjxmyQXwGGstwaHwsneBVvvFQ/4gm/HSTW3wvv
         PNQyYvngSHDh7rXnTXOluXgVK/GVjSzQNwTKtZaMq+zSfdZL1noaIlzpb8ZrGiUxpZOd
         EKaQdQATx0jpRQ+Sy8g91ZReo7kaomQ8xQLh7DEQWHYVYXcnNs2GYTDWPmB9+ydx9xX+
         1rRXa6U2QB3BSR6Ov70bWuliaQOnIe90K6j4n9EUtdeT3x/fI82YTcvix1BuzSujdcnW
         DA+Q==
X-Gm-Message-State: AIVw1127SE1B/DFtK6cgt4mrOZF33GD3ZVyG909J7OjJtx8X0HOAsIhG
        9mD25euXcs0ls+qQ1FM6bxbvdhAo1jUq
X-Received: by 10.25.204.149 with SMTP id c143mr4978519lfg.195.1501539340592;
 Mon, 31 Jul 2017 15:15:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Mon, 31 Jul 2017 15:15:39 -0700 (PDT)
In-Reply-To: <20170731205621.24305-9-pc44800@gmail.com>
References: <20170731205621.24305-1-pc44800@gmail.com> <20170731205621.24305-9-pc44800@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 31 Jul 2017 15:15:39 -0700
Message-ID: <CAGZ79kaWn9z47Va=VW4R2Aswws1N5n2u4Kvatn73s0YnV0pVqQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH 08/13] submodule: port submodule subcommand
 'summary' from shell to C
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 31, 2017 at 1:56 PM, Prathamesh Chavan <pc44800@gmail.com> wrote:
> The submodule subcommand 'summary' is ported in the process of
> making git-submodule a builtin. The function cmd_summary() from
> git-submodule.sh is ported to functions module_summary(),
> compute_summary_module_list(), prepare_submodule_summary() and
> print_submodule_summary().
>
> The first function module_summary() parses the options of submodule
> subcommand and also acts as the front-end of this subcommand.
> After parsing them, it calls the compute_summary_module_list()
>
> The functions compute_summary_module_list() runs the diff_cmd,
> and generates the modules list, as required by the subcommand.
> The generation of this module list is done by the using the
> callback function submodule_summary_callback(), and stored in the
> structure module_cb.
>
> Once the module list is generated, prepare_submodule_summary()
> further goes through the list and filters the list, for
> eventually calling the print_submodule_summary() function.
>
> Finally, the print_submodule_summary() takes care of generating
> and printing the summary for each submodule.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
> ---
> In this new version, the following changes have been made:
>
> * Firstly, about the function compute_summary_module_list().
>   This function is created to generate the list of modules, for which
>   we will generate the summary further. Since the list is actually
>   generated using the git-diff-files or git-diff-index command, but for
>   porting this, we required to create a function similar to the builtin
>   functions of the above commands. But we can't directly call cmd_diff_files()
>   and cmd_diff_index() since we don't have to display the output and instead
>   need to store it. Hence, this function is introduced.
>
> * Also, the module_cb_list *list is not freed since it is a non-heap object.
>   Hence, free() can't be using on the non-heap objects.
>
> * In the function prepare_submodule_summary(), as suggested
>   'git_config_get_string_const' was used instead of instead of '_value'
>
> * Some variables which weren't modified throughout the function-call were
>   passed as const.
>
> * The '!!' trick, which wasn't used in the last patch, is now used in this
>   new version .
>
> * the variables sha1_dst and sha1_src are removed from the function
>   print_submodule_summary(), and instead the p->oid_src and p->oid_dst are
>   used.
>
> * The variable sm_git_dir is freed at the end of the function.
>
> * variable head was no longer used in module_summary() and instead the strbuf
>   was utilized.
>
>  builtin/submodule--helper.c | 425 ++++++++++++++++++++++++++++++++++++++++++++
>  git-submodule.sh            | 182 +------------------
>  2 files changed, 426 insertions(+), 181 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index f642f9889..94438d6ce 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -13,6 +13,9 @@
>  #include "remote.h"
>  #include "refs.h"
>  #include "connect.h"
> +#include "revision.h"
> +#include "diffcore.h"
> +#include "diff.h"
>
>  typedef void (*submodule_list_func_t)(const struct cache_entry *list_item,
>                                       void *cb_data);
> @@ -766,6 +769,427 @@ static int module_name(int argc, const char **argv, const char *prefix)
>         return 0;
>  }
>
> +struct module_cb {
> +       unsigned int mod_src;
> +       unsigned int mod_dst;
> +       struct object_id oid_src;
> +       struct object_id oid_dst;
> +       char status;
> +       const char *sm_path;
> +};
> +#define MODULE_CB_INIT { 0, 0, NULL, NULL, '\0', NULL }
> +
> +struct module_cb_list {
> +       struct module_cb **entries;
> +       int alloc, nr;
> +};
> +#define MODULE_CB_LIST_INIT { NULL, 0, 0 }
> +
> +struct summary_cb {
> +       int argc;
> +       const char **argv;
> +       const char *prefix;
> +       char *diff_cmd;
> +       unsigned int cached: 1;
> +       unsigned int for_status: 1;
> +       unsigned int quiet: 1;
> +       unsigned int files: 1;
> +       int summary_limits;
> +};
> +#define SUMMARY_CB_INIT { 0, NULL, NULL, NULL, 0, 0, 0, 0, 0 }
> +
> +static int verify_submodule_object_name(const char *sm_path, const char *sha1)
> +{
> +       struct child_process cp_rev_parse = CHILD_PROCESS_INIT;
> +
> +       cp_rev_parse.git_cmd = 1;
> +       cp_rev_parse.no_stdout = 1;
> +       cp_rev_parse.dir = sm_path;
> +       prepare_submodule_repo_env(&cp_rev_parse.env_array);
> +
> +       argv_array_pushl(&cp_rev_parse.args, "rev-parse", "-q",
> +                        "--verify", NULL);
> +       argv_array_pushf(&cp_rev_parse.args, "%s^0", sha1);
> +
> +       if (run_command(&cp_rev_parse))
> +               return 1;
> +
> +       return 0;
> +}
> +
> +static void print_submodule_summary(struct summary_cb *info,
> +                                   struct module_cb *p)
> +{
> +       int missing_src = 0;
> +       int missing_dst = 0;
> +       char *displaypath;
> +       const char *sha1_abbr_src;
> +       const char *sha1_abbr_dst;
> +       int errmsg = 0;
> +       int total_commits = -1;
> +       char *sm_git_dir = xstrfmt("%s/.git", p->sm_path);
> +       int is_sm_git_dir = 0;
> +
> +       if (!info->cached && !oidcmp(&p->oid_dst, &null_oid)) {
> +               if (S_ISGITLINK(p->mod_dst)) {
> +                       struct child_process cp_rev_parse = CHILD_PROCESS_INIT;
> +                       struct strbuf sb_rev_parse = STRBUF_INIT;
> +
> +                       cp_rev_parse.git_cmd = 1;
> +                       cp_rev_parse.no_stderr = 1;
> +                       cp_rev_parse.dir = p->sm_path;
> +                       prepare_submodule_repo_env(&cp_rev_parse.env_array);
> +
> +                       argv_array_pushl(&cp_rev_parse.args,
> +                                        "rev-parse", "HEAD", NULL);
> +                       if (!capture_command(&cp_rev_parse, &sb_rev_parse, 0)) {
> +                               strbuf_strip_suffix(&sb_rev_parse, "\n");
> +
> +                               get_oid_hex(sb_rev_parse.buf, &p->oid_dst);
> +                       }
> +                       strbuf_release(&sb_rev_parse);

I think this could be replaced via
head_ref_submodule(sub->path, callback function, &where_to_store)
or is there some trickery going on, that this also works on
non-compliant submodules?
(Maybe add that as a NEEDSWORK/TODO)

> +static int compute_summary_module_list(char *head, struct summary_cb *info)
> +{
> +       struct argv_array diff_args = ARGV_ARRAY_INIT;
> +       struct rev_info rev;
> +       struct module_cb_list list = MODULE_CB_LIST_INIT;
> +
> +       argv_array_push(&diff_args, info->diff_cmd);
> +       if (info->cached)
> +               argv_array_push(&diff_args, "--cached");
> +       argv_array_pushl(&diff_args, "--ignore-submodules=dirty", "--raw",
> +                        NULL);
> +       if (head)
> +               argv_array_push(&diff_args, head);
> +       argv_array_push(&diff_args, "--");
> +       if (info->argc)
> +               argv_array_pushv(&diff_args, info->argv);
> +
> +       git_config(git_diff_basic_config, NULL);
> +       init_revisions(&rev, info->prefix);
> +       gitmodules_config();
> +       rev.abbrev = 0;

Recently there was a discussion how to operate the
revision machinery best (search for earlier versions of
js/rebase-i-final if interested), whether we can and want
to directly set flags such as .abbrev or if we'd rather
want to push "--abbrev=0" to the diff_args before the --

bisect and archive both assign abbrev directly, so I think
we're fine here.

> +       precompose_argv(diff_args.argc, diff_args.argv);
> +
> +       diff_args.argc = setup_revisions(diff_args.argc, diff_args.argv,
> +                                        &rev, NULL);
> +       rev.diffopt.output_format = DIFF_FORMAT_NO_OUTPUT | DIFF_FORMAT_CALLBACK;
> +       rev.diffopt.format_callback = submodule_summary_callback;
> +       rev.diffopt.format_callback_data = &list;
> +
> +       if (!info->cached) {
> +               if (!strcmp(info->diff_cmd, "diff-index"))

This strcmp smells like we're encoding the state not optimally
in 'info'.  Maybe we can have an enum { DIFF_FILES, DIFF_INDEX }
instead of a string (that we assign earlier) and then have to
compare to it again.

> +                       setup_work_tree();
> +               if (read_cache_preload(&rev.diffopt.pathspec) < 0) {
> +                       perror("read_cache_preload");
> +                       return -1;
> +               }
> +       } else if (read_cache() < 0) {
> +               perror("read_cache");
> +               return -1;
> +       }

This cascaded decision whether to use
setup_work_tree / read_cache_preload / read_cache
seems quite optimized, hence complicated to read. :)
I like it, though.

> +
> +       if (!summary_limits)
> +               return 0;

Good call for converting "test $summary_limit = 0 && return".
I suspected this may be an overeager optimization (as no
error checking is done at all, but that is what it is)
f2dc06a344 (git-submodule summary: limit summary size,
2008-03-11) introduced it like this.
