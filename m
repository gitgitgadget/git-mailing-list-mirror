Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BAF15C9
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 06:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718949715; cv=none; b=BDxQhKCxYyy5o+C1DqPIQroknYazE/vg4HzD+ddhfH4vkOCJU26oWs6jV3FtL4CYdZ+D49UISQB+9jE+R+ywlxkhhbMCW2MOeZSQAz6ChCC5LVHNpQZT0cY6hLmz74AV7cZuZM7PZN2OQEqt7mhQ0JWTAuEfpGiW/njCDtDjNtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718949715; c=relaxed/simple;
	bh=lDBFpozFSoflHALRUYkIyY8JoyPKrje4hLDbm07eJ/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bLS89tDK37q7EylgtauA8buqrY+KRe4yk9aheP8VJI3T9v9Y/c96QhGzQ/wnJVFeXOyViJR3H6lKBLPTMygZWJkerYyTx/kF5wA57C1C1avXw6a98B5E1wWVWBkkctDs5RC2S2UnsKlJ9AuKsFXMuHjBVGSEFGNKS6Mfvb9u72s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWpQVH7j; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWpQVH7j"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2c80637d8adso805938a91.0
        for <git@vger.kernel.org>; Thu, 20 Jun 2024 23:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718949713; x=1719554513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MIUD9NEsMqxCVKPLnRrHXXphhasmSpcrLUzRvyuptOk=;
        b=BWpQVH7jOBHNrSpLC76rdIdcXHqU9lIjgvkywMqOUX7rR+/KvRPxdHL2MGIsLl585n
         5/nDbaNdO2H7RZnoS37liZcyc9kt16Xi8r+vMSmh5M3QmzzOjHqKBPCCusrKhdczR6gc
         xq6fx/HXvoFZFLEC7aYUhgm0GAmOg0C6ypc5xUIYG6Sz9XKcFn2KdxzWbGtmgD2C13C2
         RveirrCRPlKK4OjC6wGtXd0uI5VCISzz8pPrECSCRJR7Pb2gFankt+6BraDJzLjy32bL
         PE25NIaHJegTGup9vFVEZvwTtV3o1s+LpEcJU99vRznpDtUDGtsxRfMCxLYjXniyUIuB
         rtxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718949713; x=1719554513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MIUD9NEsMqxCVKPLnRrHXXphhasmSpcrLUzRvyuptOk=;
        b=XjcmxsPRQUlfQXVDQaSoPHNUDafHBRPkB1U9fPF6ttYZuQLIOYX8xx0JmGxocZQHpt
         UFczXW7OsMmabnU1W8TC3pj69+uQZnIqSEyOew6zGj7luOJG81Xv1KdrxTbvIeSfi5Di
         xd8savccko50fkZ1jt6DfetxD0I+1AqtNQm1A1/yH+SPfc5mTjQ6e9obwez7nuKmZkRY
         E4WT+5eQffBJYFHIU0wYKLJVG8GoJpQcdlotRFGMZyJsSYQRh4gf+u1lzXNzHkv/rkPc
         wVM7mQ/6+C3ZIeZoImOX/8M0ms+tEKzMFc7IRPTdMx1NYsl0gBIz90/BER064UyAiGMD
         hINA==
X-Gm-Message-State: AOJu0YyUNPhvjt8GredkkDpNiAzQQv3c0fyek6jqzch8Cn4yN61IjP95
	xdcweHWAVkGzgOpl5miBk5IUjMrjS+EYnuKg3BgRtkWxDRwvRVuZINpKtg==
X-Google-Smtp-Source: AGHT+IEME+2Mh83hF71hJm7aRsOqcwdYihmmw86V2CKpDbx+EtFR6apYTPWl+xFfEBQk9ZYU4jl8hw==
X-Received: by 2002:a17:90a:740c:b0:2c8:7fa:a29c with SMTP id 98e67ed59e1d1-2c807faa682mr2659790a91.1.1718949712791;
        Thu, 20 Jun 2024 23:01:52 -0700 (PDT)
Received: from Ubuntu.. ([106.206.192.103])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2c81fe88e0fsm498661a91.3.2024.06.20.23.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 23:01:52 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik188@gmail.com,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 05/11] t-reftable-record: add comparison tests for obj records
Date: Fri, 21 Jun 2024 11:17:04 +0530
Message-ID: <20240621060018.12795-6-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240621060018.12795-1-chandrapratap3519@gmail.com>
References: <20240621060018.12795-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the current testing setup for obj records, the comparison
functions for obj records, reftable_obj_record_cmp_void() and
reftable_obj_record_equal_void() are left untested.

Add tests for the same by using the wrapper functions
reftable_record_cmp() and reftable_record_equal() for
reftable_index_record_cmp_void() and reftable_index_record_equal_void()
respectively.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-record.c | 39 ++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
index 1d102fb547..d7490db5e5 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -301,6 +301,44 @@ static void test_key_roundtrip(void)
 	strbuf_release(&roundtrip);
 }
 
+static void test_reftable_obj_record_comparison(void)
+{
+
+	uint8_t id_bytes[] = { 0, 1, 2, 3, 4, 5, 6 };
+	uint64_t offsets[] = { 0, 16, 32, 48, 64, 80, 96, 112};
+	struct reftable_record in[3] = {
+		{
+			.type = BLOCK_TYPE_OBJ,
+			.u.obj.hash_prefix = id_bytes,
+			.u.obj.hash_prefix_len = 7,
+			.u.obj.offsets = offsets,
+			.u.obj.offset_len = 8,
+		},
+		{
+			.type = BLOCK_TYPE_OBJ,
+			.u.obj.hash_prefix = id_bytes,
+			.u.obj.hash_prefix_len = 7,
+			.u.obj.offsets = offsets,
+			.u.obj.offset_len = 5,
+		},
+		{
+			.type = BLOCK_TYPE_OBJ,
+			.u.obj.hash_prefix = id_bytes,
+			.u.obj.hash_prefix_len = 5,
+		},
+	};
+
+	check(!reftable_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
+	check(!reftable_record_cmp(&in[0], &in[1]));
+
+	check(!reftable_record_equal(&in[1], &in[2], GIT_SHA1_RAWSZ));
+	check_int(reftable_record_cmp(&in[1], &in[2]), >, 0);
+
+	in[1].u.obj.offset_len = in[0].u.obj.offset_len;
+	check(reftable_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
+	check(!reftable_record_cmp(&in[0], &in[1]));
+}
+
 static void test_reftable_obj_record_roundtrip(void)
 {
 	uint8_t testHash1[GIT_SHA1_RAWSZ] = { 1, 2, 3, 4, 0 };
@@ -445,6 +483,7 @@ int cmd_main(int argc, const char *argv[])
 	TEST(test_reftable_ref_record_comparison(), "comparison operations work on ref record");
 	TEST(test_reftable_log_record_comparison(), "comparison operations work on log record");
 	TEST(test_reftable_index_record_comparison(), "comparison operations work on index record");
+	TEST(test_reftable_obj_record_comparison(), "comparison operations work on obj record");
 	TEST(test_reftable_log_record_roundtrip(), "record operations work on log record");
 	TEST(test_reftable_ref_record_roundtrip(), "record operations work on ref record");
 	TEST(test_varint_roundtrip(), "put_var_int and get_var_int work");
-- 
2.45.2.404.g9eaef5822c

