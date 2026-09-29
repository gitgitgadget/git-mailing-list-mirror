Received: from mail-ed2-f33.google.com (mail-ed2-f33.google.com [74.125.228.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3259651A73A
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 18:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707909; cv=none; b=m7+2Pys1XweY83CMNazkupy3BGreCuCIu48IM/fg6fvkbQINL9c2VZeADGZAPzFBMmA4M19qxDBQuVLtF+4uI5oo9QU9dvGkfZcM0lMPd13j1ERq8l4BbAtPIWtnwzIEACEnVItgEso7KABh1ckqQOuXlDazKNJ7YT487r3tXpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707909; c=relaxed/simple;
	bh=KW7HZBTzf6ZMAUoIW4I4IiawFqpS04P2mvGQ2ViEecI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m3eutljbF0/SEcKTGYNSMeHuQpe1eAtdYO2rXdOa85HtnBHYoqkk4v3aGK+eeYoL44p2yW4gAJxcMeMB+pw1byZXXKIL8TIZT33x8aQhxqvrgKsQlmni1tBlNv0MjtXuTeM0mkz5queB3Y72KcD+SGbBcUAUVyCGI29JAHSydWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oPpUgHTN; arc=none smtp.client-ip=74.125.228.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oPpUgHTN"
Received: by mail-ed2-f33.google.com with SMTP id 4fb4d7f45d1cf-6abc27842b6so5092667a12.3
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 11:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790707905; x=1791312705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=R0DYFqZMacOT/qVDbI+Yq3OnMNJgoOfs4dp8iVAbaao=;
        b=oPpUgHTNuH6qTp/WZzxvA1alNdU7gub0V3fd+Oa2epgj9RM+Wik5lOQszTiezPlXzR
         oGbh3BZKDCxh+UyvnUkGUMzH6jyZ8wvWqhsUQEBRTj//nop1wK/7CJVGuquoQX5dsAqi
         9XSEQLd/nxhZcOAwBg5uRL/ai3db6lLxnE9qbSEg7113brMLRaG7sPPS8Xgq55SIsGe3
         kY10GX0eEW2BrxLDp4DK9iOlTV+EmHS7qcWxwpOF24PMJMb2CiRCzmFLanA9KUFOI00F
         yVkuaq1r1uOQe6FSjoFE3dDkYu6YaM7l8dm5p3ugmkHsmlJ0ZZA9owkaloVvK+ZhtLAB
         Hykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790707905; x=1791312705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R0DYFqZMacOT/qVDbI+Yq3OnMNJgoOfs4dp8iVAbaao=;
        b=K1WtSIwVDQ9m2ZDR5fbZlt4CtckXGL2HsJ/nT4f/HgHhBruROyi8w0R/s7d5VFFQrA
         MUYP+xZBwmSv/eQwzCD/kHXs+rplNag84SQh78RKz22LaQDC+bypKaKJU4F0SC78NHcJ
         u3Kqi94QcYM31Fi0mBnUmAnwT9fHa8nc/8Ad7zUSMAIHLQQ+obK7qAHcmpO8+1h3TwLV
         r/Bm8yzNZA89vS5GLDqR+CSTGBLl128b897HA+2Ravo3nGkfIrWbeJgby7qbGA984Zsr
         ChZ5GdU0PEin5WTY79uRd7TPSMlCQGT5/7meU7ucbpsdSCOE6VNknY5rDdHdlExJeQBU
         f2eA==
X-Gm-Message-State: AFq9FYLD0ruzdPYg5iyV0GXWTZYMyNO+WatZ31atvJMrrJapFWUi6mbd
	mHubZuJ/uqXl6miAtlOmBkRmLf0SdRjCOFgYXBjXitb+//bAG6zj9GnVNt4WYuNWexs=
X-Gm-Gg: AYBFou0RDO9IGjwY4coMQeS06QJf1Fhf7ZzbqaBYN7j4IbkrmhC9LkOgM30mS9+iFmc
	VR/UXflSGA76YABffmZRMg02CfynYeKoW5RYvnD7fyP4mo+V1bYWzDbcWdO30Jv7HqSKuqlR6Xq
	jZtPD6GfpZuRbEblssR/81wHWjnxwWJFfwh2zJEmOT0Yujw+qU1L603cEmw1kAHPjGRPabFv3Hg
	YofpjPOGlemOeVMGBR50c9NWaKA2cv0qe9QF5ac4d2gXjYPHYbL1Eg9niD+SztAuDXKd6no/ODe
	c65+XfY3dugtsId4V56MGsN5q8Gxi+l7nOBZRHtFL+WE1OYllj0060RoyID9u8Au0BjzARbbpRr
	uSRHyk0Cqh5HzELkfJG0RpxI7O5jKrZ8tx7wUIjZkWXntCGHravpDS20HoUlh6WzRo63InwXpm9
	Q8Qe0pqdiaXPdcWCm2QnFhAAogQtQpHN0Fhp8Tl1Zgi15BxHy3NMQqFzf9E0cE2LFzrg==
X-Received: by 2002:a05:6402:ea1:b0:6a9:879a:d9e2 with SMTP id 4fb4d7f45d1cf-6aac8f2357dmr13655184a12.3.1790707905088;
        Tue, 29 Sep 2026 11:51:45 -0700 (PDT)
Received: from flare5 ([81.22.196.75])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ace2cbe021sm100545a12.5.2026.09.29.11.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 11:51:44 -0700 (PDT)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Stanislav Aleksandrov <lightofmysoul@gmail.com>
Subject: [RFC PATCH] submodule: make '^/' work like '../' but with an absolute path
Date: Tue, 29 Sep 2026 18:51:22 +0000
Message-ID: <20260929185122.3127574-1-lightofmysoul@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A submodule URL like "../../org/lib.git" breaks when the superproject
is forked to a different depth, e.g. into a GitLab subgroup. An
absolute URL doesn't break, but it forces one protocol on everyone.

Resolve a URL starting with "^/" against the superproject's remote,
like "../", but from the root of the server. Protocol, user, host and
port stay the same. For "^/org/lib.git":

    https://host/me/super.git      ->  https://host/org/lib.git
    git@host:group/sub/super.git   ->  git@host:org/lib.git

Unlike "../", "^/" fails in a superproject cloned from a local path or
without a remote, since there is no server. It also fails for
"<transport>::<address>" remotes, whose address only the helper can
parse.

The syntax comes from svn:externals, where "^/" is the repository root.

Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
RFC: the syntax is new, and it changes the meaning of local paths
that start with "^/".

- Why not "/path" or "//host/path"? "/path" is already a local
  absolute path, "//host" is a network path on Windows, and neither
  can express "git@host:path" or SSH host aliases.
- Why not url.<base>.insteadOf? It has to be set up on every clone;
  .gitmodules cannot carry it.
- Compatibility: a local "^/..." path needs a "^" directory in the
  superproject and protocol.file.allow=always, and "git submodule
  add" refuses it.
- Known costs: "^" is special in cmd.exe, Git Bash rewrites "^/..."
  arguments, and libgit2, JGit and forges would need to learn it.

GitLab has an open request for the same thing:
https://gitlab.com/gitlab-org/gitlab/-/issues/393295

 Documentation/git-submodule.adoc       |   8 +-
 Documentation/gitmodules.adoc          |   7 +-
 builtin/submodule--helper.c            |  39 +++--
 remote.c                               |  61 ++++++++
 remote.h                               |  15 ++
 submodule-config.c                     |   8 +-
 submodule-config.h                     |   6 +
 t/helper/test-submodule.c              |   7 +-
 t/meson.build                          |   1 +
 t/t0060-path-utils.sh                  |  43 ++++++
 t/t7427-submodule-root-relative-url.sh | 190 +++++++++++++++++++++++++
 t/t7450-bad-git-dotfiles.sh            |   5 +
 12 files changed, 366 insertions(+), 24 deletions(-)
 create mode 100755 t/t7427-submodule-root-relative-url.sh

diff --git a/Documentation/git-submodule.adoc b/Documentation/git-submodule.adoc
index 722d827908..f512625eb8 100644
--- a/Documentation/git-submodule.adoc
+++ b/Documentation/git-submodule.adoc
@@ -40,8 +40,9 @@ subcommands are available to perform operations on the submodules.
 	project: the current project is termed the "superproject".
 +
 _<repository>_ is the URL of the new submodule's `origin` repository.
-This may be either an absolute URL, or (if it begins with `./`
-or `../`), the location relative to the superproject's default remote
+This may be an absolute URL, (if it begins with `^/`) an absolute path
+on the server of the superproject's default remote, or (if it begins with
+`./` or `../`), the location relative to the superproject's default remote
 repository (Please note that to specify a repository `foo.git`
 which is located right next to a superproject `bar.git`, you'll
 have to use `../foo.git` instead of `./foo.git` - as one might expect
@@ -53,7 +54,8 @@ of the current branch. If no such remote-tracking branch exists or
 the `HEAD` is detached, `origin` is assumed to be the default remote.
 If the superproject doesn't have a default remote configured
 the superproject is its own authoritative upstream and the current
-working directory is used instead.
+working directory is used instead. A `^/` path needs a default remote
+with a host.
 +
 The optional argument _<path>_ is the relative location for the cloned
 submodule to exist in the superproject. If _<path>_ is not given, the
diff --git a/Documentation/gitmodules.adoc b/Documentation/gitmodules.adoc
index fd96639806..9f6cc9a4ef 100644
--- a/Documentation/gitmodules.adoc
+++ b/Documentation/gitmodules.adoc
@@ -31,9 +31,10 @@ submodule.<name>.path::
 
 submodule.<name>.url::
 	Defines a URL from which the submodule repository can be cloned.
-	This may be either an absolute URL ready to be passed to
-	linkgit:git-clone[1] or (if it begins with `./` or `../`) a location
-	relative to the superproject's origin repository.
+	This may be an absolute URL ready to be passed to
+	linkgit:git-clone[1], (if it begins with `./` or `../`) a location
+	relative to the superproject's origin repository, or (if it begins
+	with `^/`) an absolute path on the server of that repository.
 
 In addition, there are a number of optional keys:
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 5d3bcda334..16884ca6b6 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -50,7 +50,8 @@ static char *get_default_remote(void)
 	return xstrdup(repo_default_remote(the_repository));
 }
 
-static char *resolve_relative_url(const char *rel_url, const char *up_path, int quiet)
+static char *resolve_relative_url_gently(const char *rel_url,
+					 const char *up_path, int quiet)
 {
 	char *remoteurl, *resolved_url;
 	char *remote = get_default_remote();
@@ -58,14 +59,17 @@ static char *resolve_relative_url(const char *rel_url, const char *up_path, int
 
 	strbuf_addf(&remotesb, "remote.%s.url", remote);
 	if (repo_config_get_string(the_repository, remotesb.buf, &remoteurl)) {
-		if (!quiet)
+		if (!quiet && !starts_with(rel_url, "^/"))
 			warning(_("could not look up configuration '%s'. "
 				  "Assuming this repository is its own "
 				  "authoritative upstream."),
 				remotesb.buf);
 		remoteurl = xgetcwd();
 	}
-	resolved_url = relative_url(remoteurl, rel_url, up_path);
+	if (starts_with(rel_url, "^/"))
+		resolved_url = root_relative_url(remoteurl, rel_url);
+	else
+		resolved_url = relative_url(remoteurl, rel_url, up_path);
 
 	free(remote);
 	free(remoteurl);
@@ -74,6 +78,16 @@ static char *resolve_relative_url(const char *rel_url, const char *up_path, int
 	return resolved_url;
 }
 
+static char *resolve_relative_url(const char *rel_url, const char *up_path, int quiet)
+{
+	char *resolved_url = resolve_relative_url_gently(rel_url, up_path, quiet);
+
+	if (!resolved_url)
+		die(_("cannot resolve '%s' without a remote url that has a host"),
+		    rel_url);
+	return resolved_url;
+}
+
 static int get_default_remote_submodule(const char *module_path, char **default_remote)
 {
 	const struct submodule *sub;
@@ -87,11 +101,10 @@ static int get_default_remote_submodule(const char *module_path, char **default_
 		url = xstrdup(sub->url);
 
 		/* Possibly a url relative to parent */
-		if (starts_with_dot_dot_slash(url) ||
-		    starts_with_dot_slash(url)) {
+		if (submodule_url_is_relative(url)) {
 			char *oldurl = url;
 
-			url = resolve_relative_url(oldurl, NULL, 1);
+			url = resolve_relative_url_gently(oldurl, NULL, 1);
 			free(oldurl);
 		}
 	}
@@ -618,8 +631,7 @@ static void init_submodule(const char *path, const char *prefix,
 		url = xstrdup(sub->url);
 
 		/* Possibly a url relative to parent */
-		if (starts_with_dot_dot_slash(url) ||
-		    starts_with_dot_slash(url)) {
+		if (submodule_url_is_relative(url)) {
 			char *oldurl = url;
 
 			url = resolve_relative_url(oldurl, NULL, 0);
@@ -1450,8 +1462,7 @@ static void sync_submodule(const char *path, const char *prefix,
 	sub = submodule_from_path(the_repository, null_oid(the_hash_algo), path);
 
 	if (sub && sub->url) {
-		if (starts_with_dot_dot_slash(sub->url) ||
-		    starts_with_dot_slash(sub->url)) {
+		if (submodule_url_is_relative(sub->url)) {
 			char *up_path = get_up_path(path);
 
 			sub_origin_url = resolve_relative_url(sub->url, up_path, 1);
@@ -2314,8 +2325,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "submodule.%s.url", sub->name);
 	if (repo_config_get_string_tmp(the_repository, sb.buf, &url)) {
-		if (sub->url && (starts_with_dot_slash(sub->url) ||
-				 starts_with_dot_dot_slash(sub->url))) {
+		if (sub->url && submodule_url_is_relative(sub->url)) {
 			url = resolve_relative_url(sub->url, NULL, 0);
 			need_free_url = 1;
 		} else
@@ -3710,8 +3720,7 @@ static int module_add(int argc, const char **argv, const char *prefix,
 		free(sm_path);
 	}
 
-	if (starts_with_dot_dot_slash(add_data.repo) ||
-	    starts_with_dot_slash(add_data.repo)) {
+	if (submodule_url_is_relative(add_data.repo)) {
 		if (prefix)
 			die(_("Relative path can only be used from the toplevel "
 			      "of the working tree"));
@@ -3722,7 +3731,7 @@ static int module_add(int argc, const char **argv, const char *prefix,
 	} else if (is_dir_sep(add_data.repo[0]) || strchr(add_data.repo, ':')) {
 		add_data.realrepo = add_data.repo;
 	} else {
-		die(_("repo URL: '%s' must be absolute or begin with ./|../"),
+		die(_("repo URL: '%s' must be absolute or begin with ./|../|^/"),
 		    add_data.repo);
 	}
 
diff --git a/remote.c b/remote.c
index fe62068463..05ef35e3ab 100644
--- a/remote.c
+++ b/remote.c
@@ -3095,6 +3095,67 @@ char *relative_url(const char *remote_url, const char *url,
 	return strbuf_detach(&sb, NULL);
 }
 
+static const char *skip_bracketed_host(const char *host)
+{
+	const char *start = strstr(host, "@[");
+	const char *end;
+
+	start = start ? start + 1 : host;
+	if (*start != '[')
+		return host;
+	end = strchr(start + 1, ']');
+	return end ? end : host;
+}
+
+static int has_host(const char *start, const char *end)
+{
+	const char *p;
+
+	for (p = start; p < end; p++)
+		if (*p == '@')
+			start = p + 1;
+	return start < end && *start != ':' && !starts_with(start, "[]");
+}
+
+char *root_relative_url(const char *remote_url, const char *url)
+{
+	struct strbuf sb = STRBUF_INIT;
+	const char *path, *host, *end;
+	int scp;
+
+	if (!skip_prefix(url, "^/", &path))
+		BUG("not a root-relative url: '%s'", url);
+	if (*path == '/' || *path == ':')
+		die(_("root-relative url '%s' must not start with '^//' or '^/:'"),
+		    url);
+
+	for (end = remote_url; is_urlschemechar(end == remote_url, *end); end++)
+		;
+	if (starts_with(end, "::") || starts_with(remote_url, "file://") ||
+	    url_is_local_not_ssh(remote_url))
+		return NULL;
+
+	scp = !is_url(remote_url);
+	if (scp) {
+		host = remote_url;
+		end = strchr(skip_bracketed_host(remote_url), ':');
+	} else {
+		host = strstr(remote_url, "://") + 3;
+		end = strchrnul(host, '/');
+	}
+	if (!end || !has_host(host, end))
+		return NULL;
+
+	strbuf_add(&sb, remote_url, end - remote_url);
+	strbuf_addch(&sb, scp ? ':' : '/');
+	if (scp && end[1] == '/')
+		strbuf_addch(&sb, '/');
+	strbuf_addstr(&sb, path);
+	if (ends_with(path, "/"))
+		strbuf_setlen(&sb, sb.len - 1);
+	return strbuf_detach(&sb, NULL);
+}
+
 int valid_remote_name(const char *name)
 {
 	int result;
diff --git a/remote.h b/remote.h
index cca02033b9..8a759ae20d 100644
--- a/remote.h
+++ b/remote.h
@@ -478,6 +478,21 @@ void apply_push_cas(struct push_cas_option *, struct remote *, struct ref *);
 char *relative_url(const char *remote_url, const char *url,
 		   const char *up_path);
 
+/*
+ * The `url` argument starts with "^/" and names a repository relative to
+ * the root of the server that `remote_url` points to: the path of
+ * `remote_url` is replaced with the rest of `url`, keeping its scheme, user,
+ * host and port. Returns NULL if `remote_url` has no host, and dies if
+ * `url` continues with '/' or ':', which could change the kind of URL.
+ *
+ * remote_url                 url            outcome
+ * https://a.com/b/c          ^/d/e          https://a.com/d/e
+ * ssh://u@a.com:22/b/c       ^/d/e          ssh://u@a.com:22/d/e
+ * u@a.com:b/c                ^/d/e          u@a.com:d/e
+ * u@a.com:/b/c               ^/d/e          u@a.com:/d/e
+ */
+char *root_relative_url(const char *remote_url, const char *url);
+
 int valid_remote_name(const char *name);
 
 #endif
diff --git a/submodule-config.c b/submodule-config.c
index 37c3be377b..dfa819112c 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -237,9 +237,10 @@ int check_submodule_name(const char *name)
 	return 0;
 }
 
-static int submodule_url_is_relative(const char *url)
+int submodule_url_is_relative(const char *url)
 {
-	return starts_with_dot_slash(url) || starts_with_dot_dot_slash(url);
+	return starts_with_dot_slash(url) || starts_with_dot_dot_slash(url) ||
+	       starts_with(url, "^/");
 }
 
 /*
@@ -342,6 +343,9 @@ int check_submodule_url(const char *url)
 		if (count_leading_dotdots(url, &next) > 0 &&
 		    (*next == ':' || *next == '/'))
 			return -1;
+		if (skip_prefix(url, "^/", &next) &&
+		    (*next == ':' || *next == '/'))
+			return -1;
 	}
 
 	else if (url_to_curl_url(url, &curl_url)) {
diff --git a/submodule-config.h b/submodule-config.h
index 755570d5d1..3e947291d5 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -94,6 +94,12 @@ int check_submodule_name(const char *name);
 /* Returns 0 if the URL valid per RFC3986 and -1 otherwise. */
 int check_submodule_url(const char *url);
 
+/*
+ * Returns 1 if the URL is resolved against the superproject's remote,
+ * i.e. starts with "./", "../" or "^/", and 0 otherwise.
+ */
+int submodule_url_is_relative(const char *url);
+
 /*
  * Note: these helper functions exist solely to maintain backward
  * compatibility with 'fetch' and 'update_clone' storing configuration in
diff --git a/t/helper/test-submodule.c b/t/helper/test-submodule.c
index ea9bef0904..f28daf52fe 100644
--- a/t/helper/test-submodule.c
+++ b/t/helper/test-submodule.c
@@ -123,7 +123,12 @@ static int cmd__submodule_resolve_relative_url(int argc, const char **argv)
 	if (!strcmp(up_path, "(null)"))
 		up_path = NULL;
 
-	res = relative_url(remoteurl, url, up_path);
+	if (starts_with(url, "^/"))
+		res = root_relative_url(remoteurl, url);
+	else
+		res = relative_url(remoteurl, url, up_path);
+	if (!res)
+		die("cannot resolve '%s' against '%s'", url, remoteurl);
 	puts(res);
 	free(res);
 	free(remoteurl);
diff --git a/t/meson.build b/t/meson.build
index 3ca7b27104..9d3ac94aae 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -918,6 +918,7 @@ integration_tests = [
   't7424-submodule-mixed-ref-formats.sh',
   't7425-submodule-gitdir-path-extension.sh',
   't7426-submodule-get-default-remote.sh',
+  't7427-submodule-root-relative-url.sh',
   't7450-bad-git-dotfiles.sh',
   't7500-commit-template-squash-signoff.sh',
   't7501-commit-basic-functionality.sh',
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 56faf5fe73..c8618e8a30 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -7,6 +7,11 @@ test_description='Test various path utilities'
 
 . ./test-lib.sh
 
+# Keep MSYS2 from turning "^/..." arguments into Windows paths. The value
+# must not look like a path itself, or MSYS2 rewrites it for child processes.
+MSYS2_ARG_CONV_EXCL='^'
+export MSYS2_ARG_CONV_EXCL
+
 norm_path() {
 	expected=$(test-tool path-utils print_path "$2")
 	test_expect_success $3 "normalize path: $1 => $2" "
@@ -435,6 +440,44 @@ test_submodule_relative_url "(null)" "user@host:path/to/repo" "../subrepo" "user
 test_submodule_relative_url "(null)" "user@host:repo" "../subrepo" "user@host:subrepo"
 test_submodule_relative_url "(null)" "user@host:repo" "../../subrepo" ".:subrepo"
 
+test_submodule_relative_url "(null)" "https://example.com/me/super.git" "^/org/lib.git" "https://example.com/org/lib.git"
+test_submodule_relative_url "(null)" "https://example.com/a/b/c/super.git" "^/org/lib.git" "https://example.com/org/lib.git"
+test_submodule_relative_url "(null)" "https://example.com" "^/org/lib.git" "https://example.com/org/lib.git"
+test_submodule_relative_url "(null)" "https://user@example.com:8443/me/super.git" "^/org/lib.git" "https://user@example.com:8443/org/lib.git"
+test_submodule_relative_url "(null)" "https://example.com/me/super.git" "^/org/lib/" "https://example.com/org/lib"
+test_submodule_relative_url "../" "https://example.com/me/super.git" "^/org/lib.git" "https://example.com/org/lib.git"
+test_submodule_relative_url "(null)" "helper://example.com/me/super.git" "^/org/lib.git" "helper://example.com/org/lib.git"
+test_submodule_relative_url "(null)" "ssh://git@example.com:2222/a/b/super.git" "^/org/lib.git" "ssh://git@example.com:2222/org/lib.git"
+test_submodule_relative_url "(null)" "ssh://git@[::1]:2222/me/super.git" "^/org/lib.git" "ssh://git@[::1]:2222/org/lib.git"
+test_submodule_relative_url "(null)" "ssh://example.com/~user/super.git" "^/org/lib.git" "ssh://example.com/org/lib.git"
+test_submodule_relative_url "(null)" "git@example.com:me/super.git" "^/org/lib.git" "git@example.com:org/lib.git"
+test_submodule_relative_url "(null)" "git@example.com:a/b/super.git" "^/org/lib.git" "git@example.com:org/lib.git"
+test_submodule_relative_url "(null)" "git@example.com:/srv/git/super.git" "^/org/lib.git" "git@example.com:/org/lib.git"
+test_submodule_relative_url "(null)" "example.com:~user/super.git" "^/org/lib.git" "example.com:org/lib.git"
+test_submodule_relative_url "(null)" "git@[::1]:me/super.git" "^/org/lib.git" "git@[::1]:org/lib.git"
+test_submodule_relative_url "(null)" "[::1]:me/super.git" "^/org/lib.git" "[::1]:org/lib.git"
+
+test_expect_success 'root-relative submodule url needs a remote with a host' '
+	for remote in /srv/git/super.git ../super.git file:///srv/git/super.git \
+		helper::https://example.com/super.git "[::1]" \
+		https:///srv/git/super.git https://user@/super.git \
+		ssh://:22/super.git :super.git git@:super.git "[]:super.git"
+	do
+		test_must_fail test-tool submodule resolve-relative-url \
+			"(null)" "$remote" "^/org/lib.git" 2>err &&
+		test_grep "cannot resolve" err || return 1
+	done
+'
+
+test_expect_success 'root-relative submodule url cannot change the kind of url' '
+	for url in "^//evil.example.com/x.git" "^/:evil"
+	do
+		test_must_fail test-tool submodule resolve-relative-url \
+			"(null)" host:/srv/super.git "$url" 2>err &&
+		test_grep "must not start with" err || return 1
+	done
+'
+
 test_expect_success 'match .gitmodules' '
 	test-tool path-utils is_dotgitmodules \
 		.gitmodules \
diff --git a/t/t7427-submodule-root-relative-url.sh b/t/t7427-submodule-root-relative-url.sh
new file mode 100755
index 0000000000..526dfec8d2
--- /dev/null
+++ b/t/t7427-submodule-root-relative-url.sh
@@ -0,0 +1,190 @@
+#!/bin/sh
+
+test_description='submodule urls relative to the server root (^/)'
+
+. ./test-lib.sh
+
+# Keep MSYS2 from turning "^/..." arguments into Windows paths. The value
+# must not look like a path itself, or MSYS2 rewrites it for child processes.
+MSYS2_ARG_CONV_EXCL='^'
+export MSYS2_ARG_CONV_EXCL
+
+test_expect_success 'setup' '
+	git config --global protocol.file.allow always &&
+	git config --global url."$(pwd)/server/".insteadOf https://example.com/ &&
+	git config --global --add url."$(pwd)/server/".insteadOf git@example.com: &&
+
+	git init --bare server/org/dep.git &&
+	git init --bare server/org/lib.git &&
+	git init --bare server/org/team/super.git &&
+
+	git clone https://example.com/org/dep.git dep &&
+	test_commit -C dep dep &&
+	git -C dep push origin HEAD &&
+
+	git clone https://example.com/org/lib.git lib &&
+	test_commit -C lib lib &&
+	git -C lib submodule add ^/org/dep.git dep &&
+	git -C lib commit -m "add dep" &&
+	git -C lib push origin HEAD &&
+
+	git clone https://example.com/org/team/super.git super &&
+	test_commit -C super super &&
+	git -C super submodule add ^/org/lib.git lib &&
+	git -C super commit -m "add lib" &&
+	git -C super push origin HEAD &&
+
+	git clone --bare server/org/team/super.git server/me/super.git
+'
+
+test_expect_success 'add records the url as given' '
+	test_cmp_config -C super "^/org/lib.git" -f .gitmodules submodule.lib.url &&
+	test_cmp_config -C super https://example.com/org/lib.git submodule.lib.url
+'
+
+test_expect_success 'clone of the upstream in a subgroup' '
+	git clone --recurse-submodules https://example.com/org/team/super.git upstream &&
+	test_cmp_config -C upstream https://example.com/org/lib.git submodule.lib.url &&
+	test_path_is_file upstream/lib/lib.t &&
+	test_path_is_file upstream/lib/dep/dep.t
+'
+
+test_expect_success 'clone of a fork at a different depth' '
+	git clone --recurse-submodules https://example.com/me/super.git fork &&
+	test_cmp_config -C fork https://example.com/org/lib.git submodule.lib.url &&
+	test_cmp_config -C fork/lib https://example.com/org/dep.git submodule.dep.url &&
+	test_path_is_file fork/lib/dep/dep.t
+'
+
+test_expect_success 'clone over scp-like ssh uses ssh for submodules' '
+	git clone --recurse-submodules git@example.com:me/super.git fork-ssh &&
+	test_cmp_config -C fork-ssh git@example.com:org/lib.git submodule.lib.url &&
+	test_cmp_config -C fork-ssh/lib git@example.com:org/dep.git submodule.dep.url &&
+	test_path_is_file fork-ssh/lib/dep/dep.t
+'
+
+test_expect_success 'sync follows a changed superproject remote' '
+	git -C fork remote set-url origin ssh://git@example.com:2222/me/super.git &&
+	git -C fork submodule sync &&
+	test_cmp_config -C fork ssh://git@example.com:2222/org/lib.git submodule.lib.url &&
+	test_cmp_config -C fork/lib ssh://git@example.com:2222/org/lib.git remote.origin.url
+'
+
+test_expect_success 'get-default-remote finds the submodule remote by its ^/ url' '
+	git -C fork/lib remote rename origin upstream &&
+	git -C fork/lib remote add other https://example.com/org/dep.git &&
+	echo upstream >expect &&
+	git -C fork submodule--helper get-default-remote lib >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'init fails when the remote has no host' '
+	git clone server/me/super.git local &&
+	test_must_fail git -C local submodule init 2>err &&
+	test_grep "cannot resolve .* without a remote url that has a host" err
+'
+
+test_expect_success 'init without a remote does not suggest the cwd fallback' '
+	git init noremote &&
+	git -C noremote config -f .gitmodules submodule.lib.path lib &&
+	git -C noremote config -f .gitmodules submodule.lib.url "^/org/lib.git" &&
+	git -C noremote update-index --add --cacheinfo \
+		160000,$(git -C lib rev-parse HEAD),lib &&
+	test_must_fail git -C noremote submodule init 2>err &&
+	test_grep "cannot resolve" err &&
+	test_grep ! "authoritative upstream" err
+'
+
+test_expect_success 'update fails when the remote has no host' '
+	git -C noremote config submodule.lib.active true &&
+	test_must_fail git -C noremote submodule update 2>err &&
+	test_grep "cannot resolve .* without a remote url that has a host" err
+'
+
+test_expect_success 'update --init fails even if the submodule is not updated' '
+	test_must_fail git -C noremote -c submodule.lib.update=none \
+		submodule update --init 2>err &&
+	test_grep "cannot resolve" err
+'
+
+test_expect_success 'sync fails when the remote has no host' '
+	git -C local config submodule.lib.active true &&
+	test_must_fail git -C local submodule sync 2>err &&
+	test_grep "cannot resolve .* without a remote url that has a host" err
+'
+
+test_expect_success 'add fails when the remote has no host' '
+	test_must_fail git -C local submodule add "^/org/dep.git" dep 2>err &&
+	test_grep "cannot resolve .* without a remote url that has a host" err &&
+	test_path_is_missing local/dep
+'
+
+test_expect_success 'clone --recurse-submodules stops when the remote has no host' '
+	git init --bare server/org/mixed.git &&
+	git init mixed &&
+	git -C mixed config -f .gitmodules submodule.lib.path lib &&
+	git -C mixed config -f .gitmodules submodule.lib.url "^/org/lib.git" &&
+	git -C mixed config -f .gitmodules submodule.zz.path zz &&
+	git -C mixed config -f .gitmodules submodule.zz.url ../dep.git &&
+	git -C mixed update-index --add \
+		--cacheinfo 160000,$(git -C lib rev-parse HEAD),lib \
+		--cacheinfo 160000,$(git -C dep rev-parse HEAD),zz &&
+	git -C mixed add .gitmodules &&
+	git -C mixed commit -m mixed &&
+	git -C mixed push "$(pwd)/server/org/mixed.git" HEAD &&
+
+	test_must_fail git clone --recurse-submodules server/org/mixed.git \
+		mixed-clone 2>err &&
+	test_grep "cannot resolve .* without a remote url that has a host" err &&
+	test_path_is_missing mixed-clone/zz/dep.t
+'
+
+test_expect_success 'nested ^/ fails when the submodule remote has no host' '
+	git init --bare server/org/rel.git &&
+	git init rel &&
+	git -C rel config -f .gitmodules submodule.lib.path lib &&
+	git -C rel config -f .gitmodules submodule.lib.url ../lib.git &&
+	git -C rel update-index --add --cacheinfo \
+		160000,$(git -C lib rev-parse HEAD),lib &&
+	git -C rel add .gitmodules &&
+	git -C rel commit -m rel &&
+	git -C rel push "$(pwd)/server/org/rel.git" HEAD &&
+
+	test_must_fail git clone --recurse-submodules server/org/rel.git \
+		rel-clone 2>err &&
+	test_grep "cannot resolve .*dep.git. without a remote url that has a host" err
+'
+
+test_expect_success 'explicit url overrides a root-relative one' '
+	git -C local config submodule.lib.url "$(pwd)/server/org/lib.git" &&
+	git -C local submodule update --init &&
+	test_path_is_file local/lib/lib.t &&
+	git -C local submodule update --remote &&
+	test_path_is_file local/lib/lib.t
+'
+
+test_expect_success '^/ means the server root even if a local ^ directory exists' '
+	git init literal &&
+	mkdir -p "literal/^/org" &&
+	git clone --bare server/org/lib.git "literal/^/org/lib.git" &&
+	git -C literal config -f .gitmodules submodule.lib.path lib &&
+	git -C literal config -f .gitmodules submodule.lib.url "^/org/lib.git" &&
+	git -C literal update-index --add --cacheinfo \
+		160000,$(git -C lib rev-parse HEAD),lib &&
+
+	git -C literal remote add origin https://example.com/me/super.git &&
+	git -C literal submodule init &&
+	test_cmp_config -C literal https://example.com/org/lib.git submodule.lib.url &&
+
+	git -C literal config --unset submodule.lib.url &&
+	git -C literal remote set-url origin "$(pwd)/server/me/super.git" &&
+	test_must_fail git -C literal submodule init
+'
+
+test_expect_success 'add from a subdirectory is refused' '
+	mkdir super/sub &&
+	test_must_fail git -C super/sub submodule add ^/org/dep.git dep 2>err &&
+	test_grep "Relative path can only be used from the toplevel" err
+'
+
+test_done
diff --git a/t/t7450-bad-git-dotfiles.sh b/t/t7450-bad-git-dotfiles.sh
index 72c7f6f73b..0df7cb4a92 100755
--- a/t/t7450-bad-git-dotfiles.sh
+++ b/t/t7450-bad-git-dotfiles.sh
@@ -49,12 +49,17 @@ test_expect_success 'check urls' '
 	./bar/baz/foo.git
 	https://example.com/foo.git
 	http://example.com:80/deeper/foo.git
+	^/org/foo.git
 	EOF
 
 	test-tool submodule check-url >actual <<-\EOF &&
 	./bar/baz/foo.git
 	https://example.com/foo.git
 	http://example.com:80/deeper/foo.git
+	^/org/foo.git
+	^/%0ahost=example.com/foo.git
+	^//evil.example.com/foo.git
+	^/:foo.git
 	-a./foo
 	../../..//test/foo.git
 	../../../../../:localhost:8080/foo.git
-- 
2.55.0

