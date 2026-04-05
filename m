Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B0EB663
	for <git@vger.kernel.org>; Sun,  5 Apr 2026 01:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775351519; cv=none; b=C7OLvugsJkLS4SvHtlPG8zJ3/0HdOWL+Y8jeWv55Q/c/OKf0ISPc6RXLTxux+fsOxJfOes4+0bXimKpgpFzmahSzyYGU/YXNl7pbnlmyQEgm0ehxHaGExN06fNiwbKLkaV64Jtb/SG1NOwIW4XaRN/TdLG6XCwNk5JOt1LT4D9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775351519; c=relaxed/simple;
	bh=LQJ6Ls5AzKfkLRGTq4T0AXzuVt3Ja7v3udICTDQs36g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQwierHYwwYvpHkryX6riGbQ6EgC6CHdfZ0cwrXvC5G0sKpsq6KhNNpnYL4DvYvnUnHtG/4HM6cMxfnGVE6iziM6GR+CGAsQMx0vvIc64wAzc6DJLY1gu6aA8v5J2/d00K9efhiD4tR2BtXK795tJPVh04G3DRha4t0drjAYLXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fi3RoH2m; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fi3RoH2m"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35da2d35eccso1862323a91.0
        for <git@vger.kernel.org>; Sat, 04 Apr 2026 18:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775351517; x=1775956317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BYBcvb/sq4SntZMq9/LF6fqXxJudkurnnm6KQSGTyIY=;
        b=fi3RoH2mcsuPfGzPgc79X85gmvRnmmjycYuxPcCPoGdVshOpkeei/4xCplzPhsWZDD
         oMC8yUjtXeTtleG1HkLVkyMhA9F1AhvzDeZbxxQ3YWbU1rOi11AbRm3rKpUwdIKPHxGS
         pAb5fQ3Pyudy3Xu/zand4+VKCvpfmf0EuIOEO/Hw3tTppfCzJojaVxVpfn0iqI8yokzk
         vyUqIXWBUGWVK0IkyY98WCbH+ea+jzmxGiTOxN2ELEU23vaCOPQypssizvQTuNIZztqp
         jcs6aSS3c9kVcEbCS2Yq0fLyUWvybv6BEmq24bfF8Dzt69CguX6VnUw8Eww//BLWKcq/
         4cGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775351517; x=1775956317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BYBcvb/sq4SntZMq9/LF6fqXxJudkurnnm6KQSGTyIY=;
        b=EcTcF/NQdXzqmAygKVvCx4e4vdDrhelTXhVSRpnWJdicdB4a+fSffNCfadMrDjsx29
         goLxAhPQSH80evPXg0tCBDT64oQiG6h6AY/EsVquoiSvR7vdJDEwlfWX01kOj6wywygt
         Fqebfn5ZYX/TuoZwU+8G1hq52wGVxGHVdt/C8G41FZi0DHby8+WPD55QV1Q34hxTRbWf
         uFh2Y7M8W8tCpVRPxC8f0PhTlV0MIcaFrgJHphnSi/ALgGYX5ZoX3lBhX3E3MF5HbLc9
         ovS7ynjLsLuMxvyvkgftQOWq9k7Pc9yzFf18aq7unCs3fE1pyCivr81X8VZvIGtKlQPP
         Pqvw==
X-Gm-Message-State: AOJu0YxBrOeIQEY6SPCEh7vSCOV5wdwfnlc0syHPUTClvhNawTZ22gCT
	NCof1s77QM2pj7vlYtVYcXRiGtrSNDZbDAC4WLscAgfhumljSQJHGryqHZShRxR1qQQ=
X-Gm-Gg: AeBDiesZndDiXzH4Zvt+1IE86l4YxvqbsSxW+d8jwS/+osYSXcqMZB9ZLIBHPlaiOIk
	r7hvWYFhWOtKwh4nXDnZV9SHutJfB1EdpNrO0wMO0u+PEzwQ9/hrYiPXYVzBAsqQcEY6Ucw7M8n
	Vs2HV20C/Kj/atxXWgwAb+PX02BdyHb+arFvpvQCb2Vt3Y66fX6xvqiOUR0ByB5cOBBoJ3a7rzl
	YlZzVC/T/jocStqGwBWM6swYxRdMg0cXt9iZAXiZG3SGq2ZItBBSMdzT94XuAHhGQDskrIHZl2f
	WdhFdmSjSPYyFrrO348IIwxcsDt26Zmn4Valgv0Lq6p5UioSVnc7H+SspRRl+ynZ2U8WMkLtm12
	iqxY49py6c6t7U6EP/GLVvLZv+0HeSWsv5pY5qVwokfl/0pU8GL2n1IDiNrQaDSbSBAwHmESJRF
	yp61/RvGS3SMkAhEtOb5DyAzPH3YQMxuy7sE+wAXe9WxUnT1AYvljQR1mPiY2/fgLW5Xwq67dUZ
	31wV2x06W3Bxg==
X-Received: by 2002:a17:903:4b07:b0:2b0:5cb4:d89d with SMTP id d9443c01a7336-2b2818b2a90mr80563695ad.29.1775351516981;
        Sat, 04 Apr 2026 18:11:56 -0700 (PDT)
Received: from alibaba.. ([149.40.62.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27475bc2asm101536975ad.19.2026.04.04.18.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 18:11:56 -0700 (PDT)
From: Zakariyah Ali <zakariyahali100@gmail.com>
To: git@vger.kernel.org
Cc: Zakariyah Ali <zakariyahali100@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 1/1] t2000: modernize overall structure and path checks
Date: Sun,  5 Apr 2026 02:11:34 +0100
Message-ID: <20260405011135.125912-1-zakariyahali100@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327234019.95591-1-zakariyahali100@gmail.com>
References: <20260327234019.95591-1-zakariyahali100@gmail.com>
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
Signed-off-by: Zakariyah Ali <zakariyahali100@gmail.com>
---
Hi Yuchen,

Thanks for the review. Regarding test_path_is_file_not_symlink and test_path_is_dir_not_symlink, I used them as direct replacements for the existing pattern: `test ! -h <path> && test -f/-d <path>`. As you noted, they are simple and straightforward. Following your suggestion, I've added a note about them to the commit message in this v4 patch.

I have also added the 'Helped-by' trailer as suggested, since the commit message structure was provided by Junio C Hamano.

Also, a quick question please: since the GSoC proposal period for 2026 has closed, could you guide me on the next steps for applying to subsequent related internships (like Outreachy, if applicable)? I would love to know how I can best continue contributing to Git in the meantime.

Regards,
Zakariyah Ali.

 t/t2000-conflict-when-checking-files-out.sh | 99 +++++++++++----------
 1 file changed, 54 insertions(+), 45 deletions(-)

diff --git a/t/t2000-conflict-when-checking-files-out.sh b/t/t2000-conflict-when-checking-files-out.sh
index f18616ad2b..a8a49df93e 100755
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
@@ -83,53 +82,63 @@ test_expect_success SYMLINKS 'checkout-index -f twice with --prefix' '
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
+test_expect_success 'prepare path2/file0 and index' '
+	mkdir path2 &&
+	date >path2/file0 &&
+	git update-index --add path2/file0
+'
+
+test_expect_success 'write tree with path2/file0' '
+	tree1=$(git write-tree)
+'
+
 test_debug 'show_files $tree1'
 
-mkdir path3
-date >path3/file1
-test_expect_success \
-    'git update-index --add path3/file1' \
-    'git update-index --add path3/file1'
-test_expect_success \
-    'writing tree out with git write-tree' \
-    'tree2=$(git write-tree)'
+test_expect_success 'prepare path3/file1 and index' '
+	mkdir path3 &&
+	date >path3/file1 &&
+	git update-index --add path3/file1
+'
+
+test_expect_success 'write tree with path3/file1' '
+	tree2=$(git write-tree)
+'
+
 test_debug 'show_files $tree2'
 
-rm -fr path3
-test_expect_success \
-    'read previously written tree and checkout.' \
-    'git read-tree -m $tree1 && git checkout-index -f -a'
+test_expect_success 'read previously written tree and checkout.' '
+	rm -fr path3 &&
+	git read-tree -m $tree1 &&
+	git checkout-index -f -a
+'
+
 test_debug 'show_files $tree1'
 
-test_expect_success \
-    'add a symlink' \
-    'test_ln_s_add path2 path3'
-test_expect_success \
-    'writing tree out with git write-tree' \
-    'tree3=$(git write-tree)'
+test_expect_success 'add a symlink' '
+	test_ln_s_add path2 path3
+'
+
+test_expect_success 'write tree with symlink path3' '
+	tree3=$(git write-tree)
+'
+
 test_debug 'show_files $tree3'
 
 # Morten says "Got that?" here.
 # Test begins.
 
-test_expect_success \
-    'read previously written tree and checkout.' \
-    'git read-tree $tree2 && git checkout-index -f -a'
+test_expect_success 'read previously written tree and checkout.' '
+	git read-tree $tree2 &&
+	git checkout-index -f -a
+'
+
 test_debug 'show_files $tree2'
 
-test_expect_success \
-    'checking out conflicting path with -f' \
-    'test ! -h path2 && test -d path2 &&
-     test ! -h path3 && test -d path3 &&
-     test ! -h path2/file0 && test -f path2/file0 &&
-     test ! -h path3/file1 && test -f path3/file1'
+test_expect_success 'checking out conflicting path with -f' '
+	test_path_is_dir_not_symlink path2 &&
+	test_path_is_dir_not_symlink path3 &&
+	test_path_is_file_not_symlink path2/file0 &&
+	test_path_is_file_not_symlink path3/file1
+'
 
 test_done
-- 
2.43.0

