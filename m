Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90FD30101A
	for <git@vger.kernel.org>; Mon, 24 Nov 2025 12:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763988542; cv=none; b=HN8SDGhv9XMFmoDN+PfzMZaqKEof7l9TGsgikaUFDqi8xpvvK0s5JhgDouQL7lZw3Q0WBMG902KmPMmLNu+iW7rNK7Uuxgs1XJmeJTlJXnTCdrbkOBaAli7KiF+fGZg3OklYuxRxUMNH2K4RTXpJNRLOZg9/tjM10njKnuFwnso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763988542; c=relaxed/simple;
	bh=egIG+ny0Umvdno4M2zZ2I5uyyyrBSI2OJK9r4LdO4yA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=nRTBCfmnnA+mE9WbmOgLBE4xc5znndNpCpQs1y6T/fTFz/r/wVcvyvvcsYXGq6KEgl9Ffc+Je2SBJbrhN/5Yi+oj0fjY5q4PSC3igGAr+Eakvq+0GQ6zY2XgjYRy2Yf+XT0OsfrBYPM0kkv9/rkynfxkz1se2Dn3OCmxmj19uNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0JRC5Hw; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0JRC5Hw"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-94880628ffaso103562839f.0
        for <git@vger.kernel.org>; Mon, 24 Nov 2025 04:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763988538; x=1764593338; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=koeOeEV3MaSeELJruHZ//JgpY9wEYB3rOvH3VxtcH+c=;
        b=H0JRC5HwNTdN4d1rjvUeX0fX+j2qQKXMhGqRg6D45fTPWtiXwSHtvkkc29jVJUIwD0
         1lduvTZPw8NcymSKW5Ee89HaYvf0LES/VZoJlJ3L/hAvB3dJBnqldLSyLxwFFHMLjehl
         jP2KXyR2xJHFxw61m5xYREDFmqur56q3Lvi/n4NOszwxuxm7V8tT3Y4DLqbn3KHpkM+r
         oyHMTtqQMdKmbqiLg9ok8lcZ9Qw90UAXOmc6AXCGGlBNP3v9fYjWDQyEcw9oqD6Sg8F0
         4LccAH9Ofp8h5JNCYM1YVTP72yR9x/j2QKOnbnw40KPMphoKhqDTVD/68a+E9uZFWG3A
         RZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763988538; x=1764593338;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=koeOeEV3MaSeELJruHZ//JgpY9wEYB3rOvH3VxtcH+c=;
        b=Fr5g6osnLCGDd/RO7DCmMiR+ZlRUCBdm9uXH0ypa7XEuZYnlJapfhZYGmcSeMuUEmB
         /jkFyYXSvFyV9hVelUZVPnwSf1jX52Cm5VvqBrySEUQ4sLo+LEiuyBTm0xcI/H5q5HpJ
         vvCmhBzg2v7eB3pU6ahyXLPbKLvZMPiiwOIteW3CmBF1h6Fp8bxiJu9U3UyBdWkeyaqq
         NwQDhAh6c/WlvzMlimn/ehNFux4W5HR5obM0lSkqGtYgxHV7jIi+vsAzBvEF37pi1m2s
         GBHYVZ6RI8l5gRtSWzT6dGsRaWY+7wvijq2ooJHxjQdUi/PtfPhcllYmF8IQlDCmZ+H5
         +2cQ==
X-Gm-Message-State: AOJu0Yycd8su0KFXN1Ha1iZK0AyKy/O48sTvpeymqZ6v1pNgJK9WXAW8
	uknLEwH1Gk3m86kllxgkbFy3AHQFZYKK+9SPbjVvtqW3WQ5kt07tzH9aAXDqHg==
X-Gm-Gg: ASbGnctU3QHgCXTw/moZb9G31s9VXlZ5NujBQP49uqzhj5rYA2SavwQuX0j8n/Ko5zF
	eImzIXt1IL0RdEYTrnG+358UScebwW+dOqBKf3jktpt+gZS4Oz9vXzh0CmuxrltwXwBYwfZ1ZLS
	NawDbs0N+saDv3ASqmixV8xMaXqybuocS3gQB+iVtZxeQWv2eiGPz0iyCWlPxolbXao8bacnX7W
	pQk5rjxFneQvGK8FQZgLuqV1ulKwRYTkFwLbyp33UE9cjCZZ7/r/CDzdeDKC/EMRaOhhqqklRae
	6/dDKovHur8IYjapRxHQJv/PWduUDeyKiL3yFqStNQDSlXE7fxoexLNpTHl8KF2n7ROrfuSWMOp
	sTC4Y7ANWIpZSYufBEwhVtuZ1p54IjleB1BZU23ZgWfipO/jktnl/LlLP4r9EBFgnHiiOW+JHZo
	FT+X3jCSoZh5Oa
X-Google-Smtp-Source: AGHT+IGcbnmAmnflfOFqkAf0udy9l/e9tL0gnEOQlyfjo3diaybB/BW81OJqZVwyyO/wqXj7ZK+TXA==
X-Received: by 2002:a02:a913:0:b0:5b7:11f4:232 with SMTP id 8926c6da1cb9f-5b965b1b9admr7723443173.9.1763988537591;
        Mon, 24 Nov 2025 04:48:57 -0800 (PST)
Received: from [127.0.0.1] ([132.196.32.66])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b954a0de8bsm5693952173.12.2025.11.24.04.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 04:48:56 -0800 (PST)
Message-Id: <994f6ee414305ab88258141a24bf82486da56f4d.1763988532.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2002.v2.git.1763988532.gitgitgadget@gmail.com>
References: <pull.2002.git.1763588404.gitgitgadget@gmail.com>
	<pull.2002.v2.git.1763988532.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 24 Nov 2025 12:48:50 +0000
Subject: [PATCH v2 1/3] doc: convert git fetch to synopsis style
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
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

- Switch the synopsis to a synopsis block which will automatically
  format placeholders in italics and keywords in monospace
- Use _<placeholder>_ instead of <placeholder> in the description
- Use `backticks` for keywords and more complex option
descriptions. The new rendering engine will apply synopsis rules to
these spans.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/config/fetch.adoc     |  60 ++++-----
 Documentation/fetch-options.adoc    | 201 ++++++++++++++--------------
 Documentation/git-fetch.adoc        |  48 +++----
 Documentation/pull-fetch-param.adoc |  50 +++----
 Documentation/urls-remotes.adoc     |  16 +--
 builtin/fetch.c                     |   2 +-
 6 files changed, 189 insertions(+), 188 deletions(-)

diff --git a/Documentation/config/fetch.adoc b/Documentation/config/fetch.adoc
index d7dc461bd1..cd40db0cad 100644
--- a/Documentation/config/fetch.adoc
+++ b/Documentation/config/fetch.adoc
@@ -1,32 +1,32 @@
-fetch.recurseSubmodules::
+`fetch.recurseSubmodules`::
 	This option controls whether `git fetch` (and the underlying fetch
 	in `git pull`) will recursively fetch into populated submodules.
-	This option can be set either to a boolean value or to 'on-demand'.
+	This option can be set either to a boolean value or to `on-demand`.
 	Setting it to a boolean changes the behavior of fetch and pull to
 	recurse unconditionally into submodules when set to true or to not
-	recurse at all when set to false. When set to 'on-demand', fetch and
+	recurse at all when set to false. When set to `on-demand`, fetch and
 	pull will only recurse into a populated submodule when its
 	superproject retrieves a commit that updates the submodule's
 	reference.
-	Defaults to 'on-demand', or to the value of 'submodule.recurse' if set.
+	Defaults to `on-demand`, or to the value of `submodule.recurse` if set.
 
-fetch.fsckObjects::
+`fetch.fsckObjects`::
 	If it is set to true, git-fetch-pack will check all fetched
 	objects. See `transfer.fsckObjects` for what's
-	checked. Defaults to false. If not set, the value of
+	checked. Defaults to `false`. If not set, the value of
 	`transfer.fsckObjects` is used instead.
 
-fetch.fsck.<msg-id>::
+`fetch.fsck.<msg-id>`::
 	Acts like `fsck.<msg-id>`, but is used by
 	linkgit:git-fetch-pack[1] instead of linkgit:git-fsck[1]. See
 	the `fsck.<msg-id>` documentation for details.
 
-fetch.fsck.skipList::
+`fetch.fsck.skipList`::
 	Acts like `fsck.skipList`, but is used by
 	linkgit:git-fetch-pack[1] instead of linkgit:git-fsck[1]. See
 	the `fsck.skipList` documentation for details.
 
-fetch.unpackLimit::
+`fetch.unpackLimit`::
 	If the number of objects fetched over the Git native
 	transfer is below this
 	limit, then the objects will be unpacked into loose object
@@ -37,12 +37,12 @@ fetch.unpackLimit::
 	especially on slow filesystems.  If not set, the value of
 	`transfer.unpackLimit` is used instead.
 
-fetch.prune::
+`fetch.prune`::
 	If true, fetch will automatically behave as if the `--prune`
 	option was given on the command line.  See also `remote.<name>.prune`
 	and the PRUNING section of linkgit:git-fetch[1].
 
-fetch.pruneTags::
+`fetch.pruneTags`::
 	If true, fetch will automatically behave as if the
 	`refs/tags/*:refs/tags/*` refspec was provided when pruning,
 	if not set already. This allows for setting both this option
@@ -50,41 +50,41 @@ fetch.pruneTags::
 	refs. See also `remote.<name>.pruneTags` and the PRUNING
 	section of linkgit:git-fetch[1].
 
-fetch.all::
+`fetch.all`::
 	If true, fetch will attempt to update all available remotes.
 	This behavior can be overridden by passing `--no-all` or by
 	explicitly specifying one or more remote(s) to fetch from.
-	Defaults to false.
+	Defaults to `false`.
 
-fetch.output::
+`fetch.output`::
 	Control how ref update status is printed. Valid values are
 	`full` and `compact`. Default value is `full`. See the
 	OUTPUT section in linkgit:git-fetch[1] for details.
 
-fetch.negotiationAlgorithm::
+`fetch.negotiationAlgorithm`::
 	Control how information about the commits in the local repository
 	is sent when negotiating the contents of the packfile to be sent by
-	the server.  Set to "consecutive" to use an algorithm that walks
-	over consecutive commits checking each one.  Set to "skipping" to
+	the server.  Set to `consecutive` to use an algorithm that walks
+	over consecutive commits checking each one.  Set to `skipping` to
 	use an algorithm that skips commits in an effort to converge
 	faster, but may result in a larger-than-necessary packfile; or set
-	to "noop" to not send any information at all, which will almost
+	to `noop` to not send any information at all, which will almost
 	certainly result in a larger-than-necessary packfile, but will skip
-	the negotiation step.  Set to "default" to override settings made
+	the negotiation step.  Set to `default` to override settings made
 	previously and use the default behaviour.  The default is normally
-	"consecutive", but if `feature.experimental` is true, then the
-	default is "skipping".  Unknown values will cause 'git fetch' to
+	`consecutive`, but if `feature.experimental` is `true`, then the
+	default is `skipping`.  Unknown values will cause `git fetch` to
 	error out.
 +
 See also the `--negotiate-only` and `--negotiation-tip` options to
 linkgit:git-fetch[1].
 
-fetch.showForcedUpdates::
-	Set to false to enable `--no-show-forced-updates` in
+`fetch.showForcedUpdates`::
+	Set to `false` to enable `--no-show-forced-updates` in
 	linkgit:git-fetch[1] and linkgit:git-pull[1] commands.
-	Defaults to true.
+	Defaults to `true`.
 
-fetch.parallel::
+`fetch.parallel`::
 	Specifies the maximal number of fetch operations to be run in parallel
 	at a time (submodules, or remotes when the `--multiple` option of
 	linkgit:git-fetch[1] is in effect).
@@ -94,16 +94,16 @@ A value of 0 will give some reasonable default. If unset, it defaults to 1.
 For submodules, this setting can be overridden using the `submodule.fetchJobs`
 config setting.
 
-fetch.writeCommitGraph::
+`fetch.writeCommitGraph`::
 	Set to true to write a commit-graph after every `git fetch` command
 	that downloads a pack-file from a remote. Using the `--split` option,
 	most executions will create a very small commit-graph file on top of
 	the existing commit-graph file(s). Occasionally, these files will
 	merge and the write may take longer. Having an updated commit-graph
 	file helps performance of many Git commands, including `git merge-base`,
-	`git push -f`, and `git log --graph`. Defaults to false.
+	`git push -f`, and `git log --graph`. Defaults to `false`.
 
-fetch.bundleURI::
+`fetch.bundleURI`::
 	This value stores a URI for downloading Git object data from a bundle
 	URI before performing an incremental fetch from the origin Git server.
 	This is similar to how the `--bundle-uri` option behaves in
@@ -115,9 +115,9 @@ If you modify this value and your repository has a `fetch.bundleCreationToken`
 value, then remove that `fetch.bundleCreationToken` value before fetching from
 the new bundle URI.
 
-fetch.bundleCreationToken::
+`fetch.bundleCreationToken`::
 	When using `fetch.bundleURI` to fetch incrementally from a bundle
-	list that uses the "creationToken" heuristic, this config value
+	list that uses the "`creationToken`" heuristic, this config value
 	stores the maximum `creationToken` value of the downloaded bundles.
 	This value is used to prevent downloading bundles in the future
 	if the advertised `creationToken` is not strictly larger than this
diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
index ad1e1f49be..35a84a1ef2 100644
--- a/Documentation/fetch-options.adoc
+++ b/Documentation/fetch-options.adoc
@@ -1,41 +1,41 @@
---all::
---no-all::
+`--all`::
+`--no-all`::
 	Fetch all remotes, except for the ones that has the
 	`remote.<name>.skipFetchAll` configuration variable set.
 	This overrides the configuration variable `fetch.all`.
 
--a::
---append::
+`-a`::
+`--append`::
 	Append ref names and object names of fetched refs to the
 	existing contents of `.git/FETCH_HEAD`.  Without this
 	option old data in `.git/FETCH_HEAD` will be overwritten.
 
---atomic::
+`--atomic`::
 	Use an atomic transaction to update local refs. Either all refs are
 	updated, or on error, no refs are updated.
 
---depth=<depth>::
+`--depth=<depth>`::
 	Limit fetching to the specified number of commits from the tip of
 	each remote branch history. If fetching to a 'shallow' repository
 	created by `git clone` with `--depth=<depth>` option (see
 	linkgit:git-clone[1]), deepen or shorten the history to the specified
 	number of commits. Tags for the deepened commits are not fetched.
 
---deepen=<depth>::
-	Similar to --depth, except it specifies the number of commits
+`--deepen=<depth>`::
+	Similar to `--depth`, except it specifies the number of commits
 	from the current shallow boundary instead of from the tip of
 	each remote branch history.
 
---shallow-since=<date>::
+`--shallow-since=<date>`::
 	Deepen or shorten the history of a shallow repository to
-	include all reachable commits after <date>.
+	include all reachable commits after _<date>_.
 
---shallow-exclude=<ref>::
+`--shallow-exclude=<ref>`::
 	Deepen or shorten the history of a shallow repository to
 	exclude commits reachable from a specified remote branch or tag.
 	This option can be specified multiple times.
 
---unshallow::
+`--unshallow`::
 	If the source repository is complete, convert a shallow
 	repository to a complete one, removing all the limitations
 	imposed by shallow repositories.
@@ -43,13 +43,13 @@
 If the source repository is shallow, fetch as much as possible so that
 the current repository has the same history as the source repository.
 
---update-shallow::
+`--update-shallow`::
 	By default when fetching from a shallow repository,
 	`git fetch` refuses refs that require updating
-	.git/shallow. This option updates .git/shallow and accepts such
+	`.git/shallow`. This option updates `.git/shallow` and accepts such
 	refs.
 
---negotiation-tip=<commit|glob>::
+`--negotiation-tip=(<commit>|<glob>)`::
 	By default, Git will report, to the server, commits reachable
 	from all local refs to find common commits in an attempt to
 	reduce the size of the to-be-received packfile. If specified,
@@ -69,28 +69,28 @@ See also the `fetch.negotiationAlgorithm` and `push.negotiate`
 configuration variables documented in linkgit:git-config[1], and the
 `--negotiate-only` option below.
 
---negotiate-only::
+`--negotiate-only`::
 	Do not fetch anything from the server, and instead print the
 	ancestors of the provided `--negotiation-tip=*` arguments,
 	which we have in common with the server.
 +
-This is incompatible with `--recurse-submodules=[yes|on-demand]`.
+This is incompatible with `--recurse-submodules=(yes|on-demand)`.
 Internally this is used to implement the `push.negotiate` option, see
 linkgit:git-config[1].
 
---dry-run::
+`--dry-run`::
 	Show what would be done, without making any changes.
 
---porcelain::
+`--porcelain`::
 	Print the output to standard output in an easy-to-parse format for
 	scripts. See section OUTPUT in linkgit:git-fetch[1] for details.
 +
-This is incompatible with `--recurse-submodules=[yes|on-demand]` and takes
+This is incompatible with `--recurse-submodules=(yes|on-demand)` and takes
 precedence over the `fetch.output` config option.
 
 ifndef::git-pull[]
---write-fetch-head::
---no-write-fetch-head::
+`--write-fetch-head`::
+`--no-write-fetch-head`::
 	Write the list of remote refs fetched in the `FETCH_HEAD`
 	file directly under `$GIT_DIR`.  This is the default.
 	Passing `--no-write-fetch-head` from the command line tells
@@ -98,64 +98,65 @@ ifndef::git-pull[]
 	file is never written.
 endif::git-pull[]
 
--f::
---force::
-	When 'git fetch' is used with `<src>:<dst>` refspec, it may
-	refuse to update the local branch as discussed
+`-f`::
+`--force`::
 ifdef::git-pull[]
-	in the `<refspec>` part of the linkgit:git-fetch[1]
-	documentation.
+When `git fetch` is used with `<src>:<dst>` refspec, it may
+refuse to update the local branch as discussed
+in the _<refspec>_ part of the linkgit:git-fetch[1]
+documentation.
 endif::git-pull[]
 ifndef::git-pull[]
-	in the `<refspec>` part below.
+When `git fetch` is used with `<src>:<dst>` refspec, it may
+refuse to update the local branch as discussed in the _<refspec>_ part below.
 endif::git-pull[]
-	This option overrides that check.
+This option overrides that check.
 
--k::
---keep::
+`-k`::
+`--keep`::
 	Keep downloaded pack.
 
 ifndef::git-pull[]
---multiple::
-	Allow several <repository> and <group> arguments to be
-	specified. No <refspec>s may be specified.
-
---auto-maintenance::
---no-auto-maintenance::
---auto-gc::
---no-auto-gc::
+`--multiple`::
+	Allow several _<repository>_ and _<group>_ arguments to be
+	specified. No __<refspec>__s may be specified.
+
+`--auto-maintenance`::
+`--no-auto-maintenance`::
+`--auto-gc`::
+`--no-auto-gc`::
 	Run `git maintenance run --auto` at the end to perform automatic
 	repository maintenance if needed. (`--[no-]auto-gc` is a synonym.)
 	This is enabled by default.
 
---write-commit-graph::
---no-write-commit-graph::
+`--write-commit-graph`::
+`--no-write-commit-graph`::
 	Write a commit-graph after fetching. This overrides the config
 	setting `fetch.writeCommitGraph`.
 endif::git-pull[]
 
---prefetch::
+`--prefetch`::
 	Modify the configured refspec to place all refs into the
 	`refs/prefetch/` namespace. See the `prefetch` task in
 	linkgit:git-maintenance[1].
 
--p::
---prune::
+`-p`::
+`--prune`::
 	Before fetching, remove any remote-tracking references that no
 	longer exist on the remote.  Tags are not subject to pruning
 	if they are fetched only because of the default tag
-	auto-following or due to a --tags option.  However, if tags
+	auto-following or due to a `--tags` option.  However, if tags
 	are fetched due to an explicit refspec (either on the command
 	line or in the remote configuration, for example if the remote
-	was cloned with the --mirror option), then they are also
+	was cloned with the `--mirror` option), then they are also
 	subject to pruning. Supplying `--prune-tags` is a shorthand for
 	providing the tag refspec.
 ifndef::git-pull[]
 +
 See the PRUNING section below for more details.
 
--P::
---prune-tags::
+`-P`::
+`--prune-tags`::
 	Before fetching, remove any local tags that no longer exist on
 	the remote if `--prune` is enabled. This option should be used
 	more carefully, unlike `--prune` it will remove any local
@@ -168,17 +169,17 @@ See the PRUNING section below for more details.
 endif::git-pull[]
 
 ifndef::git-pull[]
--n::
+`-n`::
 endif::git-pull[]
---no-tags::
+`--no-tags`::
 	By default, tags that point at objects that are downloaded
 	from the remote repository are fetched and stored locally.
 	This option disables this automatic tag following. The default
-	behavior for a remote may be specified with the remote.<name>.tagOpt
+	behavior for a remote may be specified with the `remote.<name>.tagOpt`
 	setting. See linkgit:git-config[1].
 
 ifndef::git-pull[]
---refetch::
+`--refetch`::
 	Instead of negotiating with the server to avoid transferring commits and
 	associated objects that are already present locally, this option fetches
 	all objects as a fresh clone would. Use this to reapply a partial clone
@@ -187,19 +188,19 @@ ifndef::git-pull[]
 	object database pack consolidation to remove any duplicate objects.
 endif::git-pull[]
 
---refmap=<refspec>::
+`--refmap=<refspec>`::
 	When fetching refs listed on the command line, use the
 	specified refspec (can be given more than once) to map the
 	refs to remote-tracking branches, instead of the values of
-	`remote.*.fetch` configuration variables for the remote
+	`remote.<name>.fetch` configuration variables for the remote
 	repository.  Providing an empty `<refspec>` to the
 	`--refmap` option causes Git to ignore the configured
 	refspecs and rely entirely on the refspecs supplied as
 	command-line arguments. See section on "Configured Remote-tracking
 	Branches" for details.
 
--t::
---tags::
+`-t`::
+`--tags`::
 	Fetch all tags from the remote (i.e., fetch remote tags
 	`refs/tags/*` into local tags with the same name), in addition
 	to whatever else would otherwise be fetched.  Using this
@@ -208,8 +209,8 @@ endif::git-pull[]
 	destination of an explicit refspec; see `--prune`).
 
 ifndef::git-pull[]
---recurse-submodules[=(yes|on-demand|no)]::
-	This option controls if and under what conditions new commits of
+`--recurse-submodules[=(yes|on-demand|no)]`::
+	Control if and under what conditions new commits of
 	submodules should be fetched too. When recursing through submodules,
 	`git fetch` always attempts to fetch "changed" submodules, that is, a
 	submodule that has commits that are referenced by a newly fetched
@@ -219,19 +220,19 @@ ifndef::git-pull[]
 	adds a new submodule, that submodule cannot be fetched until it is
 	cloned e.g. by `git submodule update`.
 +
-When set to 'on-demand', only changed submodules are fetched. When set
-to 'yes', all populated submodules are fetched and submodules that are
-both unpopulated and changed are fetched. When set to 'no', submodules
+When set to `on-demand`, only changed submodules are fetched. When set
+to `yes`, all populated submodules are fetched and submodules that are
+both unpopulated and changed are fetched. When set to `no`, submodules
 are never fetched.
 +
 When unspecified, this uses the value of `fetch.recurseSubmodules` if it
-is set (see linkgit:git-config[1]), defaulting to 'on-demand' if unset.
-When this option is used without any value, it defaults to 'yes'.
+is set (see linkgit:git-config[1]), defaulting to `on-demand` if unset.
+When this option is used without any value, it defaults to `yes`.
 endif::git-pull[]
 
--j::
---jobs=<n>::
-	Number of parallel children to be used for all forms of fetching.
+`-j <n>`::
+`--jobs=<n>`::
+	Parallelize all forms of fetching up to _<n>_ jobs at a time.
 +
 If the `--multiple` option was specified, the different remotes will be fetched
 in parallel. If multiple submodules are fetched, they will be fetched in
@@ -242,12 +243,12 @@ Typically, parallel recursive and multi-remote fetches will be faster. By
 default fetches are performed sequentially, not in parallel.
 
 ifndef::git-pull[]
---no-recurse-submodules::
+`--no-recurse-submodules`::
 	Disable recursive fetching of submodules (this has the same effect as
 	using the `--recurse-submodules=no` option).
 endif::git-pull[]
 
---set-upstream::
+`--set-upstream`::
 	If the remote is fetched successfully, add upstream
 	(tracking) reference, used by argument-less
 	linkgit:git-pull[1] and other commands. For more information,
@@ -255,55 +256,55 @@ endif::git-pull[]
 	linkgit:git-config[1].
 
 ifndef::git-pull[]
---submodule-prefix=<path>::
-	Prepend <path> to paths printed in informative messages
+`--submodule-prefix=<path>`::
+	Prepend _<path>_ to paths printed in informative messages
 	such as "Fetching submodule foo".  This option is used
 	internally when recursing over submodules.
 
---recurse-submodules-default=[yes|on-demand]::
+`--recurse-submodules-default=(yes|on-demand)`::
 	This option is used internally to temporarily provide a
-	non-negative default value for the --recurse-submodules
+	non-negative default value for the `--recurse-submodules`
 	option.  All other methods of configuring fetch's submodule
 	recursion (such as settings in linkgit:gitmodules[5] and
 	linkgit:git-config[1]) override this option, as does
-	specifying --[no-]recurse-submodules directly.
+	specifying `--[no-]recurse-submodules` directly.
 
--u::
---update-head-ok::
-	By default 'git fetch' refuses to update the head which
+`-u`::
+`--update-head-ok`::
+	By default `git fetch` refuses to update the head which
 	corresponds to the current branch.  This flag disables the
-	check.  This is purely for the internal use for 'git pull'
-	to communicate with 'git fetch', and unless you are
+	check.  This is purely for the internal use for `git pull`
+	to communicate with `git fetch`, and unless you are
 	implementing your own Porcelain you are not supposed to
 	use it.
 endif::git-pull[]
 
---upload-pack <upload-pack>::
+`--upload-pack <upload-pack>`::
 	When given, and the repository to fetch from is handled
-	by 'git fetch-pack', `--exec=<upload-pack>` is passed to
+	by `git fetch-pack`, `--exec=<upload-pack>` is passed to
 	the command to specify non-default path for the command
 	run on the other end.
 
 ifndef::git-pull[]
--q::
---quiet::
-	Pass --quiet to git-fetch-pack and silence any other internally
+`-q`::
+`--quiet`::
+	Pass `--quiet` to `git-fetch-pack` and silence any other internally
 	used git commands. Progress is not reported to the standard error
 	stream.
 
--v::
---verbose::
+`-v`::
+`--verbose`::
 	Be verbose.
 endif::git-pull[]
 
---progress::
+`--progress`::
 	Progress status is reported on the standard error stream
-	by default when it is attached to a terminal, unless -q
+	by default when it is attached to a terminal, unless `-q`
 	is specified. This flag forces progress status even if the
 	standard error stream is not directed to a terminal.
 
--o <option>::
---server-option=<option>::
+`-o <option>`::
+`--server-option=<option>`::
 	Transmit the given string to the server when communicating using
 	protocol version 2.  The given string must not contain a NUL or LF
 	character.  The server's handling of server options, including
@@ -314,23 +315,23 @@ endif::git-pull[]
 	the values of configuration variable `remote.<name>.serverOption`
 	are used instead.
 
---show-forced-updates::
+`--show-forced-updates`::
 	By default, git checks if a branch is force-updated during
-	fetch. This can be disabled through fetch.showForcedUpdates, but
-	the --show-forced-updates option guarantees this check occurs.
+	fetch. This can be disabled through `fetch.showForcedUpdates`, but
+	the `--show-forced-updates` option guarantees this check occurs.
 	See linkgit:git-config[1].
 
---no-show-forced-updates::
+`--no-show-forced-updates`::
 	By default, git checks if a branch is force-updated during
-	fetch. Pass --no-show-forced-updates or set fetch.showForcedUpdates
+	fetch. Pass `--no-show-forced-updates` or set `fetch.showForcedUpdates`
 	to false to skip this check for performance reasons. If used during
-	'git-pull' the --ff-only option will still check for forced updates
+	`git-pull` the `--ff-only` option will still check for forced updates
 	before attempting a fast-forward update. See linkgit:git-config[1].
 
--4::
---ipv4::
+`-4`::
+`--ipv4`::
 	Use IPv4 addresses only, ignoring IPv6 addresses.
 
--6::
---ipv6::
+`-6`::
+`--ipv6`::
 	Use IPv6 addresses only, ignoring IPv4 addresses.
diff --git a/Documentation/git-fetch.adoc b/Documentation/git-fetch.adoc
index 16f5d9d69a..db03541915 100644
--- a/Documentation/git-fetch.adoc
+++ b/Documentation/git-fetch.adoc
@@ -8,11 +8,11 @@ git-fetch - Download objects and refs from another repository
 
 SYNOPSIS
 --------
-[verse]
-'git fetch' [<options>] [<repository> [<refspec>...]]
-'git fetch' [<options>] <group>
-'git fetch' --multiple [<options>] [(<repository> | <group>)...]
-'git fetch' --all [<options>]
+[synopsis]
+git fetch [<options>] [<repository> [<refspec>...]]
+git fetch [<options>] <group>
+git fetch --multiple [<options>] [(<repository>|<group>)...]
+git fetch --all [<options>]
 
 
 DESCRIPTION
@@ -20,19 +20,19 @@ DESCRIPTION
 Fetch branches and/or tags (collectively, "refs") from one or more
 other repositories, along with the objects necessary to complete their
 histories.  Remote-tracking branches are updated (see the description
-of <refspec> below for ways to control this behavior).
+of _<refspec>_ below for ways to control this behavior).
 
 By default, any tag that points into the histories being fetched is
 also fetched; the effect is to fetch tags that
 point at branches that you are interested in.  This default behavior
-can be changed by using the --tags or --no-tags options or by
-configuring remote.<name>.tagOpt.  By using a refspec that fetches tags
+can be changed by using the `--tags` or `--no-tags` options or by
+configuring `remote.<name>.tagOpt`.  By using a refspec that fetches tags
 explicitly, you can fetch tags that do not point into branches you
 are interested in as well.
 
-'git fetch' can fetch from either a single named repository or URL,
-or from several repositories at once if <group> is given and
-there is a remotes.<group> entry in the configuration file.
+`git fetch` can fetch from either a single named repository or URL,
+or from several repositories at once if _<group>_ is given and
+there is a `remotes.<group>` entry in the configuration file.
 (See linkgit:git-config[1]).
 
 When no remote is specified, by default the `origin` remote will be used,
@@ -48,15 +48,15 @@ include::fetch-options.adoc[]
 
 include::pull-fetch-param.adoc[]
 
---stdin::
+`--stdin`::
 	Read refspecs, one per line, from stdin in addition to those provided
-	as arguments. The "tag <name>" format is not supported.
+	as arguments. The "tag _<name>_" format is not supported.
 
 include::urls-remotes.adoc[]
 
-
-CONFIGURED REMOTE-TRACKING BRANCHES[[CRTB]]
--------------------------------------------
+[[CRTB]]
+CONFIGURED REMOTE-TRACKING BRANCHES
+-----------------------------------
 
 You often interact with the same remote repository by
 regularly and repeatedly fetching from it.  In order to keep track
@@ -84,13 +84,13 @@ This configuration is used in two ways:
 
 * When `git fetch` is run with explicit branches and/or tags
   to fetch on the command line, e.g. `git fetch origin master`, the
-  <refspec>s given on the command line determine what are to be
+  _<refspec>s_ given on the command line determine what are to be
   fetched (e.g. `master` in the example,
   which is a short-hand for `master:`, which in turn means
-  "fetch the 'master' branch but I do not explicitly say what
+  "fetch the `master` branch but I do not explicitly say what
   remote-tracking branch to update with it from the command line"),
   and the example command will
-  fetch _only_ the 'master' branch.  The `remote.<repository>.fetch`
+  fetch _only_ the `master` branch.  The `remote.<repository>.fetch`
   values determine which
   remote-tracking branch, if any, is updated.  When used in this
   way, the `remote.<repository>.fetch` values do not have any
@@ -144,9 +144,9 @@ tracking branches that are deleted, but any local tag that doesn't
 exist on the remote.
 
 This might not be what you expect, i.e. you want to prune remote
-`<name>`, but also explicitly fetch tags from it, so when you fetch
+_<name>_, but also explicitly fetch tags from it, so when you fetch
 from it you delete all your local tags, most of which may not have
-come from the `<name>` remote in the first place.
+come from the _<name>_ remote in the first place.
 
 So be careful when using this with a refspec like
 `refs/tags/*:refs/tags/*`, or any other refspec which might map
@@ -213,11 +213,11 @@ of the form:
 <flag> <old-object-id> <new-object-id> <local-reference>
 -------------------------------
 
-The status of up-to-date refs is shown only if the --verbose option is
+The status of up-to-date refs is shown only if the `--verbose` option is
 used.
 
 In compact output mode, specified with configuration variable
-fetch.output, if either entire `<from>` or `<to>` is found in the
+fetch.output, if either entire _<from>_ or _<to>_ is found in the
 other string, it will be substituted with `*` in the other string. For
 example, `master -> origin/master` becomes `master -> origin/*`.
 
@@ -303,7 +303,7 @@ include::config/fetch.adoc[]
 
 BUGS
 ----
-Using --recurse-submodules can only fetch new commits in submodules that are
+Using `--recurse-submodules` can only fetch new commits in submodules that are
 present locally e.g. in `$GIT_DIR/modules/`. If the upstream adds a new
 submodule, that submodule cannot be fetched until it is cloned e.g. by `git
 submodule update`. This is expected to be fixed in a future Git version.
diff --git a/Documentation/pull-fetch-param.adoc b/Documentation/pull-fetch-param.adoc
index bb2cf6a462..d903dc8900 100644
--- a/Documentation/pull-fetch-param.adoc
+++ b/Documentation/pull-fetch-param.adoc
@@ -1,20 +1,20 @@
-<repository>::
+_<repository>_::
 	The "remote" repository that is the source of a fetch
 	or pull operation.  This parameter can be either a URL
 	(see the section <<URLS,GIT URLS>> below) or the name
 	of a remote (see the section <<REMOTES,REMOTES>> below).
 
 ifndef::git-pull[]
-<group>::
+_<group>_::
 	A name referring to a list of repositories as the value
-	of remotes.<group> in the configuration file.
+	of `remotes.<group>` in the configuration file.
 	(See linkgit:git-config[1]).
 endif::git-pull[]
 
 [[fetch-refspec]]
-<refspec>::
+_<refspec>_::
 	Specifies which refs to fetch and which local refs to update.
-	When no <refspec>s appear on the command line, the refs to fetch
+	When no __<refspec>__s appear on the command line, the refs to fetch
 	are read from `remote.<repository>.fetch` variables instead
 ifndef::git-pull[]
 	(see <<CRTB,CONFIGURED REMOTE-TRACKING BRANCHES>> below).
@@ -24,18 +24,18 @@ ifdef::git-pull[]
 	in linkgit:git-fetch[1]).
 endif::git-pull[]
 +
-The format of a <refspec> parameter is an optional plus
-`+`, followed by the source <src>, followed
-by a colon `:`, followed by the destination <dst>.
-The colon can be omitted when <dst> is empty.  <src> is
+The format of a _<refspec>_ parameter is an optional plus
+`+`, followed by the source _<src>_, followed
+by a colon `:`, followed by the destination _<dst>_.
+The colon can be omitted when _<dst>_ is empty.  _<src>_ is
 typically a ref, or a glob pattern with a single `*` that is used
 to match a set of refs, but it can also be a fully spelled hex object
 name.
 +
-A <refspec> may contain a `*` in its <src> to indicate a simple pattern
+A _<refspec>_ may contain a `*` in its _<src>_ to indicate a simple pattern
 match. Such a refspec functions like a glob that matches any ref with the
-pattern. A pattern <refspec> must have one and only one `*` in both the <src> and
-<dst>. It will map refs to the destination by replacing the `*` with the
+pattern. A pattern _<refspec>_ must have one and only one `*` in both the _<src>_ and
+_<dst>_. It will map refs to the destination by replacing the `*` with the
 contents matched from the source.
 +
 If a refspec is prefixed by `^`, it will be interpreted as a negative
@@ -45,14 +45,14 @@ considered to match if it matches at least one positive refspec, and does
 not match any negative refspec. Negative refspecs can be useful to restrict
 the scope of a pattern refspec so that it will not include specific refs.
 Negative refspecs can themselves be pattern refspecs. However, they may only
-contain a <src> and do not specify a <dst>. Fully spelled out hex object
+contain a _<src>_ and do not specify a _<dst>_. Fully spelled out hex object
 names are also not supported.
 +
 `tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`;
 it requests fetching everything up to the given tag.
 +
-The remote ref that matches <src>
-is fetched, and if <dst> is not an empty string, an attempt
+The remote ref that matches _<src>_
+is fetched, and if _<dst>_ is not an empty string, an attempt
 is made to update the local ref that matches it.
 +
 Whether that update is allowed without `--force` depends on the ref
@@ -60,7 +60,7 @@ namespace it's being fetched to, the type of object being fetched, and
 whether the update is considered to be a fast-forward. Generally, the
 same rules apply for fetching as when pushing, see the `<refspec>...`
 section of linkgit:git-push[1] for what those are. Exceptions to those
-rules particular to 'git fetch' are noted below.
+rules particular to `git fetch` are noted below.
 +
 Until Git version 2.20, and unlike when pushing with
 linkgit:git-push[1], any updates to `refs/tags/*` would be accepted
@@ -101,19 +101,19 @@ must know this is the expected usage pattern for a branch.
 ifdef::git-pull[]
 +
 [NOTE]
-There is a difference between listing multiple <refspec>
-directly on 'git pull' command line and having multiple
+There is a difference between listing multiple _<refspec>_
+directly on `git pull` command line and having multiple
 `remote.<repository>.fetch` entries in your configuration
-for a <repository> and running a
-'git pull' command without any explicit <refspec> parameters.
-<refspec>s listed explicitly on the command line are always
+for a _<repository>_ and running a
+`git pull` command without any explicit _<refspec>_ parameters.
+__<refspec>__s listed explicitly on the command line are always
 merged into the current branch after fetching.  In other words,
-if you list more than one remote ref, 'git pull' will create
+if you list more than one remote ref, `git pull` will create
 an Octopus merge.  On the other hand, if you do not list any
-explicit <refspec> parameter on the command line, 'git pull'
-will fetch all the <refspec>s it finds in the
+explicit _<refspec>_ parameter on the command line, `git pull`
+will fetch all the __<refspec>__s it finds in the
 `remote.<repository>.fetch` configuration and merge
-only the first <refspec> found into the current branch.
+only the first _<refspec>_ found into the current branch.
 This is because making an
 Octopus from remote refs is rarely done, while keeping track
 of multiple remote heads in one-go by fetching more than one
diff --git a/Documentation/urls-remotes.adoc b/Documentation/urls-remotes.adoc
index 57b1646d3e..068b3ee4a6 100644
--- a/Documentation/urls-remotes.adoc
+++ b/Documentation/urls-remotes.adoc
@@ -4,7 +4,7 @@ REMOTES[[REMOTES]]
 ------------------
 
 The name of one of the following can be used instead
-of a URL as `<repository>` argument:
+of a URL as _<repository>_ argument:
 
 * a remote in the Git configuration file: `$GIT_DIR/config`,
 * a file in the `$GIT_DIR/remotes` directory, or
@@ -32,8 +32,8 @@ config file would appear like this:
 		fetch = <refspec>
 ------------
 
-The `<pushurl>` is used for pushes only. It is optional and defaults
-to `<URL>`. Pushing to a remote affects all defined pushurls or all
+The _<pushurl>_ is used for pushes only. It is optional and defaults
+to _<URL>_. Pushing to a remote affects all defined pushurls or all
 defined urls if no pushurls are defined. Fetch, however, will only
 fetch from the first defined url if multiple urls are defined.
 
@@ -54,8 +54,8 @@ following format:
 
 ------------
 
-`Push:` lines are used by 'git push' and
-`Pull:` lines are used by 'git pull' and 'git fetch'.
+`Push:` lines are used by `git push` and
+`Pull:` lines are used by `git pull` and `git fetch`.
 Multiple `Push:` and `Pull:` lines may
 be specified for additional branch mappings.
 
@@ -72,12 +72,12 @@ This file should have the following format:
 	<URL>#<head>
 ------------
 
-`<URL>` is required; `#<head>` is optional.
+_<URL>_ is required; `#<head>` is optional.
 
 Depending on the operation, git will use one of the following
 refspecs, if you don't provide one on the command line.
-`<branch>` is the name of this file in `$GIT_DIR/branches` and
-`<head>` defaults to `master`.
+_<branch> is the name of this file in `$GIT_DIR/branches` and
+_<head>_ defaults to `master`.
 
 git fetch uses:
 
diff --git a/builtin/fetch.c b/builtin/fetch.c
index c7ff3480fb..74b62b1315 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -47,7 +47,7 @@
 static const char * const builtin_fetch_usage[] = {
 	N_("git fetch [<options>] [<repository> [<refspec>...]]"),
 	N_("git fetch [<options>] <group>"),
-	N_("git fetch --multiple [<options>] [(<repository> | <group>)...]"),
+	N_("git fetch --multiple [<options>] [(<repository>|<group>)...]"),
 	N_("git fetch --all [<options>]"),
 	NULL
 };
-- 
gitgitgadget

