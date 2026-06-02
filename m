Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BF03E277E
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 13:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780407563; cv=none; b=ZKGr7KNaL0HSA+kuEfZ1yhlDQ2Rq5nJ7sm9sC8xzOpbvyjOQQupO7czG9vWxFCBZ1OdMDqlY3B1SVDwg2HaZ73ZVNBA56IzK82WhxKBxY3G75QiBe04a68wG3x3N6h6tynq7fKNvDB2O6Lf89d2QfcpUpN6wsbS3KsT/JFLEyOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780407563; c=relaxed/simple;
	bh=Yhkm41s+NGhN4iQRpsSc5ZS6BHb3uTqQ+XxpxznteGg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LCB6eVucCMWuDtGJ8OO20i69q1PywV5fw4wfq+FBHl+XpSaW9u0LrIKDKPcc6V2F0zRN3b5t6God1n4ZEfm83w3cPb5uFJ/gXjF8QOSxNsQwc/PltDYv5lvcYLOfg52H7V+gLesinZEsMKA8FBU2zFTiXa6/jF22HAODpWC3Njo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OrpnkGlp; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OrpnkGlp"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-91563abd6a9so101557285a.3
        for <git@vger.kernel.org>; Tue, 02 Jun 2026 06:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780407561; x=1781012361; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DRXap3L+1j/bNAIio+5mV9Fo+kIm0DZ4u93AO10Gmg=;
        b=OrpnkGlp6ELjYkYO2gvDzYAGlWwuF6cZ9yeU2jpObgC7lfw8nwq3oM5ja4NDVZL6Z8
         XV7rH9joGCMOTb9kag0/q84F7pGclL4n+Ck8xX/QI5fSAfA137oiQkssjGAA0oiSZvGj
         /jSwccYrvhSgDxQXQGXDvKvEsn96OcV5JOHzEmLfSKGUI3rMZTA0RvVMgUiY3hJTUue9
         iYou+hkapg7IrltvsglcoOLIH78UVSQZ8GuVVXIWFU9fXAhPFVGXsIwMHpsnCcR92TsL
         mXZPEyihgPAmNnBH5KnF75R7BrGxJ2RtD/ocZ1agvDwmNSTD4Z93saoKTq2RYFJZM9L/
         MojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780407561; x=1781012361;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7DRXap3L+1j/bNAIio+5mV9Fo+kIm0DZ4u93AO10Gmg=;
        b=Jqfa9I3AsUrL58p+UB8lJ6fYggfmPv/ia6zm5Kwjntojj5jamKAFEJBankByuWXPv/
         zddYBldw/skOpdvsCL3rtKilL3e2w5zQGHBEHOLGUTOFDzWEKzx1ZvqLh7iLN2mR3rHt
         pYAzJxmO0BTLVuksX7RPbCPALLnaGoTHc+PwTINIuYugb3HvPuG4/ku3UufnI8ZXrDyk
         FviWVbnoqBuyPQgC3h1YkTPojULjC49HgPgfkip0mxHZ73+eo1etI0K0rE3P93q6OY+K
         +Fj1O1gHMw2VORLn1Vm5BYLLbGjScNa9mrKaxZBROCT9rdgq1m2K9XzjzhQxvwxDpQMD
         T0ow==
X-Gm-Message-State: AOJu0YybM9yboab2LZdBy+5WyerrG8k/QYlOGVALUGqWd+rR2mVuPIvJ
	J/SlEMoi1VsJvRsLSb/4vnULpOJ1dESuqWBVLPsZaQOAIJKjt5zR106s3tquTA==
X-Gm-Gg: Acq92OHlvTJjMssDDULhFJjJW1lR/tSatW+v1s0Ike9cMfB1nP7FrjWQS3HpgYn1pV6
	8sFeEqShqQCrR7cv0K4cRq7aOOC3veq7zKGTQIQK3xgfNLWaEIF6UNIAgezlx4oW+187lzBzYvC
	9l3ESRdeLszeiyWrTyPShWAGr/syWjAQRsHIA6CwEACkprRNrbmlnHce2bMK2EwlqZhngmLJXP7
	pH9yVDfYldhvc9X9by9Zp4D7UdGnJjYnWc5Zv/n2aAmh5NCrQiSEO9yZA+62TEdt/cd03CDpDJp
	H4/fTbbIx5X9zwelwceWyKgZlXteKpTFNZIaxgMq1H8/PwMssmUcKUH4WOztH9la6h6YDLArhWT
	kkjauxqEORD35fpBNWOoxpuw27RGB/FPMk7LZ+bTWZ0DEYjQm/G03e1JLv+/vc9ucf8zR+vD/24
	XaoVTGH3cUSGtRBncw59lQJWK9/QolCMebxyA=
X-Received: by 2002:a05:620a:29c2:b0:915:83fa:b3e0 with SMTP id af79cd13be357-91583fabf36mr165648785a.5.1780407560969;
        Tue, 02 Jun 2026 06:39:20 -0700 (PDT)
Received: from [127.0.0.1] ([48.214.53.83])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91566f4abf3sm447963885a.27.2026.06.02.06.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 06:39:20 -0700 (PDT)
Message-Id: <e5a2070ee1598bc345556b4afd01ae6d40fab633.1780407557.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2302.v5.git.git.1780407557.gitgitgadget@gmail.com>
References: <pull.2302.v4.git.git.1779823288005.gitgitgadget@gmail.com>
	<pull.2302.v5.git.git.1780407557.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 02 Jun 2026 13:39:17 +0000
Subject: [PATCH v5 2/2] config: improve diagnostic for "set" with missing
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
 t/t1300-config.sh | 55 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/builtin/config.c b/builtin/config.c
index b3188cd8d4..a2d46d0ce1 100644
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
+	if (prefix && !git_config_parse_key(prefix, NULL, NULL, 1)) {
+		error(_("missing value to set to the variable '%s'"), arg);
+		advise(_("did you mean \"git config set %s %s\"?"),
+		       prefix, eq + 1);
+	} else if (!git_config_parse_key(arg, NULL, NULL, 1)) {
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
index 11fc976f3a..ed122d1100 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -469,6 +469,61 @@ test_expect_success 'invalid key' '
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
