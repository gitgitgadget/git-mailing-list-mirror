Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8C0253329
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 19:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740164721; cv=none; b=PuytF6N6KEW7Ol3Nq72nYrsJc7BGO2luzGnUe/5oWgKe0+EId739B5Trj+mucR3sKRooO219UiWXB5zD2H7pYwNsjywCWW6aI7pjqYpbKXPdbwAdjlpEN5pC5VAEPJ1m1H803DVZ4JYUTlMOi7A5oA9sMaBgi5R0D9Co8xRMoaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740164721; c=relaxed/simple;
	bh=Ta2SdK0VKTJwcutYpIweqDKNyyy8FQzaKwg6QdoIc+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jzcub0uLn/jS47x8TNIT7/BtTA/byJHvcm0DfGJabt4oXnBuFeZ04Z9ZNi7Sm2cUJeQyCbv+Pwo/oN9Pm6U19btRc8uPVk7uulJzbOhyAdEx9dtmDQchWJrQAXS3sbNs+MLy2gZN6xFbwmiyscAjwgv2NjHZ9RLRhhlMRN05XnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C44WISwE; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C44WISwE"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-472087177a5so30634011cf.2
        for <git@vger.kernel.org>; Fri, 21 Feb 2025 11:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740164719; x=1740769519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEjCHL98ZHvqyXVYNHcGtHiDJFUhnynDHrJTzoC1nT8=;
        b=C44WISwEKmXkpgW9ACD9UGVFjV5mpZlv40tdUkXw/ZpRGHDF3OHqPIycgGzypVuImB
         2xUAtw10mGhI22Diipl4FgIByUimpYLXGnsNm+XZG9tcuyownOSIB1PugVqjimYeaHkB
         ZpAQGGMTmw5UEbPbzg2jQa/sVcPUl3kWRjnjBR5nH8+BLZ1MP6PjmHhvLkX1kjFVL1p+
         Vb5f4jNYfar3ZY1YU132yT9GSa0FDBJDiJyxcREAmCWfWgM1OkwAKGWCfhjFYTCCOqu7
         718dNXtArky9R3Liib+/fuWxpcPHO9zJsdsb8YHtDBzuwxtztgCovzq6XL+A2skwCrcP
         p8dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740164719; x=1740769519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oEjCHL98ZHvqyXVYNHcGtHiDJFUhnynDHrJTzoC1nT8=;
        b=MXh0EzsqH/wPGUCIUyDUIscthtSesj82CPN2wooDiCsZg49LqpPs81P0Ls3xagnCio
         vm0YoTNxG8C6h8dkK2jp/rZNFZBgAGVKTC/BZNb/Wy1h+ee4p0/oPTjBbghMV/6TgdW0
         kj8YgJ7gHQvDtTxLzdTKPLsuBWvZR29jSz/jh/GJnkBsgGlS+2tMREGpBCG2gvmrYEWR
         VEKbhMW1M0YpYT4sgxz085dQhScyJ25fr54SKD9hWkzGnZY+YVB5YGVN4Icsh9aQ1HBO
         0L40c6xpj21XkFUdROGMgabbkXB2xzhD5lGrscXAW2yfDOFHkOrEvUxfrIc8dksS1/79
         m9Aw==
X-Gm-Message-State: AOJu0Yy4t1kpIeX3wvKRakCNMFrDS0ihO0V+uOQo6+0IpVDG28vmF2vp
	ia8muHdnyWLFzs7QCH53AFHu3wpqsafz3IksnuiVU9VeKDX7fgWCEN1Z2PMxrq0=
X-Gm-Gg: ASbGnctkbV3o/f12MfSjk/YUpdZjnryTMhnWVNEJrXCb0AMBO3/Uu+ntgqfphS8fJqm
	M6cPkFxdE+UrR5aXvUftYyi9/OxpbXQ8afCTMZRRYNQlGkKSioQ1JCmV/egrvWy72TUmJ0SSuRz
	zy/lYMPSx+2OnvEjv1FqiTMza4fau8AYlUiXAFQytF0drBZRfp8B4Vg9WLjJckaBgc6vVIurdUM
	oKuWgGV6kGr+n9ULoXl1dyo80igMLXHGb1Loas1lRhQQGMsqwNCpwo+PqTqkIvNumMnhcYw0VHC
	N3CyL23h3xfRsfuWALQQ+GGtQOF0jtbUCRzNBFlyXBNBU6FU60TN
X-Google-Smtp-Source: AGHT+IHUA1xxxeDPHpXOQytDJgGGng8PM6cwvVXi2sIwQU0VPimnQk3FyD/XXAWdHhAnAarvceXqcQ==
X-Received: by 2002:a05:622a:180b:b0:471:f55f:85f3 with SMTP id d75a77b69052e-472228d2698mr67645331cf.20.1740164719285;
        Fri, 21 Feb 2025 11:05:19 -0800 (PST)
Received: from localhost.localdomain ([70.49.151.101])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4720b1fe010sm32945661cf.60.2025.02.21.11.05.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Feb 2025 11:05:18 -0800 (PST)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v11 5/8] fetch-pack: move fetch initialization
Date: Fri, 21 Feb 2025 14:04:46 -0500
Message-ID: <20250221190451.12536-6-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221190451.12536-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20250221190451.12536-1-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Calvin Wan <calvinwan@google.com>

There are some variables initialized at the start of the
do_fetch_pack_v2() state machine. Currently, they are initialized
in FETCH_CHECK_LOCAL, which is the initial state set at the beginning
of the function.

However, a subsequent patch will allow for another initial state,
while still requiring these initialized variables.
Move the initialization to be before the state machine,
so that they are set regardless of the initial state.

Note that there is no change in behavior, because we're moving code
from the beginning of the first state to just before the execution of
the state machine.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju  <eric.peijian@gmail.com>
---
 fetch-pack.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 19b4a092ea..35dccea073 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1650,18 +1650,18 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		reader.me = "fetch-pack";
 	}
 
+	/* v2 supports these by default */
+	allow_unadvertised_object_request |= ALLOW_REACHABLE_SHA1;
+	use_sideband = 2;
+	if (args->depth > 0 || args->deepen_since || args->deepen_not)
+		args->deepen = 1;
+
 	while (state != FETCH_DONE) {
 		switch (state) {
 		case FETCH_CHECK_LOCAL:
 			sort_ref_list(&ref, ref_compare_name);
 			QSORT(sought, nr_sought, cmp_ref_by_name);
 
-			/* v2 supports these by default */
-			allow_unadvertised_object_request |= ALLOW_REACHABLE_SHA1;
-			use_sideband = 2;
-			if (args->depth > 0 || args->deepen_since || args->deepen_not)
-				args->deepen = 1;
-
 			/* Filter 'ref' by 'sought' and those that aren't local */
 			mark_complete_and_common_ref(negotiator, args, &ref);
 			filter_refs(args, &ref, sought, nr_sought);
-- 
2.48.1

