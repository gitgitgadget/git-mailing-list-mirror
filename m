Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792567069;
	b=VNrNI4T50AcBd7jwKFvZyJBuxuLvLG63NkNyTGU18njmpDRjAebq+KBd6lfCbOw1uGrB
	 AYoi6ap9tfayaxQOzmLHzD4vjMjPjXPKoAEdN33gjFPR7uBFGTzKrJmloQXNrOWHSOJHO
	 0XGDx1apj/+rrX1jlLekGnPGlsKjl/jiGxRO2obJsOnhgBKmqn8uVxWGrGSOfFuaGnvIl
	 aRCltX0PM6Zrlxt5l1MsojVYylqkk+WY8QrjR1MQdsKJqwMO8J49KzpakQs1OpywEffYs
	 CLPqsK/0ynXC/rU/vuiA8Ii2+blRQ44Wl/YZ5jeK8YvCTw3Byip5rfbjWBMmZxVIvZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792567069;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=PHIkpCc7v6CRQp5okWmG7mp63zlUreV4OrFa3i04AGk=;
	b=3csm+4iB/fdWjaU3N1eHKKKcGaBOrIYsGDBCPckwO0Gh9iluAlM4aeelvWcTUrb4vZRV
	 jGcYOy31JojWm50TBnNIH0qfVasSBgOYicqMk95s6bPXAoPc331ppAEqZ/CzXraEJlGap
	 dyHVWaz5Qa1WZUCpYU4nlFeYRRdLF0JAWI9HhvsZ5wFf6Ex8m2mFosNyGbXXRrweNmvdD
	 z9ar9u9wTRvG7YIVPGdab1rx+CYQRIqYrFtWKl9Qb2zjJvN33Yztvx49KZvQ8Jt0LJfx2
	 pmSc+amrcMjOhW7MkILGmCEg4rNBNXzl11f7OF+5iL9FX1FIfRg6p8ZTdrMror27ERQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Qmh+OVqT;
	arc=none smtp.remote-ip=209.85.210.41
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3374606A327
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 07:17:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3374606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Qmh+OVqT
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7f84a55e31aso233292a34.2
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 00:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792567067; x=1793171867; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PHIkpCc7v6CRQp5okWmG7mp63zlUreV4OrFa3i04AGk=;
        b=Qmh+OVqTpRfVtcdTsh+WpgXhf+muWhoQQ8yPBJun2F16u/a0b9zsohteSYSJ0+OUX3
         gfCPhFK3hdtRbk/p+fgLU8d7p7Vu76JeF4dYTdiTv6y/qQXUsUEfW9ojGrEke21XviQC
         CegYhXxJWiqGOnsY5tSlmpWh7WOMMEnfdlWMSVuq+mMoKkRzTBVVtBl+20ptCvAwLlz2
         2GIUTz1CjVTOeZDfQOtVTDZ0Gv6VFhtEbwRGQw0UqwwCmEEB6B3J5nRtTCvqFW/tfh2X
         lcSMydhY/2xC6FglULC/h5JUJRsZVPZKXgfZaAvhUTRoII1yLv240JlMTk/ZJMgjanRY
         v+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792567067; x=1793171867;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PHIkpCc7v6CRQp5okWmG7mp63zlUreV4OrFa3i04AGk=;
        b=Gs8kh/RNJhJuLg+/iRsgcX6oaFN6mlVRjtLbLhsB2pltTl+jep6WCAVqXkNMnh3lHr
         7nwTxqWb2SHDswyF64MjUuSMRIc2ig8q1rRX4b3t+kMSIq3nsj5XAC9rBcCkh6RyTfA7
         VW615QYDSx5A/VWdgLHKd3uQ7gu/yZWGSzOOAx3M82bkUuEdlwsb2/0onNx2fT7M5CI0
         g6m81PWeRqmPKu0Xcyf1bhKd9dhvDVYEQdxk84RNx2L6Edt7Ki2NZDaVqZ3HwBnKM+sm
         vrHNGUk13790GD/PhKxAa05/mp4fGzMONp/pS+UNkj0KzvNKuqCZzJa0b8jqph0ZUyaS
         4p7g==
X-Gm-Message-State: AFq9FYIacN/5kJPxtpzZHntHBsYjvBfnC+kKJJUCv5r0SXns9tOJ/foP
	VtuGGD6wdboXrS0+iPCpaQZ4Lt/DVOPaZybIAkbxW9btsFcKm7/b+tUX1FbVtA==
X-Gm-Gg: AYBFou0GtQq5LIA+qrWp1r+opoXLVlu0PsJR2+DXfvR1A5tL4LR6R3DKFBhDysjrOOG
	qoauzlz6Z1DKnQM9DFXNT9pVsW1So8Pm64vRORAWn7zslUKKghmTX3F+E/+uRy5yHJ8uCGSeRWd
	3nMVPXb2tpm1NU/EF/nd30vh0dKs8+wn5EYNH8qwTuVtrRqp29AwumQos/xkO76/6gHx+SHN04s
	/QJy8RVF9hEqzBNe1yQAmjt3EwgoxUoGDXVj6xfIBYGRuRdlbU5XdsTKkyfy2aAhFrit1t3+JDy
	Bepe7FTMHDATX2TQNHfQFUW31gCamSy//kFj9C9Hstn/EoKq1BSbEHatP5HsbZImt/uwozOLFCS
	xB54GeLWRIN1eOs1MD+rXg2R/W6KiJUrQtx10VN70YPntAiHnUNfDxm97sy0YAiqIvnRPfNedrK
	Q5RIjBNHr9DhqC8XbxXjvvVv4oy8ntOfkmtfywzVeHS6wg4ENq0JHgyYxPiv9NsNj6+lTqjuzpj
	6GcMOhw+F5jRopmCTbJXwTf56Q1KwrXpRaapLWlrGwcVboH+TlHG0u6ttXU
X-Received: by 2002:a05:6830:2b29:b0:829:2af1:a07d with SMTP id 46e09a7af769-84d07a0521emr794553a34.5.1792567067022;
        Wed, 21 Oct 2026 00:17:47 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.140.214])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84cbd2d2a76sm1721820a34.18.2026.10.21.00.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 00:17:45 -0700 (PDT)
Message-Id: <a163f737af090cc00e4c93a068df54d6a6ecd7ec.1792567061.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2317.v3.git.git.1792567061.gitgitgadget@gmail.com>
References: <pull.2317.git.git.1780685368.gitgitgadget@gmail.com>
	<pull.2317.v3.git.git.1792567061.gitgitgadget@gmail.com>
From: "Jason Newton via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 21 Oct 2026 07:17:38 +0000
Subject: [PATCH v3 1/4] worktree: add --reflink for copy-on-write worktree
 creation
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
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Jason Newton <nevion@gmail.com>,
    Jason Newton <nevion@gmail.com>

From: Jason Newton <nevion@gmail.com>

Creating many worktrees from the same base -- for example to run a
fleet of automated agents in parallel -- is expensive today: every
"git worktree add" materializes the entire working tree by writing
each tracked file out from the object store. The objects are shared
via the common directory, but the working tree is not: N worktrees
mean N full checkouts on disk and N times the file I/O.

Add a "--reflink" option that, on a copy-on-write filesystem, populates
the new worktree by reflinking the current worktree's files and index
instead. The subsequent "git reset --hard" then only rewrites the
paths that actually differ between the current worktree and
<commit-ish>; everything else (including untracked files such as build
outputs) keeps sharing storage with the source until modified.

A new reflink_file() helper in copy.c clones every regular file. There
is no size cutoff.

On Linux it uses the FICLONE ioctl. That is the primitive btrfs, XFS
and bcachefs implement, and the one overlayfs forwards when the lower
filesystem can clone. This path has been tested on btrfs.

On macOS it uses clonefile(), the APFS primitive. The t2400
REFLINK prerequisite probes that with "cp -c", because BSD cp has no
--reflink=always, so the macOS CI jobs exercise this path on APFS.

On Windows it uses ReFS block cloning,
FSCTL_DUPLICATE_EXTENTS_TO_FILE, as Git LFS does. The destination is
sized to the source, extents are cloned in chunks of at most 1GiB, and
the tail is rounded up to a cluster (64K, then 4K) and cloned; Windows
ignores the range past EOF. The tail is not byte-copied, and small
files are not skipped. That path is implemented and has not been run
on ReFS. A volume that rejects the control code, including NTFS, fails
the probe.

Anywhere else there is no reflink primitive. Support is probed up front
by cloning a one-byte file, and where that fails "--reflink" falls back
to an ordinary checkout instead of byte-copying the source tree. The
directory walk skips the new worktree itself when it lives inside the
source one, and preserves symlinks and modes.

Uncommitted changes in the source do not leak into the new worktree.
After reflinking the source's files we copy its index and run
"update-index --refresh" before "reset --hard": because every reflinked
file is a fresh inode, the cached stat never matches, so the refresh is
forced to re-validate by content rather than by stat. A tracked path is
therefore only left sharing extents when its content equals the indexed
object; any path whose content differs from <commit-ish> -- which
includes every uncommitted modification in the source -- is rewritten
by the reset. The new worktree is thus always a faithful checkout of
<commit-ish> for tracked paths, and only untracked files are carried
over.

The behavior can be made the default with the worktree.reflink
configuration ("true", "false" or "auto", the last suppressing the
unsupported-filesystem warning), and turned off per-invocation with
--no-reflink. A configured default degrades quietly in modes that
cannot reflink (--orphan, --no-checkout) instead of erroring, so
enabling it never breaks those commands. The checkout step continues to
honor checkout.workers, so parallel checkout composes with --reflink for
the paths that do need rewriting.

To check out many worktrees at the same commit safely, give each its
own ref (or a detached HEAD) rather than sharing one branch; a
git-worktree(1) example shows the one-shot "update-ref" transaction
that pairs with --reflink.

Signed-off-by: Jason Newton <nevion@gmail.com>
---
 Documentation/config/worktree.adoc |  10 ++
 Documentation/git-worktree.adoc    |  49 ++++++-
 builtin/worktree.c                 | 227 ++++++++++++++++++++++++++++-
 copy.c                             | 190 ++++++++++++++++++++++++
 copy.h                             |  14 ++
 t/t2400-worktree-add.sh            |  96 ++++++++++++
 6 files changed, 584 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/worktree.adoc b/Documentation/config/worktree.adoc
index 0930183b91..aa849c08d2 100644
--- a/Documentation/config/worktree.adoc
+++ b/Documentation/config/worktree.adoc
@@ -18,3 +18,13 @@
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
index e6e77252ab..4264ee753a 100644
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
@@ -213,6 +213,35 @@ To remove a locked worktree, specify `--force` twice.
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
+Reflinks require a copy-on-write filesystem: for example btrfs, XFS,
+bcachefs or ZFS on Linux (and overlayfs on top of one of these, as used by
+containers), APFS on macOS, or ReFS on Windows. On a filesystem that does
+not support reflinks, `--reflink` transparently falls back to an ordinary
+checkout. Because the source worktree's untracked and ignored files are
+cloned as well, only use `--reflink` when that is acceptable.
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
@@ -531,6 +560,24 @@ $ popd
 $ git worktree remove ../temp
 ------------
 
+To run several independent worktrees from the same starting commit -- for
+example a pool of automated agents -- give each one its own branch rather than
+sharing a single branch between them. A shared branch is unsafe here: if one
+worktree commits and another then commits from its now-stale index, the second
+commit silently drops the first one's changes. Create the branches in a single
+ref transaction and check each out in its own (optionally reflinked) worktree:
+
+------------
+$ oid=$(git rev-parse HEAD)
+$ printf 'create refs/heads/agent-%s %s\n' 1 "$oid" 2 "$oid" 3 "$oid" |
+	git update-ref --stdin
+$ for n in 1 2 3; do git worktree add --reflink ../agent-$n agent-$n; done
+------------
+
+The single linkgit:git-update-ref[1] transaction is cheap and is especially
+efficient with the `reftable` backend. If a worktree does not need to advance a
+branch at all, use a detached `HEAD` (`git worktree add --detach`) instead.
+
 CONFIGURATION
 -------------
 
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 77ecd0f71f..9d4b51305e 100644
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
@@ -394,6 +408,182 @@ worktree_copy_cleanup:
 	free(to_file);
 }
 
+/*
+ * Probe whether the filesystem backing "dir" supports reflinks. We do this
+ * once up front so that, on filesystems without copy-on-write support (and on
+ * platforms that lack a reflink primitive entirely), we can
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
+		if (!reflink_file(the_repository, dst.buf, src.buf, 0600))
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
+	if (!reflink_file(the_repository, dst, src, mode))
+		return 0;
+	return copy_file(the_repository, dst, src, mode);
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
@@ -588,6 +778,20 @@ static int add_worktree(const char *path, const char *refname,
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
@@ -832,6 +1036,7 @@ static int add(int ac, const char **av, const char *prefix,
 	const char *lock_reason = NULL;
 	int keep_locked = 0;
 	int used_new_branch_options;
+	int reflink_cli = -1;
 	struct option options[] = {
 		OPT__FORCE(&opts.force,
 			   N_("checkout <branch> even if already checked out in other worktree"),
@@ -854,6 +1059,8 @@ static int add(int ac, const char **av, const char *prefix,
 			 N_("try to match the new branch name with a remote-tracking branch")),
 		OPT_BOOL(0, "relative-paths", &opts.relative_paths,
 			 N_("use relative paths for worktrees")),
+		OPT_BOOL(0, "reflink", &reflink_cli,
+			 N_("populate the worktree using copy-on-write clones when supported")),
 		OPT_END()
 	};
 	int ret;
@@ -873,6 +1080,24 @@ static int add(int ac, const char **av, const char *prefix,
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
index 6074132050..e6dfe33f6a 100644
--- a/copy.c
+++ b/copy.c
@@ -5,6 +5,38 @@
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
+#elif defined(GIT_WINDOWS_NATIVE)
+#include <winioctl.h>
+/*
+ * Block cloning on ReFS uses FSCTL_DUPLICATE_EXTENTS_TO_FILE. Older Windows
+ * SDK headers may lack the control code and its payload struct, so define
+ * them ourselves when missing (the values are part of the stable Win32 API).
+ */
+#ifndef FSCTL_DUPLICATE_EXTENTS_TO_FILE
+#define FSCTL_DUPLICATE_EXTENTS_TO_FILE \
+	CTL_CODE(FILE_DEVICE_FILE_SYSTEM, 209, METHOD_BUFFERED, FILE_WRITE_DATA)
+typedef struct _DUPLICATE_EXTENTS_DATA {
+	HANDLE FileHandle;
+	LARGE_INTEGER SourceFileOffset;
+	LARGE_INTEGER TargetFileOffset;
+	LARGE_INTEGER ByteCount;
+} DUPLICATE_EXTENTS_DATA, *PDUPLICATE_EXTENTS_DATA;
+#endif
+#endif
+
 int copy_fd(int ifd, int ofd)
 {
 	while (1) {
@@ -72,3 +104,161 @@ int copy_file_with_time(struct repository *repo,
 		return copy_times(dst, src);
 	return status;
 }
+
+#ifdef GIT_WINDOWS_NATIVE
+/*
+ * Clone [offset, offset+count) of "src" onto "dst" via ReFS block cloning.
+ * "count" is rounded up to a cluster boundary by the caller; a range that
+ * runs past the source's end of file is harmless and ignored by Windows.
+ */
+static int clone_extent_windows(HANDLE dst, HANDLE src,
+				uint64_t offset, uint64_t count)
+{
+	DUPLICATE_EXTENTS_DATA dup;
+	DWORD bytes;
+
+	dup.FileHandle = src;
+	dup.SourceFileOffset.QuadPart = offset;
+	dup.TargetFileOffset.QuadPart = offset;
+	dup.ByteCount.QuadPart = count;
+	if (!DeviceIoControl(dst, FSCTL_DUPLICATE_EXTENTS_TO_FILE,
+			     &dup, sizeof(dup), NULL, 0, &bytes, NULL))
+		return -1;
+	return 0;
+}
+#endif
+
+int reflink_file(struct repository *repo,
+		 const char *dst, const char *src, int mode)
+{
+#if defined(__APPLE__)
+	/*
+	 * clonefile() refuses to operate when the destination exists and
+	 * copies the source's permissions for us, so "mode" is unused here.
+	 */
+	(void)mode;
+	if (clonefile(src, dst, 0) < 0)
+		return -1;
+	if (adjust_shared_perm(repo, dst))
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
+	if (adjust_shared_perm(repo, dst))
+		return -1;
+	return 0;
+#elif defined(GIT_WINDOWS_NATIVE)
+	/*
+	 * ReFS supports copy-on-write block cloning via
+	 * FSCTL_DUPLICATE_EXTENTS_TO_FILE, the same mechanism Git LFS uses.
+	 * Cloned ranges must start and end on a cluster boundary (ReFS uses
+	 * 64K or 4K clusters) and span less than 4GiB, so clone in <=1GiB
+	 * chunks and round the final chunk up to a cluster; the destination is
+	 * sized to the source's exact length and an over-long final range past
+	 * the source's EOF is ignored.
+	 */
+	const uint64_t GiB = (uint64_t)1 << 30;
+	const uint64_t clusters[] = { 64 * 1024, 4 * 1024 };
+	int fdi, fdo, ret = -1;
+	HANDLE hi, ho;
+	LARGE_INTEGER size;
+	uint64_t off;
+	size_t i;
+
+	mode = (mode & 0111) ? 0777 : 0666;
+	if ((fdi = open(src, O_RDONLY | O_BINARY)) < 0)
+		return -1;
+	if ((fdo = open(dst, O_RDWR | O_CREAT | O_EXCL | O_BINARY, mode)) < 0) {
+		int saved = errno;
+		close(fdi);
+		errno = saved;
+		return -1;
+	}
+	hi = (HANDLE)_get_osfhandle(fdi);
+	ho = (HANDLE)_get_osfhandle(fdo);
+	if (hi == INVALID_HANDLE_VALUE || ho == INVALID_HANDLE_VALUE ||
+	    !GetFileSizeEx(hi, &size)) {
+		errno = EINVAL;
+		goto cleanup;
+	}
+
+	/* the destination must be the source's exact size before cloning */
+	if (!SetFilePointerEx(ho, size, NULL, FILE_BEGIN) || !SetEndOfFile(ho)) {
+		errno = EIO;
+		goto cleanup;
+	}
+
+	ret = 0;
+	/* clone whole 1GiB regions (already cluster aligned) */
+	for (off = 0; (uint64_t)size.QuadPart > off &&
+		      (uint64_t)size.QuadPart - off > GiB; off += GiB) {
+		if (clone_extent_windows(ho, hi, off, GiB)) {
+			errno = ENOSYS;
+			ret = -1;
+			goto cleanup;
+		}
+	}
+	/* clone the tail, rounding its length up to a cluster (64K then 4K) */
+	if (!ret && (uint64_t)size.QuadPart > off) {
+		uint64_t rem = (uint64_t)size.QuadPart - off;
+
+		ret = -1;
+		for (i = 0; i < ARRAY_SIZE(clusters); i++) {
+			uint64_t count = (rem + clusters[i] - 1) &
+					 ~(clusters[i] - 1);
+			if (!clone_extent_windows(ho, hi, off, count)) {
+				ret = 0;
+				break;
+			}
+		}
+		if (ret)
+			errno = ENOSYS;	/* not a CoW volume */
+	}
+
+cleanup:
+	close(fdi);
+	if (close(fdo) && !ret) {
+		errno = EIO;
+		ret = -1;
+	}
+	if (ret) {
+		int saved = errno;
+		unlink(dst);
+		errno = saved;
+		return -1;
+	}
+	if (adjust_shared_perm(repo, dst))
+		return -1;
+	return 0;
+#else
+	/* No reflink primitive on this platform. */
+	(void)repo;
+	(void)dst;
+	(void)src;
+	(void)mode;
+	errno = ENOSYS;
+	return -1;
+#endif
+}
diff --git a/copy.h b/copy.h
index 1059b118d6..b9168a24f1 100644
--- a/copy.h
+++ b/copy.h
@@ -11,4 +11,18 @@ int copy_file(struct repository *repo,
 int copy_file_with_time(struct repository *repo,
 			const char *dst, const char *src, int mode);
 
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
+int reflink_file(struct repository *repo,
+		 const char *dst, const char *src, int mode);
+
 #endif /* COPY_H */
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index bdcca97633..4aa63c5d3f 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -1288,4 +1288,100 @@ test_expect_success 'relative worktree sets extension config' '
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
+#
+# GNU cp probes with --reflink=always. macOS cp has no such option; -c
+# is clonefile(2), which is what the APFS CI jobs exercise.
+test_lazy_prereq REFLINK '
+	echo probe >reflink-src &&
+	if test_have_prereq MACOS
+	then
+		cp -c reflink-src reflink-dst 2>/dev/null
+	else
+		cp --reflink=always reflink-src reflink-dst 2>/dev/null
+	fi
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
+		test_grep "?? untracked.bin" status
+	)
+'
+
 test_done
-- 
gitgitgadget

