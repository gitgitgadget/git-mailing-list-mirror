Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46331C4321E
	for <git@archiver.kernel.org>; Sat, 26 Nov 2022 14:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiKZOSR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Nov 2022 09:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiKZOSJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Nov 2022 09:18:09 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143162018A
        for <git@vger.kernel.org>; Sat, 26 Nov 2022 06:18:02 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id h11so3177811wrw.13
        for <git@vger.kernel.org>; Sat, 26 Nov 2022 06:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRd1ZryOj8z1WOgE+0YVHKmZ9EImRYyLeSbEzNpQk5o=;
        b=qaj5UhmZ6Jtt1laIdqaq9ClMe/5n/i2I6NBM4K0sXSBXVV0QShqXksz6VKYK3NE1ew
         6BTDR69XnN1V7URpO4/KjtAuEaFp56N5fNexJmcg2mKOSXxD1UoF5nS54YQGK5Ebr7Xf
         QwTTetm9f7CYGhlOlgtvl4fl4IxmN+J5CEVvtOrjns+2QgSXE7G5A38Bi7lm1wmRL+9t
         e5VYGp6ctFURIS+zwybLoRFG0/D8UopTZOpzBFUoGf83KormXI99wFiQLs89Danu+1cD
         Inu2S4L7bX0t87apvS18Da0taNiC77Xfwv6M6S5PK6hRgqBCp/QC9aWpg8ONOyAmFT3d
         nCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oRd1ZryOj8z1WOgE+0YVHKmZ9EImRYyLeSbEzNpQk5o=;
        b=aT8akLDTnNtUUubpqQaGN1564R868AEw/6R6xceeu7uyX4oF7Zg/Mx694V0XCICcAg
         ykFwOp46jS7+9TZC2KrcFKbqjPfiuNyjLegziVRHf77uncDYcVNG5H3BncYFQ/eoglgY
         gdoBvGbZNG0PyikVBloSYZkP3T08nJ9Z02erXs8Cf4Jo5j2LD/Rh7/ZnvOMbdk07xnYL
         rXEFdh3l4Y/9ZzanL+4jttxLSKlVu1QOAElekKAiRHsD4dmsX/WGP7ZyTDVOxSV7HV30
         WZ/CxCAmsW1fCd7d0sj6leNY005yPpsBT4NinJJVb04XgvdWduLSYElTeWR2EEepdjtb
         IumQ==
X-Gm-Message-State: ANoB5pmZjdp/U6QCqXHEqiwNwc8FpLEq5hHeQDAjtagXfK3CkYKX5P6A
        /MJYFDWqwgb5M0NdkuXy6oOCaJo5DgA=
X-Google-Smtp-Source: AA0mqf7ok2VffVPjils4QVvT/0ysIA019bzjGtcoBkJcCFxIfiJtBqtPDb1aKFjBp6LNHBZgQcOFJA==
X-Received: by 2002:a05:6000:1046:b0:241:fa2d:debc with SMTP id c6-20020a056000104600b00241fa2ddebcmr9161352wrx.12.1669472280354;
        Sat, 26 Nov 2022 06:18:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d5-20020a05600c3ac500b003cfe6fd7c60sm8613207wms.8.2022.11.26.06.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 06:17:59 -0800 (PST)
Message-Id: <3d8bf3662fe92e61805a1d9ffbccf7a17b3d1e8c.1669472277.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1434.v3.git.1669472277.gitgitgadget@gmail.com>
References: <pull.1434.v2.git.1669395151.gitgitgadget@gmail.com>
        <pull.1434.v3.git.1669472277.gitgitgadget@gmail.com>
From:   "Sean Allred via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 26 Nov 2022 14:17:57 +0000
Subject: [PATCH v3 2/2] var: allow GIT_EDITOR to return null
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sean Allred <code@seanallred.com>,
        Sean Allred <allred.sean@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sean Allred <allred.sean@gmail.com>

The handling to die early when there is no EDITOR is valuable when
used in normal code (i.e., editor.c). In git-var, where
null/empty-string is a perfectly valid value to return, it doesn't
make as much sense.

Remove this handling from `git var GIT_EDITOR` so that it does not
fail so noisily when there is no defined editor.

Signed-off-by: Sean Allred <allred.sean@gmail.com>
---
 builtin/var.c      |  7 +-----
 t/t0007-git-var.sh | 62 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 6 deletions(-)

diff --git a/builtin/var.c b/builtin/var.c
index 5cbe32ec890..a1a2522126f 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -11,12 +11,7 @@ static const char var_usage[] = "git var (-l | <variable>)";
 
 static const char *editor(int flag)
 {
-	const char *pgm = git_editor();
-
-	if (!pgm && flag & IDENT_STRICT)
-		die("Terminal is dumb, but EDITOR unset");
-
-	return pgm;
+	return git_editor();
 }
 
 static const char *pager(int flag)
diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
index e56f4b9ac59..433d242897c 100755
--- a/t/t0007-git-var.sh
+++ b/t/t0007-git-var.sh
@@ -5,6 +5,12 @@ test_description='basic sanity checks for git var'
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
+sane_unset_all_editors () {
+	sane_unset GIT_EDITOR &&
+	sane_unset VISUAL &&
+	sane_unset EDITOR
+}
+
 test_expect_success 'get GIT_AUTHOR_IDENT' '
 	test_tick &&
 	echo "$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE" >expect &&
@@ -47,6 +53,62 @@ test_expect_success 'get GIT_DEFAULT_BRANCH with configuration' '
 	)
 '
 
+test_expect_success 'get GIT_EDITOR without configuration' '
+	(
+		sane_unset_all_editors &&
+		test_expect_code 1 git var GIT_EDITOR >out &&
+		test_must_be_empty out
+	)
+'
+
+test_expect_success 'get GIT_EDITOR with configuration' '
+	test_config core.editor foo &&
+	(
+		sane_unset_all_editors &&
+		echo foo >expect &&
+		git var GIT_EDITOR >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'get GIT_EDITOR with environment variable GIT_EDITOR' '
+	(
+		sane_unset_all_editors &&
+		echo bar >expect &&
+		GIT_EDITOR=bar git var GIT_EDITOR >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'get GIT_EDITOR with environment variable EDITOR' '
+	(
+		sane_unset_all_editors &&
+		echo bar >expect &&
+		EDITOR=bar git var GIT_EDITOR >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'get GIT_EDITOR with configuration and environment variable GIT_EDITOR' '
+	test_config core.editor foo &&
+	(
+		sane_unset_all_editors &&
+		echo bar >expect &&
+		GIT_EDITOR=bar git var GIT_EDITOR >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'get GIT_EDITOR with configuration and environment variable EDITOR' '
+	test_config core.editor foo &&
+	(
+		sane_unset_all_editors &&
+		echo foo >expect &&
+		EDITOR=bar git var GIT_EDITOR >actual &&
+		test_cmp expect actual
+	)
+'
+
 # For git var -l, we check only a representative variable;
 # testing the whole output would make our test too brittle with
 # respect to unrelated changes in the test suite's environment.
-- 
gitgitgadget
