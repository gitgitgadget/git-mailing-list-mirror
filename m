Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795796167;
	b=5Sg+/TQ6z/bGq4e3cQtw/8kUHQWn2AHFWW3BLDna1488cm/kMCuwPKzAp5iktKCOY0Zs
	 aUMcV65184l4gKcIHm14GGL4PP4k/Wcx3Cw7c0mBVS9cikZ2tjOrAcmSgR1NGFd4cj716
	 BxDoXTvh79UJM9EzXANyEZ8gyb1hku18yz+nOLVXmHTLHNgBWuJB13IcQp9Htv+OvuBQH
	 S04jaR5r+ymXw6GRUIvnlCgAAgvkwNscIfxDsZpmS2X702ZBqtB9rNOMwF9n3EcqzV6tb
	 Y/wU3xFOHR4wvTs5W/2mFTouX8cJNbt36Gu/3uVWmzF5NrwZ4XrOYGh1zVX5+2PT++g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795796167;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=l47vbBsWKBhuR03+rOrhNAknyILw6Uv5lGx/8aI/Uj4=;
	b=yB7H9NGfDO4j4UI5HsqRD1WHaD66IYJs9aFVBGqryZERx6oX+/VVtrvlXpMlHivbZ4io
	 nt84ahexjsjec7GB8Og3sc/BpB1cfRdv+D47tYYfw4fhYmKI0gMLNOm5awJNsjB+q3RFv
	 n0YBVvbslK92dfmVNfwzmrqOyg4pf66umLHiE+4Gp89KagajuHF4lMwvip3V4c1d/By1x
	 djDGLKWUwzkMGA+ecsYsmMYHGjpFzZgYjtXpOMuoKlIhaCb54YDNDNQzLvn3L2Io6PD9q
	 4Pu+NG/RMwTQ3ihmTdSfzj0IWzNlN8VSb2L/TSMDJguCZ6Bz4p1fDJxVLVypMFjqHLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GmNMGHOz;
	arc=none smtp.remote-ip=209.85.167.169
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C0B606A32E
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 16:16:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67C0B606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GmNMGHOz
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-53ec9237600so3811333b6e.3
        for <git@vger.kernel.org>; Fri, 27 Nov 2026 08:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795796166; x=1796400966; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=l47vbBsWKBhuR03+rOrhNAknyILw6Uv5lGx/8aI/Uj4=;
        b=GmNMGHOzLiPi9MNkVtklSREOIVaowixHMkD+Rn5hFCtRAf2SM98bx1oSHe5561490w
         JsAOCMbnVGmEK7D4Sgt8yAxlr5FGY03FzLr1YLN56vrJ7YnpnY6sltL2TTtqyZUgsdjb
         17syg0evK1x573vKxGMG2eDLVj0VC+vRe2mbk8ndIO3BuFVsoQ/BAnF3iS6rWgvbFlhQ
         uSUd1n3yxSuURVGA8YHEBqdmSf16hSthq2hccAU3agp66PYneoyQvaZ8w43pBjHm+nwI
         ucTpB51D1exCurmDkvpcJVi4FCts+eC5h0yeMOajZfPlz487zoOa8a8GcDXbp0vHNx09
         umPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795796166; x=1796400966;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l47vbBsWKBhuR03+rOrhNAknyILw6Uv5lGx/8aI/Uj4=;
        b=mau5xYCIsOzSk2jQcMCFBJ/3rGaYJbGrLRwXBeR8BHio2ugS+q3IeHRfLJny7jMe+c
         TzBrg9qbfvfOn8wmyfT+hRiIj5jhPgP8rdFagY1zbNXBr7ufVWXlV83Wpwep1C4TtSpS
         SKLLq9EGGW9mR2D2swP4Zu9hV0LdQJfNm9zgvaItKT2j1iPwBKvGUevNSMxWeyEjBZOU
         OBD7mBVniqcvxwBJUjNncZpw8Jcc0sKk8C0tm7ZUo/wmWJLjXoRYB+BN/xefjXkWXBbe
         Htp7ZjlXqaw4s4MDi7YmijIH8KtHXDXF8NNqOiy5u0QfrCnzgqFl+pQECYWaxhaiFmJM
         rVBQ==
X-Gm-Message-State: APuU4Z+07JSxF1fs84VNjdhU6it2fBN8qc6BGSSfRfWp3Rmk+WkycsB4
	ti6kbD5/jspie/o0NQ4ut6+qG1WyCPSYY4fV9wqiKfcG25Dz1ojzwBceHtf1MQ==
X-Gm-Gg: AZFdTZcLmoOdziY3qpPBgsm70GB/WrK3DsbbQKVrE6DPnDWDffKtV6oOaouGx1LD318
	WAXymU0RHFhCo/BnLgo2APu1nOU/hGH9xR7vh5mSB5czu+rr9ayDnVFQqVUT9QUgB1eDetVNUPB
	jE06+Tp/2cZxfrmxkplgzxbt1W5WN4qF9Vn8UfrFi3aAAealo1U+ohzd1+s1525z1xbDXMEot3o
	pF55ZesPeJJpR6nT1a4u0/EO1w7qyVOoUbv6m6Aol8sk8VG7X8YoJl/jvCZ/gLCDaI4FhILvL3t
	D1GUxzzNJHJJwW2Mc6mZzJz4autjwOKxwaODvXdhqYFZDBO8TzOVsm9775dhX9g8NNfHoa+t9vX
	WCiDzJgWI9A5NfBBlcCYzztgeHCEtlktlEGESMUgTpMkvQrSGoJJ5TreK+qcUxbdrKylZ6o7OcE
	aombn0FflAECVnyxwRZg23AFKUH2fIUsLfjiPGjjGZIDQSVnudRrEcLNZn5VtswjM+/viaIUfGq
	7V+uGcSVC4TgwO9lWWSBxp5AolgF9JLBUrsdjI+EdTMO0R3BzBEL/JMnadYozAtAPk7LDWQcaI6
	akiuX7zhlHT5pwBFg5fafE8P+mHPzDRwlKIS4D9+LXx03akQ/BsEhZY=
X-Received: by 2002:a05:6808:178f:b0:55c:888:30ff with SMTP id 5614622812f47-57a0bb6edfbmr27427742b6e.45.1795796166147;
        Fri, 27 Nov 2026 08:16:06 -0800 (PST)
Received: from [127.0.0.1] ([40.124.101.213])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a347636b9sm18815820b6e.7.2026.11.27.08.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 08:16:05 -0800 (PST)
Message-Id: <4cd0ab7e9b1e4c9d350534ae9c6ffe18a4a88020.1795796162.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2509.v2.git.git.1795796162.gitgitgadget@gmail.com>
References: <pull.2509.git.git.1795774880142.gitgitgadget@gmail.com>
	<pull.2509.v2.git.git.1795796162.gitgitgadget@gmail.com>
From: "Alessio Attilio via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 27 Nov 2026 16:16:01 +0000
Subject: [PATCH v2 1/2] submodule: prepare URL helpers for reuse
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
index a74d1925aa..f9ca99c5c8 100644
--- a/submodule.c
+++ b/submodule.c
@@ -292,6 +292,47 @@ int is_submodule_active(struct repository *repo, const char *path)
 	return is_tree_submodule_active(repo, null_oid(the_hash_algo), path);
 }
 
+char *resolve_submodule_url(struct repository *repo, const char *url,
+			    const char *up_path, int quiet)
+{
+	const char *remote = repo_default_remote(repo);
+	char *remoteurl, *resolved_url;
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
-- 
gitgitgadget

