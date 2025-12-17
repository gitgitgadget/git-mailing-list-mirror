Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D86398B60
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 14:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765980548; cv=none; b=uR7IPjjlLCyN6k5WvwMjMUjG6GcNvuS9FjVQdEuWNaoVOlEkcmccqDw36bWBkUtEPwnKZJaVw4oYZzOR6Qv7Wrx/IbXleKh/sGH5z0BOTBbCiODxMKqnuNy+JrQlCR1I7O44BWau6W3TeNlCEH4wRt1KgxkAUTVW0fSPc43sL14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765980548; c=relaxed/simple;
	bh=KU9XKET55Ydbjq3CPth9O3/9Y4/1xEp49epsE5dAwfw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=o3SbJKPWU/IChxVeR/g7BcgLCgDekIH4HSI8+hFVC6KHnOAtj8mI4JU1KsaSdTGSoOYUTy9+rfO+mEODfnvi8Oasqz8TSz75XEuvvnXvvcyPTr+4naEilOeHasllCwdJjzfGBP1qx2ITdk5TdsmTM07VCnYJy9a3Atwqkx+uWWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYe0bWo6; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYe0bWo6"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8b29ff9d18cso632720885a.3
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 06:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765980544; x=1766585344; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6YWmudPBFzd+iK2JhMC00zYqoSBaqxN0Wik7xjWMEA=;
        b=AYe0bWo6Cs0UDitxrEdRQY0vScIo0AlK4l5IGnsaqqkcGzRSEkrFix6W81zVMR4Swm
         xN8dmKbaMMwzVBLtNdVsYG6U4eTwwKXuNEaF+aOAvw2+iPUGM6xKdf1GaW8Ekfq1eXVf
         AvuybICaYmXbK5mdPOP8FWuq17F1OxtThS7oXcPbBcJjrbAOZG7tyQmEGjgO5dFjqQQf
         +lmRNJ/s0xnqis37sF9Oz2z5ED5yTKKbPt25l6H+8avOTeaEF26y240LHKGq2GoF0RhK
         KigHOr9aV9eEpc3dDGQNDX+o9PJ68xuNyDQ3SO7hM7wcp1XTAlsMrdjaI/fPy8Uy+6/Q
         nlBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765980544; x=1766585344;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z6YWmudPBFzd+iK2JhMC00zYqoSBaqxN0Wik7xjWMEA=;
        b=Brei/9om8BBOqlX5Q4Dc7nGZoIw+ZkC7tAOO17OWXxKLyTk2GxePrheOKUItQlsE+W
         RnF7OR3UFkt/ya9X2oRHAPn8K0kTP/yYZUAPMlu6+gqmtf6TNUxItKImjReQB1Im/qg5
         glI1jS6GQ0kTMct3/JcWIBKpVCj8u/n2vucYA/u5gNZ+XB7ljEmXzD6raJQiTIsScOWz
         PcTKF89c2dgfMf6v3QaCF+ipFjh26xIq7K2gvQrwLMFv+jAQr9X+OX8/cVxJB2seJPZ4
         51SC6+I1XPfFnS9ypQa4RbsFG3J/fsVcSxsJhMjonBIeH0u3JCJE5xMYIQzecNF97Ppn
         bwMA==
X-Gm-Message-State: AOJu0YyCO/73Rhmg3D8k5HqtmPKaHC/qwUTVlAF3Ffk6ixoMrI4cjLdd
	TVHkYm6d/0iB6aJLKyEjfv8cpAH44OI0pTv6HjZeKYC3uKPtw3KCX8DBqW9ajjvl
X-Gm-Gg: AY/fxX4mLbKMw/RxvByNVOL3UNr/WWrmtYUalOaahchdVTIU1aIqBsLeICYw/G8fg/K
	zzXXARfslB17cJsVPaPt6H36WLvV93K2qmDKjDAxOpBn2o/HSmVeWrfiLIRV1UgovnWg9nZ0kL+
	pa9WhrHthm9EM/rVIPI9EmhfQkBMLLSzf9b/TlbJB9h05HH7JJQYZaq/LCRMIY4MhFVMPOsEmb1
	+7rjPtirtsR6uxiaG+WryjX+P4Ee8C3bhJdyqTnIbvuScmqjBYFJ84F/JwcflOr+a7OHJ22tqEf
	/FAk8IWlsLz9AHT1lrCL1PF7xAEtfBoDDchrFtvt8EagvS1K11IHRxVONAie2b3Ey3r0ogeaf8d
	MfNSB7/QUfbtlJk2XQwPh3iQhNO2nTjK+F923qBI8eI9iNU5ARgkiGP1ZXvYOd8JDuEGmy0YW4a
	IadcIDut8BF0EwU5sttoi52g==
X-Google-Smtp-Source: AGHT+IGNSmUi2qEM4BcKIoHBXEKnOgEUetmg9jh70XzSboG7Opbza4avW5jV0610NXJP9BBxwhjBhA==
X-Received: by 2002:a05:622a:4cce:b0:4ed:43fe:f51e with SMTP id d75a77b69052e-4f1d05e19f3mr251333321cf.39.1765980544210;
        Wed, 17 Dec 2025 06:09:04 -0800 (PST)
Received: from [127.0.0.1] ([48.214.53.69])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f345c2eefbsm32846121cf.18.2025.12.17.06.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 06:09:03 -0800 (PST)
Message-Id: <4c49a3d9bf57415ea31ac357452b646c75b64d82.1765980535.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
References: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
From: "Bill Zissimopoulos via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Dec 2025 14:08:43 +0000
Subject: [PATCH 06/18] mingw: compute the correct size for symlinks in
 `mingw_lstat()`
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Bill Zissimopoulos <billziss@navimatics.com>

From: Bill Zissimopoulos <billziss@navimatics.com>

POSIX specifies that upon successful return from `lstat()`: "the
value of the st_size member shall be set to the length of the pathname
contained in the symbolic link not including any terminating null byte".

Git typically doesn't trust the `stat.st_size` member of symlinks (e.g.
see `strbuf_readlink()`). Therefore, it is tempting to save on the extra
overhead of opening and reading the reparse point merely to calculate
the exact size of the link target.

This is, in fact, what Git for Windows did, from May 2015 to May 2020.
At least almost: some functions take shortcuts if `st_size` is 0 (e.g.
`diff_populate_filespec()`), hence Git for Windows hard-coded the length
of all symlinks to MAX_PATH.

This did cause problems, though, specifically in Git repositories
that were also accessed by Git for Cygwin or Git for WSL. For example,
doing `git reset --hard` using Git for Windows would update the size of
symlinks in the index to be MAX_PATH; at a later time Git for Cygwin
or Git for WSL would find that symlinks have changed size during `git
status` and update the index. And then Git for Windows would think that
the index needs to be updated. Even if the symlinks did not, in fact,
change. To avoid that, the correct size must be determined.

Signed-off-by: Bill Zissimopoulos <billziss@navimatics.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 114 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 104 insertions(+), 10 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index a3a48db581..c7571951dc 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -21,6 +21,7 @@
 #define SECURITY_WIN32
 #include <sspi.h>
 #include <wchar.h>
+#include <winioctl.h>
 #include <winternl.h>
 
 #define STATUS_DELETE_PENDING ((NTSTATUS) 0xC0000056)
@@ -917,10 +918,102 @@ static int has_valid_directory_prefix(wchar_t *wfilename)
 	return 1;
 }
 
+#ifndef _WINNT_H
+/*
+ * The REPARSE_DATA_BUFFER structure is defined in the Windows DDK (in
+ * ntifs.h) and in MSYS1's winnt.h (which defines _WINNT_H). So define
+ * it ourselves if we are on MSYS2 (whose winnt.h defines _WINNT_).
+ */
+typedef struct _REPARSE_DATA_BUFFER {
+	DWORD  ReparseTag;
+	WORD   ReparseDataLength;
+	WORD   Reserved;
+#ifndef _MSC_VER
+	_ANONYMOUS_UNION
+#endif
+	union {
+		struct {
+			WORD   SubstituteNameOffset;
+			WORD   SubstituteNameLength;
+			WORD   PrintNameOffset;
+			WORD   PrintNameLength;
+			ULONG  Flags;
+			WCHAR PathBuffer[1];
+		} SymbolicLinkReparseBuffer;
+		struct {
+			WORD   SubstituteNameOffset;
+			WORD   SubstituteNameLength;
+			WORD   PrintNameOffset;
+			WORD   PrintNameLength;
+			WCHAR PathBuffer[1];
+		} MountPointReparseBuffer;
+		struct {
+			BYTE   DataBuffer[1];
+		} GenericReparseBuffer;
+	} DUMMYUNIONNAME;
+} REPARSE_DATA_BUFFER, *PREPARSE_DATA_BUFFER;
+#endif
+
+static int read_reparse_point(const WCHAR *wpath, BOOL fail_on_unknown_tag,
+			      char *tmpbuf, int *plen, DWORD *ptag)
+{
+	HANDLE handle;
+	WCHAR *wbuf;
+	REPARSE_DATA_BUFFER *b = alloca(MAXIMUM_REPARSE_DATA_BUFFER_SIZE);
+	DWORD dummy;
+
+	/* read reparse point data */
+	handle = CreateFileW(wpath, 0,
+			FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE, NULL,
+			OPEN_EXISTING,
+			FILE_FLAG_BACKUP_SEMANTICS | FILE_FLAG_OPEN_REPARSE_POINT, NULL);
+	if (handle == INVALID_HANDLE_VALUE) {
+		errno = err_win_to_posix(GetLastError());
+		return -1;
+	}
+	if (!DeviceIoControl(handle, FSCTL_GET_REPARSE_POINT, NULL, 0, b,
+			MAXIMUM_REPARSE_DATA_BUFFER_SIZE, &dummy, NULL)) {
+		errno = err_win_to_posix(GetLastError());
+		CloseHandle(handle);
+		return -1;
+	}
+	CloseHandle(handle);
+
+	/* get target path for symlinks or mount points (aka 'junctions') */
+	switch ((*ptag = b->ReparseTag)) {
+	case IO_REPARSE_TAG_SYMLINK:
+		wbuf = (WCHAR*) (((char*) b->SymbolicLinkReparseBuffer.PathBuffer)
+				+ b->SymbolicLinkReparseBuffer.SubstituteNameOffset);
+		*(WCHAR*) (((char*) wbuf)
+				+ b->SymbolicLinkReparseBuffer.SubstituteNameLength) = 0;
+		break;
+	case IO_REPARSE_TAG_MOUNT_POINT:
+		wbuf = (WCHAR*) (((char*) b->MountPointReparseBuffer.PathBuffer)
+				+ b->MountPointReparseBuffer.SubstituteNameOffset);
+		*(WCHAR*) (((char*) wbuf)
+				+ b->MountPointReparseBuffer.SubstituteNameLength) = 0;
+		break;
+	default:
+		if (fail_on_unknown_tag) {
+			errno = EINVAL;
+			return -1;
+		} else {
+			*plen = MAX_PATH;
+			return 0;
+		}
+	}
+
+	if ((*plen =
+	     xwcstoutf(tmpbuf, normalize_ntpath(wbuf), MAX_PATH)) <  0)
+		return -1;
+	return 0;
+}
+
 int mingw_lstat(const char *file_name, struct stat *buf)
 {
 	WIN32_FILE_ATTRIBUTE_DATA fdata;
-	WIN32_FIND_DATAW findbuf = { 0 };
+	DWORD reparse_tag = 0;
+	int link_len = 0;
 	wchar_t wfilename[MAX_PATH];
 	int wlen = xutftowcs_path(wfilename, file_name);
 	if (wlen < 0)
@@ -935,28 +1028,29 @@ int mingw_lstat(const char *file_name, struct stat *buf)
 	}
 
 	if (GetFileAttributesExW(wfilename, GetFileExInfoStandard, &fdata)) {
-		/* for reparse points, use FindFirstFile to get the reparse tag */
+		/* for reparse points, get the link tag and length */
 		if (fdata.dwFileAttributes & FILE_ATTRIBUTE_REPARSE_POINT) {
-			HANDLE handle = FindFirstFileW(wfilename, &findbuf);
-			if (handle == INVALID_HANDLE_VALUE)
-				goto error;
-			FindClose(handle);
+			char tmpbuf[MAX_PATH];
+
+			if (read_reparse_point(wfilename, FALSE, tmpbuf,
+					       &link_len, &reparse_tag) < 0)
+				return -1;
 		}
 		buf->st_ino = 0;
 		buf->st_gid = 0;
 		buf->st_uid = 0;
 		buf->st_nlink = 1;
 		buf->st_mode = file_attr_to_st_mode(fdata.dwFileAttributes,
-				findbuf.dwReserved0);
-		buf->st_size = fdata.nFileSizeLow |
-			(((off_t)fdata.nFileSizeHigh)<<32);
+				reparse_tag);
+		buf->st_size = S_ISLNK(buf->st_mode) ? link_len :
+			fdata.nFileSizeLow | (((off_t) fdata.nFileSizeHigh) << 32);
 		buf->st_dev = buf->st_rdev = 0; /* not used by Git */
 		filetime_to_timespec(&(fdata.ftLastAccessTime), &(buf->st_atim));
 		filetime_to_timespec(&(fdata.ftLastWriteTime), &(buf->st_mtim));
 		filetime_to_timespec(&(fdata.ftCreationTime), &(buf->st_ctim));
 		return 0;
 	}
-error:
+
 	switch (GetLastError()) {
 	case ERROR_ACCESS_DENIED:
 	case ERROR_SHARING_VIOLATION:
-- 
gitgitgadget

