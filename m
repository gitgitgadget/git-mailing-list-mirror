Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792880040;
	b=gAOmugORPBeCO7SpfgUsfuTD0WzkmM28fIbITaBGIUmwIqHkib//BjQQh0EAW9+PmlO8
	 Lhwc+KNLE8V75bh3lUMzmt2Imbc13W0ceOxcVWpUufMIWgE+L5zTye/iEBx8KOykopJuc
	 m2MRNwBPJL8QkPHlNFcWpjIgplCKJffbxl19sL4K1iQRL4rNupIdRfCI/TnfvY3sgMg9D
	 ZoLngzsZucSPOgb2eHrI7G7Xm5vMBmeZcWCvXzlzarips3l2OV/5Bar8NPquwi7rLjioq
	 9lSorgUXAxJYc77BVGvrvHohKaV2P4MfjPwcQvTNi1Z/6evI5pwsC3+hESyDH4fQkOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792880040;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=3O+ZaCjsZjNt3tOPpyIAOxnfGLwcX/bFih0NJX6uwEU=;
	b=Vp4Gt7COgx2U5tcVYzbbiZzo7TVMNtiPGcSX1d9KywElO8L8Ea+3NaUCjB5w1tXDssbV
	 ENXbArdziVOvTdNtoV85G2xqtdXnVm4LV3kCojA91Zl6Frh8jG8CL8n7tXTO/WsAF+9VB
	 3oFrLFPtlU/VX/OuPNTmIhs/a8JJfDA2cK3ea1Od2BDF6X3WrH0pMeJTig3Sr8sbX3r+t
	 wDzC6eay6ygyKiKp5few/jiB5udz1pLmSwKs0pSPHztbtigvU/2N0rRfxi2oGcQQBzjzo
	 gM+Wo+aPE0rfItdhptb+onEiElHddf73D+/MQ/iuiWUU3crK9YD9fKqxFoUJkt4c9Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VUljZg+m;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFCF606A31A
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 22:13:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AFCF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VUljZg+m
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c450ab1483cso261662066b.3
        for <git@vger.kernel.org>; Sat, 24 Oct 2026 15:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792880038; x=1793484838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3O+ZaCjsZjNt3tOPpyIAOxnfGLwcX/bFih0NJX6uwEU=;
        b=VUljZg+molANcb+BA30MAlRk984JQClLK7VONX3qilmOmM3E/lb6V04Y4HLcwiYXo0
         bsMKpZPmZ9M8GfJyuhK98Y780vLKG7Bk2vDcfBBzCRIX04pLezAU5LuNMyhSMlcLa14Q
         rlAWipbTQR2pe2qUrTdETBLR7ltXs7I3eeo98P55LZkC46gOv7r3fQnQZMSzTzlKDF4k
         fG3EiEORZAdg+bARwt265xBbiPUPZG3K7Wi2E6CXMWAiWsMCfvxCws+xiZUDNB8LTP/R
         CKJyrO3xe/VltWdksWd7jdFzcN75JYXVpKLwMVCnFOx99VtPoflEu7qp0euGT481Wnu0
         xwiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792880038; x=1793484838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3O+ZaCjsZjNt3tOPpyIAOxnfGLwcX/bFih0NJX6uwEU=;
        b=ZQwjbeF8Qv90suRT70N5WiAwu1xduAeg2pR0M1uh/84tK9XlFa7qfPsqMq/r/OcQe2
         5PthqT9yPZfqklSuOUeNKJSzsqXdfbWkMW+iF93nYzhwMQWfS8N+mNVXxnwql/3k6aN0
         VMvs9ly2qr5A6hnjO4ip6Xd/YG78YdwEmJMChiA/VpP2Qa5fsVviExjmDHAhUvrIDBZN
         cQpoxg3I90+wIsX8O28Eod2l9t9ioC3rMxX/mtKc/g1tdE1BqfH6TSxO7ZBpoaApByxb
         YUKP8x+pE5tndlfqA5Y+1J3NfY9OAX5OfLF156Yz4gZ+gu5lZmAMxrGBBSPrpxmTRodS
         vvBw==
X-Gm-Message-State: AFq9FYKsxuoMCYFBDt5OahWxM3inZXCu4Bj99LoHfptOcW82nu8JLum6
	gecsaugEBEXEx8d2JS06PY2Y8L+RUsI2rWoTNfhydyP9FTRVPycbIZNRhZjODfgwatQ=
X-Gm-Gg: AYBFou0N8LxjEpbQaf+9l/irXkD9+fNze6Ic0LLyd8x5vU5T3qAZ8hkwz7QvmjscNsX
	tiF264Z7G1XWW3E6TPQisxP94u7BpldjTkLhO5LZLYykp3L6HisFTFmg7KSHcdpIKwPqiUUBgJv
	r2upAMf7fQo3ErbMzs+KplJpzKcHvdvyyV4plpmJOo0YxYtGxLT2A8mXm4QEzQ6pDyeBDWiR0Zb
	sJEd6MMnjI9KNWFDN2VE/fR3OMzxXIWhteshZP3DeGDtIfXmesJiXrGWwg1qZtJ8Hxya24HTgbI
	Euspqddq9XTGSJpOrBeaZWreaQEwT5nQMgy0pJGY5yloN9E4o3H+xXNLvqYG6nMubL2tpy28F3F
	IZ76i/37jGNK6D7nXvVYrn18ZOhLEszM0bGnMxn+m8F2TK12tofZM6HHVju+SiMHF1rQR9gpO5N
	HXW48TBpKFoW/uGMTckIPViz/++1mBfUG9rZfSFYHC+uWUfnrFXIKaLAjY0zLXnmhlaqiYxSGMh
	w5T4pIEEdsWc2Z6Ld4N3/rISv/+8Rlbe5BiA53sB6RWjug7muv6HwzpeE3+WlBx5u1ticV/uKav
	Ps3Q2JK7FAw8DDF8NYJnUn5lQq1rl85RSmu+hudzYgwyhCMM+wJ77dS+JwL1gXbuVON9qteS/yJ
	vdbnzG1XX4dx/5fu+7tSGh0iH3goZ6xS8lFWsM+SqFmdLloU9H7GRUO8=
X-Received: by 2002:a17:907:3d56:b0:c41:23bf:18af with SMTP id a640c23a62f3a-c46bda6a064mr379221666b.5.1792880037795;
        Sat, 24 Oct 2026 15:13:57 -0700 (PDT)
Received: from localhost.localdomain ([104.28.251.98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd4e7c94sm133745966b.27.2026.10.24.15.13.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 24 Oct 2026 15:13:56 -0700 (PDT)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Subject: [Outreachy PATCH] diffcore-rename: stop using the_repository
Date: Sat, 24 Oct 2026 23:13:41 +0100
Message-ID: <20261024221341.92086-1-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.56.0
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

diffcore_rename_extended() already has the repository through
options. Use its hash algorithm when checking for empty blobs,
and pass it to start_delayed_progress().

Remove the USE_THE_REPOSITORY_VARIABLE definition.

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
 diffcore-rename.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index c797d8ed2f..f0ce6e14e5 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -3,8 +3,6 @@
  * Copyright (C) 2005 Junio C Hamano
  */
 
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "diff.h"
 #include "diffcore.h"
@@ -1424,7 +1422,8 @@ void diffcore_rename_extended(struct diff_options *options,
 				 strcmp(options->single_follow, p->two->path))
 				continue; /* not interested */
 			else if (!options->flags.rename_empty &&
-				 is_empty_blob_oid(&p->two->oid, the_repository->hash_algo))
+				 is_empty_blob_oid(&p->two->oid,
+						   options->repo->hash_algo))
 				continue;
 			else if (add_rename_dst(p) < 0) {
 				warning("skipping rename detection, detected"
@@ -1434,7 +1433,8 @@ void diffcore_rename_extended(struct diff_options *options,
 			}
 		}
 		else if (!options->flags.rename_empty &&
-			 is_empty_blob_oid(&p->one->oid, the_repository->hash_algo))
+			 is_empty_blob_oid(&p->one->oid,
+					   options->repo->hash_algo))
 			continue;
 		else if (!DIFF_PAIR_UNMERGED(p) && !DIFF_FILE_VALID(p->two)) {
 			/*
@@ -1567,7 +1567,7 @@ void diffcore_rename_extended(struct diff_options *options,
 	trace2_region_enter("diff", "inexact renames", options->repo);
 	if (options->show_rename_progress) {
 		progress = start_delayed_progress(
-				the_repository,
+				options->repo,
 				_("Performing inexact rename detection"),
 				(uint64_t)num_destinations * (uint64_t)num_sources);
 	}

base-commit: 7e34d8174dcda3435d1404c9a30bef46afe6c13e
-- 
2.56.0

