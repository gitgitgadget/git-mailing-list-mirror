Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F2339B6AB
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 14:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765980559; cv=none; b=Zrhu5TbnGzY7FQYmSDbybK8EUeFVLSvyslVQaduO/Mh0f+ozIYVBzw/6jLhAnxD8FNKVowe+4qbkCRradpMlqspaE0eyDyWaGRlberJpM5paiLGwhBD4qWubgLqPRE9iPDQIN+2Q0NM5A9/TjP7hdTn770DAVa5Bhz1FCKZQWhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765980559; c=relaxed/simple;
	bh=wFSR6Rk71gAtyojD8RqwF/PD84ovfF/ZjNsswVjP9qw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=iDeZ79DbR4hhx4BJE6Fvj3Q3FwYO81vcN8+PqRaJa8PcOrz0vB+irohj0csAHCVRVOqqc8QCma8OcVqbgpJ2p6jNTw/ktTA+YvqATTWrFZ0qcPXw328LEv6hZqadAIgzoSlJJF+BXsPyLt6aumJA+htaGJz0XjS5DPv5IKjlaag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLMzLlNY; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLMzLlNY"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-56021f047d6so668069e0c.0
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 06:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765980556; x=1766585356; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKGA29E6LtFw+asXRELFXA2cgcqmWvZxt//K4Wuj6e4=;
        b=GLMzLlNYZEF2NI5e6EmoH/Y3tJBQ+Elyb8xpj1iMf5lUufCVBDgfzyMLHyTlH8vhgi
         1ME0rIPS/EvVreFjRZjskB6kTsP4XbqdjMFszRfGligjyCJ5ecypcP4MR1190AgZ6fU1
         YCLDzVnQ4lV/iD7ZWcvSmE/zscnOdAsBhTA5JgY2qvkAL6tp3HEUFBRl8hbjNXEL0IP1
         nWWePeW9fjrpn4bSN8BsoQ6vzNvMit3/uW48GKGBzdijTtmgGRy8jFDygDKomi1jXMnx
         04mtaP/8wCQ2q5mar2+gblHl+OMq7B2lb9hG9jn7Gy3yTionulwQFiMYuVSlLkhSyxUQ
         EIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765980556; x=1766585356;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RKGA29E6LtFw+asXRELFXA2cgcqmWvZxt//K4Wuj6e4=;
        b=vDL8OlLAczBuD6/989o64hrmuA4aQfpgvOGTZ+RU02aSL9ZgpH1yLwtO0CiE/877Je
         BGj1uOk6hsRC0O14b0vzcs9O/4MACRQFVfZiBeqQxoGml8T0o0LlFlGsnXzbPXIo8bgA
         GnD6d/T84w1IQErp+pVd9tJCv71aUaOGs4OiRPI7r6dWPnQzbgodb20A4KLgzMC+PufD
         AopcVQ3nMGhwNaVojOrjef3lPrg7Ai+DBYxRIlPHIIlAPvAc/7xzV76VegdOt4YhJtnv
         p+P9nwsUFWC1OTil9hR6sUOKQACQKWMesWG1LE8p6tzFVlY0Z4m+P1SzE+grTu4OqnTo
         LVDQ==
X-Gm-Message-State: AOJu0Yw6t6t+nDBgcS+UCWZBPKhNT8zJPiQNbOwV91OnDhYSFR3IfjzU
	D/9AjLKjXug8/DZeFNinDA8tDwYmulNOhdlxIydIV0LsswxmWxrTjEl4rd6kPzNn
X-Gm-Gg: AY/fxX5XdGWl+eCax8rOJN8xvWUF2/xB2+LyMkfCVuZQDN4WQ1VqFUugFaw6HMtvibw
	NtVg7z+JLKySUIIkYkMBytGy8PSWpKSBMF6ZhCEF3rPock9KthaSkgODiJj5kSacSEKdn5FlZ74
	hxoe3BnT/v20+yiya0RnJ+Y1NFaQA0tzJPDWY4lIyJJ09tReKSjwgxdy975kv805D7styLGdnyZ
	hDpe3dY/enHR71Gc3Ee5BJ7QcSuR/+uoMDhG2a4H0/lbGeJT1Ev+iZePU7jyC9x30wwFVIuVfpU
	AccMdppsl0CSLYQlYjHxdGHjggVtw1iLzXHUK8G27NTdsOPriYyg/mfD8hMgRCTFMEspt8ElF2Y
	ZMyqlUTxoUcxqsuwLUEFI4zRU3DPGr2OAvFRZuV54jBre1kMwiA8LIBfiRGblatNr9PLpE6AWqG
	oh8ALpzDt7O5A=
X-Google-Smtp-Source: AGHT+IHAMxnVitVqWYHNU9RziiSQ256Q1RfdC/3XeozyKRp+/ZfygVhfKa8H8n0MHNCGqv70E2FrLw==
X-Received: by 2002:a05:6122:2a13:b0:55b:113f:7e08 with SMTP id 71dfb90a1353d-55fed56db2fmr4674191e0c.2.1765980556082;
        Wed, 17 Dec 2025 06:09:16 -0800 (PST)
Received: from [127.0.0.1] ([48.214.53.69])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88993b4203fsm99448496d6.1.2025.12.17.06.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 06:09:15 -0800 (PST)
Message-Id: <1dd5f9d6cdad0f9a1fb8139274c99df008dd03ad.1765980535.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
References: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
From: "Karsten Blees via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Dec 2025 14:08:51 +0000
Subject: [PATCH 14/18] mingw: implement basic `symlink()` functionality (file
 symlinks only)
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

Implement `symlink()`. This implementation always creates _file_
symlinks (remember: Windows discerns between symlinks pointing to
directories and those pointing to files). Support for directory symlinks
will be added in a subseqeuent commit.

This implementation fails with `ENOSYS` if symlinks are disabled or
unsupported.

Signed-off-by: Karsten Blees <blees@dcon.de>
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

