Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA221DDC1D
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 20:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767989120; cv=none; b=ZhpKGj+/+o8QwIT1ZT1/AdmkEDsKegE9Kv82jZ3e3nllebSs0uuYXHB1XeLelZaQ+TWTMkJj9bAzJGtjcLLppVDnpkA2T9qCRcXyjxOTLOGHvrwOA+ltfwq4AuaZbbA9RA4fRbpldNG/j+PPLBisL2zkF9HwoGtzaqqMYSbHo4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767989120; c=relaxed/simple;
	bh=yj/UXn2o8daAD1oMoiPOgin3vWjix0gons0vwlHsiSQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HsY8ojzL1aS+/Gv4NL2ccNZVsZsKb2YyobGFW3BYkZs8trg3l3A74S+yEz/CF8xDaOMkq/7VmJrnBH8fi0k5yLbByFiD48xi3yZ2hwbfeYCKvBuQzmwDk6YonAiaUGxs4VivWyJhDOq36DGcSkGoxNq1dkxErxu2I+GMKXCpOi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8QPWWz/; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8QPWWz/"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8907fb0188fso37552406d6.1
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 12:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767989118; x=1768593918; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Spe4TlIpSxqwqIfN1AIJ4Vo9w33bl8casxd7tt4ezJY=;
        b=b8QPWWz/4sbvQ/p3Ec64lP1dk7VYvYvEfVyhACFf5XCr0GKm2RKyeEnT7So5RJfs4U
         AjoW8QDzhBZTwODsj/IVdwfrIxZrHUjXjRIFnWjvrYplc3gq/ual+Q92+C2UwBX0M2FM
         8pcLMhAK9LMr6Uoi6lCyUKurs8BCM0WHPYW38Zf6bQDxANFD2o7bsU5cbbtzQgPIUpFO
         wgIwxAZ6vpEXbxiMV914chIw4AnNOcIaLWuFNKJiUt+vUbgz/KIVTfcMlbxYNLwyrBfY
         HtD9s2aqNMRATrPPeZi5HsJSTFN/GucjC2saij8qsiLHRYSi9fR2uyFPdmUqA5w6UycP
         vmYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767989118; x=1768593918;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Spe4TlIpSxqwqIfN1AIJ4Vo9w33bl8casxd7tt4ezJY=;
        b=xS4i8RyxGoqq4WCbZRV6ld5phf2Y3h7VzWBPbjYluu2whKqG4ou7+ocdbvTLSCzotl
         45J5l23c9I7OgIdcLARmt5nmjrBAGfu4371uECUrSk6BASlIdShQ+XUKEsCkQvk5y+Ng
         IKnFKVvYiIco1nRwl23nHJwPqYhgBY2av16mSyxX/34Fg/8YjC4mR1r304XiOabXuZQU
         XsF1HUzMrBrfbpyet0zUDC23iiau6IIIgdP8B5xmPEQ/hLMmfku6qjZEJKR1cLGnFbnl
         ZzbiwGLYIMZkcRMy5wn9zPStN2zR54jfI3XVYHN7TizxLu2zyO3J7gVoFI3BVvs1iCSv
         ZixA==
X-Gm-Message-State: AOJu0YxkR0RVa1+CwXVc/3OS76+XMvmZ4/5sf++ADSznvCcfosJ6kX2/
	K2r/9na2DXxq0nvK8jd2723Nknt5QwQfZD2aXblnW22vJ3PwaY5+S0R1l1Z4J/27
X-Gm-Gg: AY/fxX7jDcMWSSS4R1tVtMwfewYrFJOsiASL6JoXcdM4y1Csgl4iPY7AT+1ERba6GcN
	05+wz256QTD694OxtKybJrq0C5bYl9XDE3KZ+ndh0+4S+n2L1b5Ne+uH9T9tVD2ItQVYeiFORho
	P4BSZjgmQ8GpkCJVntQsZW0F0UFPMyxcvSAfDpoebtuoLpd9I4kXBg5k6E+RaDr9gFR+3Ei6L8S
	PwOKj8C8Mwv4I+p+Jy3HDNAoqWL5A3O/Dhmb1hYM1SLbva880pnXtN2hboRVaJlsV2F6tt9Nswl
	mq1tMmxSVFX+dHiULut7LbTga/yukRoTv7Gz0JY939cHBJ1g1M0T1Es4t0cvxr7FneyvH1c8Yww
	YkGpspzTz04vErC1kaJSi+ZDzEud2l2OYZGw+LjeAxsdgACPvEyJ6Xbrg64gCckt2LNpqKOg5Zo
	xVHy73U60Nv4p/xqP9n/f5XeI=
X-Google-Smtp-Source: AGHT+IH89fR76wCNFebQGfeP+Uz3TNhnI1O2S5UUjcf142Ww76V9sVjgHQI2Y1husH1a7aBHd51XIg==
X-Received: by 2002:a05:6214:5403:b0:88a:314c:28bb with SMTP id 6a1803df08f44-8908418bd6fmr166123576d6.17.1767989117774;
        Fri, 09 Jan 2026 12:05:17 -0800 (PST)
Received: from [127.0.0.1] ([20.161.67.219])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770e2aa5sm82990846d6.19.2026.01.09.12.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 12:05:17 -0800 (PST)
Message-Id: <6ec4ff74577f3690a11160812666e5ca800d9d65.1767989115.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2018.v2.git.1767989115.gitgitgadget@gmail.com>
References: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
	<pull.2018.v2.git.1767989115.gitgitgadget@gmail.com>
From: "Karsten Blees via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Jan 2026 20:04:58 +0000
Subject: [PATCH v2 01/18] mingw: don't call `GetFileAttributes()` twice in
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
    Karsten Blees <karsten.blees@gmail.com>

From: Karsten Blees <karsten.blees@gmail.com>

The Win32 API function `GetFileAttributes()` cannot handle paths with
trailing dir separators. The current `mingw_stat()`/`mingw_lstat()`
implementation calls `GetFileAttributes()` twice if the path has
trailing slashes (first with the original path that was passed as
function parameter, and and a second time with a path copy with trailing
'/' removed).

With the conversion to wide Unicode, we get the length of the path for
free, and also have a (wide char) buffer that can be modified. This
makes it easy to avoid that extraneous Win32 API call.

Signed-off-by: Karsten Blees <karsten.blees@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 53 ++++++++++++++------------------------------------
 1 file changed, 15 insertions(+), 38 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index cf4f3c92e7..ae6826948e 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -918,8 +918,9 @@ static int has_valid_directory_prefix(wchar_t *wfilename)
 }
 
 /* We keep the do_lstat code in a separate function to avoid recursion.
- * When a path ends with a slash, the stat will fail with ENOENT. In
- * this case, we strip the trailing slashes and stat again.
+ * When a path ends with a slash, the call to `GetFileAttributedExW()`
+ * would fail. To prevent this, we strip any trailing slashes before that
+ * call.
  *
  * If follow is true then act like stat() and report on the link
  * target. Otherwise report on the link itself.
@@ -928,9 +929,18 @@ static int do_lstat(int follow, const char *file_name, struct stat *buf)
 {
 	WIN32_FILE_ATTRIBUTE_DATA fdata;
 	wchar_t wfilename[MAX_PATH];
-	if (xutftowcs_path(wfilename, file_name) < 0)
+	int wlen = xutftowcs_path(wfilename, file_name);
+	if (wlen < 0)
 		return -1;
 
+	/* strip trailing '/', or GetFileAttributes will fail */
+	while (wlen && is_dir_sep(wfilename[wlen - 1]))
+		wfilename[--wlen] = 0;
+	if (!wlen) {
+		errno = ENOENT;
+		return -1;
+	}
+
 	if (GetFileAttributesExW(wfilename, GetFileExInfoStandard, &fdata)) {
 		buf->st_ino = 0;
 		buf->st_gid = 0;
@@ -990,39 +1000,6 @@ static int do_lstat(int follow, const char *file_name, struct stat *buf)
 	return -1;
 }
 
-/* We provide our own lstat/fstat functions, since the provided
- * lstat/fstat functions are so slow. These stat functions are
- * tailored for Git's usage (read: fast), and are not meant to be
- * complete. Note that Git stat()s are redirected to mingw_lstat()
- * too, since Windows doesn't really handle symlinks that well.
- */
-static int do_stat_internal(int follow, const char *file_name, struct stat *buf)
-{
-	size_t namelen;
-	char alt_name[PATH_MAX];
-
-	if (!do_lstat(follow, file_name, buf))
-		return 0;
-
-	/* if file_name ended in a '/', Windows returned ENOENT;
-	 * try again without trailing slashes
-	 */
-	if (errno != ENOENT)
-		return -1;
-
-	namelen = strlen(file_name);
-	if (namelen && file_name[namelen-1] != '/')
-		return -1;
-	while (namelen && file_name[namelen-1] == '/')
-		--namelen;
-	if (!namelen || namelen >= PATH_MAX)
-		return -1;
-
-	memcpy(alt_name, file_name, namelen);
-	alt_name[namelen] = 0;
-	return do_lstat(follow, alt_name, buf);
-}
-
 static int get_file_info_by_handle(HANDLE hnd, struct stat *buf)
 {
 	BY_HANDLE_FILE_INFORMATION fdata;
@@ -1048,11 +1025,11 @@ static int get_file_info_by_handle(HANDLE hnd, struct stat *buf)
 
 int mingw_lstat(const char *file_name, struct stat *buf)
 {
-	return do_stat_internal(0, file_name, buf);
+	return do_lstat(0, file_name, buf);
 }
 int mingw_stat(const char *file_name, struct stat *buf)
 {
-	return do_stat_internal(1, file_name, buf);
+	return do_lstat(1, file_name, buf);
 }
 
 int mingw_fstat(int fd, struct stat *buf)
-- 
gitgitgadget

