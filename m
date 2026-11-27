Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795796170;
	b=voJhkCUkNz8xvKF9D2xVJx/SBtFoMJePAGk8sP1fmJPg/toy13uHOneyh2z00M0cfilY
	 ZSV9Xylr2dwOW0k/JlO+lSHfwezL//TQ+EpuF3xT3x4iBcs2WnTqQsZ+u6+j4h2xnmkjX
	 ll8T66T2Pn8XMZh8lUtptBlfq30T8nEOrnj2TF/+OCpGllK72AM0ihAP6jOzc+/8idew7
	 01th2wLs5PG5QgATVNC+y8zQ3UFkGffFlQycrf4erSL9+hDJWcmG5hIiJDtt6xHVU+gat
	 t+Y6MmfOJBuGBO8IJ7ElSUM1hVd7cyJ3V74RnAEGQUhqmZgX8eZZ0qDbr7eSwPChyhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795796170;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=FtcatmOFmmRCjSAI7dNTnC/+0dKmkpJPceOg7OL5Hu8=;
	b=iqixhkzV16liHKhtv84qE2GFNwFlqmSNAn1FQ4q8Z3W4jgzD1lK6UEJthmWpy0vMw7al
	 C6Am+5omHFVCxbv6wTLfaEtkUfwDIL3eAyDUMmWu4gwvnzEu1oaI50fMFqsbnyiww7kjb
	 mR2cCbsjPH4rCKq8lfD1i+bvxyoiyydU4JvZOeBY6MT8Eba1JgfblQheamEYxLn3uMuND
	 Y3yMVxsBN0/j8gOBj1qdFXvN5eHxrGQdR++Oam5skE0XflYWUuQ4zfdTpCf2GLGB8bYcl
	 u2dlHf4+HjmldGSFHuRKMz9q0v+iObq/Skz1ARJ78mKFlzrmEgF3yxLspRyJvvCSaAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="xxZxEC/p";
	arc=none smtp.remote-ip=209.85.161.48
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7EC606A323
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 16:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA7EC606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xxZxEC/p
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-7190d9bdb2cso4939015eaf.0
        for <git@vger.kernel.org>; Fri, 27 Nov 2026 08:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795796169; x=1796400969; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FtcatmOFmmRCjSAI7dNTnC/+0dKmkpJPceOg7OL5Hu8=;
        b=xxZxEC/pPRLZAzbSn4wRtuEy5jihuJ0yltmdlja9ze9njDDkEnq4e1o5yiFVGdxB/C
         6P5veL52yGUCV8kbncjcrdP9cDlwWRA+VYnX1364pKM+T7P3RDZTN7Ya4iDeTEefV3dF
         vmJ3IUag3Py2/HarZ59sBkXQnZIlYLEUKXZ0LDqJlmHxNDcwIIUhpNPv9OhIHgcpA6dh
         Pg53jIuD60lIaPsWT9tEEUaXGYWE2ROmmR3dWN8ZhMNKIfpiY6I8/Wv1X9WgRcGW8EpX
         1TorPlFIQ1QyS8AvnNNIk2MapcSWnYyGam5CsQeyBGn8wv6eT+zRbxb0l3uo9NIH9bZ+
         i40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795796169; x=1796400969;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FtcatmOFmmRCjSAI7dNTnC/+0dKmkpJPceOg7OL5Hu8=;
        b=HHnOKXn1A8Ysn1v/UFKWas4ydBUIYtOkh01Q7n27OPOqn2efZLh+5xO6XkIAEPmnGZ
         tyiLAIJEbZqOeVqyAu8YycKU7NGkUShtghhSr+x4V6LzHIS6nTIdrg7dRPiSCpEEg9j3
         +JTqVZpFW57KAgdfynbfzWrEjbbB81yrUOts7dlISRiULI7fzR+w5UGCDzySRqpDu9ND
         0FhMSHhQACxixVJFxA9k68tQvVNwS5O4IpLve7CEXAqn4s3M3djne08RICI2Osd1ZReE
         iep03/RyZu7c6Sh/0yE1blvuoBugE8p270hnnmdt133SyVF8Uu2J6rD4AacdMzhViF+Y
         cm5w==
X-Gm-Message-State: APuU4Z+p6/xSZTpovf6npebWwOEUvdaULMwhAQQwZFkA5bjwBSCT16kY
	ELsfkkWjuB7xvsIftKMome59+itTj7R11LXCAa+3TFN4TPSFcXul0HrdMot2Ndyl
X-Gm-Gg: AZFdTZcY5EjClVtzz0Do+wSQWSu62p2/YZl0FVlwBPkr2Pi34gL3B8RosGZlBymPBZB
	3045MnSiUeNISYa55OT+ao09Q6u0ckU/WsUI48nT0bA3f/wpiXgDy3EbPNYgjZUrQz4fkly8wgY
	0rLtkDCv/8s4JwlT82qg95TQY6vX+x8VruNklTFk71jH3ogQeznH12h7rv568B30/+qju2RoPNQ
	TDIL4/HHdPBAY78JqD0J7+IjH+nGiQASav/sHzqQvBlQQplBLDYL0CwS1sk8l6mCANTnksHM9U+
	Ekt8FAriAzq3uI5EPo6XjYrf+Xr5Ers4E/TRRCchITb1Kv9pdU+OpsWglQQsoyvO9rcAjg7XFhK
	RlvoVAd5WcL8BVkKTyLlbpwjPU2brT+C5jCsE0AwPXwAKCtJTBqsZGN8sSZ9MzdQZJ8PaOuULrt
	B080MedlV6I3sFOn8Y2m2meGFCy+ZLX7nGMPLzk4lEh32an0hmM3jaLSKxaIZdSNJaUKULUgz4e
	XDsLwB6q7eI1C9BG5jNFDW2Dq1CsxYj0/1KUibFAuDAKsG1CYjBpnnD4Hc81abmT8AuETZSbU3p
	5oLG23eBqVyiXTIoOnqh9md6ievlAZHIkrUzrHtKoWi4tHF6tKe4+hA=
X-Received: by 2002:a05:6820:616:b0:71b:85a5:c1af with SMTP id 006d021491bc7-71b85a5cc50mr6361439eaf.85.1795796168825;
        Fri, 27 Nov 2026 08:16:08 -0800 (PST)
Received: from [127.0.0.1] ([40.124.101.213])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b3806fc45sm15979112eaf.8.2026.11.27.08.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 08:16:07 -0800 (PST)
Message-Id: <b0dd21100ccfe4411ccc1237fdb7ddedb66075e8.1795796162.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2509.v2.git.git.1795796162.gitgitgadget@gmail.com>
References: <pull.2509.git.git.1795774880142.gitgitgadget@gmail.com>
	<pull.2509.v2.git.git.1795796162.gitgitgadget@gmail.com>
From: "Alessio Attilio via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 27 Nov 2026 16:16:02 +0000
Subject: [PATCH v2 2/2] status: warn about stale submodule URLs
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

When a submodule URL changes in .gitmodules, the cached
submodule.<name>.url in the superproject config can stay stale. Warn
in git status so users can run git submodule sync before a later
submodule operation uses the outdated URL.

Resolve relative URLs using the same paths as git submodule sync.
Avoid warning when the submodule remote indicates a local
customization that sync would overwrite.

Signed-off-by: Alessio Attilio <attilio.alessio@protonmail.com>
---
 submodule.c       |   3 ++
 t/t7508-status.sh |  54 ++++++++++++++++++++++++
 wt-status.c       | 104 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 161 insertions(+)

diff --git a/submodule.c b/submodule.c
index f9ca99c5c8..5d0018d032 100644
--- a/submodule.c
+++ b/submodule.c
@@ -299,6 +299,9 @@ char *resolve_submodule_url(struct repository *repo, const char *url,
 	char *remoteurl, *resolved_url;
 	struct strbuf remotesb = STRBUF_INIT;
 
+	if (!starts_with_dot_dot_slash(url) && !starts_with_dot_slash(url))
+		return xstrdup(url);
+
 	strbuf_addf(&remotesb, "remote.%s.url", remote);
 	if (repo_config_get_string(repo, remotesb.buf, &remoteurl)) {
 		if (!quiet)
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index e10c961268..76a2e96dd7 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -921,6 +921,60 @@ test_expect_success 'setup status submodule summary' '
 	git add sm
 '
 
+test_expect_success 'status reports submodule URL mismatch' '
+	test_when_finished "rm -rf url-test" &&
+	test_create_repo url-test/source &&
+	test_commit -C url-test/source initial &&
+	test_create_repo url-test/super &&
+	git -C url-test/super -c protocol.file.allow=always \
+		submodule add "$PWD/url-test/source" module &&
+	git -C url-test/super commit -m "add submodule" &&
+	git -C url-test/super status >url-test/actual 2>url-test/err &&
+	test_must_be_empty url-test/err &&
+	git -C url-test/super config -f .gitmodules submodule.module.url \
+		"$PWD/url-test/updated-source" &&
+	git -C url-test/super status --porcelain >url-test/actual 2>url-test/err &&
+	test_must_be_empty url-test/err &&
+	git -C url-test/super status >url-test/actual 2>url-test/err &&
+	test_grep "module.*different URL" url-test/err &&
+	test_grep "git submodule sync" url-test/err &&
+	git -C url-test/super submodule sync &&
+	git -C url-test/super status >url-test/actual 2>url-test/err &&
+	test_must_be_empty url-test/err &&
+	git -C url-test/super remote add origin ../source-parent &&
+	git -C url-test/super config -f .gitmodules submodule.module.url \
+		../relative-source &&
+	git -C url-test/super status >url-test/actual 2>url-test/err &&
+	test_grep "module.*different URL" url-test/err &&
+	git -C url-test/super submodule sync &&
+	git -C url-test/super status >url-test/actual 2>url-test/err &&
+	test_must_be_empty url-test/err &&
+	git -C url-test/super config -f .gitmodules submodule.module.url \
+		../another-relative-source &&
+	git -C url-test/super status >url-test/actual 2>url-test/err &&
+	test_grep "module.*different URL" url-test/err &&
+	git -C url-test/super submodule sync &&
+	git -C url-test/super status >url-test/actual 2>url-test/err &&
+	test_must_be_empty url-test/err &&
+	git -C url-test/super/module config remote.origin.url \
+		"$PWD/url-test/fork" &&
+	git -C url-test/super config -f .gitmodules submodule.module.url \
+		../fork-source &&
+	git -C url-test/super status >url-test/actual 2>url-test/err &&
+	test_must_be_empty url-test/err &&
+	git -C url-test/super/module config --add remote.origin.url \
+		"$PWD/url-test/another-fork" &&
+	git -C url-test/super config -f .gitmodules submodule.module.url \
+		../another-fork-source &&
+	git -C url-test/super status >url-test/actual 2>url-test/err &&
+	test_must_be_empty url-test/err &&
+	git -C url-test/super/module config --unset-all remote.origin.url &&
+	git -C url-test/super config --add submodule.module.url \
+		"$PWD/url-test/another-configured-source" &&
+	git -C url-test/super status >url-test/actual 2>url-test/err &&
+	test_grep "module.*different URL" url-test/err
+'
+
 test_expect_success 'status submodule summary is disabled by default' '
 	cat >expect <<EOF &&
 On branch main
diff --git a/wt-status.c b/wt-status.c
index 238bb48643..be6902c9dd 100644
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
@@ -2692,8 +2694,110 @@ static void wt_porcelain_v2_print(struct wt_status *s)
 	}
 }
 
+static int submodule_has_custom_remote_url(struct repository *repo,
+					  const char *path,
+					  const char *gitmodules_url,
+					  const char *config_url)
+{
+	struct repository subrepo = { 0 };
+	const struct string_list *remote_urls = NULL;
+	const char *remote;
+	const char *remote_url;
+	char *key, *up_path, *config_remote_url, *gitmodules_remote_url;
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
+		config_remote_url = resolve_submodule_url(repo, config_url,
+							  up_path, 1);
+		gitmodules_remote_url = resolve_submodule_url(repo, gitmodules_url,
+							      up_path, 1);
+		/*
+		 * The submodule's remote URL may be a local fork. If it matches
+		 * neither the old cached URL nor the new .gitmodules URL, leave it
+		 * alone; syncing would overwrite that customization.
+		 */
+		ret = strcmp(remote_url, config_remote_url) != 0 &&
+			strcmp(remote_url, gitmodules_remote_url) != 0;
+		free(gitmodules_remote_url);
+		free(config_remote_url);
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
+		const char *config_url;
+		char *key, *gitmodules_url;
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
+		if (repo_config_get_value(s->repo, key, &config_url)) {
+			free(key);
+			continue;
+		}
+		free(key);
+
+		gitmodules_url = resolve_submodule_url(s->repo, sub->url, NULL, 1);
+		if (strcmp(config_url, gitmodules_url) &&
+		    !submodule_has_custom_remote_url(s->repo, ce->name,
+						     sub->url,
+						     config_url))
+			warning(_("submodule '%s' has a different URL in .git/config "
+				  "than in .gitmodules\n"
+				  "  run 'git submodule sync' to update it"), ce->name);
+
+		free(gitmodules_url);
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
-- 
gitgitgadget
