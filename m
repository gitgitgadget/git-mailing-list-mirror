Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A36B368284
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 20:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767989125; cv=none; b=bW1aoDTZDzAieLBI8WrgAxlrnhwdL/FFGiZKegGu04RA9SWV2EPdGHIUSS1553qsU5oV/ErtQVkdcZOIZ1HNJCJy2619VIJA8Wji0sPnKwHu9IJpBM/xGCF/nJeVILLmnOIjw3z3yGrbwJdvT+IjiaaLfJhT9Wz+C6voxqlgxsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767989125; c=relaxed/simple;
	bh=IQDh8cpLCLOZ4mFKJkDT07evZGsi4QyKq7LytdFKha8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RZ4PBiD5xJYYYKBYw97K/JWlaiYecTf1GobEX88ODXakWquUeU07fDe5omFrJKnk2TOmlb3Zt5aEpYGcBVPZg5hCrpZpTkEclwz7TMadklTCd4zL+9CU3kNjPuOPQVSdqUsqHeK3iIJ7iCuzZymKnEWiCvVeFYThXe0OMZnvJ2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKLA6kaX; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKLA6kaX"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8b2ed01b95dso494294485a.0
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 12:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767989123; x=1768593923; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puaBXXuyoJWkIbC//d0NA+o14h6NPi+hn3TK6VZrqVQ=;
        b=JKLA6kaXQn5ufmy9nWsfpMf+p3Z5VdQWjBDbSyBfV68HIfHDdqTCLx3vYiqMaAHwEb
         VFHdUWWegQ3OKy4JGVoPFEsrBN5NBjDeVF4IABVUdRecJMR7CkiUqK5zbfFGnBWOuDgc
         RJqOhqyEUqHFWCIQzVRwekxLLgAc2HbSGUnKsFSIlNo97hN6HDr1EkKSVwAKtbg8UNOy
         NOd4nmJZK9JbBdLExKsUUWYGej6y816kWpCpzWMnpazyLA1dSvMeV1DoLVkXh99k0ZyK
         Nu1t1wha1nBRMRrWPv/msPjha9e0vkOU4R0meWLxkEiCDo9DpvxjbUi5gp7khxbp6rrS
         6/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767989123; x=1768593923;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=puaBXXuyoJWkIbC//d0NA+o14h6NPi+hn3TK6VZrqVQ=;
        b=WWvJ/DyXBNZVdHbUv0A0/1NA2U9bHfPvLnp4tqs7kAm3WmLqlL/pYHOCQAu+FarlGY
         kqMk5ouNJse+ZyT0bEPUXHH9Hs0Mfr46NvIZLMIv4cBH7mz4siO2ZGFUxWxD8Jii7qOV
         JWoJxcMDG6zRBsPYyDI67FcwYMsBcnoSvQLTCoGcODloCefTjf9DabZTjEOuT7SpVEjq
         +hUgqKNQDeuBnoClQ2ArtiyWPZ42azgcWVsdefyjr3VT/mlWFBqBf1JHofU11jdKu5fM
         Dr6vheNMJee/VS3TQq0QFz2ArsEoX5FMKQfsrE442nkjIH2gbodYY7QOR+KjiVBvHmmv
         kzVA==
X-Gm-Message-State: AOJu0YyIUaYmUyHM7gD/ulx1zsmIUWVRvvByvWl/eRvRLjKgQZ+aDsvn
	8sbVUxXlNNVRFslpHuoipRXmRpzFQzOvUZ6SHA2owqC7PjWy8qs8e98oQaGfIstQ
X-Gm-Gg: AY/fxX6iAZsWaLqiY/KDGJp+nGouFKjbyYrxEqB+ucqIEPQpd8bBDFkfjXaef2ylada
	NoN9bOXrJ3T8sQBcVpEYQg99vxg+cc56La4XmVWRc3H7wJMm//+DchPee9GGU8lVMiLO8Zurkm0
	YFUkhZmskrC/cnAgF///hLmSIL8FBv4OSgFsvq8MDoESsiK13/xWkbTD8yz44W9/S0C84KPHqid
	oxOP/bQorzDiXZVy3U4MWZ1Muq4Sp6OYK3txIxb9U7V94qLUvtY7Ht5JPMAaD7H4emsOBvRQOnl
	6h4rm+/J/yIYLRWVCqSA4kbsxdYUnblzqMqqG+pZEMrT9lMbl6rLZpGms6dh3SuWMgJRLcwxuth
	/XAd/iI+WGBVKmzQJjZPMglLT4M+hMs4mdUrXBCCzdnG6m4bIO1LMSbyN6ak0BfzD2EGA3N5AJh
	z+vdjzSy00bswk
X-Google-Smtp-Source: AGHT+IEuGbZw+bxr9D+K0aLiAQk6MCenEoIWK+4UpJ1FhUHMjm02j61cT10ns/O7y+CfmqMLu0/ETg==
X-Received: by 2002:a05:620a:4009:b0:8c0:dc64:bbad with SMTP id af79cd13be357-8c38941749emr1633354385a.73.1767989122575;
        Fri, 09 Jan 2026 12:05:22 -0800 (PST)
Received: from [127.0.0.1] ([20.161.67.219])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a794bsm899839685a.9.2026.01.09.12.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 12:05:21 -0800 (PST)
Message-Id: <8b7f5a8fc7eb6e9e2cc704b5458161952d83666a.1767989115.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2018.v2.git.1767989115.gitgitgadget@gmail.com>
References: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
	<pull.2018.v2.git.1767989115.gitgitgadget@gmail.com>
From: "Karsten Blees via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Jan 2026 20:05:02 +0000
Subject: [PATCH v2 05/18] mingw: teach dirent about symlinks
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
    Karsten Blees <karsten.blees@gmail.com>

From: Karsten Blees <karsten.blees@gmail.com>

Move the `S_IFLNK` detection to `file_attr_to_st_mode()`.

Implement `DT_LNK` detection in dirent.c's `readdir()` function.

Signed-off-by: Karsten Blees <karsten.blees@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c        | 13 +++----------
 compat/win32.h        |  6 ++++--
 compat/win32/dirent.c |  5 ++++-
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 23a926c7d1..a3a48db581 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -946,21 +946,14 @@ int mingw_lstat(const char *file_name, struct stat *buf)
 		buf->st_gid = 0;
 		buf->st_uid = 0;
 		buf->st_nlink = 1;
-		buf->st_mode = file_attr_to_st_mode(fdata.dwFileAttributes);
+		buf->st_mode = file_attr_to_st_mode(fdata.dwFileAttributes,
+				findbuf.dwReserved0);
 		buf->st_size = fdata.nFileSizeLow |
 			(((off_t)fdata.nFileSizeHigh)<<32);
 		buf->st_dev = buf->st_rdev = 0; /* not used by Git */
 		filetime_to_timespec(&(fdata.ftLastAccessTime), &(buf->st_atim));
 		filetime_to_timespec(&(fdata.ftLastWriteTime), &(buf->st_mtim));
 		filetime_to_timespec(&(fdata.ftCreationTime), &(buf->st_ctim));
-		if (fdata.dwFileAttributes & FILE_ATTRIBUTE_REPARSE_POINT) {
-			if ((findbuf.dwFileAttributes & FILE_ATTRIBUTE_REPARSE_POINT) &&
-					(findbuf.dwReserved0 == IO_REPARSE_TAG_SYMLINK)) {
-				buf->st_mode = S_IFLNK | S_IREAD;
-				if (!(findbuf.dwFileAttributes & FILE_ATTRIBUTE_READONLY))
-					buf->st_mode |= S_IWRITE;
-			}
-		}
 		return 0;
 	}
 error:
@@ -1003,7 +996,7 @@ static int get_file_info_by_handle(HANDLE hnd, struct stat *buf)
 	buf->st_gid = 0;
 	buf->st_uid = 0;
 	buf->st_nlink = 1;
-	buf->st_mode = file_attr_to_st_mode(fdata.dwFileAttributes);
+	buf->st_mode = file_attr_to_st_mode(fdata.dwFileAttributes, 0);
 	buf->st_size = fdata.nFileSizeLow |
 		(((off_t)fdata.nFileSizeHigh)<<32);
 	buf->st_dev = buf->st_rdev = 0; /* not used by Git */
diff --git a/compat/win32.h b/compat/win32.h
index a97e880757..671bcc81f9 100644
--- a/compat/win32.h
+++ b/compat/win32.h
@@ -6,10 +6,12 @@
 #include <windows.h>
 #endif
 
-static inline int file_attr_to_st_mode (DWORD attr)
+static inline int file_attr_to_st_mode (DWORD attr, DWORD tag)
 {
 	int fMode = S_IREAD;
-	if (attr & FILE_ATTRIBUTE_DIRECTORY)
+	if ((attr & FILE_ATTRIBUTE_REPARSE_POINT) && tag == IO_REPARSE_TAG_SYMLINK)
+		fMode |= S_IFLNK;
+	else if (attr & FILE_ATTRIBUTE_DIRECTORY)
 		fMode |= S_IFDIR;
 	else
 		fMode |= S_IFREG;
diff --git a/compat/win32/dirent.c b/compat/win32/dirent.c
index 52420ec7d4..24ee9b814d 100644
--- a/compat/win32/dirent.c
+++ b/compat/win32/dirent.c
@@ -12,7 +12,10 @@ static inline void finddata2dirent(struct dirent *ent, WIN32_FIND_DATAW *fdata)
 	xwcstoutf(ent->d_name, fdata->cFileName, sizeof(ent->d_name));
 
 	/* Set file type, based on WIN32_FIND_DATA */
-	if (fdata->dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY)
+	if ((fdata->dwFileAttributes & FILE_ATTRIBUTE_REPARSE_POINT)
+			&& fdata->dwReserved0 == IO_REPARSE_TAG_SYMLINK)
+		ent->d_type = DT_LNK;
+	else if (fdata->dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY)
 		ent->d_type = DT_DIR;
 	else
 		ent->d_type = DT_REG;
-- 
gitgitgadget

