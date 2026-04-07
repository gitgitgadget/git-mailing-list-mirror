Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CF222F77B
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 03:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775533499; cv=none; b=pDW7zwqaUQQ50S04BUsPqjC4X6DsSdbduvUfisYVu7WwbCglfpTxk8yNNbdW+CJMronJFvvdBfgMbD0yYTG6MKjxecLXrUwE/+AjtkUkbMm/PDbpZzryPhwuxqmlbwdg625v2p7cATnHwTugyNgiHiJJt9DA5W1NYtfHhHajsEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775533499; c=relaxed/simple;
	bh=4ZiKZ+5gF86qaSW5D7UfdvCxmddC0OBXflStq9b+KjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FhrCUO6mwPcCoDVk7L9VneDmLR2cb5vy8+L/WpeafXUQVMWIpfXqPZnDn0hhREWejwHKspTRn6pmwnsbWd3h4BRoirsiO3TEZjLr6iUJaCLMMpjfEPRm6sKs+1fq6nrPevi0URZKD+pYyWnYMwrqBUX3pj6FmdF6wsPIibHKayU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qLsFZTnK; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qLsFZTnK"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso24329395e9.3
        for <git@vger.kernel.org>; Mon, 06 Apr 2026 20:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775533496; x=1776138296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XV1kbzpbc8aK8K/BAhjEC5AiuYrbmPa8jkt0SlCILz0=;
        b=qLsFZTnKoXrU81OvtTOeUP4PwfmkHmkiIbyKeeSRhRWsFnZ8dzCDOvz6GaiIdyLHoY
         5z2Mv+orFB5w4E+ZVqNtArEScUWazW5dZ3aRCgJpC5li5vAktW+/wd7uSYi3N5NSczr9
         1YiRt1CQAdFST5xmFDtLYoxxMtROEJz7Ee1B+A6h049oF4Xhlt7agtE4d51s7BmoWU2O
         CuRV3uSm+aJ718GTOkqXA8uItO91JMOdmGZAJdtAOPkNy52MR1Y9Zp20BquHUf6i91GZ
         +4vLEMxfidQr4kAv6k94dNEPkGKGR11/E0C5UnvMujVZH6Q/cHlUW01m7O7QPyY8v1jV
         JgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775533496; x=1776138296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XV1kbzpbc8aK8K/BAhjEC5AiuYrbmPa8jkt0SlCILz0=;
        b=XzKen3/e3NNXI9sDl5O1VTMP/XftEoyvpJcYZ0wZf2r6aDBXfN/CBsJALqkLPB0JnM
         OcEekMfmtekCOuZ++y4OaDvDe8/7mEpO7+X0AyUSdNWuxBU5XUDrEe4L0jRDGeuQoSlG
         VJu2OqAPMyopDvNDDwINWLgTEzcj55zo3namwG9KCcP/OPY2V4BjNgPM7ncevTQbnYeT
         4cdwSIE0iicxMRMy2o4HAalLlFM919CRofHSgcFZ1AwpAoP2yMlvHUiVt8UwnxkTwjqu
         3figjCZuxNhCcuaEkO9RsNBgxazBMU8j3DODd1mvGxShwtceAehRPfK22w/g3CkeyMyg
         YQhg==
X-Gm-Message-State: AOJu0Yw3NbJWX9FhCWT+7RtD3xyT2V2mflu+evNg1CdZSrhDrQ/t/oGM
	2OumtnP9TQaV8yFv+bId5bUG0IVsqPJqDfnaU0xmfKZn2qYgpXS4iSQGPol9+wjAR9ATky60
X-Gm-Gg: AeBDieuzJw/hGPD5yIOERWMdVn5Ii1wothhvdwdG04vsyXobfzbA1SeBxGvFy/y30q2
	km/exh6ZdtoRGEW7xJYDsbqWqxR4u4m7LOFfUiZzrdL9JF9MwwdwW2qwX1zjtxNJQuvAW2QEMGR
	GeGJBM/PtKJWnW9a3ftNetGiR2ROmsgN0h58heWnHUWTcvewQOy7nhuXpgGShqoqNoeJc3371oB
	7xp2UABLCvG7zsMVbEzFWDg5iRfmcdXPfUjMbQtYDtAWtfkv8uNQiN5QaFCza9Wd3gXZvKJ6urx
	MI47EcKuY8eJ9dDoaT4gENGKfkZNHbDJwsmzlM/ICe+Md0QZZE0PTrkh2++i9WdJ1z3EOvM9P+W
	v186kVLtFeMFAQJ9Q00hPlRzNmKp1t4+hJq44IXSAA6xCV3XXIwYa8z4pySDDt8INBbTxLDp1RR
	7YsleTb1ls5Mz2RhwTHtPeBWYbr2w0jwCxrioHs0zHqKKCO4KuwF8Z0fcdqMBbH/i1XOZCFBXLf
	WWnXEYXW2RhHXI=
X-Received: by 2002:a05:600c:8719:b0:488:b811:51c4 with SMTP id 5b1f17b1804b1-488b8115360mr45838645e9.25.1775533496045;
        Mon, 06 Apr 2026 20:44:56 -0700 (PDT)
Received: from alibaba.. ([98.97.76.198])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488983db4fbsm108725305e9.13.2026.04.06.20.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 20:44:54 -0700 (PDT)
From: Zakariyah Ali <zakariyahali100@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	gitster@pobox.com,
	Zakariyah Ali <zakariyahali100@gmail.com>,
	Tian Yuchen <cat@malon.dev>
Subject: [PATCH v5] t2000: modernize overall structure and path checks
Date: Tue,  7 Apr 2026 04:44:46 +0100
Message-ID: <20260407034446.409175-1-zakariyahali100@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260405011135.125912-1-zakariyahali100@gmail.com>
References: <20260405011135.125912-1-zakariyahali100@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test script that dates back to 2005 certainly shows its age and
both its style and the way the tests are laid out do not match the
modern standard. Modernize it to match the current testing standards:

  * Executables that prepare the data used to test the command should
    be inside the test_expect_success block in modern tests.

  * In modern tests, running a command that is being tested, making
    sure it succeeds, and inspecting other side effects that are
    expected, are all done in a single test_expect_success block.

  * A test_expect_success block in modern tests are laid out as

         test_expect_success 'title of the test' '
                 body of the test &&
                 ...
                 body of the test
         '

    not as

         test_expect_success \
                 'title of the test' \
                 'body of the test &&
                 ...
                 body of the test'

    which is in a prehistoric style.

  * In modern tests, each &&-chained statement in the body of the
    test_expect_success block are indented with a horizontal tab,
    unlike prehistoric style that used 4-space indent.

  * Replace bare 'test -f/-d' and 'test ! -h' assertions with dedicated
    test_path_is_* helpers (specifically test_path_is_file_not_symlink and
    test_path_is_dir_not_symlink). While less commonly used in the test
    suite than test_path_is_file/dir, they act as direct replacements
    for the specific checks being performed and provide clearer
    diagnostics on failure.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Karthik Nayak <karthik.188@gmail.com>
Helped-by: Tian Yuchen <cat@malon.dev>
Signed-off-by: Zakariyah Ali <zakariyahali100@gmail.com>
---
 t/t2000-conflict-when-checking-files-out.sh | 88 +++++++--------------
 1 file changed, 30 insertions(+), 58 deletions(-)

diff --git a/t/t2000-conflict-when-checking-files-out.sh b/t/t2000-conflict-when-checking-files-out.sh
index f18616ad2b..44728329f3 100755
--- a/t/t2000-conflict-when-checking-files-out.sh
+++ b/t/t2000-conflict-when-checking-files-out.sh
@@ -48,17 +48,16 @@ mkdir path0
 date >path0/file0
 date >path1
 
-test_expect_success \
-    'git checkout-index without -f should fail on conflicting work tree.' \
-    'test_must_fail git checkout-index -a'
-
-test_expect_success \
-    'git checkout-index with -f should succeed.' \
-    'git checkout-index -f -a'
+test_expect_success 'git checkout-index without -f should fail on conflicting work tree.' '
+	test_must_fail git checkout-index -a
+'
 
-test_expect_success \
-    'git checkout-index conflicting paths.' \
-    'test -f path0 && test -d path1 && test -f path1/file1'
+test_expect_success 'git checkout-index with -f should succeed.' '
+	git checkout-index -f -a &&
+	test_path_is_file path0 &&
+	test_path_is_dir path1 &&
+	test_path_is_file path1/file1
+'
 
 test_expect_success SYMLINKS 'checkout-index -f twice with --prefix' '
 	mkdir -p tar/get &&
@@ -83,53 +82,26 @@ test_expect_success SYMLINKS 'checkout-index -f twice with --prefix' '
 # path path3 is occupied by a non-directory.  With "-f" it should remove
 # the symlink path3 and create directory path3 and file path3/file1.
 
-mkdir path2
-date >path2/file0
-test_expect_success \
-    'git update-index --add path2/file0' \
-    'git update-index --add path2/file0'
-test_expect_success \
-    'writing tree out with git write-tree' \
-    'tree1=$(git write-tree)'
-test_debug 'show_files $tree1'
-
-mkdir path3
-date >path3/file1
-test_expect_success \
-    'git update-index --add path3/file1' \
-    'git update-index --add path3/file1'
-test_expect_success \
-    'writing tree out with git write-tree' \
-    'tree2=$(git write-tree)'
-test_debug 'show_files $tree2'
-
-rm -fr path3
-test_expect_success \
-    'read previously written tree and checkout.' \
-    'git read-tree -m $tree1 && git checkout-index -f -a'
-test_debug 'show_files $tree1'
-
-test_expect_success \
-    'add a symlink' \
-    'test_ln_s_add path2 path3'
-test_expect_success \
-    'writing tree out with git write-tree' \
-    'tree3=$(git write-tree)'
-test_debug 'show_files $tree3'
-
-# Morten says "Got that?" here.
-# Test begins.
-
-test_expect_success \
-    'read previously written tree and checkout.' \
-    'git read-tree $tree2 && git checkout-index -f -a'
-test_debug 'show_files $tree2'
-
-test_expect_success \
-    'checking out conflicting path with -f' \
-    'test ! -h path2 && test -d path2 &&
-     test ! -h path3 && test -d path3 &&
-     test ! -h path2/file0 && test -f path2/file0 &&
-     test ! -h path3/file1 && test -f path3/file1'
+test_expect_success 'checkout-index -f resolves symlink conflict on leading path' '
+	mkdir path2 &&
+	date >path2/file0 &&
+	git update-index --add path2/file0 &&
+	tree1=$(git write-tree) &&
+	mkdir path3 &&
+	date >path3/file1 &&
+	git update-index --add path3/file1 &&
+	tree2=$(git write-tree) &&
+	rm -fr path3 &&
+	git read-tree -m $tree1 &&
+	git checkout-index -f -a &&
+	test_ln_s_add path2 path3 &&
+	tree3=$(git write-tree) &&
+	git read-tree $tree2 &&
+	git checkout-index -f -a &&
+	test_path_is_dir_not_symlink path2 &&
+	test_path_is_dir_not_symlink path3 &&
+	test_path_is_file_not_symlink path2/file0 &&
+	test_path_is_file_not_symlink path3/file1
+'
 
 test_done
-- 
2.43.0

