Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6698D1D63FB
	for <git@vger.kernel.org>; Mon, 23 Dec 2024 23:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734996359; cv=none; b=GQJzGVAlvhtsRxJfb+OBnqbB1eQkr50J9NGWud01DS18wq9JUUbeqKIVyfu7OAlKG7pl25BF95GNQZL2BDqaLL/wAu+okQm53wP4r+SyD34LxuQzHyHeJdITOHd3kn3atZMFMPbpIHafSuDf3OXZJQfSN5gRfdsPdh98a5Bn/Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734996359; c=relaxed/simple;
	bh=6v6kmj6IoJTTVenBvDN0ySpPKhvA1nmYwnT31qsuLH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XlfR3HnBTabnV4+E1YinVuBJ+kFZzajmBuKbiH+dSkpUxR9YvHomm0BWJ4XMoEMw/09NN0g8sUJX3mC+JyRzgjDs5XbADEijmMlWnl22z7onBJOh5iCsadW6E3AbdqquULi7l80JLxMPUTn7683zQBdmvojSlcD6So5oR4pXYDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOdPz5G9; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOdPz5G9"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6d8e8445219so41098076d6.0
        for <git@vger.kernel.org>; Mon, 23 Dec 2024 15:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734996356; x=1735601156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BuvuFUMBdM9FyTWZ9IdBTNsQLl3Xz4xTvWGs2nwwYrg=;
        b=QOdPz5G9392EWziu1enROnyht6laBkqzEPYZICEM7Hji2wksMHYG453hMVwIUm0Fcj
         60TygY5Yt646OpsEAD7ph2+KoTCBhO9b9lCTMkWjKW+ikSd4VNzrqFRSrkto4ajAoiyJ
         mXOH3AchA75VWeIemyVoZbnAdnKoG1f31N1yIQw1qMNAxvaaGE9dX+ASzGhiymQbm12P
         JvnssNNcHTEX5rvgrSjNpp+bBiuaAjhLMgpa/BD0lLj8XrUtQP7jrA3c2EemekuxsUav
         DWxPZPI0UJPCViUFGbqPTd4tOexaFZ3RSSNSJUY0j4mp2hoIxSLEr3D24gWPsgk1c24X
         2kXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734996356; x=1735601156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BuvuFUMBdM9FyTWZ9IdBTNsQLl3Xz4xTvWGs2nwwYrg=;
        b=UeFiKX5BCr2I/gvUyCwBl3zLqXfkNSP6UC3sOCY7xZ/v7p9fbKxdZICjWpOS3EbCY8
         1VoPgQaheOOuSq/wLR+MqaqTSxzpBd2/wGiaZWRFG6X2ziqM1Y8hyroDFf8egZm4BXQ7
         4HXF0XYUxheE+Rq0zVDfn0JzrnAno42+rkTqDLYaeuJ+mHnhqvxaiIPIegtj3NKIwJr8
         v+EMJUwNudsAQD9kn5Ip7mrIiWnWT2TO8jbtXXCHn/93chuwiYS9eMj8qkyft2RGNfmW
         ALglqqil5kl/q6Ofc5wBk2vu9BCuxabcSBJ8blb3UKHVQFoSvpm1n8wvHOHq6FSQMnLh
         kO5w==
X-Gm-Message-State: AOJu0YweA5ZDo6iOrMyMRwbvz9CZljgCyA9DYqCoYWM5V6u5exT8J9lh
	1CC4aj5cdgfeyls84AtAGRIpVA1xVyAlcrx6wQjJrs3p3xzCcKxgffBr7G+y
X-Gm-Gg: ASbGncs6Wo4vAmgKn9ZyGQkY1o8LkBA4hj571wIrmL36Jg8+dkCTxvVHC+9GZzcQoBs
	qrxakpiFvpT38HJuyY2GMH64b4+SUbkAS5yD7Ob6c1KQcDj2zME2j59QWlLSM6QemHVOcyJsXJO
	x6WXIkAZKJr3Nm92WJ1adDUpyXEWOUbGddrVeWCJWy4Tq6t14hup4CFQAZupC3v1f7MeXhxajBw
	nuwCBR20nCZPbZf+ARfmFvujVW1fwa5A8t3tgCCeOau/NPeFinGCrqD4AeAPwi9XJNzdEnyJkvM
	NtsJOugKPoHu127hlShULQET8BZVY8NALDQuRFTFxwaxY+nzQdTLudOBkRwgSw==
X-Google-Smtp-Source: AGHT+IFPu9iih5JmnqzLHbRXmm1otgmj4KYZ68hqJ7G4I2DFfl7pkqEri6c8uuITsuKHy3RgHdXsPw==
X-Received: by 2002:a05:6214:483:b0:6d8:86c8:c2a9 with SMTP id 6a1803df08f44-6dd233acb55mr226325446d6.31.1734996356203;
        Mon, 23 Dec 2024 15:25:56 -0800 (PST)
Received: from localhost.localdomain (pool-174-118-208-220.cpe.net.cable.rogers.com. [174.118.208.220])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd18136e56sm47672496d6.61.2024.12.23.15.25.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Dec 2024 15:25:55 -0800 (PST)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v8 3/6] fetch-pack: move fetch initialization
Date: Mon, 23 Dec 2024 19:25:20 -0400
Message-ID: <20241223232523.76236-4-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241223232523.76236-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241223232523.76236-1-eric.peijian@gmail.com>
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
index 78e7d38c47..51de82e414 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1648,18 +1648,18 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
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

