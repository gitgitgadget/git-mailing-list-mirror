Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA6F366557
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 20:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767989128; cv=none; b=sK0q9A1KVLJNBY65yUf8ZVsFT6iRhBpq1ph5jJTnVqgZHb9qiGrRW+HLtTvgjDIk1kIaT6TZsDm8bFsaufD3QToxueU2J5NuF5oNlrCJmf6TmKT+1l6ZpCp0akClhPdGzvBqAWBEEJ/YTNjtTPsNgZ59Zi3fQPa/IpCnS5IPMMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767989128; c=relaxed/simple;
	bh=KU9XKET55Ydbjq3CPth9O3/9Y4/1xEp49epsE5dAwfw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=t/U4u9WiNSRZHcj7zxZOK5adQS+EXO1jqhxC3b0NMcN5666eKxtHdkZK1/bssdHQIDyPpGhhhGjl3/4qgdGvX+MCjYSbz+jj9gA+J2J91Av/Kx1HUNHltPwh5Ud5VqpoX8RYiFHX7hbUaPp8yafvls60BLtLA+d21PAS8mJ1LqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vzhq8h9w; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vzhq8h9w"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8b2148ca40eso643514885a.1
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 12:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767989124; x=1768593924; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6YWmudPBFzd+iK2JhMC00zYqoSBaqxN0Wik7xjWMEA=;
        b=Vzhq8h9w+HKBnmWGX2LOH6ffZBeWxS0fbcwgNqDipKl3nnUZjC8aEG+1G2OpFY3MwH
         guey9ZJHUqVcbfkGNoSz8fJQNS4TzThSHauix/5hIbOdqJOhGePuAuGCiaS2kfeJF3Mf
         OrenjDmRFxxQBLT540WCtJeqfhaFkG0V+wAhuu/ctoQup2rpK3AAC2vwb7tW+l8M0RxN
         j7w9iA4Seqv20zyAt/NxPXlXzoiSqRbRkAIpIyCzoa5cVzBcG7RwABBCC3ITU3SyHG5d
         T2pLRPE5XUdO51Y5w2OLfKH1Gy/RHwFXNFoqr1GxgJNvj+Y3Z8F1YFzdk1g9vNFRp+QB
         4ESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767989124; x=1768593924;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z6YWmudPBFzd+iK2JhMC00zYqoSBaqxN0Wik7xjWMEA=;
        b=FnbR8vnSag3OWVhOx7+/WPCK+zNXwBcPGItbq2ufQUfaXn/v+U1rQgzbwDwkqrJkhT
         4eHcEVfsmlWWHR54XeM1WjueiOk3WONXBzeMbywtcfHqPma0CRD6Z2wKt408YZyyTY8f
         wmCgEwLxM5ry79saNbZvhOz2Yl4rpTynyERFod4ZgtrMzzoyy2AlO5Q+Fctd17RyxAAW
         RWT+ax9Hfeu4bWYjUMG3JseZDT0PmIJ3xz+WtknLqYwrBVC4+MmXQ+LM8bkpfqFQUuAI
         FiKWYdUvedOgLLemHcLPqVNh6/r/Aljrj4ISSO7vGNjAek2aVnlim5qLl8cZxTlMLALy
         3hmg==
X-Gm-Message-State: AOJu0YzQeyo90hnqFX3Amt3q3Qf0UiZOMj5C1btpodK1s4pM/t0OVDoj
	ubz42HwApf/Du94yUjubxWUNkesThgf8UwHLWi956wYKDQ4WmXL/mSZp2B5T7TQZ
X-Gm-Gg: AY/fxX7aBY6AUbP2mKP2bEludheU1g3l68Xkes/4pVvt/dMtp1R9njr1WqA/4wyzyGL
	gnrwaWTDRwvGOEBkSYYgnCnC8VkY/N+oR4ozRbidyQmFuwRCRpG7Q5araAcHp2GxbEweRfINg2E
	3wDm480AKf35E8w3XdcbQRsXeZK3TPmhmhGhILcRrbytR2T/YY5jyKKhm3kYPPtg/0rfwx5Pqbq
	YFsuhl50pWcLmZDvUmJ9a7xRI/1hVGyoXc50A7ir5qf3PYrvIXbDHoZobe9xF7lDdPFNF+byzKw
	xDiSM9g6g5Y2nLuoUNO0NH7HQ7sDiWX5az3iYXHQJP/fPfEIVc6e8z4E9vnrVWsBx00M9JgQyGH
	NNvMh2nmh+6ghwUYmIyfGiyjCvAPlA6xbmXApmQL0MnwAV/XtGvZhuzjNKfO05njV6LTBtmOhQt
	25IOgRUVWnbR5br2C9nXcXYMM=
X-Google-Smtp-Source: AGHT+IFjxDqiLsiTeXRGr4kDQSwdH3PTw9JCXOc7zkBMJ5WuSO2ejNJREFcRqWRshqZ3CTkv9I49VQ==
X-Received: by 2002:a05:620a:410c:b0:8be:9050:8548 with SMTP id af79cd13be357-8c389389495mr1538298885a.33.1767989123936;
        Fri, 09 Jan 2026 12:05:23 -0800 (PST)
Received: from [127.0.0.1] ([20.161.67.219])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4b9373sm866640085a.15.2026.01.09.12.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 12:05:23 -0800 (PST)
Message-Id: <1159e86dc42510297599676efee98057be857878.1767989115.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2018.v2.git.1767989115.gitgitgadget@gmail.com>
References: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
	<pull.2018.v2.git.1767989115.gitgitgadget@gmail.com>
From: "Bill Zissimopoulos via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Jan 2026 20:05:03 +0000
Subject: [PATCH v2 06/18] mingw: compute the correct size for symlinks in
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
Cc: Ben Knoble <ben.knoble@gmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Karsten Blees <karsten.blees@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
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

