Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73401803D
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 07:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpgjMNkF"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3368ae75082so88617f8f.1
        for <git@vger.kernel.org>; Tue, 02 Jan 2024 23:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704268710; x=1704873510; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3JezaSvcu6Yg9qoAcLm0p4E7VsXPWjb72K3n0wrsIw=;
        b=fpgjMNkFPnxZ6J4WGUny3cj0ptwRY1gkfQIPzWGYyhHqT3XTu85DpLx0c8LCkq3Fx+
         9ltY4uPnjesq1Ea7gcxsofhe2R5AMXEUIeGfbPATck9lWQI8ke+PdggopqrOad0gA8Bb
         PIV8MRwNxRbCQ50H51x9jik2xv61NjKqb9v6pS0KQ12kZS0fljt9bSqIcVO3j/jvCcE+
         jlkFMpUfmW0iDq6f4Qm+WUm2TDR7ALinbXmNhhIB6C0XlOL1xnCk0fIRcRKBHH1yjOvA
         j8Hlnzv2j8FV3BCpwyGC26CYp9w/TT2BWKTy5POCdfeMOROnimlM48CAjyaBNHz89UqN
         mqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704268710; x=1704873510;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U3JezaSvcu6Yg9qoAcLm0p4E7VsXPWjb72K3n0wrsIw=;
        b=vKtPyIiQxDXLIr693Jb2ASVVmsDiy8kJFvyzNq92EBht2To3iF+hVQcEJZJVnkfTW+
         +9igFfVfc88nxv6c7gYzgwq8x8FPy/0NxloVnDOKZcpqOcS7NDpiNtx66eiZjMd3J0ps
         tJhmNQHTPZ3SLJnTxGp4ur3YesclfDFm6T1Y4Ww41iVJ/BrsVcjgIz4OOaEFr0AeFZoW
         zfMaRLdMAd/UowdckKrd4JXoyelN3cxeH4kmrM3uaBAKvaTedyOjmRv07+7u+sLkh6y/
         7L8bAtTw9qS81S/sSZQzHZpIv5EJkqR43pGdvlP7sOOaaIovoFMRecLXG0/DZHX98IPq
         DewQ==
X-Gm-Message-State: AOJu0Yxy5tmjFGqJwUewGa4uNBgNkmoUtB6QWaq4pZ6SxnCUhWrAFM7F
	9rHVf/bgrRuvVnXzI4KjGAEntcNBhrw=
X-Google-Smtp-Source: AGHT+IG8yzA9BnyKXPIzLM8/N+7V4hAH2aVds6zMMqALFVC4p7yB8FjLKwPdH93D2BGXsCMFYkp0eA==
X-Received: by 2002:a05:600c:3b29:b0:40d:87a0:676 with SMTP id m41-20020a05600c3b2900b0040d87a00676mr275092wms.78.1704268709563;
        Tue, 02 Jan 2024 23:58:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c024800b0040d87100733sm1467258wmj.39.2024.01.02.23.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 23:58:29 -0800 (PST)
Message-ID: <pull.1628.v2.git.1704268708720.gitgitgadget@gmail.com>
In-Reply-To: <pull.1628.git.1703955246308.gitgitgadget@gmail.com>
References: <pull.1628.git.1703955246308.gitgitgadget@gmail.com>
From: "Chandra Pratap via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 03 Jan 2024 07:58:28 +0000
Subject: [PATCH v2] write-or-die: make GIT_FLUSH a Boolean environment
 variable
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
    
    Helped-by: Torsten Bögershausen <tboegi@web.de>

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1628%2FChand-ra%2Fgit_flush-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1628/Chand-ra/git_flush-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1628

Range-diff vs v1:

 1:  2123b43a080 ! 1:  585c76fff68 write-or-die: make GIT_FLUSH a Boolean environment variable
     @@ write-or-die.c: void maybe_flush_or_die(FILE *f, const char *desc)
       	static int skip_stdout_flush = -1;
       	struct stat st;
      -	char *cp;
     -+	int cp;
       
       	if (f == stdout) {
       		if (skip_stdout_flush < 0) {
     @@ write-or-die.c: void maybe_flush_or_die(FILE *f, const char *desc)
      -			cp = getenv("GIT_FLUSH");
      -			if (cp)
      -				skip_stdout_flush = (atoi(cp) == 0);
     -+			cp = git_env_bool("GIT_FLUSH", -1);
     -+			if (cp >= 0)
     -+				skip_stdout_flush = (cp == 0);
     - 			else if ((fstat(fileno(stdout), &st) == 0) &&
     +-			else if ((fstat(fileno(stdout), &st) == 0) &&
     ++			if (!git_env_bool("GIT_FLUSH", -1))
     ++				skip_stdout_flush = 1;
     ++			else if (!fstat(fileno(stdout), &st) &&
       				 S_ISREG(st.st_mode))
       				skip_stdout_flush = 1;
     + 			else


 Documentation/git.txt | 16 +++++++---------
 write-or-die.c        |  9 +++------
 2 files changed, 10 insertions(+), 15 deletions(-)

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
index 42a2dc73cd3..a6acabd329f 100644
--- a/write-or-die.c
+++ b/write-or-die.c
@@ -20,15 +20,12 @@ void maybe_flush_or_die(FILE *f, const char *desc)
 {
 	static int skip_stdout_flush = -1;
 	struct stat st;
-	char *cp;
 
 	if (f == stdout) {
 		if (skip_stdout_flush < 0) {
-			/* NEEDSWORK: make this a normal Boolean */
-			cp = getenv("GIT_FLUSH");
-			if (cp)
-				skip_stdout_flush = (atoi(cp) == 0);
-			else if ((fstat(fileno(stdout), &st) == 0) &&
+			if (!git_env_bool("GIT_FLUSH", -1))
+				skip_stdout_flush = 1;
+			else if (!fstat(fileno(stdout), &st) &&
 				 S_ISREG(st.st_mode))
 				skip_stdout_flush = 1;
 			else

base-commit: 1a87c842ece327d03d08096395969aca5e0a6996
-- 
gitgitgadget
