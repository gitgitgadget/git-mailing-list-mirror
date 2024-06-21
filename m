Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EC917555C
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 11:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718971091; cv=none; b=c94ccT0k63iSACzvpLAcXyfnEEiNX9Vr4SAmZQoQgeac8ooD75frWYbBKQX5suwqNyQZjPlhLcno7p/gjiIO/1LpNnHuL186rYTaaTXsCxOAYt9LEAbr2dwKdZ1D568B/TAxKlyEtaIgaFMq4XNntpa5r6UtJgZo8QK1+QMlso4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718971091; c=relaxed/simple;
	bh=Sq5GZ5n4gXFhI+9ReIFRaAxeeXg0NM+fqxYeo+aH5iY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jVzo/k0s8V6jz2VUAd8Y77HOw7jeBeIMjdTE0RpP+PQQYCU3yHkn9rZ/HQbGurYgyHpXeBpgm+kO8FRlcpRnhd6QyiG+p5ipHpxDqZfL3ZPr4QTvMUo1LkB4RBm3QBMafp6pQxMvMFJL2F/38+AYOW2TgnU9MFEJ8H5t/pvH2vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQV6K7LS; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQV6K7LS"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f6da06ba24so14245815ad.2
        for <git@vger.kernel.org>; Fri, 21 Jun 2024 04:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718971088; x=1719575888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+3y7mPz92NANjorhbC4DDbfAxJxgWbgD2KSLpNT8sw=;
        b=ZQV6K7LSQDRjWC0HxDhzMh4DzFItst6rB6smSsxSI2EpLktZ781T+5wmm8Phjsnj27
         VPrdIrLK4oOFqpXZqkn4uZfGoUZReY0RZfM4raPXSrZ1aGx4OytgYyThQfbvZ6pBWvij
         7SaZs8qK4akslyBkwHs3MQocNExk1Pu4mPl5WhMJHYtywn1P4PRxNi7UxmCq8iCYr5l0
         CbdhhFJil4TSfjVCvHskh3KM2fprFpixeDxnqrm9KlBolCo1xx2dtGmemtAJ0fJXQHLE
         oqBCl6P8rQ1NgTyaJyPlZokqsTalHhq48t43fskqqvPEwpihV4BmVKhfu3kcRCu56RK9
         rEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718971088; x=1719575888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+3y7mPz92NANjorhbC4DDbfAxJxgWbgD2KSLpNT8sw=;
        b=SFY95DQ+YjuKFfr9u+MnRocjJb4u/L1qNBfBvHRvuL/IKyPj83wN1SX4MGxCOX81+W
         eSVUWB9r3Ot1tqbnldZbKZZCK8zPL8SXOH59Md1IFiTFQDBP6As3V5p260NTtchW5wem
         CGbpp9pwCxbwJPodYtHtl32V994j1TpImc61Zeso/ydOVT+3M87QIZLVhDV5qtl1UEfG
         qrm2PM7Uy6L/BiTnAub2baefCmrL0TQHMUXSUpj0NFkA82XHYL2CpR7S1EbbibGlWXYi
         0LMPAjXw31Xj2LWmMIIc7jpOgcVSTtxThCS8z1n7ZUHtLk1T2CI8YTEOAo0o1xl9bCJy
         2IEA==
X-Gm-Message-State: AOJu0YwP3GOMaWmdFJ5JGcVSw7dCjT5Wp1NXOOQWrh0T5hohn92hgeFF
	kyDlIIDGkx2gBMMocviT1/nKlfEEtzKKih6qqDGO61+kHYQnG2RSLeEHGw==
X-Google-Smtp-Source: AGHT+IHdq+E76ynceahuWlGY6K1Pz1Zn4T6J4G0onE0f0mtxH8u6AvOb1/R2ze+yjx3gi58Y7ZpNAg==
X-Received: by 2002:a17:903:1248:b0:1f7:2561:cd98 with SMTP id d9443c01a7336-1f9aa47167amr85984845ad.60.1718971088306;
        Fri, 21 Jun 2024 04:58:08 -0700 (PDT)
Received: from Ubuntu.. ([106.206.204.195])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f9eb3c5ee9sm12407195ad.180.2024.06.21.04.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 04:58:07 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik188@gmail.com,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 09/11] t-reftable-record: add index tests for reftable_record_is_deletion()
Date: Fri, 21 Jun 2024 17:21:04 +0530
Message-ID: <20240621115708.3626-10-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240621115708.3626-1-chandrapratap3519@gmail.com>
References: <20240621060018.12795-1-chandrapratap3519@gmail.com>
 <20240621115708.3626-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reftable_record_is_deletion() is a function defined in
reftable/record.{c, h} that determines whether a record is of
type deletion or not. In the current testing setup, this function
is left untested for all the four record types (ref, log, obj, index).

Add tests for this function in the case of index records.
Note that since index records cannot be of type deletion, this function
must always return '0' when called on an index record.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-record.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
index 766431ca67..99ebfafe0b 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -477,6 +477,7 @@ static void test_reftable_index_record_roundtrip(void)
 	reftable_record_key(&in, &key);
 	test_copy(&in);
 
+	check(!reftable_record_is_deletion(&in));
 	check(!strbuf_cmp(&key, &in.u.idx.last_key));
 	n = reftable_record_encode(&in, dest, GIT_SHA1_RAWSZ);
 	check_int(n, >, 0);
-- 
2.45.2.404.g9eaef5822c

