Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A00BF50F
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 12:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740139302; cv=none; b=hyrtzej8M7Vn8VrnZ7oTJLnAwWoKZAN10gWsCbJpB3P1J2QqJdVKeIAbiXlY9IUOMKeXlEJiKIpwXzHhMRatxldmx/E6HeHo07JjNbhHZalf3OLGsMR+qbtIVl8eJz3FUY4qs1bzZ5ey2ij8aKna5SAGl03VZMH2XQiDnPvpD+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740139302; c=relaxed/simple;
	bh=vaW7JLIlw6SBJris12a1squOJ9KTR/F9IWYWhLX2yYs=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=O5PwsOzknsfaM966dM7hNUAAyfsH9L+SEOVpSsCrcgQ/9oB3nNQkTwnHDKMGJdxpb4Ty6JQBsND65oCsupEmsworxuGct0dL7bzaLip6OcR7lA/BtbjzTuf6bi2yLdV3Bbco/0kXodGOIGZL61jTh+L3m5mbbdf5+zRmhUJ1+9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDVOQ3wo; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDVOQ3wo"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38f2f783e4dso1700380f8f.3
        for <git@vger.kernel.org>; Fri, 21 Feb 2025 04:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740139298; x=1740744098; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7oW81gowL95dycHx+vcoXaHjvcVjAFDo5LXONVIeN2M=;
        b=lDVOQ3woDkbcwjx92axT0Mkug4gqDxp8/Q4fNpVjFluoiCWTCnx3sdrBG0qhGOF4qt
         LfEx5olkISemewfmzKMoPxFrZ2k0Yb71ac6ypMxkTz/Ldk4W0AC+kk19GbKhpFP67hP1
         SDnqp/YjpWKQ5zeSLJwdWN66a7jS2OlurUzlYXwGlIbvc/BMqd3GjjXl0ARlZ8HPAgj5
         DJqieKiRGaZ+r8Vt3CHAgYEo7qeK1KeVPcDSTGJAWBZnIoOjupy/hDip2sgWxnC1e8NK
         5VrV6yd3IZPPMm+I/M91GJDVO+SPfM4DRX1l4wombVN3GqJi5OwYHClM0huPMeKdwl9M
         DU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740139298; x=1740744098;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7oW81gowL95dycHx+vcoXaHjvcVjAFDo5LXONVIeN2M=;
        b=U95fq5qyvwK80ClodQ8PC0AHCrP5HHclscA9dNuRX/W2293YzpyF2RZ8w89fHAHjK4
         Vp9icFLF5QtCzTmpg5uZFdkSXF3HRIAEzOMQk8ska/1pBUEUiSX80IT41BXCRdgJ67YI
         YiTDR7dcEEy44n74bykf+L64lDErc5s7YcgbkCSqhB8ZyK0q85vsd8V98mmoStZ5T7iK
         sDu9Pqk0i/CcBz2T4K7FcX2KzcwDQ1KcRlKu7iOP97rSol6xrXTdOwgD+XFQmde9YrMm
         Pf9DlMFDyU95bUtFQsCoPMcVcpLU4s/PeFi5n7YpedrE5HEibkjSutWA/1hH7s2uPF2m
         rZlQ==
X-Gm-Message-State: AOJu0YzgAI4Uf65J0s9FWkEjfYIL2cWJyYccV+3reE9u9hbYL6qzIjne
	rpG784q9ASxSVp6VndwEzpaUTX7JEPTpXj8OM78a9cBtTQ6MRCz2DhLxyA==
X-Gm-Gg: ASbGncu/DIcEhlghfATdsggAkOsIvh3hYqn4wArA2NxAKEWF2DNhGeo6xiyZysprKBK
	F6HQlySfL3TYVTG+AePoLGCLFk4oKkLOAjuOlLAfjbFY7Wp6gKj5Qhe70Y/gatXdSLJHOTtwxXx
	LfAhNEi+CICNy8t+25qmYHKKpLdOSPUlhqb6CaacyPCS2+ZkTyzOsvlKzeFu8NilDpT3QUNywU2
	Vs5XiHb+wMocu+hJWAGezKPL2J4TvRSD376y53aGonRUxpBTQRDWAm3G+nSITqrp5LLYyO6SZ+o
	rdRURNow6j0SdHLBocaTqguBkKQ=
X-Google-Smtp-Source: AGHT+IFmGsCcSsulr6yIN1KZ41Pi+zBxengOJvjgEMeN480Un72MUVZbbYcn0fzhjRrnlcn0R7l+Xw==
X-Received: by 2002:a5d:6daa:0:b0:38f:28cb:4d35 with SMTP id ffacd0b85a97d-38f6e95b175mr2616201f8f.13.1740139297708;
        Fri, 21 Feb 2025 04:01:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02ce65dsm15395345e9.1.2025.02.21.04.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 04:01:37 -0800 (PST)
Message-Id: <pull.1864.git.1740139296483.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 21 Feb 2025 12:01:36 +0000
Subject: [PATCH] compat/mingw: rename the symlink, not the target
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Eliah Kagan <eliah.kagan@gmail.com>

From: Eliah Kagan <eliah.kagan@gmail.com>

Since 183ea3e [1], a new technique is used on Windows to rename files,
where supported. The first step of this technique is to open the file
with `CreateFileW`. At that time, `FILE_ATTRIBUTE_NORMAL` was passed as
the value of the `dwFlagsAndAttributes` argument. In b30404df [2], this
was improved by passing `FILE_FLAG_BACKUP_SEMANTICS`, to support
directories as well as regular files.

However, neither value of `dwFlagsAndAttributes` is sufficient to open
a symbolic link with the correct semantics to rename it. Symlinks on
Windows are reparse points. Attempting to open a reparse point with
`CreateFileW` dereferences the reparse point and opens the target
instead, unless `FILE_FLAG_OPEN_REPARSE_POINT` is included in
`dwFlagsAndAttributes`. This is documented for that flag and in the
"Symbolic Link Behavior" section of the `CreateFileW` docs [3].

This produces a regression where attempting to rename a symlink on
Windows renames its target to the intended new name and location of the
symlink. For example, if `symlink` points to `file`, then running

    git mv symlink symlink-renamed

leaves `symlink` in place and unchanged, but renames `file` to
`symlink-renamed` [4].

This regression is detectable by existing tests in `t7001-mv.sh`, but
the tests must be run by a Windows user with the ability to create
symlinks, and the `ln -s` command used to create the initial symlink
must also be able to create a real symlink (such as by setting the
`MSYS` environment variable to `winsymlinks:nativestrict`). Then
these two tests fail if the regression is present, and pass otherwise:

    38 - git mv should overwrite file with a symlink
    39 - check moved symlink

Let's fix this, so that renaming a symlink again renames the symlink
itself and leaves the target unchanged, by passing

    FILE_FLAG_BACKUP_SEMANTICS | FILE_FLAG_OPEN_REPARSE_POINT

as the `dwFlagsAndAttributes` argument. This is sufficient (and safe)
because including `FILE_FLAG_OPEN_REPARSE_POINT` causes no harm even
when used to open a file or directory that is not a reparse point. In
that case, as noted in [3], this flag is simply ignored.

[1]: https://github.com/git-for-windows/git/commit/183ea3eabf81822506d2cd3aa1dc0727099ebccd
[2]: https://github.com/git-for-windows/git/commit/b30404dfc04a4b087b630aea4ab88a51cd3a7459
[3]: https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-createfilew
[4]: https://github.com/git-for-windows/git/issues/5436

Signed-off-by: Eliah Kagan <eliah.kagan@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    compat/mingw: rename the symlink, not the target
    
    This contribution just came in as a Git for Windows Pull Request.
    
    Granted, I have not yet managed to find time to upstream support for
    symbolic links (it is in the pipeline:
    https://github.com/dscho/git/tree/support-symlinks-on-windows), but this
    patch still should be in upstream Git because there are other ways to
    create symbolic links than by using Git.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1864%2Fdscho%2Ffix-renaming-symlinks-on-windows-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1864/dscho/fix-renaming-symlinks-on-windows-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1864

 compat/mingw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 1d5b211b548..f524c54d06d 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2278,7 +2278,9 @@ repeat:
 
 		old_handle = CreateFileW(wpold, DELETE,
 					 FILE_SHARE_WRITE | FILE_SHARE_READ | FILE_SHARE_DELETE,
-					 NULL, OPEN_EXISTING, FILE_FLAG_BACKUP_SEMANTICS, NULL);
+					 NULL, OPEN_EXISTING,
+					 FILE_FLAG_BACKUP_SEMANTICS | FILE_FLAG_OPEN_REPARSE_POINT,
+					 NULL);
 		if (old_handle == INVALID_HANDLE_VALUE) {
 			errno = err_win_to_posix(GetLastError());
 			return -1;

base-commit: b838bf1938926a7a900166136d995d86f8a00e24
-- 
gitgitgadget
