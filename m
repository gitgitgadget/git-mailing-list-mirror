Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0927D582BAE
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 16:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788885719; cv=none; b=fmYPqECGjujFmLTx6jATQBVDejt/ceCw4JpzNvBompgtZnizteT9YHQJy0BJHgLZcv9UpKDvkM/tN/ILdmjRcWDxZNo34we1gXyjOmBIevh0BnB5P0JSKeuxiNKqInGhwxEQVok66av5JlGnTMT0W5cWvxAfruThFE6+WEurm8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788885719; c=relaxed/simple;
	bh=gn1D24o9kigtUM/6bnfnhawh1tQgybVNaP0YU9UviUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qm7zDIxCuYfewOQO43rKQN+ZeUH6OMBWmc4koRsB/bqOUmq3oQA6M06LBNStfezqCzKp3365M0pzGkGm4TaI2fZXZFYFLgLgzUTd++qr9U6UnzlhJFd3axYiZfc4tPHk7uQTUVZ7WxZ1oFC9L3iJFE1UM42ocdMy50hfgvU/hqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r6A/6lAE; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r6A/6lAE"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48441a2ba1bso3509640f8f.1
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 09:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788885715; x=1789490515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=70x/wyP6MDJHz9lNMzF7sxQ1PA0NzUmL12+tlJvp0i4=;
        b=r6A/6lAE1d84w2ZQRSxyUGv39Hj8UsoXKp5dr1gE5zl63lAt9L2vgAC3798uOxtmQN
         pFP3uxyyxl+35WHiqbTJxp8QIZqmXLjj9zPSaxuOprCrE89sdvEhGyg/oLjnFsEVKLhL
         0TJWVKeaazFgK7YJ4HIKPPLdhC7jvWOKXp277Y9mJkgOBk54MaLH0A4qtwjeqZ+ePjrj
         09/DpS7FtHw5y9/CznqyuFcf+3vXG/dpyg3Zqzbwqeug+tYfKB6mnnVKQ/5avieeYmSn
         Xu+n+/YtU4Fo5GJmXxVhoLo8fr0NdLhTpDfLHQE+xJ8B6JqyifEYYvrAa27VdYV4Zs+q
         yFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788885715; x=1789490515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=70x/wyP6MDJHz9lNMzF7sxQ1PA0NzUmL12+tlJvp0i4=;
        b=kIugUx6SUxqtQzOH1fwp2LIuVA9biBYrtSSEHCjXzJPsVDh6xORhY5FpmTX7U6OdyX
         jkc99NIQXUNMUZKgN7gQ6Be+OA1iUyMovnT27r14E+Lqsxx3FTQ+j4XOxEygKLDk7UsP
         HXpjhvlE+SfQDgTxUYTYULRqPClzpm8n2HpQcD+LBSplI7ieDUhLdmMpr1VXrTXZ9pvK
         K/z/zw33bmrPO91WJ/DoMhXaVqMXuIGT2APOZzsKbeLKrIJ6YQ2tpXIRbZplVZ2f5Hta
         PakbrlDHS/ArEV0XaaksEOsJA+dj9+8H19ILmPihvni+jDF8Kpzo0NoOP8s9Z7sS6Tyb
         Z11Q==
X-Gm-Message-State: AFuF++nN84HV4mMNDBsh9zbiEIf5XXlqjr+oHmb3eHUqLE1alKOKNWdJ
	Inya4BARhvSblPU24vxlKt4ta85Zn8vhJo6qGRFkTBfPem4h2v0dwpih0fA1QToK
X-Gm-Gg: AYBFou3PCfcist2VGI8zJ2ZrXw/MSeewnNNqpG0VHR2TNUvE/f4VYZJinrVffDRWA+A
	38umqRpjpw/nBbuNSPo50wzyuc/1kv2JTl+vmrELjY/Ga/MXn8RaljZzUuNk85dnjcb+qffYYOx
	KBz/9facp267Xv6mXLX/iEmIruVzSV+WzHtXjwlQA67PwI2kyhQPeuqMnQMr06p4B39Pjwz+7Bj
	TNijRN47+SHzw1OfPRoP85S177szCuo4dyBjqLP6Mfx0FmjLVszbyyAQaUXXW7dmISH9lCBZjxg
	5+Vt8wkgCuGHtVs4ugVgojqT5vpMMP/Q51y/ZhG6HPkNRJt1rdnnG9AVPgK4JTlldYqE8eQLK5Q
	jj3w5al6pUhz51nosh9U5VeJfR0LY4DkekQNb65PgjmhIRKxg56iFr6fGBZaUljs3M6dSRzHZX8
	/qzVkv7a93ka/MWcNlJmnkwJNssFjFbcMUGZJmQ/b1r7B2XLcTF8qHw17m8yarIhKTTc5IanjEh
	SkC82Vg+dhOlIVP2N61ErZF+T5eblkXM28Ep3T9pNbjFZVCrbDbDhkZEwqJ5ln03NwyKEv9obU5
	KtTkefBmpl7D1gj2gCzsvxhnaS+E2PxiQiPgnN4TTuC+4YAt0wJOadYBlOt+hvo9QpSljvdPylU
	=
X-Received: by 2002:a5d:5d0b:0:b0:485:8c16:a35f with SMTP id ffacd0b85a97d-4858c16a76emr28971098f8f.55.1788885714717;
        Tue, 08 Sep 2026 09:41:54 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48591eb3d3bsm24081689f8f.0.2026.09.08.09.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 09:41:53 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 0/5] Introduce 'uploadpack.lazyFetchTrusted'
Date: Tue,  8 Sep 2026 18:41:24 +0200
Message-ID: <20260908164129.560396-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.792.ged91fccac1.dirty
In-Reply-To: <20260813154748.2378747-1-christian.couder@gmail.com>
References: <20260813154748.2378747-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recently the "promisor-remote" capability was added to protocol v2,
allowing servers and clients to agree on the promisor remotes they can
safely use.

The more servers use promisor remotes, the more it is important to
properly control if they can lazy fetch when responding to a clone or
fetch request from the client.

For example, in the context of large object promisors (see
"Documentation/technical/large-object-promisors.adoc"), if a client
clones with a filter set to 100kB while the server has moved all of
the blobs >= 10kB to a promisor remote, the server will not be able to
provide blobs between 10kB and 100kB to the client, which will make
the clone fail.

Even if the `--filter=auto` option is available since ef2f1845ec
(fetch-pack: wire up and enable auto filter logic, 2026-02-16) it's
still a good idea to provide more control over lazy fetching on the
server side to server operators, as lazy fetching on the server side
could be useful in corporate environments.

Since 7b70e9efb1 (upload-pack: disable lazy-fetching by default,
2024-04-16), lazy fetching has been controlled by the
`GIT_NO_LAZY_FETCH` environment variable. This is a boolean that is
set to 'true' by default when calling `git upload-pack` for security
reasons.

The main security issue on the server side is making sure the served
repo itself is also trusted, as lazily fetching runs `git fetch`,
which may execute arbitrary commands specified in the configuration
and hooks of the served repo. The operator of the server should decide
and mark that trust, not the served repo itself, nor the client.

This series introduces a new 'uploadpack.lazyFetchTrusted' protected
configuration variable similar to 'safe.directory' (see
"Documentation/config/safe.adoc") to mark trusted repos where lazy
fetching is allowed. As it is protected, this config variable will
only take effect if it is set in global or system scope, so only
server operators can control it.

Previous related work
=====================

A previous series called "Introduce a 'fromAccepted' option to
GIT_NO_LAZY_FETCH" [1] took a different approach as it wanted to make
it easier to allow lazy fetching from accepted promisor remotes. But
after brian replied that he didn't think it was a good idea, and after
thinking about this more, my opinion now is that some promisor remotes
being accepted or not is not really relevant to the issue.

In my reply to brian, I said:

"""
Different features could be developed (in future work) to improve on
the current state:
    - a way for lazy fetching to work without reading config files,
triggering hooks, or doing potentially sensitive things,
    - an explicit way for operators to mark trusted repos (like
perhaps a server-side config the operator sets per-repo),
    - operator-defined allow/deny rules, or maybe
    - some ways/scripts/commands to scan repos and check configuration
information, remote settings and everything potentially sensitive to
decide if a repo looks safe enough to allow lazy fetching or not.
"""

So I decided to go with "an explicit way for operators to mark trusted
repos" and this series is an implementation of that.

Note that the feature developed in this series applies to protocol
v0/v1 as well as v2 while the previous one was only related to v2.

[1]: https://lore.kernel.org/git/CAP8UFD0_S9eg_w42tcNRnT9E2ntLr_eHLnzE4c2dSu67DzZoXg@mail.gmail.com/

Overview of the patches
=======================

  - Patch 1/5 is the only patch saved from the "Introduce a
    'fromAccepted' option to GIT_NO_LAZY_FETCH" series. It's not
    necessary for the rest of this series and its main feature to
    work, but I think it's a nice refactoring related to lazy
    fetching, so it might as well be part of this series. There is a
    small change in the commit message (to not mention following
    commits) compared to the version in the previous series.

  - Patch 2/5 extracts and modifies code used by the 'safe.directory'
    config variable in new path_allowlist_config_apply() and
    path_allowlist_apply() functions, so that these functions can be
    reused to process 'uploadpack.lazyFetchTrusted' in the next patch.

  - Patch 3/5 uses the new functions from the previous patch in a new
    upload_pack_lazy_fetch_trusted() function to process
    'uploadpack.lazyFetchTrusted', but the result from that processing
    isn't actually used to have a practical effect.

  - Patch 4/5, which is new in this v3, prevents infinite lazy fetch
    recursions that the following patch would otherwise make possible.
    If a repo is allowed to lazy fetch and one of its promisor remotes
    resolves back to it, for example if it is its own promisor remote
    as Junio noticed when reviewing v2, each nested `upload-pack`
    inherits `GIT_NO_LAZY_FETCH=0` and fetches again.

  - Patch 5/5 wires up the new upload_pack_lazy_fetch_trusted()
    function to decide if lazy fetching can actually be enabled.

Changes since v2
================

Thanks to Junio for reviewing the previous version.

Rebased on top of 3cb9185f65 (The 22nd batch, 2026-09-02) as the
previous version was based on a quite old commit: 745601a9a9 (mailmap:
map Elijah Newren's current and previous work addresses, 2026-08-12)
and I wanted to avoid possible merge issues.

 - Patch 1/5 has a small simplification in how try_promisor_remotes()
   is called first with its last argument set to 'true', and then with
   it set to 'false'. Both calls are now chained with `||`.

 - Patches 2/5 and 3/5 have been squashed together and reworked
   completely into the new patch 2/5, especially:

   - path_allowlist_apply() now has a
     `bool (*allow_path)(const char *path, void *cbdata)` argument so
     that callers can customize which paths they accept.

   - A new path_allowlist_config_apply() wrapper around
     path_allowlist_apply() has been added to avoid code duplication
     in the callers.

   - The `int *is_match` argument of path_allowlist_apply() has been
     changed to `bool *matches` and `int is_safe` in
     `struct safe_directory_data` has been changed to `bool safe`
     accordingly.

 - Patch 3/5 (previously 4/5) has a number of changes:

   - Its commit message has been improved and adapted to the 2 other
     big changes below.

   - It defines its own allow_trusted_path() function to customize the
     paths it accepts and pass that new function to the new functions
     from the previous commit that it uses.

   - The code and commit message have been changed so that a served
     repository is identified only by its git dir. We wrongly used to
     say that it could also be identified by its worktree, but
     `upload-pack` actually uses enter_repo(), so it doesn't know
     about worktrees.

   - `int trusted` has been changed to `bool trusted` and moved after
     the other field in `struct lazy_fetch_trusted`. This matches the
     changes to `bool *matches` and `bool safe` in the "setup.c" code.

 - Patch 4/5 is new and prevents infinite lazy fetch recursions, using
   a new `GIT_INTERNAL_LAZY_FETCH_DEPTH` environment variable to limit
   the nesting depth. See the patch 4/5 description above.

 - Patch 5/5 has a few changes:

   - The `uploadpack.lazyFetchTrusted` doc has been clarified, typo
     fixed, reorganized, and completed with information related to the
     changes in this v3, especially:
       - the fact that repos are identified by their git dir, and
       - that configuring a repo as its own remote is not a good idea.

   - Two tests have been added to make sure
     `uploadpack.lazyFetchTrusted` doesn't make infinite lazy fetch
     recursion possible, and to show that repos are identified by
     their git dir, and cannot be identified by a worktree.

CI tests
========

They all pass except for the "debian-11" one which keeps failing at
the "install git in container" step with the following error:

```
E: Release file for http://deb.debian.org/debian-security/dists/bullseye-security/InRelease
is expired (invalid since 18h 34min 49s). Updates for this repository will not be applied.
Error: Process completed with exit code 100.
```

so it is very likely unrelated to this series.

See: https://github.com/chriscool/git/actions/runs/34232995230

Range-diff compared to v2
=========================

1:  1605740203 ! 1:  9403597855 promisor-remote: factor out lazy_fetch_objects()
    @@ promisor-remote.c: static int try_promisor_remotes(struct repository *repo,
     +	promisor_remote_init(repo);
     +
     +	/* Try accepted remotes first (those the server told us to use) */
    -+	if (try_promisor_remotes(repo, remaining_oids, remaining_nr,
    -+				 to_free, true))
    -+		return true;
    -+
     +	return try_promisor_remotes(repo, remaining_oids, remaining_nr,
    -+				    to_free, false);
    ++				    to_free, true) ||
    ++		try_promisor_remotes(repo, remaining_oids, remaining_nr,
    ++				     to_free, false);
      }
      
      void promisor_remote_get_direct(struct repository *repo,
2:  5f226b6508 < -:  ---------- setup: extract path_allowlist_apply()
3:  051aa11fc9 < -:  ---------- setup: add 'allow_dot' arg to path_allowlist_apply()
-:  ---------- > 2:  2155c4202d setup: extract path_allowlist_apply()
4:  045b5e647b ! 3:  37043ffeaf upload-pack: read uploadpack.lazyFetchTrusted
    @@ Commit message
         upload-pack: read uploadpack.lazyFetchTrusted
     
         Previous commits created and prepared the path_allowlist_apply()
    -    function.
    +    and path_allowlist_config_apply() functions, but used them only for the
    +    "safe.directory" configuration variable.
     
    -    Let's reuse this function for a new "uploadpack.lazyFetchTrusted"
    +    Let's reuse these functions for a new "uploadpack.lazyFetchTrusted"
         configuration variable.
     
         It allows us to:
    @@ Commit message
           - return the result from a new upload_pack_lazy_fetch_trusted()
             function.
     
    -    The new function will be used in a following commit.
    +    As path_allowlist_config_apply() lets each caller decide which paths
    +    it is willing to accept using a callback, let's pass it a new
    +    allow_trusted_path() callback. Unlike the "safe.directory" callback, it
    +    accepts only absolute paths, and not ".", as `upload-pack` always
    +    serves a repository given by an absolute path, so there is no "current
    +    repository" for "." to refer to.
    +
    +    Note that a served repository is identified by its git directory, and
    +    not by its worktree. This is because `upload-pack` uses enter_repo()
    +    instead of the usual repository discovery, so it never learns about a
    +    worktree and `r->worktree` is always NULL there. In practice this
    +    means that a non-bare repository served as "/srv/repo" has to be
    +    allowlisted as "/srv/repo/.git".
    +
    +    The new upload_pack_lazy_fetch_trusted() function will be used in a
    +    following commit.
     
         Note that the new config variable should be read only from protected
         configuration files.
    @@ upload-pack.c: static int upload_pack_config(const char *var, const char *value,
      	return parse_hide_refs_config(var, value, "uploadpack", &data->hidden_refs);
      }
      
    ++/*
    ++ * Only absolute paths make sense here. Unlike 'safe.directory', "."
    ++ * is not accepted, as the served repository is always identified by
    ++ * an absolute path.
    ++ */
    ++static bool allow_trusted_path(const char *path, void *cbdata_)
    ++{
    ++	struct path_allowlist_cb_data *cbdata = cbdata_;
    ++
    ++	if (is_absolute_path(path))
    ++		return true;
    ++
    ++	warning(_("%s '%s' not absolute"), cbdata->key, path);
    ++	return false;
    ++}
    ++
     +struct lazy_fetch_trusted {
    -+	int trusted;
     +	char *repo_path;
    ++	bool trusted;
     +};
     +
     +static int upload_pack_protected_lazy_fetch_config(const char *var, const char *value,
    @@ upload-pack.c: static int upload_pack_config(const char *var, const char *value,
     +						   void *cb_data)
     +{
     +	struct lazy_fetch_trusted *data = cb_data;
    ++	struct path_allowlist_cb_data cbdata = { .key = var };
     +
    -+	if (!strcmp("uploadpack.lazyfetchtrusted", var)) {
    -+		path_allowlist_apply(var, value, data->repo_path,
    -+				     &data->trusted, false);
    ++	if (strcmp("uploadpack.lazyfetchtrusted", var))
     +		return 0;
    -+	}
    ++
    ++	path_allowlist_config_apply(var, value, data->repo_path, &data->trusted,
    ++				    allow_trusted_path, &cbdata);
     +
     +	return 0;
     +}
    @@ upload-pack.c: static int upload_pack_config(const char *var, const char *value,
     +{
     +	struct lazy_fetch_trusted data = { 0 };
     +
    -+	data.repo_path = real_pathdup(r->worktree ? r->worktree : r->gitdir, 0);
    ++	/*
    ++	 * A served repository is identified by its git directory, as
    ++	 * `upload-pack` uses enter_repo() instead of the usual repository
    ++	 * discovery, so its worktree, if any, is never known here.
    ++	 */
    ++	data.repo_path = real_pathdup(r->gitdir, 0);
     +	if (!data.repo_path)
     +		return false;
     +
-:  ---------- > 4:  38fc060999 promisor-remote: prevent infinite recursion when lazy fetching
5:  c116661202 ! 5:  8cb97230e5 builtin/upload-pack: set GIT_NO_LAZY_FETCH to 0 on trusted repo
    @@ Documentation/config/uploadpack.adoc: uploadpack.allowRefInWant::
      	replication delay.
     +
     +uploadpack.lazyFetchTrusted::
    -+	These config entries specify repositories that `upload-pack` is
    -+	allowed to lazily fetch missing objects for. By default,
    -+	`upload-pack` refuses to lazily fetch (see the description of the
    -+	`GIT_NO_LAZY_FETCH` environment variable in
    -+	linkgit:git-upload-pack[1]), because doing so would run `git fetch`,
    -+	which may execute arbitrary commands specified in the configuration
    -+	and hooks of the served repository. Listing a repository here tells
    -+	`upload-pack` that it is trusted, so lazy fetching from the promisor
    -+	remotes configured in it is allowed. This is equivalent to setting
    -+	`GIT_NO_LAZY_FETCH` to `0` for the matching repositories. An
    -+	explicitly set `GIT_NO_LAZY_FETCH` takes precedence over this
    -+	setting.
    ++	A multi-valued configuration variable, each of which contains the
    ++	absolute local path of a repository that `upload-pack` is allowed to
    ++	lazily fetch missing objects for.
    +++
    ++A repository is identified by its git directory, i.e. the `.git`
    ++directory of a repository that has a worktree, or the repository itself
    ++if it is bare. So a non-bare repository served as `/srv/repo` has to be
    ++allowlisted as `/srv/repo/.git`. Giving a path with `/*` appended to it
    ++will trust all repositories under the named directory. To trust all
    ++served repositories, set `uploadpack.lazyFetchTrusted` to the string
    ++`*`.
    +++
    ++The value of this setting is interpolated, i.e. `~/<path>` expands to a
    ++path relative to the home directory and `%(prefix)/<path>` expands to a
    ++path relative to Git's (runtime) prefix.
    +++
    ++By default, `upload-pack` refuses to lazily fetch (see the description
    ++of the `GIT_NO_LAZY_FETCH` environment variable in
    ++linkgit:git-upload-pack[1]), because doing so would run `git fetch`,
    ++which may execute arbitrary commands specified in the configuration
    ++and hooks of the served repository. Listing a repository here tells
    ++`upload-pack` that it is trusted, so lazy fetching from the promisor
    ++remotes configured in it is allowed. This is equivalent to setting
    ++`GIT_NO_LAZY_FETCH` to `0` for the matching repositories. An
    ++explicitly set `GIT_NO_LAZY_FETCH` takes precedence over this setting.
     ++
     +Note that this allows lazy fetching from any promisor remote
     +configured in the served repository, not only from the promisor
    @@ Documentation/config/uploadpack.adoc: uploadpack.allowRefInWant::
     +is trusted as a whole, including its configuration, so the promisor
     +remotes it configures are trusted too. It is the server operator's
     +responsibility to make sure that the promisor remotes of a trusted
    -+repository are also trustworthy.
    ++repository are also trustworthy. In particular, a trusted repository
    ++should not be configured as its own promisor remote, as `upload-pack`
    ++would then try to lazily fetch missing objects from the repository
    ++itself, which is pointless.
     ++
    -+This is a multi-valued setting, i.e. you can add more than one
    ++As this is a multi-valued setting, you can add more than one
     +repository via `git config (--global|--system) --add`. To reset the
     +list of trusted repositories (e.g. to override any such repositories
    -+specified in the system config), add a `uploadpack.lazyFetchTrusted`
    ++specified in the system config), add an `uploadpack.lazyFetchTrusted`
     +entry with an empty value.
     ++
    -+A repository is identified by its worktree, or its git directory for a bare
    -+repository, and the value must be an absolute path. Giving a path with `/*`
    -+appended to it will trust all repositories under the named directory. To trust
    -+all served repositories, set `uploadpack.lazyFetchTrusted` to the string `*`.
    -++
    -+The value of this setting is interpolated, i.e. `~/<path>` expands to a
    -+path relative to the home directory and `%(prefix)/<path>` expands to a
    -+path relative to Git's (runtime) prefix.
    -++
    -+Note that this configuration variable is only respected when it is specified
    -+in protected configuration (see <<SCOPES>>). This prevents untrusted
    -+repositories from tampering with this value.
    ++Note that this configuration variable is only respected when it is
    ++specified in protected configuration (see <<SCOPES>>). This prevents
    ++untrusted repositories from tampering with this value.
     
      ## Documentation/git-upload-pack.adoc ##
     @@ Documentation/git-upload-pack.adoc: This is implemented by having `upload-pack` internally set the
    @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone with promisor.
     +	# Check that the largest object is still missing on the server
     +	check_missing_objects server 1 "$oid"
     +'
    ++
    ++test_expect_success "trusted repo as its own promisor remote does not recurse" '
    ++	# No promisors are advertised
    ++	git -C server config promisor.advertise false &&
    ++	test_when_finished "rm -rf client" &&
    ++
    ++	# Add itself as its own remote
    ++	git -C server remote add self "$TRASH_DIRECTORY_URL/server" &&
    ++	git -C server config remote.self.promisor true &&
    ++	test_when_finished "git -C server remote remove self" &&
    ++
    ++	# Make "self" the only promisor remote of the server, so that it
    ++	# cannot get the missing object from "lop". Note that
    ++	# "remote.lop.partialCloneFilter" also makes "lop" a promisor
    ++	# remote, so it has to be unset too.
    ++	git -C server config --unset remote.lop.promisor &&
    ++	test_when_finished "git -C server config remote.lop.promisor true" &&
    ++	lop_filter="$(git -C server config remote.lop.partialCloneFilter)" &&
    ++	git -C server config --unset remote.lop.partialCloneFilter &&
    ++	test_when_finished "git -C server config remote.lop.partialCloneFilter \"$lop_filter\"" &&
    ++
    ++	# Allow lazy fetching from itself
    ++	test_config_global uploadpack.lazyFetchTrusted "$(pwd)/server" &&
    ++
    ++	# Check that lazy fetching fails
    ++	test_must_fail git clone --no-local --filter="blob:limit=5k" server client 2>err &&
    ++	test_grep "too many nested lazy fetches" err &&
    ++
    ++	# Check that the largest object is still missing on the server
    ++	check_missing_objects server 1 "$oid"
    ++'
    ++
    ++test_expect_success "uploadpack.lazyFetchTrusted needs the git dir of a non-bare repo" '
    ++	test_when_finished "rm -rf nonbare client client2" &&
    ++
    ++	# Create a non-bare repo, without any worktree content, so that
    ++	# its largest object can be filtered out below
    ++	git init nonbare &&
    ++	git -C nonbare remote add origin "$TRASH_DIRECTORY_URL/template" &&
    ++	git -C nonbare fetch origin &&
    ++	git -C nonbare update-ref HEAD FETCH_HEAD &&
    ++
    ++	git -C nonbare remote add lop "$TRASH_DIRECTORY_URL/lop" &&
    ++	git -C nonbare config remote.lop.promisor true &&
    ++	git -C nonbare config uploadpack.allowFilter true &&
    ++	git -C nonbare config uploadpack.allowAnySHA1InWant true &&
    ++	git -C nonbare config promisor.advertise false &&
    ++
    ++	# Repack everything, then repack without the largest object and
    ++	# create a promisor pack, like initialize_server() does
    ++	git -C nonbare -c repack.writebitmaps=false repack -a -d &&
    ++	rm -f nonbare/.git/objects/pack/*.promisor &&
    ++	git -C nonbare -c repack.writebitmaps=false repack -a -d \
    ++		--filter=blob:limit=5k --filter-to="$(pwd)/nonbare-pack" &&
    ++	promisor_file=$(ls nonbare/.git/objects/pack/*.pack | sed "s/\.pack/.promisor/") &&
    ++	>"$promisor_file" &&
    ++	check_missing_objects nonbare 1 "$oid" &&
    ++
    ++	# The worktree path does not identify the repo, so it is not
    ++	# trusted and the clone fails
    ++	test_config_global uploadpack.lazyFetchTrusted "$(pwd)/nonbare" &&
    ++	test_must_fail git clone --no-local --filter="blob:limit=1k" \
    ++		nonbare client 2>err &&
    ++	test_grep "lazy fetching disabled" err &&
    ++	check_missing_objects nonbare 1 "$oid" &&
    ++
    ++	# The git dir identifies the repo, so it is trusted and the
    ++	# clone succeeds
    ++	test_config_global uploadpack.lazyFetchTrusted "$(pwd)/nonbare/.git" &&
    ++	git clone --no-local --filter="blob:limit=1k" nonbare client2 &&
    ++	check_missing_objects nonbare 0 ""
    ++'
     +
      test_expect_success "init + fetch with promisor.advertise set to 'true'" '
      	git -C server config promisor.advertise true &&


Christian Couder (5):
  promisor-remote: factor out lazy_fetch_objects()
  setup: extract path_allowlist_apply()
  upload-pack: read uploadpack.lazyFetchTrusted
  promisor-remote: prevent infinite recursion when lazy fetching
  builtin/upload-pack: set GIT_NO_LAZY_FETCH to 0 on trusted repo

 Documentation/config/uploadpack.adoc  |  49 +++++++++
 Documentation/git-upload-pack.adoc    |   5 +
 Documentation/git.adoc                |   4 +-
 builtin/upload-pack.c                 |  11 ++
 environment.h                         |   8 ++
 promisor-remote.c                     |  96 +++++++++++------
 setup.c                               | 138 ++++++++++++++++---------
 setup.h                               |  50 +++++++++
 t/t0410-partial-clone.sh              |  33 ++++++
 t/t5710-promisor-remote-capability.sh | 142 ++++++++++++++++++++++++++
 upload-pack.c                         |  59 +++++++++++
 upload-pack.h                         |   3 +
 12 files changed, 514 insertions(+), 84 deletions(-)


base-commit: 3cb9185f65410273787f74333cc027d2ea5daada
-- 
2.55.0.792.ged91fccac1.dirty

