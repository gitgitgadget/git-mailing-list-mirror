Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B622E85E
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 13:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720443783; cv=none; b=at4s5uABHdudZJ4MOvi+edNYLM/gpL8OP0oCLss//2klifMzFKtUjgX1nv+nTT+YxNMkNEvAgZhXT1/RIs5mXz9o8eFC+SpacN+/EQROsWV4HJUkpwVvrGLtnn3t2JuiHLFHzlBlfNzCNV/rLU+XZanp1JXNgh7UgH2FF+7r4UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720443783; c=relaxed/simple;
	bh=cPNCjO7b6MoK+L/v/QpRsQqQp3rI+9X4jj4Da4XUcGc=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=OM8SrWMbhkT1JKznCtrRJnjeJMgNP21+ZXnAtSA76uZwLwViqgBdpKgJlPR7596MUyqOHGWY33QX7gpyhw4gOE/m5mn1XOjUbeShOHK3XTlzv5ZHUBGzny4aOBrn8pHTinp9Uuzp/a847HMeYAC2VOQPR3pOn2CZ0a04Y6Rs+qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxIg1xOD; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxIg1xOD"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-367aa05bf9dso1504960f8f.3
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 06:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720443779; x=1721048579; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zx1z9qVEcSbziVotDCs0cK1P24nCEaLdnVaOWcSDhAg=;
        b=HxIg1xOD41fmH3llSuZ6SDxHREkjFuSYP46MQfqEOjXpPxUZ1BZHCH1+jNRb/4Q+fp
         OPit4VsoBLHwVLiAMETSfkn0Uvs0hhbJFMeNTbmxOcwF9l8CF3IKXyTYG9DR4xESH002
         iqYNHNL/OtMwNQeyVQMqFnLALDW8vc0eNRn3/Ote/wkzFpgJj+u4jbFwDKuGGoOjci6d
         29LsQqOcFB1eog0C1qIA7or3qIMkGfA5/8cbPdiLq5NBwH1RBbPbqJZxER9poZ1gVJ91
         ssAqvDSQ008PDOHMkAtfYg1NIfYQBHcAKJXy21MMDDe+/yadfa3xEfJ2lN/IcfsJXdcO
         UqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720443779; x=1721048579;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zx1z9qVEcSbziVotDCs0cK1P24nCEaLdnVaOWcSDhAg=;
        b=SUQmalQ8bA2Iz/Svs2ZGgvp6ORhsYSwWunO8mpNvOb0DliZ2rluwaMxubCB8CAbSPx
         B/U3k2dSzTM3aCnZr5du6jdYJxczqTKLyO0v4d4IbARBNYGmfiDOSg5cUZrREiSM1nLZ
         T/2Zky7SoOspIAxonU/PBNdwRyEnBnCJO0ZUfreXEaEttz75OMF59nUQQ8hXB10ZV4pq
         AIwolzFPlQg3hvxL4gdcoXtK4wnfjnTUNBhIxzDRCt52kum0uGDMu3OPf6iwc3RqdobF
         9T/XsED+Psj67p0XKSHTowUUXB/SvEm41s5EZJcmd5Nz92DjmQrSZ26jgLX1fJ88PcDX
         82VQ==
X-Gm-Message-State: AOJu0YzcP2+GDSaqp/J3yiSxvgH2unvdsLCxb0UZY8c3j8ZJ8ij01jvf
	TMngftyT+4AsP+Ra4z8jL1F7bh0lERg9KbOO0MXSbEoq15a36saWsB/zwg==
X-Google-Smtp-Source: AGHT+IFwtJVibpdi9dnziUTglOgvCo+Jh4u077n+sayfNTjc7UnocuIVp0ZGi0XjK7H3OIzzPHxByw==
X-Received: by 2002:a5d:6a51:0:b0:367:898b:fc33 with SMTP id ffacd0b85a97d-3679de961fbmr8173603f8f.59.1720443779245;
        Mon, 08 Jul 2024 06:02:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3679c993858sm10983943f8f.108.2024.07.08.06.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 06:02:58 -0700 (PDT)
Message-Id: <pull.1760.git.1720443778074.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 08 Jul 2024 13:02:57 +0000
Subject: [PATCH] var(win32): do report the GIT_SHELL_PATH that is actually
 used
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

On Windows, Unix-like paths like `/bin/sh` make very little sense. In
the best case, they simply don't work, in the worst case they are
misinterpreted as absolute paths that are relative to the drive
associated with the current directory.

To that end, Git does not actually use the path `/bin/sh` that is
recorded e.g. in Unix shell scripts' hash-bang lines. Instead, as of
776297548e (Do not use SHELL_PATH from build system in prepare_shell_cmd
on Windows, 2012-04-17), it re-interprets `/bin/sh` as "look up `sh` on
the `PATH` and use the result instead".

However, when 1e65721227 (var: add support for listing the shell,
2023-06-27) introduced support for `git var GIT_SHELL_PATH`, Windows was
not special-cased as above, which is why it outputs `/bin/sh` even
though that disagrees with what Git actually uses.

Let's fix this, and also adjust the corresponding test case to verify
that it actually finds a working executable.

Reported-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    var(win32): do report the GIT_SHELL_PATH that is actually used

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1760%2Fdscho%2Fgit-var-on-windows-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1760/dscho/git-var-on-windows-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1760

 builtin/var.c      | 6 ++++++
 t/t0007-git-var.sh | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/builtin/var.c b/builtin/var.c
index 5dc384810c0..f4b1f34e403 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -51,7 +51,13 @@ static char *default_branch(int ident_flag UNUSED)
 
 static char *shell_path(int ident_flag UNUSED)
 {
+#ifdef WIN32
+	char *p = locate_in_PATH("sh");
+	convert_slashes(p);
+	return p;
+#else
 	return xstrdup(SHELL_PATH);
+#endif
 }
 
 static char *git_attr_val_system(int ident_flag UNUSED)
diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
index ff4fd9348cc..9fc58823873 100755
--- a/t/t0007-git-var.sh
+++ b/t/t0007-git-var.sh
@@ -157,7 +157,7 @@ test_expect_success POSIXPERM 'GIT_SHELL_PATH points to a valid executable' '
 test_expect_success MINGW 'GIT_SHELL_PATH points to a suitable shell' '
 	shellpath=$(git var GIT_SHELL_PATH) &&
 	case "$shellpath" in
-	*sh) ;;
+	[A-Z]:/*/sh.exe) test -f "$shellpath";;
 	*) return 1;;
 	esac
 '

base-commit: 06e570c0dfb2a2deb64d217db78e2ec21672f558
-- 
gitgitgadget
