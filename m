Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979C32652AE
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 15:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753197799; cv=none; b=e2FoiO/wruTWhqIpZCMcCf4rmI4M0+qd+KQe4eDURxXK7s5xFCV17EUbwLerYbiMIiey3wkjy+U0Gz5aN+TBXBBb8Urs0Ocg9g1QSlkSuCsWD0heU5vq0sXv3SKDyWQ4i+ggtqrY/pyI0fVBcsfniP92qRJcSrf9TRITtdxpRrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753197799; c=relaxed/simple;
	bh=3izt5RHToa3eL6cjEQ0dF+oOwJKzL1vbNMe2SqRNcrk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=I0WaswR6Ja0S3lJJQwajEOZN4IwYrfpxuujnWzKpVqodUUW/BJCWS11gBbSXWhNCKgrHzTtLOuR7m/iTt9KX7Mxvy+k/1qBZOvzoWBtZHwOgB0usS4mgFzG0hx2+K7RSFzg712FOC/ZOxgMBd9Q3QyN2i/ni6eBuVEvZhtFGI3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXEr8H2m; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXEr8H2m"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4561ed868b5so39081025e9.0
        for <git@vger.kernel.org>; Tue, 22 Jul 2025 08:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753197795; x=1753802595; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pstysf1jwtwh5qIUePUxtwT8LIJjdkwQMHK63vdfS+8=;
        b=fXEr8H2mQK0yg8pTQxMxUUjvVvaZG16oNdEl17/7EvW2Qezeith8NJ3e2l1AxmeW1z
         L9FHM7LlIK0nmlVeq6B8QQcS2yt6dBurGQwjXJ9J2/i9HiIOt2DCVXsReW3wcz5piRrb
         nZ4CmjBYzAPYZb+v7LqI0iiJ6uz87RhDNWA90PRMA6UwzIV0LdadjO//TnubXTxK8xax
         kBj7qxz3SVXRhK8kcKiJ8yslwGqNtZFbwKtv4g2Uwd3qTsknCiMHe6TSzIt/0Y83WgoV
         gH0zEdi5MDATPvTPAMqpJDZZN3lMvOfjjM2hUfbJBqmWZajdPYamgBhdvQXuadKC9NaB
         1pQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753197795; x=1753802595;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pstysf1jwtwh5qIUePUxtwT8LIJjdkwQMHK63vdfS+8=;
        b=lmQRIBjzsGUJtecMkaMXRDGG3GPGLwJ63YgRHF8K1KrqYJYBeW80kRm46wl+kat5zh
         /Agi2XQL4mWz/EsREEmtb/L5ZVDsfP10hDBY1/9zdJ6Gb/9CNIETsbaAUhOYb2jI/ekf
         Y1oY/dwqAzZ7e9Wt1oasYJG96Qv4MFgAgv4/tkeNkBHt+lBmjJDW5FeahfTyMHc0bX7q
         fxYFhGujOXjNp+KdlXve3sbojLKfFyfOwArI7UeuIRQOZMrziZvCuRB2lkB2aDXGQ2W5
         5Xxhx2WB94ACrPMV9+nrZAPGgQK5uhl/9GVZ8OZXcT7+lJS+qlEyndJNY32eSw/4wcqK
         U+NQ==
X-Gm-Message-State: AOJu0YzImz6Pwx2RmL0YCjLNWTeO/GRO7TG4o0ToMWpFtlMuTF3Ut29h
	a/XuMxs21gqzXSVaIEhRKFl+/taBLIjG+0c+M6NAJqjbC0RH5ZM9JUyphRNOJA==
X-Gm-Gg: ASbGnct10I0dDBAuipkp4VKeCHJuE9cPvmDJVrkGmEzKnbmpVGztMaDx21GjVNGTaUY
	2j9hRxnNq5FH46vvmaZflrWMq1iye2Re1BoZgSQwLwZ91VaVUbNQNLK7H8XxiJByIQoFMbgo6t7
	sJRyZW6v32YF+AGzu84zc8Jxm5sNv2fPjAb0LXoo+lw2yPjKo3/rLC2or5nn/5HjhhSf/gwgLOK
	GwwUlKy2vxCFgBrMulfl2bej5ljhoTxWiCuEYpJRXiLrpG+nC7em1gN2JoLy1d/qoU5pybkQwg0
	C/b8pqsAeRW1w0YeeDi3UNSBJhxO3cpnN0nbdd5NekcF8fUEc2gBfOp5zkYbIGtmT5tqnU1n7/5
	pB2DL/RbVF7VP5lwY+9iTk3JMGmQOuoN/tA==
X-Google-Smtp-Source: AGHT+IGqZ1UuXBgtew/1VHJXYFexFH8qPRWQ510BbbEk+aL+DIan6qsrzF0AkXhZOtAArxLozhFJdQ==
X-Received: by 2002:a05:600c:450b:b0:43d:563:6fef with SMTP id 5b1f17b1804b1-4562e373e21mr218588995e9.21.1753197795350;
        Tue, 22 Jul 2025 08:23:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca25678sm13562794f8f.12.2025.07.22.08.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 08:23:14 -0700 (PDT)
Message-Id: <bda42aa85cf4f332ef60aca1a8937ed4b868fa87.1753197791.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1943.git.1753197791.gitgitgadget@gmail.com>
References: <pull.1943.git.1753197791.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 22 Jul 2025 15:23:08 +0000
Subject: [PATCH 3/6] t6423: document two bugs with rename-to-self testcases
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

When commit 98a1a00d5301 (t6423: add a testcase causing a failed
assertion in process_renames, 2025-03-06) was added, I tweaked
the commit message, and moved the test into t6423.  However, that
still left two other things missing that made this test unlike the
others in the same testfile:

  * It didn't have an English description of the test setup like
    all other tests in t6423

  * It didn't check that the right number of files were present at
    the end

The former issue is a minor detail that isn't that critical, but the
latter feels more important.  If it had been done, I might have noticed
another bug.  In particular, this testcase involves
   Side A: rename world -> tools/world
and
   Side B: rename tools/ -> <the toplevel>
   Side B: remove world
The tools/ -> <toplevel> rename turns the world -> tools/world rename
into world -> world, i.e. a rename-to-self case.  But, it's a path
conflict because merge.directoryRenames defaults to false.  There's
no content conflict because Side A didn't modify world, so we should
just take the content of world from Side B -- i.e. delete it.  So, we
have a conflict on the path, but not on its content.  We could consider
letting the content trump since it is unconflicted, but if we are going
to leave a conflict, it should certainly represent that 'world' existed
both in the base version and on Side A.  Currently it doesn't.

Add a description of this test, add some checking of the number of
entries in the index at the end of the merge, and mark the test as
expecting to fail for now.  A subsequent commit will fix this bug.

While at it, I found another related bug from a nearly identical setup
but setting merge.directoryRenames=true.  Copy testcase 12n into 12n2,
changing it to use merge instead of cherry-pick, and turn on directory
renames for this test.  In this case, since there is no content conflict
and no path conflict, it should be okay to delete the file.
Unfortunately, the code resolves without conflict but silently leaves
world despite the fact it should be deleted.  It might also be okay if
the code spuriously thought there was a modify/delete conflict here;
that would at least notify users to look closer and then when they
notice there was no change since the base version, they can easily
resolve.  A conflict notice is much better than silently providing the
wrong resolution.  Cover this with the 12n2 testcase, which for now is
marked as expecting to fail as well.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6423-merge-rename-directories.sh | 101 +++++++++++++++++++++++++++-
 1 file changed, 99 insertions(+), 2 deletions(-)

diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index f48ed6d03534..69de7a3b84af 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -5056,6 +5056,25 @@ test_expect_success '12m: Change parent of renamed-dir to symlink on other side'
 	)
 '
 
+# Testcase 12n, Directory rename transitively makes rename back to self
+#
+# (Since this is a cherry-pick instead of merge, the labels are a bit weird.
+#  O, the original commit, is A~1 rather than what branch O points to.)
+#
+#   Commit O:  tools/hello
+#              world
+#   Commit A:  tools/hello
+#              tools/world
+#   Commit B:  hello
+#   In words:
+#     A: world -> tools/world
+#     B: tools/ -> /, i.e. rename all of tools to toplevel directory
+#        delete world
+#
+#   Expected:
+#             CONFLICT (file location): tools/world vs. world
+#
+
 test_setup_12n () {
 	git init 12n &&
 	(
@@ -5084,7 +5103,7 @@ test_setup_12n () {
 	)
 }
 
-test_expect_success '12n: Directory rename transitively makes rename back to self' '
+test_expect_failure '12n: Directory rename transitively makes rename back to self' '
 	test_setup_12n &&
 	(
 		cd 12n &&
@@ -5092,7 +5111,85 @@ test_expect_success '12n: Directory rename transitively makes rename back to sel
 		git checkout -q B^0 &&
 
 		test_must_fail git cherry-pick A^0 >out &&
-		grep "CONFLICT (file location).*should perhaps be moved" out
+		grep "CONFLICT (file location).*should perhaps be moved" out &&
+
+		# Should have 1 entry for hello, and 1 for world
+		test_stdout_line_count = 2 git ls-files -s &&
+		test_stdout_line_count = 1 git ls-files -s hello &&
+		test_stdout_line_count = 2 git ls-files -s world
+	)
+'
+
+# Testcase 12n2, Directory rename transitively makes rename back to self
+#
+#   Commit O:  tools/hello
+#              world
+#   Commit A:  tools/hello
+#              tools/world
+#   Commit B:  hello
+#   In words:
+#     A: world -> tools/world
+#     B: tools/ -> /, i.e. rename all of tools to toplevel directory
+#        delete world
+#
+#   Expected:
+#             CONFLICT (file location): tools/world vs. world
+#
+
+test_setup_12n2 () {
+	git init 12n2 &&
+	(
+		cd 12n2 &&
+
+		mkdir tools &&
+		echo hello >tools/hello &&
+		git add tools/hello &&
+		echo world >world &&
+		git add world &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git switch A &&
+		git mv world tools/world &&
+		git commit -m "Move world into tools/" &&
+
+		git switch B &&
+		git mv tools/hello hello &&
+		git rm world &&
+		git commit -m "Move hello from tools/ to toplevel"
+	)
+}
+
+test_expect_failure '12n2: Directory rename transitively makes rename back to self' '
+	test_setup_12n2 &&
+	(
+		cd 12n2 &&
+
+		git checkout -q B^0 &&
+
+		# NOTE: Since merge.directoryRenames=true, there is no path
+		# conflict for world vs. tools/world; it should end up at
+		# world.  The fact that world was unmodified on side A, means
+		# there was no content conflict; we should just take the
+		# content from side B -- i.e. delete the file.  So merging
+		# could just delete world.
+		#
+		# However, rename-to-self-via-directory-rename is a bit more
+		# challenging.  Relax this test to allow world to be treated
+		# as a modify/delete conflict as well.
+
+		test_might_fail git -c merge.directoryRenames=true merge A^0 >out &&
+
+		# Should have 1 entry for hello, and either 0 or 2 for world
+		test_stdout_line_count = 1 git ls-files -s hello &&
+		test_stdout_line_count != 1 git ls-files -s world &&
+		if test_stdout_line_count != 0 git ls-files -s world
+		then
+			grep "CONFLICT (modify/delete).*world deleted in HEAD" out
+		fi
 	)
 '
 
-- 
gitgitgadget

