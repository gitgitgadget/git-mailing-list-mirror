Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454AA28BAA8
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 17:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745430011; cv=none; b=jTz/M1F47Rt/ZpWI8nG7nmb1fGRmys8h7KOq3KITUpZfoKtKz89ChVB1NLDU66gVp5Qk1uzlvT7zuImlAxDsuQsBEqYKXbbJ+He6aNi/ZsJkm5yG13PmRRiRohvrwVrf2c0LpYjMHY3gT5nesr/wIgxtFITOvd06h8gRpi0wkvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745430011; c=relaxed/simple;
	bh=H/JrXCrfIXcKEqV6UF092ZAM6Y0z6Ih4vBiCqm+9yRs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KHKprrrOd/VCgrNKl5z5r1irUjNmFebctDCA+EITt9DUTzaPW49+e8j6+BCfcqkucL5dpGLCwCzm/JIYCKIj3TMonNgBPlo9mrl9yDfkGWItcS3bTMwukcIHrJA58f/i0DUfEFJp9e7zbbDDeqNw0zpsbnx0cW/sk2xtDr6EByI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8NP7mTQ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8NP7mTQ"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cf848528aso829505e9.2
        for <git@vger.kernel.org>; Wed, 23 Apr 2025 10:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745430007; x=1746034807; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDCihxOQMLwbK/gY+PzqUWaachfFmLE0SYlBOi0moXs=;
        b=H8NP7mTQqK5v8fxlF6Qo2JNdCOysd69wMzMEdSRa/Ndvdwg3gJgSmuFtVXezFEVUhB
         XF+YlKAOoBr1Op89VYIGzFHvwGUkmptzRXeA9FJNt/Oqn1DIFDNKMc4Ek0iEep77pFun
         yUmtut3XobS2A/Uaeq18F78ApDuoxAfX5PlIqM+NqrClN/ZVKQKPZL79jBtShowL+a0F
         ePBw8Fi9fHaqexA1S6vEc5Ivtgmcr4pYwdBmtDugfjqb+Z18+Vds7KZK3yJrTbbi/TT8
         7eIzdPc8F2l+l0Tv4X+GQutVPHP1e3GCJ0VyzKiASrJDnllCUAnb7KHOwe9y5h8Xz2mV
         F2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745430007; x=1746034807;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RDCihxOQMLwbK/gY+PzqUWaachfFmLE0SYlBOi0moXs=;
        b=gpMBQnP2GJQvv/3m0RvCIAmUOxA7u4PbSmwOto3o85RwL0a6VyAfMT05bRcqANW1HC
         p+cULTuvKpHHkNOlSqxlCbNfbx9wB04c84rTQitlkSAiNbnho2ZedUqZrg9np7Iho+hV
         rL+w/H7Pgb1/dcCh8g2Bc5rmkyqKArBunZeGXwaboYqENHKAZbmcYNxQXh8f6tXgTzxK
         J8ebST1zTYSwXvecAq19b66giL+MCev4FO1ySzffud8oL6xG4kf8lB2kvNxBqyNCip50
         Gp4MXgnMYdram1D1RnGg+OgmYtlTbd1zpZ++YsGiQPIxCAh9kG3lSjaJ2khwHJSg83ip
         Ezag==
X-Gm-Message-State: AOJu0YxvzSXhrJK7Js1/M8Z9M1gUnDfo0uGNoToidnafzlVIxKV6kdT0
	W9jWocvdfelDgqlvDWFSVOUvx83DeBcNfMEwIiKrIqEL1ZTvL3huTwSA/w==
X-Gm-Gg: ASbGncs6HqHDP/hXC/YwowrVmYuPg0fW7hB039GH0B6i5sT80lZ0F+fT5QjePkJ3X/g
	EJiT0Y8siJACcTswtk6FrlErpA7tzAVQiyJdJVdjFqK/sF3+S58LqtNbaENxPllUZcIx9iAV2Xv
	Pt7MZwH4YzFhLVLJGasQpUL8ILfgtSYNd35x6D0oiYNk7cOUTq57vSIPxpdZJQv0nYyOSJi0tg9
	4AXndcQeVsz0fOeAsaJiRhC8fzljUz2MemLBMpXtgaV0mlVUf1VXZauMHHpIWs0QcjWRgTUw77E
	q1Q0CnfAkFjh8jh6WLuYUxSpPrMuggxHKlXVCtuPSg==
X-Google-Smtp-Source: AGHT+IEdRHopMBke/VB0heW2Fc4DbmR/pSZsnjgcQeH22xLF5k0O9U8FBTz6BglaeesXIPD8AP9XGw==
X-Received: by 2002:a05:600c:3ac8:b0:43d:fa59:af97 with SMTP id 5b1f17b1804b1-4409a1d009amr3054885e9.32.1745430006978;
        Wed, 23 Apr 2025 10:40:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa433141sm19635355f8f.35.2025.04.23.10.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 10:40:06 -0700 (PDT)
Message-Id: <a9430447641ff3b3f519abc0960b6741fd7df700.1745430004.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1906.git.1745430004.gitgitgadget@gmail.com>
References: <pull.1906.git.1745430004.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 23 Apr 2025 17:40:03 +0000
Subject: [PATCH 2/3] t5309: create failing test for 'git index-pack'
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
Cc: gitster@pobox.com,
    peff@peff.net,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

This new test demonstrates some behavior where a valid packfile is being
rejected by the Git client due to the order in which it is resolving
REF_DELTAs.

The thin packfile has a REF_DELTA chain A->B->C where C is not included
in the packfile. However, the client repository contains both C and B
already. Thus, 'git index-pack' is able to resolve A before resolving B.

When resolving B, it then attempts to resolve any other REF_DELTAs that
are pointing to B as a base. This "revisits" A and complains as if there
is a cycle, but it did not actually detect a cycle.

A fix will arrive in the next change.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 t/t5309-pack-delta-cycles.sh | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/t/t5309-pack-delta-cycles.sh b/t/t5309-pack-delta-cycles.sh
index 60fc710bacb..9029f8a0dda 100755
--- a/t/t5309-pack-delta-cycles.sh
+++ b/t/t5309-pack-delta-cycles.sh
@@ -75,4 +75,30 @@ test_expect_success 'failover to a duplicate object in the same pack' '
 	test_must_fail git index-pack --fix-thin --stdin <recoverable.pack
 '
 
+test_expect_failure 'index-pack works with thin pack A->B->C with B on disk' '
+	git init server &&
+	(
+		cd server &&
+		test_commit_bulk 4
+	) &&
+
+	A=$(git -C server rev-parse HEAD^{tree}) &&
+	B=$(git -C server rev-parse HEAD~1^{tree}) &&
+	C=$(git -C server rev-parse HEAD~2^{tree}) &&
+	git -C server reset --hard HEAD~1 &&
+
+	cat >in <<-EOF &&
+	REF_DELTA $A $B
+	REF_DELTA $B $C
+	EOF
+
+	test-tool -C server pack-deltas 2 <in >thin.pack &&
+
+	git clone "file://$(pwd)/server" client &&
+	(
+		cd client &&
+		git index-pack --fix-thin --stdin <../thin.pack
+	)
+'
+
 test_done
-- 
gitgitgadget

