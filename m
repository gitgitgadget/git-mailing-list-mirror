Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A1DF1F51C
	for <e@80x24.org>; Sat, 19 May 2018 04:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750857AbeESE2I (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 May 2018 00:28:08 -0400
Received: from mail-lf0-f53.google.com ([209.85.215.53]:42822 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750797AbeESE2F (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 May 2018 00:28:05 -0400
Received: by mail-lf0-f53.google.com with SMTP id b18-v6so16756699lfa.9
        for <git@vger.kernel.org>; Fri, 18 May 2018 21:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KUMa/4s34NbgmqtA5r7pEwSHwn02XFefZ1BxXnUXuWQ=;
        b=g0dE6zflJSdsFup3DDCZhyJBytAK9tNtlYT/0TwbRqjb23Yiukf2wYW5FetU3iku90
         nkHkT19rl2yjFDjUZaxl7yG1XRbF7IvKBw8OaMz/3jzzA1ckPZ3bOIcSq8t7H2G3jUK4
         vN/AvTn+BKIgnU74zqFQ/OHKdGg1VOIpAlJuYmeaDEYB7AHUWhJp97aSX2Y/KAHfVThY
         HNGvdaJehnSc9q3OjKVFPeZeVBDE3xaDbRGNoawoUR65HS5iJupwEFdVuIC13RNe71GX
         K6S0FbrEisr+8oTqbZaZ5O+t0yPWvx7cjMPvNrcyfm98Ztx+5R0rBuxoHIQJ8aueaBFp
         u30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KUMa/4s34NbgmqtA5r7pEwSHwn02XFefZ1BxXnUXuWQ=;
        b=gUeSTxLwXrnc3zBsCxHsrE1GjeJqMthThLJjN5tJyvlqNPKxbY5QwxC9uuxn65mxwk
         CAI3jEbNb7yvZlzX2P7EIJxqSz1FqumlG8umceNnKzaGe7C2gkn6sqj6aJfEuwsfv9dY
         eemv8II7s3jf+Z9b34l5ZVSkmjNa4donZHyY0uraMb/dXU+Zb/ogRltQNp0l4YFfc6Ua
         ryHKRVPkaGOg+m68V16BX0KFQ7WbtN2P2z/ynuHYFRwdyqQnvI1Vv2WybOZHyxqovFOd
         Krivg2dgFG9Fdu7x2KKrIc/pSFIagC1Ci7Y+Fd3kbpFsb+1QXqGW2UGeI3fK3yItsCQm
         MnIw==
X-Gm-Message-State: ALKqPwd5CijavYkQJd74ZR8xp7WbyGADkrBGl3e0hUjDo8dF/hMhjbft
        arMFfFgKAzAqF2/ceMbvASfaTA==
X-Google-Smtp-Source: AB8JxZrVP4YPfojjVxDpVCaQCCcGNGum2Up3t1NRf87+8NuqtArv6zFB5XY2ws44j2ruYoN+Gr7uOA==
X-Received: by 2002:a19:e10c:: with SMTP id y12-v6mr19743044lfg.9.1526704083724;
        Fri, 18 May 2018 21:28:03 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o11-v6sm1960309lfi.14.2018.05.18.21.28.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 May 2018 21:28:03 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 06/14] git --list-cmds: collect command list in a string_list
Date:   Sat, 19 May 2018 06:27:44 +0200
Message-Id: <20180519042752.8666-7-pclouds@gmail.com>
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

Instead of printing the command directly one by one, keep them in a
list and print at the end. This allows more modification before we
print out (e.g. sorting, removing duplicates or even excluding some
items).

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 git.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/git.c b/git.c
index cd85355d81..376a59b97f 100644
--- a/git.c
+++ b/git.c
@@ -36,7 +36,7 @@ const char git_more_info_string[] =
 
 static int use_pager = -1;
 
-static void list_builtins(unsigned int exclude_option, char sep);
+static void list_builtins(struct string_list *list, unsigned int exclude_option);
 
 static int match_token(const char *spec, int len, const char *token)
 {
@@ -47,18 +47,24 @@ static int match_token(const char *spec, int len, const char *token)
 
 static int list_cmds(const char *spec)
 {
+	struct string_list list = STRING_LIST_INIT_DUP;
+	int i;
+
 	while (*spec) {
 		const char *sep = strchrnul(spec, ',');
 		int len = sep - spec;
 
 		if (match_token(spec, len, "builtins"))
-			list_builtins(0, '\n');
+			list_builtins(&list, 0);
 		else
 			die(_("unsupported command listing type '%s'"), spec);
 		spec += len;
 		if (*spec == ',')
 			spec++;
 	}
+	for (i = 0; i < list.nr; i++)
+		puts(list.items[i].string);
+	string_list_clear(&list, 0);
 	return 0;
 }
 
@@ -249,7 +255,13 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			(*argc)--;
 		} else if (skip_prefix(cmd, "--list-cmds=", &cmd)) {
 			if (!strcmp(cmd, "parseopt")) {
-				list_builtins(NO_PARSEOPT, ' ');
+				struct string_list list = STRING_LIST_INIT_DUP;
+				int i;
+
+				list_builtins(&list, NO_PARSEOPT);
+				for (i = 0; i < list.nr; i++)
+					printf("%s ", list.items[i].string);
+				string_list_clear(&list, 0);
 				exit(0);
 			} else {
 				exit(list_cmds(cmd));
@@ -533,14 +545,14 @@ int is_builtin(const char *s)
 	return !!get_builtin(s);
 }
 
-static void list_builtins(unsigned int exclude_option, char sep)
+static void list_builtins(struct string_list *out, unsigned int exclude_option)
 {
 	int i;
 	for (i = 0; i < ARRAY_SIZE(commands); i++) {
 		if (exclude_option &&
 		    (commands[i].option & exclude_option))
 			continue;
-		printf("%s%c", commands[i].cmd, sep);
+		string_list_append(out, commands[i].cmd);
 	}
 }
 
-- 
2.17.0.705.g3525833791

