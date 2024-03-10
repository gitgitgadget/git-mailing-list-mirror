Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A48200BA
	for <git@vger.kernel.org>; Sun, 10 Mar 2024 11:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710071001; cv=none; b=ogzJTQ+jvOUPXcwOPjzI2rK7CrUGnn2zOiQ5H3OlYSsFv5NkULgbq0d6j0WdXGYcwLMJlUHj072Zmab39es8CFBaR3dX8trhzG6i3zGSd+0zIvMCJmOZIShuC+jJZYPeAr7ZcRFfxNBxbN7FrmITOLSW2xChUh/jmE4aBkEHx/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710071001; c=relaxed/simple;
	bh=zZbAfiAA+Er38iL8Emc9KVFfYhOqp7rxxOpu6SAGA3g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iWT6YAkrqhNDJ1ZNT9XF0YX3FtJy3/oDEsCwZZTElH9o8sBTa/SZmGuoYLcQB0xgBnmNx8fQMTIekvwWHyCqIzaE+eGWuuMog9G7ZW61whQK6VEU67aHX0mS7zaUgIAtdDvYmldnAY4jKImRrp1ka4VUkDl1aEj4eN8qcgp9d58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZzFUXoqz; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzFUXoqz"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5131a9b3d5bso2929608e87.0
        for <git@vger.kernel.org>; Sun, 10 Mar 2024 04:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710070997; x=1710675797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nTiU0SdX1aIVcSwqbteihOMomgZsTMwTs6UMVeHUgSo=;
        b=ZzFUXoqznXTuylqkxK7e3oXuVaVgHIGrNRKFdqbZuR12DtnqKpi7aYGeqog0Y2JKP+
         RaWibv/9CejnwxGAGfKodkfaOtO04AGE43FU1pXs0ZMiuEB6SLzL5uASGniUPYz3R8UR
         TUXdyUafoUsFHl9sDjjLfqRvJZbHChpBM2DUYu5AC6tw9trIxLqeFZqtWGCj2r6BwAAx
         zRD0SFNtkI4uDhWFYWa6D5zRI0Bk8Dz05fkp9XegEucD6sW/qb0r1Drz08guQb4VjfwJ
         RRZZiHiQXWovY+J/KaTDHfJju3MeE2x+dcGkQ4ojkxTsa3agf/PsSHN1DDOYI8kz64+L
         shCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710070997; x=1710675797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nTiU0SdX1aIVcSwqbteihOMomgZsTMwTs6UMVeHUgSo=;
        b=aXuvIIPqRH4HclX7MuxzwoxSg7odgCm92flPiOJGgdtzS0+eAJ1Ys8B4Rrd2zP5U5j
         JqBJSv8y3XDU3e0rVuv74G/+i+vA7jVnu3mUId+wacHlq1Z25o1Oq/sE+/EjzqM5gvsI
         GXgzpXf/NMZGMPOdNNFB20OeGC3mwE3iGsG4OVgACrzeNBa4F4n4x97xWXKMeGCYyUp9
         +1w/EJVZoTHS8EIuFCBu3l6okk/dMJlGXqdSsdLPmdUf/lrgXvwyNvkkrAiIKTT0hA/r
         xhrch3H+I7a8ZlkQ7cgPo7XRgelVfs0cRZ9IWMmvren0tms4dXakn4HW/3YFiFT3FV0M
         39Sw==
X-Gm-Message-State: AOJu0YzDBdphh/ksQU+YVx2am42chTAiSrkiIJFiB50Tj5e1qAKzvihi
	60zkN0kOiWTRUtsC1l823dspm7LeygPGPKCItnliyVrr/f8c2Qj8
X-Google-Smtp-Source: AGHT+IGZOxhSnhiBsDxHuhCrXc8MrpQ/aX3MNwYmhR/WEBU82LmQJCbfBqoytUUIkswqyeGbhSaitQ==
X-Received: by 2002:a19:3848:0:b0:513:1a38:2406 with SMTP id d8-20020a193848000000b005131a382406mr2212021lfj.13.1710070996608;
        Sun, 10 Mar 2024 04:43:16 -0700 (PDT)
Received: from sacco-Inspiron-5559.. (88-160-103-158.subs.proxad.net. [88.160.103.158])
        by smtp.gmail.com with ESMTPSA id dx7-20020a0565122c0700b0051321139817sm643995lfb.47.2024.03.10.04.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 04:43:16 -0700 (PDT)
From: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
Subject: [GSOC][PATCH v4 1/1] t7301: use test_path_is_(missing|file)
Date: Sun, 10 Mar 2024 12:43:11 +0100
Message-Id: <20240310114311.598681-2-vincenzo.mezzela@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240310114311.598681-1-vincenzo.mezzela@gmail.com>
References: <20240304171732.64457-1-vincenzo.mezzela@gmail.com>
 <20240310114311.598681-1-vincenzo.mezzela@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace use of 'test -f' with 'test_path_is_file' helper functions from
test-lib-functions.sh. These functions perform identical operations
while enhancing debugging capabilities in case of test failures.

In the context of this file, 'test ! -f' is meant to check if the file
has been correctly cleaned, so it should be 'test ! -e'.
Thus its usage is replaced with 'test_path_is_missing' instead of 
'! test_path_is_file'.

Signed-off-by: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
---
 t/t7301-clean-interactive.sh | 490 +++++++++++++++++------------------
 1 file changed, 245 insertions(+), 245 deletions(-)

diff --git a/t/t7301-clean-interactive.sh b/t/t7301-clean-interactive.sh
index d82a3210a1..4afe53c66a 100755
--- a/t/t7301-clean-interactive.sh
+++ b/t/t7301-clean-interactive.sh
@@ -25,18 +25,18 @@ test_expect_success 'git clean -i (c: clean hotkey)' '
 	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
 	docs/manual.txt obj.o build/lib.so &&
 	echo c | git clean -i &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test ! -f a.out &&
-	test -f docs/manual.txt &&
-	test ! -f src/part3.c &&
-	test ! -f src/part3.h &&
-	test ! -f src/part4.c &&
-	test ! -f src/part4.h &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_missing a.out &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_missing src/part3.c &&
+	test_path_is_missing src/part3.h &&
+	test_path_is_missing src/part4.c &&
+	test_path_is_missing src/part4.h &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -46,18 +46,18 @@ test_expect_success 'git clean -i (cl: clean prefix)' '
 	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
 	docs/manual.txt obj.o build/lib.so &&
 	echo cl | git clean -i &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test ! -f a.out &&
-	test -f docs/manual.txt &&
-	test ! -f src/part3.c &&
-	test ! -f src/part3.h &&
-	test ! -f src/part4.c &&
-	test ! -f src/part4.h &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_missing a.out &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_missing src/part3.c &&
+	test_path_is_missing src/part3.h &&
+	test_path_is_missing src/part4.c &&
+	test_path_is_missing src/part4.h &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -67,18 +67,18 @@ test_expect_success 'git clean -i (quit)' '
 	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
 	docs/manual.txt obj.o build/lib.so &&
 	echo quit | git clean -i &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test -f a.out &&
-	test -f docs/manual.txt &&
-	test -f src/part3.c &&
-	test -f src/part3.h &&
-	test -f src/part4.c &&
-	test -f src/part4.h &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_file a.out &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_file src/part3.c &&
+	test_path_is_file src/part3.h &&
+	test_path_is_file src/part4.c &&
+	test_path_is_file src/part4.h &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -88,18 +88,18 @@ test_expect_success 'git clean -i (Ctrl+D)' '
 	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
 	docs/manual.txt obj.o build/lib.so &&
 	echo "\04" | git clean -i &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test -f a.out &&
-	test -f docs/manual.txt &&
-	test -f src/part3.c &&
-	test -f src/part3.h &&
-	test -f src/part4.c &&
-	test -f src/part4.h &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_file a.out &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_file src/part3.c &&
+	test_path_is_file src/part3.h &&
+	test_path_is_file src/part4.c &&
+	test_path_is_file src/part4.h &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -110,18 +110,18 @@ test_expect_success 'git clean -id (filter all)' '
 	docs/manual.txt obj.o build/lib.so &&
 	test_write_lines f "*" "" c |
 	git clean -id &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test -f a.out &&
-	test -f docs/manual.txt &&
-	test -f src/part3.c &&
-	test -f src/part3.h &&
-	test -f src/part4.c &&
-	test -f src/part4.h &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_file a.out &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_file src/part3.c &&
+	test_path_is_file src/part3.h &&
+	test_path_is_file src/part4.c &&
+	test_path_is_file src/part4.h &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -132,18 +132,18 @@ test_expect_success 'git clean -id (filter patterns)' '
 	docs/manual.txt obj.o build/lib.so &&
 	test_write_lines f "part3.* *.out" "" c |
 	git clean -id &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test -f a.out &&
-	test ! -f docs/manual.txt &&
-	test -f src/part3.c &&
-	test -f src/part3.h &&
-	test ! -f src/part4.c &&
-	test ! -f src/part4.h &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_file a.out &&
+	test_path_is_missing docs/manual.txt &&
+	test_path_is_file src/part3.c &&
+	test_path_is_file src/part3.h &&
+	test_path_is_missing src/part4.c &&
+	test_path_is_missing src/part4.h &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -154,18 +154,18 @@ test_expect_success 'git clean -id (filter patterns 2)' '
 	docs/manual.txt obj.o build/lib.so &&
 	test_write_lines f "* !*.out" "" c |
 	git clean -id &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test ! -f a.out &&
-	test -f docs/manual.txt &&
-	test -f src/part3.c &&
-	test -f src/part3.h &&
-	test -f src/part4.c &&
-	test -f src/part4.h &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_missing a.out &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_file src/part3.c &&
+	test_path_is_file src/part3.h &&
+	test_path_is_file src/part4.c &&
+	test_path_is_file src/part4.h &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -176,18 +176,18 @@ test_expect_success 'git clean -id (select - all)' '
 	docs/manual.txt obj.o build/lib.so &&
 	test_write_lines s "*" "" c |
 	git clean -id &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test ! -f a.out &&
-	test ! -f docs/manual.txt &&
-	test ! -f src/part3.c &&
-	test ! -f src/part3.h &&
-	test ! -f src/part4.c &&
-	test ! -f src/part4.h &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_missing a.out &&
+	test_path_is_missing docs/manual.txt &&
+	test_path_is_missing src/part3.c &&
+	test_path_is_missing src/part3.h &&
+	test_path_is_missing src/part4.c &&
+	test_path_is_missing src/part4.h &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -198,18 +198,18 @@ test_expect_success 'git clean -id (select - none)' '
 	docs/manual.txt obj.o build/lib.so &&
 	test_write_lines s "" c |
 	git clean -id &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test -f a.out &&
-	test -f docs/manual.txt &&
-	test -f src/part3.c &&
-	test -f src/part3.h &&
-	test -f src/part4.c &&
-	test -f src/part4.h &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_file a.out &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_file src/part3.c &&
+	test_path_is_file src/part3.h &&
+	test_path_is_file src/part4.c &&
+	test_path_is_file src/part4.h &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -220,18 +220,18 @@ test_expect_success 'git clean -id (select - number)' '
 	docs/manual.txt obj.o build/lib.so &&
 	test_write_lines s 3 "" c |
 	git clean -id &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test -f a.out &&
-	test -f docs/manual.txt &&
-	test ! -f src/part3.c &&
-	test -f src/part3.h &&
-	test -f src/part4.c &&
-	test -f src/part4.h &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_file a.out &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_missing src/part3.c &&
+	test_path_is_file src/part3.h &&
+	test_path_is_file src/part4.c &&
+	test_path_is_file src/part4.h &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -242,18 +242,18 @@ test_expect_success 'git clean -id (select - number 2)' '
 	docs/manual.txt obj.o build/lib.so &&
 	test_write_lines s "2 3" 5 "" c |
 	git clean -id &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test -f a.out &&
-	test ! -f docs/manual.txt &&
-	test ! -f src/part3.c &&
-	test -f src/part3.h &&
-	test ! -f src/part4.c &&
-	test -f src/part4.h &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_file a.out &&
+	test_path_is_missing docs/manual.txt &&
+	test_path_is_missing src/part3.c &&
+	test_path_is_file src/part3.h &&
+	test_path_is_missing src/part4.c &&
+	test_path_is_file src/part4.h &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -264,18 +264,18 @@ test_expect_success 'git clean -id (select - number 3)' '
 	docs/manual.txt obj.o build/lib.so &&
 	test_write_lines s "3,4 5" "" c |
 	git clean -id &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test -f a.out &&
-	test -f docs/manual.txt &&
-	test ! -f src/part3.c &&
-	test ! -f src/part3.h &&
-	test ! -f src/part4.c &&
-	test -f src/part4.h &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_file a.out &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_missing src/part3.c &&
+	test_path_is_missing src/part3.h &&
+	test_path_is_missing src/part4.c &&
+	test_path_is_file src/part4.h &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -285,11 +285,11 @@ test_expect_success 'git clean -id (select - filenames)' '
 	touch a.out foo.txt bar.txt baz.txt &&
 	test_write_lines s "a.out fo ba bar" "" c |
 	git clean -id &&
-	test -f Makefile &&
-	test ! -f a.out &&
-	test ! -f foo.txt &&
-	test ! -f bar.txt &&
-	test -f baz.txt &&
+	test_path_is_file Makefile &&
+	test_path_is_missing a.out &&
+	test_path_is_missing foo.txt &&
+	test_path_is_missing bar.txt &&
+	test_path_is_file baz.txt &&
 	rm baz.txt
 
 '
@@ -301,18 +301,18 @@ test_expect_success 'git clean -id (select - range)' '
 	docs/manual.txt obj.o build/lib.so &&
 	test_write_lines s "1,3-4" 2 "" c |
 	git clean -id &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test ! -f a.out &&
-	test ! -f src/part3.c &&
-	test ! -f src/part3.h &&
-	test -f src/part4.c &&
-	test -f src/part4.h &&
-	test ! -f docs/manual.txt &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_missing a.out &&
+	test_path_is_missing src/part3.c &&
+	test_path_is_missing src/part3.h &&
+	test_path_is_file src/part4.c &&
+	test_path_is_file src/part4.h &&
+	test_path_is_missing docs/manual.txt &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -323,18 +323,18 @@ test_expect_success 'git clean -id (select - range 2)' '
 	docs/manual.txt obj.o build/lib.so &&
 	test_write_lines s "4- 1" "" c |
 	git clean -id &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test ! -f a.out &&
-	test -f docs/manual.txt &&
-	test -f src/part3.c &&
-	test ! -f src/part3.h &&
-	test ! -f src/part4.c &&
-	test ! -f src/part4.h &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_missing a.out &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_file src/part3.c &&
+	test_path_is_missing src/part3.h &&
+	test_path_is_missing src/part4.c &&
+	test_path_is_missing src/part4.h &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -345,18 +345,18 @@ test_expect_success 'git clean -id (inverse select)' '
 	docs/manual.txt obj.o build/lib.so &&
 	test_write_lines s "*" "-5- 1 -2" "" c |
 	git clean -id &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test ! -f a.out &&
-	test -f docs/manual.txt &&
-	test ! -f src/part3.c &&
-	test ! -f src/part3.h &&
-	test -f src/part4.c &&
-	test -f src/part4.h &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_missing a.out &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_missing src/part3.c &&
+	test_path_is_missing src/part3.h &&
+	test_path_is_file src/part4.c &&
+	test_path_is_file src/part4.h &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -367,18 +367,18 @@ test_expect_success 'git clean -id (ask)' '
 	docs/manual.txt obj.o build/lib.so &&
 	test_write_lines a Y y no yes bad "" |
 	git clean -id &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test ! -f a.out &&
-	test ! -f docs/manual.txt &&
-	test -f src/part3.c &&
-	test ! -f src/part3.h &&
-	test -f src/part4.c &&
-	test -f src/part4.h &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_missing a.out &&
+	test_path_is_missing docs/manual.txt &&
+	test_path_is_file src/part3.c &&
+	test_path_is_missing src/part3.h &&
+	test_path_is_file src/part4.c &&
+	test_path_is_file src/part4.h &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -389,18 +389,18 @@ test_expect_success 'git clean -id (ask - Ctrl+D)' '
 	docs/manual.txt obj.o build/lib.so &&
 	test_write_lines a Y no yes "\04" |
 	git clean -id &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test ! -f a.out &&
-	test -f docs/manual.txt &&
-	test ! -f src/part3.c &&
-	test -f src/part3.h &&
-	test -f src/part4.c &&
-	test -f src/part4.h &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_missing a.out &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_missing src/part3.c &&
+	test_path_is_file src/part3.h &&
+	test_path_is_file src/part4.c &&
+	test_path_is_file src/part4.h &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -412,18 +412,18 @@ test_expect_success 'git clean -id with prefix and path (filter)' '
 	(cd build/ &&
 	 test_write_lines f docs "*.h" "" c |
 	 git clean -id ..) &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test ! -f a.out &&
-	test -f docs/manual.txt &&
-	test ! -f src/part3.c &&
-	test -f src/part3.h &&
-	test ! -f src/part4.c &&
-	test -f src/part4.h &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_missing a.out &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_missing src/part3.c &&
+	test_path_is_file src/part3.h &&
+	test_path_is_missing src/part4.c &&
+	test_path_is_file src/part4.h &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -435,18 +435,18 @@ test_expect_success 'git clean -id with prefix and path (select by name)' '
 	(cd build/ &&
 	 test_write_lines s ../docs/ ../src/part3.c ../src/part4.c "" c |
 	 git clean -id ..) &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test -f a.out &&
-	test ! -f docs/manual.txt &&
-	test ! -f src/part3.c &&
-	test -f src/part3.h &&
-	test ! -f src/part4.c &&
-	test -f src/part4.h &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_file a.out &&
+	test_path_is_missing docs/manual.txt &&
+	test_path_is_missing src/part3.c &&
+	test_path_is_file src/part3.h &&
+	test_path_is_missing src/part4.c &&
+	test_path_is_file src/part4.h &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -458,18 +458,18 @@ test_expect_success 'git clean -id with prefix and path (ask)' '
 	(cd build/ &&
 	 test_write_lines a Y y no yes bad "" |
 	 git clean -id ..) &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test ! -f a.out &&
-	test ! -f docs/manual.txt &&
-	test -f src/part3.c &&
-	test ! -f src/part3.h &&
-	test -f src/part4.c &&
-	test -f src/part4.h &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_missing a.out &&
+	test_path_is_missing docs/manual.txt &&
+	test_path_is_file src/part3.c &&
+	test_path_is_missing src/part3.h &&
+	test_path_is_file src/part4.c &&
+	test_path_is_file src/part4.h &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
-- 
2.34.1

