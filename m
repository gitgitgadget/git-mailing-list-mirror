Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F38EA20248
	for <e@80x24.org>; Fri, 29 Mar 2019 17:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbfC2RE1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 13:04:27 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:47085 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729814AbfC2RE1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 13:04:27 -0400
Received: by mail-ed1-f66.google.com with SMTP id d1so2607710edd.13
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 10:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=w5QL22cizJ35O2G/fdvKJaqe4QyvP8Al1D5vzFBDEfo=;
        b=bewc3XAe+Hhk+9CrSbM0tNlv5cxZzcMDFqO3gl+NSAc+zOZRMjnQJZhD+5UwHl5d0s
         yYEk+mL7Xqgv1kzr/hhlywrMLV6pcgOrYyuB6B6RmMgdwS2T7b0bOCcQosl4sPk6ru22
         T5ID6zhtGNldFJusQ/Fh5rSfiioWHF8X0MGT8KqrGD+vcGw0dJXaDmkJAIG8L5xY5gM7
         S5XjPLviHGs5HkzzKnslVemh2zf8XWIVo8Sy1TPSAbvJrOo2IvHr2JijQEXORTCxuh4d
         Qb5Js8aVkkWlcp2BkYkVXwDSGXeAEjdrJUl7xvbqGM+CkRyzrkK1AlfSjaOH6iubQQ6s
         kL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=w5QL22cizJ35O2G/fdvKJaqe4QyvP8Al1D5vzFBDEfo=;
        b=lMMHC7I3yfUH7YCFJ7bGJFqia2+EyFQGRBUlEB25f8qzFi14yqhPRyhCbxmuKufwlY
         5naQUcXnhE4OGNRXVoltbUFCpEVMoPmhmTcmcVUE8VR4SbMs8/4ucrMDo3NgsRWsh8sd
         rr/kZgh8+Xap1SHSTNgsiNVtqKwkZCKkYG2lUOlBsU2s8xO4oyqK51gQJPN0w+dzUaNt
         a6kerloHWwW3ccRvyO/gCoNnzWX1q8w93idGKcDRsOtScrhjyDhI44fftc/qczofNfsH
         te0NMKZNm0q7cVeT9TaFt5YyVAfc5KfQrTZ0KFwJZYuTdziWLtIb0zgZLG/jm3eNf/3j
         NKiw==
X-Gm-Message-State: APjAAAVdRY3EPrahQjtpGfwyetrMLAoNHANofWUsvyBYL4nXPfQkMGfU
        37Awurab+VeZVKxWHzw0yy+SOUh4
X-Google-Smtp-Source: APXvYqy0CaYM3kOjHkAeq9Jm5X0US3tczy+7i39iA1saGatTD6hPvJCLn3Nyh0UqngAEnnZZjKJp0g==
X-Received: by 2002:a50:a725:: with SMTP id h34mr23096752edc.201.1553879065029;
        Fri, 29 Mar 2019 10:04:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j14sm452352ejc.69.2019.03.29.10.04.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 10:04:24 -0700 (PDT)
Date:   Fri, 29 Mar 2019 10:04:24 -0700 (PDT)
X-Google-Original-Date: Fri, 29 Mar 2019 17:04:16 GMT
Message-Id: <pull.169.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.169.git.gitgitgadget@gmail.com>
References: <pull.169.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/7] trace2: load trace2 settings from system config
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

Here is version 2. It addresses most the V1 comments WRT the system config
changes.

It also addresses the format and uniqueness of the SID as discussed in [1].
The SID now containes: the UTC date/time, part of SHA1 of the hostname, and
the PID and is formatted to make it safe for filenames.

It also contains (a somewhat unrelated platform-specific) commit to report
total process memory usage at exit. This is helpful when looking for
problematic commands that might have scaling problems.

[1] 
https://public-inbox.org/git/51e88650-8667-df1f-13ef-4537f2e70346@jeffhostetler.com/T/#m6b4e6f2b0374d5ba88de8d0350ce6bf51b28d7da


----------------------------------------------------------------------------

Teach git to load default Trace2 settings from the system config (usually
"/etc/gitconfig"). The existing GIT_TR2_* environment variables can be used
to override the new system defaults. It also includes a little startup
refactoring.

Note: I found interactive testing of this feature to be awkward on some
platforms because of the use of prefix- or runtime-prefix-relative locations
for the system configuration. It was easy to accidentally use an officially
installed version of git to set a system config variable in the official
system config directory; and then when testing with the test version of git,
that value would not be seen because it was looking for the system config
file in a different directory.

Jeff Hostetler (7):
  trace2: refactor setting process starting time
  trace2: add absolute elapsed time to start event
  trace2: find exec-dir before trace2 initialization
  trace2: use system config for default trace2 settings
  trace2: report peak memory usage of the process
  trace2: clarify UTC datetime formatting
  trace2: make SIDs more unique

 Documentation/technical/api-trace2.txt   |  66 +++++++++---
 Makefile                                 |   1 +
 common-main.c                            |   8 +-
 compat/mingw.c                           |   2 +
 compat/win32/trace2_win32_process_info.c |  50 ++++++++-
 t/t0210-trace2-normal.sh                 |  41 +++++++-
 t/t0211-trace2-perf.sh                   |  53 ++++++++--
 t/t0212-trace2-event.sh                  |  52 ++++++++-
 trace2.c                                 |  21 +++-
 trace2.h                                 |  43 ++++++--
 trace2/tr2_cfg.c                         |   7 +-
 trace2/tr2_dst.c                         |  24 ++---
 trace2/tr2_dst.h                         |   3 +-
 trace2/tr2_sid.c                         |  39 ++++++-
 trace2/tr2_sysenv.c                      | 128 +++++++++++++++++++++++
 trace2/tr2_sysenv.h                      |  36 +++++++
 trace2/tr2_tbuf.c                        |  20 +++-
 trace2/tr2_tbuf.h                        |   5 +-
 trace2/tr2_tgt.h                         |   1 +
 trace2/tr2_tgt_event.c                   |  53 +++++-----
 trace2/tr2_tgt_normal.c                  |  19 ++--
 trace2/tr2_tgt_perf.c                    |  23 ++--
 trace2/tr2_tls.c                         |  38 ++++---
 trace2/tr2_tls.h                         |   8 +-
 24 files changed, 604 insertions(+), 137 deletions(-)
 create mode 100644 trace2/tr2_sysenv.c
 create mode 100644 trace2/tr2_sysenv.h


base-commit: 041f5ea1cf987a4068ef5f39ba0a09be85952064
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-169%2Fjeffhostetler%2Fcore-tr2-startup-and-sysenv-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-169/jeffhostetler/core-tr2-startup-and-sysenv-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/169

Range-diff vs v1:

 1:  7f1a347322 = 1:  7f1a347322 trace2: refactor setting process starting time
 2:  c15f783c26 = 2:  c15f783c26 trace2: add absolute elapsed time to start event
 3:  d4023acde7 = 3:  d4023acde7 trace2: find exec-dir before trace2 initialization
 4:  7e0d4e20fb ! 4:  d048f3ffb8 trace2: use system config for default trace2 settings
     @@ -332,11 +332,16 @@
        *
      - * The environment variable "GIT_TR2_CONFIG_PARAMS" can be set to a
      - * list of patterns considered important.  For example:
     -+ * Use the TR2_SYSENV_CFG_PARAM setting to register a list of patterns
     -+ * configured important.  For example:
     -  *
     -  *    GIT_TR2_CONFIG_PARAMS="core.*,remote.*.url"
     +- *
     +- *    GIT_TR2_CONFIG_PARAMS="core.*,remote.*.url"
     ++ * Use the TR2_SYSENV_CFG_PARAM setting to register a comma-separated
     ++ * list of patterns configured important.  For example:
     ++ *     git config --system trace2.configParams 'core.*,remote.*.url'
     ++ * or:
     ++ *     GIT_TR2_CONFIG_PARAMS=core.*,remote.*.url"
        *
     +  * Note: this routine does a read-only iteration on the config data
     +  * (using read_early_config()), so it must not be called until enough
      
       diff --git a/trace2/tr2_cfg.c b/trace2/tr2_cfg.c
       --- a/trace2/tr2_cfg.c
     @@ -527,6 +532,9 @@
      +{
      +	int k;
      +
     ++	if (!starts_with(key, "trace2."))
     ++		return 0;
     ++
      +	for (k = 0; k < ARRAY_SIZE(tr2_sysenv_settings); k++) {
      +		if (!strcmp(key, tr2_sysenv_settings[k].git_config_name)) {
      +			free(tr2_sysenv_settings[k].value);
     @@ -673,7 +681,8 @@
      + * region details in the event target.
        */
      -#define TR2_ENVVAR_EVENT_NESTING "GIT_TR2_EVENT_NESTING"
     - static int tr2env_event_nesting_wanted = 2;
     +-static int tr2env_event_nesting_wanted = 2;
     ++static int tr2env_event_max_nesting_levels = 2;
       
       /*
      - * Set this environment variable to true to omit the <time>, <file>, and
     @@ -681,12 +690,14 @@
        * <line> fields from most events.
        */
      -#define TR2_ENVVAR_EVENT_BRIEF "GIT_TR2_EVENT_BRIEF"
     - static int tr2env_event_brief;
     +-static int tr2env_event_brief;
     ++static int tr2env_event_be_brief;
       
       static int fn_init(void)
     -@@
     + {
       	int want = tr2_dst_trace_want(&tr2dst_event);
     - 	int want_nesting;
     +-	int want_nesting;
     ++	int max_nesting;
       	int want_brief;
      -	char *nesting;
      -	char *brief;
     @@ -697,15 +708,74 @@
       		return want;
       
      -	nesting = getenv(TR2_ENVVAR_EVENT_NESTING);
     +-	if (nesting && ((want_nesting = atoi(nesting)) > 0))
     +-		tr2env_event_nesting_wanted = want_nesting;
      +	nesting = tr2_sysenv_get(TR2_SYSENV_EVENT_NESTING);
     - 	if (nesting && ((want_nesting = atoi(nesting)) > 0))
     - 		tr2env_event_nesting_wanted = want_nesting;
     ++	if (nesting && *nesting && ((max_nesting = atoi(nesting)) > 0))
     ++		tr2env_event_max_nesting_levels = max_nesting;
       
      -	brief = getenv(TR2_ENVVAR_EVENT_BRIEF);
     +-	if (brief && ((want_brief = atoi(brief)) > 0))
     +-		tr2env_event_brief = want_brief;
      +	brief = tr2_sysenv_get(TR2_SYSENV_EVENT_BRIEF);
     - 	if (brief && ((want_brief = atoi(brief)) > 0))
     - 		tr2env_event_brief = want_brief;
     ++	if (brief && *brief &&
     ++	    ((want_brief = git_parse_maybe_bool(brief)) != -1))
     ++		tr2env_event_be_brief = want_brief;
       
     + 	return want;
     + }
     +@@
     + 	/*
     + 	 * In brief mode, only emit <time> on these 2 event types.
     + 	 */
     +-	if (!tr2env_event_brief || !strcmp(event_name, "version") ||
     ++	if (!tr2env_event_be_brief || !strcmp(event_name, "version") ||
     + 	    !strcmp(event_name, "atexit")) {
     + 		tr2_tbuf_utc_time(&tb_now);
     + 		jw_object_string(jw, "time", tb_now.buf);
     + 	}
     + 
     +-	if (!tr2env_event_brief && file && *file) {
     ++	if (!tr2env_event_be_brief && file && *file) {
     + 		jw_object_string(jw, "file", file);
     + 		jw_object_intmax(jw, "line", line);
     + 	}
     +@@
     + {
     + 	const char *event_name = "region_enter";
     + 	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
     +-	if (ctx->nr_open_regions <= tr2env_event_nesting_wanted) {
     ++	if (ctx->nr_open_regions <= tr2env_event_max_nesting_levels) {
     + 		struct json_writer jw = JSON_WRITER_INIT;
     + 
     + 		jw_object_begin(&jw, 0);
     +@@
     + {
     + 	const char *event_name = "region_leave";
     + 	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
     +-	if (ctx->nr_open_regions <= tr2env_event_nesting_wanted) {
     ++	if (ctx->nr_open_regions <= tr2env_event_max_nesting_levels) {
     + 		struct json_writer jw = JSON_WRITER_INIT;
     + 		double t_rel = (double)us_elapsed_region / 1000000.0;
     + 
     +@@
     + {
     + 	const char *event_name = "data";
     + 	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
     +-	if (ctx->nr_open_regions <= tr2env_event_nesting_wanted) {
     ++	if (ctx->nr_open_regions <= tr2env_event_max_nesting_levels) {
     + 		struct json_writer jw = JSON_WRITER_INIT;
     + 		double t_abs = (double)us_elapsed_absolute / 1000000.0;
     + 		double t_rel = (double)us_elapsed_region / 1000000.0;
     +@@
     + {
     + 	const char *event_name = "data_json";
     + 	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
     +-	if (ctx->nr_open_regions <= tr2env_event_nesting_wanted) {
     ++	if (ctx->nr_open_regions <= tr2env_event_max_nesting_levels) {
     + 		struct json_writer jw = JSON_WRITER_INIT;
     + 		double t_abs = (double)us_elapsed_absolute / 1000000.0;
     + 		double t_rel = (double)us_elapsed_region / 1000000.0;
      
       diff --git a/trace2/tr2_tgt_normal.c b/trace2/tr2_tgt_normal.c
       --- a/trace2/tr2_tgt_normal.c
     @@ -730,9 +800,11 @@
        * Unit tests may want to use this to help with testing.
        */
      -#define TR2_ENVVAR_NORMAL_BRIEF "GIT_TR2_BRIEF"
     - static int tr2env_normal_brief;
     +-static int tr2env_normal_brief;
     ++static int tr2env_normal_be_brief;
       
       #define TR2FMT_NORMAL_FL_WIDTH (50)
     + 
      @@
       {
       	int want = tr2_dst_trace_want(&tr2dst_normal);
     @@ -747,7 +819,20 @@
      +	brief = tr2_sysenv_get(TR2_SYSENV_NORMAL_BRIEF);
       	if (brief && *brief &&
       	    ((want_brief = git_parse_maybe_bool(brief)) != -1))
     - 		tr2env_normal_brief = want_brief;
     +-		tr2env_normal_brief = want_brief;
     ++		tr2env_normal_be_brief = want_brief;
     + 
     + 	return want;
     + }
     +@@
     + {
     + 	strbuf_setlen(buf, 0);
     + 
     +-	if (!tr2env_normal_brief) {
     ++	if (!tr2env_normal_be_brief) {
     + 		struct tr2_tbuf tb_now;
     + 
     + 		tr2_tbuf_local_time(&tb_now);
      
       diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
       --- a/trace2/tr2_tgt_perf.c
     @@ -772,9 +857,11 @@
        * Unit tests may want to use this to help with testing.
        */
      -#define TR2_ENVVAR_PERF_BRIEF "GIT_TR2_PERF_BRIEF"
     - static int tr2env_perf_brief;
     +-static int tr2env_perf_brief;
     ++static int tr2env_perf_be_brief;
       
       #define TR2FMT_PERF_FL_WIDTH (50)
     + #define TR2FMT_PERF_MAX_EVENT_NAME (12)
      @@
       {
       	int want = tr2_dst_trace_want(&tr2dst_perf);
     @@ -791,4 +878,17 @@
      +	brief = tr2_sysenv_get(TR2_SYSENV_PERF_BRIEF);
       	if (brief && *brief &&
       	    ((want_brief = git_parse_maybe_bool(brief)) != -1))
     - 		tr2env_perf_brief = want_brief;
     +-		tr2env_perf_brief = want_brief;
     ++		tr2env_perf_be_brief = want_brief;
     + 
     + 	return want;
     + }
     +@@
     + 
     + 	strbuf_setlen(buf, 0);
     + 
     +-	if (!tr2env_perf_brief) {
     ++	if (!tr2env_perf_be_brief) {
     + 		struct tr2_tbuf tb_now;
     + 
     + 		tr2_tbuf_local_time(&tb_now);
 -:  ---------- > 5:  86d8fe28cf trace2: report peak memory usage of the process
 -:  ---------- > 6:  ae11cc4186 trace2: clarify UTC datetime formatting
 -:  ---------- > 7:  4352952677 trace2: make SIDs more unique

-- 
gitgitgadget
