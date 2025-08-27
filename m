Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E0923C50C
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 15:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756308312; cv=none; b=JyOkgty4vibZCvxI4KMTi6qBeEWflZrnGogGEqiTqtAkNg62iMnFPGRaOvXTqLwt/W+YiAQJ8qq1QTOPbT4NLIqYZC1Mh+Fap1aNc6yT58vwYmmaO+AuZPwdFQQalGcYlSttzLNYOsBepMJpTq/jiUrbf57Md1o4dVH+f3k6wzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756308312; c=relaxed/simple;
	bh=u7dJ+0waYpXWiG5IsP+E5vaY9HFa58lwqrNWvxZgj+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aiLWrMk9Lk91N1RWVkuHGAghKSosWl1asJXdMDbRAv300Ozpb0icjrL2RQNGqGWpQmcjqW//aGnk4yakz+vA4o5xIWT/VWrYu3fH2VuJv3VkeDaAy8NE2IZ2zM6elGJnUmCXmrfQUwh03hWFOv06ORxS2bhvCAWjuK2rALqRqmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZQn3zvY; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZQn3zvY"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3c79f0a604aso2344584f8f.2
        for <git@vger.kernel.org>; Wed, 27 Aug 2025 08:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756308308; x=1756913108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kVK1pVZ72yPQy6b9jUPe9S1Tkivy8crFUE9nkOdEqiI=;
        b=EZQn3zvYhKX4r93JV88e6hVwZYGsIuVbb3NtBsy0F396JAkj+dNx0YreV/O8RuNwK0
         uG/qJLUj120MIdUI5dcjtDkl/njTET/0o6n01ePMokZkxVrNj6It5fSbuDekGrYC4R8M
         6CkRy727bbwfXbg5QG/oejelcSDevl+VnJGKund0EOLLpOiRRmiuKwMQeVTBRAYBQozt
         QPF4+FPa/vL3osfBnSK/AQeqYIGYUrhfkMyEMhLdkL8HoFY8rdSsNFCcdmBy8XSBT6BG
         HbzNg3fjxCKXDIDljXwkoeuEzZe9MeNYga4oUWytltd9fdlBEIt2cI+5/FOEnTleB2Et
         Y2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756308308; x=1756913108;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kVK1pVZ72yPQy6b9jUPe9S1Tkivy8crFUE9nkOdEqiI=;
        b=P6RrAQqvfMt08OkKSnatJnaff8iLTm6PLawGpv/SnCisw1MZyHxSnm7q8ipeGLNROQ
         oOknnyMnLCTJdHVI2s8pEJyJI3TQ3s9LREI8qA1ce0J0Ev4wptIyiC7G6xjsEuIDYlKe
         jbIAHJTQxEpbS3i/P1vn5ljRT2ceRXhOwv+beID3y9VVJFHadJO3pIvIbvz0z7xvZPX5
         BoMHP1M2piIm1Lm2EYCc2iQ37DVDTVC10xRtYmrh+WrM9nkzJ8QyjjgYlEffiQVLhNgp
         0UcLl68HbEXg00BAj/gFNsMFhpFFjXW7Q9TlhaCE6InSTeZ6iXquzEshbcRc5SXInU9O
         YMGg==
X-Gm-Message-State: AOJu0Yyun/m9AknbZ3EF400lAe6rONFN8HqqiBR0Qdp/G0Z/PU9p9Flt
	j8aVKai5CV5ou1jsftkxjCKA2mCwQYAQe8n/s2LbezFBCTgUX43fTsaM32uuqA==
X-Gm-Gg: ASbGncuEpPDjghypHhbeC+PXUDO2zXWkakbu4UqA4DoKEx6NED03ngIM0YSyppIYLB1
	mrG/Jm+l1haxvkuykmwK+Vc3dbVf1+obUWCF1oxf6FAtBsYcWL10mSWxbAMAbQyBwyXvC8rK7AP
	EFAVtWuacAUe67ztpYMSOpGdJrlzRaWZyfpU+05L5r3KJ0s5khuC6n3XBUuzpqL+j2lslaRy1ma
	fKjXSukgX2nsBup/aSab9sywGkbh1JJ9FhDUcH5d8eV4aXaqDYKFhL+/CEYfs4G3fWwkcYOLtL3
	R0wO2BizDbcw8ywSMvHo9oZHyySUs9xy4rj0A5tYl2TX/mg6BQXtzbb9GdAME1uDKN5ZVUcESEL
	FdGtI6M4MeXA5iXLfynrjs+Y2nz1eDAytwykV+ahogVya8Q==
X-Google-Smtp-Source: AGHT+IGYCyaCNZbVyw7i2Imcvlp3/bEngvXuLbuYlBhvZRcmS4TDat0apajSfCg7U1CHAiSHIE7YTg==
X-Received: by 2002:a05:6000:178b:b0:3c8:e9d3:c38a with SMTP id ffacd0b85a97d-3c8e9d3d0bemr10825113f8f.5.1756308308306;
        Wed, 27 Aug 2025 08:25:08 -0700 (PDT)
Received: from localhost.localdomain ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b73627bc4sm17894305e9.9.2025.08.27.08.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 08:25:07 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Wing Huang <huangsen365@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 1/6] t0018: switch default branch name to main
Date: Wed, 27 Aug 2025 16:24:45 +0100
Message-ID: <7c20f7693f4518ef79be0a2277515bb00d912213.1756308283.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
In-Reply-To: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

These tests use "trunk" as the default branch name but the exact
name of the branch is incidental to testing if the advice message
includes it. Git 3.0 will change the default branch name to "main"
and remove support for GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME so change
these test to use "main" instead of "topic".

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t0018-advice.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t0018-advice.sh b/t/t0018-advice.sh
index f68e08d0b14..c695ade4be8 100755
--- a/t/t0018-advice.sh
+++ b/t/t0018-advice.sh
@@ -2,7 +2,7 @@
 
 test_description='Test advise_if_enabled functionality'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=trunk
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -33,7 +33,7 @@ test_expect_success 'advice should not be printed when config variable is set to
 
 test_expect_success 'advice should not be printed when --no-advice is used' '
 	q_to_tab >expect <<-\EOF &&
-	On branch trunk
+	On branch main
 
 	No commits yet
 
@@ -55,7 +55,7 @@ test_expect_success 'advice should not be printed when --no-advice is used' '
 
 test_expect_success 'advice should not be printed when GIT_ADVICE is set to false' '
 	q_to_tab >expect <<-\EOF &&
-	On branch trunk
+	On branch main
 
 	No commits yet
 
@@ -77,7 +77,7 @@ test_expect_success 'advice should not be printed when GIT_ADVICE is set to fals
 
 test_expect_success 'advice should be printed when GIT_ADVICE is set to true' '
 	q_to_tab >expect <<-\EOF &&
-	On branch trunk
+	On branch main
 
 	No commits yet
 
-- 
2.49.0.897.gfad3eb7d210

