Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8D6B2023D
	for <e@80x24.org>; Mon, 22 May 2017 21:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934097AbdEVV2e (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 17:28:34 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34452 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933607AbdEVV2c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 17:28:32 -0400
Received: by mail-pf0-f179.google.com with SMTP id 9so93753921pfj.1
        for <git@vger.kernel.org>; Mon, 22 May 2017 14:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4wCpgNe5uCBPQJkHQITliqGe7hXbMwua+2eK2o6LIlk=;
        b=Ch7BVcq39yW0bodBtE+2QuZQ2MRdzzn9kh1wq0V04S/LWH2CwBYlLH/GiWwADPKhgE
         mAoSZp7tAP8oZDHN5l8ZvELcd3D6Po/m/qu2LDrihTcAo33evfiHxJv+pPDvlY2xNRvw
         KLxAADN0lZSp7BQFnOzkQmjga7QsP9KfgbKWwKYZ4i5b5bRsLFSBx9WMSvpWAaAig/YS
         T51BXQUEr7Ozp0fG0dnI8dr+sEAIfHYsXaVE/x6UlzP8dklCckQTZgjFpaGweUX6wSPi
         VppK0tqYbz9sqZ/1dyw9PeiwH/srk1bl+0E8j1F0qE0FZDk51XcFxV0Q3oQn4rEh92EI
         zz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4wCpgNe5uCBPQJkHQITliqGe7hXbMwua+2eK2o6LIlk=;
        b=oNYZN+2GMHFKKK5EIZXXos+JjVzxO9s7ByXlTibRfPMpMr+mnvb0cFl2TJKD21yPGR
         YQSqtuqmq9ZhxIpButHz3J6skbVzf/zw+53BS1ylbeoTeQfxBcOj/RP9FhzjIH1yPHK8
         vvSr8ITRuDRiPJEsWME/Xa+GS3q+Sdd1a2uTurrruBANlxMfAUFY6idWdJIM9WUMCBl4
         PgftYdD367tc4cdAGHmZJYXK/v+fSDH4Z7XVL20ublruU+KVTm+h4XcWpy+F4zESbopc
         NWHuANSc4GDJl6d4sqwFrBCIl/JR4c8SjCTU/mZ3yTVq/klRKoc20+haDAEh8B5pkGo0
         r0kA==
X-Gm-Message-State: AODbwcA4FaODZMBxJ4+xiDc6CEMenqUCvLmXGTPVB8kU+6Lxj9uRs8Ho
        LWAOHF40g5GXnzIvPpw2mDqYUDYd1t3s
X-Received: by 10.99.116.7 with SMTP id p7mr27517973pgc.162.1495488511311;
 Mon, 22 May 2017 14:28:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Mon, 22 May 2017 14:28:30 -0700 (PDT)
In-Reply-To: <20170521122711.22021-2-pc44800@gmail.com>
References: <20170521122711.22021-1-pc44800@gmail.com> <20170521122711.22021-2-pc44800@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 22 May 2017 14:28:30 -0700
Message-ID: <CAGZ79kYeJoVGRFyeGsXevo2JmDMoxf=tJubWcy5Qt==3QK=Hjg@mail.gmail.com>
Subject: Re: [GSoC][PATCH v1 2/2] submodule: port submodule subcommand status
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 21, 2017 at 5:27 AM, Prathamesh Chavan <pc44800@gmail.com> wrote:
> This aims to make git-submodule status a builtin. 'status' is ported
> to submodule--helper, and submodule--helper is called from
> git-submodule.sh.
>
> For the purpose of porting cmd_status, the code is split up such that
> one function obtains all the list of submodules, acting as the
> front-end of git-submodule status. This function later calls the
> second function for_each_submodule_list,it which basically loops
> through the list of submodules and calls function fn, which in this
> case is status_submodule. The third function, status submodule returns
> the status of submodule and also takes care of the recursive flag.
>
> The first function module_status parses the options present in argv,
> and then with the help of module_list_compute, generates the list of
> submodules present in the current working tree.
>
> The second function for_each_submodule_list traverses through the list,
> and calls function fn (which in the case of submodule subcommand
> foreach is status_submodule) is called for each entry.
>
> The third function status_foreach checks for the various conditions,
> and prints the status of the submodule accordingly. Also, this
> function takes care of the recursive flag by creating a separate
> child_process and running it inside the submodule.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
> ---
> A new function, get_submodule_displaypath is also introduced for getting
> the displaypath of the submodule while taking care of its prefix and
> superprefix.
>
>  builtin/submodule--helper.c | 162 ++++++++++++++++++++++++++++++++++++++++++++
>  git-submodule.sh            |  48 +------------
>  2 files changed, 163 insertions(+), 47 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 5f0ddd8ad..7c040a375 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -13,6 +13,8 @@
>  #include "refs.h"
>  #include "connect.h"
>
> +typedef void (*submodule_list_func_t)(const struct cache_entry *list_item, void *cb_data);
> +
>  static char *get_default_remote(void)
>  {
>         char *dest = NULL, *ret;
> @@ -219,6 +221,23 @@ static int resolve_relative_url_test(int argc, const char **argv, const char *pr
>         return 0;
>  }
>
> +static char *get_submodule_displaypath(const char *path, const char *prefix)
> +{
> +       const char *super_prefix = get_super_prefix();
> +
> +       if (prefix && super_prefix) {
> +               BUG("cannot have prefix '%s' and superprefix '%s'",
> +                   prefix, super_prefix);
> +       } else if (prefix) {
> +               struct strbuf sb = STRBUF_INIT;
> +               return xstrdup(relative_path(path, prefix, &sb));
> +       } else if (super_prefix) {
> +               return xstrfmt("%s/%s", super_prefix, path);
> +       } else {
> +               return xstrdup(path);
> +       }
> +}
> +
>  enum describe_step {
>         step_bare = 0,
>         step_tags,
> @@ -395,6 +414,13 @@ static int module_list(int argc, const char **argv, const char *prefix)
>         return 0;
>  }
>
> +static void for_each_submodule_list(const struct module_list list, submodule_list_func_t fn, void *cb_data)
> +{
> +       int i;
> +       for (i = 0; i < list.nr; i++)
> +               fn(list.entries[i], cb_data);
> +}

Up to here it looks like the patch in
https://public-inbox.org/git/20170521125814.26255-2-pc44800@gmail.com/
(without the nit of having an extra void return)

Maybe it is worth it to combine the two patch series, such that we'd need
to review the common parts only once?

> +
>  static void init_submodule(const char *path, const char *prefix, int quiet)
>  {
>         const struct submodule *sub;
> @@ -532,6 +558,141 @@ static int module_init(int argc, const char **argv, const char *prefix)
>         return 0;
>  }
>
> +struct cb_status {
> +       const char *prefix;
> +       unsigned int quiet: 1;
> +       unsigned int cached: 1;
> +       unsigned int recursive: 1;
> +};
> +#define CB_STATUS_INIT { NULL, 0, 0, 0 }



> +
> +               if (run_command(&cpr))
> +                       die(_("Failed to recurse into submodule path %s"), list_item->name);

I thought this is a badly worded error message, but it turns out it
is just as in the shell code, which is good for a direct translation.

Maybe we can adapt the error message in a later follow up to be more
aligned to other submodule error messages. (dropping "path" and putting
single quotes around %s, also un-capitalize the first letter)


> +static int module_status(int argc, const char **argv, const char *prefix)
> +{
> +       struct cb_status info = CB_STATUS_INIT;
> +       struct pathspec pathspec;
> +       struct module_list list = MODULE_LIST_INIT;
> +       int quiet = 0;
> +       int cached = 0;
> +       int recursive = 0;
> +
> +       struct option module_status_options[] = {
> +               OPT__QUIET(&quiet, N_("Suppress output for initializing a submodule")),
> +               OPT_BOOL(0, "cached", &cached, N_("Use commit stored in the index instead of the one stored in the submodule HEAD")),
> +               OPT_BOOL(0, "recursive", &recursive, N_("Recurse into nested submodules")),
> +               OPT_END(),
> +       };
> +
> +       const char *const git_submodule_helper_usage[] = {
> +               N_("git submodule status [--quiet] [--cached] [--recursive] [<path>]"),
> +               NULL
> +       };
> +
> +       argc = parse_options(argc, argv, prefix, module_status_options,
> +                            git_submodule_helper_usage, 0);
> +
> +       if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
> +               return 1;
> +
> +       info.prefix = prefix;
> +       info.quiet = !!quiet;
> +       info.cached = !!cached;
> +       info.recursive = !!recursive;
> +
> +       for_each_submodule_list(list, status_submodule, &info);
> +
> +       return 0;
> +}

This function looks good. Though my gut reaction was to suggest to
add another layer of abstraction. Then I checked wt-status.c, but that
makes use of "submodule summary" and not "submodule status". So all is good.


> +       git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper status ${GIT_QUIET:+--quiet} ${cached:+--cached} ${recursive:+--recursive} "$@"

I'd think we would not need to pass down superprefix here as we do not call
"submodule status" in a recursive way. The recursion works on
the submodule helper itself, so we could simplify it to just

    git ${wt_prefix:+-C "$wt_prefix"} submodule--helper status
${GIT_QUIET:+--quiet} ${cached:+--cached} ${recursive:+--recursive}
"$@"

Another idea that I just had:
Maybe we could drop --cached, --recursive as well,
as they are just command line options, which could
be just part of "$@".

For --quiet this is a bit more complicated as it may come in
via an environment variable (which we could also check for
in C in theory. I know I omitted that when writing some
submodule--helper code a couple months ago, but the reason
escaped me)

Thanks,
Stefan
