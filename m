Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519E92AD00
	for <git@vger.kernel.org>; Sun, 19 Jul 2026 13:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784468692; cv=none; b=Q0LjW1YJyNMIL7X5/akm8AulopwlP0fOrGiXJawRfsD5mAFCkOEAkHsTdggSDvxQcvBaVd7VJRNRnlL/EumuiqLQxmfnUEGCXv1XOti5SeaczY+71QqRccatWD2LGfZgydk5YY1vZ9XWhGS09Rqgz/cetag3B+MQuvhnSu+qhM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784468692; c=relaxed/simple;
	bh=Bvozxn4yAlfpEtGu9B+L5sxI7xUb9kQ5FjFgPqWgDCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BU2UXW1vB7JsCJoekts4v4T7ytB7c65qZQzeQK6Yzn1sTDvaSk4kpIJfTddDeOTY2V/Rzm7EByshxxr0/YhDm9+nalosvhLUel3fS9C8LkjrrETQG0emviuzmOUkpblgkoTveO73EiUU0JFKeRVzVr1i0tdoaZbpg/NxZfbRy2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXc0mTdy; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXc0mTdy"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c9e7391839cso5376793a12.0
        for <git@vger.kernel.org>; Sun, 19 Jul 2026 06:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784468691; x=1785073491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pWreBvMjRkTsRRKqqixqjOUqIXxHi0c49HmuFuQS6v4=;
        b=YXc0mTdyavk0lonQ/dyZENq20nL2DUBnj05GkI5kDpst4PwBwB1qny+s1+c1ZWdq/4
         8szHtIBSq6cDKiXTWm+17S0awMVf6utaC3iw0nMXRBWmsLBkJV6i6nHovk4AQ0Xg+j1F
         vUKjvXcDnB7R/5MvoEMdJvNYD27MQ0eLoeR+3lZvgcPerkPpkVUn5UBIPhNssm2ZOpLI
         9NelOCuMONcWL/3EazU2cn2Zz4UPS7cnG2d/30qbOqir/K4KoCfKXdrNT3ESDQrsFyiu
         JiAhRYe9LajdP0OrTWCkqKVIJQnXeEfgr2gcxjyae3G4wGYYe2G8etLLo7Rvx6417H2r
         4RyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784468691; x=1785073491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pWreBvMjRkTsRRKqqixqjOUqIXxHi0c49HmuFuQS6v4=;
        b=nJSjf27TbaIkcT9yD3n7JnmSDdhMCvvFUvcz0OzT3sAi/QkjXnylqJDe5YdJTvS04t
         iojsZp/+6lp01y3pv5/esH/zhxtkPHrTd9NOHI4VDl+7KQRp4tHJKIjZtP8bQFcSq9zB
         nB1Mt9xixsdXiCe+sNnKfz5T8UcZAVjGTwbRMc7fSBEWrWAkUWL/bqkqkyCe9tKpSNy9
         1V6n2i6bhv5K9GjnFWB3slTmOnOum8FzWU7moxvFx2pCYLa8voJ8nN4HovSeSchCJOje
         ldNhNZQ+Us9bx13d0qD2RYOduOVJNXutN4TceetnGk5wyRiIzmlUyAkWLKUCkkje0Xjs
         PEDQ==
X-Gm-Message-State: AOJu0YyUqIFxi7kcxvw8jhx3Vflxm3/5QQ2RPCbGONkbbuqR9MIaUDQT
	6WjbfLHQ3nl9vluV+Z6r8D3NnGufvG4T1SWF0qTqzJAX9jWDDLWovFEB5X/WjQ==
X-Gm-Gg: AfdE7cmXqRMjgV0ItdLr7E25OtVwfUD5IiMIMpL8eJSjBK9AFkvgX1BqTv1OvqKsTkn
	zbdU0l9SbB8tG4PeacT2xON3C0vfux9LyV8PvrOp1oBut8zL3vE5CmC7TxpLDV9zw4WHbVSZKFp
	eKsTxhu4S2AVTjBsSQx0VmzOwf1VUa249WZha9qmrb4wHfrWULFjZ6Cgwb41cpqvOAPFXYr+W5b
	jbcoY5995HPER6M7BWvyodjDrMaw/Ok/IFus607fYDKNUH1yLyh/OT0iOidG3ejTj5KKHPILPNO
	DcWh08pxmZcWPhpSwzCOuuGDiZsGSMQS7xgSCj3bI8su0Eewpt3zqKXu6cyYh9MbKJ1A6svexgG
	56zCLiE8nL33yAkKNub943RrnOg5EDvXlv85znmimWf5/31mK35YRzvPmQXOSbxYnqmRxCJsldK
	yeYQ==
X-Received: by 2002:a05:6300:83c6:10b0:3c3:becb:b705 with SMTP id adf61e73a8af0-3c3becbd092mr6158700637.27.1784468690554;
        Sun, 19 Jul 2026 06:44:50 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a20b037sm28619582eec.27.2026.07.19.06.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 06:44:49 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: git@vger.kernel.org,
	Thiago Perrotta <tbperrotta@gmail.com>,
	Philippe Blain <levraiphilippeblain@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>
Cc: Yury Norov <ynorov@nvidia.com>,
	linux-kernel@vger.kernel.org,
	Yury Norov <yury.norov@gmail.com>,
	Codex <codex@openai.com>
Subject: [PATCH] completion: complete paths for git send-email
Date: Sun, 19 Jul 2026 09:44:47 -0400
Message-ID: <20260719134447.381835-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yury Norov <ynorov@nvidia.com>

git send-email accepts either revisions or paths to patch files, but its
Bash completion only offers revisions. This prevents patch files from
being completed. It can also make a prefix such as "0" expand to an
unrelated hexadecimal ref even when matching 0001-*.patch files exist.

In my Linux tree, an attempt to autocomplete the standard-named patch
brings a random hashtag:

 $ ls 0*
 0001-bitmap-drop-bitmap_next_set_region.patch
 $ git send-email 0<Tab>
 $ git send-email 05c69d298c96703741cac9a5cbbf6c53bd55a6e2

Introduce an append variant of __gitcomp_file() and use it to add
filesystem candidates after the existing revision candidates.  Keep the
latter because revisions remain valid send-email arguments.

Add a regression test covering patch files alongside a 40-hex ref.

Assisted-by: Codex <codex@openai.com>
Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 contrib/completion/git-completion.bash | 29 +++++++++++++++++++-------
 t/t9902-completion.sh                  | 12 ++++++++++-
 2 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e87578771..b7017488d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -579,21 +579,18 @@ __gitcomp_file_direct ()
 }
 
 # Generates completion reply with compgen from newline-separated possible
-# completion filenames.
+# completion filenames by appending them to the existing list of completion
+# candidates, COMPREPLY.
 # It accepts 1 to 3 arguments:
 # 1: List of possible completion filenames, separated by a single newline.
 # 2: A directory prefix to be added to each possible completion filename
 #    (optional).
 # 3: Generate possible completion matches for this word (optional).
-__gitcomp_file ()
+__gitcomp_file_append ()
 {
 	local IFS=$'\n'
 
-	# XXX does not work when the directory prefix contains a tilde,
-	# since tilde expansion is not applied.
-	# This means that COMPREPLY will be empty and Bash default
-	# completion will be used.
-	__gitcompadd "$1" "${2-}" "${3-$cur}" ""
+	__gitcompappend "$1" "${2-}" "${3-$cur}" ""
 
 	# use a hack to enable file mode in bash < 4
 	compopt -o filenames +o nospace 2>/dev/null ||
@@ -601,6 +598,23 @@ __gitcomp_file ()
 	true
 }
 
+# Generates completion reply with compgen from newline-separated possible
+# completion filenames.
+# It accepts 1 to 3 arguments:
+# 1: List of possible completion filenames, separated by a single newline.
+# 2: A directory prefix to be added to each possible completion filename
+#    (optional).
+# 3: Generate possible completion matches for this word (optional).
+__gitcomp_file ()
+{
+	# XXX does not work when the directory prefix contains a tilde,
+	# since tilde expansion is not applied.
+	# This means that COMPREPLY will be empty and Bash default
+	# completion will be used.
+	COMPREPLY=()
+	__gitcomp_file_append "$@"
+}
+
 # Find the current subcommand for commands that follow the syntax:
 #
 #    git <command> <subcommand>
@@ -2634,6 +2648,7 @@ _git_send_email ()
 		;;
 	esac
 	__git_complete_revlist
+	__gitcomp_file_append "$(compgen -f -- "$cur")"
 }
 
 _git_stage ()
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 55dc9eabf..e87827f21 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2777,7 +2777,17 @@ test_expect_success PERL 'send-email' '
 	test_completion "git send-email --val" <<-\EOF &&
 	--validate Z
 	EOF
-	test_completion "git send-email ma" "main "
+	test_completion "git send-email ma" "main " &&
+
+	git tag 05c69d298c96703741cac9a5cbbf6c53bd55a6e2 &&
+	test_when_finished "git tag -d 05c69d298c96703741cac9a5cbbf6c53bd55a6e2 &&
+		rm -f 0001-example.patch 0002-example.patch" &&
+	touch 0001-example.patch 0002-example.patch &&
+	test_completion "git send-email 0" <<-\EOF
+	0001-example.patch
+	0002-example.patch
+	05c69d298c96703741cac9a5cbbf6c53bd55a6e2 Z
+	EOF
 '
 
 test_expect_success 'complete files' '
-- 
2.53.0

