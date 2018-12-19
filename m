Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,URIBL_DBL_SPAM shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 500951F405
	for <e@80x24.org>; Wed, 19 Dec 2018 18:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729672AbeLSSlE (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 13:41:04 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38967 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729538AbeLSSlE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Dec 2018 13:41:04 -0500
Received: by mail-qk1-f195.google.com with SMTP id q70so12282600qkh.6
        for <git@vger.kernel.org>; Wed, 19 Dec 2018 10:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QrfzOjvzB0+8emoqtVdOhF66R+mythtWz0i9HuohYXY=;
        b=W74MhOr0/8lV/Gqw/gh/DnZ1Gsww5eq1Wa6ztjKHodLSvJdf90muWYTwAy/GiqbuYW
         wqIp3fKpQYBspZsf0K1qZoYmEri4ltS1CqHroZ/NSOKmaayi5MQ+o5BauLXUd07sZniT
         gMY8lKCAkucHJY+gzhKWbApuJ6FYTU7xAk30ipPeqfeMIOlm9fuJH3QU7NugTjmW+0xl
         szuqseLGHW0dqey5pg6+dtFpX/NcL8WhiG0iLCC23/BJDW81lDmQlQjTi50MB80DjH+t
         +xlFBGtaA2cpsyA+UAAGYK6CbvueZdvkB/HljofHTbfz+HDqWSuimuoW2Q+u262EV0BI
         wOnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=QrfzOjvzB0+8emoqtVdOhF66R+mythtWz0i9HuohYXY=;
        b=mkoTAUapahMw5KwkNYKK116WgFP3xttdbFpr5IoL2VUzohySjkCbjKGP7wkGaWyh4G
         TABIe65tWfndI9n5B+j4rYQ2qWFRDYOVpH0k7ZsmelzecJ2MRaWodSgUm8M+OA+7yZQK
         Gv/kN4wi+UzBOcfXri1EptYq5il6GQOPMCZdA93wWro83NDq4aQigHvTtJbTsIJyZ3mx
         sNcyRIA1h8ZlGlVR9jzfWREzmY+PB2VveyQuQcMIN3hBvHrhZCdHvV9jesHjt+GuIarD
         UD2QNTsaRU4ihutEVnBp5Q/HyD0zAnKS528ryO8utX+dj0iKGwfPrUfqWPCMAbadpkd6
         Zytw==
X-Gm-Message-State: AA+aEWaTrR6KgWfKJ5Vhtv679d02U6PfallzwjVNaCRt3iLXpHtWRE6Y
        Y7fY0FvyizqMzmHkjZrx0duwQaFA
X-Google-Smtp-Source: AFSGD/XXbifnJbkKxjF6zZQJLLrzf8G8hwv+t4pYueVW8hG/i7f5Z/xRn4iEJWBR4xrCWdwq9b0sdw==
X-Received: by 2002:a37:b2c2:: with SMTP id b185mr20981790qkf.194.1545244862802;
        Wed, 19 Dec 2018 10:41:02 -0800 (PST)
Received: from whubbs1.gaikai.biz ([100.42.103.5])
        by smtp.gmail.com with ESMTPSA id i73sm1907442qke.80.2018.12.19.10.41.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 10:41:02 -0800 (PST)
Received: (nullmailer pid 16413 invoked by uid 1000);
        Wed, 19 Dec 2018 18:41:01 -0000
From:   William Hubbs <williamh@gentoo.org>
To:     git@vger.kernel.org
Cc:     williamh@gentoo.org, chutzpah@gentoo.org
Subject: [PATCH 1/1]     Add author and committer configuration settings
Date:   Wed, 19 Dec 2018 12:39:39 -0600
Message-Id: <20181219183939.16358-2-williamh@gentoo.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181219183939.16358-1-williamh@gentoo.org>
References: <20181219183939.16358-1-williamh@gentoo.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

    The author.email, author.name, committer.email and committer.name
    settings are analogous to the GIT_AUTHOR_* and GIT_COMMITTER_*
    environment variables, but for the git config system. This allows them
    to be set separately for each repository.

Signed-off-by: William Hubbs <williamh@gentoo.org>
---
 Documentation/config/user.txt | 20 +++++++++++
 builtin/commit.c              |  2 +-
 cache.h                       |  5 ++-
 config.c                      |  6 ++++
 ident.c                       | 68 ++++++++++++++++++++++++++++++++---
 log-tree.c                    |  3 +-
 sequencer.c                   |  3 +-
 7 files changed, 97 insertions(+), 10 deletions(-)

diff --git a/Documentation/config/user.txt b/Documentation/config/user.txt
index b5b2ba1199..6ba7002252 100644
--- a/Documentation/config/user.txt
+++ b/Documentation/config/user.txt
@@ -1,3 +1,23 @@
+author.email::
+Your email address to be recorded on the author line of any newly
+created commits.
+If this is not set, we use user.email.
+
+author.name::
+Your full name to be recorded on the author line of any newly
+created commits.
+If this is not set, we use user.name.
+
+committer.email::
+Your email address to be recorded on the committer line of any newly
+created commits.
+If this is not set, we use user.email.
+
+committer.name::
+Your full name to be recorded on the committer line of any newly
+created commits.
+If this is not set, we use user.name.
+
 user.email::
 	Your email address to be recorded in any newly created commits.
 	Can be overridden by the `GIT_AUTHOR_EMAIL`, `GIT_COMMITTER_EMAIL`, and
diff --git a/builtin/commit.c b/builtin/commit.c
index c021b119bb..49a97adeb8 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -607,7 +607,7 @@ static void determine_author_info(struct strbuf *author_ident)
 		set_ident_var(&date, strbuf_detach(&date_buf, NULL));
 	}
 
-	strbuf_addstr(author_ident, fmt_ident(name, email, date, IDENT_STRICT));
+	strbuf_addstr(author_ident, fmt_ident(name, email, date, IDENT_STRICT|IDENT_AUTHOR));
 	assert_split_ident(&author, author_ident);
 	export_one("GIT_AUTHOR_NAME", author.name_begin, author.name_end, 0);
 	export_one("GIT_AUTHOR_EMAIL", author.mail_begin, author.mail_end, 0);
diff --git a/cache.h b/cache.h
index ca36b44ee0..0ee87f22a9 100644
--- a/cache.h
+++ b/cache.h
@@ -1479,10 +1479,13 @@ int date_overflows(timestamp_t date);
 #define IDENT_STRICT	       1
 #define IDENT_NO_DATE	       2
 #define IDENT_NO_NAME	       4
+#define IDENT_AUTHOR          8
+#define IDENT_COMMITTER       16
+
 extern const char *git_author_info(int);
 extern const char *git_committer_info(int);
 extern const char *fmt_ident(const char *name, const char *email, const char *date_str, int);
-extern const char *fmt_name(const char *name, const char *email);
+extern const char *fmt_committer_name(void);
 extern const char *ident_default_name(void);
 extern const char *ident_default_email(void);
 extern const char *git_editor(void);
diff --git a/config.c b/config.c
index ff521eb27a..4bd5920dea 100644
--- a/config.c
+++ b/config.c
@@ -1484,6 +1484,12 @@ int git_default_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (starts_with(var, "author."))
+		return git_ident_config(var, value, cb);
+
+	if (starts_with(var, "committer."))
+		return git_ident_config(var, value, cb);
+
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
 }
diff --git a/ident.c b/ident.c
index 33bcf40644..3da96ebbef 100644
--- a/ident.c
+++ b/ident.c
@@ -11,6 +11,10 @@
 static struct strbuf git_default_name = STRBUF_INIT;
 static struct strbuf git_default_email = STRBUF_INIT;
 static struct strbuf git_default_date = STRBUF_INIT;
+static struct strbuf git_author_name = STRBUF_INIT;
+static struct strbuf git_author_email = STRBUF_INIT;
+static struct strbuf git_committer_name = STRBUF_INIT;
+static struct strbuf git_committer_email = STRBUF_INIT;
 static int default_email_is_bogus;
 static int default_name_is_bogus;
 
@@ -361,7 +365,15 @@ const char *fmt_ident(const char *name, const char *email,
 	int strict = (flag & IDENT_STRICT);
 	int want_date = !(flag & IDENT_NO_DATE);
 	int want_name = !(flag & IDENT_NO_NAME);
+	int want_author = (flag & IDENT_AUTHOR);
+	int want_committer = (flag & IDENT_COMMITTER);
 
+	if (!email) {
+		if (want_author && git_author_email.len)
+			email = git_author_email.buf;
+		else if (want_committer && git_committer_email.len)
+			email = git_committer_email.buf;
+	}
 	if (!email) {
 		if (strict && ident_use_config_only
 		    && !(ident_config_given & IDENT_MAIL_GIVEN)) {
@@ -377,6 +389,12 @@ const char *fmt_ident(const char *name, const char *email,
 
 	if (want_name) {
 		int using_default = 0;
+		if (!name) {
+			if (want_author && git_author_name.len)
+				name = git_author_name.buf;
+			else if (want_committer && git_committer_name.len)
+				name = git_committer_name.buf;
+		}
 		if (!name) {
 			if (strict && ident_use_config_only
 			    && !(ident_config_given & IDENT_NAME_GIVEN)) {
@@ -425,9 +443,11 @@ const char *fmt_ident(const char *name, const char *email,
 	return ident.buf;
 }
 
-const char *fmt_name(const char *name, const char *email)
+const char *fmt_committer_name(void)
 {
-	return fmt_ident(name, email, NULL, IDENT_STRICT | IDENT_NO_DATE);
+	char *name = getenv("GIT_COMMITTER_NAME");
+	char *email = getenv("GIT_COMMITTER_EMAIL");
+	return fmt_ident(name, email, NULL, IDENT_STRICT | IDENT_NO_DATE|IDENT_COMMITTER);
 }
 
 const char *git_author_info(int flag)
@@ -439,7 +459,7 @@ const char *git_author_info(int flag)
 	return fmt_ident(getenv("GIT_AUTHOR_NAME"),
 			 getenv("GIT_AUTHOR_EMAIL"),
 			 getenv("GIT_AUTHOR_DATE"),
-			 flag);
+			 flag|IDENT_AUTHOR);
 }
 
 const char *git_committer_info(int flag)
@@ -451,7 +471,7 @@ const char *git_committer_info(int flag)
 	return fmt_ident(getenv("GIT_COMMITTER_NAME"),
 			 getenv("GIT_COMMITTER_EMAIL"),
 			 getenv("GIT_COMMITTER_DATE"),
-			 flag);
+			 flag|IDENT_COMMITTER);
 }
 
 static int ident_is_sufficient(int user_ident_explicitly_given)
@@ -480,6 +500,46 @@ int git_ident_config(const char *var, const char *value, void *data)
 		return 0;
 	}
 
+	if (!strcmp(var, "author.name")) {
+		if (!value)
+			return config_error_nonbool(var);
+		strbuf_reset(&git_author_name);
+		strbuf_addstr(&git_author_name, value);
+		author_ident_explicitly_given |= IDENT_NAME_GIVEN;
+		ident_config_given |= IDENT_NAME_GIVEN;
+		return 0;
+	}
+
+	if (!strcmp(var, "author.email")) {
+		if (!value)
+			return config_error_nonbool(var);
+		strbuf_reset(&git_author_email);
+		strbuf_addstr(&git_author_email, value);
+		author_ident_explicitly_given |= IDENT_MAIL_GIVEN;
+		ident_config_given |= IDENT_MAIL_GIVEN;
+		return 0;
+	}
+
+	if (!strcmp(var, "committer.name")) {
+		if (!value)
+			return config_error_nonbool(var);
+		strbuf_reset(&git_committer_name);
+		strbuf_addstr(&git_committer_name, value);
+		committer_ident_explicitly_given |= IDENT_NAME_GIVEN;
+		ident_config_given |= IDENT_NAME_GIVEN;
+		return 0;
+	}
+
+	if (!strcmp(var, "committer.email")) {
+		if (!value)
+			return config_error_nonbool(var);
+		strbuf_reset(&git_committer_email);
+		strbuf_addstr(&git_committer_email, value);
+		committer_ident_explicitly_given |= IDENT_MAIL_GIVEN;
+		ident_config_given |= IDENT_MAIL_GIVEN;
+		return 0;
+	}
+
 	if (!strcmp(var, "user.name")) {
 		if (!value)
 			return config_error_nonbool(var);
diff --git a/log-tree.c b/log-tree.c
index 10680c139e..6760a2e9c4 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -687,8 +687,7 @@ void show_log(struct rev_info *opt)
 	 */
 	if (ctx.need_8bit_cte >= 0 && opt->add_signoff)
 		ctx.need_8bit_cte =
-			has_non_ascii(fmt_name(getenv("GIT_COMMITTER_NAME"),
-					       getenv("GIT_COMMITTER_EMAIL")));
+			has_non_ascii(fmt_committer_name());
 	ctx.date_mode = opt->date_mode;
 	ctx.date_mode_explicit = opt->date_mode_explicit;
 	ctx.abbrev = opt->diffopt.abbrev;
diff --git a/sequencer.c b/sequencer.c
index e1a4dd15f1..f357defda5 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4036,8 +4036,7 @@ void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag)
 	int has_footer;
 
 	strbuf_addstr(&sob, sign_off_header);
-	strbuf_addstr(&sob, fmt_name(getenv("GIT_COMMITTER_NAME"),
-				getenv("GIT_COMMITTER_EMAIL")));
+	strbuf_addstr(&sob, fmt_committer_name());
 	strbuf_addch(&sob, '\n');
 
 	if (!ignore_footer)
-- 
2.19.2

