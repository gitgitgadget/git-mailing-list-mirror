Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8150C39B6A9
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 14:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765980559; cv=none; b=AR0GIFouLHppZFSi1SSC89yesnlOwz2N/lvn1HhfhRVPPgBTR0U3oUwcKDSsLPj7QLZ2UXwN1y289FPwXaIQE6DvwIgrCSXwuANoL/v45A9a0AusGigoK3Gc+CkOKnNj1fWadPSXAeux/ultfkbK0fYKTa+JQE2hvAJ0DJGwqvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765980559; c=relaxed/simple;
	bh=q3DNDMh9/qJUjjY5pv0PHw0sf+kroMagZgpFoBwGMts=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WheLMlJrh76k0+A0VjCJTiMUaGTF55Uwy0od1XJXBjCV3K7uTHLYMfxHLhLhL1YSwRa2yCgYJYabq4AW3ywktqnp20IAakt3zYsU9iyXem4mEfoUEmWuQTHh67Y8wq9E574ppACxr8gP42ysYHm0fY3cPz51OpSIbcg5E4wGN8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qj1v/0/7; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qj1v/0/7"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8b2ea5a44a9so625686185a.0
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 06:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765980555; x=1766585355; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=izkttAH5zNBYKvJYgE53eO1RDyZrt/oG52ZVOc4EuiM=;
        b=Qj1v/0/7VYqXQeueN2lwqeRJyz/mB4J+chsFKmd2DJd53OBTjTArTXBWFlrLWUvOfo
         A1xvUycAK0cTc1UmG4OZgB3Fid3m5EL/k2HCO+JF2oeO/O7BkadZIwshETza91NXtCLF
         +1T5kLPB3AWNmXKJrwjPQLvFrlf7eeY3KkvoPNKkBTeuCJvy4ra8LMMPuvK4kNcaA0x/
         iZEbkW68V/WjiXE5mi/+4omJx49RpS1G+d4r5OEj7f0ARqUaeOxoMct14PBYctxpxPhe
         V3tXeVu0ll5PF4DV49E5b9I4/rCispcrALGhAwpa6PiFZgA2eOX7XU39HIbY8N2EaThA
         1zOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765980555; x=1766585355;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=izkttAH5zNBYKvJYgE53eO1RDyZrt/oG52ZVOc4EuiM=;
        b=hF8omxRBzDdEwEYVCPefaUxHU0lPcXWDwlgywCVHdzk4GU37gk2XbSF9+XDfSg7xev
         7quBWm8tJ9Nuu7fTNXi/amhr264VRTkPleRqk2LYakRBzuwKe45s9P8WXWtSQ0cxmn6M
         LB/b/HKsEePnCWXpWYNjxGduR5trGOtX2ysXk119lYGc8DtDt7siek4cTio6LjMnVQBJ
         jMm/woKZDVEHmBI29QieT9ICdb2T3x6TbAERNsDLQR98UXxwSO15TT+S9vIUFCsWz2B5
         7+vPIOSp4GydYkLvPysWAdtaLQULlHHzfHY1S+E2c8EDqa8fPR39bxKxzLl7YMKaA5+S
         A8Gw==
X-Gm-Message-State: AOJu0YxXtZdxYY6xy3Gw704HyUbLqZ5LmbgdclUXGfkDpmpXZIiOf+RS
	bV1OIi9EjL64M/cS8bbsZnwRSNmIIcTPLVIBKdmlI0iJYAWvkQd9ImOr7XwJ7pzn
X-Gm-Gg: AY/fxX6doedJb64FIcgtEHL+YgkuQhELTieJLFXTuVAbOoEGtFrzgcCYVoT5aMSYmlO
	vSm6UrXZ3aD5DDUbbZc4vt6C7qYw19Maaw60AkYo2kO/ydHEg/XY/3o1rftzp9fF8vkllqDic88
	tZjYko8Kn2Q2FzAleg9E3cTDmy+uKbhU8Ra8Zem0fA4rqVy0CE/iyUgvTsIe4lK7PWuhLt/Iesz
	n4T6Qf9sKyYZ82e3fQaerq2WzJ5ZOW+flNpmQdtgS/oHhMHbIWHx+M3XD3Uc9j0eaH9ECiMmOmV
	kCqZXcQxEPxISqFNbim+R9i1PNo7Jlae8HEpezlNnQvchUGUgL+arb7D0nwM8u1lc98ldEGKniJ
	29IALZGGc7ONzQi8y9YTIgHPJ58DM+xCgAAKdlGIklFcxulqiX5xV6n5ibPDV0ebb36wUHqssMX
	M/sNKKX9ITh3w=
X-Google-Smtp-Source: AGHT+IGjF/PgZ8BXFY6shlWTE32ZQq+GEF+AwEcQCsFHxygLtexRlWYGUkKwZ+Rx9wlXL35+jft/EQ==
X-Received: by 2002:a05:620a:700a:b0:8a3:1b83:1025 with SMTP id af79cd13be357-8bb3a38a363mr2647023985a.73.1765980555014;
        Wed, 17 Dec 2025 06:09:15 -0800 (PST)
Received: from [127.0.0.1] ([48.214.53.69])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8be30d86914sm396453485a.17.2025.12.17.06.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 06:09:14 -0800 (PST)
Message-Id: <8fef8220f4d60b48358882fbc961c4604eab3abf.1765980535.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
References: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
From: "Karsten Blees via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Dec 2025 14:08:50 +0000
Subject: [PATCH 13/18] mingw: implement `readlink()`
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

Implement `readlink()` by reading NTFS reparse points via the
`read_reparse_point()` function that was introduced earlier to determine
the length of symlink targets. Works for symlinks and directory
junctions. If symlinks are disabled, fail with `ENOSYS`.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw-posix.h |  3 +--
 compat/mingw.c       | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/compat/mingw-posix.h b/compat/mingw-posix.h
index 0939feff27..896aa976b1 100644
--- a/compat/mingw-posix.h
+++ b/compat/mingw-posix.h
@@ -121,8 +121,6 @@ struct utsname {
  * trivial stubs
  */
 
-static inline int readlink(const char *path UNUSED, char *buf UNUSED, size_t bufsiz UNUSED)
-{ errno = ENOSYS; return -1; }
 static inline int symlink(const char *oldpath UNUSED, const char *newpath UNUSED)
 { errno = ENOSYS; return -1; }
 static inline int fchmod(int fildes UNUSED, mode_t mode UNUSED)
@@ -197,6 +195,7 @@ int setitimer(int type, struct itimerval *in, struct itimerval *out);
 int sigaction(int sig, struct sigaction *in, struct sigaction *out);
 int link(const char *oldpath, const char *newpath);
 int uname(struct utsname *buf);
+int readlink(const char *path, char *buf, size_t bufsiz);
 
 /*
  * replacements of existing functions
diff --git a/compat/mingw.c b/compat/mingw.c
index 5d2a8c247c..b407a2ac07 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2698,6 +2698,30 @@ int link(const char *oldpath, const char *newpath)
 	return 0;
 }
 
+int readlink(const char *path, char *buf, size_t bufsiz)
+{
+	WCHAR wpath[MAX_PATH];
+	char tmpbuf[MAX_PATH];
+	int len;
+	DWORD tag;
+
+	if (xutftowcs_path(wpath, path) < 0)
+		return -1;
+
+	if (read_reparse_point(wpath, TRUE, tmpbuf, &len, &tag) < 0)
+		return -1;
+
+	/*
+	 * Adapt to strange readlink() API: Copy up to bufsiz *bytes*, potentially
+	 * cutting off a UTF-8 sequence. Insufficient bufsize is *not* a failure
+	 * condition. There is no conversion function that produces invalid UTF-8,
+	 * so convert to a (hopefully large enough) temporary buffer, then memcpy
+	 * the requested number of bytes (including '\0' for robustness).
+	 */
+	memcpy(buf, tmpbuf, min(bufsiz, len + 1));
+	return min(bufsiz, len);
+}
+
 pid_t waitpid(pid_t pid, int *status, int options)
 {
 	HANDLE h = OpenProcess(SYNCHRONIZE | PROCESS_QUERY_INFORMATION,
-- 
gitgitgadget

