Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83683F20E6
	for <git@vger.kernel.org>; Thu,  7 May 2026 12:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158279; cv=none; b=uahBwjI7xzHCShiWCu5noD5hpAXaQVf/jF0AbtsMlxHJGOUtGPYFxz7G66S+VX30W3q+rhgrAfPSlM6TLYmFflMKVbDLNs6f73Qk7KpvbhS+SbO5MKXyVCjtmfY57ox5a/4hq9UYFUTU8Jl9kX+FFAvZGsnptxUuXmEQHRy2ofM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158279; c=relaxed/simple;
	bh=chSFdLA6gaEnJh1JfbFmjrYyNRIRV7SAostygs5o1+M=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=s4UQKQ1PeIVS4VV3i4yf8Vk2VIfEy66B5ZxsaDEYZRYJfjtPO7J9ymtCVs15RQeAmMmPxYJZL49VRSamNlC7qvGUWIIULB9jz75FO8JC02G2aHISdszAQmp0lDr6OEdP4ysdHzLDTAfTwo4LNW+T8pzM69eWsDOiyq8hcbXzW+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jrxz19Il; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jrxz19Il"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8d736211595so55114185a.0
        for <git@vger.kernel.org>; Thu, 07 May 2026 05:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778158276; x=1778763076; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m78NMXdG9yMxhLsGRNany8UpMqQUmryXk3KYDr82MVI=;
        b=Jrxz19IlRu9r3+LE9j6SKaLovGpPdXfYnD2tKMvjUdLQHzDmuCRVYPl/w5GDb+5222
         675RvP5YfwewQ3khsf0LfZSOuceKQSUD5/64YOpWqdm26kR43RISGXmD+pn2ckaMcUf7
         O3As2VQ4rIhcjrX3l2212pJI3s41bAzF0l2+LS7208jCjT3xr26PHU5rf118MZ0MIjjn
         1/PfdTP0/R34naObboGck8VNKFANxT8ssbGxrIDMB+XgBo1YBg9HLp+mBunWlLFj6zaA
         EzBOBzng7LiFUcoa7cZgC6tFr/phmijHCa4SOLVH7H1Z5kMndqt4yqvtnRgeN99UJcY1
         +JAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778158276; x=1778763076;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m78NMXdG9yMxhLsGRNany8UpMqQUmryXk3KYDr82MVI=;
        b=FeEri3N5khF91SN75CBuuUCTVdPR+6k0fwy6mO3mhbRfRXKvdlLrgBj18LbZAi6Wuj
         DxcTEpDWDGQAkuI8kVqnSNMIIjO9Nt+rZx/V82iGohHVm1wII/rFiQ7iLnyJPWLIJCwV
         zwpm6oJ00WH3Z8vnqou63+y9Xw3a5KobqmKBH+aTBz4ZMktzuFBCSEwxbUPqafQ7wxGf
         gtvarfr+l2h13zA7JgDg5HZf7GpCVjMx0dBWJEsV3xdW9HAcwLEWP2QtE59SeUnPl0KH
         ESGOO/IYvecksCZ4tOnOpY1Cll3buMTxI2FqwOUGsRYDmW+zFqI0Oux1SMBlm2jiaoqH
         xP2Q==
X-Gm-Message-State: AOJu0YwWL1swHfGWtDdb2qAmy4V8m3MbwOWqGGa0ISewzkdd54JNHSk6
	yzGJPbgJoH+pkVAC+XhM0O4k1wFqLbL6vv4VL98+okN6Jm3A/afP1LVSp/zrkg==
X-Gm-Gg: AeBDieu0EdgOWtjTjJ7z9aEsLYewy0rKUmWNeEgEaNJVB5KWNP7YZpFXSlEZxzAIpMz
	aImoSYscYQnmzbX4XAj7GoZ3h0TMzzxNK+Ajwtl+FXRsHW1WGocVQ8/LoENOs9L0kWAk3v1DwQG
	X3TdN+CYV+rLuO2xD/kUh9+FU0Nf0u8GNT+DLcr+wsN7Q9QAhQ7Ex6h8oiALOpb1d56aFOzY6Ti
	i68z2aMzvrawx0fz5MC2GlNwLnHVu9/Gza4lswpTkwrhfcbLDRniw2lk5XcOYYWYkSWckP47nn0
	V2OugBQPwQ3qPk3YAvdG1+SPHG3UZXyblC/5t9BvyvkjCbQpv9UWl4umg1owbBfLDiyxAwPZfcB
	s1obPVnfwsNnlH4XG0uW1CplrVj+JiIxQP3VNLa/fqD1G7PJ11WDW5wQCn2kjCCNijIcYHojX0d
	A7ADYUoaqDdsbvjWtPixE8OnGSw7Bs0Qux9jMR8SMgaYmK+Q==
X-Received: by 2002:a05:620a:4101:b0:8cf:dceb:827e with SMTP id af79cd13be357-904d6ccc0d3mr1126046585a.52.1778158276117;
        Thu, 07 May 2026 05:51:16 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.117.85])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c253e04sm1917192685a.31.2026.05.07.05.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 05:51:15 -0700 (PDT)
Message-Id: <8ee749dd2fea06811e929d247e34132cb5c95ead.1778158273.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2103.v2.git.1778158273.gitgitgadget@gmail.com>
References: <pull.2103.git.1777380768.gitgitgadget@gmail.com>
	<pull.2103.v2.git.1778158273.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 07 May 2026 12:51:12 +0000
Subject: [PATCH v2 1/2] mingw: optionally use legacy (non-POSIX) delete
 semantics
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
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
index 2023c16db6..aa7525f419 100644
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
+		use_legacy_delete = git_env_bool("GIT_TEST_LEGACY_DELETE", 0);
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

