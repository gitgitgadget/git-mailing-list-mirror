Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6537C1FE465
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 09:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740475774; cv=none; b=Wzk5Hi317G3q3Rte7+mg1jcFNNNw9Vq3Bv3AVTeBLDdbFkpd0rBqNmE7OZmWZ5pUR9FBojonC4XBEpTKkzj/t4Nq1oBwpQL3VAlh8HiYLxxXD38+tjqYYhuQKtY4wiWMQ2kFZ3p5v6biCjtisCxtOXGqiu/YeUAncBhhtEVkZbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740475774; c=relaxed/simple;
	bh=wEYKpiFzoNr39cfnesRh3C7AD4gVkEqAKi5Qllu1OfU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iyH+Z5QoteZUWzg9MZKx1CRB2owG5fVrVMNpkhVmIE4F7ZVhQgq193bje2OHYUrsxfL72cjM8KIINSDtLx/7sK0KO2D4NdikE111Et+ICHuaPzPlVsnc8HayI6X4JBUphez6Tm1hrf+GSphPsi5G8ujX8b/jRXPfGOpCIaf9PaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHaBIRrA; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHaBIRrA"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abbd96bef64so871597866b.3
        for <git@vger.kernel.org>; Tue, 25 Feb 2025 01:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740475771; x=1741080571; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QfSLxZydrSfqW1xMvsv0SqvzxvhQtLB2KzyBUKCQxrI=;
        b=iHaBIRrA1YhbLY7F2q7bYqtQ9zJaBKcpahsFwUKVJ5em3VhLDIklCADFQZapMa90yu
         NrWXKzngyOHXqe8bu8ihyYWH0YdLTMPkRmYG1k6uWKrdpHft/eoIJ5+LwJWs6as6rip7
         MU13iRdGdbxQnXPS7tKLEQJMQVAWGGrvWEXKi9zUoo5gU7uNwNwgI4byIbF+HyBw/+hh
         NxIo/6gJEhNZqEU+VCZ+HvC1FNwjWHCLqnBh/JkwVFbmmW+vlhzPM3J84auORycHmQyz
         rDXw6UbSBq0NFe01VUivyqzlSteSE9bbQCp50Ct56Lo2Qy97NucIU6IsABNGyDA3jAZe
         GUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740475771; x=1741080571;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QfSLxZydrSfqW1xMvsv0SqvzxvhQtLB2KzyBUKCQxrI=;
        b=OOuS8SayPJlAM+UOayRcx8bozW1n7Wb6nlzTkdGiKroyXaT1EhtRpP1PzsrQgi5VAD
         a7Yu5KdKm1Kswrtw1AzhSK1XKlaw/c5CXREo37KIFQ7BXANGg/R3RatEVaT4lvZi4PPl
         8j1jhtMejvl8ht3VWl8Ern/Na11ae6ObBCqUIGpseUhJmU200caYWc3zJHR9kPT3X97z
         FUPBGReXojyGnlj5dvMXJTOLbuktXfCKxd6j3diDSiGylbj43PLg2zuZS7ojvTZyQJ6t
         kD7I+iJyXvDeSyyUupX+Az0NFGQxGM1I/NoM8ms/LEFvU/SrvN7yBRw+O1e13NkObsYx
         XfMw==
X-Gm-Message-State: AOJu0YyG2J4vMjjOtB291MN3VCF4UM6Ite1c3V9d2UDS45oUwrmZk+yN
	GPH7NXb3osfE8iWJv8GurMPoCaaDnJ17tvRxIPrJaQ9ZcLqvT+TE
X-Gm-Gg: ASbGncsJfAQkkIkTG0+p0BVHN++OCb9QihrKe6cDnA6dfN5uh92VywCFJ7L4RR1E+lc
	UGO/+n20CpdNAevlm44fM6/9csP4Lc3vzL52Gv4V0rctACeAjPnRD95VxwCWAAvRfztCcGMTRS3
	QN5pWy/aMeHChNt5XYPrJCofsJKVPI5Gp/5bvMfMMATB360slVd95UXeQyVVlj9YidlWQ5dqI5K
	wqGX6CcV/HU7noezV5KqjADQp5GbUNO8Lfmt/+yPKZlfypTgkQzHcyCO2YSeObwmwiecNE9z2NS
	dnUsKy32kl01bqrClaudTDHM3vqeDKAS
X-Google-Smtp-Source: AGHT+IFEabihop/mZ53SKaoiVL11c+8QLzNKF6KyaBjbGdN1uQyfAzC/Q+LGqYVR5/vB2RhamrsSpQ==
X-Received: by 2002:a17:906:3290:b0:ab7:b30:42ed with SMTP id a640c23a62f3a-abed0959f38mr220924466b.0.1740475770368;
        Tue, 25 Feb 2025 01:29:30 -0800 (PST)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:20c2:4ab6:a193:5b8c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1cd561esm111944466b.19.2025.02.25.01.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:29:30 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 25 Feb 2025 10:29:06 +0100
Subject: [PATCH v2 3/7] refs/files: remove duplicate duplicates check
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-245-partially-atomic-ref-updates-v2-3-cfa3236895d7@gmail.com>
References: <20250225-245-partially-atomic-ref-updates-v2-0-cfa3236895d7@gmail.com>
In-Reply-To: <20250225-245-partially-atomic-ref-updates-v2-0-cfa3236895d7@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, jltobler@gmail.com, 
 phillip.wood123@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2998; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=wEYKpiFzoNr39cfnesRh3C7AD4gVkEqAKi5Qllu1OfU=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGe9jXSUZQWqfDPJVWV01p3OeTtRRwQ1sboEz
 TQZrvc6BHBPqYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJnvY10AAoJED7VnySO
 Rox/FBIL/3z9fMR8EyUZ7ZGzXJHfWuLBLU/JheB6iLXpexNR3hVPdf3tF5jZA/lo811aPMdOm6h
 svj8fgh2b5Nu+J6aK4nCoz7TMfV+Me1GDpKrewTg4Xqn8adwKbNbLRVe+vbu/QaqkSFiRQJlj9x
 EKNJryGk6WjAaZGwZsf4Pfu1CjOOH/OycLNJZi4+gXC6EyB9LT15qZiO9kNCnsr8iRCQ4ESv7ut
 F70K9Fty6wqEQj5ULok/KxDlq/DcaFhZgu//0JT0+wNTBIL2LeR75OzNW7V28n2J+X6UGqWjC8u
 wsOUOrB8/qJUO+lvf1vxvbCVxVK9Z3NSZ+7uEDKKgcbGl1MnLYLjFB5jH730nUneAJMNrH54ICw
 42PjoGVqb93qHgBdGoHKLC4ldvN3IJ5dZDXnJRcr26rf5s9IkrPQ939s40Av3Q2FTgHZtf8rHqm
 TJDiBK9ycYhanx97uypUki8gWWrct0RIwxtCSO8hObNy4hbbgTPO26fZAeffsGWQJiIlnCXLYr7
 PI=
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
index ab69746947..69f385f344 100644
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
index 85ed85ad87..7c6a0b3478 100644
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
index a6e05eaecd..4b7fc8f1ab 100644
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
2.47.2

