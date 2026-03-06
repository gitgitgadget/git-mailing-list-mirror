Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9B134676F
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 21:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772833654; cv=none; b=k+Q7VdbjPqDDIF1JI0cXDgrngcJ08HDqMW4tOrtaha9clwZG5ZgAuR6fCmfKq1HJVxci/NYtPyuJUSARNnbhw9ifWjN/ca9IYl9KDPGrf+yOpcQGNWfT14tyjjLHmi54H+8uqcCBonsiWfWJQAKlMi1Wl5cBbL+TG9aVT1Ynj8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772833654; c=relaxed/simple;
	bh=mG5HvBXR4InIasE8NER7dngZ53bB/z8KRGCZcmw02As=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=oKV9tQf97bxNANMWcSDjfwyo2vuAFUz/qNz3ac8ZD219+SgEmIX1xwb6dPxiUWfZXgZujprhuGibYCcw5rsh7djn44TAV4SZIlvxFviTcXZ4VDovZgUG3GhXTuwaFm2ErjLto0bGkzwfkfk/OEryqze2anefRrZs2z0BFnYPBBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bA9/enDr; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bA9/enDr"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-89a09ef1e3aso66098066d6.0
        for <git@vger.kernel.org>; Fri, 06 Mar 2026 13:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772833651; x=1773438451; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1CuxPIpkBlrHY4kbLjlMv+d1GrL5na7t8uGezcF1Vzc=;
        b=bA9/enDr3rPgczh1e2QDjqrmueLLlBQFCIcJ/+l7tjlg0wIPPh2RCv6UDYBSjleEcX
         jc+cSAwIvo/E76RA5mr8D/yMx8MwOmSIm4l21q249R5jyrxn+kUuHFZNSTps3x+LqbGf
         susTGihPafgN9ACWBP5Ye+MlOxWo/03JyO1ZNuz/zo8c0F57vX518IA/GnD9j8L0nns1
         5q8l9xFw7rtFe9/1SsLQKpMmAfAFO2Yljnifd1K7VLhbzMmUhRP02VjYeJ3TdY8leGGf
         XC5OnYV/x15IDeJOJgbu+r4e4sanG8UNHKuemPP6OANCFMg02LD5nl3Cme55BS/fgNrU
         rr6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772833651; x=1773438451;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1CuxPIpkBlrHY4kbLjlMv+d1GrL5na7t8uGezcF1Vzc=;
        b=hiUi6fll3lE8dfUyWZ4K8ziuw9cvrKqzOFu2mAhLNYSXSMBn8yiNe0GwWQWQlKgknz
         02mTYMfZDqdHaMPLYTl/YGkguwbGTkuEB3rJ0eFbAtvhhPhmGkZuSK8kBIaadQ4JUlm2
         RotkinTSBdbASkiOKYNAo/MnSu2exCuai9NEmdXm4s5hpUbXJi7wHlLhIwEAYGDYCcC9
         T26Pa4/LBn5HX7pvfFL+LHD+GxRnfV0SGEC0UEp3ckHYQWg/B+62xjp/KYCYCHYCBgYD
         xiPRr8wV4L3jB//+IpPfSS6ssbKBQc/GJL/J7tkTVXmjjenCficnlUL416xdwXOp5fqI
         UWRA==
X-Gm-Message-State: AOJu0YxZv5mHVHBpOZIJY0c2yFzOdS7uOcBLeroiCXjFaxNHnSYWBEXc
	kUjM7qzpkQat2zSBUtu9EaxO2xJZn7wqQjRKM3oKyR2bcKWMppPQD8X++j2TMQ==
X-Gm-Gg: ATEYQzxQC73dGIO/kcMSMQ0ShUZztGRXmKmVJWwfZbM5RLTohLa7qOZklcXCjBj3Hwf
	qKGXi2QV8Li1igD4ylQ49UqolEZWRg2b0JLUpUGtZFdWQ9fd5ezpGxil3yqXMq+v8yY+e3Ap5J7
	EHsOVXKoildQgfSsB9pYl+5BlPs9ZBNToO82w30l3CQLUws+lxKMq5X1Ad5xtjNpAVlfF94pa/n
	C0PzSTrwMPFvfpU3/YS0p65IJM/1x+o7zTz5E+acWBOkdv7pFk/cdECdV65L7R7X9EZUllDfaOy
	v+BonPoTUWcw9ycTnFv8x78d+U6/Jq1Lq5jtfGkVGKDw3gN4fGOO189hb1I5TIQnJM7LXaXsgiB
	xchj4LVNQEoCkUaf9HeQ0dzl7ATgpK8nzHShVseiVHu5KaIuucJ8DOb6R7LEpjQEYkw4qv2L1Bc
	J5JigafVMcpcxgS5nijcW+gIkaYQ==
X-Received: by 2002:ad4:5c4c:0:b0:89a:3013:be02 with SMTP id 6a1803df08f44-89a30acb826mr52253396d6.34.1772833651158;
        Fri, 06 Mar 2026 13:47:31 -0800 (PST)
Received: from [127.0.0.1] ([64.236.134.162])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a3143d5f7sm20536046d6.13.2026.03.06.13.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 13:47:30 -0800 (PST)
Message-Id: <pull.2058.v4.git.1772833649843.gitgitgadget@gmail.com>
In-Reply-To: <pull.2058.v3.git.1772780113400.gitgitgadget@gmail.com>
References: <pull.2058.v3.git.1772780113400.gitgitgadget@gmail.com>
From: "Alan Braithwaite via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 06 Mar 2026 21:47:29 +0000
Subject: [PATCH v4] clone: add clone.<url>.defaultObjectFilter config
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2058%2Fabraithwaite%2Falan%2Ffetch-blob-size-limit-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2058/abraithwaite/alan/fetch-blob-size-limit-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/2058

Range-diff vs v3:

 1:  5408412f2a ! 1:  4bf3e1ec63 clone: add clone.<url>.defaultObjectFilter config
     @@ Documentation/config/clone.adoc: endif::[]
      +----
      ++
      +An explicit `--filter` option on the command line takes precedence
     -+over this config.  Only affects the initial clone; it has no effect
     -+on later fetches into an existing repository.  If the server does
     -+not support object filtering, the setting is silently ignored.
     ++over this config, and `--no-filter` defeats it entirely to force a
     ++full clone.  Only affects the initial clone; it has no effect on
     ++later fetches into an existing repository.  If the server does not
     ++support object filtering, the setting is silently ignored.
      
       ## builtin/clone.c ##
      @@
     @@ builtin/clone.c: int cmd_clone(int argc,
       	} else
       		die(_("repository '%s' does not exist"), repo_name);
       
     -+	if (!filter_options.choice) {
     ++	if (!filter_options.choice && !filter_options.no_filter) {
      +		char *config_filter = get_default_object_filter(repo);
      +		if (config_filter) {
      +			parse_list_objects_filter(&filter_options, config_filter);
     @@ t/t5616-partial-clone.sh: test_expect_success 'after fetching descendants of non
      +		clone "$SERVER_URL" default-filter-url-over-bare &&
      +
      +	test "$(git -C default-filter-url-over-bare config --local remote.origin.partialclonefilter)" = "blob:none"
     ++'
     ++
     ++test_expect_success '--no-filter defeats clone.defaultObjectFilter' '
     ++	SERVER_URL="file://$(pwd)/default-filter-srv.bare" &&
     ++	git -c "clone.$SERVER_URL.defaultObjectFilter=blob:none" \
     ++		clone --no-filter "$SERVER_URL" default-filter-no-filter &&
     ++
     ++	test_must_fail git -C default-filter-no-filter config --local remote.origin.promisor
      +'
       
       . "$TEST_DIRECTORY"/lib-httpd.sh


 Documentation/config/clone.adoc | 34 ++++++++++++
 builtin/clone.c                 | 50 ++++++++++++++++++
 t/t5616-partial-clone.sh        | 92 +++++++++++++++++++++++++++++++++
 3 files changed, 176 insertions(+)

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
index 1e354e057f..e85d2a8ce8 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -722,6 +722,98 @@ test_expect_success 'after fetching descendants of non-promisor commits, gc work
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
