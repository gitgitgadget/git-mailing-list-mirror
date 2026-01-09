Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B33368290
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 20:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767989136; cv=none; b=Tm38lrdf1SQySYfl8CbtrU42dXb/J1zpSk52lZmC5R2dhr7CS3tvf9H+4ulPeOYgeEvWleSUg09DooJmN/Wa5S+NOhzqqEFdjmpZfUCZ4x7Tlaq9FPuVN+51nGrQzxm9FpaJNTqsVEWd247MOSJMkMgNlH+h89fRX9cFvn/0juA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767989136; c=relaxed/simple;
	bh=mkFBlwdCtDbwUv2adVwrjuB4rBealHNcYybMUcXtQi4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MfHE9K98t2dXFeDUvA2BCEC7wCNV28dSDuYfuUsoKmCGvJPMWaJYtiUt/lT8KZtosABtoI/aJHkff/BLVtBZNZfeVy7/XLaocAt4dXR7rl6hKMQD9M0Vi0RQ/qUTF0eOJ5uGDVNU4hWLOGWmV1PaiS0b94ppNzMyPWcCDiEjYJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlNyuz6l; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlNyuz6l"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8888546d570so56003856d6.2
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 12:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767989134; x=1768593934; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=byZSZ7/8JC2PlrBa183kWSTE62qPkKdbthjHZyAgv/c=;
        b=hlNyuz6lzjWwnv5GD/wXEwL3IP8CyU/3QxZ9f6ip1EWxRWbnf1j255BpnJFajQxPBR
         VAsBvw85/bxkKBd40gh4jG2mUF58cEXD9JJuxkr7oohN3OrrfagEIuHpdRG57O/v08zP
         ZfY4BYPoTyCguKQaxHcOM1+BVYBdwWrdP8eGUHf6fcCd7smkShQRwPN8FGHmu5cWRtyL
         /jelpiaRSs8pF4d7cAAUP3rWqYNla417Lpq8onMQfy0052HqjIXr7u2GFwLIcyL5/7rT
         A3J/c2o7ILpbuMkEoyWpqQ66Ha6aEnPtoP3ysZicSkvGAfL0dokdJTUQ/eKgFq0Iu6MT
         brDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767989134; x=1768593934;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=byZSZ7/8JC2PlrBa183kWSTE62qPkKdbthjHZyAgv/c=;
        b=vJ21H08vOrbknCeUqFvnW0cgxaLcR/Cpi7U35reMt7zWevuTNL/fGLGSDI9Xqx8/KA
         AKaVkZYUIAjzVF/QXStkHYT/56Y1KYEADOyjxakp5zdubw1tY5D1ifrod/wxOmiu5SXs
         RIFxoY3o2COEzlapT9tdvrJpuba6pJJcmUb52VgiRfmlSnUr9sokA3Wq/bsh8MxJtLwu
         B+twaZx7lB06f7SRjGVnDs9PzbiW1FQ4Q1qFfBb6C5ytSMMcc5qf0iaUtqZ1LsbxPBka
         45ogwoNmncT7n8OWIBcDtCV8rn/DOkOXqKa0zMrS06+Nu1G/OlCv29xqCX91WaB3iVxD
         V3Zw==
X-Gm-Message-State: AOJu0YyxJIqKTQKQ4dhWMkm6hcPL6oD93lo4/JXEhGkrqFIxfzxr3id8
	npg9qTjitBzyoSTvceqVUWXTKwzmFYK264MoXDBEvNL3YmITggiaKfPbDYGZrEzK
X-Gm-Gg: AY/fxX7mi6i6UL1l3iQhn8xVxIKz+uK1MsKDDaRGddQkNvIwiYy7eI7KZhDMzhOgyod
	VsNqOnvTJROon7WXoJ0G2Xn7YHgQ5c6ocW2os7aol4+7J2mGkjCervhI+UTSbfpgfZi9bCxCIYQ
	/tyrufUib1+mUr/+vd345bTOdwmj4ZgPNpJ0YUpc/IRyfTQXX+hDxrdkhOABxbToLzG82dcuEMg
	2oCuLpXVow+4FEabqKS4j5X+txE1CSKqIo1MA6A1MQUiedq9ckD1/rYXYoXF58d3aztdDa2QXT+
	FvdFgcYvBX5+peGE2zL0ZGLxhEIEN0KYhLo10H3LhXnnxfEcaE7t6hoJy0gfUUUEHYmSr2oOleM
	Fi9LcUhRR6L76N9+xAVBrdwWd7dOUJDJJrXDIpqJ+Ai+tVo+SmxkUCSCgapDsgHQz/CEM0SwgHg
	wmkcZC98RncCk/
X-Google-Smtp-Source: AGHT+IEONHoVfCoGcQ+0Zg2OGoI20iPWB/MI4zbGBeODajwdveSExwzj2GtFwe3tnTjlT+7WOPKSTg==
X-Received: by 2002:ad4:5d4c:0:b0:890:2a38:e321 with SMTP id 6a1803df08f44-890842e636dmr164622316d6.62.1767989133861;
        Fri, 09 Jan 2026 12:05:33 -0800 (PST)
Received: from [127.0.0.1] ([20.161.67.219])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8907723469fsm91154316d6.37.2026.01.09.12.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 12:05:33 -0800 (PST)
Message-Id: <4e0ac43ef6e04f645d501f8f46514c0dfc3f68a8.1767989115.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2018.v2.git.1767989115.gitgitgadget@gmail.com>
References: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
	<pull.2018.v2.git.1767989115.gitgitgadget@gmail.com>
From: "Karsten Blees via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Jan 2026 20:05:11 +0000
Subject: [PATCH v2 14/18] mingw: implement basic `symlink()` functionality
 (file symlinks only)
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

Implement `symlink()`. This implementation always creates _file_
symlinks (remember: Windows discerns between symlinks pointing to
directories and those pointing to files). Support for directory symlinks
will be added in a subseqeuent commit.

This implementation fails with `ENOSYS` if symlinks are disabled or
unsupported.

Signed-off-by: Karsten Blees <karsten.blees@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw-posix.h |  3 +--
 compat/mingw.c       | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/compat/mingw-posix.h b/compat/mingw-posix.h
index 896aa976b1..2d989fd762 100644
--- a/compat/mingw-posix.h
+++ b/compat/mingw-posix.h
@@ -121,8 +121,6 @@ struct utsname {
  * trivial stubs
  */
 
-static inline int symlink(const char *oldpath UNUSED, const char *newpath UNUSED)
-{ errno = ENOSYS; return -1; }
 static inline int fchmod(int fildes UNUSED, mode_t mode UNUSED)
 { errno = ENOSYS; return -1; }
 #ifndef __MINGW64_VERSION_MAJOR
@@ -195,6 +193,7 @@ int setitimer(int type, struct itimerval *in, struct itimerval *out);
 int sigaction(int sig, struct sigaction *in, struct sigaction *out);
 int link(const char *oldpath, const char *newpath);
 int uname(struct utsname *buf);
+int symlink(const char *target, const char *link);
 int readlink(const char *path, char *buf, size_t bufsiz);
 
 /*
diff --git a/compat/mingw.c b/compat/mingw.c
index b407a2ac07..8d366794c4 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2698,6 +2698,34 @@ int link(const char *oldpath, const char *newpath)
 	return 0;
 }
 
+int symlink(const char *target, const char *link)
+{
+	wchar_t wtarget[MAX_PATH], wlink[MAX_PATH];
+	int len;
+
+	/* fail if symlinks are disabled or API is not supported (WinXP) */
+	if (!has_symlinks) {
+		errno = ENOSYS;
+		return -1;
+	}
+
+	if ((len = xutftowcs_path(wtarget, target)) < 0
+			|| xutftowcs_path(wlink, link) < 0)
+		return -1;
+
+	/* convert target dir separators to backslashes */
+	while (len--)
+		if (wtarget[len] == '/')
+			wtarget[len] = '\\';
+
+	/* create file symlink */
+	if (!CreateSymbolicLinkW(wlink, wtarget, 0)) {
+		errno = err_win_to_posix(GetLastError());
+		return -1;
+	}
+	return 0;
+}
+
 int readlink(const char *path, char *buf, size_t bufsiz)
 {
 	WCHAR wpath[MAX_PATH];
-- 
gitgitgadget

