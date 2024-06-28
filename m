Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D2F80BEC
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 06:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719556659; cv=none; b=LpeQk7g+0SOofM0u7lxN6rYMzRYalrQb7bp7EzKPlUrowqgYTZ/z0UALU1fyQTNaLkVLJJPi/+NvnCMcIN9ez5ATLS0eKTQSqLUK+sHLJKtBYVtl01/TpzMgJGrWe6rX8uZxoczDd2SVX5//k538SG9Md99ltZ2EVeUW9AR/6GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719556659; c=relaxed/simple;
	bh=QrPwgborrqctCqeQPOf8HiFfX/Scxe86B2fyjkKGJ9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SNIdBU4rFGmeLyxz4aDCz1aeYRDO9uOUDbwTUhqAmpwzxS+8g8MQtrRAyWeYfE/eV9aCtzbg+BQrjNgVJ81DELvR9HWdlreMc0MPqhzbUMq14Qs4F0vC8f+RFOBT58BlShRm95dubPm6VmmtL6aC8J46sw+Eina1iC7z4pxiEuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axwHM1tZ; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axwHM1tZ"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3d562882f4cso179259b6e.3
        for <git@vger.kernel.org>; Thu, 27 Jun 2024 23:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719556656; x=1720161456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xv592SfPjxw8jhBL83Ylm0VRCACmKjSSuf/KOFQ4CKA=;
        b=axwHM1tZ1Gptsoesy5ACltkHS3Djr77EyAaSY3lWN9qfWUVBSV1ztvjBufOFLtZp10
         NqSWqnByIo+Lu5LAiP0nNFnvzo/Yw2pGnXqC/i1F23L3yH2QHPvO+3GLyXL9n4bi4P70
         0kWhEG+ggbZxoAkszNNAS8G+cLSrluaakh3SHfTeVOTpTM55IyZZV8bd2kAoBajeGSnw
         WrOlYE+ZKN6EiELC+R4svaHhuQ3u2A4dzPOeOrIn4sRn2K5fP+4PSqhQhilu2UB4dyHE
         gPd4DdVySLEfBdknjzQW+glyKPaqGjp74jZee7l0930+WzahM9qc08aP/RivcVEyuTc0
         EJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719556656; x=1720161456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xv592SfPjxw8jhBL83Ylm0VRCACmKjSSuf/KOFQ4CKA=;
        b=gYfs05PlpOK+4yceipkg2Beo4e5/pr45fDrfyobQX7XaIY3oBrjUZ/D8vD7PmhZbSz
         DpR5cEcTDW+El395M0g2ZZNd5W4GltA1dShbbiKhalVoCivuizqHZKEKkyqsRem4+QUl
         t/MvGjYOKRuEHefQ1uWa8LFPSi+QLdMtUXKisx0rQo8JC9oW2wjM5mAxjcMAqaonjLFW
         cZxxuO8LQuShPKlsIgH85W97rVP5H3I4NQpeLpwexoZBnwn6W9JWbPvL8/fYsdrNnzwh
         9VT+sfH0F6OLgtKkCHMFC+qNaHeX7TtIE1AB6w3XDBNcroNQsU80aneHgKJcEvEOjZSg
         i7og==
X-Gm-Message-State: AOJu0YztvW4bASG+fTWp5KkB3NCyC20auh1fBhBGA2qaOiRs4Dfzt3tD
	VDMGV7PuKjm4yIK7EHGDhYt+WZrKhaYpD2boP8iG3sslbFyLc7mLtQZW91Jfa/E=
X-Google-Smtp-Source: AGHT+IEwGO0HuUeUB4YiF23VMgzNMQlWhIroSVnzx2EAOVkHHSIDyRJxj3boEa5q8q21uglfKJONbg==
X-Received: by 2002:a05:6808:1704:b0:3d2:26d1:5fd4 with SMTP id 5614622812f47-3d54594db07mr20205769b6e.8.1719556655677;
        Thu, 27 Jun 2024 23:37:35 -0700 (PDT)
Received: from Ubuntu.. ([117.99.235.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70804a93ce7sm786003b3a.207.2024.06.27.23.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 23:37:35 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik188@gmail.com,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 10/11] t-reftable-record: add tests for reftable_ref_record_compare_name()
Date: Fri, 28 Jun 2024 11:49:40 +0530
Message-ID: <20240628063625.4092-11-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240628063625.4092-1-chandrapratap3519@gmail.com>
References: <20240621060018.12795-1-chandrapratap3519@gmail.com>
 <20240628063625.4092-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reftable_ref_record_compare_name() is a function defined by
reftable/record.{c, h} and is used to compare the refname of two
ref records when sorting multiple ref records using 'qsort'.
In the current testing setup, this function is left unexercised.
Add a testing function for the same.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-record.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
index 55b8d03494..f45f2fdef2 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -95,6 +95,28 @@ static void test_reftable_ref_record_comparison(void)
 	check(!reftable_record_cmp(&in[0], &in[1]));
 }
 
+static void test_reftable_ref_record_compare_name(void)
+{
+	struct reftable_ref_record recs[14] = { 0 };
+	size_t N = ARRAY_SIZE(recs), i;
+
+	for (i = 0; i < N; i++)
+		recs[i].refname = xstrfmt("%02"PRIuMAX, (uintmax_t)i);
+
+	QSORT(recs, N, reftable_ref_record_compare_name);
+
+	for (i = 1; i < N; i++) {
+		check_int(strcmp(recs[i - 1].refname, recs[i].refname), <, 0);
+		check_int(reftable_ref_record_compare_name(&recs[i], &recs[i]), ==, 0);
+	}
+
+	for (i = 0; i < N - 1; i++)
+		check_int(reftable_ref_record_compare_name(&recs[i + 1], &recs[i]), >, 0);
+
+	for (i = 0; i < N; i++)
+		reftable_ref_record_release(&recs[i]);
+}
+
 static void test_reftable_ref_record_roundtrip(void)
 {
 	struct strbuf scratch = STRBUF_INIT;
@@ -490,6 +512,7 @@ int cmd_main(int argc, const char *argv[])
 	TEST(test_reftable_log_record_comparison(), "comparison operations work on log record");
 	TEST(test_reftable_index_record_comparison(), "comparison operations work on index record");
 	TEST(test_reftable_obj_record_comparison(), "comparison operations work on obj record");
+	TEST(test_reftable_ref_record_compare_name(), "reftable_ref_record_compare_name works");
 	TEST(test_reftable_log_record_roundtrip(), "record operations work on log record");
 	TEST(test_reftable_ref_record_roundtrip(), "record operations work on ref record");
 	TEST(test_varint_roundtrip(), "put_var_int and get_var_int work");
-- 
2.45.2.404.g9eaef5822c

