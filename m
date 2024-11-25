Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21BD175D5D
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 19:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732561254; cv=none; b=WxwAB1iNm+v7/mKqZDVds29M5KFTeKESGfou3PGgk8CRzTgO+8cCJVni0crHoCATzE/m3EZresErn5Md9gSK4xuHVUgDJCUHUkMNpG1+l0dt5rDCt54LOezT9tIzLosSFYfBae+OMmqFLljlbrkeODkrjoIpA5SWBLG0QmTuhhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732561254; c=relaxed/simple;
	bh=k+fFbkadHeGxRbpMNlRo59SnkVPp52TouE0IEUYv1MA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kKw3PQ2XjGrrpj0qJQwbah3SSWSnlSrrCzvOEuOqrZFSqq04VskexjRA7388JO6uMeQQrPGmkV/zYtL9dfccu7NOtBQZ+kIPz/NO8aY4GXl/3dsWCbBIXyJWHUMaHGej774BK+1ccmdVLBCnqWmrq92U2bDOnjGfMrA8HZa8d5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FVp9l1Oy; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVp9l1Oy"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53dd59a2bc1so3812082e87.2
        for <git@vger.kernel.org>; Mon, 25 Nov 2024 11:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732561250; x=1733166050; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6iLONYqtVU1pLoXib68N4F9qGns3tP+elqiy9IVqXQ=;
        b=FVp9l1OyU+NAoF7NQZifRnZH2e1HlmQ/TenZeZemfdxrZzoLz8w1yytubtQVPWb6v7
         X3fFK0pC5LH8KHiYpKIogzZ2nvElYgs39K5bmF72JyJla8XxgzPuHmsAYTx8i4PNb5Dh
         VjJSvywlbqxBwDLoS+3a+1tO82q4c50UoOa4OEbYx1ARabk6C7lAB2uKAW3Sjnn0LqwP
         AUhaz97Qp2SwfXyQiv1iLaX+fiBKtdJY3ZklfBOraV5Jr6a0aVUarpL7IMEOExsKobZF
         6TPbhVoBzbY2B/PunD1kaihK93C4Pb6DMwsSfbaj+PqzyG8MP30FfVJgemh9Xu1Jik7v
         a5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732561250; x=1733166050;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6iLONYqtVU1pLoXib68N4F9qGns3tP+elqiy9IVqXQ=;
        b=H5ZNwYH7ak8g8dke5Hp5TYjdqT9xkaZZJ9UyzsQLmFNDy2yNQWd8bMvNMPpo1poiLL
         OXtPuiB1JdmDh6/oKqqS1o0LKLqKhAxJ+eMz6xKS4LZv9BhC3Ni6X/ZdwPv2X0kGB8kW
         UhWq+FHRT0Cf0EX6E180LbUfGOPM4TebKtD26QP9a6zBudc3skhqLYMJxKkTb5Hvcqox
         sQfJx8SDgfxkdeWDWiWuFUiC5pkugQgugVA452imjfJ3J88pde884LZ5XlRPUyHExIct
         DQHCM8bcEPJNnAzqOU1C43Ai+OMe1YQrJon1DVigpYQdDWr7dEALUCtcEfFxdh3rZ+WK
         CiTA==
X-Gm-Message-State: AOJu0YxGmxGpORBCQ7OUAhi5X8zAr1+pk9aqZQLWE9I1sv8A0gaiItQR
	kuC62SdgQdkEeaCj0RRnoSkq2LHtaKqyb9Duo3zrQK/yhGk1bkkCuwBAcQ==
X-Gm-Gg: ASbGncuDV0TJKiKNOM1eLrnW47Eo8cTwruU2W7O0FWfZGhSMRtp2Axv0ouMpfdehPwK
	7DAnXs9dax+993gUpR4KcDwKGxP+n8aRIfOWxtYJnKNNh+AppJqV2mNzA5sp66J/M5HcEZ9c6AB
	7jgT9WKfbdA/BQitJE5YcOYfeT9FgoftdIzpGy//pBLN7+EG+fLxkKWD8+fBtrRuRqBGBbPCYJx
	h4qpiTT5apvcktl30n6NJ4HfH/F2uO2uAJvr30aajo9sjvZbpk=
X-Google-Smtp-Source: AGHT+IHfceti8yGcKuD0KziWzuL0P5TxMgToFp3nrAb3R56sICqG7ZxQJud/1wcJc7JvhXHB73puHw==
X-Received: by 2002:a05:6512:3b90:b0:53d:c3aa:e4ec with SMTP id 2adb3069b0e04-53dd35a4cfamr6396567e87.1.1732561250058;
        Mon, 25 Nov 2024 11:00:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b52f92fsm502545566b.107.2024.11.25.11.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 11:00:49 -0800 (PST)
Message-Id: <pull.1831.v2.git.1732561248717.gitgitgadget@gmail.com>
In-Reply-To: <pull.1831.git.1732557520428.gitgitgadget@gmail.com>
References: <pull.1831.git.1732557520428.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 25 Nov 2024 19:00:48 +0000
Subject: [PATCH v2] fast-import: disallow "." and ".." path components
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

If a user specified e.g.
   M 100644 :1 ../some-file
then fast-import previously would happily create a git history where
there is a tree in the top-level directory named "..", and with a file
inside that directory named "some-file".  The top-level ".." directory
causes problems.  While git checkout will die with errors and fsck will
report hasDotdot problems, the user is going to have problems trying to
remove the problematic file.  Simply avoid creating this bad history in
the first place.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    fast-import: disallow "." and ".." path components
    
    Changes since v1:
    
     * make use of is_dot_or_dotdot() from dir.h
     * fix style issue

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1831%2Fnewren%2Fdisallow-dotdot-fast-import-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1831/newren/disallow-dotdot-fast-import-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1831

Range-diff vs v1:

 1:  86ea3df0351 ! 1:  447b6794a4a fast-import: disallow "." and ".." path components
     @@ builtin/fast-import.c: static int tree_content_set(
       		root->tree = t = grow_tree_content(t, t->entry_count);
       	e = new_tree_entry();
       	e->name = to_atom(p, n);
     -+	if (!strcmp(e->name->str_dat, ".") || !strcmp(e->name->str_dat, "..")) {
     ++	if (is_dot_or_dotdot(e->name->str_dat))
      +		die("path %s contains invalid component", p);
     -+	}
       	e->versions[0].mode = 0;
       	oidclr(&e->versions[0].oid, the_repository->hash_algo);
       	t->entries[t->entry_count++] = e;


 builtin/fast-import.c  |  2 ++
 t/t9300-fast-import.sh | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 76d5c20f141..995ef76f9d6 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -1466,6 +1466,8 @@ static int tree_content_set(
 		root->tree = t = grow_tree_content(t, t->entry_count);
 	e = new_tree_entry();
 	e->name = to_atom(p, n);
+	if (is_dot_or_dotdot(e->name->str_dat))
+		die("path %s contains invalid component", p);
 	e->versions[0].mode = 0;
 	oidclr(&e->versions[0].oid, the_repository->hash_algo);
 	t->entries[t->entry_count++] = e;
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 6224f54d4d2..caf3dc003a0 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -522,6 +522,26 @@ test_expect_success 'B: fail on invalid committer (5)' '
 	test_must_fail git fast-import <input
 '
 
+test_expect_success 'B: fail on invalid file path' '
+	cat >input <<-INPUT_END &&
+	blob
+	mark :1
+	data <<EOF
+	File contents
+	EOF
+
+	commit refs/heads/badpath
+	committer Name <email> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	Commit Message
+	COMMIT
+	M 100644 :1 ../invalid-path
+	INPUT_END
+
+	test_when_finished "git update-ref -d refs/heads/badpath" &&
+	test_must_fail git fast-import <input
+'
+
 ###
 ### series C
 ###

base-commit: 04eaff62f286226f501dd21f069e0e257aee11a6
-- 
gitgitgadget
