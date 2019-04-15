Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2BF020248
	for <e@80x24.org>; Mon, 15 Apr 2019 20:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbfDOUjq (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 16:39:46 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:36864 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfDOUjq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 16:39:46 -0400
Received: by mail-ed1-f52.google.com with SMTP id f53so14323923ede.4
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 13:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5rX45kOZmovogq6xNgXuLCXWxKxjws/2olFgnoGDDtA=;
        b=CMYWWu3YvmCurwLT/Y+6S0ghg6HKkSbAW45Cdkf3OxpSOJ7o85RsDnnM08e9B02uud
         7CtLoHKHNbu4hFM3GYNZeXTovwIwQqxW2cjVMFF/HUmnlo8WyGpT8ow8SS+i3SCF/VwR
         1cojV8CgU+nrO39dCt96lLfB4VAxKFxogNL3h9VmczhMLY1vZ40hpGMGPOApR72bzFtQ
         O8RMIy5+q0lqQOy08bharGQgSvOgl+bnupty1wapfNmLTPxpXeRWHphGChOSisMxmdJY
         7G3pKgBC290G4YgeGQtBxW0IpflxoEtRwCkH43E+s9eIw62QbIwsboOhjI/D3C9OEOfE
         8rxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5rX45kOZmovogq6xNgXuLCXWxKxjws/2olFgnoGDDtA=;
        b=P5NpU40I+wGGKzq21Ig6FS8Iv87ppuwqLfjqbA/KFWtsaU4Yy7rnRc2dPGC9bNJIo7
         NigJAZAeU+/+wrE33JfN2q7VOK57nS9n01C/gBrKSx5eAD9C53QbA9f/NrFr9sgSX156
         V7hn5yU/0GYWK92rfTUpwk08egYLKjIRlzx3/D6T7A67MdR7Y3qL1gGvF5+lDCgFlhyl
         WukBDPD7yoO9xMfXdjnP7pL/t2b7yJwkZuNLDZe6/kkQOHBDXexYUs9V5ZnjiWgBs0DB
         ajyTtS7wSKZEnWPhum0TGFPWOn752L5qDsH97TeGiLfuKhEBwX+PvBtdL0bdwLNChRLC
         fdAg==
X-Gm-Message-State: APjAAAVHREGzlp+3WkoRnYTSW56U+9JsqRcbtxks/73ybRFcq7GDx48n
        SHBzTYRohlDI1OqXLTJQ8o5WaLtb
X-Google-Smtp-Source: APXvYqxtRZOe1LOZmGCbSgAfS3HXnfiTz0Ctpc04emQqkWxPsdkZ33G7+K+vQavLcLgxuOHFP9mv/w==
X-Received: by 2002:a17:906:f0f:: with SMTP id z15mr26100685eji.125.1555360782633;
        Mon, 15 Apr 2019 13:39:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l3sm1798345edl.63.2019.04.15.13.39.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 13:39:41 -0700 (PDT)
Date:   Mon, 15 Apr 2019 13:39:41 -0700 (PDT)
X-Google-Original-Date: Mon, 15 Apr 2019 20:39:30 GMT
Message-Id: <pull.169.v4.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.169.v3.git.gitgitgadget@gmail.com>
References: <pull.169.v3.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 00/10] trace2: load trace2 settings from system config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jrnieder@gmail.com,
        steadmon@google.com, avarab@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Version 4 fixes a few clang-format warnings and simplifies the PID field in
the SID.

Jeff Hostetler (10):
  config: initialize opts structure in repo_read_config()
  trace2: refactor setting process starting time
  trace2: add absolute elapsed time to start event
  trace2: find exec-dir before trace2 initialization
  config: add read_very_early_config()
  trace2: use system/global config for default trace2 settings
  trace2: report peak memory usage of the process
  trace2: clarify UTC datetime formatting
  trace2: make SIDs more unique
  trace2: update docs to describe system/global config settings

 Documentation/config.txt                 |   2 +
 Documentation/config/trace2.txt          |  56 ++++++++
 Documentation/technical/api-trace2.txt   | 176 +++++++++++++----------
 Documentation/trace2-target-values.txt   |  10 ++
 Makefile                                 |   1 +
 common-main.c                            |   8 +-
 compat/mingw.c                           |   2 +
 compat/win32/trace2_win32_process_info.c |  50 ++++++-
 config.c                                 |  25 +++-
 config.h                                 |   4 +
 t/t0210-trace2-normal.sh                 |  49 ++++++-
 t/t0211-trace2-perf.sh                   |  43 ++++--
 t/t0212-trace2-event.sh                  |  42 +++++-
 trace2.c                                 |  21 ++-
 trace2.h                                 |  43 ++++--
 trace2/tr2_cfg.c                         |   7 +-
 trace2/tr2_dst.c                         |  26 ++--
 trace2/tr2_dst.h                         |   3 +-
 trace2/tr2_sid.c                         |  53 ++++++-
 trace2/tr2_sysenv.c                      | 127 ++++++++++++++++
 trace2/tr2_sysenv.h                      |  36 +++++
 trace2/tr2_tbuf.c                        |  19 ++-
 trace2/tr2_tbuf.h                        |   5 +-
 trace2/tr2_tgt.h                         |   1 +
 trace2/tr2_tgt_event.c                   |  53 +++----
 trace2/tr2_tgt_normal.c                  |  19 +--
 trace2/tr2_tgt_perf.c                    |  23 +--
 trace2/tr2_tls.c                         |  38 +++--
 trace2/tr2_tls.h                         |   8 +-
 29 files changed, 747 insertions(+), 203 deletions(-)
 create mode 100644 Documentation/config/trace2.txt
 create mode 100644 Documentation/trace2-target-values.txt
 create mode 100644 trace2/tr2_sysenv.c
 create mode 100644 trace2/tr2_sysenv.h


base-commit: 041f5ea1cf987a4068ef5f39ba0a09be85952064
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-169%2Fjeffhostetler%2Fcore-tr2-startup-and-sysenv-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-169/jeffhostetler/core-tr2-startup-and-sysenv-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/169

Range-diff vs v3:

  1:  ea8c199f91 !  1:  f6653f1c59 config: initialize opts structure in repo_read_config()
     @@ -25,7 +25,7 @@
       static void repo_read_config(struct repository *repo)
       {
      -	struct config_options opts;
     -+	struct config_options opts = {0};
     ++	struct config_options opts = { 0 };
       
       	opts.respect_includes = 1;
       	opts.commondir = repo->commondir;
  2:  3dbcfc6a8d !  2:  48e34834b6 trace2: refactor setting process starting time
     @@ -196,8 +196,8 @@
      -	 * thread's array (because of reallocs).
      -	 */
      -	tr2tls_us_start_main = tr2tls_thread_main->array_us_start[0];
     -+	tr2tls_thread_main = tr2tls_create_self("main",
     -+						tr2tls_us_start_process);
     ++	tr2tls_thread_main =
     ++		tr2tls_create_self("main", tr2tls_us_start_process);
       }
       
       void tr2tls_release(void)
  3:  8b00025af5 =  3:  175371fb54 trace2: add absolute elapsed time to start event
  4:  c3c5f6a96b =  4:  94729b284c trace2: find exec-dir before trace2 initialization
  5:  d15be7b63a !  5:  b0fe1385f1 config: add read_very_early_config()
     @@ -16,8 +16,8 @@
       
       	current_parsing_scope = CONFIG_SCOPE_REPO;
      -	if (repo_config && !access_or_die(repo_config, R_OK, 0))
     -+	if (!opts->ignore_repo &&
     -+	    repo_config && !access_or_die(repo_config, R_OK, 0))
     ++	if (!opts->ignore_repo && repo_config &&
     ++	    !access_or_die(repo_config, R_OK, 0))
       		ret += git_config_from_file(fn, repo_config, data);
       
       	/*
     @@ -25,8 +25,7 @@
       	 * But let's not complicate things before it's actually needed.
       	 */
      -	if (repository_format_worktree_config) {
     -+	if (!opts->ignore_worktree &&
     -+	    repository_format_worktree_config) {
     ++	if (!opts->ignore_worktree && repository_format_worktree_config) {
       		char *path = git_pathdup("config.worktree");
       		if (!access_or_die(path, R_OK, 0))
       			ret += git_config_from_file(fn, path, data);
     @@ -35,8 +34,7 @@
       
       	current_parsing_scope = CONFIG_SCOPE_CMDLINE;
      -	if (git_config_from_parameters(fn, data) < 0)
     -+	if (!opts->ignore_cmdline &&
     -+	    git_config_from_parameters(fn, data) < 0)
     ++	if (!opts->ignore_cmdline && git_config_from_parameters(fn, data) < 0)
       		die(_("unable to parse command-line config"));
       
       	current_parsing_scope = CONFIG_SCOPE_UNKNOWN;
     @@ -50,7 +48,7 @@
      + */
      +void read_very_early_config(config_fn_t cb, void *data)
      +{
     -+	struct config_options opts = {0};
     ++	struct config_options opts = { 0 };
      +
      +	opts.respect_includes = 1;
      +	opts.ignore_repo = 1;
  6:  c085a482dd !  6:  550cad6189 trace2: use system/global config for default trace2 settings
     @@ -41,16 +41,17 @@
       --- a/t/t0210-trace2-normal.sh
       +++ b/t/t0210-trace2-normal.sh
      @@
     - #!/bin/sh
     - 
     -+# Turn off any inherited trace2 settings for this test.
     -+unset GIT_TR2 GIT_TR2_PERF GIT_TR2_EVENT
     -+unset GIT_TR2_BRIEF
     -+unset GIT_TR2_CONFIG_PARAMS
     -+
       test_description='test trace2 facility (normal target)'
       . ./test-lib.sh
       
     ++# Turn off any inherited trace2 settings for this test.
     ++sane_unset GIT_TR2 GIT_TR2_PERF GIT_TR2_EVENT
     ++sane_unset GIT_TR2_BRIEF
     ++sane_unset GIT_TR2_CONFIG_PARAMS
     ++
     + # Add t/helper directory to PATH so that we can use a relative
     + # path to run nested instances of test-tool.exe (see 004child).
     + # This helps with HEREDOC comparisons later.
      @@
       # Warning: So you may see extra lines in artifact files when
       # Warning: interactively debugging.
     @@ -67,7 +68,7 @@
       	test_cmp expect actual
       '
       
     -+unset GIT_TR2_BRIEF
     ++sane_unset GIT_TR2_BRIEF
      +
      +# Now test without environment variables and get all Trace2 settings
      +# from the global config.
     @@ -112,16 +113,17 @@
       --- a/t/t0211-trace2-perf.sh
       +++ b/t/t0211-trace2-perf.sh
      @@
     - #!/bin/sh
     - 
     -+# Turn off any inherited trace2 settings for this test.
     -+unset GIT_TR2 GIT_TR2_PERF GIT_TR2_EVENT
     -+unset GIT_TR2_PERF_BRIEF
     -+unset GIT_TR2_CONFIG_PARAMS
     -+
       test_description='test trace2 facility (perf target)'
       . ./test-lib.sh
       
     ++# Turn off any inherited trace2 settings for this test.
     ++sane_unset GIT_TR2 GIT_TR2_PERF GIT_TR2_EVENT
     ++sane_unset GIT_TR2_PERF_BRIEF
     ++sane_unset GIT_TR2_CONFIG_PARAMS
     ++
     + # Add t/helper directory to PATH so that we can use a relative
     + # path to run nested instances of test-tool.exe (see 004child).
     + # This helps with HEREDOC comparisons later.
      @@
       # Warning: So you may see extra lines in artifact files when
       # Warning: interactively debugging.
     @@ -138,7 +140,7 @@
       	test_cmp expect actual
       '
       
     -+unset GIT_TR2_PERF_BRIEF
     ++sane_unset GIT_TR2_PERF_BRIEF
      +
      +# Now test without environment variables and get all Trace2 settings
      +# from the global config.
     @@ -165,16 +167,17 @@
       --- a/t/t0212-trace2-event.sh
       +++ b/t/t0212-trace2-event.sh
      @@
     - #!/bin/sh
     + test_description='test trace2 facility'
     + . ./test-lib.sh
       
      +# Turn off any inherited trace2 settings for this test.
     -+unset GIT_TR2 GIT_TR2_PERF GIT_TR2_EVENT
     -+unset GIT_TR2_BARE
     -+unset GIT_TR2_CONFIG_PARAMS
     ++sane_unset GIT_TR2 GIT_TR2_PERF GIT_TR2_EVENT
     ++sane_unset GIT_TR2_BARE
     ++sane_unset GIT_TR2_CONFIG_PARAMS
      +
     - test_description='test trace2 facility'
     - . ./test-lib.sh
     + perl -MJSON::PP -e 0 >/dev/null 2>&1 && test_set_prereq JSON_PP
       
     + # Add t/helper directory to PATH so that we can use a relative
      @@
       # Warning: So you may see extra lines in artifact files when
       # Warning: interactively debugging.
     @@ -353,7 +356,8 @@
       		if (tr2_dst_want_warning())
       			warning("trace2: invalid AF_UNIX value '%s' for '%s' tracing",
      -				tgt_value, dst->env_var_name);
     -+				tgt_value, tr2_sysenv_display_name(dst->sysenv_var));
     ++				tgt_value,
     ++				tr2_sysenv_display_name(dst->sysenv_var));
       
       		tr2_dst_trace_disable(dst);
       		return 0;
     @@ -371,7 +375,8 @@
       	if (tr2_dst_want_warning())
       		warning("trace2: could not connect to socket '%s' for '%s' tracing: %s",
      -			path, dst->env_var_name, strerror(e));
     -+			path, tr2_sysenv_display_name(dst->sysenv_var), strerror(e));
     ++			path, tr2_sysenv_display_name(dst->sysenv_var),
     ++			strerror(e));
       
       	tr2_dst_trace_disable(dst);
       	return 0;
  7:  2a7a933875 !  7:  56d8ce3fd6 trace2: report peak memory usage of the process
     @@ -40,8 +40,8 @@
      + */
      +static void get_peak_memory_info(void)
      +{
     -+	DECLARE_PROC_ADDR(psapi.dll, BOOL, GetProcessMemoryInfo,
     -+			  HANDLE, PPROCESS_MEMORY_COUNTERS, DWORD);
     ++	DECLARE_PROC_ADDR(psapi.dll, BOOL, GetProcessMemoryInfo, HANDLE,
     ++			  PPROCESS_MEMORY_COUNTERS, DWORD);
      +
      +	if (INIT_PROC_ADDR(GetProcessMemoryInfo)) {
      +		PROCESS_MEMORY_COUNTERS pmc;
  8:  56f357dc7b =  8:  196a9d2c85 trace2: clarify UTC datetime formatting
  9:  156ffde489 !  9:  9fdcb50140 trace2: make SIDs more unique
     @@ -63,7 +63,7 @@
      + * Compute the final component of the SID representing the current process.
      + * This should uniquely identify the process and be a valid filename (to
      + * allow writing trace2 data to per-process files).  It should also be fixed
     -+ * possible length for use as a database key.
     ++ * length for possible use as a database key.
      + *
      + * "<yyyymmdd>T<hhmmss>.<fraction>Z-<host>-<process>"
      + *
     @@ -71,17 +71,19 @@
      + *    "H<first_8_chars_of_sha1_of_hostname>"
      + *    "Localhost" when no hostname.
      + *
     -+ * where <process> is a possibly wrapped PID:
     -+ *    "P<6-digit-pid>"
     -+ *    "W<wrapped-6-digit-pid>" when PID too big.
     -+ *    
     ++ * where <process> is a 9 character string containing the least signifcant
     ++ * 32 bits in the process-id.
     ++ *    "P<pid>"
     ++ * (This is an abribrary choice.  On most systems pid_t is a 32 bit value,
     ++ * so limit doesn't matter.  On larger systems, a truncated value is fine
     ++ * for our purposes here.)
      + */
      +static void tr2_sid_append_my_sid_component(void)
      +{
      +	const struct git_hash_algo *algo = &hash_algos[GIT_HASH_SHA1];
      +	struct tr2_tbuf tb_now;
      +	git_hash_ctx ctx;
     -+	uintmax_t pid = getpid();
     ++	pid_t pid = getpid();
      +	unsigned char hash[GIT_MAX_RAWSZ + 1];
      +	char hex[GIT_MAX_HEXSZ + 1];
      +	char hostname[HOST_NAME_MAX + 1];
     @@ -101,11 +103,7 @@
      +		strbuf_add(&tr2sid_buf, hex, 8);
      +	}
      +
     -+	strbuf_addch(&tr2sid_buf, '-');
     -+	if (pid > 999999)
     -+		strbuf_addf(&tr2sid_buf, "W%06d", (int)(pid % 1000000));
     -+	else
     -+		strbuf_addf(&tr2sid_buf, "P%06d", (int)pid);
     ++	strbuf_addf(&tr2sid_buf, "-P%08"PRIx32, (uint32_t)pid);
      +}
      +
       /*
     @@ -149,10 +147,9 @@
      +	secs = tv.tv_sec;
      +	gmtime_r(&secs, &tm);
      +
     -+	xsnprintf(tb->buf, sizeof(tb->buf),
     -+		  "%4d%02d%02dT%02d%02d%02d.%06ldZ", tm.tm_year + 1900,
     -+		  tm.tm_mon + 1, tm.tm_mday, tm.tm_hour, tm.tm_min, tm.tm_sec,
     -+		  (long)tv.tv_usec);
     ++	xsnprintf(tb->buf, sizeof(tb->buf), "%4d%02d%02dT%02d%02d%02d.%06ldZ",
     ++		  tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday, tm.tm_hour,
     ++		  tm.tm_min, tm.tm_sec, (long)tv.tv_usec);
      +}
      
       diff --git a/trace2/tr2_tbuf.h b/trace2/tr2_tbuf.h
 10:  285beb2b2d ! 10:  3414016d04 trace2: update docs to describe system/global config settings
     @@ -188,53 +188,59 @@
       git version 2.20.1.155.g426c96fcdb
       ------------
      -+
     -+
     -+or
     -+
     -+------------
     -+$ git config --global trace2.eventTarget ~/log.event
     -+$ git version
     -+git version 2.20.1.155.g426c96fcdb
     -+------------
     -+
     -+yields
     -+
     - ------------
     - $ cat ~/log.event
     - {"event":"version","sid":"sid":"20190408T191610.507018Z-H9b68c35f-P028492","thread":"main","time":"2019-01-16T17:28:42.620713Z","file":"common-main.c","line":38,"evt":"1","exe":"2.20.1.155.g426c96fcdb"}
     -@@
     - {"event":"atexit","sid":"20190408T191610.507018Z-H9b68c35f-P028492","thread":"main","time":"2019-01-16T17:28:42.621268Z","file":"trace2/tr2_tgt_event.c","line":163,"t_abs":0.001265,"code":0}
     - ------------
     - 
     +-------------
     +-$ cat ~/log.event
     +-{"event":"version","sid":"sid":"20190408T191610.507018Z-H9b68c35f-P028492","thread":"main","time":"2019-01-16T17:28:42.620713Z","file":"common-main.c","line":38,"evt":"1","exe":"2.20.1.155.g426c96fcdb"}
     +-{"event":"start","sid":"20190408T191610.507018Z-H9b68c35f-P028492","thread":"main","time":"2019-01-16T17:28:42.621027Z","file":"common-main.c","line":39,"t_abs":0.001173,"argv":["git","version"]}
     +-{"event":"cmd_name","sid":"20190408T191610.507018Z-H9b68c35f-P028492","thread":"main","time":"2019-01-16T17:28:42.621122Z","file":"git.c","line":432,"name":"version","hierarchy":"version"}
     +-{"event":"exit","sid":"20190408T191610.507018Z-H9b68c35f-P028492","thread":"main","time":"2019-01-16T17:28:42.621236Z","file":"git.c","line":662,"t_abs":0.001227,"code":0}
     +-{"event":"atexit","sid":"20190408T191610.507018Z-H9b68c35f-P028492","thread":"main","time":"2019-01-16T17:28:42.621268Z","file":"trace2/tr2_tgt_event.c","line":163,"t_abs":0.001265,"code":0}
     +-------------
     +-
      -== Enabling a Target
      -
      -A Trace2 Target is enabled when the corresponding environment variable
      -(`GIT_TR2`, `GIT_TR2_PERF`, or `GIT_TR2_EVENT`) is set.  The following
      -values are recognized.
     -+=== Enabling a Target
     - 
     +-
      -`0`::
      -`false`::
     -+To enable a target, set the corresponding environment variable or
     -+system or global config value to one of the following:
     - 
     --	Disables the target.
      -
     +-	Disables the target.
     + 
      -`1`::
      -`true`::
     --
     ++or
     + 
      -	Enables the target and writes stream to `STDERR`.
      -
      -`[2-9]`::
     --
     ++------------
     ++$ git config --global trace2.eventTarget ~/log.event
     ++$ git version
     ++git version 2.20.1.155.g426c96fcdb
     ++------------
     + 
      -	Enables the target and writes to the already opened file descriptor.
     --
     ++yields
     + 
      -`<absolute-pathname>`::
     --
     ++------------
     ++$ cat ~/log.event
     ++{"event":"version","sid":"sid":"20190408T191610.507018Z-H9b68c35f-P000059a8","thread":"main","time":"2019-01-16T17:28:42.620713Z","file":"common-main.c","line":38,"evt":"1","exe":"2.20.1.155.g426c96fcdb"}
     ++{"event":"start","sid":"20190408T191610.507018Z-H9b68c35f-P000059a8","thread":"main","time":"2019-01-16T17:28:42.621027Z","file":"common-main.c","line":39,"t_abs":0.001173,"argv":["git","version"]}
     ++{"event":"cmd_name","sid":"20190408T191610.507018Z-H9b68c35f-P000059a8","thread":"main","time":"2019-01-16T17:28:42.621122Z","file":"git.c","line":432,"name":"version","hierarchy":"version"}
     ++{"event":"exit","sid":"20190408T191610.507018Z-H9b68c35f-P000059a8","thread":"main","time":"2019-01-16T17:28:42.621236Z","file":"git.c","line":662,"t_abs":0.001227,"code":0}
     ++{"event":"atexit","sid":"20190408T191610.507018Z-H9b68c35f-P000059a8","thread":"main","time":"2019-01-16T17:28:42.621268Z","file":"trace2/tr2_tgt_event.c","line":163,"t_abs":0.001265,"code":0}
     ++------------
     + 
      -	Enables the target, opens and writes to the file in append mode.
     --
     ++=== Enabling a Target
     + 
      -`af_unix:[<socket_type>:]<absolute-pathname>`::
     --
     ++To enable a target, set the corresponding environment variable or
     ++system or global config value to one of the following:
     + 
      -	Enables the target, opens and writes to a Unix Domain Socket
      -	(on platforms that support them).
      -+
     @@ -316,6 +322,15 @@
       Each event is a JSON-object containing multiple key/value pairs
       written as a single line and followed by a LF.
       
     +@@
     + ------------
     + {
     + 	"event":"version",
     +-	"sid":"20190408T191827.272759Z-H9b68c35f-P011764",
     ++	"sid":"20190408T191827.272759Z-H9b68c35f-P00003510",
     + 	"thread":"main",
     + 	"time":"2019-04-08T19:18:27.282761Z",
     + 	"file":"common-main.c",
      @@
       `"repo":<repo-id>`::
       	when present, is the integer repo-id as described previously.

-- 
gitgitgadget
