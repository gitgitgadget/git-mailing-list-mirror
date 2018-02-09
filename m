Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F20D51F576
	for <e@80x24.org>; Fri,  9 Feb 2018 11:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752416AbeBILGW (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 06:06:22 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45860 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752159AbeBILGV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 06:06:21 -0500
Received: by mail-pl0-f67.google.com with SMTP id p5so1314962plo.12
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 03:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NSa6lPeZz1fb12/YI7IhjF7Uo/g89HIzysWS3Gse68w=;
        b=EkL/w3kyYDJI9gwgKcqkGY/z/u5dn2KmUF55hCZpyEuf0KO7gA2lWh6PQCbqaYqnQm
         fGK7dnGNt7WeI1ump0SHXmlUwPjWWtZAuDNZUfRwVQ0mdwUulqqIs1cuk0eDRL6mEEJ4
         788BIWo8NYQToBxXalQV+tI0JbCs69s9zxasI3CyujOXmUejjXchNAvmD3svgt2Q1uuD
         S5uEE1CfRJkDtKlACL5jHppKHVZUX9vTKYOQwv4DYSGmtZk+QQMZBwvf0oFKYlZuQ1nM
         8/JOI/Wpcab8hbWkYfNUfjQb2SCZB5RdFktv8V8HMqPok2Xqywr5QkfPozcDgVOsKCWU
         FeGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NSa6lPeZz1fb12/YI7IhjF7Uo/g89HIzysWS3Gse68w=;
        b=dKdZWa9CkK+Fu5dUEa/BP1dGCLqwonIcbPpb/fUmXUakcTdDkVibGPDBvDIXpAI4S9
         kFdpL7fTS3I8tnYaJZpQec9BMBvrmKMFXYciNlCuNOwWqL4ToniCP63cEAglSG/APGJD
         mwQg/sKUHreiMcB4NE/OQoP3YKgvKEf9ntqLzPcUNh7DVVh1PqOpkSTgqgSgZDVEr3rw
         8QQsh2JUGI46N0aeJwr7IU2gXk4fiB+u7SxiDfyER8X5h2Wu8eUzuB+lzcG2q6ZbdaWO
         JXlJvGuG9ZBV+39YINjXghaHxEw4oTlERnZ3EjobQ+LB6jFVAKZ69JfKE7jopVj1T9EP
         OksQ==
X-Gm-Message-State: APf1xPDzR0r/DBg4zNv16NHPNMFnhtuCOhjjziJmT2T3gLeAme5C/QBh
        NmE7VDff7ex7yKT0wS0g8thfhA==
X-Google-Smtp-Source: AH8x225KP2y1ymJ6b9ZhxzqdipQPjuUZvbrurr3jIwwAARNzSo584hIu3uMe1SCjG1scjAMLOOc0MA==
X-Received: by 2002:a17:902:7889:: with SMTP id q9-v6mr2247990pll.114.1518174380557;
        Fri, 09 Feb 2018 03:06:20 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id z5sm4782490pge.11.2018.02.09.03.06.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 03:06:20 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 09 Feb 2018 18:06:15 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 42/42] git-completion.bash: add GIT_COMPLETION_OPTIONS=all config
Date:   Fri,  9 Feb 2018 18:02:21 +0700
Message-Id: <20180209110221.27224-43-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.207.gedba492059
In-Reply-To: <20180209110221.27224-1-pclouds@gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com>
 <20180209110221.27224-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By default, some option names (mostly --force, scripting related or for
internal use) are not completable for various reasons. When
GIT_COMPLETION_OPTIONS is set to all, all options (except hidden ones)
are completable.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash |  6 +++++-
 parse-options.c                        | 11 +++++++----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0ddf40063b..0cfa489a8e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -36,6 +36,10 @@
 #
 #     When set to "1", do not include "DWIM" suggestions in git-checkout
 #     completion (e.g., completing "foo" when "origin/foo" exists).
+#
+#   GIT_COMPLETION_OPTIONS
+#
+#     When set to "all", complete all possible options
 
 case "$COMP_WORDBREAKS" in
 *:*) : great ;;
@@ -303,7 +307,7 @@ __gitcomp_builtin ()
 	if [ -z "$options" ]; then
 		# leading and trailing spaces are significant to make
 		# option removal work correctly.
-		options=" $(__git ${cmd/_/ } --git-completion-helper) $incl "
+		options=" $(__git ${cmd/_/ } --git-completion-helper=$GIT_COMPLETION_OPTIONS) $incl "
 		for i in $excl; do
 			options="${options/ $i / }"
 		done
diff --git a/parse-options.c b/parse-options.c
index 979577ba2c..5b8b2b376e 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -430,14 +430,17 @@ void parse_options_start(struct parse_opt_ctx_t *ctx,
  * many options that do not suppress it properly.
  */
 static int show_gitcomp(struct parse_opt_ctx_t *ctx,
-			const struct option *opts)
+			const struct option *opts,
+			const char *arg)
 {
 	for (; opts->type != OPTION_END; opts++) {
 		const char *suffix = "";
 
 		if (!opts->long_name)
 			continue;
-		if (opts->flags & (PARSE_OPT_HIDDEN | PARSE_OPT_NOCOMPLETE))
+		if (opts->flags & PARSE_OPT_HIDDEN)
+			continue;
+		if ((opts->flags & PARSE_OPT_NOCOMPLETE) && strcmp(arg, "all"))
 			continue;
 
 		switch (opts->type) {
@@ -498,8 +501,8 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 			goto show_usage;
 
 		/* lone --git-completion-helper is asked by git-completion.bash */
-		if (ctx->total == 1 && !strcmp(arg + 1, "-git-completion-helper"))
-			return show_gitcomp(ctx, options);
+		if (ctx->total == 1 && skip_prefix(arg + 1, "-git-completion-helper=", &arg))
+			return show_gitcomp(ctx, options, arg);
 
 		if (arg[1] != '-') {
 			ctx->opt = arg + 1;
-- 
2.16.1.207.gedba492059

