Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 682871F576
	for <e@80x24.org>; Wed, 24 Jan 2018 09:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932965AbeAXJyk (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 04:54:40 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:41306 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932799AbeAXJyh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 04:54:37 -0500
Received: by mail-pf0-f193.google.com with SMTP id c6so2635247pfi.8
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 01:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l1r+T6jAgRh2EBj3MRp1qC7fExiNbUAeEVLchMYkqig=;
        b=tmSwD5W+9dSKBAyWJODG+Fb15jxc9/qxZoGd5Tq/LuuCNH8unVIz/lkryBtLcDO1yn
         nboAZpiBgd8WrpFMAN1+HSxgsfV+e7ykrTUg/VxMMc8m8lbLWqrRyrERcPmX5aVU0fNA
         T5n1cmR144yViLZrEiO9FKpL6AnXgSG6u+9NLJ6zehjo7znBKEIKvGTIuHOOFQnNKdrl
         43lviYGEOr5lIpeyB8Vd84jEwJHMkqisDwGc85ocNMQb6T1ZCjSpsVBQRydXD9xMK3tO
         MfExcXbQImRtEiGUsmYA5NIZB/FulOrXSRoz/464dM9iGpubz2t4D85WhFmz2ClzZkDP
         Hukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l1r+T6jAgRh2EBj3MRp1qC7fExiNbUAeEVLchMYkqig=;
        b=eITmANHzfQtUM025W5SHHsEmo+mrcv52AVbetbsyd4DqJDiTXrAQu4V9ov2G3cLAqC
         JAxeTU0c96oBUJ+JN6UYH0Shppp6lSRGheRRd+PwzQO0ArDlOF/0MhL4BZ++wFF8Hmp6
         gW2xe9v6P3B+CV7MTB1IsK/yIotPYQgYg7hT2n9rQKD1y32XEaoBjkA7IC0XW/OoYDMA
         FCBJ6VwpiDNMP7jG4CUXCa9O8nlqsiCoWWOYXcM9AwgUic55eneDX4gKIyA8PmXA8dUM
         scFajbyv6eu5C/EifIw+tg3WOfk9Jy3VEVtU7cVZ1m5CeZcnj6uTvGwdx9lujNAyRQAq
         Ll4Q==
X-Gm-Message-State: AKwxytf5ZH8HkpwcIhGP9Nb+5oTKcLKj+PdG4MrQ/mt3pREs5j+xGG0I
        HkGK+8KTBWo1d3oeMtAYytgiiw==
X-Google-Smtp-Source: AH8x227BMAEJ6UFIW/CIPcIyDjB50yoXZhHN9U/lnp8H5+77OmcEMdflcCS2xJ8qCbGDbysiHc4byw==
X-Received: by 2002:a17:902:6b89:: with SMTP id p9-v6mr7740616plk.377.1516787677234;
        Wed, 24 Jan 2018 01:54:37 -0800 (PST)
Received: from ash ([171.233.110.59])
        by smtp.gmail.com with ESMTPSA id r84sm10183401pfk.92.2018.01.24.01.54.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jan 2018 01:54:36 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 24 Jan 2018 16:54:32 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        kaartic.sivaraam@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 5/7] worktree move: refuse to move worktrees with submodules
Date:   Wed, 24 Jan 2018 16:53:55 +0700
Message-Id: <20180124095357.19645-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.0.47.g3d9b0fac3a
In-Reply-To: <20180124095357.19645-1-pclouds@gmail.com>
References: <20180124095357.19645-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Submodules contains .git files with relative paths. After a worktree
move, these files need to be updated or they may point to nowhere.

This is a bandage patch to make sure "worktree move" don't break
people's worktrees by accident. When .git file update code is in
place, this validate_no_submodules() could be removed.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-worktree.txt |  2 +-
 builtin/worktree.c             | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 5d115b855a..24bb69de50 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -83,7 +83,7 @@ with `--reason`.
 move::
 
 Move a working tree to a new location. Note that the main working tree
-cannot be moved.
+or linked working trees containing submodules cannot be moved.
 
 prune::
 
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 89398e67e4..15980a0a49 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -606,6 +606,27 @@ static int unlock_worktree(int ac, const char **av, const char *prefix)
 	return ret;
 }
 
+static void validate_no_submodules(const struct worktree *wt)
+{
+	struct index_state istate = { NULL };
+	int i, found_submodules = 0;
+
+	if (read_index_from(&istate, worktree_git_path(wt, "index")) > 0) {
+		for (i = 0; i < istate.cache_nr; i++) {
+			struct cache_entry *ce = istate.cache[i];
+
+			if (S_ISGITLINK(ce->ce_mode)) {
+				found_submodules = 1;
+				break;
+			}
+		}
+	}
+	discard_index(&istate);
+
+	if (found_submodules)
+		die(_("working trees containing submodules cannot be moved"));
+}
+
 static int move_worktree(int ac, const char **av, const char *prefix)
 {
 	struct option options[] = {
@@ -632,6 +653,8 @@ static int move_worktree(int ac, const char **av, const char *prefix)
 	if (is_main_worktree(wt))
 		die(_("'%s' is a main working tree"), av[0]);
 
+	validate_no_submodules(wt);
+
 	if (is_directory(dst.buf)) {
 		const char *sep = find_last_dir_sep(wt->path);
 
-- 
2.16.0.47.g3d9b0fac3a

