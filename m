Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71B02147E6
	for <git@vger.kernel.org>; Wed, 27 May 2026 04:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779855859; cv=none; b=hL2aYT44hD4iLB9ii/935ppAN6JlRYQJQd/5WWKTp78/fXx6AOcfFPbxYHgpXGBFVz0GjMWTWV8XdiSbZ/6w7KL6R2QdkewCFNfQKgxlpUF1Ac9SKSsXKD3xEXXWuAcX6iLcz73mVoRfWle90nqiSif4DRqdEAnwaRAc49+K5rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779855859; c=relaxed/simple;
	bh=HWzO9FWbRYOWT7eUh2shZ5UcfdP7ryZvIdqBkD5/42A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gYBoXOgz0R7B5iw7Q8D6KjkcpIzWfY5nBnYRFrSEG3X74VZeHlqV/K8Q10to0J+XlELKOn5+uK5JVryxEHcXsistPWZCErAmQ34lqIGcWCkvp5h8TWr6WQxeTuniMNmvQbnppIOMaa23zYUeJXPXrW3FjPynXyrYyLPEPckL7/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NptvioAy; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NptvioAy"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36a3e47bba4so685438a91.2
        for <git@vger.kernel.org>; Tue, 26 May 2026 21:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779855857; x=1780460657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U31sT3Lh/IQ68bKuh91lAlnznQtGqYTwktz3xH2WsIE=;
        b=NptvioAyWK4+Kox5hzcd/XUYIjuWeEV4Bm+O6bW7rRq6Is3Vbki7bfOepeZsaOGsUZ
         rVP4smxHycxgWiPrXXf+QTCvX+ZbTFTbsUU5H8yED5tgQjCR6RjCQ2P8ugRU4Gz37Tbv
         aLEM/r18g5pYVZ+SUae8Q9PubyWID32TpQe9mw0jLejO7Y2yZfPJBvk5waLyIvpj6JRF
         BbzmTCuAgAdyzICo7syQnrcY2v6Jbq74e1kltR1axdkqFuq8OyuM3LY8n2os5tCuBevk
         eImnLu6Auy+Aau07+wuQoVopYSqFw1GDIj6MTAUeJmptQhsoPwPh/j2lY5Xf5UDP/bC2
         u42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779855857; x=1780460657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U31sT3Lh/IQ68bKuh91lAlnznQtGqYTwktz3xH2WsIE=;
        b=SoM89jhTlbUcwpv9rsswxRBSHbRbNT2yG1RmD9DMf8iy8JVOYoNwtYcSt5wtpBUP8b
         7nSmnw+ChjqaZmSA8pwosoe+N+6SS7qZctxnJpBvE5JGlD+xmJnG+hBr1O6AOHRdUSdI
         uRj1TQVRfsJ4oHEcdNhYm9B2ZmDMG/8YTVDguMK8LdBNXI0DOtGLqWEW+uI2ljladnNj
         5csHgLjCvJdMyhD6qzFX22sjQFGJkzzCzbaLvAwW6zxqT+RLEUHRIfJQZym0PbgrE2eW
         J8qyzctjqvVZ1qqeUk3Bmte7oYKoztgPJKDJgL0g5YMnQDcRG4oSQNEctURIIyOuvMe7
         U/ng==
X-Gm-Message-State: AOJu0YzwylWVg3NXXXiHVESSeX3yKDhYqvigPEOYyLG4Z5PZID984cQ3
	DDdmio6TuDRBBpPiGxLV+LXo3Iia4BuEG6W3T+hbeD+girK92xNQc2fRmQnDjQ==
X-Gm-Gg: Acq92OHgqXdiQNc1M2Bp+Vy5nb49kZzVh9pieMZU95io0/ZpXsOM4sMDaxcyFMn1TZP
	h/KYqRhAdAw3qsJVajno1sv8GboVBjbquBmFH6Aucwi0N3oMV/YUJ5SKmspaT6uaMx+dK5+8Qbd
	BssHVB514oTIZ2yf16c8jvNpUTZlYzms3G/h0Y+b+lplYEGQek9+DN2GqRPVFKTQySzU8EU6A5R
	0NNWwklk80FvQ8GwrlzZufG+H8OqCv0yP2NLTMLMcqHv98IMFrNCQLOveZTwO3O0c0jhDn/0e3k
	u/e/vhtOSyEPTseGGMXDnTZHDyJqIRhcPVFhAzmmHZffsqJXZhZkB0i8mdDsu+/cadBlc9UMth5
	Kgoxg6Lu2fOqFpLK0jvoOqRcVrkj2st5p76PBlMXdmTznq+p8W+AvPzdHMqmPMOkflfG+FH5rJ0
	VDaWFCJfT0YE61R8LsqPwaql/DtdCvannxqiV45JxIAQjd19AJgV2GPETWGT+AhHoEMAz2sHRvZ
	HHed6PZDdE7KqNnXw==
X-Received: by 2002:a17:902:c407:b0:2b2:b1a5:aa4e with SMTP id d9443c01a7336-2beb061fe54mr136842765ad.3.1779855857347;
        Tue, 26 May 2026 21:24:17 -0700 (PDT)
Received: from localhost.localdomain (122x211x77x66.ap122.ftth.ucom.ne.jp. [122.211.77.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58d9fe9sm135625495ad.65.2026.05.26.21.24.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 May 2026 21:24:16 -0700 (PDT)
From: Keita Oda <ainsophyao@gmail.com>
To: git@vger.kernel.org
Cc: Keita ODA <ainsophyao@gmail.com>
Subject: [RFC PATCH 3/3] t4034: cover moved-and-edited word diff alignment
Date: Wed, 27 May 2026 13:24:02 +0900
Message-Id: <20260527042402.13607-4-ainsophyao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260527042402.13607-1-ainsophyao@gmail.com>
References: <20260527042402.13607-1-ainsophyao@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Keita ODA <ainsophyao@gmail.com>

Add a focused --word-diff-align test with a moved permission-style block where
one value changes inside the moved block.

The test is intentionally small.  It checks that the changed line is paired and
that the RFC renderer exposes the old and new value with word-diff-like
markers.

---
 t/t4034-diff-words.sh | 46 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 0be647c2f..7bf696b17 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -148,6 +148,52 @@ test_expect_success '--word-diff=plain' '
 	word_diff --word-diff=plain --no-color
 '
 
+test_expect_success '--word-diff-align marks moved-and-edited block lines' '
+	cat >old <<-\EOF &&
+	#define LIMIT_PUBLIC_UPLOADS       25
+	#define LIMIT_PUBLIC_INVITES       8
+
+	/* Public resource permissions. */
+	#define PERM_RESOURCE_READ         0x0001
+	#define PERM_RESOURCE_LIST         0x0002
+	#define PERM_RESOURCE_COMMENT      0x0004
+	#define PERM_RESOURCE_EXPORT       0x0008
+	#define PERM_RESOURCE_SHARE        0x0010
+	#define PERM_RESOURCE_ARCHIVE      0x0020
+	#define PERM_RESOURCE_DELETE       0x0040
+	#define PERM_RESOURCE_ADMIN        0x0080
+
+	#define PERM_INTERNAL_DEBUG        0x0100
+	#define PERM_INTERNAL_IMPERSONATE  0x0200
+
+	#define AUDIT_POLICY_STRICT        1
+	#define AUDIT_POLICY_VERBOSE       2
+	EOF
+	cat >new <<-\EOF &&
+	#define LIMIT_PUBLIC_UPLOADS       25
+	#define LIMIT_PUBLIC_INVITES       8
+
+	#define PERM_INTERNAL_DEBUG        0x0100
+	#define PERM_INTERNAL_IMPERSONATE  0x0200
+
+	#define AUDIT_POLICY_STRICT        1
+	#define AUDIT_POLICY_VERBOSE       2
+
+	/* Public resource permissions. */
+	#define PERM_RESOURCE_READ         0x0001
+	#define PERM_RESOURCE_LIST         0x0002
+	#define PERM_RESOURCE_COMMENT      0x0004
+	#define PERM_RESOURCE_EXPORT       0x0001
+	#define PERM_RESOURCE_SHARE        0x0010
+	#define PERM_RESOURCE_ARCHIVE      0x0020
+	#define PERM_RESOURCE_DELETE       0x0040
+	#define PERM_RESOURCE_ADMIN        0x0080
+	EOF
+	test_must_fail git diff --no-index --histogram --word-diff-align old new >actual &&
+	test_grep "^-#define PERM_RESOURCE_EXPORT\\[-.*0x0008-\\]" actual &&
+	test_grep "^+#define PERM_RESOURCE_EXPORT{+.*0x0001+}" actual
+'
+
 test_expect_success '--word-diff=plain --color' '
 	cat >expect <<-EOF &&
 		<BOLD>diff --git a/pre b/post<RESET>
-- 
2.39.3 (Apple Git-146)
