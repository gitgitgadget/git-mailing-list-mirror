Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6483B27FF
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 14:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781881022; cv=none; b=ils/44E0efVtzQ64QO+giF6l3+dDAfebjmUvLF/bTUBWzwRAXTfHTHCT4FJg3OlhJeK1hHvcd1Dg/OVmQ8pORfmfX9poGodjsTCazskn84mrJFwkGZmtQ1QA5VTbqthrckcvT1+x80UCmiOnZujFHUMR6ZLHsGzNj9wFfAjWoKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781881022; c=relaxed/simple;
	bh=qVsxIjzdSm1tnpJ+Hdj0LMHjlX6xueOhi8gHhIP+9KI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tsIDayG5VpLHN4Qkz+Qv2gAetxNnSX8/Pgp/ocv/HO0ykxHvPMZDCS/necMckGRlwP8ewjvE+8PA9jWngDUjiZ7aqap7jBTJHmPkpE9WAvJTeA1MV+0vIfidySNIY/x2HI2Lpih3gNu+qAQxogJN7Hge5L884rSeFpxlmKPrkmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuKAAfDj; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuKAAfDj"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49241a577d8so5751565e9.3
        for <git@vger.kernel.org>; Fri, 19 Jun 2026 07:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781881020; x=1782485820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONz0+rxJiVMHDlVHhyHdpbDKsJS59tsEdI8qwaVj3cM=;
        b=UuKAAfDjvGjmn9a9uZYe4DjL0nBh6eEMrGdBiTg/sy6JuOedpXGFD527lzKXTu4epw
         uwU2uJlRSIxQrytWCH4lB8h85nXPwzb10T8ty+tbPuUau+kyKSILP/H2MQMUQdpQ/PWn
         r57SAbcgzCf6wf9LVOwlVFbO1CmZwCZ2/iF/LokSGI1Qr0HginHm+4u79Xn9LTHQf81E
         ZCVp0S4NZqOHPwmDyGc2tx6Nq9xY4yvtiA/bptwuxa0BJEpI1Xwdj+oqpH2xP6aFsvKB
         taF2SAMWLOSPV/czNbLNAqgLb1hbJPdlaaWoPR/esrdQDhN06KVz98c7dni+khhZGs78
         YD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781881020; x=1782485820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ONz0+rxJiVMHDlVHhyHdpbDKsJS59tsEdI8qwaVj3cM=;
        b=Oj2fg1H72Ol84jR1Jwbbg9XSc7AsZRXNW7Kc/ejiyu1mOvrDxfO4abirb2ZBVgDSUY
         MOEeBDdx186emC+OTs/ChMH/7FVqp/fL01+kCLlvvXxq6yJwqr0nTq+I3yG2L14YHnus
         ZwLndltDRIe/LQo2sKIZCBsilbyHHJmPq0VgMeuzNeJj+dEWUC/P89leyrVNfqHvfg9J
         28DIk8aPAV0aqUcFbVBucvT+oHT/I+gmYv7zKNlqFVJ9kdhdgwldb+8QN9F1atQLjWoE
         hXf93Rz8OMPKXRvyHkGakYDJsx4YjFZS40DgpP4j7+6b2C4qgqvDhWge7J8ddM5J1gpM
         zMzg==
X-Forwarded-Encrypted: i=1; AFNElJ/UrcZe3dzQT70nMABMWR9q2Yoy6Txx+Kz4ienZTyN3xw/S6p0l/IJxqjvqpA+5z1NDJwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFAuKhsTufzC89v9uSooWx12vAnf2Uebugy3+rc+fhp1UKGXc8
	ENVGAfbnAcQZCSjppfgJJNWuQLfI/FVndCtjCKr92DqXKTEGm7QjZWz2
X-Gm-Gg: AfdE7cmpDfiuF0ognZsVogydixZWC3aakqUfvcW5+H1BByKI+jKowEiChnYHu9x9cvx
	OIPB5fsUNsfpP98TgdGEmx9So7ok6Ci1yRwnR/or+imdomyS3Y7OPUa/wIXZ5XA6AQL98G7/uGK
	ZygsHiZFnHODpQZe/RSvDxWMX08L/XPSPmwFrMeziVK8wk4Zr0N8S1etmFSAA8R2vK/uVTkF2Hz
	YjrH3jyOjKFo44bXI5VG34N8A7uH9MjCV6lGUYdBP8RuzDgPK4ttwVRT4Q1WozUN8NI04RiBca7
	RMa7fborCZNiOMVEEfcPTvIGqSUSwNT/CoTTMVcrJjkQw9Y6MDHZ7tNwtO58lWVlFC719fM0/hA
	ROanOcdV9gicHwcjZc52hEyP+mBU3DFKsK8rkh9wwfd9+uZ1vTaPwVJcXrmTz0Qt8aUKgnAmued
	P2PYJWSbcQI+1KI18VkQjxCsRNnATvGGl5TE+NsF1bEJF09SSU8UFEJmKIwjZV+Vt+pngqLayo6
	/e36WS/gMRbNsi9g+Mgp9//sBeeDv1t2fv+Xf8+XnKJ3e71TOIpTCavGqTDofbGeGfnNrGA310l
	OuaUXsPDC7HxuaCSOcsayuSnI+IQ1WcINV9nr+NdgLJP5yBQ/EcmyGf+JlB9evoPGdgQpZNUeKw
	iBjRFqAUcY6au6g==
X-Received: by 2002:a05:600c:4346:b0:490:b8ee:d6a5 with SMTP id 5b1f17b1804b1-49240e20cc6mr40828425e9.6.1781881019301;
        Fri, 19 Jun 2026 07:56:59 -0700 (PDT)
Received: from localhost.localdomain (static-204-100-6-89.ipcom.comunitel.net. [89.6.100.204])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49240efc63fsm39430795e9.1.2026.06.19.07.56.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Jun 2026 07:56:58 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: gitster@pobox.com
Cc: peff@peff.net,
	eric.peijian@gmail.com,
	chriscool@tuxfamily.org,
	git@vger.kernel.org,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	chandrapratap3519@gmail.com,
	Calvin Wan <calvinwan@google.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [PATCH GSoC RFC v13 07/12] fetch-pack: move fetch initialization
Date: Fri, 19 Jun 2026 16:56:36 +0200
Message-ID: <20260619-ps-eric-work-rebase-v13-7-3d4c7315d2f8@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
References: <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
 <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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
Signed-off-by: Eric Ju <eric.peijian@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 fetch-pack.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 3d32114907..cdebd3476f 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1736,18 +1736,18 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
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
2.54.0
