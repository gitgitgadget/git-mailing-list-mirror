Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFF621B91C
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 11:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742450; cv=none; b=cT0+/dxqvgAH5MPNf7E14+RgAeMbGKIOG7vCAO3DzfOESEOb+6ad+jl432qX3iXTEevYDMbFhCdncBZyrSGH7AVXpcsbi7KCNC5ra4zid4v2/EfAf4RC7fn+XJk1s3vE0AVTDnAUvmTf3zCgYjiThyidRP1Xay/5i1mWZLCEgu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742450; c=relaxed/simple;
	bh=IB9h00v4zfs7q+FeZZk33xlgGFW2QmXAcKQGj56BkwY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sd7e10EQyBp7NCPedZZ8T/GshJ45cFQlI/HzcGfcjtwkWa8Okumtm0Z9OAil7p3I3FouX4FaxpW4+jCI/ccbqcIOmeRqauNazejAYPjSTeK2C66mF3VfxW36j2GPgHjPAx5RAiLTw98yfemB3aiUCUlXyltw30xcqyC/jrttaWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4UWgE+N; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4UWgE+N"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa64f3c5a05so350227966b.3
        for <git@vger.kernel.org>; Mon, 09 Dec 2024 03:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733742445; x=1734347245; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lUvb5dIPp19cc7hdfTanzPMDqohb3VapJTcypa4CDlg=;
        b=b4UWgE+NrX5SCdAQoyVYyhwZzSfHPWoCWugfoD1/VJ7RJSnna6VgitUuI8wO/HL52K
         efrYSnILrwdTQmGYKWbEynONChoGtnpkzC0bnfAZg1J1qyQEEsuH7T3cdfyOtEmC6ps3
         uaECc0vclO1PbGXtr9I224ELEXS3BQV71y/7oNnNlPRIWqTSzicbVEbxIGInLk7cO0v2
         1v/dwvm9tulM8pXXohVSqINn+8O+96qWrL0sduNOTpvbi3xGG29oqsXfbLSqcFTLYgLt
         nKDmKd+KixhD78NHi3U30gkLjNlh12SBwemZ+83h0B4wpS79o3hty3PYn9UZKCyqOLn5
         AwzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733742445; x=1734347245;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lUvb5dIPp19cc7hdfTanzPMDqohb3VapJTcypa4CDlg=;
        b=rHmqbGnKWh8n/08Ukhesyu0X41dIFVmfNHuxN+7zX+ZcthgW2r3Y2B0EuzLGxqGofZ
         E51G5W/aIyzpg+dfFdWa5lPNDDhlLS99F8Ab7d27OPwI/fu6jnuJ0mYREwXY1L6VOjnU
         lsW0lQpIhU5QBIGb6Z6pN7LrOPUzyOf0m8zhvlmY3Kch9cKvVEK2P6F73RtGAN6HdO/U
         UO60ilrPvS6C9IAnUfOK0sADN10vhTqTeLIAamWemhppk0cdyKWDOVGgGuxW/1kdtupN
         H5Z6CzrK9IynTnLUyioG7Nw7GAMZt3qOVLkUmqVobFpinFQbqhxDEgbPv81lumMLuQaM
         UWHA==
X-Gm-Message-State: AOJu0YzwmawWk/PZz1n+MEtDczwhjr7ktVpHqkIDLotZs6UzfgHNRKpS
	xGq0kmymPOzEJWP9kyPxwJW4JQKjYa3AGtt+wBTE9QdAeQ6rjhx5vEB7NrOo
X-Gm-Gg: ASbGncuPQVQRXOsA4nJ9ka91W7r85Z3CqiAPxEd2XQbjmCbPwQfX1vU6ygIOUhT1i0Y
	Z3Sq3fHRkdG7QgMOqdF/wra/saLd34WQoy9bHHMgS2Mrfo1lrAcS6fXpVQqqskzBKHf/CnZl2If
	uIzGuNwxK2t0u53X8X0cxVLiNiACpqfidmcxJa+c17gLEWsMrscpMQ8vqQ7dYixcmB1p6mYmG11
	yfjis5c7+eu4tgrXJ8zYtJFuVOLQqUYZxp8aIJPxmjZyBaN2YNsnkntpQwT6ZY=
X-Google-Smtp-Source: AGHT+IGivM0pKNa6dg6VN+MmXHpcvUfNkaDjY62c2dF5lN+hdkxjJgm+iaxjaFlu3vQWH+WhHlIerA==
X-Received: by 2002:a17:906:23e9:b0:aa6:8ce6:1928 with SMTP id a640c23a62f3a-aa68ce619ddmr249798866b.48.1733742444220;
        Mon, 09 Dec 2024 03:07:24 -0800 (PST)
Received: from [192.168.178.20] ([2a02:2455:8256:2d00:9c39:c2d7:aedd:294d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa672d377fbsm257013366b.75.2024.12.09.03.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 03:07:23 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 09 Dec 2024 12:07:16 +0100
Subject: [PATCH 2/7] refs: add `index` field to `struct ref_udpate`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-320-git-refs-migrate-reflogs-v1-2-d4bc37ee860f@gmail.com>
References: <20241209-320-git-refs-migrate-reflogs-v1-0-d4bc37ee860f@gmail.com>
In-Reply-To: <20241209-320-git-refs-migrate-reflogs-v1-0-d4bc37ee860f@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, toon@iotcl.com, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2464; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=IB9h00v4zfs7q+FeZZk33xlgGFW2QmXAcKQGj56BkwY=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnVs9nG+ho1weYLZZriqxo2sVBFAN1zW+svdMi+
 zUwXj5aHaiJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZ1bPZwAKCRA+1Z8kjkaM
 f79RC/9u7GVl6hptX9bIn5PXVkQ41tTdhRYisFi1S7G84pqfqwfBKUwekn6gkWtl8g5ILv8j2IU
 c1kSj8NYXESS/4abO62F/f/Ms/3/Dm2URPWcAzLARdgArkNX7kkdGWkGPi5E7s6tGW5D/ax/kbb
 HNQpRGBFqLX8mRXTxMxPfYh2CHF6KBz++x0GVVjSQJPHRCCpX/+OfX37rjyOESTSZpcAltQ+3dW
 Nh2UhTpXAv6sxgpv+VhVJ+Blh5g3ITwU6ACkuuNktuFLgElN6H4vTzxoCninc0UqQNsXqEuY2cN
 FD9nzQFvIM35cV7wtL/d2v4uW2uD7IjX+VgvPzWtdWBNJwN1og6XXcnjG5JSNEwZC1jZlmUr+V9
 f1hUqCGOSB7bFMzzQv+OAT43in2C9nqtmI+MiWG/Cdtl5MJevDXGAc1MK8lkokTY+9A63cpNW1W
 apbkVTE0K075Ej1nBdO9N53/t6KjnEcQuQ94mzWvL1zpoIQ4cBkY5DsqcPQlb/JH9Ijaw=
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

