Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70021E00A0
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 20:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730147722; cv=none; b=uRNFh2WRArBdQgXgyfXTL56hsdDgd/sIgU5rOOHGhKBlIbG8GCgBsqDWyUoSoyrx0RlCTZCGcSN4EkWG41Z4gAsDNP3SZK+PInbtr8pO4DBxRWKbBTd228wrNP+1rjm/vpOUl9gyHhu9SvOpx1+G9do2WFuLfsdCHgWamauSmSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730147722; c=relaxed/simple;
	bh=DMMQh7V1oDuDvCYzO0NDaRD3Dz4Evr6CC+tuGinKoK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5KeZ2/yPeRIM5Obxx3zbjmVmV99VRr9of/gXQT0xEh7bH0qs4opQURL/0x4hH/sl4FcrvMoOSATMeTenX2qb2st1x9T79hkkH//oPm1flN1biO9QMW234R5A7GIh1DOw346PW1jH6RixQTDZaqgBS/BEn5qW99ZdE0DFQ7LaJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfcZyIPT; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfcZyIPT"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-460b16d4534so22883371cf.3
        for <git@vger.kernel.org>; Mon, 28 Oct 2024 13:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730147718; x=1730752518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhK6fj0H2pwBr0NBtbbGdg3r2mhQKP8KxlbU/cQf5Iw=;
        b=JfcZyIPTrG6w8ksM3B+85vcz5yFatDkbgTvfZr9QlGx5nQCzXbOg56vJHhd2SYBivt
         2ffnj8SHCEH56E2bne10KyGCs8jML4gaXUdZt8LaGqXU5DMlBjNauITKk6Vy0tbf6/as
         xv8KQbCBo5nvrhIb7B0cIw5Lvp+BBdFBhU7E4uN84COxPEHxs4WSRtZjxRTJqzgrYqwU
         7+2+J2+nM+PSdZCFTpJ5IPlGPIQ4yCvhOfY6yn0Zn3M6BEdl5O6XQMrKSFnWAKt0WrSW
         NjmMQGEiAj831+8FCMTPLl9wPQK0zHXsYKaypOA9/g0g0gM+UuZP+x1u7RaGUpogRUx1
         PrbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730147718; x=1730752518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhK6fj0H2pwBr0NBtbbGdg3r2mhQKP8KxlbU/cQf5Iw=;
        b=O+j/jbWxgIpDmTiY2gqRg8GEFvhCOmV3sezpVLNUU0M8bKMnxFz7Ynsm8hEBPyVyS+
         kEE7HLfmCCDBwlYDfhfwZCEknuVbP3SveeshHcvTuB/gq9yU4zdmZK5RZtVcbP2GV3s1
         k2uGOR/ptKx+CLymrmeKclLw5TwboOMU53YgWeDY0KRmpKRwe7HcINom8x0Ke9AcOTuY
         46Xbcgrw12iqQcnxUXuXHhq63p1NMVnyOuTdiN0if9O4G8V/3P/t+JKQ4vFzvlhVPsQG
         APUX4UlpQXgmWce6q3btapU6hg+menAOiZAvrf/4NxEm4vjAh4EsM1WDUflJgt4YahPy
         9aQA==
X-Gm-Message-State: AOJu0YzDNHJ2LEc9VD6UNOQ+EG9lPnRspfhoTqECiGndyVfzPI9/8YgZ
	Lji8LDK9FbvIjCuO9m4n4r23IHT4qGNpQjr2gNmQAtpAQ4/N/PIrs7TxiB6A
X-Google-Smtp-Source: AGHT+IGSCVbJzNfX2r+UATdtwddkdDz8TmDF7Uy1XmAQFfmlHhWUQG9jDT0AqmOKeTz3QBVwVKl2kg==
X-Received: by 2002:a05:622a:14b:b0:461:169e:d2f1 with SMTP id d75a77b69052e-4613c1b9ecfmr125402051cf.60.1730147718440;
        Mon, 28 Oct 2024 13:35:18 -0700 (PDT)
Received: from localhost.localdomain ([184.147.230.152])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4613228c099sm38215791cf.46.2024.10.28.13.35.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Oct 2024 13:35:18 -0700 (PDT)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v5 2/6] fetch-pack: move fetch initialization
Date: Mon, 28 Oct 2024 16:34:53 -0400
Message-ID: <20241028203457.19715-3-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028203457.19715-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241028203457.19715-1-eric.peijian@gmail.com>
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
index 533fb76f95..afffbcaafc 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1645,18 +1645,18 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
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
2.47.0

