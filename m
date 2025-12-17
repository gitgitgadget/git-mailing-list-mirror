Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5A7398B75
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 14:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765980547; cv=none; b=Nq+IvOJfvAzLHpAXG3vjZgUCQNPMfntTnIaPZk/U2PW74ZOuqov4NTOSfDjuyWntY4pDFWNs/VKvQXVDLB11io3ScCdUttbE7YJ7T++l7MAeDGPcK6MFRVJ88FvjbKrHIoiQCJPTfRimj99OYi8j8USSbOopU7pe6qaW/DNQqF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765980547; c=relaxed/simple;
	bh=q/IrQW5xy1HM0phJJmyd6TAaZ4kNIBD+SFvz7uMcHww=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=IBwaITDvnOMYjFw2GVuMzJ0PRpq67SNXCEZkpvvCz8cYkK5yp5YfvqaFOky+wIddDMWPtqI/XOkbYuc4s/4hZJZQqsdZXE6e0pwWZDbG1aeFWFE1lcdSW06AGy7b168XafB+iANiJbc6xOBGKp7jikkIZsw6AG7tViLKuPRxqf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mi0mUi5p; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mi0mUi5p"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8b2ea5a44a9so625666685a.0
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 06:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765980543; x=1766585343; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lIH9EQe3+d4RRRy0J9UWleeYtV1u7/SFPkto1AfRqBY=;
        b=Mi0mUi5pA7mCA0ZNRjfhHLUz1C5U92UNYd5+am5ueHDgqKjyRNtYfFqIr82sTB+p/d
         Q9QWZP8rttWABuyzZCqchWR63fsN7g7cW/NapS55YQ6SiLC1RSH6SNNE4c4Vmwfsc5tl
         ozmdo/uMwSbgchO/TKbE5MxEyKUniqOfZlgP7afErn5Res6aeSRwMvUqK4nPbNhlUrvG
         BdwiFD9sTXAXs0TTMzXjqruvXawB9hJlJL2D4GXw48xbVGB4eszseuUWz0/hlwUa/82E
         1rujcwXNjc6QrDAhl0pwjRdm7VJlGm2K1z+omDTiGjjYMAlgk6SCujDgnBZpOA969sbf
         Su4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765980543; x=1766585343;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lIH9EQe3+d4RRRy0J9UWleeYtV1u7/SFPkto1AfRqBY=;
        b=TndYko4XyJp/ES8MHNqBmJqRJlph1TMkCanUB9YQQEjpWsYdNT9KLKECZ8Mz8Y8xx0
         CTrkkOqGd/xhPGTCvwJZ7FGyyR74tTXWANYbL7eEzzcT09BhJ5NNwm/OhpQBOoxqWmv/
         y0DvPqGOsWl3+6JJjt0ke9Xm4CwsmstDCcUAsVbWFByWsvn/5Evw3I8e+Gxy7QzXY7bR
         5S47i+5ddkbW5GgoasMhjnqQ7wraWdERNicKwGpWPYRVN3oQgO0DZW40a0paiKSwK5WL
         RmFp1+FgqnQ7Med65wJNzSWHNN4X94CkiK/VjUOh3SxVu8VSbIREBAOHc3htrN71iZms
         t4JA==
X-Gm-Message-State: AOJu0Yygkjo3i245sSYOecZMHi5UuIQ5O/F79TtgM0pyE34DLflz8heQ
	g/P53Bxnyd7XebkDR9TdhuxqBdPZwpe/4ahduMcVx4x3en9gQAz/cEyDlerPiLb7
X-Gm-Gg: AY/fxX5RpuBcmoGnTmf5z8p/AN1LtjO/hwmOMJJLuM8qxBtGP/n4PVlQpwdBCJ2O+ee
	2bzUZ6Txl+pZ9yV9WJFW4fgFsBLTBK02/TOGPKaOGYHYEFKeUW5pHe+o80+dgHcfiNsxssZXuxW
	fppccUhz+nlxd1Kq6utoaEp2TUqIZUqggdwTqenE1fBQomWkLX1Hk2HTDOPsSqiTyX8L6CBSyW6
	unedkxHuKb9sLzrtWy4D7wFNYXre94/b5GoWUwhQxlM+oSyQ+J4hSNL4ImBr6CncIGPdd5h7VZo
	mdXaAP9IADcvOYxbYGz9EYD8pjln5YoHJIKbixYsMpAIlNtHo3diPivOEQcio6xrTwYhkMBPJbX
	/ExdWFw3y740Eq5fdH3LCFERTGCBjd8Fm29oN6C85OE//VmhoZqpibduVVTM1RYc/46SbTR2BJ0
	rYdGlGFthvHx7ruF5c1O9S6A==
X-Google-Smtp-Source: AGHT+IEvZnAQ2iKvwiW5DaR/v22Ru4hPUohqA0+1Z0L0vZF3GMSBRtm4rS2fGiNk/qHXpZSEHC0Aww==
X-Received: by 2002:a05:620a:f06:b0:8b2:f0be:27e4 with SMTP id af79cd13be357-8bb399d953fmr2625231485a.18.1765980542999;
        Wed, 17 Dec 2025 06:09:02 -0800 (PST)
Received: from [127.0.0.1] ([48.214.53.69])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8be31b669e9sm403005985a.37.2025.12.17.06.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 06:09:02 -0800 (PST)
Message-Id: <db1d156aa01826c8371e1ebdfeafa65744b66010.1765980535.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
References: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
From: "Karsten Blees via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Dec 2025 14:08:42 +0000
Subject: [PATCH 05/18] mingw: teach dirent about symlinks
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

Move the `S_IFLNK` detection to `file_attr_to_st_mode()`.

Implement `DT_LNK` detection in dirent.c's `readdir()` function.

Signed-off-by: Karsten Blees <blees@dcon.de>
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

