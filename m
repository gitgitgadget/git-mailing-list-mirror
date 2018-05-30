Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA65F1F42D
	for <e@80x24.org>; Wed, 30 May 2018 21:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932462AbeE3VHj (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 17:07:39 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55380 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932321AbeE3VHi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 17:07:38 -0400
Received: by mail-wm0-f67.google.com with SMTP id a8-v6so50169763wmg.5
        for <git@vger.kernel.org>; Wed, 30 May 2018 14:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wrxqX6cP/E8M8QlI4itUjLGD9jLJL0t44oPIXd9ewuo=;
        b=c9D4TIpFzs/TvKsN5BrSc3SyNyx1w/3AtnXsjCCfvQpCIxuerrHErwp8RtIf5gPxGD
         LxbBWDZcFGFwOClbeqH4LiVQ4degMZFl9Nl7VEtu5WK8ugMDxYvcYUFbWmV1N9ZjqJpm
         yBRinX1RiscnjJXE6n8Bn2TXo2lFThB+z7RXEQp4PoOV7Hmi07J0z8urEQOrDYStF3UK
         TLS5M8dNQ92vBzVz8X8Ed0XaOdOva2a4iFbHDg9XJDaMBvFYCHK3W4H4G2n1lAFMyAVE
         XL47aYNyjHNg1N6p0ZfOKE2r50nIf4JFzBQwaYCmEFFXllpfexCw/Ukz1e+7IjTvWLZI
         YEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wrxqX6cP/E8M8QlI4itUjLGD9jLJL0t44oPIXd9ewuo=;
        b=YFAnJgBCYpatcs7rTBycnT0V1FUfbb3NWvB4Mn/0i9HBMIxb/lgJJCnKWe+sJqz9Q/
         0IUwwgagKZGd78ECIZiGIsH77GWmCzZAG25qZBWrkDSAfgxKQqIUbafnAS0iqF37h1Pu
         rEqZU4EIXzp29xycE+MaeHdAbx9Cgc7r18z44UgxtBWu5QpfEEGT1fsq0dwXwyEJIk8o
         uxEEBShXWqSTLWxhkxUXJSCB1Q20Ct2CRvTg1dvEwYzJrT9Hm64sdZ0FBqMvYM2xkMnj
         KFkXjBjLu6Ocdu9pxxmuWOlDfX3IfKL7BB9XxcI7V6aJWIhM9ajEwjMjv8jW4T5Y5UJm
         nH+g==
X-Gm-Message-State: ALKqPwfkPNtCIjGkpOh1E3q8s+3XjFD22Vj0Y/qdSQmLZjHK0g6eQTOo
        d+nM1lUcUIYq4c3sPPFhRWtcULEp
X-Google-Smtp-Source: ADUXVKKjlKSye8Cips9Py4y3ROC9oZpjFFCNvIhu4kRa0L1hreZrppmfv+HCJbOrE0U3g82TkYeLCA==
X-Received: by 2002:a1c:8f8f:: with SMTP id r137-v6mr2407127wmd.103.1527714456916;
        Wed, 30 May 2018 14:07:36 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id o16-v6sm18237097wri.67.2018.05.30.14.07.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 May 2018 14:07:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 4/4] color.ui config: add "isatty" setting
Date:   Wed, 30 May 2018 21:06:41 +0000
Message-Id: <20180530210641.19771-5-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180530210641.19771-1-avarab@gmail.com>
References: <20180530210641.19771-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A co-worker of mine who was using UNIX systems when dinosaurs roamed
the earth was lamenting that kids these days were using tools like
"git" that thought they knew better than isatty(3) when deciding
whether or not something was a terminal, and the state of the
documentation fixed earlier in this series certainly didn't help.

So this setting is a small gift to all the UNIX graybeards out
there. Now they can set color.ui=isatty and only emit fancy colors in
situations when the gods of old intended, not whatever heuristic we've
decided to set "auto" to.

As noted here this is *currently* the same as setting color.ui=auto &
color.pager=false, but I think it's good to explicitly have this
setting for any future changes. The reason, as now noted in the
documentation is that the "auto" setting may become even smarter in
the future and learn even deeper heuristics for when to turn itself on
even if isatty(3) were returning true.

At that point the fans of plain isatty(3) will become even more upset
at what we're doing, so let's give them a simple future-proof opt-out.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt | 10 ++++++++++
 color.c                  | 12 ++++++++----
 color.h                  |  1 +
 t/t7006-pager.sh         | 15 +++++++++++++++
 4 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index b882a88214..183569786f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1292,6 +1292,16 @@ color.ui::
 	determined by a call to `isatty(3)`) or to a pager (unless
 	`color.pager` is set to false).
 +
+If you don't like the magic of `auto` and prefer for git to just ask
+`isatty(3)` whether it's connected to a terminal set this to
+`isatty`. This will cause it to always obey that function, except
+(like `auto`) if `TERM=dumb` is set in the environment. Currently this
+is equivalent to setting `auto` and `color.pager=false`, but in the
+future `auto` may be smart enough to handle other cases, i.e. when
+`isatty(3)` returns `1` but something else other than `TERM=dumb`
+suggests the terminal can't handle colors or not. If you'd like to
+avoid all that magic use `isatty`.
++
 Setting this to some value unknown to git will warn and fall back to
 `auto`. This is so that new values can be recognized in the future
 without the git configuration file being incompatible between versions
diff --git a/color.c b/color.c
index e52c6cdd29..05f95649bc 100644
--- a/color.c
+++ b/color.c
@@ -306,6 +306,8 @@ int git_config_colorbool(const char *var, const char *value)
 			return 1;
 		if (!strcasecmp(value, "auto"))
 			return GIT_COLOR_AUTO;
+		if (!strcasecmp(value, "isatty"))
+			return GIT_COLOR_ISATTY;
 	}
 
 	if (!var)
@@ -332,13 +334,14 @@ int git_config_colorbool(const char *var, const char *value)
 	return GIT_COLOR_AUTO;
 }
 
-static int check_auto_color(int fd)
+static int check_auto_color(int fd, int isatty_only)
 {
 	static int color_stderr_is_tty = -1;
 	int *is_tty_p = fd == 1 ? &color_stdout_is_tty : &color_stderr_is_tty;
 	if (*is_tty_p < 0)
 		*is_tty_p = isatty(fd);
-	if (*is_tty_p || (fd == 1 && pager_in_use() && pager_use_color)) {
+	if (*is_tty_p || (!isatty_only && fd == 1 && pager_in_use() &&
+			  pager_use_color)) {
 		if (!is_terminal_dumb())
 			return 1;
 	}
@@ -359,9 +362,10 @@ int want_color_fd(int fd, int var)
 	if (var < 0)
 		var = git_use_color_default;
 
-	if (var == GIT_COLOR_AUTO) {
+	if (var == GIT_COLOR_AUTO || var == GIT_COLOR_ISATTY) {
+		int isatty_only = var == GIT_COLOR_ISATTY;
 		if (want_auto[fd] < 0)
-			want_auto[fd] = check_auto_color(fd);
+			want_auto[fd] = check_auto_color(fd, isatty_only);
 		return want_auto[fd];
 	}
 	return var;
diff --git a/color.h b/color.h
index 5b744e1bc6..01d8cc01a5 100644
--- a/color.h
+++ b/color.h
@@ -57,6 +57,7 @@ struct strbuf;
 #define GIT_COLOR_NEVER  0
 #define GIT_COLOR_ALWAYS 1
 #define GIT_COLOR_AUTO   2
+#define GIT_COLOR_ISATTY 3
 
 /* A default list of colors to use for commit graphs and show-branch output */
 extern const char *column_colors_ansi[];
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index b16f2ac28b..ea4f2f47d0 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -309,6 +309,13 @@ test_expect_success 'no color when stdout is a regular file' '
 	! colorful colorless.log
 '
 
+test_expect_success 'no color when stdout is a regular file (isatty)' '
+	rm -f colorless.log &&
+	test_config color.ui isatty &&
+	git log >colorless.log &&
+	! colorful colorless.log
+'
+
 test_expect_success 'unknown color.ui values default to "auto" (regular file)' '
 	rm -f colorless.log &&
 	test_config color.ui doesnotexist &&
@@ -340,6 +347,14 @@ test_expect_success TTY 'colors are suppressed by color.pager' '
 	! colorful paginated.out
 '
 
+test_expect_success TTY 'colors are suppressed by color.ui=isatty when writing to a pager' '
+	rm -f paginated.out &&
+	test_config color.ui isatty &&
+	test_config color.pager true &&
+	test_terminal git log &&
+	! colorful paginated.out
+'
+
 test_expect_success 'color when writing to a file intended for a pager' '
 	rm -f colorful.log &&
 	test_config color.ui auto &&
-- 
2.17.0.290.gded63e768a

