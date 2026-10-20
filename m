Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792512252;
	b=XmC60ZiOCoJ3zVWv/x/h9XlTxew0Fg9J+p+O8XI1MM55nr9WL2lwGUdjtx9nPh0Y4hkS
	 UuaG8Dkpx9H4358D9uoUqP/tJxrOfnWo0JGKDZKj/zLeuOf5qKpJVBO/lZ3mjqVLG2Td0
	 /D8J0pFvPd7ZTfa6/1L9iauwDB+MZaRcCTBGYxg50nWvqufZk+M+L2hHZuPDOmCwLkl2o
	 mCP3jnyv86KBFLW74QisfD1Ef9T0YPX/xV6Ed07j1Gc46QJDsYdPUi3aUHBccybe4dClq
	 QteenpiJek8fziOMkmoEeHZY4HrWmJTwhdPrx35QJMikAyXjTNdCE7CSjmUAoPzE6Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792512252;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=mr0h/H2Al6lamuYTkAWZBjYZ5bNNJB99WgLwakMLXY0=;
	b=0FvTt9llgrrkxY5rCp6J5S1ckmiTHpMoNu+1HHJowplNKV64L+EkMiK6ju3lNTjKSATM
	 WzTXm1x9pt+Zfn0jp7VnVclz2Uno1ooGPZeBIcGzIw+Kr3gZIxYmdkCTjh+mo+Zn5Wwwx
	 FZXriMYAHBEedP4tJrvogE4mutr+kYwz3dK7IHdWhP0568gzdUWpBE2mTD92YDUq3Wv5Y
	 ohT3LU0cpFJm7LfdcnkgUx7wvlMUaeemBfjuCsusNXtaRLILHMZfI/cMIR5E9Fn/ZQPDQ
	 j0Mx9g552Asmb56SJS/5IQkFd82Om/rW2T20iQ4jeJ4H3ZgJ+OTk+H3J5+/MRMPHqAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ifa6HL4h;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AB1606A31B
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 16:04:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2AB1606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ifa6HL4h
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-35943f55c06so1264872eec.0
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 09:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792512251; x=1793117051; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mr0h/H2Al6lamuYTkAWZBjYZ5bNNJB99WgLwakMLXY0=;
        b=Ifa6HL4hypu7q1ERRkKk33Y08YlGMS49MSDjWxiW8yopifbOa1AvO3Du9IuFI7nY95
         xPj3p7FP6RL4teFzTQzJdnfzPf5dMVnfxUYjpQcSeK1LGZXzP/BCMGz5VrAwdiWWllRq
         M+UWNZmp8vj/Ir7+UI2jwe4uHakPKfBEh8MysRq0TNBS4IsskOdDCmnhZHrXk92cE7p5
         ISBm+D5VeIkJLrzHiAmIOnoiyIgd0GjrQ0tRcMYD6UqIIGzQC4yHNBb/M8Htdk3vvSbH
         UIOR3+23oy+Hnexy7eAvav55by2BvLkTRUpUrGrFPyi1zkxki+Qu5jX+SRpoaOmmjCR0
         sBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792512251; x=1793117051;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mr0h/H2Al6lamuYTkAWZBjYZ5bNNJB99WgLwakMLXY0=;
        b=DMjuJ8rLITd8KHRxa7sbo80mZmefJAu5uqG/xv/hiPC8EBs6cJCpfacXYCj8pWmdfK
         irLIWSr6SWBgsUA/isZ3xB3e0PTPXtUtlqQdo747M7L9DlttyGD/ZMN3PGkDwm3vln46
         fb0xkEEbgezIvHffFuEvv4ChG/E1Q6sdCFR/GflI6D3QIeAzJZ4ESxvJRCDhgUCtofZ+
         XfQpVt3PElxfKblU2dqXpqMk9Iz9DXfQrgQ4ihtWZuY+HCkYBPZP9LnkhxNLUeFD4ChH
         KVoXLUes4yTAtFZ7phNLkwSpYeOIUX71/IBT+cgnaT8sipJaj6pqpUfaBjhZ49gTsIlu
         JlsA==
X-Gm-Message-State: AFq9FYIZbQdeERo96WBL4UKpX8qrPr6Fioo6PBFVQ7hsQDcIZ7zaxkq/
	XzWED/dBFhCXKq3HI/185z3JMqqB2dYrnq1TZ5N8tK9mAmK57vXKyi5Z5V2wFQ==
X-Gm-Gg: AYBFou0KN70sgGV6xZKMAIWT+COMD76EnsiWc7zCp7x/LOXBxfrw96wZv/0uUjOlL+2
	u6PKBG9i8BoUaEldSbIge/xu0lDKwsXNRcpBUj2CC6Gxa3EesgXmuzwxdIY8/rcWQAMMKEoBLgr
	01RxeIwOzEajxplt3XEMmbK6nVeWUIFIVMaEM/sIoMGb8UJi4CaxJkMma07NTpQNmcYXugp7/3f
	Vpj24R2GpJmenA2VQZiwqC0bRnsuUVeRuhIMEGqTNjofOGRgbZaApVdHr6gCHjpTlwav4KWnfge
	eKfY9gf3XPkzuuwvqr66ydfAVKXzvWWchQ0krx1hg2JSKhSkpKf2ARwIE4k0HuCc+ExXTVLhvBU
	kx4IOutddRV3N/V1Z3k80mX1Rie3+Hm5RFhzae1XJmhOoQvtMft7fda3QCY8Ac8Tn6FleLKz8ud
	2PgKqxfCuTyoDlfKYEe8wUlxZZZ2FAmbss6u3kd5XdZbqZ05XcFgW/BUl8qyNRW0/G/lXqOwL9Y
	fQFBejgtA==
X-Received: by 2002:a05:7301:1408:b0:353:ba38:789d with SMTP id 5a478bee46e88-365f53e0019mr3039246eec.0.1792512250426;
        Tue, 20 Oct 2026 09:04:10 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.71.72])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3607ee0d391sm42788094eec.4.2026.10.20.09.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 09:04:09 -0700 (PDT)
Message-Id: <pull.2317.v2.git.git.1792512249.gitgitgadget@gmail.com>
In-Reply-To: <pull.2317.git.git.1780685368.gitgitgadget@gmail.com>
References: <pull.2317.git.git.1780685368.gitgitgadget@gmail.com>
From: "Jason Newton via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 20 Oct 2026 16:04:07 +0000
Subject: [PATCH v2 0/2] worktree: copy-on-write creation and ephemeral branches
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
    Jason Newton <nevion@gmail.com>

When many worktrees share one repository -- for example a fleet of agents
each needing an isolated checkout -- "git worktree add" is costly at scale.
Objects are shared via the common directory, but the working tree is not:
each add rewrites every tracked file, so N worktrees cost N full checkouts
of disk and I/O. A branch created only to back one of those worktrees is
also left behind when the worktree is removed.

Patch 1 adds "git worktree add --reflink". On a copy-on-write filesystem it
populates the new worktree by reflinking the current worktree's files and
index, then "git reset --hard" rewrites only the paths that differ from .
reflink_file() in copy.c uses FICLONE (Linux), clonefile() (macOS), and ReFS
block cloning (FSCTL_DUPLICATE_EXTENTS_TO_FILE, as Git LFS does). Elsewhere
it is probed up front and falls back to a normal checkout. worktree.reflink
(true/false/auto) sets the default; --no-reflink overrides.

Uncommitted edits to tracked files in the source do not leak into the new
worktree. The copied index is refreshed before reset, and because every
reflinked file is a new inode the refresh re-validates by content. Only
untracked files are carried over. The option stays opt-in for that reason:
it copies the source's untracked and ignored files, which a plain checkout
does not.

For many worktrees at one commit, the series does not share a branch.
git-worktree(1) shows a single update-ref transaction that creates a ref per
worktree (or a detached HEAD). A shared branch still lets a stale index in
one worktree silently revert a commit made in another.

Patch 2 treats a branch that "git worktree add " created itself as owned by
that worktree. "git worktree remove" deletes it. Branches named with -b/-B,
or that already existed, are left alone. --keep-branch keeps an owned
branch.

Changes since v1:

 * Dropped the patch that allowed one branch to be checked out in several
   worktrees. Documented the per-ref / detached-HEAD pattern instead (brian
   m. carlson, Junio).
 * Explained, in the commit message and the manual, why a dirty source
   worktree does not leak tracked content (brian m. carlson).
 * Added the ReFS block-cloning arm (brian m. carlson).
 * Noted overlayfs as a supported setup when the lower filesystem supports
   reflinks (brian m. carlson).
 * Kept --reflink opt-in. A whole-tree reflink is not invisible: it carries
   untracked files, and cloning every file can be slower than checkout when
   the files are small (Junio; qub1n on the ReFS work).
 * Rebased onto 47fdf2208c ("The 7th batch"). reflink_file() now takes a
   repository argument, matching copy_file().
 * Added ephemeral-branch reaping for the auto-named branch that "worktree
   add " creates.

Jason Newton (2):
  worktree: add --reflink for copy-on-write worktree creation
  worktree: reap ephemeral branches created by "worktree add"

 Documentation/config/worktree.adoc |  10 +
 Documentation/git-worktree.adoc    |  71 ++++++-
 builtin/branch.c                   |  28 +++
 builtin/worktree.c                 | 301 ++++++++++++++++++++++++++++-
 copy.c                             | 190 ++++++++++++++++++
 copy.h                             |  14 ++
 t/t2400-worktree-add.sh            | 143 ++++++++++++++
 t/t3200-branch.sh                  |   2 +-
 t/t3400-rebase.sh                  |   2 +-
 t/t5516-fetch-push.sh              |   2 +-
 10 files changed, 754 insertions(+), 9 deletions(-)


base-commit: 47fdf2208c5b94c8cc01c106b8f7c85efb91c926
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2317%2Fnevion%2Fworktree-reflink-cow-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2317/nevion/worktree-reflink-cow-v2
Pull-Request: https://github.com/git/git/pull/2317

Range-diff vs v1:

 1:  7dbd9ca94f ! 1:  83841020f4 worktree: add --reflink for copy-on-write worktree creation
     @@ Commit message
          via the common directory, but the working tree is not: N worktrees
          mean N full checkouts on disk and N times the file I/O.
      
     -    Add a "--reflink" option that, on copy-on-write filesystems, populates
     +    Add a "--reflink" option that, on a copy-on-write filesystem, populates
          the new worktree by reflinking the current worktree's files and index
          instead. The subsequent "git reset --hard" then only rewrites the
          paths that actually differ between the current worktree and
          <commit-ish>; everything else (including untracked files such as build
     -    outputs) keeps sharing storage with the source until modified. Because
     -    the cloned index still carries the source files' stat data, it is
     -    refreshed against the reflinked files first so that reset recognizes
     -    the unchanged paths as up to date and leaves them sharing extents
     -    rather than rewriting them.
     +    outputs) keeps sharing storage with the source until modified.
      
     -    The clones are made by a new reflink_file() helper in copy.c, which
     -    uses the FICLONE ioctl on Linux and clonefile() on macOS and reports
     -    an error otherwise so callers fall back to a normal copy. Support is
     -    probed up front; when unavailable -- including on filesystems without
     -    copy-on-write and on platforms such as Windows that lack a reflink
     -    primitive -- "--reflink" transparently falls back to an ordinary
     -    checkout, so the worst case is no slower than today rather than a
     -    byte-for-byte copy of the source tree. The directory walk skips the
     -    new worktree itself when it lives inside the source one, and preserves
     -    symlinks and modes.
     +    A new reflink_file() helper in copy.c clones every regular file. There
     +    is no size cutoff.
     +
     +    On Linux it uses the FICLONE ioctl. That is the primitive btrfs, XFS
     +    and bcachefs implement, and the one overlayfs forwards when the lower
     +    filesystem can clone. This path has been tested on btrfs.
     +
     +    On macOS it uses clonefile(), the APFS primitive. That path is
     +    implemented and has not been run here.
     +
     +    On Windows it uses ReFS block cloning,
     +    FSCTL_DUPLICATE_EXTENTS_TO_FILE, as Git LFS does. The destination is
     +    sized to the source, extents are cloned in chunks of at most 1GiB, and
     +    the tail is rounded up to a cluster (64K, then 4K) and cloned; Windows
     +    ignores the range past EOF. The tail is not byte-copied, and small
     +    files are not skipped. That path is implemented and has not been run
     +    on ReFS. A volume that rejects the control code, including NTFS, fails
     +    the probe.
     +
     +    Anywhere else there is no reflink primitive. Support is probed up front
     +    by cloning a one-byte file, and where that fails "--reflink" falls back
     +    to an ordinary checkout instead of byte-copying the source tree. The
     +    directory walk skips the new worktree itself when it lives inside the
     +    source one, and preserves symlinks and modes.
     +
     +    Uncommitted changes in the source do not leak into the new worktree.
     +    After reflinking the source's files we copy its index and run
     +    "update-index --refresh" before "reset --hard": because every reflinked
     +    file is a fresh inode, the cached stat never matches, so the refresh is
     +    forced to re-validate by content rather than by stat. A tracked path is
     +    therefore only left sharing extents when its content equals the indexed
     +    object; any path whose content differs from <commit-ish> -- which
     +    includes every uncommitted modification in the source -- is rewritten
     +    by the reset. The new worktree is thus always a faithful checkout of
     +    <commit-ish> for tracked paths, and only untracked files are carried
     +    over.
      
          The behavior can be made the default with the worktree.reflink
          configuration ("true", "false" or "auto", the last suppressing the
          unsupported-filesystem warning), and turned off per-invocation with
          --no-reflink. A configured default degrades quietly in modes that
          cannot reflink (--orphan, --no-checkout) instead of erroring, so
     -    enabling it never breaks those commands. The checkout step continues
     -    to honor checkout.workers, so parallel checkout composes with
     -    --reflink for the paths that do need rewriting.
     +    enabling it never breaks those commands. The checkout step continues to
     +    honor checkout.workers, so parallel checkout composes with --reflink for
     +    the paths that do need rewriting.
     +
     +    To check out many worktrees at the same commit safely, give each its
     +    own ref (or a detached HEAD) rather than sharing one branch; a
     +    git-worktree(1) example shows the one-shot "update-ref" transaction
     +    that pairs with --reflink.
      
          Signed-off-by: Jason Newton <nevion@gmail.com>
      
     @@ Documentation/git-worktree.adoc: To remove a locked worktree, specify `--force`
      +	worktrees from the same base. `--no-reflink` forces an ordinary
      +	checkout, overriding the `worktree.reflink` configuration.
      ++
     -+Reflinks require a copy-on-write filesystem (for example btrfs, XFS,
     -+bcachefs or ZFS on Linux, or APFS on macOS). On filesystems or platforms
     -+that do not support reflinks, `--reflink` transparently falls back to an
     -+ordinary checkout. Because the source worktree's untracked and ignored
     -+files are cloned as well, only use `--reflink` when that is acceptable.
     ++Reflinks require a copy-on-write filesystem: for example btrfs, XFS,
     ++bcachefs or ZFS on Linux (and overlayfs on top of one of these, as used by
     ++containers), APFS on macOS, or ReFS on Windows. On a filesystem that does
     ++not support reflinks, `--reflink` transparently falls back to an ordinary
     ++checkout. Because the source worktree's untracked and ignored files are
     ++cloned as well, only use `--reflink` when that is acceptable.
      ++
      +This option cannot be combined with `--no-checkout` or `--orphan`. It can
      +be enabled by default with the `worktree.reflink` configuration; see
     @@ Documentation/git-worktree.adoc: To remove a locked worktree, specify `--force`
       `--guess-remote`::
       `--no-guess-remote`::
       	With `worktree add <path>`, without _<commit-ish>_, instead
     +@@ Documentation/git-worktree.adoc: $ popd
     + $ git worktree remove ../temp
     + ------------
     + 
     ++To run several independent worktrees from the same starting commit -- for
     ++example a pool of automated agents -- give each one its own branch rather than
     ++sharing a single branch between them. A shared branch is unsafe here: if one
     ++worktree commits and another then commits from its now-stale index, the second
     ++commit silently drops the first one's changes. Create the branches in a single
     ++ref transaction and check each out in its own (optionally reflinked) worktree:
     ++
     ++------------
     ++$ oid=$(git rev-parse HEAD)
     ++$ printf 'create refs/heads/agent-%s %s\n' 1 "$oid" 2 "$oid" 3 "$oid" |
     ++	git update-ref --stdin
     ++$ for n in 1 2 3; do git worktree add --reflink ../agent-$n agent-$n; done
     ++------------
     ++
     ++The single linkgit:git-update-ref[1] transaction is cheap and is especially
     ++efficient with the `reftable` backend. If a worktree does not need to advance a
     ++branch at all, use a detached `HEAD` (`git worktree add --detach`) instead.
     ++
     + CONFIGURATION
     + -------------
     + 
      
       ## builtin/worktree.c ##
      @@
     @@ builtin/worktree.c: worktree_copy_cleanup:
       
      +/*
      + * Probe whether the filesystem backing "dir" supports reflinks. We do this
     -+ * once up front so that, on filesystems without copy-on-write support (or on
     -+ * platforms such as Windows that lack a reflink primitive entirely), we can
     ++ * once up front so that, on filesystems without copy-on-write support (and on
     ++ * platforms that lack a reflink primitive entirely), we can
      + * fall back to a normal checkout instead of byte-copying the whole source
      + * working tree -- which would include untracked files and be slower than the
      + * checkout we are trying to avoid.
     @@ builtin/worktree.c: worktree_copy_cleanup:
      +	if (fd >= 0) {
      +		write_in_full(fd, "x", 1);
      +		close(fd);
     -+		if (!reflink_file(dst.buf, src.buf, 0600))
     ++		if (!reflink_file(the_repository, dst.buf, src.buf, 0600))
      +			ok = 1;
      +		unlink(dst.buf);
      +	}
     @@ builtin/worktree.c: worktree_copy_cleanup:
      + */
      +static int reflink_or_copy(const char *dst, const char *src, int mode)
      +{
     -+	if (!reflink_file(dst, src, mode))
     ++	if (!reflink_file(the_repository, dst, src, mode))
      +		return 0;
     -+	return copy_file(dst, src, mode);
     ++	return copy_file(the_repository, dst, src, mode);
      +}
      +
      +/*
     @@ copy.c
      +#elif defined(__APPLE__)
      +#include <sys/attr.h>
      +#include <sys/clonefile.h>
     ++#elif defined(GIT_WINDOWS_NATIVE)
     ++#include <winioctl.h>
     ++/*
     ++ * Block cloning on ReFS uses FSCTL_DUPLICATE_EXTENTS_TO_FILE. Older Windows
     ++ * SDK headers may lack the control code and its payload struct, so define
     ++ * them ourselves when missing (the values are part of the stable Win32 API).
     ++ */
     ++#ifndef FSCTL_DUPLICATE_EXTENTS_TO_FILE
     ++#define FSCTL_DUPLICATE_EXTENTS_TO_FILE \
     ++	CTL_CODE(FILE_DEVICE_FILE_SYSTEM, 209, METHOD_BUFFERED, FILE_WRITE_DATA)
     ++typedef struct _DUPLICATE_EXTENTS_DATA {
     ++	HANDLE FileHandle;
     ++	LARGE_INTEGER SourceFileOffset;
     ++	LARGE_INTEGER TargetFileOffset;
     ++	LARGE_INTEGER ByteCount;
     ++} DUPLICATE_EXTENTS_DATA, *PDUPLICATE_EXTENTS_DATA;
     ++#endif
      +#endif
      +
       int copy_fd(int ifd, int ofd)
       {
       	while (1) {
     -@@ copy.c: int copy_file_with_time(const char *dst, const char *src, int mode)
     +@@ copy.c: int copy_file_with_time(struct repository *repo,
       		return copy_times(dst, src);
       	return status;
       }
      +
     -+int reflink_file(const char *dst, const char *src, int mode)
     ++#ifdef GIT_WINDOWS_NATIVE
     ++/*
     ++ * Clone [offset, offset+count) of "src" onto "dst" via ReFS block cloning.
     ++ * "count" is rounded up to a cluster boundary by the caller; a range that
     ++ * runs past the source's end of file is harmless and ignored by Windows.
     ++ */
     ++static int clone_extent_windows(HANDLE dst, HANDLE src,
     ++				uint64_t offset, uint64_t count)
     ++{
     ++	DUPLICATE_EXTENTS_DATA dup;
     ++	DWORD bytes;
     ++
     ++	dup.FileHandle = src;
     ++	dup.SourceFileOffset.QuadPart = offset;
     ++	dup.TargetFileOffset.QuadPart = offset;
     ++	dup.ByteCount.QuadPart = count;
     ++	if (!DeviceIoControl(dst, FSCTL_DUPLICATE_EXTENTS_TO_FILE,
     ++			     &dup, sizeof(dup), NULL, 0, &bytes, NULL))
     ++		return -1;
     ++	return 0;
     ++}
     ++#endif
     ++
     ++int reflink_file(struct repository *repo,
     ++		 const char *dst, const char *src, int mode)
      +{
      +#if defined(__APPLE__)
      +	/*
     @@ copy.c: int copy_file_with_time(const char *dst, const char *src, int mode)
      +	(void)mode;
      +	if (clonefile(src, dst, 0) < 0)
      +		return -1;
     -+	if (adjust_shared_perm(the_repository, dst))
     ++	if (adjust_shared_perm(repo, dst))
      +		return -1;
      +	return 0;
      +#elif defined(__linux__)
     @@ copy.c: int copy_file_with_time(const char *dst, const char *src, int mode)
      +	}
      +	if (close(fdo) != 0)
      +		return -1;
     -+	if (adjust_shared_perm(the_repository, dst))
     ++	if (adjust_shared_perm(repo, dst))
     ++		return -1;
     ++	return 0;
     ++#elif defined(GIT_WINDOWS_NATIVE)
     ++	/*
     ++	 * ReFS supports copy-on-write block cloning via
     ++	 * FSCTL_DUPLICATE_EXTENTS_TO_FILE, the same mechanism Git LFS uses.
     ++	 * Cloned ranges must start and end on a cluster boundary (ReFS uses
     ++	 * 64K or 4K clusters) and span less than 4GiB, so clone in <=1GiB
     ++	 * chunks and round the final chunk up to a cluster; the destination is
     ++	 * sized to the source's exact length and an over-long final range past
     ++	 * the source's EOF is ignored.
     ++	 */
     ++	const uint64_t GiB = (uint64_t)1 << 30;
     ++	const uint64_t clusters[] = { 64 * 1024, 4 * 1024 };
     ++	int fdi, fdo, ret = -1;
     ++	HANDLE hi, ho;
     ++	LARGE_INTEGER size;
     ++	uint64_t off;
     ++	size_t i;
     ++
     ++	mode = (mode & 0111) ? 0777 : 0666;
     ++	if ((fdi = open(src, O_RDONLY | O_BINARY)) < 0)
     ++		return -1;
     ++	if ((fdo = open(dst, O_RDWR | O_CREAT | O_EXCL | O_BINARY, mode)) < 0) {
     ++		int saved = errno;
     ++		close(fdi);
     ++		errno = saved;
     ++		return -1;
     ++	}
     ++	hi = (HANDLE)_get_osfhandle(fdi);
     ++	ho = (HANDLE)_get_osfhandle(fdo);
     ++	if (hi == INVALID_HANDLE_VALUE || ho == INVALID_HANDLE_VALUE ||
     ++	    !GetFileSizeEx(hi, &size)) {
     ++		errno = EINVAL;
     ++		goto cleanup;
     ++	}
     ++
     ++	/* the destination must be the source's exact size before cloning */
     ++	if (!SetFilePointerEx(ho, size, NULL, FILE_BEGIN) || !SetEndOfFile(ho)) {
     ++		errno = EIO;
     ++		goto cleanup;
     ++	}
     ++
     ++	ret = 0;
     ++	/* clone whole 1GiB regions (already cluster aligned) */
     ++	for (off = 0; (uint64_t)size.QuadPart > off &&
     ++		      (uint64_t)size.QuadPart - off > GiB; off += GiB) {
     ++		if (clone_extent_windows(ho, hi, off, GiB)) {
     ++			errno = ENOSYS;
     ++			ret = -1;
     ++			goto cleanup;
     ++		}
     ++	}
     ++	/* clone the tail, rounding its length up to a cluster (64K then 4K) */
     ++	if (!ret && (uint64_t)size.QuadPart > off) {
     ++		uint64_t rem = (uint64_t)size.QuadPart - off;
     ++
     ++		ret = -1;
     ++		for (i = 0; i < ARRAY_SIZE(clusters); i++) {
     ++			uint64_t count = (rem + clusters[i] - 1) &
     ++					 ~(clusters[i] - 1);
     ++			if (!clone_extent_windows(ho, hi, off, count)) {
     ++				ret = 0;
     ++				break;
     ++			}
     ++		}
     ++		if (ret)
     ++			errno = ENOSYS;	/* not a CoW volume */
     ++	}
     ++
     ++cleanup:
     ++	close(fdi);
     ++	if (close(fdo) && !ret) {
     ++		errno = EIO;
     ++		ret = -1;
     ++	}
     ++	if (ret) {
     ++		int saved = errno;
     ++		unlink(dst);
     ++		errno = saved;
     ++		return -1;
     ++	}
     ++	if (adjust_shared_perm(repo, dst))
      +		return -1;
      +	return 0;
      +#else
     -+	/* No reflink support on this platform (e.g. Windows). */
     ++	/* No reflink primitive on this platform. */
     ++	(void)repo;
      +	(void)dst;
      +	(void)src;
      +	(void)mode;
     @@ copy.c: int copy_file_with_time(const char *dst, const char *src, int mode)
      +}
      
       ## copy.h ##
     -@@ copy.h: int copy_fd(int ifd, int ofd);
     - int copy_file(const char *dst, const char *src, int mode);
     - int copy_file_with_time(const char *dst, const char *src, int mode);
     +@@ copy.h: int copy_file(struct repository *repo,
     + int copy_file_with_time(struct repository *repo,
     + 			const char *dst, const char *src, int mode);
       
      +/*
      + * Create "dst" as a copy-on-write (reflink) clone of the regular file
     @@ copy.h: int copy_fd(int ifd, int ofd);
      + * ENOSYS (or the underlying error). Callers are expected to fall back to
      + * copy_file() in that case. Returns 0 on success.
      + */
     -+int reflink_file(const char *dst, const char *src, int mode);
     ++int reflink_file(struct repository *repo,
     ++		 const char *dst, const char *src, int mode);
      +
       #endif /* COPY_H */
      
     @@ t/t2400-worktree-add.sh: test_expect_success 'relative worktree sets extension c
      +		echo artifact >expect &&
      +		test_cmp expect wt/untracked.bin &&
      +		git -C wt status --porcelain >status &&
     -+		grep "?? untracked.bin" status
     ++		test_grep "?? untracked.bin" status
      +	)
      +'
      +
 2:  97f0fdad9b < -:  ---------- worktree: allow sharing a checked-out branch across worktrees
 -:  ---------- > 2:  6e2acdc5e2 worktree: reap ephemeral branches created by "worktree add"

-- 
gitgitgadget
