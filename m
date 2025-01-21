Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42811862BB
	for <git@vger.kernel.org>; Tue, 21 Jan 2025 03:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737430478; cv=none; b=nQDyJWoefA1X6lBjpGT//2cB73z2s8UlXkFEPtyoBv5J0TPmzBfQQfjPGbr+TcQk6aQMuMWYHGZr09/wcHLrCl/5AzTbFjzc3NX+qt5XuiX1FsWIccB/VVT5Mpstimax+ACvmr4UoQ5PU3YPRvKiW0bxLIfGGytzf8hbzIJ/Iso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737430478; c=relaxed/simple;
	bh=67d1Ix8aAmNRTgR/Bvv6TXJRyzwplTwSAZM5YGxA9Gg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IMiLqUgFjbwt5HO1/KgZ4UPpBepl9X8SuvABoWpqf/n1Uz/jQYgWxpUN5C1+uugSW7bqW6nClXz9V8Y8VTiyhRQ2DOwksdngzS9b4OuLPin2+2QJPByii6JHB/MQCwF3Wg2cXvaPNVhhH+5o0deiMSWaa4jrSAEmvcyEuq7/Vwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2rcDvvN; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2rcDvvN"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2f43da61ba9so6644439a91.2
        for <git@vger.kernel.org>; Mon, 20 Jan 2025 19:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737430476; x=1738035276; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BiUhG0rQ6Qig+Jfqu0diARchfeZC/aytcSuPqquNORA=;
        b=T2rcDvvN4hS1XJ+ZK+tbQ6cBydJWNKOQ0uYreeaHiDAu6eeaMWnKaqs9V3ckDWXqHr
         XqasxNTU5GPeEJp3lI0KC3Zwn4n6KAcneTEWWgTge2q1YB73oGId7nPc/dOIaXJeZ8p4
         kla5MDBsyazYUZeiAJWMYA6cc0yjPrpcVK/TyaJrVQAhzexXONOjDSplHGyZfF1YpMIw
         IwGIffDcDpDK4Inf4n2Eu5+so6t/V/1iwtCyXvqpUcyEQFQc2rrYM208uSiW70qSR15U
         S2bbSKETM2+lYDG4T73jPHsDR36Nk2dGj5lzCj9r4QBfk2Sl0W7VLAwbqXxZ8ImL/oyR
         OG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737430476; x=1738035276;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BiUhG0rQ6Qig+Jfqu0diARchfeZC/aytcSuPqquNORA=;
        b=U3VDyyUwcMlg1H37S7u483b20HZOUvMR28rkkZmNA04EJt62WEEpab+TwNurI0X1T6
         h3TNZOLqm2hR0h7hW2zTMF97IoTCEB5Z3mOoQQWZrg+tdWqw/Zs2inOVH5uwa1Xb/7Ai
         ILlN1GCuugjxc+StggLiNmfFJ4cTDO5rANPbRMxgXDpOfNQbmFfm8gPRDp2JMY5Fwi9e
         IgWerZfsisGR3Mbh/0oFAzRHWNIQ9dnqMvjTezM8x7ysG3wSlJZRC360Wx9iSTc6+xmi
         qdH3kmDl3YdV0BMhtPezGeV1b/69VQwG3Ar8gARg9RCTBjLaKGdUJngfzBnmpa/05ovg
         ALng==
X-Gm-Message-State: AOJu0YxTvdt8st5Vdvv4xFerL533x1LMWm6pIfIIx6Yudi5XmqxEffMB
	Kay/VJCBwSn2siEtjuEv2h5DmSfHoSp9kRTI4t26rFfUxdvlV2XT
X-Gm-Gg: ASbGncslJKR4NcL0tUJzc+VRcgrmiI9Pg+eUvylJDBh3f1P3xQar01PZ0mZ3UsvzwgS
	aUj9zTDCj/QnxAdmSnSrPFZyH9tuUKaUDI/Iw812w9qQcZdSu/n6bpXZKQbmY6vHqJ/rRWSsm8O
	sZ24NuoUElVkZrdozALn/Ip52qsZdKooYQRUomI0nI44GFng/s1oQFCIPHa7RNnih2e9ORG8iGd
	eOeSit9qmqWJadn3JRwsDtyMKaUOliBEza0Xq70tZOLstTZFvFsoMibje5gYsYwSj7ymqiT
X-Google-Smtp-Source: AGHT+IFYV8Ky7o6nuyw5ianj0FTRfNDXpkhVR1h18fNim79Xi2RPcWdC29le3vf01zILAo4FWml1UQ==
X-Received: by 2002:a17:90b:2d48:b0:2ee:3fa7:ef4d with SMTP id 98e67ed59e1d1-2f782d4f152mr23634088a91.24.1737430475880;
        Mon, 20 Jan 2025 19:34:35 -0800 (PST)
Received: from [127.0.0.2] ([103.39.127.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7db6ab125sm126291a91.26.2025.01.20.19.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 19:34:35 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 21 Jan 2025 04:34:11 +0100
Subject: [PATCH v2 2/3] refs: use 'uint64_t' for 'ref_update.index'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250121-461-corrupted-reftable-followup-v2-2-37e26c7a79b4@gmail.com>
References: <20250121-461-corrupted-reftable-followup-v2-0-37e26c7a79b4@gmail.com>
In-Reply-To: <20250121-461-corrupted-reftable-followup-v2-0-37e26c7a79b4@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, 
 "brian m. carlson" <sandals@crustytoothpaste.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2559; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=67d1Ix8aAmNRTgR/Bvv6TXJRyzwplTwSAZM5YGxA9Gg=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGePFcQFSsWlMEH3MOnuvuA1AhEUkS1diAuzm
 LrVqZQZD2KPf4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJnjxXEAAoJED7VnySO
 Rox/qesMAJStR3YaAsEfsrkL/KQZXJfV8rR23/weT6DOdPrd3RZwVqLAeUKZARQBfySX+urQ5zN
 Ek6qx3+OepYtD+7tigNRBf4dhseEVgRLlc3YYMr0EZ4t2jVa3l4a8AP70yz64fMaqgpkPHrgPDp
 dRs5ijtAQ+XxI+l/kEScZwLhv0+l92HiF2ue7Fo94B2iZMxjxuMf+H7MoHlIFZBPP29YzjXLTW+
 BkdNqZ+JMdDLX0CuJAvyI3rpfEXGpJYEGJQw7ew0h3Yc1kr7ubWKiqfyq1E1knsrs7WdvNUUTB4
 8VN6EzO7Gy9Lzl5zg7e4RnwLtWUEEl7bWM3QNqseG7ApzvUBEmUwjZZ4f8a0rbZJsvY2O8/5/qG
 1fVUESgZ+s4DYt9HgF9/XbQzxVxCHEGyOGZE8aD30WGN8sOz61Qfed4RJkzXZyRgA2HmJPmKeUq
 KqGhX+5fauN4Uom06XiRtlJ8Yd94Xfly+NfReB1n/eBhqXjvt3NS1qQGAYUmIJrDVJtcJvO11z5
 04=
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
index ad6d774717150f1fe68a59c629e05e49a469693f..ef04f403a6a3a34f9156b4cf68c3daa29c9cbad6 100644
--- a/refs.c
+++ b/refs.c
@@ -1331,7 +1331,7 @@ static int ref_transaction_update_reflog(struct ref_transaction *transaction,
 					 const char *committer_info,
 					 unsigned int flags,
 					 const char *msg,
-					 unsigned int index,
+					 uint64_t index,
 					 struct strbuf *err)
 {
 	struct ref_update *update;
@@ -2813,7 +2813,7 @@ static int migrate_one_ref(const char *refname, const char *referent UNUSED, con
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

