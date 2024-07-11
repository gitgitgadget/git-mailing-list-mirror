Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957A64963F
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 04:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720670989; cv=none; b=VQjDth3pkLCqvEvkt2Lq6l1zxlwlcKuudwc7lSqTILzw8e5eyyKiY6sdiczYyJuG+HJLk8SckvL0g36VZZFTvW96/Jrzqaq7tQp8C4jHKO8UiRxT6KIDkiXensFU5R1Ktq+6sYszBOw1N5xIa6xDs1xM5vFLquzMcpSfQfPGtmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720670989; c=relaxed/simple;
	bh=87klCzSTbrediqyqHtkAjIc+2bmYERhxJvizzC5tyF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=odAQrgix4aQJrgLHR8eSrxrSJS5hb/GN/Xb6K7MCwVR7A3lueSxyrt7mlj3R9FWtPSbyWxmYzYRYGqiIRQKOapzRXkVM6ezg/99Es6h7Jvnv8uiJZ+R/RRLJaxmelRyDzrhEXM0iPs5ca9VHql/cyNBdYFhH40Tds706hFwHgx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqpVPRuj; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqpVPRuj"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-70df213542bso253493a12.3
        for <git@vger.kernel.org>; Wed, 10 Jul 2024 21:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720670987; x=1721275787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdKIEcp7iYQzcciWp7cti3GIS7qLWBiX/oOTwmZ5/VY=;
        b=TqpVPRujyOWaXOdaKSQNEKQOF2gluraWawtlgkCP2p+SD6HCKhCoVUH/hjE/I/e13S
         jieJ78wWAE62MPTiqVOm4jxSR1FdzBijm+RHJi+LGGmEbz3uSViJxTsXO71jZQaNHfmo
         E7dXRl5W1cWWbWgFrDptIDYPvHNHM8WHYuwbVRPkqqPFpZtJ7UIeSY4lDNlgSUz4ThLV
         mR4gnPpyND7CD7WICNT4lcV1XM22zXZ5m0kisP+4ngY1AJpYm4aNzngTbyp8JfvReTe5
         Ge6Zlsd1MhwDBcepf3aTcDV07cNbfgVSjQGHN7+zZUGUCCAjVQ1Q3WK6o2Sj4U1qObVC
         Qpbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720670987; x=1721275787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LdKIEcp7iYQzcciWp7cti3GIS7qLWBiX/oOTwmZ5/VY=;
        b=SEcC+fp+VyQB3uwB284S870EBOhnSdf0ENn+1X8bYch7qPO0BZEYTD82aNTbhN5Dq7
         YH/w4+/kSdPiAXWWlJURk5mRgOh7CLYsnWdknqblwtZmYIjiWkoqCMPbItX5CCPjRyD5
         omh50xuJdkdRuaXYR7paUvVaPyV/74tcdBkZ9HTlI1thDKLmO+9O/ahBaWWNoMM8Xv62
         jyFWbDC/8bPo+LMmwilrsbzUGwUYb7V4z3myMuyLfHF9fm82kRCJTqBSDjp/zA7GxDX5
         g9nI2ia3IJ/SqMZi7SaKCLRhEYwNRHTqrF9ecGB+kwA11TNr2Uy4yM2GXl65gquLwnr+
         x7EA==
X-Gm-Message-State: AOJu0Ywx41oHO0TOdG9u1O+m1mturZW/x4I0CuyydVQ3V7o0Sw2Kby0p
	UDUfciomdk8lYOVAhWH1uu3/ILzdBOfN4FCPDJrSEdeCT77g1w4hgQDCL/5T
X-Google-Smtp-Source: AGHT+IFOSnF1yfoqgPsmDcKeaN5h67jywpv5uazJgQ0gOiS8vdiCFxQzhsPtHo+lnBdvZWuju1Zatw==
X-Received: by 2002:a05:6a20:a11b:b0:1c2:8cf4:7664 with SMTP id adf61e73a8af0-1c2982438bfmr8230075637.31.1720670986604;
        Wed, 10 Jul 2024 21:09:46 -0700 (PDT)
Received: from Ubuntu.. ([106.206.206.104])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fbb6abf738sm40808595ad.198.2024.07.10.21.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 21:09:46 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	chriscool@tuxfamily.org
Subject: [PATCH v3 5/7] t-reftable-merged: add tests for reftable_merged_table_max_update_index
Date: Thu, 11 Jul 2024 09:28:34 +0530
Message-ID: <20240711040854.4602-6-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240711040854.4602-1-chandrapratap3519@gmail.com>
References: <20240709053847.4453-1-chandrapratap3519@gmail.com>
 <20240711040854.4602-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reftable_merged_table_max_update_index() as defined by reftable/
merged.{c, h} returns the maximum update index in a merged table.
Since this function is currently unexercised, add tests for it.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-merged.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/unit-tests/t-reftable-merged.c b/t/unit-tests/t-reftable-merged.c
index d151d6557b..ffc9bd25d2 100644
--- a/t/unit-tests/t-reftable-merged.c
+++ b/t/unit-tests/t-reftable-merged.c
@@ -236,6 +236,7 @@ static void t_merged_refs(void)
 	check(!err);
 	check_int(reftable_merged_table_hash_id(mt), ==, GIT_SHA1_FORMAT_ID);
 	check_int(reftable_merged_table_min_update_index(mt), ==, 1);
+	check_int(reftable_merged_table_max_update_index(mt), ==, 3);
 
 	while (len < 100) { /* cap loops/recursion. */
 		struct reftable_ref_record ref = { 0 };
@@ -365,6 +366,7 @@ static void t_merged_logs(void)
 	check(!err);
 	check_int(reftable_merged_table_hash_id(mt), ==, GIT_SHA1_FORMAT_ID);
 	check_int(reftable_merged_table_min_update_index(mt), ==, 1);
+	check_int(reftable_merged_table_max_update_index(mt), ==, 3);
 
 	while (len < 100) { /* cap loops/recursion. */
 		struct reftable_log_record log = { 0 };
-- 
2.45.GIT

