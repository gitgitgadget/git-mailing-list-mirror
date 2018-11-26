Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 207701F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 19:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbeK0Gda (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 01:33:30 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42769 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbeK0Gda (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 01:33:30 -0500
Received: by mail-lf1-f66.google.com with SMTP id l10so14504678lfh.9
        for <git@vger.kernel.org>; Mon, 26 Nov 2018 11:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RJS/R0DqCr0Cu87YIJsBu8RKuJlzC4d2RPIZHrEO54c=;
        b=Lxs9S6F4f2tUhBjt1KI3DemZQ2qZG6nE9u1a+Sjphb0pj3MStiBWpkAub0CwjdUI/r
         HfgVijE/ZFlhdrAGyLdFc1cAziNv13D6iEcS43cO2RJ+mE1GNFSrrdoyEc61v10Z45NC
         AFBZsIpwjwmFLcBHlR7R5qXGFc0hBiT6c4axVUsNG5veV5bB2FhNqKIASJxJIGeBFSIT
         brdn0h4tRWmkX9S8UNP6Q1+gkrwkiQkSzUvnnXgz0yjRpFtVhwTNYpQ96xxRYzD1bJsF
         Q1tMey/63449gr2bvad7x4Cpml+mLQXD0GyH1+JSZouDZadBJe4iu608o7YhXQSc2SFf
         V0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RJS/R0DqCr0Cu87YIJsBu8RKuJlzC4d2RPIZHrEO54c=;
        b=l0CJeqIVK/BRhsUUosknAxS8z0mWFixejCI429nFacdiXpzLGK0Il8t61TkvCUM01Q
         3Oj/pUkRiy9DzzIIvlzLgnnuMu19PH7bN4KuW3hpxq74e7EyjbbVcQqvFTLRrV1bmeON
         LqGaPM10DjR5qtkBUFQcYAYPxD9agF/b2uk4JwuVKn+pWQnZW5sSOhx4P+nieBImbdkl
         fQLOc4ICCOmtyoH4RStzVCpZZaJgsWLGWwXZ27pGjyLL6Adt9hs88dCFFh91xRc0N+4l
         bukMTTAMmV/sKF/GfiIygpC7D/ICNMKq9sIvrdOHRloKHJZVYRryVlfZVfawLQmgbvUp
         gOXw==
X-Gm-Message-State: AGRZ1gLaT182uD512O7S7UEJWb+qEvoRPizYBD2dbCae3huk39Rn2IUO
        fU0Gsdrm1oAMF9ng6UuKDr0=
X-Google-Smtp-Source: AJdET5cME5fyQ3nmWQ20z7Keqwo2MXXMuC1HmcpJuVdPVu+xBv2WHLJleUhk23GMt+5/MeGtZPYQlw==
X-Received: by 2002:a19:2395:: with SMTP id j143mr16311833lfj.107.1543261099345;
        Mon, 26 Nov 2018 11:38:19 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id p91sm202564lfg.4.2018.11.26.11.38.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 11:38:18 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        bert.wesarg@googlemail.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        drizzd@gmx.net, git@matthieu-moy.fr, hellmuth@ira.uka.de,
        jjensen@workspacewhiz.com, jost@tcs.ifi.lmu.de, kevin@sb.org,
        per.lundberg@hibox.tv, sandals@crustytoothpaste.net,
        eckhard.s.maass@googlemail.com
Subject: [PATCH v2 2/2] unpack-trees: support core.allIgnoredFilesArePreciousWhenMerging
Date:   Mon, 26 Nov 2018 20:38:04 +0100
Message-Id: <20181126193804.30741-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1327.g328c130451.dirty
In-Reply-To: <20181126193804.30741-1-pclouds@gmail.com>
References: <20181111095254.30473-1-pclouds@gmail.com>
 <20181126193804.30741-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ignored files can be marked precious to prevent being overwritten
during a merge (or even a branch switch). If you really want to make
sure no ignored files are overwritten, this config variable is for
you.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config/core.txt |  6 ++++++
 Documentation/gitignore.txt   |  5 +++--
 unpack-trees.c                | 21 ++++++++++++++++++++-
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index d0e6635fe0..bff5834c13 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -1,3 +1,9 @@
+core.allIgnoredFilesArePreciousWhenMerging::
+	During a merge operation, if "precious" attribute is unset,
+	consider it set. You can explicitly remove "precious"
+	attribute if needed. See linkgit:gitattributes[5] for more
+	information.
+
 core.fileMode::
 	Tells Git if the executable bit of files in the working tree
 	is to be honored.
diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 0e9614289e..2832df7178 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -142,8 +142,9 @@ To stop tracking a file that is currently tracked, use
 'git rm --cached'.
 
 Ignored files are generally considered discardable. See `precious`
-attribute in linkgit:gitattributes[5] to change the behavior regarding
-ignored files.
+attribute in linkgit:gitattributes[5] and
+`core.allIgnoredFilesArePreciousWhenMerging` in linkgit:git-config[1]
+to change the behavior regarding ignored files.
 
 EXAMPLES
 --------
diff --git a/unpack-trees.c b/unpack-trees.c
index 9a5aadc084..df3b163e2e 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1877,6 +1877,25 @@ static int icase_exists(struct unpack_trees_options *o, const char *name, int le
 	return src && !ie_match_stat(o->src_index, src, st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE);
 }
 
+static int is_precious_ignored_file(struct index_state *istate, const char *path)
+{
+	static struct attr_check *check;
+	int all_precious;
+
+	if (!check)
+		check = attr_check_initl("precious", NULL);
+	if (!check)
+		return 0;
+
+	git_check_attr(istate, path, check);
+	if (ATTR_UNSET(check->items[0].value) &&
+	    !git_config_get_bool("core.allignoredfilesarepreciouswhenmerging",
+				 &all_precious) &&
+	    all_precious)
+		return 1;
+	return ATTR_TRUE(check->items[0].value);
+}
+
 static int check_ok_to_remove(const char *name, int len, int dtype,
 			      const struct cache_entry *ce, struct stat *st,
 			      enum unpack_trees_error_types error_type,
@@ -1895,7 +1914,7 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
 		return 0;
 
 	if (o->dir &&
-	    !is_precious_file(o->src_index, name) &&
+	    !is_precious_ignored_file(o->src_index, name) &&
 	    is_excluded(o->dir, o->src_index, name, &dtype))
 		/*
 		 * ce->name is explicitly excluded, so it is Ok to
-- 
2.19.1.1327.g328c130451.dirty

