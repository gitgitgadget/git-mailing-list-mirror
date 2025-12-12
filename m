Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82162D1319
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 22:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765579016; cv=none; b=fHmLwoLxwYVtfmbJNIkZf89lXZKGjE/Gxa8uMdELE9Hov8xIZa00QsrDzB8nPoJUbZJkXODO4OuNtBHX5ik8duVjsk9uro1DAjOSypjyREPAkPWsxmSeGi6jh/pTXjwHKHO4bS/GQduVD885GS4u0u/aNwKwkbhttNbsrkBgxQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765579016; c=relaxed/simple;
	bh=MIJd8k/4ROhcROgzX3Fsgfvygfc7LcPolhCYXA3QpfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bObR55zbzMCuhCeyfcgrdC2QyjVA/99Vehv/+h4skW5vSASN6OjqRjWFjp5cmd/jkOi2Q1wQg9X7Br3fONcjDPZ0aXc2J/pYhhFCxI0TyijOF+aXgD9my79lTqSF4c6GMHAtNO2Q4xmfz44M7eWvSARuPnnHwKv9XZ5NKP4IRmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KI1lCugm; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KI1lCugm"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-3f5ba2fc0d1so660061fac.3
        for <git@vger.kernel.org>; Fri, 12 Dec 2025 14:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765579013; x=1766183813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bm2iWL1+q3iDgCLH2vqTqRMb7Qr3bhx1NT0HJJbPJDQ=;
        b=KI1lCugmtz3IcXKazp8kpXj/XF/n4sOIizDmwmzyF5HzDHTnDfNHof4tSHA00xsL9d
         0tJBekmiGT12uDA7WhrCkkE383Zw5rvfV9GHSkY9gNpJMvEeiLOTHP9YgvY6r32ilJnM
         0KT55wvYllDW6D2NtvmEAdxrM95qwr9gW+bvrhnqdRcGeRKUVsZevmne85u9uY4ppCcW
         Nzbjp/Kh/3zq9qO7BbOJEFwfhynwchIUe4WAy3P6a9/8epM/YPPtWt4yZEg3qNt6xWhy
         DVOqgMdHoFNnFw9/yWtVAUOGBMfiYbNQDyNItCx6n5LfM9OYKHaXrbxj4XWPy69+B7Jt
         BjFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765579013; x=1766183813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bm2iWL1+q3iDgCLH2vqTqRMb7Qr3bhx1NT0HJJbPJDQ=;
        b=Dw+r1/CM/xXqny35IIf3w7UxPdpLNeTvn8S2BxrkuY4eCXcSJWqMFPfeRW1ttJvHtG
         K49r/RP5psHyb3Iunuq5edr2HQqQhBvYn2mY90OxPnmAKle8VmDEn5MvjRFarrNtQT6A
         RBwjt8qmjCNDSWRNGbUb0H4sET5FVKmcDMkZhfOKW2tK0OQXncCoW57OjTpRyqzFUQwS
         qkIOqKtBkPy4bapgGPJVHYcsZIl8+ervhx3LNAtdLx6399Ul2X12nQgEg70v7aQ3G6Q4
         kW+UzvB/1XX6HtzMwtFLz3ym9UsxywSjxgyR80d2QRVNTkN9slZk1NRgKmZ13AtrxB/p
         oK9A==
X-Gm-Message-State: AOJu0YyH55DW6GxZ5J/8YTpkv0Ia+w81h/Ls6WRJpFzaY8pRDS9EL3D/
	FIX5PIY4xyr6b/QSq9c6MItvu8jtdsRsx7/MAlYNoF5icBx3Gjr7c206SqkTNA==
X-Gm-Gg: AY/fxX6KGm04HcexG3G8yhFK4try6ljvFuc0NFarA8jsPHimKlR29G5YRcuijNpwf8k
	XwRZrrQQSA3BF9PYvm1PJweU2qHsbT8sQ4JbvpxzTajTl+rfbldBmvSwHqj2LwcJ8E+zNfVy7yr
	S46hoVs5xAkq/Hb9z/MSLp2bQYzKevn2QSzMTBJehH5QntkYMhMLnPPFQqIWhydZP/yXJh13P84
	+5ZdyZApTCHEeRBB/Dm3l/AfXbipMiFcmZ1sQKG6M1PB9USquFGSQqRbzdtYcGUcKcrDFRD8fMJ
	cHPEfLXHnwbFznTRmeX73u22qrbAxO5iNDhHTS2+DewJGtXrrfTlqptpgL6jJi8CXLO874Yic1C
	iORJy8Uinnt4q+8Ceqbn+/2x2vWwm9dfVacYJei+tFp/SZ649sYHuL+EIkdXUjru38sI7f++WKM
	EFXQvzNb4AuDDM6woRReY=
X-Google-Smtp-Source: AGHT+IHOIkBQe7E1dVZr/V27bkOPwniF1KWwUbbr/f9Fz6c5uhKWGRenep2FjuO8KEwWGZCXC1SusQ==
X-Received: by 2002:a05:6871:4b08:b0:3ec:39bb:d50b with SMTP id 586e51a60fabf-3f5f86af315mr1996044fac.5.1765579013512;
        Fri, 12 Dec 2025 14:36:53 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f614ded1b3sm173998fac.10.2025.12.12.14.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 14:36:53 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 6/7] builtin/repo: add disk size info to keyvalue stucture output
Date: Fri, 12 Dec 2025 16:36:43 -0600
Message-ID: <20251212223644.3090879-7-jltobler@gmail.com>
X-Mailer: git-send-email 2.52.0.209.ge85ae279b0
In-Reply-To: <20251212223644.3090879-1-jltobler@gmail.com>
References: <20251209225820.2861276-1-jltobler@gmail.com>
 <20251212223644.3090879-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to a prior commit, extend the keyvalue and nul output formats of
the git-repo(1) structure command to additionally provide info regarding
total object disk sizes by object type.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/git-repo.adoc |  1 +
 builtin/repo.c              | 18 ++++++++++++++++++
 t/t1901-repo-structure.sh   | 11 ++++++++++-
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 287eee4b93..861073f641 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -51,6 +51,7 @@ supported:
 * Reference counts categorized by type
 * Reachable object counts categorized by type
 * Total inflated size of reachable objects by type
+* Total disk size of reachable objects by type
 
 +
 The output format can be chosen through the flag `--format`. Three formats are
diff --git a/builtin/repo.c b/builtin/repo.c
index b0609cfae5..252a53f452 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -214,6 +214,7 @@ struct object_values {
 struct object_stats {
 	struct object_values type_counts;
 	struct object_values inflated_sizes;
+	struct object_values disk_sizes;
 };
 
 struct repo_structure {
@@ -471,6 +472,15 @@ static void structure_keyvalue_print(struct repo_structure *stats,
 	printf("objects.tags.inflated_size%c%" PRIuMAX "%c", key_delim,
 	       (uintmax_t)stats->objects.inflated_sizes.tags, value_delim);
 
+	printf("objects.commits.disk_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.disk_sizes.commits, value_delim);
+	printf("objects.trees.disk_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.disk_sizes.trees, value_delim);
+	printf("objects.blobs.disk_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.disk_sizes.blobs, value_delim);
+	printf("objects.tags.disk_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.disk_sizes.tags, value_delim);
+
 	fflush(stdout);
 }
 
@@ -545,37 +555,45 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
 	struct count_objects_data *data = cb_data;
 	struct object_stats *stats = data->stats;
 	size_t inflated_total = 0;
+	size_t disk_total = 0;
 	size_t object_count;
 
 	for (size_t i = 0; i < oids->nr; i++) {
 		struct object_info oi = OBJECT_INFO_INIT;
 		unsigned long inflated;
+		off_t disk;
 
 		oi.sizep = &inflated;
+		oi.disk_sizep = &disk;
 
 		if (odb_read_object_info_extended(data->odb, &oids->oid[i], &oi,
 						  OBJECT_INFO_FOR_PREFETCH) < 0)
 			continue;
 
 		inflated_total += inflated;
+		disk_total += disk;
 	}
 
 	switch (type) {
 	case OBJ_TAG:
 		stats->type_counts.tags += oids->nr;
 		stats->inflated_sizes.tags += inflated_total;
+		stats->disk_sizes.tags += disk_total;
 		break;
 	case OBJ_COMMIT:
 		stats->type_counts.commits += oids->nr;
 		stats->inflated_sizes.commits += inflated_total;
+		stats->disk_sizes.commits += disk_total;
 		break;
 	case OBJ_TREE:
 		stats->type_counts.trees += oids->nr;
 		stats->inflated_sizes.trees += inflated_total;
+		stats->disk_sizes.trees += disk_total;
 		break;
 	case OBJ_BLOB:
 		stats->type_counts.blobs += oids->nr;
 		stats->inflated_sizes.blobs += inflated_total;
+		stats->disk_sizes.blobs += disk_total;
 		break;
 	default:
 		BUG("invalid object type");
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index b18213c660..1553f3cd32 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -4,6 +4,11 @@ test_description='test git repo structure'
 
 . ./test-lib.sh
 
+object_type_disk_usage() {
+	git cat-file --batch-check='%(objectsize:disk)' --batch-all-objects \
+		--filter=object:type=$1 | awk '{ sum += $1 } END { print sum }'
+}
+
 test_expect_success 'empty repository' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
@@ -91,7 +96,7 @@ test_expect_success SHA1 'keyvalue and nul format' '
 		test_commit_bulk 42 &&
 		git tag -a foo -m bar &&
 
-		cat >expect <<-\EOF &&
+		cat >expect <<-EOF &&
 		references.branches.count=1
 		references.tags.count=1
 		references.remotes.count=0
@@ -104,6 +109,10 @@ test_expect_success SHA1 'keyvalue and nul format' '
 		objects.trees.inflated_size=28554
 		objects.blobs.inflated_size=453
 		objects.tags.inflated_size=132
+		objects.commits.disk_size=$(object_type_disk_usage commit)
+		objects.trees.disk_size=$(object_type_disk_usage tree)
+		objects.blobs.disk_size=$(object_type_disk_usage blob)
+		objects.tags.disk_size=$(object_type_disk_usage tag)
 		EOF
 
 		git repo structure --format=keyvalue >out 2>err &&
-- 
2.52.0.209.ge85ae279b0

