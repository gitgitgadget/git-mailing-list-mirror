Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111E72F0688
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 08:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758183116; cv=none; b=XeCoiWndC9tUQkYPaxzJ1w0NnvIHUk/5IslCCwcrQdS+vV+X+OZWVvnURid2CM4FtlBVae8hN15lssab1IG2GTpx5DPUQ9OIcv3P5iKzRGFF3Vh6PvVp+GMlwETvGTLauejGgX+GQKFT91tBP/61oTPnhzVn9f5WRLsUD9HPPEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758183116; c=relaxed/simple;
	bh=zWoPe0vras3ukN3EXTbWsYthYEvMDbeLCILSpRxs4lc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XQagO4ekEPr/gBuS4w1spJgTitlceZ4avF3W/5d8Wxi+4Aow/tCV33E8y1XVZ3zLcc4+1SFqKGsLTIkLB1fynH22JjQRIZDSQdVaRIMdj6fLUZOozEdzfj5c0zqgl+wyy3TOBcw6gbSg878MEVZqFTkIM0lFXVIKxxq7YPdcQEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MrP/MhEG; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrP/MhEG"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-62ee43b5e5bso947720a12.1
        for <git@vger.kernel.org>; Thu, 18 Sep 2025 01:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758183113; x=1758787913; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LBV4UuZFHXCvy5U4QeFt2gvWDuAPETmlzL4C2wDlbUA=;
        b=MrP/MhEGaJI3QtVR3uBynvhWQx4i3lX9pVV62ERM7kzS8pyW3pY6eHD+cH1aJ4FTRY
         ryoxrxaZylHaM7hiM9WaT4FMyoA5JxG4a/A5mr2uCYyfw3/dW4NZlA0UJV5dr93oX5iv
         CGtCrs/prn+x25t+bO2m5G+VMgGqpH2QFGFA1l6gZwyzK0ys1b0IvV95bh/9/dAM1HWo
         yjTFHIJqHpqct11fzArhO7DNddNzZGk/fcxQPFtVVKlaFNPTLGfi2B5VBq9revZZknZ5
         vakpluISbzrl7+VbhC0x4HIJOo6UElAyYpNwHJp8P4clhvyozMeNw08a7TldXhobzM7v
         hQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758183113; x=1758787913;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LBV4UuZFHXCvy5U4QeFt2gvWDuAPETmlzL4C2wDlbUA=;
        b=NNalvsiW2seOpOasbVmfDfvE7DAGLxzzJ8RFmg6upcCVS/wu7SUoZI55d49SVBtWQ2
         7muqf7qlf8dzvVaTMGIls9mnC4oMnRHvg5o/5plOs5CReUXuQXoPBfSwhyWChILzuvB7
         u8wtBr49yo2Uie2tSCHBsJ7gesCqUyvMW6VIoQZioV/rTf0k8QPsZI4nThFnkwZy1rb+
         xcKn5TutbJQWsjFZcO1R/v6whSTTVBEXnj5sFoKxJYkrWP1nZ73w1Sq5dmzNy70kMNk+
         ESD9gLzEXwqtG8J5uazkLVNKpDSBhxszPPFDnWej3kHA0dtEHQwB+MLwkupaeipjqbwJ
         AIrA==
X-Gm-Message-State: AOJu0Yw2vUOjZjBncZe2MfdxD06LM1H3L1kX7n6zDp+bezrrLg0vpJPn
	HKi7C38yJjqzPqmKbIYs5r1PZp9zRitAIZ4njjVQkoYUiq14IXpclVJD
X-Gm-Gg: ASbGncvuaOq+UUaiMoa63vmmy2cWcSS4xelsO8UtP/t7rhzgSehsVMamhhKgX5pfu7Z
	a9hu/ere/+72JP7v9YOBmTeD0Zj3ZoQA34cbPOqzIzlyNP3fTlsVKdBLiGLvVCIC4wyIm1Ha85H
	fO7ggxmhG8dCndWqTOq7dgIK4mM+3bp8tYmj15hrIrPLdHFe3BiDgimOaRZ67+l7VIhgzVVmNw0
	sVqFErKL9gAxK6MmeIy/Ezv2xtM0fSYCEc+pxAaRKLWH2Lhm1ZwnrUf0jk+Nc7lmZlUZxVsxBNm
	FgGklE4DJ5O12nUAcwc5TSiZ6KM+6Y+jVFbWuA4lQi11GwMKuV7oLS4PDf5qNGvEuSqrhMMwfK6
	3OIcXqJIMLwmrBaLPbc4+L3TItvo7ucREmdki/wVsOFiScFs=
X-Google-Smtp-Source: AGHT+IF0yMOaJcSLT2z/fyEGFvZICgrwKHml5xEWhHYCGVnWTHEtlL12iSS8YHUy2diaFDn2bG9Ykg==
X-Received: by 2002:a17:906:f592:b0:b07:8893:83da with SMTP id a640c23a62f3a-b1bb9b218ddmr482856066b.64.1758183111556;
        Thu, 18 Sep 2025 01:11:51 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:2802:b9c0:7d04:71e9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fd2ce20f4sm139986566b.111.2025.09.18.01.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 01:11:51 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 18 Sep 2025 10:11:45 +0200
Subject: [PATCH v3 4/8] reftable: ensure tables in a stack use sequential
 update indices
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-228-reftable-introduce-consistency-checks-v3-4-271af03eb34d@gmail.com>
References: <20250918-228-reftable-introduce-consistency-checks-v3-0-271af03eb34d@gmail.com>
In-Reply-To: <20250918-228-reftable-introduce-consistency-checks-v3-0-271af03eb34d@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, shejialuo@gmail.com, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2584; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=zWoPe0vras3ukN3EXTbWsYthYEvMDbeLCILSpRxs4lc=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjLvsNo3KkAcYfGdUCXj62109tSW6aMRsZpt
 GBVtISHiFGsZYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoy77DAAoJED7VnySO
 Rox/fjAL/27Ucnn4TZAogi/TOUBEB7UwVprovagiPJ6WjlubdcsqFGFXF5GC3fKMwFbsc2bqflR
 q6yRX6H/Sj7iut02b/dra6zIRRqhH2a26RxOibnSe2ach/RcssHvpaKl6HsZC3GcoOUjGo4GVwV
 Eva6X5CRO+CwQ69dA6d1Ns8tSKzpHfFoVUUnnftQm280hlutl7quZIfnHd1NpvNwUzg+Esrnzzu
 zIHLUmYBzxMahX4yJCDQkwnWdQYpo4HGpB/41wBpQb491jkAlTE1teHQfhiIZ3gAGsHHov9aMvs
 VUWmepUMEHRSqw1oNpRMwDcOV5vYKe4kTab0zdgWj0Ib8zenHgNZPMEh9jXUUM4VCjb2abwEbaV
 pSQJNbJ/NWT44Lic/3eH9EyELMXP1FBggSHy2ll3BJ7vfxs5PU6iiYI93O4UtqnuY90RGNaQXPl
 qOPqEURJ6JTMTx2SDOOdUOQZsJfxG90gWoQuxKzZCGCPh2rgNCGAWX+GunwbIkmVz25upVgo7l5
 H4=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

When tables are loaded into a stack, we expect that the tables are
sequentially ordered by their update indices. But there is no validation
done for this. Add validation to ensure that tables loaded are
sequential.

Raise a 'REFTABLE_FORMAT_ERROR' when this validation fails.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 reftable/stack.c                |  9 +++++++++
 t/unit-tests/u-reftable-stack.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/reftable/stack.c b/reftable/stack.c
index 955be1edb6..a458f5a4c5 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -238,6 +238,7 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
 				      int reuse_open)
 {
 	size_t cur_len = !st->merged ? 0 : st->merged->tables_len;
+	const struct reftable_table *prev_table = NULL;
 	struct reftable_table **cur = NULL;
 	struct reftable_table **reused = NULL;
 	struct reftable_table **new_tables = NULL;
@@ -317,6 +318,14 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
 
 		new_tables[new_tables_len] = table;
 		new_tables_len++;
+
+		/* table's update indices must be sequential */
+		if (prev_table && (prev_table->max_update_index != table->min_update_index - 1)) {
+			err = REFTABLE_FORMAT_ERROR;
+			goto done;
+		}
+
+		prev_table = table;
 	}
 
 	/* success! */
diff --git a/t/unit-tests/u-reftable-stack.c b/t/unit-tests/u-reftable-stack.c
index a8b91812e8..465f4a2689 100644
--- a/t/unit-tests/u-reftable-stack.c
+++ b/t/unit-tests/u-reftable-stack.c
@@ -1330,3 +1330,31 @@ void test_reftable_stack__invalid_limit_updates(void)
 	reftable_stack_destroy(st);
 	clear_dir(dir);
 }
+
+void test_reftable_stack__non_seq_update_indices(void)
+{
+	struct reftable_write_options opts = { 0 };
+	struct reftable_stack *st1 = NULL;
+	char *dir = get_tmp_dir(__LINE__);
+
+	struct reftable_ref_record ref1 = {
+		.refname = (char *)"HEAD",
+		.update_index = 1,
+		.value_type = REFTABLE_REF_SYMREF,
+		.value.symref = (char *)"master",
+	};
+	struct reftable_ref_record ref2 = {
+		.refname = (char *)"branch2",
+		.update_index = 3,
+		.value_type = REFTABLE_REF_SYMREF,
+		.value.symref = (char *)"master",
+	};
+
+	cl_assert_equal_i(reftable_new_stack(&st1, dir, &opts), 0);
+	cl_assert_equal_i(reftable_stack_add(st1, write_test_ref, &ref1, 0), 0);
+	cl_assert_equal_i(reftable_stack_add(st1, write_test_ref, &ref2, 0),
+			  REFTABLE_FORMAT_ERROR);
+
+	reftable_stack_destroy(st1);
+	clear_dir(dir);
+}

-- 
2.51.0

