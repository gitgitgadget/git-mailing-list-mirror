Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CC61FC7CB
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 21:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745357743; cv=none; b=gRUA/yWYCJds6hcHHKd2YlNsxh0ZO4mcjIE5cnhgidL0r0WHfF8r4HLUSXzQ7I6RaDTrLKbvpSc+rPWKTFw86dW9QsMGaNG8zQ6Ix//FS2Uezvi7bRSx/N+yxMUy3M6BJe6fvFzOlBCq0mEREyNDJ+QgJQndmNpaGIkHXaonY3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745357743; c=relaxed/simple;
	bh=/JtNkaog9Pt4CsahUbrzuZjtltM/6PCm+Vdw76ujFvc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UbwugMpPh0X9sB6hke6mWlCXoMxPvV19DuITkDUBzvT5NZP4B02QNKh3bk4avLDQi2yjCuHbH2pYVBtNbffrYlbUTyJCrQolMOp2+163gpRbh/3JIKF1HNEVbZxJvf65/7BbUB0hWV+kDOOLgV/EVnLiUKb7XAyZvaxuHnnchkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/P+Ky7U; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/P+Ky7U"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-736e52948ebso6526572b3a.1
        for <git@vger.kernel.org>; Tue, 22 Apr 2025 14:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745357740; x=1745962540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zzfwypZJFuttLki1j4LUG+Trm1jsyuGbNgse0/Vg/Xs=;
        b=e/P+Ky7U80GbSYSCMJ5Fl0eNfvzxwMPw7w30Ig4GdVxELFyLuXuON0H2g/1hzKEl4Z
         +vGMfR4Tv8zdXK9JXSdV4w3u0juYM/Msohz1I99UxTFJnlXacicdlTNsW7kz3YwGb0O8
         amTvvdyr5Y/WEuWA6AafFo5rr8GQE/7aWxtmrRha6iFcwOfoNNIzxttsgR+VG7qg8zgC
         INZfYE+JMYKbw+1KWaPLm8itj8VT+8clNWWuT+ShRaBHzKuXgLFm/sga0PGbFQ6HhGRS
         FAALpVu++4XZf56JHuTxXKaLOUG2OL+dFa5ILPGWu4EG6gw4uF0j8sSegM7a8Y3lRk5X
         uM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745357740; x=1745962540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zzfwypZJFuttLki1j4LUG+Trm1jsyuGbNgse0/Vg/Xs=;
        b=g3JM91OFzDT8r9uuoAXWzCTvJW4plzd88ShJrbmp2HWifrHa4Vz85dJ+WsU+FmvxPA
         wYXc5WC3OJrM96ackg5KEOjDsgC2bO5I+2NQlaTGAQJGBOQXxzk4MgY4m/FHKhbhp5Ct
         xd8pGYZddX3Pnity788YhRKY+uLQWjvlK3yLk5becypjOxKP9q/OqHNkkmZaSX4TAJoc
         78LiB/CoJQP5rtsg9/aL4iJ+vl4EHuIBiByUf0i0Uyz4mw4mIfTpfigo376vRbdV4WaM
         sGyzea/SF6km8nxCTPidhpaEad6FTemnDh3bZXc4FUtbwqIpRr6YSbyeXfyYAs/7M9Th
         bgzA==
X-Gm-Message-State: AOJu0YwUoNLRaJNOSfcrEtSSobmQli3HbNbrR5UEk4IBdoU0XCq2Mc5n
	pDN/7COSByz+3h+gI0XODEBeTTuSqxqAri6YJbT8YIvlEmMUmIU8vApL9Q==
X-Gm-Gg: ASbGncvXyPA5Wypi87IRg98V/TQbdQQAPGw+WeNdf1xhQ1x2U3N2QzI3EQQbb4GK4lN
	vWqYjVyAGFSrFukUA1o3IszBjkEpYMYqusEkbe9lBq7/Hi4Ee7mRpL1mBzMbnn00EeFQ3hDBYxs
	X9zjqyUTdF6sbIxPfThq4JjhOKL/YNtcMgD3FiIJ7B0MB9JMYg7su8e0fEUg/2wPfiLbtigMG1j
	38RIeFXV3seZyYskkoPWEaPjGJZ7932OQtcMWe5L1MDy27tZ70FKtmvAQqp0uUo01UQaP/o2qCs
	FtLKdYlTSUahOqIh4VlgMthDPAYrnGo1ZUJrovPW6CyFiM9QxS540P5RgKKhyia/ZoFntcEiyxR
	kGl2ZL2SqoA==
X-Google-Smtp-Source: AGHT+IGXgmNIjxiHW+0oKaLb7kVcS+RxI9kx/7wIhQ2IBFnW4XzLZY9fS+dXJJUJXQGlRDGK3zyHnw==
X-Received: by 2002:a05:6a20:9c97:b0:1f5:8eec:e516 with SMTP id adf61e73a8af0-203cbd27a2dmr31110394637.32.1745357740264;
        Tue, 22 Apr 2025 14:35:40 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:32:97e3:2ca3:dc92:5416:e6c6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0db1273f1dsm7831053a12.4.2025.04.22.14.35.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Apr 2025 14:35:39 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC PATCH v2] revision: remove log_reencode field from rev_info
Date: Tue, 22 Apr 2025 18:31:34 -0300
Message-Id: <20250422213133.18685-1-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the log_reencode field from struct rev-info, as it is not used.
This field was introduced in 52883fb, but it hasn't been used since its
introduction.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
Hi!

Since this patch wasn't merged, I'm sending a v2 only applying the nitpick from
the previous review in the commit message :-)

Thanks!

 revision.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/revision.h b/revision.h
index 71e984c452..87f8d798c2 100644
--- a/revision.h
+++ b/revision.h
@@ -292,7 +292,6 @@ struct rev_info {
 	struct string_list *ref_message_ids;
 	int		add_signoff;
 	const char	*extra_headers;
-	const char	*log_reencode;
 	const char	*subject_prefix;
 	int		patch_name_max;
 	int		no_inline;
-- 
2.39.5 (Apple Git-154)

