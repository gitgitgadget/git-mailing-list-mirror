Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA9C720248
	for <e@80x24.org>; Sun, 24 Feb 2019 10:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbfBXKL1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 05:11:27 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33731 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbfBXKLX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 05:11:23 -0500
Received: by mail-ed1-f68.google.com with SMTP id c55so5247520edb.0
        for <git@vger.kernel.org>; Sun, 24 Feb 2019 02:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LW/rF5EpX3U/xvmr3B9KFzrTceCR4+8bAW4aFsti+dY=;
        b=skeuvulFT55eVve5jZ2YRB4cnDXMLW4TCSzfcTMGwW0LSXmbkdmGX4z5Y/ciblNC28
         V29g9Wg59obkTwBwA2zL6bOpmgf/S59KsiTXagZAIavMUiDb8djBmiOpLcer+PhzE1bk
         eH18eYXuG0yJqpvBpUKLD2Dym1zz1oOqJxEk5GyPtzu9YZ2y6vjZzEvEcQguGvEMKqn4
         66IYyKN074/BhfmZBj4SX8xY+1bZgB3ioofO3HKF8AK2w9pnFuK27lfkU66LupG8XXNJ
         s60q+sOR8USCrNEdkWU4rQB9/Sl7TPSfMG3KPiNhkk6TyHV6s90TiJnV+KjsRV4MgNQP
         OJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LW/rF5EpX3U/xvmr3B9KFzrTceCR4+8bAW4aFsti+dY=;
        b=f9mmnviBZOFFIWU7ut0WH88teUSUJGBAV3d3OTLca9AviRWRGjjcHhHmzNeL4OosPg
         dHqCtg/D0P2r818bNA0Yh/GHdiAhsnSHxhsxxtUSqcGozsPCRuCDwGLIKkUF+noRQwOr
         Rbn6Gy4KMklCgsc7Wf0gCBr2U8dBZPuh3qhgkx8cgZoIgBRtodJ5BZbHExo/u1s0v7rW
         juhY3WNY73XX18NkJotbuGvyboSTt35NxA6q/KIcW/K+NG+qEpkGbTBG2YM+tGs+sCUP
         1RVDkTI/YzWwHsfRVb8zSLOQxY33pBQoJsy5yyExGF4GsL0NINV7x8I0SFXh9EfkkDDa
         bXNw==
X-Gm-Message-State: AHQUAuYg1Ppx9/BEUR63sOkQqqcHst9NAhNbedjAhEGbifsiMXB4gQkK
        vx1Itz7sS0tMzUjxBXcw9UHxpcSu
X-Google-Smtp-Source: AHgI3IbNqjZs1osF4r9LSOfKJowpnULYtGC1WFmAVfI6zPQR+Zs/pw4XvRtHjyQcnHss1+KsfErmlA==
X-Received: by 2002:aa7:d58e:: with SMTP id r14mr46722edq.39.1551003081325;
        Sun, 24 Feb 2019 02:11:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c5sm1817685edm.36.2019.02.24.02.11.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 02:11:20 -0800 (PST)
Date:   Sun, 24 Feb 2019 02:11:20 -0800 (PST)
X-Google-Original-Date: Sun, 24 Feb 2019 10:10:55 GMT
Message-Id: <7b878b71d57104e4a2db78c74530e982469a9c9a.1551003074.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.117.git.gitgitgadget@gmail.com>
References: <pull.117.git.gitgitgadget@gmail.com>
From:   "Pranit Bauva via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 07/26] bisect.c: libify `check_good_are_ancestors_of_bad` and
 its dependents
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Pranit Bauva <pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

Since we want to get rid of git-bisect.sh it would be necessary to
convert those exit() calls to return statements so that errors can be
reported.

Emulate try catch in C by converting `exit(<positive-value>)` to
`return <negetive-value>`. Follow POSIX conventions to return
<negative-value> to indicate error.

Turn `exit()` to `return` calls in `check_good_are_ancestors_of_bad()`.

In `check_merge_bases()` there is an early success special case,
so we have introduced special error code `-11` which indicates early
success. This `-11` is converted back to `0` in `cmd_bisect_helper()`.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
---
 bisect.c                 | 41 +++++++++++++++++++++++++---------------
 builtin/bisect--helper.c | 12 ++++++++++--
 2 files changed, 36 insertions(+), 17 deletions(-)

diff --git a/bisect.c b/bisect.c
index 1134854fe2..87db1cc4be 100644
--- a/bisect.c
+++ b/bisect.c
@@ -859,17 +859,24 @@ static int check_ancestors(int rev_nr, struct commit **rev, const char *prefix)
  *
  * If that's not the case, we need to check the merge bases.
  * If a merge base must be tested by the user, its source code will be
- * checked out to be tested by the user and we will exit.
+ * checked out to be tested by the user and we will return.
  */
-static void check_good_are_ancestors_of_bad(const char *prefix, int no_checkout)
+static int check_good_are_ancestors_of_bad(const char *prefix, int no_checkout)
 {
 	char *filename = git_pathdup("BISECT_ANCESTORS_OK");
 	struct stat st;
 	int fd, rev_nr, res = 0;
 	struct commit **rev;
 
-	if (!current_bad_oid)
-		die(_("a %s revision is needed"), term_bad);
+	/*
+	 * We don't want to clean the bisection state
+	 * as we need to get back to where we started
+	 * by using `git bisect reset`.
+	 */
+	if (!current_bad_oid) {
+		res = error(_("a %s revision is needed"), term_bad);
+		goto done;
+	}
 
 	/* Check if file BISECT_ANCESTORS_OK exists. */
 	if (!stat(filename, &st) && S_ISREG(st.st_mode))
@@ -884,18 +891,20 @@ static void check_good_are_ancestors_of_bad(const char *prefix, int no_checkout)
 	if (check_ancestors(rev_nr, rev, prefix))
 		res = check_merge_bases(rev_nr, rev, no_checkout);
 	free(rev);
-	if(res)
-		exit(res == -11 ? 0 : -res);
-
-	/* Create file BISECT_ANCESTORS_OK. */
-	fd = open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0600);
-	if (fd < 0)
-		warning_errno(_("could not create file '%s'"),
-			      filename);
-	else
-		close(fd);
+	
+	if (!res)
+	{
+		/* Create file BISECT_ANCESTORS_OK. */
+		fd = open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0600);
+		if (fd < 0)
+			warning_errno(_("could not create file '%s'"),
+				      filename);
+		else
+			close(fd);
+	}
  done:
 	free(filename);
+	return res;
 }
 
 /*
@@ -973,7 +982,9 @@ int bisect_next_all(const char *prefix, int no_checkout)
 	if (read_bisect_refs())
 		die(_("reading bisect refs failed"));
 
-	check_good_are_ancestors_of_bad(prefix, no_checkout);
+	res = check_good_are_ancestors_of_bad(prefix, no_checkout);
+	if (res)
+		return res;
 
 	bisect_rev_setup(&revs, prefix, "%s", "^%s", 1);
 	revs.limited = 1;
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index f441ea85ff..ffb5dbe4b3 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -663,7 +663,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 
 	switch (cmdmode) {
 	case NEXT_ALL:
-		return bisect_next_all(prefix, no_checkout);
+		res = bisect_next_all(prefix, no_checkout);
+		break;
 	case WRITE_TERMS:
 		if (argc != 2)
 			return error(_("--write-terms requires two arguments"));
@@ -710,5 +711,12 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		return error("BUG: unknown subcommand '%d'", cmdmode);
 	}
 	free_terms(&terms);
-	return !!res;
+	/* 
+	 * Handle early success
+	 * From check_merge_bases > check_good_are_ancestors_of_bad > bisect_next_all
+	 */
+	if (res == -11)
+		res = 0;
+
+	return res < 0 ? -res : res;
 }
-- 
gitgitgadget

