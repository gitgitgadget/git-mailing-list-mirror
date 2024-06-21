Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB76172BC7
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 11:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718971085; cv=none; b=GYVBGfdXcgdfB4/TZHq9aDL/2436JRf4+sjieorvCc+c0TJ8NglktzyvoB5aAUDGBiH7lxHVySv3n+TjrtdcA/i4bOGyN8p0UYbft4oTb2hAnOigz6mAH1hO9/xfJkDDHcQPhWHuqON95Qv/z4n6Z9KLYIGt7P/jS7F90VOMF8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718971085; c=relaxed/simple;
	bh=NRJZPoMrg9FpbLJeDirocCZmg3nnkmqfTIQubgTedVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+3nSYaW2POSZKeNpa75XGGRIIokUwhFwkJXPcQxB7PHNB/hjq0fAYcAbW81GVemf+8jPCW/rGpC1DUfo1rVMHElFagmE9UQXaLj+mF/gy+P26PwCfjc+tBzMVQOfWB1xRE5RnHH19mzxm8nINvEBycSdSiwAYEhc8qo/WhgXNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=croj4D13; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="croj4D13"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f862f7c7edso15777735ad.3
        for <git@vger.kernel.org>; Fri, 21 Jun 2024 04:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718971082; x=1719575882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0K52JLzcWFaK5zDwjskdDWV4KeyY+dwCntcyvt9vJgk=;
        b=croj4D13o2vZ4dY2Z9PR8x362qaCCrLsJa9Mtl9cTnAUd29ERcy9zzQbAPzWq20jQX
         qJbUedYDf971I9PI+QfDz500n0xGANrPjmVL7MN2Xvr/gvhanbz0L3+VmW/30r1MUSYZ
         Qi8zkwoog/8e1tKUeMmLOK7oaqSMMFBzPVU2s6jyl/Pq3HV7e/na9XidGOV9leFme4MJ
         8KN6LsL7dtDX9gn7L1EA9/0HV63idGS/qrqvTdc//3V5eL2dxOEPRBKhmbPUDMMRECNM
         O4N12nKOpFZe3kzXn1hi39sBPDT/O20cMmEhY50t3X9Pw2keivSFC+wv0AY0PU5hmWho
         jeLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718971082; x=1719575882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0K52JLzcWFaK5zDwjskdDWV4KeyY+dwCntcyvt9vJgk=;
        b=C4SULSOFIWgxW+CtMsIds04wyO+jghKHY57Xy/NcCc5r5Sxw7eSPU62esxNVSsdcQy
         U9HzNP6mDydjr7lxB0bRWeAT7gsjANJN75E1bBGn6TT+zqV8ANGRLvPYFE339r6aEzyv
         Z7OrXJJJygsXTl/EItWHfUyhzN7B3dAybzipwntUZVnyCVCKLX7w89dQa47hG8cBP51G
         WKMycmMAn93ceVti286DAjbNgM1a/u8PdCNEPtXOsBCrD3iAg+kPBhAT2YEh+IifEipD
         dQ9+0TzS8sxtII52EjmlP7gxKXF6DroBYDdpKHrwmw1AMMxTM9C4HWjWmuO0oRgX5MR3
         YPjg==
X-Gm-Message-State: AOJu0YxX/skP6RqVWrj7B6eBtN5LDTkWirO+yI910POfSSgYO9ryZVhf
	np6yPhnJh1ArEbfx1826SAU9rj84CqMLeAxPAOeEXqkbwkBl+Qmjj9CBkw==
X-Google-Smtp-Source: AGHT+IFQ0nLFRhLRy6UuK9DzRrEv7QKlHhCWvz+MLHWijUmliNb/7U7wVHrux9XGoNhZEHjIrr6srw==
X-Received: by 2002:a17:902:e812:b0:1f6:7f20:d988 with SMTP id d9443c01a7336-1f9aa44fd68mr95541235ad.42.1718971082348;
        Fri, 21 Jun 2024 04:58:02 -0700 (PDT)
Received: from Ubuntu.. ([106.206.204.195])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f9eb3c5ee9sm12407195ad.180.2024.06.21.04.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 04:58:01 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik188@gmail.com,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 07/11] t-reftable-record: add log tests for reftable_record_is_deletion()
Date: Fri, 21 Jun 2024 17:21:02 +0530
Message-ID: <20240621115708.3626-8-chandrapratap3519@gmail.com>
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

Add tests for this function in the case of log records.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-record.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
index cbc2ce93b2..b2e1a892c0 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -231,6 +231,10 @@ static void test_reftable_log_record_roundtrip(void)
 	set_hash(in[2].value.update.new_hash, 3);
 	set_hash(in[2].value.update.old_hash, 4);
 
+	check(!reftable_log_record_is_deletion(&in[0]));
+	check(reftable_log_record_is_deletion(&in[1]));
+	check(!reftable_log_record_is_deletion(&in[2]));
+
 	for (size_t i = 0; i < ARRAY_SIZE(in); i++) {
 		struct reftable_record rec = { .type = BLOCK_TYPE_LOG };
 		struct strbuf key = STRBUF_INIT;
-- 
2.45.2.404.g9eaef5822c

