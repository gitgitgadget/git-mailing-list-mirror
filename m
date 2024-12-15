Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4543F190493
	for <git@vger.kernel.org>; Sun, 15 Dec 2024 16:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734279958; cv=none; b=qukmm7hgZGCunGgdcxv1DGLTjgk1kVbyJVigoqKNIS6kv0784VsMOQ8Jfq+449hAIMwJBwAtoXn+8fvQMuAAUwPJ0XT82IAetwW6SRRWU83uyD2eR1zBXVoPtGKEiggdAvfKe2Z+aYNd0WXogFh0/9JJVsVOAqdBl+TNMklGd4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734279958; c=relaxed/simple;
	bh=IB9h00v4zfs7q+FeZZk33xlgGFW2QmXAcKQGj56BkwY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JYBMoc7lrVNbCRwBIT9hluP7aw6Y+xLvaglU0QRVBQylcKDoPxLppVeIbhqVprcNNHmqJn15v1EE7EFBYdpXzNw78x860/5nRXvgiINgTpqfLsM/wE1fXtbmmbkUKuOfYnV0uqy1P7b4wDgtd5bYO3kHLwXZ4MEOvauVbKBWt2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J04VRP/y; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J04VRP/y"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa66e4d1d5aso539020766b.2
        for <git@vger.kernel.org>; Sun, 15 Dec 2024 08:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734279954; x=1734884754; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lUvb5dIPp19cc7hdfTanzPMDqohb3VapJTcypa4CDlg=;
        b=J04VRP/yE9gdoeJbA12JdSuoYHBxI2hecsaV6WNOlsEMcGnev+tDTrdY6FuVUhQodP
         SjbZxZh+cKLfidA4LRJj4902qNO3R9Rc5RrvxMQUxdDyu1LN/FHo/7wEYZd5h/KJ+wTM
         P1h9ELG8+gFiJs73cQLbHb3dybbja4qIAM38bHJjNgvSVH3LekWLZ82dqMvJsdRL0WqA
         hZMwPJcN0KJYuw3oL0TI15GQMKeu+T9Y4dWXFHd1YRfvzjkRTfRxJk9IgDxXC32/5Qtq
         PuZ8PcX0VpQts8DxtD4RsSNZ4CIqj3rv4/4/rVYCRuj6LA8EJ+P6FMsCEerzbh0zVYQ3
         nMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734279954; x=1734884754;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lUvb5dIPp19cc7hdfTanzPMDqohb3VapJTcypa4CDlg=;
        b=ViN5LEoOjsSV0CLOQaU1j2iCeIcop7wKEK9F7wM+1coL+K5M4FUwKZg74nQEudBlxh
         u6WcA6V0f/69J4Iul/yb/ldrqKINx6leCHY57cKpGlJe4sAK3dB18NuXRThJIkMpoSd2
         3xI/PxUQqzHWl2l+TpsZrogsQbqkdYFf00KF7ydXVgGDfMTN+9eUNASq+EaIvDGYbbM3
         t3LfsPjjzNt2/ldQK7/oDiSes5OrH1TyV8SvQ8x0IAUq79SH0HzrJO6UjnQFSZzrDCfG
         8B8VjjzuA8b1MgQj0MEgn89NOG5xF0GF2Z+qkHSBJQfYxi2n5ZfSw1cE0PEF7KSFKu5a
         xBMg==
X-Gm-Message-State: AOJu0YzPVS5HX2dQmVXz/2TUFdqHTUaIiBCul6SxbSk3KD1pJ2SUNDEj
	QGT/vE3sd5/xWd/1H5qZiXJFo0brLL4DcOmAItC/SXZbu4pJ5veu2s3gvwXT
X-Gm-Gg: ASbGncue6kB0FOjh0IHzB/G34nv7t/3KzmYySdAZY4fe6eQJowLPApis12ih3UZp0T6
	SUZp/E1iUd4dPxY/isB9A/WoynXvusiTAwuIUf4D/SoMUO19xZqf0GDEoo2iWDB5tZHNv/Mu3Ud
	ceNZiHhbSTzHy1O8uKscwn1DWRQE6VYnrEN7wndw2rFTmtU39Hv4iLVOPBkDL4lTsrnYd6SROuI
	AZF8cqwonChv57FGEJcJRBH+gBsx9gAntD3q3M2TB44b7bfzJk2pn740d4rvf0AAmOmzg==
X-Google-Smtp-Source: AGHT+IEBhSHIGMVvRwHMqzguIOCKx100tSwpM4AGGa8OBr+yz6/goeONJ6ummHslPTgH4C1bKmNw3w==
X-Received: by 2002:a17:907:2da4:b0:aa6:23ba:d8c8 with SMTP id a640c23a62f3a-aab778c1e88mr988215066b.11.1734279954316;
        Sun, 15 Dec 2024 08:25:54 -0800 (PST)
Received: from [192.168.178.20] ([2a02:2455:8256:2d00:9c39:c2d7:aedd:294d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9638ad1asm224887866b.139.2024.12.15.08.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 08:25:54 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Sun, 15 Dec 2024 17:25:39 +0100
Subject: [PATCH v3 2/8] refs: add `index` field to `struct ref_udpate`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241215-320-git-refs-migrate-reflogs-v3-2-4127fe707b98@gmail.com>
References: <20241215-320-git-refs-migrate-reflogs-v3-0-4127fe707b98@gmail.com>
In-Reply-To: <20241215-320-git-refs-migrate-reflogs-v3-0-4127fe707b98@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2464; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=IB9h00v4zfs7q+FeZZk33xlgGFW2QmXAcKQGj56BkwY=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnXwMNi0jRUAToXzhracDci5bYYFEf843L++Vin
 wnZZ33yPtmJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZ18DDQAKCRA+1Z8kjkaM
 fxxbC/4lmJNV09bcvVJghGfJ/HfRmEMZ9Tgf3C4V66G1jAeQR7aekpcqdjIcMV4h2qSKHzasAPk
 Tp33OEkXra/XJAnjpCt1em5VlYtxCYPLu2TzU21hzcCnLtpqZwKXWGGfjuXjwodS9VtlNW+emuL
 b0B5XMjCSuIo4iD/9pdPPJ7qGmSgYQx7sjjOEUm3BxrabGhWALdnZpxrJZwQ/OWtHjxE/4i/3uz
 6/t+vkZ0z7UppATLfZ2ym8uGEKOdYoSXcQCUbjwoWTJLx/zmlFLeLyKskGJNys9WO+b7csDx5rE
 4k1Hpf1EG/CGFlNfh5Y0x2OTU+L7wdF1gVe7NpfvHjbFuRt6sjr6cFaFpxuwea9W5TIlNMCHvYO
 COg+EIIGtwC6VSWG24Phhgrl7gT7Ax8dWwuYr6WTfLcMfmrvAPwTnQ5z2NeB7l5Cs+jCpEx1EZv
 J3qOBmFQ77mf54qy3qadhDZFRrdJr5ZGp3FltADf/VMt2awilEnbEQbBRfmSCpZKJorh8=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The reftable backend, sorts its updates by refname before applying them,
this ensures that the references are stored sorted. When migrating
reflogs from one backend to another, the order of the reflogs must be
maintained. Add a new `index` field to the `ref_update` struct to
facilitate this.

This field is used in the reftable backend's sort comparison function
`transaction_update_cmp`, to ensure that indexed fields maintain their
order.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/refs-internal.h    |  7 +++++++
 refs/reftable-backend.c | 13 +++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 0fd95cdacd99e4a728c22f5286f6b3f0f360c110..f5c733d099f0c6f1076a25f4f77d9d5eb345ec87 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -115,6 +115,13 @@ struct ref_update {
 	char *msg;
 	char *committer_info;
 
+	/*
+	 * The index overrides the default sort algorithm. This is needed
+	 * when migrating reflogs and we want to ensure we carry over the
+	 * same order.
+	 */
+	unsigned int index;
+
 	/*
 	 * If this ref_update was split off of a symref update via
 	 * split_symref_update(), then this member points at that
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index e882602487c66261d586a94101bb1b4e9a2ed60e..c008f20be719fec3af6a8f81c821cb9c263764d7 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1279,8 +1279,17 @@ static int reftable_be_transaction_abort(struct ref_store *ref_store UNUSED,
 
 static int transaction_update_cmp(const void *a, const void *b)
 {
-	return strcmp(((struct reftable_transaction_update *)a)->update->refname,
-		      ((struct reftable_transaction_update *)b)->update->refname);
+	struct reftable_transaction_update *update_a = (struct reftable_transaction_update *)a;
+	struct reftable_transaction_update *update_b = (struct reftable_transaction_update *)b;
+
+	/*
+	 * If there is an index set, it should take preference (default is 0).
+	 * This ensures that updates with indexes are sorted amongst themselves.
+	 */
+	if (update_a->update->index || update_b->update->index)
+		return update_a->update->index - update_b->update->index;
+
+	return strcmp(update_a->update->refname, update_b->update->refname);
 }
 
 static int write_transaction_table(struct reftable_writer *writer, void *cb_data)

-- 
2.47.1

