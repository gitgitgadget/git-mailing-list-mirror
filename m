Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795774883;
	b=CtXsiIx26JW+en+r5yDpdfOKEGPGxJVFpHijpAhQVMhxXJx/ktJyMvPidP2QfOUyBT37
	 bH005rVu1A1fmhpijSuw2p+BgzNlpAfteg0WikUqaOU/YCcmBMQj+8y2/E6CcIXLtQz08
	 dCYCf83z6xx7wvwkjF4XN/gS9DRoMq8WfEZInAXb/Sxmtxj15P+tfLzheqBTQozE2j8x1
	 b7hvU3Aatkdt+EklsOxt6tEJG1qjY7n+yR7L+NAH0SFtPdufUl1Di7sLaVmf9i6ZGF6nZ
	 +XpEQmAjhNFsPaHYtdpVsmZFNZwYMSKjuvtybjIcQapl9124y4STUcQ5iiidFvenKzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795774883;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=TeEHmgvCsHXUvSxefyXdXShkvpWvXzXKarKGCPbT980=;
	b=yVLnXNHZ7v1GSXeo5eQGJtPAPESHu6+t1PQp/YdiAmEkq3n9TLc0Fx8sgwWMK47mhLxE
	 NeqfM4E5foUh0Mk2gppHZS+jbYL2Ioos7kRGfguSrDGkykiKbnwP4a1gSUF0lh0Ad2Xgf
	 ChwEbEca8UA5QjtcbNQ2ryG+ADOX63deqVcsYzNgxWJo4ztkGEP1W9BSTlJS5auWIo6gp
	 FU3a1+HWms11JM3CfL6Pomv9c92O4WGgVkEXvuQLWPBT08c/5sPZ/8aTaPwfRwB4+kFTK
	 8ftxgT1KwRajH2sKJrYw+P97PNrpdsWUdFQtr/erSibB9WBdUSQ5rAosKEUCbjcKrww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="rC5h9W/k";
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB56606A31C
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 10:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEB56606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rC5h9W/k
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-385d8a00598so11810350eec.1
        for <git@vger.kernel.org>; Fri, 27 Nov 2026 02:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795774882; x=1796379682; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TeEHmgvCsHXUvSxefyXdXShkvpWvXzXKarKGCPbT980=;
        b=rC5h9W/k1Pf4RMcF8kZEDWR5XHlCEvS2rrKh4TO/9ZA44Kf5YvOkHntabwRVS9FcmO
         5CUnfN2S6NkEBp2HVfYUvC6HAuQSUR2N40qEO1Vm5gwkfnpJTpfXWg5PpLWOoTkl7Ohz
         YNSz9QCyJH8acZz9O8yJMIBPA/BN36xNahY2gMlKfzbYecjqP5RwE04JpTUIV0jq9qwF
         jBPiZ7rjEP5iZdxohyGeHUCPIwJ2KkorplLw2SUaOKEK3uDGE/uiTQcdGzWOrmJEbfAh
         PNKJZPAFz/LDcS6decT9oml9MN+t/SGdjy65G3ZBZBAfFgh9griyWcO+9lTiD4QkFHEk
         Sv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795774882; x=1796379682;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TeEHmgvCsHXUvSxefyXdXShkvpWvXzXKarKGCPbT980=;
        b=n8IxXtUhi/3Nal6UXClnn67XOOsNC8kZ1NSvsECE1yOzrxBN6r2G3VA1qmhRUg48/C
         mCmzp1skdnYolx6S7dgwEdKqmb6v8YnDvCUOSFrk9CqUiOhW19i1AfiyaoFTFVZdd2ta
         7MSfUOPvQij4RqzgKoLfh9KQMpd8/sgFdXCmT6PxbH1gWH+INUouKAe7aNrsNVYm4aym
         tGXgmiosGEtlH+vR0sAgSCv+447M8q6v4lNOOhY98tjZ0j+HJUd5GVV2iG7TCLotywcT
         WlPj6eLSa7vwOHjlzg1Nn/TzcxI3FQDyE5zZaYCdT7h4z30xY+Azhp4UxaGm0zUS84Ct
         3lug==
X-Gm-Message-State: APuU4Z8XnwK37pHacKQ9zxjT4AkcXV9gD/M1hIDq9Pyv0khY0ptXAOv+
	2V/Alb+yDEmmdxWGe5Vq2LCCqnGTSASLWu3S9sFLvPvbDtuEFE5Il8/DZjuwXQ==
X-Gm-Gg: AZFdTZeT3HaRLMmjQ5WgULhhUSyIhThL/CS8bV3nxLwG7SKdulirnsQhfoFFB/9YV7f
	QdG3ykqOFUVwulskiYb/DbNgwfQBFH+fXRnqb1nC3v0OGaWbGPRgEJWzTSFMOgKdEbDvk7lVAtv
	rKodXfwfXji8RDJqn+n+7sIV32j8+SnxhEXjSkbAzQ3xVOG7744Z7mpAaz0Rh73q9XyaTJAB/sf
	oHPSC4c852nSuUgj/DOmhlU3RQplkG7j2p+nEpdzL4NLqPpvEq7QUdLy7kKmoM+0CqS38d2JxTg
	lQjZujNHHc/2YX9/6OWvpQ1Hr1Rwivev1vged4HLUN7TgAGtGmn3qlNJ/lyX4AsPdUrG4+ugzn5
	fVNY8X6No4gnjUCrkpR/6Bx24gGII3GBfvHjjMdALLYWdIaFQH8PiI+ZwEJ06ulg62txqFw2S6R
	xjXlTNPGjRX9PmKt84kQvbDA+PYrUBBPFeU3by1ixxLK/sK+uXXjPrD2xnPXhdD25NuBiAsj0SC
	uBIK6dw7u7T7ephXX94piylv8vfzG+L9my6md01NwK4+MoFAYHmu+H3whT984mVrap/Kr7mqqnL
	VPjngIPVa4QRynTTRz3B4wN5jbigDzUV
X-Received: by 2002:a05:693c:41cf:20b0:386:c803:49df with SMTP id 5a478bee46e88-386c803524cmr9839459eec.28.1795774881582;
        Fri, 27 Nov 2026 02:21:21 -0800 (PST)
Received: from [127.0.0.1] ([20.169.110.113])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385f68bc0adsm66609907eec.13.2026.11.27.02.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 02:21:20 -0800 (PST)
Message-Id: <pull.2509.git.git.1795774880142.gitgitgadget@gmail.com>
From: "Alessio Attilio via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 27 Nov 2026 10:21:20 +0000
Subject: [PATCH] status: warn about stale submodule URLs
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Alessio Attilio <attilio.alessio@protonmail.com>,
    Alessio Attilio <attilio.alessio@protonmail.com>

From: Alessio Attilio <attilio.alessio@protonmail.com>

When a submodule URL changes in .gitmodules, the URL cached in
.git/config can keep pointing at the old remote. That leaves users
with no indication that later submodule operations may use a
repository different from the one the project declares.

Warn in git status so users can find and sync stale configuration
before it causes a confusing fetch or update. Resolve relative URLs
like git submodule sync does, and leave customized submodule remotes
alone.

Signed-off-by: Alessio Attilio <attilio.alessio@protonmail.com>
---
    status: report when submodule URLs are out of sync
    
    Closes gitgitgadget/git#565

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2509%2Fkairosci%2Ftopic%2Fstatus-submodule-url-sync-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2509/kairosci/topic/status-submodule-url-sync-v1
Pull-Request: https://github.com/git/git/pull/2509

 builtin/submodule--helper.c | 63 ++++--------------------
 submodule.c                 | 44 +++++++++++++++++
 submodule.h                 |  3 ++
 t/t7508-status.sh           | 55 +++++++++++++++++++++
 wt-status.c                 | 97 +++++++++++++++++++++++++++++++++++++
 5 files changed, 209 insertions(+), 53 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 461b682d0d..5f293d9dfd 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -46,35 +46,6 @@
 typedef void (*each_submodule_fn)(const struct cache_entry *list_item,
 				  void *cb_data);
 
-static char *get_default_remote(void)
-{
-	return xstrdup(repo_default_remote(the_repository));
-}
-
-static char *resolve_relative_url(const char *rel_url, const char *up_path, int quiet)
-{
-	char *remoteurl, *resolved_url;
-	char *remote = get_default_remote();
-	struct strbuf remotesb = STRBUF_INIT;
-
-	strbuf_addf(&remotesb, "remote.%s.url", remote);
-	if (repo_config_get_string(the_repository, remotesb.buf, &remoteurl)) {
-		if (!quiet)
-			warning(_("could not look up configuration '%s'. "
-				  "Assuming this repository is its own "
-				  "authoritative upstream."),
-				remotesb.buf);
-		remoteurl = xgetcwd();
-	}
-	resolved_url = relative_url(remoteurl, rel_url, up_path);
-
-	free(remote);
-	free(remoteurl);
-	strbuf_release(&remotesb);
-
-	return resolved_url;
-}
-
 static int get_default_remote_submodule(const char *module_path, char **default_remote)
 {
 	const struct submodule *sub;
@@ -92,7 +63,7 @@ static int get_default_remote_submodule(const char *module_path, char **default_
 		    starts_with_dot_slash(url)) {
 			char *oldurl = url;
 
-			url = resolve_relative_url(oldurl, NULL, 1);
+			url = resolve_submodule_url(the_repository, oldurl, NULL, 1);
 			free(oldurl);
 		}
 	}
@@ -290,23 +261,6 @@ static void module_list_active(struct module_list *list)
 	*list = active_modules;
 }
 
-static char *get_up_path(const char *path)
-{
-	struct strbuf sb = STRBUF_INIT;
-
-	strbuf_addstrings(&sb, "../", count_slashes(path));
-
-	/*
-	 * Check if 'path' ends with slash or not
-	 * for having the same output for dir/sub_dir
-	 * and dir/sub_dir/
-	 */
-	if (!is_dir_sep(path[strlen(path) - 1]))
-		strbuf_addstr(&sb, "../");
-
-	return strbuf_detach(&sb, NULL);
-}
-
 static void for_each_listed_submodule(const struct module_list *list,
 				      each_submodule_fn fn, void *cb_data)
 {
@@ -623,7 +577,7 @@ static void init_submodule(const char *path, const char *prefix,
 		    starts_with_dot_slash(url)) {
 			char *oldurl = url;
 
-			url = resolve_relative_url(oldurl, NULL, 0);
+			url = resolve_submodule_url(the_repository, oldurl, NULL, 0);
 			free(oldurl);
 		}
 
@@ -1453,10 +1407,12 @@ static void sync_submodule(const char *path, const char *prefix,
 	if (sub && sub->url) {
 		if (starts_with_dot_dot_slash(sub->url) ||
 		    starts_with_dot_slash(sub->url)) {
-			char *up_path = get_up_path(path);
+			char *up_path = get_submodule_up_path(path);
 
-			sub_origin_url = resolve_relative_url(sub->url, up_path, 1);
-			super_config_url = resolve_relative_url(sub->url, NULL, 1);
+			sub_origin_url = resolve_submodule_url(the_repository, sub->url,
+							      up_path, 1);
+			super_config_url = resolve_submodule_url(the_repository,
+								 sub->url, NULL, 1);
 			free(up_path);
 		} else {
 			sub_origin_url = xstrdup(sub->url);
@@ -2334,7 +2290,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	if (repo_config_get_string_tmp(the_repository, sb.buf, &url)) {
 		if (sub->url && (starts_with_dot_slash(sub->url) ||
 				 starts_with_dot_dot_slash(sub->url))) {
-			url = resolve_relative_url(sub->url, NULL, 0);
+			url = resolve_submodule_url(the_repository, sub->url, NULL, 0);
 			need_free_url = 1;
 		} else
 			url = sub->url;
@@ -3761,7 +3717,8 @@ static int module_add(int argc, const char **argv, const char *prefix,
 			      "of the working tree"));
 
 		/* dereference source url relative to parent's url */
-		to_free = resolve_relative_url(add_data.repo, NULL, 1);
+		to_free = resolve_submodule_url(the_repository, add_data.repo,
+						NULL, 1);
 		add_data.realrepo = to_free;
 	} else if (is_dir_sep(add_data.repo[0]) || strchr(add_data.repo, ':')) {
 		add_data.realrepo = add_data.repo;
diff --git a/submodule.c b/submodule.c
index a74d1925aa..5d0018d032 100644
--- a/submodule.c
+++ b/submodule.c
@@ -292,6 +292,50 @@ int is_submodule_active(struct repository *repo, const char *path)
 	return is_tree_submodule_active(repo, null_oid(the_hash_algo), path);
 }
 
+char *resolve_submodule_url(struct repository *repo, const char *url,
+			    const char *up_path, int quiet)
+{
+	const char *remote = repo_default_remote(repo);
+	char *remoteurl, *resolved_url;
+	struct strbuf remotesb = STRBUF_INIT;
+
+	if (!starts_with_dot_dot_slash(url) && !starts_with_dot_slash(url))
+		return xstrdup(url);
+
+	strbuf_addf(&remotesb, "remote.%s.url", remote);
+	if (repo_config_get_string(repo, remotesb.buf, &remoteurl)) {
+		if (!quiet)
+			warning(_("could not look up configuration '%s'. "
+				  "Assuming this repository is its own "
+				  "authoritative upstream."),
+				remotesb.buf);
+		remoteurl = xgetcwd();
+	}
+	resolved_url = relative_url(remoteurl, url, up_path);
+
+	free(remoteurl);
+	strbuf_release(&remotesb);
+
+	return resolved_url;
+}
+
+char *get_submodule_up_path(const char *path)
+{
+	struct strbuf sb = STRBUF_INIT;
+
+	strbuf_addstrings(&sb, "../", count_slashes(path));
+
+	/*
+	 * Check if 'path' ends with slash or not
+	 * for having the same output for dir/sub_dir
+	 * and dir/sub_dir/
+	 */
+	if (!is_dir_sep(path[strlen(path) - 1]))
+		strbuf_addstr(&sb, "../");
+
+	return strbuf_detach(&sb, NULL);
+}
+
 int is_submodule_populated_gently(const char *path, int *return_error_code)
 {
 	int ret = 0;
diff --git a/submodule.h b/submodule.h
index 1a465a1208..2028f272c4 100644
--- a/submodule.h
+++ b/submodule.h
@@ -62,6 +62,9 @@ int is_tree_submodule_active(struct repository *repo,
 			     const struct object_id *treeish_name,
 			     const char *path);
 int is_submodule_active(struct repository *repo, const char *path);
+char *resolve_submodule_url(struct repository *repo, const char *url,
+			    const char *up_path, int quiet);
+char *get_submodule_up_path(const char *path);
 /*
  * Determine if a submodule has been populated at a given 'path' by checking if
  * the <path>/.git resolves to a valid git repository.
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index e10c961268..bf28de1907 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -921,6 +921,61 @@ test_expect_success 'setup status submodule summary' '
 	git add sm
 '
 
+test_expect_success 'status reports submodule URL mismatch' '
+	test_when_finished "rm -rf url-test" &&
+	test_when_finished "rm -f actual err" &&
+	test_create_repo url-test/source &&
+	test_commit -C url-test/source initial &&
+	test_create_repo url-test/super &&
+	git -C url-test/super -c protocol.file.allow=always \
+		submodule add "$PWD/url-test/source" module &&
+	git -C url-test/super commit -m "add submodule" &&
+	git -C url-test/super status >actual 2>err &&
+	test_must_be_empty err &&
+	git -C url-test/super config -f .gitmodules submodule.module.url \
+		"$PWD/url-test/updated-source" &&
+	git -C url-test/super status --porcelain >actual 2>err &&
+	test_must_be_empty err &&
+	git -C url-test/super status >actual 2>err &&
+	test_grep "module.*different URL" err &&
+	test_grep "git submodule sync" err &&
+	git -C url-test/super submodule sync &&
+	git -C url-test/super status >actual 2>err &&
+	test_must_be_empty err &&
+	git -C url-test/super remote add origin ../source-parent &&
+	git -C url-test/super config -f .gitmodules submodule.module.url \
+		../relative-source &&
+	git -C url-test/super status >actual 2>err &&
+	test_grep "module.*different URL" err &&
+	git -C url-test/super submodule sync &&
+	git -C url-test/super status >actual 2>err &&
+	test_must_be_empty err &&
+	git -C url-test/super config -f .gitmodules submodule.module.url \
+		../another-relative-source &&
+	git -C url-test/super status >actual 2>err &&
+	test_grep "module.*different URL" err &&
+	git -C url-test/super submodule sync &&
+	git -C url-test/super status >actual 2>err &&
+	test_must_be_empty err &&
+	git -C url-test/super/module config remote.origin.url \
+		"$PWD/url-test/fork" &&
+	git -C url-test/super config -f .gitmodules submodule.module.url \
+		../fork-source &&
+	git -C url-test/super status >actual 2>err &&
+	test_must_be_empty err &&
+	git -C url-test/super/module config --add remote.origin.url \
+		"$PWD/url-test/another-fork" &&
+	git -C url-test/super config -f .gitmodules submodule.module.url \
+		../another-fork-source &&
+	git -C url-test/super status >actual 2>err &&
+	test_must_be_empty err &&
+	git -C url-test/super/module config --unset-all remote.origin.url &&
+	git -C url-test/super config --add submodule.module.url \
+		"$PWD/url-test/another-configured-source" &&
+	git -C url-test/super status >actual 2>err &&
+	test_grep "module.*different URL" err
+'
+
 test_expect_success 'status submodule summary is disabled by default' '
 	cat >expect <<EOF &&
 On branch main
diff --git a/wt-status.c b/wt-status.c
index 238bb48643..e06c18d8e0 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -3,6 +3,7 @@
 
 #include "git-compat-util.h"
 #include "advice.h"
+#include "config.h"
 #include "wt-status.h"
 #include "object.h"
 #include "dir.h"
@@ -23,6 +24,7 @@
 #include "remote.h"
 #include "refs.h"
 #include "submodule.h"
+#include "submodule-config.h"
 #include "column.h"
 #include "read-cache.h"
 #include "setup.h"
@@ -2692,8 +2694,103 @@ static void wt_porcelain_v2_print(struct wt_status *s)
 	}
 }
 
+static int submodule_has_custom_remote_url(struct repository *repo,
+					  const char *path,
+					  const char *url,
+					  const char *configured_url)
+{
+	struct repository subrepo = { 0 };
+	const struct string_list *remote_urls = NULL;
+	const char *remote;
+	const char *remote_url;
+	char *key, *up_path, *old_url, *new_url;
+	int error_code, ret = 0;
+
+	if (!is_submodule_populated_gently(path, &error_code))
+		return 0;
+
+	if (repo_submodule_init(&subrepo, repo, path,
+				null_oid(repo->hash_algo)) < 0) {
+		repo_clear(&subrepo);
+		return 0;
+	}
+
+	remote = repo_default_remote(&subrepo);
+
+	key = xstrfmt("remote.%s.url", remote);
+	if (!repo_config_get_value_multi(&subrepo, key, &remote_urls) &&
+	    remote_urls->nr == 1) {
+		remote_url = remote_urls->items[0].string;
+		up_path = get_submodule_up_path(path);
+		old_url = resolve_submodule_url(repo, configured_url, up_path, 1);
+		new_url = resolve_submodule_url(repo, url, up_path, 1);
+		ret = strcmp(remote_url, old_url) != 0 &&
+			strcmp(remote_url, new_url) != 0;
+		free(new_url);
+		free(old_url);
+		free(up_path);
+	} else {
+		/*
+		 * Multiple URLs are a local customization; sync would replace
+		 * them all with a single URL.
+		 */
+		ret = remote_urls && remote_urls->nr > 1;
+	}
+	free(key);
+	repo_clear(&subrepo);
+
+	return ret;
+}
+
+static void wt_status_check_submodule_urls(struct wt_status *s)
+{
+	int i;
+
+	if (s->status_format != STATUS_FORMAT_LONG &&
+	    s->status_format != STATUS_FORMAT_NONE)
+		return;
+
+	if (is_gitmodules_unmerged(s->repo->index))
+		return;
+
+	for (i = 0; i < s->repo->index->cache_nr; i++) {
+		struct cache_entry *ce = s->repo->index->cache[i];
+		const struct submodule *sub;
+		const char *configured_url;
+		char *key, *expected_url;
+
+		if (ce_stage(ce) || !S_ISGITLINK(ce->ce_mode))
+			continue;
+
+		sub = submodule_from_path(s->repo, null_oid(s->repo->hash_algo),
+					  ce->name);
+		if (!sub || !sub->url || !is_submodule_active(s->repo, ce->name))
+			continue;
+
+		key = xstrfmt("submodule.%s.url", sub->name);
+		if (repo_config_get_value(s->repo, key, &configured_url)) {
+			free(key);
+			continue;
+		}
+		free(key);
+
+		expected_url = resolve_submodule_url(s->repo, sub->url, NULL, 1);
+		if (strcmp(configured_url, expected_url) &&
+		    !submodule_has_custom_remote_url(s->repo, ce->name,
+						     expected_url,
+						     configured_url))
+			warning(_("submodule '%s' has a different URL in .git/config "
+				  "than in .gitmodules\n"
+				  "  run 'git submodule sync' to update it"), ce->name);
+
+		free(expected_url);
+	}
+}
+
 void wt_status_print(struct wt_status *s)
 {
+	wt_status_check_submodule_urls(s);
+
 	trace2_data_intmax("status", s->repo, "count/changed", s->change.nr);
 	trace2_data_intmax("status", s->repo, "count/untracked",
 			   s->untracked.nr);

base-commit: acba8bf9753134d9bde89f94369f775838a8c5fe
-- 
gitgitgadget
