Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF3451F453
	for <e@80x24.org>; Mon, 28 Jan 2019 21:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfA1Vrp (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 16:47:45 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:39865 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfA1Vro (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 16:47:44 -0500
Received: by mail-ed1-f42.google.com with SMTP id b14so14346992edt.6
        for <git@vger.kernel.org>; Mon, 28 Jan 2019 13:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2Ioufx6Rge6oMnaVIhgoCRI+ZeOmqSp7VFBxlikhKPE=;
        b=vY4MEe7H/GE2RyShh80Kwnul80W8lbO7JFRgwIzNSHks0NdDAyRg8JSAZMYOhDUyue
         fny0//KEVuAmLDw+q97mKaS5MzlQPScUE8SlXURUxCjUG7vkHR4ThpGjsDwuO1J6CQdd
         u9CohqButudAO59QMLyU2tAfs8tAtT4sb9i04Xpu93/+9f1XDXs6TnozhspKmxHUpoiN
         dfsw5W5llSKDHmeq5Gl+gDAIG8tVDQyXIdlNgcifurGePElGOh+lp7DkjpYMxs19mlIE
         +A/CW0vptlq64sPPUIQDFVnZLE3dKJ12+ozqBpO6FXjdCBszsgB7S0aS8N5nJ9bXFXjr
         yWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2Ioufx6Rge6oMnaVIhgoCRI+ZeOmqSp7VFBxlikhKPE=;
        b=cPzNKaOzmrcGn3DfpSNXBnVcrV7TEXwtZUrEG/pZVBru9+RxWxSIEiL+0szj+fVwN3
         LtkeXEAt0ormW5M8vu293+CyoAi6eaB987scJOofgVlTMI/jtJDvkncLV3WwKY1gk9BC
         3XeGuniE6VORQPjsHq8DgtOXa0YjjpwvihLqeopLlZa4MA9tyTrIh13cn65Q99slV8os
         WaMfaXjTQXnMDOkYAwizwy5YtKWoNgL9BJJSKAsVGVo8rmP02tdp5OJ7D6lstYNtwhDF
         Pb9W9C4EkLcYAfCtDP23jW7iSdLjcAR68yKIQ1ZSjxX598DDzxQcqTQS42llfF8vvfJo
         SuAg==
X-Gm-Message-State: AJcUukf8HfhqOGyfyckZ7xTzWY+Vf5ONS++cDpto5MXvFnzIvbQ2694H
        UK8XgOyiZQagGGnjuVUyKA7t33/a
X-Google-Smtp-Source: ALg8bN77NqNExjO7QDACDfaOXf9V7W2W4bwRQ5q8TlLTE3JvVOcsnDZ8GujcS8aTIK1vRXPtyIjTEg==
X-Received: by 2002:a50:b32f:: with SMTP id q44mr23292409edd.70.1548712061307;
        Mon, 28 Jan 2019 13:47:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i46sm13811938ede.62.2019.01.28.13.47.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 13:47:40 -0800 (PST)
Date:   Mon, 28 Jan 2019 13:47:40 -0800 (PST)
X-Google-Original-Date: Mon, 28 Jan 2019 21:47:25 GMT
Message-Id: <pull.108.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.git.gitgitgadget@gmail.com>
References: <pull.108.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 00/14] Trace2 tracing facility
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

 Documentation/technical/api-trace2.txt | 1158 ++++++++++++++++++++++++
 Makefile                               |   11 +
 builtin/am.c                           |    1 +
 builtin/checkout.c                     |    7 +
 builtin/pack-objects.c                 |   12 +-
 builtin/rebase.c                       |   19 +
 builtin/receive-pack.c                 |    4 +
 builtin/reset.c                        |    6 +
 builtin/submodule--helper.c            |   11 +-
 builtin/worktree.c                     |    1 +
 cache.h                                |    1 +
 common-main.c                          |   13 +-
 compat/mingw.c                         |   11 +-
 compat/mingw.h                         |    3 +-
 compat/win32/ancestry.c                |  102 +++
 config.c                               |    2 +
 config.mak.uname                       |    2 +
 connect.c                              |    3 +
 editor.c                               |    1 +
 exec-cmd.c                             |    2 +
 git-compat-util.h                      |    7 +
 git.c                                  |   65 ++
 pager.c                                |    1 +
 read-cache.c                           |   47 +-
 remote-curl.c                          |    7 +
 repository.c                           |    2 +
 repository.h                           |    3 +
 run-command.c                          |   63 +-
 run-command.h                          |   17 +-
 sequencer.c                            |    2 +
 sh-i18n--envsubst.c                    |    3 +
 sub-process.c                          |    1 +
 submodule.c                            |   11 +-
 t/helper/test-parse-options.c          |    3 +
 t/helper/test-tool.c                   |    4 +
 t/helper/test-tool.h                   |    1 +
 t/helper/test-trace2.c                 |  273 ++++++
 t/t0001-init.sh                        |    1 +
 t/t0210-trace2-normal.sh               |  147 +++
 t/t0210/scrub_normal.perl              |   48 +
 t/t0211-trace2-perf.sh                 |  163 ++++
 t/t0211/scrub_perf.perl                |   76 ++
 t/t0212-trace2-event.sh                |  246 +++++
 t/t0212/parse_events.perl              |  251 +++++
 trace2.c                               |  809 +++++++++++++++++
 trace2.h                               |  403 +++++++++
 trace2/tr2_cfg.c                       |   92 ++
 trace2/tr2_cfg.h                       |   19 +
 trace2/tr2_dst.c                       |   90 ++
 trace2/tr2_dst.h                       |   34 +
 trace2/tr2_sid.c                       |   67 ++
 trace2/tr2_sid.h                       |   18 +
 trace2/tr2_tbuf.c                      |   32 +
 trace2/tr2_tbuf.h                      |   23 +
 trace2/tr2_tgt.h                       |  126 +++
 trace2/tr2_tgt_event.c                 |  606 +++++++++++++
 trace2/tr2_tgt_normal.c                |  331 +++++++
 trace2/tr2_tgt_perf.c                  |  573 ++++++++++++
 trace2/tr2_tls.c                       |  164 ++++
 trace2/tr2_tls.h                       |   95 ++
 trace2/tr2_verb.c                      |   30 +
 trace2/tr2_verb.h                      |   24 +
 transport-helper.c                     |    2 +
 transport.c                            |    1 +
 usage.c                                |   31 +
 wt-status.c                            |   23 +-
 66 files changed, 6384 insertions(+), 21 deletions(-)
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


base-commit: 77556354bb7ac50450e3b28999e3576969869068
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-108%2Fjeffhostetler%2Fcore-trace2-2019-v0-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-108/jeffhostetler/core-trace2-2019-v0-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/108

Range-diff vs v1:

  1:  1a90de9dab =  1:  1a90de9dab trace2: Documentation/technical/api-trace2.txt
  2:  4aaf4834bf !  2:  ea39b76d31 trace2: create new combined trace facility
     @@ -3527,7 +3527,7 @@
      +	if (ctx->nr_open_regions > 0) {
      +		int len_indent = TR2_INDENT_LENGTH(ctx);
      +		while (len_indent > dots.len) {
     -+			strbuf_addf(buf, "%s", dots.buf);
     ++			strbuf_addbuf(buf, &dots);
      +			len_indent -= dots.len;
      +		}
      +		strbuf_addf(buf, "%.*s", len_indent, dots.buf);
     @@ -3559,7 +3559,7 @@
      +	const char *event_name = "version";
      +	struct strbuf buf_payload = STRBUF_INIT;
      +
     -+	strbuf_addf(&buf_payload, "%s", git_version_string);
     ++	strbuf_addstr(&buf_payload, git_version_string);
      +
      +	perf_io_write_fl(file, line, event_name, NULL,
      +			 NULL, NULL, NULL,
  3:  5baee8295e =  3:  5ac061e14a trace2: collect platform-specific process information
  4:  978b9ebf0d =  4:  f9d689a54b trace2:data: add trace2 regions to wt-status
  5:  3941647097 =  5:  6be101d520 trace2:data: add editor/pager child classification
  6:  a20cf139ee =  6:  b590f19100 trace2:data: add trace2 sub-process classification
  7:  49b6b9bd24 =  7:  68192b8dfb trace2:data: add trace2 transport child classification
  8:  0f8f366bbe =  8:  b373ab640b trace2:data: add trace2 hook classification
  9:  705c2ece6d =  9:  548ea52742 trace2:data: add trace2 instrumentation to index read/write
 10:  1aa79cb126 = 10:  3458917811 pack-objects: add trace2 regions
 11:  8446f69b57 = 11:  86feec03e2 trace2:data: add subverb to checkout command
 12:  7eea9027f9 = 12:  9abbdf9ccd trace2:data: add subverb to reset command
 13:  618e5ccb0b = 13:  06ccce9632 trace2:data: add subverb for rebase
 14:  33a1ca7222 ! 14:  851aa8f34d trace2: t/helper/test-trace2, t0210.sh, t0211.sh, t0212.sh
     @@ -356,9 +356,11 @@
      +# Trace2 events will/can be written to each active target (subject
      +# to whatever filtering that target decides to do).
      +# This script tests the normal target in isolation.
     ++#
     ++# Defer setting GIT_TR2 until the actual command line we want to test
     ++# because hidden git and test-tool commands run by the test harness
     ++# can contaminate our output.
      +
     -+# Enable "normal" trace2 target.
     -+GIT_TR2="$(pwd)/trace.normal" && export GIT_TR2
      +# Enable "brief" feature which turns off "<clock> <file>:<line> " prefix.
      +GIT_TR2_BRIEF=1 && export GIT_TR2_BRIEF
      +
     @@ -382,7 +384,9 @@
      +
      +test_expect_success 'normal stream, return code 0' '
      +	test_when_finished "rm trace.normal actual expect" &&
     ++	GIT_TR2="$(pwd)/trace.normal" && export GIT_TR2 &&
      +	$TT trace2 001return 0 &&
     ++	unset GIT_TR2 &&
      +	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
      +	cat >expect <<-EOF &&
      +		version $V
     @@ -396,7 +400,9 @@
      +
      +test_expect_success 'normal stream, return code 1' '
      +	test_when_finished "rm trace.normal actual expect" &&
     ++	GIT_TR2="$(pwd)/trace.normal" && export GIT_TR2 &&
      +	test_must_fail $TT trace2 001return 1 &&
     ++	unset GIT_TR2 &&
      +	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
      +	cat >expect <<-EOF &&
      +		version $V
     @@ -414,7 +420,9 @@
      +
      +test_expect_success 'normal stream, exit code 0' '
      +	test_when_finished "rm trace.normal actual expect" &&
     ++	GIT_TR2="$(pwd)/trace.normal" && export GIT_TR2 &&
      +	$TT trace2 002exit 0 &&
     ++	unset GIT_TR2 &&
      +	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
      +	cat >expect <<-EOF &&
      +		version $V
     @@ -428,7 +436,9 @@
      +
      +test_expect_success 'normal stream, exit code 1' '
      +	test_when_finished "rm trace.normal actual expect" &&
     ++	GIT_TR2="$(pwd)/trace.normal" && export GIT_TR2 &&
      +	test_must_fail $TT trace2 002exit 1 &&
     ++	unset GIT_TR2 &&
      +	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
      +	cat >expect <<-EOF &&
      +		version $V
     @@ -446,7 +456,9 @@
      +
      +test_expect_success 'normal stream, error event' '
      +	test_when_finished "rm trace.normal actual expect" &&
     ++	GIT_TR2="$(pwd)/trace.normal" && export GIT_TR2 &&
      +	$TT trace2 003error "hello world" "this is a test" &&
     ++	unset GIT_TR2 &&
      +	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
      +	cat >expect <<-EOF &&
      +		version $V
     @@ -551,9 +563,11 @@
      +# Trace2 events will/can be written to each active target (subject
      +# to whatever filtering that target decides to do).
      +# Test each target independently.
     ++#
     ++# Defer setting GIT_TR2_PERF until the actual command we want to
     ++# test because hidden git and test-tool commands in the test
     ++# harness can contaminate our output.
      +
     -+# Enable "perf" trace2 target.
     -+GIT_TR2_PERF="$(pwd)/trace.perf" && export GIT_TR2_PERF
      +# Enable "brief" feature which turns off the prefix:
      +#     "<clock> <file>:<line> | <nr_parents> | "
      +GIT_TR2_PERF_BRIEF=1 && export GIT_TR2_PERF_BRIEF
     @@ -569,7 +583,9 @@
      +
      +test_expect_success 'perf stream, return code 0' '
      +	test_when_finished "rm trace.perf actual expect" &&
     ++	GIT_TR2_PERF="$(pwd)/trace.perf" && export GIT_TR2_PERF &&
      +	$TT trace2 001return 0 &&
     ++	unset GIT_TR2_PERF &&
      +	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <trace.perf >actual &&
      +	cat >expect <<-EOF &&
      +		d0|main|version|||||$V
     @@ -583,7 +599,9 @@
      +
      +test_expect_success 'perf stream, return code 1' '
      +	test_when_finished "rm trace.perf actual expect" &&
     ++	GIT_TR2_PERF="$(pwd)/trace.perf" && export GIT_TR2_PERF &&
      +	test_must_fail $TT trace2 001return 1 &&
     ++	unset GIT_TR2_PERF &&
      +	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <trace.perf >actual &&
      +	cat >expect <<-EOF &&
      +		d0|main|version|||||$V
     @@ -601,7 +619,9 @@
      +
      +test_expect_success 'perf stream, error event' '
      +	test_when_finished "rm trace.perf actual expect" &&
     ++	GIT_TR2_PERF="$(pwd)/trace.perf" && export GIT_TR2_PERF &&
      +	$TT trace2 003error "hello world" "this is a test" &&
     ++	unset GIT_TR2_PERF &&
      +	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <trace.perf >actual &&
      +	cat >expect <<-EOF &&
      +		d0|main|version|||||$V
     @@ -647,7 +667,9 @@
      +
      +test_expect_success 'perf stream, child processes' '
      +	test_when_finished "rm trace.perf actual expect" &&
     ++	GIT_TR2_PERF="$(pwd)/trace.perf" && export GIT_TR2_PERF &&
      +	$TT trace2 004child $TT trace2 004child $TT trace2 001return 0 &&
     ++	unset GIT_TR2_PERF &&
      +	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <trace.perf >actual &&
      +	cat >expect <<-EOF &&
      +		d0|main|version|||||$V
     @@ -792,9 +814,10 @@
      +# Trace2 events will/can be written to each active target (subject
      +# to whatever filtering that target decides to do).
      +# Test each target independently.
     -+
     -+# Enable "event" trace2 target.
     -+GIT_TR2_EVENT="$(pwd)/trace.event" && export GIT_TR2_EVENT
     ++#
     ++# Defer setting GIT_TR2_PERF until the actual command we want to
     ++# test because hidden git and test-tool commands in the test
     ++# harness can contaminate our output.
      +
      +# We don't bother repeating the 001return and 002exit tests, since they
      +# have coverage in the normal and perf targets.
     @@ -805,7 +828,9 @@
      +
      +test_expect_success 'event stream, error event' '
      +	test_when_finished "rm trace.event actual expect" &&
     ++	GIT_TR2_EVENT="$(pwd)/trace.event" && export GIT_TR2_EVENT &&
      +	$TT trace2 003error "hello world" "this is a test" &&
     ++	unset GIT_TR2_EVENT &&
      +	perl "$TEST_DIRECTORY/t0212/parse_events.perl" <trace.event >actual &&
      +	sed -e "s/^|//" >expect <<-EOF &&
      +	|VAR1 = {
     @@ -842,7 +867,9 @@
      +
      +test_expect_success 'event stream, return code 0' '
      +#	test_when_finished "rm trace.event actual expect" &&
     ++	GIT_TR2_EVENT="$(pwd)/trace.event" && export GIT_TR2_EVENT &&
      +	$TT trace2 004child $TT trace2 004child $TT trace2 001return 0 &&
     ++	unset GIT_TR2_EVENT &&
      +	perl "$TEST_DIRECTORY/t0212/parse_events.perl" <trace.event >actual &&
      +	sed -e "s/^|//" >expect <<-EOF &&
      +	|VAR1 = {
     @@ -933,7 +960,9 @@
      +	git config --local t0212.def "hello world" &&
      +	# delete events generated by the above config commands
      +	rm trace.event &&
     ++	GIT_TR2_EVENT="$(pwd)/trace.event" && export GIT_TR2_EVENT &&
      +	GIT_TR2_CONFIG_PARAMS="t0212.*" $TT trace2 001return 0 &&
     ++	unset GIT_TR2_EVENT &&
      +	perl "$TEST_DIRECTORY/t0212/parse_events.perl" <trace.event >actual &&
      +	sed -e "s/^|//" >expect <<-EOF &&
      +	|VAR1 = {
     @@ -966,7 +995,9 @@
      +
      +test_expect_success 'basic trace2_data' '
      +	test_when_finished "rm trace.event actual expect" &&
     ++	GIT_TR2_EVENT="$(pwd)/trace.event" && export GIT_TR2_EVENT &&
      +	$TT trace2 006data test_category k1 v1 test_category k2 v2 &&
     ++	unset GIT_TR2_EVENT &&
      +	perl "$TEST_DIRECTORY/t0212/parse_events.perl" <trace.event >actual &&
      +	sed -e "s/^|//" >expect <<-EOF &&
      +	|VAR1 = {

-- 
gitgitgadget
