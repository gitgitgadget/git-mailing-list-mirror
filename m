Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71C8366DB0
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 20:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767989140; cv=none; b=lhPLMY2Z7V54nDECy/3Z2fqkDilopMBXIYRbbG7+3/La6hzF/i3dYbwJO8KLwpMNopgEOfHD0C4XrBzuRYT8UttwtX9t9Gf5ml0zVRHyoza3QpaT26/+4V98ROM8OXMxNONAq999wKaJweufTVEWzekulitqiPh5hmeZDqFQWLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767989140; c=relaxed/simple;
	bh=0vGci/VrqkC8+2h/r8EQE+dQkdrOBCAelV7bFpHwMBs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BrbALGoxlbVWj/rOchchybm6GNCHIgcMMGknCch1q7m3TaLET5CMDbBj5gjvgHuqNKzfUD0s8f2jVKZs0PSilioqAFIi0AUtaY4fa3+fMyZqdnf8UfTBgk8WRlAXKWm1JPAQ2w40lFjl3DE1XpWf57fHW7rxmuJovFqRwXYajaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ws0VclLT; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ws0VclLT"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-88a2d21427dso46427906d6.3
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 12:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767989135; x=1768593935; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBAXF9wtRldmnWBbTeiPBn6012LH8MRuOc/wa+3U8uk=;
        b=Ws0VclLTszu/LXWQfvmz65MuKEQdXBSKnSWse9299mJYppv+7UX6v59P5KbhE/M7i2
         pGLKDCx6VuYYef/JAm4V/N/D7zr4dl36oqAnLLDG0zEeJjcTe+Qmc2bJLdvFzIz4/nMh
         CjlNEz7nxay7aAqgt0RsFbQAlo5mYFX6IcFZ7YKSsn9WDCqLv/fuBmkPyGDqzkLy+hUR
         1DJn+Lss8u20SnzitCd406WJgqr1RUdS7Xm0T9I8prIwA1udVwd9cL0cSVfsahWWaMuZ
         VjPpogYfoKhBnxdMhjVzoo4E+FOFI7xWcUg0CsVxNFQrWdd/2zSJWje1b7lkXlJA4u0j
         Op2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767989135; x=1768593935;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yBAXF9wtRldmnWBbTeiPBn6012LH8MRuOc/wa+3U8uk=;
        b=X8bN0hSxCH0gMpfdRP+x1yckkRlO2Encd+Bneyur+iziLa97Yi4pq6ZVzpqOrWGeMt
         UBEj8jFMHC1jYv8OrC5UODLpRiX+gdRRe8p1FocrYnNJHOOH/tC2ZheGV5IbqrMyQOD7
         VqKmoh0BgZUT8g7XEsUfFvJC37SK8GY8HymQbj6Oxx+1E19ME5BLQwbP7FPAm9wtrxmU
         lhF7Y9HGnSj4j9Gu5tZHpz7FvMeiwYFlxGmW2OAuum6KDQvD+MNAKai0SpL0Ol0Sr2Vb
         xxpNAu8AOUalydPwn2XYACXxAiAsITub5kyZFclrXDFAptolNDGmLMoMaigvpTr4a7bC
         pmpg==
X-Gm-Message-State: AOJu0YzkvErcvZr34u2PaKPUMWXVPaGJNbADPNoRDSknQOJPs4K9QOaY
	Md2l48VP95zmwfELhtE0Dz8g7u6COmgOMgTJC6mDPlIPXOmkRJz1JxusnvjyM3j/
X-Gm-Gg: AY/fxX6fWjlYIEV7BLgF+3LRJr0Vg+kQ6NMdZvVrcZWtAt34QDBaPJbJh5mMdvRdLel
	/+3WHRU3hjsf9+1WCzCpSnTr5A6P8YqKEdWgqBbc4G5rlqUWsOIIkl31oJzSXtcx2UiHfNM18py
	eB0yZ/7eCZKWNMuoecVunfWh7AFN4uLeYViq9gMbwKIGyILXM5iZDXYe6rH/sWhqKiFMvM5iHxg
	WOTZyK8oAil9hkIbsjDMI07mjywGs1MiSHVEobuKN5+ZV9XWrU3GT6tz38pvi/E57cAQxIzn9vI
	LuOmH0BODGK9ZR3R4IW6e4IOiKLw6GoDqwLt5rQhKqbdudr9pTAhk5u/uIjAi/DNpWdSZ0LhD5G
	eghbUQxQFZgTeFCZN2zOuuT/Fm78/yrJ3+gY2jGNyZ9MDjWvNVby2oiTCTaId0DggFLD/yHB8HM
	SWHb4lp3s8qhqd
X-Google-Smtp-Source: AGHT+IGXHGz8y/9IkdEXq6+179ua6xgZqfdyQ+VrLWC7Z2Tm3YlL7YnRcnEuSfSSeILVHkpo5jlGIA==
X-Received: by 2002:a05:6214:450b:b0:88f:ce04:3261 with SMTP id 6a1803df08f44-89084179b90mr177063016d6.6.1767989135085;
        Fri, 09 Jan 2026 12:05:35 -0800 (PST)
Received: from [127.0.0.1] ([20.161.67.219])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770ce659sm79829296d6.10.2026.01.09.12.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 12:05:34 -0800 (PST)
Message-Id: <3d479fd47e68242b028e1bbfd0019dfb0ededac8.1767989115.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2018.v2.git.1767989115.gitgitgadget@gmail.com>
References: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
	<pull.2018.v2.git.1767989115.gitgitgadget@gmail.com>
From: "Karsten Blees via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Jan 2026 20:05:12 +0000
Subject: [PATCH v2 15/18] mingw: add support for symlinks to directories
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

Symlinks on Windows have a flag that indicates whether the target is a
file or a directory. Symlinks of wrong type simply don't work. This even
affects core Win32 APIs (e.g. `DeleteFile()` refuses to delete directory
symlinks).

However, `CreateFile()` with FILE_FLAG_BACKUP_SEMANTICS does work. Check
the target type by first creating a tentative file symlink, opening it,
and checking the type of the resulting handle. If it is a directory,
recreate the symlink with the directory flag set.

It is possible to create symlinks before the target exists (or in case
of symlinks to symlinks: before the target type is known). If this
happens, create a tentative file symlink and postpone the directory
decision: keep a list of phantom symlinks to be processed whenever a new
directory is created in `mingw_mkdir()`.

Limitations: This algorithm may fail if a link target changes from file
to directory or vice versa, or if the target directory is created in
another process. It's the best Git can do, though.

Signed-off-by: Karsten Blees <karsten.blees@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 164 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 164 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index 8d366794c4..59a32e454e 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -296,6 +296,131 @@ int mingw_core_config(const char *var, const char *value,
 	return 0;
 }
 
+static inline int is_wdir_sep(wchar_t wchar)
+{
+	return wchar == L'/' || wchar == L'\\';
+}
+
+static const wchar_t *make_relative_to(const wchar_t *path,
+				       const wchar_t *relative_to, wchar_t *out,
+				       size_t size)
+{
+	size_t i = wcslen(relative_to), len;
+
+	/* Is `path` already absolute? */
+	if (is_wdir_sep(path[0]) ||
+	    (iswalpha(path[0]) && path[1] == L':' && is_wdir_sep(path[2])))
+		return path;
+
+	while (i > 0 && !is_wdir_sep(relative_to[i - 1]))
+		i--;
+
+	/* Is `relative_to` in the current directory? */
+	if (!i)
+		return path;
+
+	len = wcslen(path);
+	if (i + len + 1 > size) {
+		error("Could not make '%ls' relative to '%ls' (too large)",
+		      path, relative_to);
+		return NULL;
+	}
+
+	memcpy(out, relative_to, i * sizeof(wchar_t));
+	wcscpy(out + i, path);
+	return out;
+}
+
+enum phantom_symlink_result {
+	PHANTOM_SYMLINK_RETRY,
+	PHANTOM_SYMLINK_DONE,
+	PHANTOM_SYMLINK_DIRECTORY
+};
+
+/*
+ * Changes a file symlink to a directory symlink if the target exists and is a
+ * directory.
+ */
+static enum phantom_symlink_result
+process_phantom_symlink(const wchar_t *wtarget, const wchar_t *wlink)
+{
+	HANDLE hnd;
+	BY_HANDLE_FILE_INFORMATION fdata;
+	wchar_t relative[MAX_PATH];
+	const wchar_t *rel;
+
+	/* check that wlink is still a file symlink */
+	if ((GetFileAttributesW(wlink)
+			& (FILE_ATTRIBUTE_REPARSE_POINT | FILE_ATTRIBUTE_DIRECTORY))
+			!= FILE_ATTRIBUTE_REPARSE_POINT)
+		return PHANTOM_SYMLINK_DONE;
+
+	/* make it relative, if necessary */
+	rel = make_relative_to(wtarget, wlink, relative, ARRAY_SIZE(relative));
+	if (!rel)
+		return PHANTOM_SYMLINK_DONE;
+
+	/* let Windows resolve the link by opening it */
+	hnd = CreateFileW(rel, 0,
+			FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE, NULL,
+			OPEN_EXISTING, FILE_FLAG_BACKUP_SEMANTICS, NULL);
+	if (hnd == INVALID_HANDLE_VALUE) {
+		errno = err_win_to_posix(GetLastError());
+		return PHANTOM_SYMLINK_RETRY;
+	}
+
+	if (!GetFileInformationByHandle(hnd, &fdata)) {
+		errno = err_win_to_posix(GetLastError());
+		CloseHandle(hnd);
+		return PHANTOM_SYMLINK_RETRY;
+	}
+	CloseHandle(hnd);
+
+	/* if target exists and is a file, we're done */
+	if (!(fdata.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY))
+		return PHANTOM_SYMLINK_DONE;
+
+	/* otherwise recreate the symlink with directory flag */
+	if (DeleteFileW(wlink) && CreateSymbolicLinkW(wlink, wtarget, 1))
+		return PHANTOM_SYMLINK_DIRECTORY;
+
+	errno = err_win_to_posix(GetLastError());
+	return PHANTOM_SYMLINK_RETRY;
+}
+
+/* keep track of newly created symlinks to non-existing targets */
+struct phantom_symlink_info {
+	struct phantom_symlink_info *next;
+	wchar_t *wlink;
+	wchar_t *wtarget;
+};
+
+static struct phantom_symlink_info *phantom_symlinks = NULL;
+static CRITICAL_SECTION phantom_symlinks_cs;
+
+static void process_phantom_symlinks(void)
+{
+	struct phantom_symlink_info *current, **psi;
+	EnterCriticalSection(&phantom_symlinks_cs);
+	/* process phantom symlinks list */
+	psi = &phantom_symlinks;
+	while ((current = *psi)) {
+		enum phantom_symlink_result result = process_phantom_symlink(
+				current->wtarget, current->wlink);
+		if (result == PHANTOM_SYMLINK_RETRY) {
+			psi = &current->next;
+		} else {
+			/* symlink was processed, remove from list */
+			*psi = current->next;
+			free(current);
+			/* if symlink was a directory, start over */
+			if (result == PHANTOM_SYMLINK_DIRECTORY)
+				psi = &phantom_symlinks;
+		}
+	}
+	LeaveCriticalSection(&phantom_symlinks_cs);
+}
+
 /* Normalizes NT paths as returned by some low-level APIs. */
 static wchar_t *normalize_ntpath(wchar_t *wbuf)
 {
@@ -479,6 +604,8 @@ int mingw_mkdir(const char *path, int mode UNUSED)
 	if (xutftowcs_path(wpath, path) < 0)
 		return -1;
 	ret = _wmkdir(wpath);
+	if (!ret)
+		process_phantom_symlinks();
 	if (!ret && needs_hiding(path))
 		return set_hidden_flag(wpath, 1);
 	return ret;
@@ -2723,6 +2850,42 @@ int symlink(const char *target, const char *link)
 		errno = err_win_to_posix(GetLastError());
 		return -1;
 	}
+
+	/* convert to directory symlink if target exists */
+	switch (process_phantom_symlink(wtarget, wlink)) {
+	case PHANTOM_SYMLINK_RETRY:	{
+		/* if target doesn't exist, add to phantom symlinks list */
+		wchar_t wfullpath[MAX_PATH];
+		struct phantom_symlink_info *psi;
+
+		/* convert to absolute path to be independent of cwd */
+		len = GetFullPathNameW(wlink, MAX_PATH, wfullpath, NULL);
+		if (!len || len >= MAX_PATH) {
+			errno = err_win_to_posix(GetLastError());
+			return -1;
+		}
+
+		/* over-allocate and fill phantom_symlink_info structure */
+		psi = xmalloc(sizeof(struct phantom_symlink_info)
+			+ sizeof(wchar_t) * (len + wcslen(wtarget) + 2));
+		psi->wlink = (wchar_t *)(psi + 1);
+		wcscpy(psi->wlink, wfullpath);
+		psi->wtarget = psi->wlink + len + 1;
+		wcscpy(psi->wtarget, wtarget);
+
+		EnterCriticalSection(&phantom_symlinks_cs);
+		psi->next = phantom_symlinks;
+		phantom_symlinks = psi;
+		LeaveCriticalSection(&phantom_symlinks_cs);
+		break;
+	}
+	case PHANTOM_SYMLINK_DIRECTORY:
+		/* if we created a dir symlink, process other phantom symlinks */
+		process_phantom_symlinks();
+		break;
+	default:
+		break;
+	}
 	return 0;
 }
 
@@ -3424,6 +3587,7 @@ int wmain(int argc, const wchar_t **wargv)
 
 	/* initialize critical section for waitpid pinfo_t list */
 	InitializeCriticalSection(&pinfo_cs);
+	InitializeCriticalSection(&phantom_symlinks_cs);
 
 	/* set up default file mode and file modes for stdin/out/err */
 	_fmode = _O_BINARY;
-- 
gitgitgadget

