Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0E217966D
	for <git@vger.kernel.org>; Thu, 30 May 2024 12:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717070991; cv=none; b=PGFXBOwrYiQttuyz4SQWuqdo7TW/N1j59KTT4kvibAikVXD59Bq5bYlmhfOj/t87YfttOgblMfuT5NtKI/3HhRaaXmx2P0a3xRokGOPlodATCRPauiUPtmbCil1NIQtI951b/ehkGSh+SBH8EyA5WBSxTzYmC2+sZ8N4H7YEF0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717070991; c=relaxed/simple;
	bh=t2Sh2uOYymZ8PY1NxFZ+tdvRzLosECEg/jwYIX9U8wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bDUeeEfrvFFefegvk3ByBLrSZIhbQFaVpABMZN8gCjczgsShQXh21ApN5oBRtuKcPpQJpuD8GtMF3AaRJU62ZX0L5X+J1xHtxzdiHVGETrh4UBvKFWgTtrhATlTM0ZHrwHnmWpBOkxRzg7ayVMgsNNKhaLVFL2Aa/c7QnOpEHz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjB0jbe/; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjB0jbe/"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a62db0c8c9cso74389966b.2
        for <git@vger.kernel.org>; Thu, 30 May 2024 05:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717070988; x=1717675788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/VAe/ORVbUECRLIQtAb+P3zV3BjjcPefMr5fQ54+9M=;
        b=PjB0jbe/5pTSr9vTNuSinhUacJe3C58R+6/SPQLFhIiF/+tpHX1ohuq8IAIIFtd431
         dzq/01s+7uGVJYnCto6YL3YO+yRMuhqyWa9DEucDCVkRIE0Fv9Is5BxO3SZkVtbViAKP
         prfBA3NOFuGwYuqfmKvNIb5qb5ADIReqP8ZYp8PErWDcu6h6gm3JZNi+1muTjXkv8Mkv
         mgIbjHMsNPoiboYbgaWrJQikbWKuqJCUgqx6iquvUsRyF89xCq5DrjZfbWFkywjycBKS
         wDFI+9CHvnNTgvuzt3Tn5jinBp9JWEQMA3p7szQu6Fad2d2iHWvthlyPBCp3KC5eSKvU
         bAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717070988; x=1717675788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o/VAe/ORVbUECRLIQtAb+P3zV3BjjcPefMr5fQ54+9M=;
        b=s5UXhVsppbu8QH2e+Am8Eqm9CsP1W2durMDxaOxqIc7LG8mUqZY/W6kQXcIZU9jV9n
         fhndcOstMuBh0utJcIGovAcKlo9PykUih3RgYmsgZ5j7KiDuGf138Zip0aLajKpYyBub
         Ghng3sk4dmP6uVcvIYtSO96DedbL1ydBYKPMXaK32kFkwqWJEaIaLAgAGOCnVxMyf+it
         PEPMZlHBetuBsfc0jb0/w9aZAWD2WVE+WR2/bOntehlnU6NVKqMgm8nGFVhCj04+Bodo
         bRcEO3ExQhSJF/i6pCpKUl126Js0bTRqm9wL+AZKIlEF0BzZ0ia/pxZsKfNcrcbMZ/MJ
         r5wQ==
X-Gm-Message-State: AOJu0YysRUF79PyVBnlUYkzCMoLKDU8mEtLEgT07Tnr15nT6KiKWpFSg
	8B2U18H9jZ5lg5OrILvksdZhGqwJeo2AHaGsdeFTKkUJWgg0SO3ENhvGa7TPfQmfpA==
X-Google-Smtp-Source: AGHT+IGNVpEMZvCFUP6LJGk4yFnQWQI4ixvwZ6pokZNBQO04aL0NpCz7gqTxcuwlCgALvufpmO3Mqg==
X-Received: by 2002:a17:906:d1c4:b0:a66:7b79:3573 with SMTP id a640c23a62f3a-a667b7936cbmr82780366b.25.1717070988283;
        Thu, 30 May 2024 05:09:48 -0700 (PDT)
Received: from laptop.modem.local ([85.100.180.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc8e105sm831393866b.172.2024.05.30.05.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 05:09:47 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v3 1/6] refs: create and use `ref_update_expects_existing_old_ref()`
Date: Thu, 30 May 2024 15:09:35 +0300
Message-ID: <20240530120940.456817-2-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240514124411.1037019-1-knayak@gitlab.com>
References: <20240514124411.1037019-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

The files and reftable backend, need to check if a ref must exist, so
that the required validation can be done. A ref must exist only when the
`old_oid` value of the update has been explicitly set and it is not the
`null_oid` value.

Since we also support symrefs now, we need to ensure that even when
`old_target` is set a ref must exist. While this was missed when we
added symref support in transactions, there are no active users of this
path. As we introduce the 'symref-verify' command in the upcoming
commits, it is important to fix this.

So let's export this to a function called
`ref_update_expects_existing_old_ref()` and expose it internally via
'refs-internal.h'.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                  | 6 ++++++
 refs/files-backend.c    | 3 +--
 refs/refs-internal.h    | 6 ++++++
 refs/reftable-backend.c | 2 +-
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 8260c27cde..50d8d7d777 100644
--- a/refs.c
+++ b/refs.c
@@ -2679,3 +2679,9 @@ int ref_update_check_old_target(const char *referent, struct ref_update *update,
 			    referent, update->old_target);
 	return -1;
 }
+
+int ref_update_expects_existing_old_ref(struct ref_update *update)
+{
+	return (update->flags & REF_HAVE_OLD) &&
+		(!is_null_oid(&update->old_oid) || update->old_target);
+}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 5f3089d947..194e74eb4d 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2412,8 +2412,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 			       struct strbuf *err)
 {
 	struct strbuf referent = STRBUF_INIT;
-	int mustexist = (update->flags & REF_HAVE_OLD) &&
-		!is_null_oid(&update->old_oid);
+	int mustexist = ref_update_expects_existing_old_ref(update);
 	int ret = 0;
 	struct ref_lock *lock;
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 53a6c5d842..ee298ec0d5 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -765,4 +765,10 @@ int ref_update_has_null_new_value(struct ref_update *update);
 int ref_update_check_old_target(const char *referent, struct ref_update *update,
 				struct strbuf *err);
 
+/*
+ * Check if the ref must exist, this means that the old_oid or
+ * old_target is non NULL.
+ */
+int ref_update_expects_existing_old_ref(struct ref_update *update);
+
 #endif /* REFS_REFS_INTERNAL_H */
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 1af86bbdec..b838cf8f00 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -824,7 +824,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 					      &current_oid, &referent, &u->type);
 		if (ret < 0)
 			goto done;
-		if (ret > 0 && (!(u->flags & REF_HAVE_OLD) || is_null_oid(&u->old_oid))) {
+		if (ret > 0 && !ref_update_expects_existing_old_ref(u)) {
 			/*
 			 * The reference does not exist, and we either have no
 			 * old object ID or expect the reference to not exist.
-- 
2.43.GIT

