Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C562CCB9
	for <git@vger.kernel.org>; Sat,  7 Mar 2026 01:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772847241; cv=none; b=tY/2nbpadEMHIZsUTALsBSc37AUfzPqg+8QhxBRPfPXx5UA3UfDKGhOcA9BEdeGu8tmW1ag6RQjPR0ORUZnIiSns/GgLJdIGY/nRphyousnfYNcDlYJ4SqICuHovawolUWUzC+A3Fhd13S2SfTu+u1WXQeGNeTzNfzJAzJs/CQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772847241; c=relaxed/simple;
	bh=FFkyMxAn9cDoBcU8MVvNhIflzKqbJfwMHyLk2bBI5aA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=jeo1EWqJZJZsyRksLu3CnVC0kJmE3dCvVmEY+KyPLn7xR1VJqL91LSQIMEYwR5oEyiXSv1lbN5ZK5K4GBdYXwHoXsYTg/gZFRg/Lv2N/UUzFGgDXsKP4a7ZMsUQ79e0CleOp+95oKleKN5acc6FRaHXaIy2RKeufiuXbV3t65dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FoimQIUH; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoimQIUH"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-4138136f02eso3621221fac.2
        for <git@vger.kernel.org>; Fri, 06 Mar 2026 17:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772847238; x=1773452038; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLz0vTRFvaqgr4YojyxGlGhZRPQ8+MjAMedyjtUm4QM=;
        b=FoimQIUH3zTrQhAV4gf924FivPR5upvdhF3sSq8tpVSDzdKdM4VgSOq2Plc53Lj/jT
         KTANQrAPrm3xNRxN+KXw3mz1WTbxKBZxevj2A9Z/sbBbCmT8qohYRYC/+dYCOr0TqpZW
         36y2AjEN6FAka/+NQQ1AFKbnptapXM6irEzd/NfbLbow1mqEKTT1kPaRntowvVqqIitm
         +Di3CHaOTy4JpGp1k2GuRloMHUKF7wMUSil1V9zTOUx9+51q+bVa53Z5SDi5ycU0Rf/z
         0yqs8h80rIaUUccXiihqt0XyQIEJJQ5etGhzyGFlmdYmzU9ThvQMi5q0A9ns/zGlUj0X
         8lmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772847238; x=1773452038;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wLz0vTRFvaqgr4YojyxGlGhZRPQ8+MjAMedyjtUm4QM=;
        b=CbOKWr5baY5cF0usuJ7T0swvcUboBtPo5qKAzpsw/OorXUJiCsQk1uZj4dogyBs4+D
         s99C+Bx+MPI0W+q5rbhG5jB6VuTbNTE5J9HX/QFFWFpbyUkx4ifz2MimfBtahqhxLut5
         hBN2b2niMVopMVXmkfM/vQy4WnvJNtGWDwxIjFyYi+PWUxzdfsSK12+uDdwgkGoqy9FU
         5grA/lKSFVN/2AOV0ZXtdb3PoLPYplPpDdfdQs5Cp1CBSTlmf34QKnFXxJ4zf9UVx0VQ
         Fxwd8LHxaTCVfBCUPKcvzhpmOSAYA/BehTNVbSYXmmnXQpq5O3/uU3w7aMGNLeAAwFZ4
         g1iw==
X-Gm-Message-State: AOJu0YwHf0VaNhZ5TIiyqOP+VZHSPdh7CwMHCnLw6ydmW+OpRkDwtxIn
	GCvTWIADtDoTOHkEi8IxNTtW3kwZLWsC914e/SWBnf/cvuicexVlFoMaLMViKw==
X-Gm-Gg: ATEYQzwkAoBjoDI3xu3mWIv4L4gckCJ3WTl1GrEKEeIfSskYWVKIqAfJTFHQe7PU7yN
	WxNnNvxfI1780gTnEKKCVbIVh3jQHLNHt+b2DqhnlbyYl/S6Rq1lzRsVTE1GvEzyv7aty7oLJWf
	CuCaY2SWH5l7Yp6IrEEy7ZDv1DZzd3ql5arus1X/ra5MSftQxokJO7i3b9/lQSy/viXpg7eB6t+
	jbzynO53YWLJgZVKhKld+MAPpFnnpAjfKTaHoEDOTNGnATTUqWHjLkt2uM2r4hpEMeUKznuXtBp
	HwssBSPFhE9WNxy4QN6gtV0G/iavFMRzmizL8HV5AidJ1U7wBg4UVGKjcjBTfBuWyXMO5whoGM0
	5OmWL6jQQ8caFsuxXUFgibxeYPIsu/9SNQT4Q9k5L7hoO2aTs9nPDeq/xr1XFdgK134dXAe4rIN
	orv7EhsP6lPsD4WV/XZcQicimRSA==
X-Received: by 2002:a05:6870:7819:b0:40a:5795:1533 with SMTP id 586e51a60fabf-416e448a084mr2407062fac.34.1772847238249;
        Fri, 06 Mar 2026 17:33:58 -0800 (PST)
Received: from [127.0.0.1] ([52.173.219.149])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-416e6836886sm2736855fac.16.2026.03.06.17.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 17:33:57 -0800 (PST)
Message-Id: <pull.2058.v5.git.1772847236966.gitgitgadget@gmail.com>
In-Reply-To: <pull.2058.v4.git.1772833649843.gitgitgadget@gmail.com>
References: <pull.2058.v4.git.1772833649843.gitgitgadget@gmail.com>
From: "Alan Braithwaite via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 07 Mar 2026 01:33:56 +0000
Subject: [PATCH v5] clone: add clone.<url>.defaultObjectFilter config
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: ps@pks.im,
    christian.couder@gmail.com,
    jonathantanmy@google.com,
    me@ttaylorr.com,
    gitster@pobox.com,
    Jeff King <peff@peff.net>,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Alan Braithwaite <alan@braithwaite.dev>,
    Alan Braithwaite <alan@braithwaite.dev>

From: Alan Braithwaite <alan@braithwaite.dev>

Add a new configuration option that lets users specify a default
partial clone filter, optionally scoped by URL pattern.  When
cloning a repository whose URL matches a configured pattern,
git-clone automatically applies the filter, equivalent to passing
--filter on the command line.

    [clone]
        defaultObjectFilter = blob:limit=1m

    [clone "https://github.com/"]
        defaultObjectFilter = blob:limit=5m

    [clone "https://internal.corp.com/large-project/"]
        defaultObjectFilter = blob:none

The bare clone.defaultObjectFilter applies to all clones.  The
URL-qualified form clone.<url>.defaultObjectFilter restricts the
setting to matching URLs.  URL matching uses the existing
urlmatch_config_entry() infrastructure, following the same rules as
http.<url>.* — a domain, namespace, or specific project can be
matched, and the most specific match wins.

The config only affects the initial clone.  Once the clone completes,
the filter is recorded in remote.<name>.partialCloneFilter, so
subsequent fetches inherit it automatically.  An explicit --filter
on the command line takes precedence, and --no-filter defeats the
configured default entirely.

Signed-off-by: Alan Braithwaite <alan@braithwaite.dev>
---
    fetch, clone: add fetch.blobSizeLimit config

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2058%2Fabraithwaite%2Falan%2Ffetch-blob-size-limit-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2058/abraithwaite/alan/fetch-blob-size-limit-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/2058

Range-diff vs v4:

 1:  4bf3e1ec63 ! 1:  fa1ea69bdb clone: add clone.<url>.defaultObjectFilter config
     @@ Commit message
          clone: add clone.<url>.defaultObjectFilter config
      
          Add a new configuration option that lets users specify a default
     -    partial clone filter per URL pattern.  When cloning a repository
     -    whose URL matches a configured pattern, git-clone automatically
     -    applies the filter, equivalent to passing --filter on the command
     -    line.
     +    partial clone filter, optionally scoped by URL pattern.  When
     +    cloning a repository whose URL matches a configured pattern,
     +    git-clone automatically applies the filter, equivalent to passing
     +    --filter on the command line.
     +
     +        [clone]
     +            defaultObjectFilter = blob:limit=1m
      
              [clone "https://github.com/"]
                  defaultObjectFilter = blob:limit=5m
     @@ Commit message
              [clone "https://internal.corp.com/large-project/"]
                  defaultObjectFilter = blob:none
      
     -    URL matching uses the existing urlmatch_config_entry() infrastructure,
     -    following the same rules as http.<url>.* — you can match a domain,
     -    a namespace path, or a specific project, and the most specific match
     -    wins.
     +    The bare clone.defaultObjectFilter applies to all clones.  The
     +    URL-qualified form clone.<url>.defaultObjectFilter restricts the
     +    setting to matching URLs.  URL matching uses the existing
     +    urlmatch_config_entry() infrastructure, following the same rules as
     +    http.<url>.* — a domain, namespace, or specific project can be
     +    matched, and the most specific match wins.
      
          The config only affects the initial clone.  Once the clone completes,
          the filter is recorded in remote.<name>.partialCloneFilter, so
          subsequent fetches inherit it automatically.  An explicit --filter
     -    flag on the command line takes precedence.
     -
     -    Only the URL-qualified form (clone.<url>.defaultObjectFilter) is
     -    honored; a bare clone.defaultObjectFilter without a URL subsection
     -    is ignored.
     +    on the command line takes precedence, and --no-filter defeats the
     +    configured default entirely.
      
          Signed-off-by: Alan Braithwaite <alan@braithwaite.dev>
      
     @@ t/t5616-partial-clone.sh: test_expect_success 'after fetching descendants of non
      +	git -c "clone.$SERVER_URL.defaultObjectFilter=blob:limit=1k" clone \
      +		"$SERVER_URL" default-filter-clone &&
      +
     -+	test "$(git -C default-filter-clone config --local remote.origin.promisor)" = "true" &&
     -+	test "$(git -C default-filter-clone config --local remote.origin.partialclonefilter)" = "blob:limit=1024"
     ++	echo true >expect &&
     ++	git -C default-filter-clone config --local remote.origin.promisor >actual &&
     ++	test_cmp expect actual &&
     ++
     ++	echo "blob:limit=1024" >expect &&
     ++	git -C default-filter-clone config --local remote.origin.partialclonefilter >actual &&
     ++	test_cmp expect actual
      +'
      +
      +test_expect_success 'clone with --filter overrides clone.<url>.defaultObjectFilter' '
     @@ t/t5616-partial-clone.sh: test_expect_success 'after fetching descendants of non
      +	git -c "clone.$SERVER_URL.defaultObjectFilter=blob:limit=1k" \
      +		clone --filter=blob:none "$SERVER_URL" default-filter-override &&
      +
     -+	test "$(git -C default-filter-override config --local remote.origin.partialclonefilter)" = "blob:none"
     ++	echo "blob:none" >expect &&
     ++	git -C default-filter-override config --local remote.origin.partialclonefilter >actual &&
     ++	test_cmp expect actual
      +'
      +
      +test_expect_success 'clone with clone.<url>.defaultObjectFilter=blob:none works' '
     @@ t/t5616-partial-clone.sh: test_expect_success 'after fetching descendants of non
      +	git -c "clone.$SERVER_URL.defaultObjectFilter=blob:none" clone \
      +		"$SERVER_URL" default-filter-blobnone &&
      +
     -+	test "$(git -C default-filter-blobnone config --local remote.origin.promisor)" = "true" &&
     -+	test "$(git -C default-filter-blobnone config --local remote.origin.partialclonefilter)" = "blob:none"
     ++	echo true >expect &&
     ++	git -C default-filter-blobnone config --local remote.origin.promisor >actual &&
     ++	test_cmp expect actual &&
     ++
     ++	echo "blob:none" >expect &&
     ++	git -C default-filter-blobnone config --local remote.origin.partialclonefilter >actual &&
     ++	test_cmp expect actual
      +'
      +
      +test_expect_success 'clone.<url>.defaultObjectFilter with tree:0 works' '
     @@ t/t5616-partial-clone.sh: test_expect_success 'after fetching descendants of non
      +	git -c "clone.$SERVER_URL.defaultObjectFilter=tree:0" clone \
      +		"$SERVER_URL" default-filter-tree0 &&
      +
     -+	test "$(git -C default-filter-tree0 config --local remote.origin.promisor)" = "true" &&
     -+	test "$(git -C default-filter-tree0 config --local remote.origin.partialclonefilter)" = "tree:0"
     ++	echo true >expect &&
     ++	git -C default-filter-tree0 config --local remote.origin.promisor >actual &&
     ++	test_cmp expect actual &&
     ++
     ++	echo "tree:0" >expect &&
     ++	git -C default-filter-tree0 config --local remote.origin.partialclonefilter >actual &&
     ++	test_cmp expect actual
      +'
      +
      +test_expect_success 'most specific URL match wins for clone.defaultObjectFilter' '
     @@ t/t5616-partial-clone.sh: test_expect_success 'after fetching descendants of non
      +		-c "clone.$SERVER_URL.defaultObjectFilter=blob:none" \
      +		clone "$SERVER_URL" default-filter-url-specific &&
      +
     -+	test "$(git -C default-filter-url-specific config --local remote.origin.partialclonefilter)" = "blob:none"
     ++	echo "blob:none" >expect &&
     ++	git -C default-filter-url-specific config --local remote.origin.partialclonefilter >actual &&
     ++	test_cmp expect actual
      +'
      +
      +test_expect_success 'non-matching URL does not apply clone.defaultObjectFilter' '
     @@ t/t5616-partial-clone.sh: test_expect_success 'after fetching descendants of non
      +	git -c clone.defaultObjectFilter=blob:none \
      +		clone "file://$(pwd)/default-filter-srv.bare" default-filter-bare-key &&
      +
     -+	test "$(git -C default-filter-bare-key config --local remote.origin.promisor)" = "true" &&
     -+	test "$(git -C default-filter-bare-key config --local remote.origin.partialclonefilter)" = "blob:none"
     ++	echo true >expect &&
     ++	git -C default-filter-bare-key config --local remote.origin.promisor >actual &&
     ++	test_cmp expect actual &&
     ++
     ++	echo "blob:none" >expect &&
     ++	git -C default-filter-bare-key config --local remote.origin.partialclonefilter >actual &&
     ++	test_cmp expect actual
      +'
      +
      +test_expect_success 'URL-specific clone.defaultObjectFilter overrides bare form' '
     @@ t/t5616-partial-clone.sh: test_expect_success 'after fetching descendants of non
      +		-c "clone.$SERVER_URL.defaultObjectFilter=blob:none" \
      +		clone "$SERVER_URL" default-filter-url-over-bare &&
      +
     -+	test "$(git -C default-filter-url-over-bare config --local remote.origin.partialclonefilter)" = "blob:none"
     ++	echo "blob:none" >expect &&
     ++	git -C default-filter-url-over-bare config --local remote.origin.partialclonefilter >actual &&
     ++	test_cmp expect actual
      +'
      +
      +test_expect_success '--no-filter defeats clone.defaultObjectFilter' '


 Documentation/config/clone.adoc |  34 +++++++++
 builtin/clone.c                 |  50 ++++++++++++++
 t/t5616-partial-clone.sh        | 118 ++++++++++++++++++++++++++++++++
 3 files changed, 202 insertions(+)

diff --git a/Documentation/config/clone.adoc b/Documentation/config/clone.adoc
index 0a10efd174..1d6c0957a0 100644
--- a/Documentation/config/clone.adoc
+++ b/Documentation/config/clone.adoc
@@ -21,3 +21,37 @@ endif::[]
 	If a partial clone filter is provided (see `--filter` in
 	linkgit:git-rev-list[1]) and `--recurse-submodules` is used, also apply
 	the filter to submodules.
+
+`clone.defaultObjectFilter`::
+`clone.<url>.defaultObjectFilter`::
+	When set to a filter spec string (e.g., `blob:limit=1m`,
+	`blob:none`, `tree:0`), linkgit:git-clone[1] will automatically
+	use `--filter=<value>` to enable partial clone behavior.
+	Objects matching the filter are excluded from the initial
+	transfer and lazily fetched on demand (e.g., during checkout).
+	Subsequent fetches inherit the filter via the per-remote config
+	that is written during the clone.
++
+The bare `clone.defaultObjectFilter` applies to all clones.  The
+URL-qualified form `clone.<url>.defaultObjectFilter` restricts the
+setting to clones whose URL matches `<url>`, following the same
+rules as `http.<url>.*` (see linkgit:git-config[1]).  The most
+specific URL match wins.  You can match a domain, a namespace, or a
+specific project:
++
+----
+[clone]
+    defaultObjectFilter = blob:limit=1m
+
+[clone "https://github.com/"]
+    defaultObjectFilter = blob:limit=5m
+
+[clone "https://internal.corp.com/large-project/"]
+    defaultObjectFilter = blob:none
+----
++
+An explicit `--filter` option on the command line takes precedence
+over this config, and `--no-filter` defeats it entirely to force a
+full clone.  Only affects the initial clone; it has no effect on
+later fetches into an existing repository.  If the server does not
+support object filtering, the setting is silently ignored.
diff --git a/builtin/clone.c b/builtin/clone.c
index 45d8fa0eed..1207655815 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -44,6 +44,7 @@
 #include "path.h"
 #include "pkt-line.h"
 #include "list-objects-filter-options.h"
+#include "urlmatch.h"
 #include "hook.h"
 #include "bundle.h"
 #include "bundle-uri.h"
@@ -757,6 +758,47 @@ static int git_clone_config(const char *k, const char *v,
 	return git_default_config(k, v, ctx, cb);
 }
 
+static int clone_filter_collect(const char *var, const char *value,
+				const struct config_context *ctx UNUSED,
+				void *cb)
+{
+	char **filter_spec_p = cb;
+
+	if (!strcmp(var, "clone.defaultobjectfilter")) {
+		if (!value)
+			return config_error_nonbool(var);
+		free(*filter_spec_p);
+		*filter_spec_p = xstrdup(value);
+	}
+	return 0;
+}
+
+/*
+ * Look up clone.defaultObjectFilter or clone.<url>.defaultObjectFilter
+ * using the urlmatch infrastructure.  A URL-qualified entry that matches
+ * the clone URL takes precedence over the bare form, following the same
+ * rules as http.<url>.* configuration variables.
+ */
+static char *get_default_object_filter(const char *url)
+{
+	struct urlmatch_config config = URLMATCH_CONFIG_INIT;
+	char *filter_spec = NULL;
+	char *normalized_url;
+
+	config.section = "clone";
+	config.key = "defaultobjectfilter";
+	config.collect_fn = clone_filter_collect;
+	config.cb = &filter_spec;
+
+	normalized_url = url_normalize(url, &config.url);
+
+	repo_config(the_repository, urlmatch_config_entry, &config);
+	free(normalized_url);
+	urlmatch_config_release(&config);
+
+	return filter_spec;
+}
+
 static int write_one_config(const char *key, const char *value,
 			    const struct config_context *ctx,
 			    void *data)
@@ -1057,6 +1099,14 @@ int cmd_clone(int argc,
 	} else
 		die(_("repository '%s' does not exist"), repo_name);
 
+	if (!filter_options.choice && !filter_options.no_filter) {
+		char *config_filter = get_default_object_filter(repo);
+		if (config_filter) {
+			parse_list_objects_filter(&filter_options, config_filter);
+			free(config_filter);
+		}
+	}
+
 	/* no need to be strict, transport_set_option() will validate it again */
 	if (option_depth && atoi(option_depth) < 1)
 		die(_("depth %s is not a positive number"), option_depth);
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 1e354e057f..1254901f3e 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -722,6 +722,124 @@ test_expect_success 'after fetching descendants of non-promisor commits, gc work
 	git -C partial gc --prune=now
 '
 
+# Test clone.<url>.defaultObjectFilter config
+
+test_expect_success 'setup for clone.defaultObjectFilter tests' '
+	git init default-filter-src &&
+	echo "small" >default-filter-src/small.txt &&
+	dd if=/dev/zero of=default-filter-src/large.bin bs=1024 count=100 2>/dev/null &&
+	git -C default-filter-src add . &&
+	git -C default-filter-src commit -m "initial" &&
+
+	git clone --bare "file://$(pwd)/default-filter-src" default-filter-srv.bare &&
+	git -C default-filter-srv.bare config --local uploadpack.allowfilter 1 &&
+	git -C default-filter-srv.bare config --local uploadpack.allowanysha1inwant 1
+'
+
+test_expect_success 'clone with clone.<url>.defaultObjectFilter applies filter' '
+	SERVER_URL="file://$(pwd)/default-filter-srv.bare" &&
+	git -c "clone.$SERVER_URL.defaultObjectFilter=blob:limit=1k" clone \
+		"$SERVER_URL" default-filter-clone &&
+
+	echo true >expect &&
+	git -C default-filter-clone config --local remote.origin.promisor >actual &&
+	test_cmp expect actual &&
+
+	echo "blob:limit=1024" >expect &&
+	git -C default-filter-clone config --local remote.origin.partialclonefilter >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'clone with --filter overrides clone.<url>.defaultObjectFilter' '
+	SERVER_URL="file://$(pwd)/default-filter-srv.bare" &&
+	git -c "clone.$SERVER_URL.defaultObjectFilter=blob:limit=1k" \
+		clone --filter=blob:none "$SERVER_URL" default-filter-override &&
+
+	echo "blob:none" >expect &&
+	git -C default-filter-override config --local remote.origin.partialclonefilter >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'clone with clone.<url>.defaultObjectFilter=blob:none works' '
+	SERVER_URL="file://$(pwd)/default-filter-srv.bare" &&
+	git -c "clone.$SERVER_URL.defaultObjectFilter=blob:none" clone \
+		"$SERVER_URL" default-filter-blobnone &&
+
+	echo true >expect &&
+	git -C default-filter-blobnone config --local remote.origin.promisor >actual &&
+	test_cmp expect actual &&
+
+	echo "blob:none" >expect &&
+	git -C default-filter-blobnone config --local remote.origin.partialclonefilter >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'clone.<url>.defaultObjectFilter with tree:0 works' '
+	SERVER_URL="file://$(pwd)/default-filter-srv.bare" &&
+	git -c "clone.$SERVER_URL.defaultObjectFilter=tree:0" clone \
+		"$SERVER_URL" default-filter-tree0 &&
+
+	echo true >expect &&
+	git -C default-filter-tree0 config --local remote.origin.promisor >actual &&
+	test_cmp expect actual &&
+
+	echo "tree:0" >expect &&
+	git -C default-filter-tree0 config --local remote.origin.partialclonefilter >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'most specific URL match wins for clone.defaultObjectFilter' '
+	SERVER_URL="file://$(pwd)/default-filter-srv.bare" &&
+	git \
+		-c "clone.file://.defaultObjectFilter=blob:limit=1k" \
+		-c "clone.$SERVER_URL.defaultObjectFilter=blob:none" \
+		clone "$SERVER_URL" default-filter-url-specific &&
+
+	echo "blob:none" >expect &&
+	git -C default-filter-url-specific config --local remote.origin.partialclonefilter >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'non-matching URL does not apply clone.defaultObjectFilter' '
+	git \
+		-c "clone.https://other.example.com/.defaultObjectFilter=blob:none" \
+		clone "file://$(pwd)/default-filter-srv.bare" default-filter-url-nomatch &&
+
+	test_must_fail git -C default-filter-url-nomatch config --local remote.origin.promisor
+'
+
+test_expect_success 'bare clone.defaultObjectFilter applies to all clones' '
+	git -c clone.defaultObjectFilter=blob:none \
+		clone "file://$(pwd)/default-filter-srv.bare" default-filter-bare-key &&
+
+	echo true >expect &&
+	git -C default-filter-bare-key config --local remote.origin.promisor >actual &&
+	test_cmp expect actual &&
+
+	echo "blob:none" >expect &&
+	git -C default-filter-bare-key config --local remote.origin.partialclonefilter >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'URL-specific clone.defaultObjectFilter overrides bare form' '
+	SERVER_URL="file://$(pwd)/default-filter-srv.bare" &&
+	git \
+		-c clone.defaultObjectFilter=blob:limit=1k \
+		-c "clone.$SERVER_URL.defaultObjectFilter=blob:none" \
+		clone "$SERVER_URL" default-filter-url-over-bare &&
+
+	echo "blob:none" >expect &&
+	git -C default-filter-url-over-bare config --local remote.origin.partialclonefilter >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--no-filter defeats clone.defaultObjectFilter' '
+	SERVER_URL="file://$(pwd)/default-filter-srv.bare" &&
+	git -c "clone.$SERVER_URL.defaultObjectFilter=blob:none" \
+		clone --no-filter "$SERVER_URL" default-filter-no-filter &&
+
+	test_must_fail git -C default-filter-no-filter config --local remote.origin.promisor
+'
 
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd

base-commit: 7b2bccb0d58d4f24705bf985de1f4612e4cf06e5
-- 
gitgitgadget
