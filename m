Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0561839EC
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 23:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711409160; cv=none; b=QPLDZn3wzvXqXtKhpdfJAqVkOdyaBpDoyeHUyaHOY7KCzOUgYWh1tQNT8GK2SctVnBWz63VRlY363ZF6GEwvqb32X9cRHdj4jnp4J1HT/5WUOLwHbdXwXh34GHJmjH/7HkM9hPxv6lY4UnVcnufz596DM6129tppWUJY3Z9TlVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711409160; c=relaxed/simple;
	bh=ZhQ85xADd0/ZHE19/tnDGV5cl+2uE1utK1xTFeSCg6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FSYI2lSPDDo5PgylCtH9Yoofn/hr4gst6YcFcJNzscV6yzw4rdI1wJ63TLBEFeVWTwz+WH6Hb+v4vhatsrXUB39UtyBlGsgpKL2rUFzKhBqwNM/ONq7jCnAAywQG/0/H472N8v1+qIY0ROcCWo0IAyjkxgiXcyvccxAy+R82RIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAKqbhNa; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAKqbhNa"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e6b01c3dc3so2896129a34.2
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 16:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711409157; x=1712013957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+iz49xF6CT0aWg9ZEEUZ7ajs+zK39LqP1prwOpiZwLY=;
        b=iAKqbhNaIG7TjhVlVMdXGjeXhLfVBF5tIX/JVlN0H3XTvABCQR/hQ1hAPLliC/cY8b
         Kak9+LSbXQ4o+duIhJMRVX8Ma/lE5qurpHMFSZOCDfjQXaCZLr587Zz//P71ozcsXunD
         wAPCX4M1Rx6Sglpm4syT0wJQ1VAEXdw7XijX790AJzgeMv/0WJv/eaJJS/zoif+lBx/F
         yGqdfFatxb7t1evxpHDrQJIZ0d3bE5gL6vUdxJASmXJaXkYVClsuveumqTgIM4Y8C2y8
         iPurvyRBfJCiODx3+KdQJamH6DrPnUGlKuLe1Db9Bf0XypyKfGgGa2dP/rcEOratIbhG
         CJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711409157; x=1712013957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+iz49xF6CT0aWg9ZEEUZ7ajs+zK39LqP1prwOpiZwLY=;
        b=GzsZzes+1/eFIb1DZ2Rfo6o046ckSfmlzWGz+Xi3wugCCoSkXOiRHFWRLsn0MhBDe1
         N3/+pcdk5Bd5kYmyQUuvu+fMbZyyVS6mfozJ+xaXcmeoIlccVmdqLe/oVqct8zE4vdkQ
         w3uKfC9jKc2D+KulnS/LQeq9r4n4ueUcvB2thA4IWwPD03E/5C/jfgzX7sAXdIoeFVqM
         Gvu+CoELRP7hLJ5SNf9/WBwFoUZA1eKTgyzIEgnBiLjo489majSdOoU5EjIotzhjXdjQ
         lCwKRCW68p/PaWMpo9xBEQulT4PN/ZrcLZXrM5LV0uS05KXSty2QIal1sdg/Zhkrlkxv
         m0jA==
X-Gm-Message-State: AOJu0YzO5TEFKcuuQDN/GHJEkOsba7S6M41kFHUU1RO2/HdtqcY4a0ea
	zejQTLfpXRbER+wG3IKEjJGoZuk3EPx2bcYmX32GWRnX9Zu+7jsoGUqeMxDtTcA=
X-Google-Smtp-Source: AGHT+IHzR5et+sk7LpciCQXLaPBUvxzRi+wYgTTcBXMNlk8Xf4ooPgud39jcXW0JadtCVGEQVGQ+tQ==
X-Received: by 2002:a05:6870:a413:b0:220:bf55:b12a with SMTP id m19-20020a056870a41300b00220bf55b12amr10472467oal.38.1711409156947;
        Mon, 25 Mar 2024 16:25:56 -0700 (PDT)
Received: from localhost.localdomain (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id vp8-20020a056871a00800b0022a1d794bb8sm1454868oab.22.2024.03.25.16.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 16:25:56 -0700 (PDT)
From: Brian Lyles <brianmlyles@gmail.com>
To: git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>,
	newren@gmail.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com
Subject: [PATCH v5 3/7] rebase: update `--empty=ask` to `--empty=stop`
Date: Mon, 25 Mar 2024 18:16:50 -0500
Message-ID: <20240325232451.963946-4-brianmlyles@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240119060721.3734775-2-brianmlyles@gmail.com>
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When git-am(1) got its own `--empty` option in 7c096b8d61 (am: support
--empty=<option> to handle empty patches, 2021-12-09), `stop` was used
instead of `ask`. `stop` is a more accurate term for describing what
really happens, and consistency is good.

Update git-rebase(1) to also use `stop`, while keeping `ask` as a
deprecated synonym. Update the tests to primarily use `stop`, but also
ensure that `ask` is still allowed.

In a future commit, we'll be adding a new `--empty` option for
git-cherry-pick(1) as well, making the consistency even more relevant.

Reported-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
---
 Documentation/git-rebase.txt | 15 ++++++++-------
 builtin/rebase.c             | 16 ++++++++++------
 t/t3424-rebase-empty.sh      | 21 ++++++++++++++++-----
 3 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 0b0d0ccb80..67dd0a533e 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -289,23 +289,24 @@ See also INCOMPATIBLE OPTIONS below.
 +
 See also INCOMPATIBLE OPTIONS below.
 
---empty=(ask|drop|keep)::
+--empty=(drop|keep|stop)::
 	How to handle commits that are not empty to start and are not
 	clean cherry-picks of any upstream commit, but which become
 	empty after rebasing (because they contain a subset of already
 	upstream changes):
 +
 --
-`ask`;;
-	The rebase will halt when the commit is applied, allowing you to
-	choose whether to drop it, edit files more, or just commit the empty
-	changes. This option is implied when `-i`/`--interactive` is
-	specified.
 `drop`;;
 	The commit will be dropped. This is the default behavior.
 `keep`;;
 	The commit will be kept. This option is implied when `--exec` is
 	specified unless `-i`/`--interactive` is also specified.
+`stop`;;
+`ask`;;
+	The rebase will halt when the commit is applied, allowing you to
+	choose whether to drop it, edit files more, or just commit the empty
+	changes. This option is implied when `-i`/`--interactive` is
+	specified. `ask` is a deprecated synonym of `stop`.
 --
 +
 Note that commits which start empty are kept (unless `--no-keep-empty`
@@ -711,7 +712,7 @@ be dropped automatically with `--no-keep-empty`).
 Similar to the apply backend, by default the merge backend drops
 commits that become empty unless `-i`/`--interactive` is specified (in
 which case it stops and asks the user what to do).  The merge backend
-also has an `--empty=(ask|drop|keep)` option for changing the behavior
+also has an `--empty=(drop|keep|stop)` option for changing the behavior
 of handling commits that become empty.
 
 Directory rename detection
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 5b086f651a..a4916781ce 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -58,7 +58,7 @@ enum empty_type {
 	EMPTY_UNSPECIFIED = -1,
 	EMPTY_DROP,
 	EMPTY_KEEP,
-	EMPTY_ASK
+	EMPTY_STOP
 };
 
 enum action {
@@ -951,10 +951,14 @@ static enum empty_type parse_empty_value(const char *value)
 		return EMPTY_DROP;
 	else if (!strcasecmp(value, "keep"))
 		return EMPTY_KEEP;
-	else if (!strcasecmp(value, "ask"))
-		return EMPTY_ASK;
+	else if (!strcasecmp(value, "stop"))
+		return EMPTY_STOP;
+	else if (!strcasecmp(value, "ask")) {
+		warning(_("--empty=ask is deprecated; use '--empty=stop' instead."));
+		return EMPTY_STOP;
+	}
 
-	die(_("unrecognized empty type '%s'; valid values are \"drop\", \"keep\", and \"ask\"."), value);
+	die(_("unrecognized empty type '%s'; valid values are \"drop\", \"keep\", and \"stop\"."), value);
 }
 
 static int parse_opt_keep_empty(const struct option *opt, const char *arg,
@@ -1133,7 +1137,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 				 "instead of ignoring them"),
 			      1, PARSE_OPT_HIDDEN),
 		OPT_RERERE_AUTOUPDATE(&options.allow_rerere_autoupdate),
-		OPT_CALLBACK_F(0, "empty", &options, "(drop|keep|ask)",
+		OPT_CALLBACK_F(0, "empty", &options, "(drop|keep|stop)",
 			       N_("how to handle commits that become empty"),
 			       PARSE_OPT_NONEG, parse_opt_empty),
 		OPT_CALLBACK_F('k', "keep-empty", &options, NULL,
@@ -1550,7 +1554,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	if (options.empty == EMPTY_UNSPECIFIED) {
 		if (options.flags & REBASE_INTERACTIVE_EXPLICIT)
-			options.empty = EMPTY_ASK;
+			options.empty = EMPTY_STOP;
 		else if (options.exec.nr > 0)
 			options.empty = EMPTY_KEEP;
 		else
diff --git a/t/t3424-rebase-empty.sh b/t/t3424-rebase-empty.sh
index 73ff35ced2..1ee6b00fd5 100755
--- a/t/t3424-rebase-empty.sh
+++ b/t/t3424-rebase-empty.sh
@@ -72,6 +72,17 @@ test_expect_success 'rebase --merge --empty=keep' '
 	test_cmp expect actual
 '
 
+test_expect_success 'rebase --merge --empty=stop' '
+	git checkout -B testing localmods &&
+	test_must_fail git rebase --merge --empty=stop upstream &&
+
+	git rebase --skip &&
+
+	test_write_lines D C B A >expect &&
+	git log --format=%s >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'rebase --merge --empty=ask' '
 	git checkout -B testing localmods &&
 	test_must_fail git rebase --merge --empty=ask upstream &&
@@ -101,9 +112,9 @@ test_expect_success 'rebase --interactive --empty=keep' '
 	test_cmp expect actual
 '
 
-test_expect_success 'rebase --interactive --empty=ask' '
+test_expect_success 'rebase --interactive --empty=stop' '
 	git checkout -B testing localmods &&
-	test_must_fail git rebase --interactive --empty=ask upstream &&
+	test_must_fail git rebase --interactive --empty=stop upstream &&
 
 	git rebase --skip &&
 
@@ -112,7 +123,7 @@ test_expect_success 'rebase --interactive --empty=ask' '
 	test_cmp expect actual
 '
 
-test_expect_success 'rebase --interactive uses default of --empty=ask' '
+test_expect_success 'rebase --interactive uses default of --empty=stop' '
 	git checkout -B testing localmods &&
 	test_must_fail git rebase --interactive upstream &&
 
@@ -194,9 +205,9 @@ test_expect_success 'rebase --exec uses default of --empty=keep' '
 	test_cmp expect actual
 '
 
-test_expect_success 'rebase --exec --empty=ask' '
+test_expect_success 'rebase --exec --empty=stop' '
 	git checkout -B testing localmods &&
-	test_must_fail git rebase --exec "true" --empty=ask upstream &&
+	test_must_fail git rebase --exec "true" --empty=stop upstream &&
 
 	git rebase --skip &&
 
-- 
2.43.2

