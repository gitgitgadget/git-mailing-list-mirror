Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5DDC433F5
	for <git@archiver.kernel.org>; Wed,  1 Jun 2022 01:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348965AbiFABQ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 May 2022 21:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240650AbiFABQU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 May 2022 21:16:20 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467B695A0F
        for <git@vger.kernel.org>; Tue, 31 May 2022 18:16:19 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id q21so265320wra.2
        for <git@vger.kernel.org>; Tue, 31 May 2022 18:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ySYb0bPh5yBgtNR4vNC6nrsO4qrJWXNlTwKc+e1X43Y=;
        b=HZekNoRGjNlpHHHzM6LEwxsLC1EhWFJ78Iv30uIlFFEkhvjey99lMi8IDtGiAPm/3A
         ErOUs/c9NxauSg0nIP1JsUKCRcB52cWpJIlfibgDorAQzAIOo9E623aFFH7aOxdLiG1z
         5L1MTxQEbsPH/t6UK56GG0MGisQnteZgm8C3DqGHiKLUF86GoRZvQX7UD8fo1oyrxdUx
         Xsg4kW2cesBgguE7dX1yNnFksbj9ND3WEN7DKCBniS9j/AnV3OP7hl3DQDdzVsepGXPt
         /8iEl23h+DGJyqmidFezAsDEFqWTAXDjVqxKX5gBiH8onst2+2OEag/H5WAcmgzyz8/P
         Ddrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ySYb0bPh5yBgtNR4vNC6nrsO4qrJWXNlTwKc+e1X43Y=;
        b=Ib5Za0elt0VhEEJT4VIa596Ai1Tu9BS2/C7BTyBVavs4xnn2DmgZFJSaZs3sH49rmg
         tE2zPp3PrDR36pSMK0YrHfLKA/lRNknYyrD8bJeWsNfCprHVqdzJKK3lvWYdZ+XdsHl9
         J0VZDq9wQerndJ64yrEDrLhCNOf0XlVu0bVQKh/57AyYOvn1o1hYFCdu5+whUNEgatRn
         V6OldI0JRMuU94fyy6TSz8R1Avez2d9Yde34VAUaNw1omXh4SC9JO18J+EUCLaTwOw0W
         KaQIG5VC236pC+QEbtrqbxKvcAc0mSP20NJJNDwgLEmTltdOaWjJlCI9B0goG7ZC9YRd
         VfGw==
X-Gm-Message-State: AOAM5318GI8c0Ox7eOY35OC5tnlnnKFh8pm/NXoG19XGsSuZXiSA6634
        cwdQY0JE73f/qL6ipyvp4gPG71h2Uuc=
X-Google-Smtp-Source: ABdhPJx5JtXDaPQ1VBxW14yE3poyWMP9QblLmpCEAVq1N5bKwO2in/BCkib7ct1g33G3dS63qW4KvQ==
X-Received: by 2002:a05:6000:160c:b0:210:2a80:195 with SMTP id u12-20020a056000160c00b002102a800195mr14854070wrb.251.1654046177442;
        Tue, 31 May 2022 18:16:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h42-20020a05600c49aa00b003973d425a7fsm318346wmp.41.2022.05.31.18.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 18:16:16 -0700 (PDT)
Message-Id: <8e29ac807c6a0cf94ea3a44ee3304011c2ad159c.1654046173.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1237.v3.git.1654046173.gitgitgadget@gmail.com>
References: <pull.1237.v2.git.1653658034086.gitgitgadget@gmail.com>
        <pull.1237.v3.git.1654046173.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Jun 2022 01:16:13 +0000
Subject: [PATCH v3 2/2] usage: add warn_once() helper for repeated warnings
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, me@ttaylorr.com,
        avarab@gmail.com, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, jrnieder@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Robert Coup <robert.coup@koordinates.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The previous change added a warning when valid_remote() detects
credentials in the URL. Since remotes are validated multiple times per
process, this causes multiple warnings to print.

To avoid these kinds of repeated, advisory warnings, create a new
warn_once() helper that behaves the same as warning(), but only after
formatting the output string and adding it to a strset. If that addition
signals that the string already exists in the strset, then do not print
the warning.

In the case of the credentials in a URL, the existing test demonstrates
this per-process limitation: 'git clone' runs 'git-remote-curl' as a
child process, giving two messages. This is an improvement over the
previous six messages.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 git-compat-util.h |  1 +
 remote.c          |  2 +-
 t/t5601-clone.sh  |  5 ++++-
 usage.c           | 22 ++++++++++++++++++++++
 4 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 58fd813bd01..776a5f660aa 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -526,6 +526,7 @@ int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
 int error_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
 void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
 void warning_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
+void warn_once(const char *warn, ...) __attribute__((format (printf, 1, 2)));
 
 #ifndef NO_OPENSSL
 #ifdef APPLE_COMMON_CRYPTO
diff --git a/remote.c b/remote.c
index accf08bf51f..72fffd0d968 100644
--- a/remote.c
+++ b/remote.c
@@ -60,7 +60,7 @@ static void check_if_creds_in_url(const char *url)
 		      "<redacted>", 10);
 
 	if (!strcmp("warn", value))
-		warning(_("URL '%s' uses plaintext credentials"), redacted.buf);
+		warn_once(_("URL '%s' uses plaintext credentials"), redacted.buf);
 	if (!strcmp("die", value))
 		die(_("URL '%s' uses plaintext credentials"), redacted.buf);
 
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index cba3553b7c4..6ae3eec9eb6 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -75,7 +75,10 @@ test_expect_success 'clone warns or fails when using username:password' '
 	test_must_fail git -c fetch.credentialsInUrl=allow clone https://username:password@localhost attempt1 2>err &&
 	! grep "URL '\''https://username:<redacted>@localhost'\'' uses plaintext credentials" err &&
 	test_must_fail git -c fetch.credentialsInUrl=warn clone https://username:password@localhost attempt1 2>err &&
-	grep "warning: URL '\''https://username:<redacted>@localhost'\'' uses plaintext credentials" err &&
+	grep "warning: URL '\''https://username:<redacted>@localhost'\'' uses plaintext credentials" err >warnings &&
+	# The warning is printed twice, for the two processes:
+	# "git clone" and "git-remote-curl".
+	test_line_count = 2 warnings &&
 	test_must_fail git -c fetch.credentialsInUrl=die clone https://username:password@localhost attempt2 2>err &&
 	grep "fatal: URL '\''https://username:<redacted>@localhost'\'' uses plaintext credentials" err
 '
diff --git a/usage.c b/usage.c
index b738dd178b3..242633c5f8d 100644
--- a/usage.c
+++ b/usage.c
@@ -5,6 +5,7 @@
  */
 #include "git-compat-util.h"
 #include "cache.h"
+#include "strmap.h"
 
 static void vreportf(const char *prefix, const char *err, va_list params)
 {
@@ -287,6 +288,27 @@ void warning(const char *warn, ...)
 	va_end(params);
 }
 
+static struct strset prev_warnings = STRSET_INIT;
+
+void warn_once(const char *warn, ...)
+{
+	char buf[1024];
+	va_list params;
+	va_start(params, warn);
+
+	if (vsnprintf(buf, sizeof(buf), warn, params) >= 0) {
+		if (!strset_add(&prev_warnings, buf)) {
+			va_end(params);
+			return;
+		}
+	}
+	va_end(params);
+
+	va_start(params, warn);
+	warn_routine(warn, params);
+	va_end(params);
+}
+
 /* Only set this, ever, from t/helper/, when verifying that bugs are caught. */
 int BUG_exit_code;
 
-- 
gitgitgadget
