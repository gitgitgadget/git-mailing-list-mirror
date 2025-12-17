Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFF9396DA4
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 14:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765980541; cv=none; b=IHCtNHvDsrBkINpmCF8ePayxJgDmrLl8x8/V/Ix83WKs4UM0BU5PE0Tcu1qeHpd93F13T7AQAFkS/b+IIGCeHHRgBd6ydHQO1G8iGirVBWpIyBNDs5QZw4v69SrykONyYiijCOCApLBp8Wd9YHyIPuRvly/yJwENimTKYmWAsJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765980541; c=relaxed/simple;
	bh=uySKwY5/RbFwR6EGsjpO21FJNnqmrEgfikl6OgUxdKk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pS8ieqfDHX8FptBKQrzikzM2XTYKTefmxprO5UzFWzPY9TJRgepMW/ljjd859Adj1k1pfA2C0k5Jzk2/usIEepKHP7Obeobsr7ToPJGOp9LisAKaDrAE+NwSO19oQ+38C9lOIU+6wGAQNRMqvSRNWLmx59RycwfSIg0bxEm0DQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6hNoR7v; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6hNoR7v"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8b25ed53fcbso838039485a.0
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 06:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765980538; x=1766585338; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNDBvmFoRIyMTBDVBW1HvShyCl5K426P58nofELRy/s=;
        b=U6hNoR7ve14BltJ/mfm2R/u+BQofE6cld498JZzTUlF1FdCB/pM5oEloEtjINCsTHH
         IeA/Tl+iSsySms2sR0MFBoalmr3//vdp5nMNFz0v9A0FELFsy+qhGS458qmm8POlx7pW
         sgdO0qjT23wN7MaZG6fc225XXuv+CegdjyFqZTh1WZGJCP4US8cCYciVpUpMDl4hcWQv
         TkCNlw9Q7JgAUwp+5UcCbFvR8y3yQstX+mgT2Os/iz0YzpdGRb5VVR1ahXF5tby7ReS7
         UF7YaX6OiMd/mRoEdtbsLoXmMbF/5Xw85iBUz5vVtyWmREdolvCxj42glS7qfw9BlwMo
         bW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765980538; x=1766585338;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KNDBvmFoRIyMTBDVBW1HvShyCl5K426P58nofELRy/s=;
        b=qGeHdcYS3ZgfQPav5i89xqEZpAtsdWiE1yYcIJLc7FoQ9GXLaJUzrAZKXQKzrPUnxz
         vs19gn9fjjjSKdRTN8i63dFl6N4U9pLZ3FUPudhWp9+BprwJef98BAL4t77NgsDiwCO7
         /4jUJrs3rvMFbgMja/Dzkon9TfoWsqOnGFF2A0b22s3tTD8zMUmnPtwDB5sRqNMs6jps
         rovbZahAYZggnN5BvcnalLiMNtivhIX3KM9YHJ7dT5pzBXoDY20QelJuq0DU0MRkIsq2
         hbq6Vo/w3vfp01Ee4OHSQorjFeX4SwbbxxJ3zlnATALSuQVsCW3JT6FjjY2IwiHpIgws
         u+WA==
X-Gm-Message-State: AOJu0YxGrvcKJrHvDtuc3fvNqmKLGjslAvf5qYuXbg47Toe3wG5WTKG9
	6qHOkR+c2h23TQZFtEmzSxgwlBKO/hyORJkk9MfRN53DedWfNmwKfCD/R8LXSsH6
X-Gm-Gg: AY/fxX6OQ1Fete60UACOexoEk1p+JkxdQ9r2pFmLDGNRE04yOGwxc8azH1hrV93JOd8
	j8r3U9iks9omQLRtTZzpy7QBcELT+jZtc1eAxyp2uViPwIpPTdj4p0XYMjHGf0nLd0nJHJKlVt8
	XKWlp5x8z7cL78aOREepCzPkW+DZTLzKq9kmPv2hmesbkfNFejPtYhXxTNMys00729IFI7lg/PI
	wf5CPq5QaggHzesLsfyxCcgb2yx580iO6QF+t6rItxtF6JxQx1cge119mRIir2euTd79csiPM92
	N2smY9o4h4+KdahgxIxMry+yUin04EEXeaK3zdPrtSkWNe65oHbtV+ykEnSQRbcT13S5BDVjpRI
	eLxB57b/ISqPjL9oO4CsoSWpFQe8OJ3nNbDSqJKSNr6GhAqjACtyvXMH+RbdtPuZfWLfTn8Edv5
	qaNZdnLgO5isU=
X-Google-Smtp-Source: AGHT+IEEvgB+JEodNxyh9EWZJj1drAZ82fG19HLffZMPbJeKR1k11WIAL1I8jM6vuLpWdqs2OWoVXg==
X-Received: by 2002:a05:620a:404a:b0:8b2:f29e:3afa with SMTP id af79cd13be357-8bb3a231f1amr2865573285a.45.1765980538186;
        Wed, 17 Dec 2025 06:08:58 -0800 (PST)
Received: from [127.0.0.1] ([48.214.53.69])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8be303e7e51sm424558985a.7.2025.12.17.06.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 06:08:57 -0800 (PST)
Message-Id: <dae450dd0e995b26d0140cf3753d103f5470f44d.1765980535.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
References: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
From: "Karsten Blees via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Dec 2025 14:08:38 +0000
Subject: [PATCH 01/18] mingw: don't call `GetFileAttributes()` twice in
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
    Karsten Blees <blees@dcon.de>

From: Karsten Blees <blees@dcon.de>

The Win32 API function `GetFileAttributes()` cannot handle paths with
trailing dir separators. The current `mingw_stat()`/`mingw_lstat()`
implementation calls `GetFileAttributes()` twice if the path has
trailing slashes (first with the original path that was passed as
function parameter, and and a second time with a path copy with trailing
'/' removed).

With the conversion to wide Unicode, we get the length of the path for
free, and also have a (wide char) buffer that can be modified. This
makes it easy to avoid that extraneous Win32 API call.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 48 ++++++++++++------------------------------------
 1 file changed, 12 insertions(+), 36 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index cf4f3c92e7..f5a0fe3325 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -928,9 +928,18 @@ static int do_lstat(int follow, const char *file_name, struct stat *buf)
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
@@ -990,39 +999,6 @@ static int do_lstat(int follow, const char *file_name, struct stat *buf)
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
@@ -1048,11 +1024,11 @@ static int get_file_info_by_handle(HANDLE hnd, struct stat *buf)
 
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

