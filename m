Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19AB6FC3
	for <git@vger.kernel.org>; Sun,  8 Feb 2026 20:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770582533; cv=none; b=FT+7Oq3S/dgztT5Ey5+1k+v4q1W7EAU7C87603YBOrppDI4qrCGByrzWh/LKNW3LOO9FELXK80C5fnDZQBPWh/ijpwqSyY4lqnIJpuOeAy1X+bqey8b+BkCXHN3Lean7Ks7mevUG6OIjOZu/caoDWP5jgR5Yk6vTMybQ0Poc1Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770582533; c=relaxed/simple;
	bh=VTjUdduDk7+PSEwsLAlh3YxLmkCPNe06rEezSMQ7HfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J9SQTrBE81jnZcjFiGaDsNd5lAW19WxPQrR2JmqkANNYJvI4clV29JYLLv6YYrnsK/t/Ewgb2dQDFsP+0IAnCywuWiB9tvRasu5Rc0srY4QHcCSkNXf6ZqHkfGTF4fuFYKmL9fxFitMVieIVUvtEXneYxW9pamEP7Oc/Zfs3phM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLtNCmjE; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLtNCmjE"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47fedb7c68dso40319955e9.2
        for <git@vger.kernel.org>; Sun, 08 Feb 2026 12:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770582531; x=1771187331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xwpYOHgOZthReS+6WzbzDTR3GlpXl+3p/hitjIbqp1E=;
        b=CLtNCmjECHhH/Mm2nKOmNVFtyk5QsNvLkttQHaQc2TbQrOnmrs0Ig6TI7MtMYQ5DiN
         E70MKOdH+iqvJesk+ENF9F+Uxc/61Z92uWeySI+hK2qrF9zhk2mYEN2TScpc3zddlSKh
         jK83pYUGksv+mjq5O+Hyodq4Qp8GdTmg9K8e/j4Bc8p3D9BYmYHk6NJKZXJbxCb5EPeQ
         zDM1Yv55TjXBQb3EC36yRBApeW/BCulkwCOyPUMMlpLyxuExG6x58WJ7Rql3zMeSTn9Q
         vVtrn2zuqEtSy/fNVkAkDrvAHW9f8hG0g41vXXD53z0AmrcL05fSdZjtP9dWUmexojW5
         6nOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770582531; x=1771187331;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwpYOHgOZthReS+6WzbzDTR3GlpXl+3p/hitjIbqp1E=;
        b=wjESM9s8ubZR66vG5GLx0ulC/cTEstrLgvyEwYOprWsS+9fTQXH++TotjkKARS4Z2Q
         yR3oUdXA9yqwrm0o9oN/TdBYmW+YQyUeVmYkQHvuajfqsE8TlCPMn7d2KrV/pEYEArA9
         rNdW0a6lph86yQvL5FJYbrUsXY4yAa3QSVhcZlWfqPjxC8BbT5CxlF4Bp6XQcfnPhfu4
         ffTbM2W0zB2j719kcgQCymxX1/ZBada3tfm/p/sUQ84eCfQHWIv86y5Qs0lTaW4DcnLW
         UYt0KJoysDKE8D4G7aYOtnlGh5LHzNElta5eWPhqX0DCMBJ1vUqtXwrlb97Xl5D2QxyE
         /79g==
X-Gm-Message-State: AOJu0YwBuc2+2WxOiDoAToVfloTmBBhGV5TkieowTyM3R4ZCHFDtIcKR
	GNXEFjmtpkeJmjQ2wjzCzbNNezdZZv2RYPIxaevueDcMViGYtI42VFVd036tbw==
X-Gm-Gg: AZuq6aJXm18sNQi8hFaM3+5cg0hwlmuszCGRCiuK+UOQUJFMAGw60obAaSq8hekAUaM
	/ul+uCNpsPEFkkkWr9SgizWRN+acdIus+Bkioz4pC6dmaA0mpyg8v37W5FbmoV95rgCfB1O5M9I
	6r2lbqNoikysICbRMTQ/dwyJusqwWHdckIj/M7nYKMrAhRxt28gT8H0HI98HZyOwRQ1DUlyyxxY
	QTcUqbBW0sc+DFgsXQLcms/5mkwi75x+FJ+W3b0pKzJZYx/7nKzzvsUs52YZDyJ0F/3PNJcyWop
	OJQnVHZ8RjIytJyO5MI09KDAEg6HjETRpifSdIC043ND5O6lgtFGlHcLJNcU0TdVya6239wgHDY
	FRUYV/5Fhf1rE1/nXiapDLtxDLMgJ1BVqPtC5teTjnouknPBHdvlcxZodCjeworaGgjes6MHlFZ
	si1ut4+h2AUxbQRNo=
X-Received: by 2002:a05:600c:314e:b0:47e:e8c2:905f with SMTP id 5b1f17b1804b1-48320928e3fmr127604085e9.8.1770582530565;
        Sun, 08 Feb 2026 12:28:50 -0800 (PST)
Received: from fedora ([159.146.42.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4832097d8dbsm117268895e9.4.2026.02.08.12.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 12:28:49 -0800 (PST)
From: =?UTF-8?q?Burak=20Kaan=20Kara=C3=A7ay?= <bkkaracay@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	gitster@pobox.com,
	=?UTF-8?q?Burak=20Kaan=20Kara=C3=A7ay?= <bkkaracay@gmail.com>
Subject: [GSOC PATCH] t2003: modernize test path helpers
Date: Sun,  8 Feb 2026 23:28:09 +0300
Message-ID: <20260208202809.270523-1-bkkaracay@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The old style 'test -f' and 'test -d' checks are silent on failure,
which makes debugging difficult.

Replace them with the 'test_path_is_*' helpers which provide verbose
error messages when a test fails.

Signed-off-by: Burak Kaan Karaçay <bkkaracay@gmail.com>
---
 t/t2003-checkout-cache-mkdir.sh | 49 ++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/t/t2003-checkout-cache-mkdir.sh b/t/t2003-checkout-cache-mkdir.sh
index ff163cf675..5844389c88 100755
--- a/t/t2003-checkout-cache-mkdir.sh
+++ b/t/t2003-checkout-cache-mkdir.sh
@@ -24,27 +24,27 @@ test_expect_success SYMLINKS 'have symlink in place where dir is expected.' '
 	mkdir path2 &&
 	ln -s path2 path1 &&
 	git checkout-index -f -a &&
-	test ! -h path1 && test -d path1 &&
-	test -f path1/file1 && test ! -f path2/file1
+	test_path_is_dir_not_symlink path1 &&
+	test_path_is_file path1/file1 && test_path_is_missing path2/file1
 '
 
 test_expect_success 'use --prefix=path2/' '
 	rm -fr path0 path1 path2 &&
 	mkdir path2 &&
 	git checkout-index --prefix=path2/ -f -a &&
-	test -f path2/path0 &&
-	test -f path2/path1/file1 &&
-	test ! -f path0 &&
-	test ! -f path1/file1
+	test_path_is_file path2/path0 &&
+	test_path_is_file path2/path1/file1 &&
+	test_path_is_missing path0 &&
+	test_path_is_missing path1/file1
 '
 
 test_expect_success 'use --prefix=tmp-' '
 	rm -fr path0 path1 path2 tmp* &&
 	git checkout-index --prefix=tmp- -f -a &&
-	test -f tmp-path0 &&
-	test -f tmp-path1/file1 &&
-	test ! -f path0 &&
-	test ! -f path1/file1
+	test_path_is_file tmp-path0 &&
+	test_path_is_file tmp-path1/file1 &&
+	test_path_is_missing path0 &&
+	test_path_is_missing path1/file1
 '
 
 test_expect_success 'use --prefix=tmp- but with a conflicting file and dir' '
@@ -52,10 +52,10 @@ test_expect_success 'use --prefix=tmp- but with a conflicting file and dir' '
 	echo nitfol >tmp-path1 &&
 	mkdir tmp-path0 &&
 	git checkout-index --prefix=tmp- -f -a &&
-	test -f tmp-path0 &&
-	test -f tmp-path1/file1 &&
-	test ! -f path0 &&
-	test ! -f path1/file1
+	test_path_is_file tmp-path0 &&
+	test_path_is_file tmp-path1/file1 &&
+	test_path_is_missing path0 &&
+	test_path_is_missing path1/file1
 '
 
 test_expect_success SYMLINKS 'use --prefix=tmp/orary/ where tmp is a symlink' '
@@ -63,10 +63,10 @@ test_expect_success SYMLINKS 'use --prefix=tmp/orary/ where tmp is a symlink' '
 	mkdir tmp1 tmp1/orary &&
 	ln -s tmp1 tmp &&
 	git checkout-index --prefix=tmp/orary/ -f -a &&
-	test -d tmp1/orary &&
-	test -f tmp1/orary/path0 &&
-	test -f tmp1/orary/path1/file1 &&
-	test -h tmp
+	test_path_is_dir tmp1/orary &&
+	test_path_is_file tmp1/orary/path0 &&
+	test_path_is_file tmp1/orary/path1/file1 &&
+	test_path_is_symlink tmp
 '
 
 test_expect_success SYMLINKS 'use --prefix=tmp/orary- where tmp is a symlink' '
@@ -74,9 +74,9 @@ test_expect_success SYMLINKS 'use --prefix=tmp/orary- where tmp is a symlink' '
 	mkdir tmp1 &&
 	ln -s tmp1 tmp &&
 	git checkout-index --prefix=tmp/orary- -f -a &&
-	test -f tmp1/orary-path0 &&
-	test -f tmp1/orary-path1/file1 &&
-	test -h tmp
+	test_path_is_file tmp1/orary-path0 &&
+	test_path_is_file tmp1/orary-path1/file1 &&
+	test_path_is_symlink tmp
 '
 
 test_expect_success SYMLINKS 'use --prefix=tmp- where tmp-path1 is a symlink' '
@@ -84,10 +84,9 @@ test_expect_success SYMLINKS 'use --prefix=tmp- where tmp-path1 is a symlink' '
 	mkdir tmp1 &&
 	ln -s tmp1 tmp-path1 &&
 	git checkout-index --prefix=tmp- -f -a &&
-	test -f tmp-path0 &&
-	test ! -h tmp-path1 &&
-	test -d tmp-path1 &&
-	test -f tmp-path1/file1
+	test_path_is_file tmp-path0 &&
+	test_path_is_dir_not_symlink tmp-path1 &&
+	test_path_is_file tmp-path1/file1
 '
 
 test_expect_success 'apply filter from working tree .gitattributes with --prefix' '
-- 
2.52.0

