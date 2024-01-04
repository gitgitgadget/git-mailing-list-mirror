Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD4A20B10
	for <git@vger.kernel.org>; Thu,  4 Jan 2024 10:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIAUq1oO"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-32f8441dfb5so294810f8f.0
        for <git@vger.kernel.org>; Thu, 04 Jan 2024 02:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704363619; x=1704968419; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HSTxad5QRP1qk185vWoQX5rK7rnqi/MiY0IYzJxWWO0=;
        b=DIAUq1oO6IrNBSAL4DT+YWxPZPXxBPGhvLvBnZHG1cfgkBnrzhT3nLOv9v7A7NyEbz
         llAEvbpyfyk5a9uoZ7meOZ0japEMJAKNwMLqa0hN5gf7Vee5fadS5lKL7iz0ggGB6Uwo
         zxZaelF2Y04ch1nFkQD4aZdmLwOyeDoL07yvyA0b0/bNmey+rXelo4tD6FCdpzZz/IOR
         O170JJ2YADuU8qs4fgFyO3DWfykDSacLQejQ8gzuY6m9+byca3fy0IYWfF4z6mCj7dwZ
         GtsGA7N5YBMtK4BSbgHrUgVcYy6Vc6aukVjkip0yuchXue8BrFxd4bDGbcCbAisWT6vu
         a8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704363619; x=1704968419;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HSTxad5QRP1qk185vWoQX5rK7rnqi/MiY0IYzJxWWO0=;
        b=rZVBP3/RImIwWyyErRBMxIvSHWCEoSH69Qo2YmLK2balaJp+g5UyLd4dmkzW0IbR47
         EaDMyjeHNs/G5Tr6A0SQ5WAGQ0bl7um4ul8FR1ZU9w4BTdh9PDAIohF1BwhulKI64G3s
         S9gaTeX0IX++RBRibC67nO/CbBUGUvpeogvHidcRJBuIL0UtleWJpC4ThPATlKcMh728
         TDdzb5Ofey7KyZFF9HGdSGhTpL9v8fgMMZf+vUWBuA3D1DjYpoNtdy3R/AwvVTO2ZwAU
         8SbGjFjomAl73FznibAXHqV3vcR9sRgAyfzrGbzoPOI75GsDWuEvsrOCJCJFV3/9FN0b
         DjKQ==
X-Gm-Message-State: AOJu0Yz7nK+BpWXDcUqjgEhBnxNlEJdg3mslL1V5P3JB0atzbmdMuzLP
	wpw0JpRJ44f0mVDZ9p1yZh5YBICzBTE=
X-Google-Smtp-Source: AGHT+IFkRKDCbS3fxhZFj5JS0EwjEr8S4XKCwb3/ftF6nTB8RicrL65ckg17f47nDREPtP3vzUHVdw==
X-Received: by 2002:a5d:4d90:0:b0:334:b3d0:c300 with SMTP id b16-20020a5d4d90000000b00334b3d0c300mr257758wru.32.1704363619182;
        Thu, 04 Jan 2024 02:20:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l4-20020a5d4804000000b003365f5e87f4sm32473102wrq.95.2024.01.04.02.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 02:20:18 -0800 (PST)
Message-ID: <pull.1628.v3.git.1704363617842.gitgitgadget@gmail.com>
In-Reply-To: <pull.1628.v2.git.1704268708720.gitgitgadget@gmail.com>
References: <pull.1628.v2.git.1704268708720.gitgitgadget@gmail.com>
From: "Chandra Pratap via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 04 Jan 2024 10:20:17 +0000
Subject: [PATCH v3] write-or-die: make GIT_FLUSH a Boolean environment
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1628%2FChand-ra%2Fgit_flush-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1628/Chand-ra/git_flush-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1628

Range-diff vs v2:

 1:  585c76fff68 ! 1:  c98885c0ede write-or-die: make GIT_FLUSH a Boolean environment variable
     @@ Documentation/git.txt: for further details.
      -	If this environment variable is set to "1", then commands such
      +	If this Boolean environment variable is set to true, then commands such
       	as 'git blame' (in incremental mode), 'git rev-list', 'git log',
     --	'git check-attr' and 'git check-ignore' will
     --	force a flush of the output stream after each record have been
     --	flushed. If this
     + 	'git check-attr' and 'git check-ignore' will
     + 	force a flush of the output stream after each record have been
     + 	flushed. If this
      -	variable is set to "0", the output of these commands will be done
     --	using completely buffered I/O.   If this environment variable is
     --	not set, Git will choose buffered or record-oriented flushing
     --	based on whether stdout appears to be redirected to a file or not.
     -+	'git check-attr' and 'git check-ignore' will force a flush of the output
     -+	stream after each record have been flushed. If this variable is set to
     -+	false, the output of these commands will be done using completely buffered
     -+	I/O. If this environment variable is not set, Git will choose buffered or
     -+	record-oriented flushing based on whether stdout appears to be redirected
     -+	to a file or not.
     - 
     - `GIT_TRACE`::
     - 	Enables general trace messages, e.g. alias expansion, built-in
     ++	variable is set to false, the output of these commands will be done
     + 	using completely buffered I/O.   If this environment variable is
     + 	not set, Git will choose buffered or record-oriented flushing
     + 	based on whether stdout appears to be redirected to a file or not.
      
       ## write-or-die.c ##
     -@@ write-or-die.c: void maybe_flush_or_die(FILE *f, const char *desc)
     +@@
     + void maybe_flush_or_die(FILE *f, const char *desc)
       {
       	static int skip_stdout_flush = -1;
     - 	struct stat st;
     +-	struct stat st;
      -	char *cp;
       
       	if (f == stdout) {
     @@ write-or-die.c: void maybe_flush_or_die(FILE *f, const char *desc)
      -			if (cp)
      -				skip_stdout_flush = (atoi(cp) == 0);
      -			else if ((fstat(fileno(stdout), &st) == 0) &&
     -+			if (!git_env_bool("GIT_FLUSH", -1))
     -+				skip_stdout_flush = 1;
     -+			else if (!fstat(fileno(stdout), &st) &&
     - 				 S_ISREG(st.st_mode))
     - 				skip_stdout_flush = 1;
     - 			else
     +-				 S_ISREG(st.st_mode))
     +-				skip_stdout_flush = 1;
     +-			else
     +-				skip_stdout_flush = 0;
     ++			skip_stdout_flush = git_env_bool("GIT_FLUSH", -1);
     ++			if (skip_stdout_flush < 0) {
     ++				struct stat st;
     ++				if (fstat(fileno(stdout), &st))
     ++					skip_stdout_flush = 0;
     ++				else
     ++					skip_stdout_flush = S_ISREG(st.st_mode);
     ++			}
     + 		}
     + 		if (skip_stdout_flush && !ferror(f))
     + 			return;


 Documentation/git.txt |  5 ++---
 write-or-die.c        | 19 ++++++++-----------
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 2535a30194f..d06eea024f7 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -724,13 +724,12 @@ for further details.
 	waiting for someone with sufficient permissions to fix it.
 
 `GIT_FLUSH`::
-// NEEDSWORK: make it into a usual Boolean environment variable
-	If this environment variable is set to "1", then commands such
+	If this Boolean environment variable is set to true, then commands such
 	as 'git blame' (in incremental mode), 'git rev-list', 'git log',
 	'git check-attr' and 'git check-ignore' will
 	force a flush of the output stream after each record have been
 	flushed. If this
-	variable is set to "0", the output of these commands will be done
+	variable is set to false, the output of these commands will be done
 	using completely buffered I/O.   If this environment variable is
 	not set, Git will choose buffered or record-oriented flushing
 	based on whether stdout appears to be redirected to a file or not.
diff --git a/write-or-die.c b/write-or-die.c
index 42a2dc73cd3..39421528653 100644
--- a/write-or-die.c
+++ b/write-or-die.c
@@ -19,20 +19,17 @@
 void maybe_flush_or_die(FILE *f, const char *desc)
 {
 	static int skip_stdout_flush = -1;
-	struct stat st;
-	char *cp;
 
 	if (f == stdout) {
 		if (skip_stdout_flush < 0) {
-			/* NEEDSWORK: make this a normal Boolean */
-			cp = getenv("GIT_FLUSH");
-			if (cp)
-				skip_stdout_flush = (atoi(cp) == 0);
-			else if ((fstat(fileno(stdout), &st) == 0) &&
-				 S_ISREG(st.st_mode))
-				skip_stdout_flush = 1;
-			else
-				skip_stdout_flush = 0;
+			skip_stdout_flush = git_env_bool("GIT_FLUSH", -1);
+			if (skip_stdout_flush < 0) {
+				struct stat st;
+				if (fstat(fileno(stdout), &st))
+					skip_stdout_flush = 0;
+				else
+					skip_stdout_flush = S_ISREG(st.st_mode);
+			}
 		}
 		if (skip_stdout_flush && !ferror(f))
 			return;

base-commit: 1a87c842ece327d03d08096395969aca5e0a6996
-- 
gitgitgadget
