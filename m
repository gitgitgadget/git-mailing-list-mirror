Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2663C4574
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 20:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781901132; cv=none; b=OFQh0VA1IPccqJxQ8hJOE4gB9Svp2NCv3IsEqpDoAZr3Fpl2uNgmIPEtiKmlmTE2YFS7lQgkV3ZciDSmSl+SwN+hYIY/pgyeLYJCIc5tCNASr2cWzdO+UZhcnCvEn1A/l8TevneVS9D0r9sPBjnMbpFGx6A54ewxjeN0wlGDBC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781901132; c=relaxed/simple;
	bh=+c9gBcRkpLHu2POqo4wEoN4koTrA38HnnjE9cOfAR+Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jWh8guQkOvu2awF3uL09TC2PhvbghsbrQpKe3vSdNLRWw5vWGT3YZSHapiG0YDJYzV8ZcUZBXaGY7WAWa8qCZ/C8RCcxjsp4JsRzrUIW19gEsXMc+kmCpOjiKr7oQ3vSeCYgDDwl9mEgGUNMNYTxKMnxNyl5Nhb8aL8pprnA7ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7Ce1yvP; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7Ce1yvP"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-915c48e6ae2so194630785a.2
        for <git@vger.kernel.org>; Fri, 19 Jun 2026 13:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781901129; x=1782505929; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+e5ImIA+tTu1zqUfAkNLBrfvTN2BitU+4y2tgA0N1k=;
        b=L7Ce1yvP+QGw6Iu21hKHVaSwhLICKhv1EwzJYwJHJuXHTFeL/FpXi2itYy/b3EU7UA
         oVeT2RWlW/c39F5lqJgW9Lq4s86xEGMUKxhhfbo+i0rXLJD4MenSfZGtqAsOGBawuq1K
         hFxPPcahoXZbNGFcGVOZEq3ChVCjd0dM0ZU0y9LtPqfvfcTxizxjUKPX1sXX5fVwg9l7
         Qpdo1O5Jbq4WuVEPk/n/r5sGyZdMqgay2p2Bz4NH4tRBeRE3bTD9evrq45YYeLAJ5/lx
         1QMF2gF/AVdlJ+a0gmHlMqMqlahe7Vmk50gpgdlcOvyfTPml57vDh4aGBLOOmcAfwxam
         iH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781901129; x=1782505929;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c+e5ImIA+tTu1zqUfAkNLBrfvTN2BitU+4y2tgA0N1k=;
        b=KfRqpOLywrWdQQbz0iBjYlc732LyP0Ntbj3tGXAT0n9xtJP+iEJHL6LqrALMABJHNZ
         G3/Bg+klEFw5/jndByD25NZeIMf0vOizEszFv9eznVkeiIBKjHym7vAGiWn53wzsw5gs
         nknlhGhCuXDFXv815K8vNMfOTXd3OqhHyTN3mm5k4d0w6amhrB0YQwIgv4AOyPgmDZTR
         iK1aHYwV3+4JSYI2YsGyyJ1JDaajC8YPqKkuG9bnWMXb2Xd17zk77FfsTrXbijIjCsCP
         yXtVzpw67H5JcZc8WPaujkRAjKk440J3IIZHPtXIpm5QusA047Y+IEB4DDqMFUbF63qr
         4L9Q==
X-Gm-Message-State: AOJu0YxdObmPHCGD0HLunPn34Rd7Gr+Nfal/6vIRbJBQ0e2mj4ZPiA2G
	BvRSmBZJYz12XcwMZHgVjiX0R3OBaio6YCuWNyvmiY3rOVwedkWK8fq+BjycTg==
X-Gm-Gg: AfdE7cni7GOHEDhDg23dMNKImKwQcDQM3ZrZ1wavSouPbg1kZg7W7YK7W45zLgSsi6a
	cqels/0O7hqS7LRQ1VIhTAdb/2/EsBID+TYo1E4agAZnlz+tE1gdshxFygZlWJ2BpZDhzZi9O22
	Gd1nW5JaJRvsXzrjzgXTBo5uAYzZGQNn/2FE8IDSQxsPOp3EbApBHckkHLi6Hhmt+E+VUM/tw3z
	bZuT8Eg2yHNFUgz8I/xUpQIK5EeLOilFA0O9CoXIVb3CZAO6On39HBBdol66FudrVy+i5OmnsYv
	aCbrWbKXmEHxzX+lkm7MQvUPdhAntifagxgHrHb1SGVyXLS/BNQyq/bqHBx4ly6eO5BIw+0oO4c
	UdrXYAxDwJ6lnBZmJOI5fKrP1IoGsNOskdEIcBgfTdi9zQZBVc3n1hB6BLRkMPFEuLiio6cPgG3
	6cSRTvRWh82+wnVEJ7
X-Received: by 2002:a05:620a:4056:b0:915:cda5:27ff with SMTP id af79cd13be357-92092255b7amr813788085a.45.1781901128941;
        Fri, 19 Jun 2026 13:32:08 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.216.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-921d796a11asm81491385a.7.2026.06.19.13.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 13:32:08 -0700 (PDT)
Message-Id: <pull.2314.v3.git.git.1781901127385.gitgitgadget@gmail.com>
In-Reply-To: <pull.2314.v2.git.git.1780610623006.gitgitgadget@gmail.com>
References: <pull.2314.v2.git.git.1780610623006.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 19 Jun 2026 20:32:07 +0000
Subject: [PATCH v3] config.mak.uname: avoid macOS dup-library warning
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Building on macOS with Xcode 15 or newer emits:

    ld: warning: ignoring duplicate libraries: 'libgit.a',
    'target/release/libgitcore.a'

Some link recipes list the same archive twice, which is harmless.
Quiet the warning instead.

Pass -Wl,-no_warn_duplicate_libraries on Xcode 15 and newer, whose
linkers added both the warning and the suppression flag (ld64-907
and dyld-1009). Earlier linkers reject the flag, so gate on the
linker version. Broaden the existing -fno-common version probe to
also match the "ld64-NNN" and "dyld-NNN" forms Xcode 15 reports.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    Makefile: drop duplicate %.a from test-helper link rule
    
    Fix warning of duplicate libraries on macOS.
    
    Changes in v3:
    
     * Suppress the warning at the linker rather than dedup the archive list
     * Pass -Wl,-no_warn_duplicate_libraries in config.mak.uname, gated on
       the linker version (reuses the probe added for -fno-common), and
       broaden the regex to match all three PROJECT:{ld64,dyld,ld}-NNN forms
     * Floor of 907 and the version forms (ld64-907, dyld-1009.5) per meson:
       https://github.com/mesonbuild/meson/blob/master/mesonbuild/linkers/linkers.py

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2314%2FHaraldNordgren%2Fmakefile-test-helper-dedup-libs-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2314/HaraldNordgren/makefile-test-helper-dedup-libs-v3
Pull-Request: https://github.com/git/git/pull/2314

Range-diff vs v2:

 1:  0ef442ea05 < -:  ---------- Makefile: dedup archives in $(LIBS) so link recipes don't repeat them
 -:  ---------- > 1:  5bf560c5ad config.mak.uname: avoid macOS dup-library warning


 config.mak.uname | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index 8719e09f66..9ebd240378 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -173,8 +173,15 @@ ifeq ($(uname_S),Darwin)
 		NEEDS_GOOD_LIBICONV = UnfortunatelyYes
         endif
 
-	# Silence Xcode 16.3+ linker warning about __DATA,__common alignment.
-	LD_MAJOR_VERSION = $(shell ld -v 2>&1 | sed -n 's/.*PROJECT:ld-\([0-9]*\).*/\1/p')
+	# ld reports "PROJECT:{ld,ld64,dyld}-NNN", match any of the three.
+	LD_MAJOR_VERSION = $(shell ld -v 2>&1 | sed -n 's/.*PROJECT:[^ ]*-\([0-9][0-9]*\).*/\1/p')
+
+	# Silence the Xcode 15+ warning about archives listed more than once.
+        ifeq ($(shell test -n "$(LD_MAJOR_VERSION)" && test "$(LD_MAJOR_VERSION)" -ge 907 && echo 1),1)
+		BASIC_LDFLAGS += -Wl,-no_warn_duplicate_libraries
+        endif
+
+	# Silence the Xcode 16.3+ warning about __DATA,__common alignment.
         ifeq ($(shell test -n "$(LD_MAJOR_VERSION)" && test "$(LD_MAJOR_VERSION)" -ge 1167 && echo 1),1)
 		BASIC_CFLAGS += -fno-common
         endif

base-commit: 95e20213faefeb95df29277c58ac1980ab68f701
-- 
gitgitgadget
