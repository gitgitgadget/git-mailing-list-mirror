Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0D21A2566
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 23:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720739510; cv=none; b=P6gmXSbikO9zp7C6y2DItWwcuRfJBsyHDeFK9+tMRiwKhdgoK45yYJ295eWMwxM9HoF6+WTSheqJp4+a5oYQaR7EnTpU9FxkNCsGZOG4zuXLqRfQ1tsGqKAUVAs/Fu2JJRpIa2G6EwXK1Use2zb1cvxR/SsHXJ8rHiBVqCSrN2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720739510; c=relaxed/simple;
	bh=vPT+TOEiMe/bjQeQ0jCb6acz4GYnr54LsJHfh1fhtc4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DeDIQkC3k84dD0BNH35LcLhNwwX3bp+a3UN8kwBjB3Pfk6M68PK3MEau42cueHpYN8NtXeT/EPerLcWiQK3Gt26X0SHUrguYGvUqqnrWWqCx822SZ3s+7p4JmqYuz+mI2aqhAeANhWBkN0REIkp7/ofxwFIuhqnoUKBggAN0ID4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htCMcIgy; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htCMcIgy"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2eeb2d60efbso16685301fa.1
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 16:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720739506; x=1721344306; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkJwz/YY+MwgxQ1TrFALyw+kqQQqMj4QPMpSB0JQrS4=;
        b=htCMcIgyzMcCaaoPp751YJy0c+R/eAxRf8anx59drTVLLj9Mn4A+b9Re1mTEeZbvsA
         /SVD0KfH+KqxUZilSrN+8m5nv0GVC5+laG/lvG84aq15nFzKnGroMEzSSAdoV3UAoExs
         WqL9AkN5vQvB5ir8tQV932qKxPLY61722eoG+iNCb0bNTob5wDrHKqzvkqhhU8msKybx
         atmFlwL6nVOg0bs5iKgpyEEedGj6FFRFfTBsPCuqM0N/smxODrWK7MjOQ5wlmymPyYTq
         ScXBt2veyV+hpBIqlVV0i+CE/4IynMjk9aRv76OILQJ+2VeflN0HMHytrH673gThzGa2
         zIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720739506; x=1721344306;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dkJwz/YY+MwgxQ1TrFALyw+kqQQqMj4QPMpSB0JQrS4=;
        b=oxIQVbb7EXnxE02H1w0AUSbtQyD82H1tixA23o1CZExipXHbarirsMFCyheSK5ZxWw
         qkKz1pRWNc8C+uCgeOUKsTSpTpwGhCwjkxYtC95Se6wr6i23c2bJwI3dM7gTbiSWFwnW
         f+jjLRGvSY8DNxk/rSwJYAgeTywfpY3hjX3fe0iV3EPm04Z9mAY+zrcBLnncZAXrz4V2
         tLWoQHbFAs+tadm09lu8wSegG/MV9WE3qVyHkKvNup8oEe4IkAfC9oQorM1fNRvv7Xcp
         /oJxmJA6bnjb5TB7q8+36MfIZwE2TMfLfNALA06XD18OB7QhFQ+rYsfbrAabht8Ytoy6
         Mz5w==
X-Gm-Message-State: AOJu0YzpVo04GRaRQDARWyGS1TMtyS33qM2wvoS9rhnIZEP9yOUyfKrn
	hw67VXKSTSljNoOGvomIbpdYCdVT6VKa7cXY6+IQCLt6q4qZDwUk+5ZSsA==
X-Google-Smtp-Source: AGHT+IHhsDr7b4tFQfsLaawas4lUPGVQNzlpZkvgkc/R1clmfoMdSH5yzNPuZCeD7oIoqLRQ78rUAQ==
X-Received: by 2002:a2e:9bd5:0:b0:2ec:56ce:d50e with SMTP id 38308e7fff4ca-2eeb30bc5f4mr63264371fa.3.1720739505524;
        Thu, 11 Jul 2024 16:11:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde84798sm8790470f8f.38.2024.07.11.16.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 16:11:44 -0700 (PDT)
Message-Id: <8bfd23cfa00c351ffdcc25bd29f3b84089544a56.1720739496.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1760.v2.git.1720739496.gitgitgadget@gmail.com>
References: <pull.1760.git.1720443778074.gitgitgadget@gmail.com>
	<pull.1760.v2.git.1720739496.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 11 Jul 2024 23:11:36 +0000
Subject: [PATCH v2 7/7] var(win32): do report the GIT_SHELL_PATH that is
 actually used
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
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

On Windows, Unix-like paths like `/bin/sh` make very little sense. In
the best case, they simply don't work, in the worst case they are
misinterpreted as absolute paths that are relative to the drive
associated with the current directory.

To that end, Git does not actually use the path `/bin/sh` that is
recorded e.g. when `run_command()` is called with a Unix shell
command-line. Instead, as of 776297548e (Do not use SHELL_PATH from
build system in prepare_shell_cmd on Windows, 2012-04-17), it
re-interprets `/bin/sh` as "look up `sh` on the `PATH` and use the
result instead".

This is the logic users expect to be followed when running `git var
GIT_SHELL_PATH`.

However, when 1e65721227 (var: add support for listing the shell,
2023-06-27) introduced support for `git var GIT_SHELL_PATH`, Windows was
not special-cased as above, which is why it outputs `/bin/sh` even
though that disagrees with what Git actually uses.

Let's fix this by using the exact same logic as `prepare_shell_cmd()`,
adjusting the Windows-specific `git var GIT_SHELL_PATH` test case to
verify that it actually finds a working executable.

Reported-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/var.c      | 3 ++-
 t/t0007-git-var.sh | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/var.c b/builtin/var.c
index 5dc384810c0..e30ff45be1c 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -12,6 +12,7 @@
 #include "refs.h"
 #include "path.h"
 #include "strbuf.h"
+#include "run-command.h"
 
 static const char var_usage[] = "git var (-l | <variable>)";
 
@@ -51,7 +52,7 @@ static char *default_branch(int ident_flag UNUSED)
 
 static char *shell_path(int ident_flag UNUSED)
 {
-	return xstrdup(SHELL_PATH);
+	return git_shell_path();
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
-- 
gitgitgadget
