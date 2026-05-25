Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA773DD850
	for <git@vger.kernel.org>; Mon, 25 May 2026 08:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779698002; cv=none; b=CO27IVswjp4tNVa91vKYkhglhvX64jw1l4n8S1Uc6nVTGyZ9xCHHCKF6hPYv3gf2O9ZI6cwNG5/hF9lD1kDs9f8Qxx9ALQ2qtgIReAbJLfqOwiRyz3GO0qGZnza5LyVCdr0khWShcwWk8H3/D0dR7Cx5xSN+kjit2wOl1VxtIA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779698002; c=relaxed/simple;
	bh=+LLkAd3wqmR2GWuOly04Y/iMvi8BDOva03FFx3nYnFs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LxPKuFfsirMH1xx3YsLBxKPvtWjgpuAfi3DQELlI1vfmT9I/DdL4YhcXQT/Go6cVVu/d8kheRv5YyZ1Cwn3VijdVlFDlEh7RITFNGMGC/SW7MErEkd+a/gVoQqJ/mOfm8kW3ddshJsh/gUJaJ5MbDA+ZKABdZzlZ4CURs4psKjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlCpy5g/; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlCpy5g/"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2ee990e8597so22970760eec.1
        for <git@vger.kernel.org>; Mon, 25 May 2026 01:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779697997; x=1780302797; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcerY8479EiRgGz2g1TICXO32Eerqm1KeTujLMvfZRI=;
        b=jlCpy5g/kLYr66xEnl22/g7/y1Gx2VYDgYfOpQhIeh36/9NMTVq2bIyx60AcUZYAgk
         9xfIB40HkG0APcsQSxhbRj8YWgIeTc6RJ9B7jon2465M9zYK4iuDi3cv1Xh5RaoPVn7r
         OWhWcVm6a0ENCCYMYi4jQ+O35/AIgoir2bY5v/KwVm5NcTUhBZdOVeZjBiq2uJNmuHS/
         EerF/QhCuH1NiqyQGturn/VsQsekFnG2W2rMxjaanmYjEi4PHAFZJJshypuBOc6/g7ej
         MBg8pySDiwYxX2paoS+wZn/Gazy3mp72iEERmHAflm4P1ULiRLSIzXLs6BDQcNEiO/vW
         i8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779697997; x=1780302797;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xcerY8479EiRgGz2g1TICXO32Eerqm1KeTujLMvfZRI=;
        b=hKMlpZ/Ul0d35VT3eeNkMBZiYPKmnGpz8PkD6FvL6TV8jEWN0IwbHO8nlZvN9MpjAx
         RIu+YOApjTTlMUnikRL/kdnLUH5B6ncjMoHppstt1TmatCOiHKZKZg4zG2qfWXhHfo1O
         JMNKprwmrxgz/xqyrXbSZbze/DTIFpvAGMi9E/Qd7uO5/2iWbBuhjGVv2N8lkiDRbmew
         qfX38ZNGKOmfhAxRuef3Wu2ovbYvWxrUpOvR27mtVsLeQs1U6ylLjEU4GID8ppcVTt+p
         GUlBFhuotRWqaB0acIThpq+llTwfx6oQaMdyqi5llRVJVJjM7o98BV7ySo/NmTU5mWt9
         S2Ow==
X-Gm-Message-State: AOJu0Yx9mH2P1iOC9zJXJdYijtBhoP6RrK6Gq+Pv5nToDdq4DiOE9k4h
	6KT8WLma0VHzojATMC5GKzZdXo1aDqYLDpVicR0/2tgT72YgzlNXiQBHmDc46Q==
X-Gm-Gg: Acq92OFvSsM+LwG6DpO8MBrogbNXXkrswX/qi92k0aWLH+3IDjNs6SK0OzjCHPRkOCs
	jxSuBYrQXDug9SW3O/zS1m0HcOmROG/d0Q7HbRKjfOmoG/2ef+d8+WdOk9Rm4StH30Y6LAgewDG
	j2KeQ+xctSOWS/r861HX7/oQQ4HAOWct1/NJzU0yLPcxhIWnAsvIB0Lv9pcBKhLGAhHupzQc2Pl
	QWuYhkvujnyA+xBze2/DsPr3ghK1AwXpQGcCb7patFO+o4Bz8Fu0/9w8MtcBx8Up+3e8vM0ZREi
	ecJqVdcRIC2ckL7Azy08YoI7t3bZfGgEM5Ex6ctEzmiS8tFln0aoIQsoiBAvTG1qvPa3aqxgocl
	1KaLZQ2/FVR1j86Ej4hv6xzaqpPuCheKrQ58PWZ/o2rXjGV1u19R1eHFPDJzEtxvW2BLYjebiyE
	hQp2JgNHRL8EI0Gqz/LPFDgojX+Cb6qq+TWGcNzA==
X-Received: by 2002:a05:693c:8848:b0:304:59cc:aee8 with SMTP id 5a478bee46e88-30459ccb57emr3331821eec.18.1779697997259;
        Mon, 25 May 2026 01:33:17 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.247.178])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30452230f1bsm7142478eec.14.2026.05.25.01.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 01:33:16 -0700 (PDT)
Message-Id: <pull.2302.v3.git.git.1779697995418.gitgitgadget@gmail.com>
In-Reply-To: <pull.2302.v2.git.git.1778935976330.gitgitgadget@gmail.com>
References: <pull.2302.v2.git.git.1778935976330.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 25 May 2026 08:33:15 +0000
Subject: [PATCH v3] config: suggest the correct form when key contains "=" in
 set context
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

A user who types "git config pull.rebase=false" gets only "error:
invalid key: pull.rebase=false" with no clue what went wrong.

Emit a "did you mean ..." hint suggesting the split form.  Restrict it
to plausible-set contexts ("git config set", bare "git config <key>",
and their 2-arg forms); explicit "get"/"unset" keep the existing error.

"=" is legal inside a subsection, so only fire when "=" lands after
the last ".".  When the user supplied a separate value, use it in the
suggestion instead of the suffix after "=":

    $ git config set pull.rebase=false true
    error: invalid key: pull.rebase=false
    hint: did you mean "git config set pull.rebase true"?

Signed-off-by: Harald Nordgren <harald.nordgren@kostdoktorn.se>
Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    config: suggest the correct form when key contains "="
    
     * Skip the hint when the inferred value contains whitespace, so git
       config set pull.rebase=false "hello world" no longer suggests a
       malformed command.
     * Replace the inline actions == 0 check with a named actions_implicit
       flag, simplfied the code.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2302%2FHaraldNordgren%2Fconfig-hint-equals-key-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2302/HaraldNordgren/config-hint-equals-key-v3
Pull-Request: https://github.com/git/git/pull/2302

Range-diff vs v2:

 1:  40d9eb3e5c ! 1:  6b9d66361d config: suggest the correct form when key contains "=" in set context
     @@ Commit message
              hint: did you mean "git config set pull.rebase true"?
      
          Signed-off-by: Harald Nordgren <harald.nordgren@kostdoktorn.se>
     +    Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## builtin/config.c ##
      @@
     @@ builtin/config.c: static void check_argc(int argc, int min, int max)
      +		return;
      +	if (!value)
      +		value = eq + 1;
     ++	if (!*value || strpbrk(value, " \t\n"))
     ++		return;
      +	advise(_("did you mean \"git config set %.*s %s\"?"),
      +	       (int)(eq - key), key, value);
      +}
     @@ builtin/config.c: static int cmd_config_actions(int argc, const char **argv, con
       		exit(129);
       	}
       
     +-	if (actions == 0)
      +	actions_implicit = (actions == 0);
     - 	if (actions == 0)
     ++	if (actions_implicit)
       		switch (argc) {
       		case 1: actions = ACTION_GET; break;
     + 		case 2: actions = ACTION_SET; break;
      @@ builtin/config.c: static int cmd_config_actions(int argc, const char **argv, const char *prefix)
       		if (ret == CONFIG_NOTHING_SET)
       			error(_("cannot overwrite multiple values with a single value\n"
     @@ t/t1300-config.sh: test_expect_success 'invalid key' '
      +	test_grep ! "did you mean" err
      +'
      +
     ++test_expect_success 'misplaced "=" in key: value with whitespace skips hint' '
     ++	test_must_fail git config set pull.rebase=false "hello world" 2>err &&
     ++	test_grep "invalid key: pull\\.rebase=false" err &&
     ++	test_grep ! "did you mean" err
     ++'
     ++
      +test_expect_success '"=" inside subsection is valid, no hint' '
      +	test_when_finished "rm -f subsection.cfg" &&
      +	git config set -f subsection.cfg foo.bar=baz.boo qux 2>err &&


 builtin/config.c  | 34 +++++++++++++++++++++++++++++-
 t/t1300-config.sh | 53 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/builtin/config.c b/builtin/config.c
index cf4ba0f7cc..8c7ab36fcb 100644
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
@@ -210,6 +211,24 @@ static void check_argc(int argc, int min, int max)
 	exit(129);
 }
 
+static void advise_setting_with_equals(const char *key, const char *value)
+{
+	const char *last_dot = strrchr(key, '.');
+	const char *eq;
+
+	if (!last_dot)
+		return;
+	eq = strchr(last_dot + 1, '=');
+	if (!eq)
+		return;
+	if (!value)
+		value = eq + 1;
+	if (!*value || strpbrk(value, " \t\n"))
+		return;
+	advise(_("did you mean \"git config set %.*s %s\"?"),
+	       (int)(eq - key), key, value);
+}
+
 static void show_config_origin(const struct config_display_options *opts,
 			       const struct key_value_info *kvi,
 			       struct strbuf *buf)
@@ -1133,6 +1152,11 @@ static int cmd_config_set(int argc, const char **argv, const char *prefix,
 
 	argc = parse_options(argc, argv, prefix, opts, builtin_config_set_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
+	if (argc == 1 && strchr(argv[0], '=')) {
+		error(_("wrong number of arguments, should be 2"));
+		advise_setting_with_equals(argv[0], NULL);
+		exit(129);
+	}
 	check_argc(argc, 2, 2);
 
 	if ((flags & CONFIG_FLAGS_FIXED_VALUE) && !value_pattern)
@@ -1160,6 +1184,8 @@ static int cmd_config_set(int argc, const char **argv, const char *prefix,
 			error(_("cannot overwrite multiple values with a single value\n"
 			"       Use --value=<pattern>, --append or --all to change %s."), argv[0]);
 	}
+	if (ret == CONFIG_INVALID_KEY)
+		advise_setting_with_equals(argv[0], argv[1]);
 
 	location_options_release(&location_opts);
 	free(comment);
@@ -1371,6 +1397,7 @@ static int cmd_config_actions(int argc, const char **argv, const char *prefix)
 	};
 	char *value = NULL, *comment = NULL;
 	int ret = 0;
+	int actions_implicit;
 	struct key_value_info default_kvi = KVI_INIT;
 
 	argc = parse_options(argc, argv, prefix, opts,
@@ -1385,7 +1412,8 @@ static int cmd_config_actions(int argc, const char **argv, const char *prefix)
 		exit(129);
 	}
 
-	if (actions == 0)
+	actions_implicit = (actions == 0);
+	if (actions_implicit)
 		switch (argc) {
 		case 1: actions = ACTION_GET; break;
 		case 2: actions = ACTION_SET; break;
@@ -1485,6 +1513,8 @@ static int cmd_config_actions(int argc, const char **argv, const char *prefix)
 		if (ret == CONFIG_NOTHING_SET)
 			error(_("cannot overwrite multiple values with a single value\n"
 			"       Use a regexp, --add or --replace-all to change %s."), argv[0]);
+		else if (ret == CONFIG_INVALID_KEY)
+			advise_setting_with_equals(argv[0], argv[1]);
 	}
 	else if (actions == ACTION_SET_ALL) {
 		check_write(&location_opts.source);
@@ -1515,6 +1545,8 @@ static int cmd_config_actions(int argc, const char **argv, const char *prefix)
 		check_argc(argc, 1, 2);
 		ret = get_value(&location_opts, &display_opts, argv[0], argv[1],
 				0, flags);
+		if (ret == CONFIG_INVALID_KEY && actions_implicit)
+			advise_setting_with_equals(argv[0], NULL);
 	}
 	else if (actions == ACTION_GET_ALL) {
 		check_argc(argc, 1, 2);
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 11fc976f3a..4e12b78536 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -469,6 +469,59 @@ test_expect_success 'invalid key' '
 	test_must_fail git config inval.2key blabla
 '
 
+test_expect_success 'misplaced "=" in key: bare 1-arg form hints' '
+	test_must_fail git config pull.rebase=false 2>err &&
+	test_grep "invalid key: pull\\.rebase=false" err &&
+	test_grep "did you mean .git config set pull\\.rebase false." err
+'
+
+test_expect_success 'misplaced "=" in key: bare 2-arg form uses given value' '
+	test_must_fail git config pull.rebase=false true 2>err &&
+	test_grep "did you mean .git config set pull\\.rebase true." err
+'
+
+test_expect_success 'misplaced "=" in key: set subcommand uses given value' '
+	test_must_fail git config set pull.rebase=false true 2>err &&
+	test_grep "did you mean .git config set pull\\.rebase true." err
+'
+
+test_expect_success 'misplaced "=" in key: set with single arg hints' '
+	test_must_fail git config set pull.rebase=false 2>err &&
+	test_grep "wrong number of arguments" err &&
+	test_grep "did you mean .git config set pull\\.rebase false." err
+'
+
+test_expect_success 'misplaced "=" in key: explicit --get does not hint' '
+	test_must_fail git config --get pull.rebase=false 2>err &&
+	test_grep "invalid key: pull\\.rebase=false" err &&
+	test_grep ! "did you mean" err
+'
+
+test_expect_success 'misplaced "=" in key: get subcommand does not hint' '
+	test_must_fail git config get pull.rebase=false 2>err &&
+	test_grep ! "did you mean" err
+'
+
+test_expect_success 'misplaced "=" in key: unset subcommand does not hint' '
+	test_must_fail git config unset pull.rebase=false 2>err &&
+	test_grep ! "did you mean" err
+'
+
+test_expect_success 'misplaced "=" in key: value with whitespace skips hint' '
+	test_must_fail git config set pull.rebase=false "hello world" 2>err &&
+	test_grep "invalid key: pull\\.rebase=false" err &&
+	test_grep ! "did you mean" err
+'
+
+test_expect_success '"=" inside subsection is valid, no hint' '
+	test_when_finished "rm -f subsection.cfg" &&
+	git config set -f subsection.cfg foo.bar=baz.boo qux 2>err &&
+	test_grep ! "did you mean" err &&
+	echo qux >expect &&
+	git config get -f subsection.cfg foo.bar=baz.boo >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'correct key' '
 	git config 123456.a123 987
 '

base-commit: 6a4418c36d6bad69a599044b3cf49dcbd049cb45
-- 
gitgitgadget
