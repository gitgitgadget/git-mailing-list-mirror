Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8667B3F0747
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 12:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783598916; cv=none; b=LxZxu3f6uECxRd5b7ns774cAujmqn1V1ZgIbQvw73ZhqWXuQG78bWCoCmROUEN8YG4cpLW6T2c+iRb9svJPdvblqh5hd/jbxCVxMgfwG7hSEfoLVLLgJkzQcqfVNmqMM36uqz8BkFs8MAiq8tvyvqZn0ZFIs4Zra1I11RDOBr7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783598916; c=relaxed/simple;
	bh=/1oxNXKjAf3E8AQLJO2I+CEyyoNp0HZt5KR60FDABZM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CiSEsTG4WvQWvIw1lO17lErPaigdm0MGv2XcI2n7ILg6zsJa7v1D2u1RElRKTdMfqlpiwXNuQ4ieUWCZ0locB6/cnZHv48frq5gL12NJoccKEJ32XOTpiBoyEcCBqAyzdwZ+1K43XBzRGqMsMW4NZLmkJW/xaeugKIh7UECL2rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=daOxp5D8; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="daOxp5D8"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8eefd4a8057so15589176d6.0
        for <git@vger.kernel.org>; Thu, 09 Jul 2026 05:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783598914; x=1784203714; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NqgZ7AGindYkbpbqTXbhOsg229NhVMKHw5DSLGDH28E=;
        b=daOxp5D8yt1yQkYP7w0CDXhmjzETg15RJ287uNUoAoKu/J0jVtiy2SuWGnOUbY9Kkc
         iF7T7M/HHVpqFD90qgDsqhZnBhTXzMgTClDQH2fgb4bWquwDVOZ/Zt3CiihSp3cVE/Z2
         6t22+q5X9XP8QAgUOrqFK7hqaTToki4viZ8s32/9J/urOAqpP8flVmzWYCArQ06pqNQB
         D1RrWGW75Hecc44j5vxia2TAbXqXgqnSriNhxZHU2F0UggP+UYb7pXEpOESYEQaj4psJ
         aXBJxOrADQkalTV949wPViEWzlcc1gibStsJh/SQqVbrYpkLtrGL9JKBq8pf1DtoT3p5
         tBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783598914; x=1784203714;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NqgZ7AGindYkbpbqTXbhOsg229NhVMKHw5DSLGDH28E=;
        b=ETkOikEtO2uSgfP2kR3hSxK7zrY4D65KwkC6/Q6MiLid4R6uyY39TjnXmdYSvvYHLg
         U7GC5t0sCzUK4MoiN/Ta3v/utIJiy2x1Ii7M3mAwC4iLZiQIXTAlD9gcvRKuzi91yTus
         1EvTRHySDWtu9SpIxVFUECYFuOc6sa7houSTpxTImbX2VRp7Ulellj9gV6L3Z3oKASNX
         ZyEKwQ5JXtsL9YRhVaU+6Xbjni0abFtXFVtz9RzF9iuRaXqU4/R2BAxyQ5mI5oZK2ilU
         UOqLIs1Rqt+ocuct+OHdGe6/lY/3/fHYh0zu3Hs4iz9WneaoIvRe0Du57RWJIeHC65MG
         gDzA==
X-Gm-Message-State: AOJu0YyllR5kyOM2Cp2O5OvYTSLsyRppdftFB4jL4Qr0yrEjc5OE+g/5
	oPJsz3T57Xp/o/UfjfWd8vWbLkvo0Ud4Odn2m4cuZbsEtdsaP08qrtEMnhJz7/kE
X-Gm-Gg: AfdE7cmnCEn6gU1vf34RsqQoArVVxDEMcmlAFpz7Dj+soeJ13CrKN+nQii1AkLCUZCJ
	VXdsXfkjDmztPlEDC66xds+CYNHzGGG5wheyvVMCm99dVcYkAmZCnpVLSLg1MmmhLZxHghVjTPB
	Nq0KIlEdY1BfSG4F04fo4mEjSw16vbw7LybCIlD+W2PBnxFV+cNBbkWQKIWpNFT5c08uqLn/3Hp
	tRLQRDdM0fhGiIW/YlYOaxkZtXlbl5uafbSbLZDICnb0rUHUYs4nfq4X4J9DFUFqfxw+tA3BkxN
	7x7/0xAB7l8iR698j0WyVtX6VFwpqdXmD1SNYnjVnWub05OBH2OcvVIxh8BC7BgAfYUZYz1X4qE
	pziWtRoWDguPJ1T2DGl6MhFwdLRSdsTiKqQHBVK3DEqFSqR1CRl1LCHBAMajKDPrDjsXuTL2ZdF
	RiVHoUw/7SqgHHsd9933i+M6TD
X-Received: by 2002:a05:6214:451f:b0:8fd:6dc5:948 with SMTP id 6a1803df08f44-8fec390997amr71453796d6.61.1783598914551;
        Thu, 09 Jul 2026 05:08:34 -0700 (PDT)
Received: from [127.0.0.1] ([40.79.247.66])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd7c1ec84sm15978776d6.29.2026.07.09.05.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 05:08:34 -0700 (PDT)
Message-Id: <889d0d38bc9952a9f5f74063c685c72c299b1490.1783598912.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2166.v2.git.1783598912.gitgitgadget@gmail.com>
References: <pull.2166.git.1783344957.gitgitgadget@gmail.com>
	<pull.2166.v2.git.1783598912.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Jul 2026 12:08:30 +0000
Subject: [PATCH v2 1/2] t/perf: add perf test for ref tombstone scenarios
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
Cc: Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

Add performance tests for update-ref when many tombstones are present
in a reftable.

The first test exercises the scenario where all refs are deleted
(creating tombstones) and then re-created with the same names, which
currently exhibits quadratic behavior.

The second test uses a separate repository with an asymmetric variant
where refs are deleted and then new, differently-named refs are
created.  When the tombstones sort after the new refs, every create
scans all tombstones, making this case even worse than re-creating
the same refs.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 t/perf/p1401-ref-store-tombstones.sh | 46 ++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100755 t/perf/p1401-ref-store-tombstones.sh

diff --git a/t/perf/p1401-ref-store-tombstones.sh b/t/perf/p1401-ref-store-tombstones.sh
new file mode 100755
index 0000000000..9e3d8031aa
--- /dev/null
+++ b/t/perf/p1401-ref-store-tombstones.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+
+test_description="Tests performance of ref operations with many tombstones"
+
+. ./perf-lib.sh
+
+test_expect_success "setup" '
+	git init --ref-format=reftable repo &&
+	blob=$(echo foo | git -C repo hash-object -w --stdin) &&
+	for i in $(test_seq 8000)
+	do
+		printf "create refs/tags/tag-%d %s\n" "$i" "$blob" ||
+		return 1
+	done >repo/input &&
+	git -C repo update-ref --stdin <repo/input &&
+	git -C repo for-each-ref --format="delete %(refname)" |
+	git -C repo update-ref --stdin
+'
+
+test_perf "recreate refs after mass delete" '
+	git -C repo update-ref --stdin <repo/input &&
+	git -C repo for-each-ref --format="delete %(refname)" |
+	git -C repo update-ref --stdin
+'
+
+test_expect_success "setup asymmetric" '
+	git init --ref-format=reftable repo2 &&
+	blob=$(echo foo | git -C repo2 hash-object -w --stdin) &&
+	for i in $(test_seq 8000)
+	do
+		printf "create refs/tags/old-%d %s\n" "$i" "$blob" ||
+		return 1
+	done >repo2/input-old &&
+	sed "s/old-/new-/" <repo2/input-old >repo2/input-new &&
+	git -C repo2 update-ref --stdin <repo2/input-old &&
+	git -C repo2 for-each-ref --format="delete %(refname)" |
+	git -C repo2 update-ref --stdin
+'
+
+test_perf "create new refs after deleting differently-named refs" '
+	git -C repo2 update-ref --stdin <repo2/input-new &&
+	git -C repo2 for-each-ref --format="delete %(refname)" refs/tags/ |
+	git -C repo2 update-ref --stdin
+'
+
+test_done
-- 
gitgitgadget

