Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD916302154
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 16:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760458508; cv=none; b=eF55o8n5EB7qDu7vcRK1bHdgJPi6vk7I8QOh7YTOJcMV6wiGcpug7LaWWrSr9seln3qkXaM8mc0UlUQztjfjsJpcybJzqL8DES90qkgK7zOWb58nPx7RB1DG2UOkIdcJX6m2FDpDispsSnOj3byogsBWFABwiiRIyYRHi5oZx/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760458508; c=relaxed/simple;
	bh=iCB03mqszEZUYtdqEOQDM/eU8P8TNoGtTFlL5x8eWMI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WKJTnuPzcqzMIC8Gk35paobsI/kKgmsbjyisfinvZv6xVlg3Cu7gzTPYAG6oX9pCyWD8x56tjhg48fiGvISpI5AjiCwIv+JmcFye08mU/xZbsiSRuH7UjeTdGsKIlln2vKJq+C1YtlMhiNd2jkztmlRhq5fZU16OkSCuE808g3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQvE6zDn; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQvE6zDn"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46fc5e54cceso15717105e9.0
        for <git@vger.kernel.org>; Tue, 14 Oct 2025 09:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760458504; x=1761063304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SwNYdkNSv6vyLOTB2aUUWO7XxJ02nMoRPg4ryPfwLO8=;
        b=NQvE6zDn4K0chIp2FPOX2oAHhNAwdnn86AQh4kVX3FPnMNQFpcyD/ruscGQSLPSeY7
         yeRMZwry6S5Yb+zXPTSF9/09ZnKxm3RNF7tEJ89KTIBa89cSBSIQTE9cp9iiKuk3Gls5
         A7gb8IWAqSMggG5SSsjbzXpom+4i+dNzv509t2bzgoGutLnAxz2zOOUdZjAbG54jfpTv
         EwNTDx8o80i/nbh73OyhLK3tBawyUC9dyHxjwKpzrgJCLK8DvYrnBSkrWMG3TNWsGDzg
         C6f/H7ObnuL8vQoIVB9KPE8Nh/43KWEdxShN74FgOwE6+D6l65aHEBQIuR6xvpCCIBjK
         1dVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760458504; x=1761063304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SwNYdkNSv6vyLOTB2aUUWO7XxJ02nMoRPg4ryPfwLO8=;
        b=t7dgbFppTquPLYVWluNB7vkXuHfGBSzA+zK2t6cKjAyqlMeWnTOFKE110Uu6lMLOT4
         /OvfZF+SHaloaCTqYrUPblffTuwZ0ayouqrwms+dH7nCFKGFA753Nij34KDrEIgmAtOd
         uJCf4MvxWq99epjVd7evRH0O9iFVz2LvggLLBYX8vykrHfELQk54EaVWpsFl+gmYA+AM
         Cwxe1Gjadu8YLbCLvlqTH+h/l7eTr4ak/8XH2KZot+8H+IFR5Cvu+DilQNYQON3Ze0AZ
         4oIo1xE/p7qk5TlnxMwpaf8IKCXlGgHyh0iTu+r5oGkaN+MHcuKsJuxIRftxpTiyIvcW
         /wCg==
X-Gm-Message-State: AOJu0YyPI4GnJBr7GEHfZeRHf/XctV+kSJolu5D5R1j1f22GiXb1FdJs
	XgrCYuJ4RPTjMMK50hRw5o1eGHINX37ynRagNFhUXwWy0jhBAEo1QTCKB0VtRmDtZSU=
X-Gm-Gg: ASbGncsi+49JXX1bxHFIpoxaKY//fNzZo0H4skaI3p2MYYEqznHrkgjarzpJtBIfqor
	xvkG8+/Vj8O1+Gl/a3c3S4wTF3QaVzty6dQ6ABxge+uhUHiMzfptMf/qZo3X189cqE1+Xa4KMU+
	Q0F+mGHot8zunS4Hjdm9dULGVuBTCfAEUbHvgd08NsviGnFACQ8L5Lth6dUBmqXhucF8UcrE7Hn
	mhinwnQpdIgzq7NOJt1qyP+tIKTMX5iW02koDjRglyY5CHIeQkdB32g/Jl2tHJiXDQlsx/90gZn
	vUDZlqX8MiBP5B+F3TXDL+Bmq30CSrI30z4AofkOZjR9wvKHpADGsFAw/bKY/QSs2rUHM+C5BHI
	AOVwNPJggEB7k3mS6QQcTJl6+aV/r/inuO8osIvCi+/PqBw+mC3+s0Ab+CZf0MVhdJnma17lFbm
	XQVaRoh/Qvk4sgRumlusIuDcuHmZ9vsCGc80BIVnfhVVfssMPwkL0AOtPL9LJPo+ySw9wYx4nI2
	Agu8gSnWfC6tz0wsPYrpdDx/vM=
X-Google-Smtp-Source: AGHT+IFUw7599UfJi0vUzeWRftPAOENkpTLInak3odP8zPqnLZW4EXjW57ImVmQSzepWcGRr4IRNdw==
X-Received: by 2002:a05:600d:41f3:b0:46e:6603:2a84 with SMTP id 5b1f17b1804b1-46fa9b08bd7mr198177155e9.32.1760458503554;
        Tue, 14 Oct 2025 09:15:03 -0700 (PDT)
Received: from localhost.localdomain ([102.90.84.168])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce582abcsm24426380f8f.17.2025.10.14.09.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 09:15:03 -0700 (PDT)
From: Solly <solobarine@gmail.com>
To: git@vger.kernel.org
Cc: Solly <solobarine@gmail.com>
Subject: [PATCH 1/1] t: update path checks using test_path helpers
Date: Tue, 14 Oct 2025 17:14:46 +0100
Message-Id: <20251014161446.6135-1-solobarine@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update old-style shell path checks to use the modern test
helpers 'test_path_is_file' and 'test_path_is_dir' for improved
readability.

Signed-off-by: Solly <solobarine@gmail.com>
---
 t/t2401-worktree-prune.sh | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/t/t2401-worktree-prune.sh b/t/t2401-worktree-prune.sh
index fe671d4197..27127fa5a5 100755
--- a/t/t2401-worktree-prune.sh
+++ b/t/t2401-worktree-prune.sh
@@ -24,8 +24,8 @@ test_expect_success 'prune files inside $GIT_DIR/worktrees' '
 Removing worktrees/abc: not a valid directory
 EOF
 	test_cmp expect actual &&
-	! test -f .git/worktrees/abc &&
-	! test -d .git/worktrees
+	! test_path_is_file .git/worktrees/abc &&
+	! test_path_is_dir .git/worktrees
 '
 
 test_expect_success 'prune directories without gitdir' '
@@ -36,8 +36,8 @@ Removing worktrees/def: gitdir file does not exist
 EOF
 	git worktree prune --verbose 2>actual &&
 	test_cmp expect actual &&
-	! test -d .git/worktrees/def &&
-	! test -d .git/worktrees
+	! test_path_is_dir .git/worktrees/def &&
+	! test_path_is_dir .git/worktrees
 '
 
 test_expect_success SANITY 'prune directories with unreadable gitdir' '
@@ -47,8 +47,8 @@ test_expect_success SANITY 'prune directories with unreadable gitdir' '
 	chmod u-r .git/worktrees/def/gitdir &&
 	git worktree prune --verbose 2>actual &&
 	test_grep "Removing worktrees/def: unable to read gitdir file" actual &&
-	! test -d .git/worktrees/def &&
-	! test -d .git/worktrees
+	! test_path_is_dir .git/worktrees/def &&
+	! test_path_is_dir .git/worktrees
 '
 
 test_expect_success 'prune directories with invalid gitdir' '
@@ -57,8 +57,8 @@ test_expect_success 'prune directories with invalid gitdir' '
 	: >.git/worktrees/def/gitdir &&
 	git worktree prune --verbose 2>actual &&
 	test_grep "Removing worktrees/def: invalid gitdir file" actual &&
-	! test -d .git/worktrees/def &&
-	! test -d .git/worktrees
+	! test_path_is_dir .git/worktrees/def &&
+	! test_path_is_dir .git/worktrees
 '
 
 test_expect_success 'prune directories with gitdir pointing to nowhere' '
@@ -67,8 +67,8 @@ test_expect_success 'prune directories with gitdir pointing to nowhere' '
 	echo "$(pwd)"/nowhere >.git/worktrees/def/gitdir &&
 	git worktree prune --verbose 2>actual &&
 	test_grep "Removing worktrees/def: gitdir file points to non-existent location" actual &&
-	! test -d .git/worktrees/def &&
-	! test -d .git/worktrees
+	! test_path_is_dir .git/worktrees/def &&
+	! test_path_is_dir .git/worktrees
 '
 
 test_expect_success 'not prune locked checkout' '
@@ -76,23 +76,23 @@ test_expect_success 'not prune locked checkout' '
 	mkdir -p .git/worktrees/ghi &&
 	: >.git/worktrees/ghi/locked &&
 	git worktree prune &&
-	test -d .git/worktrees/ghi
+	test_path_is_dir .git/worktrees/ghi
 '
 
 test_expect_success 'not prune recent checkouts' '
 	test_when_finished rm -r .git/worktrees &&
 	git worktree add jlm HEAD &&
-	test -d .git/worktrees/jlm &&
+	test_path_is_dir .git/worktrees/jlm &&
 	rm -rf jlm &&
 	git worktree prune --verbose --expire=2.days.ago &&
-	test -d .git/worktrees/jlm
+	test_path_is_dir .git/worktrees/jlm
 '
 
 test_expect_success 'not prune proper checkouts' '
 	test_when_finished rm -r .git/worktrees &&
 	git worktree add --detach "$PWD/nop" main &&
 	git worktree prune &&
-	test -d .git/worktrees/nop
+	test_path_is_dir .git/worktrees/nop
 '
 
 test_expect_success 'prune duplicate (linked/linked)' '
@@ -103,8 +103,8 @@ test_expect_success 'prune duplicate (linked/linked)' '
 	mv .git/worktrees/w2/gitdir.new .git/worktrees/w2/gitdir &&
 	git worktree prune --verbose 2>actual &&
 	test_grep "duplicate entry" actual &&
-	test -d .git/worktrees/w1 &&
-	! test -d .git/worktrees/w2
+	test_path_is_dir .git/worktrees/w1 &&
+	! test_path_is_dir .git/worktrees/w2
 '
 
 test_expect_success 'prune duplicate (main/linked)' '
@@ -116,7 +116,7 @@ test_expect_success 'prune duplicate (main/linked)' '
 	mv repo wt &&
 	git -C wt worktree prune --verbose 2>actual &&
 	test_grep "duplicate entry" actual &&
-	! test -d .git/worktrees/wt
+	! test_path_is_dir .git/worktrees/wt
 '
 
 test_expect_success 'not prune proper worktrees inside linked worktree with relative paths' '
-- 
2.34.1

