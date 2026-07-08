Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C63D3B95FA
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 17:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783532994; cv=none; b=FYaBu3Mi/w0RRgNxvBLV2hLAYvYtB9UTnVQ4dRcJ5jikEOg1JpMVgjIwoFPN/EiQXMl8k42fN/vuU2xdFM6UKQ46hnODpW1q0KgnU18bd0YZnYxhEXA8CvAtwV3a+bOeOS54roNgb1IKJuJ3A9sv7smBJ4i41gkan6mT9od7cJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783532994; c=relaxed/simple;
	bh=8ePVFv1ZC234Ci3mEMysTcZ+1WGeCLucWD/rB88EScs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cVtwUyYvFjsl8/9hCzH9d5aR4iiA6GnkfxndO8tzXqfCtFuOmYQE4hNbiU1e+Ze3bcCCgvCgbYYGyK38BRYW3g8rfo1+bsylaR5NublB8++XQ4NXkXQBc732SgJqW7vZYDlHQcdLGmCs5641kg8i6T8gjvp6CqQPrkAXxNM4FtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sy6LHsXm; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sy6LHsXm"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c2a76536bso7415691cf.1
        for <git@vger.kernel.org>; Wed, 08 Jul 2026 10:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783532992; x=1784137792; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HrQmnZ/fosIbHnThR/u2r/itVPhMiVUJoOFWgEMe6Ow=;
        b=Sy6LHsXmJKwP6rR65RY19hqq9A1n41MSvIgpbZubBpzlhtYMd92+BefiEdVavp3sv4
         PE167nQr8G2zl/2vUU3cphgaZjT9g60nYcSQurToB9NKMxgmpf3QqX2DTuTEPiQ82HiP
         cHG30W010DvjiNfvdDf16ozHa8DtcZ3gdcPrwrMy/P6fY8n0E82Ik+2ecBRKu5AbTdqd
         29lEHM2eiKs6MP5ryIl0GJx7Qt6ffbup0DzX02MbKjSrC6KkjMaPQUyvxSON599nvPxF
         dXUSfYu0BnuB/bZRk/xFDcQbbI2a0BDYKcDHH0WUFPwEOvTS43j4pVwo0nomd8FPmXcT
         REww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783532992; x=1784137792;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HrQmnZ/fosIbHnThR/u2r/itVPhMiVUJoOFWgEMe6Ow=;
        b=Kth7WPd9xkk/USlyMPdLjSojGTSr36USjV3LUlZlkr2XeHJw2BhI3HFLSjRD8SnAxu
         r5VzG3DTJKuxOIS7gXz+XIbtY45MwqTZhqkopIGsVnhbxR7+f69V4dbWew5nk4tE/G45
         hYRMMKuIIGnmcWjgS3my5RshXl11ufhlyiRO/+ZivoCA4a1nR30geQ/jBQVxSEIfvfgW
         schNggcEc/jKtQhmT7iXiIYKWfslL9CG9mqYgF4m0pud7G6c2A2DBQZv7T5mpdYq1SUu
         YtWtk1kpoiDF3KwzEkvR7Ux6qjK3NvzaW6MPlabQN7pZMSM4TQvJtFgqX+0kVr5AXuvp
         vI8w==
X-Gm-Message-State: AOJu0Yx8yG4aXdgo5X4SZqv+JKFNJhKuba+Z7tYqsEYDcvnCWrciJw9x
	XfYC/eYRQFU9hvdi2p+ZyiFZi8ce/nXZ8bA4oSCJw5+KxlHhV7dtv5oHp6Z8Jw==
X-Gm-Gg: AfdE7clbym+8Dv3txH20B8eXYqhenmAUYniGejd9in5kHBfCwKzsGt9SEFGQxqU9WlV
	f+N7HNUf/Hg3OT2Q++ii9RlkcXlf7iBwSlHA0UoucUem2b6dHdMSw6WZX3plzuDr3yPkXiHr1Az
	sCQx9ZNTCKXkj3nsu4PdopzGwlA0n/tD0QeCNfe4AlYSoRwUoHwerT5k0+uqW1P/abJ9q+Ycdyh
	Y4+2BRcis6aQLrXZRwc1LlR4D3619MstGcXi8T4mZF6thprLw22DTG2h4HPUEw7LMQdfiM95zHz
	vJv5/h2xO3MSwgChDWNsU0BtM7EQKfHreAgwMWONruCPT2Ur5NdN/WVNCHDeuLAtRah8F06w6Om
	Elit4xSwya+tRRD8Dhyt3nLDeKAuk9IeZG/+21MZSv8syDDsBMuBW8RQPSAOr69tJMo5tK4m64C
	LtjA/PvdiQfnNE
X-Received: by 2002:a05:622a:1911:b0:51b:f549:c70a with SMTP id d75a77b69052e-51c8b3e1b60mr38769371cf.23.1783532992404;
        Wed, 08 Jul 2026 10:49:52 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.47.18])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f472a9d8c0sm186534776d6.49.2026.07.08.10.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 10:49:51 -0700 (PDT)
Message-Id: <89a22c6a7532afa530f1c04ee27177e141dd360c.1783532989.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2132.v3.git.1783532989.gitgitgadget@gmail.com>
References: <pull.2132.v2.git.1780301856444.gitgitgadget@gmail.com>
	<pull.2132.v3.git.1783532989.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 08 Jul 2026 17:49:48 +0000
Subject: [PATCH v3 2/2] prio-queue: use cascade for unfused gets
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

When flush_get() removes the root without an immediate replacement,
use a cascade-then-sift-up strategy instead of sift-down.

Standard sift-down places the last element at the root and sifts it
down.  This needs two comparisons per level (pick the smaller child,
then compare against the element), even though the displaced element
almost always ends up near the bottom where it came from.

cascade_down() instead moves the vacancy down by promoting the
smaller child at each level (one comparison per level), leaving the
vacancy at a leaf.  The last element is then placed at the vacancy
and sift_up() floats it to its correct position, which is typically
very little work since it already belongs near the bottom.

This is the well-known "bottom-up" variant of sift-down [1].

[1] https://en.wikipedia.org/wiki/Heapsort#Bottom-up_heapsort

Helped-by: Rene Scharfe <l.s.r@web.de>
Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 prio-queue.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/prio-queue.c b/prio-queue.c
index 926fc04e85..230d6f5e33 100644
--- a/prio-queue.c
+++ b/prio-queue.c
@@ -66,13 +66,31 @@ static void sift_down_root(struct prio_queue *queue)
 	}
 }
 
+/* Cascade vacancy toward a leaf, promoting the smaller child at each level */
+static size_t cascade_down(struct prio_queue *queue)
+{
+	size_t ix, child;
+
+	for (ix = 0; (child = ix * 2 + 1) < queue->nr_; ix = child) {
+		if (child + 1 < queue->nr_ &&
+		    compare(queue, child, child + 1) >= 0)
+			child++;
+		queue->array[ix] = queue->array[child];
+	}
+	return ix;
+}
+
 static inline void flush_get(struct prio_queue *queue)
 {
+	size_t ix;
+
 	if (!queue->get_pending)
 		return;
 	queue->get_pending = 0;
-	queue->array[0] = queue->array[--queue->nr_];
-	sift_down_root(queue);
+	--queue->nr_;
+	ix = cascade_down(queue);
+	queue->array[ix] = queue->array[queue->nr_];
+	sift_up(queue, ix);
 }
 
 void prio_queue_put(struct prio_queue *queue, void *thing)
-- 
gitgitgadget
