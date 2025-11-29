Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD13311979
	for <git@vger.kernel.org>; Sat, 29 Nov 2025 18:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764440916; cv=none; b=PnNo1H729n+vsoKZZBhzawHcWVp2Areiu9vLxPWvgL0T8tVgJin5o3B5L51fSGInwY1QaDO42lh6p/zqX/wxyNXsh/WrK5xR6WTaKKz8Vhiarx0WTtS22kf27NeFz0EXy1bgEbinJ+zgVDtSYp/iuHGjntQv1Ac+Iw7W5vnXnMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764440916; c=relaxed/simple;
	bh=96XjwrIn3XUzTvRB9kGSlc1CeZWI9mmwVRv7HHNyqQY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CP1/PuG3UUGfegt64EY521nbohXLyHyO+Q7d6y7GwvX3A6P7kHAZnfXJGIbHxXVE4/qkpHRszcEkSU0S3ncKoLn4p1L6UhGJJZk7zdi4n4tN6hGTGKNbyciMdZVd7vNONvQEIS0hLDDIc6V9IUR8l5gBDmB+sPLf/EoSWIS1RZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tb+WgBhO; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tb+WgBhO"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8b2d7c38352so365768985a.0
        for <git@vger.kernel.org>; Sat, 29 Nov 2025 10:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764440913; x=1765045713; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItOI4uMh0uMFKRfhENseGlftt8X5Mk8TBixVlXyJ1X4=;
        b=Tb+WgBhO36WAgnztlGERdvZ6ZtDIbHp3H9VcM2Xbte69ZoUswWt38M1gwE9MW4rl94
         yTQkUGo9Ib9JLWretjFhqcpU1wyxv6KK1z+XheS/8qD5ZoTb9wZlzGish/JTHVA7HcZa
         zGx2Q+3IWVmEuiXe2jE7QrOcm7a9ATexX6eDfY1r8W2nuRkQKqp3qS6/whBOQiowo5rA
         /jd6a4eZPpEenjQsubZ+W/7TDMRH3dx2thYas69A4bePKA/X4i7tDH4uhaWFJ+hFEBn0
         85Wt2QwfbhRZLnoXZ9YtSJuU6gZ8vrBj3ieWaM8OpeEtOooZZZ/gO3H2BPonTSdTtnCz
         Y2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764440913; x=1765045713;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ItOI4uMh0uMFKRfhENseGlftt8X5Mk8TBixVlXyJ1X4=;
        b=cfl1DdF00tx0O3CIynfHUEz/ONGkn3L+a/oKSxHlHwVh7FGCeiA6sBvLm9fY0RE1fQ
         c81GDThzR/vPsBLD61vdmGkDZZl8QbnE9IsPbnDMiEMVhh18fI9brc8TsAVxcZegDbId
         Gr6RwQFuL5GT7aG4FsM6b7RlqE0/ImFO0yj/2+sDpdENE3eTeWAxFMuq0kEic8gfchjX
         JiPvw13Kd08KqrwANuQLLeOrDtnq+2SJp8JXkD8NL+87QnLfqLzCcoM3VNw4ifTnaoet
         /lCgGPUoUdXjf3iX9/SGWJctEcWjhsgp4OxDEYIygOmC4TUpIw1INkfrVvaj2WQr2UbG
         f4Zg==
X-Gm-Message-State: AOJu0YzUQkoodLi9Xl88VFDFDp0m86709QoBTkSWFJvEHKn5WFDS/a8R
	Jm//ztzu3yw12TyOM6M24jLAIv4MhGISIWRHuSsM6qBwj+xkTtTTrmiVPqy4Kw==
X-Gm-Gg: ASbGncvFEl9BXPWacU/vKCH1fCsg0KYl3E/Ib31J2rIpTrKVthCrGEYXiXbLlJ4BV6f
	Hf4jQEUW0VM4yek3CQEQ9ux7MqJ/uE/+NSaVQtUEjVIp7vYMBLNYYZTsXBgbXIsAvf4x+C20Xti
	5tSGaYB446EVfvoTqmNV3jo+PnrBKCwJcSTJQaOUsZeGtTFXfD5unwm4awPak2KhrCUcKONgow4
	a0f6OQe3Lxv3SHD4Ns2tRJKQozzs+EqaGzPEEXxPXbPs7Npcs4SJ0DExmnRCRfMVzXjeSOgYzW/
	NtHWzx8kn+HXSAXSdyxik4g2NZQjbyVECSlsWtrS646o0XmYaC4Xb74KOAK+KariN4l4HAWa37b
	AFoiZUC2AFTXg/dbji5uiRUpcvFoO+eH47Wdd52Z16q7+vo2+T0vzpq3J5WMyTif/rmyNrWUZ2m
	nYlkQ5yBxUQP8i
X-Google-Smtp-Source: AGHT+IGpPvnb0uT8MSknkfgu+CHC6XeV7W30S1rQWCTmeJWhdwElzbHtU0de7DWLaM4wG8HeMt136Q==
X-Received: by 2002:a05:620a:45a7:b0:810:a62b:1950 with SMTP id af79cd13be357-8b33bde8919mr4895676885a.31.1764440913228;
        Sat, 29 Nov 2025 10:28:33 -0800 (PST)
Received: from [127.0.0.1] ([20.97.198.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b5299a5377sm534524285a.14.2025.11.29.10.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 10:28:32 -0800 (PST)
Message-Id: <96e279f50ebc26084095e781cf58db233fa05b74.1764440906.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2009.git.1764440906.gitgitgadget@gmail.com>
References: <pull.2009.git.1764440906.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 29 Nov 2025 18:28:19 +0000
Subject: [PATCH 03/10] mingw: special-case `open(symlink, O_CREAT | O_EXCL)`
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

The `_wopen()` function would gladly follow a symbolic link to a
non-existent file and create it when given above-mentioned flags.

Git expects the `open()` call to fail, though. So let's add yet another
work-around to pretend that Windows behaves like Linux.

This is required to let t4115.8(--reject removes .rej symlink if it
exists) pass on Windows when enabling the MSYS2 runtime's symbolic link
support.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index 736a07a028..9fbf12a3d3 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -627,6 +627,7 @@ int mingw_open (const char *filename, int oflags, ...)
 	int fd, create = (oflags & (O_CREAT | O_EXCL)) == (O_CREAT | O_EXCL);
 	wchar_t wfilename[MAX_PATH];
 	open_fn_t open_fn;
+	WIN32_FILE_ATTRIBUTE_DATA fdata;
 
 	DECLARE_PROC_ADDR(ntdll.dll, NTSTATUS, NTAPI, RtlGetLastNtStatus, void);
 
@@ -651,6 +652,19 @@ int mingw_open (const char *filename, int oflags, ...)
 	else if (xutftowcs_path(wfilename, filename) < 0)
 		return -1;
 
+	/*
+	 * When `symlink` exists and is a symbolic link pointing to a
+	 * non-existing file, `_wopen(symlink, O_CREAT | O_EXCL)` would
+	 * create that file. Not what we want: Linux would say `EEXIST`
+	 * in that instance, which is therefore what Git expects.
+	 */
+	if (create &&
+	    GetFileAttributesExW(wfilename, GetFileExInfoStandard, &fdata) &&
+	    (fdata.dwFileAttributes & FILE_ATTRIBUTE_REPARSE_POINT)) {
+		errno = EEXIST;
+		return -1;
+	}
+
 	fd = open_fn(wfilename, oflags, mode);
 
 	/*
-- 
gitgitgadget

