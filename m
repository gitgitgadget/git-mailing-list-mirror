Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8527A25A64C
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 16:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760374428; cv=none; b=fPYfp0GYYviQ8QYxsFvXRGifYjQmlnveoyA37dTyT+hUG2yCJ8Sqoxc/Py5nTOemfwe+saw8zPAW/TC0tZ1ZbbUWrMhIExZtq3WaOWBF3HzKhsayDrirfQHpecrbEvMyLoJz0dz3sDbJZBWNScIQF26tr1ciLubhUjhQjP/ciMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760374428; c=relaxed/simple;
	bh=rN+7mV2/b8mCrjFVmeKoqJurkM8wdwHx8q+9ZPzZu3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jEFlPYIDoPLwSrjTgs1BinLrbPcswHHoUPWPdAw4M3cRvkFxZ5CLC0q9qxw0m18AsCAueDsUJHmZaEqQ8zyi9s9aKqPz09tLnn29vzRL0g4Y8kWVPFdIMg4oeo73/nrKADhi/Ujgoh3CM6wUCLCYtkCnHsFA+eYBo7OPZDGGP5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aS55QvX/; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aS55QvX/"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e2826d5c6so26941285e9.1
        for <git@vger.kernel.org>; Mon, 13 Oct 2025 09:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760374424; x=1760979224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qpL4HcA+mvaksnl34FeP8KxmYHTrVekCe41gZU+eZq0=;
        b=aS55QvX/zg6S601C+uAjeF8OrxRfQx5o5sT2uXvegn8LAdoUT+xRBSDR02guV+5xE0
         Q0O9dGeuqLQXXzlqzcnFwwtTuH0p3VVckWhVyPdb9uFt6kVYVoi4DbAnhDwE96AaoEXe
         C6pnt04VX80JYxHGTu9Im66ugWhuAsqvqBILD3BGzQ3cR9DlfFx9mUh47l/1ebcz9chq
         6tUILBm8FMl7rueugM8g/bkI03HdJ8hg4XvvxOQiMujkymN+xglpmp7bUl1E/tN797jb
         ktrwvx6CnzFu1NO2GwAFmHuvqU2jTV23XN4DsoovoSh+Jyx7gbPEY4/AZOj9+vfgPG2L
         C6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760374424; x=1760979224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qpL4HcA+mvaksnl34FeP8KxmYHTrVekCe41gZU+eZq0=;
        b=SJ6D9IT6ZSQ14O77BNz5UwjlgxbQyDzJR8gE5mfNeCK5BZkrl2LLPvVhu9sNG8qLHr
         7qmaZ/ggLcI8SmwhW75/CvkdNC8IcW4WvBZKXLWxgEOyAbcNysYTG7gKwdtiRK7Mm2dD
         NbgvyxFgoGfSxwYlDBF8HHkZgwPwsPzNuV/knXCwJbFR8U2oPxEQOHgnk5KIqtYgJ3cx
         7Twf91LhqHnRcp82381NgnV26TaypDIy9a4J98+j7nZsxJ4L3/4X+Jp1LijnqHaCdgML
         cigF6uljgu2ybm60KAIIyFnHal6LR75x4G+WJmUSHnV9aMnqEZ2rp/d/eGLqCeKsLHt4
         FS0w==
X-Gm-Message-State: AOJu0Yy71O5M0ABUBKuSHEArN1rdiEDEYQ0Ecx2fsWLWiD3JXZBVAKqX
	ZsATHs8Z9rAKyTvRtSPZ9P1Uzk21ogkkKcCaWhhIKR2QGvtGR6VxQWxdD8ijtoWzZ2/73g==
X-Gm-Gg: ASbGncv3wUdxMaBJTWWA3cy02+EelnA0akZNeVM7pTxpsqo4qOsTm5YkkK2XTWbjoKY
	ScVeHl0YPV4wxsyhlN4kNn+wt0Wo3uui+NsZthQMR2B7869ZwMqFmkb07RpHi3UIKflfdzevP2b
	6U0XOC/jOKXQcYLbhQjCE88RPvEogwWCvruWrst6/xWJ9zS+XdrpLrrLD3LskYtwfq33yi8U14B
	Bcl0wBAMSmcJX6UOd/UUptu1IYe8mAYROuchT3qH62/GKdDBnyCmuqzMpBM5eKOVOeKpAIbqNK1
	NJoeE1Mi1osxB4GTzghNX3Yei+pxaXxiAihWBeGwmfTCL5O72QqxnPG7bkPxYMjiMkonfP2ewf7
	YfSX7kSO5wsdyZZ3R0Q31SsoFnmloO8PWwXZu0txTkhWsxzTWcz3H6W9o6kcUe5PZVMxask92JK
	QIU0j/98kk02pQ2i9tabuzL/AiCM7fTu1aoHxL1ywbOIfA
X-Google-Smtp-Source: AGHT+IEMfuBp468BJNGTZnJk2xsQ4LFI0Zd4+dv4BnTIVw6XY2J/uGgqucRdkI4qaE6tSx23MURsZQ==
X-Received: by 2002:a05:600c:890d:b0:46e:32f7:98fc with SMTP id 5b1f17b1804b1-46fa9af3656mr119811335e9.21.1760374424324;
        Mon, 13 Oct 2025 09:53:44 -0700 (PDT)
Received: from localhost.localdomain ([105.113.110.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fc155143fsm133487885e9.11.2025.10.13.09.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 09:53:43 -0700 (PDT)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Subject: [PATCH] [Outreachy] patch-ids: fix const correctness
Date: Mon, 13 Oct 2025 17:53:20 +0100
Message-ID: <20251013165320.201333-1-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `patch_id_neq()` function received a pointer to diff options via
`cmpfn_data` but cast it to a non-const type. This caused a const
correctness warning and could potentially allow unintended modification
of read-only data.

Fix this by casting to `const struct diff_options *` instead, removing
the outdated NEEDSWORK comment in the process.

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
 patch-ids.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/patch-ids.c b/patch-ids.c
index a5683b462c..b6b808332f 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -41,8 +41,8 @@ static int patch_id_neq(const void *cmpfn_data,
 			const struct hashmap_entry *entry_or_key,
 			const void *keydata UNUSED)
 {
-	/* NEEDSWORK: const correctness? */
-	struct diff_options *opt = (void *)cmpfn_data;
+	
+	const struct diff_options *opt = (void *)cmpfn_data;
 	struct patch_id *a, *b;
 
 	a = container_of(eptr, struct patch_id, ent);
-- 
2.43.0

