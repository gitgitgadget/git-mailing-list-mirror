Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCA014F90
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 20:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732740470; cv=none; b=lOYE8I4LVywd121Pzw56UjxK0Lz25F9XSkBmBOzjdPgrdWADqNF+uCU5wl+nJke57hkKIfGj07skPh7k90+AfY0yJ9P8xsjABIPaqZDYXxFvwId8sWgOIv/vOy0zD434YppqNYrRFjXPp4HyO+LDxWVRisa5jh/5LfTiCqS/Z+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732740470; c=relaxed/simple;
	bh=q+NVIXyxX6XzuFF3cZt3LK0ol//wLFk0qft1CXvun50=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=TbSHz3jesf/Fnl1F4ME5X8Bmg405OiYHJBfR4ptRI+a5DtYzhCqV8LPstEWeF/OQ0R6mX+0ayk2Ejmyh4t80CrQkaos9tZ+uKLqjxCSgQHIoIojhLC/Cba7FPFPgN8Jyc5m1H27BOACy0FsMSk4YSjJMRkLtHWpxW9ct1prbqZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKAvF5tf; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKAvF5tf"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3823cae4be1so86056f8f.3
        for <git@vger.kernel.org>; Wed, 27 Nov 2024 12:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732740466; x=1733345266; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UQICT9qxVFyEumtT0g3YrEm6IBE5qyZrePf/RVY4OYU=;
        b=lKAvF5tfubTKIsCnuOEgaabPC24bz8rAIsfMGCZUWyg9JVwfwUYuj/X3NvK1wSNfQq
         TjmkYBsIOLZRmsPBtFSJTtunxqzPOorqluB3AnNaPfE9EGc+GdXDNktYOiB5b09oikw4
         52iAVqfKvH7uGtJVfduKH9BBFcx/x/2T4Dp57jhv2Rq7MCBzRBltW6E6j0m2cDHPu3n1
         0Iwe9FH4d9Azu5B1zkJdLlob3Fh1OEihCCJ4nEfmmZS++nwq2yhYPBR3jbenI0L6SmoC
         c6K7lJTkPY2HG7myZTDKc+DmmScqxIl+qdjDEguJtkXIULZlvR8DbQQDdpRxKf5uLJni
         6oeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732740466; x=1733345266;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UQICT9qxVFyEumtT0g3YrEm6IBE5qyZrePf/RVY4OYU=;
        b=rIFp9OR7ETu4o+OKfpIaE1gBpCBooUoZ9D6jZIo4nki5cAOw8YqSGV5Icu3JDbSyJd
         b6dOiOKAJir0tBNsw0HYzSYnRWp6PhlmR7iZiwY7o322Z85xlQ0JM29zmJB0mDLdXnJL
         kow7tHjpt2v7vipYtvbVOjC+UeZtEcHy4AVYL7SCnHF1FNyv1ekjCsh32BWTSzbpJMiP
         ffI5rblER4eFCTj3xuqkPqHqEPki6Re5uqFgpvKHIdPndzDfp5UHgTvFZQkU1gDjdoo0
         lf9Zjv/heWwaLCiSEHiC1NR+ZiNZT5ukBoolDVG6WpY4SXQgSLpCT+vEy4v4kk5nJsW1
         siJA==
X-Gm-Message-State: AOJu0Yw0Ba/b3gxubH2klK8MrI5ZUbMVP18G78DJYDWKCowJaszTX6Sp
	Zn6RR0RJ++LfuhOCtVHtfceq72xaDg5/hiHzhag+/mUJt3AH6hRZogm1LQ==
X-Gm-Gg: ASbGncsZt5bZBQZigMtn8Urt+tQyDJDSAIDG/M1ZlzN47no8FH2GIgxDcE9NsS+SUZf
	zx2f5aBL5qBcoc0BK7NQ1S+UXGJGcTYsbCHMePJLWv65t/bTh7F5fv+/+58yjLPtmguhqZvoSQx
	7WFcXF0keCOQ3Xmy7EAD8VZaw7Q0v8aM0TXEh5k0SyBo3G9VVqw+8hXVYCKbf/hIh5hPIMLOW+G
	K2o8g3ElZSki/dRJg1j6xH++zi3UhxJpei6E3aPTGF9xVUFvFI=
X-Google-Smtp-Source: AGHT+IH5XjWWBvo6L3DwZhM/tATHFm/WcN0s0S90u3fj0hapKCavrIroR/eT5AjBjVfy3CLlx+pX5w==
X-Received: by 2002:a5d:6da8:0:b0:382:49a5:2229 with SMTP id ffacd0b85a97d-385c6ed7578mr4075784f8f.39.1732740465821;
        Wed, 27 Nov 2024 12:47:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fafe338sm17106832f8f.33.2024.11.27.12.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 12:47:45 -0800 (PST)
Message-Id: <pull.1832.git.1732740464398.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 27 Nov 2024 20:47:44 +0000
Subject: [PATCH] fast-import: disallow more path components
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
    Patrick Steinhardt <ps@pks.im>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Jeff King <peff@peff.net>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Instead of just disallowing '.' and '..', make use of verify_path() to
ensure that fast-import will disallow anything we wouldn't allow into
the index, such as anything under .git/, .gitmodules as a symlink, or
a dos drive prefix on Windows.

Since a few fast-export and fast-import tests that tried to stress-test
the correct handling of quoting relied on filenames that fail
is_valid_win32_path(), such as spaces or periods at the end of filenames
or backslashes within the filename, turn off core.protectNTFS for those
tests to ensure they keep passing.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    Disallow verify_path() failures from fast-import
    
    Since en/fast-import-path-sanitize has already made it to next, this
    commit is based on that. (See
    https://lore.kernel.org/git/pull.1831.v2.git.1732561248717.gitgitgadget@gmail.com/
    for discussion of that series.)
    
    Changes relative to that commit: this fixes up the error message as
    suggested by Kristoffer, and makes the checks more encompassing as
    suggested by Patrick and Peff -- in particular, using verify_path() as
    suggested by Peff.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1832%2Fnewren%2Fdisallow-verify-path-fast-import-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1832/newren/disallow-verify-path-fast-import-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1832

 builtin/fast-import.c  |  5 ++-
 t/t9300-fast-import.sh | 88 ++++++++++++++++++++++++++++++++++++++++--
 t/t9350-fast-export.sh |  2 +-
 3 files changed, 88 insertions(+), 7 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 3e7ec1f1198..bb4b769c7c3 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -13,6 +13,7 @@
 #include "delta.h"
 #include "pack.h"
 #include "path.h"
+#include "read-cache-ll.h"
 #include "refs.h"
 #include "csum-file.h"
 #include "quote.h"
@@ -1413,6 +1414,8 @@ static int tree_content_set(
 		die("Empty path component found in input");
 	if (!*slash1 && !S_ISDIR(mode) && subtree)
 		die("Non-directories cannot have subtrees");
+	if (!verify_path(p, mode))
+		die("invalid path '%s'", p);
 
 	if (!root->tree)
 		load_tree(root);
@@ -1468,8 +1471,6 @@ static int tree_content_set(
 		root->tree = t = grow_tree_content(t, t->entry_count);
 	e = new_tree_entry();
 	e->name = to_atom(p, n);
-	if (is_dot_or_dotdot(e->name->str_dat))
-		die("path %s contains invalid component", p);
 	e->versions[0].mode = 0;
 	oidclr(&e->versions[0].oid, the_repository->hash_algo);
 	t->entries[t->entry_count++] = e;
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 5a5127fffa7..e2b1db6bc2f 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -522,7 +522,7 @@ test_expect_success 'B: fail on invalid committer (5)' '
 	test_must_fail git fast-import <input
 '
 
-test_expect_success 'B: fail on invalid file path' '
+test_expect_success 'B: fail on invalid file path of ..' '
 	cat >input <<-INPUT_END &&
 	blob
 	mark :1
@@ -542,6 +542,86 @@ test_expect_success 'B: fail on invalid file path' '
 	test_must_fail git fast-import <input
 '
 
+test_expect_success 'B: fail on invalid file path of .' '
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
+	M 100644 :1 ./invalid-path
+	INPUT_END
+
+	test_when_finished "git update-ref -d refs/heads/badpath" &&
+	test_must_fail git fast-import <input
+'
+
+test_expect_success WINDOWS 'B: fail on invalid file path of C:' '
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
+	M 100644 :1 C:/invalid-path
+	INPUT_END
+
+	test_when_finished "git update-ref -d refs/heads/badpath" &&
+	test_must_fail git fast-import <input
+'
+
+test_expect_success 'B: fail on invalid file path of .git' '
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
+	M 100644 :1 .git/invalid-path
+	INPUT_END
+
+	test_when_finished "git update-ref -d refs/heads/badpath" &&
+	test_must_fail git fast-import <input
+'
+
+test_expect_success 'B: fail on invalid file path of .gitmodules' '
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
+	M 120000 :1 .gitmodules
+	INPUT_END
+
+	test_when_finished "git update-ref -d refs/heads/badpath" &&
+	test_must_fail git fast-import <input
+'
+
 ###
 ### series C
 ###
@@ -966,7 +1046,7 @@ test_expect_success 'L: verify internal tree sorting' '
 	:100644 100644 M	ba
 	EXPECT_END
 
-	git fast-import <input &&
+	git -c core.protectNTFS=false fast-import <input &&
 	GIT_PRINT_SHA1_ELLIPSIS="yes" git diff-tree --abbrev --raw L^ L >output &&
 	cut -d" " -f1,2,5 output >actual &&
 	test_cmp expect actual
@@ -3117,7 +3197,7 @@ test_path_eol_success () {
 	test_expect_success "S: paths at EOL with $test must work" '
 		test_when_finished "git branch -D S-path-eol" &&
 
-		git fast-import --export-marks=marks.out <<-EOF >out 2>err &&
+		git -c core.protectNTFS=false fast-import --export-marks=marks.out <<-EOF >out 2>err &&
 		blob
 		mark :401
 		data <<BLOB
@@ -3226,7 +3306,7 @@ test_path_space_success () {
 	test_expect_success "S: paths before space with $test must work" '
 		test_when_finished "git branch -D S-path-space" &&
 
-		git fast-import --export-marks=marks.out <<-EOF 2>err &&
+		git -c core.protectNTFS=false fast-import --export-marks=marks.out <<-EOF 2>err &&
 		blob
 		mark :401
 		data <<BLOB
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 1eb035ee4ce..bb83e5accd9 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -631,7 +631,7 @@ test_expect_success 'fast-export quotes pathnames' '
 	 git rev-list HEAD >expect &&
 	 git init result &&
 	 cd result &&
-	 git fast-import <../export.out &&
+	 git -c core.protectNTFS=false fast-import <../export.out &&
 	 git rev-list HEAD >actual &&
 	 test_cmp ../expect actual
 	)

base-commit: 4a2790a257b314ab59f6f2e25f3d7ca120219922
-- 
gitgitgadget
