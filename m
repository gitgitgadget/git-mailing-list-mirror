Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2006F505
	for <git@vger.kernel.org>; Tue,  7 May 2024 06:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715061652; cv=none; b=KBA1ZI4DPOHh5rcLxyLhlXb71Puiwxt6d7WdeHL0ajFrkV0jhEmgauZ7EKSQPSbZaifuq+f7dv7CRngfkYXJKKuv3SmZArUn8yU2B4oyZH0T6/qizHM7Gx/b2CD+nMtT1FEWfcyRh/dsWKZtEXcLfrY9exjOknUq7oMWDkDyzb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715061652; c=relaxed/simple;
	bh=oZFWb+3aaNcg/2ca6eKEJMk7EIU6qgKjI84Y2Ec/j00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZbNWYxbCOfYvqY8pZFMfT/mQQ3Fyh1Vj4c/1a6ATK6TaJRFGEIjWZZN+/RGJIYT40993HOkgd9yD8JhTVTobTlQmv5LCiCwewZ13kxFi865+4fJWeCTDrvyE2O8L7o5Rr2HHQ+acJq3QrnoN9335uepty1mjCCTW68lo5ogXuWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6EJBiS+; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6EJBiS+"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a59b178b75bso438632066b.0
        for <git@vger.kernel.org>; Mon, 06 May 2024 23:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715061648; x=1715666448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZflLsbLD4lKmVHQqEfTTNP8o7RKt7jjLEZ5EL2rALYg=;
        b=I6EJBiS+0UiK8wItHlpFt1ifiQRb/5dlnhRrjpjEjfN8jsf8nKI7Q54OXWyWkNOHh8
         q13pFkZdCTLRYDyxdWq2u1JOJ+aEMoLIlml959knrslH20qpeMh5VvXBWavW712e+nlv
         YadXuXIh9wf1nLAii6rt9A6eu71RWbrYHzw9saRm1eWvYKQR6Br0TfTsnDYUiZXNX7ub
         SJzJvHwNJPYLESLD9VWTqRpbMWW0L2cN55B7BT830TKTRZve4bXqg6jhkDQTGiLE9yJ4
         5Rz2HFV+O0cpwwuqEL+W45nLkZ4eAMSJSEHdrcCK10BjOgbBpInoApoFt9NxWTMOEmC/
         Ja4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715061648; x=1715666448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZflLsbLD4lKmVHQqEfTTNP8o7RKt7jjLEZ5EL2rALYg=;
        b=iULMRahxs5MNKM5c/HUinFrY1WkRmlM5akMPrAYweVDUK/woUk23jPznAf2jv1VUGa
         Ea8AeTq9ChqzINSbf5zR+M+HZ05dh3L4FF3NWNTWWrtQq4nnYPK7ikFnFgeWyxFszUWZ
         3Xu28wn9lMkcGKMGmdnq8dzKopoiM3PfyI046TAhzvINPpUSxi0EqwgnKk+zKAX/CebU
         8qbyzHtYB+4Nw05vTdmWYqPFnNx6Pdw3jLpOvvtQ2JSbnGdvnm32Fratn6plXptIsvDN
         VyHEF7mv+zpsbjaqDagOq1Rz5OoI34sXIEOT+cOgQW/oGzcfpuOyOZGhWv9fPmtZ+q8G
         DHBQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6415Ci71CLazERmgKluLBO+oiRIjQeu1ze/q7DH0hv6J93xe+/8ErF95/fSguEDgFGmmSIsuYHxIGF5SBda9jcs/z
X-Gm-Message-State: AOJu0YzmTAET9tFHp0ocJVcpvwwXl4giE44/JleE/InR0cADMSprvCnW
	7aHiZdgbZXfEJIewvJPELpEMEw2M14MZYAd+0BU/0IPzoyAwkNgz
X-Google-Smtp-Source: AGHT+IGDMVKQ+BukINj8sjufJAXbgTmW3bPtufSaSk7AwBWHc/e+lUhaq289uH3XpMKfV98hWtOyFg==
X-Received: by 2002:a17:906:358b:b0:a59:a8a4:a5a7 with SMTP id o11-20020a170906358b00b00a59a8a4a5a7mr5414137ejb.30.1715061647774;
        Mon, 06 May 2024 23:00:47 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:1aa1:adf2:4cd1:ebdc])
        by smtp.gmail.com with ESMTPSA id y27-20020a1709060a9b00b00a59baca79basm3066691ejf.60.2024.05.06.23.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 23:00:47 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im,
	phillip.wood123@gmail.com
Subject: [PATCH v7 4/8] refs: move `original_update_refname` to 'refs.c'
Date: Tue,  7 May 2024 08:00:31 +0200
Message-ID: <20240507060035.28602-5-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240507060035.28602-1-knayak@gitlab.com>
References: <20240503124115.252413-1-knayak@gitlab.com>
 <20240507060035.28602-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

The files backend and the reftable backend implement
`original_update_refname` to obtain the original refname of the update.
Move it out to 'refs.c' and only expose it internally to the refs
library. This will be used in an upcoming commit to also introduce
another common functionality for the two backends.

We also rename the function to `ref_update_original_update_refname` to
keep it consistent with the upcoming other 'ref_update_*' functions
that'll be introduced.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                  |  9 +++++++++
 refs/files-backend.c    | 21 +++++----------------
 refs/refs-internal.h    |  5 +++++
 refs/reftable-backend.c | 24 +++++++-----------------
 4 files changed, 26 insertions(+), 33 deletions(-)

diff --git a/refs.c b/refs.c
index 2bb3e09425..d65e4cc41e 100644
--- a/refs.c
+++ b/refs.c
@@ -2830,3 +2830,12 @@ int copy_existing_ref(const char *oldref, const char *newref, const char *logmsg
 {
 	return refs_copy_existing_ref(get_main_ref_store(the_repository), oldref, newref, logmsg);
 }
+
+const char *ref_update_original_update_refname(struct ref_update *update)
+{
+	while (update->parent_update)
+		update = update->parent_update;
+
+	return update->refname;
+}
+
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 40cc715ea7..64d2a50e97 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2422,17 +2422,6 @@ static int split_symref_update(struct ref_update *update,
 	return 0;
 }
 
-/*
- * Return the refname under which update was originally requested.
- */
-static const char *original_update_refname(struct ref_update *update)
-{
-	while (update->parent_update)
-		update = update->parent_update;
-
-	return update->refname;
-}
-
 /*
  * Check whether the REF_HAVE_OLD and old_oid values stored in update
  * are consistent with oid, which is the reference's current value. If
@@ -2449,16 +2438,16 @@ static int check_old_oid(struct ref_update *update, struct object_id *oid,
 	if (is_null_oid(&update->old_oid))
 		strbuf_addf(err, "cannot lock ref '%s': "
 			    "reference already exists",
-			    original_update_refname(update));
+			    ref_update_original_update_refname(update));
 	else if (is_null_oid(oid))
 		strbuf_addf(err, "cannot lock ref '%s': "
 			    "reference is missing but expected %s",
-			    original_update_refname(update),
+			    ref_update_original_update_refname(update),
 			    oid_to_hex(&update->old_oid));
 	else
 		strbuf_addf(err, "cannot lock ref '%s': "
 			    "is at %s but expected %s",
-			    original_update_refname(update),
+			    ref_update_original_update_refname(update),
 			    oid_to_hex(oid),
 			    oid_to_hex(&update->old_oid));
 
@@ -2512,7 +2501,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 
 		reason = strbuf_detach(err, NULL);
 		strbuf_addf(err, "cannot lock ref '%s': %s",
-			    original_update_refname(update), reason);
+			    ref_update_original_update_refname(update), reason);
 		free(reason);
 		goto out;
 	}
@@ -2532,7 +2521,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 				if (update->flags & REF_HAVE_OLD) {
 					strbuf_addf(err, "cannot lock ref '%s': "
 						    "error reading reference",
-						    original_update_refname(update));
+						    ref_update_original_update_refname(update));
 					ret = TRANSACTION_GENERIC_ERROR;
 					goto out;
 				}
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 108f4ec419..617b93a6c8 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -749,4 +749,9 @@ void base_ref_store_init(struct ref_store *refs, struct repository *repo,
  */
 struct ref_store *maybe_debug_wrap_ref_store(const char *gitdir, struct ref_store *store);
 
+/*
+ * Return the refname under which update was originally requested.
+ */
+const char *ref_update_original_update_refname(struct ref_update *update);
+
 #endif /* REFS_REFS_INTERNAL_H */
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index f48ab5ad22..0988f59ed4 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -622,16 +622,6 @@ static int reftable_be_read_symbolic_ref(struct ref_store *ref_store,
 	return ret;
 }
 
-/*
- * Return the refname under which update was originally requested.
- */
-static const char *original_update_refname(struct ref_update *update)
-{
-	while (update->parent_update)
-		update = update->parent_update;
-	return update->refname;
-}
-
 struct reftable_transaction_update {
 	struct ref_update *update;
 	struct object_id current_oid;
@@ -910,7 +900,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 			/* The reference does not exist, but we expected it to. */
 			strbuf_addf(err, _("cannot lock ref '%s': "
 				    "unable to resolve reference '%s'"),
-				    original_update_refname(u), u->refname);
+				    ref_update_original_update_refname(u), u->refname);
 			ret = -1;
 			goto done;
 		}
@@ -982,17 +972,17 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 		if (u->flags & REF_HAVE_OLD && !oideq(&current_oid, &u->old_oid)) {
 			if (is_null_oid(&u->old_oid))
 				strbuf_addf(err, _("cannot lock ref '%s': "
-					    "reference already exists"),
-					    original_update_refname(u));
+						   "reference already exists"),
+					    ref_update_original_update_refname(u));
 			else if (is_null_oid(&current_oid))
 				strbuf_addf(err, _("cannot lock ref '%s': "
-					    "reference is missing but expected %s"),
-					    original_update_refname(u),
+						   "reference is missing but expected %s"),
+					    ref_update_original_update_refname(u),
 					    oid_to_hex(&u->old_oid));
 			else
 				strbuf_addf(err, _("cannot lock ref '%s': "
-					    "is at %s but expected %s"),
-					    original_update_refname(u),
+						   "is at %s but expected %s"),
+					    ref_update_original_update_refname(u),
 					    oid_to_hex(&current_oid),
 					    oid_to_hex(&u->old_oid));
 			ret = -1;
-- 
2.43.GIT

