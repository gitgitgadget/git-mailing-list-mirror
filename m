Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EF4397B17
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 18:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780425815; cv=none; b=nPKQ7UdcA/Jm5lFDohQzyQh9LBuhuBfl/Kj8ItQZW51G/TaHrhKgMQPTMmHXS8yN+tbDPT3n2yGJ9xtSbq70/DeOFeoWTmHivDgl6iCuM5su3x7hQL+kw6p9XlcS9s2SPRcSpYAqvpFHQj76JAU8FPgEoJ0lPOAI2DUw7fUbg5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780425815; c=relaxed/simple;
	bh=d6zKEiDW5UdMEP287PxMl1kJ33rsCe1gQ2IwioCqT4g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MIfyMgKIdT62okjvh7gLykUKU2xL5S2bff6x8IRzh03RmEaoyKwEzRkPxG8OC7Cy+USG8KnDYWR9e3g5rQSBKC8e55I4cjdy0/0EkFxjSWdE/vFtLRYkX4Q3ASGkcXfEDfoT9wQj+9RTzW/LfwwM/VV5GDuP/AIUQS53jL99qR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwwVM/Am; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwwVM/Am"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-69df5352d0eso3977573eaf.3
        for <git@vger.kernel.org>; Tue, 02 Jun 2026 11:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780425813; x=1781030613; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJyahszukc3fSoHSJUntYk9ZkHmfPMP/+aeTmDGkoXc=;
        b=fwwVM/AmXqMZUjD5iOL6mg0anXzmJQKK9oj27t1r8AdUMn7lNKlrG6hYs177VHR/zB
         8fCfQ93SuLwuj3Vqw69PAvFGB/5ShQkT2LaEMa1eL23Q7VAsZsNoEFsFGV6FGLXZWT96
         iTYrpZQEXZxDPe7WXijjh7UY9er5coT4xg3S5hA+p7oFvsssyA7UqyfXbvKZrsZH5FV/
         /83fLnrmUxDbwv/WdYa0a49NuGDIcbRb/H1qk+Bk+49tDs5MWXAjL9LLQ/yAlpPUg2Ap
         EYX2M9QY0Pp7pUDo/uLv5zeOWKxNPkCCEUUEC2JPMerwbZwTPSJ27tL/mL5XOazV/U6F
         xb4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780425813; x=1781030613;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OJyahszukc3fSoHSJUntYk9ZkHmfPMP/+aeTmDGkoXc=;
        b=qydVV3nxkRus8Uc5pVQY2XcKUKq95qQ38laq+Rg4V0M0yR22c1zK2viP+W566agpBv
         NssuaozHCMhIbyzMw/q7LzHhZXJ8jQdUOO4LRfc6eCfCz7eh8RC7FTm22CHmNcTCQx5O
         bIfgB63jFPLnNSnjXDIXD8gn1ZEZ/+LmDl6SbXJNil7FiJAimvgnUtBKgIx/44eCtFpX
         ratDhQVlZH/e1P9k+qLMVWtdpE+5963CNPYBN82DsJywbhCrF6ZvlDy7Tw0c4SMW3k2O
         FUMyh3MNjkOBx0SVHTNb4Y6FzWUk3hjSLtAe5I+fSsBJxeY1gAYH6wYQCPWPnly7Wt70
         2+8A==
X-Gm-Message-State: AOJu0Yw2i/3ejQwTKKfaXxmdgwl1u/J0wT2iEjWARty8fKV54HavNHr6
	Q9LgD+ls5AkjEw8j17YqjC4q568/0dJSR3bPRvkReLanTy1z1pmCda/5oRh+k03E
X-Gm-Gg: Acq92OHXuLRd5ez12bUWFusV5+HsdoD/14RpcepWs1oRhdt1vHT+ADQ1BLWWHztlhMA
	wWKs7YG6Pw+D7SoRVY5C2Popzrp30zriIY3WPDOh//zCNdGJDlEQowz2DvtxeopqSVrnsuSOFUw
	nLmNlX4ni1XaE8AZBlgyHz17SJUSpIsEc94YkMAyGi3AF8WDzkC//ILLmCXoNrPZZe0wqfLebnr
	a9FqdTY2nLWWv7wXtAX6eZMpWHNQjr0Onlgu8uYncytVYmr/L1fxiAX4/GmoNWTALJ+vNkXQnYL
	1xws/JPp4jl26PFiU/3CyAoz1MduqTJjXrdVcoTFJIfU3hTYqHWbrEUtFWZ8Vonrpe1w3K2Wepb
	0DXOSoL6OQZncxRFcUWgoYEcBtUqf2q+N2eWxwbqJ7O/jYJ9yJbN+VPnmmS4tVVUK1xmMERdmlT
	WlmDSY83l3zNPEjjtDtEX4v9cVThhzcoJ3X1oy
X-Received: by 2002:a05:6820:4c86:b0:696:1f76:436d with SMTP id 006d021491bc7-69e4808ed80mr190487eaf.42.1780425812554;
        Tue, 02 Jun 2026 11:43:32 -0700 (PDT)
Received: from [127.0.0.1] ([20.80.108.168])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e46450223sm379443eaf.14.2026.06.02.11.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 11:43:32 -0700 (PDT)
Message-Id: <a7f8a084c7c2858638b8cdd145cb21ffcdfd9c57.1780425808.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2302.v6.git.git.1780425808.gitgitgadget@gmail.com>
References: <pull.2302.v5.git.git.1780407557.gitgitgadget@gmail.com>
	<pull.2302.v6.git.git.1780425808.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 02 Jun 2026 18:43:28 +0000
Subject: [PATCH v6 2/2] config: improve diagnostic for "set" with missing
 value
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

"git config set pull.rebase=false" currently fails with "wrong
number of arguments", and the implicit form "git config
pull.rebase=false" fails with "invalid key". Neither points at
the real problem: the value is missing.

Report that directly, and when the argument has the shape
"<valid-key>=<value>", also suggest the split form:

    $ git config set pull.rebase=false
    error: missing value to set to the variable 'pull.rebase=false'
    hint: did you mean "git config set pull.rebase false"?

When the prefix before "=" is not a valid key, drop the hint:

    $ git config set foo=bar
    error: missing value to set to a variable with an invalid name 'foo=bar'

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/config.c  | 32 ++++++++++++++++++++++++++-
 t/t1300-config.sh | 56 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/builtin/config.c b/builtin/config.c
index cf4ba0f7cc..8d8ec0beea 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -1,6 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
+#include "advice.h"
 #include "config.h"
 #include "color.h"
 #include "date.h"
@@ -210,6 +211,26 @@ static void check_argc(int argc, int min, int max)
 	exit(129);
 }
 
+static NORETURN void die_missing_set_value(const char *arg)
+{
+	const char *last_dot = strrchr(arg, '.');
+	const char *eq = last_dot ? strchr(last_dot + 1, '=') : NULL;
+	char *prefix = eq ? xstrndup(arg, eq - arg) : NULL;
+
+	if (prefix && git_config_key_is_valid(prefix)) {
+		error(_("missing value to set to the variable '%s'"), arg);
+		advise(_("did you mean \"git config set %s %s\"?"),
+		       prefix, eq + 1);
+	} else if (git_config_key_is_valid(arg)) {
+		error(_("missing value to set to the variable '%s'"), arg);
+	} else {
+		error(_("missing value to set to a variable with an invalid name '%s'"),
+		      arg);
+	}
+	free(prefix);
+	exit(129);
+}
+
 static void show_config_origin(const struct config_display_options *opts,
 			       const struct key_value_info *kvi,
 			       struct strbuf *buf)
@@ -1133,6 +1154,8 @@ static int cmd_config_set(int argc, const char **argv, const char *prefix,
 
 	argc = parse_options(argc, argv, prefix, opts, builtin_config_set_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
+	if (argc == 1)
+		die_missing_set_value(argv[0]);
 	check_argc(argc, 2, 2);
 
 	if ((flags & CONFIG_FLAGS_FIXED_VALUE) && !value_pattern)
@@ -1371,6 +1394,7 @@ static int cmd_config_actions(int argc, const char **argv, const char *prefix)
 	};
 	char *value = NULL, *comment = NULL;
 	int ret = 0;
+	int actions_implicit;
 	struct key_value_info default_kvi = KVI_INIT;
 
 	argc = parse_options(argc, argv, prefix, opts,
@@ -1385,7 +1409,8 @@ static int cmd_config_actions(int argc, const char **argv, const char *prefix)
 		exit(129);
 	}
 
-	if (actions == 0)
+	actions_implicit = (actions == 0);
+	if (actions_implicit)
 		switch (argc) {
 		case 1: actions = ACTION_GET; break;
 		case 2: actions = ACTION_SET; break;
@@ -1394,6 +1419,11 @@ static int cmd_config_actions(int argc, const char **argv, const char *prefix)
 			error(_("no action specified"));
 			exit(129);
 		}
+	if (actions_implicit && argc == 1) {
+		const char *last_dot = strrchr(argv[0], '.');
+		if (last_dot && strchr(last_dot + 1, '='))
+			die_missing_set_value(argv[0]);
+	}
 	if (display_opts.omit_values &&
 	    !(actions == ACTION_LIST || actions == ACTION_GET_REGEXP)) {
 		error(_("--name-only is only applicable to --list or --get-regexp"));
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 11fc976f3a..87ca11a127 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -469,6 +469,62 @@ test_expect_success 'invalid key' '
 	test_must_fail git config inval.2key blabla
 '
 
+test_expect_success 'set with 1 arg of "key=value": valid key suggests split form' '
+	test_must_fail git config set pull.rebase=false 2>err &&
+	test_grep "missing value to set to the variable .pull\\.rebase=false." err &&
+	test_grep "did you mean .git config set pull\\.rebase false." err
+'
+
+test_expect_success 'set with 1 arg of "key=value": implicit form suggests split form' '
+	test_must_fail git config pull.rebase=false 2>err &&
+	test_grep "missing value to set to the variable .pull\\.rebase=false." err &&
+	test_grep "did you mean .git config set pull\\.rebase false." err
+'
+
+test_expect_success 'set with 1 arg of "key=value": invalid key does not suggest split form' '
+	test_must_fail git config set foo=bar 2>err &&
+	test_grep "missing value to set to a variable with an invalid name .foo=bar." err &&
+	test_grep ! "did you mean" err
+'
+
+test_expect_success 'set with 1 arg: variable name starting with digit is invalid' '
+	test_must_fail git config set foo.1bar=baz 2>err &&
+	test_grep "missing value to set to a variable with an invalid name .foo\\.1bar=baz." err &&
+	test_grep ! "did you mean" err
+'
+
+test_expect_success 'set with 1 arg: digit-led section name is valid' '
+	test_must_fail git config set 1foo.bar=baz 2>err &&
+	test_grep "missing value to set to the variable .1foo\\.bar=baz." err &&
+	test_grep "did you mean .git config set 1foo\\.bar baz." err
+'
+
+test_expect_success 'set with 1 arg: subsection plus invalid variable name' '
+	test_must_fail git config set foo.some.b_r=baz 2>err &&
+	test_grep "missing value to set to a variable with an invalid name .foo\\.some\\.b_r=baz." err &&
+	test_grep ! "did you mean" err
+'
+
+test_expect_success 'set with 1 arg of valid key reports missing value' '
+	test_must_fail git config set pull.rebase 2>err &&
+	test_grep "missing value to set to the variable .pull\\.rebase." err &&
+	test_grep ! "did you mean" err
+'
+
+test_expect_success 'set with 2 args including "=" in invalid key does not suggest' '
+	test_must_fail git config set pull.rebase=false true 2>err &&
+	test_grep "invalid key: pull\\.rebase=false" err &&
+	test_grep ! "did you mean" err
+'
+
+test_expect_success '"=" inside subsection is valid' '
+	test_when_finished "rm -f subsection.cfg" &&
+	git config set -f subsection.cfg foo.bar=baz.boo qux &&
+	echo qux >expect &&
+	git config get -f subsection.cfg foo.bar=baz.boo >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'correct key' '
 	git config 123456.a123 987
 '
-- 
gitgitgadget
