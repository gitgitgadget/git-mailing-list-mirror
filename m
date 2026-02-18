Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042EC2FE042
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 12:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771418816; cv=none; b=nWaLErGYYaGg+YymVPEKO0H2Su9tz7dgcufS+qkTY6FWNmYP642DVwBHsX5PXAyVoHt4M5/kBuEzcd+jumksZY3vv7SKTBYdd6oOVK/v7juMYVP45xEu3ssvodz0ZnLugkrMB5lXbEG19xo1q/DqzYnRlF7MdrsxpgNSGfd7PUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771418816; c=relaxed/simple;
	bh=37XP7m6UqAx29VGpdWiryh/xJhLacaHGEbbwM88uvng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZEur1cEJ7RstnzVboOCuF1nIVHU9a44Y81h+2o4848ZmNv4urQW8GAz10KdSkNr/2jH0+vJ4+ohGrI4jt8DjPDMu0pZneaM0Npv7AUY8y36awnaZf+as4OmynNbcm1aWnffDJ2fdP93t1ghBlnL42oHgXLwP9gQdP6ss77DRSek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3eOrhSQ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3eOrhSQ"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-824b03d9787so182488b3a.2
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 04:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771418814; x=1772023614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aA05lfEAVSoET+LkhCpZsbF3XObYeCHbN459JDAR84I=;
        b=S3eOrhSQ+gcP5fIBb/atORC32A5vnSeOKLFO5pYbloDnHhO0h0AKub6eIgQqBiWIRE
         mX/1oSEcntgNcxth3soYgQ5iblR0UhEQ2Z6iDHJoPy316e/OmgflTcoJrohxZEfdxlGe
         wlZloAGkU0O9DBrVtL9WM4FewSHBcXKcTv33SqXlKBgtAsoB1z5j26fTSEMNOmMUPfgb
         UOSgtkL5JK5sS89qw745XXoRbUAClklmKreSpRrULKlZPxSrOq/CsvVE8vjeE0ZpDDyf
         b1G1oXxyVlxnhyXntjzCjwAr1aiPUGPNSJWWRkt+v4lPr7F/5aHwyKk154H9XKedwwEA
         NQxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771418814; x=1772023614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aA05lfEAVSoET+LkhCpZsbF3XObYeCHbN459JDAR84I=;
        b=hUz8d8QFnP7X2iqDsApdmVsmeVRjbxmaYtwQbAnw8fIpLx1FeOTMwnn4woFep5w+qD
         e5kNODV0ZX83KRULBiZ8I51OdFmf9ehPYg9buASEF20OxKYBk2Q5pnz6N1GZCdCS6OAl
         weP1+TsZAmIjnSw3lKmBurqSKm/v2QQreaXAp5CBWrTswJN1i9MBELzbIvClSWUuUMqA
         NSSf68GKVnnfldy2/qlyLub42o4pSpCEBlQ9rcKzIsVx39AytfvP8ax3o5Bmer2b/DPK
         Fjpn+23ILNNKPxGm00swZvCGi+xhAhPBTDlukph7smto8kKX6MZy0LCywab0CPNfWoTc
         mjGQ==
X-Gm-Message-State: AOJu0Ywk9kvMdJHWjf0C6e9U0+h6tJcX6fjIxN6Pj2QHUuHpYmIRozz4
	ekTYQMDbxFq2U4OxuRVxcu2U7cv3JCkJmudZ6sj+zRfJlf5sShpizsbH
X-Gm-Gg: AZuq6aJdw6u1FIvkc5HEnsqbLRU/0iuHCX3RS40W11KeIWRZSuKnc7vvr5sCcve6fqp
	M7PQQ8P/a6uXZjnY8PJkitDmuSzv1XByDKyOpNV6SOjFu0N6thi9Qmao+g2j++3jE1X3atg2ukj
	FGlj+q+6oP4NSvxgthNzXAFjT2gRH7IsRcqSHfRkHWI5GQ94/dwm5cevQFnyJuGOFetWIr328AR
	P0zlNZpqN5i4gO64HdnwgGIn4egLxwnrhR9Hd1xDmxQr1DJKLWs8DRMz/tYb+61gq3ZZJ/DQlSG
	P6LS+5Zt9xm12SiD+EETXk4Ik4AD6+bsz/1US0chsexLaBoLLXUBXJnf4M3VOujSFcawRUtrpqE
	O8yb0CoCRUqMJzjDUrGRuErE89zpiUrRFfFnMIIvvub+rfto8o1BDaGfeahqisFKFrzbkK/l0Xh
	Kk8Scas4zHGsoeyjUYERegf22oNsvlmYaKKFZofks=
X-Received: by 2002:a05:6a00:1142:b0:823:c646:28c8 with SMTP id d2e1a72fcca58-824c5ec6f49mr12431298b3a.1.1771418814269;
        Wed, 18 Feb 2026 04:46:54 -0800 (PST)
Received: from malon-Yoga-14sARE-2020.. ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b69ee6sm16639485b3a.32.2026.02.18.04.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 04:46:53 -0800 (PST)
From: Tian Yuchen <a3205153416@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	karthik.188@gmail.com
Subject: [PATCH v6 2/2] setup: allow cwd/.git to be a symlink to a directory
Date: Wed, 18 Feb 2026 20:46:38 +0800
Message-ID: <20260218124638.176936-3-a3205153416@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260218124638.176936-1-a3205153416@gmail.com>
References: <20260218124638.176936-1-a3205153416@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Strictly enforcing 'lstat()' prevents valid '.git' symlinks.

Rely on 'stat()' (via 'read_gitfile_gently()') to handle filesystem
resolution, instead of blocking it with strict logic checks in
'setup_git_directory_gently_1()'.

To ensure safety and correctness, we unconditionally delegate benign
cases ('ENOENT', 'IS_A_DIR') and security risks ('NOT_A_FILE') to
'read_gitfile_error_die()'.

For other errors (like invalid format), we only invoke the handler if
'die_on_error' is true; otherwise, we return the error code to respect
the gentle fallback behavior.

Add 't/t0009-git-dir-validation.sh' to verify symlink support and FIFO
rejection, and register it in 't/meson.build'.

Signed-off-by: Tian Yuchen <a3205153416@gmail.com>
---
 setup.c                       | 21 ++++++----
 t/meson.build                 |  1 +
 t/t0009-git-dir-validation.sh | 72 +++++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+), 8 deletions(-)
 create mode 100755 t/t0009-git-dir-validation.sh

diff --git a/setup.c b/setup.c
index d48b6a3a3d..f4b9d41f78 100644
--- a/setup.c
+++ b/setup.c
@@ -1590,15 +1590,20 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 		gitdirenv = read_gitfile_gently(dir->buf, die_on_error ?
 						NULL : &error_code);
 		if (!gitdirenv) {
-			if (die_on_error ||
-			    error_code == READ_GITFILE_ERR_NOT_A_FILE) {
-				/* NEEDSWORK: fail if .git is not file nor dir */
-				if (is_git_directory(dir->buf)) {
-					gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;
-					gitdir_path = xstrdup(dir->buf);
+			if (error_code){
+				if (error_code == READ_GITFILE_ERR_STAT_ENOENT ||
+				error_code == READ_GITFILE_ERR_IS_A_DIR ||
+				error_code == READ_GITFILE_ERR_NOT_A_FILE ||
+				die_on_error) {
+					read_gitfile_error_die(error_code, dir->buf, NULL);
+				} else {
+					return GIT_DIR_INVALID_GITFILE;
 				}
-			} else if (error_code != READ_GITFILE_ERR_STAT_FAILED)
-				return GIT_DIR_INVALID_GITFILE;
+			}
+			if (is_git_directory(dir->buf)) {
+				gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;
+				gitdir_path = xstrdup(dir->buf);
+			}
 		} else
 			gitfile = xstrdup(dir->buf);
 		/*
diff --git a/t/meson.build b/t/meson.build
index f80e366cff..c4afaacee5 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -80,6 +80,7 @@ integration_tests = [
   't0006-date.sh',
   't0007-git-var.sh',
   't0008-ignores.sh',
+  't0009-git-dir-validation.sh',
   't0010-racy-git.sh',
   't0012-help.sh',
   't0013-sha1dc.sh',
diff --git a/t/t0009-git-dir-validation.sh b/t/t0009-git-dir-validation.sh
new file mode 100755
index 0000000000..9b3925c85f
--- /dev/null
+++ b/t/t0009-git-dir-validation.sh
@@ -0,0 +1,72 @@
+#!/bin/sh
+
+test_description='setup: validation of .git file/directory types
+
+Verify that setup_git_directory() correctly handles:
+1. Valid .git directories (including symlinks to them).
+2. Invalid .git files (FIFOs, sockets) by erroring out.
+3. Invalid .git files (garbage) by erroring out.
+'
+
+. ./test-lib.sh
+
+test_expect_success 'setup: create parent git repository' '
+	git init parent &&
+	test_commit -C parent "root-commit"
+'
+
+test_expect_success SYMLINKS 'setup: .git as a symlink to a directory is valid' '
+	mkdir -p parent/link-to-dir &&
+	(
+		cd parent/link-to-dir &&
+		git init real-repo &&
+		ln -s real-repo/.git .git &&
+		git rev-parse --git-dir >actual &&
+		echo .git >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success PIPE 'setup: .git as a FIFO (named pipe) is rejected' '
+	mkdir -p parent/fifo-trap &&
+	(
+		cd parent/fifo-trap &&
+		mkfifo .git &&
+		test_must_fail git rev-parse --git-dir 2>stderr &&
+		grep "not a regular file" stderr
+	)
+'
+
+test_expect_success SYMLINKS,PIPE 'setup: .git as a symlink to a FIFO is rejected' '
+	mkdir -p parent/symlink-fifo-trap &&
+	(
+		cd parent/symlink-fifo-trap &&
+		mkfifo target-fifo &&
+		ln -s target-fifo .git &&
+		test_must_fail git rev-parse --git-dir 2>stderr &&
+		grep "not a regular file" stderr
+	)
+'
+
+test_expect_success 'setup: .git with garbage content is rejected' '
+	mkdir -p parent/garbage-trap &&
+	(
+		cd parent/garbage-trap &&
+		echo "garbage" >.git &&
+		test_must_fail git rev-parse --git-dir 2>stderr &&
+		grep "invalid gitfile format" stderr
+	)
+'
+
+test_expect_success 'setup: .git as an empty directory is ignored' '
+	mkdir -p parent/empty-dir &&
+	(
+		cd parent/empty-dir &&
+		mkdir .git &&
+		git rev-parse --git-dir >actual &&
+		echo "$TRASH_DIRECTORY/parent/.git" >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_done
-- 
2.43.0

