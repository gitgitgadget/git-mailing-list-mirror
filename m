Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795814857;
	b=44ysrcuJozPRKnpzHeWZ15Z0f45nEQq/tFHf/HBFBL+5p/IKPt0Q8a+HzN6s1mU9W2gE
	 C9xrO1zmubrXYcGNHVkHshyHc6To+x0xaLvnL1jZFMXUS5125mFog5TIbYsiLvBXlHQZC
	 6htWPNMtwJ7e7MD6xxU3DJHPth0X/psyyiCXOo5qzkXaxcQD1hjhaWfzrMyQ2LZs5ksuj
	 CzMfD70CEKyG06xOnpAy5Y/ZFNCEcLvyUC+lf8fR4M26Ty4jiZ80Ws8xNJoSNuwqkrr8/
	 obsgJ12HkxchYKJJYcCdRSCD7iUkTLapyxSIcoySGrl5gqtRLZpuXFnIliLXMDcJVHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795814857;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=0/dUK912G2QNzQci61XJd4pulyMLltpAdgKeN7EECOY=;
	b=ES8ms3i+rjpuF5v/Z+8ea6Vd0en4gDzrg1oWBBAhlEBxUpTGe39LagnKbPpsNKV4ghY5
	 W0kJez0AmfwdFcVXljNQ+DEQDl7fZ2OtuGOMVXJ85Zl97HImphbaN9je3Md0vHPavIwaV
	 VblTcu1syaw1888qCQ0zsMtYOCWqNMCo6WTi0KHT1xs1+nb3XmKV5Rks945P3vRqKHHJK
	 o6Okfo0a/VTsn1sAGs/q4hnBjsynirKpJIpu6Ao3nKy1l65i9yjykVfgHZWVYUFcdpUbo
	 EdfmNSTiOI5QD4ZKYoJZV2VamKtS3TY+hgvkZLL5v9/feRtzPY+j/r+g+CxRyoyxmmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=apybqtqw;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DF6606A324
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 21:27:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28DF6606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=apybqtqw
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-380c28f9e35so9342640eec.1
        for <git@vger.kernel.org>; Fri, 27 Nov 2026 13:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795814856; x=1796419656; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0/dUK912G2QNzQci61XJd4pulyMLltpAdgKeN7EECOY=;
        b=apybqtqwT7uLZNZpCsTTnsaa+wPceoQoZWZYeov7vmyh0I5Y88R5tEdveDpf4Kap1P
         7cZzmx9WiMN0BxEbSQf4Q9/aI9BlgmItZDNC1j6Y8aLARNLH3YIVo9DYrTdUd3hczASi
         FCCDSmCScFXxy3TR8m099V2Uu9iQfbt1XXyetdVsgtLjPdQNyCldp1+Es/+hMIRoCAph
         RxAoqPfLUIBWIhQXsds5AtbEo9auh8n9FQgHEtYZABChQ57iL9O/ugdw6sFexPNBKAcp
         MPs21QdrN/8n1kjIoXPG5pXz9FSbZakkJbo7W4ucXfOpWKxRyG/lfkUg+DUmXGGK5/n/
         6qGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795814856; x=1796419656;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0/dUK912G2QNzQci61XJd4pulyMLltpAdgKeN7EECOY=;
        b=BiCh0/N0Kk8IffLHXYz1DXxuSkwhuGtxbLx6oRHcn0P/x2p+zY1OUoiMY5E3RHBoND
         OaqYlRTEZjELkU6Nybt82ZuPsQggy9b91Ks529I/9oAElTf2GkNgAng0W50Q5ljp3DaP
         FeQI8c8PPkDJEOnMuI8mrjzAVlTFSEzV0fgURv0GEdTy4803xr7dOqKKBoPP2Kqn9EZX
         qnF96qZtwE6VwwR2rVqktMbI9PKR4lD9dJm+mIdwY/l5a34fRjmgX+NWukVWuIM/1Dyv
         zyZirheficm7tr0JVsKFq3mwnHPICt1mJGZ4Uk4eJqk2Ek9kavWMbitu3hphnRW8cHiz
         Elnw==
X-Gm-Message-State: APuU4Z/n36X6IFlqn0AIAe1Zir3+SRatnb1MEEDEajcHB7JsxQ9qh0cw
	A+3CsrX8Nm0SbdWwqjMjfaJzUMGM6An6aYn9pMtwUuWC9M8Z7H7fnjwrtdlP+7uh
X-Gm-Gg: AZFdTZfsCEI80i6/RHzV6DgH9G/QI1ysMaZXCaYKiCFIjWCAhx9qjrgQoQooSVP3UMu
	K24tOCWzgVLbTYxXxGnWZ3nrANw2BLJJ1AwTQV0+CXXZD8sgnss3mGEQvLbTcyLjylxNypppFTr
	ziDBWa85xaC+alVdkrmVso/ah/scq7iFSEeQy3Yc4HX9w+7Ou3UGTBMu9nHoo5XMQVZRDKMYjnY
	5KohQouByjFP1REsJiSccUTk4rPX9afvvyFqumffZnVRhlHO2vzOx2dw47NeDPDUNeihQLoUcIz
	EcuPl2wLUXQvSBFBgRzANYS2fJe/96YgCOK9oJD5Umh8uDJ6F0vj5/xhb+B145P5WOplwy+6EuF
	NgTu0eAUYxr2rZagInC6BVXoWInHfFc37wjMxn4era/ef7d9/J8WbeACtRYfwt60+XZeE2SuEnH
	lOZNs+McXXgkNMoMr1JiX2Yf8dPT+7yR/yeVXuGNOasjL7/LNwD+L6cWX9ErOCUGtei+5D7Ba27
	K3FFxsz3NfKxKUCsfMZuOvxcVrOvQ4f7ADiKs9KFQNotPrq2viGCuT6YuXnv0QjkSvM0eGCQ11i
	a8sz6mAKAvw0LXAzRSI2k6YJKcmHrAxCfvbykWLyi0BdDjUFjQlB
X-Received: by 2002:a05:7300:7b26:b0:36c:dd3b:a3e4 with SMTP id 5a478bee46e88-3856f25f8f2mr28426305eec.3.1795814856168;
        Fri, 27 Nov 2026 13:27:36 -0800 (PST)
Received: from [127.0.0.1] ([20.169.116.17])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385f68bc0adsm70746309eec.13.2026.11.27.13.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 13:27:35 -0800 (PST)
Message-Id: <fc300295ffaef49b592307a90ac3e58bb803b7ca.1795814853.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2509.v3.git.git.1795814853.gitgitgadget@gmail.com>
References: <pull.2509.git.git.1795774880142.gitgitgadget@gmail.com>
	<pull.2509.v3.git.git.1795814853.gitgitgadget@gmail.com>
From: "Alessio Attilio via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 27 Nov 2026 21:27:32 +0000
Subject: [PATCH v3 1/2] submodule: prepare URL helpers for reuse
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

Move the relative submodule URL resolver and the helper that computes
the path back to the superproject from builtin/submodule--helper.c to
submodule.c so they can be shared with git status.

Pass the repository explicitly to the resolver instead of relying on
the_repository, and update existing callers to use the shared helpers.

Signed-off-by: Alessio Attilio <attilio.alessio@protonmail.com>
---
 builtin/submodule--helper.c | 63 ++++++-------------------------------
 submodule.c                 | 41 ++++++++++++++++++++++++
 submodule.h                 |  3 ++
 3 files changed, 54 insertions(+), 53 deletions(-)

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
index a74d1925aa..3eab799f1f 100644
--- a/submodule.c
+++ b/submodule.c
@@ -292,6 +292,47 @@ int is_submodule_active(struct repository *repo, const char *path)
 	return is_tree_submodule_active(repo, null_oid(the_hash_algo), path);
 }
 
+char *resolve_submodule_url(struct repository *repo, const char *rel_url,
+			    const char *up_path, int quiet)
+{
+	char *remoteurl, *resolved_url;
+	const char *remote = repo_default_remote(repo);
+	struct strbuf remotesb = STRBUF_INIT;
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
+	resolved_url = relative_url(remoteurl, rel_url, up_path);
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
-- 
gitgitgadget

