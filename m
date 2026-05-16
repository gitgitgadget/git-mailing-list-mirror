Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D14F390C9E
	for <git@vger.kernel.org>; Sat, 16 May 2026 12:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778935979; cv=none; b=ELRgiEt2T5ji5ojiT4xgQqr0oNslwtmFAfxCp/5m5piFrOlqfoVmyWi1kEAuacGvu46u8M2U7QWjzdJJySKbVyGj1AFxGRp3SMxOCMdPQkBn8MJrjN6zCtAGshj6MtzBP7Fkzwe1bvNEzX1bxwCpb5WpcsEt09jCk0CBy8T+W3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778935979; c=relaxed/simple;
	bh=rOvQegWvEFJQ4qbnBHVcQ/YqZDkAmfuJTGhqz+OsSgs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lcJCR16gY8aRPIgUATntaNGFhQqdTOVWoiROKqNIjGB52IiRhWAckxoS+4gbJ1bfpahVGFNYAjbW0Tldou95LhQImXAvaYUwV1p0DROZboDdHZ7bp3aJoc2LgHv7/lpfX9Vk+moffU0u92c/joj21Swb8ik92r5VrGoFOa2u15w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IU5Z95hK; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IU5Z95hK"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5102582e237so9756091cf.2
        for <git@vger.kernel.org>; Sat, 16 May 2026 05:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778935977; x=1779540777; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/pbei3UgPYll3mwEBiFRzU5Ivw7PjwHcG9d/meUAvA=;
        b=IU5Z95hKUlhbUU5tvrVZmD4prNAhXtowpPzxNDu9JskSRhaa/oDK7BpBAr3THsg2JJ
         HypOj6J0wmXqPy0Fc1CowFAzjteK/tRxQpquHUASqi5MH/C24GCzyEC1SVb31zdFdxrI
         E1+pWfeZWCwqejzbTwNvjKA27GMf5dteuJuEXUgcTRUAzjU+rr1tEBhDq8I8U/KpEgPn
         dS4Hy9eVUMgtBDpAIdiOfrD231opTuP6U4ADlenPrwrj7eFlbVmHQ3i49BkoyNu8nrhm
         z25gUbjX91QMCFJvOPdwuaW/0a7iFwO3LG5rxxfGSOouS2ADCsfP+9Yirxpjv5aUvC9E
         k02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778935977; x=1779540777;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R/pbei3UgPYll3mwEBiFRzU5Ivw7PjwHcG9d/meUAvA=;
        b=GNkZlG3gdSS1N+keLbHnMntaZWi7RVDxKA4DvTxwhsJbybneTElWgBrXQG10KGuXvX
         fvh7QD8nhG/YP5HxQrPIN0Qy/fGbB5XOwZn6Dr0BZv+ezfHilHo8u8+WrvDxiZPLp0du
         AupWcMq+nb/3l1S5nDBDbg0DtnVyUBnIxj28P2SIlSQjULkgRcVmTr2qTDjladRuMaXs
         0mLo2rfCJBFSTU6RQ5St+faP8suemHJcrTV+cuaAbgEyC+K7C/XPuGw5QX0NB0LvZuHq
         blE+bMmFMEDdwElW84GeGneofJSqZeZWRmchc+/olk1nNgvqiZ94AE4AqAed+trNh7bh
         zuyg==
X-Gm-Message-State: AOJu0YwkRueX02auBUwONRGxh7gBQtwuZcyyJee7eVKWL1ZfoYA8oyC8
	s10p+DzrOj+t6h6E3TRsh/DfTiu/KcgXBrvBZB2wzlFYBllaWhAVduL+uBQrig==
X-Gm-Gg: Acq92OFYjm1YLLaTKNWnVWPp2ht2+fKt2mduENboKjskw33AnHSZK8MSpoqKI/Kfw72
	mJZO9v9xnETmQL/QovX2AjPZo2x0eZgck4Xt/LgSYlrXX2kuQVEoxjhYrq/caXBmXkufHRz4klO
	KWbNvO2ZRBn55YI0gNWHxnQosP5qHuy9xj6bW6D9c5sQpP1wS2tJqbJdlVyQAkL2SoYs+8SeFas
	HVVdhCcsaEFtkSxR28Di9tBGAuey/vXlTtVaS+Qva0QHvF53ZNWpIUSkfjVu3xVIvtLpliwmhTK
	NPM1mPnwBSeB2T7YNyQJ8BfrkaUNrwPd/aWdZF8EzFTeXCaZs5yERmlCR9Z7TMWbaMHP2OnRfre
	hbQ7XnAaBdLESct5FCAzvmhBj5n0pVr+jGM2iIzfxdwerqLoo1mKDyNDHh1guiEtoWWvXEcPqyg
	OXGaFZR3zn54rV5v3BgaMQSG+DYlJ4EB6OstFr
X-Received: by 2002:ac8:584d:0:b0:516:401d:102c with SMTP id d75a77b69052e-5165a050e8emr111476931cf.21.1778935977217;
        Sat, 16 May 2026 05:52:57 -0700 (PDT)
Received: from [127.0.0.1] ([20.106.231.36])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51645856d4esm71951511cf.27.2026.05.16.05.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 05:52:56 -0700 (PDT)
Message-Id: <pull.2302.v2.git.git.1778935976330.gitgitgadget@gmail.com>
In-Reply-To: <pull.2302.git.git.1778680725459.gitgitgadget@gmail.com>
References: <pull.2302.git.git.1778680725459.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 16 May 2026 12:52:56 +0000
Subject: [PATCH v2] config: suggest the correct form when key contains "=" in
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
---
    config: suggest the correct form when key contains "="
    
     * Hint moved from git_config_parse_key() to a new
       advise_setting_with_equals() in builtin/config.c; wired only into set
       and bare paths.
     * Only fires when = is after the last .; 2-arg forms use the user's
       value.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2302%2FHaraldNordgren%2Fconfig-hint-equals-key-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2302/HaraldNordgren/config-hint-equals-key-v2
Pull-Request: https://github.com/git/git/pull/2302

Range-diff vs v1:

 1:  56eb3ce6fd < -:  ---------- config: suggest the correct form when key contains "="
 -:  ---------- > 1:  40d9eb3e5c config: suggest the correct form when key contains "=" in set context


 builtin/config.c  | 30 ++++++++++++++++++++++++++++++
 t/t1300-config.sh | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/builtin/config.c b/builtin/config.c
index cf4ba0f7cc..f14a30e720 100644
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
@@ -210,6 +211,22 @@ static void check_argc(int argc, int min, int max)
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
+	advise(_("did you mean \"git config set %.*s %s\"?"),
+	       (int)(eq - key), key, value);
+}
+
 static void show_config_origin(const struct config_display_options *opts,
 			       const struct key_value_info *kvi,
 			       struct strbuf *buf)
@@ -1133,6 +1150,11 @@ static int cmd_config_set(int argc, const char **argv, const char *prefix,
 
 	argc = parse_options(argc, argv, prefix, opts, builtin_config_set_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
+	if (argc == 1 && strchr(argv[0], '=')) {
+		error(_("wrong number of arguments, should be 2"));
+		advise_setting_with_equals(argv[0], NULL);
+		exit(129);
+	}
 	check_argc(argc, 2, 2);
 
 	if ((flags & CONFIG_FLAGS_FIXED_VALUE) && !value_pattern)
@@ -1160,6 +1182,8 @@ static int cmd_config_set(int argc, const char **argv, const char *prefix,
 			error(_("cannot overwrite multiple values with a single value\n"
 			"       Use --value=<pattern>, --append or --all to change %s."), argv[0]);
 	}
+	if (ret == CONFIG_INVALID_KEY)
+		advise_setting_with_equals(argv[0], argv[1]);
 
 	location_options_release(&location_opts);
 	free(comment);
@@ -1371,6 +1395,7 @@ static int cmd_config_actions(int argc, const char **argv, const char *prefix)
 	};
 	char *value = NULL, *comment = NULL;
 	int ret = 0;
+	int actions_implicit;
 	struct key_value_info default_kvi = KVI_INIT;
 
 	argc = parse_options(argc, argv, prefix, opts,
@@ -1385,6 +1410,7 @@ static int cmd_config_actions(int argc, const char **argv, const char *prefix)
 		exit(129);
 	}
 
+	actions_implicit = (actions == 0);
 	if (actions == 0)
 		switch (argc) {
 		case 1: actions = ACTION_GET; break;
@@ -1485,6 +1511,8 @@ static int cmd_config_actions(int argc, const char **argv, const char *prefix)
 		if (ret == CONFIG_NOTHING_SET)
 			error(_("cannot overwrite multiple values with a single value\n"
 			"       Use a regexp, --add or --replace-all to change %s."), argv[0]);
+		else if (ret == CONFIG_INVALID_KEY)
+			advise_setting_with_equals(argv[0], argv[1]);
 	}
 	else if (actions == ACTION_SET_ALL) {
 		check_write(&location_opts.source);
@@ -1515,6 +1543,8 @@ static int cmd_config_actions(int argc, const char **argv, const char *prefix)
 		check_argc(argc, 1, 2);
 		ret = get_value(&location_opts, &display_opts, argv[0], argv[1],
 				0, flags);
+		if (ret == CONFIG_INVALID_KEY && actions_implicit)
+			advise_setting_with_equals(argv[0], NULL);
 	}
 	else if (actions == ACTION_GET_ALL) {
 		check_argc(argc, 1, 2);
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 128971ee12..f46c081413 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -462,6 +462,53 @@ test_expect_success 'invalid key' '
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

base-commit: 59ff4886a579f4bc91e976fe18590b9ae02c7a08
-- 
gitgitgadget
