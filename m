Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6C0625
	for <git@vger.kernel.org>; Sun, 15 Mar 2026 05:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773553026; cv=none; b=gGnglmjkTm6JD9q223SlHXfur3wFn2giRc8/PpiodmgBXxX69yWvaeulxrLgJQi9MA9J1YU1qdB6p4m2oMGdKYNN1KjfWSP3uVIevHs+V0wC81hbbf9rnDgB5BtiR9GnPdR8IV2Xf9MpXqNI1r15Az/GRi6pvdxEhAgqeylmlII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773553026; c=relaxed/simple;
	bh=2+JKJseIjpOiJm31Y4WSrQ6uTDdY1tC3qB3Ez5kM9p4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=I6xnEGAq0jeOZCvGIfxqaJtSk1tezcmX81y9Bmo9k/DnzE2IMKsdk5jxdaZgWGUZDZu8H6AMCWVPSqbtu9wmzcha/d9Ip/A2xxAyfoIXthEVgxLbYpKnXpwd/GU9M/DH3PCzcTBie3ndyu8X7v40s+VMIDWIANZdkSNSoi+9T0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pe4QftNK; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pe4QftNK"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-354a18c48b5so3460879a91.1
        for <git@vger.kernel.org>; Sat, 14 Mar 2026 22:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773553024; x=1774157824; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V43ir0tNLKHYBcMIu9/Oxgd0yyRsi00FL0rI0eyP0Go=;
        b=Pe4QftNKsUDRLuwaPLL/nMnpzq9XLzQaYhBmYORsZ5IzR+iSMEv1RJQIREURZuyXeq
         KpeK659xItKdxJChEOWljC2N1K3HbT1Cy1S0LkohdzZf4aNPq3mJuaJz5n8ScmIuDllP
         j6EQgBjQKpzoNZNvwepZSknnWPg3PmY1JFxW1zaM0Nqe03VL1Zhnd0IS/kID7YBA6VEE
         pjOj948pLnsDWJO64JSs15s7/GZkWWj/2xkTB4s6pPZn8noijHbujhMFzzNxiqHseQuD
         AT4dlAE38ModkxXdYVJLL84cSY2y4uI4kdExS1c7lfqAi4UpMCC2bE5bvd0llL09uV1O
         00hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773553024; x=1774157824;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V43ir0tNLKHYBcMIu9/Oxgd0yyRsi00FL0rI0eyP0Go=;
        b=mw9cydEHKyk2Fa1uzNKR74oG3d+ubJMJQvgkSc3VEXq7ZIgFjhHX/1zOMhyu1yAOas
         DS89FMrI2v0YbeadpvH1zwB4SQywQG1HJwvccVgzVW6idDcnAGmomcfOuV4FD0Eoj83B
         O2VI55lRnN9zfvrmZcGpjDaasUQ/E5kFEuvh3DXrLD93YJ77cL9X2ViklGWmiENFSUzL
         jRm0ezr5C0Pv7THUY5Snia4QTFI6NmjrBJItOK3L21HdFxhT/0BcEKCKxIIn+9jYSZym
         IdtMoDd27zwa/yC3kCuBdgUZNuq3+vTsJVnAsTjtB9esrx67+NdCCAucpgiFGkMx3n+1
         idCg==
X-Gm-Message-State: AOJu0YyHDu71ID4AGlFbM5AYOZrCS1LZKIZt90w0Bg1LQRhiiCzeW92T
	2P+3Y3l1l5DeJbbHPQHJ5mJRzpqOk6SYGs5rQn3o8052TYXixXCE42fEbm3ZIA==
X-Gm-Gg: ATEYQzzmByB4Mp99R7kL7afWfxwiLgRZ5DhV7g96I0JHb9ARmBl3RGAvF7kQ2B6ze+J
	WETIgY/lIUpYhP7NRYrj/WefuXoIIzTFk+tSJQTYLdp7+eHz+OU7yp1MKhCnuBXzei961jAzvnx
	urDjnS1eNWxp8pasfw2rUDt1jzMZ0QuhXIMVD9Z+FMREXWlmresmDcS71iD0qvS10lr9l1R1I4G
	s93uklw1DvPyYPCoeGzN3LJI+r+MNLmiRCC/YIaqN0Yt8lL4LXHajuUQrgOWpSzHvbNMrw0nPZQ
	5xMU2Zyfn9UktBQoCyUjIOpVzRnbpIt2u4/uTyDAT8/ES2gJFyZMStEyhLtcvY/6Jg2D8st+dvO
	dBoUv1Y7wNGg6kupVA/ROvqfYa6y5RjHmqaufBr2fXGd4MmzozTK5mLEQUUvotCCXm2gR54awbF
	1SE1gPj/E3n5XVTqBmP9C9t3pRrLh4v0+rYQ==
X-Received: by 2002:a17:90b:52c3:b0:359:ff8a:ee44 with SMTP id 98e67ed59e1d1-35a21e4ee3dmr8584537a91.2.1773553023599;
        Sat, 14 Mar 2026 22:37:03 -0700 (PDT)
Received: from [127.0.0.1] ([20.3.221.180])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a0bc58b44sm11017764a91.3.2026.03.14.22.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 22:37:03 -0700 (PDT)
Message-Id: <pull.2058.v6.git.1773553022381.gitgitgadget@gmail.com>
In-Reply-To: <pull.2058.v5.git.1772847236966.gitgitgadget@gmail.com>
References: <pull.2058.v5.git.1772847236966.gitgitgadget@gmail.com>
From: "Alan Braithwaite via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 15 Mar 2026 05:37:02 +0000
Subject: [PATCH v6] clone: add clone.<url>.defaultObjectFilter config
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2058%2Fabraithwaite%2Falan%2Ffetch-blob-size-limit-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2058/abraithwaite/alan/fetch-blob-size-limit-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/2058

Range-diff vs v5:

 1:  fa1ea69bdb ! 1:  480453b2e7 clone: add clone.<url>.defaultObjectFilter config
     @@ builtin/clone.c: static int git_clone_config(const char *k, const char *v,
      +	config.cb = &filter_spec;
      +
      +	normalized_url = url_normalize(url, &config.url);
     ++	if (!normalized_url) {
     ++		urlmatch_config_release(&config);
     ++		return NULL;
     ++	}
      +
      +	repo_config(the_repository, urlmatch_config_entry, &config);
      +	free(normalized_url);
     @@ t/t5616-partial-clone.sh: test_expect_success 'after fetching descendants of non
      +test_expect_success 'setup for clone.defaultObjectFilter tests' '
      +	git init default-filter-src &&
      +	echo "small" >default-filter-src/small.txt &&
     -+	dd if=/dev/zero of=default-filter-src/large.bin bs=1024 count=100 2>/dev/null &&
      +	git -C default-filter-src add . &&
      +	git -C default-filter-src commit -m "initial" &&
      +
     @@ t/t5616-partial-clone.sh: test_expect_success 'after fetching descendants of non
      +'
      +
      +test_expect_success 'clone with clone.<url>.defaultObjectFilter applies filter' '
     ++	test_when_finished "rm -r default-filter-clone" &&
      +	SERVER_URL="file://$(pwd)/default-filter-srv.bare" &&
      +	git -c "clone.$SERVER_URL.defaultObjectFilter=blob:limit=1k" clone \
      +		"$SERVER_URL" default-filter-clone &&
     @@ t/t5616-partial-clone.sh: test_expect_success 'after fetching descendants of non
      +'
      +
      +test_expect_success 'clone with --filter overrides clone.<url>.defaultObjectFilter' '
     ++	test_when_finished "rm -r default-filter-override" &&
      +	SERVER_URL="file://$(pwd)/default-filter-srv.bare" &&
      +	git -c "clone.$SERVER_URL.defaultObjectFilter=blob:limit=1k" \
      +		clone --filter=blob:none "$SERVER_URL" default-filter-override &&
     @@ t/t5616-partial-clone.sh: test_expect_success 'after fetching descendants of non
      +'
      +
      +test_expect_success 'clone with clone.<url>.defaultObjectFilter=blob:none works' '
     ++	test_when_finished "rm -r default-filter-blobnone" &&
      +	SERVER_URL="file://$(pwd)/default-filter-srv.bare" &&
      +	git -c "clone.$SERVER_URL.defaultObjectFilter=blob:none" clone \
      +		"$SERVER_URL" default-filter-blobnone &&
     @@ t/t5616-partial-clone.sh: test_expect_success 'after fetching descendants of non
      +'
      +
      +test_expect_success 'clone.<url>.defaultObjectFilter with tree:0 works' '
     ++	test_when_finished "rm -r default-filter-tree0" &&
      +	SERVER_URL="file://$(pwd)/default-filter-srv.bare" &&
      +	git -c "clone.$SERVER_URL.defaultObjectFilter=tree:0" clone \
      +		"$SERVER_URL" default-filter-tree0 &&
     @@ t/t5616-partial-clone.sh: test_expect_success 'after fetching descendants of non
      +'
      +
      +test_expect_success 'most specific URL match wins for clone.defaultObjectFilter' '
     ++	test_when_finished "rm -r default-filter-url-specific" &&
      +	SERVER_URL="file://$(pwd)/default-filter-srv.bare" &&
      +	git \
      +		-c "clone.file://.defaultObjectFilter=blob:limit=1k" \
     @@ t/t5616-partial-clone.sh: test_expect_success 'after fetching descendants of non
      +'
      +
      +test_expect_success 'non-matching URL does not apply clone.defaultObjectFilter' '
     ++	test_when_finished "rm -r default-filter-url-nomatch" &&
      +	git \
      +		-c "clone.https://other.example.com/.defaultObjectFilter=blob:none" \
      +		clone "file://$(pwd)/default-filter-srv.bare" default-filter-url-nomatch &&
     @@ t/t5616-partial-clone.sh: test_expect_success 'after fetching descendants of non
      +'
      +
      +test_expect_success 'bare clone.defaultObjectFilter applies to all clones' '
     ++	test_when_finished "rm -r default-filter-bare-key" &&
      +	git -c clone.defaultObjectFilter=blob:none \
      +		clone "file://$(pwd)/default-filter-srv.bare" default-filter-bare-key &&
      +
     @@ t/t5616-partial-clone.sh: test_expect_success 'after fetching descendants of non
      +'
      +
      +test_expect_success 'URL-specific clone.defaultObjectFilter overrides bare form' '
     ++	test_when_finished "rm -r default-filter-url-over-bare" &&
      +	SERVER_URL="file://$(pwd)/default-filter-srv.bare" &&
      +	git \
      +		-c clone.defaultObjectFilter=blob:limit=1k \
     @@ t/t5616-partial-clone.sh: test_expect_success 'after fetching descendants of non
      +'
      +
      +test_expect_success '--no-filter defeats clone.defaultObjectFilter' '
     ++	test_when_finished "rm -r default-filter-no-filter" &&
      +	SERVER_URL="file://$(pwd)/default-filter-srv.bare" &&
      +	git -c "clone.$SERVER_URL.defaultObjectFilter=blob:none" \
      +		clone --no-filter "$SERVER_URL" default-filter-no-filter &&


 Documentation/config/clone.adoc |  34 +++++++++
 builtin/clone.c                 |  54 ++++++++++++++
 t/t5616-partial-clone.sh        | 126 ++++++++++++++++++++++++++++++++
 3 files changed, 214 insertions(+)

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
index 45d8fa0eed..18316a7da9 100644
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
@@ -757,6 +758,51 @@ static int git_clone_config(const char *k, const char *v,
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
+	if (!normalized_url) {
+		urlmatch_config_release(&config);
+		return NULL;
+	}
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
@@ -1057,6 +1103,14 @@ int cmd_clone(int argc,
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
index 1e354e057f..e8cf5e353a 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -722,6 +722,132 @@ test_expect_success 'after fetching descendants of non-promisor commits, gc work
 	git -C partial gc --prune=now
 '
 
+# Test clone.<url>.defaultObjectFilter config
+
+test_expect_success 'setup for clone.defaultObjectFilter tests' '
+	git init default-filter-src &&
+	echo "small" >default-filter-src/small.txt &&
+	git -C default-filter-src add . &&
+	git -C default-filter-src commit -m "initial" &&
+
+	git clone --bare "file://$(pwd)/default-filter-src" default-filter-srv.bare &&
+	git -C default-filter-srv.bare config --local uploadpack.allowfilter 1 &&
+	git -C default-filter-srv.bare config --local uploadpack.allowanysha1inwant 1
+'
+
+test_expect_success 'clone with clone.<url>.defaultObjectFilter applies filter' '
+	test_when_finished "rm -r default-filter-clone" &&
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
+	test_when_finished "rm -r default-filter-override" &&
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
+	test_when_finished "rm -r default-filter-blobnone" &&
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
+	test_when_finished "rm -r default-filter-tree0" &&
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
+	test_when_finished "rm -r default-filter-url-specific" &&
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
+	test_when_finished "rm -r default-filter-url-nomatch" &&
+	git \
+		-c "clone.https://other.example.com/.defaultObjectFilter=blob:none" \
+		clone "file://$(pwd)/default-filter-srv.bare" default-filter-url-nomatch &&
+
+	test_must_fail git -C default-filter-url-nomatch config --local remote.origin.promisor
+'
+
+test_expect_success 'bare clone.defaultObjectFilter applies to all clones' '
+	test_when_finished "rm -r default-filter-bare-key" &&
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
+	test_when_finished "rm -r default-filter-url-over-bare" &&
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
+	test_when_finished "rm -r default-filter-no-filter" &&
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
