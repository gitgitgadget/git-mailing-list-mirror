Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4F1172BC7
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 11:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718971082; cv=none; b=JsFZbpFxIGGMI5xsRomCQ3lAgT5aOXLcdJ/O9vqu+kTCPXbNavlqZWhcp7Xoc2LT84A+eJ1MKMzTImD6iP8+Nfo6ho+LqvavDBOyHb0o1zikcup7L3MZS5lBFe31VfvQqa6tvF0CRqdcFNsr1I7TVhtOkQSBHg9g8WQfxFoAwKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718971082; c=relaxed/simple;
	bh=0KGmpyY77eQcUQF5ZB3LaGt6atjQSoxI7Grq13CmUQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WCpGiTVQpkkz7KT2ybk+N3o/cgG7Os2sdRt5/MynpQrHokDtS1ZH2C0jnKVaqxAvNG5A7RHvncu2DInZ/Ix6OuRdk9D10xqhkgER9j1dYr9VagIDuGheqFBocOJ0Mq5G3lRufyO/CUFYD3BK6O801jgjN2yL4LXFx+GRuTk9d2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QyeZEhy2; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyeZEhy2"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f480624d10so15583305ad.1
        for <git@vger.kernel.org>; Fri, 21 Jun 2024 04:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718971079; x=1719575879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRF+wbaRaaKwoot8inbQdv64fAvqiwZLW0ytW9NdOC4=;
        b=QyeZEhy2gnVGcFbg+kfqHbo7LEhTZmWB2JrD3h3xu9E1zTQ1L6IAQFcSweFeFnRobU
         BNJt+T9s4jYw9gIa1DdBszFYzZpNejAyXTYVwyHo0GyDj/9Ni4lf7UQc/6ObNN/mZLY9
         qR4rowKYJ4ktvhCg0dmUEGorX0zvBFz9Ohta2i+pgd2TEoUA9RqfJFD5SLN+462l54jK
         8BeW72dhn8mH4KRG2/8INZakE2A1lj4VpiavNPX6IHg8ayH7yg48PeIhaxS4OYXbcUBO
         aY/Nc30UPJsrVkReKehwJIDbh3NFJj7Qs+N3jqKJR6V6TS2M7jrPYfviMx9d+ILdP8l1
         AZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718971079; x=1719575879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HRF+wbaRaaKwoot8inbQdv64fAvqiwZLW0ytW9NdOC4=;
        b=MlGdK4Qg+mmeY4eoS1wIea+0YekR2kTyF6GHLQGKV3yJyAWyx37Q80ssnXSynr19m5
         ov6nflSGFFIWHC+MDUL5NZl8AgE2YmurfKiqWleDDphw1laOCi9F8TaDyZ1f7OcaXxdv
         Lld5eaTJdQ8zOh8A4tmp5wNkT8YXHOOexwX63UBPYlINOSLEDz7bLR1ue13mnESzIFEX
         9zIG58o04XkJ3xViercyl+BtwR9wd2IW2GxcWuzzcUtB4i5VBi9TTzB8ggcp4X8Meb6i
         LjxFZQ4LSA8UqL1l8oKynUF6Q8h4klWUYbJhR1rM7wZF7h80RXEP4oRaojUJ3XgvN42u
         cbnw==
X-Gm-Message-State: AOJu0Yyywo7dtczV8MhVD6Q1yQ4r+KdaRoTF+jiZvw0YbrazdwW6Uup2
	MujYyK3oXESsAZIUwpLf616aHO8GOpK1TOC9jbzlOQo42w67/hvLZ/JdtA==
X-Google-Smtp-Source: AGHT+IGRO06Is5xQDRH7gfNSjeXJk0MGQB/PTyKtbgWRALCaSNhcyQ+DksWrUhFV51x4MiOqjmYDCQ==
X-Received: by 2002:a17:902:b7c1:b0:1f6:efd9:bec4 with SMTP id d9443c01a7336-1f9aa3cedd2mr67794595ad.19.1718971079295;
        Fri, 21 Jun 2024 04:57:59 -0700 (PDT)
Received: from Ubuntu.. ([106.206.204.195])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f9eb3c5ee9sm12407195ad.180.2024.06.21.04.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 04:57:58 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik188@gmail.com,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 06/11] t-reftable-record: add ref tests for reftable_record_is_deletion()
Date: Fri, 21 Jun 2024 17:21:01 +0530
Message-ID: <20240621115708.3626-7-chandrapratap3519@gmail.com>
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

Add tests for this function in the case of ref records.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-record.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
index 1f9c830631..cbc2ce93b2 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -108,6 +108,7 @@ static void test_reftable_ref_record_roundtrip(void)
 	for (int i = REFTABLE_REF_DELETION; i < REFTABLE_NR_REF_VALUETYPES; i++) {
 		struct reftable_record in = {
 			.type = BLOCK_TYPE_REF,
+			.u.ref.value_type = i,
 		};
 		struct reftable_record out = { .type = BLOCK_TYPE_REF };
 		struct strbuf key = STRBUF_INIT;
@@ -121,15 +122,19 @@ static void test_reftable_ref_record_roundtrip(void)
 		in.u.ref.value_type = i;
 		switch (i) {
 		case REFTABLE_REF_DELETION:
+			check(reftable_record_is_deletion(&in));
 			break;
 		case REFTABLE_REF_VAL1:
+			check(!reftable_record_is_deletion(&in));
 			set_hash(in.u.ref.value.val1, 1);
 			break;
 		case REFTABLE_REF_VAL2:
+			check(!reftable_record_is_deletion(&in));
 			set_hash(in.u.ref.value.val2.value, 1);
 			set_hash(in.u.ref.value.val2.target_value, 2);
 			break;
 		case REFTABLE_REF_SYMREF:
+			check(!reftable_record_is_deletion(&in));
 			in.u.ref.value.symref = xstrdup("target");
 			break;
 		}
-- 
2.45.2.404.g9eaef5822c

