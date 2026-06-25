Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CFE3E1686
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 12:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782389632; cv=none; b=BX4Kp9BLtccrC10cS3mMy3hC5/FKXGTsTAfWIVa+x5seAMKDVvBTLbkqg6XHdWi6b6O1F+o5/OcxJAQHcjQKzwyKo2S8MQSdyS32m8+rVayusTMr2z4DWoyNoQZTtXCFcirK5gRc6gAKwOVzE2ncLhAMs8PjKI5QUM89vp15CXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782389632; c=relaxed/simple;
	bh=qVsxIjzdSm1tnpJ+Hdj0LMHjlX6xueOhi8gHhIP+9KI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XzcdCuhNrMKbr1pYb3jaq2rZQWO1bOALhy7yC62VVGzBzFDiuu8cYrGJCA2tiQurRHIOWlcN8yxQcEUzmLpA6QTRvkvtwLUbyKrPH6dLet9jiJM8W2sJJDay8xyJxGN7SBM6ag/+dSUNg8rCvk5j8ICpjTlql7djpugk75db6wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nCHHrK0O; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCHHrK0O"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4923fb1f095so21543315e9.1
        for <git@vger.kernel.org>; Thu, 25 Jun 2026 05:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782389629; x=1782994429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONz0+rxJiVMHDlVHhyHdpbDKsJS59tsEdI8qwaVj3cM=;
        b=nCHHrK0OKSyqT3HjO5XKFWoRJToEwRdXNSXfnAABUEWJvOx6Bn9wudmcrM7nY5fVe6
         c0WZveUA6YZkWQcoXsw9cFmNttSYD+NaflzXlQ5bQT9bwV9EqvHtO2L486257Scz/ttL
         i9OuWdS87co6LPrOMlPOr478VNFadRvNyZQRgqQCkesorKjzXyhy1hzVvUk0KGgn+XgZ
         ygLrlga0uVE7MecIjK8VD89S5sOl71jj5iWF6W3DHPfy2PZD2qoLVXzd0xK8oWn8LcVK
         j0ghF4vGql+y3rrkvml16b5i54v2PZrClnXk3PVXMngLcubNSNUaXz7j7a+orM+TV70J
         HjvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782389629; x=1782994429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ONz0+rxJiVMHDlVHhyHdpbDKsJS59tsEdI8qwaVj3cM=;
        b=PSB+w+iAsV+/i4u0x7hUgGfp9K3IcHvTVZGtX+5iQgxvs9M5qGZPskOfCJpyL+qVp1
         5lOK57wqKck8DbXqOT8O0D7vbvk+SkMMs/y7oZxwU1LN+UvKnu7KmUPx8YByiRGTXZ5G
         mogxQVkUr0oRpE/q4nfNu3IDtvtTQTN+uBqjeURrC3jNwJKuRVufHURV6U3tjr8Tb4eD
         vj9Ir7nLuWZpaGignyArpqALLhykE2NWhkAo+5SpTycdEA41ZPvER2tO3uKE1GXr58T2
         4LAQnJnW7IgQA+yWb4X3heRL+IRKT+q0zIoJzaGl8/utsz3S7Tx70D8T7jts1/unGRta
         jCYw==
X-Gm-Message-State: AOJu0YyfnjhqF7VdaIL2TnDB/1UVpbtj7gzoU+C1XO3xFZ39zV2VEoB0
	erg+nsvW2k29eZYsfQycjdz6J1PXMeRRaLw3LR4ZCi9mx7ixJ01uijBYB53Qddl4
X-Gm-Gg: AfdE7cn4rrEc7l7z5fR9F5f6TVcPeSXvBNtVuQC5aqx8Pd8E7CM/fEABnIE3qlomDbY
	SsmguZF3VMMOkJQ2tdgz/RXytiszyJcADxiGrg508VKHU8hMk26wLtHEqRQNZZriIPkYrrcA1tX
	1E9/uqP+4NHosChdgs5nfhVR33HU0K04ADCAVITUowiayjYrMnTJkuk/+WcZnUDzB9g3CwtEunT
	WTadZUv5g/NKUWcttWphkgMvhWwXsUO/2WmKvYBEkPfUMbcigQapvF0tagLhESxgfHpfd8O0edQ
	sdiT/caSDjvusjKquymiAgevLaSB/w5SHtIgwOeUbbmNk/6qQaz9jP4HTJQLNmaJlhr2NkVBG3H
	x/8Rd7667+EmfiI6eTwvM1Gsl38SySurPYrDRVX3hRmsxmP7ov8eqyPtB8GwMp+/GqznL4B7GlE
	Q7lFsnM/UjJ6Q6OhADYfDVUHpks3rvGlvEbCKYgCl8Y4IWf6JSCVwdJ3ofRLcuLfQu4HLGtQhPa
	jmM547yPhEAiI0dBpmJkpEjmzpC/KQd5W02OU8zkB4ha24Yc/Nc8lBK5Z88rbe9BKuBMq92ExLs
	kpbbF3Zjq6Trz+bFYtZcHZCU+nQHRM/hyRLEAvNgexEdVwFsnup5ozRmIbar9vYlRyez070PH+0
	J6tQBD+pVng==
X-Received: by 2002:a05:600c:5486:b0:490:601f:d776 with SMTP id 5b1f17b1804b1-492668628admr30614165e9.3.1782389629071;
        Thu, 25 Jun 2026 05:13:49 -0700 (PDT)
Received: from localhost.localdomain (62.174.236.137.static.user.ono.com. [62.174.236.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492660adaecsm62207245e9.5.2026.06.25.05.13.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Jun 2026 05:13:48 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	toon@iotcl.com,
	Calvin Wan <calvinwan@google.com>,
	Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH GSoC v14 08/13] fetch-pack: move fetch initialization
Date: Thu, 25 Jun 2026 14:13:30 +0200
Message-ID: <20260625-ps-eric-work-rebase-v14-8-09f7ffe21a53@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
References: <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
 <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
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
