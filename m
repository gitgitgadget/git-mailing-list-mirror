Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037D2130AC2
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 15:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709824956; cv=none; b=gCaT8q0Bpbep28Kt3UaZn610GzjcPA/kcLsm64Fbh9nJ+p3eRT+O+p/w93Kqi5pACaMndD7z/b0mHYNBR5ayKJBsfOSjwqnWjw01ShgKvIFIJSmgCkS6yFp2zrvbV+BEIWaau9sha/w+1GigFeBQfnoAH+IMBtJ7ZpIf+KHPYNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709824956; c=relaxed/simple;
	bh=smkKSBjFfk9GhWeZEx4dPXGAWodL+yzJaQFC5xg7tRE=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ub7XmSHG83fZx1NKzWbSmyB7v0XCX4R9TBXxnz1dp764+e/ttrGdr19in3ohspljjJ6ZwM5JxFOwvOArNLTyK367azAigLgNHZa3WS2ONj8IcO7Vk7qpSkLVYuqP+s1hCv37N+S4oxVaaTEXI0ighUNuvbovgwJtJhUL++V7Sd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhDs02wQ; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhDs02wQ"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51341a5aafbso1095071e87.0
        for <git@vger.kernel.org>; Thu, 07 Mar 2024 07:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709824951; x=1710429751; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TU83T99cHGoAZca3sEX6lwhqsB1KO5dXBt4kckaA3DQ=;
        b=hhDs02wQDGoRqexYZUSWMZoNgAacfimjF5F6Q2aSeWAuvRYxsBSK7Ap0GN0z0ly+TL
         bghytLVw3HOgFcBvgze5xRpR1bxRd5Bo/CMktX+ramumW0OWtjmRDDULpT3qateb/+uj
         jGLHty+2JcW1uZsBjtbTdTqtDIRjEFpkzGAIG7V51Tt4xExnEzFrSLKVBwn6pPnZElzH
         /kf7w8liDSUfj+GlEnhKMduCAwlYS7LuCLgn5Y1RyOlIijsbVTvLCkj3sO6kiVcCrF3n
         H2TYQr3XCE64ySBU0SkfE7lN3iW/GVVWPCiKJuRdzMJ6Hduqb1HaEske04hg1acFKaON
         OvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709824951; x=1710429751;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TU83T99cHGoAZca3sEX6lwhqsB1KO5dXBt4kckaA3DQ=;
        b=Sjf0WjP7pdVbss3pCaooMKKESue6yzoqTG22ClDrEwRxV2DXWF89zHArvqaVI4iJqd
         j4jZbQArvAoVpZ5OdFja7GYbdYHyzt4ln6n5EPwSUwT+lxNA3caG36SZxwA0S00JeuuL
         +Rh9icdUSJ0VKmQUK6J7ebvGyFIc/6tdOkzYq25qBGmuz8SLQbZuEEgSDr6NrpzsukIS
         39d6nqbrk9hgtWTXbEg8N6xHWnp1MYkzOGqgI4mp68vyJamGPEUA7CJ5uVMhkZeHnKkZ
         7ltSP4U242GoJvT87Sil98KvPFbCAZEq7sb/8e6fGpNIWvLTheHbqgPW0ObUa1KWu7Ym
         HIBg==
X-Gm-Message-State: AOJu0YzDY2guPUQFzyQ1kNHwIlxGftzAQFCNvbVpK/T3Ls9FVgfjl78y
	PNvpeHPD90akPVscwfyISWUNC5C0BOyfayv4C+SwXbQ7M1CB93G0+Qp7IaAT
X-Google-Smtp-Source: AGHT+IG3UKxzum31I2lQdT69mUpPe6ehhMwdc5XTSftTgFrF3MHOFpzE0F2J1RScqYZ5EzGjFi1CFg==
X-Received: by 2002:a05:6512:1388:b0:512:ee09:a7a5 with SMTP id fc8-20020a056512138800b00512ee09a7a5mr2140746lfb.34.1709824951091;
        Thu, 07 Mar 2024 07:22:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o32-20020a05600c512000b0041312e8ef2bsm1333090wms.26.2024.03.07.07.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 07:22:30 -0800 (PST)
Message-ID: <b378b93242a7870772fdb53d7bf2d58d3347ba62.1709824949.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1679.v2.git.1709824949.gitgitgadget@gmail.com>
References: <pull.1679.git.1709566808.gitgitgadget@gmail.com>
	<pull.1679.v2.git.1709824949.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 07 Mar 2024 15:22:27 +0000
Subject: [PATCH v2 1/3] t0211: demonstrate missing 'def_param' events for
 certain commands
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Josh Steadmon <steadmon@google.com>,
    Jeff Hostetler <git@jeffhostetler.com>,
    Jeff Hostetler <jeffhostetler@github.com>,
    Jeff Hostetler <jeffhostetler@github.com>

From: Jeff Hostetler <jeffhostetler@github.com>

Some Git commands fail to emit 'def_param' events for interesting
config and environment variable settings.

Add unit tests to demonstrate this.

Most commands are considered "builtin" and are based upon git.c.
These typically do emit 'def_param' events.  Exceptions are some of
the "query" commands, the "run-dashed" mechanism, and alias handling.

Commands built from remote-curl.c (instead of git.c), such as
"git-remote-https", do not emit 'def_param' events.

Likewise, "git-http-fetch" is built http-fetch.c and does not emit
them.

Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
 t/t0211-trace2-perf.sh | 231 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 231 insertions(+)

diff --git a/t/t0211-trace2-perf.sh b/t/t0211-trace2-perf.sh
index 290b6eaaab1..588c5bad033 100755
--- a/t/t0211-trace2-perf.sh
+++ b/t/t0211-trace2-perf.sh
@@ -287,4 +287,235 @@ test_expect_success 'unsafe URLs are redacted by default' '
 	grep "d0|main|def_param|.*|remote.origin.url:https://user:pwd@example.com" actual
 '
 
+# Confirm that the requested command produces a "cmd_name" and a
+# set of "def_param" events.
+#
+try_simple () {
+	test_when_finished "rm prop.perf actual" &&
+
+	cmd=$1 &&
+	cmd_name=$2 &&
+
+	test_config_global "trace2.configParams" "cfg.prop.*" &&
+	test_config_global "trace2.envvars" "ENV_PROP_FOO,ENV_PROP_BAR" &&
+
+	test_config_global "cfg.prop.foo" "red" &&
+
+	ENV_PROP_FOO=blue \
+		GIT_TRACE2_PERF="$(pwd)/prop.perf" \
+			$cmd &&
+	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <prop.perf >actual &&
+	grep "d0|main|cmd_name|.*|$cmd_name" actual &&
+	grep "d0|main|def_param|.*|cfg.prop.foo:red" actual &&
+	grep "d0|main|def_param|.*|ENV_PROP_FOO:blue" actual
+}
+
+# Representative mainstream builtin Git command dispatched
+# in run_builtin() in git.c
+#
+test_expect_success 'expect def_params for normal builtin command' '
+	try_simple "git version" "version"
+'
+
+# Representative query command dispatched in handle_options()
+# in git.c
+#
+test_expect_failure 'expect def_params for query command' '
+	try_simple "git --man-path" "_query_"
+'
+
+# remote-curl.c does not use the builtin setup in git.c, so confirm
+# that executables built from remote-curl.c emit def_params.
+#
+# Also tests the dashed-command handling where "git foo" silently
+# spawns "git-foo".  Make sure that both commands should emit
+# def_params.
+#
+# Pass bogus arguments to remote-https and allow the command to fail
+# because we don't actually have a remote to fetch from.  We just want
+# to see the run-dashed code run an executable built from
+# remote-curl.c rather than git.c.  Confirm that we get def_param
+# events from both layers.
+#
+test_expect_failure 'expect def_params for remote-curl and _run_dashed_' '
+	test_when_finished "rm prop.perf actual" &&
+
+	test_config_global "trace2.configParams" "cfg.prop.*" &&
+	test_config_global "trace2.envvars" "ENV_PROP_FOO,ENV_PROP_BAR" &&
+
+	test_config_global "cfg.prop.foo" "red" &&
+
+	test_might_fail env \
+		ENV_PROP_FOO=blue \
+		GIT_TRACE2_PERF="$(pwd)/prop.perf" \
+		git remote-http x y &&
+
+	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <prop.perf >actual &&
+
+	grep "d0|main|cmd_name|.*|_run_dashed_" actual &&
+	grep "d0|main|def_param|.*|cfg.prop.foo:red" actual &&
+	grep "d0|main|def_param|.*|ENV_PROP_FOO:blue" actual &&
+
+	grep "d1|main|cmd_name|.*|remote-curl" actual &&
+	grep "d1|main|def_param|.*|cfg.prop.foo:red" actual &&
+	grep "d1|main|def_param|.*|ENV_PROP_FOO:blue" actual
+'
+
+# Similarly, `git-http-fetch` is not built from git.c so do a
+# trivial fetch so that the main git.c run-dashed code spawns
+# an executable built from http-fetch.c.  Confirm that we get
+# def_param events from both layers.
+#
+test_expect_failure 'expect def_params for http-fetch and _run_dashed_' '
+	test_when_finished "rm prop.perf actual" &&
+
+	test_config_global "trace2.configParams" "cfg.prop.*" &&
+	test_config_global "trace2.envvars" "ENV_PROP_FOO,ENV_PROP_BAR" &&
+
+	test_config_global "cfg.prop.foo" "red" &&
+
+	test_might_fail env \
+		ENV_PROP_FOO=blue \
+		GIT_TRACE2_PERF="$(pwd)/prop.perf" \
+		git http-fetch --stdin file:/// <<-EOF &&
+	EOF
+
+	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <prop.perf >actual &&
+
+	grep "d0|main|cmd_name|.*|_run_dashed_" actual &&
+	grep "d0|main|def_param|.*|cfg.prop.foo:red" actual &&
+	grep "d0|main|def_param|.*|ENV_PROP_FOO:blue" actual &&
+
+	grep "d1|main|cmd_name|.*|http-fetch" actual &&
+	grep "d1|main|def_param|.*|cfg.prop.foo:red" actual &&
+	grep "d1|main|def_param|.*|ENV_PROP_FOO:blue" actual
+'
+
+# Historically, alias expansion explicitly emitted the def_param
+# events (independent of whether the command was a builtin, a Git
+# command or arbitrary shell command) so that it wasn't dependent
+# upon the unpeeling of the alias. Let's make sure that we preserve
+# the net effect.
+#
+test_expect_success 'expect def_params during git alias expansion' '
+	test_when_finished "rm prop.perf actual" &&
+
+	test_config_global "trace2.configParams" "cfg.prop.*" &&
+	test_config_global "trace2.envvars" "ENV_PROP_FOO,ENV_PROP_BAR" &&
+
+	test_config_global "cfg.prop.foo" "red" &&
+
+	test_config_global "alias.xxx" "version" &&
+
+	ENV_PROP_FOO=blue \
+		GIT_TRACE2_PERF="$(pwd)/prop.perf" \
+			git xxx &&
+
+	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <prop.perf >actual &&
+
+	# "git xxx" is first mapped to "git-xxx" and the child will fail.
+	grep "d0|main|cmd_name|.*|_run_dashed_ (_run_dashed_)" actual &&
+
+	# We unpeel that and substitute "version" into "xxx" (giving
+	# "git version") and update the cmd_name event.
+	grep "d0|main|cmd_name|.*|_run_git_alias_ (_run_dashed_/_run_git_alias_)" actual &&
+
+	# These def_param events could be associated with either of the
+	# above cmd_name events.  It does not matter.
+	grep "d0|main|def_param|.*|cfg.prop.foo:red" actual &&
+	grep "d0|main|def_param|.*|ENV_PROP_FOO:blue" actual &&
+
+	# The "git version" child sees a different cmd_name hierarchy.
+	# Also test the def_param (only for completeness).
+	grep "d1|main|cmd_name|.*|version (_run_dashed_/_run_git_alias_/version)" actual &&
+	grep "d1|main|def_param|.*|cfg.prop.foo:red" actual &&
+	grep "d1|main|def_param|.*|ENV_PROP_FOO:blue" actual
+'
+
+test_expect_success 'expect def_params during shell alias expansion' '
+	test_when_finished "rm prop.perf actual" &&
+
+	test_config_global "trace2.configParams" "cfg.prop.*" &&
+	test_config_global "trace2.envvars" "ENV_PROP_FOO,ENV_PROP_BAR" &&
+
+	test_config_global "cfg.prop.foo" "red" &&
+
+	test_config_global "alias.xxx" "!git version" &&
+
+	ENV_PROP_FOO=blue \
+		GIT_TRACE2_PERF="$(pwd)/prop.perf" \
+			git xxx &&
+
+	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <prop.perf >actual &&
+
+	# "git xxx" is first mapped to "git-xxx" and the child will fail.
+	grep "d0|main|cmd_name|.*|_run_dashed_ (_run_dashed_)" actual &&
+
+	# We unpeel that and substitute "git version" for "git xxx" (as a
+	# shell command.  Another cmd_name event is emitted as we unpeel.
+	grep "d0|main|cmd_name|.*|_run_shell_alias_ (_run_dashed_/_run_shell_alias_)" actual &&
+
+	# These def_param events could be associated with either of the
+	# above cmd_name events.  It does not matter.
+	grep "d0|main|def_param|.*|cfg.prop.foo:red" actual &&
+	grep "d0|main|def_param|.*|ENV_PROP_FOO:blue" actual &&
+
+	# We get the following only because we used a git command for the
+	# shell command. In general, it could have been a shell script and
+	# we would see nothing.
+	#
+	# The child knows the cmd_name hierarchy so it includes it.
+	grep "d1|main|cmd_name|.*|version (_run_dashed_/_run_shell_alias_/version)" actual &&
+	grep "d1|main|def_param|.*|cfg.prop.foo:red" actual &&
+	grep "d1|main|def_param|.*|ENV_PROP_FOO:blue" actual
+'
+
+test_expect_failure 'expect def_params during nested git alias expansion' '
+	test_when_finished "rm prop.perf actual" &&
+
+	test_config_global "trace2.configParams" "cfg.prop.*" &&
+	test_config_global "trace2.envvars" "ENV_PROP_FOO,ENV_PROP_BAR" &&
+
+	test_config_global "cfg.prop.foo" "red" &&
+
+	test_config_global "alias.xxx" "yyy" &&
+	test_config_global "alias.yyy" "version" &&
+
+	ENV_PROP_FOO=blue \
+		GIT_TRACE2_PERF="$(pwd)/prop.perf" \
+			git xxx &&
+
+	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <prop.perf >actual &&
+
+	# "git xxx" is first mapped to "git-xxx" and try to spawn "git-xxx"
+	# and the child will fail.
+	grep "d0|main|cmd_name|.*|_run_dashed_ (_run_dashed_)" actual &&
+	grep "d0|main|child_start|.*|.* class:dashed argv:\[git-xxx\]" actual &&
+
+	# We unpeel that and substitute "yyy" into "xxx" (giving "git yyy")
+	# and spawn "git-yyy" and the child will fail.
+	grep "d0|main|alias|.*|alias:xxx argv:\[yyy\]" actual &&
+	grep "d0|main|cmd_name|.*|_run_dashed_ (_run_dashed_/_run_dashed_)" actual &&
+	grep "d0|main|child_start|.*|.* class:dashed argv:\[git-yyy\]" actual &&
+
+	# We unpeel that and substitute "version" into "xxx" (giving
+	# "git version") and update the cmd_name event.
+	grep "d0|main|alias|.*|alias:yyy argv:\[version\]" actual &&
+	grep "d0|main|cmd_name|.*|_run_git_alias_ (_run_dashed_/_run_dashed_/_run_git_alias_)" actual &&
+
+	# These def_param events could be associated with any of the
+	# above cmd_name events.  It does not matter.
+	grep "d0|main|def_param|.*|cfg.prop.foo:red" actual >actual.matches &&
+	grep "d0|main|def_param|.*|ENV_PROP_FOO:blue" actual &&
+
+	# However, we do not want them repeated each time we unpeel.
+	test_line_count = 1 actual.matches &&
+
+	# The "git version" child sees a different cmd_name hierarchy.
+	# Also test the def_param (only for completeness).
+	grep "d1|main|cmd_name|.*|version (_run_dashed_/_run_dashed_/_run_git_alias_/version)" actual &&
+	grep "d1|main|def_param|.*|cfg.prop.foo:red" actual &&
+	grep "d1|main|def_param|.*|ENV_PROP_FOO:blue" actual
+'
+
 test_done
-- 
gitgitgadget

