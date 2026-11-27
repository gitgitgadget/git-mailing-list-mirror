Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795814856;
	b=0MKHuwGlMbG8i+dsC9lsk9OFWEvFO405d0ZgmqKFWTvCfJTzQ7Fr4IciI2HV48Nzca52
	 yfOpV5l90hB0CLULiOawWxfF7CN6doQ38YUSTJGT5ITH4oor4ZyijYEeAHnYlSUDkvzTs
	 Vk3nEaPj1tnFE18PqQlVsU3iP5uxUZ+0nK9V/7/iwqza2BkIuygmNZFhPf9Se2sKmvnOi
	 GGqVoQQUjYUUNp4z6GNMevdnj/atzGEHewaHX+IAEF+c8jF6YlJj1sZ9vbVWOzgQ51dQB
	 XTtjzCJ070hrp2+TYBRdtMKWiVA7CuFrjUZ0H4ySUIxPZspv/7/6g21LAQNZWfV81LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795814856;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=wKiUc3g9fFGczQ7W2YHA93qjXsB/nnE9dp4dRzSMoIE=;
	b=xNgQlPYTjPKBQb3yoI3GEdWEeBwtHLP/jsYBQYXmFcsluvDcld8CLFZRB5rqyxP7no2c
	 egc47xOkJjJUCYAx9zmZx5+ZECOvpc/wQxgexxCA9DxySl+TsBwaoyaVe7LB4lOi/3NNI
	 hRXokn81d9Mdw60EnDzDlQ1YWiM8zW8RnDyoACDYNCdJlcASCklbh0i9cPc31Hv1arMV0
	 Qi1EGiqMdJqPMMbghm3dH6u4HNgnQpwcdsRtQhgV4/kRDcuvp2426pKfCn8Qm39bj8tWF
	 ZdVek3WBKRbPo+gPeUf6O3txghO8cBETFMxkPQhuv+kYplWZxZGUqTdtWrKzdBXJB7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SKSnWOtm;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31946606A31C
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 21:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31946606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SKSnWOtm
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-38644aedba1so13228695eec.0
        for <git@vger.kernel.org>; Fri, 27 Nov 2026 13:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795814855; x=1796419655; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wKiUc3g9fFGczQ7W2YHA93qjXsB/nnE9dp4dRzSMoIE=;
        b=SKSnWOtmNqu8dT3PDV/wvICnU8Ez9F6AHnbthYXguG1gVWeEtdJ+fik7OmrovAYYOh
         +N/I4+K6SyDnAp/9Bp57VH2StbjQ9sgzYU+1fPJrCvxOyFdQcvc0lQw7KHgCGGzNPHyG
         M3cvdDVikqyqpTOvWEwLijB4lEmkrU7GislurSLyAFXgld1CRawO2yxGbxFKbqvuh8pd
         nk1uaNPF8zZ8pv7yjH7jWymppV4GsbWnuhOEMBZZK/G2v4Q/GEO0oG6aUxOyL2JQjEHI
         zrM5Mn7329pJFRDt4HM1qUkcFEuJbF5UVSve+gdDASPCos6InKGE3Sw+b5i5EvggG9Rv
         ZN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795814855; x=1796419655;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wKiUc3g9fFGczQ7W2YHA93qjXsB/nnE9dp4dRzSMoIE=;
        b=Pm4WJK+cPW1V4Yc8Z2klEUJzrJZ6Rmbs9bdNsqLGkV/uKE+lBD0fK8CBZOw0JZbjaM
         RfHzogo2w9jpHMXBWPDctKDXsvx6YlOeanG9FWw0yRHgrX4FsDnoyVjT2BGwZub/CYXP
         BWXXnFmV7L/xdkR+lUnBZmXNaSbv/dfsG4Gg2+INLKDHtCRgJAD/8fek9iMAZIIajG42
         KHO2ko3iXBK/FphWZhjest9/vWIN8q1M+H2B7WRJS6Ks9jGRmczHmi5ECSGB2WSryMQw
         1g32xQlAFMJGJMEkPhtwrf8TxRV8SqTD4tk12w64YjibNBdeOzMUPvfmM0I48pWoqPDg
         zcPA==
X-Gm-Message-State: APuU4Z8Dd1G4gPJYOJt2O7yFBC/XkhVFv+DLdrkTWuNQqG25Uvq7rkVA
	uiSCqkj1F9RDg4U2XDjmi1dofNgUfhtzylorS4bcx7d6Z3EDZ9R6g78DcYsoLn4/
X-Gm-Gg: AZFdTZemr51TCCY1t8mn7x6KQKxs3Z5RSiXR/0zGSxRGrbqdW4lkOmuPaQVZeLljoUX
	dvpeKEzzvCFLqs29vZz+0PuVJPYp8pKvJWILtMysPeYTDfDmtY9guTeZWEppoIEc9IuRioUhPdn
	GT+yD34irwGxFLHf7xSRA7IMuzwXu5sZoF9+WrAMAmGjjmb24BnZnnFSgdoIGY0gEyGiSBg2Ca9
	LZRlo6QijL++HngLA+Krp0fLM2EY0K42j5NU+tH1Wmk/hM3Yh8q4dUVoWp/sYNa51DmKqZUxqyz
	iGqUTiMd1rsdiNRw4SJVL3mNuQ0kJbvS9PAUc0VjZIxsA0YpumBCusB+APwvqEtpsfjO1QenZgV
	FpAnA/yChAjNdXRt8LXhFrMtI4T4icRTcAMuvbjqO83jK4wLo7zeFwLPI++ZzjHsi1zOcQTcIUv
	eBxxutf+PP9MiRYXcnbtbjXqmkeKdDBCk6qHxZJwQsVjW1Hs5XyD6pE0dXTmGp9ApsxlaW3x646
	CWfOJP2EBK2R+TT5aJgcoiZd0bEtJu/MsvKHjfo4n8pOw3Bx59MWdtY8kIElWCNkz13fxDqvUch
	oJ3pzqMAEna0pEEU4pqyIRlTSr6FkWM=
X-Received: by 2002:a05:701b:2608:b0:1b2:6eef:3f32 with SMTP id a92af1059eb24-1b5568f1322mr21098881c88.37.1795814854971;
        Fri, 27 Nov 2026 13:27:34 -0800 (PST)
Received: from [127.0.0.1] ([20.169.116.17])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b556829d31sm97615654c88.9.2026.11.27.13.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 13:27:34 -0800 (PST)
Message-Id: <pull.2509.v3.git.git.1795814853.gitgitgadget@gmail.com>
In-Reply-To: <pull.2509.git.git.1795774880142.gitgitgadget@gmail.com>
References: <pull.2509.git.git.1795774880142.gitgitgadget@gmail.com>
From: "Alessio Attilio via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 27 Nov 2026 21:27:31 +0000
Subject: [PATCH v3 0/2] status: report when submodule URLs are out of sync
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
Cc: Alessio Attilio <attilio.alessio@protonmail.com>

When a submodule URL changes in .gitmodules, the corresponding URL in the
superproject's .git/config may keep pointing at the old location. This
series makes git status warn about that mismatch and suggest git submodule
sync.

The warning resolves relative URLs as git submodule sync does. It also
suppresses the warning when the populated submodule has a custom remote URL
that a sync would overwrite.

The series is split into:

 1. submodule: move URL helpers to submodule.c
 2. submodule: make URL resolution repository-aware
 3. status: warn about stale submodule URLs

Changes since v2:

 * Keep the helper relocation in a preparatory commit.
 * Move repository-aware URL resolution into its own commit.
 * Keep test output inside its fixture directory.

Closes gitgitgadget/git#565

Alessio Attilio (2):
  submodule: prepare URL helpers for reuse
  status: warn about stale submodule URLs

 Documentation/git-status.adoc |   6 ++
 builtin/commit.c              |   1 +
 builtin/submodule--helper.c   |  63 +++---------------
 submodule.c                   |  45 +++++++++++++
 submodule.h                   |   3 +
 t/t7508-status.sh             |  84 ++++++++++++++++++++++++
 wt-status.c                   | 120 ++++++++++++++++++++++++++++++++++
 wt-status.h                   |   1 +
 8 files changed, 270 insertions(+), 53 deletions(-)


base-commit: acba8bf9753134d9bde89f94369f775838a8c5fe
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2509%2Fkairosci%2Ftopic%2Fstatus-submodule-url-sync-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2509/kairosci/topic/status-submodule-url-sync-v3
Pull-Request: https://github.com/git/git/pull/2509

Range-diff vs v2:

 1:  4cd0ab7e9b ! 1:  fc300295ff submodule: prepare URL helpers for reuse
     @@ submodule.c: int is_submodule_active(struct repository *repo, const char *path)
       	return is_tree_submodule_active(repo, null_oid(the_hash_algo), path);
       }
       
     -+char *resolve_submodule_url(struct repository *repo, const char *url,
     ++char *resolve_submodule_url(struct repository *repo, const char *rel_url,
      +			    const char *up_path, int quiet)
      +{
     -+	const char *remote = repo_default_remote(repo);
      +	char *remoteurl, *resolved_url;
     ++	const char *remote = repo_default_remote(repo);
      +	struct strbuf remotesb = STRBUF_INIT;
      +
      +	strbuf_addf(&remotesb, "remote.%s.url", remote);
     @@ submodule.c: int is_submodule_active(struct repository *repo, const char *path)
      +				remotesb.buf);
      +		remoteurl = xgetcwd();
      +	}
     -+	resolved_url = relative_url(remoteurl, url, up_path);
     ++	resolved_url = relative_url(remoteurl, rel_url, up_path);
      +
      +	free(remoteurl);
      +	strbuf_release(&remotesb);
 2:  b0dd21100c ! 2:  9dc6283075 status: warn about stale submodule URLs
     @@ Commit message
          in git status so users can run git submodule sync before a later
          submodule operation uses the outdated URL.
      
     -    Resolve relative URLs using the same paths as git submodule sync.
     -    Avoid warning when the submodule remote indicates a local
     -    customization that sync would overwrite.
     +    The check considers three URLs: the .gitmodules URL resolved against
     +    the superproject's default remote, the cached submodule.<name>.url, and
     +    the submodule's default remote URL. The first two determine whether the
     +    cached URL is stale. If they differ, compare the submodule remote with
     +    the old and new URLs as sync would write them. Warn only when that
     +    remote matches either URL; a different URL or multiple URLs indicate a
     +    local customization that sync would otherwise overwrite.
     +
     +    Resolve relative URLs using the same paths as git submodule sync, and
     +    do not resolve the already-resolved cached URL a second time. Emit the
     +    warning on standard error for long, short, and porcelain status output,
     +    limited to submodules matched by the pathspec. Do not emit it when
     +    --ignore-submodules is given or when the wt-status machinery is used by
     +    another command.
      
          Signed-off-by: Alessio Attilio <attilio.alessio@protonmail.com>
      
     + ## Documentation/git-status.adoc ##
     +@@ Documentation/git-status.adoc: are what you _would_ commit by running `git commit`; the second and
     + third are what you _could_ commit by running `git add` before running
     + `git commit`.
     + 
     ++When a submodule's URL in `.gitmodules` differs from the URL cached in
     ++`.git/config`, `git status` warns that `git submodule sync` can update the
     ++cached URL. The warning is written to standard error in all output formats.
     ++It is limited to submodules matched by the pathspec, and is suppressed when
     ++`--ignore-submodules` is specified.
     ++
     + OPTIONS
     + -------
     + 
     +
     + ## builtin/commit.c ##
     +@@ builtin/commit.c: struct repository *repo UNUSED)
     + 
     + 	s.ignore_submodule_arg = ignore_submodule_arg;
     + 	s.status_format = status_format;
     ++	s.check_submodule_urls = 1;
     + 	s.verbose = verbose;
     + 	if (no_renames != -1)
     + 		s.detect_rename = !no_renames;
     +
       ## submodule.c ##
     -@@ submodule.c: char *resolve_submodule_url(struct repository *repo, const char *url,
     +@@ submodule.c: char *resolve_submodule_url(struct repository *repo, const char *rel_url,
     + 			    const char *up_path, int quiet)
     + {
       	char *remoteurl, *resolved_url;
     +-	const char *remote = repo_default_remote(repo);
     ++	const char *remote;
       	struct strbuf remotesb = STRBUF_INIT;
       
     -+	if (!starts_with_dot_dot_slash(url) && !starts_with_dot_slash(url))
     -+		return xstrdup(url);
     ++	if (!starts_with_dot_dot_slash(rel_url) && !starts_with_dot_slash(rel_url))
     ++		return xstrdup(rel_url);
      +
     ++	remote = repo_default_remote(repo);
       	strbuf_addf(&remotesb, "remote.%s.url", remote);
       	if (repo_config_get_string(repo, remotesb.buf, &remoteurl)) {
       		if (!quiet)
     @@ t/t7508-status.sh: test_expect_success 'setup status submodule summary' '
      +	git -C url-test/super config -f .gitmodules submodule.module.url \
      +		"$PWD/url-test/updated-source" &&
      +	git -C url-test/super status --porcelain >url-test/actual 2>url-test/err &&
     ++	test_grep "module.*different URL" url-test/err &&
     ++	git -C url-test/super status --short >url-test/actual 2>url-test/err &&
     ++	test_grep "module.*different URL" url-test/err &&
     ++	git -C url-test/super status --porcelain=v2 >url-test/actual 2>url-test/err &&
     ++	test_grep "module.*different URL" url-test/err &&
     ++	git -C url-test/super status --ignore-submodules >url-test/actual 2>url-test/err &&
      +	test_must_be_empty url-test/err &&
     ++	git -C url-test/super status -- .gitmodules >url-test/actual 2>url-test/err &&
     ++	test_must_be_empty url-test/err &&
     ++	git -C url-test/super status -- module >url-test/actual 2>url-test/err &&
     ++	test_grep "module.*different URL" url-test/err &&
      +	git -C url-test/super status >url-test/actual 2>url-test/err &&
      +	test_grep "module.*different URL" url-test/err &&
      +	test_grep "git submodule sync" url-test/err &&
     @@ t/t7508-status.sh: test_expect_success 'setup status submodule summary' '
      +	git -C url-test/super status >url-test/actual 2>url-test/err &&
      +	test_grep "module.*different URL" url-test/err
      +'
     ++
     ++test_expect_success 'status compares relative submodule URLs only once' '
     ++	test_when_finished "rm -rf url-test" &&
     ++	test_create_repo url-test/relative-source &&
     ++	test_commit -C url-test/relative-source initial &&
     ++	test_create_repo url-test/relative-super &&
     ++	git -C url-test/relative-super -c protocol.file.allow=always \
     ++		submodule add "$PWD/url-test/relative-source" module &&
     ++	git -C url-test/relative-super commit -m "add submodule" &&
     ++	git -C url-test/relative-super remote add origin ../a/b &&
     ++	git -C url-test/relative-super config -f .gitmodules \
     ++		submodule.module.url ../mod1 &&
     ++	git -C url-test/relative-super submodule sync &&
     ++	git -C url-test/relative-super status >url-test/actual 2>url-test/err &&
     ++	test_must_be_empty url-test/err &&
     ++	git -C url-test/relative-super config -f .gitmodules \
     ++		submodule.module.url ../mod2 &&
     ++	git -C url-test/relative-super status >url-test/actual 2>url-test/err &&
     ++	test_grep "module.*different URL" url-test/err
     ++'
      +
       test_expect_success 'status submodule summary is disabled by default' '
       	cat >expect <<EOF &&
     @@ wt-status.c
       
       #include "git-compat-util.h"
       #include "advice.h"
     ++#include "abspath.h"
      +#include "config.h"
       #include "wt-status.h"
       #include "object.h"
     @@ wt-status.c
       #include "remote.h"
       #include "refs.h"
       #include "submodule.h"
     ++#include "url.h"
      +#include "submodule-config.h"
       #include "column.h"
       #include "read-cache.h"
     @@ wt-status.c: static void wt_porcelain_v2_print(struct wt_status *s)
      +	remote = repo_default_remote(&subrepo);
      +
      +	key = xstrfmt("remote.%s.url", remote);
     -+	if (!repo_config_get_value_multi(&subrepo, key, &remote_urls) &&
     ++	if (!repo_config_get_string_multi(&subrepo, key, &remote_urls) &&
      +	    remote_urls->nr == 1) {
      +		remote_url = remote_urls->items[0].string;
      +		up_path = get_submodule_up_path(path);
     -+		config_remote_url = resolve_submodule_url(repo, config_url,
     -+							  up_path, 1);
     ++		/*
     ++		 * sync_submodule() stores a relative URL in the superproject's
     ++		 * config without the submodule path prefix, but adds that prefix
     ++		 * when storing the URL in the submodule's remote configuration.
     ++		 */
     ++		if (url_is_local_not_ssh(config_url) && !is_absolute_path(config_url)) {
     ++			struct strbuf sb = STRBUF_INIT;
     ++
     ++			strbuf_addstr(&sb, up_path);
     ++			strbuf_addstr(&sb, config_url);
     ++			config_remote_url = strbuf_detach(&sb, NULL);
     ++		} else {
     ++			config_remote_url = xstrdup(config_url);
     ++		}
      +		gitmodules_remote_url = resolve_submodule_url(repo, gitmodules_url,
      +							      up_path, 1);
      +		/*
     @@ wt-status.c: static void wt_porcelain_v2_print(struct wt_status *s)
      +{
      +	int i;
      +
     -+	if (s->status_format != STATUS_FORMAT_LONG &&
     -+	    s->status_format != STATUS_FORMAT_NONE)
     ++	if (!s->check_submodule_urls || s->ignore_submodule_arg)
      +		return;
      +
      +	if (is_gitmodules_unmerged(s->repo->index))
     @@ wt-status.c: static void wt_porcelain_v2_print(struct wt_status *s)
      +	for (i = 0; i < s->repo->index->cache_nr; i++) {
      +		struct cache_entry *ce = s->repo->index->cache[i];
      +		const struct submodule *sub;
     -+		const char *config_url;
     ++		char *config_url;
      +		char *key, *gitmodules_url;
      +
     -+		if (ce_stage(ce) || !S_ISGITLINK(ce->ce_mode))
     ++		if (ce_stage(ce) || !S_ISGITLINK(ce->ce_mode) ||
     ++		    !ce_path_match(s->repo->index, ce, &s->pathspec, NULL))
      +			continue;
      +
      +		sub = submodule_from_path(s->repo, null_oid(s->repo->hash_algo),
     @@ wt-status.c: static void wt_porcelain_v2_print(struct wt_status *s)
      +			continue;
      +
      +		key = xstrfmt("submodule.%s.url", sub->name);
     -+		if (repo_config_get_value(s->repo, key, &config_url)) {
     ++		if (repo_config_get_string(s->repo, key, &config_url)) {
      +			free(key);
      +			continue;
      +		}
     @@ wt-status.c: static void wt_porcelain_v2_print(struct wt_status *s)
      +				  "than in .gitmodules\n"
      +				  "  run 'git submodule sync' to update it"), ce->name);
      +
     ++		free(config_url);
      +		free(gitmodules_url);
      +	}
      +}
      +
       void wt_status_print(struct wt_status *s)
       {
     -+	wt_status_check_submodule_urls(s);
     ++	if (s->check_submodule_urls)
     ++		wt_status_check_submodule_urls(s);
      +
       	trace2_data_intmax("status", s->repo, "count/changed", s->change.nr);
       	trace2_data_intmax("status", s->repo, "count/untracked",
       			   s->untracked.nr);
     +
     + ## wt-status.h ##
     +@@ wt-status.h: struct wt_status {
     + 	unsigned colopts;
     + 	int null_termination;
     + 	int commit_template;
     ++	int check_submodule_urls;
     + 	int show_branch;
     + 	int show_stash;
     + 	int hints;

-- 
gitgitgadget
