Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795814859;
	b=o58H/nZ8OeSTjP6+wmCi/SJN/adfxmcnb4r6pXQ/g0VpyCktRO32ecB+B8yUhulO0aF0
	 tSqqau6W4WmK385AJSjuh8fwO/67VtOh5tuNhOTh697eCTSW939njSPyNYvp6r1enP59D
	 w99NsxdxIbmS+l5/yVqo+uJCn4n0544m4urQDlYRYm7egh+PZSqqYO/A+9mdSQJN3jL/p
	 Zem4q0XMhdWhKz2g3zvrgPbtToh+SLtx/Ps5LGKJYfe0eNIraQ+s15d7X8jCDEZKcz6ml
	 yIq3bvuRIpuguoDhwKv99efSFRMvvCN5PCYCXbDL0tz7c076e4zJUzI5LqB1SpypyRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795814859;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=XZJA2Z61KGA1qRXjnpmFFQlBkdzHnfaUye0Shxf2y3s=;
	b=rVnyqldvy633Qj2lWi3v5qXeor+TdLC+EMFsa+kPbSwrOeMxieYV+8mWvKJaxAIntFal
	 G8tSTDgt7sT5tS80G5s4i6ndi6s2TJD3WVT55e0p6bU/10yCDDTutmOfVL1mUqPA/m3be
	 87stq3EfavSuTK8ETHS9EN0Zszpv6C5jGoyAvhNEDM+BJkE5nU7cUjVh+VR2wbgF1mbYK
	 pImt0bpB/SQy79BNSQE7mwg0NEhWxx+gkcwolHhgEe+Qi2OA1YwOABXha3Ajwenzj7fif
	 mjoWEb0DpwwmFgIp/LkHIWoGU8PHLF2LOy+didAozwHAsiQv5k31zQJOkIrn9Lv0CLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dR5sBv9k;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DE5606A335
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 21:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91DE5606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dR5sBv9k
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-386cf1041cdso5889470eec.0
        for <git@vger.kernel.org>; Fri, 27 Nov 2026 13:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795814858; x=1796419658; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XZJA2Z61KGA1qRXjnpmFFQlBkdzHnfaUye0Shxf2y3s=;
        b=dR5sBv9k3YYLJAHOrcf1uqFpOE4g70uveAXVYqYhSpz9lURHC2/xZbTMYrNL+N2ToV
         KShbwjoF6fYdL1eS1p12oaZCE3osuh8tMvn4bMxjNAQhIVvEdYnOgiMxrhWH4l4tRtNl
         gW3QTttTx70lLrPT1twPRprCXewWa3KJzB90u/0HPuqsdSK8PZFeoAOvGSRPEl2VOOKC
         DhtkoI+Bynf29s5GXO1Dw1zYDAuRs6WbudYlAr57J5qz+UFqQgN6WfDpXritt3jHve4b
         gX1NrgaRo1bmOoKIvxdn0vTPj058Dcc9Xv83njK8np2Nt7SVVj6m3b8qScNTMFmus+XX
         x33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795814858; x=1796419658;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XZJA2Z61KGA1qRXjnpmFFQlBkdzHnfaUye0Shxf2y3s=;
        b=FZwixops+QdT1uZY1Q6nddRTo9rq1ed0kQYKrZSiIlqAIY1eQxvg4m40rg9mtlLOMP
         kwIvErJR7tBx642NkwkQmLC3CXaCswzUnEG4z7vsGaB2YH5JxjIa/HJMwKmmDhM013wX
         MYNR5lvI519ZyMY7VYGyGxxj0iLf8babS3G6YWqCuQI1MxfRyHMe0nhTGezXTy5xhmyW
         1mKyifXIwoMSnpbSddb/ir1rpeuwRX5AWGDCfEjkwr/t1OhDADSPeWYitoywo8+JtNi9
         lwmS7LWOw635irlcITNhqV+7KhSZTzxUjXanF2Ym5Jlsbv9dgWjORLiCmZWBEqRZWqD+
         K6FQ==
X-Gm-Message-State: APuU4Z+CzqqL8ZBHqXxRIutSWwODsiqz/YKEf6Bp3oq/atwNyvqJiASO
	ZeBb3bEO2fb3wb6OzX9CMDuHFh+m7oolTRHfb4ETAlMTraNFNQvKMWPukcmaa0r8
X-Gm-Gg: AZFdTZfihKoPQ6zDVueXNzRC2bdLKX5kF6bz6BwQMZAGt9J6Vgr2WSQmFur1wzyHbRv
	EYq0OUS28QrpQUKArG9+AENdAtK/YUPtj/yDpYMbnci1J9qmV9tn9PFNTTNMvySOnndRfvhRyZv
	YBzCDad9MSSLkR5gGdEV+L7IGeYbgcg78yHp4wMoOkpCxdsiTijTTKaS5fz0KH5xxwvJ+KR06IJ
	R+BjVV4RqMwGszXe/FzwC72Re7gCiyQTHcTjW18chGRhZLuFuDJA8+Sv9acjWYGcY0EuuqBgbhX
	Ec4CqU0Y/YEomTgPsAhdZj2yNk6weQNmnkZvXu4QdGmqjGXqRaCaLQHF+sHC0NHGuV/gzMZGevs
	aRgokZ/cgi6TEVFShPdia9OGy7T93yRzJ25QM1AMLxJWZdvgmKuUNgAx8EUMkKBIlyOEl0rjw/k
	T5wIDHFzZ0GsPxhn0HjQvvhNSAXx0SI+xIEfD6mEN8KdLafRrPP9PJE81WtWjfK0CqWR6zo2LRc
	DkKVbqjlT5XHRKcej4dCJliuplnlVAd8ddO422stsNHY41wTaHQCqRQ1szNFMceNqxo9JtM66KM
	7klvK5A2VivienSaHfmtFZkmUT+++cI=
X-Received: by 2002:a05:7301:6083:b0:386:a01f:a36b with SMTP id 5a478bee46e88-386a01fa8d8mr30538755eec.35.1795814857394;
        Fri, 27 Nov 2026 13:27:37 -0800 (PST)
Received: from [127.0.0.1] ([20.169.116.17])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386aa203267sm44113063eec.0.2026.11.27.13.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 13:27:36 -0800 (PST)
Message-Id: <9dc62830755b06ca2a95d307dd0b593d2a77c536.1795814853.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2509.v3.git.git.1795814853.gitgitgadget@gmail.com>
References: <pull.2509.git.git.1795774880142.gitgitgadget@gmail.com>
	<pull.2509.v3.git.git.1795814853.gitgitgadget@gmail.com>
From: "Alessio Attilio via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 27 Nov 2026 21:27:33 +0000
Subject: [PATCH v3 2/2] status: warn about stale submodule URLs
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

The check considers three URLs: the .gitmodules URL resolved against
the superproject's default remote, the cached submodule.<name>.url, and
the submodule's default remote URL. The first two determine whether the
cached URL is stale. If they differ, compare the submodule remote with
the old and new URLs as sync would write them. Warn only when that
remote matches either URL; a different URL or multiple URLs indicate a
local customization that sync would otherwise overwrite.

Resolve relative URLs using the same paths as git submodule sync, and
do not resolve the already-resolved cached URL a second time. Emit the
warning on standard error for long, short, and porcelain status output,
limited to submodules matched by the pathspec. Do not emit it when
--ignore-submodules is given or when the wt-status machinery is used by
another command.

Signed-off-by: Alessio Attilio <attilio.alessio@protonmail.com>
---
 Documentation/git-status.adoc |   6 ++
 builtin/commit.c              |   1 +
 submodule.c                   |   6 +-
 t/t7508-status.sh             |  84 ++++++++++++++++++++++++
 wt-status.c                   | 120 ++++++++++++++++++++++++++++++++++
 wt-status.h                   |   1 +
 6 files changed, 217 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-status.adoc b/Documentation/git-status.adoc
index 9acca52bfb..1e0831a98e 100644
--- a/Documentation/git-status.adoc
+++ b/Documentation/git-status.adoc
@@ -22,6 +22,12 @@ are what you _would_ commit by running `git commit`; the second and
 third are what you _could_ commit by running `git add` before running
 `git commit`.
 
+When a submodule's URL in `.gitmodules` differs from the URL cached in
+`.git/config`, `git status` warns that `git submodule sync` can update the
+cached URL. The warning is written to standard error in all output formats.
+It is limited to submodules matched by the pathspec, and is suppressed when
+`--ignore-submodules` is specified.
+
 OPTIONS
 -------
 
diff --git a/builtin/commit.c b/builtin/commit.c
index 36e47e18ed..577b097aa0 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1636,6 +1636,7 @@ struct repository *repo UNUSED)
 
 	s.ignore_submodule_arg = ignore_submodule_arg;
 	s.status_format = status_format;
+	s.check_submodule_urls = 1;
 	s.verbose = verbose;
 	if (no_renames != -1)
 		s.detect_rename = !no_renames;
diff --git a/submodule.c b/submodule.c
index 3eab799f1f..24775b21b7 100644
--- a/submodule.c
+++ b/submodule.c
@@ -296,9 +296,13 @@ char *resolve_submodule_url(struct repository *repo, const char *rel_url,
 			    const char *up_path, int quiet)
 {
 	char *remoteurl, *resolved_url;
-	const char *remote = repo_default_remote(repo);
+	const char *remote;
 	struct strbuf remotesb = STRBUF_INIT;
 
+	if (!starts_with_dot_dot_slash(rel_url) && !starts_with_dot_slash(rel_url))
+		return xstrdup(rel_url);
+
+	remote = repo_default_remote(repo);
 	strbuf_addf(&remotesb, "remote.%s.url", remote);
 	if (repo_config_get_string(repo, remotesb.buf, &remoteurl)) {
 		if (!quiet)
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index e10c961268..830217b4a5 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -921,6 +921,90 @@ test_expect_success 'setup status submodule summary' '
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
+	test_grep "module.*different URL" url-test/err &&
+	git -C url-test/super status --short >url-test/actual 2>url-test/err &&
+	test_grep "module.*different URL" url-test/err &&
+	git -C url-test/super status --porcelain=v2 >url-test/actual 2>url-test/err &&
+	test_grep "module.*different URL" url-test/err &&
+	git -C url-test/super status --ignore-submodules >url-test/actual 2>url-test/err &&
+	test_must_be_empty url-test/err &&
+	git -C url-test/super status -- .gitmodules >url-test/actual 2>url-test/err &&
+	test_must_be_empty url-test/err &&
+	git -C url-test/super status -- module >url-test/actual 2>url-test/err &&
+	test_grep "module.*different URL" url-test/err &&
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
+test_expect_success 'status compares relative submodule URLs only once' '
+	test_when_finished "rm -rf url-test" &&
+	test_create_repo url-test/relative-source &&
+	test_commit -C url-test/relative-source initial &&
+	test_create_repo url-test/relative-super &&
+	git -C url-test/relative-super -c protocol.file.allow=always \
+		submodule add "$PWD/url-test/relative-source" module &&
+	git -C url-test/relative-super commit -m "add submodule" &&
+	git -C url-test/relative-super remote add origin ../a/b &&
+	git -C url-test/relative-super config -f .gitmodules \
+		submodule.module.url ../mod1 &&
+	git -C url-test/relative-super submodule sync &&
+	git -C url-test/relative-super status >url-test/actual 2>url-test/err &&
+	test_must_be_empty url-test/err &&
+	git -C url-test/relative-super config -f .gitmodules \
+		submodule.module.url ../mod2 &&
+	git -C url-test/relative-super status >url-test/actual 2>url-test/err &&
+	test_grep "module.*different URL" url-test/err
+'
+
 test_expect_success 'status submodule summary is disabled by default' '
 	cat >expect <<EOF &&
 On branch main
diff --git a/wt-status.c b/wt-status.c
index 238bb48643..5bcbe634df 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -3,6 +3,8 @@
 
 #include "git-compat-util.h"
 #include "advice.h"
+#include "abspath.h"
+#include "config.h"
 #include "wt-status.h"
 #include "object.h"
 #include "dir.h"
@@ -23,6 +25,8 @@
 #include "remote.h"
 #include "refs.h"
 #include "submodule.h"
+#include "url.h"
+#include "submodule-config.h"
 #include "column.h"
 #include "read-cache.h"
 #include "setup.h"
@@ -2692,8 +2696,124 @@ static void wt_porcelain_v2_print(struct wt_status *s)
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
+	if (!repo_config_get_string_multi(&subrepo, key, &remote_urls) &&
+	    remote_urls->nr == 1) {
+		remote_url = remote_urls->items[0].string;
+		up_path = get_submodule_up_path(path);
+		/*
+		 * sync_submodule() stores a relative URL in the superproject's
+		 * config without the submodule path prefix, but adds that prefix
+		 * when storing the URL in the submodule's remote configuration.
+		 */
+		if (url_is_local_not_ssh(config_url) && !is_absolute_path(config_url)) {
+			struct strbuf sb = STRBUF_INIT;
+
+			strbuf_addstr(&sb, up_path);
+			strbuf_addstr(&sb, config_url);
+			config_remote_url = strbuf_detach(&sb, NULL);
+		} else {
+			config_remote_url = xstrdup(config_url);
+		}
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
+	if (!s->check_submodule_urls || s->ignore_submodule_arg)
+		return;
+
+	if (is_gitmodules_unmerged(s->repo->index))
+		return;
+
+	for (i = 0; i < s->repo->index->cache_nr; i++) {
+		struct cache_entry *ce = s->repo->index->cache[i];
+		const struct submodule *sub;
+		char *config_url;
+		char *key, *gitmodules_url;
+
+		if (ce_stage(ce) || !S_ISGITLINK(ce->ce_mode) ||
+		    !ce_path_match(s->repo->index, ce, &s->pathspec, NULL))
+			continue;
+
+		sub = submodule_from_path(s->repo, null_oid(s->repo->hash_algo),
+					  ce->name);
+		if (!sub || !sub->url || !is_submodule_active(s->repo, ce->name))
+			continue;
+
+		key = xstrfmt("submodule.%s.url", sub->name);
+		if (repo_config_get_string(s->repo, key, &config_url)) {
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
+		free(config_url);
+		free(gitmodules_url);
+	}
+}
+
 void wt_status_print(struct wt_status *s)
 {
+	if (s->check_submodule_urls)
+		wt_status_check_submodule_urls(s);
+
 	trace2_data_intmax("status", s->repo, "count/changed", s->change.nr);
 	trace2_data_intmax("status", s->repo, "count/untracked",
 			   s->untracked.nr);
diff --git a/wt-status.h b/wt-status.h
index e9fe32e98c..45eeb8b558 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -123,6 +123,7 @@ struct wt_status {
 	unsigned colopts;
 	int null_termination;
 	int commit_template;
+	int check_submodule_urls;
 	int show_branch;
 	int show_stash;
 	int hints;
-- 
gitgitgadget
