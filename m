Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EA46F2F3
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 06:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719556637; cv=none; b=t8ASP8zdkOUwlIrCFeBtaw6Cfq4oaZWlsb7N8y+IgGnhFU1n8p6zvhiPqdA+4IH7o1XMz7To+WhwnqxjAmxRskkmJmGnArRwml8Dipi+/dshP+ADXi/EC+XlIGOXCs5kcby4qmu/S+ZhxTSyGnRfWEgldjIkPnstMbDOMBMi/Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719556637; c=relaxed/simple;
	bh=2RGKYoOflRPlpaPlN8au/OOJe0S1P/Ugn4N1GrcdGbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YgsbJZk84vVwoh4rn7ffM4bjoU1YigTVYAgbmhBQy0DQeTSHAAdJ+pA8MLSZOoplNHY0nSShBxA/fczL6XWCKDWBYku5vQhKJgIcTUHtFuDcA670DeRV7G/1deOu6tfkZ+p4i9Aask1fDQx1sYGY5+A853DwX5/t4XbX/7vYra4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JevGgab5; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JevGgab5"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-706aab1b7ffso243638b3a.1
        for <git@vger.kernel.org>; Thu, 27 Jun 2024 23:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719556635; x=1720161435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zf9IA6MXUcABFH2EsqnWuHVk065kriLFK3PKrLW8/Y=;
        b=JevGgab5Cf1DE/vu5OCEWidUk7Yajxyq4OwmctltyE3Kw4aeFwdILg5/uu/jRcq+Ka
         eS9/K8mLZvnQQg67M98FJyZJagH2CWSBNhs4Webi1b9RNoA9ayrxK5TT4NeACgQoIFUF
         VSQJ+hyV4NGkCCUYKokw6GT6ztlAWagulSEix7phMDaWpSHqx3VbblpM3B4qDO36LspO
         ziayh8vBPN/wdasaGXlo+IgWsLxP+dcQFYr6GL34dORI/M6FQQ3UfipNJIP+o+JiDHuB
         FuXA1oMH1mR+u/MzKVLQfD14qmFVAsCwEumKEGlxnLcS/R+H4nRqPUndrQQFzmhTqnLK
         GKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719556635; x=1720161435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8zf9IA6MXUcABFH2EsqnWuHVk065kriLFK3PKrLW8/Y=;
        b=PdPoeX/wmz5WBPK7XrDnMqs16zlHlFzjiTeaBBDyjJrlnVm0wCgPrBt3A8wLmCzomK
         syYokGctKTHeuWbQvfNKuAZNvSmfgGXf8vLWbRjufsdobk37xY0atBSUiQl7yRBa9PhY
         hEvrwV20chsrxXXbBnxmi1SH35gED9uSHnoAjS7/KRvqnoi2h3a45pAEKRFwbsazXKPP
         FAVVLJ6kYtX/aDPL94K9jrdDgs/+NFeYIXhIYEqpogamyosdKTDr1ixXDE6NzxQ8ycE8
         o9V4MTP9JV/C/bf4qs5PiHbZncgHGxk3fM380b8DLHXnsyI5OsCd2qpOAaVBlC9i55je
         w0qw==
X-Gm-Message-State: AOJu0Yzb/bmUmi+jg+Msmxm49s7x4KHrmFYGQAIHZO478JM6UTNizUTT
	X9wVdHbitlc2jU+eUdzuN3cJxBL8sAadrxo1ZyvG7i6jnKken6hprtuyokP6ouw=
X-Google-Smtp-Source: AGHT+IFUT1MI2vTf7Nnjd+70DyuGw/F7sBJqirP0wFhg4sa2hqbTEs/RfqrWbQy6hWDdgLEcGHUbFg==
X-Received: by 2002:aa7:9edc:0:b0:706:29e6:2ed2 with SMTP id d2e1a72fcca58-7067459359dmr15769260b3a.5.1719556634927;
        Thu, 27 Jun 2024 23:37:14 -0700 (PDT)
Received: from Ubuntu.. ([117.99.235.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70804a93ce7sm786003b3a.207.2024.06.27.23.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 23:37:14 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik188@gmail.com,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 03/11] t-reftable-record: add comparison tests for ref records
Date: Fri, 28 Jun 2024 11:49:33 +0530
Message-ID: <20240628063625.4092-4-chandrapratap3519@gmail.com>
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

In the current testing setup for ref records, the comparison
functions for ref records, reftable_ref_record_cmp_void() and
reftable_ref_record_equal() are left untested.

Add tests for the same by using the wrapper functions
reftable_record_cmp() and reftable_record_equal() for
reftable_ref_record_cmp_void() and reftable_ref_record_equal()
respectively.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-record.c | 33 ++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
index 82988d9231..aaa49e76af 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -63,6 +63,38 @@ static void set_hash(uint8_t *h, int j)
 		h[i] = (j >> i) & 0xff;
 }
 
+static void test_reftable_ref_record_comparison(void)
+{
+	struct reftable_record in[3] = {
+		{
+			.type = BLOCK_TYPE_REF,
+			.u.ref.refname = (char *) "refs/heads/master",
+			.u.ref.value_type = REFTABLE_REF_VAL1,
+		},
+		{
+			.type = BLOCK_TYPE_REF,
+			.u.ref.refname = (char *) "refs/heads/master",
+			.u.ref.value_type = REFTABLE_REF_DELETION,
+		},
+		{
+			.type = BLOCK_TYPE_REF,
+			.u.ref.refname = (char *) "HEAD",
+			.u.ref.value_type = REFTABLE_REF_SYMREF,
+			.u.ref.value.symref = (char *) "refs/heads/master",
+		},
+	};
+
+	check(!reftable_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
+	check(!reftable_record_cmp(&in[0], &in[1]));
+
+	check(!reftable_record_equal(&in[1], &in[2], GIT_SHA1_RAWSZ));
+	check_int(reftable_record_cmp(&in[1], &in[2]), >, 0);
+
+	in[1].u.ref.value_type = in[0].u.ref.value_type;
+	check(reftable_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
+	check(!reftable_record_cmp(&in[0], &in[1]));
+}
+
 static void test_reftable_ref_record_roundtrip(void)
 {
 	struct strbuf scratch = STRBUF_INIT;
@@ -371,6 +403,7 @@ static void test_reftable_index_record_roundtrip(void)
 
 int cmd_main(int argc, const char *argv[])
 {
+	TEST(test_reftable_ref_record_comparison(), "comparison operations work on ref record");
 	TEST(test_reftable_log_record_comparison(), "comparison operations work on log record");
 	TEST(test_reftable_log_record_roundtrip(), "record operations work on log record");
 	TEST(test_reftable_ref_record_roundtrip(), "record operations work on ref record");
-- 
2.45.2.404.g9eaef5822c

