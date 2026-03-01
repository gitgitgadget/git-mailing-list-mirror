Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09563358D9
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 16:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772383504; cv=none; b=c16wwmPKZmkex+o2u1JtBGi+oEqtChtiWdSIj+i66uNkVemzjri7Ssz3BEukdzpwKAGEzCJbCeeLqD7o32i89JS1isvq4CSlPHkZCaBMNJGycU8O7qkfJWWKzGuZpg4ozJcACx348NCdVSjRbBRbFpcyIjpeHNWFC83jxF0ySlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772383504; c=relaxed/simple;
	bh=RjmEtP6oHytAtaagHAmFEAVwi2F0YgnzZfKlTdUaf3k=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=dNWjKg3LdmmWheV/g5w6wH3YNKq/nXThu8Wwdc3gUPgf51qbJDlAo4xAq7gHeBcse00ecDPO1K3QhzhFQ9q0UBdi6c25cGmyB31g2nB2X7mqkY6EGMHGoKh2Bzl74yiroX7mU25BSkHsNt2eeCrd0QZcnzl0i1//CEf9ajo5GLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFmM2/9j; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFmM2/9j"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8954a050c19so44700966d6.3
        for <git@vger.kernel.org>; Sun, 01 Mar 2026 08:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772383501; x=1772988301; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XMBZdM/W2rLZH67SKyi9QOcRwEnvcsBn0r4Q4xEcuDs=;
        b=hFmM2/9jU1s2XWZdFeQ3LVmNYauq7B2rMJfFgshmNsHhjYWzd/UC/EJyfKOFDSSXHQ
         nlR4LnnIqeAvX8GfiHws8vbEjYpB364wOruQMvyH/6UmoKWLktiIdvtiRO+C/UW8Yv2g
         CgKY2ULHadRA3Q3AZ/nytKQ9g5eiVZT0fejP/c7THDhyQFeB2qNXpb0KtQ6VSi/hvu/T
         xksAUNtEgJlTzuNs/QjbAnecwsjLy+wtxN21FrOvjRHXROnJ+D/9wm96JXgypoSqZVUu
         IdDpOMvQU1Wa9ePly8IFGtuCsxTgvVFoM9IFAgnwJGc+pAZZMfeOteGsqr51tJFqdyjg
         YLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772383501; x=1772988301;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XMBZdM/W2rLZH67SKyi9QOcRwEnvcsBn0r4Q4xEcuDs=;
        b=naYv5h3d6y1HOkJisVUvz+Jc0o9RvH+Hx/mv74fKRMIGvDloWAgTnzxkuYgJbVfpC8
         rdnrrviDT/JvdBZ2u2e1UjqemhysipyJzQyot5JvIN+hg+gXbk4sP7L7Z58IoZkR8vIp
         S0WyNZtqqPiVcLJvDq2fv9xusn7+UDkwuauPAq0VuEg8ZonvBfjMU2jqKgCjv1A8xNcp
         qePL6F/aPWgH5X2DD/pta5gJIJ4v/B4GxjIu9nhuK1qaR/vgxsKIgOzrCTxPPAo6YxC+
         5y5gjTksLGmX2KqMt5IUuj/Ch3nLzzsTsvVog0IxPBW3gsUzRBheMMofJ1B2QT2JMK7F
         Kr1Q==
X-Gm-Message-State: AOJu0YxZgM21A5P9sYRIEXUF2+m+Bee2KRWa8eP6vpTWn59zUGjYrUyz
	0Ao0/Etmj7l3tBV22/PE9b+Fd2VOsOmLvtAqwvXhF59mk99noNqL2phwBQ8dGw==
X-Gm-Gg: ATEYQzxbL1GMmhB/rsKiDO9C8U1x8t+8gEGJKIc8K8Psw4d55Bp1QKa0G+MpKeozUWB
	A7+XH/LCAy15My4MaW8NSKS+thOjF5g/RTX1JwFakS/itDpp92D+gcDKT0XA8DQ2j5mZdWeAGVm
	4XPMob1sbNAeqEwK7eWOktFrMCXg/EfDv8ixAEhzewm0BLT/icYv3E35z5Gz/EbC1k77zUK9Oba
	yDMCAXN5SvEW44jTUfJMhzJvv/AmovKbFe8qpTcfTurnJkFaziBKtXurzo/9PdgwrA9rgnLJTYp
	yuanB9vW2jltjbXfPt499nc7pHrC4h0KObIQ6g5JqAEv9k5zQ1dnXDtuxvT5j0ROHsn/Jl+egMx
	j1+gEQcOBr5uke3Z7vyfR+rSxgOcWZIwGSyxyp3SPCQ9DJwv04dWkfly/90MFNN/cR3YZAoKIEb
	8BYLgpzrzRyJ1+lvhXf0y0Xr8=
X-Received: by 2002:a05:6214:ccd:b0:899:fd64:1b72 with SMTP id 6a1803df08f44-899fd64281fmr476306d6.41.1772383500989;
        Sun, 01 Mar 2026 08:45:00 -0800 (PST)
Received: from [127.0.0.1] ([9.234.151.82])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899f0e4740dsm19610066d6.2.2026.03.01.08.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 08:45:00 -0800 (PST)
Message-Id: <pull.2058.git.1772383499900.gitgitgadget@gmail.com>
From: "Alan Braithwaite via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 01 Mar 2026 16:44:59 +0000
Subject: [PATCH] fetch, clone: add fetch.blobSizeLimit config
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: ps@pks.im,
    christian.couder@gmail.com,
    jonathantanmy@google.com,
    me@ttaylorr.com,
    gitster@pobox.com,
    Alan Braithwaite <alan@braithwaite.dev>,
    Alan Braithwaite <alan@braithwaite.dev>

From: Alan Braithwaite <alan@braithwaite.dev>

External tools like git-lfs and git-fat use the filter clean/smudge
mechanism to manage large binary objects, but this requires pointer
files, a separate storage backend, and careful coordination. Git's
partial clone infrastructure provides a more native approach: large
blobs can be excluded at the protocol level during fetch and lazily
retrieved on demand. However, enabling this requires passing
`--filter=blob:limit=<size>` on every clone, which is not
discoverable and cannot be set as a global default.

Add a new `fetch.blobSizeLimit` configuration option that enables
size-based partial clone behavior globally. When set, both `git
clone` and `git fetch` automatically apply a `blob:limit=<size>`
filter. Blobs larger than the threshold that are not needed for the
current worktree are excluded from the transfer and lazily fetched
on demand when needed (e.g., during checkout, diff, or merge).

This makes it easy to work with repositories that have accumulated
large binary files in their history, without downloading all of
them upfront.

The precedence order is:
  1. Explicit `--filter=` on the command line (highest)
  2. Existing `remote.<name>.partialclonefilter`
  3. `fetch.blobSizeLimit` (new, lowest)

Once a clone or fetch applies this setting, the remote is registered
as a promisor remote with the corresponding filter spec, so
subsequent fetches inherit it automatically. If the server does not
support object filtering, the setting is silently ignored.

Signed-off-by: Alan Braithwaite <alan@braithwaite.dev>
---
    fetch, clone: add fetch.blobSizeLimit config

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2058%2Fabraithwaite%2Falan%2Ffetch-blob-size-limit-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2058/abraithwaite/alan/fetch-blob-size-limit-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2058

 Documentation/config/fetch.adoc | 19 +++++++++++
 builtin/clone.c                 | 13 +++++++
 builtin/fetch.c                 | 45 +++++++++++++++++++------
 t/t5616-partial-clone.sh        | 60 +++++++++++++++++++++++++++++++++
 4 files changed, 127 insertions(+), 10 deletions(-)

diff --git a/Documentation/config/fetch.adoc b/Documentation/config/fetch.adoc
index cd40db0cad..4165354dd9 100644
--- a/Documentation/config/fetch.adoc
+++ b/Documentation/config/fetch.adoc
@@ -103,6 +103,25 @@ config setting.
 	file helps performance of many Git commands, including `git merge-base`,
 	`git push -f`, and `git log --graph`. Defaults to `false`.
 
+`fetch.blobSizeLimit`::
+	When set to a size value (e.g., `1m`, `100k`, `1g`), both
+	linkgit:git-clone[1] and linkgit:git-fetch[1] will automatically
+	use `--filter=blob:limit=<value>` to enable partial clone
+	behavior. Blobs larger than this threshold are excluded from the
+	initial transfer and lazily fetched on demand when needed (e.g.,
+	during checkout).
++
+This provides a convenient way to enable size-based partial clones
+globally without passing `--filter` on every command. Once a clone or
+fetch applies this setting, the remote is registered as a promisor
+remote with the corresponding filter, so subsequent fetches inherit
+the filter automatically.
++
+An explicit `--filter` option on the command line takes precedence over
+this config. An existing `remote.<name>.partialclonefilter` also takes
+precedence. If the server does not support object filtering, the
+setting is silently ignored.
+
 `fetch.bundleURI`::
 	This value stores a URI for downloading Git object data from a bundle
 	URI before performing an incremental fetch from the origin Git server.
diff --git a/builtin/clone.c b/builtin/clone.c
index 45d8fa0eed..1e3261b623 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -78,6 +78,7 @@ static struct string_list option_optional_reference = STRING_LIST_INIT_NODUP;
 static int max_jobs = -1;
 static struct string_list option_recurse_submodules = STRING_LIST_INIT_NODUP;
 static int config_filter_submodules = -1;    /* unspecified */
+static char *config_blob_size_limit;
 static int option_remote_submodules;
 
 static int recurse_submodules_cb(const struct option *opt,
@@ -753,6 +754,10 @@ static int git_clone_config(const char *k, const char *v,
 		config_reject_shallow = git_config_bool(k, v);
 	if (!strcmp(k, "clone.filtersubmodules"))
 		config_filter_submodules = git_config_bool(k, v);
+	if (!strcmp(k, "fetch.blobsizelimit")) {
+		free(config_blob_size_limit);
+		git_config_string(&config_blob_size_limit, k, v);
+	}
 
 	return git_default_config(k, v, ctx, cb);
 }
@@ -1010,6 +1015,13 @@ int cmd_clone(int argc,
 	argc = parse_options(argc, argv, prefix, builtin_clone_options,
 			     builtin_clone_usage, 0);
 
+	if (!filter_options.choice && config_blob_size_limit) {
+		struct strbuf buf = STRBUF_INIT;
+		strbuf_addf(&buf, "blob:limit=%s", config_blob_size_limit);
+		parse_list_objects_filter(&filter_options, buf.buf);
+		strbuf_release(&buf);
+	}
+
 	if (argc > 2)
 		usage_msg_opt(_("Too many arguments."),
 			builtin_clone_usage, builtin_clone_options);
@@ -1634,6 +1646,7 @@ int cmd_clone(int argc,
 		       ref_storage_format);
 
 	list_objects_filter_release(&filter_options);
+	free(config_blob_size_limit);
 
 	string_list_clear(&option_not, 0);
 	string_list_clear(&option_config, 0);
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 573c295241..ff898cb6f4 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -109,6 +109,7 @@ struct fetch_config {
 	int recurse_submodules;
 	int parallel;
 	int submodule_fetch_jobs;
+	char *blob_size_limit;
 };
 
 static int git_fetch_config(const char *k, const char *v,
@@ -160,6 +161,9 @@ static int git_fetch_config(const char *k, const char *v,
 		return 0;
 	}
 
+	if (!strcmp(k, "fetch.blobsizelimit"))
+		return git_config_string(&fetch_config->blob_size_limit, k, v);
+
 	if (!strcmp(k, "fetch.output")) {
 		if (!v)
 			return config_error_nonbool(k);
@@ -2342,7 +2346,8 @@ static int fetch_multiple(struct string_list *list, int max_children,
  * or inherit the default filter-spec from the config.
  */
 static inline void fetch_one_setup_partial(struct remote *remote,
-					   struct list_objects_filter_options *filter_options)
+					   struct list_objects_filter_options *filter_options,
+					   const struct fetch_config *config)
 {
 	/*
 	 * Explicit --no-filter argument overrides everything, regardless
@@ -2352,10 +2357,12 @@ static inline void fetch_one_setup_partial(struct remote *remote,
 		return;
 
 	/*
-	 * If no prior partial clone/fetch and the current fetch DID NOT
-	 * request a partial-fetch, do a normal fetch.
+	 * If no prior partial clone/fetch, the current fetch did not
+	 * request a partial-fetch, and no global blob size limit is
+	 * configured, do a normal fetch.
 	 */
-	if (!repo_has_promisor_remote(the_repository) && !filter_options->choice)
+	if (!repo_has_promisor_remote(the_repository) &&
+	    !filter_options->choice && !config->blob_size_limit)
 		return;
 
 	/*
@@ -2372,11 +2379,27 @@ static inline void fetch_one_setup_partial(struct remote *remote,
 	/*
 	 * Do a partial-fetch from the promisor remote using either the
 	 * explicitly given filter-spec or inherit the filter-spec from
-	 * the config.
+	 * the per-remote config.
+	 */
+	if (repo_has_promisor_remote(the_repository)) {
+		partial_clone_get_default_filter_spec(filter_options,
+						      remote->name);
+		if (filter_options->choice)
+			return;
+	}
+
+	/*
+	 * Fall back to the global fetch.blobSizeLimit config. This
+	 * enables partial clone behavior without requiring --filter
+	 * on the command line or a pre-existing promisor remote.
 	 */
-	if (!filter_options->choice)
-		partial_clone_get_default_filter_spec(filter_options, remote->name);
-	return;
+	if (!filter_options->choice && config->blob_size_limit) {
+		struct strbuf buf = STRBUF_INIT;
+		strbuf_addf(&buf, "blob:limit=%s", config->blob_size_limit);
+		parse_list_objects_filter(filter_options, buf.buf);
+		strbuf_release(&buf);
+		partial_clone_register(remote->name, filter_options);
+	}
 }
 
 static int fetch_one(struct remote *remote, int argc, const char **argv,
@@ -2762,9 +2785,10 @@ int cmd_fetch(int argc,
 		oidset_clear(&acked_commits);
 		trace2_region_leave("fetch", "negotiate-only", the_repository);
 	} else if (remote) {
-		if (filter_options.choice || repo_has_promisor_remote(the_repository)) {
+		if (filter_options.choice || repo_has_promisor_remote(the_repository) ||
+		    config.blob_size_limit) {
 			trace2_region_enter("fetch", "setup-partial", the_repository);
-			fetch_one_setup_partial(remote, &filter_options);
+			fetch_one_setup_partial(remote, &filter_options, &config);
 			trace2_region_leave("fetch", "setup-partial", the_repository);
 		}
 		trace2_region_enter("fetch", "fetch-one", the_repository);
@@ -2876,5 +2900,6 @@ int cmd_fetch(int argc,
  cleanup:
 	string_list_clear(&list, 0);
 	list_objects_filter_release(&filter_options);
+	free(config.blob_size_limit);
 	return result;
 }
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 1e354e057f..44b41f315f 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -722,6 +722,66 @@ test_expect_success 'after fetching descendants of non-promisor commits, gc work
 	git -C partial gc --prune=now
 '
 
+# Test fetch.blobSizeLimit config
+
+test_expect_success 'setup for fetch.blobSizeLimit tests' '
+	git init blob-limit-src &&
+	echo "small" >blob-limit-src/small.txt &&
+	dd if=/dev/zero of=blob-limit-src/large.bin bs=1024 count=100 2>/dev/null &&
+	git -C blob-limit-src add . &&
+	git -C blob-limit-src commit -m "initial" &&
+
+	git clone --bare "file://$(pwd)/blob-limit-src" blob-limit-srv.bare &&
+	git -C blob-limit-srv.bare config --local uploadpack.allowfilter 1 &&
+	git -C blob-limit-srv.bare config --local uploadpack.allowanysha1inwant 1
+'
+
+test_expect_success 'clone with fetch.blobSizeLimit config applies filter' '
+	git -c fetch.blobSizeLimit=1k clone \
+		"file://$(pwd)/blob-limit-srv.bare" blob-limit-clone &&
+
+	test "$(git -C blob-limit-clone config --local remote.origin.promisor)" = "true" &&
+	test "$(git -C blob-limit-clone config --local remote.origin.partialclonefilter)" = "blob:limit=1024"
+'
+
+test_expect_success 'clone with --filter overrides fetch.blobSizeLimit' '
+	git -c fetch.blobSizeLimit=1k clone --filter=blob:none \
+		"file://$(pwd)/blob-limit-srv.bare" blob-limit-override &&
+
+	test "$(git -C blob-limit-override config --local remote.origin.partialclonefilter)" = "blob:none"
+'
+
+test_expect_success 'fetch with fetch.blobSizeLimit registers promisor remote' '
+	git clone --no-checkout "file://$(pwd)/blob-limit-srv.bare" blob-limit-fetch &&
+
+	# Sanity: not yet a partial clone
+	test_must_fail git -C blob-limit-fetch config --local remote.origin.promisor &&
+
+	# Add a new commit to the server
+	echo "new-small" >blob-limit-src/new-small.txt &&
+	dd if=/dev/zero of=blob-limit-src/new-large.bin bs=1024 count=100 2>/dev/null &&
+	git -C blob-limit-src add . &&
+	git -C blob-limit-src commit -m "second" &&
+	git -C blob-limit-src push "file://$(pwd)/blob-limit-srv.bare" main &&
+
+	# Fetch with the config set
+	git -C blob-limit-fetch -c fetch.blobSizeLimit=1k fetch origin &&
+
+	test "$(git -C blob-limit-fetch config --local remote.origin.promisor)" = "true" &&
+	test "$(git -C blob-limit-fetch config --local remote.origin.partialclonefilter)" = "blob:limit=1024"
+'
+
+test_expect_success 'fetch.blobSizeLimit does not override existing partialclonefilter' '
+	git clone --filter=blob:none \
+		"file://$(pwd)/blob-limit-srv.bare" blob-limit-existing &&
+
+	test "$(git -C blob-limit-existing config --local remote.origin.partialclonefilter)" = "blob:none" &&
+
+	# Fetch with a different blobSizeLimit; existing filter should win
+	git -C blob-limit-existing -c fetch.blobSizeLimit=1k fetch origin &&
+
+	test "$(git -C blob-limit-existing config --local remote.origin.partialclonefilter)" = "blob:none"
+'
 
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd

base-commit: 7b2bccb0d58d4f24705bf985de1f4612e4cf06e5
-- 
gitgitgadget
