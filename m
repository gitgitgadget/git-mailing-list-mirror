Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B90FE20248
	for <e@80x24.org>; Thu, 11 Apr 2019 15:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfDKPSn (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 11:18:43 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40670 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfDKPSm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 11:18:42 -0400
Received: by mail-ed1-f67.google.com with SMTP id d46so757194eda.7
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 08:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SRA0hCAlHP36ug+ye60uLjgNcIkVRaso68LRElCdCXQ=;
        b=G8Ev9OFSJp1KSDqbsy5jR26yhzYsEzY4g4SWYl17gl7uy8/EY1zR0JPbX97fORnkDH
         sibmXrSVYBXTXtOSGasCoCIWDBB7Pt4bU6dW5eAf6Lk5Bc6PVAZexLQ0LBJl09zfopad
         CuZQutNNPmffWc+q5Uw8N/HmHFX3HN8fKewqmXQZwD8/lgfJlmcsmDHyW47ykefv/VG5
         4wHT1zESt55cjHEskfxdrm2LFH+Ui0PpbAUfGUmdidG1RqHtdPqDSSxQCi7sV666GkLZ
         hBwGKjXOaMHDipSc32PF/eqLyoyeK48RiKxf7eoTQajDcbtyGH4KDrG5L11V6dzuK3yB
         evAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SRA0hCAlHP36ug+ye60uLjgNcIkVRaso68LRElCdCXQ=;
        b=p0ywiFV8AuQCzecfCvJtZc1tY/TIsV/3NcCRfpdjhV/GaNBWieSI9gElDQI+c5KyvS
         sSke6XIwhC1RP8ksvTxbEssS/vvqAp+yVewyVa9y8/MUiulv7MnIK1Lc5qrpPw5R2mA6
         3cv2s1UMR038wcmLA89qgmZllCF7o1G5I4Lx9sPo894K0MXCk2oKpyR8mA5X5kDIkyle
         uXUl0Khv5H/KdOLs9tMUoT6fnNkJW0xk/MQ4UMdmBRniAy3edwQrm5qk9KMUmCWramIc
         JFTmWW0njPoVV8cWvqa8EjdrBfSyUR6W3pl8j8gTLUIyUesLZcfKIFG3aVRlNnSfFiTn
         aD4g==
X-Gm-Message-State: APjAAAVGvoHzxt9gyAXBGvP5zwEG5rAskhJfu54qjkhO4Srmwcx+7LDc
        yCBYVLDI9SpPEOHlB6+YzLcFxWtb
X-Google-Smtp-Source: APXvYqwgsqy6apxTa+js9l+Ggq//4K9e8CGb+Kb7+rP7/AUiCI6J06vEd2Pd8n+sR7RQ7VvYkxU4ZQ==
X-Received: by 2002:a17:906:69d6:: with SMTP id g22mr3233397ejs.124.1554995917979;
        Thu, 11 Apr 2019 08:18:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o25sm4632732ejc.87.2019.04.11.08.18.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 08:18:37 -0700 (PDT)
Date:   Thu, 11 Apr 2019 08:18:37 -0700 (PDT)
X-Google-Original-Date: Thu, 11 Apr 2019 15:18:26 GMT
Message-Id: <pull.169.v3.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.169.v2.git.gitgitgadget@gmail.com>
References: <pull.169.v2.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 00/10] trace2: load trace2 settings from system config
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

Here is version 3.
[] It incorporates Ævar's suggestions WRT the format and uniqueness of the
SID. [] It now reads both system and global config for trace2 settings and
handles includes as Jonathan suggested.

I added a read_very_early_config() function that is similar to 
read_early_config()but omits repo local, worktree, and -c command line
settings. This felt like a little bit of a hack, but it made the intent
clear. And it avoided asserting the various global variables were in a
certain known state before calling the read_early_config().

In doing so, I uncovered an uninitialized opts variable in
read_repo_config(). The first patch in this series addresses it in
isolation. As the commit message suggests, this went undetected because opts 
variable doesn't get passed all the way down, but I'm not familiar enough
with that code to know whether that's an accident or by design. Callers of 
config_with_options() all setopts.respect_includes and that changes the args
that config_with_options()passes to the functions that it calls. What makes
this a little more troubling is theopts.event_fn field added in
8032cc4462b8af268fe457c2a0431473334dfd18 that might not be initialized.
Again, I'm not familiar enough with this code and the actually observable
control flows thru it to know if that could cause an issue.

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
 config.c                                 |  27 +++-
 config.h                                 |   4 +
 t/t0210-trace2-normal.sh                 |  49 ++++++-
 t/t0211-trace2-perf.sh                   |  43 ++++--
 t/t0212-trace2-event.sh                  |  42 +++++-
 trace2.c                                 |  21 ++-
 trace2.h                                 |  43 ++++--
 trace2/tr2_cfg.c                         |   7 +-
 trace2/tr2_dst.c                         |  24 ++--
 trace2/tr2_dst.h                         |   3 +-
 trace2/tr2_sid.c                         |  55 ++++++-
 trace2/tr2_sysenv.c                      | 127 ++++++++++++++++
 trace2/tr2_sysenv.h                      |  36 +++++
 trace2/tr2_tbuf.c                        |  20 ++-
 trace2/tr2_tbuf.h                        |   5 +-
 trace2/tr2_tgt.h                         |   1 +
 trace2/tr2_tgt_event.c                   |  53 +++----
 trace2/tr2_tgt_normal.c                  |  19 +--
 trace2/tr2_tgt_perf.c                    |  23 +--
 trace2/tr2_tls.c                         |  38 +++--
 trace2/tr2_tls.h                         |   8 +-
 29 files changed, 750 insertions(+), 203 deletions(-)
 create mode 100644 Documentation/config/trace2.txt
 create mode 100644 Documentation/trace2-target-values.txt
 create mode 100644 trace2/tr2_sysenv.c
 create mode 100644 trace2/tr2_sysenv.h


base-commit: 041f5ea1cf987a4068ef5f39ba0a09be85952064
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-169%2Fjeffhostetler%2Fcore-tr2-startup-and-sysenv-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-169/jeffhostetler/core-tr2-startup-and-sysenv-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/169

Range-diff vs v2:

  -:  ---------- >  1:  ea8c199f91 config: initialize opts structure in repo_read_config()
  1:  7f1a347322 =  2:  3dbcfc6a8d trace2: refactor setting process starting time
  2:  c15f783c26 =  3:  8b00025af5 trace2: add absolute elapsed time to start event
  3:  d4023acde7 =  4:  c3c5f6a96b trace2: find exec-dir before trace2 initialization
  -:  ---------- >  5:  d15be7b63a config: add read_very_early_config()
  4:  d048f3ffb8 !  6:  c085a482dd trace2: use system config for default trace2 settings
     @@ -1,8 +1,8 @@
      Author: Jeff Hostetler <jeffhost@microsoft.com>
      
     -    trace2: use system config for default trace2 settings
     +    trace2: use system/global config for default trace2 settings
      
     -    Teach git to read the system config (usually "/etc/gitconfig") for
     +    Teach git to read the system and global config files for
          default Trace2 settings.  This allows system-wide Trace2 settings to
          be installed and inherited to make it easier to manage a collection of
          systems.
     @@ -10,10 +10,9 @@
          The original GIT_TR2* environment variables are loaded afterwards and
          can be used to override the system settings.
      
     -    Only the system config file is used.  Trace2 config values are ignored
     -    in local, global, and other config files.  Likewise, the "-c" command
     -    line arguments are ignored for Trace2 values.  These limits are for
     -    performance reasons.
     +    Only the system and global config files are used.  Repo and worktree
     +    local config files are ignored.  Likewise, the "-c" command line
     +    arguments are also ignored.  These limits are for performance reasons.
      
          (1) For users not using Trace2, there should be minimal overhead to
          detect that Trace2 is not enabled.  In particular, Trace2 should not
     @@ -24,54 +23,8 @@
          git process initialization (which involves discovering the .git directory
          and reading a hierarchy of config files).
      
     -    Added the GIT_TEST_TR2_SYSTEM_CONFIG environment variable for testing
     -    purposes to specify the pathname of a fake "system" config or disable
     -    use of the system config.
     -
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
     - diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
     - --- a/Documentation/technical/api-trace2.txt
     - +++ b/Documentation/technical/api-trace2.txt
     -@@
     - Socket type can be either `stream` or `dgram`.  If the socket type is
     - omitted, Git will try both.
     - 
     -+== Trace2 Settings in System Config
     -+
     -+Trace2 also reads configuration information from the system config.
     -+This is intended to help adminstrators to gather system-wide Git
     -+performance data.
     -+
     -+Trace2 only reads the system configuration, it does not read global,
     -+local, worktree, or `-c` config settings.
     -+
     -+Trace2 will try to load the following system configuration settings
     -+and then read the corresponding environment variables at startup.
     -+
     -+....
     -+---------------------------------------------------
     -+trace2.normalTarget          GIT_TR2
     -+trace2.normalBrief           GIT_TR2_BRIEF
     -+
     -+trace2.perfTarget            GIT_TR2_PERF
     -+trace2.perfBrief             GIT_TR2_PERF_BRIEF
     -+
     -+trace2.eventTarget           GIT_TR2_EVENT
     -+trace2.eventBrief            GIT_TR2_EVENT_BRIEF
     -+trace2.eventNesting          GIT_TR2_EVENT_NESTING
     -+
     -+trace2.configParams          GIT_TR2_CONFIG_PARAMS
     -+
     -+trace2.destinationDebug      GIT_TR2_DST_DEBUG
     -+---------------------------------------------------
     -+....
     -+
     -+
     - == Trace2 API
     - 
     - All public Trace2 functions and macros are defined in `trace2.h` and
     -
       diff --git a/Makefile b/Makefile
       --- a/Makefile
       +++ b/Makefile
     @@ -90,10 +43,6 @@
      @@
       #!/bin/sh
       
     -+# Disable loading of Trace2 settings from the system config
     -+# (usually "/etc/gitconfig") to eliminate system dependencies.
     -+GIT_TEST_TR2_SYSTEM_CONFIG=0 && export GIT_TEST_TR2_SYSTEM_CONFIG
     -+
      +# Turn off any inherited trace2 settings for this test.
      +unset GIT_TR2 GIT_TR2_PERF GIT_TR2_EVENT
      +unset GIT_TR2_BRIEF
     @@ -118,22 +67,34 @@
       	test_cmp expect actual
       '
       
     -+# Now test using system config by using a mocked up config file
     -+# rather than inheriting "/etc/gitconfig".  Here we do not use
     -+# GIT_TR2* environment variables.
     -+
      +unset GIT_TR2_BRIEF
      +
     -+MOCK=./mock_system_config
     ++# Now test without environment variables and get all Trace2 settings
     ++# from the global config.
      +
     -+test_expect_success 'setup mocked /etc/gitconfig' '
     -+	git config --file $MOCK trace2.normalTarget "$(pwd)/trace.normal" &&
     -+	git config --file $MOCK trace2.normalBrief 1
     ++test_expect_success 'using global config, normal stream, return code 0' '
     ++	test_when_finished "rm trace.normal actual expect" &&
     ++	test_config_global trace2.normalBrief 1 &&
     ++	test_config_global trace2.normalTarget "$(pwd)/trace.normal" &&
     ++	test-tool trace2 001return 0 &&
     ++	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
     ++	cat >expect <<-EOF &&
     ++		version $V
     ++		start _EXE_ trace2 001return 0
     ++		cmd_name trace2 (trace2)
     ++		exit elapsed:_TIME_ code:0
     ++		atexit elapsed:_TIME_ code:0
     ++	EOF
     ++	test_cmp expect actual
      +'
      +
     -+test_expect_success 'using mock, normal stream, return code 0' '
     -+	test_when_finished "rm trace.normal actual expect" &&
     -+	GIT_TEST_TR2_SYSTEM_CONFIG="$MOCK" test-tool trace2 001return 0 &&
     ++test_expect_success 'using global config with include' '
     ++	test_when_finished "rm trace.normal actual expect real.gitconfig" &&
     ++	test_config_global trace2.normalBrief 1 &&
     ++	test_config_global trace2.normalTarget "$(pwd)/trace.normal" &&
     ++	mv "$(pwd)/.gitconfig" "$(pwd)/real.gitconfig" &&
     ++	test_config_global include.path "$(pwd)/real.gitconfig" &&
     ++	test-tool trace2 001return 0 &&
      +	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
      +	cat >expect <<-EOF &&
      +		version $V
     @@ -153,10 +114,6 @@
      @@
       #!/bin/sh
       
     -+# Disable loading of Trace2 settings from the system config
     -+# (usually "/etc/gitconfig") to eliminate system dependencies.
     -+GIT_TEST_TR2_SYSTEM_CONFIG=0 && export GIT_TEST_TR2_SYSTEM_CONFIG
     -+
      +# Turn off any inherited trace2 settings for this test.
      +unset GIT_TR2 GIT_TR2_PERF GIT_TR2_EVENT
      +unset GIT_TR2_PERF_BRIEF
     @@ -181,22 +138,16 @@
       	test_cmp expect actual
       '
       
     -+# Now test using system config by using a mocked up config file
     -+# rather than inheriting "/etc/gitconfig".  Here we do not use
     -+# GIT_TR2* environment variables.
     -+
      +unset GIT_TR2_PERF_BRIEF
      +
     -+MOCK=./mock_system_config
     -+
     -+test_expect_success 'setup mocked /etc/gitconfig' '
     -+	git config --file $MOCK trace2.perfTarget "$(pwd)/trace.perf" &&
     -+	git config --file $MOCK trace2.perfBrief 1
     -+'
     ++# Now test without environment variables and get all Trace2 settings
     ++# from the global config.
      +
     -+test_expect_success 'using mock, perf stream, return code 0' '
     ++test_expect_success 'using global config, perf stream, return code 0' '
      +	test_when_finished "rm trace.perf actual expect" &&
     -+	GIT_TEST_TR2_SYSTEM_CONFIG="$MOCK" test-tool trace2 001return 0 &&
     ++	test_config_global trace2.perfBrief 1 &&
     ++	test_config_global trace2.perfTarget "$(pwd)/trace.perf" &&
     ++	test-tool trace2 001return 0 &&
      +	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <trace.perf >actual &&
      +	cat >expect <<-EOF &&
      +		d0|main|version|||||$V
     @@ -216,10 +167,6 @@
      @@
       #!/bin/sh
       
     -+# Disable loading of Trace2 settings from the system config
     -+# (usually "/etc/gitconfig") to eliminate system dependencies.
     -+GIT_TEST_TR2_SYSTEM_CONFIG=0 && export GIT_TEST_TR2_SYSTEM_CONFIG
     -+
      +# Turn off any inherited trace2 settings for this test.
      +unset GIT_TR2 GIT_TR2_PERF GIT_TR2_EVENT
      +unset GIT_TR2_BARE
     @@ -244,19 +191,13 @@
       	test_cmp expect actual
       '
       
     -+# Now test using system config by using a mocked up config file
     -+# rather than inheriting "/etc/gitconfig".  Here we do not use
     -+# GIT_TR2* environment variables.
     -+
     -+MOCK=./mock_system_config
     ++# Now test without environment variables and get all Trace2 settings
     ++# from the global config.
      +
     -+test_expect_success 'setup mocked /etc/gitconfig' '
     -+	git config --file $MOCK trace2.eventTarget "$(pwd)/trace.event"
     -+'
     -+
     -+test_expect_success JSON_PP 'using mock, event stream, error event' '
     ++test_expect_success JSON_PP 'using global config, event stream, error event' '
      +	test_when_finished "rm trace.event actual expect" &&
     -+	GIT_TEST_TR2_SYSTEM_CONFIG="$MOCK" test-tool trace2 003error "hello world" "this is a test" &&
     ++	test_config_global trace2.eventTarget "$(pwd)/trace.event" &&
     ++	test-tool trace2 003error "hello world" "this is a test" &&
      +	perl "$TEST_DIRECTORY/t0212/parse_events.perl" <trace.event >actual &&
      +	sed -e "s/^|//" >expect <<-EOF &&
      +	|VAR1 = {
     @@ -503,8 +444,9 @@
      +
      +/*
      + * This table must match "enum tr2_sysenv_variable" in tr2_sysenv.h.
     -+ * These strings are constant and must match the published names as
     -+ * described in the documentation.
     ++ *
     ++ * The strings in this table are constant and must match the published
     ++ * config and environment variable names as described in the documentation.
      + *
      + * We do not define entries for the GIT_TR2_PARENT_* environment
      + * variables because they are transient and used to pass information
     @@ -512,19 +454,28 @@
      + */
      +/* clang-format off */
      +static struct tr2_sysenv_entry tr2_sysenv_settings[] = {
     -+	{ "GIT_TR2_CONFIG_PARAMS",   "trace2.configparams"     },
     -+
     -+	{ "GIT_TR2_DST_DEBUG",       "trace2.destinationdebug" },
     -+
     -+	{ "GIT_TR2",                 "trace2.normaltarget"     },
     -+	{ "GIT_TR2_BRIEF",           "trace2.normalbrief"      },
     -+
     -+	{ "GIT_TR2_EVENT",           "trace2.eventtarget"      },
     -+	{ "GIT_TR2_EVENT_BRIEF",     "trace2.eventbrief"       },
     -+	{ "GIT_TR2_EVENT_NESTING",   "trace2.eventnesting"     },
     -+
     -+	{ "GIT_TR2_PERF",            "trace2.perftarget"       },
     -+	{ "GIT_TR2_PERF_BRIEF",      "trace2.perfbrief"        },
     ++	[TR2_SYSENV_CFG_PARAM]     = { "GIT_TR2_CONFIG_PARAMS",
     ++				       "trace2.configparams" },
     ++
     ++	[TR2_SYSENV_DST_DEBUG]     = { "GIT_TR2_DST_DEBUG",
     ++				       "trace2.destinationdebug" },
     ++
     ++	[TR2_SYSENV_NORMAL]        = { "GIT_TR2",
     ++				       "trace2.normaltarget" },
     ++	[TR2_SYSENV_NORMAL_BRIEF]  = { "GIT_TR2_BRIEF",
     ++				       "trace2.normalbrief" },
     ++
     ++	[TR2_SYSENV_EVENT]         = { "GIT_TR2_EVENT",
     ++				       "trace2.eventtarget" },
     ++	[TR2_SYSENV_EVENT_BRIEF]   = { "GIT_TR2_EVENT_BRIEF",
     ++				       "trace2.eventbrief" },
     ++	[TR2_SYSENV_EVENT_NESTING] = { "GIT_TR2_EVENT_NESTING",
     ++				       "trace2.eventnesting" },
     ++
     ++	[TR2_SYSENV_PERF]          = { "GIT_TR2_PERF",
     ++				       "trace2.perftarget" },
     ++	[TR2_SYSENV_PERF_BRIEF]    = { "GIT_TR2_PERF_BRIEF",
     ++				       "trace2.perfbrief" },
      +};
      +/* clang-format on */
      +
     @@ -550,31 +501,20 @@
      + * Load Trace2 settings from the system config (usually "/etc/gitconfig"
      + * unless we were built with a runtime-prefix).  These are intended to
      + * define the default values for Trace2 as requested by the administrator.
     ++ *
     ++ * Then override with the Trace2 settings from the global config.
      + */
      +void tr2_sysenv_load(void)
      +{
     -+	const char *system_config_pathname;
     -+	const char *test_pathname;
     -+
     -+	system_config_pathname = git_etc_gitconfig();
     -+
     -+	test_pathname = getenv("GIT_TEST_TR2_SYSTEM_CONFIG");
     -+	if (test_pathname) {
     -+		if (!*test_pathname || !strcmp(test_pathname, "0"))
     -+			return; /* disable use of system config */
     -+
     -+		/* mock it with given test file */
     -+		system_config_pathname = test_pathname;
     -+	}
     ++	if (ARRAY_SIZE(tr2_sysenv_settings) != TR2_SYSENV_MUST_BE_LAST)
     ++		BUG("tr2_sysenv_settings size is wrong");
      +
     -+	if (file_exists(system_config_pathname))
     -+		git_config_from_file(tr2_sysenv_cb, system_config_pathname,
     -+				     NULL);
     ++	read_very_early_config(tr2_sysenv_cb, NULL);
      +}
      +
      +/*
     -+ * Return the value for the requested setting.  Start with the /etc/gitconfig
     -+ * value and allow the corresponding environment variable to override it.
     ++ * Return the value for the requested Trace2 setting from these sources:
     ++ * the system config, the global config, and the environment.
      + */
      +const char *tr2_sysenv_get(enum tr2_sysenv_variable var)
      +{
  5:  86d8fe28cf =  7:  2a7a933875 trace2: report peak memory usage of the process
  6:  ae11cc4186 =  8:  56f357dc7b trace2: clarify UTC datetime formatting
  7:  4352952677 !  9:  156ffde489 trace2: make SIDs more unique
     @@ -22,11 +22,11 @@
      -{"event":"cmd_name","sid":"1547659722619736-11614","thread":"main","time":"2019-01-16T17:28:42.621122Z","file":"git.c","line":432,"name":"version","hierarchy":"version"}
      -{"event":"exit","sid":"1547659722619736-11614","thread":"main","time":"2019-01-16T17:28:42.621236Z","file":"git.c","line":662,"t_abs":0.001227,"code":0}
      -{"event":"atexit","sid":"1547659722619736-11614","thread":"main","time":"2019-01-16T17:28:42.621268Z","file":"trace2/tr2_tgt_event.c","line":163,"t_abs":0.001265,"code":0}
     -+{"event":"version","sid":"20190329-144314-319944-9b68c35f-012232","thread":"main","time":"2019-01-16T17:28:42.620713Z","file":"common-main.c","line":38,"evt":"1","exe":"2.20.1.155.g426c96fcdb"}
     -+{"event":"start","sid":"20190329-144314-319944-9b68c35f-012232","thread":"main","time":"2019-01-16T17:28:42.621027Z","file":"common-main.c","line":39,"t_abs":0.001173,"argv":["git","version"]}
     -+{"event":"cmd_name","sid":"20190329-144314-319944-9b68c35f-012232","thread":"main","time":"2019-01-16T17:28:42.621122Z","file":"git.c","line":432,"name":"version","hierarchy":"version"}
     -+{"event":"exit","sid":"20190329-144314-319944-9b68c35f-012232","thread":"main","time":"2019-01-16T17:28:42.621236Z","file":"git.c","line":662,"t_abs":0.001227,"code":0}
     -+{"event":"atexit","sid":"20190329-144314-319944-9b68c35f-012232","thread":"main","time":"2019-01-16T17:28:42.621268Z","file":"trace2/tr2_tgt_event.c","line":163,"t_abs":0.001265,"code":0}
     ++{"event":"version","sid":"sid":"20190408T191610.507018Z-H9b68c35f-P028492","thread":"main","time":"2019-01-16T17:28:42.620713Z","file":"common-main.c","line":38,"evt":"1","exe":"2.20.1.155.g426c96fcdb"}
     ++{"event":"start","sid":"20190408T191610.507018Z-H9b68c35f-P028492","thread":"main","time":"2019-01-16T17:28:42.621027Z","file":"common-main.c","line":39,"t_abs":0.001173,"argv":["git","version"]}
     ++{"event":"cmd_name","sid":"20190408T191610.507018Z-H9b68c35f-P028492","thread":"main","time":"2019-01-16T17:28:42.621122Z","file":"git.c","line":432,"name":"version","hierarchy":"version"}
     ++{"event":"exit","sid":"20190408T191610.507018Z-H9b68c35f-P028492","thread":"main","time":"2019-01-16T17:28:42.621236Z","file":"git.c","line":662,"t_abs":0.001227,"code":0}
     ++{"event":"atexit","sid":"20190408T191610.507018Z-H9b68c35f-P028492","thread":"main","time":"2019-01-16T17:28:42.621268Z","file":"trace2/tr2_tgt_event.c","line":163,"t_abs":0.001265,"code":0}
       ------------
       
       == Enabling a Target
     @@ -35,10 +35,16 @@
       {
       	"event":"version",
      -	"sid":"1547659722619736-11614",
     -+	"sid":"20190329-144314-319944-9b68c35f-012232",
     ++	"sid":"20190408T191827.272759Z-H9b68c35f-P011764",
       	"thread":"main",
     - 	"time":"2019-01-16T17:28:42.620713Z",
     +-	"time":"2019-01-16T17:28:42.620713Z",
     ++	"time":"2019-04-08T19:18:27.282761Z",
       	"file":"common-main.c",
     +-	"line":38,
     ++	"line":42,
     + 	...
     + }
     + ------------
      
       diff --git a/trace2/tr2_sid.c b/trace2/tr2_sid.c
       --- a/trace2/tr2_sid.c
     @@ -56,34 +62,50 @@
      +/*
      + * Compute the final component of the SID representing the current process.
      + * This should uniquely identify the process and be a valid filename (to
     -+ * allow writing trace2 data to per-process files).
     ++ * allow writing trace2 data to per-process files).  It should also be fixed
     ++ * possible length for use as a database key.
     ++ *
     ++ * "<yyyymmdd>T<hhmmss>.<fraction>Z-<host>-<process>"
     ++ *
     ++ * where <host> is a 9 character string:
     ++ *    "H<first_8_chars_of_sha1_of_hostname>"
     ++ *    "Localhost" when no hostname.
      + *
     -+ * <yyyymmdd> '-' <hhmmss> '-' <fraction> '-' <sha1-prefix> '-' <pid>
     ++ * where <process> is a possibly wrapped PID:
     ++ *    "P<6-digit-pid>"
     ++ *    "W<wrapped-6-digit-pid>" when PID too big.
     ++ *    
      + */
      +static void tr2_sid_append_my_sid_component(void)
      +{
      +	const struct git_hash_algo *algo = &hash_algos[GIT_HASH_SHA1];
      +	struct tr2_tbuf tb_now;
      +	git_hash_ctx ctx;
     ++	uintmax_t pid = getpid();
      +	unsigned char hash[GIT_MAX_RAWSZ + 1];
      +	char hex[GIT_MAX_HEXSZ + 1];
      +	char hostname[HOST_NAME_MAX + 1];
      +
     -+	tr2_tbuf_utc_datetime_for_filename(&tb_now);
     ++	tr2_tbuf_utc_datetime(&tb_now);
      +	strbuf_addstr(&tr2sid_buf, tb_now.buf);
     -+	strbuf_addch(&tr2sid_buf, '-');
      +
     ++	strbuf_addch(&tr2sid_buf, '-');
      +	if (xgethostname(hostname, sizeof(hostname)))
     -+		xsnprintf(hostname, sizeof(hostname), "localhost");
     -+
     -+	algo->init_fn(&ctx);
     -+	algo->update_fn(&ctx, hostname, strlen(hostname));
     -+	algo->final_fn(hash, &ctx);
     -+	hash_to_hex_algop_r(hex, hash, algo);
     -+	strbuf_add(&tr2sid_buf, hex, 8);
     ++		strbuf_add(&tr2sid_buf, "Localhost", 9);
     ++	else {
     ++		algo->init_fn(&ctx);
     ++		algo->update_fn(&ctx, hostname, strlen(hostname));
     ++		algo->final_fn(hash, &ctx);
     ++		hash_to_hex_algop_r(hex, hash, algo);
     ++		strbuf_addch(&tr2sid_buf, 'H');
     ++		strbuf_add(&tr2sid_buf, hex, 8);
     ++	}
      +
      +	strbuf_addch(&tr2sid_buf, '-');
     -+	strbuf_addf(&tr2sid_buf, "%06"PRIuMAX, (uintmax_t)getpid());
     ++	if (pid > 999999)
     ++		strbuf_addf(&tr2sid_buf, "W%06d", (int)(pid % 1000000));
     ++	else
     ++		strbuf_addf(&tr2sid_buf, "P%06d", (int)pid);
      +}
      +
       /*
     @@ -117,7 +139,7 @@
       		  (long)tv.tv_usec);
       }
      +
     -+void tr2_tbuf_utc_datetime_for_filename(struct tr2_tbuf *tb)
     ++void tr2_tbuf_utc_datetime(struct tr2_tbuf *tb)
      +{
      +	struct timeval tv;
      +	struct tm tm;
     @@ -128,7 +150,7 @@
      +	gmtime_r(&secs, &tm);
      +
      +	xsnprintf(tb->buf, sizeof(tb->buf),
     -+		  "%4d%02d%02d-%02d%02d%02d-%06ld", tm.tm_year + 1900,
     ++		  "%4d%02d%02dT%02d%02d%02d.%06ldZ", tm.tm_year + 1900,
      +		  tm.tm_mon + 1, tm.tm_mday, tm.tm_hour, tm.tm_min, tm.tm_sec,
      +		  (long)tv.tv_usec);
      +}
     @@ -140,6 +162,6 @@
        * Fill buffer with formatted UTC datatime string.
        */
       void tr2_tbuf_utc_datetime_extended(struct tr2_tbuf *tb);
     -+void tr2_tbuf_utc_datetime_for_filename(struct tr2_tbuf *tb);
     ++void tr2_tbuf_utc_datetime(struct tr2_tbuf *tb);
       
       #endif /* TR2_TBUF_H */
  -:  ---------- > 10:  285beb2b2d trace2: update docs to describe system/global config settings

-- 
gitgitgadget
