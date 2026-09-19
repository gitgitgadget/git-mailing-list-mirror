Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6877333B6FB
	for <git@vger.kernel.org>; Sat, 19 Sep 2026 21:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789853241; cv=none; b=cz2atUcQ4HSAddRKxCTITRcBM/kAtcL0/yq6JUiHAFpSn69dUmB2ifnBzEf4a6DdcFL5V/B6/hyZFK5ebLfE/CbiUsNHe7ws9UM/4+mzvFa9b8dVYcSsGaEddEQZXMA3DCPOa2xKmAzzm6wh3FHqH8sS+dv5vgdcnnb3cfCQsrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789853241; c=relaxed/simple;
	bh=nmnT+BxbiKicnTMIzE0Yj8KI0BLjqIhI30o2ODkPOv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q686Zhi5npg1+xCSxNd5uc/tjrZaSoju2aHUsyYU+vLufwxW5b4/g45DYVhYULInFurn1xO5CLPVS5Xr2Xq997BPtuAumR2Bu835UjO5fvkjWusZeX+w7k04VF0nYnxVQi52TqDBXOHMwhgEpaKU0SZudtxzlteYxG5UnqaRHeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRyC2h0x; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRyC2h0x"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66fabb1a601so1553699d50.3
        for <git@vger.kernel.org>; Sat, 19 Sep 2026 14:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789853239; x=1790458039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=66djkRtAq3SzNbU24/rC1d9K636KQEvK0LfSphyMTO0=;
        b=DRyC2h0xEBquEGAqA9ol4yCJUwIaVaRyNYszRfLlbjYcM4q7eyxVlsGE6cDa30Ge7e
         zyGU1FFGrfbXfdXvrxFlxmXrD4Bj5QknzwdrTa5BfpqKPecDtOZkQyvvH2gLtts88zTn
         SMh3GdqG6zpi2cdEv9DRXeG8ifjFRd+JGZq0r3RHfCo8KDzGHjfJWPWJQZQmSISaOSJf
         eUrYQYtFmKvjlrZQ5EPL+eg31vrMbDZ92SilJbqjgaPqAJTl0GzRpb2sJgZnM691UG5F
         2D3N64kV/cKmNj0phhGi8ngOefqwuXrfZ1LE8hf4TImTa+hP6WzFWRUTAVEq2v/oKbtL
         ivOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789853239; x=1790458039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=66djkRtAq3SzNbU24/rC1d9K636KQEvK0LfSphyMTO0=;
        b=vnc5QDfR6zzhgxHdiHpsI5Fb/G2ktu49tJbPYITrDK2kS0qCCMlZHJAhSj0H/5XDQk
         jC8vZLj99ZLisHtuamoKZwEl5UkbgwCjR74zJRfLkuHLG3F07sizGC3J0rR46Zc7O6yV
         jfHs3CCNT4m4LyIvpTewT0Uh9RaacByS/ESU+o7F8otU7+02v22aoRxxbyMcubuX/7Rx
         mCmk4qA5mmJu5nc842LhZBf4u/Or4KHUNM4iwyRa3FdZf/JXhDDgFa1cwtV5hPDKqpUZ
         yWYDqPGGcHzT8nBWGmn/QENrzmZJ094EndAb5cUEymVKm2Jn1BvXtkpkl1FbTF+vgoPM
         PTjw==
X-Gm-Message-State: AFuF++l+QWKQs7po2nlRsq7hPfo5nSbv6bgR75zCPwVzQhMjhRYjwNIu
	qZbZ050VFvQlSDS2hB0do93MpbmH4VC12myvfpLDoftcKZgu+7BlfnB6TD1v6TXt
X-Gm-Gg: AYBFou3i+NL8RZwQp8XVH6kEcAdZafRG0NNsz2kMJjgsnHZ4n8f2hM3XLXNVKmDHW/u
	fR9L9nvhaAebtPCI5VfydshuA39gmq+NvYUWVi7c7vbOlB86+hmxYemVqgZg7XePlk8GNa1dNzE
	gPD0UlfBq6RtpS+FOgdvotkMYw2LzE3G6ZThY1CkCppn8nPIkSBIlfwLSYUTw54ixWNji1tSSCL
	GPQD5OVZ8wBSVUGxRGKKyMl+vmkm/zgb53OgYzhm8dI2w98EflDfsZT+xgj1m0qsP2/M24BFuwh
	u6Jxpqlr51n6kpzLHX8IptGvBzQ3n6sDKCrjb2yWDMbp4y/VECVRpSOsxW7kD6gp6hkr5MKsd2n
	90CPKJy+aSofTCFW7067feohQldtm5Tvdl1XiDH7SQmzIU3S1VmrDlXYq+w/wvUtbhdoJ3wqvUa
	X9W3mfKo+WorV1VnbYIrUqPBvSk1AciIbCsfBhKmcCOOfYii2/BsG1CwBQLosiEXeCZcT6fSalr
	WLQCXDupqG8jyAv4CW9tm0BovvZRWSce3Zul2IuFfXwi153z/ngtCJ4RqHLvNP6+bKrrbMK4zJg
	BCHg9YXWfbu9pDjxj23TWkLP4YvcLQyR
X-Received: by 2002:a05:690c:60c7:b0:873:17c9:afca with SMTP id 00721157ae682-897320902dcmr19346617b3.29.1789853239500;
        Sat, 19 Sep 2026 14:27:19 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::6])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-89a4751bae9sm11756497b3.28.2026.09.19.14.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 14:27:18 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Eli Barzilay <eli@barzilay.org>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	John Cai <johncai86@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: [PATCH 1/2] builtin/stash: remove unused header
Date: Sat, 19 Sep 2026 17:26:35 -0400
Message-ID: <b6798c8a25993913d2ba13b8f3b08d602364ca44.1789853192.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7.dirty
In-Reply-To: <cover.1789853192.git.ben.knoble@gmail.com>
References: <cover.1789853192.git.ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clang complains that oid-array.h is unused. Certainly none of the
oid_array* functions, types, etc., are used, and the
transitively-included hash.h declarations are used but covered by a
pre-existing direct #include of hash.h.

Signed-off-by: D. Ben Knoble <ben.knoble@gmail.com>
---
 builtin/stash.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 7a9843413b..dfea2d2c4c 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -31,7 +31,6 @@
 #include "reflog.h"
 #include "reflog-walk.h"
 #include "add-interactive.h"
-#include "oid-array.h"
 #include "commit.h"
 
 #define INCLUDE_ALL_FILES 2
-- 
2.56.0.rc1.315.gc6ed9934b7.dirty

