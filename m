Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D137371D00
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 06:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772780120; cv=none; b=OSF2OQrMLNe2euS2Qur33RSQr/imJEmzxMUONnR6WXlpiXB6eb4HCAO3B4/7hEiVPjGrNt1YB5ZcTeerY70U/AlLYAfjV9VWi6qw4zaU09JGHebYQn8Xp8ZToVw5EadXY8T5Q2xj2AJ1IXqrl+MFMSdQvmLg3BJp+Y2CeLHthPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772780120; c=relaxed/simple;
	bh=C4PRAI6VCEG83vCXNwsutJtk/CCsmkN0B92cPQrNOiU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=NJE0DA6aFCVRWts2bQG15+QzXOzba0jYKYZQnkKv9kJSIkZ5TAqrkavn/R3RYc+bnPdpBtaItILlOUQP2TYCh5WEuzy28qdOiaGI4k+SG6VoYfT906kNq65BGKxkVqZXdRWgcJo4B+WvThCzSRiCqEIUxHtT22Ty3JTUhldFVXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=leFCh4bT; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leFCh4bT"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-4152698e745so1541890fac.1
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 22:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772780117; x=1773384917; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRgFXJc8JNcdBefR+L2ZamevrVZ9j2t7oCk3rvxCoZQ=;
        b=leFCh4bTiXR2+80XCT8hpyWFpj3JrSEGDIu+TYtSxx335BvUgbW7EWR52P0CmskAcI
         kW26kELiP7ZpzPlIM2pO1dNTSCurFws5j6cwfjATxShNse4KihzVnElWVxwosZT5n2ab
         h04cAHZ8iWeHa7T6CxSSb3Zw9HEo0WxUP2/Q7tymarHYYqkUmITll1tF6VIsOS6UEaEg
         Cy/OqBoN6y8R5O1yWldqMteJlmf3LFGE6K+HenWIisQMAkcrghefnhvmURi/CGLdIu9y
         nyvDnCKsqFEZOdorhsCO0nPEy/E3YGvR2oO3SCHUX+2nUp203KY2Ydobzdk3sR7mgP/R
         SHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772780117; x=1773384917;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eRgFXJc8JNcdBefR+L2ZamevrVZ9j2t7oCk3rvxCoZQ=;
        b=gdmoUfZRLzWGpzpneH/vQjHkB77P/4SGjRJzX/2ObVY0C2oSNOSrzMv4SsVCnY+B3G
         ipRuRgFeNS1TNKEKoKIMjxuzi0I6iApXdJXrP/APwD7jtfE2gq+kyonuhxsbzS3E9cAL
         rX3EIWtrbFAbcUaII0o8eAErisunLzOOl7vXXTbDj+sfDi44r8ggr3DrlOsJyI+r5uqT
         Yp+I3kf3+T6gUOQtvvFkjxcNTMRiAnlVP5TtoOYTa0HyIEH3fB+y+m5lldsK6UbGV/jE
         IEnV/EdxhYKEl+7Fe9Pn5lbW15DIePGqmtvdt2OCNZ3MR2cN5+pApaiZJdOGgrgwZb7Y
         qR3A==
X-Gm-Message-State: AOJu0Yy1DD4t0LrenxPtJS/qsfmLHs/qlyrJcpEItjg2npnosa/Ykk9V
	johyDI84D8Oerpb0K/tx5nLzYcoja+UWCAMMbex0jdRncfok6IWW30/3BmYdgA==
X-Gm-Gg: ATEYQzy0LHDzx3dMqYxjOsxDuNnwH+71I30o24fcoZTEbprHSPBoEsT455ZHXSrD2wz
	u3kM5RukNAuwB/nsFV6TyuXZ05U62MA98cbM7Vu8rU3nTWdi0nq+qklqid9dw1ID9TPAmLPNnCJ
	DpOAqRk3miAtMyJ4PhSwW4WGcN42J/Ud7BDsd413wV1OgMBDBH+IEFZP1bGvlECARYOfbJKGwtU
	QMe88gxpqcE9OTVzvtjmwoY2FbRMLvQ7iiMBd16QZ7dobQzv3dcFolEIJ3j/XL4kMb2Pe/i0Svx
	IoYISRUVTMtyHpfF7YBaazcfr4smKSAQTokr6qFp7g+FAuhHHmII8zDp2YXwgKyQlbKhD1Xewcl
	WkDjN4rTm/00nqKkHNFPv3eCtF5N1r/0BhP0Ts1+GouOgD5h14VLvSba6VyUVAW4ShAJY2juNZ1
	CUXEWYnMEhsFVRzeUndSv7DcZ0
X-Received: by 2002:a05:6870:41c1:b0:415:e735:f044 with SMTP id 586e51a60fabf-416e43fad52mr818978fac.45.1772780116734;
        Thu, 05 Mar 2026 22:55:16 -0800 (PST)
Received: from [127.0.0.1] ([52.154.131.96])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-416e65b1be6sm728098fac.7.2026.03.05.22.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 22:55:15 -0800 (PST)
Message-Id: <pull.2058.v3.git.1772780113400.gitgitgadget@gmail.com>
In-Reply-To: <pull.2058.v2.git.1772672251281.gitgitgadget@gmail.com>
References: <pull.2058.v2.git.1772672251281.gitgitgadget@gmail.com>
From: "Alan Braithwaite via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 06 Mar 2026 06:55:13 +0000
Subject: [PATCH v3] clone: add clone.<url>.defaultObjectFilter config
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
    Alan Braithwaite <alan@braithwaite.dev>,
    Alan Braithwaite <alan@braithwaite.dev>

From: Alan Braithwaite <alan@braithwaite.dev>

Add a new configuration option that lets users specify a default
partial clone filter per URL pattern.  When cloning a repository
whose URL matches a configured pattern, git-clone automatically
applies the filter, equivalent to passing --filter on the command
line.

    [clone "https://github.com/"]
        defaultObjectFilter = blob:limit=5m

    [clone "https://internal.corp.com/large-project/"]
        defaultObjectFilter = blob:none

URL matching uses the existing urlmatch_config_entry() infrastructure,
following the same rules as http.<url>.* — you can match a domain,
a namespace path, or a specific project, and the most specific match
wins.

The config only affects the initial clone.  Once the clone completes,
the filter is recorded in remote.<name>.partialCloneFilter, so
subsequent fetches inherit it automatically.  An explicit --filter
flag on the command line takes precedence.

Only the URL-qualified form (clone.<url>.defaultObjectFilter) is
honored; a bare clone.defaultObjectFilter without a URL subsection
is ignored.

Signed-off-by: Alan Braithwaite <alan@braithwaite.dev>
---
    fetch, clone: add fetch.blobSizeLimit config

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2058%2Fabraithwaite%2Falan%2Ffetch-blob-size-limit-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2058/abraithwaite/alan/fetch-blob-size-limit-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2058

Range-diff vs v2:

 1:  4a73edd2e8 ! 1:  5408412f2a clone: add clone.<url>.defaultObjectFilter config
     @@ Documentation/config/clone.adoc: endif::[]
       	linkgit:git-rev-list[1]) and `--recurse-submodules` is used, also apply
       	the filter to submodules.
      +
     ++`clone.defaultObjectFilter`::
      +`clone.<url>.defaultObjectFilter`::
      +	When set to a filter spec string (e.g., `blob:limit=1m`,
      +	`blob:none`, `tree:0`), linkgit:git-clone[1] will automatically
     -+	use `--filter=<value>` when the clone URL matches `<url>`.
     ++	use `--filter=<value>` to enable partial clone behavior.
      +	Objects matching the filter are excluded from the initial
      +	transfer and lazily fetched on demand (e.g., during checkout).
      +	Subsequent fetches inherit the filter via the per-remote config
      +	that is written during the clone.
      ++
     -+The URL matching follows the same rules as `http.<url>.*` (see
     -+linkgit:git-config[1]).  The most specific URL match wins.  You can
     -+match a complete domain, a namespace, or a specific project:
     ++The bare `clone.defaultObjectFilter` applies to all clones.  The
     ++URL-qualified form `clone.<url>.defaultObjectFilter` restricts the
     ++setting to clones whose URL matches `<url>`, following the same
     ++rules as `http.<url>.*` (see linkgit:git-config[1]).  The most
     ++specific URL match wins.  You can match a domain, a namespace, or a
     ++specific project:
      ++
      +----
     ++[clone]
     ++    defaultObjectFilter = blob:limit=1m
     ++
      +[clone "https://github.com/"]
      +    defaultObjectFilter = blob:limit=5m
      +
     @@ builtin/clone.c: static int git_clone_config(const char *k, const char *v,
       	return git_default_config(k, v, ctx, cb);
       }
       
     -+struct clone_filter_data {
     -+	char *default_object_filter;
     -+};
     -+
      +static int clone_filter_collect(const char *var, const char *value,
      +				const struct config_context *ctx UNUSED,
      +				void *cb)
      +{
     -+	struct clone_filter_data *data = cb;
     ++	char **filter_spec_p = cb;
      +
      +	if (!strcmp(var, "clone.defaultobjectfilter")) {
     -+		free(data->default_object_filter);
     -+		data->default_object_filter = xstrdup(value);
     ++		if (!value)
     ++			return config_error_nonbool(var);
     ++		free(*filter_spec_p);
     ++		*filter_spec_p = xstrdup(value);
      +	}
      +	return 0;
      +}
      +
      +/*
     -+ * Look up clone.<url>.defaultObjectFilter using the urlmatch
     -+ * infrastructure.  Only URL-qualified forms are supported; a bare
     -+ * clone.defaultObjectFilter (without a URL) is ignored.
     ++ * Look up clone.defaultObjectFilter or clone.<url>.defaultObjectFilter
     ++ * using the urlmatch infrastructure.  A URL-qualified entry that matches
     ++ * the clone URL takes precedence over the bare form, following the same
     ++ * rules as http.<url>.* configuration variables.
      + */
      +static char *get_default_object_filter(const char *url)
      +{
      +	struct urlmatch_config config = URLMATCH_CONFIG_INIT;
     -+	struct clone_filter_data data = { 0 };
     -+	struct string_list_item *item;
     ++	char *filter_spec = NULL;
      +	char *normalized_url;
      +
      +	config.section = "clone";
      +	config.key = "defaultobjectfilter";
      +	config.collect_fn = clone_filter_collect;
     -+	config.cascade_fn = git_clone_config;
     -+	config.cb = &data;
     ++	config.cb = &filter_spec;
      +
      +	normalized_url = url_normalize(url, &config.url);
      +
      +	repo_config(the_repository, urlmatch_config_entry, &config);
      +	free(normalized_url);
     -+
     -+	/*
     -+	 * Reject the bare form clone.defaultObjectFilter (no URL
     -+	 * subsection).  urlmatch stores the best match in vars with
     -+	 * hostmatch_len == 0 for non-URL-qualified entries; discard
     -+	 * the result if that is what we got.
     -+	 */
     -+	item = string_list_lookup(&config.vars, "defaultobjectfilter");
     -+	if (item) {
     -+		const struct urlmatch_item *m = item->util;
     -+		if (!m->hostmatch_len && !m->pathmatch_len) {
     -+			FREE_AND_NULL(data.default_object_filter);
     -+		}
     -+	}
     -+
      +	urlmatch_config_release(&config);
      +
     -+	return data.default_object_filter;
     ++	return filter_spec;
      +}
      +
       static int write_one_config(const char *key, const char *value,
     @@ t/t5616-partial-clone.sh: test_expect_success 'after fetching descendants of non
      +	test_must_fail git -C default-filter-url-nomatch config --local remote.origin.promisor
      +'
      +
     -+test_expect_success 'bare clone.defaultObjectFilter without URL is ignored' '
     ++test_expect_success 'bare clone.defaultObjectFilter applies to all clones' '
      +	git -c clone.defaultObjectFilter=blob:none \
      +		clone "file://$(pwd)/default-filter-srv.bare" default-filter-bare-key &&
      +
     -+	test_must_fail git -C default-filter-bare-key config --local remote.origin.promisor
     ++	test "$(git -C default-filter-bare-key config --local remote.origin.promisor)" = "true" &&
     ++	test "$(git -C default-filter-bare-key config --local remote.origin.partialclonefilter)" = "blob:none"
     ++'
     ++
     ++test_expect_success 'URL-specific clone.defaultObjectFilter overrides bare form' '
     ++	SERVER_URL="file://$(pwd)/default-filter-srv.bare" &&
     ++	git \
     ++		-c clone.defaultObjectFilter=blob:limit=1k \
     ++		-c "clone.$SERVER_URL.defaultObjectFilter=blob:none" \
     ++		clone "$SERVER_URL" default-filter-url-over-bare &&
     ++
     ++	test "$(git -C default-filter-url-over-bare config --local remote.origin.partialclonefilter)" = "blob:none"
      +'
       
       . "$TEST_DIRECTORY"/lib-httpd.sh


 Documentation/config/clone.adoc | 33 +++++++++++++
 builtin/clone.c                 | 50 ++++++++++++++++++++
 t/t5616-partial-clone.sh        | 84 +++++++++++++++++++++++++++++++++
 3 files changed, 167 insertions(+)

diff --git a/Documentation/config/clone.adoc b/Documentation/config/clone.adoc
index 0a10efd174..7ef6321be2 100644
--- a/Documentation/config/clone.adoc
+++ b/Documentation/config/clone.adoc
@@ -21,3 +21,36 @@ endif::[]
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
+over this config.  Only affects the initial clone; it has no effect
+on later fetches into an existing repository.  If the server does
+not support object filtering, the setting is silently ignored.
diff --git a/builtin/clone.c b/builtin/clone.c
index 45d8fa0eed..b549191707 100644
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
 
+	if (!filter_options.choice) {
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
index 1e354e057f..a4bfdb329e 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -722,6 +722,90 @@ test_expect_success 'after fetching descendants of non-promisor commits, gc work
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
+	test "$(git -C default-filter-clone config --local remote.origin.promisor)" = "true" &&
+	test "$(git -C default-filter-clone config --local remote.origin.partialclonefilter)" = "blob:limit=1024"
+'
+
+test_expect_success 'clone with --filter overrides clone.<url>.defaultObjectFilter' '
+	SERVER_URL="file://$(pwd)/default-filter-srv.bare" &&
+	git -c "clone.$SERVER_URL.defaultObjectFilter=blob:limit=1k" \
+		clone --filter=blob:none "$SERVER_URL" default-filter-override &&
+
+	test "$(git -C default-filter-override config --local remote.origin.partialclonefilter)" = "blob:none"
+'
+
+test_expect_success 'clone with clone.<url>.defaultObjectFilter=blob:none works' '
+	SERVER_URL="file://$(pwd)/default-filter-srv.bare" &&
+	git -c "clone.$SERVER_URL.defaultObjectFilter=blob:none" clone \
+		"$SERVER_URL" default-filter-blobnone &&
+
+	test "$(git -C default-filter-blobnone config --local remote.origin.promisor)" = "true" &&
+	test "$(git -C default-filter-blobnone config --local remote.origin.partialclonefilter)" = "blob:none"
+'
+
+test_expect_success 'clone.<url>.defaultObjectFilter with tree:0 works' '
+	SERVER_URL="file://$(pwd)/default-filter-srv.bare" &&
+	git -c "clone.$SERVER_URL.defaultObjectFilter=tree:0" clone \
+		"$SERVER_URL" default-filter-tree0 &&
+
+	test "$(git -C default-filter-tree0 config --local remote.origin.promisor)" = "true" &&
+	test "$(git -C default-filter-tree0 config --local remote.origin.partialclonefilter)" = "tree:0"
+'
+
+test_expect_success 'most specific URL match wins for clone.defaultObjectFilter' '
+	SERVER_URL="file://$(pwd)/default-filter-srv.bare" &&
+	git \
+		-c "clone.file://.defaultObjectFilter=blob:limit=1k" \
+		-c "clone.$SERVER_URL.defaultObjectFilter=blob:none" \
+		clone "$SERVER_URL" default-filter-url-specific &&
+
+	test "$(git -C default-filter-url-specific config --local remote.origin.partialclonefilter)" = "blob:none"
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
+	test "$(git -C default-filter-bare-key config --local remote.origin.promisor)" = "true" &&
+	test "$(git -C default-filter-bare-key config --local remote.origin.partialclonefilter)" = "blob:none"
+'
+
+test_expect_success 'URL-specific clone.defaultObjectFilter overrides bare form' '
+	SERVER_URL="file://$(pwd)/default-filter-srv.bare" &&
+	git \
+		-c clone.defaultObjectFilter=blob:limit=1k \
+		-c "clone.$SERVER_URL.defaultObjectFilter=blob:none" \
+		clone "$SERVER_URL" default-filter-url-over-bare &&
+
+	test "$(git -C default-filter-url-over-bare config --local remote.origin.partialclonefilter)" = "blob:none"
+'
 
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd

base-commit: 7b2bccb0d58d4f24705bf985de1f4612e4cf06e5
-- 
gitgitgadget
