Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SORTED_RECIPS,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C3B61F576
	for <e@80x24.org>; Mon, 26 Feb 2018 10:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752253AbeBZKa5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 05:30:57 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44625 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751796AbeBZKa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 05:30:56 -0500
Received: by mail-pl0-f66.google.com with SMTP id w21so9009092plp.11
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 02:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WmHQhIjVTVh+Mz+4CH8PNgUn9m9AnmuIRbIRcuQSy1A=;
        b=lkAe0Fq38Rp5MFHEePGjuPy286aN58uk4lE5TfbwNNAOIqO0PyCsJCmKwQmdGLr89x
         SGq75cqbZYfg5kQoxb8SSmUcxvCpw1tdEz2zdhNNSqR72WZhpFYJO5eBvx1+vEycRRUf
         DWN8XaHjyPj3gLxpd9Unt5qcAbPjDLC8+P5qNokED87shpSK3ssSp89C4GfQ0kROu2tM
         NGajGhYb9bsThYBli7Jyi9ebclzbgPnTz2SZkwjjTqa+9bJYI5ghosU3+2qnw2NzrILy
         UXX01M3iUJepLXC7HIKHxByfGlyV5GvRYmVnLaph46NITcfuEJLtg+UtpFdt+s4n5eDW
         4ecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WmHQhIjVTVh+Mz+4CH8PNgUn9m9AnmuIRbIRcuQSy1A=;
        b=gPrqZ9oz11ULS0A+8dCeLdmd7+rR8FIyZCGS/PRqZEBwKQQO2slCjWMe4tG7w6aZCA
         nIhJ5ACLCH7LoPDUkOL0baLZ8uEY8SNzDLf17vYYPmxci5gNgrssfyc3roIXpgjHoUye
         fMUSukhK9gsO4nPKW0KbgTvgLLbkcVdzTqeTJ6VOVueqffRVERwhrG7ecIIUsoEgcm3m
         2Z/doSBUrw4myS+psFCUVXqPNFullynSgSk2O1slhY//AvACgEkKFHVsMzI8TEbiZ1JD
         0tsRIrm4p0Hl4fwFOvmlEuaAw/+5uK7Pmc4ZIphLwP2iLhqe42jSNEIsdVfX7pIZ5vAs
         3ZXg==
X-Gm-Message-State: APf1xPDubDWoUe2O+kN8/ZmIuABjDOiT92iF3oHn7M3c7jXVyD6J0Ae5
        zf8xmPF2U+uAPJeUk38vSlFkOg==
X-Google-Smtp-Source: AH8x227BkKAvYjt1uE2os3HzShqXaY0oRss/ygHvCankufxDMlcxo37bhwjxjmnxM9WMdxLekhAB3Q==
X-Received: by 2002:a17:902:bb96:: with SMTP id m22-v6mr10145861pls.17.1519641056374;
        Mon, 26 Feb 2018 02:30:56 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id e25sm9901559pfn.67.2018.02.26.02.30.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Feb 2018 02:30:55 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 26 Feb 2018 17:30:50 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sbeller@google.com, sunshine@sunshineco.com
Subject: [PATCH 2/4] repository.c: delete dead functions
Date:   Mon, 26 Feb 2018 17:30:28 +0700
Message-Id: <20180226103030.26900-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180226103030.26900-1-pclouds@gmail.com>
References: <20180214180814.GA139458@google.com>
 <20180226103030.26900-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 repository.c | 45 ---------------------------------------------
 1 file changed, 45 deletions(-)

diff --git a/repository.c b/repository.c
index 70dc8dc661..be86da82cc 100644
--- a/repository.c
+++ b/repository.c
@@ -16,51 +16,6 @@ static struct repository the_repo = {
 };
 struct repository *the_repository = &the_repo;
 
-static char *git_path_from_env(const char *envvar, const char *git_dir,
-			       const char *path, int fromenv)
-{
-	if (fromenv) {
-		const char *value = getenv(envvar);
-		if (value)
-			return xstrdup(value);
-	}
-
-	return xstrfmt("%s/%s", git_dir, path);
-}
-
-static int find_common_dir(struct strbuf *sb, const char *gitdir, int fromenv)
-{
-	if (fromenv) {
-		const char *value = getenv(GIT_COMMON_DIR_ENVIRONMENT);
-		if (value) {
-			strbuf_addstr(sb, value);
-			return 1;
-		}
-	}
-
-	return get_common_dir_noenv(sb, gitdir);
-}
-
-static void repo_setup_env(struct repository *repo)
-{
-	struct strbuf sb = STRBUF_INIT;
-
-	repo->different_commondir = find_common_dir(&sb, repo->gitdir,
-						    !repo->ignore_env);
-	free(repo->commondir);
-	repo->commondir = strbuf_detach(&sb, NULL);
-	raw_object_store_clear(&repo->objects);
-	repo->objects.objectdir =
-		git_path_from_env(DB_ENVIRONMENT, repo->commondir,
-				  "objects", !repo->ignore_env);
-	free(repo->graft_file);
-	repo->graft_file = git_path_from_env(GRAFT_ENVIRONMENT, repo->commondir,
-					     "info/grafts", !repo->ignore_env);
-	free(repo->index_file);
-	repo->index_file = git_path_from_env(INDEX_ENVIRONMENT, repo->gitdir,
-					     "index", !repo->ignore_env);
-}
-
 static void expand_base_dir(char **out, const char *in,
 			    const char *base_dir, const char *def_in)
 {
-- 
2.16.1.435.g8f24da2e1a

