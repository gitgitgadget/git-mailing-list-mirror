Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A493E18734C
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 09:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721035858; cv=none; b=GE7xsgo7kkjJK5UNbILREYoyIC0V/bEOgQ/kSYKpyA9IzFQB2lfPG1FFps0yF5xpSk3/qwpyBMp0FnFJsq894Ywy5i3TPB0AHrRMhuJLfw+NDSlCVEHp1DACmkXN7vDROTpFATiyzYWRGwQLZQA60f6a+M/jKNMnfVQ4DeerJ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721035858; c=relaxed/simple;
	bh=NKLRjRIvuJP94W+tCj4VNJ0/Xh/FWZbhInoDE+UGwyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bMeGB3S331U/Zhsd/PJ6R2msxh4juoML4sIXfxs2/9i2+W/oJNFMZmOIvE/8Eut8+ewq2kZ1sSONtBjczIlvjLXq1kKFQGMWkqPRW2o1bvHnmQdHrkp7GutWmo1OqZmpTw8Q/AWum4HPLAdTv0//fIjDO4oEhxRL/aZWE2EiTgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfTpuYRv; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfTpuYRv"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4266ea6a412so27510615e9.1
        for <git@vger.kernel.org>; Mon, 15 Jul 2024 02:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721035855; x=1721640655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWpRRpBwnZmw3yWd0ypb6JPNeFDHxwHjwgCkp69QJus=;
        b=kfTpuYRv2OlTZSc2TCFvoJT678jx5AbOXi3T69yYqtpVoqdoiOpFzIKRoIOjx6ZXAi
         331Fa1kE/jovK1fmyP9Jazi+hOhaWG0q2C1G2OKu9/GM6kYWitI/WSAghO8A2NSa0Fhq
         zYQzBoRHCCZrIzWlksM5gtkoS4JfI6yCcgHb2z3EdAQY5SFnR2Wz/4609ndK11CKa3AX
         dFBp8tMzVJi8BGlQftQ+UFvfyMNn4efEwQBhgGSNi5maRjgWxq+K0UoM89UiOKMi7Wxp
         EwMOnBivPXv5pa+sdxzjzT7qRgrEHDY3FELfa11rKZahmamvoYs4ZoweNfmi4EAU3nrC
         2CTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721035855; x=1721640655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWpRRpBwnZmw3yWd0ypb6JPNeFDHxwHjwgCkp69QJus=;
        b=qGy1BR5KXp6saUMEX7YDFfrOQw+DR2uAcAcVasLMReP2HTPjm8N8dZF0UUsPSyaUPh
         nQHsjwC8pr3VNOhah4KSvcNKcXvaAbcxQIAtZwJof+iQa7+y0Y0EkgOqwKSqvLzL0ATu
         u64wwIR9zumiRDKpPBjn6mZcBanjNrlgL+6TqbV9pqPeYUN3Fong+VR4GuJZ0UGeragA
         C006vVK/NgzuIC4AFkPDTok/Iwws6qYZwNsjFrmypJxbyROn57jI/BHhhXivvrGt0AMA
         5YKeuEUmve3q2O7JFUUOSEb+k7Mlz9d72Iy2t0Fh/osMknXuatirfLCWhDoGL+u8LBJq
         Qeww==
X-Forwarded-Encrypted: i=1; AJvYcCVsDN5hkLL4maap4LEFuIR7NpP8TZawssA7g/50prNMxyAtJ84JdQW1srEMq9yNbFGjgro7XF8d7id5LkUKuXKL+LzJ
X-Gm-Message-State: AOJu0Yzsga86GVC6NudHMScYkgvMCn8eVrQZ52Av0rPWmdIHfqui/FTI
	J6AsgbFQA/RDU1fLFctX8W9bI5wDb7UofCxkC5kWHlG6p7Js1g7e
X-Google-Smtp-Source: AGHT+IF9QdwqnUr8MwH53SZgXoABka+Xwfi2roFrFiTfjShW2JjCeq0UZPQ2lrDYefFScqYl9SXz8w==
X-Received: by 2002:a05:600c:2154:b0:426:602d:a246 with SMTP id 5b1f17b1804b1-426707f7e2emr136616365e9.32.1721035854921;
        Mon, 15 Jul 2024 02:30:54 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:1a3c:da7e:77ea:d1ae])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafbf19sm5745208f8f.68.2024.07.15.02.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 02:30:54 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: chriscool@tuxfamily.org,
	git@vger.kernel.org,
	jltobler@gmail.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com
Subject: [PATCH v4 5/8] clang-format: formalize some of the spacing rules
Date: Mon, 15 Jul 2024 11:30:44 +0200
Message-ID: <20240715093047.49321-6-karthik.188@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240715093047.49321-1-karthik.188@gmail.com>
References: <20240713134518.773053-1-karthik.188@gmail.com>
 <20240715093047.49321-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are some spacing rules that we follow in the project and it makes
sense to formalize them:
* Ensure there is no space inserted after the logical not '!' operator.
* Ensure there is no space before the case statement's colon.
* Ensure there is no space before the first bracket '[' of an array.
* Ensure there is no space in empty blocks.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .clang-format | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/.clang-format b/.clang-format
index 914254a29b..a0dd1f2eb9 100644
--- a/.clang-format
+++ b/.clang-format
@@ -121,11 +121,18 @@ PointerAlignment: Right
 # x = (int32)y;    not    x = (int32) y;
 SpaceAfterCStyleCast: false
 
+# No space is inserted after the logical not operator
+SpaceAfterLogicalNot: false
+
 # Insert spaces before and after assignment operators
 # int a = 5;    not    int a=5;
 # a += 42;             a+=42;
 SpaceBeforeAssignmentOperators: true
 
+# Spaces will be removed before case colon.
+# case 1: break;    not     case 1 : break;
+SpaceBeforeCaseColon: false
+
 # Put a space before opening parentheses only after control statement keywords.
 # void f() {
 #   if (true) {
@@ -134,6 +141,13 @@ SpaceBeforeAssignmentOperators: true
 # }
 SpaceBeforeParens: ControlStatements
 
+# No space before first '[' in arrays
+# int a[5][5];     not      int a [5][5];
+SpaceBeforeSquareBrackets: false
+
+# No space will be inserted into {}
+# while (true) {}    not    while (true) { }
+SpaceInEmptyBlock: false
 
 # The number of spaces before trailing line comments (// - comments).
 # This does not affect trailing block comments (/* - comments).
-- 
2.45.2

