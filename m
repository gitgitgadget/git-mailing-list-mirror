Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F6028DB74
	for <git@vger.kernel.org>; Thu, 22 May 2025 15:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747929348; cv=none; b=kC7tvoD2k22V41GCvKfDJv215XquKzAIXsUm4u/B6Palyg9qPRdhI77X2LJm3VumnwBTsZInOGy2LZLQgRF2gzfpD8j21YJVEWh5MTaXyprg1yL1Rm8rXlC5fRmfXmxgQOVxe6+bAYOo8/qEE1Fj+fLnaDMR5VCuZzbbCsNoiPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747929348; c=relaxed/simple;
	bh=6EO6N4r/3jK6e9OOPCbrnCQ75kYkqqvM9xg6EYqSxvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O0lbq7SVUP6JyKWQY2fLLuzZyumQ5nf5Aj29/mXivMFxCP8f8lIle56BtZrzzkNBCmPMSKZMCsH7yiNATql0uSJBozWftfTrFVmRzdyFveu0a7DoypvZqx/deWEqsAaJTD1Ohw/V5TPhRo4NlRW697OwsEnaBg5NBtxIE4Dr6yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sef/4glI; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sef/4glI"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a363ccac20so5525004f8f.2
        for <git@vger.kernel.org>; Thu, 22 May 2025 08:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747929345; x=1748534145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=agYTRZtuMj3O6/HrEcYOspVRNEJfG0/WCpvvpS2Xdh8=;
        b=Sef/4glIp0sKkNS0nzwhw+Nd//3Pa00wTluE9U1pPL8bilYT8xzsowIMU8kErCjxBI
         CJHOnW6fr9Wo+MvstGb1x7gjDins+MXu7xDA9CeOByZhkvQWLiI5BOPgWA/pdB5BKXW8
         h3wM+7TWm2/dvyULqSLQFfzhevE9uPyYpmYN0eenYbGl9Mbed/IffUTRgqXLbrwdR0Gv
         BViFcImRmBlnfek2p3KTqC3c0Wch42OB1yCbqOAH7V4VnN8cI3DUo16RYcevragUBx6T
         o7U40HSf9kbdJlIkux4IpAG92WeVPN68jSfyAyXcMmMYSs5gh+fi62LQRDPMpqRfRZdO
         RfIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747929345; x=1748534145;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=agYTRZtuMj3O6/HrEcYOspVRNEJfG0/WCpvvpS2Xdh8=;
        b=APHr7Gl66R7gf9vAdbXGkjZM11JQFD0IkcFX2yQl9GuMyJ195dw1N89lw0FmLinA3P
         CafSsIUQNNPT52OloNyUow8ocT45WwpIJKz9s0EgcwmE84D4CLVdiLk4DVcL18d8zbLc
         zcNKEWZrptgp2Z3gcGxofLdfsldQ9xOxJzP6OD1y3j+2legzakvRh66c5dktdqaamnLK
         0W+wwhvekaf8zGbsX83Lb9aspBfew5oXDkYnyjM1iNMoovDJwebOQ4HSavB5eKfkoL1y
         xMZi6Ff/GabjztWa9RzsAutI+6clSy6sAnzqd0xI0LaJ8T7zjvyLlqQWMmd2ihKPdOMM
         Vluw==
X-Gm-Message-State: AOJu0YweMyGiUCldXCHbLyjvjQAejGV/ghGizmzXIz5MAMP9svoy00gN
	muryorl0uDtAhw52CSosoMYTpBPr6hzVreEGzF8GzgCIibGz4FZe3ZLjolLtuw==
X-Gm-Gg: ASbGncvMHdEXBMW1V4KA3afKhXSFvrCnLQTL+O8COOEq47tCPV6YKmB07QaI7DtDBZC
	jxk4IF68q4oZ7dQBsch1ZJZ1wtm0gW01sLJ+gXMy3rKy7RAG7e8BaxozvHRMmYeaHJdlJ5kqeAG
	IwONsi/c2jA4PgDouCrPcEdeurpr1zuD1p+2NFJe4np+BQp+LWpmcm7tux8yTX+SyHituI/JGWg
	MEqLWUZ3EO8nC5435nmnjO+OWmBbMhD6R5gU0QNrnYK9WOEj5w/mhnGlI1gMjT2E9LV3WIiOUXj
	Udu6ULcRbFVWaaPqmCjr0hIJW0sfArx0oZmg1wFGpFqgI4eiknpi3DLhY4e1EfNV0IE=
X-Google-Smtp-Source: AGHT+IEioBbsgTM+rdsmw1siXN2F0LcZCCAZ+2XUHwg2hFaAuoBR7MpgTL6oDzWbAggAdfO6XK+hGQ==
X-Received: by 2002:a5d:5888:0:b0:3a4:7373:7179 with SMTP id ffacd0b85a97d-3a47373741fmr7229110f8f.21.1747929345351;
        Thu, 22 May 2025 08:55:45 -0700 (PDT)
Received: from berwick.broadband ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a369140048sm19253599f8f.57.2025.05.22.08.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 08:55:44 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>,
	Taylor Blau <me@ttaylorr.com>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 2/4] midx repack: avoid potential integer overflow on 64 bit systems
Date: Thu, 22 May 2025 16:55:21 +0100
Message-ID: <54303d96c31fcfde2b6db0043ee45b17223a1696.1747929225.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
In-Reply-To: <cover.1747929225.git.phillip.wood@dunelm.org.uk>
References: <cover.1747753388.git.phillip.wood@dunelm.org.uk> <cover.1747929225.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

On a 64 bit system the calculation

    p->pack_size * pack_info[i].referenced_objects

could overflow. If a pack file contains 2^28 objects with an average
compressed size of 1KB then the pack size will be 2^38B. If all of the
objects are referenced by the multi-pack index the sum above will
overflow. Avoid this by using shifted integer arithmetic and changing
the order of the calculation so that the pack size is divided by the
total number of objects in the pack before multiplying by the number of
objects referenced by the multi-pack index. Using a shift of 14 bits
should give reasonable accuracy while avoiding overflow for pack sizes
less that 1PB.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 midx-write.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 105014a2792..8121e96f4fd 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1704,9 +1704,15 @@ static void fill_included_packs_batch(struct repository *r,
 		if (!want_included_pack(r, m, pack_kept_objects, pack_int_id))
 			continue;
 
-		expected_size = uint64_mult(p->pack_size,
-					    pack_info[i].referenced_objects);
+		/*
+		 * Use shifted integer arithmetic to calculate the
+		 * expected pack size to ~4 significant digits without
+		 * overflow for packsizes less that 1PB.
+		 */
+		expected_size = (uint64_t)pack_info[i].referenced_objects << 14;
 		expected_size /= p->num_objects;
+		expected_size = u64_mult(expected_size, p->pack_size);
+		expected_size = u64_add(expected_size, 1u << 13) >> 14;
 
 		if (expected_size >= batch_size)
 			continue;
-- 
2.49.0.897.gfad3eb7d210

