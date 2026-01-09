Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D716366DCE
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 20:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767989135; cv=none; b=P/E5yI8bBQ/+OEgAOoq/FH3K3GJgjbYUh+RU4hEf1o5YtEMpJ2RuBFnaPxKG11ywNqqmqfi6+PZB+bLOGWHibSKBSy2lgDDW/EfA8df5Ip+SGnQ+gbxYePOUBTkSEFcRkprHMsdKpvu/h2FjC/OKvCHAtXMmQ20+unIYjAoCPLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767989135; c=relaxed/simple;
	bh=nQcIJEg7zhE9SZ2mvRvo6S+zKWRIfVDCpV/MhvhXfOg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YZzJV72ycNLcRlnlJlhKe3shi8PvH7Tk/lYZQGEfoTKxhKG+AJQBUsz7ndU/1YIvJJcgxwTJYBlzMn4vgqp/NcaRaH99SFcpA9HLmARvgXSOm06XBGHJT1VJK3hN5zeuMIyCCm/UTmlldLTqOCLCGn3RnKp4De5YObuA4Y1v7OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOlU5lt2; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOlU5lt2"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8c0f13e4424so448445685a.1
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 12:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767989132; x=1768593932; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DANt6saeqVBji7Yc3EDD3xN2+F5PN3a3+CVMrju4vcU=;
        b=SOlU5lt2Q8NVFKLyKdTLiqqtCKzSBTvWv/r+AODsADSJd7ANUqHHilcJcY8Na+Ie0L
         vaKYb9EBsVQnRX3RrNuWrMkNtab1UXQzmlOsAj0AqQ6tzUWM266ar0zZ+PLM8KW/pcS9
         JIOJCeweUIJqWFjpQ50keBNp+9pxKsqJdb90/KuZQStYoO8cdfA5nJx8xQ2QoQh7oYdL
         XjJjWbVz9bK4NostW5+I2YoLesoAlsD/W92YlGF278VP4Z/fDpNNkC/PfDNNs5Rig0w6
         cFigrCfgLFawq9GCpMYFARGAH6QIdRgIcCeI5WFPWHW1kJnRTsLYf6UfRse3PoBzvSaU
         ckew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767989132; x=1768593932;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DANt6saeqVBji7Yc3EDD3xN2+F5PN3a3+CVMrju4vcU=;
        b=Nf8eoKh7hlLyFqulICbOfw+pIe4vKdUpaXCwEdrauVYuKlzgNahbCPFDAvVrzOoz9I
         A9cD4id82Rr1g5l7JLjKEOfG3G4IT62vT3BRs5SH4TqTAeeaNljbKHLWG5HAXh4tPBPs
         eeo5H6SwqEr2vISajCPv80YKP2tz9kSpz+oqtug1XPm62HkeY2WG0YXR7bcKIgML8hSc
         U4ePHYKWb8emCGS/oVk8GCO4Qv2/uJDuJc2gCZyDgKtAy2ghRqcRhXtI3HkovAyVpcDb
         2pkCEQ4JXyJigaLjBWdajSnT0AYjGui67FFVgb9OOAzhQdmD2ySC9UvwoZdmRgxqlDRm
         L1sg==
X-Gm-Message-State: AOJu0YzhwdZSu2oBeHCJb8dnfsq5t9S3chvIGEkUl89DeSvTWH78IiSW
	+ZhQPXSvaUQRKFzPbpJ617ZWmesWH5iEQyyr2oTIdf4M9rwzA97PAzo6AC8VTZpO
X-Gm-Gg: AY/fxX5fL1R/OGSLoTx7pKeI5Nl5v9ZHhKzO4X4BFm0SAPN881ap5ELoa6MyVOXoSrq
	m5x3xoPB4sYJIGHeGn579rQmIj9gvmnCEMi2uMsqwnVYO+1jcDfcv7m1/N6CTq5inc85AH+Hpl7
	32rRglZXX6/KKkFArorzE5vtjZXvKA+/GKX5WTsHFBHYsvgSrkATJPkvsuuSYjJ2DlE+rAYY2j3
	JE4IV3XVPeCvHwcjYj90g6MY0pnYuuyWWyHP88cUHPz9rrZP8NnLTYAs3fGmN1zMNgg2ZMGkNSk
	/8Zv0zO718tLOnMtbk5/cSUx7ki1fkdzX0tLhwWZwuxcf523hJi/m9QmpZcrzM+sOBBDUzMoRn3
	a8sGf0PGlxT7rgX6cW5/96FWUACLV6DhgzsI1OVUzroNHTPqRqCbnzjBVUAGqtx/9l8S4JnsbBS
	yFXX9rGQxELkjb
X-Google-Smtp-Source: AGHT+IFdfFIsGjYh6KEA/TwCVo8IDg3UbR0ZeYucd/r3F1qAQ4wMX5kpxI+JV3nJdqLImMGnEZrxmA==
X-Received: by 2002:a05:620a:2991:b0:8b2:e6b1:a9b6 with SMTP id af79cd13be357-8c3893690c1mr1335440785a.2.1767989131650;
        Fri, 09 Jan 2026 12:05:31 -0800 (PST)
Received: from [127.0.0.1] ([20.161.67.219])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f51b787sm874613185a.29.2026.01.09.12.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 12:05:30 -0800 (PST)
Message-Id: <f79cf31dab8fab373978a382d71877803d89c8f7.1767989115.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2018.v2.git.1767989115.gitgitgadget@gmail.com>
References: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
	<pull.2018.v2.git.1767989115.gitgitgadget@gmail.com>
From: "Karsten Blees via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Jan 2026 20:05:09 +0000
Subject: [PATCH v2 12/18] mingw: allow `mingw_chdir()` to change to
 symlink-resolved directories
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

If symlinks are enabled, resolve all symlinks when changing directories,
as required by POSIX.

Note: Git's `real_path()` function bases its link resolution algorithm
on this property of `chdir()`. Unfortunately, the current directory on
Windows is limited to only MAX_PATH (260) characters. Therefore using
symlinks and long paths in combination may be problematic.

Signed-off-by: Karsten Blees <karsten.blees@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 55f0bb478e..5d2a8c247c 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -866,9 +866,27 @@ int mingw_access(const char *filename, int mode)
 int mingw_chdir(const char *dirname)
 {
 	wchar_t wdirname[MAX_PATH];
+
 	if (xutftowcs_path(wdirname, dirname) < 0)
 		return -1;
-	return _wchdir(wdirname);
+
+	if (has_symlinks) {
+		HANDLE hnd = CreateFileW(wdirname, 0,
+				FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE, NULL,
+				OPEN_EXISTING, FILE_FLAG_BACKUP_SEMANTICS, NULL);
+		if (hnd == INVALID_HANDLE_VALUE) {
+			errno = err_win_to_posix(GetLastError());
+			return -1;
+		}
+		if (!GetFinalPathNameByHandleW(hnd, wdirname, ARRAY_SIZE(wdirname), 0)) {
+			errno = err_win_to_posix(GetLastError());
+			CloseHandle(hnd);
+			return -1;
+		}
+		CloseHandle(hnd);
+	}
+
+	return _wchdir(normalize_ntpath(wdirname));
 }
 
 int mingw_chmod(const char *filename, int mode)
-- 
gitgitgadget

