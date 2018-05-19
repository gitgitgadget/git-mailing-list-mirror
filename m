Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FA401F51C
	for <e@80x24.org>; Sat, 19 May 2018 04:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751860AbeESE2R (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 May 2018 00:28:17 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37062 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750743AbeESE2E (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 May 2018 00:28:04 -0400
Received: by mail-lf0-f67.google.com with SMTP id r2-v6so16787262lff.4
        for <git@vger.kernel.org>; Fri, 18 May 2018 21:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZXBMZD8z+AxXdgRgnWOQzhPMKgKVyFwqUnpWdO0hawc=;
        b=Hmfj1uXDbS+SqdIZA6fj9MWQ50QN652AfiN4/xByV2AYvY3Qlh8VWaOHTAvBvyKvNy
         ktQVBf46ZSnD3s6UXlBoWnN2tANXdG31qvnCqFja0wexb1RL4TNfoUFqiajDI7AUd7T9
         6IZDbXXPeARdE9C1Oulzh5DbUNaYpNxw+3xcuaQEPyH7xA7eXPe1aT6+qLCFGuiUozNm
         O5SSNZnRdiB88BiO40EaxLeBdu08O7zALyiBFlzOBQzQ2NfmyLP9umcjolX0nS5e3S+0
         EbDnUNRNHcBGNnN4zun4G51hNcOQvkaWHf24Z3dz1vvkH04G2h7zdg2v7cVq0o3Gt+W8
         jxiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZXBMZD8z+AxXdgRgnWOQzhPMKgKVyFwqUnpWdO0hawc=;
        b=qJ+ZMA1jmqso8QldJHCxmSfujJxedR77EBYG5h5BNrL11f4XkST+14DB3kcvG9XIEo
         hpQcz/uYo7PsMBQpmm7z2N6+6K7Abn/8+NJHIcB1qB+DptsF4k38liiPGd+NqdLVpznZ
         YEqWf1NodtcjLPhl2F610rsb95C7vEjH2BbyPwqbrc662XUmMfQ9NHlLxInWo0K1ZmsZ
         x8KYsgD67n2DagBONYwBZHUahxzvOOgimfHAo92MALoRxOdBPAOgc3rsnOrZ9jSIqXG/
         G0FN1U+96n5nDJp3mQsGxsESMc0Z+1r5s4iRd8q4cF+NHJ46/l7e2y4MqDaqPNxqoghv
         IKYQ==
X-Gm-Message-State: ALKqPwfoWuHpIqnPlM8QG4ITu/RN6rwwbSH4+o2LVdgZ0spI8Znsphl+
        egZ9BrrztRyEM/1YGQxetcUuEw==
X-Google-Smtp-Source: AB8JxZqAv432NEoZBUrawGRyZDodzUni3WiXAu7u1xyJEAxczk+XK2sAr/lSpVJFB4fv9/Rqj6zGrw==
X-Received: by 2002:a19:9a10:: with SMTP id c16-v6mr23635411lfe.60.1526704082665;
        Fri, 18 May 2018 21:28:02 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o11-v6sm1960309lfi.14.2018.05.18.21.28.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 May 2018 21:28:01 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 05/14] git.c: convert --list-* to --list-cmds=*
Date:   Sat, 19 May 2018 06:27:43 +0200
Message-Id: <20180519042752.8666-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180519042752.8666-1-pclouds@gmail.com>
References: <20180519042752.8666-1-pclouds@gmail.com>
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
 contrib/completion/git-completion.bash |  2 +-
 git.c                                  | 37 +++++++++++++++++++++-----
 t/t0012-help.sh                        |  2 +-
 3 files changed, 33 insertions(+), 8 deletions(-)

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

