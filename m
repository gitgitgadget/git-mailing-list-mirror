Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970CFC433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 15:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379548AbiBUPtq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 10:49:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379528AbiBUPto (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 10:49:44 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FA32458F
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 07:49:20 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a8so34425474ejc.8
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 07:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=J6wHlSNbtJ8e0jG+N5ov/5xKrRPl0IBVeiX2XY93QqU=;
        b=i3BIFNh5VGYS59xO6lGxjQ21CMNRk63ZEPh54pvYOcohuyscKZhx5dg6Sjj5XgTGoF
         JwyhbBD++aVCh437dNPjkAYrBz9pm1c+gRbKLtIJ7kAFZLlqKrCjR67Jhg5It4xVYajp
         pnwfq14bnptyISEJHAj2KXjQXqQu+dlcz14x3L1qrF44RNjikuXT2TKW32zVdWFHToRQ
         +3vKlLzWIQq5rZRxUbhxkGfzX3MbtFepPsoE+vIbGbhEPozh76Nifi2zNyF9vYoYnSn3
         4WHho+H5T7Q75JDIj6k+akzM3wJ2YtOu/eIprLGzvXYv3DsyUm0kvxSl6DHu2RKsGCWL
         samg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=J6wHlSNbtJ8e0jG+N5ov/5xKrRPl0IBVeiX2XY93QqU=;
        b=6SysVoqwjPYiJdVoF4k44KGXkpEq5OMhF1citJbdkuRQO/j3CYzHZ9Mpol4pH/t9lc
         wMbG+c7i/nyl1K6hT8Q7BeCBKymPZxEf6hBzn9ViTVI3BjGUJXc5g5+k0oVaE5hS69SX
         zt65qRx34xmql9XkjnpSUuJnIDLdae/eM1XHUay9Fwc5qznISz1LKx8mIwWpJ7EwmEUo
         zYyh2cKvWEWSI9K/Gte72CCP0awi6vTcw27AVcaVWsGBMH8wV5Uunya459ifnE4e8mpD
         frA2vhOIVFrS0bxV9K6ZWEFiRfeJi3LvqyE/dRmdeksPIguFYWL8yS8yNycDJ63Q4hOk
         00Mw==
X-Gm-Message-State: AOAM531NS9ubfhl14THLlzI7NVEABptGWhyBuZKj60CYbWCPqgktfUVx
        Mcq0SGqSmCtQop0IZ8ttEabMx72flideyQ==
X-Google-Smtp-Source: ABdhPJwmII82Km1N19CD1wTwGYazagmZOeBBmewJqCON9Ycz+oL7UrzyOKG4rwBsm9hgUq7OH0owgA==
X-Received: by 2002:a17:906:538f:b0:6ce:98ad:3100 with SMTP id g15-20020a170906538f00b006ce98ad3100mr16583397ejo.566.1645458558153;
        Mon, 21 Feb 2022 07:49:18 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id r8sm8502444edt.65.2022.02.21.07.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 07:49:17 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nMAw9-005hFF-7h;
        Mon, 21 Feb 2022 16:49:17 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Abhra303 <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH] add usage-strings ci check and amend remaining usage
 strings
Date:   Mon, 21 Feb 2022 16:39:54 +0100
References: <pull.1147.git.1645030949730.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <pull.1147.git.1645030949730.gitgitgadget@gmail.com>
Message-ID: <220221.86tucsb4oy.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 16 2022, Abhradeep Chakraborty via GitGitGadget wrote:

> From: Abhra303 <chakrabortyabhradeep79@gmail.com>
>
> Usage strings for git (sub)command flags has a style guide that
> suggests - first letter should not capitalized (unless requied)
> and it should skip full-stop at the end of line. But there are
> some files where usage-strings do not follow the above mentioned
> guide. Moreover, there are no checks to verify if all usage strings
> are following the guide/convention or not.
>
> Amend the usage strings that don't follow the convention/guide and
> add a `CI` check for checking the usage strings (whether the first
> letter is capital or it ends with full-stop). If the `check` find
> such strings then print those strings and return a non-zero status.
>
> Also provide a script that takes an optional argument (a valid <tree>
> string), to check the usage strings in the given <tree> (`HEAD` is
> the default argument).
>
> Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
> ---
>     add usage-strings ci check and amend remaining usage strings
>     
>     This patch series completely fixes #636.
>     
>     The issue is about amending the usage-strings (for command flags such as
>     -h, -v etc.) which do not follow the style convention/guide. There was a
>     PR [https://github.com/gitgitgadget/git/pull/920] addressing this issue
>     but as Johannes [https://github.com/dscho] said in his comment
>     [https://github.com/gitgitgadget/git/issues/636#issuecomment-1018660439],
>     there are some files that still have those kind of usage strings.
>     Johannes also suggested to add a CI check under ci/test-documentation.sh
>     to check the usage strings.
>     
>     So, in this patch, all remaining usage strings are corrected. I also
>     added a check-usage-strings target in Makefile which can be used to
>     check usage strings. It uses check-usage-strings.sh.
>     
>      1. If check-usage-strings.sh is run on a valid git repo - it will check
>         the validity of usage-strings in the tree specified by an argument
>         or in the HEAD if no argument provided.
>      2. If the current repo is not a git repo (i.e. if it doesn't find any
>         .git folder), it will check the usage string in the current root
>         directory.
>     
>     For the first case, output of make check-usage-strings or
>     ./check-usage-strings.sh would be similar to -
>     
>     HEAD:builtin/bisect--helper.c:1212                        N_("use <cmd>... to automatically bisect."), BISECT_RUN),
>     HEAD:builtin/submodule--helper.c:1877            OPT__QUIET(&quiet, "Suppress output for cloning a submodule"),
>     
>     
>     If an argument provided - ./check-usage-strings.sh 'v2.34.0' , it will
>     search for usage-strings in v2.34.0 and v2.34.0 will be prefixed before
>     filenames instead of HEAD.
>     
>     In the second case, output would be similar to -
>     
>     diff.c:5596                            N_("select files by diff type."),
>     diff.c:5599               N_("Output to a specific file"),
>     builtin/branch.c:666            OPT_BIT('C', NULL, &copy, N_("copy a branch, even if target exists."), 2),
>     make: *** [check-usage-strings] Error 1
>     
>     
>     Note in the last case - arguments provided to it will be useless.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1147%2FAbhra303%2Fusage_command_amend-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1147/Abhra303/usage_command_amend-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1147

Sorry about leaving this patch submission hanging. I read this at the
time, but forgot to find time to loop back to it.

>  Makefile                    |  5 +++++
>  builtin/bisect--helper.c    |  2 +-
>  builtin/reflog.c            |  6 +++---
>  builtin/submodule--helper.c |  2 +-
>  check-usage-strings.sh      | 33 +++++++++++++++++++++++++++++++++
>  ci/test-documentation.sh    |  1 +
>  diff.c                      |  2 +-
>  t/helper/test-run-command.c |  6 +++---
>  8 files changed, 48 insertions(+), 9 deletions(-)
>  create mode 100755 check-usage-strings.sh
>
> diff --git a/Makefile b/Makefile
> index 186f9ab6190..93faed51da0 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -3416,6 +3416,11 @@ check-docs::
>  check-builtins::
>  	./check-builtins.sh
>  
> +### Make sure all the usage strings follow usage string style guide
> +#
> +check-usage-strings::
> +	./check-usage-strings.sh
> +
>  ### Test suite coverage testing
>  #
>  .PHONY: coverage coverage-clean coverage-compile coverage-test coverage-report
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 28a2e6a5750..614d95b022c 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -1209,7 +1209,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  		OPT_CMDMODE(0, "bisect-visualize", &cmdmode,
>  			 N_("visualize the bisection"), BISECT_VISUALIZE),
>  		OPT_CMDMODE(0, "bisect-run", &cmdmode,
> -			 N_("use <cmd>... to automatically bisect."), BISECT_RUN),
> +			 N_("use <cmd>... to automatically bisect"), BISECT_RUN),
>  		OPT_BOOL(0, "no-log", &nolog,
>  			 N_("no log for BISECT_WRITE")),
>  		OPT_END()
> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index 85b838720c3..28372c5e2b5 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -600,7 +600,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
>  		OPT_BIT(0, "updateref", &flags,
>  			N_("update the reference to the value of the top reflog entry"),
>  			EXPIRE_REFLOGS_UPDATE_REF),
> -		OPT_BOOL(0, "verbose", &verbose, N_("print extra information on screen.")),
> +		OPT_BOOL(0, "verbose", &verbose, N_("print extra information on screen")),
>  		OPT_CALLBACK_F(0, "expire", &cmd, N_("timestamp"),
>  			       N_("prune entries older than the specified time"),
>  			       PARSE_OPT_NONEG,
> @@ -613,7 +613,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
>  			 N_("prune any reflog entries that point to broken commits")),
>  		OPT_BOOL(0, "all", &do_all, N_("process the reflogs of all references")),
>  		OPT_BOOL(1, "single-worktree", &all_worktrees,
> -			 N_("limits processing to reflogs from the current worktree only.")),
> +			 N_("limits processing to reflogs from the current worktree only")),
>  		OPT_END()
>  	};
>  
> @@ -736,7 +736,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
>  		OPT_BIT(0, "updateref", &flags,
>  			N_("update the reference to the value of the top reflog entry"),
>  			EXPIRE_REFLOGS_UPDATE_REF),
> -		OPT_BOOL(0, "verbose", &verbose, N_("print extra information on screen.")),
> +		OPT_BOOL(0, "verbose", &verbose, N_("print extra information on screen")),
>  		OPT_END()
>  	};
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index c5d3fc3817f..9864ec1427d 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1874,7 +1874,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>  		OPT_STRING(0, "depth", &clone_data.depth,
>  			   N_("string"),
>  			   N_("depth for shallow clones")),
> -		OPT__QUIET(&quiet, "Suppress output for cloning a submodule"),
> +		OPT__QUIET(&quiet, "suppress output for cloning a submodule"),
>  		OPT_BOOL(0, "progress", &progress,
>  			   N_("force cloning progress")),
>  		OPT_BOOL(0, "require-init", &require_init,

It's really good to have these fixed! Ditto for the remaining ones I
elided.

> diff --git a/check-usage-strings.sh b/check-usage-strings.sh
> new file mode 100755
> index 00000000000..a4028e0d00d
> --- /dev/null
> +++ b/check-usage-strings.sh
> @@ -0,0 +1,33 @@
> +{
> +  if test -d ".git"
> +  then
> +    rev=${1:-"HEAD"}
> +    for entry in $(git grep -l 'struct option .* = {$' "$rev" -- \*.c);
> +    do
> +      git show "$entry" |
> +      sed -n '/struct option .* = {/,/OPT_END/{=;p;}' |
> +      sed "N;s/^\\([0-9]*\\)\\n/$(echo "$entry" | sed 's/\//\\&/g'):\\1/";
> +    done
> +  else
> +    for entry in $(grep -rl --include="*.c" 'struct option .* = {$' . );
> +    do
> +      cat "$entry" |
> +      sed -n '/struct option .* = {/,/OPT_END/{=;p;}' |
> +      sed "N;s/^\\([0-9]*\\)\\n/$(echo "$entry" | sed -e 's/\//\\&/g' -e 's/^\.\\\///'):\\1/";
> +    done
> +  fi
> +} |
> +grep -Pe '((?<!OPT_GROUP\(N_\(|OPT_GROUP\()"(?!GPG|DEPRECATED|SHA1|HEAD)[A-Z]|(?<!"|\.\.)\.")' |
> +{
> +  status=0
> +  while read content;
> +  do
> +    if test -n "$content"
> +    then
> +      echo "$content";
> +      status=1;
> +    fi
> +  done
> +
> +  exit $status
> +}
> diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
> index de41888430a..f66848dfc66 100755
> --- a/ci/test-documentation.sh
> +++ b/ci/test-documentation.sh
> @@ -15,6 +15,7 @@ filter_log () {
>  }

As much as I like the idea, I really don't want us to have this method
of doing it though, i.e. to start parsing our C code with a
hard-to-maintain shellscript.

But the good news is that there's much easier way to add this!

Aside: if we did want to do the "parse C" method the right way to do it
would be to have a coccinelle script do it. We don't currently, but we
use coccicheck, and if you look at the linux kernel's use of it there's
multiple such checks there. I.e. you can have it parse the C and run
your checks with an arbitrary script.

But in this case there's really a much easier way to do this, to just
extend something like this:

diff --git a/parse-options.c b/parse-options.c
index 2437ad3bcdd..90d8da6ad4c 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -492,6 +492,8 @@ static void parse_options_check(const struct option *opts)
 		default:
 			; /* ok. (usually accepts an argument) */
 		}
+		if (opts->help && ends_with(opts->help, "."))
+			err |= optbug(opts, xstrfmt("argh should not end with a dot: %s", opts->help));
 		if (opts->argh &&
 		    strcspn(opts->argh, " _") != strlen(opts->argh))
 			err |= optbug(opts, "multi-word argh should use dash to separate words");

Then the t0012-help.sh test will catch these, and that's where these
sorts of checks belong in our tree.

See b6c2a0d45d4 (parse-options: make sure argh string does not have SP
or _, 2014-03-23) for the existing code shown in the context where we
already check "argh" like that, i.e. we're just missing a test for
"help".

Obviously such a function would need to hardcode some of the logic you
added in your shellscript. E.g. this fires on a string ending in "...",
but yours doesn't.

That should be fairly easy to do though, and if not we could always just
dump these to stderr or something if a
git_env_bool("GIT_TEST_PARSE_OPTIONS_DUMP_FIELD_HELP", 0) was true, and
do the testing itself in t0012-help.sh.

>  make check-builtins
> +make check-usage-strings
>  make check-docs

Good to have this as a "make" target, not something e.g. peculiar to CI.
