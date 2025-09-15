Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E576C296BD8
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 20:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757968212; cv=none; b=QZtKFF/M9dPCeQ9kuKaETQCWPqiP0k8CAyjihF6021b18n/Os5OCnJfC23sZ9OV2Mycpo0PYk6nQhaweO6NGUG/wjCkZW5Rm5h2H8XKR3a4alRZlGXPafxWlo28/QzXaiKraF9RID2t3EWoOpisciueGHw+TYOcjLGNBzSlheMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757968212; c=relaxed/simple;
	bh=PRNtIyZsBEXcYWqniTorG6s1EgSC6k2bL8vzajC4A+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=siNDed++d6iYoJ/dqXVuVMcdgt2X4wARfBXACLoon50mPaQLtQGBDxKtSX7eWqzd0CODQL+5IbPZSlWqyxLBlOnWwWb11VZrHUwmIuPP6l6KppkKZ1NOqNq2YSxldPkKa1+wnQzAGChx0yNIJI/cKn1CyV40kJFgKFPOTa1ofxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIhMfOyM; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIhMfOyM"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-746c0ee5d77so3614590a34.3
        for <git@vger.kernel.org>; Mon, 15 Sep 2025 13:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757968209; x=1758573009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2/iyyWSW5nl82FOfem36g3aryzYBT1VYXPtCqcit2o=;
        b=QIhMfOyMRF+kYpFmrfZZsF2O4w2ATWkxGW6KM+HrwtRvBLQz3Lf0KVgcJCYaRplIEC
         6C8ddyN4gB5ma5AD9/knom+porIyxUZvASTC0DGXfOX944AhmGTvFNNU9tmuGplSnNDg
         YYZ+5Ph6IQVe4XzUjfUDYV/gNkPsSgQoMlWrnJn6BJ0y5XfvdHnC9CEXtMoMBH1LhR4O
         9vBu5QMoUE5Xg0M/MgHXuu+q75NEIjdt5MgJV3ayeLD9RAuwGfGfobno+ehVWgd5C8FR
         dtHQ5+htq9scdgspa7yfVm6YwdE/q6B78RrbL7FlFng3/PjT+VUqdqwKB2MLcv9XUgHr
         MMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757968209; x=1758573009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R2/iyyWSW5nl82FOfem36g3aryzYBT1VYXPtCqcit2o=;
        b=Nccp5+IQiBTLjqW9exjvWqcCGMPDX3oI2K06TPrE8Dd1vYn+peS6h+yuKHCUk0GBuU
         Z8pRVgdVqyydQZcacM0VHsGGcN418HTdx22zNiFRkNv8cel6/Wh9TNtEeJE0bCmfcE85
         3bxtsQUTruZ5dNW0CHVcNnXzKsScFDFUVHu6w6vEJdOkdziHMdf/q6dC26lmbI0sO60q
         f+aEpGR//wvJMNejOUpftty8/KOf1IvaMaU+BFbPAAmwffOJGaJhjIOcRmc3QlmCnW6+
         NncdtSx3ICeo2IvsipimPELnr+n2ZomXTA35pjDVycQrm7eotVaARadJG2n4D4Q33pAD
         ExgQ==
X-Gm-Message-State: AOJu0Yy7ljqmdhqo1csiasiLRjyd9PWTPzNKsPM3S1GZ+2KlCzSaCzxS
	DkTM4Kjmipjaw4DBdyRaapNs8YMiGAa7CpxU/zsIYiSrn9clEek2Fk+DQc8E+A==
X-Gm-Gg: ASbGncuITKBjUg+Wzqh9Ag2RlV36QRaedKLmJEABT2rvPVTYOseMv0etkvI5fEHokBF
	bobx03vTUjLJ5eZwdf/cjADyXtmupoqLnpFcr307dmT/5QJVlzuHKCJqn3jC/qJTWEYlbO9f0Jr
	astusyZZ/zAHv/yALnZK2XgNaSwohvq33cgHngn6kwERqgsCr4swNyNEBw+rZ1bKpPg2367rdYf
	n6Wx6VlZLVHUsZ2pr2Ck3VWCiOz2AGk6XJeXEszTzdZIsU7nELnz9wF2TXjTdGV1kLAJ2ikz8kd
	r/XUiqDRDRiFM5wz//qx44YWyvysw2y0lJPShgkAEZKjgDM9oEpSAzdncZN+0gmS4aGdttkNsI+
	NQu4ZcQBpqFz4APA8kxNHffCELj/SCkOpN7WElB9O6g==
X-Google-Smtp-Source: AGHT+IFKrYdWEk2pb9ji5k0Qbqe/cdBbqsQpSzPCuNvGbryo0EQVwZneejl11XvmDGQ2QNyw891BYA==
X-Received: by 2002:a05:6830:3814:b0:743:968b:3440 with SMTP id 46e09a7af769-753550e1e9emr7218920a34.20.1757968209499;
        Mon, 15 Sep 2025 13:30:09 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524c260735sm3114325a34.39.2025.09.15.13.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 13:30:08 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 2/6] builtin/update-index: end ODB transaction when --verbose is specified
Date: Mon, 15 Sep 2025 15:29:52 -0500
Message-ID: <20250915202956.3784935-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20250915202956.3784935-1-jltobler@gmail.com>
References: <20250909191134.555689-1-jltobler@gmail.com>
 <20250915202956.3784935-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With 23a3a303 (update-index: use the bulk-checkin infrastructure,
2022-04-04), object database transactions were added to
git-update-index(1) to facilitate writing objects in bulk. With
transactions, newly added objects are instead written to a temporary
object directory and migrated to the primary object database upon
transaction commit.

When the --verbose option is specified, each of the following objects is
explicitly flushed via flush_odb_transaction() prior to reporting the
update. Flushing the object database transaction migrates pending
objects to the primary object database without marking the transaction
as complete. This is done so objects are immediately visible to
git-update-index(1) callers using the --verbose option and that rely on
parsing verbose output to know when objects are written.

Due to how git-update-index(1) parses options, each filename argument is
evaluated with only the set of options that precede it. Therefore, it is
possible for an initial set of objects to be written in a transaction
before a --verbose option is encountered.

As soon as the --verbose option is parsed in git-update-index(1), all
subsequent object writes are flushed prior to being reported and thus no
longer benefit from being transactional. Furthermore, the mechanism to
flush a transaction without committing is rather awkward. Drop the call
to flush_odb_transaction() in favor of ending the transaction early when
the --verbose flag is encountered.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/update-index.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 2ba2d29c95..d36bc55752 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -70,14 +70,6 @@ static void report(const char *fmt, ...)
 	if (!verbose)
 		return;
 
-	/*
-	 * It is possible, though unlikely, that a caller could use the verbose
-	 * output to synchronize with addition of objects to the object
-	 * database. The current implementation of ODB transactions leaves
-	 * objects invisible while a transaction is active, so flush the
-	 * transaction here before reporting a change made by update-index.
-	 */
-	flush_odb_transaction(the_repository->objects->transaction);
 	va_start(vp, fmt);
 	vprintf(fmt, vp);
 	putchar('\n');
@@ -1150,6 +1142,21 @@ int cmd_update_index(int argc,
 			const char *path = ctx.argv[0];
 			char *p;
 
+			/*
+			 * It is possible, though unlikely, that a caller could
+			 * use the verbose output to synchronize with addition
+			 * of objects to the object database. The current
+			 * implementation of ODB transactions leaves objects
+			 * invisible while a transaction is active, so end the
+			 * transaction here early before processing the next
+			 * update. All further updates are performed outside of
+			 * a transaction.
+			 */
+			if (transaction && verbose) {
+				end_odb_transaction(transaction);
+				transaction = NULL;
+			}
+
 			setup_work_tree();
 			p = prefix_path(prefix, prefix_length, path);
 			update_one(p);
-- 
2.51.0.193.g4975ec3473b

