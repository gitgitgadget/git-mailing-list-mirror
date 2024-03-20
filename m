Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E198624B
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 23:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710977959; cv=none; b=DFjLNoqjFF3prGO57SM0B27BTh8EsIv/VKwRglPeV11DlUgbBpb108ERrAzQ1DaWAyxn+VxZW6UqlOk20skuXgX+VSSSXG52wGcUhF91Ji32jFPs8hHwlRscNF+B74HtMtAGhXamM6SMt8fv2LVSchTHQSjWAaD7ImVMbazdGTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710977959; c=relaxed/simple;
	bh=ZhQ85xADd0/ZHE19/tnDGV5cl+2uE1utK1xTFeSCg6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DmY3D5DGYphgIunfIYU/KRNH9c5J6c0/IavIHEmx9sebfLPc8xMrSXnyeFjCjSGHMdeMGO+bNoAT9V4FoeU15Q+9jMRRhaTgt81wuR2FCsG7vb7lp+96IU1Gzb8On4KtU7cRvDmb8o0x0Qs1u5Ud2gmMStrheWSFCZa4KYBN8QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gmw+JeYw; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gmw+JeYw"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78850ab4075so18742785a.1
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 16:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710977956; x=1711582756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+iz49xF6CT0aWg9ZEEUZ7ajs+zK39LqP1prwOpiZwLY=;
        b=Gmw+JeYwlSK642yX5UtuORqgjQ/Ogps06AGBiEfNJnEakgoPEkprbZ1pv76juAlpaB
         RAJt7XnNKFTQYb0vwDBewoYPkf+/5mXLStQ5ciXp4UrP3l8F6bJIGHS/zG2wSY+gSepN
         LSN2wNmEdXArdxxFfBilpp1k3/3UCke8RLnVFlQqRmwu6dMSETNDAaB0cCtDoMF9DdcJ
         U2R6rUHgU3Uo/Y48PXnUA+wj4Y6oi+uXEkJfU3xGWSz01akNzGCPATN1e7gKmTotlKG7
         B8HHykfpC/TGAetQTy3ir7Gt3FjSsSn5UKQf+4FJvvppc9gDTrDXcLpilJKG7P62dJyQ
         97/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710977956; x=1711582756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+iz49xF6CT0aWg9ZEEUZ7ajs+zK39LqP1prwOpiZwLY=;
        b=VoS9bYmLZLis1QvBWv+TdqUuLpmR/DiPbZG1ednT6gsE/QzRC6HeSiT7PROkgHerkD
         LRQQFJJHdK9i5QJRWQzzX3c1r98bDeW15nOhnmD5ziED0WJFui32OPcPMZsnA77PH88N
         eYPpO2AwKT1iy9Axm+hb10o6r04gmnnYFjGgxSpzc5ncGNaqPAZ7u8GECU+nDOLwUehQ
         S+T8vs1dd4/FLRhIhnP8VgoDXe+AeZl94Me4gAZzX1hFdL3Y90LxzYJuILwIVcKQ81el
         epR9spuksuOK+7jgnzJuvEUGZwLMK1vo5yFOJxID6H8UzXqiilLCee2QX2RIJjnDzBU+
         3XlQ==
X-Gm-Message-State: AOJu0Yxnm4V865+w5EtUvn8F+WSf5EaL3Cc80hgdK3nGqr7LvJ5wuwem
	4LQDMFfQAIWtQ85FXtsxAn/Fd26386Wry/sQjZ264wRvjIDxRdBGf0gRdtq33pQ=
X-Google-Smtp-Source: AGHT+IFnRl1/exSFVhf0YjDP4l5RyEeRElgN+wW5I3hJ39HGWlaxUHxeERpVtbXqUntdoddUhawOrA==
X-Received: by 2002:a05:620a:1342:b0:789:d55a:d10e with SMTP id c2-20020a05620a134200b00789d55ad10emr21217572qkl.52.1710977955795;
        Wed, 20 Mar 2024 16:39:15 -0700 (PDT)
Received: from localhost.localdomain (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id v18-20020a05620a123200b0078a0edbaa94sm2400867qkj.91.2024.03.20.16.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 16:39:15 -0700 (PDT)
From: Brian Lyles <brianmlyles@gmail.com>
To: git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>,
	newren@gmail.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com
Subject: [PATCH v4 3/7] rebase: update `--empty=ask` to `--empty=stop`
Date: Wed, 20 Mar 2024 18:36:58 -0500
Message-ID: <20240320233724.214369-4-brianmlyles@gmail.com>
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

