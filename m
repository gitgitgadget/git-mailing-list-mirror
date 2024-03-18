Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF8938FA8
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 12:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710766068; cv=none; b=t+nj4oeWIs5nhq6qL+Rn61yM7SZEdEZbI4yGPfxj7HabAMAsbZkZzY2vgg895qR3DyWpczFVwE3fvlQpvAQS+pYbUxVXASth7gCnkdB62vFi7c/LKBGQ+/V6H3HEOH7UBCtF6vw5LJlxEERdcbJ6zV/tjSxgGE3461Mohs6WwIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710766068; c=relaxed/simple;
	bh=2d2f8P/K6eQ5MQuXmEVY8loA+G05OMq9vQLaLXbEaPs=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KByNr2jZvNCBZI/DEzML4AkILz7cN98K2vXZFq+NwCHuYPapV6wikGr3yceFXa69XqlBbed8BwDScmXFbiuIlk2OlyXhKfbBw8zXu7T6+j2m9A0jIxmwDLFc4rZ203nNUZbnhGkGe9ukmycM1fK3cNzdMYqa/dapa7ZLuEZ/q4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IaUpyeXq; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaUpyeXq"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-412e784060cso31084295e9.1
        for <git@vger.kernel.org>; Mon, 18 Mar 2024 05:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710766064; x=1711370864; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=686slgiMFeh2Oc748QM8UuEwyINmY3mZzDpqBG7i2Os=;
        b=IaUpyeXqM7BAH2Il93t8RT41VuqATVZI9V5d4gNNO6BZ9c9gKaUSUHm/Wm8YpFgvTx
         QiQU9AydM0xzJiRVpcu/RsQTdJ8nk9hzxgCaEfOsKGhJIUprQ4OYYCroKkNF1JouL2xz
         rGOf5EHvNhqDB00ZIxsNAocSDKo6y3O2wELr5jCrNQ04HpEMd+1wOmmHY77OJi57fcsZ
         c7v18xTMMxgpwPznXsnHgyhUsb4KRbjJ7f5aCQZaUWh3JPIsWo0t+RP2ey36yKVX3NgK
         dnuf7mbO0vqLBArOAArzmXmw2XElMitnupvcAvwwKaGgHiaAhm9Z9dgnExLDsPf5NFJo
         MBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710766064; x=1711370864;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=686slgiMFeh2Oc748QM8UuEwyINmY3mZzDpqBG7i2Os=;
        b=boJfXLOF/EZwkEPWYlo33rg/KK9HJgyt7PvpgbymlIrkPv38YEzZd3ckgWmdxdMAuc
         cpXzkQ08If+jDbNhHCE8DzqvRr+0fTVOJ5xXQ0iKSDlnc3zqs+hoqDsxTyXkQQ1bBli0
         vjaef6c9KtP1Onfp3ViAL6v484WIvZdafPSv9hUKo8YljMFs9fexMVnhXClFMshRGMHq
         7jm1QYOKojmh+q917q7Nu5dLlnY5N2giwBnrjLFY5ye9T9LjfxSbrzZSLZFLcSb5aKIX
         PZRpj/u6bsyNP6BpT8728Ytnk72U6duYjMxMmWl3PAR3iSCe+EDGeowDbnF+2F23rzjm
         en3g==
X-Gm-Message-State: AOJu0YwO3M5OKPClsko7ZYQw/esSapwRTGOx82L5U0PndYf4+BOaxggl
	1pEgERwsOrojodERufN6n+rTWPyvCrUVdSB4o8A2Vl8AlTaI0fnFngv6D7xg
X-Google-Smtp-Source: AGHT+IEtnIVMrYd24II8nyfu9JsQIzuigsGxIKkawffRRYEfGUj0NcDur2EwpXZ/czvCrNqGpz+sqA==
X-Received: by 2002:a5d:4a51:0:b0:33e:c91b:9083 with SMTP id v17-20020a5d4a51000000b0033ec91b9083mr10031990wrs.16.1710766063805;
        Mon, 18 Mar 2024 05:47:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a26-20020a5d457a000000b0033e7e9c8657sm9744639wrc.45.2024.03.18.05.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 05:47:43 -0700 (PDT)
Message-ID: <0157b1deaebd5de4734d35f96f22a8da752e09bd.1710766062.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1699.git.1710766062.gitgitgadget@gmail.com>
References: <pull.1699.git.1710766062.gitgitgadget@gmail.com>
From: "Mohit Marathe via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 18 Mar 2024 12:47:41 +0000
Subject: [PATCH 1/2] git-compat-util: migrate `convert_slashes()` from
 compat/mingw.h
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
Cc: Mohit Marathe <mohitmarathe@proton.me>,
    Mohit Marathe <mohitmarathe@proton.me>

From: Mohit Marathe <mohitmarathe@proton.me>

This patch migrates the `convert_slashes` function to `git-compat-
util.h` and renames it to `change_path_separators`.

Signed-off-by: Mohit Marathe <mohitmarathe@proton.me>
---
 abspath.c         | 4 ++--
 compat/mingw.c    | 4 ++--
 compat/mingw.h    | 6 ------
 git-compat-util.h | 7 +++++++
 path.c            | 2 +-
 5 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/abspath.c b/abspath.c
index 1202cde23db..ea35e2c05ce 100644
--- a/abspath.c
+++ b/abspath.c
@@ -58,7 +58,7 @@ static void get_root_part(struct strbuf *resolved, struct strbuf *remaining)
 	strbuf_reset(resolved);
 	strbuf_add(resolved, remaining->buf, offset);
 #ifdef GIT_WINDOWS_NATIVE
-	convert_slashes(resolved->buf);
+	change_path_separators(resolved->buf);
 #endif
 	strbuf_remove(remaining, 0, offset);
 }
@@ -278,7 +278,7 @@ char *prefix_filename(const char *pfx, const char *arg)
 
 	strbuf_addstr(&path, arg);
 #ifdef GIT_WINDOWS_NATIVE
-	convert_slashes(path.buf + pfx_len);
+	change_path_separators(path.buf + pfx_len);
 #endif
 	return strbuf_detach(&path, NULL);
 }
diff --git a/compat/mingw.c b/compat/mingw.c
index 320fb99a90e..f7c1a009563 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1170,7 +1170,7 @@ char *mingw_getcwd(char *pointer, int len)
 	}
 	if (xwcstoutf(pointer, wpointer, len) < 0)
 		return NULL;
-	convert_slashes(pointer);
+	change_path_separators(pointer);
 	return pointer;
 }
 
@@ -2636,7 +2636,7 @@ static void setup_windows_environment(void)
 		 * executable (by not mistaking the dir separators
 		 * for escape characters).
 		 */
-		convert_slashes(tmp);
+		change_path_separators(tmp);
 	}
 
 	/* simulate TERM to enable auto-color (see color.c) */
diff --git a/compat/mingw.h b/compat/mingw.h
index 6aec50e4124..f5ca4adc194 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -448,12 +448,6 @@ HANDLE winansi_get_osfhandle(int fd);
  * git specific compatibility
  */
 
-static inline void convert_slashes(char *path)
-{
-	for (; *path; path++)
-		if (*path == '\\')
-			*path = '/';
-}
 #define PATH_SEP ';'
 char *mingw_query_user_email(void);
 #define query_user_email mingw_query_user_email
diff --git a/git-compat-util.h b/git-compat-util.h
index 7c2a6538e5a..3db90c09295 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1309,6 +1309,13 @@ static inline int strtol_i(char const *s, int base, int *result)
 	return 0;
 }
 
+static inline void change_path_separators(char *path)
+{
+	for (; *path; path++)
+		if (*path == '\\')
+			*path = '/';
+}
+
 void git_stable_qsort(void *base, size_t nmemb, size_t size,
 		      int(*compar)(const void *, const void *));
 #ifdef INTERNAL_QSORT
diff --git a/path.c b/path.c
index 8bb223c92c9..cd7c88ffa0d 100644
--- a/path.c
+++ b/path.c
@@ -758,7 +758,7 @@ char *interpolate_path(const char *path, int real_home)
 			else
 				strbuf_addstr(&user_path, home);
 #ifdef GIT_WINDOWS_NATIVE
-			convert_slashes(user_path.buf);
+			change_path_separators(user_path.buf);
 #endif
 		} else {
 			struct passwd *pw = getpw_str(username, username_len);
-- 
gitgitgadget

