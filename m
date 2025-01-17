Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171361F8685
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 07:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737100767; cv=none; b=st39Qxd+WhpY6g/yKxOp2QQe6RLJnXA1lSo+PrKNWL+HLvcf/8nnJEsmRra7ouvJ+OCRS7kWzieuEfRtfNPEIwn/muthna3+EwL5T+ShHfiq/KW/HMFnsYamo5PehFBkRQBu+3m/72UHL2w8cR+ZvA7mekWZQ0qQI54e/cTfLE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737100767; c=relaxed/simple;
	bh=QXtX5jLFmydYhhuEfNhJpOWcHr6bwu+XJLZtYGMwFQE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nx4UWjTBpwNkBrRXwnYiWR/M08ZLHtmfXpJfPiG7m/i08QWMPz5dH2iDoLT66LqXImCGOnIT7ChI+rkspspRV6ORzCc5CN5ChGNeMgUP00IMOob2dQxw+q50yNNNR7vyiyhHdU2VKQ61zD1vjvPMr6Q+9Hoo2dAQEIcx89LhQjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wd7AyqWe; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wd7AyqWe"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2166651f752so41827215ad.3
        for <git@vger.kernel.org>; Thu, 16 Jan 2025 23:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737100765; x=1737705565; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=idZdvyfZLFm5C8ArqB8WXQ7aW5VpYCUtutotB0XiO9c=;
        b=Wd7AyqWe2Y7eRFXNh2bHY+H1SeonYXgsx56BMJ+eLSk1TwjZHbnRwALXkc+wLBY84K
         ZIPiVdrcl/iinlDcDQR0e8Tsz3JLE5oAfuOUCMkdoSC8YvIPInYoSV5efZR6jZ2B5B+O
         +c1iRY9ypenXC8zWdWM2mZ8OXWzjaK2vesaD+XHW5hKGjNwfXWN3/6uukjuDmleIvbhA
         D5yHeQzaymxPxtEJ+ogzYUPIkbhiACepyfX3KrMPDDiEfLBxLEtONiSR6vTITezq6Sk4
         Gxfm2PXWzX8UhCoHoIHbJ1IXWkGduS7W1SFk6U4sQ51N5nMdwjTEr77wmDYZvuB0Vqqm
         9puw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737100765; x=1737705565;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=idZdvyfZLFm5C8ArqB8WXQ7aW5VpYCUtutotB0XiO9c=;
        b=iYSSBKV3GQZQo1IlaCfUmQ4DXs8XNI9OG0k3/0o6d3FgofScM2h+LKBDML0jH3UnJI
         ag9CL7JRCtAG4fn/jZeUf7ob7Ke+Tzg/dDP97cU3Pa0axXpf/83PuHtXLF312g1spRKg
         QUvSNn5UYwcSAIX1h+92AwsSX3+MRdrjJ1Q+DJ5uVVgVCYIjbPlqtrUiUlSTOTS7Na9g
         oUk9QEVrAFpdJzJa5GoxnNfrHun7Ok3oK9348cJfkErA5u8QRDT/BMGcDbUvGgND9wGk
         LjmS63dNSY/84vqSGCDSjyYZl70ILXXL81AuEMsDF4Ay47ObHmkMgayEXY7q+j6pCsQV
         r4Wg==
X-Gm-Message-State: AOJu0Yz0D5NBaqLe+BRB4cIBk/AXOMdN9MLdleIzhFbU/VJPh14MQaBN
	lS969/v9fUqOzdu3KD7UWLNOufPpaL37mkkd1YtFA4aLzwT7NEiu
X-Gm-Gg: ASbGncvcjv67Zy8SCjTvBv8LFLrz+wvuP6oU30zd+7wc3STUQf1v6VALlezOjVKbzVY
	jUz/ppzbfAnIKGlsREQFWyGGPDQo/XR7dZzuyj6fVU0etlSkfDKWxQz3CK6e7Ze07krSi4Gm/wd
	ylh8ppYlz4+gqqqpz5+r4lT6aB6Stz2Eb44sNhb1FBG+Q2V+NEI/9LiDSqhDmWhys/bb6XwJQx3
	KFa42Ewpq75Sw4fw2lf+ccuc74NVXW+ZoxmyD637iwKGaIQkWuYtCDyuEY=
X-Google-Smtp-Source: AGHT+IGLZwYPO7+Ac1H3i9cCPXLG67SFfVvACkNxXB3DTFM6V24AkVRkbYc3DAmezmchIGBKbhK4dg==
X-Received: by 2002:a17:902:f548:b0:20c:9936:f0ab with SMTP id d9443c01a7336-21c35637a1cmr22130615ad.47.1737100765202;
        Thu, 16 Jan 2025 23:59:25 -0800 (PST)
Received: from [127.0.0.2] ([103.39.127.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d4025f4sm10517595ad.204.2025.01.16.23.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 23:59:24 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 17 Jan 2025 08:59:13 +0100
Subject: [PATCH 2/3] refs: use 'uint64_t' for 'ref_update.index'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-461-corrupted-reftable-followup-v1-2-70ee605ae3fe@gmail.com>
References: <20250117-461-corrupted-reftable-followup-v1-0-70ee605ae3fe@gmail.com>
In-Reply-To: <20250117-461-corrupted-reftable-followup-v1-0-70ee605ae3fe@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, sandals@crustytoothpaste.net, 
 gitster@pobox.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2559; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=QXtX5jLFmydYhhuEfNhJpOWcHr6bwu+XJLZtYGMwFQE=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGeKDdWbJRIGn0xZ905MUZ9tvi0GLllROYGOt
 khGvqq3hJPBNIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJnig3VAAoJED7VnySO
 Rox/NLYMAIV/jjsienOyqBhW3hARLSrhtw3T3czyECzPCT3QqlLLhdyuN/qv32Abd3HpUAvju8W
 2sA3pb3fG1419RPih1Bm1XJK1O5mMIzy562KRsEWPhPEosRnXvgaP92IeNl3huU+URdNHP6NrKb
 2exNhIzPLh4ni9FN5TzF6q3z6qJ3CH8bq1047PUEMudNyueEE/gB9CdHCmDQhFMzohgPfOQt3Dp
 EWPMVtwDevXiQkUnRCpKmjmGWWuMF7H3ekGckjXqz4+Ck82+WGx+P9snSduDKVpn8s8+LO5k6C9
 PqIfw+gOsIj2WolNzruGc9IWwuMeFFHJoTKS21/wVMParK7R/mvz+3BZTTNu7FFalrQJWiHD/J3
 znKdWd0lC6RFAIzXBHb9TUBkLu0RVedNYAqhPBgCSRoJ0F8WRoVIo9CLFBioNH4mJGnH6ltIQF2
 85nWcQNBgrwcR1QVn/JLN5qW4vt/As6G1yH3FuudDdcxRs00NwCsr+1rQy5j/IaXx+fbCtnnjF5
 es=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The 'ref_update.index' variable is used to store an index for a given
reference update. This index is used to order the updates in a
predetermined order, while the default ordering is alphabetical as per
the refname.

For large repositories with millions of references, it should be safer
to use 'uint64_t'. Let's do that. This also is applied for all other
code sections where we store 'index' and pass it around.

Reported-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                  | 4 ++--
 refs/refs-internal.h    | 4 ++--
 refs/reftable-backend.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 1bb6f0356d5c5cae8bea9d6f4d5ff35164a03c64..0de23f91b2e4401e93aee6940d4aa2abea4312cf 100644
--- a/refs.c
+++ b/refs.c
@@ -1325,7 +1325,7 @@ static int ref_transaction_update_reflog(struct ref_transaction *transaction,
 					 const char *committer_info,
 					 unsigned int flags,
 					 const char *msg,
-					 unsigned int index,
+					 uint64_t index,
 					 struct strbuf *err)
 {
 	struct ref_update *update;
@@ -2807,7 +2807,7 @@ static int migrate_one_ref(const char *refname, const char *referent UNUSED, con
 }
 
 struct reflog_migration_data {
-	unsigned int index;
+	uint64_t index;
 	const char *refname;
 	struct ref_store *old_refs;
 	struct ref_transaction *transaction;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index aaab711bb96844755dfa600d37efdb25b30a0765..8894b43d1d1a327d404d3923c507d2d39649de19 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -120,7 +120,7 @@ struct ref_update {
 	 * when migrating reflogs and we want to ensure we carry over the
 	 * same order.
 	 */
-	unsigned int index;
+	uint64_t index;
 
 	/*
 	 * If this ref_update was split off of a symref update via
@@ -203,7 +203,7 @@ struct ref_transaction {
 	enum ref_transaction_state state;
 	void *backend_data;
 	unsigned int flags;
-	unsigned int max_index;
+	uint64_t max_index;
 };
 
 /*
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 289496058e6eb4d3e3aef96ca70219cd4ff78eae..6814c87bc618229ac8a70b904be3f850371ad876 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -942,7 +942,7 @@ struct write_transaction_table_arg {
 	size_t updates_nr;
 	size_t updates_alloc;
 	size_t updates_expected;
-	unsigned int max_index;
+	uint64_t max_index;
 };
 
 struct reftable_transaction_data {

-- 
2.47.0

