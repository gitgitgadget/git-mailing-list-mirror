Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C67397D0F
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 14:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765980543; cv=none; b=etaDGNeTfQGTXgWjxjqizHYfjXrJOUxj0SpYmdInUH/YiEYdTwImScvXa+thX49PBS4Um4OVrXhb8d0vU5shaHFMp8j8I6eLIwl7kMWUr3mJV3Au9FLItPnj8QsRWDR4mSjQL5ACePezZxoLKFjQE9PPKIPFz2cnfAykhrjsc9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765980543; c=relaxed/simple;
	bh=/4BX15i0pBDE7ySp+ZDjTHWMH8X6BzMPWN+B8mMMe3s=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZdZwxHBZZp1hMdX+31LD0yQiSXUjUFgJQXrw3chTswrGTuqxvgZNQsNLbXcJ4to9mrXBovN8wAesaZTuTLq8hF2ksEv4n/6UkBK7rWhj3U/W0eQiXfuyzlo9aTfz9nlmgvaAGaPsCFWMtemt9Ytey0mGvT1AUlLn7+gsl4Ajv5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcMx82P5; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcMx82P5"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-93f5729f159so3360165241.0
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 06:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765980541; x=1766585341; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFQ+k1Ui5/8bYhQSEdRwn+HI0En7QfMWCGznvDGaMog=;
        b=YcMx82P5LDQ0EMUAxKS4zt9y8sLJwABX4Kq0Z83i2C3jGFYbejp3WAaYyZUUiIowyu
         8WyhcA4DW0/l85zPY25l/c1cV4YphGiqDF2n4q98/nPcxMCw0k+3fCrfL7IDzToUhL3s
         IP5KB6tWH9nxCCY/TTHG9bQkenHfhPQCAiwFWLI/7r/vSF3HTpo6MOuugxVUChinG93s
         aFW+HuPy2OCr4smIgILxTUgyVVgjtB1d5+h0X9RdcOQJllE0RE7kYbCbvACSLxmVIgRw
         96VPQIOO8TV1dJSggai4sRJoXK+pCv3t6Av523L/153hlJfFJBVDe45IrBisDsdlXocC
         w4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765980541; x=1766585341;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pFQ+k1Ui5/8bYhQSEdRwn+HI0En7QfMWCGznvDGaMog=;
        b=h1oYT3YpO9Sso1m+aY0oXg7ZYRxlcgWr+rCuuWGXE7CzwJ7HnuQWTdPuH65uI+inOf
         SlzQlWiU6c2EFM/RVqOq8qWJOiGPluSOOt5yoTG0WfCyUetbuN5qvA1QLSaP6qTxvgEX
         XS5zaX8hgZg2O5NEWQGX7WFN6Je3KjeBNL4GKGEnxpItcm0KfUHv5ZSzEDbEJ2yXo3n7
         gQJeR4tHCAtQxJBOMpl1cwk89IuAJThVNWP2mMdKsrOmXJ5cDV0kDrBo3ahmrx4dZPyv
         yHPwi6bl68PmU35LQcRxIcyBdsmCac1KMdWshj8QCbLZvZfS1TLmN2UskUditAMleEHv
         pe2g==
X-Gm-Message-State: AOJu0YwHR++NiOf3T75dDKGzydkb7cnzxugJo8C8pUf0PexJ9buPFGqP
	REYNnpGx1fQXbHBqtdGNad6Az8WHAorMsp9M6jCWPaH2I+VF/6oLkoQy/Oj8K5q6
X-Gm-Gg: AY/fxX5Ucwg/6EO4LvyA+GVJsazOn/nnt3I2nhcTUcVfuqEY6pkmlezFyFG/jq3Bxdr
	t5avZt98NlSC6eR8SM7xwa3Q2vGm0jbmohc/mtYA6njdH9+qcwEKN9qNJ/s7xrp3RhPSEen91mD
	p7KOSm/atV7+kGyYKNvLrIdX+yy42yjko2REuhVnY7h3PRreR5py3VV2vUK38NVbgMKJPCaeUd5
	zl53qc7YAHmDY25Ed3D6STYNRGXeCsyQk6bhSBjS7ER6UCaLXySzPcOBkXKTmiqlt5/SLckC9vO
	Hxcmhl1vvl/zK8eNeWRDClz2lR7087+//ICKXGJwmSWCPNOq1tHOvi/msHW0qY594Ozg6IBRc8c
	0Pen5aQtG4dTfiKOk1RYT326lLRfr90AUaHfWRtUhLmGahwcGy4+7O7Xe+/MHeII1TfWhhjT+1c
	hpxaNFr307kZ0=
X-Google-Smtp-Source: AGHT+IFnTnCcdGKx2KngrwLZw0dSt52fySiRM7T0JnwsosVrxWMHZS6oiAX/x0d4TopquyFUxl51lw==
X-Received: by 2002:a05:6102:5128:b0:5db:28a5:2afe with SMTP id ada2fe7eead31-5e82768a364mr6841120137.12.1765980540702;
        Wed, 17 Dec 2025 06:09:00 -0800 (PST)
Received: from [127.0.0.1] ([48.214.53.69])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88987f398d1sm98446226d6.0.2025.12.17.06.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 06:09:00 -0800 (PST)
Message-Id: <aa0ca80bbb00ec53f359c79719b95bcc141ac85c.1765980535.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
References: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
From: "Karsten Blees via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Dec 2025 14:08:40 +0000
Subject: [PATCH 03/18] mingw: drop the separate `do_lstat()` function
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

With the new `mingw_stat()` implementation, `do_lstat()` is only called
from `mingw_lstat()` (with the function parameter `follow == 0`). Remove
the extra function and the old `mingw_stat()`-specific (`follow == 1`)
logic.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 59afd69686..ec6c2801d3 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -917,14 +917,7 @@ static int has_valid_directory_prefix(wchar_t *wfilename)
 	return 1;
 }
 
-/* We keep the do_lstat code in a separate function to avoid recursion.
- * When a path ends with a slash, the stat will fail with ENOENT. In
- * this case, we strip the trailing slashes and stat again.
- *
- * If follow is true then act like stat() and report on the link
- * target. Otherwise report on the link itself.
- */
-static int do_lstat(int follow, const char *file_name, struct stat *buf)
+int mingw_lstat(const char *file_name, struct stat *buf)
 {
 	WIN32_FILE_ATTRIBUTE_DATA fdata;
 	wchar_t wfilename[MAX_PATH];
@@ -958,13 +951,7 @@ static int do_lstat(int follow, const char *file_name, struct stat *buf)
 			if (handle != INVALID_HANDLE_VALUE) {
 				if ((findbuf.dwFileAttributes & FILE_ATTRIBUTE_REPARSE_POINT) &&
 						(findbuf.dwReserved0 == IO_REPARSE_TAG_SYMLINK)) {
-					if (follow) {
-						char buffer[MAXIMUM_REPARSE_DATA_BUFFER_SIZE];
-						buf->st_size = readlink(file_name, buffer, MAXIMUM_REPARSE_DATA_BUFFER_SIZE);
-					} else {
-						buf->st_mode = S_IFLNK;
-					}
-					buf->st_mode |= S_IREAD;
+					buf->st_mode = S_IFLNK | S_IREAD;
 					if (!(findbuf.dwFileAttributes & FILE_ATTRIBUTE_READONLY))
 						buf->st_mode |= S_IWRITE;
 				}
@@ -1022,11 +1009,6 @@ static int get_file_info_by_handle(HANDLE hnd, struct stat *buf)
 	return 0;
 }
 
-int mingw_lstat(const char *file_name, struct stat *buf)
-{
-	return do_lstat(0, file_name, buf);
-}
-
 int mingw_stat(const char *file_name, struct stat *buf)
 {
 	wchar_t wfile_name[MAX_PATH];
-- 
gitgitgadget

