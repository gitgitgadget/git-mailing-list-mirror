Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CAC54662
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 19:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719601544; cv=none; b=NTrP22YjzCCiwYmT27UMtEESS3pIipQ1/vB9aDvysibFSrb35PDWWTfbbmhoTm+zFw05BO1Qoh6+twQv4BT/JEo7CfAtssTWdDpZdgLPPjlN+OyiCHAwljbpelSaAslcND0qDaEbNH8fLYE43fK57kFVaKsuQV722ZL2cZc7aAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719601544; c=relaxed/simple;
	bh=v5wyCHQBuLCg3n1RvRotf2Bds2mIKPfLnXxXAkv4vVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=htmg+MSYszOrb6wGcmWVe9mF2086amOM7ahQJlLLOSx8XtG0e0xQItMo3jw0jMXTOitTPGvKMBuphqN3NuPDV4RKRRmbr0bL9K368FgtpiaHEEV++Yyo/wJd+TVWOHrdwCjJmrfEqw81PZXN9/EJDLCna111GB4Zigle0vcy17o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+SJCliq; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+SJCliq"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4449beccc7fso5527241cf.0
        for <git@vger.kernel.org>; Fri, 28 Jun 2024 12:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719601542; x=1720206342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UeYBkhNyTT/Qoi6Sa0KM8qxv2snYCjXxbxnvtVkZMqk=;
        b=a+SJCliqooS/7Jz0MFuEgN2QZgqKFNEos/LuuJJD5deF/YSR5+X5AhBHBw4Hs+12Hr
         4Hk3vpj1Vrl7kRlndxG+BHdRWmIjH9foyF6eowHEFrIQy+8csPi06xeQEGja3UsYpiTD
         FX053UoJjO0arFolTAVjgUea1OTt0dmUEbvshuNI8kfnBzg+kEJpRHtecc7riu+7Xv0V
         f1BBfPEfER1zCevGuwcryZArGW7x0nFyshhhkaUmi/t8hxAtSTaVx3BPfba6wBhmziyG
         KJ264FGJP3yjuOxGqyL/TN4p5h9IJbstMepXSJtTKydZVY+JSBKVHTxvNqAUBObgNIkF
         goeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719601542; x=1720206342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UeYBkhNyTT/Qoi6Sa0KM8qxv2snYCjXxbxnvtVkZMqk=;
        b=QiS4RGUiBv9Xukoef06JvccNfi6BekvFPFoMWGKX9R8uN51yPQ9a9bsljRuunZRwFB
         0skZA4R4aevWpeq5gvsV1QMXfz0G5UCfwm0LCA4HFDKBhF4mQhJm0yscKKSj3HZmk0jf
         chRWCqGoaTBEGdHltUDganmsUV5EcdCesPAPd4f4H3W1H6Ntx3ztq+ehHMCmU9r1G+5x
         7se6p0NJ0OgZggWWCVbd6fSFopUHtJPUXjdVAI+1MUmjgkqiwp/xvKizwVCoo7IBgDgE
         oVlTKVEPmkM1il1/uoMhjlmb3oGI/GoiPtneiZKS04/LZ+g5/iZhn7z5+a7g7ZVcIHQH
         hzRQ==
X-Gm-Message-State: AOJu0Yz/9eP0fUyLJ1KTId+7mR+TEXth14itsdjZaBRglowmNkpHem2B
	mur0i+PEJXroE+hEss47ZE+rOkz7XHZ7uWcVXA1HnxEztepsDTIqa4/yN/Wt
X-Google-Smtp-Source: AGHT+IF3gzkB8jiThcCASfzX7SbjCXiINZAJ+80CutYnePwbXHmwse+F3FAmfriwx9Aj9qZ2XnqHrw==
X-Received: by 2002:a05:6214:20e2:b0:6b5:2b33:5445 with SMTP id 6a1803df08f44-6b5409d9263mr247308286d6.25.1719601541725;
        Fri, 28 Jun 2024 12:05:41 -0700 (PDT)
Received: from localhost.localdomain ([76.71.94.205])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e574cc4sm10262346d6.53.2024.06.28.12.05.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 28 Jun 2024 12:05:41 -0700 (PDT)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Calvin Wan <calvinwan@google.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	John Cai <johncai86@gmail.com>,
	Eric Ju <eric.peijian@gmail.com>
Subject: [PATCH 2/6] fetch-pack: move fetch initialization
Date: Fri, 28 Jun 2024 15:04:59 -0400
Message-ID: <20240628190503.67389-3-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628190503.67389-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
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

Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju  <eric.peijian@gmail.com>
Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
---
 fetch-pack.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index fc9fb66cd8..da0de9c537 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1676,18 +1676,18 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
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
2.45.2

