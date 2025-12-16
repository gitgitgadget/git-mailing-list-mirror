Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077D92D6605
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 15:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765899235; cv=none; b=Scr3dUcDQvQr2zEDh7NJJIK5Q/km9+Q0e2XHOoqy7WFQLze8Gs4PODqLlcY6h4zdG4QvNz03AjnHu1beuMPQLZc14Kt2FTlwsRwo5uFZteLN4tgMa0ol1vA39BmPhJ4/yullmntpEd7XIhWPD4u1MLUiqpm9EY3AZBWs4WoNp5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765899235; c=relaxed/simple;
	bh=8zlMMqjZj6FRgrd8+f9QW06laXuGqjrnsi9RhrPiKu4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fyC60TtntuFFl0VCxSBsGu7+EIrYeeDfAYKkKwxdcWTfPBKwT/XZ6by3ncLJE7ZLGvOvnizpX9MNR5TnF4PiYGolueR4zz1Q4YHgmv0njI9Ejxw0M2eIFRAIm3a66B3k2PGTcirWiYhw0WtR30nWYuWOPybFlzLwMq9diNU31aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cfh2M0Jn; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cfh2M0Jn"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4eda057f3c0so44271781cf.2
        for <git@vger.kernel.org>; Tue, 16 Dec 2025 07:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765899232; x=1766504032; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MXxD+bf+4aEQPd5WanLwsiL+2CbU/CfZ/IMVsa7vYk=;
        b=Cfh2M0JnR81oZ9tusCTrTi5VUch54EFjxpIsj5oINrm/GO/3k6LKZP9twEMT1QfFYx
         /c6B6fuDGHxaPryIbZe8rluTWglxjSLhurksOXRO3Pj5A38R5Og79NbVFUm1fwAGuUBp
         4A1aU+zYGLuYif4m3Hda5Ij0zvUwpm0agvzHSTLbdn5ophI5Nn/nfgl5xWEtim26xsOl
         mqPaeYbtkI1Tf3ts+awNRWAAs0H6AS9uhr8oQIDKouLqOScuPLAVE946JX2bqzx+Wrtd
         pYuVPK/wX8UjVIxfzW/1eekC1Kyuc5/xGSZq5ryFqnlFVEAkaYc/ixWkd9rLu0/933DK
         ENpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765899232; x=1766504032;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2MXxD+bf+4aEQPd5WanLwsiL+2CbU/CfZ/IMVsa7vYk=;
        b=fKR8QFa7b7NHkPczIzJaxOz/UFEQ1jud/MY0EOw+cuV3qC1dSFH3gegNAIozKJACAb
         rl2TGmXXy1OIaSOaJ1jS6w6nwY4nAkeQ9Zm5wpPHlEHRjbX0e9IxQt7XCSpPHe0FMj9f
         t6A1L/oZhrQLqbRvqHPQTibb1lmJZhMhMfgMBBwwjsz9NtVGTILa6+etqZzUElBKdyEu
         GU0QF3VNmNGmqcCBShSXnKJ4NlWFsBAGw8xWv04GcE52rgs4F2PgGsN+GIbYaBy+MDFe
         agfBw6t5TUv8hZ30Ru/enCd4Fx2buHpiW/evUroohLdZOm7MTqka9rgHfU7/8QFh7bJ9
         e6HQ==
X-Gm-Message-State: AOJu0Ywc+LIMOLErOwu7oUQ1++/0150gqHnxQDoVhSokhqTB0p7Sai37
	vHiT+q6XHD+TAqslqEWUl3w0AXrqJ1TiR+gKrdsSRs+4aOcUgqWKambhfOxHIw==
X-Gm-Gg: AY/fxX4TokK9x4pwyoh7TKqU/UeCcPEL8cVeFfET61SbiL1j9r8PAiq41C5mM+JiUyo
	32S6OyTrRwTMu+gU8/WqcU33YKCSj8NlIX7i/L2vN858zSIGYktvIBV5QB4rEuRbBUV2eZ28N6W
	6IAEMckIvrr5jQtFHWcOJunal2b5mphSBdZnSNwZ6ReKmyLq5Peiqaglf6JPuyhEDnmNg8c1dt+
	1JxOOsBkOxg5UrqUzQKrYOUCUJvIvnexCwVA9V4QW7ohy7coZrCwkHYJgdC26szojB6BHPXVdWx
	8ZUIolbncKn9wwU1R7FesTa9T64b7SHvqct2S6AG5KRSarOKIruliRE+AaMwbZhQFG79gh2CWee
	BQQdX09cfQWsKwkKsWQlVk5kJU2p37/QXL54CGlD0ZWRlm2VrkTOeqDFK3YGmHuyR960NmCjLOI
	/QaQjtsQJYsg==
X-Google-Smtp-Source: AGHT+IHjJl8wKWQpAaFjdgoF3j0HV5nlaLtgfBrH6sLsw6vm7MDZ9/7o8XsSxUvQViz3gEeow54ZHw==
X-Received: by 2002:a05:622a:a0d:b0:4ed:b06b:d67d with SMTP id d75a77b69052e-4f1d059d2b0mr191167731cf.45.1765899232172;
        Tue, 16 Dec 2025 07:33:52 -0800 (PST)
Received: from [127.0.0.1] ([4.246.135.7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f345c2e0ecsm17476231cf.19.2025.12.16.07.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 07:33:51 -0800 (PST)
Message-Id: <1928738b464915e3fb796145688bbfcfcc0fee3c.1765899229.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2017.git.1765899229.gitgitgadget@gmail.com>
References: <pull.2017.git.1765899229.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 16 Dec 2025 15:33:45 +0000
Subject: [PATCH 1/5] mingw: do resolve symlinks in `getcwd()`
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

As pointed out in https://github.com/git-for-windows/git/issues/1676,
the `git rev-parse --is-inside-work-tree` command currently fails when
the current directory's path contains symbolic links.

The underlying reason for this bug is that `getcwd()` is supposed to
resolve symbolic links, but our `mingw_getcwd()` implementation did not.

We do have all the building blocks for that, though: the
`GetFinalPathByHandleW()` function will resolve symbolic links. However,
we only called that function if `GetLongPathNameW()` failed, for
historical reasons: the latter function was supported for a long time,
but the former API function was introduced only with Windows Vista, and
we used to support also Windows XP. With that support having been
dropped, we are free to call the symbolic link-resolving function right
away.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index ba1b7b6dd1..7215b127cc 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1251,18 +1251,16 @@ char *mingw_getcwd(char *pointer, int len)
 {
 	wchar_t cwd[MAX_PATH], wpointer[MAX_PATH];
 	DWORD ret = GetCurrentDirectoryW(ARRAY_SIZE(cwd), cwd);
+	HANDLE hnd;
 
 	if (!ret || ret >= ARRAY_SIZE(cwd)) {
 		errno = ret ? ENAMETOOLONG : err_win_to_posix(GetLastError());
 		return NULL;
 	}
-	ret = GetLongPathNameW(cwd, wpointer, ARRAY_SIZE(wpointer));
-	if (!ret && GetLastError() == ERROR_ACCESS_DENIED) {
-		HANDLE hnd = CreateFileW(cwd, 0,
-			FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE, NULL,
-			OPEN_EXISTING, FILE_FLAG_BACKUP_SEMANTICS, NULL);
-		if (hnd == INVALID_HANDLE_VALUE)
-			return NULL;
+	hnd = CreateFileW(cwd, 0,
+			  FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE, NULL,
+			  OPEN_EXISTING, FILE_FLAG_BACKUP_SEMANTICS, NULL);
+	if (hnd != INVALID_HANDLE_VALUE) {
 		ret = GetFinalPathNameByHandleW(hnd, wpointer, ARRAY_SIZE(wpointer), 0);
 		CloseHandle(hnd);
 		if (!ret || ret >= ARRAY_SIZE(wpointer))
@@ -1271,13 +1269,11 @@ char *mingw_getcwd(char *pointer, int len)
 			return NULL;
 		return pointer;
 	}
-	if (!ret || ret >= ARRAY_SIZE(wpointer))
-		return NULL;
-	if (GetFileAttributesW(wpointer) == INVALID_FILE_ATTRIBUTES) {
+	if (GetFileAttributesW(cwd) == INVALID_FILE_ATTRIBUTES) {
 		errno = ENOENT;
 		return NULL;
 	}
-	if (xwcstoutf(pointer, wpointer, len) < 0)
+	if (xwcstoutf(pointer, cwd, len) < 0)
 		return NULL;
 	convert_slashes(pointer);
 	return pointer;
-- 
gitgitgadget

