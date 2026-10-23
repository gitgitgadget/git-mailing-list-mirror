Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792740385;
	b=VVnwyx1jTqpw1Fh+B1G7PQ8XE6ZR9CTyHyOQJgniiWQQvTPnRk2M+q/fa+WMNDqpJ70s
	 qvWFfLJWHAC/Thq7qU27ErcmOKgwjY+znp7YwDoMMXxchHlUi+V26jNJIZsUbhB2OVMt+
	 +kTocbj+k/goIvmahHPGxen/70XA/XPd6xLjon0DONyKFhKfPQaUBePVjjOcyzdEB17oV
	 7/IKNoUMW5smt7wMRCX6BrnqX3r0nSVA+60vg2gxp8rotahluDHGqkY/yc3zEPnsFrkgn
	 gSShvH/Ndk9S+1BzbIID5DOe2kJyEOGWceu1sBDJpedPNgjOhSAafejB5fW76OvMP+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792740385;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7GQJkRufc3jnKSZclhlopVxbB/mqive+erFt1PfjEBY=;
	b=DpPFC4eKVBmQjz0UCY3CP+kNEYKp/BzXhlz7vGrE86qQQhq4/tc1UTPUjPqYBuRtI1zN
	 Tpo602CL0pc3qJBvNeEFwHN4jIxlQKZtTxN0JNjhGuhdFgAlXihIl/tz3lBWFaua3z479
	 tnR6zvfBGl43Shx1mdIKfvjfEAkxuWl4nt3nzuqWt3W7t77yzBENUbvXVebnI8p6B7qWr
	 hUpo2AOGGJos4lzqr8eFQK4kHscOfTJ5d8ZWFfS7YGQegmZ5Knt1WQ6roGJrlewtPEYG1
	 23DWFMbEs5+0Kw+88k0U1PUfOPW+q1zoz2hwrdnxJ2mF38YzwF1PPydub+FunHfmeTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OTKBjDCT;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8574B606A334
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 07:26:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8574B606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OTKBjDCT
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48c4d99c32bso362898f8f.1
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 00:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792740384; x=1793345184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7GQJkRufc3jnKSZclhlopVxbB/mqive+erFt1PfjEBY=;
        b=OTKBjDCTu61tMxSaXVyR+RCXHTpQu4Vz3FwmGijUhExA7kqWObZw4ej3ZgC969rrYv
         hrM/SmNx6lPT+VLBdWgaE3EPHtJOln4VrhKs63JXg5lp/F3F81z5IKA4q9VCHuYC3nIv
         cKCYfveUShD2POiCaDvjz0ldkAR7qVUoQlDZkLPr6EdV4cziD/qeNB1DOSdMZTsRKkIS
         COPj3PnZYUWb4pJ7geCXpoJxqAmIW18Uw8kP6HS+hdVPfBILQl21bZBod2F/7nuOewPY
         Bmp7nFlk6rWiBsDdvR0z8VZVBX5R3Bnq7beXIPGE6ubKLix+HS2os6DFPX9wc4I2jV8Z
         +6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792740384; x=1793345184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7GQJkRufc3jnKSZclhlopVxbB/mqive+erFt1PfjEBY=;
        b=gR/0HXSwRs/P8IkHOTaym8k3lqs8vjRSQFPnje8rVAGbbIN9FwJzzMGWr4PyYQnPax
         gNvBnaBgsg56/ywiSUa7ReRKNxgs6I7s+qlCma22LnxlkBywUs5bVDAl3DN77uVy33nu
         ltjJI4OmhigmFGrocNq8Nevu1K0DNwnZDNlcjqjUgAarPGyIgwAfB54sB1G6DeQe8CzQ
         VP2vkjOcYTp5sHCT4sqeV2F8nNe2Mdri5L/tSlUpI2GOwC1vBdfvXaQzwt/EO3o6L1NU
         RpREEqMerE+wf9j9U4Wd8SzhM/sgcUVLFKXUxL9RRiNfej2XFwHScwcQZaqBawVuw94L
         w2qg==
X-Gm-Message-State: AFq9FYKvuH1y/pqwKTBoxWLiA1dwJ+d4MqiPRNCxZOhQLdctjNuSTE/r
	bwFsYbirTcM+157fSLvnldqR9h5auMY0Q1Gc5CfPUiY7NY/omsXBp0IFBMDH+g==
X-Gm-Gg: AYBFou2k3JFGFSEMv0MN1vlNrYq+quLJtqsU2E3mN6R1VUQRe3oCNI2T+cuh+3qxxwR
	KqYwS8HjLQReXf1iqNftgmBt0ghPHy2l0mcHDf2Grq7puPcwVSJl6XYDGokPe3xYIZ5N3cU9sLp
	VSMT9lfF1FG4JrsLv/YJOWNgyFR+KW5D5nk4sD625W0lr8rF7U2tSGBTEGiTHHo+q4p9jXIn6ZC
	TjnbVK5VZvQSqDlqA9CwsD5qULsudqzyYsScu0PCrv8NBp9SJG7i74sAei/33FYvsIWm0d1F05l
	fURAR/pz65M0nV61HlcIp91s4DldS5WQGsc/ibbKJAUuFpYcbuxHw2yufB9grNzA1LzEmrW+z/Z
	wJ7sN8CuLaZN5s80GWNOL4Ptf9vPFLGcIG85OQ+gj0YLQ2GOo7SXArgYnjA0gsWAuWzlV/XniWZ
	IK7BN0Cfj57ukLPKn/YWG3x+eA0fqIaP5cxSdFFm11iC/KAWBKhRj/h/H7eyGJbNCqi2qbSP2Rd
	NcPAGLs9g1SIO2eBlfJ4jD/aZCY3ixkvmVQR40mxt2XoJa2rTS8jnGIKHEGFz5OWBKZzDNbHQhE
	qaBfsvS4rQ0TgPUk3lmuWLnxqFeEs442a72Dh4V20RJIIcAuXZjmaQ3NVy4FASA7BRijkSkxzEs
	palRtGSzfw+Zx43x/0JNV7t6ej1m3GEFFtrUHwdWLByGCT0taH4K+3F7S83jrMmBBhg==
X-Received: by 2002:a5d:5d10:0:b0:48c:571a:a1aa with SMTP id ffacd0b85a97d-48e38594bfbmr2036224f8f.19.1792740383622;
        Fri, 23 Oct 2026 00:26:23 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e38055da4sm3228024f8f.43.2026.10.23.00.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 00:26:22 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 05/13] object-file-convert: implement mapping in terms of object DB
Date: Fri, 23 Oct 2026 09:25:50 +0200
Message-ID: <20261023072559.3204273-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.0.215.g47fdf2208c
In-Reply-To: <20261023072559.3204273-1-christian.couder@gmail.com>
References: <20261023072559.3204273-1-christian.couder@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "brian m. carlson" <sandals@crustytoothpaste.net>

Now that we have odb_map_oid, let's implement repo_oid_to_algop in terms
of it.  We still need the latter because it does some cleanup that needs
to happen so that our object database backend need not deal with these
issues.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 object-file-convert.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/object-file-convert.c b/object-file-convert.c
index 63ee18630b..90a75a6c21 100644
--- a/object-file-convert.c
+++ b/object-file-convert.c
@@ -7,6 +7,7 @@
 #include "repository.h"
 #include "hash.h"
 #include "object.h"
+#include "odb.h"
 #include "loose.h"
 #include "commit.h"
 #include "gpg-interface.h"
@@ -35,18 +36,7 @@ int repo_oid_to_algop(struct repository *repo, const struct object_id *srcoid,
 			oidcpy(dest, src);
 		return 0;
 	}
-	if (repo_loose_object_map_oid(repo, src, to, dest)) {
-		/*
-		 * We may have loaded the object map at repo initialization but
-		 * another process (perhaps upstream of a pipe from us) may have
-		 * written a new object into the map.  If the object is missing,
-		 * let's reload the map to see if the object has appeared.
-		 */
-		repo_read_loose_object_map(repo);
-		if (repo_loose_object_map_oid(repo, src, to, dest))
-			return -1;
-	}
-	return 0;
+	return odb_map_oid(repo->objects, src, to, dest, 0);
 }
 
 static int decode_tree_entry_raw(struct object_id *oid, const char **path,
-- 
2.56.0.215.g47fdf2208c

