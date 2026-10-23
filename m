Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792727812;
	b=wnmMQGAbO+Xt1UFQhhv0miis43HT4RbLYtCxWCoi+KuTtIr2x8KK03kN42skvxIGzf0r
	 7k6U7KjwlJQPb2R1ueIxGCug2A+9tdDx/dyAqmjnk5jzRvT4gpwtaBavFpCjEeY7Snmmm
	 L/IPYOGdqdfsGS4+2hkSRf91Oxp2WJxbVCthDrUOpq8bJJ/me8u3OHv/N9RL2PP0cns10
	 DPOgjFlzK5Jpspy4ypR2l1tf3HXODEU8MIUoN70zeK2zPz47wQ6P2GqHqWT2hVybvf7c6
	 +K3K3T8Qcm7tlhsFrSuuzRHf53t14JoND1Rq9ECLLTvrl9q8TCHFRFeDFuRmjGzIK8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792727812;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=IfTH7qdUMgoZPRsMixH4FpZWBlw/I37Vg8OCfck+L4c=;
	b=0Dw39ADzTgFNNZlNiCXM92o1/mLHqMunP7wsTzfZNNO9t0wXMwwrIiqV5Uzo7SoMxIQh
	 yd6zMC0mhnDZQcBpW9mAwTG9Ll0GhoYDZwhsybmx5LYPe9m4ylFQ1xcQrT6sDgLSWzM7Y
	 jgNkgYEGUosMHYhZNNxEnEmQYwBEL28xeCeF/fX4FTleUOl9sh2iZ5q0Qrgc17SXwAULW
	 RiTyC5/Qw6GlAKRrEuTpxwyWXbw5DHyGVwFO2A+vB3TMNBnlPRyAqqhvOsH4nBF1yaIpe
	 Adk7C52gRXiQsRMNnWQ1uEAEmBMZ+l7STJ9KhwmtBRmLE6UVWZK4oi8maBD7qD0ohyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ELJ1VB+7;
	arc=none smtp.remote-ip=209.85.161.44
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115DD606A319
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 03:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 115DD606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ELJ1VB+7
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6dde81a6820so327438eaf.2
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 20:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792727811; x=1793332611; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IfTH7qdUMgoZPRsMixH4FpZWBlw/I37Vg8OCfck+L4c=;
        b=ELJ1VB+7Hf6Q1wVuTNzCXlUBZkgbDvTO3ffS1ygn/ewMUW6W0ZZDU+5vMUgQHAswEi
         quMzgv71MGFo7YPEjewmz65D7KviZKg8zJljUpYTgPkgsnh6kwQIbNJZ02iOEyTwfnC8
         KcMhj1xJ/rYvmAP+qsEYfVpL7oM9oGB0JTynnnUgNqgW9XzN6IFL8VaJ18Efe9ctS+ay
         VP8SBzzzDrb17z7DYUp247+DpLq5/RjqBNLFpkVe2Ovynm5rE4/oKIgkgypfCmKHQlFo
         ZAkcBtagxIevUA4OWxddsUrM8bZoVzY2zAWvGhDDZatA5tnefDo7cmACRjJwtWEwPlzA
         ldVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792727811; x=1793332611;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IfTH7qdUMgoZPRsMixH4FpZWBlw/I37Vg8OCfck+L4c=;
        b=Mvwh5VvpV0QLXOeuXIyOIhp2VqpFzhgS3boEc4PN7VE+rB0xiiLyWaPpDtRijX6dV2
         cEdJMp0WRgVASIBRf+0tq+leX/HvUjP+y0UfFi1lMNaJz3DVgT5aU73AMrk4vYg/ENHa
         qKHrVEmIRCmme19vY8x++ZKlXbsi032dIZA8MNjvEDO0ab2hpKgqbyuBB733KikWm5aH
         HeZXMZ/GljVPx/RdJNgdngQUfj/7Yvnk730mxFIZiKQqzo+Zv5ttqrxtsgtXVfy3q3LS
         LONjmzGpL6paMuxAW1vVraaIzRQxn6++h2gXlnI5Z21655q45FB+3g3zYIJoDfTXhWGo
         26XA==
X-Gm-Message-State: AFq9FYJPEeC2NhMrZLHBmJOksAbDfCeMl0dE4QS20iCasAvyEw2DA8l3
	6WPOOLnlAewQInN8s7vHj1DrL38K3cCELoiq6QlcDjvnElCQJWMOgMSqHeCV2f4D0TE=
X-Gm-Gg: AYBFou0cXpXx5KcEJ6PJJGJlwsr2aY69q8j8dEZNz2OP0my/lFAuxQ+t47l0yBSlQvC
	e0H9aMVSpOj6P++UY1NHsd/7fwzXgB005DU7f7YU3HzCuX7UpuQy6Md5rwbIgZUEIQKgaJL99f0
	uHOtQjzxwTIjVeinukTHag4ny3dNfO/XS7fvIlUQujacOGuYEbhvU4QW/m+Hvkg/x/rZbB43UGT
	nQHZyeMQ0R/Xy2o6kSTqxx0DLAOrWVYWAkk5JloAUPXueqMQ/OV66Y47LZm4PXCYK6EOcsoBstk
	d6zNVXZqJsi27y7hh2ejVLpisKAgWpA/Z3bzTXrMUSJp7WIfcO9BRgWacp2YnRlYHU2xcx9sOFq
	ngQZgAF9YPbMmkxz6hDJzWhmaAzG1zaT9v6j9jXDIKE9zrYbh67YaYHFURFdDA7iAWDhOxX2e7r
	C/sblLT+QanOn+LbNt9ImNd3mmpFAXaW4Ca6FlX53+wmAkpc35i4u9RBssD0Tc3q7wnIR68+5uO
	JwL0TOb1P0oyyQ59w/tGbqtPryEzWGv4s+ONYr1Jpcam29Ic4KRQua/AS4=
X-Received: by 2002:a05:6820:a016:b0:6f8:124f:d4eb with SMTP id 006d021491bc7-70b88ad5cb9mr759473eaf.69.1792727811024;
        Thu, 22 Oct 2026 20:56:51 -0700 (PDT)
Received: from [127.0.0.1] ([40.80.212.243])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-70b8b346990sm954611eaf.13.2026.10.22.20.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 20:56:49 -0700 (PDT)
Message-Id: <pull.2276.git.1792727808109.gitgitgadget@gmail.com>
From: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Oct 2026 03:56:48 +0000
Subject: [PATCH] [Outreachy PATCH] diff-delta: use safe integer arithmetic
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Srujith A Poojary <poojarysrujith@gmail.com>,
    Srujith A Poojary <poojarysrujith@gmail.com>

From: Srujith A Poojary <poojarysrujith@gmail.com>

Replace manual multiplication and addition in create_delta_index()
with safe integer helpers (st_mult, st_add, st_add3) to prevent
overflows while preserving NULL returns on failure.

Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
---
    [Outreachy PATCH] diff-delta: use safe integer arithmetic

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2276%2Fpoojarysrujith%2Fc-refactor-target-name-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2276/poojarysrujith/c-refactor-target-name-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2276

 diff-delta.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/diff-delta.c b/diff-delta.c
index 7cbedeb507..45df070ab9 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -162,8 +162,8 @@ struct delta_index * create_delta_index(const void *buf, size_t bufsize)
 	hmask = hsize - 1;
 
 	/* allocate lookup index */
-	memsize = sizeof(*hash) * hsize +
-		  sizeof(*entry) * entries;
+	memsize = st_add(st_mult(sizeof(*hash), hsize),
+				st_mult(sizeof(*entry), entries));
 	mem = malloc(memsize);
 	if (!mem)
 		return NULL;
@@ -258,9 +258,9 @@ struct delta_index * create_delta_index(const void *buf, size_t bufsize)
 	 * Now create the packed index in array form
 	 * rather than linked lists.
 	 */
-	memsize = sizeof(*index)
-		+ sizeof(*packed_hash) * (hsize+1)
-		+ sizeof(*packed_entry) * entries;
+	memsize = st_add3(sizeof(*index),
+			st_mult(sizeof(*packed_hash), hsize + 1),
+			st_mult(sizeof(*packed_entry), entries));
 	mem = malloc(memsize);
 	if (!mem) {
 		free(hash);

base-commit: 47fdf2208c5b94c8cc01c106b8f7c85efb91c926
-- 
gitgitgadget
