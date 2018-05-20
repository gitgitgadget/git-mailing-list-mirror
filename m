Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63C3A1F51C
	for <e@80x24.org>; Sun, 20 May 2018 18:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751678AbeETSks (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 14:40:48 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36087 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751434AbeETSkj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 14:40:39 -0400
Received: by mail-lf0-f65.google.com with SMTP id e9-v6so3859415lfb.3
        for <git@vger.kernel.org>; Sun, 20 May 2018 11:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e7uwwhx9bWvaMgump4vmgAZRNAd6GqTKm1EsgU4vnTc=;
        b=Jt24K6cjlCpYGUMGDcPKdNe6HBmuS2HuurijBC8t8zKOrJPKnHchd3uleG3q+Pm1AV
         Rdk/CLl1dp7hPV3pBgr/ZL79Ba6j2UsxmBt23VsalIjM3MRwh6X3aOiN5ez6xZ8/liv/
         0P7wTv8JFr3SwUA5wtIMw+dG9sdj1puo5EHcDYx5bo64MTex7zylT8QXUj8QwRAL+pUz
         vhT1a1BCU3bNcXKQ1JdC+ZMzFzEehmS93vGnvlOw4WF2+V6aZjAX1U5oIIT+jih9G4Zu
         9HIxFWCgfYr2ktzwPMSeXCAbHzQtNLgG36naisLg8O3XpkRyy8+mmUJs3oXteAGS56HY
         5mTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e7uwwhx9bWvaMgump4vmgAZRNAd6GqTKm1EsgU4vnTc=;
        b=ecOMIHJkzDKf+OBkIY/jKG67hysgSZuWoUuXv9Y5bV7yVABAe3XiuOPE9u+lZD5qhy
         NFtBkWJpYHWY8MqSElctDp+LGW0STmAvWaMyhIxOFIo+kgUgVlet9XNUbqacbmc5srp2
         JMm1LO/Kat8AwICUfatYDStSPp39RrHpvcEVqPbmzNlOygWXzd04Y1hML8HL29Awrsb8
         yDFBIu5mlo5T3lMJN+D/w6k4dRiDefo8Mksk6ElOniCjpcTcdSKJYYctnrVVR/U6k07o
         PVxBgKmofSrIJmEblogHxrQzP9B11Me48eL/CMr7n9+2Li1e4iFwI/gnsC/myDg6h/tp
         gkQQ==
X-Gm-Message-State: ALKqPwea2qlsz5o0LlLcXxNgYZu2mxCA8T87wCmHfrEwDxuWwh3LPvEz
        Z5vmJUrsKqyh1W71iyPi9L0Q9w==
X-Google-Smtp-Source: AB8JxZrwglGva77Fpl8UB4YzQ1e9JuUeL2sCI2U+SCh2iNvfCNfIKBJyBtdKEUqb5/0UruBSEtUwHA==
X-Received: by 2002:a19:d894:: with SMTP id r20-v6mr23118283lfi.7.1526841637164;
        Sun, 20 May 2018 11:40:37 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id k5-v6sm2176906lji.39.2018.05.20.11.40.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 May 2018 11:40:36 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 15/17] completion: add and use --list-cmds=nohelpers
Date:   Sun, 20 May 2018 20:40:07 +0200
Message-Id: <20180520184009.976-16-pclouds@gmail.com>
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

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git.txt                  |  3 ++-
 contrib/completion/git-completion.bash | 20 ++++----------------
 git.c                                  | 14 ++++++++++++++
 3 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index c423810eac..820ab77fcb 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -169,7 +169,8 @@ foo.bar= ...`) sets `foo.bar` to the empty string which `git config
 	groups are: builtins, parseopt (builtin commands that use
 	parse-options), main (all commands in libexec directory),
 	others (all other commands in `$PATH` that have git- prefix),
-	list-<category> (see categories in command-list.txt)
+	list-<category> (see categories in command-list.txt),
+	nohelpers (exclude helper commands).
 
 GIT COMMANDS
 ------------
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index cd1d8e553f..217c8a3d3b 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -843,7 +843,7 @@ __git_commands () {
 		then
 			printf "%s" "$GIT_TESTING_PORCELAIN_COMMAND_LIST"
 		else
-			git --list-cmds=list-mainporcelain,others,list-complete
+			git --list-cmds=list-mainporcelain,others,nohelpers,list-complete
 		fi
 		;;
 	all)
@@ -851,27 +851,15 @@ __git_commands () {
 		then
 			printf "%s" "$GIT_TESTING_ALL_COMMAND_LIST"
 		else
-			git --list-cmds=main,others
+			git --list-cmds=main,others,nohelpers
 		fi
 		;;
 	esac
 }
 
-__git_list_commands ()
-{
-	local i IFS=" "$'\n'
-	for i in $(__git_commands $1)
-	do
-		case $i in
-		*--*)             : helper pattern;;
-		*) echo $i;;
-		esac
-	done
-}
-
 __git_list_all_commands ()
 {
-	__git_list_commands all
+	__git_commands all
 }
 
 __git_all_commands=
@@ -883,7 +871,7 @@ __git_compute_all_commands ()
 
 __git_list_porcelain_commands ()
 {
-	__git_list_commands porcelain
+	__git_commands porcelain
 }
 
 __git_porcelain_commands=
diff --git a/git.c b/git.c
index 19f73b3fa3..f6ae79ffaf 100644
--- a/git.c
+++ b/git.c
@@ -39,6 +39,18 @@ static int use_pager = -1;
 
 static void list_builtins(struct string_list *list, unsigned int exclude_option);
 
+static void exclude_helpers_from_list(struct string_list *list)
+{
+	int i = 0;
+
+	while (i < list->nr) {
+		if (strstr(list->items[i].string, "--"))
+			unsorted_string_list_delete_item(list, i, 0);
+		else
+			i++;
+	}
+}
+
 static int match_token(const char *spec, int len, const char *token)
 {
 	int token_len = strlen(token);
@@ -61,6 +73,8 @@ static int list_cmds(const char *spec)
 			list_all_main_cmds(&list);
 		else if (match_token(spec, len, "others"))
 			list_all_other_cmds(&list);
+		else if (match_token(spec, len, "nohelpers"))
+			exclude_helpers_from_list(&list);
 		else if (len > 5 && !strncmp(spec, "list-", 5)) {
 			struct strbuf sb = STRBUF_INIT;
 
-- 
2.17.0.705.g3525833791

