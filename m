Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2033644D1
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 20:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767989121; cv=none; b=J+VMbkGMd7wXSAdbToSgkSK5TRghHMpd6zmrhaYtRM/loqQctJnUvW7FOtAwSEZF+tDbkYGEcD3m5/sKhG/2pZ6Kl5v6ST3qO7bolxecHjP/jAYX3qEBEDZ+QnT/eEsQTAjXO+Xeb31ReDKMODjJH9kclKwg7vfoIt8/esbd74U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767989121; c=relaxed/simple;
	bh=pWrsSBTEKd7cRA9TVzMjqbFZORo+bVDlJA/IuHmWjc4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DCrSjJ/N01bpbJdBmEPTp0GVDTBNgU99e2borBnL1zbTzymVzc0Rho5X6nRuwXwDowAVriA5YCyVHWu4ge04VaqlqbgDRRTWq7HKzf9tGNuU+RxuyS5lEVoLnjvKeksEZqRj9iBQzXe4fsNq5+2+tV6cKc4J4xZbXinfrBSN+88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1vmf8Fn; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1vmf8Fn"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8b220ddc189so615282985a.0
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 12:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767989119; x=1768593919; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Oj+JGWSpfaEcYpTrTTW4Ru8IQEwNKkCfl2kMh9rgeI=;
        b=S1vmf8FnPS7uDL5dIed2BvnoUYP2ItziwGTugs6pdzMU4UOztSj3FfqlEEoK6Xb8jo
         V12dKboW9dL5N92OeEltMjlctbxmUPY2lUlKXzOrTu2njZVeVeMITHIqIipv/HUmCueR
         NFb494jLzqBIGz3bL7Nd6FMZd6C2QTg9TKqqZrRnDWOW4BGoHm9ATBiYWb9+mOcot/ce
         3axNAmStE3IF6R3FAQQhOLIrlVHHjkwQJTdI+sJIR115DWcP9gKo/HFgH/+H/BBt7KzX
         Zac5aggUO/SQGVjzmjAD0JzosXdJcly9VrwCQ7z2hyCUjz2NqrEnGAjgQ6Bu3wFhzSGQ
         1/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767989119; x=1768593919;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Oj+JGWSpfaEcYpTrTTW4Ru8IQEwNKkCfl2kMh9rgeI=;
        b=VXkaHRpC7+ERvbfyBivT/QIXlEdHr1QJaQDmOnOxn0kVNyLZ0/jQD/i7ZdRTjQh1CC
         1zLj2SZziGt3xugr+EbwLvA33Zd1jz9tQ0meNPIj5eot5NOmUTHxXtZWE4xNypjyqsQp
         LfwlejsIiCqZXKXQbG2RlfQ4zm83uM0pwvoeQOAnrTODmfYJtDY74y6VSTx5Vx76bUju
         mam6YO7WX991W7KJaOTEpyWE1i61PRspe+89NBVVV60mQxaIpGkcnKh5HgXf3upbvl2t
         aNnA3rqD/xJLWiRgwG0saTCOU1WhFQMK7g7sAVW6N1DdBFQ8UoOJLtfhSzdi23NeXJxq
         YHqQ==
X-Gm-Message-State: AOJu0YwQ7UVCHRlEoyHJbd0YzsoVZIlwrISuoXRNcwxzXBP2xrDq+Qcz
	GU7UMfBunA7B8iy+c3U/tvio+B1uyjiFbxos8yomfL9bLSsVfVYVczyvS+5mClG/
X-Gm-Gg: AY/fxX7a9xGrGUm7N/5QS6Lcj0qUR1iTka72du09CNRBXXL5He/5Gr5WEQ5+QrklqlX
	1/OpA3x5oOEZr9KjkO4wF+axDdQasl2ka4Bj/YHRbgn3SGtlq0lFGSWnfEUkl8JfrW/0YimBmOJ
	AvoRT/SIVcw66Tn3IQhz/I65pwVwLGBM5+OT2zOYI3IK9U3cP800Pg6T7e6BbWAjD36aZW9/6ql
	I72K0QigOj4y/AMBaSXYTeoC5iTRgXAVmpOoGwCHpb9uZw92IsmBxXiQvMTIdu5Oy7RBL3phFsU
	s7W6CvXoAmKMI7OJuBzStWJhyjgBVOd/8a/NcYoNLM5pFNtOj3c9IND4FzrsrpHZ0GaAfccOFRp
	HFoH78rWJ/yaJzx2m2vutcgmgZsDXFy9+SQ2Ns4FhR6ZiaFJ3MYvA6Qac4HflEuE29uEzP/5rZY
	rc7fD3IZWwbe/M
X-Google-Smtp-Source: AGHT+IEeIBXpwRRiZCMh9ca7XOOPxw4N1h+Jo6g5j2ps9L+MmU4w/UJzk2AUENRKHUXahV/5qYzSog==
X-Received: by 2002:a05:620a:1a13:b0:8b5:5a33:22d2 with SMTP id af79cd13be357-8c3893f22e6mr1371666985a.46.1767989118738;
        Fri, 09 Jan 2026 12:05:18 -0800 (PST)
Received: from [127.0.0.1] ([20.161.67.219])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4c964csm887475685a.22.2026.01.09.12.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 12:05:18 -0800 (PST)
Message-Id: <5d83a8ab760c7fcbffe43ed82cfebd3d8eefda96.1767989115.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2018.v2.git.1767989115.gitgitgadget@gmail.com>
References: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
	<pull.2018.v2.git.1767989115.gitgitgadget@gmail.com>
From: "Karsten Blees via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Jan 2026 20:04:59 +0000
Subject: [PATCH v2 02/18] mingw: implement `stat()` with symlink support
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

With respect to symlinks, the current `mingw_stat()` implementation is
almost identical to `mingw_lstat()`: except for the file type (`st_mode
& S_IFMT`), it returns information about the link rather than the target.

Implement `mingw_stat()` by opening the file handle requesting minimal
permissions, and then calling `GetFileInformationByHandle()` on it. This
way, all links are resolved by the Windows file system layer.

Signed-off-by: Karsten Blees <karsten.blees@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index ae6826948e..13970ae729 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1027,9 +1027,26 @@ int mingw_lstat(const char *file_name, struct stat *buf)
 {
 	return do_lstat(0, file_name, buf);
 }
+
 int mingw_stat(const char *file_name, struct stat *buf)
 {
-	return do_lstat(1, file_name, buf);
+	wchar_t wfile_name[MAX_PATH];
+	HANDLE hnd;
+	int result;
+
+	/* open the file and let Windows resolve the links */
+	if (xutftowcs_path(wfile_name, file_name) < 0)
+		return -1;
+	hnd = CreateFileW(wfile_name, 0,
+			FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE, NULL,
+			OPEN_EXISTING, FILE_FLAG_BACKUP_SEMANTICS, NULL);
+	if (hnd == INVALID_HANDLE_VALUE) {
+		errno = err_win_to_posix(GetLastError());
+		return -1;
+	}
+	result = get_file_info_by_handle(hnd, buf);
+	CloseHandle(hnd);
+	return result;
 }
 
 int mingw_fstat(int fd, struct stat *buf)
-- 
gitgitgadget

