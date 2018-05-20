Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 057CB1F51C
	for <e@80x24.org>; Sun, 20 May 2018 18:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752522AbeETSlJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 14:41:09 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:42110 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751310AbeETSk1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 14:40:27 -0400
Received: by mail-lf0-f65.google.com with SMTP id b18-v6so20771143lfa.9
        for <git@vger.kernel.org>; Sun, 20 May 2018 11:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=njJwA/pxfKu01g9lBASD49cXznDEewPIO7RJEdHO+lA=;
        b=nRW8MfMaotZHUv9ZMxfnm7/D6rnjbBVswjNEv5ZHUVB17uMWFe/v0148ycQzyWdk4t
         iNda9bvyku7Rbt2DiH7QRZ7tjqPUPUqyTh6RHgmaSOhs9HHft7d5mt5/w88AVcxM9uZr
         fQelpP2wPzxCjMBax06bAeuZazCFT1w1C7MMjcFMPlQ3xMLyX+H4suGOY3foY/6h7+Iz
         lBGGRxTvUMCaHc81CSDs6bYZKNeExB4n0mNtzUMXKBNl5o4QxUEzglSsQuk2MkzwNiIW
         DoDMSQ8XjuLCA5PYvt5YUAqNbzj4E/R94HP50ikVoX0Z4+ggzQ936bA98nLoY6WlleWB
         k56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=njJwA/pxfKu01g9lBASD49cXznDEewPIO7RJEdHO+lA=;
        b=lQpHRpHppFfrTlQIh6LHAkMLdxZqgClE/w1TY9/oOzoRARGj9MEx3EeCGq1108m0o+
         GQF+dC/soq8Rkk3wtSlwGF11auWo6Gjn1rc+EDJ1FdXZN/+S0z3OB9AYRwY1ywYR80jM
         FVGZeoRX0QbxYLRnIealBLM6RVbJ/ErRyrEuIb15mNF+hyR8PBt200IAfwEUasB8vHxy
         juFVkFvlTWdX8ic2DJqP4QaFtJAV/0R9/bUqJaJw5LfKvK7McarSb7X2dJBmrzLvu9QD
         sjsnovjI0LPQ0ddFrFWZzeJzjy+q9dsQHK6R/6e8PYhyz87IdCSMS5ma3XegyuD946AR
         /YEw==
X-Gm-Message-State: ALKqPweQGMD9jectAQM8QaGVfUm8OG2nCa1Sa/gyk8FCXxAIEmcAE8U7
        Sh5ka2mLq95ebn6Rqu42I405Og==
X-Google-Smtp-Source: AB8JxZrkhIYQEkloo7F8050vOgeem4xbfFyQNbEOO2IY2kgszjazVAyw4CrW6gOFBh7cBLIkrehmZw==
X-Received: by 2002:a19:7d05:: with SMTP id y5-v6mr6869861lfc.95.1526841626070;
        Sun, 20 May 2018 11:40:26 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id k5-v6sm2176906lji.39.2018.05.20.11.40.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 May 2018 11:40:25 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 05/17] git.c: convert --list-* to --list-cmds=*
Date:   Sun, 20 May 2018 20:39:57 +0200
Message-Id: <20180520184009.976-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180520184009.976-1-pclouds@gmail.com>
References: <20180519042752.8666-1-pclouds@gmail.com>
 <20180520184009.976-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Even if these are hidden options, let's make them a bit more generic
since we're introducing more listing types shortly. The code is
structured to allow combining multiple listing types together because
we will soon add more types the 'builtins'.

'parseopt' remains separate because it has separate (SPC) to match
git-completion.bash needs and will not combine with others.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git.txt                  |  6 +++++
 contrib/completion/git-completion.bash |  2 +-
 git.c                                  | 37 +++++++++++++++++++++-----
 t/t0012-help.sh                        |  2 +-
 4 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 4767860e72..2800e3d188 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -163,6 +163,12 @@ foo.bar= ...`) sets `foo.bar` to the empty string which `git config
 	Do not perform optional operations that require locks. This is
 	equivalent to setting the `GIT_OPTIONAL_LOCKS` to `0`.
 
+--list-cmds=group[,group...]::
+	List commands by group. This is an internal/experimental
+	option and may change or be removed in the future. Supported
+	groups are: builtins, parseopt (builtin commands that use
+	parse-options).
+
 GIT COMMANDS
 ------------
 
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a757073945..3556838759 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3049,7 +3049,7 @@ __git_complete_common () {
 __git_cmds_with_parseopt_helper=
 __git_support_parseopt_helper () {
 	test -n "$__git_cmds_with_parseopt_helper" ||
-		__git_cmds_with_parseopt_helper="$(__git --list-parseopt-builtins)"
+		__git_cmds_with_parseopt_helper="$(__git --list-cmds=parseopt)"
 
 	case " $__git_cmds_with_parseopt_helper " in
 	*" $1 "*)
diff --git a/git.c b/git.c
index 3a89893712..cd85355d81 100644
--- a/git.c
+++ b/git.c
@@ -38,6 +38,30 @@ static int use_pager = -1;
 
 static void list_builtins(unsigned int exclude_option, char sep);
 
+static int match_token(const char *spec, int len, const char *token)
+{
+	int token_len = strlen(token);
+
+	return len == token_len && !strncmp(spec, token, token_len);
+}
+
+static int list_cmds(const char *spec)
+{
+	while (*spec) {
+		const char *sep = strchrnul(spec, ',');
+		int len = sep - spec;
+
+		if (match_token(spec, len, "builtins"))
+			list_builtins(0, '\n');
+		else
+			die(_("unsupported command listing type '%s'"), spec);
+		spec += len;
+		if (*spec == ',')
+			spec++;
+	}
+	return 0;
+}
+
 static void commit_pager_choice(void) {
 	switch (use_pager) {
 	case 0:
@@ -223,12 +247,13 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			}
 			(*argv)++;
 			(*argc)--;
-		} else if (!strcmp(cmd, "--list-builtins")) {
-			list_builtins(0, '\n');
-			exit(0);
-		} else if (!strcmp(cmd, "--list-parseopt-builtins")) {
-			list_builtins(NO_PARSEOPT, ' ');
-			exit(0);
+		} else if (skip_prefix(cmd, "--list-cmds=", &cmd)) {
+			if (!strcmp(cmd, "parseopt")) {
+				list_builtins(NO_PARSEOPT, ' ');
+				exit(0);
+			} else {
+				exit(list_cmds(cmd));
+			}
 		} else {
 			fprintf(stderr, _("unknown option: %s\n"), cmd);
 			usage(git_usage_string);
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index c096f33505..3c91a9024a 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -59,7 +59,7 @@ test_expect_success 'git help' '
 '
 
 test_expect_success 'generate builtin list' '
-	git --list-builtins >builtins
+	git --list-cmds=builtins >builtins
 '
 
 while read builtin
-- 
2.17.0.705.g3525833791

