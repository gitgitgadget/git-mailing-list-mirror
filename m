Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF463CF02D
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 10:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780913699; cv=none; b=C/49tLC01d0akuIQf7tLlsIrqUx9FS3UFpfMm4tdE5nxKeNYQSZPOYGe3dhtLOdclU6vvCzw5DiB2DZzGW1xkVfdgdE1OJPj5O0a3a1BlDlrNziyzUSN2+wp+g6kPiyxl8JqkhCudGzVvdVvyKkrIqhOwGyq9LNKixblB8JbUnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780913699; c=relaxed/simple;
	bh=qVsxIjzdSm1tnpJ+Hdj0LMHjlX6xueOhi8gHhIP+9KI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NRUBbeaj4fsPPXsq4B79pToqwOral3V2lE0IntdsNlQci21N4jAWJgE2wl/rAr7oI6OOpEiq4gPXw3sqsUb2Z3kqFBlTzbDfDo/BKDYh6AUwuj9Diho7yp3IIyjlxDRlbLDwuiq6eED6GY4B8/yZlpetHa+kbcVotRdjJlGTX64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QwLFLJ6b; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwLFLJ6b"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45eec22fab7so2045011f8f.3
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 03:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780913696; x=1781518496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONz0+rxJiVMHDlVHhyHdpbDKsJS59tsEdI8qwaVj3cM=;
        b=QwLFLJ6bs551x5ZWx2VPy4E0BjrntB6io5l4+HGwIx/1MZPl1fWwJ17tXx4D87kuVT
         pLymQIQ+FYvvc8xzb0ad0NMuCUef1Ub5EMwEzyfVudWUDa8Nw0C6gqOMuAXBDmDz8Bif
         fkz8iDwZV8IxgTtEuKDyGucMs51ehzebnpuwfCVUaJte/cBhWdmR7Bbyryazrv075JPa
         /FsekbY97OsvKXjch0ukQ4amJjELVPdnBGqCDKWrfyRlfSOUlEU6kWUFuRPLNelCuNlh
         aB7cQDMjpBNQeFIFQ+94pjeDQp3XUlA8fYvxCMfkGCLZg0Wcp7k9h3PYTWdrzQP9QRBt
         flOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780913696; x=1781518496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ONz0+rxJiVMHDlVHhyHdpbDKsJS59tsEdI8qwaVj3cM=;
        b=imRsa77aNZa8tHefYAa/40PAdLdSxs9gUmzeJgrB+7OLxFrjnfbsX6L7EN1PhOqHBx
         xn8BazuzdyaFeqdsQZGl0VzBmQ06ltSZGxyc1HmN8H1IafEt9lFyhcRF7cBkwuEO9t54
         NTjiv7MWwcXetVOEyh8jL3932tMXG+QqGHGeZK4EJJ+2AgksERfB6PB+ob+n82KJPq4c
         MLwl4vXXnDSJIEToqM+LM20aYvS/4MhFBOY6BuieGXvP6i83C8ssEb66D8NnfmmTS2zc
         TVVQXqPFos2aOChDtS5ifLRrFaFBIJVMVKYlFKUymQJOQGn5r3rxii99T/q7WfRGanRK
         8DpA==
X-Forwarded-Encrypted: i=1; AFNElJ80qIrtkwzib9xZOUeSd9/8xqkOxPwmUpneh0pMz4sDNj8T0lIb4b8Q6mQ6ZQYgrPFC02Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTNjSQiHmuns7VTq95OGv2Di7crt9amTY93n8FwybRUxB1mcYU
	fluUb6lzkUP80Iyb/cw99IYRSFDfNnYr/o+N7feRqjH2eU7UNNOXcG+e
X-Gm-Gg: Acq92OE6lIY0pZmx1Hb+mLo2Cy1TxWtyTeweLGmVn45hF74SZ7G0w9CfoaDqyn9uCK3
	7jkWQgMAmnJmT1XCWbv8YYvuB/EuxNaO/MmnxZD/jsLHW1Q2t+bVsd+vIwzPhkhVkm58DVMqNwZ
	QwG8bsVqeIHtTdyumI6AuPxpc2ZePssjjzZK67NB2cAzWO0Eo2plCKQj4FKRwckRvnVMPh5dDQr
	5Xlh31lUfsu9KFa1/OWaeMiYRkKHvgjq2wMJfG5nWthEt5qCaHDvX9+7vZUo1anVWZOMRYjMvKZ
	ZDZB0ZDo62uvY1kzPcMhxpGcnEJHBnYm2LPmp6sissRBs67/s/ShZat7lhz/xuC1DVpiurkODnP
	oOkxx2nIKhmyR83JtW9trP9xMFRyMeejIocbgHiEa5JL/F4zld/BpsCt/lXj5tWXKS3QifAo251
	UCA8poBLEpHfuh5UQD0/hFAbi5gr+pe1CG8YXh+lWMDWDKHxRtolp4lP3Nu/qDswWb2EDIqDIYb
	Uqy6RuzK9TRYwniro2SfF9FpZxgQdXF1ho1obA7Q7N4yDTSvmLJDKGTW/Zh1Px7JoBC7PtRByPd
	CJD/KrAE8r9/LH/DZXLkk3M3XzqMsrz5Fr669G+TJfEHfUL7gJ82irG8UhxuOZocEbFuiNvihf+
	r
X-Received: by 2002:a05:600c:8b68:b0:490:bad7:3634 with SMTP id 5b1f17b1804b1-490c25e1104mr257990825e9.19.1780913696495;
        Mon, 08 Jun 2026 03:14:56 -0700 (PDT)
Received: from localhost.localdomain ([188.87.4.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f0a43e9sm51131949f8f.0.2026.06.08.03.14.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 08 Jun 2026 03:14:56 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: eric.peijian@gmail.com
Cc: calvinwan@google.com,
	chriscool@tuxfamily.org,
	git@vger.kernel.org,
	jltobler@gmail.com,
	jonathantanmy@google.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	chandrapratap3519@gmail.com,
	Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [PATCH GSoC RFC v12 07/12] fetch-pack: move fetch initialization
Date: Mon,  8 Jun 2026 12:14:30 +0200
Message-ID: <20260608-ps-eric-work-rebase-v12-7-5338b766e658@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
References: <20250221190451.12536-1-eric.peijian@gmail.com>
 <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
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
