Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99B2153827
	for <git@vger.kernel.org>; Fri,  3 May 2024 12:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714740087; cv=none; b=POmuezAOOHdk0mrw9km8f8ABmxTM6dwvO3RYubAtw0wSy8DKfPv9wsauO+xQK8pEs/kjmb5CPgTxhNkBKKO44kiQexXJ3TFTdqIJVdejOGDPJ59kZWEVK/HIQ7n+nTB7+vnoeqsgkSuKHjEol6sJ40MyRzqnb3YpKDIEbkN7XOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714740087; c=relaxed/simple;
	bh=x5NJzEm/l+tdpypU2YQeD1LsrlF6/p0kmKnaRHbXr+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=md93mEiXL2nsz0hqMR3bzkxnhVP6ZNNcfzh0YOiLmbhfQpSiYW70bTZqtnafS4CgkmOSJwSRUvvsqnhhlWmXUL9wUvkFFgpbAYHcVYi1xUHsqCYKMZJAse7BzLQddjmbTujpiAcWzmy6N1VUvvBoOmLebR88vxDojUemiMY47fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFTpE1Eo; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFTpE1Eo"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a58fbbcd77aso871365366b.2
        for <git@vger.kernel.org>; Fri, 03 May 2024 05:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714740083; x=1715344883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qOXZV2jE+XCtep9w+nE1i/SMX3mRLFWlzoISh0VSnYg=;
        b=LFTpE1EodAIC/ixqbP3o0MB7sqS2dfX9zKSdGyzNGEOsf7MXdGxSyxamw2a/Et9Y0s
         ykM/Fl9H+ke6jwYoax7DzHXWL6+f94UUTrNkLxQuX1Uy4PVlXhaaeaiLpX2q4TffkSqT
         B3KMWCj/ry63zGr7XfexDkwZkA8yADrx9GQT6lWentdwdrLD8XY3IEhJSyuNPILXeSBT
         O20Jwj1FklLFNrJz94CXmm8nMWe8m1BKHdHN7wF5pGZZuWzjaUDEeqQ2mqpMmhQDFpb0
         RJD4GCuQVND7lo2FREaCHc2xt5yyKJnSCAMavokHd68iEXHRDCs/cYsHXne7zwuEMCCQ
         eagg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714740083; x=1715344883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qOXZV2jE+XCtep9w+nE1i/SMX3mRLFWlzoISh0VSnYg=;
        b=Qyjngak4cYEm60uHdsH/FjJ1MuqDMR0L7RRA7vZq7GKi10mzDhWfIOE5RO71v80+PN
         7n08a6rRhQNOL0cjg2BECj2PZkO47DHbRUZtf8Dx2MtEbF87DIdO97VrXy6PO4Z8ACK7
         aV+YcsPorfgebkyXK9mgNiSsjsoA9Z8tjJcWFvwTZNiqeTNkA3UTNHaznBkQBq5HdIYr
         HYlWjCo+lwInoWYSlt7F8MNHy34ROm5Te2Tk8W/LIwR5wijF3kRmQZbxjuRRPnWxSEdH
         xHVrsjamcEzNPD61o1ioouTeg9eCzGhTM987KFaay9aCLk79RDFMIRvbeb/LZz9YM4J+
         eNmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVs6UXmFdjhe+sKr4LhBTs53KqUqPjyGzimVT1eAWomIt/DEbxnuQA1Kd50t9QHt7qs5szCeyR7t0iZBIJnmObOn7M5
X-Gm-Message-State: AOJu0Yy7yaildhT05Z5BsOSm+KW48JPIHE45Tb29c+crCSQ1jWUG5sn5
	0ufxBf1MN+oeXvNwKeJDk0jx/m9DGJ1D/O4MTcPIIm/5tMV9gu3f
X-Google-Smtp-Source: AGHT+IEGqU8hQ2dfMuGtEP8GfPhzCOB0xmN1A2pGOkY21PGR6N/ZKYqK5xpDwzCEo/PygHTYTB3Sag==
X-Received: by 2002:a17:907:101a:b0:a58:84e9:c669 with SMTP id ox26-20020a170907101a00b00a5884e9c669mr1701543ejb.52.1714740083041;
        Fri, 03 May 2024 05:41:23 -0700 (PDT)
Received: from localhost.localdomain ([185.223.147.210])
        by smtp.gmail.com with ESMTPSA id ot38-20020a170906cce600b00a5994c5c948sm533323ejb.133.2024.05.03.05.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 05:41:22 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v6 5/7] refs: use transaction in `refs_create_symref()`
Date: Fri,  3 May 2024 14:41:13 +0200
Message-ID: <20240503124115.252413-6-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240503124115.252413-1-knayak@gitlab.com>
References: <20240501202229.2695774-1-knayak@gitlab.com>
 <20240503124115.252413-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

The `refs_create_symref()` function updates a symref to a given new
target. To do this, it uses a ref-backend specific function
`create_symref()`.

In the previous commits, we introduced symref support in transactions.
This means we can now use transactions to perform symref updates and
don't have to resort to `create_symref()`. Doing this allows us to
remove and cleanup `create_symref()`, which we will do in the following
commit.

Modify the expected error message for a test in
't/t0610-reftable-basics.sh', since the error is now thrown from
'refs.c'. This is because in transactional updates, F/D conflicts are
caught before we're in the reference backend.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                           | 24 +++++++++++++++++-------
 t/t0610-reftable-basics.sh       |  2 +-
 t/t1416-ref-transaction-hooks.sh | 23 +++++++++++++++++++++++
 3 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index acb153b6f8..195861b09b 100644
--- a/refs.c
+++ b/refs.c
@@ -2289,14 +2289,24 @@ int refs_create_symref(struct ref_store *refs,
 		       const char *refs_heads_master,
 		       const char *logmsg)
 {
-	char *msg;
-	int retval;
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
+	int ret = 0;
 
-	msg = normalize_reflog_message(logmsg);
-	retval = refs->be->create_symref(refs, ref_target, refs_heads_master,
-					 msg);
-	free(msg);
-	return retval;
+	transaction = ref_store_transaction_begin(refs, &err);
+	if (!transaction ||
+	    ref_transaction_update(transaction, ref_target, NULL, NULL,
+				   refs_heads_master, NULL, REF_NO_DEREF,
+				   logmsg, &err) ||
+	    ref_transaction_commit(transaction, &err)) {
+		ret = error("%s", err.buf);
+	}
+
+	strbuf_release(&err);
+	if (transaction)
+		ref_transaction_free(transaction);
+
+	return ret;
 }
 
 int create_symref(const char *ref_target, const char *refs_heads_master,
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index 178791e086..9e8d22bcbd 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -286,7 +286,7 @@ test_expect_success 'ref transaction: creating symbolic ref fails with F/D confl
 	git init repo &&
 	test_commit -C repo A &&
 	cat >expect <<-EOF &&
-	error: unable to write symref for refs/heads: file/directory conflict
+	error: ${SQ}refs/heads/main${SQ} exists; cannot create ${SQ}refs/heads${SQ}
 	EOF
 	test_must_fail git -C repo symbolic-ref refs/heads refs/heads/foo 2>err &&
 	test_cmp expect err
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index 2092488090..067fd57290 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -134,4 +134,27 @@ test_expect_success 'interleaving hook calls succeed' '
 	test_cmp expect target-repo.git/actual
 '
 
+test_expect_success 'hook captures git-symbolic-ref updates' '
+	test_when_finished "rm actual" &&
+
+	test_hook reference-transaction <<-\EOF &&
+		echo "$*" >>actual
+		while read -r line
+		do
+			printf "%s\n" "$line"
+		done >>actual
+	EOF
+
+	git symbolic-ref refs/heads/symref refs/heads/main &&
+
+	cat >expect <<-EOF &&
+	prepared
+	$ZERO_OID ref:refs/heads/main refs/heads/symref
+	committed
+	$ZERO_OID ref:refs/heads/main refs/heads/symref
+	EOF
+
+	test_cmp expect actual
+'
+
 test_done
-- 
2.43.GIT

