Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 997331F404
	for <e@80x24.org>; Sun, 17 Dec 2017 22:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932217AbdLQWtn (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Dec 2017 17:49:43 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:41229 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932129AbdLQWtk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Dec 2017 17:49:40 -0500
Received: by mail-wm0-f67.google.com with SMTP id g75so26196551wme.0
        for <git@vger.kernel.org>; Sun, 17 Dec 2017 14:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZF+jvzJ9vsg4V1SC9EnxS594SkmYAi8XUaZI1LUS/0k=;
        b=bHpzj1hPyAlqEusOHFQGSQzS2++kif/jGpKd9PQM8HlDNGCM1OpmCLe5H3GBtCPhTd
         VONdXkagaQH9ZkmzXnqPXpqfhgxBNNWaXcCtl7c8U2+GEiN3oRyXeHsKN0xkiNLDAx3p
         t5ajta+7f4FedsQfPNFcI+GnT+Kj+g+Xx9SnFwODEIUfogfS+5aYPlBXDDtibM0pe/bC
         vgrLHLqlUJYJ7hP2nN0g6opce6kQtrRA4kziAVDnvOYTDeEnhjRzXnkWR2gRKwoIDVGT
         o5PgvalrNZNcGQieB4Kv4IVT4co3mzapgZ6c2jLVjxwdg67v/f4vz771zhyQ6d5Iv9SL
         d4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZF+jvzJ9vsg4V1SC9EnxS594SkmYAi8XUaZI1LUS/0k=;
        b=RloIjr+CxljcgsoHZ5OZDm0eSxjy9N/str1M+a04JogpF26sBOnL6lYHwaokmkBV/9
         7j/nvX+V0d3TJpnXVQsL4T+kOcBoaMzqjzVpNhDeREhDoFBgOsQ+zUgYVKPmIIZoFwJm
         fVCOuHUWzBB9Jq87ZziAeVn8XRGQ498C0T5geXYVoEMJplvTc8CoL0wscYPqdTXdN2U2
         ax9EvUTx6ebRGQBJgLJxKT7s9GrYL6fx6al0jpS9AejHZQoKRkgHRYii87HLC5ESJYTL
         a0rTqS7oYRj7+1b72ETPwiXsC6O2y0usezuL2xAMMuC2YHEtn9WcmkGXA6ZDpJmoEzbt
         ygFA==
X-Gm-Message-State: AKGB3mIahWXIdzFz8FeB6sdU1LnLYAla0H0DKHQXDvvWG1P4K3ZkDE9U
        a4Je2HMk82wUFFQ769SZFVeyYoZk
X-Google-Smtp-Source: ACJfBovCeE3FwBZTshgIcx/7EnUwmGo3RXscrTMSGTEzRbeYoECD3WMhgq2fLi7A9hJqf8nsGh8N/A==
X-Received: by 10.28.158.206 with SMTP id h197mr10122362wme.23.1513550979297;
        Sun, 17 Dec 2017 14:49:39 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id c34sm6353847wra.53.2017.12.17.14.49.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Dec 2017 14:49:38 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 1/3] repository: fix repo_read_index with submodules
Date:   Sun, 17 Dec 2017 22:51:20 +0000
Message-Id: <20171217225122.28941-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670
In-Reply-To: <20171217225122.28941-1-t.gummerer@gmail.com>
References: <20171210212202.28231-1-t.gummerer@gmail.com>
 <20171217225122.28941-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

repo_read_index calls read_index_from, which takes an path argument for
the location of the index file.  For the split index however it relies
on the current working directory to construct the path using git_path.

repo_read_index calls read_index_from with the full path for the index
file, however it doesn't change the cwd, so when split index mode is
turned on, read_index_from can't find the file for the split index.

For example t3007-ls-files-recurse-submodules.sh was broken with
GIT_TEST_SPLIT_INDEX set in 188dce131f ("ls-files: use repository
object", 2017-06-22), and t7814-grep-recurse-submodules.sh was also
broken in a similar manner, probably by introducing struct repository
there, although I didn't track down the exact commit for that.

Fix this by introducing a new read_index_for_repo function, which knows
about the correct paths for the submodules.

The alternative would have been to make the callers pass in the base
path for the split index, however that ended up being more complicated,
and I think we want to converge towards using struct repository for
things like these anyway.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 cache.h      |  1 +
 read-cache.c | 16 ++++++++++++++--
 repository.c |  2 +-
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index cb5db7bf83..d42bea1ef7 100644
--- a/cache.h
+++ b/cache.h
@@ -614,6 +614,7 @@ extern int read_index_preload(struct index_state *, const struct pathspec *paths
 extern int do_read_index(struct index_state *istate, const char *path,
 			 int must_exist); /* for testting only! */
 extern int read_index_from(struct index_state *, const char *path);
+extern int read_index_for_repo(const struct repository *);
 extern int is_index_unborn(struct index_state *);
 extern int read_index_unmerged(struct index_state *);
 
diff --git a/read-cache.c b/read-cache.c
index 2eb81a66b9..70357febdc 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -20,6 +20,7 @@
 #include "split-index.h"
 #include "utf8.h"
 #include "fsmonitor.h"
+#include "repository.h"
 
 /* Mask for the name length in ce_flags in the on-disk index */
 
@@ -1871,7 +1872,8 @@ static void freshen_shared_index(char *base_sha1_hex, int warn)
 	free(shared_index);
 }
 
-int read_index_from(struct index_state *istate, const char *path)
+static int do_read_index_from(struct index_state *istate, const char *path,
+			      const struct repository *repo)
 {
 	struct split_index *split_index;
 	int ret;
@@ -1896,7 +1898,7 @@ int read_index_from(struct index_state *istate, const char *path)
 		split_index->base = xcalloc(1, sizeof(*split_index->base));
 
 	base_sha1_hex = sha1_to_hex(split_index->base_sha1);
-	base_path = git_path("sharedindex.%s", base_sha1_hex);
+	base_path = repo_git_path(repo, "sharedindex.%s", base_sha1_hex);
 	ret = do_read_index(split_index->base, base_path, 1);
 	if (hashcmp(split_index->base_sha1, split_index->base->sha1))
 		die("broken index, expect %s in %s, got %s",
@@ -1909,6 +1911,16 @@ int read_index_from(struct index_state *istate, const char *path)
 	return ret;
 }
 
+int read_index_for_repo(const struct repository *repo)
+{
+	return do_read_index_from(repo->index, repo->index_file, repo);
+}
+
+int read_index_from(struct index_state *istate, const char *path)
+{
+	return do_read_index_from(istate, path, the_repository);
+}
+
 int is_index_unborn(struct index_state *istate)
 {
 	return (!istate->cache_nr && !istate->timestamp.sec);
diff --git a/repository.c b/repository.c
index bb2fae5446..928b1f553d 100644
--- a/repository.c
+++ b/repository.c
@@ -229,5 +229,5 @@ int repo_read_index(struct repository *repo)
 	if (!repo->index)
 		repo->index = xcalloc(1, sizeof(*repo->index));
 
-	return read_index_from(repo->index, repo->index_file);
+	return read_index_for_repo(repo);
 }
-- 
2.15.1.620.gb9897f4670

