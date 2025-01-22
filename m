Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B974190692
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 05:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737524167; cv=none; b=PbksFkWLQUeQBEdha85sDtQr6N8tRkPnB0hHwz6ZA0r19FXkyfNNuGJ8hybZDRYwrBwr+MVME+aPprizkiPP2bPIO+EXSti3ePut12F4v0rg7wZArhwm2j9ZYfLrjZ7WuMAZO4lPBe81JjRDZ5dpnN57BkQ59YkjzcB7op5VO4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737524167; c=relaxed/simple;
	bh=67d1Ix8aAmNRTgR/Bvv6TXJRyzwplTwSAZM5YGxA9Gg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bB82kc5/rqufggO/KTjMEWyq6lPnPEq3fiOOtSe5s34yJIzVq8hg30rLki+dsOCzQWn20K0zsAoDIyHYBZAQENNn81oZE47M+a9U330GAQCIqO4fiy9MapvcfWSOuE+xMfY5bSHJm6WWWkpyXZOeosiQ+EmhZRBDklHNhxGQH7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/2BQUyB; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/2BQUyB"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2f43d17b0e3so11712546a91.0
        for <git@vger.kernel.org>; Tue, 21 Jan 2025 21:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737524165; x=1738128965; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BiUhG0rQ6Qig+Jfqu0diARchfeZC/aytcSuPqquNORA=;
        b=S/2BQUyBxkNiIv1g4okBDwJC/89e1HbZhMCuXUxZqYtEuultA+yoDT8mc5Xsb9Q4an
         PPxMZqE3FQR7VdD8/Pb4fPe/6pZSiHXwNrgCuEzLYKk3b70wEQ7WAIQvihzOH9QavtYs
         yMWPKJKwm+IZJ1rOcQyMzy0UPS5yEVWt5jqX0boMcT5gyhTgsf3thRE9plCBRLeYq9Os
         xSyNBAdk8/nwgwtHf0jqVBsgLasnL7yjLQYzpOAcrXkh13oJ7m1hw0vcRqE3375QVrMP
         q8s5LsqLLbcH0DKCTPb2Vqu40DknANF39+cp9lsgY22z2Ww+MnS/kXzLQeWJMMNFmvPA
         d9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737524165; x=1738128965;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BiUhG0rQ6Qig+Jfqu0diARchfeZC/aytcSuPqquNORA=;
        b=cSKM+mLdFnkNCPcoec2qAVtpgk57h7pGQkhxTXldcW3fTamh0VKClQ9iwD8X9X10S1
         GQGcWAQDdhCTAJ62h9pHkGmGc9hZOS1VZGaihESh3bw+op7lrrHsEh9T91tw27yc2q6r
         BeKNR6lAGRNOaN6KGPt8YNfVoBvLzz/6iDehGyihTnppBa+SHqDjrbIlFD1W9cGpTwop
         KA+28BXrca3Vy9RbQ8Z5TZh6UYp12LxE4Xz8IPMFGT3rrnHindI1Wh0XBiNuU4XszZud
         u93l/4u9VWN2Vsf6D5Rs5sxlHYhaQCfyB41ZCvgiFGYWAbPeM4IE5KUwiMMdzO0HY4Mu
         VkVw==
X-Gm-Message-State: AOJu0YzksLccC7wkxErCjtFa0Rwacx5pfHkkAFHYafV0wLQfGSlNg5wN
	QxcDEE/k0VEJbAYaBNSg6+zRy0td/x/T5evHT2ZVnuSxnyLLpv+n
X-Gm-Gg: ASbGncsvAl0bdfGRAFABdmGZYTD9G3cHzV28zASwyyGKonrBdQwhOSL5P6lFEV9zt+F
	xFW8WFoLMsFYx2OJe9nKiSvhWvZnYQccRmzTHPKLy9fLmXJgyDes5bA2aL9FtPYif6YcQl2QrPR
	Q0N+na2u0H97SnVFm/Gf5YPKhwZZ2NWdgpUCHs8xUhWyHzf/DPA4FoUr7IR0TLWazq1PKkDuYik
	LDgk4Gh9Q4PBwe8RqRm9Q9hWuj339TE50py6IdDl6zoGBYbTC/BpQFsJPcY9s3aTZJweWFQ
X-Google-Smtp-Source: AGHT+IFd/2bxoqVqcevaMpVMN5ioGq4X1VrIhNEmK+NIzUeNMtOM6cWS34gIn3jPgC4Yj92pGs7SaQ==
X-Received: by 2002:a05:6a00:a38d:b0:725:cfd0:dffa with SMTP id d2e1a72fcca58-72daf9beb7emr26234905b3a.5.1737524165416;
        Tue, 21 Jan 2025 21:36:05 -0800 (PST)
Received: from [127.0.0.2] ([103.39.127.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72db4e718efsm9369207b3a.152.2025.01.21.21.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 21:36:05 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 22 Jan 2025 06:35:48 +0100
Subject: [PATCH v3 2/3] refs: use 'uint64_t' for 'ref_update.index'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250122-461-corrupted-reftable-followup-v3-2-ae5f88bf04fa@gmail.com>
References: <20250122-461-corrupted-reftable-followup-v3-0-ae5f88bf04fa@gmail.com>
In-Reply-To: <20250122-461-corrupted-reftable-followup-v3-0-ae5f88bf04fa@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2559; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=67d1Ix8aAmNRTgR/Bvv6TXJRyzwplTwSAZM5YGxA9Gg=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGeQg716kFpezf6w6jW89Z85Gc79C41zsQCOi
 R1vAQGbjBqeXYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJnkIO9AAoJED7VnySO
 Rox/NOcL/2b65vcTJ4Lhhsh66daOakfmrcxD0hTHOmzdjvl75g+ZgVrl2tB24EPTff/0N+1Zn6V
 m1uZxn094dceZ5kwoyVD0EP1SyTkoefXFUC5QJh1e+o+gd1bnuNKQhO7UX1JqtStq2xLAUsgBzJ
 hIaCZcDMYbu532L/hs4vuhjIxUk5owYVw2x2dFc8UoSZ4aqxJ/tqt9kLtvY3GTLXs97HUN0/eOH
 +Javmuu0uFRwKogwqUNxbxhgR6PnLe5rfEaFZmhszN5M5qi/9FU1zkpJ3l5FNL3RnlMBDXia1ad
 2bA/VOrcg+GvdL6SQg5bsIO20mHj9cXWwz9w+AGWsYeDWVEAXSRAl1Dir8Hdk8wt+V1U5snfPij
 Lee32WWVQmaHgWNXLnw1tin/zXBRL8lNgdy90I76tvzVUSpAydNIMszuyWaX95DcCqUvjFaesMa
 YdVdGCAd6GYfFrL/NY9wYlD6n0255idIW1KFxRa0maErtzqXzdgI14nscjsvMe/k7JZYfuSqda9
 ak=
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

