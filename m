Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0F8BE4D
	for <git@vger.kernel.org>; Sat, 30 Dec 2023 16:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJEe1mFn"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40d5b89e2bfso36281025e9.0
        for <git@vger.kernel.org>; Sat, 30 Dec 2023 08:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703955248; x=1704560048; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XgHAq04W4mln8XgPkGczPR/4vNppIrR9pwxbq2Z1s5g=;
        b=fJEe1mFnm1RgqKzmFxEo64/DFdFXOVwSDnQ3QU97FTpo3ZIO9PtUYPbxLqcqQBPYeb
         1YHPSX+WISAwaIrN3bcByNiW12QAHsh5ZWA1jW0WnjzYaHoqCesg6GP3UhpZjsBGcDwc
         hKF7sQSWqlWQDWKcfiYHbEUTaC7bT/7sUh0cZ7fDYLtFmuTMHYcr4xpUFJNvzD8svQCv
         IEnCx8NWPVlXEklGapMM/wU6fKZgQYDgMb2yQC/WlcvaEhvinf3CS2tX5kdRhuhu1YPC
         NHK97U90LlISmZ5GnwTkASfEAwGchz77OWCH6Wio31FdFSuwaUa5MPfN1WRWEYXIHeY6
         NYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703955248; x=1704560048;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XgHAq04W4mln8XgPkGczPR/4vNppIrR9pwxbq2Z1s5g=;
        b=Y2Kyz4Y4CvsTBSf+wf9w4VkAkqrbo6m+6VIBPArGuc/kD6xU3PGWUvDthDNt43vHew
         T/y9ReXgg96NcWel3KuMgR/GNOlwkx+kdjBnHysEiGPPmuRfun0JBHRrFGpf/kP6Vb88
         a4EOzG9CEUETIuprFLfutG/RuOZt8lT+n/O1DNOFEVHq2PR/7JmywTaRPgF7Ahjb0B7S
         8er+AQwt4yCBZydx3CFMhBHC+WeVSi/5MDpNl0I0Cq+MIoYaVP1F2ChLNPdGUniyJqwy
         tQzgxQi3EmJjV4jdX3GMrJRDGhtKjtrPi6rB28Vg5ZwNx+fbpJpD6jjjnCOPQ+j0/P/B
         0aHA==
X-Gm-Message-State: AOJu0YxpPtA3JBkqjsGxLLrbpzgHz/f66EOV2ajtXD5kHWzvawDQ/kqk
	E/IzAHRUrv9xAbGDrIHZAHfeIpKInCU=
X-Google-Smtp-Source: AGHT+IF/kbaDDudFZJTokJCzFhrY1VEob6nPAmGlbUO4EIVj57dMWq0gxjL+MN1cepIKuFLFTW7T9w==
X-Received: by 2002:a05:600c:4511:b0:40d:6b08:e8ad with SMTP id t17-20020a05600c451100b0040d6b08e8admr1994585wmo.58.1703955247817;
        Sat, 30 Dec 2023 08:54:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c12-20020a5d4ccc000000b003371e7113d4sm4433998wrt.24.2023.12.30.08.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 08:54:07 -0800 (PST)
Message-ID: <pull.1628.git.1703955246308.gitgitgadget@gmail.com>
From: "Chandra Pratap via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 30 Dec 2023 16:54:06 +0000
Subject: [PATCH] write-or-die: make GIT_FLUSH a Boolean environment variable
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
Cc: Chandra Pratap <chandrapratap376@gmail.com>,
    Chandra Pratap <chandrapratap3519@gmail.com>

From: Chandra Pratap <chandrapratap3519@gmail.com>

Among Git's environment variable, the ones marked as "Boolean"
accept values in a way similar to Boolean configuration variables,
i.e. values like 'yes', 'on', 'true' and positive numbers are
taken as "on" and values like 'no', 'off', 'false' are taken as
"off".
GIT_FLUSH can be used to force Git to use non-buffered I/O when
writing to stdout. It can only accept two values, '1' which causes
Git to flush more often and '0' which makes all output buffered.
Make GIT_FLUSH accept more values besides '0' and '1' by turning it
into a Boolean environment variable, modifying the required logic.
Update the related documentation.

Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
    write-or-die: make GIT_FLUSH a Boolean environment variable

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1628%2FChand-ra%2Fgit_flush-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1628/Chand-ra/git_flush-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1628

 Documentation/git.txt | 16 +++++++---------
 write-or-die.c        |  9 ++++-----
 2 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 2535a30194f..83fd60f2d11 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -724,16 +724,14 @@ for further details.
 	waiting for someone with sufficient permissions to fix it.
 
 `GIT_FLUSH`::
-// NEEDSWORK: make it into a usual Boolean environment variable
-	If this environment variable is set to "1", then commands such
+	If this Boolean environment variable is set to true, then commands such
 	as 'git blame' (in incremental mode), 'git rev-list', 'git log',
-	'git check-attr' and 'git check-ignore' will
-	force a flush of the output stream after each record have been
-	flushed. If this
-	variable is set to "0", the output of these commands will be done
-	using completely buffered I/O.   If this environment variable is
-	not set, Git will choose buffered or record-oriented flushing
-	based on whether stdout appears to be redirected to a file or not.
+	'git check-attr' and 'git check-ignore' will force a flush of the output
+	stream after each record have been flushed. If this variable is set to
+	false, the output of these commands will be done using completely buffered
+	I/O. If this environment variable is not set, Git will choose buffered or
+	record-oriented flushing based on whether stdout appears to be redirected
+	to a file or not.
 
 `GIT_TRACE`::
 	Enables general trace messages, e.g. alias expansion, built-in
diff --git a/write-or-die.c b/write-or-die.c
index 42a2dc73cd3..f501a6e382a 100644
--- a/write-or-die.c
+++ b/write-or-die.c
@@ -20,14 +20,13 @@ void maybe_flush_or_die(FILE *f, const char *desc)
 {
 	static int skip_stdout_flush = -1;
 	struct stat st;
-	char *cp;
+	int cp;
 
 	if (f == stdout) {
 		if (skip_stdout_flush < 0) {
-			/* NEEDSWORK: make this a normal Boolean */
-			cp = getenv("GIT_FLUSH");
-			if (cp)
-				skip_stdout_flush = (atoi(cp) == 0);
+			cp = git_env_bool("GIT_FLUSH", -1);
+			if (cp >= 0)
+				skip_stdout_flush = (cp == 0);
 			else if ((fstat(fileno(stdout), &st) == 0) &&
 				 S_ISREG(st.st_mode))
 				skip_stdout_flush = 1;

base-commit: 1a87c842ece327d03d08096395969aca5e0a6996
-- 
gitgitgadget
