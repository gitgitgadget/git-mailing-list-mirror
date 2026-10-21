Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792567074;
	b=m91NPNHqUSoOp4Gg8qfsqT6Hy5JXrS3uJyFJjHSHsEZUaL3S7Ou3ns7E0F9iF6tyLh5g
	 omLKSNCIpve6mhvHsQTN4hFCsf+UCHf5GYAe+zC+1wESP6QdHhLEkFd3Sf+UfZ05mxqn+
	 DvnOAiPhUDbWHLf9H5CYLQ6bWg0WEBwX3UeufTHxER4xBDayGfnFMTp3GVZxFPIlfkBNH
	 KepXNxQXmM1ovRv+qO/xZ76D2mx2/ozSDVr/qU5RyK6uHA42/4X3vJz2SiXwYAPLil6wB
	 iT6ov/2i3znnedh46Uu/Fa4Tb1VGVq5SylAzXQ1yPJAl/ylA6/HbNbmuMpp8IVLXwjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792567074;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=zd0yTAPxrECKhT+XG3a25TIq6eKLTrHiDSApASmUd48=;
	b=p2TMH/smXbqkjjztAw2iAkUI4ChFyM//DqIMey/cNXTlMKr741Y1NSzJPFuZr/mdou0P
	 SBYtL6+gEmG7ISVsDDAWUSK7HPsgQQtMexM34hkWxh8TqDV07csZ329gSn2MOFhGkVQlY
	 MP99vXfHs4MY5WWwifiEH8A5CiqNmvRFoAGvCni4mhIPcXSFUjhtM/+32cJXws194k1R1
	 LDQmDxY6EpU7jBKxvJAkfPgbtrfi56fyKcDQdmTiEgQwtNKIEk/CP//SKGPh7tGFq3Jl1
	 EIFOcU7o2l3XdKkqCvQxKlD04QXYcvLLSq8xLqWzW3u4S+jx3lAN4sk85qN59EY2eLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HWo0MzVl;
	arc=none smtp.remote-ip=209.85.167.177
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB7B606A31D
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 07:17:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EB7B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HWo0MzVl
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4b190cdc9feso366836b6e.0
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 00:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792567073; x=1793171873; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zd0yTAPxrECKhT+XG3a25TIq6eKLTrHiDSApASmUd48=;
        b=HWo0MzVldxJPA4v1hvQ/05v3N+shpNQBmBmZVHKN3NQPzbmmuR/8ygeq8XwKPER3lR
         fecD48YbPrvORdGJiSz9d0up0SDt63+xKRcZiDCwhop/Je1KsdmcHHJW9DKwvIX75B7S
         RNJWQJT1Bcpy+e8CZ1DDT8uTI+cJscJJxb+H4zpIxHsPHCU+bpVaoj/fmBBz3nymM6zQ
         Guw45aQWNJvTrsfebmTzpBB6SToqCtK95w7DcxvD1Q6SfKapeOi5xjVn7QOTLgBOssos
         zz+hz9DWTYDs2fnROuMX4w8AYjNTdWixYE2OCvjV8HAppKOpjrry0Mx7VyLnpmgVydSq
         F7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792567073; x=1793171873;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zd0yTAPxrECKhT+XG3a25TIq6eKLTrHiDSApASmUd48=;
        b=Bpr1F9Lg8qJrlJYgR2KCBvnEmGPe0ewo7B9Y3dOTpBjG6rWGxlTcfBziHEsY5MNELV
         oTuRQaJGjnM4mhwkL+98Eh80VBFNgD4lX/0TxGjYFwuunVZchwJr39UFfTDdpaoGA2xK
         y0HL4/KHXSo/znMKQeRdCr4MOKU3299M94ZxmSJqvkojmiez/nye2G1SRHJ8Il2ylqad
         jUJQUXvW2WF1NBRJYbhPVrtCiH5PDVY9tKQ11HDxur/yjeJceQ3md3Azr1OwFpdTPd1w
         7mC5zolUmlNpmLoJfQYXdR+5KjbifQ4/xtrnEGsux8RLgCXGAoV9i91Fn0tYnaziKZuw
         gOag==
X-Gm-Message-State: AFq9FYJgiHriHSjIl8aaw55c6dKWqFX1QKN7lhgz4mXf48sD3Cd9x7qg
	HtQl5G5EhUyB3bo7nvX/mQzi7szvDgcXvM7ryTjIpEOVYPWMIBDvh8J9Z1iMyw==
X-Gm-Gg: AYBFou18sNpvlZUum0hqKVbkncE6Y4yRyeWeA7ERHA7VVm5f2ZWyIDKzk8R0Yhu5NNq
	tlHUuPTEh8vbbqbOGFLVX4IJvtEsXvCGGhuXcA1Q9f+bHxOh4Ng9xuoyGjvSfy7FuWwoQkjQj53
	myoI0xymt9+6i1Mfpz4HsvwmEHfXZmz2+m4o7k7EdIawRIg/4jBrXrJa/sXS4QCvPHxpkwLtT7b
	ZHO+RfZlSPp462SzAF5JMAs0+Qz0ldN8Pocq/1AAGWwI9Y95trlUfhSanKo1IO9KQ1BsTtyZ96K
	/iLqH/WoW5BEFk8ECWkXuA5cD1kpFZrPRWCnSTwMW5gHamVk/dL1lMpc+60n+G3Sg5Zknc07ES0
	DaSmQa8Svy7UojLXo3YDPZomOm9fqLjE22mf86cny8Haj1tpjAHLAhPpZdsBGCtAsSl7/omGntO
	7DXWYf40l+TjT2HyI81Tr5MnFa9YpCWQ9QcNJO8PkrmDEL1LdJZ8YwEejsdQNo93nc3IbFZYQrI
	BTTK4SiGKck3TZmT7FpYMzWMMdSiceJMCsO0sP00sQj4dtqZRu00DQV61SE
X-Received: by 2002:a05:6808:14d2:b0:4fa:95f4:3334 with SMTP id 5614622812f47-5535bea38famr680342b6e.42.1792567072914;
        Wed, 21 Oct 2026 00:17:52 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.140.214])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-552a182d59bsm1385276b6e.0.2026.10.21.00.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 00:17:51 -0700 (PDT)
Message-Id: <91806975a6909265b1325206ef2f33a169393920.1792567061.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2317.v3.git.git.1792567061.gitgitgadget@gmail.com>
References: <pull.2317.git.git.1780685368.gitgitgadget@gmail.com>
	<pull.2317.v3.git.git.1792567061.gitgitgadget@gmail.com>
From: "Jason Newton via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 21 Oct 2026 07:17:40 +0000
Subject: [PATCH v3 3/4] worktree: disable reflink on Windows
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

FSCTL_DUPLICATE_EXTENTS_TO_FILE can publish zeros when the source
data is still cached. git-lfs issue 6312 reports that on Windows 11
build 26200, and a later reproduction hit build 26200.9448. No fixed
Windows build is identified, so reflink_file() refuses on every
Windows version.

git worktree add --reflink and worktree.reflink=true warn with that
build number and fall back to a regular checkout. worktree.reflink=auto
stays silent, as it does when the filesystem cannot reflink.

Signed-off-by: Jason Newton <nevion@gmail.com>
---
 Documentation/config/worktree.adoc |   6 +-
 Documentation/git-worktree.adoc    |  12 ++-
 builtin/worktree.c                 |  13 +++
 copy.c                             | 133 +++--------------------------
 t/t2400-worktree-add.sh            |  15 ++++
 5 files changed, 53 insertions(+), 126 deletions(-)

diff --git a/Documentation/config/worktree.adoc b/Documentation/config/worktree.adoc
index aa849c08d2..e221efc615 100644
--- a/Documentation/config/worktree.adoc
+++ b/Documentation/config/worktree.adoc
@@ -25,6 +25,8 @@ thus making it incompatible with older versions of Git.
 	(see linkgit:git-worktree[1]). May be set to "`true`", "`false`"
 	(the default), or "`auto`". With "`true`", a filesystem that does
 	not support reflinks produces a warning before falling back to an
-	ordinary checkout; with "`auto`", the fallback is silent. An
-	explicit `--reflink` or `--no-reflink` on the command line
+	ordinary checkout; with "`auto`", the fallback is silent. On Windows
+	the request always falls back. An explicit request warns that block
+	cloning can zero-fill files on Windows build 26200; "`auto`" stays
+	silent. An explicit `--reflink` or `--no-reflink` on the command line
 	overrides this setting.
diff --git a/Documentation/git-worktree.adoc b/Documentation/git-worktree.adoc
index 99e6e55be4..6cc7c1f27a 100644
--- a/Documentation/git-worktree.adoc
+++ b/Documentation/git-worktree.adoc
@@ -244,10 +244,14 @@ To remove a locked worktree, specify `--force` twice.
 +
 Reflinks require a copy-on-write filesystem: for example btrfs, XFS,
 bcachefs or ZFS on Linux (and overlayfs on top of one of these, as used by
-containers), APFS on macOS, or ReFS on Windows. On a filesystem that does
-not support reflinks, `--reflink` transparently falls back to an ordinary
-checkout. Because the source worktree's untracked and ignored files are
-cloned as well, only use `--reflink` when that is acceptable.
+containers), or APFS on macOS. Reflink is disabled on Windows. ReFS block
+cloning can zero-fill files on Windows build 26200 (git-lfs issue 6312),
+and no fixed build is known. On Windows, `--reflink` falls back to an
+ordinary checkout and, unless `worktree.reflink` is `auto`, warns with
+that build number. On a filesystem that does not support reflinks,
+`--reflink` transparently falls back to an ordinary checkout. Because the
+source worktree's untracked and ignored files are cloned as well, only use
+`--reflink` when that is acceptable.
 +
 This option cannot be combined with `--no-checkout` or `--orphan`. It can
 be enabled by default with the `worktree.reflink` configuration; see
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 1059429cbb..93fcaa5ecd 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -563,6 +563,18 @@ static int reflink_worktree(const char *path, const char *wt_git_dir,
 		return error(_("--reflink needs a source working tree, but this "
 			       "repository does not have one"));
 
+#ifdef GIT_WINDOWS_NATIVE
+	/*
+	 * reflink_file() refuses on Windows. Build 26200 is the version
+	 * named in git-lfs issue 6312; no later build is known to be fixed.
+	 * Auto mode stays quiet, matching the non-Windows fallback.
+	 */
+	if (!opts->quiet && opts->reflink != REFLINK_AUTO)
+		warning(_("reflink is disabled on Windows; block cloning "
+			  "can zero-fill files on Windows build 26200; "
+			  "falling back to a regular checkout"));
+	return 1;
+#else
 	if (!reflink_supported(path)) {
 		/* In auto mode the fallback is expected, so stay quiet. */
 		if (!opts->quiet && opts->reflink != REFLINK_AUTO)
@@ -570,6 +582,7 @@ static int reflink_worktree(const char *path, const char *wt_git_dir,
 				  "falling back to a regular checkout"), path);
 		return 1;
 	}
+#endif
 
 	if (stat(path, &dst_st))
 		return error_errno(_("could not stat '%s'"), path);
diff --git a/copy.c b/copy.c
index e6dfe33f6a..2eb4c7477e 100644
--- a/copy.c
+++ b/copy.c
@@ -18,23 +18,6 @@
 #elif defined(__APPLE__)
 #include <sys/attr.h>
 #include <sys/clonefile.h>
-#elif defined(GIT_WINDOWS_NATIVE)
-#include <winioctl.h>
-/*
- * Block cloning on ReFS uses FSCTL_DUPLICATE_EXTENTS_TO_FILE. Older Windows
- * SDK headers may lack the control code and its payload struct, so define
- * them ourselves when missing (the values are part of the stable Win32 API).
- */
-#ifndef FSCTL_DUPLICATE_EXTENTS_TO_FILE
-#define FSCTL_DUPLICATE_EXTENTS_TO_FILE \
-	CTL_CODE(FILE_DEVICE_FILE_SYSTEM, 209, METHOD_BUFFERED, FILE_WRITE_DATA)
-typedef struct _DUPLICATE_EXTENTS_DATA {
-	HANDLE FileHandle;
-	LARGE_INTEGER SourceFileOffset;
-	LARGE_INTEGER TargetFileOffset;
-	LARGE_INTEGER ByteCount;
-} DUPLICATE_EXTENTS_DATA, *PDUPLICATE_EXTENTS_DATA;
-#endif
 #endif
 
 int copy_fd(int ifd, int ofd)
@@ -105,29 +88,6 @@ int copy_file_with_time(struct repository *repo,
 	return status;
 }
 
-#ifdef GIT_WINDOWS_NATIVE
-/*
- * Clone [offset, offset+count) of "src" onto "dst" via ReFS block cloning.
- * "count" is rounded up to a cluster boundary by the caller; a range that
- * runs past the source's end of file is harmless and ignored by Windows.
- */
-static int clone_extent_windows(HANDLE dst, HANDLE src,
-				uint64_t offset, uint64_t count)
-{
-	DUPLICATE_EXTENTS_DATA dup;
-	DWORD bytes;
-
-	dup.FileHandle = src;
-	dup.SourceFileOffset.QuadPart = offset;
-	dup.TargetFileOffset.QuadPart = offset;
-	dup.ByteCount.QuadPart = count;
-	if (!DeviceIoControl(dst, FSCTL_DUPLICATE_EXTENTS_TO_FILE,
-			     &dup, sizeof(dup), NULL, 0, &bytes, NULL))
-		return -1;
-	return 0;
-}
-#endif
-
 int reflink_file(struct repository *repo,
 		 const char *dst, const char *src, int mode)
 {
@@ -171,87 +131,20 @@ int reflink_file(struct repository *repo,
 	return 0;
 #elif defined(GIT_WINDOWS_NATIVE)
 	/*
-	 * ReFS supports copy-on-write block cloning via
-	 * FSCTL_DUPLICATE_EXTENTS_TO_FILE, the same mechanism Git LFS uses.
-	 * Cloned ranges must start and end on a cluster boundary (ReFS uses
-	 * 64K or 4K clusters) and span less than 4GiB, so clone in <=1GiB
-	 * chunks and round the final chunk up to a cluster; the destination is
-	 * sized to the source's exact length and an over-long final range past
-	 * the source's EOF is ignored.
+	 * ReFS block cloning (FSCTL_DUPLICATE_EXTENTS_TO_FILE) is disabled.
+	 * On Windows 11 build 26200 the ioctl remaps on-disk clusters, so a
+	 * clone of data still sitting in the cache captures unwritten zeros.
+	 * The later flush of the source does not update the clone, and the
+	 * zeros are permanent. That is git-lfs issue 6312, reproduced on
+	 * build 26200.9448. No fixed Windows build is identified, so refuse
+	 * on every Windows version and let the caller fall back to a copy.
 	 */
-	const uint64_t GiB = (uint64_t)1 << 30;
-	const uint64_t clusters[] = { 64 * 1024, 4 * 1024 };
-	int fdi, fdo, ret = -1;
-	HANDLE hi, ho;
-	LARGE_INTEGER size;
-	uint64_t off;
-	size_t i;
-
-	mode = (mode & 0111) ? 0777 : 0666;
-	if ((fdi = open(src, O_RDONLY | O_BINARY)) < 0)
-		return -1;
-	if ((fdo = open(dst, O_RDWR | O_CREAT | O_EXCL | O_BINARY, mode)) < 0) {
-		int saved = errno;
-		close(fdi);
-		errno = saved;
-		return -1;
-	}
-	hi = (HANDLE)_get_osfhandle(fdi);
-	ho = (HANDLE)_get_osfhandle(fdo);
-	if (hi == INVALID_HANDLE_VALUE || ho == INVALID_HANDLE_VALUE ||
-	    !GetFileSizeEx(hi, &size)) {
-		errno = EINVAL;
-		goto cleanup;
-	}
-
-	/* the destination must be the source's exact size before cloning */
-	if (!SetFilePointerEx(ho, size, NULL, FILE_BEGIN) || !SetEndOfFile(ho)) {
-		errno = EIO;
-		goto cleanup;
-	}
-
-	ret = 0;
-	/* clone whole 1GiB regions (already cluster aligned) */
-	for (off = 0; (uint64_t)size.QuadPart > off &&
-		      (uint64_t)size.QuadPart - off > GiB; off += GiB) {
-		if (clone_extent_windows(ho, hi, off, GiB)) {
-			errno = ENOSYS;
-			ret = -1;
-			goto cleanup;
-		}
-	}
-	/* clone the tail, rounding its length up to a cluster (64K then 4K) */
-	if (!ret && (uint64_t)size.QuadPart > off) {
-		uint64_t rem = (uint64_t)size.QuadPart - off;
-
-		ret = -1;
-		for (i = 0; i < ARRAY_SIZE(clusters); i++) {
-			uint64_t count = (rem + clusters[i] - 1) &
-					 ~(clusters[i] - 1);
-			if (!clone_extent_windows(ho, hi, off, count)) {
-				ret = 0;
-				break;
-			}
-		}
-		if (ret)
-			errno = ENOSYS;	/* not a CoW volume */
-	}
-
-cleanup:
-	close(fdi);
-	if (close(fdo) && !ret) {
-		errno = EIO;
-		ret = -1;
-	}
-	if (ret) {
-		int saved = errno;
-		unlink(dst);
-		errno = saved;
-		return -1;
-	}
-	if (adjust_shared_perm(repo, dst))
-		return -1;
-	return 0;
+	(void)repo;
+	(void)dst;
+	(void)src;
+	(void)mode;
+	errno = ENOSYS;
+	return -1;
 #else
 	/* No reflink primitive on this platform. */
 	(void)repo;
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 14bf455736..592f414955 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -1288,6 +1288,21 @@ test_expect_success 'relative worktree sets extension config' '
 	test_cmp_config -C repo true extensions.relativeworktrees
 '
 
+test_expect_success MINGW 'reflink is disabled on Windows build 26200' '
+	test_when_finished "rm -rf winreflink" &&
+	git init winreflink &&
+	(
+		cd winreflink &&
+		test_commit base file.txt base &&
+		git worktree add --reflink wt -b winbr base 2>err &&
+		test_grep "build 26200" err &&
+		echo base >expect &&
+		test_cmp expect wt/file.txt &&
+		git -C wt status --porcelain >status &&
+		test_must_be_empty status
+	)
+'
+
 test_expect_success '--reflink produces a correct checkout on any filesystem' '
 	test_when_finished "rm -rf reflinkrepo" &&
 	git init reflinkrepo &&
-- 
gitgitgadget

