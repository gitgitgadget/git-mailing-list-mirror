Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479B9C7618D
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 15:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjCTP7H (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 11:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjCTP6K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 11:58:10 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08155EFBD
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 08:49:22 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id x3so48479673edb.10
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 08:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unity3d.com; s=google; t=1679327342;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g4aWYxRjgAKC/ul0/9ljJgQ4JxDBWuLjZ48mUJypjnE=;
        b=dSxVPMU/pNEKYxXTHsGznDR0xVw+od14qL2QJ0l+JKns++wJCV3rDoRw4IxhEnoE1E
         uZfn/1J9Me8h/0s9Ai7Z62GZOQdJF9gzTaXZvf+CCbC/jVB861Y+tq5cDl3NfnaC9bps
         WotfT0v/qsUYnXRnuLI2/Paz3yYnr68LRbtX6vj+i4j54drgK5tGLeDBtB2eEHCttNTa
         GKAZuSDwtIf/zR35gt9+LMAZ7DKoobjBA65rb3p/+W4NQDGfX5UWM4pOQ4OBXPgcEqXI
         8sgNo6emXwqmKTSWnIBNSKGFlcCnmW04shJCcuJrKeVVhuQiGEhmzzEnWjr5fVyDpoWO
         KSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679327342;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g4aWYxRjgAKC/ul0/9ljJgQ4JxDBWuLjZ48mUJypjnE=;
        b=drglkKN0ZX3oucPGx/3Kt0SdQNGBDB5RVlawetwOS6HAQg7zbQVFayDibU1PBImJO/
         g1fJ91RBp5ueit6Uu7sdQZQ71sju579lnRutpQoXcxj20JR+//4xnslRMv4GUQOGm3od
         C7bSeUEpIdsKUhMJ7+IVOunY4uL+5fJbGLXaYbxw5oePUdwQUwbayI4MyX6DjqimLut2
         iAZLTmNUgUDMRj4uosyso0gWvDt3U9z4NBdhbq4FvxfPAeWvK/2AaVIyWhj8dHBLGDg8
         0YML/pvC8PyyjGaAUrgWF8ybqfter9pxuEVHxdqLOPUjcEQagDKNmq1rlUYlyHHptbxE
         DUJQ==
X-Gm-Message-State: AO0yUKWYWSMCkgNVa2loOlEX+AKk/5TodMv20Y5ZDSNaKUKFouPY+nNr
        2BVS06mQ7M4B6DLHtXiUxyyaig==
X-Google-Smtp-Source: AK7set9fo+gdwEmFWAFGEI5avAlJhG/TX1M6Eze4WJ+8hrWnl8DF5V72ofdF9wOlhr0PuSBtTb8Mfg==
X-Received: by 2002:a05:6402:153:b0:501:d2eb:6b2c with SMTP id s19-20020a056402015300b00501d2eb6b2cmr1744985edu.15.1679327341964;
        Mon, 20 Mar 2023 08:49:01 -0700 (PDT)
Received: from [10.45.35.106] ([80.80.14.217])
        by smtp.gmail.com with ESMTPSA id k2-20020a50c082000000b005002daeb27asm5034982edf.37.2023.03.20.08.49.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 08:49:01 -0700 (PDT)
Message-ID: <8c0b4c56-45a2-865c-fe6e-367d3d5f8a02@unity3d.com>
Date:   Mon, 20 Mar 2023 16:49:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] builtin/sparse-checkout: add check-rules command
To:     Elijah Newren <newren@gmail.com>,
        William Sprent via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>
References: <pull.1488.git.1678283349.gitgitgadget@gmail.com>
 <21c8375efff5c20e299c52aa579e6b10dafcbc4f.1678283349.git.gitgitgadget@gmail.com>
 <CABPp-BE51HR9jvi_VxYHk8aWdGw+m=zCOgdYn8rQzYhht+bVJA@mail.gmail.com>
Content-Language: en-US
From:   William Sprent <williams@unity3d.com>
In-Reply-To: <CABPp-BE51HR9jvi_VxYHk8aWdGw+m=zCOgdYn8rQzYhht+bVJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/03/2023 05.26, Elijah Newren wrote:
> Hi,
> 
> On Wed, Mar 8, 2023 at 5:49 AM William Sprent via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: William Sprent <williams@unity3d.com>
>>
>> There exists no direct way to interrogate git about which paths are
>> matched by a given set of sparsity rules. It is possible to get this
>> information from git, but it includes checking out the commit that
>> contains the paths, applying the sparse checkout patterns and then using
>> something like 'git ls-files -t' to check if the skip worktree bit is
>> set. This works in some case, but there are cases where it is awkward or
>> infeasible to generate a checkout for this purpose.
>>
>> Exposing the pattern matching of sparse checkout enables more tooling to
>> be built and avoids a situation where tools that want to reason about
>> sparse checkouts start containing parallel implementation of the rules.
>> To accommodate this, add a 'check-rules' subcommand to the
>> 'sparse-checkout' builtin along the lines of the 'git check-ignore' and
>> 'git check-attr' commands. The new command accepts a list of paths on
>> stdin and outputs just the ones the match the sparse checkout.
>>
>> To allow for use in a bare repository and to allow for interrogating
>> about other patterns than the current ones, include a '--rules-file'
>> option which allows the caller to explicitly pass sparse checkout rules
>> in the format accepted by 'sparse-checkout set --stdin'.
>>
>> To allow for reuse of the handling of input patterns for the
>> '--rules-file' flag, modify 'add_patterns_from_input()' to be able to
>> read from a 'FILE' instead of just stdin.
>>
>> To allow for reuse of the logic which decides whether or not rules
>> should be interpreted as cone-mode patterns, split that part out of
>> 'update_modes()' such that can be called without modifying the config.
>>
>> An alternative could have been to create a new 'check-sparsity' command.
>> However, placing it under 'sparse-checkout' allows for a) more easily
>> re-using the sparse checkout pattern matching and cone/non-code mode
>> handling, and b) keeps the documentation for the command next to the
>> experimental warning and the cone-mode discussion.
>>
>> Signed-off-by: William Sprent <williams@unity3d.com>
>> ---
>>   Documentation/git-sparse-checkout.txt |  23 ++++-
>>   builtin/sparse-checkout.c             | 126 +++++++++++++++++++++----
>>   t/t1091-sparse-checkout-builtin.sh    | 129 +++++++++++++++++++++++++-
>>   3 files changed, 255 insertions(+), 23 deletions(-)
>>
>> diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
>> index 68392d2a56e..8fdde8f53be 100644
>> --- a/Documentation/git-sparse-checkout.txt
>> +++ b/Documentation/git-sparse-checkout.txt
>> @@ -9,7 +9,7 @@ git-sparse-checkout - Reduce your working tree to a subset of tracked files
>>   SYNOPSIS
>>   --------
>>   [verse]
>> -'git sparse-checkout' (init | list | set | add | reapply | disable) [<options>]
>> +'git sparse-checkout' (init | list | set | add | reapply | disable | check-rules) [<options>]
>>
>>
>>   DESCRIPTION
>> @@ -135,6 +135,27 @@ paths to pass to a subsequent 'set' or 'add' command.  However,
>>   the disable command, so the easy restore of calling a plain `init`
>>   decreased in utility.
>>
>> +'check-rules'::
>> +       Check whether sparsity rules match one or more paths.
>> ++
>> +By default `check-rules` reads a list of paths from stdin and outputs only
>> +the ones that match the current sparsity rules. The input is expected to consist
>> +of one path per line, matching the output of `git ls-tree --name-only` including
>> +that pathnames that begin with a double quote (") are interpreted C-style quoted
>> +strings.
>> ++
>> +When called with the `--rules-file <file>` the input files are matched against
>> +the sparse checkout rules found in `<file>` instead of the current ones. The
>> +rules in the files are expected to be in the same form as accepted by `git
>> +sparse-checkout set --stdin`.
> 
> Could we add a "(in particular, they must be newline-delimited)" to
> the end of that paragraph?
> 
> I built your series locally to test, and my first attempt was:
> 
> $ git sparse-checkout set t reftable
> $ echo -e "t/helper/test-userdiff.c\nreftable/basics.c\nmerge-ort.c\nDocumentation/give-up.txt"
> | git sparse-checkout check-rules
> t/helper/test-userdiff.c
> reftable/basics.c
> merge-ort.c
> 
> ...which did exactly what I expected and wanted.  So, I decided to
> undo the sparse checkout and use the --rules-file option:
> 
> $ echo -e "t/helper/test-userdiff.c\nreftable/basics.c\nmerge-ort.c\nDocumentation/give-up.txt"
> | git sparse-checkout check-rules --rules-file <(echo t reftable)
> merge-ort.c
> 
> I was perplexed.  I thought it was a bug and was typing up explaining
> why this was a problem, before I re-read this sentence of your
> documentation closer and realized I had just flubbed it.  I should
> have ran:
> $ echo -e "t/helper/test-userdiff.c\nreftable/basics.c\nmerge-ort.c\nDocumentation/give-up.txt"
> | git sparse-checkout check-rules --rules-file <(echo -e
> "t\nreftable")
> t/helper/test-userdiff.c
> reftable/basics.c
> merge-ort.c
> 
> Given that this wasn't obvious to me after reading the Documentation
> (it probably should have been but just wasn't), might it be worth
> calling out?
> 

Sure. I'll add that to the end. That gives us:

"The rules in the files are expected to be in the same form as accepted by `git
sparse-checkout set --stdin` (in particular, they must be newline-delimited)."

>> ++
>> +The `--rules-file` flag can be combined with the `--[no]-cone` with the same
>> +effect as for the `set` command with the `--stdin` flag.
>> ++
>> +When called with the `-z` flag the input format and output format is \0
>> +terminated and not quoted.
> 
> I believe this does not affect the format of the --rules-file
> option...but maybe it should?  Whether it does or doesn't, do we want
> to call it out when explaining -z's behavior?
>

It does not affect the --rules-file option. That's right.
I think it makes sense to make it such that you can feed the exact same rules
into 'check-rules' as you can into 'set --stdin', and 'set --stdin' does not have
a -z option. And since rules are a user facing concept, I can't think of a
situation where you would want to store them as null separated records.

If we _do_ want to have a -z for the --rules-file option, I think that it should
probably be a separate option given that it isn't unlikely that you would want
to have rules stored newline separated as they are first and foremost for users
but still would prefer to not have to deal with quoted paths when authoring
a tool or a script.

But I do think it makes sense to call it out in the documentation. Maybe something
along the lines of:

"When called with the `-z` flag, the format of the paths input on stdin as well as
the output paths are \0 terminated and not quoted. Note that this does not apply
to the format of the rules passed with the `--rules-file` option."

  
>> +
>>   EXAMPLES
>>   --------
>>   `git sparse-checkout set MY/DIR1 SUB/DIR2`::
>> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
>> index 5fdc3d9aab5..969ae14a415 100644
>> --- a/builtin/sparse-checkout.c
>> +++ b/builtin/sparse-checkout.c
>> @@ -20,7 +20,7 @@
>>   static const char *empty_base = "";
>>
>>   static char const * const builtin_sparse_checkout_usage[] = {
>> -       N_("git sparse-checkout (init | list | set | add | reapply | disable) [<options>]"),
>> +       N_("git sparse-checkout (init | list | set | add | reapply | disable | check-rules) [<options>]"),
>>          NULL
>>   };
>>
>> @@ -384,13 +384,7 @@ static int set_config(enum sparse_checkout_mode mode)
>>          return 0;
>>   }
>>
>> -static int update_modes(int *cone_mode, int *sparse_index)
>> -{
>> -       int mode, record_mode;
>> -
>> -       /* Determine if we need to record the mode; ensure sparse checkout on */
>> -       record_mode = (*cone_mode != -1) || !core_apply_sparse_checkout;
>> -
>> +static enum sparse_checkout_mode update_cone_mode(int *cone_mode) {
>>          /* If not specified, use previous definition of cone mode */
>>          if (*cone_mode == -1 && core_apply_sparse_checkout)
>>                  *cone_mode = core_sparse_checkout_cone;
>> @@ -398,12 +392,21 @@ static int update_modes(int *cone_mode, int *sparse_index)
>>          /* Set cone/non-cone mode appropriately */
>>          core_apply_sparse_checkout = 1;
>>          if (*cone_mode == 1 || *cone_mode == -1) {
>> -               mode = MODE_CONE_PATTERNS;
>>                  core_sparse_checkout_cone = 1;
>> -       } else {
>> -               mode = MODE_ALL_PATTERNS;
>> -               core_sparse_checkout_cone = 0;
>> +               return MODE_CONE_PATTERNS;
>>          }
>> +       core_sparse_checkout_cone = 0;
>> +       return MODE_ALL_PATTERNS;
>> +}
>> +
>> +static int update_modes(int *cone_mode, int *sparse_index)
>> +{
>> +       int mode, record_mode;
>> +
>> +       /* Determine if we need to record the mode; ensure sparse checkout on */
>> +       record_mode = (*cone_mode != -1) || !core_apply_sparse_checkout;
>> +
>> +       mode = update_cone_mode(cone_mode);
>>          if (record_mode && set_config(mode))
>>                  return 1;
>>
>> @@ -547,7 +550,7 @@ static void strbuf_to_cone_pattern(struct strbuf *line, struct pattern_list *pl)
>>
>>   static void add_patterns_from_input(struct pattern_list *pl,
>>                                      int argc, const char **argv,
>> -                                   int use_stdin)
>> +                                   FILE *file)
>>   {
>>          int i;
>>          if (core_sparse_checkout_cone) {
>> @@ -557,9 +560,9 @@ static void add_patterns_from_input(struct pattern_list *pl,
>>                  hashmap_init(&pl->parent_hashmap, pl_hashmap_cmp, NULL, 0);
>>                  pl->use_cone_patterns = 1;
>>
>> -               if (use_stdin) {
>> +               if (file) {
>>                          struct strbuf unquoted = STRBUF_INIT;
>> -                       while (!strbuf_getline(&line, stdin)) {
>> +                       while (!strbuf_getline(&line, file)) {
>>                                  if (line.buf[0] == '"') {
>>                                          strbuf_reset(&unquoted);
>>                                          if (unquote_c_style(&unquoted, line.buf, NULL))
>> @@ -581,10 +584,10 @@ static void add_patterns_from_input(struct pattern_list *pl,
>>                          }
>>                  }
>>          } else {
>> -               if (use_stdin) {
>> +               if (file) {
>>                          struct strbuf line = STRBUF_INIT;
>>
>> -                       while (!strbuf_getline(&line, stdin)) {
>> +                       while (!strbuf_getline(&line, file)) {
>>                                  size_t len;
>>                                  char *buf = strbuf_detach(&line, &len);
>>                                  add_pattern(buf, empty_base, 0, pl, 0);
>> @@ -611,7 +614,8 @@ static void add_patterns_cone_mode(int argc, const char **argv,
>>          struct pattern_list existing;
>>          char *sparse_filename = get_sparse_checkout_filename();
>>
>> -       add_patterns_from_input(pl, argc, argv, use_stdin);
>> +       add_patterns_from_input(pl, argc, argv,
>> +                               use_stdin ? stdin : NULL);
>>
>>          memset(&existing, 0, sizeof(existing));
>>          existing.use_cone_patterns = core_sparse_checkout_cone;
>> @@ -648,7 +652,7 @@ static void add_patterns_literal(int argc, const char **argv,
>>                                             pl, NULL, 0))
>>                  die(_("unable to load existing sparse-checkout patterns"));
>>          free(sparse_filename);
>> -       add_patterns_from_input(pl, argc, argv, use_stdin);
>> +       add_patterns_from_input(pl, argc, argv, use_stdin ? stdin : NULL);
>>   }
>>
>>   static int modify_pattern_list(int argc, const char **argv, int use_stdin,
>> @@ -667,7 +671,8 @@ static int modify_pattern_list(int argc, const char **argv, int use_stdin,
>>                  break;
>>
>>          case REPLACE:
>> -               add_patterns_from_input(pl, argc, argv, use_stdin);
>> +               add_patterns_from_input(pl, argc, argv,
>> +                                       use_stdin ? stdin : NULL);
>>                  break;
>>          }
>>
>> @@ -929,6 +934,86 @@ static int sparse_checkout_disable(int argc, const char **argv,
>>          return set_config(MODE_NO_PATTERNS);
>>   }
>>
>> +static char const * const builtin_sparse_checkout_check_rules_usage[] = {
>> +       N_("git sparse-checkout check-rules [-z] [--skip-checks]"
>> +          "[--[no-]cone] [--rules-file <file>]"),
>> +       NULL
>> +};
>> +
>> +static struct sparse_checkout_check_rules_opts {
>> +       int cone_mode;
>> +       int null_termination;
>> +       char *rules_file;
>> +} check_rules_opts;
>> +
>> +static int check_rules(struct pattern_list *pl, int null_terminated) {
>> +       struct strbuf line = STRBUF_INIT;
>> +       struct strbuf unquoted = STRBUF_INIT;
>> +       char *path;
>> +       int line_terminator = null_terminated ? 0 : '\n';
>> +       strbuf_getline_fn getline_fn = null_terminated ? strbuf_getline_nul
>> +               : strbuf_getline;
>> +       the_repository->index->sparse_checkout_patterns = pl;
>> +       while (!getline_fn(&line, stdin)) {
> 
> strbuf_getline_nul() and strbuf_getline() are documented as
> overwriting their strbuf, so there is no need to clear line.
> 
>> +               path = line.buf;
>> +               if (!null_terminated && line.buf[0] == '"') {
>> +                       strbuf_reset(&unquoted);
>> +                       if (unquote_c_style(&unquoted, line.buf, NULL))
> 
> unquote_c_style() is documented as appending to its strbuf, but you
> handle that via the strbuf_reset() on the line before.
> 
>> +                               die(_("unable to unquote C-style string '%s'"),
>> +                                       line.buf);
>> +
>> +                       path = unquoted.buf;
>> +               }
>> +
>> +               if (path_in_sparse_checkout(path, the_repository->index))
>> +                       write_name_quoted(path, stdout, line_terminator);
>> +       }
> 
> Do you need to call strbuf_release() for both line and unquoted here?
> I think you might have a small leak.
> 

I think you are right. I'll make sure to do that.

>> +
>> +       return 0;
>> +}
>> +
>> +static int sparse_checkout_check_rules(int argc, const char **argv, const char *prefix)
>> +{
>> +       static struct option builtin_sparse_checkout_check_rules_options[] = {
>> +               OPT_BOOL('z', NULL, &check_rules_opts.null_termination,
>> +                        N_("terminate input and output files by a NUL character")),
>> +               OPT_BOOL(0, "cone", &check_rules_opts.cone_mode,
>> +                        N_("when used with --rules-file interpret patterns as cone mode patterns")),
>> +               OPT_FILENAME(0, "rules-file", &check_rules_opts.rules_file,
>> +                        N_("use patterns in <file> instead of the current ones.")),
>> +               OPT_END(),
>> +       };
>> +
>> +       FILE *fp;
>> +       int ret;
>> +       struct pattern_list pl = {0};
>> +       char *sparse_filename;
>> +       check_rules_opts.cone_mode = -1;
>> +
>> +       argc = parse_options(argc, argv, prefix,
>> +                            builtin_sparse_checkout_check_rules_options,
>> +                            builtin_sparse_checkout_check_rules_usage,
>> +                            PARSE_OPT_KEEP_UNKNOWN_OPT);
>> +
>> +       update_cone_mode(&check_rules_opts.cone_mode);
>> +       pl.use_cone_patterns = core_sparse_checkout_cone;
>> +       if (check_rules_opts.rules_file) {
>> +               fp = xfopen(check_rules_opts.rules_file, "r");
>> +               add_patterns_from_input(&pl, argc, argv, fp);
>> +               fclose(fp);
>> +       } else {
>> +               sparse_filename = get_sparse_checkout_filename();
>> +               if (add_patterns_from_file_to_list(sparse_filename, "", 0, &pl,
>> +                                                  NULL, 0))
>> +                       die(_("unable to load existing sparse-checkout patterns"));
>> +               free(sparse_filename);
>> +       }
>> +
>> +       ret = check_rules(&pl, check_rules_opts.null_termination);
>> +       clear_pattern_list(&pl);
>> +       return ret;
>> +}
>> +
>>   int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
>>   {
>>          parse_opt_subcommand_fn *fn = NULL;
>> @@ -939,6 +1024,7 @@ int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
>>                  OPT_SUBCOMMAND("add", &fn, sparse_checkout_add),
>>                  OPT_SUBCOMMAND("reapply", &fn, sparse_checkout_reapply),
>>                  OPT_SUBCOMMAND("disable", &fn, sparse_checkout_disable),
>> +               OPT_SUBCOMMAND("check-rules", &fn, sparse_checkout_check_rules),
>>                  OPT_END(),
>>          };
>>
>> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
>> index 7216267aec7..521dc914fa7 100755
>> --- a/t/t1091-sparse-checkout-builtin.sh
>> +++ b/t/t1091-sparse-checkout-builtin.sh
>> @@ -555,7 +555,7 @@ test_expect_success 'cone mode: set with core.ignoreCase=true' '
>>          check_files repo a folder1
>>   '
>>
>> -test_expect_success 'interaction with submodules' '
>> +test_expect_success 'setup submodules' '
>>          git clone repo super &&
>>          (
>>                  cd super &&
>> @@ -566,11 +566,22 @@ test_expect_success 'interaction with submodules' '
>>                  git commit -m "add submodule" &&
>>                  git sparse-checkout init --cone &&
>>                  git sparse-checkout set folder1
>> -       ) &&
>> +       )
>> +'
>> +
>> +test_expect_success 'interaction with submodules' '
>>          check_files super a folder1 modules &&
>>          check_files super/modules/child a deep folder1 folder2
>>   '
>>
>> +test_expect_success 'check-rules interaction with submodules' '
>> +       git -C super ls-tree --name-only -r HEAD >all-files &&
>> +       git -C super sparse-checkout check-rules >check-rules-matches <all-files &&
>> +
>> +       test_i18ngrep ! "modules/" check-rules-matches &&
>> +       test_i18ngrep "folder1/" check-rules-matches
> 
> This file already uses test_i18ngrep, so continuing to use it is okay
> just for consistency.  But in general test_i18ngrep is deprecated
> ("Should not be used and will be removed soon." according to the docs;
> soon is relative) and we prefer to just use grep.
> 

Ah. Thanks. I didn't know. I'll leave it for consistency.

>> +'
>> +
>>   test_expect_success 'different sparse-checkouts with worktrees' '
>>          git -C repo sparse-checkout set --cone deep folder1 &&
>>          git -C repo worktree add --detach ../worktree &&
>> @@ -915,4 +926,118 @@ test_expect_success 'disable fails outside work tree' '
>>          test_i18ngrep "this operation must be run in a work tree" err
>>   '
>>
>> +test_expect_success 'setup clean' '
>> +       git -C repo clean -fdx
>> +'
>> +
>> +test_expect_success 'check-rules cone mode' '
>> +       cat >rules <<-\EOF &&
>> +       folder1
>> +       deep/deeper1/deepest
>> +       EOF
>> +
>> +       git -C bare ls-tree -r --name-only HEAD >all-files &&
>> +       git -C bare sparse-checkout check-rules --cone \
>> +               --rules-file ../rules >check-rules-file <all-files &&
>> +
>> +       git -C repo sparse-checkout set --cone --stdin <rules&&
>> +       git -C repo ls-files -t >out &&
>> +       sed -n "/^S /!s/^. //p" out >ls-files &&
>> +
>> +       git -C repo sparse-checkout check-rules >check-rules-default <all-files &&
>> +
>> +       test_i18ngrep "deep/deeper1/deepest/a" check-rules-file &&
>> +       test_i18ngrep ! "deep/deeper2" check-rules-file &&
>> +
>> +       test_cmp check-rules-file ls-files &&
>> +       test_cmp check-rules-file check-rules-default
>> +'
>> +
>> +test_expect_success 'check-rules non-cone mode' '
>> +       cat >rules <<-\EOF &&
>> +       deep/deeper1/deepest/a
>> +       EOF
>> +
>> +       git -C bare ls-tree -r --name-only HEAD >all-files &&
>> +       git -C bare sparse-checkout check-rules --no-cone --rules-file ../rules\
>> +               >check-rules-file <all-files &&
>> +
>> +       cat rules | git -C repo sparse-checkout set --no-cone --stdin &&
>> +       git -C repo ls-files -t >out &&
>> +       sed -n "/^S /!s/^. //p" out >ls-files &&
>> +
>> +       git -C repo sparse-checkout check-rules >check-rules-default <all-files &&
>> +
>> +       cat >expect <<-\EOF &&
>> +       deep/deeper1/deepest/a
>> +       EOF
>> +
>> +       test_cmp expect check-rules-file &&
>> +       test_cmp check-rules-file ls-files &&
>> +       test_cmp check-rules-file check-rules-default
>> +'
>> +
>> +test_expect_success 'check-rules cone mode is default' '
>> +       cat >rules <<-\EOF &&
>> +       folder1
>> +       EOF
>> +
>> +       cat >all-files <<-\EOF &&
>> +       toplevel
>> +       folder2/file
>> +       folder1/file
>> +       EOF
>> +
>> +       cat >expect <<-\EOF &&
>> +       toplevel
>> +       folder1/file
>> +       EOF
>> +
>> +       git -C bare sparse-checkout check-rules \
>> +               --rules-file ../rules >actual <all-files &&
>> +
>> +       test_cmp expect actual
> 
> This test is checking that despite whatever sparse-checkout setting we
> have, that the --rules-files option makes it ignore those rules and
> use the specified one instead, and in particular that cone mode is
> assumed when nothing is specified with --rules-file.  The test is
> stronger because the test right before this one did a non-cone-mode
> checkout.  But since this test didn't itself do a non-cone-mode
> checkout, that extra strength of the test could be lost by a future
> contributor inserting another test between these.  It's not a big
> deal, but perhaps it'd make sense to have this test add a `git
> sparse-checkout set --no-cone ...` call near the beginning?
> 

That's a good point. I'll add that.

>> +'
>> +
>> +test_expect_success 'check-rules quoting' '
>> +       cat >rules <<-EOF &&
>> +       "folder\" a"
>> +       EOF
>> +       cat >files <<-EOF &&
>> +       "folder\" a/file"
>> +       "folder\" b/file"
>> +       EOF
>> +       cat >expect <<-EOF &&
>> +       "folder\" a/file"
>> +       EOF
>> +       git sparse-checkout check-rules --cone \
>> +               --rules-file rules >actual <files &&
>> +
>> +       test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'check-rules null termination' '
>> +       cat >rules <<-EOF &&
>> +       "folder\" a"
>> +       EOF
>> +
>> +       lf_to_nul >files <<-EOF &&
>> +       folder" a/a
>> +       folder" a/b
>> +       folder" b/fileQ
>> +       EOF
>> +
>> +       cat >expect <<-EOF &&
>> +       folder" a/aQfolder" a/bQ
>> +       EOF
>> +
>> +       git sparse-checkout check-rules --cone -z \
>> +               --rules-file rules >actual.nul <files &&
>> +       nul_to_q <actual.nul >actual &&
>> +       echo >>actual &&
>> +
>> +       test_cmp expect actual
>> +'
>> +
>> +
>>   test_done
>> --
>> gitgitgadget
> 
> Overall, nicely done.  I only found minor things to comment on, and
> like the overall design, explanation, and implementation.

Thanks for taking the time to review.
