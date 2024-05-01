Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6AA165FA9
	for <git@vger.kernel.org>; Wed,  1 May 2024 20:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714594964; cv=none; b=dVgWXjjiOj/C/4POY596wWcRWoL8yleLShpNvGoBJcXMHGy2CBgtg8xadL41l6569WCj+UB/GTpiglW84x2jzQJnp367KZs3CnIjyJOTAPgNLoMrqCWRKPy3ISV8kS7tmBHVH2WG69pZuL1rWZK84Wl7PF1+GzMYZ66EnUERkr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714594964; c=relaxed/simple;
	bh=pIA3dB2NY88LKuKHFYIL8+eFHWkC3jYjGtRqh54PfRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m5tt0t0EJMeXE0K7/KowPZw5+Y3RMzQ3K1C/EfrVoyQmKHOea84Kgo0X0lc8wm7DpBk6Q6bmC5wXXetX5zg3tQA0OWfQUBvMlthcs9yCbUKp9CRqt8yWWs2U9AZQAlu3FIADao0ZAl9r/dj8RVj7DK58QZOvQpRe6adFUW+iDO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h6LbgU37; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6LbgU37"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56e48d0a632so11149407a12.2
        for <git@vger.kernel.org>; Wed, 01 May 2024 13:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714594961; x=1715199761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Izd+AuMZ5FG40rHJcxlWa9FnVLDPhR3L+w6PpTgQ390=;
        b=h6LbgU37dtgMhMEpWFkuhLi/W6xJTxrrdxq4U+A4vs1jBzzpHgS292ghlKt1c7aAei
         dKj+ZQnjIUBQlVNgts3uzJSJA8V3zIgEHrdXnepZ6c3JPjOQbJVBsqf1/1oRDUW70yD8
         DdFzzgJfW7IRYdizAKThp6GouKcZ9k09nKRuyr65Cgky3NvN0Wl6368h/SULL2vLOXyN
         MNMVRGINWf27uF9mJm9o1FGgTWlTMmzGVXOIJaxN8TgOpFec4OtSRGydmqdHCEYyblye
         XLZP17SwzCjbH30GJd0l2hzV0T0tlchuP8RuSYQWA+EFQhytjCuWnryL3XI+jiM0lPBu
         hJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714594961; x=1715199761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Izd+AuMZ5FG40rHJcxlWa9FnVLDPhR3L+w6PpTgQ390=;
        b=W6IKRR1MeGe8S4VDoWnSuzKrTr69aYaHb9HIOoBrs/zHDXyyZNXK1aMZqaU5LBspvG
         UlfKoH5uh5tVo+HGZXrbxCKHEo/qjUO5QTY7oZv1wA0huMoGOByd1stId6kETyEnyFmj
         Knx9avaLulhEdAH+0IsaFVPxmy5acSSj6MvPBV8w2RwOP/hUC9lnfusmVosj3E5wdlGF
         3wdbXRc0ZRX3zmF2Nh/iNZPnvFK0zibjPb+Y3XLEjgcnClc+Gz2gGQ0bPsVSabTFmxsK
         yoGeVgibjBg7oN5f06JzxwojpoUbq7sfodYRu+cGNIu2oipW/m8JSWSfe7LRmaz573cs
         BeLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrHKnJWCTY9j0eZQVeFDbPXK5yh9VbBJ4vZlqgWyLCCAb1fTmPeDBFkmaHbJyI04JVZjpibkBIdxwz8lam0UIZj3Mw
X-Gm-Message-State: AOJu0YwfEMkKaWxqjeUrw22VD9Oq8sTWJbHgWiXJnv7oiOKsX6bjwVRU
	4/9g3L2e2VprAUIsTXgpHsN0HH8J2n/GNMMglrKr8Hl6XeV25pK4
X-Google-Smtp-Source: AGHT+IEQ/nhiwDZjn9x7EUP0M/yFZ0cDyyX+iPMmHdmdb/hwgH8UiDUbSs+Ysznx6EIEitVqHAwZaw==
X-Received: by 2002:a17:906:2a08:b0:a58:e3d5:87ba with SMTP id j8-20020a1709062a0800b00a58e3d587bamr38490eje.75.1714594961231;
        Wed, 01 May 2024 13:22:41 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:8270:9642:2bfa:e177])
        by smtp.gmail.com with ESMTPSA id hg25-20020a170906f35900b00a58eec6f5acsm5290686ejb.102.2024.05.01.13.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 13:22:40 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v5 6/7] refs: rename `refs_create_symref()` to `refs_update_symref()`
Date: Wed,  1 May 2024 22:22:28 +0200
Message-ID: <20240501202229.2695774-7-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240501202229.2695774-1-knayak@gitlab.com>
References: <20240426152449.228860-1-knayak@gitlab.com>
 <20240501202229.2695774-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

The `refs_create_symref()` function is used to update/create a symref.
But it doesn't check the old target of the symref, if existing. It force
updates the symref. In this regard, the name `refs_create_symref()` is a
bit misleading. So let's rename it to `refs_update_symref()`. This is
akin to how 'git-update-ref(1)' also allows us to create apart from
update.

While we're here, rename the arguments in the function to clarify what
they actually signify and reduce confusion.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/branch.c          |  2 +-
 builtin/worktree.c        |  2 +-
 refs.c                    | 12 +++++-------
 refs.h                    |  2 +-
 t/helper/test-ref-store.c |  2 +-
 5 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index dd3e3a7dc0..4491f7a20c 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -555,7 +555,7 @@ static int replace_each_worktree_head_symref(struct worktree **worktrees,
 			continue;
 
 		refs = get_worktree_ref_store(worktrees[i]);
-		if (refs_create_symref(refs, "HEAD", newref, logmsg))
+		if (refs_update_symref(refs, "HEAD", newref, logmsg))
 			ret = error(_("HEAD of working tree %s is not updated"),
 				    worktrees[i]->path);
 	}
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 7c6c72536b..480202c517 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -517,7 +517,7 @@ static int add_worktree(const char *path, const char *refname,
 		ret = refs_update_ref(wt_refs, NULL, "HEAD", &commit->object.oid,
 				      NULL, 0, UPDATE_REFS_MSG_ON_ERR);
 	else
-		ret = refs_create_symref(wt_refs, "HEAD", symref.buf, NULL);
+		ret = refs_update_symref(wt_refs, "HEAD", symref.buf, NULL);
 	if (ret)
 		goto done;
 
diff --git a/refs.c b/refs.c
index 1b67c87f47..1215b0fae2 100644
--- a/refs.c
+++ b/refs.c
@@ -2286,10 +2286,8 @@ int peel_iterated_oid(const struct object_id *base, struct object_id *peeled)
 	return peel_object(base, peeled) ? -1 : 0;
 }
 
-int refs_create_symref(struct ref_store *refs,
-		       const char *ref_target,
-		       const char *refs_heads_master,
-		       const char *logmsg)
+int refs_update_symref(struct ref_store *refs, const char *ref,
+		       const char *target, const char *logmsg)
 {
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
@@ -2297,8 +2295,8 @@ int refs_create_symref(struct ref_store *refs,
 
 	transaction = ref_store_transaction_begin(refs, &err);
 	if (!transaction ||
-	    ref_transaction_update(transaction, ref_target, NULL, NULL,
-				   refs_heads_master, NULL, REF_NO_DEREF,
+	    ref_transaction_update(transaction, ref, NULL, NULL,
+				   target, NULL, REF_NO_DEREF,
 				   logmsg, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		ret = error("%s", err.buf);
@@ -2314,7 +2312,7 @@ int refs_create_symref(struct ref_store *refs,
 int create_symref(const char *ref_target, const char *refs_heads_master,
 		  const char *logmsg)
 {
-	return refs_create_symref(get_main_ref_store(the_repository), ref_target,
+	return refs_update_symref(get_main_ref_store(the_repository), ref_target,
 				  refs_heads_master, logmsg);
 }
 
diff --git a/refs.h b/refs.h
index c7851bf587..71cc1c58e0 100644
--- a/refs.h
+++ b/refs.h
@@ -606,7 +606,7 @@ int refs_copy_existing_ref(struct ref_store *refs, const char *oldref,
 int copy_existing_ref(const char *oldref, const char *newref,
 			const char *logmsg);
 
-int refs_create_symref(struct ref_store *refs, const char *refname,
+int refs_update_symref(struct ref_store *refs, const char *refname,
 		       const char *target, const char *logmsg);
 int create_symref(const char *refname, const char *target, const char *logmsg);
 
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 82bbf6e2e6..4651e4ced7 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -118,7 +118,7 @@ static int cmd_create_symref(struct ref_store *refs, const char **argv)
 	const char *target = notnull(*argv++, "target");
 	const char *logmsg = *argv++;
 
-	return refs_create_symref(refs, refname, target, logmsg);
+	return refs_update_symref(refs, refname, target, logmsg);
 }
 
 static struct flag_definition transaction_flags[] = {
-- 
2.43.GIT

