Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A49416D0C
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 18:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780685375; cv=none; b=gXm3GtR+r4VDEQ4lGQDiFckghDeMbLAeuYcFUOhVfcyrN0pmfukYBDEBzgzJ7m2XBqSfaHp3ZBY8OM3hA7EMQ30aSNvgVPuEYtjw614D37oChpszdL2xX/VSjMsDD6Jv0MhIYoP5bmh31afJMw6CdOMFEp4JKGRfhbutGuwy5wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780685375; c=relaxed/simple;
	bh=ngztuhgH9h8JpOh6EJJFXuAIYJDS5MzeUBB4EsW6hs8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=V/wiZYjUC4ZkavCy+KIYSfZN0n4wF5q8JVZjDiJ7zKw3AoB0hbK+ludWPlZUJlbJGo/pf5Dp9Dq0D9/UNIUg09hLHFDcEiTjjstL16Erm7RGUR6SR8blIPHiXf5OAvCBkUXZr4Py8SuycVdxHUeemeJL15T6113EmOtaFb4Ic6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYzcT43M; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYzcT43M"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8cebfb15413so22842806d6.0
        for <git@vger.kernel.org>; Fri, 05 Jun 2026 11:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780685371; x=1781290171; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P8qJEASar4iQq2vOBac5JiMJJNq84gdjQxgjsn/VNAg=;
        b=ZYzcT43M8sz6mQT40IDe3qTBUniyKSTtZe9ZaoEuxTYDLRzNRoZzACmsj8Ca7GkPMB
         a1WpfZkeExbQgGbMaJE1ruZonCnz7qKCQJDmIKoUKkf/MzSqd1nBy+tXAsB7I27zOoXS
         jA1uejDZSsAUvkW899EcUGx9mYX81C28x+BHtngp2066mulIEHrJsZ2rwi70To0DZdRF
         zPwrT/Vle54IU8zFuyiATR5E5ytYTI1tv5PzHOtvDlLgMDBnxK8Eq54w3NuQZNZPl1TM
         wmJybKcE2DquT21UaDlBoUfpDED+Y0kpuosGC9fyMtaEeCKOKRRQcseJ17iUby6sLn8f
         J2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780685371; x=1781290171;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P8qJEASar4iQq2vOBac5JiMJJNq84gdjQxgjsn/VNAg=;
        b=hgpBK9XvTld+jAa4/cA63fhzGjgdxNS8YyHF9S+SqWQRb+xnP+sCOtcHYroCmcv7CK
         R737fyJAQZKwIx5Pa2ksuWwYJnGWEr0kPLtENaz9kR3VQsprQe2WfBq4TJSgZLP9hTBH
         jmJfYOg1H6Xwi/MqC9qXuiOvMdzlucWRSQbWlLJIwKz0COULCR3BPZ7MRMk+E+TgB7Cg
         aAESBibQ0imZJBAJuu8usU8qRxls4CfpyxuFamTxkfr+oI+doALITkTqqD3UEkwMndtt
         nAO4nSeBtFM+eWNGClXRCbsekTgfJbnnsSzK1iG58ft4NDh2gsY/ieR0FyZYPJfbgBoi
         eExw==
X-Gm-Message-State: AOJu0YxqMvMSb4TobzjIA/BIHYlQ4QuZShzghxc8+P5Lr97I+QOiLjgb
	FdZ6E8o8NZRa0K8Db/etausDw6siMISENyDpNGW6Mij5hfGLKB0+wq5nFrw9PQ==
X-Gm-Gg: Acq92OFrsKiO/g/5U9Dmk2gZH1JHBGRgNQgpARumKI5B2v2ey9Mg2XMXgZVC5Ec+IiV
	oNzXrIusdYWXpbCpV3AYt/F6Dv+8zQew6BsAHL6QMtCakyvii+CyL1eMOjNpu5OqhtIZfJyDMdI
	jFhIt45hcHwUwJYZ+2aLDx7abJ00NccJqJdzEgI6hLFuvS98NBKiikCoPbEHNeUN+V0tvpLB6aC
	kFMt2I8g1SiZmglxtsOgwLgtHFh5NMTlZ1Hgkghune9X1EPxUZhZxF3F5HTOqQqn/jBIh9O89T6
	lqv0mvz7Ui11RUnV2jcW85ML8i6ixXV8xQfjDyIjTiAoFjQP3BnIyPWDEQkY3+goZYkdtDxhv5X
	9djvMnr2rDXxafGle7HrkEPuc41E/xxbLlCK7LIl8IbtS6J5IgC7pTXmpvCUp4VZ9uuDW7qOcWn
	3Uru5LExlZU57lquPv5XLn0uIczvgsIUISovdd
X-Received: by 2002:a0c:fbcd:0:b0:8ac:b2e1:37a4 with SMTP id 6a1803df08f44-8cee613369emr73496306d6.25.1780685370327;
        Fri, 05 Jun 2026 11:49:30 -0700 (PDT)
Received: from [127.0.0.1] ([74.235.126.66])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecc8222bcsm90858006d6.0.2026.06.05.11.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 11:49:29 -0700 (PDT)
Message-Id: <7dbd9ca94f3c25f34fe76e6d0c4ff034075cda1c.1780685368.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2317.git.git.1780685368.gitgitgadget@gmail.com>
References: <pull.2317.git.git.1780685368.gitgitgadget@gmail.com>
From: "Jason Newton via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 05 Jun 2026 18:49:27 +0000
Subject: [PATCH 1/2] worktree: add --reflink for copy-on-write worktree
 creation
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
Cc: Jason Newton <nevion@gmail.com>,
    Jason Newton <nevion@gmail.com>

From: Jason Newton <nevion@gmail.com>

Creating many worktrees from the same base -- for example to run a
fleet of automated agents in parallel -- is expensive today: every
"git worktree add" materializes the entire working tree by writing
each tracked file out from the object store. The objects are shared
via the common directory, but the working tree is not: N worktrees
mean N full checkouts on disk and N times the file I/O.

Add a "--reflink" option that, on copy-on-write filesystems, populates
the new worktree by reflinking the current worktree's files and index
instead. The subsequent "git reset --hard" then only rewrites the
paths that actually differ between the current worktree and
<commit-ish>; everything else (including untracked files such as build
outputs) keeps sharing storage with the source until modified. Because
the cloned index still carries the source files' stat data, it is
refreshed against the reflinked files first so that reset recognizes
the unchanged paths as up to date and leaves them sharing extents
rather than rewriting them.

The clones are made by a new reflink_file() helper in copy.c, which
uses the FICLONE ioctl on Linux and clonefile() on macOS and reports
an error otherwise so callers fall back to a normal copy. Support is
probed up front; when unavailable -- including on filesystems without
copy-on-write and on platforms such as Windows that lack a reflink
primitive -- "--reflink" transparently falls back to an ordinary
checkout, so the worst case is no slower than today rather than a
byte-for-byte copy of the source tree. The directory walk skips the
new worktree itself when it lives inside the source one, and preserves
symlinks and modes.

The behavior can be made the default with the worktree.reflink
configuration ("true", "false" or "auto", the last suppressing the
unsupported-filesystem warning), and turned off per-invocation with
--no-reflink. A configured default degrades quietly in modes that
cannot reflink (--orphan, --no-checkout) instead of erroring, so
enabling it never breaks those commands. The checkout step continues
to honor checkout.workers, so parallel checkout composes with
--reflink for the paths that do need rewriting.

Signed-off-by: Jason Newton <nevion@gmail.com>
---
 Documentation/config/worktree.adoc |  10 ++
 Documentation/git-worktree.adoc    |  30 +++-
 builtin/worktree.c                 | 227 ++++++++++++++++++++++++++++-
 copy.c                             |  65 +++++++++
 copy.h                             |  13 ++
 t/t2400-worktree-add.sh            |  88 +++++++++++
 6 files changed, 431 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/worktree.adoc b/Documentation/config/worktree.adoc
index a248076ea5..d3a03c86d4 100644
--- a/Documentation/config/worktree.adoc
+++ b/Documentation/config/worktree.adoc
@@ -17,3 +17,13 @@
 Note that setting `worktree.useRelativePaths` to "`true`" implies enabling the
 `extensions.relativeWorktrees` config (see linkgit:git-config[1]),
 thus making it incompatible with older versions of Git.
+
+`worktree.reflink`::
+	Controls whether `git worktree add` populates new worktrees with
+	copy-on-write (reflink) clones, as if `--reflink` had been given
+	(see linkgit:git-worktree[1]). May be set to "`true`", "`false`"
+	(the default), or "`auto`". With "`true`", a filesystem that does
+	not support reflinks produces a warning before falling back to an
+	ordinary checkout; with "`auto`", the fallback is silent. An
+	explicit `--reflink` or `--no-reflink` on the command line
+	overrides this setting.
diff --git a/Documentation/git-worktree.adoc b/Documentation/git-worktree.adoc
index fbf8426cd9..1ca81718b7 100644
--- a/Documentation/git-worktree.adoc
+++ b/Documentation/git-worktree.adoc
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [synopsis]
 git worktree add [-f] [--detach] [--checkout] [--lock [--reason <string>]]
-		 [--orphan] [(-b | -B) <new-branch>] <path> [<commit-ish>]
+		 [--orphan] [--reflink] [(-b | -B) <new-branch>] <path> [<commit-ish>]
 git worktree list [-v | --porcelain [-z]]
 git worktree lock [--reason <string>] <worktree>
 git worktree move <worktree> <new-path>
@@ -213,6 +213,34 @@ To remove a locked worktree, specify `--force` twice.
 	such as configuring sparse-checkout. See "Sparse checkout"
 	in linkgit:git-read-tree[1].
 
+`--reflink`::
+`--no-reflink`::
+	Populate the new worktree by creating copy-on-write (reflink)
+	clones of the current worktree's files and index instead of
+	writing every file out from the object store. The checkout that
+	follows then only has to rewrite the paths that actually differ
+	between the current worktree and _<commit-ish>_; everything else
+	(including untracked files such as build outputs) keeps sharing
+	storage with the source worktree until modified. This makes
+	`add` much faster and far cheaper on disk when creating many
+	worktrees from the same base. `--no-reflink` forces an ordinary
+	checkout, overriding the `worktree.reflink` configuration.
++
+Reflinks require a copy-on-write filesystem (for example btrfs, XFS,
+bcachefs or ZFS on Linux, or APFS on macOS). On filesystems or platforms
+that do not support reflinks, `--reflink` transparently falls back to an
+ordinary checkout. Because the source worktree's untracked and ignored
+files are cloned as well, only use `--reflink` when that is acceptable.
++
+This option cannot be combined with `--no-checkout` or `--orphan`. It can
+be enabled by default with the `worktree.reflink` configuration; see
+linkgit:git-config[1].
++
+The checkout that populates a new worktree also honors the
+`checkout.workers` configuration (see linkgit:git-config[1]), so setting it
+parallelizes the file writes and can further speed up `add`, with or
+without `--reflink`.
+
 `--guess-remote`::
 `--no-guess-remote`::
 	With `worktree add <path>`, without _<commit-ish>_, instead
diff --git a/builtin/worktree.c b/builtin/worktree.c
index d21c43fde3..973da33051 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -30,7 +30,7 @@
 
 #define BUILTIN_WORKTREE_ADD_USAGE \
 	N_("git worktree add [-f] [--detach] [--checkout] [--lock [--reason <string>]]\n" \
-	   "                 [--orphan] [(-b | -B) <new-branch>] <path> [<commit-ish>]")
+	   "                 [--orphan] [--reflink] [(-b | -B) <new-branch>] <path> [<commit-ish>]")
 
 #define BUILTIN_WORKTREE_LIST_USAGE \
 	N_("git worktree list [-v | --porcelain [-z]]")
@@ -47,6 +47,11 @@
 #define BUILTIN_WORKTREE_UNLOCK_USAGE \
 	N_("git worktree unlock <worktree>")
 
+/* values for add_opts.reflink and the worktree.reflink config */
+#define REFLINK_OFF	0
+#define REFLINK_ON	1	/* warn and fall back if unsupported */
+#define REFLINK_AUTO	2	/* silently fall back if unsupported */
+
 #define WORKTREE_ADD_DWIM_ORPHAN_INFER_TEXT \
 	_("No possible source branch, inferring '--orphan'")
 
@@ -123,6 +128,7 @@ struct add_opts {
 	int checkout;
 	int orphan;
 	int relative_paths;
+	int reflink;
 	const char *keep_locked;
 };
 
@@ -130,6 +136,7 @@ static int show_only;
 static int verbose;
 static int guess_remote;
 static int use_relative_paths;
+static int reflink_config = REFLINK_OFF;
 static timestamp_t expire;
 
 static int git_worktree_config(const char *var, const char *value,
@@ -141,6 +148,13 @@ static int git_worktree_config(const char *var, const char *value,
 	} else if (!strcmp(var, "worktree.userelativepaths")) {
 		use_relative_paths = git_config_bool(var, value);
 		return 0;
+	} else if (!strcmp(var, "worktree.reflink")) {
+		if (value && !strcmp(value, "auto"))
+			reflink_config = REFLINK_AUTO;
+		else
+			reflink_config = git_config_bool(var, value) ?
+				REFLINK_ON : REFLINK_OFF;
+		return 0;
 	}
 
 	return git_default_config(var, value, ctx, cb);
@@ -397,6 +411,182 @@ worktree_copy_cleanup:
 	free(to_file);
 }
 
+/*
+ * Probe whether the filesystem backing "dir" supports reflinks. We do this
+ * once up front so that, on filesystems without copy-on-write support (or on
+ * platforms such as Windows that lack a reflink primitive entirely), we can
+ * fall back to a normal checkout instead of byte-copying the whole source
+ * working tree -- which would include untracked files and be slower than the
+ * checkout we are trying to avoid.
+ */
+static int reflink_supported(const char *dir)
+{
+	struct strbuf src = STRBUF_INIT, dst = STRBUF_INIT;
+	int fd, ok = 0;
+
+	strbuf_addf(&src, "%s/.git-reflink-probe-src", dir);
+	strbuf_addf(&dst, "%s/.git-reflink-probe-dst", dir);
+
+	fd = open(src.buf, O_WRONLY | O_CREAT | O_TRUNC, 0600);
+	if (fd >= 0) {
+		write_in_full(fd, "x", 1);
+		close(fd);
+		if (!reflink_file(dst.buf, src.buf, 0600))
+			ok = 1;
+		unlink(dst.buf);
+	}
+	unlink(src.buf);
+
+	strbuf_release(&src);
+	strbuf_release(&dst);
+	return ok;
+}
+
+/*
+ * Reflink a single regular file, falling back to a regular copy when the
+ * clone fails for this particular file (for example across mount points).
+ */
+static int reflink_or_copy(const char *dst, const char *src, int mode)
+{
+	if (!reflink_file(dst, src, mode))
+		return 0;
+	return copy_file(dst, src, mode);
+}
+
+/*
+ * Recursively copy the working-tree directory "src" into "dst" using reflinks
+ * for regular files. Directory entries that resolve to the destination
+ * worktree itself (identified by skip_dev/skip_ino, which matters when the new
+ * worktree lives inside the source one) and the top-level ".git" gitfile are
+ * skipped.
+ */
+static int reflink_tree(const char *src, const char *dst,
+			dev_t skip_dev, ino_t skip_ino, int top)
+{
+	struct strbuf s = STRBUF_INIT, d = STRBUF_INIT;
+	DIR *dir;
+	struct dirent *de;
+	int ret = 0;
+
+	dir = opendir(src);
+	if (!dir)
+		return error_errno(_("could not open directory '%s'"), src);
+
+	while (!ret && (de = readdir(dir))) {
+		struct stat st;
+
+		if (is_dot_or_dotdot(de->d_name))
+			continue;
+		if (top && !strcmp(de->d_name, ".git"))
+			continue;
+
+		strbuf_reset(&s);
+		strbuf_addf(&s, "%s/%s", src, de->d_name);
+		strbuf_reset(&d);
+		strbuf_addf(&d, "%s/%s", dst, de->d_name);
+
+		if (lstat(s.buf, &st)) {
+			ret = error_errno(_("could not stat '%s'"), s.buf);
+			break;
+		}
+
+		if (S_ISDIR(st.st_mode)) {
+			/* never recurse into the new worktree itself */
+			if (st.st_dev == skip_dev && st.st_ino == skip_ino)
+				continue;
+			if (mkdir(d.buf, st.st_mode & 07777) && errno != EEXIST) {
+				ret = error_errno(_("could not create directory '%s'"), d.buf);
+				break;
+			}
+			ret = reflink_tree(s.buf, d.buf, skip_dev, skip_ino, 0);
+		} else if (S_ISLNK(st.st_mode)) {
+			struct strbuf link = STRBUF_INIT;
+
+			if (strbuf_readlink(&link, s.buf, st.st_size))
+				ret = error_errno(_("could not read symlink '%s'"), s.buf);
+			else if (symlink(link.buf, d.buf))
+				ret = error_errno(_("could not create symlink '%s'"), d.buf);
+			strbuf_release(&link);
+		} else if (S_ISREG(st.st_mode)) {
+			if (reflink_or_copy(d.buf, s.buf, st.st_mode))
+				ret = error_errno(_("could not copy '%s' to '%s'"),
+						  s.buf, d.buf);
+		}
+		/* silently skip fifos, sockets and device nodes */
+	}
+
+	closedir(dir);
+	strbuf_release(&s);
+	strbuf_release(&d);
+	return ret;
+}
+
+/*
+ * Populate the new worktree at "path" by reflinking the current worktree's
+ * files and index. The subsequent "git reset --hard" then only has to rewrite
+ * the paths that actually differ between the source and <commit-ish>, leaving
+ * everything else sharing storage with the source. Returns 1 when reflinks are
+ * unavailable so the caller can fall back to a plain checkout.
+ */
+static int reflink_worktree(const char *path, const char *wt_git_dir,
+			    const struct add_opts *opts, struct strvec *child_env)
+{
+	const char *src_wt = the_repository->worktree;
+	char *src_index = NULL, *dst_index = NULL;
+	struct stat dst_st;
+	int ret = 0;
+
+	if (!src_wt)
+		return error(_("--reflink needs a source working tree, but this "
+			       "repository does not have one"));
+
+	if (!reflink_supported(path)) {
+		/* In auto mode the fallback is expected, so stay quiet. */
+		if (!opts->quiet && opts->reflink != REFLINK_AUTO)
+			warning(_("the filesystem at '%s' does not support reflinks; "
+				  "falling back to a regular checkout"), path);
+		return 1;
+	}
+
+	if (stat(path, &dst_st))
+		return error_errno(_("could not stat '%s'"), path);
+
+	if ((ret = reflink_tree(src_wt, path, dst_st.st_dev, dst_st.st_ino, 1)))
+		return ret;
+
+	/*
+	 * Clone the source index so the following reset sees the source's
+	 * state and only materializes the differences to <commit-ish>.
+	 */
+	src_index = repo_git_path(the_repository, "index");
+	dst_index = xstrfmt("%s/index", wt_git_dir);
+	if (!access(src_index, F_OK) &&
+	    reflink_or_copy(dst_index, src_index, 0666)) {
+		ret = error_errno(_("could not copy index to '%s'"), dst_index);
+		goto out;
+	}
+
+	/*
+	 * The cloned index still carries the source files' stat information.
+	 * Refresh it against the freshly reflinked files so that "git reset"
+	 * recognizes unchanged paths as up to date and leaves them sharing
+	 * storage instead of rewriting (and thus un-sharing) them.
+	 */
+	if (!access(dst_index, F_OK)) {
+		struct child_process cp = CHILD_PROCESS_INIT;
+		cp.git_cmd = 1;
+		strvec_pushl(&cp.args, "update-index", "-q", "--refresh", NULL);
+		strvec_pushv(&cp.env, child_env->v);
+		/* a dirty working tree is not an error here */
+		run_command(&cp);
+	}
+
+out:
+	free(src_index);
+	free(dst_index);
+	return ret;
+}
+
 static int checkout_worktree(const struct add_opts *opts,
 			     struct strvec *child_env)
 {
@@ -589,6 +779,20 @@ static int add_worktree(const char *path, const char *refname,
 	    (ret = make_worktree_orphan(refname, opts, &child_env)))
 		goto done;
 
+	/*
+	 * When --reflink is requested and the filesystem supports it, copy the
+	 * current worktree (and its index) into the new one using copy-on-write
+	 * clones. checkout_worktree() then only rewrites the paths that differ
+	 * from <commit-ish>. reflink_worktree() returns 1 when reflinks are not
+	 * available, in which case we just do an ordinary checkout below.
+	 */
+	if (opts->checkout && opts->reflink) {
+		ret = reflink_worktree(path, sb_repo.buf, opts, &child_env);
+		if (ret < 0)
+			goto done;
+		ret = 0;
+	}
+
 	if (opts->checkout &&
 	    (ret = checkout_worktree(opts, &child_env)))
 		goto done;
@@ -801,6 +1005,7 @@ static int add(int ac, const char **av, const char *prefix,
 	const char *lock_reason = NULL;
 	int keep_locked = 0;
 	int used_new_branch_options;
+	int reflink_cli = -1;
 	struct option options[] = {
 		OPT__FORCE(&opts.force,
 			   N_("checkout <branch> even if already checked out in other worktree"),
@@ -823,6 +1028,8 @@ static int add(int ac, const char **av, const char *prefix,
 			 N_("try to match the new branch name with a remote-tracking branch")),
 		OPT_BOOL(0, "relative-paths", &opts.relative_paths,
 			 N_("use relative paths for worktrees")),
+		OPT_BOOL(0, "reflink", &reflink_cli,
+			 N_("populate the worktree using copy-on-write clones when supported")),
 		OPT_END()
 	};
 	int ret;
@@ -842,6 +1049,24 @@ static int add(int ac, const char **av, const char *prefix,
 	if (opts.orphan && !opts.checkout)
 		die(_("options '%s' and '%s' cannot be used together"),
 		    "--orphan", "--no-checkout");
+
+	/*
+	 * Resolve whether to reflink: an explicit --reflink/--no-reflink on
+	 * the command line wins, otherwise fall back to the worktree.reflink
+	 * configuration (which may select the "auto" mode).
+	 */
+	opts.reflink = (reflink_cli != -1) ? reflink_cli : reflink_config;
+	if (opts.reflink && (opts.orphan || !opts.checkout)) {
+		/*
+		 * Reflinking is incompatible with these; only complain when it
+		 * was explicitly requested, otherwise quietly do a plain
+		 * checkout so a configured default does not break these modes.
+		 */
+		if (reflink_cli == REFLINK_ON)
+			die(_("options '%s' and '%s' cannot be used together"),
+			    "--reflink", opts.orphan ? "--orphan" : "--no-checkout");
+		opts.reflink = REFLINK_OFF;
+	}
 	if (opts.orphan && ac == 2)
 		die(_("option '%s' and commit-ish cannot be used together"),
 		    "--orphan");
diff --git a/copy.c b/copy.c
index b668209b6c..d2c8ce5209 100644
--- a/copy.c
+++ b/copy.c
@@ -7,6 +7,21 @@
 #include "strbuf.h"
 #include "abspath.h"
 
+#if defined(__linux__)
+#include <sys/ioctl.h>
+/*
+ * FICLONE lives in <linux/fs.h>, but including that header tends to clash
+ * with the libc headers git already pulls in, so define it ourselves if it
+ * is missing. The value is part of the stable kernel uapi.
+ */
+#ifndef FICLONE
+#define FICLONE _IOW(0x94, 9, int)
+#endif
+#elif defined(__APPLE__)
+#include <sys/attr.h>
+#include <sys/clonefile.h>
+#endif
+
 int copy_fd(int ifd, int ofd)
 {
 	while (1) {
@@ -72,3 +87,53 @@ int copy_file_with_time(const char *dst, const char *src, int mode)
 		return copy_times(dst, src);
 	return status;
 }
+
+int reflink_file(const char *dst, const char *src, int mode)
+{
+#if defined(__APPLE__)
+	/*
+	 * clonefile() refuses to operate when the destination exists and
+	 * copies the source's permissions for us, so "mode" is unused here.
+	 */
+	(void)mode;
+	if (clonefile(src, dst, 0) < 0)
+		return -1;
+	if (adjust_shared_perm(the_repository, dst))
+		return -1;
+	return 0;
+#elif defined(__linux__)
+	int fdi, fdo, status;
+
+	mode = (mode & 0111) ? 0777 : 0666;
+	if ((fdi = open(src, O_RDONLY)) < 0)
+		return -1;
+	if ((fdo = open(dst, O_WRONLY | O_CREAT | O_EXCL, mode)) < 0) {
+		int saved = errno;
+		close(fdi);
+		errno = saved;
+		return -1;
+	}
+	status = ioctl(fdo, FICLONE, fdi);
+	close(fdi);
+	if (status < 0) {
+		int saved = errno;
+		close(fdo);
+		/* we created an empty file above; do not leave it behind */
+		unlink(dst);
+		errno = saved;
+		return -1;
+	}
+	if (close(fdo) != 0)
+		return -1;
+	if (adjust_shared_perm(the_repository, dst))
+		return -1;
+	return 0;
+#else
+	/* No reflink support on this platform (e.g. Windows). */
+	(void)dst;
+	(void)src;
+	(void)mode;
+	errno = ENOSYS;
+	return -1;
+#endif
+}
diff --git a/copy.h b/copy.h
index 2af77cba86..a8646f7ff5 100644
--- a/copy.h
+++ b/copy.h
@@ -7,4 +7,17 @@ int copy_fd(int ifd, int ofd);
 int copy_file(const char *dst, const char *src, int mode);
 int copy_file_with_time(const char *dst, const char *src, int mode);
 
+/*
+ * Create "dst" as a copy-on-write (reflink) clone of the regular file
+ * "src", so that the two files share their data blocks until one of
+ * them is modified. "dst" must not already exist.
+ *
+ * This only succeeds on filesystems that support block cloning (e.g.
+ * btrfs, XFS or bcachefs on Linux, APFS on macOS). When the platform or
+ * filesystem does not support reflinks, -1 is returned with errno set to
+ * ENOSYS (or the underlying error). Callers are expected to fall back to
+ * copy_file() in that case. Returns 0 on success.
+ */
+int reflink_file(const char *dst, const char *src, int mode);
+
 #endif /* COPY_H */
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 58b4445cc4..56fb79179a 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -1248,4 +1248,92 @@ test_expect_success 'relative worktree sets extension config' '
 	test_cmp_config -C repo true extensions.relativeworktrees
 '
 
+test_expect_success '--reflink produces a correct checkout on any filesystem' '
+	test_when_finished "rm -rf reflinkrepo" &&
+	git init reflinkrepo &&
+	(
+		cd reflinkrepo &&
+		test_commit base file.txt base &&
+		test_commit next file.txt next &&
+		git worktree add --reflink wt -b reflinkbr base &&
+		echo base >expect &&
+		test_cmp expect wt/file.txt &&
+		git -C wt status --porcelain >status &&
+		test_must_be_empty status
+	)
+'
+
+test_expect_success '--reflink rejects incompatible options' '
+	test_must_fail git worktree add --reflink --no-checkout wt-bad HEAD 2>err &&
+	test_grep "cannot be used together" err &&
+	test_must_fail git worktree add --reflink --orphan wt-bad2 2>err &&
+	test_grep "cannot be used together" err
+'
+
+test_expect_success 'worktree.reflink config drives a correct checkout' '
+	test_when_finished "rm -rf reflinkcfg" &&
+	git init reflinkcfg &&
+	(
+		cd reflinkcfg &&
+		test_commit cfg file.txt value &&
+		git -c worktree.reflink=true worktree add wt HEAD &&
+		echo value >expect &&
+		test_cmp expect wt/file.txt
+	)
+'
+
+test_expect_success 'worktree.reflink=auto does not break --orphan' '
+	test_when_finished "rm -rf reflinkorphan" &&
+	git init reflinkorphan &&
+	(
+		cd reflinkorphan &&
+		test_commit base file.txt value &&
+		git -c worktree.reflink=auto worktree add --orphan wt &&
+		git -C wt symbolic-ref --short HEAD >actual &&
+		echo wt >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '--no-reflink overrides worktree.reflink' '
+	test_when_finished "rm -rf reflinkoff" &&
+	git init reflinkoff &&
+	(
+		cd reflinkoff &&
+		test_commit base file.txt value &&
+		git -c worktree.reflink=true worktree add --no-reflink wt HEAD &&
+		echo value >expect &&
+		test_cmp expect wt/file.txt
+	)
+'
+
+# Reflinks are only available on copy-on-write filesystems (btrfs, XFS,
+# bcachefs, APFS, ...). Where they are unavailable, --reflink transparently
+# falls back to a regular checkout, which the test above already covers.
+test_lazy_prereq REFLINK '
+	echo probe >reflink-src &&
+	cp --reflink=always reflink-src reflink-dst 2>/dev/null
+'
+
+test_expect_success REFLINK '--reflink carries untracked files and reconciles changes' '
+	test_when_finished "rm -rf cowrepo" &&
+	git init cowrepo &&
+	(
+		cd cowrepo &&
+		test_commit same same.txt content &&
+		test_commit old change.txt old-value &&
+		test_commit new change.txt new-value &&
+		echo artifact >untracked.bin &&
+		git worktree add --reflink wt -b cowbr old &&
+		echo content >expect &&
+		test_cmp expect wt/same.txt &&
+		echo old-value >expect &&
+		test_cmp expect wt/change.txt &&
+		echo artifact >expect &&
+		test_cmp expect wt/untracked.bin &&
+		git -C wt status --porcelain >status &&
+		grep "?? untracked.bin" status
+	)
+'
+
 test_done
-- 
gitgitgadget

