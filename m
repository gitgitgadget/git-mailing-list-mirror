Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981E53F54AD
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 12:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777380784; cv=none; b=gQcVpLLB+e6CMg3EZQE1nZq4CbZjTQ4pk3kcAZCK8ZcPtV2/7gp2PopKil0StyrO78rEqwaBEOhDugfuEWIrHsX9ydFv0Te6RaTHLeG91fDpMgdGqSkl1Q87xeWbJPXfA2/FIVDLW11bWCxLGELu5alaoXpNqhZGOjX3QaNlMgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777380784; c=relaxed/simple;
	bh=jLojsT3yFPP8weFgka2ObyrkVxYfEJFGJuxMnVc4tqU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HdKrWgwfsp/lkDxNLKSeTwtkLA3JGGwPaNrC6/WjLaeM/ztf28+6wTxF6t4F/qOBdDJvUHxPTuJrScoiFBMYKCBwVC2iLIlau2HYj6vnzoIPd5yIljic7Z6QgHTTNpSWJJYonaKu6OQrW3xNYcefvkytWQsiIjOrqx0v+OnsjBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oVyFlkxW; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVyFlkxW"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-652f220595fso11476300d50.0
        for <git@vger.kernel.org>; Tue, 28 Apr 2026 05:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777380772; x=1777985572; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dDGWLxKFv7oelXdexI4Uf03JVRTq2AUBa/XrArJcIk8=;
        b=oVyFlkxWnI9dS4jjEKqvgv+lcPwjOSmBxx2T7yb7aD7eyzjFtSpSqx/ajV2ptAIzpL
         WX6GaNzT7luvDXnoFfaCKLZVPMISd9S3Ob/qqme2DilH58ZhWhRIE5AetB0jiAg51kcF
         IR/CN5BBF1/6ev6Cm/Fxy9CSA42A/qNecBGjgGfwrl6isaXSgtCvaCWjya5tk+ZTvjxr
         cHGlb8sQhqcPMkRA4iFx889C3QAxuT0bmGpAfpFmzoBmL5efBLbmc5TtC6YpyBvX8cUV
         zK+IYGDekQWU/wBrN91tBPqj025pl6lJALxjCYDUlTvsMHHEVgvpU6ZNpSTss5HfCZhE
         Bo3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777380772; x=1777985572;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dDGWLxKFv7oelXdexI4Uf03JVRTq2AUBa/XrArJcIk8=;
        b=U5VSvCsT2gJvRHtbyq+BXn5wIjOhwSMXcCTZ6+bJex7lmo9fvjff2THn4CjAhMyzA6
         pUiqyErwYzfCQzkWyakIetUdidWrH8voDiuK9mtV5uw/+YjO6JNl1XPwAUEsORt2O8N0
         BQR1n249iCH5TXz5ZeNRyEBX5+nn0YJcCaZd4Nv9ELc3Y2otkL2qWHT0yYgW7ItHXSfu
         03mvE7xw+jhBYUI6Tr6j0J5EqV+NIgazVTafIKiCewXgEHANMc7LvUle2y+VsbrBjvRF
         loZChv9Nz4OwLZqd2TgvdtnJ3KvwBYKLyo4a8aIq6Ve8KiO8JQiSjy5xCqaATJ61FjjL
         lsDg==
X-Gm-Message-State: AOJu0YzJw5Rpu9CPRsOU3Kciz+0r/HWmi8+tF/gs4lk4WvqY5N5/uBIX
	SV0avgOsepTVGix83xNnjXFzhKH2XWsTmhu76YcmV2/f6XqYbcFe/0gLPLQWlw==
X-Gm-Gg: AeBDiesUlBD0fm5JsWNd7qKnV5QQA0GU0PjL05dB1f/at5M9QpUiHW4Yd3kpRPgqQJh
	nXurXdfwh7s5zCG3kqmqFbE24s8V0l8BjPaYAHrQpJHle4gOv5GozoDvFTsN10/Pd/wgG4uP3Zf
	RFytbNl3uofcj9IfYxuOFbLoV3Xr+Rr2AVYo5OyhXEjZeTjPPnID9IV5Jon27jowYq8qOUdHxo1
	8DxXAavf2btqCMs8605wWNiceX5PftJcKzwLPmS6FWsByWnv7Dx81dn1NQKIXXX4KVCdBHl589V
	673rg7Py+AAIqSFlDaIF9zGdizbO7E087ukEDiOuu0xzu50POWifV2h2B54DMPsZUT/xM+bODQS
	vGtNsJdF8Qf+/4vOPvybfHwJN/QjzeyONxU+25kaG/bjJMuQKW2tbjO9jC7fx8xzzMHGJjDQcOn
	9DmoMW+ivWQRZ5PQNmNNLT/5ZqXt8QjxOjR+cgiw==
X-Received: by 2002:a05:690c:39a:b0:7b3:9f53:9382 with SMTP id 00721157ae682-7bcf50e80ccmr26327987b3.20.1777380771626;
        Tue, 28 Apr 2026 05:52:51 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.137.185])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bcf0d1eee0sm17439837b3.42.2026.04.28.05.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 05:52:51 -0700 (PDT)
Message-Id: <97508e91b62c91b77447dbba39a84770682591a8.1777380768.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2103.git.1777380768.gitgitgadget@gmail.com>
References: <pull.2103.git.1777380768.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 28 Apr 2026 12:52:47 +0000
Subject: [PATCH 1/2] mingw: optionally use legacy (non-POSIX) delete semantics
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
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

At some point between Windows 10 Build 17134.1304 and Build 18363.657,
the default behavior of `DeleteFileW()` was changed to use POSIX
semantics (https://stackoverflow.com/a/60512798). Under those semantics,
a file can be deleted even when another process holds an active
`MapViewOfFile` view on it: the directory entry is removed immediately,
but the underlying data persists until the last handle is closed.

On older Windows versions (and Windows 10 builds before that change),
`DeleteFileW()` uses legacy semantics where deletion fails outright if
any process holds a file mapping.

To allow testing code paths that depend on the legacy behavior, introduce
a `GIT_TEST_LEGACY_DELETE` environment variable. When set, `mingw_unlink()`
uses `SetFileInformationByHandle()` with `FileDispositionInfo` (the
non-POSIX variant) instead of `DeleteFileW()`, forcing legacy delete
semantics regardless of the Windows version.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 47 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 2023c16db6..04f9aa3922 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -449,20 +449,63 @@ static wchar_t *normalize_ntpath(wchar_t *wbuf)
 	return wbuf;
 }
 
+/*
+ * Use SetFileInformationByHandle(FileDispositionInfo) to force legacy
+ * (non-POSIX) delete semantics. On Windows 11, DeleteFileW() uses POSIX
+ * delete semantics internally, allowing deletion even with active
+ * MapViewOfFile views. This helper simulates Windows 10 behavior where
+ * deletion fails if a file mapping exists.
+ *
+ * Returns nonzero on success (like DeleteFileW), 0 on failure.
+ */
+static int legacy_delete_file(const wchar_t *wpathname)
+{
+	FILE_DISPOSITION_INFO fdi = { TRUE };
+	DWORD gle;
+	HANDLE h = CreateFileW(wpathname, DELETE,
+			       FILE_SHARE_READ | FILE_SHARE_WRITE |
+			       FILE_SHARE_DELETE,
+			       NULL, OPEN_EXISTING,
+			       FILE_FLAG_OPEN_REPARSE_POINT, NULL);
+	if (h == INVALID_HANDLE_VALUE)
+		return 0;
+
+	if (SetFileInformationByHandle(h, FileDispositionInfo,
+				       &fdi, sizeof(fdi))) {
+		CloseHandle(h);
+		return 1;
+	}
+	gle = GetLastError();
+	CloseHandle(h);
+	SetLastError(gle);
+	return 0;
+}
+
+static int try_delete_file(const wchar_t *wpathname, int use_legacy)
+{
+	if (use_legacy)
+		return legacy_delete_file(wpathname);
+	return DeleteFileW(wpathname);
+}
+
 int mingw_unlink(const char *pathname, int handle_in_use_error)
 {
+	static int use_legacy_delete = -1;
 	int tries = 0;
 	wchar_t wpathname[MAX_PATH];
 	if (xutftowcs_path(wpathname, pathname) < 0)
 		return -1;
 
-	if (DeleteFileW(wpathname))
+	if (use_legacy_delete < 0)
+		use_legacy_delete = !!getenv("GIT_TEST_LEGACY_DELETE");
+
+	if (try_delete_file(wpathname, use_legacy_delete))
 		return 0;
 
 	do {
 		/* read-only files cannot be removed */
 		_wchmod(wpathname, 0666);
-		if (!_wunlink(wpathname))
+		if (try_delete_file(wpathname, use_legacy_delete))
 			return 0;
 		if (!is_file_in_use_error(GetLastError()))
 			break;
-- 
gitgitgadget

