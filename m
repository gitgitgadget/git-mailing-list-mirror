Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B651BD9C9
	for <git@vger.kernel.org>; Sat,  7 Mar 2026 01:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772845349; cv=none; b=ZWV6T+E+ZDcm1RwaYyk265kah0spMpXGsKBqUz2fGG+iGZivm10/u1tBX8E8/KSMEtmv5P/Nq2PmBr1+cMe3WKZKrcKXUEt3J5mhTzTGXiZfSElpwldnDhJW4kmdd/J162wGOIwmILKnBZ6qfjcp2yByUCGczLldW6Top+YjZqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772845349; c=relaxed/simple;
	bh=YZUJc3DWVVch6WMbcTsGvCPRX9fFHIPBDD8a1uDX8Lo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dUR767Xsi5St2MNdM+rXGasrFKMa1iQdZqOutux3g5VydUNIFhh/Lg93EbSBF1YCU5vVTYQrDw5wEwMw6WTWIwSqWFH8k1L8Q93B6Vg8bkS6phB2Q4dlD3pvpZjW9p5Rd7ZJ8HxLllaCCcAZdZLhvanQPd9ODn5Q1HN3joIiKrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVcWnis3; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVcWnis3"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-4043b27ddeaso3467790fac.1
        for <git@vger.kernel.org>; Fri, 06 Mar 2026 17:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772845347; x=1773450147; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QnrDac9NRz8uyOSsFUKj8/fVY97JGNlBUkGVF0FF1gY=;
        b=ZVcWnis3UeI5/16grrgHslW2DSHKMLarANjes0yPOC3fWI5QMQ+14czB25SihbDE0Q
         CSPpRQBu11Y9Fdtl4DkddT2JPJJbxs13IXPuAJYX5WihsmYo68YxRwoVEOQxAJjMnmY2
         bPKq06RuXVVyct/SSel+n4wLZGuPU7te34g3/5PxKWYCzKyYgAsBzphhfMwg53O7pGjb
         AV2rjAzwwZEHQzttuViVMIhqyZGo68fZvRWRczsCOeAtJYs59HkPtTheM//3nnGzGvpf
         IVn0tqytJWbs4Jdj9ktQ8OidCJAjFS9cL2oJa2Xz7IISqP2fjITrAnUTxAy9pkLeTgHY
         r5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772845347; x=1773450147;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QnrDac9NRz8uyOSsFUKj8/fVY97JGNlBUkGVF0FF1gY=;
        b=kXsYdo2kT8cewMSl5hgXrj+t9HicbKTYtuo3kzMeRW7G2DAbsQGtJr/KSYMIl0SG50
         fLnhFs1162rh/YCkhSVnZamInK6Kw3iaBC/XggBwG3nbGJbICAC7ZeuT00fQancWRzY9
         /19VgopsfT4ZQlLgetsubRtCtLVhz+Ok34qmyYGilcpoTjivouc8OYfjeR8+B45aR0cV
         sGJh7zH6Cd3sgBXL1XRz7acouPSuN2FtNbCJWExOxjLC/+/+LNTtEroEyOt/YI/d8E+V
         A1IqLtStTOZmG1HdMlfJ2PNLe5Cgv4K2f96jPegf+A9EaW0e8Ij54wElLR1zBALkYI4g
         IyKg==
X-Gm-Message-State: AOJu0Yzujei1E4DuiRoKP+5glUAQ/e01z6tIwDl1u/5lWYDi+66NTPSc
	eDCcC2ugx0H0GivR4zvvKhcelbMMrqTwg+ABq3aH8fX67W2B9oIYSJk0QdG9BQ==
X-Gm-Gg: ATEYQzwFibBNb8WEPOZoufOnbxcGhB+uIJ+uV2rK8/hr4CY5Q7H6afk2BiD8ZLnPmxU
	ThxyWlKgwIqYmssU6eNbAp0NMOL0ozda3vfQ0nGBtB6F4xdQs1Y0xRD2X+6fODN2Elbpn7otSiP
	qN6GV9vnvKFJ8T0vsi1CC705I4PRgDWkCILPeTpEJernsOEQe7xJ/HLw3LuPGo9wslBKVT62Uzo
	br7pTOFXvN0pOXM/JqB1UBzQqKKlrG/6OiSu7HyydpFm3lYJsTufq06EGivDXM4JKRhJWJU/Mkx
	03vmB8l4jRxg/VFYdJ35rUuFRt49uKsIRT5Vu6uXtklIfsPphDJuXEl41hQDPMENiIMzCIaeVxd
	C0pywc+VK1j3e8/4H3GgCbbzyabclwV3hoKWyC3vHWXk/+LvMxm7GGve86nL33oLaBqw8F9PmzG
	fl9UQ3Mias0c49dmBP5/AjFYhDB9I=
X-Received: by 2002:a05:6870:e182:b0:40a:65ee:d307 with SMTP id 586e51a60fabf-416e44a20cdmr2641323fac.26.1772845346689;
        Fri, 06 Mar 2026 17:02:26 -0800 (PST)
Received: from [127.0.0.1] ([172.212.169.147])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-416e65b1cacsm2893748fac.8.2026.03.06.17.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 17:02:26 -0800 (PST)
Message-Id: <09e00d3f82ae2a05bd7069cbde0d98400238d78e.1772845338.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2065.git.1772845338.gitgitgadget@gmail.com>
References: <pull.2065.git.1772845338.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 07 Mar 2026 01:02:17 +0000
Subject: [PATCH 3/4] t4211: add tests for -L with standard diff options
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
Cc: Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

Now that -L output flows through the standard diff pipeline, verify
that previously-ignored diff options work: formatting (--word-diff,
--word-diff-regex, --no-prefix, --src/dst-prefix, --full-index,
--abbrev), whitespace handling (-w, -b), output indicators
(--output-indicator-new/old/context), direction reversal (-R),
--color-moved, and pickaxe options (-S, -G).

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 t/t4211-line-log.sh | 281 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 281 insertions(+)

diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 01f7ec8c32..b7f68be490 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -339,6 +339,92 @@ test_expect_success 'zero-width regex .* matches any function name' '
 	test_cmp expect actual
 '
 
+test_expect_success 'setup for diff pipeline tests' '
+	git checkout parent-oids &&
+
+	head_blob_old=$(git rev-parse --short HEAD^:file.c) &&
+	head_blob_new=$(git rev-parse --short HEAD:file.c) &&
+	root_blob=$(git rev-parse --short HEAD~4:file.c) &&
+	null_blob=$(test_oid zero | cut -c1-7) &&
+	head_blob_old_full=$(git rev-parse HEAD^:file.c) &&
+	head_blob_new_full=$(git rev-parse HEAD:file.c) &&
+	root_blob_full=$(git rev-parse HEAD~4:file.c) &&
+	null_blob_full=$(test_oid zero)
+'
+
+test_expect_success '-L diff output includes index and new file mode' '
+	git log -L:func2:file.c --format= >actual &&
+
+	# Output should contain index headers (not present in old code path)
+	grep "^index $head_blob_old\.\.$head_blob_new 100644" actual &&
+
+	# Root commit should show new file mode and null index
+	grep "^new file mode 100644" actual &&
+	grep "^index $null_blob\.\.$root_blob$" actual &&
+
+	# Hunk headers should include funcname context
+	grep "^@@ .* @@ int func1()" actual
+'
+
+test_expect_success '-L with --word-diff' '
+	cat >expect <<-\EOF &&
+
+	diff --git a/file.c b/file.c
+	--- a/file.c
+	+++ b/file.c
+	@@ -6,4 +6,4 @@ int func1()
+	int func2()
+	{
+	    return [-F2;-]{+F2 + 2;+}
+	}
+
+	diff --git a/file.c b/file.c
+	new file mode 100644
+	--- /dev/null
+	+++ b/file.c
+	@@ -0,0 +6,4 @@
+	{+int func2()+}
+	{+{+}
+	{+    return F2;+}
+	{+}+}
+	EOF
+	git log -L:func2:file.c --word-diff --format= >actual &&
+	grep -v "^index " actual >actual.filtered &&
+	grep -v "^index " expect >expect.filtered &&
+	test_cmp expect.filtered actual.filtered
+'
+
+test_expect_success '-L with --no-prefix' '
+	git log -L:func2:file.c --no-prefix --format= >actual &&
+	grep "^diff --git file.c file.c" actual &&
+	grep "^--- file.c" actual &&
+	! grep "^--- a/" actual
+'
+
+test_expect_success '-L with --full-index' '
+	git log -L:func2:file.c --full-index --format= >actual &&
+	grep "^index $head_blob_old_full\.\.$head_blob_new_full 100644" actual &&
+	grep "^index $null_blob_full\.\.$root_blob_full$" actual
+'
+
+test_expect_success 'setup -L with whitespace change' '
+	git checkout -b ws-change parent-oids &&
+	sed "s/    return F2 + 2;/	return F2 + 2;/" file.c >tmp &&
+	mv tmp file.c &&
+	git commit -a -m "Whitespace change in func2()"
+'
+
+test_expect_success '-L with --ignore-all-space suppresses whitespace-only diff' '
+	git log -L:func2:file.c --format= >without_w &&
+	git log -L:func2:file.c --format= -w >with_w &&
+
+	# Without -w: three commits produce diffs (whitespace, modify, root)
+	test $(grep -c "^diff --git" without_w) = 3 &&
+
+	# With -w: whitespace-only commit produces no hunk, so only two diffs
+	test $(grep -c "^diff --git" with_w) = 2
+'
+
 test_expect_success 'show line-log with graph' '
 	git checkout parent-oids &&
 	head_blob_old=$(git rev-parse --short HEAD^:file.c) &&
@@ -424,4 +510,199 @@ test_expect_failure '-L --find-object should filter commits by object' '
 	test_must_be_empty actual
 '
 
+test_expect_success '-L with --word-diff-regex' '
+	git checkout parent-oids &&
+	git log -L:func2:file.c --word-diff \
+		--word-diff-regex="[a-zA-Z0-9_]+" --format= >actual &&
+	# Word-diff markers must be present
+	grep "{+" actual &&
+	grep "+}" actual &&
+	# No line-level +/- markers (word-diff replaces them);
+	# exclude --- header lines from the check
+	! grep "^+[^+]" actual &&
+	! grep "^-[^-]" actual
+'
+
+test_expect_success '-L with --src-prefix and --dst-prefix' '
+	git checkout parent-oids &&
+	git log -L:func2:file.c --src-prefix=old/ --dst-prefix=new/ \
+		--format= >actual &&
+	grep "^diff --git old/file.c new/file.c" actual &&
+	grep "^--- old/file.c" actual &&
+	grep "^+++ new/file.c" actual &&
+	! grep "^--- a/" actual
+'
+
+test_expect_success '-L with --abbrev' '
+	git checkout parent-oids &&
+	git log -L:func2:file.c --abbrev=4 --format= -1 >actual &&
+	# 4-char abbreviated hashes on index line
+	grep "^index [0-9a-f]\{4\}\.\.[0-9a-f]\{4\}" actual
+'
+
+test_expect_success '-L with -b suppresses whitespace-only diff' '
+	git checkout ws-change &&
+	git log -L:func2:file.c --format= >without_b &&
+	git log -L:func2:file.c --format= -b >with_b &&
+	test $(grep -c "^diff --git" without_b) = 3 &&
+	test $(grep -c "^diff --git" with_b) = 2
+'
+
+test_expect_success '-L with --output-indicator-*' '
+	git checkout parent-oids &&
+	git log -L:func2:file.c --output-indicator-new=">" \
+		--output-indicator-old="<" --output-indicator-context="|" \
+		--format= -1 >actual &&
+	grep "^>" actual &&
+	grep "^<" actual &&
+	grep "^|" actual &&
+	# No standard +/-/space content markers; exclude ---/+++ headers
+	! grep "^+[^+]" actual &&
+	! grep "^-[^-]" actual &&
+	! grep "^ " actual
+'
+
+test_expect_success '-L with -R reverses diff' '
+	git checkout parent-oids &&
+	git log -L:func2:file.c -R --format= -1 >actual &&
+	grep "^diff --git b/file.c a/file.c" actual &&
+	grep "^--- b/file.c" actual &&
+	grep "^+++ a/file.c" actual &&
+	# The modification added "F2 + 2", so reversed it is removed
+	grep "^-.*F2 + 2" actual &&
+	grep "^+.*return F2;" actual
+'
+
+test_expect_success 'setup for color-moved test' '
+	git checkout -b color-moved-test parent-oids &&
+	cat >big.c <<-\EOF &&
+	int bigfunc()
+	{
+	    int a = 1;
+	    int b = 2;
+	    int c = 3;
+	    return a + b + c;
+	}
+	EOF
+	git add big.c &&
+	git commit -m "add bigfunc" &&
+	sed "s/    /	/" big.c >tmp && mv tmp big.c &&
+	git commit -a -m "reindent bigfunc"
+'
+
+test_expect_success '-L with --color-moved' '
+	git log -L:bigfunc:big.c --color-moved=zebra \
+		--color-moved-ws=ignore-all-space \
+		--color=always --format= -1 >actual.raw &&
+	test_decode_color <actual.raw >actual &&
+	# Old moved lines: bold magenta; new moved lines: bold cyan
+	grep "BOLD;MAGENTA" actual &&
+	grep "BOLD;CYAN" actual
+'
+
+test_expect_success 'setup for no-newline-at-eof tests' '
+	git checkout --orphan no-newline &&
+	git reset --hard &&
+	printf "int top()\n{\n    return 1;\n}\n\nint bot()\n{\n    return 2;\n}" >noeol.c &&
+	git add noeol.c &&
+	test_tick &&
+	git commit -m "add noeol.c (no trailing newline)" &&
+	sed "s/return 2/return 22/" noeol.c >tmp && mv tmp noeol.c &&
+	git commit -a -m "modify bot()" &&
+	printf "int top()\n{\n    return 1;\n}\n\nint bot()\n{\n    return 33;\n}\n" >noeol.c &&
+	git commit -a -m "modify bot() and add trailing newline"
+'
+
+# When the tracked function is at the end of a file with no trailing
+# newline, the "\ No newline at end of file" marker should appear.
+test_expect_success '-L no-newline-at-eof appears in tracked range' '
+	git log -L:bot:noeol.c --format= -1 HEAD~1 >actual &&
+	grep "No newline at end of file" actual
+'
+
+# When tracking a function that ends before the no-newline content,
+# the marker should not appear in the output.
+test_expect_success '-L no-newline-at-eof suppressed outside range' '
+	git log -L:top:noeol.c --format= >actual &&
+	! grep "No newline at end of file" actual
+'
+
+# When a commit removes a no-newline last line and replaces it with
+# a newline-terminated line, the marker should still appear (on the
+# old side of the diff).
+test_expect_success '-L no-newline-at-eof marker with deleted line' '
+	git log -L:bot:noeol.c --format= -1 >actual &&
+	grep "No newline at end of file" actual
+'
+
+test_expect_success 'setup for range boundary deletion test' '
+	git checkout --orphan range-boundary &&
+	git reset --hard &&
+	cat >boundary.c <<-\EOF &&
+	void above()
+	{
+	    return;
+	}
+
+	void tracked()
+	{
+	    int x = 1;
+	    int y = 2;
+	}
+
+	void below()
+	{
+	    return;
+	}
+	EOF
+	git add boundary.c &&
+	test_tick &&
+	git commit -m "add boundary.c" &&
+	cat >boundary.c <<-\EOF &&
+	void above()
+	{
+	    return;
+	}
+
+	void tracked()
+	{
+	    int x = 1;
+	    int y = 2;
+	}
+
+	void below_renamed()
+	{
+	    return 0;
+	}
+	EOF
+	git commit -a -m "modify below() only"
+'
+
+# When only a function below the tracked range is modified, the
+# tracked function should not produce a diff.
+test_expect_success '-L suppresses deletions outside tracked range' '
+	git log -L:tracked:boundary.c --format= >actual &&
+	test $(grep -c "^diff --git" actual) = 1
+'
+
+test_expect_success '-L with -S filters to string-count changes' '
+	git checkout parent-oids &&
+	git log -L:func2:file.c -S "F2 + 2" --format= >actual &&
+	# -S searches the whole file, not just the tracked range;
+	# combined with the -L range walk, this selects commits that
+	# both touch func2 and change the count of "F2 + 2" in the file.
+	test $(grep -c "^diff --git" actual) = 1 &&
+	grep "F2 + 2" actual
+'
+
+test_expect_success '-L with -G filters to diff-text matches' '
+	git checkout parent-oids &&
+	git log -L:func2:file.c -G "F2 [+] 2" --format= >actual &&
+	# -G greps the whole-file diff text, not just the tracked range;
+	# combined with -L, this selects commits that both touch func2
+	# and have "F2 + 2" in their diff.
+	test $(grep -c "^diff --git" actual) = 1 &&
+	grep "F2 + 2" actual
+'
+
 test_done
-- 
gitgitgadget

