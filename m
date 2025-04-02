Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625762356A1
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 09:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743586698; cv=none; b=jV0el01ziLL1AJgKsRns+2Fvek8UtD8E+RVwVRm6n4tSdQXB8e79bMD9+SCX6RpCOrDFFKszjArh++yv5Xqf3NQ6XpQ4CeaO1XWOCiSvOfYy463XRzFNmxVTSpDwzeee7uBj9ZcV7pTmBhhGGHzEW+6die6wv7LIhnqseWUgzdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743586698; c=relaxed/simple;
	bh=7E3wFSvBZCfYvmivV3uIUSaURsMis5gxn2Z+5a82G+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rxZ+jtFcZFSsdbgWaoAtWreptO43st48fDxtdUcnbjtkIwU6Hp8YMvKpgd61Pgjh0hpKT5z8Fs/2jjDq3+gm5ZYN5uaFLoMAuyOBu80TfNb3+05yyQ9C7Nt8VSrE+moFwzk28PuSqFlI5Gcv7A4ze6z5my4t432TG8JEisbnqTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BbDNNZaL; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbDNNZaL"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22409077c06so7237735ad.1
        for <git@vger.kernel.org>; Wed, 02 Apr 2025 02:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743586696; x=1744191496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a36nl8sHbLg0Suwi477jrhcL6a3tp2o/WIEgbhpMgUY=;
        b=BbDNNZaLPXN+/8uXza6I+GcWC0tyKJ6ZVaOTka7kihPIoR+1vA5MAp0zf+6Zu9A3Yj
         +EXje6CtkyYKvzyA1jCZyYJ2fUHNzjaIk9JEO3E7kcCYJDpUDT3pcV1losgPQs+QHNUO
         eLomh3rRy6p8/rM9uPOAbrIc7Ym55rzcn1WoAYrmgYP0oJnXOnido/qF69ZOCk5s7adR
         liyPly8tnT5v5uF7dH/AVjRuEC0s48t8N7qmEjL7hLaQ2xriPuuMLL0A77X2OQ59VOtM
         9nvlTlgL9cj38OYEcPw/40QAgA6kFq0/yDaZyuLIlOqp+nDIOAp1XePUiGpDRhj8G9Bx
         velw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743586696; x=1744191496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a36nl8sHbLg0Suwi477jrhcL6a3tp2o/WIEgbhpMgUY=;
        b=M1wjn8fM2b9SHeus7DlWAo+PsPHR9QK6SjWwK6l+Enp8fxemVoGxJWr5RloSyWhash
         zqd1P2umjgIdMR/huQiRJfEPqNV2GOVfcl95ECogJo0hfrSuDVbByVBLuUPb9+Ip+i7k
         AN45SQdkjB1WUEeg9Hrv5C8EwATj4HMz3wZ8rqgqVHrAYI3J3UxmUdnWGYlncY2GJLJZ
         P25T4vkqAonXlsp+UYapWj5TzmhZfKw947sQ+GOFBvZL2iWmNlO4lyYIhnYXJRa8plvR
         3L0KSRDh+WiG+LmH8zJkRLbB4il0mJVHshjgWr3UwFq035sCl3o8UODTt9jiczdo9S/J
         iRrg==
X-Gm-Message-State: AOJu0Yy4gXAkLI3I1+ZWgRr7LOmdK7RwMa4pa4O43/cMJApFdxLabHQj
	M+IvJOSJAt5yGisku002IbpvbWOm5xpruBXxHKyk1qKRKhePaeBinH8ARA==
X-Gm-Gg: ASbGncuODFL199axaMcocUvF2LRFvhSw2zfygUl164SqNaHhJe9OFnoYDdUCBbzzfBA
	nCUN/FXgU+BZ23exDILY7yyqXLKCzXQ0vEHKiCA9co2WqqUh0F7+cdYiM9smyM6Jgk3xw3lK4oZ
	mvenc7rv/u5nEik36AIcBjVHbrE9obJKeMU+3ewXHvAtX9UKnB/Kc4TNU55nE5DHagakXBMIA8o
	apxkLuJ3l3r4RF7GvgzJbhUSlujxtgLrkn5cg89HedUR4RK1lC6Kq/y3XVgl+SsgVvrQ49ePr1n
	nlaQNTuWcUSk1gicScB5k+uIncVlhPggFQYUJYZ7gHlVJTYf4WYqPH1kD8uFWf049w==
X-Google-Smtp-Source: AGHT+IHPO3kya+mDo9xmmSL0rn7kGmwpDld/inuSw3g0Pr4s9Jeo3dzt+GiLiOKagjBD1AGy+T9S9g==
X-Received: by 2002:a05:6a00:3d12:b0:736:ff65:3fd0 with SMTP id d2e1a72fcca58-73980462a28mr24959452b3a.16.1743586695952;
        Wed, 02 Apr 2025 02:38:15 -0700 (PDT)
Received: from localhost.localdomain ([136.233.152.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739710ad63bsm10805294b3a.147.2025.04.02.02.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 02:38:15 -0700 (PDT)
From: zanal <zanalsorathiya8405@gmail.com>
X-Google-Original-From: zanal <zanalsorathiya@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] The second batch
Date: Wed,  2 Apr 2025 09:37:44 +0000
Message-ID: <20250402093744.21569-1-zanalsorathiya@gmail.com>
X-Mailer: git-send-email 2.49.0.110.g30eadc9d59
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/RelNotes/2.50.0.adoc | 34 ++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/RelNotes/2.50.0.adoc b/Documentation/RelNotes/2.50.0.adoc
index 50e3027984..1905c61e9e 100644
--- a/Documentation/RelNotes/2.50.0.adoc
+++ b/Documentation/RelNotes/2.50.0.adoc
@@ -17,6 +17,26 @@ Performance, Internal Implementation, Development Support etc.
 
  * "git fsck" becomes more careful when checking the refs.
 
+ * "git fast-export | git fast-import" learns to deal with commit and
+   tag objects with embedded signatures a bit better.
+
+ * The code paths to check whether a refname X is available (by seeing
+   if another ref X/Y exists, etc.) have been optimized.
+
+ * First step of deprecating and removing merge-recursive.
+
+ * In protocol v2 where the refs advertisement is constrained, we try
+   to tell the server side not to limit the advertisement when there
+   is no specific need to, which has been the source of confusion and
+   recent bugs.  Revamp the logic to simplify.
+
+ * Update meson based build procedure for breaking changes support.
+
+ * Enable -Wunreachable-code for developer builds.
+
+ * Build update.
+   (merge 7c8cd9c158 es/meson-building-docs-requires-perl later to maint).
+
 
 Fixes since v2.49
 -----------------
@@ -30,5 +50,19 @@ Fixes since v2.49
    when certain renames are involved.
    (merge 3adba40858 en/merge-process-renames-crash-fix later to maint).
 
+ * Certain "cruft" objects would have never been refreshed when there
+   are multiple cruft packs in the repository, which has been
+   corrected.
+   (merge 08f612ba70 tb/multi-cruft-pack-refresh-fix later to maint).
+
+ * The xdiff code on 32-bit platform misbehaved when an insanely large
+   context size is given, which has been corrected.
+   (merge d39e28e68c rs/xdiff-context-length-fix later to maint).
+
  * Other code cleanup, docfix, build fix, etc.
    (merge 227c4f33a0 ja/doc-block-delimiter-markup-fix later to maint).
+   (merge 2bfd3b3685 ab/decorate-code-cleanup later to maint).
+   (merge 5337daddc7 am/dir-dedup-decl-of-repository later to maint).
+   (merge 554051d691 en/diff-rename-follow-fix later to maint).
+   (merge a18c18b470 en/random-cleanups later to maint).
+   (merge 5af21c9acb hj/doc-rev-list-ancestry-fix later to maint).
-- 
2.49.0.110.g30eadc9d59

