Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CA31C5D76
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 22:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741039323; cv=none; b=nLh4Xnk4nA8iNtZ+9dh2n6nbPoWOMNO4vI+HLQR9jX4heqZDgxk9hxHta26soX9FBmGnWmufU1kpCuUeAfmAghbxC6VQoAw1+ixTG4B8mEAEk5bG0smRjpqjRM1Mp0md/7gRkpAAtUfIbUe5cjEiYu6tyniUPPOL3vPoBtMEXWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741039323; c=relaxed/simple;
	bh=F9BNVIIs5rOt2lKmswauhY7ZPy4+8kiElwUjLfBSM5U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sx6Q1zb2aGIaWgrdoXLAIax1xpyk2pY1pc7PzTn7eCkjRb6ZkaH5HxQ+A5EnpQhGNEuyh9o3LglR+MSZ89WwWe+keNEQfYgyWRseEOtSPPNVNRsE9+Mv+WApIKxcxSD24Boodz0pYmtLT3RrDr3fXvEVE3dv8V/jtrUkypTgX7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZbRE1EOl; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbRE1EOl"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2234e4b079cso90043715ad.1
        for <git@vger.kernel.org>; Mon, 03 Mar 2025 14:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741039321; x=1741644121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PdxQeQmWLHvuQE04oozeWR7qZzDvIeYAgMZbpGrNkfA=;
        b=ZbRE1EOltqd5Qeokzb6ggp8AYPHEuLSOb2raZUvVJ4f6+zEDn8SXxpP2oc2b0quAAu
         r0DQxRQrUmAsjZ8nHgIMUwZgAhS0Oh1gMz2UCG8p5Nq3eAQDPHVmvMO+W4Q9Aok3k2Km
         i1Zc3YEvdYJGX5rB0TC8eeohFyuofNSu/qHAtdKNc6hqTsWaDJjTI7atxclKSBHMDGqY
         BJluFpQl61w6gZpIl2p0HHj2Cn/yEkHxYwuGCSgRjidjLB0tYp3m89aizDhMG3RO2C81
         XPXJwASGhbifinRSmpgAipqLUHTN6eCK4gnULXz/YQBoArGSDJfcmXkQgMOf1CfVDu2T
         Hi2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741039321; x=1741644121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PdxQeQmWLHvuQE04oozeWR7qZzDvIeYAgMZbpGrNkfA=;
        b=a2jFl8xamA0o53suFo72UGLVgIHBu7+Jvd1Wasvy/Sq6l95RHDPnrsevKy6NM9RsQ6
         Fb/TAa0OGJ6H0jtQoMUkAYnnt/b6YJNfZX8kojKJPOKTGGDQ9E7grDQv7c5344Umpenq
         6o1OAeU0HiFAXWPUf/ZwiBF+g5aF5OI6rXTicDMoLdc8ZEVdtrGjzcTmfWjUrWwyc+wV
         dOCM0cuXPH0OvlHKE5VVoOAXG0mBj4q8uwTpBkS8+ag9/XTYdJ1LFvjoX0D4O5QDZZym
         tS7oIdrilpQbbylqCGy22OC1y/smA+TR97L3Ai+7afu6ZIFXWSzCxbKmeWlOOWGAz+vd
         dtgg==
X-Gm-Message-State: AOJu0YyfaqmqI0/e+WfEaq067vtBm2920cIyUjAOHSuHWZf1OMM7kABn
	p0WEzHhY/xnVW77ScPUgPyX22Ynmo1SaJKVzw9FpUWVsUNZNO1lNFNNw5Q==
X-Gm-Gg: ASbGnct78eNnKfJnJe3SSqkMS/mDZgIvJ0zyStDk0JWBRkTi6clb0P9fRt0d0znwS11
	iqqA2zeZZwEUdhumQTqPIxuAUXocZ5hk7VdIw0HUbEwZz82UrvfKGY5AopFlR+kPM4oQjPzVGGP
	O5LbvTKpn09EJfeJTLZOV1rXA5ulp3ef9/WlLbeFea61aBmF269TegP7yTxbXMXGy5sgcn0hUTa
	Rnskb5chgSLgtsIg52tHOxylSw3WARixjl3BkdFv+FKlZE2lR2+ETilysVlckjeeXjMOvFkWnvk
	22c+QfOjUbCPNeILWiCGAW9PG9qtOGkiHWW+3pQUnJZV8f1PYueYJiUgH6HJ4ZLIHdkDBNhFEFG
	1rP7RjuLLFg==
X-Google-Smtp-Source: AGHT+IHGa2cRjWBrxTWtwuPt2fc9CJDIsK6t2Eq3VI2qIDhQweYumcNAknEAGVR7002SSGhr+rbg/g==
X-Received: by 2002:a17:902:f547:b0:21b:d2b6:ca7f with SMTP id d9443c01a7336-2236920c5b1mr239609275ad.32.1741039321200;
        Mon, 03 Mar 2025 14:02:01 -0800 (PST)
Received: from localhost.localdomain ([2804:7f0:b77d:283:5dd5:8e9e:2c56:864a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504dc7e1sm82746565ad.176.2025.03.03.14.01.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 03 Mar 2025 14:02:00 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC][RFC PATCH 6/6] t4014: add tests for the new flag --subject-extra-prefix
Date: Mon,  3 Mar 2025 19:00:29 -0300
Message-Id: <20250303220029.10716-7-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250303220029.10716-1-lucasseikioshiro@gmail.com>
References: <20250303220029.10716-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests for `format-patch --subject-extra-prefix` asserting that it
works correctly in the following situations:

- without other flags related to the prefix;

- with the --rfc flag, which should add RFC to the prefix;

- with the -n flag, which should add the numbering to the prefix;

- with the -v flag, which should add the patch version to the prefix;

- with the -k flag, diying as they aren't meant to be used together.

Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 t/t4014-format-patch.sh | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 884f83fb8a..1256ce2197 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1444,6 +1444,46 @@ test_expect_success '--rfc and -k cannot be used together' '
 	test_cmp expect.err actual.err
 '
 
+cat >expect <<'EOF'
+Subject: [EXTRA][PATCH] header with . in it
+EOF
+test_expect_success '--subject-extra-prefix adds extra prefix' '
+	git format-patch -1 --stdout --subject-extra-prefix=EXTRA >patch &&
+	grep ^Subject: patch >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<'EOF'
+Subject: [EXTRA][RFC PATCH] header with . in it
+EOF
+test_expect_success '--subject-extra-prefix works with --rfc' '
+	git format-patch --rfc -1 --stdout --subject-extra-prefix=EXTRA >patch &&
+	grep ^Subject: patch >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<'EOF'
+Subject: [EXTRA][PATCH 1/1] header with . in it
+EOF
+test_expect_success '--subject-extra-prefix works with numbered patches' '
+	git format-patch -n -1 --stdout --subject-extra-prefix=EXTRA >patch &&
+	grep ^Subject: patch >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<'EOF'
+Subject: [EXTRA][PATCH v2] header with . in it
+EOF
+test_expect_success '--subject-extra-prefix works with -v' '
+	git format-patch -v2 -1 --stdout --subject-extra-prefix=EXTRA >patch &&
+	grep ^Subject: patch >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure '--subject-extra-prefix does not run with -k' '
+	git format-patch -k -1 --stdout --subject-extra-prefix=EXTRA >/dev/null
+'
+
 test_expect_success '--from=ident notices bogus ident' '
 	test_must_fail git format-patch -1 --stdout --from=foo >patch
 '
-- 
2.39.5 (Apple Git-154)

