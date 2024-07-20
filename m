Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2764DC133
	for <git@vger.kernel.org>; Sat, 20 Jul 2024 03:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721447037; cv=none; b=hyHk57v2H/a3YQ7EX9/4J2gC9HhFeHTT17V/VugnszMaBVsbkLhVpzxM/6drmL/TkCXr4vCfkZe9osFLPI58mE0Tv6SOq/Mnz805szSzyvsLHr561Nws6k6uX/dFiKaHbp6HqhF0KkSwVu6VhINRP/nTJcQvh6vXDHYdTb/Ch2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721447037; c=relaxed/simple;
	bh=HWeG/ivjt1g5ClaOquTXlrAteavQUo29TeRLt8oSP4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WE7ZGCD4I0QQA/bGficsCRzo/7U9nkIpr/NNeGv+Fsr5dq4PXp3UwAk/RTQByUZgOd+gIJkjiDMvHWk4wVJXtH/ulee/898AFMfnrnwDHTSht8sdfnR0cWxzZa+72NvwgotMHNUHHJZkptN4q4DVKUoXhUvy16Fkz80lxZrDHeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKkKfZji; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKkKfZji"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-79ef72bb8c8so101297385a.2
        for <git@vger.kernel.org>; Fri, 19 Jul 2024 20:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721447035; x=1722051835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXJpSg21NiWZjerNEeO54cx2aELRqlPQgLqFicUJJKQ=;
        b=fKkKfZji6o522Rd1Pm0+/IS81Ex6egKdn7itoV2UWdqnPayqvh23BJqcGAOSvw2uL4
         18GSxIS+2UFoTKNSRfYcZmrL5Wo6ALrrJ2P9DK251nBhjgCRK9vBofofJDr/qV6pmJGR
         Hw/omeL+XwJLhBDYTihXMYI83yhZ9pJ5IAU+JKQm1Jvgzh4ReKH9y6Hc0Y9W+W3SSxio
         kCKPv/M+v6KMJd07mhEThLFi6CAH9tEx5mq/SV5vyh830pc0Ox7gdaQIXl6luanfKGBl
         T3pKcoRpR37cSOUsiRR4FehXVXWdwtf9oO0925QBq40ckmY6bqFDMPsf7Uum4blwbQLB
         Lggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721447035; x=1722051835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zXJpSg21NiWZjerNEeO54cx2aELRqlPQgLqFicUJJKQ=;
        b=qU2NYTy8AeAuB8uUPtXLHUNbbC5LRn7e4fFYCJIYT4tmVsD/aM7dlg2J6Irzuu1teM
         QRpg+v4Iu7YIpMIwZvdqh8Q25Cnsd7N6qd5MEuxn9qC+86h0xCTVKa5Qrjzt9edUn2bg
         GuLqh3L+1YwhKRvyAtplPeJxFNQfmdSjEFeWD/4tdmC8QN1eLiOOnXP0M5IgDSf3KNC6
         CCTjW5fBEnhTcbqtYqSgjcVJHwD99fS0fxfW95onn/5hVwVQEoPsPkgU0aET95KCUyUE
         YwS9BczhFlHgMMgUlB1x73yf7st82AqHt7nlI0yD9iVgWDM+UrDkQbZiLxQaU6Kb/xNQ
         B8uQ==
X-Gm-Message-State: AOJu0Yz/Hf8TKzAW48MYEP6yjzdsnefsNt7ZCk6VPRIwetvaucHol3x1
	Bo14cM4P7O8xG2cUM4/yHJwV4uhxO+ktouvO9jM+9vYHVZDSShjii1Wa94+7LZM=
X-Google-Smtp-Source: AGHT+IEozT0sDFtu+uemyHJL8o1apgQ9P953yY2Tdm9PA9W4GFLKB2+tO3HaIvrMJcIVvy+ZmlB5wg==
X-Received: by 2002:a05:620a:4249:b0:79e:fd16:6b74 with SMTP id af79cd13be357-7a1a13bea4fmr259572485a.57.1721447034802;
        Fri, 19 Jul 2024 20:43:54 -0700 (PDT)
Received: from localhost.localdomain (bras-base-unvlon5586w-grc-14-76-71-94-205.dsl.bell.ca. [76.71.94.205])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a199073b49sm150487385a.100.2024.07.19.20.43.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Jul 2024 20:43:54 -0700 (PDT)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v2 2/6] fetch-pack: move fetch initialization
Date: Fri, 19 Jul 2024 23:43:33 -0400
Message-ID: <20240720034337.57125-3-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240720034337.57125-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20240720034337.57125-1-eric.peijian@gmail.com>
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
index 9c8cda0f9e..a605b9a499 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1675,18 +1675,18 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
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

