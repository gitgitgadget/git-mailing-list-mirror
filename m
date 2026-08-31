Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289EE33D512
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 19:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788204560; cv=none; b=VuubuRfPC/O/4kBoKHztLgVsMMsxLcDtwC8UnPRvmGZWHTy4kfa/mvzwkW3ZCdYOPGDRjUZvX31fGAnlOy2Bx07EOoTiyee64S1RVqjUSadUQTdHw+t6XsWFl5qG0Q2eXb7f0vj/WxvqpWWAe/wfsMnkpx+te1LLWK6JjOKuj5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788204560; c=relaxed/simple;
	bh=5CXpCEA7KRmyAqRB49PPz2nhplChvEA3nYwmsuSG608=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TpnJgVaz2k/VFIT+AB/bmSKV961xazkbE1TRO+bG7Yzgf5NaNBDteH2gU1Nen6ZzbX1Yft+ed6tgTrHjmqAS0qEP4O7Ng5vDmGwY5uGOUJpy5LxdP4ecdDoXahYaYZuiq2WlW0oYJqxpvQT5QCztnwemPKOqT+4joZDZ58agIuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGRFrrKb; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGRFrrKb"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d944747d41so10751765ad.0
        for <git@vger.kernel.org>; Mon, 31 Aug 2026 12:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788204558; x=1788809358; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=S5fLkX4y/nf0i1Zi+ElZ1dCU9Z1nCeBP9sdAd0Wh1Us=;
        b=XGRFrrKbwFZR0Wyy4Rp4q7yZhT9toknWD/JJ5E0byXC6COUZiLhiPrMkQdu5BU12ZW
         1yLAt+FdsfenRbxL/8fD92txub3+fRioSiHKOrqFo0UHXHLlUxgQCrn10R/w7RRo2lWo
         cmtZ1y4/t9HPykehojO3KtnSkEz6fec/8x5nD8rCb0d1oStsgbrl8yJ+Xd5OKSDqXbN9
         PT4jpdGmMfjBI0d/OHI7GpS0CnpBdCodXFdhjhm2jFitm3Tb/ZEvrCrS0Bzf4ClzCUZZ
         nvFEF102l4cD+aqF4gN2YGxmz+dGd+nVXEeDH8F+yQw465finClpqiEHR8FvXjP9IbF5
         1Ymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788204558; x=1788809358;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=S5fLkX4y/nf0i1Zi+ElZ1dCU9Z1nCeBP9sdAd0Wh1Us=;
        b=h6CR4ShMINQDBaMqVxUZFPykHK6QYi45m12mTbXEF8lwnpTGkSiNq/1Um2Gd/VVtO8
         p03U4cYDTO+QanQtMoZIaT2xgedykrxr3KP3hW53nuiKIcjLFg3tt8a9D4SdN6h4dDfi
         RC/upZB5EGQXYsakZwwAwPy0V1LVscQR6kLMos95o97LXxGesu19wNN8tWkKOB8fdzMM
         i6/NhMIWGdhUfVJ6pOr9LwzLil854SoS5E0E1VFz/ln72SLhGzeGOcWXH7vPEqH4DFqs
         4fu1eAIQx1NNB6psBSkQzKY8rLdneAyGlUcw+Z+cU1H5qcOm/4bW9oJ813EHz3nOAe7q
         GBVw==
X-Gm-Message-State: AFuF++mjeqHTCuTvUHzMz2J4CjWnKSm6wzjgEBWQi9COTP+3/dkHhxx4
	LHZnvHR7EwUkUl0rBhyDB1yKE11zgZU6fRhrA00BRpoQR74R9GjAXtdj
X-Gm-Gg: AYBFou1kUtx9HZAZRvv6XSBXWd6f3OufvrfAHCv3Lp0UbZuKX8BhAYtEEzGWS0J37h1
	y62P57RS+CQGCTiOyP9/u1xfsqWNPYfr8o0fUKLmYtsqgM8JBTG9nppD/Ska5s7vG01y/UV0oRd
	VapeXL8iV47ZYhvzmoke1tl+wrCiMfHH34LZSRKqCJNIzENcXOKi6yPmY4fy4UcFj1jmzicP5Nc
	RJ7VdDTfVG8NgmCXqaszwZov77rNRrd3aZifUrpqJwkBp6qO4FCIsfBzurCKWdjAuzUt9D2SoRF
	D3jY9zP06nEKlEQ6jhA7BK8Wmijj5GtqQJ3CVUZT/9IYfpF1oM+iVwt3804cJUsjcmZREkEEIyC
	I3R73ftIa3461J6n+jwetf53bWkpYrIUD4vvhK7NYXqIGyEmyd1GF85NdtAZY11TZn9kztMC/Vr
	pbTrKs6lGKMmvji2C99fL6y72BhlTSJrjWw2Rcqj23eLmTlzPlTll0QFmF9LomjH8=
X-Received: by 2002:a17:903:38c3:b0:2ca:e19c:97b with SMTP id d9443c01a7336-2d74dc30f3cmr476489675ad.5.1788204558420;
        Mon, 31 Aug 2026 12:29:18 -0700 (PDT)
Received: from [100.87.176.22] ([117.213.200.3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286fa400c8sm36808479eec.30.2026.08.31.12.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 12:29:17 -0700 (PDT)
From: Hardik Kumar <hardikxk@gmail.com>
Date: Tue, 01 Sep 2026 00:59:13 +0530
Subject: [PATCH v3] versioncmp: fix typo in versioncmp.c,
 t/t0022-crlf-rename.sh
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-typo-fix-v3-1-cc342f329190@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22MQQ6CMBBFr2K6tqYdlBZX3sO4KDDAJEJJSxoJ4
 e4ObGThbt7PvLeIiIEwivtpEQETRfIDQ3Y+iapzQ4uSamYBCnJlwcppHr1s6CMN6NIYbQwfgt/
 HgDzvqeeLuaM4+TDv5aS39U8kaaklXNEqZw3Wt+zR9o7el8r3Yosk+ImF0gcRWMwduqZ0mGe2O
 Irrun4Bvk2/y9kAAAA=
X-Change-ID: 20260828-typo-fix-721b77177721
To: git@vger.kernel.org
Cc: Hardik Kumar <hardikxk@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788204556; l=1546;
 i=hardikxk@gmail.com; s=20260827; h=from:subject:message-id;
 bh=5CXpCEA7KRmyAqRB49PPz2nhplChvEA3nYwmsuSG608=;
 b=MTF4vHCwiyAn4m6icNoaWtAmjcI7MIWHB+lXH/rvAOuQKmgqCeSVyVPhV4h0o2MwhBFpezj8b
 qeKirsFtu5NAmIg6KVb2rQy8TB6vlIkLxR87pMXumrTbHLMwVNUgNZD
X-Developer-Key: i=hardikxk@gmail.com; a=ed25519;
 pk=56yFuFlLHAdRemUZghoGHVCijEX767atrut3dPD0thQ=

The patch fixes two typos in two places.
versioncmp.c:           "fractionnal" -> "fractional"
t/t0022-crlf-rename.sh: "similiarity" -> "similarity"

No functional changes, only update a comment and a test_description.

Signed-off-by: Hardik Kumar <hardikxk@gmail.com>
---
Changes in v3:
- fix file name typo in commit message body
- Link to v2: https://lore.kernel.org/r/20260901-typo-fix-v2-1-6aeafbae6389@gmail.com

Changes in v2:
- refactor commit message
- Link to v1: https://lore.kernel.org/r/20260828-typo-fix-v1-1-24e80a87ed53@gmail.com
---
 t/t0022-crlf-rename.sh | 2 +-
 versioncmp.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0022-crlf-rename.sh b/t/t0022-crlf-rename.sh
index 9bd863a970..328c6e5903 100755
--- a/t/t0022-crlf-rename.sh
+++ b/t/t0022-crlf-rename.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='ignore CR in CRLF sequence while computing similiarity'
+test_description='ignore CR in CRLF sequence while computing similarity'
 
 . ./test-lib.sh
 
diff --git a/versioncmp.c b/versioncmp.c
index 3a81b17bc1..f1e451755a 100644
--- a/versioncmp.c
+++ b/versioncmp.c
@@ -15,7 +15,7 @@
 
 /*
  * states: S_N: normal, S_I: comparing integral part, S_F: comparing
- * fractionnal parts, S_Z: idem but with leading Zeroes only
+ * fractional parts, S_Z: idem but with leading Zeroes only
  */
 #define  S_N    0x0
 #define  S_I    0x3

---
base-commit: f78ce2f7b6df702f93d40b85d6bda92a3f65da79
change-id: 20260828-typo-fix-721b77177721

