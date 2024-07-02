Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B688814D2BF
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 07:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719906594; cv=none; b=PqmCihtO23kSBGStkDSuJmrlDYH53/E14oxFiO1mliDN4hz966zXkqhcvjNJDIjKyu1hl7XZuLqy+QJBZSppNDETx1YeBSXkRfz19yCmtsOdKWa28KNw/ytemHcUUjVPKcuSfaYfrei393w78uBsS5MKCIooEe+rmqu1eRO+nP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719906594; c=relaxed/simple;
	bh=vfmBT15Yfik046KDeYJhNepLC8rrhPq93JJ278eFMlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UK5aaUCZvQ73m748SUxRDBuRJ5q43VI9hf9rmeyDr6Fve4K3jqYKPFBLW37JFLIh6/BBTQG7O64vdKOXbBOAyZFTlc7FUDPipDurq0sjvUE2Relbbv/7aRLDPkBEPhxZMs+II/L1gpBZrQvWGS8kuUX2NfJsUSlrOTZWCGAETdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6VIJW2W; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6VIJW2W"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3d55db7863bso2546883b6e.1
        for <git@vger.kernel.org>; Tue, 02 Jul 2024 00:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719906591; x=1720511391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fuLTt4KEArDVqocACKGXB3ECVOLU/82LKdhDhScyN2w=;
        b=I6VIJW2W5r43Ex4qOxN9LzVp3+LWfCLNZXWN9np4EWa0wUMc+Fl+QXmqWvaO9qnV1N
         lvtdLCd+okCXj2hvXcwoc61wOhNhn55J9/DRZX3j0SJOyj2Z3LX3qywYSkvlxdFv5rpr
         dA0/nAHbH6R7ZGmgA5jQS4FxvyjgBZiwtL5oUlJ8V59+CO9II7U3kYq4XWWg6S4I55Do
         JPWnz26D0TAxHReVxI8fJxGvW8zaVpcMfH35JSMUcPJohSCGijvNTn+yrlH3xMmyqhry
         gXliqmXSayK9Vypg3Gdj8vdmmbCcOB3caehDqyBzxTX8h6Knj8/UcQ1mgBRiAETsGfj1
         mwMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719906591; x=1720511391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fuLTt4KEArDVqocACKGXB3ECVOLU/82LKdhDhScyN2w=;
        b=PxC0dtbAN56jRQqJ90PtuTq61vc20uLAEsJIeEedOH/zh1HgZd2pyWcUWgm5h3O0jF
         H4wRJvmYxK1ZygWrawynhhQ9dLFZcj2eHJd7euzhWZYVqXBk4Owc1FV7ByP4TFYUPE2x
         BW5HCOQnq9IlxVE2EDnsHpKQBwy9RKgiqe4TCrp9v93kB9GJMJRrRtFRtKZe3XgW3JDl
         arwboGOfD8GR8HhdGxsbGB0/8IRslQX/QEhevbCNRyS5qq15JU7D9PX3RJXtUh5lEsXv
         hlQTEnyBSnnoiG9o+Vua7RnjssjWQq3IAHzXBWKXKyzszgYumES6t3fgpZTHlZJ0OoFp
         3o6Q==
X-Gm-Message-State: AOJu0YxeNP1YPq1D5TKDOwvzN94pSVUe89N4LMc1OkCMVE7CQMNZDO1Z
	Iunu9Cm0ANMpoAYkMQMYWpK7yrd4HmKjKDGgURd4ZdtQDjEc5Mmtt3txIczSHzU=
X-Google-Smtp-Source: AGHT+IFfP9FfAT0jZE2OI9kGWI2618QFTI0lbgtInW5wWr1u/Vp1OOm3SuPC10lRbovro+oiIlbdFQ==
X-Received: by 2002:a05:6870:71cc:b0:254:a3c7:b917 with SMTP id 586e51a60fabf-25db3433859mr7674489fac.34.1719906591445;
        Tue, 02 Jul 2024 00:49:51 -0700 (PDT)
Received: from Ubuntu.. ([106.206.197.80])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-708044ac424sm7772626b3a.161.2024.07.02.00.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 00:49:51 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 03/11] t-reftable-record: add comparison tests for ref records
Date: Tue,  2 Jul 2024 12:52:16 +0530
Message-ID: <20240702074906.5587-4-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240702074906.5587-1-chandrapratap3519@gmail.com>
References: <20240628063625.4092-1-chandrapratap3519@gmail.com>
 <20240702074906.5587-1-chandrapratap3519@gmail.com>
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
index dd64e71f3b..99534acd17 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -63,6 +63,38 @@ static void set_hash(uint8_t *h, int j)
 		h[i] = (j >> i) & 0xff;
 }
 
+static void t_reftable_ref_record_comparison(void)
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
 static void t_reftable_ref_record_roundtrip(void)
 {
 	struct strbuf scratch = STRBUF_INIT;
@@ -371,6 +403,7 @@ static void t_reftable_index_record_roundtrip(void)
 
 int cmd_main(int argc, const char *argv[])
 {
+	TEST(t_reftable_ref_record_comparison(), "comparison operations work on ref record");
 	TEST(t_reftable_log_record_comparison(), "comparison operations work on log record");
 	TEST(t_reftable_log_record_roundtrip(), "record operations work on log record");
 	TEST(t_reftable_ref_record_roundtrip(), "record operations work on ref record");
-- 
2.45.2.404.g9eaef5822c

