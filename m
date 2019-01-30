Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D3C61F453
	for <e@80x24.org>; Wed, 30 Jan 2019 19:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733280AbfA3TvW (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 14:51:22 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:32793 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbfA3TvN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 14:51:13 -0500
Received: by mail-ed1-f65.google.com with SMTP id p6so672090eds.0
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 11:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CV7WGoNKdqnK9FZ81EaPWncoNYCYEdobDJpYb9pm9hk=;
        b=LjRHosplq8cO7Sb8ABoOodHYbQijJElg4f8+w6I+SX8uIM5EdRs6KeE+RX8856fl4X
         JxDpHUxyRSPyEqXWyMYRK+F8xrnQN/ebSMIR3ZVfFQvl9B67kIcF4pUjwQ6atzov9SFl
         eYl0veF8E95r2xQ5VaoKvupAvTwCJIaFgoa2KwjmR1Wl5Fa3FWCYyheW5x0ObgT0Cnem
         1Qy0pLJDtW4fZBqSQHYgG55H2g6kB2QdwFSHt2UghtAWBcihQkjoON5afmMr5fs/QOYr
         rchTlYU8jF53UW48GyHb2jcqakVrJkZoYAb+6veV7Q42aSSJZsPOdBf5YNcJEjQIHPtu
         jfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CV7WGoNKdqnK9FZ81EaPWncoNYCYEdobDJpYb9pm9hk=;
        b=JNPH+Cd1NtkT3oksG1Ax9V7S/4BoYySInPUxJ27xSMJzw2NOcE3eTVoUiv+azqdNWK
         Tp8MqwvyMjUMzUArMXprh1TrhSwvTgxpS7ZcuSm0iFjBXiz0KzsodbpTh1pEolAGzFIk
         K6w2ks8SFW5J0S3Drf1CbzwALP1Ogk1lfeZAJ+7+TbN7utORGdyYeU/0voPcFLuUCQa/
         lTI3zkRIdtlnTU2x+pOw6QYX3EhHBwizhInUJfP60Wr+xXnGAb/duZfy++bspMbRQ5E3
         aBQ1dB6y2ouB/QwRn9mJ/7/ufkrLphejlNlsNRsrehRUJuYuiBgMmyxvlk7upRgZC+cZ
         9bWA==
X-Gm-Message-State: AJcUuke0fejQ/XnItqyx8AJRetishTMThIAtORHpFLfTlG8MiEd9m5ik
        NQSjonGbi9u8W/ReZAxpStEGYyL6
X-Google-Smtp-Source: ALg8bN5EHMo445Ct9NvOH2GXsQXw/ecUyn4ddHo6bYWOL1f/YByWXyzEEcE4WpwEgPx0sUFOUpXkWA==
X-Received: by 2002:a05:6402:1816:: with SMTP id g22mr32069710edy.191.1548877864854;
        Wed, 30 Jan 2019 11:51:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m13sm764567edd.2.2019.01.30.11.51.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 11:51:04 -0800 (PST)
Date:   Wed, 30 Jan 2019 11:51:04 -0800 (PST)
X-Google-Original-Date: Wed, 30 Jan 2019 19:50:49 GMT
Message-Id: <pull.108.v3.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v2.git.gitgitgadget@gmail.com>
References: <pull.108.v2.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 00/14] Trace2 tracing facility
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

V3 addresses: [] re-fix the trace2 tests using an inline environment
variable rather than exporting and unsetting. [] overhaul the design
document to include prototype declarations and more file format information.
[] incorporate most of the suggestions from clang-format. [] add ability to
trace to a unix domain socket. [] added forward declarations suggested by
Ramsay. [] rebased onto current master to fixup conflict with
sb/submodule-recursive-fetch-gets-the-tip that was merged yesterday.


----------------------------------------------------------------------------

V2 addresses: [] "jh/trace2" bad interaction with "js/vsts-ci" in "pu". []
coccinelle warnings in trace2/tr2_tgt_perf.c reported during CI testing.


----------------------------------------------------------------------------

This patch series contains a greatly refactored version of my original
Trace2 series [1] from August 2018.

A new design doc in Documentation/technical/api-trace2.txt (in the first
commit) explains the relationship of Trace2 to the current tracing facility.
Calls to the current tracing facility have not been changed, rather new
trace2 calls have been added so that both continue to work in parallel for
the time being.

[1] https://public-inbox.org/git/pull.29.git.gitgitgadget@gmail.com/

Cc: gitster@pobox.comCc: peff@peff.netCc: jrnieder@gmail.com

Derrick Stolee (1):
  pack-objects: add trace2 regions

Jeff Hostetler (13):
  trace2: Documentation/technical/api-trace2.txt
  trace2: create new combined trace facility
  trace2: collect platform-specific process information
  trace2:data: add trace2 regions to wt-status
  trace2:data: add editor/pager child classification
  trace2:data: add trace2 sub-process classification
  trace2:data: add trace2 transport child classification
  trace2:data: add trace2 hook classification
  trace2:data: add trace2 instrumentation to index read/write
  trace2:data: add subverb to checkout command
  trace2:data: add subverb to reset command
  trace2:data: add subverb for rebase
  trace2: t/helper/test-trace2, t0210.sh, t0211.sh, t0212.sh

 Documentation/technical/api-trace2.txt | 1347 ++++++++++++++++++++++++
 Makefile                               |   11 +
 builtin/am.c                           |    1 +
 builtin/checkout.c                     |    7 +
 builtin/pack-objects.c                 |   16 +-
 builtin/rebase.c                       |   17 +
 builtin/receive-pack.c                 |    4 +
 builtin/reset.c                        |    6 +
 builtin/submodule--helper.c            |    9 +-
 builtin/worktree.c                     |    1 +
 cache.h                                |    1 +
 common-main.c                          |   13 +-
 compat/mingw.c                         |   11 +-
 compat/mingw.h                         |    3 +-
 compat/win32/ancestry.c                |  101 ++
 config.c                               |    2 +
 config.mak.uname                       |    2 +
 connect.c                              |    3 +
 editor.c                               |    1 +
 exec-cmd.c                             |    2 +
 git-compat-util.h                      |    7 +
 git.c                                  |   65 ++
 pager.c                                |    1 +
 read-cache.c                           |   51 +-
 remote-curl.c                          |    7 +
 repository.c                           |    2 +
 repository.h                           |    3 +
 run-command.c                          |   59 +-
 run-command.h                          |   13 +-
 sequencer.c                            |    2 +
 sh-i18n--envsubst.c                    |    3 +
 sub-process.c                          |    1 +
 submodule.c                            |   11 +-
 t/helper/test-parse-options.c          |    3 +
 t/helper/test-tool.c                   |    4 +
 t/helper/test-tool.h                   |    1 +
 t/helper/test-trace2.c                 |  274 +++++
 t/t0001-init.sh                        |    1 +
 t/t0210-trace2-normal.sh               |  135 +++
 t/t0210/scrub_normal.perl              |   48 +
 t/t0211-trace2-perf.sh                 |  153 +++
 t/t0211/scrub_perf.perl                |   76 ++
 t/t0212-trace2-event.sh                |  234 ++++
 t/t0212/parse_events.perl              |  251 +++++
 trace2.c                               |  807 ++++++++++++++
 trace2.h                               |  380 +++++++
 trace2/tr2_cfg.c                       |   90 ++
 trace2/tr2_cfg.h                       |   19 +
 trace2/tr2_dst.c                       |  198 ++++
 trace2/tr2_dst.h                       |   36 +
 trace2/tr2_sid.c                       |   67 ++
 trace2/tr2_sid.h                       |   18 +
 trace2/tr2_tbuf.c                      |   32 +
 trace2/tr2_tbuf.h                      |   23 +
 trace2/tr2_tgt.h                       |  131 +++
 trace2/tr2_tgt_event.c                 |  590 +++++++++++
 trace2/tr2_tgt_normal.c                |  325 ++++++
 trace2/tr2_tgt_perf.c                  |  536 ++++++++++
 trace2/tr2_tls.c                       |  164 +++
 trace2/tr2_tls.h                       |   97 ++
 trace2/tr2_verb.c                      |   30 +
 trace2/tr2_verb.h                      |   24 +
 transport-helper.c                     |    2 +
 transport.c                            |    1 +
 usage.c                                |   31 +
 wt-status.c                            |   24 +-
 66 files changed, 6567 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/technical/api-trace2.txt
 create mode 100644 compat/win32/ancestry.c
 create mode 100644 t/helper/test-trace2.c
 create mode 100755 t/t0210-trace2-normal.sh
 create mode 100644 t/t0210/scrub_normal.perl
 create mode 100755 t/t0211-trace2-perf.sh
 create mode 100644 t/t0211/scrub_perf.perl
 create mode 100755 t/t0212-trace2-event.sh
 create mode 100644 t/t0212/parse_events.perl
 create mode 100644 trace2.c
 create mode 100644 trace2.h
 create mode 100644 trace2/tr2_cfg.c
 create mode 100644 trace2/tr2_cfg.h
 create mode 100644 trace2/tr2_dst.c
 create mode 100644 trace2/tr2_dst.h
 create mode 100644 trace2/tr2_sid.c
 create mode 100644 trace2/tr2_sid.h
 create mode 100644 trace2/tr2_tbuf.c
 create mode 100644 trace2/tr2_tbuf.h
 create mode 100644 trace2/tr2_tgt.h
 create mode 100644 trace2/tr2_tgt_event.c
 create mode 100644 trace2/tr2_tgt_normal.c
 create mode 100644 trace2/tr2_tgt_perf.c
 create mode 100644 trace2/tr2_tls.c
 create mode 100644 trace2/tr2_tls.h
 create mode 100644 trace2/tr2_verb.c
 create mode 100644 trace2/tr2_verb.h


base-commit: b5101f929789889c2e536d915698f58d5c5c6b7a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-108%2Fjeffhostetler%2Fcore-trace2-2019-v0-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-108/jeffhostetler/core-trace2-2019-v0-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/108

Range-diff vs v2:

  1:  1a90de9dab <  -:  ---------- trace2: Documentation/technical/api-trace2.txt
  -:  ---------- >  1:  60b56d6a8f trace2: Documentation/technical/api-trace2.txt
  2:  ea39b76d31 !  2:  bfe2fe0bbe trace2: create new combined trace facility
     @@ -65,12 +65,10 @@
      -			       update_clone_start_failure,
      -			       update_clone_task_finished,
      -			       suc);
     -+	run_processes_parallel_tr2(suc->max_jobs,
     -+				   update_clone_get_next_task,
     ++	run_processes_parallel_tr2(suc->max_jobs, update_clone_get_next_task,
      +				   update_clone_start_failure,
     -+				   update_clone_task_finished,
     -+				   suc,
     -+				   "submodule", "parallel/update");
     ++				   update_clone_task_finished, suc, "submodule",
     ++				   "parallel/update");
       
       	/*
       	 * We saved the output and put it out all at once now.
     @@ -427,7 +425,7 @@
      +	 * we skip this for Windows because the compat layer already
      +	 * has to emulate the execvp() call anyway.
      +	 */
     -+	int exec_id = trace2_exec(file, (const char**)argv);
     ++	int exec_id = trace2_exec(file, (const char **)argv);
      +#endif
      +
       	if (!execvp(file, argv))
     @@ -493,8 +491,8 @@
      +	return run_command_v_opt_cd_env_tr2(argv, opt, dir, env, NULL);
      +}
      +
     -+int run_command_v_opt_cd_env_tr2(const char **argv, int opt, const char *dir, const char *const *env,
     -+				 const char *tr2_class)
     ++int run_command_v_opt_cd_env_tr2(const char **argv, int opt, const char *dir,
     ++				 const char *const *env, const char *tr2_class)
       {
       	struct child_process cmd = CHILD_PROCESS_INIT;
       	cmd.argv = argv;
     @@ -519,18 +517,15 @@
       	return 0;
       }
      +
     -+int run_processes_parallel_tr2(int n,
     -+			       get_next_task_fn get_next_task,
     ++int run_processes_parallel_tr2(int n, get_next_task_fn get_next_task,
      +			       start_failure_fn start_failure,
     -+			       task_finished_fn task_finished,
     -+			       void *pp_cb,
     -+			       const char *tr2_category,
     -+			       const char *tr2_label)
     ++			       task_finished_fn task_finished, void *pp_cb,
     ++			       const char *tr2_category, const char *tr2_label)
      +{
      +	int result;
      +
     -+	trace2_region_enter_printf(tr2_category, tr2_label, NULL,
     -+				   "max:%d", ((n < 1) ? online_cpus() : n));
     ++	trace2_region_enter_printf(tr2_category, tr2_label, NULL, "max:%d",
     ++				   ((n < 1) ? online_cpus() : n));
      +
      +	result = run_processes_parallel(n, get_next_task, start_failure,
      +					task_finished, pp_cb);
     @@ -539,7 +534,6 @@
      +
      +	return result;
      +}
     -+
      
       diff --git a/run-command.h b/run-command.h
       --- a/run-command.h
     @@ -568,8 +562,8 @@
        * To unset an environment variable use just "VAR".
        */
       int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir, const char *const *env);
     -+int run_command_v_opt_cd_env_tr2(const char **argv, int opt, const char *dir, const char *const *env,
     -+				 const char *tr2_class);
     ++int run_command_v_opt_cd_env_tr2(const char **argv, int opt, const char *dir,
     ++				 const char *const *env, const char *tr2_class);
       
       /**
        * Execute the given command, sending "in" to its stdin, and capturing its
     @@ -577,13 +571,9 @@
       			   start_failure_fn,
       			   task_finished_fn,
       			   void *pp_cb);
     -+int run_processes_parallel_tr2(int n,
     -+			       get_next_task_fn,
     -+			       start_failure_fn,
     -+			       task_finished_fn,
     -+			       void *pp_cb,
     -+			       const char *tr2_category,
     -+			       const char *tr2_label);
     ++int run_processes_parallel_tr2(int n, get_next_task_fn, start_failure_fn,
     ++			       task_finished_fn, void *pp_cb,
     ++			       const char *tr2_category, const char *tr2_label);
       
       #endif
      
     @@ -612,9 +602,9 @@
       --- a/submodule.c
       +++ b/submodule.c
      @@
     - 	/* default value, "--submodule-prefix" and its value are added later */
       
     - 	calculate_changed_submodule_paths(r);
     + 	calculate_changed_submodule_paths(r, &spf.changed_submodule_names);
     + 	string_list_sort(&spf.changed_submodule_names);
      -	run_processes_parallel(max_parallel_jobs,
      -			       get_next_submodule,
      -			       fetch_start_failure,
     @@ -727,9 +717,8 @@
      +	     tgt_j;					\
      +	     j++, tgt_j = tr2_tgt_builtins[j])
      +
     -+#define for_each_wanted_builtin(j, tgt_j)	\
     -+	for_each_builtin(j, tgt_j)		\
     -+	if (tr2_dst_trace_want(tgt_j->pdst))
     ++#define for_each_wanted_builtin(j, tgt_j) \
     ++	for_each_builtin(j, tgt_j) if (tr2_dst_trace_want(tgt_j->pdst))
      +
      +/*
      + * Force (rather than lazily) initialize any of the requested
     @@ -745,7 +734,8 @@
      +	int j;
      +	int sum = 0;
      +
     -+	for_each_builtin(j, tgt_j) {
     ++	for_each_builtin(j, tgt_j)
     ++	{
      +		if (tgt_j->pfn_init())
      +			sum++;
      +	}
     @@ -763,7 +753,8 @@
      +	struct tr2_tgt *tgt_j;
      +	int j;
      +
     -+	for_each_builtin(j, tgt_j) {
     ++	for_each_builtin(j, tgt_j)
     ++	{
      +		tgt_j->pfn_term();
      +	}
      +}
     @@ -794,8 +785,9 @@
      +	 * the trace output if someone calls die(), for example.
      +	 */
      +	tr2tls_pop_unwind_self();
     -+	
     -+	for_each_wanted_builtin(j, tgt_j) {
     ++
     ++	for_each_wanted_builtin(j, tgt_j)
     ++	{
      +		if (tgt_j->pfn_atexit)
      +			tgt_j->pfn_atexit(us_elapsed_absolute,
      +					  tr2main_exit_code);
     @@ -821,7 +813,8 @@
      +	us_now = getnanotime() / 1000;
      +	us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
      +
     -+	for_each_wanted_builtin(j, tgt_j) {
     ++	for_each_wanted_builtin(j, tgt_j)
     ++	{
      +		if (tgt_j->pfn_signal)
      +			tgt_j->pfn_signal(us_elapsed_absolute, signo);
      +	}
     @@ -851,7 +844,8 @@
      +	/*
      +	 * Emit 'version' message on each active builtin target.
      +	 */
     -+	for_each_wanted_builtin(j, tgt_j) {
     ++	for_each_wanted_builtin(j, tgt_j)
     ++	{
      +		if (tgt_j->pfn_version_fl)
      +			tgt_j->pfn_version_fl(file, line);
      +	}
     @@ -870,7 +864,8 @@
      +	if (!trace2_enabled)
      +		return;
      +
     -+	for_each_wanted_builtin(j, tgt_j) {
     ++	for_each_wanted_builtin(j, tgt_j)
     ++	{
      +		if (tgt_j->pfn_start_fl)
      +			tgt_j->pfn_start_fl(file, line, argv);
      +	}
     @@ -893,16 +888,18 @@
      +	us_now = getnanotime() / 1000;
      +	us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
      +
     -+	for_each_wanted_builtin(j, tgt_j) {
     ++	for_each_wanted_builtin(j, tgt_j)
     ++	{
      +		if (tgt_j->pfn_exit_fl)
     -+			tgt_j->pfn_exit_fl(file, line, us_elapsed_absolute, code);
     ++			tgt_j->pfn_exit_fl(file, line, us_elapsed_absolute,
     ++					   code);
      +	}
      +
      +	return code;
      +}
      +
     -+void trace2_cmd_error_va_fl(const char *file, int line,
     -+			    const char *fmt, va_list ap)
     ++void trace2_cmd_error_va_fl(const char *file, int line, const char *fmt,
     ++			    va_list ap)
      +{
      +	struct tr2_tgt *tgt_j;
      +	int j;
     @@ -914,7 +911,8 @@
      +	 * We expect each target function to treat 'ap' as constant
      +	 * and use va_copy (because an 'ap' can only be walked once).
      +	 */
     -+	for_each_wanted_builtin(j, tgt_j) {
     ++	for_each_wanted_builtin(j, tgt_j)
     ++	{
      +		if (tgt_j->pfn_error_va_fl)
      +			tgt_j->pfn_error_va_fl(file, line, fmt, ap);
      +	}
     @@ -928,7 +926,8 @@
      +	if (!trace2_enabled)
      +		return;
      +
     -+	for_each_wanted_builtin(j, tgt_j) {
     ++	for_each_wanted_builtin(j, tgt_j)
     ++	{
      +		if (tgt_j->pfn_command_path_fl)
      +			tgt_j->pfn_command_path_fl(file, line, pathname);
      +	}
     @@ -946,7 +945,8 @@
      +	tr2_verb_append_hierarchy(command_verb);
      +	hierarchy = tr2_verb_get_hierarchy();
      +
     -+	for_each_wanted_builtin(j, tgt_j) {
     ++	for_each_wanted_builtin(j, tgt_j)
     ++	{
      +		if (tgt_j->pfn_command_verb_fl)
      +			tgt_j->pfn_command_verb_fl(file, line, command_verb,
      +						   hierarchy);
     @@ -962,15 +962,16 @@
      +	if (!trace2_enabled)
      +		return;
      +
     -+	for_each_wanted_builtin(j, tgt_j) {
     ++	for_each_wanted_builtin(j, tgt_j)
     ++	{
      +		if (tgt_j->pfn_command_subverb_fl)
      +			tgt_j->pfn_command_subverb_fl(file, line,
      +						      command_subverb);
      +	}
      +}
      +
     -+void trace2_cmd_alias_fl(const char *file, int line,
     -+			 const char *alias, const char **argv)
     ++void trace2_cmd_alias_fl(const char *file, int line, const char *alias,
     ++			 const char **argv)
      +{
      +	struct tr2_tgt *tgt_j;
      +	int j;
     @@ -978,7 +979,8 @@
      +	if (!trace2_enabled)
      +		return;
      +
     -+	for_each_wanted_builtin(j, tgt_j) {
     ++	for_each_wanted_builtin(j, tgt_j)
     ++	{
      +		if (tgt_j->pfn_alias_fl)
      +			tgt_j->pfn_alias_fl(file, line, alias, argv);
      +	}
     @@ -992,8 +994,8 @@
      +	tr2_cfg_list_config_fl(file, line);
      +}
      +
     -+void trace2_cmd_set_config_fl(const char *file, int line,
     -+			      const char *key, const char *value)
     ++void trace2_cmd_set_config_fl(const char *file, int line, const char *key,
     ++			      const char *value)
      +{
      +	if (!trace2_enabled)
      +		return;
     @@ -1018,15 +1020,15 @@
      +	cmd->trace2_child_id = tr2tls_locked_increment(&tr2_next_child_id);
      +	cmd->trace2_child_us_start = us_now;
      +
     -+	for_each_wanted_builtin(j, tgt_j) {
     ++	for_each_wanted_builtin(j, tgt_j)
     ++	{
      +		if (tgt_j->pfn_child_start_fl)
      +			tgt_j->pfn_child_start_fl(file, line,
      +						  us_elapsed_absolute, cmd);
      +	}
      +}
      +
     -+void trace2_child_exit_fl(const char *file, int line,
     -+			  struct child_process *cmd,
     ++void trace2_child_exit_fl(const char *file, int line, struct child_process *cmd,
      +			  int child_exit_code)
      +{
      +	struct tr2_tgt *tgt_j;
     @@ -1040,24 +1042,25 @@
      +
      +	us_now = getnanotime() / 1000;
      +	us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
     -+	
     ++
      +	if (cmd->trace2_child_us_start)
      +		us_elapsed_child = us_now - cmd->trace2_child_us_start;
      +	else
      +		us_elapsed_child = 0;
     -+	
     -+	for_each_wanted_builtin(j, tgt_j) {
     ++
     ++	for_each_wanted_builtin(j, tgt_j)
     ++	{
      +		if (tgt_j->pfn_child_exit_fl)
     -+			tgt_j->pfn_child_exit_fl(
     -+				file, line, us_elapsed_absolute,
     -+				cmd->trace2_child_id,
     -+				cmd->pid,
     -+				child_exit_code, us_elapsed_child);
     ++			tgt_j->pfn_child_exit_fl(file, line,
     ++						 us_elapsed_absolute,
     ++						 cmd->trace2_child_id, cmd->pid,
     ++						 child_exit_code,
     ++						 us_elapsed_child);
      +	}
      +}
      +
     -+int trace2_exec_fl(const char *file, int line,
     -+		   const char *exe, const char **argv)
     ++int trace2_exec_fl(const char *file, int line, const char *exe,
     ++		   const char **argv)
      +{
      +	struct tr2_tgt *tgt_j;
      +	int j;
     @@ -1073,7 +1076,8 @@
      +
      +	exec_id = tr2tls_locked_increment(&tr2_next_exec_id);
      +
     -+	for_each_wanted_builtin(j, tgt_j) {
     ++	for_each_wanted_builtin(j, tgt_j)
     ++	{
      +		if (tgt_j->pfn_exec_fl)
      +			tgt_j->pfn_exec_fl(file, line, us_elapsed_absolute,
      +					   exec_id, exe, argv);
     @@ -1095,16 +1099,15 @@
      +	us_now = getnanotime() / 1000;
      +	us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
      +
     -+	for_each_wanted_builtin(j, tgt_j) {
     ++	for_each_wanted_builtin(j, tgt_j)
     ++	{
      +		if (tgt_j->pfn_exec_result_fl)
     -+			tgt_j->pfn_exec_result_fl(file, line,
     -+						  us_elapsed_absolute,
     -+						  exec_id, code);
     ++			tgt_j->pfn_exec_result_fl(
     ++				file, line, us_elapsed_absolute, exec_id, code);
      +	}
      +}
      +
     -+void trace2_thread_start_fl(const char *file, int line,
     -+			    const char *thread_name)
     ++void trace2_thread_start_fl(const char *file, int line, const char *thread_name)
      +{
      +	struct tr2_tgt *tgt_j;
      +	int j;
     @@ -1114,8 +1117,7 @@
      +	if (!trace2_enabled)
      +		return;
      +
     -+	if (tr2tls_is_main_thread())
     -+	{
     ++	if (tr2tls_is_main_thread()) {
      +		/*
      +		 * We should only be called from the new thread's thread-proc,
      +		 * so this is technically a bug.  But in those cases where the
     @@ -1123,7 +1125,7 @@
      +		 * are built with threading disabled), we need to allow it.
      +		 *
      +		 * Convert this call to a region-enter so the nesting looks
     -+		 * looks correct.  
     ++		 * correct.
      +		 */
      +		trace2_region_enter_printf_fl(file, line, NULL, NULL, NULL,
      +					      "thread-proc on main: %s",
     @@ -1136,7 +1138,8 @@
      +
      +	tr2tls_create_self(thread_name);
      +
     -+	for_each_wanted_builtin(j, tgt_j) {
     ++	for_each_wanted_builtin(j, tgt_j)
     ++	{
      +		if (tgt_j->pfn_thread_start_fl)
      +			tgt_j->pfn_thread_start_fl(file, line,
      +						   us_elapsed_absolute);
     @@ -1154,16 +1157,16 @@
      +	if (!trace2_enabled)
      +		return;
      +
     -+	if (tr2tls_is_main_thread())
     -+	{
     ++	if (tr2tls_is_main_thread()) {
      +		/*
     -+		 * We should only be called from the exiting thread's thread-proc,
     -+		 * so this is technically a bug.  But in those cases where the
     -+		 * main thread also runs the thread-proc function (or when we
     -+		 * are built with threading disabled), we need to allow it.
     ++		 * We should only be called from the exiting thread's
     ++		 * thread-proc, so this is technically a bug.  But in
     ++		 * those cases where the main thread also runs the
     ++		 * thread-proc function (or when we are built with
     ++		 * threading disabled), we need to allow it.
      +		 *
     -+		 * Convert this call to a region-leave so the nesting looks
     -+		 * looks correct.  
     ++		 * Convert this call to a region-leave so the nesting
     ++		 * looks correct.
      +		 */
      +		trace2_region_leave_printf_fl(file, line, NULL, NULL, NULL,
      +					      "thread-proc on main");
     @@ -1181,7 +1184,8 @@
      +	tr2tls_pop_unwind_self();
      +	us_elapsed_thread = tr2tls_region_elasped_self(us_now);
      +
     -+	for_each_wanted_builtin(j, tgt_j) {
     ++	for_each_wanted_builtin(j, tgt_j)
     ++	{
      +		if (tgt_j->pfn_thread_exit_fl)
      +			tgt_j->pfn_thread_exit_fl(file, line,
      +						  us_elapsed_absolute,
     @@ -1191,8 +1195,8 @@
      +	tr2tls_unset_self();
      +}
      +
     -+void trace2_def_param_fl(const char *file, int line,
     -+			 const char *param, const char *value)
     ++void trace2_def_param_fl(const char *file, int line, const char *param,
     ++			 const char *value)
      +{
      +	struct tr2_tgt *tgt_j;
      +	int j;
     @@ -1200,14 +1204,14 @@
      +	if (!trace2_enabled)
      +		return;
      +
     -+	for_each_wanted_builtin(j, tgt_j) {
     ++	for_each_wanted_builtin(j, tgt_j)
     ++	{
      +		if (tgt_j->pfn_param_fl)
      +			tgt_j->pfn_param_fl(file, line, param, value);
      +	}
      +}
      +
     -+void trace2_def_repo_fl(const char *file, int line,
     -+			struct repository *repo)
     ++void trace2_def_repo_fl(const char *file, int line, struct repository *repo)
      +{
      +	struct tr2_tgt *tgt_j;
      +	int j;
     @@ -1220,15 +1224,15 @@
      +
      +	repo->trace2_repo_id = tr2tls_locked_increment(&tr2_next_repo_id);
      +
     -+	for_each_wanted_builtin(j, tgt_j) {
     ++	for_each_wanted_builtin(j, tgt_j)
     ++	{
      +		if (tgt_j->pfn_repo_fl)
      +			tgt_j->pfn_repo_fl(file, line, repo);
      +	}
      +}
      +
      +void trace2_region_enter_printf_va_fl(const char *file, int line,
     -+				      const char *category,
     -+				      const char *label,
     ++				      const char *category, const char *label,
      +				      const struct repository *repo,
      +				      const char *fmt, va_list ap)
      +{
     @@ -1250,59 +1254,53 @@
      +	 * We expect each target function to treat 'ap' as constant
      +	 * and use va_copy.
      +	 */
     -+	for_each_wanted_builtin(j, tgt_j) {
     ++	for_each_wanted_builtin(j, tgt_j)
     ++	{
      +		if (tgt_j->pfn_region_enter_printf_va_fl)
      +			tgt_j->pfn_region_enter_printf_va_fl(
     -+				file, line, us_elapsed_absolute,
     -+				category, label, repo, fmt, ap);
     ++				file, line, us_elapsed_absolute, category,
     ++				label, repo, fmt, ap);
      +	}
      +
      +	tr2tls_push_self(us_now);
      +}
      +
     -+void trace2_region_enter_fl(const char *file, int line,
     -+			    const char *category,
     -+			    const char *label,
     -+			    const struct repository *repo)
     ++void trace2_region_enter_fl(const char *file, int line, const char *category,
     ++			    const char *label, const struct repository *repo)
      +{
     -+	trace2_region_enter_printf_va_fl(file, line,
     -+					 category, label, repo,
     ++	trace2_region_enter_printf_va_fl(file, line, category, label, repo,
      +					 NULL, NULL);
      +}
      +
      +void trace2_region_enter_printf_fl(const char *file, int line,
     -+				   const char *category,
     -+				   const char *label,
     ++				   const char *category, const char *label,
      +				   const struct repository *repo,
      +				   const char *fmt, ...)
      +{
      +	va_list ap;
      +
      +	va_start(ap, fmt);
     -+	trace2_region_enter_printf_va_fl(file, line,
     -+					 category, label, repo,
     -+					 fmt, ap);
     ++	trace2_region_enter_printf_va_fl(file, line, category, label, repo, fmt,
     ++					 ap);
      +	va_end(ap);
      +}
      +
      +#ifndef HAVE_VARIADIC_MACROS
      +void trace2_region_enter_printf(const char *category, const char *label,
     -+				const struct repository *repo,
     -+				const char *fmt, ...)
     ++				const struct repository *repo, const char *fmt,
     ++				...)
      +{
      +	va_list ap;
      +
      +	va_start(ap, fmt);
     -+	trace2_region_enter_printf_va_fl(NULL, 0,
     -+					 category, label, repo,
     -+					 fmt, ap);
     ++	trace2_region_enter_printf_va_fl(NULL, 0, category, label, repo, fmt,
     ++					 ap);
      +	va_end(ap);
      +}
      +#endif
      +
      +void trace2_region_leave_printf_va_fl(const char *file, int line,
     -+				      const char *category,
     -+				      const char *label,
     ++				      const char *category, const char *label,
      +				      const struct repository *repo,
      +				      const char *fmt, va_list ap)
      +{
     @@ -1325,67 +1323,59 @@
      +	 * it lines up with the corresponding push/enter.
      +	 */
      +	us_elapsed_region = tr2tls_region_elasped_self(us_now);
     -+	
     ++
      +	tr2tls_pop_self();
      +
      +	/*
      +	 * We expect each target function to treat 'ap' as constant
      +	 * and use va_copy.
      +	 */
     -+	for_each_wanted_builtin(j, tgt_j) {
     ++	for_each_wanted_builtin(j, tgt_j)
     ++	{
      +		if (tgt_j->pfn_region_leave_printf_va_fl)
      +			tgt_j->pfn_region_leave_printf_va_fl(
      +				file, line, us_elapsed_absolute,
     -+				us_elapsed_region,
     -+				category, label, repo,
     -+				fmt, ap);
     ++				us_elapsed_region, category, label, repo, fmt,
     ++				ap);
      +	}
      +}
      +
     -+void trace2_region_leave_fl(const char *file, int line,
     -+			    const char *category,
     -+			    const char *label,
     -+			    const struct repository *repo)
     ++void trace2_region_leave_fl(const char *file, int line, const char *category,
     ++			    const char *label, const struct repository *repo)
      +{
     -+	trace2_region_leave_printf_va_fl(file, line,
     -+					 category, label, repo,
     ++	trace2_region_leave_printf_va_fl(file, line, category, label, repo,
      +					 NULL, NULL);
      +}
      +
      +void trace2_region_leave_printf_fl(const char *file, int line,
     -+				   const char *category,
     -+				   const char *label,
     ++				   const char *category, const char *label,
      +				   const struct repository *repo,
      +				   const char *fmt, ...)
      +{
      +	va_list ap;
      +
      +	va_start(ap, fmt);
     -+	trace2_region_leave_printf_va_fl(file, line,
     -+					 category, label, repo,
     -+					 fmt, ap);
     ++	trace2_region_leave_printf_va_fl(file, line, category, label, repo, fmt,
     ++					 ap);
      +	va_end(ap);
      +}
      +
      +#ifndef HAVE_VARIADIC_MACROS
      +void trace2_region_leave_printf(const char *category, const char *label,
     -+				const struct repository *repo,
     -+				const char *fmt, ...)
     ++				const struct repository *repo, const char *fmt,
     ++				...)
      +{
      +	va_list ap;
      +
      +	va_start(ap, fmt);
     -+	trace2_region_leave_printf_va_fl(NULL, 0,
     -+					 category, label, repo,
     -+					 fmt, ap);
     ++	trace2_region_leave_printf_va_fl(NULL, 0, category, label, repo, fmt,
     ++					 ap);
      +	va_end(ap);
      +}
      +#endif
      +
     -+void trace2_data_string_fl(const char *file, int line,
     -+			   const char *category,
     -+			   const struct repository *repo,
     -+			   const char *key,
     ++void trace2_data_string_fl(const char *file, int line, const char *category,
     ++			   const struct repository *repo, const char *key,
      +			   const char *value)
      +{
      +	struct tr2_tgt *tgt_j;
     @@ -1401,18 +1391,17 @@
      +	us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
      +	us_elapsed_region = tr2tls_region_elasped_self(us_now);
      +
     -+	for_each_wanted_builtin(j, tgt_j) {
     ++	for_each_wanted_builtin(j, tgt_j)
     ++	{
      +		if (tgt_j->pfn_data_fl)
      +			tgt_j->pfn_data_fl(file, line, us_elapsed_absolute,
     -+					   us_elapsed_region,
     -+					   category, repo, key, value);
     ++					   us_elapsed_region, category, repo,
     ++					   key, value);
      +	}
      +}
      +
     -+void trace2_data_intmax_fl(const char *file, int line,
     -+			   const char *category,
     -+			   const struct repository *repo,
     -+			   const char *key,
     ++void trace2_data_intmax_fl(const char *file, int line, const char *category,
     ++			   const struct repository *repo, const char *key,
      +			   intmax_t value)
      +{
      +	struct strbuf buf_string = STRBUF_INIT;
     @@ -1420,15 +1409,13 @@
      +	if (!trace2_enabled)
      +		return;
      +
     -+	strbuf_addf(&buf_string, "%"PRIdMAX, value);
     ++	strbuf_addf(&buf_string, "%" PRIdMAX, value);
      +	trace2_data_string_fl(file, line, category, repo, key, buf_string.buf);
      +	strbuf_release(&buf_string);
      +}
      +
     -+void trace2_data_json_fl(const char *file, int line,
     -+			 const char *category,
     -+			 const struct repository *repo,
     -+			 const char *key,
     ++void trace2_data_json_fl(const char *file, int line, const char *category,
     ++			 const struct repository *repo, const char *key,
      +			 const struct json_writer *value)
      +{
      +	struct tr2_tgt *tgt_j;
     @@ -1444,16 +1431,17 @@
      +	us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
      +	us_elapsed_region = tr2tls_region_elasped_self(us_now);
      +
     -+	for_each_wanted_builtin(j, tgt_j) {
     ++	for_each_wanted_builtin(j, tgt_j)
     ++	{
      +		if (tgt_j->pfn_data_fl)
      +			tgt_j->pfn_data_json_fl(file, line, us_elapsed_absolute,
     -+						us_elapsed_region,
     -+						category, repo, key, value);
     ++						us_elapsed_region, category,
     ++						repo, key, value);
      +	}
      +}
      +
     -+void trace2_printf_va_fl(const char *file, int line,
     -+			 const char *fmt, va_list ap)
     ++void trace2_printf_va_fl(const char *file, int line, const char *fmt,
     ++			 va_list ap)
      +{
      +	struct tr2_tgt *tgt_j;
      +	int j;
     @@ -1470,15 +1458,15 @@
      +	 * We expect each target function to treat 'ap' as constant
      +	 * and use va_copy.
      +	 */
     -+	for_each_wanted_builtin(j, tgt_j) {
     ++	for_each_wanted_builtin(j, tgt_j)
     ++	{
      +		if (tgt_j->pfn_printf_va_fl)
      +			tgt_j->pfn_printf_va_fl(file, line, us_elapsed_absolute,
      +						fmt, ap);
      +	}
      +}
      +
     -+void trace2_printf_fl(const char *file, int line,
     -+		      const char *fmt, ...)
     ++void trace2_printf_fl(const char *file, int line, const char *fmt, ...)
      +{
      +	va_list ap;
      +
     @@ -1565,8 +1553,8 @@
      + *
      + * Write an error message to the TRACE2 targets.
      + */
     -+void trace2_cmd_error_va_fl(const char *file, int line,
     -+			    const char *fmt, va_list ap);
     ++void trace2_cmd_error_va_fl(const char *file, int line, const char *fmt,
     ++			    va_list ap);
      +
      +#define trace2_cmd_error_va(fmt, ap) \
      +	trace2_cmd_error_va_fl(__FILE__, __LINE__, (fmt), (ap))
     @@ -1579,8 +1567,7 @@
      + */
      +void trace2_cmd_path_fl(const char *file, int line, const char *pathname);
      +
     -+#define trace2_cmd_path(p) \
     -+	trace2_cmd_path_fl(__FILE__, __LINE__, (p))
     ++#define trace2_cmd_path(p) trace2_cmd_path_fl(__FILE__, __LINE__, (p))
      +
      +/*
      + * Emit a 'cmd_verb' event with the canonical name of the (usually)
     @@ -1589,8 +1576,7 @@
      + */
      +void trace2_cmd_verb_fl(const char *file, int line, const char *command_verb);
      +
     -+#define trace2_cmd_verb(v) \
     -+	trace2_cmd_verb_fl(__FILE__, __LINE__, (v))
     ++#define trace2_cmd_verb(v) trace2_cmd_verb_fl(__FILE__, __LINE__, (v))
      +
      +/*
      + * Emit a 'cmd_subverb' event to further describe the command being run.
     @@ -1601,14 +1587,13 @@
      +void trace2_cmd_subverb_fl(const char *file, int line,
      +			   const char *command_subverb);
      +
     -+#define trace2_cmd_subverb(sv) \
     -+	trace2_cmd_subverb_fl(__FILE__, __LINE__, (sv))
     ++#define trace2_cmd_subverb(sv) trace2_cmd_subverb_fl(__FILE__, __LINE__, (sv))
      +
      +/*
      + * Emit an 'alias' expansion event.
      + */
     -+void trace2_cmd_alias_fl(const char *file, int line,
     -+			 const char *alias, const char **argv);
     ++void trace2_cmd_alias_fl(const char *file, int line, const char *alias,
     ++			 const char **argv);
      +
      +#define trace2_cmd_alias(alias, argv) \
      +	trace2_cmd_alias_fl(__FILE__, __LINE__, (alias), (argv))
     @@ -1630,8 +1615,7 @@
      + */
      +void trace2_cmd_list_config_fl(const char *file, int line);
      +
     -+#define trace2_cmd_list_config() \
     -+	trace2_cmd_list_config_fl(__FILE__, __LINE__)
     ++#define trace2_cmd_list_config() trace2_cmd_list_config_fl(__FILE__, __LINE__)
      +
      +/*
      + * Emit a "def_param" event for the given config key/value pair IF
     @@ -1640,8 +1624,8 @@
      + * Use this for new/updated config settings created/updated after
      + * trace2_cmd_list_config() is called.
      + */
     -+void trace2_cmd_set_config_fl(const char *file, int line,
     -+			      const char *key, const char *value);
     ++void trace2_cmd_set_config_fl(const char *file, int line, const char *key,
     ++			      const char *value);
      +
      +#define trace2_cmd_set_config(k, v) \
      +	trace2_cmd_set_config_fl(__FILE__, __LINE__, (k), (v))
     @@ -1656,14 +1640,12 @@
      +void trace2_child_start_fl(const char *file, int line,
      +			   struct child_process *cmd);
      +
     -+#define trace2_child_start(cmd) \
     -+	trace2_child_start_fl(__FILE__, __LINE__, (cmd))
     ++#define trace2_child_start(cmd) trace2_child_start_fl(__FILE__, __LINE__, (cmd))
      +
      +/*
     -+ * Emit a 'child_exit' event after the child process completes. 
     ++ * Emit a 'child_exit' event after the child process completes.
      + */
     -+void trace2_child_exit_fl(const char *file, int line,
     -+			  struct child_process *cmd,
     ++void trace2_child_exit_fl(const char *file, int line, struct child_process *cmd,
      +			  int child_exit_code);
      +
      +#define trace2_child_exit(cmd, code) \
     @@ -1678,11 +1660,10 @@
      + *
      + * Returns the "exec_id".
      + */
     -+int trace2_exec_fl(const char *file, int line,
     -+		   const char *exe, const char **argv);
     ++int trace2_exec_fl(const char *file, int line, const char *exe,
     ++		   const char **argv);
      +
     -+#define trace2_exec(exe, argv) \
     -+	trace2_exec_fl(__FILE__, __LINE__, (exe), (argv))
     ++#define trace2_exec(exe, argv) trace2_exec_fl(__FILE__, __LINE__, (exe), (argv))
      +
      +/*
      + * Emit an 'exec_result' when possible.  On Unix-derived systems,
     @@ -1705,7 +1686,7 @@
      + * Thread names will be decorated with an instance number automatically.
      + */
      +void trace2_thread_start_fl(const char *file, int line,
     -+				 const char *thread_name);
     ++			    const char *thread_name);
      +
      +#define trace2_thread_start(thread_name) \
      +	trace2_thread_start_fl(__FILE__, __LINE__, (thread_name))
     @@ -1725,9 +1706,9 @@
      + * Write a "<param> = <value>" pair describing some aspect of the
      + * run such as an important configuration setting or command line
      + * option that significantly changes command behavior.
     -+ */ 
     -+void trace2_def_param_fl(const char *file, int line,
     -+			 const char *param, const char *value);
     ++ */
     ++void trace2_def_param_fl(const char *file, int line, const char *param,
     ++			 const char *value);
      +
      +#define trace2_def_param(param, value) \
      +	trace2_def_param_fl(__FILE__, __LINE__, (param), (value))
     @@ -1738,11 +1719,9 @@
      + *
      + * Emits a 'worktree' event for this repo instance.
      + */
     -+void trace2_def_repo_fl(const char *file, int line,
     -+			struct repository *repo);
     ++void trace2_def_repo_fl(const char *file, int line, struct repository *repo);
      +
     -+#define trace2_def_repo(repo) \
     -+	trace2_def_repo_fl(__FILE__, __LINE__, repo)
     ++#define trace2_def_repo(repo) trace2_def_repo_fl(__FILE__, __LINE__, repo)
      +
      +/*
      + * Emit a 'region_enter' event for <category>.<label> with optional
     @@ -1752,24 +1731,20 @@
      + * current time.  This controls the indenting of all subsequent events
      + * on this thread.
      + */
     -+void trace2_region_enter_fl(const char *file, int line,
     -+			    const char *category,
     -+			    const char *label,
     -+			    const struct repository *repo);
     ++void trace2_region_enter_fl(const char *file, int line, const char *category,
     ++			    const char *label, const struct repository *repo);
      +
      +#define trace2_region_enter(category, label, repo) \
     -+	trace2_region_enter_fl( \
     -+		__FILE__, __LINE__, (category), (label), (repo))
     ++	trace2_region_enter_fl(__FILE__, __LINE__, (category), (label), (repo))
      +
      +void trace2_region_enter_printf_va_fl(const char *file, int line,
     -+				      const char *category,
     -+				      const char *label,
     ++				      const char *category, const char *label,
      +				      const struct repository *repo,
      +				      const char *fmt, va_list ap);
      +
     -+#define trace2_region_enter_printf_va(category, label, repo, fmt, ap) \
     -+	trace2_region_enter_printf_va_fl( \
     -+		__FILE__, __LINE__, (category), (label), (repo), (fmt), (ap))
     ++#define trace2_region_enter_printf_va(category, label, repo, fmt, ap)    \
     ++	trace2_region_enter_printf_va_fl(__FILE__, __LINE__, (category), \
     ++					 (label), (repo), (fmt), (ap))
      +
      +void trace2_region_enter_printf_fl(const char *file, int line,
      +				   const char *category, const char *label,
     @@ -1777,14 +1752,14 @@
      +				   const char *fmt, ...);
      +
      +#ifdef HAVE_VARIADIC_MACROS
     -+#define trace2_region_enter_printf(category, label, repo, ...) \
     -+	trace2_region_enter_printf_fl( \
     -+		__FILE__, __LINE__, (category), (label), (repo), __VA_ARGS__)
     ++#define trace2_region_enter_printf(category, label, repo, ...)                 \
     ++	trace2_region_enter_printf_fl(__FILE__, __LINE__, (category), (label), \
     ++				      (repo), __VA_ARGS__)
      +#else
      +__attribute__((format (region_enter_printf, 4, 5)))
      +void trace2_region_enter_printf(const char *category, const char *label,
     -+				const struct repository *repo,
     -+				const char *fmt, ...);
     ++				const struct repository *repo, const char *fmt,
     ++				...);
      +#endif
      +
      +/*
     @@ -1794,24 +1769,20 @@
      + * Leave current nesting level and report the elapsed time spent
      + * in this nesting level.
      + */
     -+void trace2_region_leave_fl(const char *file, int line,
     -+			    const char *category,
     -+			    const char *label,
     -+			    const struct repository *repo);
     ++void trace2_region_leave_fl(const char *file, int line, const char *category,
     ++			    const char *label, const struct repository *repo);
      +
      +#define trace2_region_leave(category, label, repo) \
     -+	trace2_region_leave_fl( \
     -+		__FILE__, __LINE__, (category), (label), (repo))
     ++	trace2_region_leave_fl(__FILE__, __LINE__, (category), (label), (repo))
      +
      +void trace2_region_leave_printf_va_fl(const char *file, int line,
     -+				      const char *category,
     -+				      const char *label,
     ++				      const char *category, const char *label,
      +				      const struct repository *repo,
      +				      const char *fmt, va_list ap);
      +
     -+#define trace2_region_leave_printf_va(category, label, repo, fmt, ap) \
     -+	trace2_region_leave_printf_va_fl( \
     -+		__FILE__, __LINE__, (category), (label), (repo), (fmt), (ap))
     ++#define trace2_region_leave_printf_va(category, label, repo, fmt, ap)    \
     ++	trace2_region_leave_printf_va_fl(__FILE__, __LINE__, (category), \
     ++					 (label), (repo), (fmt), (ap))
      +
      +void trace2_region_leave_printf_fl(const char *file, int line,
      +				   const char *category, const char *label,
     @@ -1819,14 +1790,14 @@
      +				   const char *fmt, ...);
      +
      +#ifdef HAVE_VARIADIC_MACROS
     -+#define trace2_region_leave_printf(category, label, repo, ...) \
     -+	trace2_region_leave_printf_fl( \
     -+		__FILE__, __LINE__, (category), (label), (repo), __VA_ARGS__)
     ++#define trace2_region_leave_printf(category, label, repo, ...)                 \
     ++	trace2_region_leave_printf_fl(__FILE__, __LINE__, (category), (label), \
     ++				      (repo), __VA_ARGS__)
      +#else
      +__attribute__((format (region_leave_printf, 4, 5)))
      +void trace2_region_leave_printf(const char *category, const char *label,
     -+				const struct repository *repo,
     -+				const char *fmt, ...);
     ++				const struct repository *repo, const char *fmt,
     ++				...);
      +#endif
      +
      +/*
     @@ -1838,35 +1809,29 @@
      + * for post-processing.  On printf-based TRACE2 targets, this is converted
      + * into a fixed-format printf message.
      + */
     -+void trace2_data_string_fl(const char *file, int line,
     -+			   const char *category,
     -+			   const struct repository *repo,
     -+			   const char *key,
     ++void trace2_data_string_fl(const char *file, int line, const char *category,
     ++			   const struct repository *repo, const char *key,
      +			   const char *value);
      +
     -+#define trace2_data_string(category, repo, key, value) \
     -+	trace2_data_string_fl( \
     -+		__FILE__, __LINE__, (category), (repo), (key), (value))
     ++#define trace2_data_string(category, repo, key, value)                       \
     ++	trace2_data_string_fl(__FILE__, __LINE__, (category), (repo), (key), \
     ++			      (value))
      +
     -+void trace2_data_intmax_fl(const char *file, int line,
     -+			   const char *category,
     -+			   const struct repository *repo,
     -+			   const char *key,
     ++void trace2_data_intmax_fl(const char *file, int line, const char *category,
     ++			   const struct repository *repo, const char *key,
      +			   intmax_t value);
      +
     -+#define trace2_data_intmax(category, repo, key, value) \
     -+	trace2_data_intmax_fl( \
     -+		__FILE__, __LINE__, (category), (repo), (key), (value))
     ++#define trace2_data_intmax(category, repo, key, value)                       \
     ++	trace2_data_intmax_fl(__FILE__, __LINE__, (category), (repo), (key), \
     ++			      (value))
      +
     -+void trace2_data_json_fl(const char *file, int line,
     -+			 const char *category,
     -+			 const struct repository *repo,
     -+			 const char *key,
     ++void trace2_data_json_fl(const char *file, int line, const char *category,
     ++			 const struct repository *repo, const char *key,
      +			 const struct json_writer *jw);
      +
     -+#define trace2_data_json(category, repo, key, value) \
     -+	trace2_data_json_fl( \
     -+		__FILE__, __LINE__, (category), (repo), (key), (value))
     ++#define trace2_data_json(category, repo, key, value)                       \
     ++	trace2_data_json_fl(__FILE__, __LINE__, (category), (repo), (key), \
     ++			    (value))
      +
      +/*
      + * Emit a 'printf' event.
     @@ -1876,8 +1841,8 @@
      + * any formatting guidelines.  Post-processors may choose to ignore
      + * them.
      + */
     -+void trace2_printf_va_fl(const char *file, int line,
     -+			 const char *fmt, va_list ap);
     ++void trace2_printf_va_fl(const char *file, int line, const char *fmt,
     ++			 va_list ap);
      +
      +#define trace2_printf_va(fmt, ap) \
      +	trace2_printf_va_fl(__FILE__, __LINE__, (fmt), (ap))
     @@ -1885,8 +1850,7 @@
      +void trace2_printf_fl(const char *file, int line, const char *fmt, ...);
      +
      +#ifdef HAVE_VARIADIC_MACROS
     -+#define trace2_printf(...) \
     -+	trace2_printf_fl(__FILE__, __LINE__, __VA_ARGS__)
     ++#define trace2_printf(...) trace2_printf_fl(__FILE__, __LINE__, __VA_ARGS__)
      +#else
      +__attribute__((format (printf, 1, 2)))
      +void trace2_printf(const char *fmt, ...);
     @@ -1948,8 +1912,7 @@
      +	tr2_cfg_loaded = 0;
      +}
      +
     -+struct tr2_cfg_data
     -+{
     ++struct tr2_cfg_data {
      +	const char *file;
      +	int line;
      +};
     @@ -1982,15 +1945,14 @@
      +		read_early_config(tr2_cfg_cb, &data);
      +}
      +
     -+void tr2_cfg_set_fl(const char *file, int line,
     -+		    const char *key, const char *value)
     ++void tr2_cfg_set_fl(const char *file, int line, const char *key,
     ++		    const char *value)
      +{
      +	struct tr2_cfg_data data = { file, line };
      +
      +	if (tr2_cfg_load_patterns() > 0)
      +		tr2_cfg_cb(key, value, &data);
      +}
     -+
      
       diff --git a/trace2/tr2_cfg.h b/trace2/tr2_cfg.h
       new file mode 100644
     @@ -2010,8 +1972,8 @@
      + * Emit a "def_param" event for the given key/value pair IF we consider
      + * the key to be "interesting".
      + */
     -+void tr2_cfg_set_fl(const char *file, int line,
     -+		    const char *key, const char *value);
     ++void tr2_cfg_set_fl(const char *file, int line, const char *key,
     ++		    const char *value);
      +
      +void tr2_cfg_free_patterns(void);
      +
     @@ -2025,6 +1987,32 @@
      +#include "cache.h"
      +#include "trace2/tr2_dst.h"
      +
     ++/*
     ++ * If a Trace2 target cannot be opened for writing, we should issue a
     ++ * warning to stderr, but this is very annoying if the target is a pipe
     ++ * or socket and beyond the user's control -- especially since every
     ++ * git command (and sub-command) will print the message.  So we silently
     ++ * eat these warnings and just discard the trace data.
     ++ *
     ++ * Enable the following environment variable to see these warnings.
     ++ */
     ++#define TR2_ENVVAR_DST_DEBUG "GIT_TR2_DST_DEBUG"
     ++
     ++static int tr2_dst_want_warning(void)
     ++{
     ++	static int tr2env_dst_debug = -1;
     ++
     ++	if (tr2env_dst_debug == -1) {
     ++		const char *env_value = getenv(TR2_ENVVAR_DST_DEBUG);
     ++		if (!env_value || !*env_value)
     ++			tr2env_dst_debug = 0;
     ++		else
     ++			tr2env_dst_debug = atoi(env_value) > 0;
     ++	}
     ++
     ++	return tr2env_dst_debug;
     ++}
     ++
      +void tr2_dst_trace_disable(struct tr2_dst *dst)
      +{
      +	if (dst->need_close)
     @@ -2034,50 +2022,129 @@
      +	dst->need_close = 0;
      +}
      +
     ++static int tr2_dst_try_path(struct tr2_dst *dst, const char *tgt_value)
     ++{
     ++	int fd = open(tgt_value, O_WRONLY | O_APPEND | O_CREAT, 0666);
     ++	if (fd == -1) {
     ++		if (tr2_dst_want_warning())
     ++			warning("trace2: could not open '%s' for '%s' tracing: %s",
     ++				tgt_value, dst->env_var_name, strerror(errno));
     ++
     ++		tr2_dst_trace_disable(dst);
     ++		return 0;
     ++	}
     ++
     ++	dst->fd = fd;
     ++	dst->need_close = 1;
     ++	dst->initialized = 1;
     ++
     ++	return dst->fd;
     ++}
     ++
     ++#ifndef NO_UNIX_SOCKETS
     ++#define PREFIX_AF_UNIX "af_unix:"
     ++#define PREFIX_AF_UNIX_LEN (8)
     ++
     ++static int tr2_dst_try_unix_domain_socket(struct tr2_dst *dst,
     ++					  const char *tgt_value)
     ++{
     ++	int fd;
     ++	struct sockaddr_un sa;
     ++	const char *path = tgt_value + PREFIX_AF_UNIX_LEN;
     ++	int path_len = strlen(path);
     ++
     ++	if (!is_absolute_path(path) || path_len >= sizeof(sa.sun_path)) {
     ++		if (tr2_dst_want_warning())
     ++			warning("trace2: invalid AF_UNIX path '%s' for '%s' tracing",
     ++				path, dst->env_var_name);
     ++
     ++		tr2_dst_trace_disable(dst);
     ++		return 0;
     ++	}
     ++
     ++	sa.sun_family = AF_UNIX;
     ++	strlcpy(sa.sun_path, path, sizeof(sa.sun_path));
     ++	if ((fd = socket(AF_UNIX, SOCK_STREAM, 0)) == -1 ||
     ++	    connect(fd, (struct sockaddr *)&sa, sizeof(sa)) == -1) {
     ++		if (tr2_dst_want_warning())
     ++			warning("trace2: could not connect to socket '%s' for '%s' tracing: %s",
     ++				path, dst->env_var_name, strerror(errno));
     ++
     ++		tr2_dst_trace_disable(dst);
     ++		return 0;
     ++	}
     ++
     ++	dst->fd = fd;
     ++	dst->need_close = 1;
     ++	dst->initialized = 1;
     ++
     ++	return dst->fd;
     ++}
     ++#endif
     ++
     ++static void tr2_dst_malformed_warning(struct tr2_dst *dst,
     ++				      const char *tgt_value)
     ++{
     ++	struct strbuf buf = STRBUF_INIT;
     ++
     ++	strbuf_addf(&buf, "trace2: unknown trace value for '%s': '%s'",
     ++		    dst->env_var_name, tgt_value);
     ++	strbuf_addstr(
     ++		&buf,
     ++		"\n         If you want to trace into a file, then please set it"
     ++		"\n         to an absolute pathname.");
     ++#ifndef NO_UNIX_SOCKETS
     ++	strbuf_addstr(
     ++		&buf,
     ++		"\n         If you want to trace to a unix domain socket, prefix"
     ++		"\n         the absolute pathname with \"af_unix:\".");
     ++#endif
     ++
     ++	warning("%s", buf.buf);
     ++
     ++	strbuf_release(&buf);
     ++}
     ++
      +int tr2_dst_get_trace_fd(struct tr2_dst *dst)
      +{
     -+	const char *trace;
     ++	const char *tgt_value;
      +
      +	/* don't open twice */
      +	if (dst->initialized)
      +		return dst->fd;
      +
     -+	trace = getenv(dst->env_var_name);
     ++	dst->initialized = 1;
     ++
     ++	tgt_value = getenv(dst->env_var_name);
      +
     -+	if (!trace || !strcmp(trace, "") ||
     -+	    !strcmp(trace, "0") || !strcasecmp(trace, "false"))
     ++	if (!tgt_value || !strcmp(tgt_value, "") || !strcmp(tgt_value, "0") ||
     ++	    !strcasecmp(tgt_value, "false")) {
      +		dst->fd = 0;
     -+	else if (!strcmp(trace, "1") || !strcasecmp(trace, "true"))
     ++		return dst->fd;
     ++	}
     ++
     ++	if (!strcmp(tgt_value, "1") || !strcasecmp(tgt_value, "true")) {
      +		dst->fd = STDERR_FILENO;
     -+	else if (strlen(trace) == 1 && isdigit(*trace))
     -+		dst->fd = atoi(trace);
     -+	else if (is_absolute_path(trace)) {
     -+		int fd = open(trace, O_WRONLY | O_APPEND | O_CREAT, 0666);
     -+		if (fd == -1) {
     -+			/*
     -+			 * Silently eat the error and disable tracing on this
     -+			 * destination.  This will cause us to lose events,
     -+			 * but that is better than causing a stream of warnings
     -+			 * for each git command they run.
     -+			 *
     -+			 * warning("could not open '%s' for tracing: %s",
     -+			 *         trace, strerror(errno));
     -+			 */
     -+			tr2_dst_trace_disable(dst);
     -+		} else {
     -+			dst->fd = fd;
     -+			dst->need_close = 1;
     -+		}
     -+	} else {
     -+		warning("unknown trace value for '%s': %s\n"
     -+			"         If you want to trace into a file, then please set %s\n"
     -+			"         to an absolute pathname (starting with /)",
     -+			dst->env_var_name, trace, dst->env_var_name);
     -+		tr2_dst_trace_disable(dst);
     ++		return dst->fd;
      +	}
      +
     -+	dst->initialized = 1;
     -+	return dst->fd;
     ++	if (strlen(tgt_value) == 1 && isdigit(*tgt_value)) {
     ++		dst->fd = atoi(tgt_value);
     ++		return dst->fd;
     ++	}
     ++
     ++	if (is_absolute_path(tgt_value))
     ++		return tr2_dst_try_path(dst, tgt_value);
     ++
     ++#ifndef NO_UNIX_SOCKETS
     ++	if (!strncmp(tgt_value, PREFIX_AF_UNIX, PREFIX_AF_UNIX_LEN))
     ++		return tr2_dst_try_unix_domain_socket(dst, tgt_value);
     ++#endif
     ++
     ++	/* Always warn about malformed values. */
     ++	tr2_dst_malformed_warning(dst, tgt_value);
     ++	tr2_dst_trace_disable(dst);
     ++	return 0;
      +}
      +
      +int tr2_dst_trace_want(struct tr2_dst *dst)
     @@ -2105,12 +2172,15 @@
      +	 * If we get an IO error, just close the trace dst.
      +	 */
      +
     -+	if (write(tr2_dst_get_trace_fd(dst),
     -+		  buf_line->buf, buf_line->len) < 0) {
     -+		warning("unable to write trace for '%s': %s",
     -+			dst->env_var_name, strerror(errno));
     -+		tr2_dst_trace_disable(dst);
     -+	}
     ++	int fd = tr2_dst_get_trace_fd(dst);
     ++
     ++	if (write(fd, buf_line->buf, buf_line->len) >= 0)
     ++		return;
     ++
     ++	if (tr2_dst_want_warning())
     ++		warning("unable to write trace to '%s': %s", dst->env_var_name,
     ++			strerror(errno));
     ++	tr2_dst_trace_disable(dst);
      +}
      
       diff --git a/trace2/tr2_dst.h b/trace2/tr2_dst.h
     @@ -2121,11 +2191,13 @@
      +#ifndef TR2_DST_H
      +#define TR2_DST_H
      +
     ++struct strbuf;
     ++
      +struct tr2_dst {
     -+	const char * const env_var_name;
     ++	const char *const env_var_name;
      +	int fd;
      +	unsigned int initialized : 1;
     -+	unsigned int  need_close : 1;
     ++	unsigned int need_close : 1;
      +};
      +
      +/*
     @@ -2199,8 +2271,8 @@
      +	}
      +
      +	us_now = getnanotime() / 1000;
     -+	strbuf_addf(&tr2sid_buf, "%"PRIuMAX"-%"PRIdMAX,
     -+		    (uintmax_t)us_now, (intmax_t)getpid());
     ++	strbuf_addf(&tr2sid_buf, "%" PRIuMAX "-%" PRIdMAX, (uintmax_t)us_now,
     ++		    (intmax_t)getpid());
      +
      +	setenv(TR2_ENVVAR_PARENT_SID, tr2sid_buf.buf, 1);
      +}
     @@ -2268,8 +2340,8 @@
      +	secs = tv.tv_sec;
      +	localtime_r(&secs, &tm);
      +
     -+	xsnprintf(tb->buf, sizeof(tb->buf), "%02d:%02d:%02d.%06ld",
     -+		  tm.tm_hour, tm.tm_min, tm.tm_sec, (long)tv.tv_usec);
     ++	xsnprintf(tb->buf, sizeof(tb->buf), "%02d:%02d:%02d.%06ld", tm.tm_hour,
     ++		  tm.tm_min, tm.tm_sec, (long)tv.tv_usec);
      +}
      +
      +void tr2_tbuf_utc_time(struct tr2_tbuf *tb)
     @@ -2282,11 +2354,11 @@
      +	secs = tv.tv_sec;
      +	gmtime_r(&secs, &tm);
      +
     -+	xsnprintf(tb->buf, sizeof(tb->buf), "%4d-%02d-%02d %02d:%02d:%02d.%06ld",
     -+		  tm.tm_year+1900, tm.tm_mon+1, tm.tm_mday,
     -+		  tm.tm_hour, tm.tm_min, tm.tm_sec, (long)tv.tv_usec);
     ++	xsnprintf(tb->buf, sizeof(tb->buf),
     ++		  "%4d-%02d-%02d %02d:%02d:%02d.%06ld", tm.tm_year + 1900,
     ++		  tm.tm_mon + 1, tm.tm_mday, tm.tm_hour, tm.tm_min, tm.tm_sec,
     ++		  (long)tv.tv_usec);
      +}
     -+
      
       diff --git a/trace2/tr2_tbuf.h b/trace2/tr2_tbuf.h
       new file mode 100644
     @@ -2325,94 +2397,99 @@
      +#ifndef TR2_TGT_H
      +#define TR2_TGT_H
      +
     ++struct child_process;
     ++struct repository;
     ++struct json_writer;
     ++
      +/*
      + * Function prototypes for a TRACE2 "target" vtable.
      + */
      +
     -+typedef int (tr2_tgt_init_t)(void);
     -+typedef void (tr2_tgt_term_t)(void);
     -+
     -+typedef void (tr2_tgt_evt_version_fl_t)
     -+	(const char *file, int line);
     -+
     -+typedef void (tr2_tgt_evt_start_fl_t)
     -+	(const char *file, int line, const char **argv);
     -+typedef void (tr2_tgt_evt_exit_fl_t)
     -+	(const char *file, int line, uint64_t us_elapsed_absolute, int code);
     -+typedef void (tr2_tgt_evt_signal_t)
     -+	(uint64_t us_elapsed_absolute, int signo);
     -+typedef void (tr2_tgt_evt_atexit_t)
     -+	(uint64_t us_elapsed_absolute, int code);
     -+
     -+typedef void (tr2_tgt_evt_error_va_fl_t)
     -+	(const char *file, int line, const char *fmt, va_list ap);
     -+
     -+typedef void (tr2_tgt_evt_command_path_fl_t)
     -+	(const char *file, int line, const char *command_path);
     -+typedef void (tr2_tgt_evt_command_verb_fl_t)
     -+	(const char *file, int line, const char *command_verb,
     -+	 const char *hierarchy);
     -+typedef void (tr2_tgt_evt_command_subverb_fl_t)
     -+	(const char *file, int line, const char *command_subverb);
     -+
     -+typedef void (tr2_tgt_evt_alias_fl_t)
     -+	(const char *file, int line, const char *alias, const char **argv);
     -+
     -+typedef void (tr2_tgt_evt_child_start_fl_t)
     -+	(const char *file, int line, uint64_t us_elapsed_absolute,
     -+	 const struct child_process *cmd);
     -+typedef void (tr2_tgt_evt_child_exit_fl_t)
     -+	(const char *file, int line, uint64_t us_elapsed_absolute, int cid,
     -+	 int pid, int code, uint64_t us_elapsed_child);
     -+
     -+typedef void (tr2_tgt_evt_thread_start_fl_t)
     -+	(const char *file, int line, uint64_t us_elapsed_absolute);
     -+typedef void (tr2_tgt_evt_thread_exit_fl_t)
     -+	(const char *file, int line, uint64_t us_elapsed_absolute,
     -+	 uint64_t us_elapsed_thread);
     -+
     -+typedef void (tr2_tgt_evt_exec_fl_t)
     -+	(const char *file, int line, uint64_t us_elapsed_absolute,
     -+	 int exec_id, const char *exe, const char **argv);
     -+typedef void (tr2_tgt_evt_exec_result_fl_t)
     -+	(const char *file, int line, uint64_t us_elapsed_absolute,
     -+	 int exec_id, int code);
     -+
     -+typedef void (tr2_tgt_evt_param_fl_t)
     -+	(const char *file, int line, const char *param, const char *value);
     -+
     -+typedef void (tr2_tgt_evt_repo_fl_t)
     -+	(const char *file, int line, const struct repository *repo);
     -+
     -+typedef void (tr2_tgt_evt_region_enter_printf_va_fl_t)
     -+	(const char *file, int line, uint64_t us_elapsed_absolute,
     -+	 const char *category, const char *label, const struct repository *repo,
     -+	 const char *fmt, va_list ap);
     -+typedef void (tr2_tgt_evt_region_leave_printf_va_fl_t)
     -+	(const char *file, int line, uint64_t us_elapsed_absolute,
     -+	 uint64_t us_elapsed_region, const char *category, const char *label,
     -+	 const struct repository *repo, const char *fmt, va_list ap);
     -+
     -+typedef void (tr2_tgt_evt_data_fl_t)
     -+	(const char *file, int line, uint64_t us_elapsed_absolute,
     -+	 uint64_t us_elapsed_region, const char *category,
     -+	 const struct repository *repo, const char *key, const char *value);
     -+typedef void (tr2_tgt_evt_data_json_fl_t)
     -+	(const char *file, int line, uint64_t us_elapsed_absolute,
     -+	 uint64_t us_elapsed_region, const char *category,
     -+	 const struct repository *repo,
     -+	 const char *key, const struct json_writer *value);
     -+
     -+typedef void (tr2_tgt_evt_printf_va_fl_t)
     -+	(const char *file, int line, uint64_t us_elapsed_absolute,
     -+	 const char *fmt, va_list ap);
     ++typedef int(tr2_tgt_init_t)(void);
     ++typedef void(tr2_tgt_term_t)(void);
     ++
     ++typedef void(tr2_tgt_evt_version_fl_t)(const char *file, int line);
     ++
     ++typedef void(tr2_tgt_evt_start_fl_t)(const char *file, int line,
     ++				     const char **argv);
     ++typedef void(tr2_tgt_evt_exit_fl_t)(const char *file, int line,
     ++				    uint64_t us_elapsed_absolute, int code);
     ++typedef void(tr2_tgt_evt_signal_t)(uint64_t us_elapsed_absolute, int signo);
     ++typedef void(tr2_tgt_evt_atexit_t)(uint64_t us_elapsed_absolute, int code);
     ++
     ++typedef void(tr2_tgt_evt_error_va_fl_t)(const char *file, int line,
     ++					const char *fmt, va_list ap);
     ++
     ++typedef void(tr2_tgt_evt_command_path_fl_t)(const char *file, int line,
     ++					    const char *command_path);
     ++typedef void(tr2_tgt_evt_command_verb_fl_t)(const char *file, int line,
     ++					    const char *command_verb,
     ++					    const char *hierarchy);
     ++typedef void(tr2_tgt_evt_command_subverb_fl_t)(const char *file, int line,
     ++					       const char *command_subverb);
     ++
     ++typedef void(tr2_tgt_evt_alias_fl_t)(const char *file, int line,
     ++				     const char *alias, const char **argv);
     ++
     ++typedef void(tr2_tgt_evt_child_start_fl_t)(const char *file, int line,
     ++					   uint64_t us_elapsed_absolute,
     ++					   const struct child_process *cmd);
     ++typedef void(tr2_tgt_evt_child_exit_fl_t)(const char *file, int line,
     ++					  uint64_t us_elapsed_absolute, int cid,
     ++					  int pid, int code,
     ++					  uint64_t us_elapsed_child);
     ++
     ++typedef void(tr2_tgt_evt_thread_start_fl_t)(const char *file, int line,
     ++					    uint64_t us_elapsed_absolute);
     ++typedef void(tr2_tgt_evt_thread_exit_fl_t)(const char *file, int line,
     ++					   uint64_t us_elapsed_absolute,
     ++					   uint64_t us_elapsed_thread);
     ++
     ++typedef void(tr2_tgt_evt_exec_fl_t)(const char *file, int line,
     ++				    uint64_t us_elapsed_absolute, int exec_id,
     ++				    const char *exe, const char **argv);
     ++typedef void(tr2_tgt_evt_exec_result_fl_t)(const char *file, int line,
     ++					   uint64_t us_elapsed_absolute,
     ++					   int exec_id, int code);
     ++
     ++typedef void(tr2_tgt_evt_param_fl_t)(const char *file, int line,
     ++				     const char *param, const char *value);
     ++
     ++typedef void(tr2_tgt_evt_repo_fl_t)(const char *file, int line,
     ++				    const struct repository *repo);
     ++
     ++typedef void(tr2_tgt_evt_region_enter_printf_va_fl_t)(
     ++	const char *file, int line, uint64_t us_elapsed_absolute,
     ++	const char *category, const char *label, const struct repository *repo,
     ++	const char *fmt, va_list ap);
     ++typedef void(tr2_tgt_evt_region_leave_printf_va_fl_t)(
     ++	const char *file, int line, uint64_t us_elapsed_absolute,
     ++	uint64_t us_elapsed_region, const char *category, const char *label,
     ++	const struct repository *repo, const char *fmt, va_list ap);
     ++
     ++typedef void(tr2_tgt_evt_data_fl_t)(const char *file, int line,
     ++				    uint64_t us_elapsed_absolute,
     ++				    uint64_t us_elapsed_region,
     ++				    const char *category,
     ++				    const struct repository *repo,
     ++				    const char *key, const char *value);
     ++typedef void(tr2_tgt_evt_data_json_fl_t)(const char *file, int line,
     ++					 uint64_t us_elapsed_absolute,
     ++					 uint64_t us_elapsed_region,
     ++					 const char *category,
     ++					 const struct repository *repo,
     ++					 const char *key,
     ++					 const struct json_writer *value);
     ++
     ++typedef void(tr2_tgt_evt_printf_va_fl_t)(const char *file, int line,
     ++					 uint64_t us_elapsed_absolute,
     ++					 const char *fmt, va_list ap);
      +
      +/*
      + * "vtable" for a TRACE2 target.  Use NULL if a target does not want
      + * to emit that message.
      + */
     -+struct tr2_tgt
     -+{
     ++struct tr2_tgt {
      +	struct tr2_dst                          *pdst;
      +
      +	tr2_tgt_init_t                          *pfn_init;
     @@ -2465,7 +2542,7 @@
      +#include "trace2/tr2_tgt.h"
      +#include "trace2/tr2_tls.h"
      +
     -+static struct tr2_dst tr2dst_event  = { "GIT_TR2_EVENT", 0, 0, 0 };
     ++static struct tr2_dst tr2dst_event = { "GIT_TR2_EVENT", 0, 0, 0 };
      +
      +/*
      + * The version number of the JSON data generated by the EVENT target
     @@ -2534,9 +2611,8 @@
      + *     "line":<line_number>
      + *     "repo":<repo_id>
      + */
     -+static void event_fmt_prepare(const char *event_name,
     -+			      const char *file, int line,
     -+			      const struct repository *repo,
     ++static void event_fmt_prepare(const char *event_name, const char *file,
     ++			      int line, const struct repository *repo,
      +			      struct json_writer *jw)
      +{
      +	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
     @@ -2549,8 +2625,7 @@
      +	/*
      +	 * In brief mode, only emit <time> on these 2 event types.
      +	 */
     -+	if (!tr2env_event_brief ||
     -+	    !strcmp(event_name, "version") ||
     ++	if (!tr2env_event_brief || !strcmp(event_name, "version") ||
      +	    !strcmp(event_name, "atexit")) {
      +		tr2_tbuf_utc_time(&tb_now);
      +		jw_object_string(jw, "time", tb_now.buf);
     @@ -2596,8 +2671,8 @@
      +	jw_release(&jw);
      +}
      +
     -+static void fn_exit_fl(const char *file, int line,
     -+		       uint64_t us_elapsed_absolute, int code)
     ++static void fn_exit_fl(const char *file, int line, uint64_t us_elapsed_absolute,
     ++		       int code)
      +{
      +	const char *event_name = "exit";
      +	struct json_writer jw = JSON_WRITER_INIT;
     @@ -2645,8 +2720,7 @@
      +	jw_release(&jw);
      +}
      +
     -+static void maybe_add_string_va(struct json_writer *jw,
     -+				const char *field_name,
     ++static void maybe_add_string_va(struct json_writer *jw, const char *field_name,
      +				const char *fmt, va_list ap)
      +{
      +	if (fmt && *fmt && ap) {
     @@ -2668,8 +2742,8 @@
      +	}
      +}
      +
     -+static void fn_error_va_fl(const char *file, int line,
     -+			   const char *fmt, va_list ap)
     ++static void fn_error_va_fl(const char *file, int line, const char *fmt,
     ++			   va_list ap)
      +{
      +	const char *event_name = "error";
      +	struct json_writer jw = JSON_WRITER_INIT;
     @@ -2691,8 +2765,7 @@
      +	jw_release(&jw);
      +}
      +
     -+static void fn_command_path_fl(const char *file, int line,
     -+			       const char *pathname)
     ++static void fn_command_path_fl(const char *file, int line, const char *pathname)
      +{
      +	const char *event_name = "cmd_path";
      +	struct json_writer jw = JSON_WRITER_INIT;
     @@ -2725,7 +2798,7 @@
      +}
      +
      +static void fn_command_subverb_fl(const char *file, int line,
     -+			       const char *command_subverb)
     ++				  const char *command_subverb)
      +{
      +	const char *event_name = "cmd_subverb";
      +	struct json_writer jw = JSON_WRITER_INIT;
     @@ -2739,8 +2812,8 @@
      +	jw_release(&jw);
      +}
      +
     -+static void fn_alias_fl(const char *file, int line,
     -+			const char *alias, const char **argv)
     ++static void fn_alias_fl(const char *file, int line, const char *alias,
     ++			const char **argv)
      +{
      +	const char *event_name = "alias";
      +	struct json_writer jw = JSON_WRITER_INIT;
     @@ -2771,8 +2844,8 @@
      +		jw_object_string(&jw, "child_class", "hook");
      +		jw_object_string(&jw, "hook_name", cmd->trace2_hook_name);
      +	} else {
     -+		const char *child_class = ((cmd->trace2_child_class) ?
     -+					   cmd->trace2_child_class : "?");
     ++		const char *child_class =
     ++			cmd->trace2_child_class ? cmd->trace2_child_class : "?";
      +		jw_object_string(&jw, "child_class", child_class);
      +	}
      +	if (cmd->dir)
     @@ -2790,9 +2863,8 @@
      +}
      +
      +static void fn_child_exit_fl(const char *file, int line,
     -+			     uint64_t us_elapsed_absolute,
     -+			     int cid, int pid, int code,
     -+			     uint64_t us_elapsed_child)
     ++			     uint64_t us_elapsed_absolute, int cid, int pid,
     ++			     int code, uint64_t us_elapsed_child)
      +{
      +	const char *event_name = "child_exit";
      +	struct json_writer jw = JSON_WRITER_INIT;
     @@ -2842,8 +2914,7 @@
      +	jw_release(&jw);
      +}
      +
     -+static void fn_exec_fl(const char *file, int line,
     -+		       uint64_t us_elapsed_absolute,
     ++static void fn_exec_fl(const char *file, int line, uint64_t us_elapsed_absolute,
      +		       int exec_id, const char *exe, const char **argv)
      +{
      +	const char *event_name = "exec";
     @@ -2864,8 +2935,8 @@
      +}
      +
      +static void fn_exec_result_fl(const char *file, int line,
     -+			      uint64_t us_elapsed_absolute,
     -+			      int exec_id, int code)
     ++			      uint64_t us_elapsed_absolute, int exec_id,
     ++			      int code)
      +{
      +	const char *event_name = "exec_result";
      +	struct json_writer jw = JSON_WRITER_INIT;
     @@ -2880,8 +2951,8 @@
      +	jw_release(&jw);
      +}
      +
     -+static void fn_param_fl(const char *file, int line,
     -+			const char *param, const char *value)
     ++static void fn_param_fl(const char *file, int line, const char *param,
     ++			const char *value)
      +{
      +	const char *event_name = "def_param";
      +	struct json_writer jw = JSON_WRITER_INIT;
     @@ -2924,8 +2995,7 @@
      +		struct json_writer jw = JSON_WRITER_INIT;
      +
      +		jw_object_begin(&jw, 0);
     -+		event_fmt_prepare(
     -+			event_name, file, line, repo, &jw);
     ++		event_fmt_prepare(event_name, file, line, repo, &jw);
      +		jw_object_intmax(&jw, "nesting", ctx->nr_open_regions);
      +		if (category)
      +			jw_object_string(&jw, "category", category);
     @@ -2939,13 +3009,10 @@
      +	}
      +}
      +
     -+static void fn_region_leave_printf_va_fl(const char *file, int line,
     -+					 uint64_t us_elapsed_absolute,
     -+					 uint64_t us_elapsed_region,
     -+					 const char *category,
     -+					 const char *label,
     -+					 const struct repository *repo,
     -+					 const char *fmt, va_list ap)
     ++static void fn_region_leave_printf_va_fl(
     ++	const char *file, int line, uint64_t us_elapsed_absolute,
     ++	uint64_t us_elapsed_region, const char *category, const char *label,
     ++	const struct repository *repo, const char *fmt, va_list ap)
      +{
      +	const char *event_name = "region_leave";
      +	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
     @@ -2969,12 +3036,9 @@
      +	}
      +}
      +
     -+static void fn_data_fl(const char *file, int line,
     -+		       uint64_t us_elapsed_absolute,
     -+		       uint64_t us_elapsed_region,
     -+		       const char *category,
     -+		       const struct repository *repo,
     -+		       const char *key,
     ++static void fn_data_fl(const char *file, int line, uint64_t us_elapsed_absolute,
     ++		       uint64_t us_elapsed_region, const char *category,
     ++		       const struct repository *repo, const char *key,
      +		       const char *value)
      +{
      +	const char *event_name = "data";
     @@ -3001,10 +3065,8 @@
      +
      +static void fn_data_json_fl(const char *file, int line,
      +			    uint64_t us_elapsed_absolute,
     -+			    uint64_t us_elapsed_region,
     -+			    const char *category,
     -+			    const struct repository *repo,
     -+			    const char *key,
     ++			    uint64_t us_elapsed_region, const char *category,
     ++			    const struct repository *repo, const char *key,
      +			    const struct json_writer *value)
      +{
      +	const char *event_name = "data_json";
     @@ -3029,8 +3091,7 @@
      +	}
      +}
      +
     -+struct tr2_tgt tr2_tgt_event =
     -+{
     ++struct tr2_tgt tr2_tgt_event = {
      +	&tr2dst_event,
      +
      +	fn_init,
     @@ -3087,7 +3148,7 @@
      +#define TR2_ENVVAR_NORMAL_BRIEF "GIT_TR2_BRIEF"
      +static int tr2env_normal_brief;
      +
     -+#define TR2FMT_NORMAL_FL_WIDTH       (50)
     ++#define TR2FMT_NORMAL_FL_WIDTH (50)
      +
      +static int fn_init(void)
      +{
     @@ -3113,7 +3174,7 @@
      +
      +static void normal_fmt_prepare(const char *file, int line, struct strbuf *buf)
      +{
     -+	strbuf_setlen(buf,0);
     ++	strbuf_setlen(buf, 0);
      +
      +	if (!tr2env_normal_brief) {
      +		struct tr2_tbuf tb_now;
     @@ -3159,14 +3220,13 @@
      +	strbuf_release(&buf_payload);
      +}
      +
     -+static void fn_exit_fl(const char *file, int line,
     -+		       uint64_t us_elapsed_absolute, int code)
     ++static void fn_exit_fl(const char *file, int line, uint64_t us_elapsed_absolute,
     ++		       int code)
      +{
      +	struct strbuf buf_payload = STRBUF_INIT;
      +	double elapsed = (double)us_elapsed_absolute / 1000000.0;
      +
     -+	strbuf_addf(&buf_payload, "exit elapsed:%.6f code:%d",
     -+		    elapsed, code);
     ++	strbuf_addf(&buf_payload, "exit elapsed:%.6f code:%d", elapsed, code);
      +	normal_io_write_fl(file, line, &buf_payload);
      +	strbuf_release(&buf_payload);
      +}
     @@ -3176,8 +3236,8 @@
      +	struct strbuf buf_payload = STRBUF_INIT;
      +	double elapsed = (double)us_elapsed_absolute / 1000000.0;
      +
     -+	strbuf_addf(&buf_payload, "signal elapsed:%.6f code:%d",
     -+		    elapsed, signo);
     ++	strbuf_addf(&buf_payload, "signal elapsed:%.6f code:%d", elapsed,
     ++		    signo);
      +	normal_io_write_fl(__FILE__, __LINE__, &buf_payload);
      +	strbuf_release(&buf_payload);
      +}
     @@ -3187,14 +3247,13 @@
      +	struct strbuf buf_payload = STRBUF_INIT;
      +	double elapsed = (double)us_elapsed_absolute / 1000000.0;
      +
     -+	strbuf_addf(&buf_payload, "atexit elapsed:%.6f code:%d",
     -+		    elapsed, code);
     ++	strbuf_addf(&buf_payload, "atexit elapsed:%.6f code:%d", elapsed, code);
      +	normal_io_write_fl(__FILE__, __LINE__, &buf_payload);
      +	strbuf_release(&buf_payload);
      +}
      +
     -+static void maybe_append_string_va(struct strbuf *buf,
     -+				   const char *fmt, va_list ap)
     ++static void maybe_append_string_va(struct strbuf *buf, const char *fmt,
     ++				   va_list ap)
      +{
      +	if (fmt && *fmt && ap) {
      +		va_list copy_ap;
     @@ -3211,8 +3270,8 @@
      +	}
      +}
      +
     -+static void fn_error_va_fl(const char *file, int line,
     -+			   const char *fmt, va_list ap)
     ++static void fn_error_va_fl(const char *file, int line, const char *fmt,
     ++			   va_list ap)
      +{
      +	struct strbuf buf_payload = STRBUF_INIT;
      +
     @@ -3222,8 +3281,7 @@
      +	strbuf_release(&buf_payload);
      +}
      +
     -+static void fn_command_path_fl(const char *file, int line,
     -+			       const char *pathname)
     ++static void fn_command_path_fl(const char *file, int line, const char *pathname)
      +{
      +	struct strbuf buf_payload = STRBUF_INIT;
      +
     @@ -3246,7 +3304,7 @@
      +}
      +
      +static void fn_command_subverb_fl(const char *file, int line,
     -+			       const char *command_subverb)
     ++				  const char *command_subverb)
      +{
      +	struct strbuf buf_payload = STRBUF_INIT;
      +
     @@ -3294,9 +3352,8 @@
      +}
      +
      +static void fn_child_exit_fl(const char *file, int line,
     -+			     uint64_t us_elapsed_absolute,
     -+			     int cid, int pid, int code,
     -+			     uint64_t us_elapsed_child)
     ++			     uint64_t us_elapsed_absolute, int cid, int pid,
     ++			     int code, uint64_t us_elapsed_child)
      +{
      +	struct strbuf buf_payload = STRBUF_INIT;
      +	double elapsed = (double)us_elapsed_child / 1000000.0;
     @@ -3307,8 +3364,7 @@
      +	strbuf_release(&buf_payload);
      +}
      +
     -+static void fn_exec_fl(const char *file, int line,
     -+		       uint64_t us_elapsed_absolute,
     ++static void fn_exec_fl(const char *file, int line, uint64_t us_elapsed_absolute,
      +		       int exec_id, const char *exe, const char **argv)
      +{
      +	struct strbuf buf_payload = STRBUF_INIT;
     @@ -3322,8 +3378,8 @@
      +}
      +
      +static void fn_exec_result_fl(const char *file, int line,
     -+			      uint64_t us_elapsed_absolute,
     -+			      int exec_id, int code)
     ++			      uint64_t us_elapsed_absolute, int exec_id,
     ++			      int code)
      +{
      +	struct strbuf buf_payload = STRBUF_INIT;
      +
     @@ -3356,8 +3412,8 @@
      +}
      +
      +static void fn_printf_va_fl(const char *file, int line,
     -+			    uint64_t us_elapsed_absolute,
     -+			    const char *fmt, va_list ap)
     ++			    uint64_t us_elapsed_absolute, const char *fmt,
     ++			    va_list ap)
      +{
      +	struct strbuf buf_payload = STRBUF_INIT;
      +
     @@ -3366,8 +3422,7 @@
      +	strbuf_release(&buf_payload);
      +}
      +
     -+struct tr2_tgt tr2_tgt_normal =
     -+{
     ++struct tr2_tgt tr2_tgt_normal = {
      +	&tr2dst_normal,
      +
      +	fn_init,
     @@ -3415,7 +3470,7 @@
      +#include "trace2/tr2_tgt.h"
      +#include "trace2/tr2_tls.h"
      +
     -+static struct tr2_dst tr2dst_perf   = { "GIT_TR2_PERF", 0, 0, 0 };
     ++static struct tr2_dst tr2dst_perf = { "GIT_TR2_PERF", 0, 0, 0 };
      +
      +/*
      + * Set this environment variable to true to omit the "<time> <file>:<line>"
     @@ -3426,9 +3481,9 @@
      +#define TR2_ENVVAR_PERF_BRIEF "GIT_TR2_PERF_BRIEF"
      +static int tr2env_perf_brief;
      +
     -+#define TR2FMT_PERF_FL_WIDTH       (50)
     ++#define TR2FMT_PERF_FL_WIDTH (50)
      +#define TR2FMT_PERF_MAX_EVENT_NAME (12)
     -+#define TR2FMT_PERF_REPO_WIDTH     (4)
     ++#define TR2FMT_PERF_REPO_WIDTH (4)
      +#define TR2FMT_PERF_CATEGORY_WIDTH (10)
      +
      +#define TR2_DOTS_BUFFER_SIZE (100)
     @@ -3471,18 +3526,18 @@
      + *         [<elapsed_absolute>] [<elapsed_relative>] <bar>
      + *         [<category>] <bar> [<dots>] "
      + */
     -+static void perf_fmt_prepare(
     -+	const char *event_name, struct tr2tls_thread_ctx *ctx,
     -+	const char *file, int line, const struct repository *repo,
     -+	uint64_t *p_us_elapsed_absolute, uint64_t *p_us_elapsed_relative,
     -+	const char *category, struct strbuf *buf)
     ++static void perf_fmt_prepare(const char *event_name,
     ++			     struct tr2tls_thread_ctx *ctx, const char *file,
     ++			     int line, const struct repository *repo,
     ++			     uint64_t *p_us_elapsed_absolute,
     ++			     uint64_t *p_us_elapsed_relative,
     ++			     const char *category, struct strbuf *buf)
      +{
      +	int len;
      +
     -+	strbuf_setlen(buf,0);
     ++	strbuf_setlen(buf, 0);
      +
      +	if (!tr2env_perf_brief) {
     -+
      +		struct tr2_tbuf tb_now;
      +
      +		tr2_tbuf_local_time(&tb_now);
     @@ -3498,15 +3553,15 @@
      +	}
      +
      +	strbuf_addf(buf, "d%d | ", tr2_sid_depth());
     -+	strbuf_addf(buf, "%-*s | %-*s | ",
     -+		    TR2_MAX_THREAD_NAME, ctx->thread_name.buf,
     -+		    TR2FMT_PERF_MAX_EVENT_NAME, event_name);
     ++	strbuf_addf(buf, "%-*s | %-*s | ", TR2_MAX_THREAD_NAME,
     ++		    ctx->thread_name.buf, TR2FMT_PERF_MAX_EVENT_NAME,
     ++		    event_name);
      +
      +	len = buf->len + TR2FMT_PERF_REPO_WIDTH;
      +	if (repo)
      +		strbuf_addf(buf, "r%d ", repo->trace2_repo_id);
      +	while (buf->len < len)
     -+		strbuf_addch(buf, ' ' );
     ++		strbuf_addch(buf, ' ');
      +	strbuf_addstr(buf, "| ");
      +
      +	if (p_us_elapsed_absolute)
     @@ -3520,7 +3575,7 @@
      +			    ((double)(*p_us_elapsed_relative)) / 1000000.0);
      +	else
      +		strbuf_addf(buf, "%9s | ", " ");
     -+		
     ++
      +	strbuf_addf(buf, "%-*s | ", TR2FMT_PERF_CATEGORY_WIDTH,
      +		    (category ? category : ""));
      +
     @@ -3534,21 +3589,19 @@
      +	}
      +}
      +
     -+static void perf_io_write_fl(
     -+	const char *file, int line,
     -+	const char *event_name,
     -+	const struct repository *repo,
     -+	uint64_t *p_us_elapsed_absolute,
     -+	uint64_t *p_us_elapsed_relative,
     -+	const char *category,
     -+	const struct strbuf *buf_payload)
     ++static void perf_io_write_fl(const char *file, int line, const char *event_name,
     ++			     const struct repository *repo,
     ++			     uint64_t *p_us_elapsed_absolute,
     ++			     uint64_t *p_us_elapsed_relative,
     ++			     const char *category,
     ++			     const struct strbuf *buf_payload)
      +{
      +	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
      +	struct strbuf buf_line = STRBUF_INIT;
      +
      +	perf_fmt_prepare(event_name, ctx, file, line, repo,
     -+			 p_us_elapsed_absolute, p_us_elapsed_relative,
     -+			 category, &buf_line);
     ++			 p_us_elapsed_absolute, p_us_elapsed_relative, category,
     ++			 &buf_line);
      +	strbuf_addbuf(&buf_line, buf_payload);
      +	tr2_dst_write_line(&tr2dst_perf, &buf_line);
      +	strbuf_release(&buf_line);
     @@ -3561,8 +3614,7 @@
      +
      +	strbuf_addstr(&buf_payload, git_version_string);
      +
     -+	perf_io_write_fl(file, line, event_name, NULL,
     -+			 NULL, NULL, NULL,
     ++	perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
      +			 &buf_payload);
      +	strbuf_release(&buf_payload);
      +}
     @@ -3574,23 +3626,21 @@
      +
      +	sq_quote_argv_pretty(&buf_payload, argv);
      +
     -+	perf_io_write_fl(file, line, event_name, NULL,
     -+			 NULL, NULL, NULL,
     ++	perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
      +			 &buf_payload);
      +	strbuf_release(&buf_payload);
      +}
      +
     -+static void fn_exit_fl(const char *file, int line,
     -+		       uint64_t us_elapsed_absolute, int code)
     ++static void fn_exit_fl(const char *file, int line, uint64_t us_elapsed_absolute,
     ++		       int code)
      +{
      +	const char *event_name = "exit";
      +	struct strbuf buf_payload = STRBUF_INIT;
      +
      +	strbuf_addf(&buf_payload, "code:%d", code);
      +
     -+	perf_io_write_fl(file, line, event_name, NULL,
     -+			 &us_elapsed_absolute, NULL, NULL,
     -+			 &buf_payload);
     ++	perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
     ++			 NULL, NULL, &buf_payload);
      +	strbuf_release(&buf_payload);
      +}
      +
     @@ -3602,8 +3652,7 @@
      +	strbuf_addf(&buf_payload, "signo:%d", signo);
      +
      +	perf_io_write_fl(__FILE__, __LINE__, event_name, NULL,
     -+			 &us_elapsed_absolute, NULL, NULL,
     -+			 &buf_payload);
     ++			 &us_elapsed_absolute, NULL, NULL, &buf_payload);
      +	strbuf_release(&buf_payload);
      +}
      +
     @@ -3615,13 +3664,12 @@
      +	strbuf_addf(&buf_payload, "code:%d", code);
      +
      +	perf_io_write_fl(__FILE__, __LINE__, event_name, NULL,
     -+			 &us_elapsed_absolute, NULL, NULL,
     -+			 &buf_payload);
     ++			 &us_elapsed_absolute, NULL, NULL, &buf_payload);
      +	strbuf_release(&buf_payload);
      +}
      +
     -+static void maybe_append_string_va(struct strbuf *buf,
     -+				   const char *fmt, va_list ap)
     ++static void maybe_append_string_va(struct strbuf *buf, const char *fmt,
     ++				   va_list ap)
      +{
      +	if (fmt && *fmt && ap) {
      +		va_list copy_ap;
     @@ -3638,30 +3686,27 @@
      +	}
      +}
      +
     -+static void fn_error_va_fl(const char *file, int line,
     -+			   const char *fmt, va_list ap)
     ++static void fn_error_va_fl(const char *file, int line, const char *fmt,
     ++			   va_list ap)
      +{
      +	const char *event_name = "error";
      +	struct strbuf buf_payload = STRBUF_INIT;
      +
      +	maybe_append_string_va(&buf_payload, fmt, ap);
      +
     -+	perf_io_write_fl(file, line, event_name, NULL,
     -+			 NULL, NULL, NULL,
     ++	perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
      +			 &buf_payload);
      +	strbuf_release(&buf_payload);
      +}
      +
     -+static void fn_command_path_fl(const char *file, int line,
     -+			       const char *pathname)
     ++static void fn_command_path_fl(const char *file, int line, const char *pathname)
      +{
      +	const char *event_name = "cmd_path";
      +	struct strbuf buf_payload = STRBUF_INIT;
      +
      +	strbuf_addstr(&buf_payload, pathname);
      +
     -+	perf_io_write_fl(file, line, event_name, NULL,
     -+			 NULL, NULL, NULL,
     ++	perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
      +			 &buf_payload);
      +	strbuf_release(&buf_payload);
      +}
     @@ -3677,22 +3722,20 @@
      +	if (verb_hierarchy && *verb_hierarchy)
      +		strbuf_addf(&buf_payload, " (%s)", verb_hierarchy);
      +
     -+	perf_io_write_fl(file, line, event_name, NULL,
     -+			 NULL, NULL, NULL,
     ++	perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
      +			 &buf_payload);
      +	strbuf_release(&buf_payload);
      +}
      +
      +static void fn_command_subverb_fl(const char *file, int line,
     -+			       const char *command_subverb)
     ++				  const char *command_subverb)
      +{
      +	const char *event_name = "cmd_subverb";
      +	struct strbuf buf_payload = STRBUF_INIT;
      +
      +	strbuf_addstr(&buf_payload, command_subverb);
      +
     -+	perf_io_write_fl(file, line, event_name, NULL,
     -+			 NULL, NULL, NULL,
     ++	perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
      +			 &buf_payload);
      +	strbuf_release(&buf_payload);
      +}
     @@ -3706,8 +3749,7 @@
      +	strbuf_addf(&buf_payload, "alias:%s argv:", alias);
      +	sq_quote_argv_pretty(&buf_payload, argv);
      +
     -+	perf_io_write_fl(file, line, event_name, NULL,
     -+			 NULL, NULL, NULL,
     ++	perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
      +			 &buf_payload);
      +	strbuf_release(&buf_payload);
      +}
     @@ -3723,8 +3765,8 @@
      +		strbuf_addf(&buf_payload, "[ch%d] class:hook hook:%s",
      +			    cmd->trace2_child_id, cmd->trace2_hook_name);
      +	} else {
     -+		const char *child_class = ((cmd->trace2_child_class) ?
     -+					   cmd->trace2_child_class : "?");
     ++		const char *child_class =
     ++			cmd->trace2_child_class ? cmd->trace2_child_class : "?";
      +		strbuf_addf(&buf_payload, "[ch%d] class:%s",
      +			    cmd->trace2_child_id, child_class);
      +	}
     @@ -3739,37 +3781,33 @@
      +		strbuf_addstr(&buf_payload, " git");
      +	sq_quote_argv_pretty(&buf_payload, cmd->argv);
      +
     -+	perf_io_write_fl(file, line, event_name, NULL,
     -+			 &us_elapsed_absolute, NULL, NULL,
     -+			 &buf_payload);
     ++	perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
     ++			 NULL, NULL, &buf_payload);
      +	strbuf_release(&buf_payload);
      +}
      +
      +static void fn_child_exit_fl(const char *file, int line,
     -+			     uint64_t us_elapsed_absolute,
     -+			     int cid, int pid, int code,
     -+			     uint64_t us_elapsed_child)
     ++			     uint64_t us_elapsed_absolute, int cid, int pid,
     ++			     int code, uint64_t us_elapsed_child)
      +{
      +	const char *event_name = "child_exit";
      +	struct strbuf buf_payload = STRBUF_INIT;
      +
      +	strbuf_addf(&buf_payload, "[ch%d] pid:%d code:%d", cid, pid, code);
      +
     -+	perf_io_write_fl(file, line, event_name, NULL,
     -+			 &us_elapsed_absolute, &us_elapsed_child, NULL,
     -+			 &buf_payload);
     ++	perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
     ++			 &us_elapsed_child, NULL, &buf_payload);
      +	strbuf_release(&buf_payload);
      +}
      +
      +static void fn_thread_start_fl(const char *file, int line,
     -+				     uint64_t us_elapsed_absolute)
     ++			       uint64_t us_elapsed_absolute)
      +{
      +	const char *event_name = "thread_start";
      +	struct strbuf buf_payload = STRBUF_INIT;
      +
     -+	perf_io_write_fl(file, line, event_name, NULL,
     -+			 &us_elapsed_absolute, NULL, NULL,
     -+			 &buf_payload);
     ++	perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
     ++			 NULL, NULL, &buf_payload);
      +	strbuf_release(&buf_payload);
      +}
      +
     @@ -3780,14 +3818,12 @@
      +	const char *event_name = "thread_exit";
      +	struct strbuf buf_payload = STRBUF_INIT;
      +
     -+	perf_io_write_fl(file, line, event_name, NULL,
     -+			 &us_elapsed_absolute, &us_elapsed_thread, NULL,
     -+			 &buf_payload);
     ++	perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
     ++			 &us_elapsed_thread, NULL, &buf_payload);
      +	strbuf_release(&buf_payload);
      +}
      +
     -+static void fn_exec_fl(const char *file, int line,
     -+		       uint64_t us_elapsed_absolute,
     ++static void fn_exec_fl(const char *file, int line, uint64_t us_elapsed_absolute,
      +		       int exec_id, const char *exe, const char **argv)
      +{
      +	const char *event_name = "exec";
     @@ -3799,15 +3835,14 @@
      +		strbuf_addf(&buf_payload, " %s", exe);
      +	sq_quote_argv_pretty(&buf_payload, argv);
      +
     -+	perf_io_write_fl(file, line, event_name, NULL,
     -+			 &us_elapsed_absolute, NULL, NULL,
     -+			 &buf_payload);
     ++	perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
     ++			 NULL, NULL, &buf_payload);
      +	strbuf_release(&buf_payload);
      +}
      +
      +static void fn_exec_result_fl(const char *file, int line,
     -+			      uint64_t us_elapsed_absolute,
     -+			      int exec_id, int code)
     ++			      uint64_t us_elapsed_absolute, int exec_id,
     ++			      int code)
      +{
      +	const char *event_name = "exec_result";
      +	struct strbuf buf_payload = STRBUF_INIT;
     @@ -3816,22 +3851,20 @@
      +	if (code > 0)
      +		strbuf_addf(&buf_payload, " err:%s", strerror(code));
      +
     -+	perf_io_write_fl(file, line, event_name, NULL,
     -+			 &us_elapsed_absolute, NULL, NULL,
     -+			 &buf_payload);
     ++	perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
     ++			 NULL, NULL, &buf_payload);
      +	strbuf_release(&buf_payload);
      +}
      +
     -+static void fn_param_fl(const char *file, int line,
     -+			const char *param, const char *value)
     ++static void fn_param_fl(const char *file, int line, const char *param,
     ++			const char *value)
      +{
      +	const char *event_name = "def_param";
      +	struct strbuf buf_payload = STRBUF_INIT;
      +
      +	strbuf_addf(&buf_payload, "%s:%s", param, value);
      +
     -+	perf_io_write_fl(file, line, event_name, NULL,
     -+			 NULL, NULL, NULL,
     ++	perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
      +			 &buf_payload);
      +	strbuf_release(&buf_payload);
      +}
     @@ -3845,8 +3878,7 @@
      +	strbuf_addstr(&buf_payload, "worktree:");
      +	sq_quote_buf_pretty(&buf_payload, repo->worktree);
      +
     -+	perf_io_write_fl(file, line, event_name, repo,
     -+			 NULL, NULL, NULL,
     ++	perf_io_write_fl(file, line, event_name, repo, NULL, NULL, NULL,
      +			 &buf_payload);
      +	strbuf_release(&buf_payload);
      +}
     @@ -3865,19 +3897,15 @@
      +		strbuf_addf(&buf_payload, "label:%s ", label);
      +	maybe_append_string_va(&buf_payload, fmt, ap);
      +
     -+	perf_io_write_fl(file, line, event_name, repo,
     -+			 &us_elapsed_absolute, NULL, category,
     -+			 &buf_payload);
     ++	perf_io_write_fl(file, line, event_name, repo, &us_elapsed_absolute,
     ++			 NULL, category, &buf_payload);
      +	strbuf_release(&buf_payload);
      +}
      +
     -+static void fn_region_leave_printf_va_fl(const char *file, int line,
     -+					 uint64_t us_elapsed_absolute,
     -+					 uint64_t us_elapsed_region,
     -+					 const char *category,
     -+					 const char *label,
     -+					 const struct repository *repo,
     -+					 const char *fmt, va_list ap)
     ++static void fn_region_leave_printf_va_fl(
     ++	const char *file, int line, uint64_t us_elapsed_absolute,
     ++	uint64_t us_elapsed_region, const char *category, const char *label,
     ++	const struct repository *repo, const char *fmt, va_list ap)
      +{
      +	const char *event_name = "region_leave";
      +	struct strbuf buf_payload = STRBUF_INIT;
     @@ -3886,18 +3914,14 @@
      +		strbuf_addf(&buf_payload, "label:%s ", label);
      +	maybe_append_string_va(&buf_payload, fmt, ap);
      +
     -+	perf_io_write_fl(file, line, event_name, repo,
     -+			 &us_elapsed_absolute, &us_elapsed_region, category,
     -+			 &buf_payload);
     ++	perf_io_write_fl(file, line, event_name, repo, &us_elapsed_absolute,
     ++			 &us_elapsed_region, category, &buf_payload);
      +	strbuf_release(&buf_payload);
      +}
      +
     -+static void fn_data_fl(const char *file, int line,
     -+		       uint64_t us_elapsed_absolute,
     -+		       uint64_t us_elapsed_region,
     -+		       const char *category,
     -+		       const struct repository *repo,
     -+		       const char *key,
     ++static void fn_data_fl(const char *file, int line, uint64_t us_elapsed_absolute,
     ++		       uint64_t us_elapsed_region, const char *category,
     ++		       const struct repository *repo, const char *key,
      +		       const char *value)
      +{
      +	const char *event_name = "data";
     @@ -3905,18 +3929,15 @@
      +
      +	strbuf_addf(&buf_payload, "%s:%s", key, value);
      +
     -+	perf_io_write_fl(file, line, event_name, repo,
     -+			 &us_elapsed_absolute, &us_elapsed_region, category,
     -+			 &buf_payload);
     ++	perf_io_write_fl(file, line, event_name, repo, &us_elapsed_absolute,
     ++			 &us_elapsed_region, category, &buf_payload);
      +	strbuf_release(&buf_payload);
      +}
      +
      +static void fn_data_json_fl(const char *file, int line,
      +			    uint64_t us_elapsed_absolute,
     -+			    uint64_t us_elapsed_region,
     -+			    const char *category,
     -+			    const struct repository *repo,
     -+			    const char *key,
     ++			    uint64_t us_elapsed_region, const char *category,
     ++			    const struct repository *repo, const char *key,
      +			    const struct json_writer *value)
      +{
      +	const char *event_name = "data_json";
     @@ -3924,29 +3945,26 @@
      +
      +	strbuf_addf(&buf_payload, "%s:%s", key, value->json.buf);
      +
     -+	perf_io_write_fl(file, line, event_name, repo,
     -+			 &us_elapsed_absolute, &us_elapsed_region, category,
     -+			 &buf_payload);
     ++	perf_io_write_fl(file, line, event_name, repo, &us_elapsed_absolute,
     ++			 &us_elapsed_region, category, &buf_payload);
      +	strbuf_release(&buf_payload);
      +}
      +
      +static void fn_printf_va_fl(const char *file, int line,
     -+			    uint64_t us_elapsed_absolute,
     -+			    const char *fmt, va_list ap)
     ++			    uint64_t us_elapsed_absolute, const char *fmt,
     ++			    va_list ap)
      +{
      +	const char *event_name = "printf";
      +	struct strbuf buf_payload = STRBUF_INIT;
      +
      +	maybe_append_string_va(&buf_payload, fmt, ap);
      +
     -+	perf_io_write_fl(file, line, event_name, NULL,
     -+			 &us_elapsed_absolute, NULL, NULL,
     -+			 &buf_payload);
     ++	perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
     ++			 NULL, NULL, &buf_payload);
      +	strbuf_release(&buf_payload);
      +}
      +
     -+struct tr2_tgt tr2_tgt_perf =
     -+{
     ++struct tr2_tgt tr2_tgt_perf = {
      +	&tr2dst_perf,
      +
      +	fn_init,
     @@ -4012,11 +4030,11 @@
      +	 * application run time.
      +	 */
      +	ctx->alloc = TR2_REGION_NESTING_INITIAL_SIZE;
     -+	ctx->array_us_start = (uint64_t*)xcalloc(ctx->alloc, sizeof(uint64_t));
     ++	ctx->array_us_start = (uint64_t *)xcalloc(ctx->alloc, sizeof(uint64_t));
      +	ctx->array_us_start[ctx->nr_open_regions++] = us_now;
      +
      +	ctx->thread_id = tr2tls_locked_increment(&tr2_next_thread_id);
     -+	
     ++
      +	strbuf_init(&ctx->thread_name, 0);
      +	if (ctx->thread_id)
      +		strbuf_addf(&ctx->thread_name, "th%02d:", ctx->thread_id);
     @@ -4031,7 +4049,7 @@
      +
      +struct tr2tls_thread_ctx *tr2tls_get_self(void)
      +{
     -+	struct tr2tls_thread_ctx * ctx = pthread_getspecific(tr2tls_key);
     ++	struct tr2tls_thread_ctx *ctx = pthread_getspecific(tr2tls_key);
      +
      +	/*
      +	 * If the thread-proc did not call trace2_thread_start(), we won't
     @@ -4046,14 +4064,14 @@
      +
      +int tr2tls_is_main_thread(void)
      +{
     -+	struct tr2tls_thread_ctx * ctx = pthread_getspecific(tr2tls_key);
     ++	struct tr2tls_thread_ctx *ctx = pthread_getspecific(tr2tls_key);
      +
      +	return ctx == tr2tls_thread_main;
      +}
      +
      +void tr2tls_unset_self(void)
      +{
     -+	struct tr2tls_thread_ctx * ctx;
     ++	struct tr2tls_thread_ctx *ctx;
      +
      +	ctx = tr2tls_get_self();
      +
     @@ -4097,7 +4115,7 @@
      +	ctx = tr2tls_get_self();
      +	if (!ctx->nr_open_regions)
      +		return 0;
     -+	
     ++
      +	us_start = ctx->array_us_start[ctx->nr_open_regions - 1];
      +
      +	return us - us_start;
     @@ -4155,6 +4173,8 @@
      +#ifndef TR2_TLS_H
      +#define TR2_TLS_H
      +
     ++struct strbuf;
     ++
      +/*
      + * Arbitry limit for thread names for column alignment.
      + */
  3:  5ac061e14a !  3:  e8b8226640 trace2: collect platform-specific process information
     @@ -80,7 +80,6 @@
      +	pid = pe32.th32ParentProcessID;
      +
      +	while (find_pid(pid, hSnapshot, &pe32)) {
     -+
      +		jw_array_string(jw, pe32.szExeFile);
      +
      +		pid = pe32.th32ParentProcessID;
     @@ -102,8 +101,8 @@
      +		get_processes(&jw, hSnapshot);
      +		jw_end(&jw);
      +
     -+		trace2_data_json("process", the_repository,
     -+				 "windows/ancestry", &jw);
     ++		trace2_data_json("process", the_repository, "windows/ancestry",
     ++				 &jw);
      +
      +		jw_release(&jw);
      +		CloseHandle(hSnapshot);
     @@ -122,7 +121,7 @@
      +{
      +	if (IsDebuggerPresent())
      +		trace2_data_intmax("process", the_repository,
     -+			   "windows/debugger_present", 1);
     ++				   "windows/debugger_present", 1);
      +}
      +
      +void trace2_collect_process_info(void)
     @@ -171,7 +170,8 @@
      +void trace2_collect_process_info(void);
      +#else
      +#define trace2_collect_process_info() \
     -+	do {} while (0)
     ++	do {                          \
     ++	} while (0)
      +#endif
      +
       #endif /* TRACE2_H */
  4:  f9d689a54b !  4:  0d59a6f2eb trace2:data: add trace2 regions to wt-status
     @@ -44,7 +44,8 @@
       void wt_status_print(struct wt_status *s)
       {
      +	trace2_data_intmax("status", s->repo, "count/changed", s->change.nr);
     -+	trace2_data_intmax("status", s->repo, "count/untracked", s->untracked.nr);
     ++	trace2_data_intmax("status", s->repo, "count/untracked",
     ++			   s->untracked.nr);
      +	trace2_data_intmax("status", s->repo, "count/ignored", s->ignored.nr);
      +
      +	trace2_region_enter("status", "print", s->repo);
  5:  6be101d520 =  5:  2513091f77 trace2:data: add editor/pager child classification
  6:  b590f19100 =  6:  785f6f866e trace2:data: add trace2 sub-process classification
  7:  68192b8dfb =  7:  b7e6644f4b trace2:data: add trace2 transport child classification
  8:  b373ab640b =  8:  52aace533b trace2:data: add trace2 hook classification
  9:  548ea52742 !  9:  a2bcc6fd28 trace2:data: add trace2 instrumentation to index read/write
     @@ -18,8 +18,10 @@
      +	 * TODO trace2: replace "the_repository" with the actual repo instance
      +	 * that is associated with the given "istate".
      +	 */
     -+	trace2_data_intmax("index", the_repository, "read/version", istate->version);
     -+	trace2_data_intmax("index", the_repository, "read/cache_nr", istate->cache_nr);
     ++	trace2_data_intmax("index", the_repository, "read/version",
     ++			   istate->version);
     ++	trace2_data_intmax("index", the_repository, "read/cache_nr",
     ++			   istate->cache_nr);
      +
       	return istate->cache_nr;
       
     @@ -46,11 +48,11 @@
       
       	base_oid_hex = oid_to_hex(&split_index->base_oid);
       	base_path = xstrfmt("%s/sharedindex.%s", gitdir, base_oid_hex);
     -+	trace2_region_enter_printf("index", "shared/do_read_index", the_repository,
     -+				   "%s", base_path);
     ++	trace2_region_enter_printf("index", "shared/do_read_index",
     ++				   the_repository, "%s", base_path);
       	ret = do_read_index(split_index->base, base_path, 1);
     -+	trace2_region_leave_printf("index", "shared/do_read_index", the_repository,
     -+				   "%s", base_path);
     ++	trace2_region_leave_printf("index", "shared/do_read_index",
     ++				   the_repository, "%s", base_path);
       	if (!oideq(&split_index->base_oid, &split_index->base->oid))
       		die(_("broken index, expect %s in %s, got %s"),
       		    base_oid_hex, base_path,
     @@ -63,8 +65,10 @@
      +	 * TODO trace2: replace "the_repository" with the actual repo instance
      +	 * that is associated with the given "istate".
      +	 */
     -+	trace2_data_intmax("index", the_repository, "write/version", istate->version);
     -+	trace2_data_intmax("index", the_repository, "write/cache_nr", istate->cache_nr);
     ++	trace2_data_intmax("index", the_repository, "write/version",
     ++			   istate->version);
     ++	trace2_data_intmax("index", the_repository, "write/cache_nr",
     ++			   istate->cache_nr);
      +
       	return 0;
       }
 10:  3458917811 ! 10:  d508322638 pack-objects: add trace2 regions
     @@ -14,6 +14,7 @@
          3. Write pack-file.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
     +    Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
       diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
       --- a/builtin/pack-objects.c
     @@ -30,7 +31,8 @@
       		}
       	}
       
     -+	trace2_region_enter("pack-objects", "enumerate-objects", the_repository);
     ++	trace2_region_enter("pack-objects", "enumerate-objects",
     ++			    the_repository);
       	prepare_packing_data(the_repository, &to_pack);
       
       	if (progress)
     @@ -38,15 +40,18 @@
       	if (include_tag && nr_result)
       		for_each_ref(add_ref_tag, NULL);
       	stop_progress(&progress_state);
     -+	trace2_region_leave("pack-objects", "enumerate-objects", the_repository);
     ++	trace2_region_leave("pack-objects", "enumerate-objects",
     ++			    the_repository);
       
       	if (non_empty && !nr_result)
       		return 0;
      -	if (nr_result)
      +	if (nr_result) {
     -+		trace2_region_enter("pack-objects", "prepare-pack", the_repository);
     ++		trace2_region_enter("pack-objects", "prepare-pack",
     ++				    the_repository);
       		prepare_pack(window, depth);
     -+		trace2_region_leave("pack-objects", "prepare-pack", the_repository);
     ++		trace2_region_leave("pack-objects", "prepare-pack",
     ++				    the_repository);
      +	}
      +
      +	trace2_region_enter("pack-objects", "write-pack-file", the_repository);
 11:  86feec03e2 = 11:  33e431be88 trace2:data: add subverb to checkout command
 12:  9abbdf9ccd = 12:  e46e92bc7c trace2:data: add subverb to reset command
 13:  06ccce9632 ! 13:  0a05e15978 trace2:data: add subverb for rebase
     @@ -11,16 +11,14 @@
       		ACTION_EDIT_TODO,
       		ACTION_SHOW_CURRENT_PATCH,
       	} action = NO_ACTION;
     -+	static const char *action_names[] = {
     -+		N_("undefined"),
     -+		N_("continue"),
     -+		N_("skip"),
     -+		N_("abort"),
     -+		N_("quit"),
     -+		N_("edit_todo"),
     -+		N_("show_current_patch"),
     -+		NULL
     -+	};
     ++	static const char *action_names[] = { N_("undefined"),
     ++					      N_("continue"),
     ++					      N_("skip"),
     ++					      N_("abort"),
     ++					      N_("quit"),
     ++					      N_("edit_todo"),
     ++					      N_("show_current_patch"),
     ++					      NULL };
       	const char *gpg_sign = NULL;
       	struct string_list exec = STRING_LIST_INIT_NODUP;
       	const char *rebase_merges = NULL;
 14:  851aa8f34d ! 14:  aeaf990b1b trace2: t/helper/test-trace2, t0210.sh, t0211.sh, t0212.sh
     @@ -54,16 +54,15 @@
      +#include "exec-cmd.h"
      +#include "config.h"
      +
     -+typedef int (fn_unit_test)(int argc, const char **argv);
     ++typedef int(fn_unit_test)(int argc, const char **argv);
      +
     -+struct unit_test 
     -+{
     ++struct unit_test {
      +	fn_unit_test *ut_fn;
     -+	const char   *ut_name;
     -+	const char   *ut_usage;
     ++	const char *ut_name;
     ++	const char *ut_usage;
      +};
      +
     -+#define MyOk    0
     ++#define MyOk 0
      +#define MyError 1
      +
      +static int get_i(int *p_value, const char *data)
     @@ -91,7 +90,8 @@
      + * [] the "code" field in the "exit" trace2 event.
      + * [] the "code" field in the "atexit" trace2 event.
      + * [] the "name" field in the "cmd_verb" trace2 event.
     -+ * [] "def_param" events for all of the "interesting" pre-defined config settings.
     ++ * [] "def_param" events for all of the "interesting" pre-defined
     ++ * config settings.
      + */
      +static int ut_001return(int argc, const char **argv)
      +{
     @@ -110,7 +110,8 @@
      + * [] the "code" field in the "exit" trace2 event.
      + * [] the "code" field in the "atexit" trace2 event.
      + * [] the "name" field in the "cmd_verb" trace2 event.
     -+ * [] "def_param" events for all of the "interesting" pre-defined config settings.
     ++ * [] "def_param" events for all of the "interesting" pre-defined
     ++ * config settings.
      + */
      +static int ut_002exit(int argc, const char **argv)
      +{
     @@ -213,7 +214,7 @@
      + *
      + * Test harness can confirm (on platforms with a real exec() function):
      + * [] TODO talk about process replacement and how it affects SID.
     -+ */ 
     ++ */
      +static int ut_005exec(int argc, const char **argv)
      +{
      +	int result;
     @@ -234,8 +235,7 @@
      +		die("%s", usage_error);
      +
      +	while (argc) {
     -+		if (!argv[0] || !*argv[0] ||
     -+		    !argv[1] || !*argv[1] ||
     ++		if (!argv[0] || !*argv[0] || !argv[1] || !*argv[1] ||
      +		    !argv[2] || !*argv[2])
      +			die("%s", usage_error);
      +
     @@ -252,7 +252,7 @@
      + *     test-tool trace2 <ut_name_1> <ut_usage_1>
      + *     test-tool trace2 <ut_name_2> <ut_usage_2>
      + *     ...
     -+ */ 
     ++ */
      +#define USAGE_PREFIX "test-tool trace2"
      +
      +static struct unit_test ut_table[] = {
     @@ -275,9 +275,10 @@
      +	struct unit_test *ut_k;
      +
      +	fprintf(stderr, "usage:\n");
     -+	for_each_ut(k, ut_k) {
     -+		fprintf(stderr, "\t%s %s %s\n",
     -+			USAGE_PREFIX, ut_k->ut_name, ut_k->ut_usage);
     ++	for_each_ut(k, ut_k)
     ++	{
     ++		fprintf(stderr, "\t%s %s %s\n", USAGE_PREFIX, ut_k->ut_name,
     ++			ut_k->ut_usage);
      +	}
      +
      +	return 129;
     @@ -307,11 +308,12 @@
      +	int k;
      +	struct unit_test *ut_k;
      +
     -+	argc--;	/* skip over "trace2" arg */
     ++	argc--; /* skip over "trace2" arg */
      +	argv++;
      +
      +	if (argc) {
     -+		for_each_ut(k, ut_k) {
     ++		for_each_ut(k, ut_k)
     ++		{
      +			if (!strcmp(argv[0], ut_k->ut_name))
      +				return ut_k->ut_fn(argc - 1, argv + 1);
      +		}
     @@ -319,7 +321,6 @@
      +
      +	return print_usage();
      +}
     -+
      
       diff --git a/t/t0210-trace2-normal.sh b/t/t0210-trace2-normal.sh
       new file mode 100755
     @@ -337,8 +338,6 @@
      +TTDIR="$GIT_BUILD_DIR/t/helper/" && export TTDIR
      +PATH="$TTDIR:$PATH" && export PATH
      +
     -+TT="test-tool" && export TT
     -+
      +# Warning: use of 'test_cmp' may run test-tool.exe and/or git.exe
      +# Warning: to do the actual diff/comparison, so the HEREDOCs here
      +# Warning: only cover our actual calls to test-tool and/or git.
     @@ -384,9 +383,7 @@
      +
      +test_expect_success 'normal stream, return code 0' '
      +	test_when_finished "rm trace.normal actual expect" &&
     -+	GIT_TR2="$(pwd)/trace.normal" && export GIT_TR2 &&
     -+	$TT trace2 001return 0 &&
     -+	unset GIT_TR2 &&
     ++	GIT_TR2="$(pwd)/trace.normal" test-tool trace2 001return 0 &&
      +	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
      +	cat >expect <<-EOF &&
      +		version $V
     @@ -400,9 +397,7 @@
      +
      +test_expect_success 'normal stream, return code 1' '
      +	test_when_finished "rm trace.normal actual expect" &&
     -+	GIT_TR2="$(pwd)/trace.normal" && export GIT_TR2 &&
     -+	test_must_fail $TT trace2 001return 1 &&
     -+	unset GIT_TR2 &&
     ++	test_must_fail env GIT_TR2="$(pwd)/trace.normal" test-tool trace2 001return 1 &&
      +	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
      +	cat >expect <<-EOF &&
      +		version $V
     @@ -420,9 +415,7 @@
      +
      +test_expect_success 'normal stream, exit code 0' '
      +	test_when_finished "rm trace.normal actual expect" &&
     -+	GIT_TR2="$(pwd)/trace.normal" && export GIT_TR2 &&
     -+	$TT trace2 002exit 0 &&
     -+	unset GIT_TR2 &&
     ++	GIT_TR2="$(pwd)/trace.normal" test-tool trace2 002exit 0 &&
      +	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
      +	cat >expect <<-EOF &&
      +		version $V
     @@ -436,9 +429,7 @@
      +
      +test_expect_success 'normal stream, exit code 1' '
      +	test_when_finished "rm trace.normal actual expect" &&
     -+	GIT_TR2="$(pwd)/trace.normal" && export GIT_TR2 &&
     -+	test_must_fail $TT trace2 002exit 1 &&
     -+	unset GIT_TR2 &&
     ++	test_must_fail env GIT_TR2="$(pwd)/trace.normal" test-tool trace2 002exit 1 &&
      +	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
      +	cat >expect <<-EOF &&
      +		version $V
     @@ -456,9 +447,7 @@
      +
      +test_expect_success 'normal stream, error event' '
      +	test_when_finished "rm trace.normal actual expect" &&
     -+	GIT_TR2="$(pwd)/trace.normal" && export GIT_TR2 &&
     -+	$TT trace2 003error "hello world" "this is a test" &&
     -+	unset GIT_TR2 &&
     ++	GIT_TR2="$(pwd)/trace.normal" test-tool trace2 003error "hello world" "this is a test" &&
      +	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
      +	cat >expect <<-EOF &&
      +		version $V
     @@ -544,8 +533,6 @@
      +TTDIR="$GIT_BUILD_DIR/t/helper/" && export TTDIR
      +PATH="$TTDIR:$PATH" && export PATH
      +
     -+TT="test-tool" && export TT
     -+
      +# Warning: use of 'test_cmp' may run test-tool.exe and/or git.exe
      +# Warning: to do the actual diff/comparison, so the HEREDOCs here
      +# Warning: only cover our actual calls to test-tool and/or git.
     @@ -583,9 +570,7 @@
      +
      +test_expect_success 'perf stream, return code 0' '
      +	test_when_finished "rm trace.perf actual expect" &&
     -+	GIT_TR2_PERF="$(pwd)/trace.perf" && export GIT_TR2_PERF &&
     -+	$TT trace2 001return 0 &&
     -+	unset GIT_TR2_PERF &&
     ++	GIT_TR2_PERF="$(pwd)/trace.perf" test-tool trace2 001return 0 &&
      +	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <trace.perf >actual &&
      +	cat >expect <<-EOF &&
      +		d0|main|version|||||$V
     @@ -599,9 +584,7 @@
      +
      +test_expect_success 'perf stream, return code 1' '
      +	test_when_finished "rm trace.perf actual expect" &&
     -+	GIT_TR2_PERF="$(pwd)/trace.perf" && export GIT_TR2_PERF &&
     -+	test_must_fail $TT trace2 001return 1 &&
     -+	unset GIT_TR2_PERF &&
     ++	test_must_fail env GIT_TR2_PERF="$(pwd)/trace.perf" test-tool trace2 001return 1 &&
      +	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <trace.perf >actual &&
      +	cat >expect <<-EOF &&
      +		d0|main|version|||||$V
     @@ -619,9 +602,7 @@
      +
      +test_expect_success 'perf stream, error event' '
      +	test_when_finished "rm trace.perf actual expect" &&
     -+	GIT_TR2_PERF="$(pwd)/trace.perf" && export GIT_TR2_PERF &&
     -+	$TT trace2 003error "hello world" "this is a test" &&
     -+	unset GIT_TR2_PERF &&
     ++	GIT_TR2_PERF="$(pwd)/trace.perf" test-tool trace2 003error "hello world" "this is a test" &&
      +	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <trace.perf >actual &&
      +	cat >expect <<-EOF &&
      +		d0|main|version|||||$V
     @@ -667,19 +648,17 @@
      +
      +test_expect_success 'perf stream, child processes' '
      +	test_when_finished "rm trace.perf actual expect" &&
     -+	GIT_TR2_PERF="$(pwd)/trace.perf" && export GIT_TR2_PERF &&
     -+	$TT trace2 004child $TT trace2 004child $TT trace2 001return 0 &&
     -+	unset GIT_TR2_PERF &&
     ++	GIT_TR2_PERF="$(pwd)/trace.perf" test-tool trace2 004child test-tool trace2 004child test-tool trace2 001return 0 &&
      +	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <trace.perf >actual &&
      +	cat >expect <<-EOF &&
      +		d0|main|version|||||$V
     -+		d0|main|start|||||_EXE_ trace2 004child $TT trace2 004child $TT trace2 001return 0
     ++		d0|main|start|||||_EXE_ trace2 004child test-tool trace2 004child test-tool trace2 001return 0
      +		d0|main|cmd_verb|||||trace2 (trace2)
     -+		d0|main|child_start||_T_ABS_|||[ch0] class:? argv: $TT trace2 004child $TT trace2 001return 0
     ++		d0|main|child_start||_T_ABS_|||[ch0] class:? argv: test-tool trace2 004child test-tool trace2 001return 0
      +		d1|main|version|||||$V
     -+		d1|main|start|||||_EXE_ trace2 004child $TT trace2 001return 0
     ++		d1|main|start|||||_EXE_ trace2 004child test-tool trace2 001return 0
      +		d1|main|cmd_verb|||||trace2 (trace2/trace2)
     -+		d1|main|child_start||_T_ABS_|||[ch0] class:? argv: $TT trace2 001return 0
     ++		d1|main|child_start||_T_ABS_|||[ch0] class:? argv: test-tool trace2 001return 0
      +		d2|main|version|||||$V
      +		d2|main|start|||||_EXE_ trace2 001return 0
      +		d2|main|cmd_verb|||||trace2 (trace2/trace2/trace2)
     @@ -795,8 +774,6 @@
      +TTDIR="$GIT_BUILD_DIR/t/helper/" && export TTDIR
      +PATH="$TTDIR:$PATH" && export PATH
      +
     -+TT="test-tool" && export TT
     -+
      +# Warning: use of 'test_cmp' may run test-tool.exe and/or git.exe
      +# Warning: to do the actual diff/comparison, so the HEREDOCs here
      +# Warning: only cover our actual calls to test-tool and/or git.
     @@ -828,9 +805,7 @@
      +
      +test_expect_success 'event stream, error event' '
      +	test_when_finished "rm trace.event actual expect" &&
     -+	GIT_TR2_EVENT="$(pwd)/trace.event" && export GIT_TR2_EVENT &&
     -+	$TT trace2 003error "hello world" "this is a test" &&
     -+	unset GIT_TR2_EVENT &&
     ++	GIT_TR2_EVENT="$(pwd)/trace.event" test-tool trace2 003error "hello world" "this is a test" &&
      +	perl "$TEST_DIRECTORY/t0212/parse_events.perl" <trace.event >actual &&
      +	sed -e "s/^|//" >expect <<-EOF &&
      +	|VAR1 = {
     @@ -866,10 +841,8 @@
      +#    P3:      |--- TT trace2 001return 0
      +
      +test_expect_success 'event stream, return code 0' '
     -+#	test_when_finished "rm trace.event actual expect" &&
     -+	GIT_TR2_EVENT="$(pwd)/trace.event" && export GIT_TR2_EVENT &&
     -+	$TT trace2 004child $TT trace2 004child $TT trace2 001return 0 &&
     -+	unset GIT_TR2_EVENT &&
     ++	test_when_finished "rm trace.event actual expect" &&
     ++	GIT_TR2_EVENT="$(pwd)/trace.event" test-tool trace2 004child test-tool trace2 004child test-tool trace2 001return 0 &&
      +	perl "$TEST_DIRECTORY/t0212/parse_events.perl" <trace.event >actual &&
      +	sed -e "s/^|//" >expect <<-EOF &&
      +	|VAR1 = {
     @@ -878,10 +851,10 @@
      +	|      "_EXE_",
      +	|      "trace2",
      +	|      "004child",
     -+	|      "$TT",
     ++	|      "test-tool",
      +	|      "trace2",
      +	|      "004child",
     -+	|      "$TT",
     ++	|      "test-tool",
      +	|      "trace2",
      +	|      "001return",
      +	|      "0"
     @@ -892,7 +865,7 @@
      +	|          "_EXE_",
      +	|          "trace2",
      +	|          "004child",
     -+	|          "$TT",
     ++	|          "test-tool",
      +	|          "trace2",
      +	|          "001return",
      +	|          "0"
     @@ -912,7 +885,7 @@
      +	|      "_EXE_",
      +	|      "trace2",
      +	|      "004child",
     -+	|      "$TT",
     ++	|      "test-tool",
      +	|      "trace2",
      +	|      "001return",
      +	|      "0"
     @@ -958,11 +931,7 @@
      +	test_when_finished "rm trace.event actual expect" &&
      +	git config --local t0212.abc 1 &&
      +	git config --local t0212.def "hello world" &&
     -+	# delete events generated by the above config commands
     -+	rm trace.event &&
     -+	GIT_TR2_EVENT="$(pwd)/trace.event" && export GIT_TR2_EVENT &&
     -+	GIT_TR2_CONFIG_PARAMS="t0212.*" $TT trace2 001return 0 &&
     -+	unset GIT_TR2_EVENT &&
     ++	GIT_TR2_EVENT="$(pwd)/trace.event" GIT_TR2_CONFIG_PARAMS="t0212.*" test-tool trace2 001return 0 &&
      +	perl "$TEST_DIRECTORY/t0212/parse_events.perl" <trace.event >actual &&
      +	sed -e "s/^|//" >expect <<-EOF &&
      +	|VAR1 = {
     @@ -995,9 +964,7 @@
      +
      +test_expect_success 'basic trace2_data' '
      +	test_when_finished "rm trace.event actual expect" &&
     -+	GIT_TR2_EVENT="$(pwd)/trace.event" && export GIT_TR2_EVENT &&
     -+	$TT trace2 006data test_category k1 v1 test_category k2 v2 &&
     -+	unset GIT_TR2_EVENT &&
     ++	GIT_TR2_EVENT="$(pwd)/trace.event" test-tool trace2 006data test_category k1 v1 test_category k2 v2 &&
      +	perl "$TEST_DIRECTORY/t0212/parse_events.perl" <trace.event >actual &&
      +	sed -e "s/^|//" >expect <<-EOF &&
      +	|VAR1 = {

-- 
gitgitgadget
