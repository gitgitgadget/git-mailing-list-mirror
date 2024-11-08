Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF1819259B
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 16:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731083107; cv=none; b=r2ADc8oU6UwZKzEz5402zpfyxqVeMgyGZEx+JXlzXMsI7OiPhPBK/PDFjzPSRmUMhaLGKJNA114bzaLgzBopZs96CEMtNlJetOTEmTsKr0r6WhQkY+kQ6rI9ZTXG7BZX+8kR2WovnfbzWGilk4RnB7YWTkR0TvkFh5M8ND/dqUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731083107; c=relaxed/simple;
	bh=DMMQh7V1oDuDvCYzO0NDaRD3Dz4Evr6CC+tuGinKoK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E0/Uqqphbl62x+LY3Ej0pwtzcQWLhgfQG+2E4g89xxmPp+qLrWFTzp13RhPdwfBqEa2ou25/w/6MKvoTMt/yrl5nDk2Y3Jdm7h3+2fV9W4djJ7nJDRseEXT3jX2RRv0ZTw4Xjh4AyQttoRI7E2LXX6H8qZEJrI3fBtcIVmj5nuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6YzaiwP; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6YzaiwP"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-46089a6849bso14841771cf.3
        for <git@vger.kernel.org>; Fri, 08 Nov 2024 08:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731083101; x=1731687901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhK6fj0H2pwBr0NBtbbGdg3r2mhQKP8KxlbU/cQf5Iw=;
        b=Q6YzaiwPxdPqVGVGxmDIzI8yP1VHnEQAbSotbfhXTRWhlncL3QfOJAqJz/B4vOEd/6
         14NqQsHdWRmaUqLQKKOSuFR6LK4lHS0uBkp+yKqYcuB1ZkG5Im0pAr3KMSDnUPlciEL7
         9WlAqMIt9QBeqY19HGn63XyOdAldRnSTKQTnIUHHoxnS+O++pypqEsPBFHmZCh4hhSBT
         u/UbdFewqj5kPIfJvvLWwnotcovPrWSxsldusF879KbdOMx8D/CA2WPCqrrdtaY7JjbP
         hk8m1cuefLVP2mWKxHjs+T/4wEHMsIFvPLhoum0k09ONKl6vqbfoUMg/Qypci/nflUpZ
         Z/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731083101; x=1731687901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhK6fj0H2pwBr0NBtbbGdg3r2mhQKP8KxlbU/cQf5Iw=;
        b=VTkdRaWr3rm31ntQRpzj7YwIFcdvtgoPMxK7PW9Wx61yIA1Jr9ZdY8ehiUyd03lA6b
         m5nfoFjUQ1CU/3Cnf8Y7yzWJrsShVp90/fD5lLyhgzGkTuOyMlUmgheEw6G7DJIM9bz9
         95RnIGPZy+JS35On6gTaHlpT+8/ai87udNFpbAwdo0OioWEOLZp7Jr2jmt1nfcg3Wv0T
         b272luDFxD9K8a3+Pb3CFI5tUSez3COzfAyblci3y03vHJ79YSWTDOKz73aR6YhrxpVD
         TYqhU2r69sEzR3uYNkYtiicGKITdRlPB9PERloMKGt1wIjMiq0FVq9YjgmDl9EjHAY70
         JPTw==
X-Gm-Message-State: AOJu0YwA8slnGrywgZ9m0TLV/k3J6yzH/C7ecpI7Pz5+mLBkTRXntAsn
	GFCe8MK/3umcKxpdt5y2Yn8sVm9cZH9KFr0bgKiJLmxs2NMGg8lcrttKNQ9Y
X-Google-Smtp-Source: AGHT+IHK1AmRrMuQwYELwK8z+NDhmdmUiqx6sWbIbcr46cTnvOgmrap7UGLmykxEwNFg8bZtBnKTSw==
X-Received: by 2002:ac8:57c1:0:b0:461:636e:ee90 with SMTP id d75a77b69052e-4630932677bmr46212901cf.21.1731083101173;
        Fri, 08 Nov 2024 08:25:01 -0800 (PST)
Received: from localhost.localdomain ([174.95.142.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff3ef11esm21928711cf.15.2024.11.08.08.25.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 08 Nov 2024 08:25:00 -0800 (PST)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v6 3/6] fetch-pack: move fetch initialization
Date: Fri,  8 Nov 2024 11:24:38 -0500
Message-ID: <20241108162441.50736-4-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108162441.50736-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241108162441.50736-1-eric.peijian@gmail.com>
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

