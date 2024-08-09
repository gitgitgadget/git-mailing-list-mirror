Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA7E19309D
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 11:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723202034; cv=none; b=iodxT4T8BUgsKCeqCVtEpM67BRkjzE20BDB1rp9sNhNC7lkiQWCE4KqKNO5goUOMPusDJW3tC8m/nnLam+E9RKnVK7Wso0kX/Vq7qjoULv55imEslosRtQ/G/x1hv2Sq5sX3oMBkd2nNkMcXi7p3s8homWYnFPB3REe6aySi60k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723202034; c=relaxed/simple;
	bh=CS77GZaKmbqjoRwfTMFlhcsQ9bukzaXFxtqoDthO32k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rcWv0bDxtXzIoiHVwv0mb0Lh/uYPivcLVLCZTo4baZHS2LGnVk3BwRzuY2jIBuKOuE4KmK9347tIoWWW/ybsUYEv5evhOTuk/RP+wePyz25hlIBuTSGOgMiU6HABW23mT+rDs3TaUCT5oiRKryt8MQKA5+3lB2jpQKBs9XAKQ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWtySYV3; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWtySYV3"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3db1d0fca58so1286161b6e.3
        for <git@vger.kernel.org>; Fri, 09 Aug 2024 04:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723202031; x=1723806831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ay7cmSxiwFmgG+lInLAEoiXWb4RJh7Hitfijj9jFTcw=;
        b=nWtySYV3kwHoTKzGN6c9r+PjTpbt8qsVtO47xe8w7cjYnBL7aEerzV+437OIZRIACk
         o1kSkQYY5XQXxwSdKbHTvdA6rG//ICUQPlwzcYzpeWiWsNLVIt/FKQSGeb9ZxTGTJz8B
         GplP/tdys+e320B9E0bk8vfND/61tGLPSwZJI/ulV7uAX2ZioJ1U0LwzHwMWCNSqA2Lj
         8pvU1l5y6eHiNR9qwaoUofcQrOSuvFIGYAHQ6udvHXHsur0nzY91SMlKxSWcXcWCFQTp
         ILM0f1YPmY/1rWU5Pwz3yU9xC6PSnRO8mLtnCz9v9amgGb85xFOrv+CS/0PTMudzgJ81
         DukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723202031; x=1723806831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ay7cmSxiwFmgG+lInLAEoiXWb4RJh7Hitfijj9jFTcw=;
        b=KjL32raJ2E3c1d1VLcoEN3cRmdzB4Uv9VvED047J3oRzp3cj6Ho4Uk5jgIZIrqZnsX
         qaRyLiT9I9M8QTftyTpqsk0j0/WApmlwvPvyF+ZMPFROIpMtyboxzGULeFkCPiKzWldb
         5rU2of8gqhcl0ONbfffzThhJHbrCvcA7PIXvgtNIy3JCokuPT7pvZFYAPjkdy6w7YBXK
         2VU47vFMbsdogXcoFmwVDhFf/cGWhVYs4hKCJXuBqW8McTCAoQavNWbV6pgsnUVreFo1
         76RhXTFGwDdcad+11A2ut/0eZHZzbLESsnY/zSmKWQiT4mRgZDZMRNd5YRVjAV4sbfSF
         aPUA==
X-Gm-Message-State: AOJu0YxlecUs1ufDvaqJAsTE8bBIxVRLUklm75IusyndGkKgdoc2Dq6v
	HHv7CbuOJyBEaiVvgtMLen7HKJzKEd3I6CbVXcZHzXozokNawcL1h/1Hff8t
X-Google-Smtp-Source: AGHT+IGdt9g9PvdfNekkVgzK3TZ+ACzhZ8EzUt4APiAzr4iQLTQs30GE3vm1Y3bMdYEVzZ/yKmrTig==
X-Received: by 2002:a05:6808:d46:b0:3d9:2e63:8330 with SMTP id 5614622812f47-3dc416ec079mr1173063b6e.43.1723202031185;
        Fri, 09 Aug 2024 04:13:51 -0700 (PDT)
Received: from Ubuntu.. ([117.99.60.199])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-710cb2e74d1sm2490377b3a.171.2024.08.09.04.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 04:13:50 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 4/4] t-reftable-readwrite: add test for known error
Date: Fri,  9 Aug 2024 16:35:44 +0530
Message-ID: <20240809111312.4401-5-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240809111312.4401-1-chandrapratap3519@gmail.com>
References: <20240807141608.4524-1-chandrapratap3519@gmail.com>
 <20240809111312.4401-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using reftable_writer_add_ref() to add a ref record to a
reftable writer, The update_index of the ref record must be within
the limits set by reftable_writer_set_limits(), or REFTABLE_API_ERROR
is returned. This scenario is currently left untested. Add a test
case for the same.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-readwrite.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/unit-tests/t-reftable-readwrite.c b/t/unit-tests/t-reftable-readwrite.c
index 7daf28ec6d..a5462441d3 100644
--- a/t/unit-tests/t-reftable-readwrite.c
+++ b/t/unit-tests/t-reftable-readwrite.c
@@ -773,6 +773,11 @@ static void t_write_key_order(void)
 	check(!err);
 	err = reftable_writer_add_ref(w, &refs[1]);
 	check_int(err, ==, REFTABLE_API_ERROR);
+
+	refs[0].update_index = 2;
+	err = reftable_writer_add_ref(w, &refs[0]);
+	check_int(err, ==, REFTABLE_API_ERROR);
+
 	reftable_writer_close(w);
 	reftable_writer_free(w);
 	strbuf_release(&buf);
-- 
2.45.GIT

