Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECD622424D
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 11:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742471055; cv=none; b=dTLr5uFpER+JmNpnqPV0k8dlWDjuBPd1AIaT7f+diUuvYuiczBxwNMejTYfGukpJCIrUEukB9ON9gpI2EONch7FrD8WrRJvPci4ZbEZ+PlnLL/Mt4zZH2DqGUXWkUzPguZYoxwR/UZSSXZaNjfQP+9QKK2oFN+C0jES+szMu1Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742471055; c=relaxed/simple;
	bh=jMxSi78Ou42dqiV64yEbnYTH/R9O8cbltEOgjGxX5Bw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nq/bCN1W+Rm/zVajog6qL1Ry3K8qtSBkDvtb/4lzaJleAXqMyAVxUpmGizGLIazTG+vgy/kkyVHme9jNSRRoYsVKPkVn2+3H3f8CP5USL/lEQcir32Qzz7i3A7J8Y3eKpOjF66PoxOsZ5yl+ohmu5neFUjvm6csm1TPg4UmOB/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfbZMmSD; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfbZMmSD"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac2aeada833so137855666b.0
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 04:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742471052; x=1743075852; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bc65zLz9YYweJmOCsYLVTRRerGukoX4aoY+eAYY8QkM=;
        b=dfbZMmSDmnEViVuubeeoX35EVcTY7Y6YgIHAauxbvWZiRbxzPDLAVcI3/ZM9K26CUR
         meI7CkwKvSe12RMUOD1KH9khQbD7Ik1rQPN0spPHvuFEstofgPaCaQkB8w5GchzHaseN
         LEBrjcPUH2eyDgPYpulnhPaAxjnVsR40VPx+Dw6hvP5irP6zTVZGJ6sBiIH7T8UHrO7T
         2tvXjWdRiLsq0xyimF1W6vEbJ9SK/9+VzJa5yrz/3O1hXOcJivVob/jN0q397z48PuU5
         /Y+ql7AkMaEKJuy0574SD5ByDQUneEU0qTQxp4kFfPTx5TSTFp2OwUY0Q/koO1F9Axnw
         i9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742471052; x=1743075852;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bc65zLz9YYweJmOCsYLVTRRerGukoX4aoY+eAYY8QkM=;
        b=mY2opVZ3Com/6/vSGo+2c/M9jRvQ3njRHOYTrj5b2HOAMUBQCxSPiXfN7PEbeSsHAa
         pCWRxKvscl1a3PMy8YKJXwdeG1EDKRu9SHHjxEG1QH2DiaKk0ZCNUKBreSZyCAKbJlCg
         J3gdR0NoaZ/ZbJzud2GzQ0nZyfBopBItbF2W6vGkR6rLZwa0xFXJR+RClD4IRmCfwkDp
         HuG479hNMkT+S9k74s6JLp01bRwxCbSNyhznT87/DofwYfgNDBdlgluxVb5YJg6Qx4L0
         3A/W7ZYt8Wv1Bpd79r/H83/lk8w63kiSAq5ZL+D5n/NsO65ocMb5LdBUgsbql8wWLYWG
         6kaA==
X-Gm-Message-State: AOJu0Yz80QL5neybIkONBa4wl+GTofELMn7PCyhkymmyVEUhVqd0ej5S
	8LsZDSNmYRzBPUgAmqt14S6Pnh2Scakx8qxWeUr371SA+P75HIC4ABDs17z0
X-Gm-Gg: ASbGnctIKSysBBUKCzabDabDICICo8kW7Qm9I6ecnXCWs9ZA3Y/EjD/Eil1ZF7tc0/k
	81YgbZM6gTeW+KcXkiYT2zM3eWABy654uhi/TaNkIiPug1UqulIP7j7xqB78wtMnffAw0a9oLnp
	clXusCCvG1tVDa64eQ3vKMP8UZroQbKfY4eHqh75jx7Hx8vmCD3aqN5ToN9dqLdtzwL9Eusy/HH
	addL3MeQM/e+ht2zfNwN/o4iynahjBDN0Hn8/HQX+2QNqwdfQVI+7s9an+DEhIPWsnCrKB22NZ7
	qJQxeFQWmGyqc6cJc3i23pIxMLh1DUPjQK/1rIhcG1Ag9zw21po=
X-Google-Smtp-Source: AGHT+IEN8Yt191tCXLEds74XnSE/7AX/g1F9nHmHb2sZrKutRMUXxsXvUPUYdb6yWr/pTGqEdPY+CQ==
X-Received: by 2002:a17:907:9805:b0:ac1:e45f:9c71 with SMTP id a640c23a62f3a-ac3cdb49b76mr355875166b.1.1742471051432;
        Thu, 20 Mar 2025 04:44:11 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:b4f3:1c64:be3f:2632])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149d0077sm1167298866b.93.2025.03.20.04.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 04:44:11 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 20 Mar 2025 12:43:58 +0100
Subject: [PATCH v4 3/8] refs/files: remove duplicate duplicates check
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-245-partially-atomic-ref-updates-v4-3-3dcc1b311dc9@gmail.com>
References: <20250320-245-partially-atomic-ref-updates-v4-0-3dcc1b311dc9@gmail.com>
In-Reply-To: <20250320-245-partially-atomic-ref-updates-v4-0-3dcc1b311dc9@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, jltobler@gmail.com, 
 phillip.wood123@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2998; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=jMxSi78Ou42dqiV64yEbnYTH/R9O8cbltEOgjGxX5Bw=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGfb/4cKSQIuTJzUwWW0MYl27SABjpNuZFblj
 GrjhqtV5upzxYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJn2/+HAAoJED7VnySO
 Rox/1c8L/3R4xbeX9H8EERFNAfCDSGcPi9vMQZBTvIYyeWknio+vaHdhtRSkcAJrKTs9cfFtpEZ
 Qo3ON/Os4TMpqyWaMT5h4g4jTMEERlALA0ly25iMVN6VvLHANt7bbRYGMAXt9MwwUIkvWB1je1v
 U8CVCEtfXFsJnMS1MI5oQiCbL4vdHv97NyK7w34+9gqP8SRRd6Zi0Fc3jh5BVUYg7AMGN7U7QuH
 oGf1UPG2o1u8/oxMyk71e5CsuTbt4GUcSTwBBLxopCTRHYeSoAho9EJk0XRXze7/i0o1+Iun1GL
 MEv5XuHLL7ZUuw86GZJfvs84tnFP9vwJfAeIbvoqPIG9gCowR6WRT/HLhX+b52Ig4Jx7tKwWutB
 ADe1fvq+h0f2oBQ1qAAT3jRY9RC6AAgKCX11t/tdOurl15RkZdVuEBuDImOC89XTtw4Q8sXw1ct
 P91ikR5desxcrWI4EYPgq0e8Bzh8ZpQSrVB4e4QKEqF3n4OLQjz6WUIpE2BEuhZ82D7ixIVR2+5
 o0=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Within the files reference backend's transaction's 'finish' phase, a
verification step is currently performed wherein the refnames list is
sorted and examined for multiple updates targeting the same refname.

It has been observed that this verification is redundant, as an
identical check is already executed during the transaction's 'prepare'
stage. Since the refnames list remains unmodified following the
'prepare' stage, this secondary verification can be safely eliminated.

The duplicate check has been removed accordingly, and the
`ref_update_reject_duplicates()` function has been marked as static, as
its usage is now confined to 'refs.c'.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c               | 9 +++++++--
 refs/files-backend.c | 6 ------
 refs/refs-internal.h | 8 --------
 3 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index 504bf2063e..61bed9672a 100644
--- a/refs.c
+++ b/refs.c
@@ -2303,8 +2303,13 @@ int refs_update_symref_extended(struct ref_store *refs, const char *ref,
 	return ret;
 }
 
-int ref_update_reject_duplicates(struct string_list *refnames,
-				 struct strbuf *err)
+/*
+ * Write an error to `err` and return a nonzero value iff the same
+ * refname appears multiple times in `refnames`. `refnames` must be
+ * sorted on entry to this function.
+ */
+static int ref_update_reject_duplicates(struct string_list *refnames,
+					struct strbuf *err)
 {
 	size_t i, n = refnames->nr;
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 58f62ea8a3..ea023a59fc 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3016,12 +3016,6 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 	if (transaction->state != REF_TRANSACTION_PREPARED)
 		BUG("commit called for transaction that is not prepared");
 
-	string_list_sort(&transaction->refnames);
-	if (ref_update_reject_duplicates(&transaction->refnames, err)) {
-		ret = TRANSACTION_GENERIC_ERROR;
-		goto cleanup;
-	}
-
 	/*
 	 * It's really undefined to call this function in an active
 	 * repository or when there are existing references: we are
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 92db793026..6d3770d0cc 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -142,14 +142,6 @@ int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
 		      struct object_id *oid, struct strbuf *referent,
 		      unsigned int *type, int *failure_errno);
 
-/*
- * Write an error to `err` and return a nonzero value iff the same
- * refname appears multiple times in `refnames`. `refnames` must be
- * sorted on entry to this function.
- */
-int ref_update_reject_duplicates(struct string_list *refnames,
-				 struct strbuf *err);
-
 /*
  * Add a ref_update with the specified properties to transaction, and
  * return a pointer to the new object. This function does not verify

-- 
2.48.1

