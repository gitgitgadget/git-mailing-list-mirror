Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795796165;
	b=y1c8SjdO8WH6o1w8ADlTpGItxH3KSuFtLWE7zUAnspWofEmZ5C1TAM4FFdjtyt1gx19Y
	 kU9vILL41ZCV+H2OqI7M8uFQpcY8vzLbJS4DXlYFK0kclFh4vKrvrzypHQI3D+HQBPLVA
	 bHVsXLwrOFFU3BYmQcnCsvwgQ92CwBwBAmwoDGJ/QamuuwzEszQJ/AuRSbRPaYQvfLbwl
	 eGSQ6iWtrU3Ey15hUSRFr4sH/8EtBvGI53Akn8uT6N9iMjLB599JGyuaOosHjRbTquPgr
	 wsGOXIgXqYmRsQ9v2sq6SaOMmae67nEqADWdyQpdJzvXl+GbWyq1FYlXaloGkYId1zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795796165;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=Di1G4pjg8jUUCJfvctXL3Wt7AsBWn1BfFNXjsrfLO9M=;
	b=sSSr3LOIYxuFo1198Etl1BANUYs6hdmMbb1lmKkS5fFG+4eLEpmkXNxORukibokNZ3B4
	 BkT3fQjkJYylgdWWYDy+rZ7jKTYO226o1YMB9AlXS7eA9H1V7TNXXtaOofr7r7/hv2GqY
	 JyEiyDYFAX3A6S1X+stUnQ40RjE4hkvUk6pvPLTJwU0rgmCDSBxlVURBf7WZTmdQ9fCRp
	 QtPeRqg2fVIOgD6tuhCUC3uSz1gA/jFeH5sMbAFP0aVny3XiUciwDPMhZdl+bt/jEB/CT
	 Beuh8F0SjIelLESsSejBZkC4xoY8ZNoLb7kaXarAyHTOi9DQR/IM8urps9gmkca3Rrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CfI8kYT6;
	arc=none smtp.remote-ip=209.85.167.174
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737E2606A31E
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 16:16:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 737E2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CfI8kYT6
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-57e4bd7fb1eso1609933b6e.0
        for <git@vger.kernel.org>; Fri, 27 Nov 2026 08:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795796164; x=1796400964; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Di1G4pjg8jUUCJfvctXL3Wt7AsBWn1BfFNXjsrfLO9M=;
        b=CfI8kYT60Zjn7vkgyJKdRak1Regm1s0kz1QFhnwk9DWXypyZAZB+tSYKnva0/T2/TI
         3h71fWmo5JftttSbxHdnlr+l3s3WA6Z18WgG01H0CsKcTYLiIZheXe4kJ3gvcNKVAOJP
         Vcz97BUnY2n3XGOMPh1cQDkkOL/vT8xa/xilsT4U75oIuGPFOSV+1UT6HCmNWNMw7lYv
         O664hjfySFFU1TsX5yGdWoAstNJjMlOOPtngwKYbVrNAqxqv3VW5kqH5HoawmjdGMwaE
         D3vqZtDO263z4DHxWPmzUE4Uyx3Ojto8r+WazyW/vnTqVuVhDES+KHp9c16D4uTwP/PV
         MUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795796164; x=1796400964;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Di1G4pjg8jUUCJfvctXL3Wt7AsBWn1BfFNXjsrfLO9M=;
        b=GxlNksjOlWhJ29DBXUvQYtznqVJJ4GjPe7cU7Xor6KLlbW/Jf7h+KtsPHm6+sy6vld
         Zv0IsLFnI6VJcsF8iFSTMKTx+9h52qviJHvNpBcKECbAblNiAzLaR3zvFxWuBh2D2rz1
         tTpgRyP6msqJ0LIivjcju08i1drPuW0w4Yb+xYpryl//7kPoL4QyBdaXiBMRi/ncrbL7
         pVjz218YYycpbfnTKeZFsrfLETZyQw+gVwY8WUooFJufihleXIARLL5A10oQeqSmuwnF
         PJ3IxGYX8xn/qwUW4IAgetJrWcbQ0GS14ERKjqKjiwyeHyDcgeHzkSAxgZ2gj4m7UH2M
         +6xQ==
X-Gm-Message-State: APuU4Z9XGW9bEXfbZzEh0zqFI+abnUvcBcEBjNyr35rETMaASQ4xcnLW
	Sq9YnbakbphLJBCsXSFCuO+slhM5lza61yIyKw97uTeFw8IifkDWgT4ux4Wzkg==
X-Gm-Gg: AZFdTZcePPeoBGXbFdHSrF5mGEFQ9PGjC58vFjifaVSCNG83RSXeuT49o6XXSZjwetg
	gg2dOhl3It9TWjkCQs/apNWJ33kwuaP9XCzYmSHWUqDV3FvdJG0mcXXis7feR8Ppo56YOkjY0aA
	bv5gwIwlcBx5GCyzlIsTJsNCSgjH0IO/c4yBz7Sb7SD1di5mUTigMY0kRNcohf09aXjVCugk2AN
	G1l40LEqdN/yqxHgjyu0K1YIlZp5ESTrqTXdO8ysK5zNXv76LDEdt+qZOeX0uh5OEZ5SNulwVxe
	NTidsQrZeQXRoW+agLT6fICsOx1eGCgjiJsVrvcDkTnmU7GsJjb6daRDtWRTYggSA+HOf89DNgr
	sMPQAW99YmxT6Nnq680d/mN/ipvjtIZuQ9xtmPXxvTDFZNexHdu9piNhYTV/b6jTL2nvVA1NiGV
	Q6Gn5mU8C21+s8cok9OTZCBdNrLZhD2lKsdA8bFYMc5hWnl3QzdNZ7poEs8uDsi2mYFqHIm1F7n
	n9JPBaplyfkc3DzMrQHND8nhaOMPEtTmYfuwVI89BnfS8o1MkYmUKrneL3r6ELvDnZAbBA5G0Qq
	394mVf910rPXx1ec4IWfrVOhWXnkPhREOg==
X-Received: by 2002:a05:6808:1a10:b0:564:48f3:dfa8 with SMTP id 5614622812f47-57a0a111c93mr27641277b6e.11.1795796164222;
        Fri, 27 Nov 2026 08:16:04 -0800 (PST)
Received: from [127.0.0.1] ([40.124.101.213])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bd044fc4besm19610317fac.7.2026.11.27.08.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 08:16:03 -0800 (PST)
Message-Id: <pull.2509.v2.git.git.1795796162.gitgitgadget@gmail.com>
In-Reply-To: <pull.2509.git.git.1795774880142.gitgitgadget@gmail.com>
References: <pull.2509.git.git.1795774880142.gitgitgadget@gmail.com>
From: "Alessio Attilio via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 27 Nov 2026 16:16:00 +0000
Subject: [PATCH v2 0/2] status: report when submodule URLs are out of sync
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

 1. submodule: prepare URL helpers for reuse
 2. status: warn about stale submodule URLs

Changes since v1:

 * Move the URL helper extraction into a preparatory commit.
 * Clarify the comparison between the cached URL, .gitmodules, and the
   populated submodule's remote URL.
 * Keep test output inside its fixture directory.

Closes gitgitgadget/git#565

Alessio Attilio (2):
  submodule: prepare URL helpers for reuse
  status: warn about stale submodule URLs

 builtin/submodule--helper.c |  63 ++++------------------
 submodule.c                 |  44 +++++++++++++++
 submodule.h                 |   3 ++
 t/t7508-status.sh           |  54 +++++++++++++++++++
 wt-status.c                 | 104 ++++++++++++++++++++++++++++++++++++
 5 files changed, 215 insertions(+), 53 deletions(-)


base-commit: acba8bf9753134d9bde89f94369f775838a8c5fe
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2509%2Fkairosci%2Ftopic%2Fstatus-submodule-url-sync-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2509/kairosci/topic/status-submodule-url-sync-v2
Pull-Request: https://github.com/git/git/pull/2509

Range-diff vs v1:

 1:  528258ee95 ! 1:  4cd0ab7e9b status: warn about stale submodule URLs
     @@ Metadata
      Author: Alessio Attilio <attilio.alessio@protonmail.com>
      
       ## Commit message ##
     -    status: warn about stale submodule URLs
     +    submodule: prepare URL helpers for reuse
      
     -    When a submodule URL changes in .gitmodules, the URL cached in
     -    .git/config can keep pointing at the old remote. That leaves users
     -    with no indication that later submodule operations may use a
     -    repository different from the one the project declares.
     +    Move the relative submodule URL resolver and the helper that computes
     +    the path back to the superproject from builtin/submodule--helper.c to
     +    submodule.c so they can be shared with git status.
      
     -    Warn in git status so users can find and sync stale configuration
     -    before it causes a confusing fetch or update. Resolve relative URLs
     -    like git submodule sync does, and leave customized submodule remotes
     -    alone.
     +    Pass the repository explicitly to the resolver instead of relying on
     +    the_repository, and update existing callers to use the shared helpers.
      
          Signed-off-by: Alessio Attilio <attilio.alessio@protonmail.com>
      
     @@ submodule.c: int is_submodule_active(struct repository *repo, const char *path)
      +	char *remoteurl, *resolved_url;
      +	struct strbuf remotesb = STRBUF_INIT;
      +
     -+	if (!starts_with_dot_dot_slash(url) && !starts_with_dot_slash(url))
     -+		return xstrdup(url);
     -+
      +	strbuf_addf(&remotesb, "remote.%s.url", remote);
      +	if (repo_config_get_string(repo, remotesb.buf, &remoteurl)) {
      +		if (!quiet)
     @@ submodule.h: int is_tree_submodule_active(struct repository *repo,
       /*
        * Determine if a submodule has been populated at a given 'path' by checking if
        * the <path>/.git resolves to a valid git repository.
     -
     - ## t/t7508-status.sh ##
     -@@ t/t7508-status.sh: test_expect_success 'setup status submodule summary' '
     - 	git add sm
     - '
     - 
     -+test_expect_success 'status reports submodule URL mismatch' '
     -+	test_when_finished "rm -rf url-test" &&
     -+	test_when_finished "rm -f actual err" &&
     -+	test_create_repo url-test/source &&
     -+	test_commit -C url-test/source initial &&
     -+	test_create_repo url-test/super &&
     -+	git -C url-test/super -c protocol.file.allow=always \
     -+		submodule add "$PWD/url-test/source" module &&
     -+	git -C url-test/super commit -m "add submodule" &&
     -+	git -C url-test/super status >actual 2>err &&
     -+	test_must_be_empty err &&
     -+	git -C url-test/super config -f .gitmodules submodule.module.url \
     -+		"$PWD/url-test/updated-source" &&
     -+	git -C url-test/super status --porcelain >actual 2>err &&
     -+	test_must_be_empty err &&
     -+	git -C url-test/super status >actual 2>err &&
     -+	test_grep "module.*different URL" err &&
     -+	test_grep "git submodule sync" err &&
     -+	git -C url-test/super submodule sync &&
     -+	git -C url-test/super status >actual 2>err &&
     -+	test_must_be_empty err &&
     -+	git -C url-test/super remote add origin ../source-parent &&
     -+	git -C url-test/super config -f .gitmodules submodule.module.url \
     -+		../relative-source &&
     -+	git -C url-test/super status >actual 2>err &&
     -+	test_grep "module.*different URL" err &&
     -+	git -C url-test/super submodule sync &&
     -+	git -C url-test/super status >actual 2>err &&
     -+	test_must_be_empty err &&
     -+	git -C url-test/super config -f .gitmodules submodule.module.url \
     -+		../another-relative-source &&
     -+	git -C url-test/super status >actual 2>err &&
     -+	test_grep "module.*different URL" err &&
     -+	git -C url-test/super submodule sync &&
     -+	git -C url-test/super status >actual 2>err &&
     -+	test_must_be_empty err &&
     -+	git -C url-test/super/module config remote.origin.url \
     -+		"$PWD/url-test/fork" &&
     -+	git -C url-test/super config -f .gitmodules submodule.module.url \
     -+		../fork-source &&
     -+	git -C url-test/super status >actual 2>err &&
     -+	test_must_be_empty err &&
     -+	git -C url-test/super/module config --add remote.origin.url \
     -+		"$PWD/url-test/another-fork" &&
     -+	git -C url-test/super config -f .gitmodules submodule.module.url \
     -+		../another-fork-source &&
     -+	git -C url-test/super status >actual 2>err &&
     -+	test_must_be_empty err &&
     -+	git -C url-test/super/module config --unset-all remote.origin.url &&
     -+	git -C url-test/super config --add submodule.module.url \
     -+		"$PWD/url-test/another-configured-source" &&
     -+	git -C url-test/super status >actual 2>err &&
     -+	test_grep "module.*different URL" err
     -+'
     -+
     - test_expect_success 'status submodule summary is disabled by default' '
     - 	cat >expect <<EOF &&
     - On branch main
     -
     - ## wt-status.c ##
     -@@
     - 
     - #include "git-compat-util.h"
     - #include "advice.h"
     -+#include "config.h"
     - #include "wt-status.h"
     - #include "object.h"
     - #include "dir.h"
     -@@
     - #include "remote.h"
     - #include "refs.h"
     - #include "submodule.h"
     -+#include "submodule-config.h"
     - #include "column.h"
     - #include "read-cache.h"
     - #include "setup.h"
     -@@ wt-status.c: static void wt_porcelain_v2_print(struct wt_status *s)
     - 	}
     - }
     - 
     -+static int submodule_has_custom_remote_url(struct repository *repo,
     -+					  const char *path,
     -+					  const char *url,
     -+					  const char *configured_url)
     -+{
     -+	struct repository subrepo = { 0 };
     -+	const struct string_list *remote_urls = NULL;
     -+	const char *remote;
     -+	const char *remote_url;
     -+	char *key, *up_path, *old_url, *new_url;
     -+	int error_code, ret = 0;
     -+
     -+	if (!is_submodule_populated_gently(path, &error_code))
     -+		return 0;
     -+
     -+	if (repo_submodule_init(&subrepo, repo, path,
     -+				null_oid(repo->hash_algo)) < 0) {
     -+		repo_clear(&subrepo);
     -+		return 0;
     -+	}
     -+
     -+	remote = repo_default_remote(&subrepo);
     -+
     -+	key = xstrfmt("remote.%s.url", remote);
     -+	if (!repo_config_get_value_multi(&subrepo, key, &remote_urls) &&
     -+	    remote_urls->nr == 1) {
     -+		remote_url = remote_urls->items[0].string;
     -+		up_path = get_submodule_up_path(path);
     -+		old_url = resolve_submodule_url(repo, configured_url, up_path, 1);
     -+		new_url = resolve_submodule_url(repo, url, up_path, 1);
     -+		ret = strcmp(remote_url, old_url) != 0 &&
     -+			strcmp(remote_url, new_url) != 0;
     -+		free(new_url);
     -+		free(old_url);
     -+		free(up_path);
     -+	} else {
     -+		/*
     -+		 * Multiple URLs are a local customization; sync would replace
     -+		 * them all with a single URL.
     -+		 */
     -+		ret = remote_urls && remote_urls->nr > 1;
     -+	}
     -+	free(key);
     -+	repo_clear(&subrepo);
     -+
     -+	return ret;
     -+}
     -+
     -+static void wt_status_check_submodule_urls(struct wt_status *s)
     -+{
     -+	int i;
     -+
     -+	if (s->status_format != STATUS_FORMAT_LONG &&
     -+	    s->status_format != STATUS_FORMAT_NONE)
     -+		return;
     -+
     -+	if (is_gitmodules_unmerged(s->repo->index))
     -+		return;
     -+
     -+	for (i = 0; i < s->repo->index->cache_nr; i++) {
     -+		struct cache_entry *ce = s->repo->index->cache[i];
     -+		const struct submodule *sub;
     -+		const char *configured_url;
     -+		char *key, *expected_url;
     -+
     -+		if (ce_stage(ce) || !S_ISGITLINK(ce->ce_mode))
     -+			continue;
     -+
     -+		sub = submodule_from_path(s->repo, null_oid(s->repo->hash_algo),
     -+					  ce->name);
     -+		if (!sub || !sub->url || !is_submodule_active(s->repo, ce->name))
     -+			continue;
     -+
     -+		key = xstrfmt("submodule.%s.url", sub->name);
     -+		if (repo_config_get_value(s->repo, key, &configured_url)) {
     -+			free(key);
     -+			continue;
     -+		}
     -+		free(key);
     -+
     -+		expected_url = resolve_submodule_url(s->repo, sub->url, NULL, 1);
     -+		if (strcmp(configured_url, expected_url) &&
     -+		    !submodule_has_custom_remote_url(s->repo, ce->name,
     -+						     expected_url,
     -+						     configured_url))
     -+			warning(_("submodule '%s' has a different URL in .git/config "
     -+				  "than in .gitmodules\n"
     -+				  "  run 'git submodule sync' to update it"), ce->name);
     -+
     -+		free(expected_url);
     -+	}
     -+}
     -+
     - void wt_status_print(struct wt_status *s)
     - {
     -+	wt_status_check_submodule_urls(s);
     -+
     - 	trace2_data_intmax("status", s->repo, "count/changed", s->change.nr);
     - 	trace2_data_intmax("status", s->repo, "count/untracked",
     - 			   s->untracked.nr);
 -:  ---------- > 2:  b0dd21100c status: warn about stale submodule URLs

-- 
gitgitgadget
