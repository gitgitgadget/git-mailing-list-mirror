Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2225D38A710
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 13:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774704605; cv=none; b=l/kWE7Pr3QJ3hc7LelmWwMGe5vlUtRU32gyVLI6d/ihEIbsgpcEXt0iPxvf2cDQvUefUTFUAnzuSlcfKBZF6Dzdin34970fmkvAX1/qk5cdN4R0bAa93fdpqCiiwP9qaRNvcS5yq6VtM4fdWX6BE76T89G5+Q8CkinZgVYwKLIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774704605; c=relaxed/simple;
	bh=UnoEh6LCWG/cUSx30sstY+fs5r76fRy/JGC0eNYEVIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BLARXtEtSUfsiDVCNMY9izRCNCCHzDYsKXfdtG1IDkjQQZdSh9Czhm19xjNghMpjxITXu0kTfkr3xxGj8p1rdybLk3pUrJ3Ca/AndN/kKhWaVYNZoknJZis3YgS8wLp02M1GVMK+Z87Ru5ZGDQjyJLiBHs4ve9qxXPRkSCGVvqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFWxCkw6; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFWxCkw6"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82a07738118so1783159b3a.0
        for <git@vger.kernel.org>; Sat, 28 Mar 2026 06:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774704603; x=1775309403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6yuIqcenYNScRBvglIHSathNmQAUn1qH2RQdSPFHb0Q=;
        b=LFWxCkw65YtxjWFjqy7Bl3QSd3cUh8AIC0PHTHp0bGmTJqLRT7tHMMFHLEsAvDfgvb
         oC4rNur5V92JLIngoOzTAIODZC+WDVzltofWU4depCZkjI29dMPK+Edv4YLvlThlgKZf
         i1iB92hbaIii2dA12jceUSpe2AWhe/8/hJdOG3xIA+QmGAThy/D1vOE44mbvOj2TSwML
         UkyDjq4ZFjv2RCnp82eFp2RpFsezPWtd3b/oR3qLwe/UqsykSPD2a+DgBRY5YpsZg8Z3
         6E7nhjMUWGXl/ZXZSwUCHK+FilZfEt4YO5WiCPXj9rfO5N+5SaeQykYoQHfmKt/id6Sn
         r1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774704603; x=1775309403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6yuIqcenYNScRBvglIHSathNmQAUn1qH2RQdSPFHb0Q=;
        b=nwc1LxgRu60aW13Nfn/1NOe52nIoNmCpVeyAQqIh8dhlIjcz+JUgQWV9xLugS8J8F6
         JmF+1/JIbv9VvogF1/8lAyOA4Urw+uNwy0DjKdJM6vubDxcJljh6cGegvcUmcLFPe0N/
         +lKRCH7iMJpgaaLY7vBOpltpg/hkQ8b+U3VUHMchCJerC/c7BF06+KP9TpC/OfL4bMXj
         cdZEQ8thvOf+IVs3shBCiBqSU5Oi5K2T5WXO2FJUa6dJMyd96ttdJTx93ju6bBEvz/CN
         /vdmZZDgFgL5A63uRuqWX8/tokDqsfU3vVZNJnpCchNTx5ZIEOS9wl9Y4zMjbC46ST8z
         oXYQ==
X-Gm-Message-State: AOJu0YxX5GhNub2SWYIqOXoW0JhOI2SUw+xvKTojRYhMdfsGY23Hj7/D
	rZ7OVtAidp47XtubCsiQf1eVmVIvUaInorPjPN3b1ViiJDqU6yGJ5uuCqBK8S7Up
X-Gm-Gg: ATEYQzxDuvMWNWhMs4OUpeHH6GPztTFcweujYZKjwlAQlHJoalbyMeHlw4RQYfpkF/O
	pXi7dBM8acHAi0CHYI4TjDj/rfRhDL1S3p7EGXng8eM3wPe4mIpLxlznx7KrD0wIpsN2NpTnOOa
	Bzs66kpmNz5H6z1uymT8COXxJGuehflEXANvj37z8yzZPXkUsI6dS3Yy3VOSzC51qnOnA0lRzEs
	SXPA1oDlpOrjuZrKbz2Te7847oImEt9rU5vRaQP9aKa0SI8IkG1HP1sa1lj3/HkJPjWRNo1u/mX
	fWVUCVwzGH1yg86Ly4ZMR/zWOpw4zcj90UHQqnIaLUayNrGH5XBhRoZNvPw7UwffNoXNyzLAULf
	FhhTij7FFx4eq7zRYUTGwU+Q1rLRIVqAhAmi4KNFKKGcEWFPSsNeD882xL8/zy+33RKev60eY8p
	COjTfldWtx8bIWbqlf/wcmDV8VI3ZQJaCMh6n2cHHOSf82lyMfGUZQY6O/XbMAFaqcN9PqIVOFS
	Zlzczd+UQ==
X-Received: by 2002:a05:6a00:138e:b0:82c:6e58:b069 with SMTP id d2e1a72fcca58-82c95e58b84mr5872566b3a.8.1774704602905;
        Sat, 28 Mar 2026 06:30:02 -0700 (PDT)
Received: from trieu2-huynh-trieuhpn-ubuntu24.bee-live.svc.cluster.local ([27.122.242.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca843bf3csm2208791b3a.11.2026.03.28.06.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 06:30:02 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
To: git@vger.kernel.org
Cc: Trieu Huynh <vikingtc4@gmail.com>
Subject: [GSoC PATCH 1/2] t8003: avoid suppressing git's exit code
Date: Sat, 28 Mar 2026 22:29:54 +0900
Message-ID: <20260328132955.172262-1-vikingtc4@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update t8003-blame-corner-cases.sh to redirect git-blame output
to a temporary file instead of piping it directly to not hide
the exit code of git commands behind pipes, as a crash in git
might go unnoticed.

Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
 t/t8003-blame-corner-cases.sh | 48 ++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
index 731265541a..17ed5af121 100755
--- a/t/t8003-blame-corner-cases.sh
+++ b/t/t8003-blame-corner-cases.sh
@@ -50,67 +50,78 @@ test_expect_success setup '
 
 test_expect_success 'straight copy without -C' '
 
-	git blame uno | grep Second
+	git blame uno >actual &&
+	test_grep Second actual
 
 '
 
 test_expect_success 'straight move without -C' '
 
-	git blame dos | grep Initial
+	git blame dos >actual &&
+	test_grep Initial actual
 
 '
 
 test_expect_success 'straight copy with -C' '
 
-	git blame -C1 uno | grep Second
+	git blame -C1 uno >actual &&
+	test_grep Second actual
 
 '
 
 test_expect_success 'straight move with -C' '
 
-	git blame -C1 dos | grep Initial
+	git blame -C1 dos >actual &&
+	test_grep Initial actual
 
 '
 
 test_expect_success 'straight copy with -C -C' '
 
-	git blame -C -C1 uno | grep Initial
+	git blame -C -C1 uno >actual &&
+	test_grep Initial actual
 
 '
 
 test_expect_success 'straight move with -C -C' '
 
-	git blame -C -C1 dos | grep Initial
+	git blame -C -C1 dos >actual &&
+	test_grep Initial actual
 
 '
 
 test_expect_success 'append without -C' '
 
-	git blame -L2 tres | grep Second
+	git blame -L2 tres >actual &&
+	test_grep Second actual
 
 '
 
 test_expect_success 'append with -C' '
 
-	git blame -L2 -C1 tres | grep Second
+	git blame -L2 -C1 tres >actual &&
+	test_grep Second actual
 
 '
 
 test_expect_success 'append with -C -C' '
 
-	git blame -L2 -C -C1 tres | grep Second
+	git blame -L2 -C -C1 tres >actual &&
+	test_grep Second actual
 
 '
 
 test_expect_success 'append with -C -C -C' '
 
-	git blame -L2 -C -C -C1 tres | grep Initial
+	git blame -L2 -C -C -C1 tres >actual &&
+	test_grep Initial actual
 
 '
 
 test_expect_success 'blame wholesale copy' '
 
-	git blame -f -C -C1 HEAD^ -- cow | sed -e "$pick_fc" >current &&
+	git blame -f -C -C1 HEAD^ -- cow >actual &&
+	sed -e "$pick_fc" actual >current &&
 	cat >expected <<-\EOF &&
 	mouse-Initial
 	mouse-Second
@@ -122,7 +133,8 @@ test_expect_success 'blame wholesale copy' '
 
 test_expect_success 'blame wholesale copy and more' '
 
-	git blame -f -C -C1 HEAD -- cow | sed -e "$pick_fc" >current &&
+	git blame -f -C -C1 HEAD -- cow >actual &&
+	sed -e "$pick_fc" actual >current &&
 	cat >expected <<-\EOF &&
 	mouse-Initial
 	mouse-Second
@@ -144,7 +156,8 @@ test_expect_success 'blame wholesale copy and more in the index' '
 	EOF
 	git add horse &&
 	test_when_finished "git rm -f horse" &&
-	git blame -f -C -C1 -- horse | sed -e "$pick_fc" >current &&
+	git blame -f -C -C1 -- horse >actual &&
+	sed -e "$pick_fc" actual >current &&
 	cat >expected <<-\EOF &&
 	mouse-Initial
 	mouse-Second
@@ -168,7 +181,8 @@ test_expect_success 'blame during cherry-pick with file rename conflict' '
 	(git cherry-pick HEAD@{1} || test $? -eq 1) &&
 	git show HEAD@{1}:rodent > rodent &&
 	git add rodent &&
-	git blame -f -C -C1 rodent | sed -e "$pick_fc" >current &&
+	git blame -f -C -C1 rodent >actual &&
+	sed -e "$pick_fc" actual >current &&
 	cat >expected <<-\EOF &&
 	mouse-Initial
 	mouse-Second
@@ -246,14 +260,14 @@ test_expect_success 'setup file with CRLF newlines' '
 test_expect_success 'blame file with CRLF core.autocrlf true' '
 	git config core.autocrlf true &&
 	git blame crlffile >actual &&
-	grep "A U Thor" actual
+	test_grep "A U Thor" actual
 '
 
 test_expect_success 'blame file with CRLF attributes text' '
 	git config core.autocrlf false &&
 	echo "crlffile text" >.gitattributes &&
 	git blame crlffile >actual &&
-	grep "A U Thor" actual
+	test_grep "A U Thor" actual
 '
 
 test_expect_success 'blame file with CRLF core.autocrlf=true' '
@@ -267,7 +281,7 @@ test_expect_success 'blame file with CRLF core.autocrlf=true' '
 	git checkout crlfinrepo &&
 	rm tmp &&
 	git blame crlfinrepo >actual &&
-	grep "A U Thor" actual
+	test_grep "A U Thor" actual
 '
 
 test_expect_success 'setup coalesce tests' '
-- 
2.43.0

