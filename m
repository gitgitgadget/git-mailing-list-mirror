Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322822EFDA6
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 17:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773077809; cv=none; b=Aav9kTN09kLqKTRXVGVRw6JqYqf4ldt/efSN0ajOZLxvSmJ/ySLnh1J4sMvbBSIojTmYLjvKjRDVuhdO0y4HgGdivjAqlkjhD71XswvMPPVY7QLmqiwPGQvOWcKkL8Cm31ZTII75VEhNgtVSfm4+/WPd2C0HFG06LVXrmb0A9O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773077809; c=relaxed/simple;
	bh=la4AWZW92cRdWyDM6haGBSZMbaIpOq4Y1dWmZs8fyEU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DMVZDqopiX6pjXwQqY7p7305rWpaSJUQC1MPtG5aqQ6UDnd8FTghkMU3ud3PXooZASdMemIOcRoLBCyKqGq3kONkR2H+u9EAGoDdemZ8iH3fGWnXiav5hWh3DhPRoJPogVup1XNiwDuB3oaCkF/AOB9mv6BG2vKgaiW5p8Nbz94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0iRx6GB; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0iRx6GB"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c7384f5a9cdso2118777a12.0
        for <git@vger.kernel.org>; Mon, 09 Mar 2026 10:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773077807; x=1773682607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nEdOwJ89oUbutPXQHZenzRn5U+8pMtOq0WvKDfWhANI=;
        b=K0iRx6GBAWfwD6Tv2NZmz3Z13UWYbUMGuxma39YRqBQcoO1RIPgSogGa7k79tD96qr
         imB3gs0bn/YugtgwkyubkfxZku/7nPBDGkI18tFFZOsdfO83/kiO7XnzxSKesLCxDCX8
         a2oW2ZxXR70a1zWavMaHku0S6hpthN0Y5nB9PQP6SVGsIDyd6Hg552D+HRcfQnXE5klA
         XyrE5aDGv9GAOPvcSi6yjaQVm/iJ/Yd9uBYsy0B0oHRZQKRgNY2PTU90UAL655+LVfqi
         gbSec34WK7gNteRJSRUs0Uk5pxw5AsYAbBrEEPXX5uOeeoNrlDBZaa4eRWIqTcNJZf/5
         nalw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773077807; x=1773682607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nEdOwJ89oUbutPXQHZenzRn5U+8pMtOq0WvKDfWhANI=;
        b=UKQTb1uSl7Bpjrn8yzlor6PTpZnw0P2r5fZ5Dp5ON2DoQPQXp5seLB463eCbcr1W+S
         WxufT0mBCbpB7WZA81PMKhYuTp7TcTUSHE1VcMz+oPRJNoUigDSyz5q0cH9xW/0PFWEi
         +IGH4u6hEhU6P+HCvGqgZnE7UduMfj5u8L61QdC5yvuxYnlxwFaEkkQTfbW7qe93woq5
         OlsJpWYZZH4gaArqKThZ8qeYQo9nEEz+XX92WnwkmVJMVbGlROE1ZpzEFOr0lr0fOP/Y
         pHO4UvvnCbE1WiFnhOYpC2k7W4eI6q9Fqnh75vAO8PXrHJRE27VRqx8q3ZY0KO/rhWtF
         mnbA==
X-Gm-Message-State: AOJu0YxTW+8PGoMTWbm26I5A8SzNMqCorrR6QvJTrZsJ9X7ykrMptGZU
	Zz2fhvIhSVvNG/u7wrkRBOMuaQYg+wU8UTBmUkXn6eg2DwtFSeqziiqHOZ6+aQ==
X-Gm-Gg: ATEYQzw/tB2g0pHs+vsAU3+0JjTMwvBHw+vZFRkPzZBNaKDoc0vhefHy2nPh1pJm7VF
	1RKtBV9ExK7QXrWct+CqcZtZIBvIh2OgapRlk9eygBVHxm8hom0GUnAWMneSisTbxGvFn+ysHPy
	5lKfezyfm+WslVt7C8lsdcfzwQsCGvo8clVUTa0FVGRjYQEEWm7kxzqZ+39CgGIOyvQkaIzjX/l
	p7V+R2w6jTxkqhzq82bfYatgISjrOl5yZIomPfd4+Ke+g7XQDGxjMHbaRwHSegbIKXYORVqVgh/
	K+arUNi8scYNdv97/3FwA4gs4cmoM9jJDU7sCwaj56rf5FmNtnBu8gvGk2b7jcgXfFIWZMMnKWw
	EfbEPEimU6bUtrcbS/n88kG0EomtUVu+YKRZHh3JXyJ/bW//d3AIjVA1tiADEO+Rb6XF979vqN2
	/GZb4c/LZPc0uu2F0hOoyReIUF3swTrUDsad0zbiA8Xwz4JHLibILb+RXZGqNGie9apiyFFi0=
X-Received: by 2002:a17:902:e552:b0:2a0:fe9f:1884 with SMTP id d9443c01a7336-2ae8249e5ecmr110743555ad.55.1773077806809;
        Mon, 09 Mar 2026 10:36:46 -0700 (PDT)
Received: from localhost.localdomain ([115.244.141.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83fb3cc3sm118674805ad.73.2026.03.09.10.36.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Mar 2026 10:36:46 -0700 (PDT)
From: PRASHANT S BISHT <prashantjee2025@gmail.com>
To: git@vger.kernel.org
Cc: PRASHANT S BISHT <prashantjee2025@gmail.com>
Subject: [PATCH] t0004: replace test -e with test_path_exists
Date: Mon,  9 Mar 2026 23:06:35 +0530
Message-ID: <20260309173635.29683-1-prashantjee2025@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace old-style path existence checks with the modern test_path_exists
helper function that provides clearer diagnostic messages on failure.
When test -e fails, the output gives no indication of what went wrong.

These instances were found using:

  git grep "test -[efd]" t/ | grep -v "if test"

as suggested in the microproject ideas.
---
 t/t0004-unwritable.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t0004-unwritable.sh b/t/t0004-unwritable.sh
index 3bdafbae0f..2a9fc781b6 100755
--- a/t/t0004-unwritable.sh
+++ b/t/t0004-unwritable.sh
@@ -21,7 +21,7 @@ test_expect_success POSIXPERM,SANITY 'write-tree should notice unwritable reposi
 	test_must_fail git write-tree 2>out.write-tree
 '
 
-test_lazy_prereq WRITE_TREE_OUT 'test -e "$TRASH_DIRECTORY"/out.write-tree'
+test_lazy_prereq WRITE_TREE_OUT 'test_path_exists "$TRASH_DIRECTORY/out.write-tree"'
 test_expect_success WRITE_TREE_OUT 'write-tree output on unwritable repository' '
 	cat >expect <<-\EOF &&
 	error: insufficient permission for adding an object to repository database .git/objects
@@ -36,7 +36,7 @@ test_expect_success POSIXPERM,SANITY 'commit should notice unwritable repository
 	test_must_fail git commit -m second 2>out.commit
 '
 
-test_lazy_prereq COMMIT_OUT 'test -e "$TRASH_DIRECTORY"/out.commit'
+test_lazy_prereq COMMIT_OUT 'test_path_exists "$TRASH_DIRECTORY/out.commit"'
 test_expect_success COMMIT_OUT 'commit output on unwritable repository' '
 	cat >expect <<-\EOF &&
 	error: insufficient permission for adding an object to repository database .git/objects
@@ -52,7 +52,7 @@ test_expect_success POSIXPERM,SANITY 'update-index should notice unwritable repo
 	test_must_fail git update-index file 2>out.update-index
 '
 
-test_lazy_prereq UPDATE_INDEX_OUT 'test -e "$TRASH_DIRECTORY"/out.update-index'
+test_lazy_prereq UPDATE_INDEX_OUT 'test_path_exists "$TRASH_DIRECTORY/out.update-index"'
 test_expect_success UPDATE_INDEX_OUT 'update-index output on unwritable repository' '
 	cat >expect <<-\EOF &&
 	error: insufficient permission for adding an object to repository database .git/objects
@@ -69,7 +69,7 @@ test_expect_success POSIXPERM,SANITY 'add should notice unwritable repository' '
 	test_must_fail git add file 2>out.add
 '
 
-test_lazy_prereq ADD_OUT 'test -e "$TRASH_DIRECTORY"/out.add'
+test_lazy_prereq ADD_OUT 'test_path_exists "$TRASH_DIRECTORY/out.add"'
 test_expect_success ADD_OUT 'add output on unwritable repository' '
 	cat >expect <<-\EOF &&
 	error: insufficient permission for adding an object to repository database .git/objects
-- 
2.50.1 (Apple Git-155)

