Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E982D8391
	for <git@vger.kernel.org>; Fri,  2 Jan 2026 09:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767347601; cv=none; b=WQZD+fMUZpIoaE4CLVvABCvo5HhK5i5eolCA+gW9VKq8lZ4FphLHvu3niIbMNaAffpTOTdS79FE95IpsZZoThvg4y7gQXAQfywdKSZevy8YkCch77MLB/C78M861r2bR+l5HaouptYtauiZaPl3VeIWmX2VCgNt045qm17WaaeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767347601; c=relaxed/simple;
	bh=OtQG43cYGr2rVnV084EuPv7Pp+w7KR3REgN4CZQQ8Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i0UVLwh6VCQVla+X6dWpELRXCyVRpG/iLD2L7/oOcTqaDKxaiwRnElWEfENOHacdrytsb5HTNnjg2ATtNvvnPQAeRSRTq9H0ieHeyr7zo690OfmYQEfpgZaZzMWJz/BT9POCWUJnkwZGGQL9wWNepcadizuW+iiMZe6BKgzt35Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLEaYxLG; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLEaYxLG"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso9089163b3a.3
        for <git@vger.kernel.org>; Fri, 02 Jan 2026 01:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767347598; x=1767952398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L2SWlEiaVnShQeUQvHnNOYf3sUdsLbP1mmSqf+EBc+I=;
        b=PLEaYxLG6/aDy6JHVM8ELGLsMyibqV0YuThUSf2YnpuYN4RXkbXu8Ob7LB8jUYwncq
         iSuodR0CvTuzqtqIvvkE978ey+FoxdVHk0MjYX4ls0qBU5qZfpNZcR0hCnluNEiK+Z21
         n85rTP+W62kRuwXZ9rzmc8tPtNtH4zenrNmeY/ys7Mr/+QuifhjMesvBYXZUlDfY21Uk
         v2tswQEhF1Nj1sleKr7Ge0S1tDMNmaLk9SDfVds2n5RxJdz29GLuYcaRNrgVuV7Loojv
         9OWBar3I0Xnt6BUojyErJLMGH0P3TtbGe6k3uBSVeWffiYIknsr/zsRnLtIb/LG+BfQI
         JGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767347598; x=1767952398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L2SWlEiaVnShQeUQvHnNOYf3sUdsLbP1mmSqf+EBc+I=;
        b=tQW5Hjcct7KfPWFyqVCYcFYa+rSgsrUwSPvrTt7XPV66/LWmGIjSo+Nc6XAFZXCAeI
         etQhqh+okIpmz7IJpzQnL4rL581fCYuEn5gskBfvJ7W99diVwM06utKvOVsK4BjriP6Z
         eASbAtfSYLHK7i2pUa2+CuekbVEQteWK95VbkXw9CrRk1K4cRpMNJlu6YBrBRZerTu3A
         G66fSFCDXg9BhofJztyE/SkZmaSwHkK+OmHxCPYmD8MlZqYde6KqJsByaK+c3MBZo8AB
         7nLlK+68fH3gidCQ2ZrsrlcDpz0KLl0INWLycyRifXLPwO9bFMAMi2djx2bTAVgXH1lj
         aABg==
X-Gm-Message-State: AOJu0YwQrsyWXWV7zoTjukgzWfeNMDXoY5V/j684qfWJMqPb+z9rAdIR
	rK1WBk0/r6s4ohAii6+mL+cskwFnPhUmWNI6MeY12/7L2XVW8/aA5bVaPB0m8Exw
X-Gm-Gg: AY/fxX65vMrqIUbkG4ftE/DShjogVHHYck5Cx+C5cgcv/6Azbu+9nJMVcs1Ugx8CZI2
	fQOeWaIMijbUdYy8eJ6wXFduki/izg9k8XRit6NkLfWyvXw7P+vHGUuwWBGslJtiplCGbmQVYcq
	CP1sq/5/jJFcc4MZ5mvYedF6zc4c45ix+AQWjDu9k8pZf4ywUbgBWRr2F1ZfBxymNQCyHbAUmju
	QYygoJ3SXXUViEBvZz/qNPmi1Wk/dOeVCGejEQFbsxSQbtw0Z3T38mL3AAl0lQohQtrCYgZn1cM
	nDEvvSuUyF1F00APRq9nvIYPufU9+IFnaRPf25kGKY5CLWfO+E9MNGx1kt/BHbrSpgl9qLeuVeD
	1shel9jVVAsX4Wb+BRRgk08Imb70EA/YxgKWxJB87At+wwS1in65L2E1Xt3D1izYtZHd8w8To+r
	3fg87FaRC794JpdZ8l4Fw0u72Funo3HcBG+IjyG8jVcP4=
X-Google-Smtp-Source: AGHT+IHtAd0X1XiitQHpZfWc4F0P79YKUwr0OC7qrw3bzcQ9hqe2r92e/u7t1UtSbtjJ4LshirFGfA==
X-Received: by 2002:a05:6a00:278f:b0:7b9:2ddc:599a with SMTP id d2e1a72fcca58-7ff655acc10mr31625239b3a.17.1767347598377;
        Fri, 02 Jan 2026 01:53:18 -0800 (PST)
Received: from localhost.localdomain ([1.39.18.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7b31c479sm39827302b3a.24.2026.01.02.01.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 01:53:18 -0800 (PST)
From: pushkarkumarsingh1970@gmail.com
To: git@vger.kernel.org
Cc: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Subject: [PATCH v2] t1300: use test helpers instead of shell primitives
Date: Fri,  2 Jan 2026 09:46:55 +0000
Message-ID: <20260102095248.18780-1-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>

Replace plain "test -f" (regular file checks) with "test_path_is_file" and "test -h"
(symbolic link checks) with "test_path_is_symlink". The test framework helpers
provide clearer diagnostics and better consistency across the test suite.

Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
---
v2: expand commit message to clarify that
	- test -f checks regular files
	- test -h checks symbolic links

 t/t1300-config.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 358d636379..9850fcd5b5 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1232,12 +1232,12 @@ test_expect_success SYMLINKS 'symlinked configuration' '
 	test_when_finished "rm myconfig" &&
 	ln -s notyet myconfig &&
 	git config --file=myconfig test.frotz nitfol &&
-	test -h myconfig &&
-	test -f notyet &&
+	test_path_is_symlink myconfig &&
+	test_path_is_file notyet &&
 	test "z$(git config --file=notyet test.frotz)" = znitfol &&
 	git config --file=myconfig test.xyzzy rezrov &&
-	test -h myconfig &&
-	test -f notyet &&
+	test_path_is_symlink myconfig &&
+	test_path_is_file notyet &&
 	cat >expect <<-\EOF &&
 	nitfol
 	rezrov
-- 
2.43.0

