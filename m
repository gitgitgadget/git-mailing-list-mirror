Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3124F20C
	for <git@vger.kernel.org>; Sat, 30 Mar 2024 22:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711838795; cv=none; b=TLFAmLTKiMnkRrv/t3QZBLPG27hHPkpv8Ubvt4+3GWZVexOhwgmsdlELSoV5iXc/PwbvpTBLJMltaYd6B3G1SF9fiU9eIBWZiuesABvv1L7QsermbxJgGYJ07PbXht04vMjeI4roHYV+jgqCe/8C8kZZa8Om2fCnjK/oqVs5g5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711838795; c=relaxed/simple;
	bh=wniBKXqMzZJhXjNSxfr9JWyMIKF9bX+jFkISRtWq5wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UdDkZAcyglV9jkXt6hjUZqkdVxtWhRRKBlu/02ggVjJ5Ick7as6x4lHJuva5dnOgc78IJaG/oNoYJBVIGiw6IygMRM4TowgI1iYbd3S1OetAJBhDJIQxfc/jYP4u4PJYu1iOG2VQy9J2bIK9PaUnluHn2Hq/ogDOMrqLiHB0iLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIWGnmO3; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIWGnmO3"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a46a7208eedso378650966b.0
        for <git@vger.kernel.org>; Sat, 30 Mar 2024 15:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711838792; x=1712443592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yO+h24QuUuCjFg8uUnlx4jBF2Q74WKPeJgQelstpoXM=;
        b=HIWGnmO3yPg+V0ueBplY0uegA891zTS0cWreLdZ9ayjOYTiJE0e9J1YsSrPbMZqHcY
         E6RWv7mefQcNjjizB8QI1yqDTGJ0AE0cUvGBjp4aRDymCt13VuLtz7yOwehGV9fja3NS
         LbbktbQEPqwX+bKWm4IosOpbw+c1BjVK1f0/ug750hr6l5RpYWgFZtSjCr6xDnAP8pdb
         UWqTrM7kmDy3fKUmuddyPrhUiHxZk9C4+nF0v9HwP4g1yTPZw2sCP/DBrpWWktKoRsHk
         x54qSGDiuZDi2Ix/9KkTtYJimdIeXkhmZFNfcHP/uYcsQ1SJ/9/rarb9f/Dbgt+V9Wrz
         uiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711838792; x=1712443592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yO+h24QuUuCjFg8uUnlx4jBF2Q74WKPeJgQelstpoXM=;
        b=IAYzlg1R9CyZGTSVw52AG1LZUL/GWA7kqBYugqg2BgF/nopJs0yycYc2Dmb2//cCKJ
         +7JC5Zg4dRxdfhICfvtGGbY5uUCEGzAbm97WwrWN4Bi4sieeAB0nb3DVLD5ZSk1e9GJh
         5c3l+KDMLO1XyunYQNs/Tk6lYzo013/M7ycJDUaLQ5AZpIWJHZ7Z0qqhi4SN4LWoi5En
         a2x0oksZWyguJDC4nx9weVX/Uel8gWHAD7vgw7kUYkClgE+LpzNjfqBWvf92rmAwo9lk
         kToIb1SF5Tj0LAwYFQHVhRS2BQK8pzR11ZEG4PV1SYNjwKn4p96/mDJKDHi63KWJxUsK
         0+8g==
X-Gm-Message-State: AOJu0YxPrPEtvD3cudd4M3XdxlBKc9AeVuwbKdAD6eJ9Pi+Q1KxJo45D
	Gw0hQHebc1AlYVLjpkQKKKj0nGiFy/fSaADbcEOKonJebBeIJw3Igd8Z9aMIvrY=
X-Google-Smtp-Source: AGHT+IEeG5UdzuG01ceMRHaRbfoB5ueETLngDbhDnQoDVLYHB7cnpa+6IAFBeklBzAQZ+8lkvO3clw==
X-Received: by 2002:a17:906:6a0b:b0:a49:dfe1:d5e with SMTP id qw11-20020a1709066a0b00b00a49dfe10d5emr4163120ejc.57.1711838791805;
        Sat, 30 Mar 2024 15:46:31 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:9f01:e67d:4cf3:c3bc])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090637d300b00a46cc48ab07sm3533580ejc.221.2024.03.30.15.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 15:46:31 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 5/8] refs/files-backend: add support for symref updates
Date: Sat, 30 Mar 2024 23:46:20 +0100
Message-ID: <20240330224623.579457-6-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240330224623.579457-1-knayak@gitlab.com>
References: <20240330224623.579457-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

Add support for transactional symbolic reference updates in the files
backend. This also adheres to the config of using symlinks for symbolic
references.

While this commit is setting up the files-backend to support symrefs in
transaction's. It will only be used in a consequent commit, when we wire
up the `update-symref` option for `git-update-ref`.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/files-backend.c | 45 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 4dbe73c106..6b4cc80843 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2323,7 +2323,7 @@ static int split_head_update(struct ref_update *update,
 			transaction, "HEAD",
 			update->flags | REF_LOG_ONLY | REF_NO_DEREF,
 			&update->new_oid, &update->old_oid,
-			update->msg, NULL);
+			update->msg, update->symref_target);
 
 	/*
 	 * Add "HEAD". This insertion is O(N) in the transaction
@@ -2386,7 +2386,7 @@ static int split_symref_update(struct ref_update *update,
 	new_update = ref_transaction_add_update(
 			transaction, referent, new_flags,
 			&update->new_oid, &update->old_oid,
-			update->msg, NULL);
+			update->msg, update->symref_target);
 
 	new_update->parent_update = update;
 
@@ -2396,7 +2396,7 @@ static int split_symref_update(struct ref_update *update,
 	 * done when new_update is processed.
 	 */
 	update->flags |= REF_LOG_ONLY | REF_NO_DEREF;
-	update->flags &= ~REF_HAVE_OLD;
+	update->flags &= ~(REF_HAVE_OLD|REF_UPDATE_SYMREF);
 
 	/*
 	 * Add the referent. This insertion is O(N) in the transaction
@@ -2567,6 +2567,27 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 		}
 	}
 
+	if (update->flags & REF_UPDATE_SYMREF) {
+		if (create_symref_lock(refs, lock, update->refname, update->symref_target)) {
+			ret = TRANSACTION_GENERIC_ERROR;
+			goto out;
+		}
+
+		if (close_ref_gently(lock)) {
+			strbuf_addf(err, "couldn't close '%s.lock'",
+				    update->refname);
+			ret = TRANSACTION_GENERIC_ERROR;
+			goto out;
+		}
+
+		/*
+		 * Once we have created the symref lock, the commit
+		 * phase of the transaction only needs to commit the lock.
+		 */
+		if (update->flags & REF_UPDATE_SYMREF)
+			update->flags |= REF_NEEDS_COMMIT;
+	}
+
 	if ((update->flags & REF_HAVE_NEW) &&
 	    !(update->flags & REF_DELETING) &&
 	    !(update->flags & REF_LOG_ONLY)) {
@@ -2862,6 +2883,14 @@ static int files_transaction_finish(struct ref_store *ref_store,
 
 		if (update->flags & REF_NEEDS_COMMIT ||
 		    update->flags & REF_LOG_ONLY) {
+			if (update->flags & REF_UPDATE_SYMREF) {
+				if (!refs_resolve_ref_unsafe(&refs->base, update->symref_target,
+							     RESOLVE_REF_READING, &update->new_oid, NULL)) {
+					strbuf_addf(err, "refname %s not found", update->symref_target);
+					goto cleanup;
+				}
+			}
+
 			if (files_log_ref_write(refs,
 						lock->ref_name,
 						&lock->old_oid,
@@ -2879,6 +2908,16 @@ static int files_transaction_finish(struct ref_store *ref_store,
 				goto cleanup;
 			}
 		}
+
+		/*
+		 * We try creating a symlink, if that succeeds we continue to the
+		 * next updated. If not, we try and create a regular symref.
+		 */
+		if (update->flags & REF_UPDATE_SYMREF && prefer_symlink_refs)
+			if (!create_ref_symlink(lock, update->symref_target))
+				continue;
+
+
 		if (update->flags & REF_NEEDS_COMMIT) {
 			clear_loose_ref_cache(refs);
 			if (commit_ref(lock)) {
-- 
2.43.GIT

