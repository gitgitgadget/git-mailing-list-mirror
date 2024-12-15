Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9C21940B3
	for <git@vger.kernel.org>; Sun, 15 Dec 2024 16:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734279961; cv=none; b=bnegeeNTVh0y3TsBnKDZDLJ94aoR7RgrbFHg7rFeZHTENpf4wRf0lFMkr/H7eI7rtC6qNFm13zGz66ZXBPQnL/sHt2RpKu6Xi0oTuErfbNyGa0mgJCTby1HgCvHO/U+/ZbDEmrfouWVX9m+iaLBxRHrfzObTHKJpKonRHRrlFf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734279961; c=relaxed/simple;
	bh=jDPMqKatsQhg+EBjNPw/kC4fYprM2j3L9khrIu5BB0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bLGc0CyTUXKNGj/hu4HeibY0NrN2CKAp0bZwfUyAJWeBz6tnPldqk+o/+N0OvciGQyMzYyJwT/SIGBX2MT6/XsKGRPDNIAoy4s04/clJaFhjtuHCRdhqLXrEkKKvmoyJ2eXq3XnQut1hBV4uUNTP+Lty9T8DQ0tiF3diPVFyxP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SS0VR5le; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SS0VR5le"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aab925654d9so336669766b.2
        for <git@vger.kernel.org>; Sun, 15 Dec 2024 08:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734279958; x=1734884758; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hFja4Dce2bjeu8KBc7aHCgLjbi7WVN8kJntGzJ+xVtg=;
        b=SS0VR5leARAq0rq78Wquk2MjLjhTpyvq3jHXjNnbEr1bpxk/DeiZb7BXokLRqtA7IN
         U3lZFNddDRPiwq/CuWwHnY3Ob/C6FKcotJ8x+TyzrdekHbLG34cBvZId7w6Vo/DRfpmd
         nd5xZTV/N3UcD/gnHI2NmSb38Nv8uf9baOSMOFiQ+sugQbyB+sok/AQE0BLCsG0XIfuP
         Trtu6YhGYwa/T+1PpkxJbURVlEQ/3Vc8KyQ0l+nQwR4SCYmsC1hXHFMzCFDJ8a1BWnck
         1YzaGVO6JCZIMbBwkQIejvV79JwFShs+/N33xBI7KDASPoKbUv4x6euQkt4aVbmHAkJQ
         fBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734279958; x=1734884758;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hFja4Dce2bjeu8KBc7aHCgLjbi7WVN8kJntGzJ+xVtg=;
        b=Ws/dk0B7R85Wi3WFpXp5MzSCTBYg1FO7pLEm8nGEGnLu5hHY1ElAmJqgiYB1M+mpjL
         kqT6+Wf0fZb8PnAa6/QWtJNzlGng2bTNKfY/4ohiHLcAFJeipaseXi/uhrZxKLYxf6Ma
         xpSJU5bBTSfA4VWP7T4BHpm94zua26OGKzF56IwSobWWIwLgtbhR1xzdN+zc+67GLq8E
         jdLsi+9xb6xv2jdvV3jaioFcW4DtgJPcju+IulmaMJ3nD8WxvQFK22q6cMXDyonSjvHG
         phTIf6MhBEqJI7rx5h0Yj/RumZcOv1KZZDwY0xoQlP/BTS19ZTBA+6p9xc00jP9eo9D/
         NxEw==
X-Gm-Message-State: AOJu0YysNtcxwEDGAsBh2y+xhdMUbdkNzF34eWb8UAzSeXEiob4CODYS
	bmu9l/vGlOoHdpv+vNdNP19d3u8dYwD0XP7rr7Ogg/mS/8K7n5D0
X-Gm-Gg: ASbGncvRLZchKmiT0H9WB5S/HjeMC2WtNb2rN7QI3kNDeVv2AGSk5xKHqctjD5IRF2I
	XgDCN+b1be6G2Mzd6IzLr5eYnZ/0LkiHsdifMivDEOHFZHF9AA6K0VseMBesTIZqoyq+gPMfWN7
	kFntvrxL7RKevep+1DE8iYI7KPksNe4jw741o5bssidVvWb4yGydWjajkcSB/Z5qcvq+2PCoT0n
	4gkzuTQpnxN01wRx7o58WwjyEZb8fuDzhsI5Dj9BhF2MP9E4KFghzcfF9CgxSi74fsSuw==
X-Google-Smtp-Source: AGHT+IEpbq135coc0PrsYDSJfTmgYHumdNb87a2VFfzxX8OFxH2RktPZ936y8B7CeGAMfolb1GavPQ==
X-Received: by 2002:a17:906:f58e:b0:aa6:2fdc:db1a with SMTP id a640c23a62f3a-aab77e8ab9bmr861133166b.38.1734279958043;
        Sun, 15 Dec 2024 08:25:58 -0800 (PST)
Received: from [192.168.178.20] ([2a02:2455:8256:2d00:9c39:c2d7:aedd:294d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9638ad1asm224887866b.139.2024.12.15.08.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 08:25:57 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Sun, 15 Dec 2024 17:25:44 +0100
Subject: [PATCH v3 7/8] refs: allow multiple reflog entries for the same
 refname
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241215-320-git-refs-migrate-reflogs-v3-7-4127fe707b98@gmail.com>
References: <20241215-320-git-refs-migrate-reflogs-v3-0-4127fe707b98@gmail.com>
In-Reply-To: <20241215-320-git-refs-migrate-reflogs-v3-0-4127fe707b98@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4945; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=jDPMqKatsQhg+EBjNPw/kC4fYprM2j3L9khrIu5BB0Q=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnXwMOb82QdwdoIBEfJT+tJHkyOa/fgHvHcYBcU
 Nssp2/DTSaJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZ18DDgAKCRA+1Z8kjkaM
 f13pC/9YIwIdj362MmG8xJEM96iS1PWxavA0ollutg+IXF8iM55G1jdFGBoXqJw+PtKDZmbvX5B
 cLQE1QlywTRWZ+madOEmF3raZ82gXIqNe0QXNeoeJvJg3QIMBc8ZmLLX35lOjZkYYrTvYEOfjS6
 7O5tkppDjfUOwzDy+UYR3O6E0FyGJlUZK5xjp+bFJzOuHDU7tVivcAir1t0kHdlm3ZJ7KpuPYcE
 6HIduhEPW6aVpgGNMNryTJcke9vnquK0V9P/slBAmOG9JFI/nuF2rOTOizVnwTjfnSqqtGhq6fC
 TnQG+lK3VKpSrU2hwFTCeeXoDNiuM8um8NkFI98jq8h/mBiUrD1pTMIeq1Kma0UEBNA7zUA+Fvn
 uVbCZvRp/QfhvnOUthRRHXvlscH39B1KrCWYE14uwcNrMJazO4DXjD34SUBToo0aEL+MnbifnjR
 VbDm76Vt1zI16W16/F/RD+XfI8jmpHnCyjjb1YA7twElhfCkv7m0DVlPyv0jZwbuXaoWk=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The reference transaction only allows a single update for a given
reference to avoid conflicts. This, however, isn't an issue for reflogs.
There are no conflicts to be resolved in reflogs and when migrating
reflogs between backends we'd have multiple reflog entries for the same
refname.

So allow multiple reflog updates within a single transaction. Also the
reflog creation logic isn't exposed to the end user. While this might
change in the future, currently, this reduces the scope of issues to
think about.

In the reftable backend, the writer sorts all updates based on the
update_index before writing to the block. When there are multiple
reflogs for a given refname, it is essential that the order of the
reflogs is maintained. So add the `index` value to the `update_index`.
The `index` field is only set when multiple reflog entries for a given
refname are added and as such in most scenarios the old behavior
remains.

This is required to add reflog migration support to `git refs migrate`.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/files-backend.c    | 15 +++++++++++----
 refs/reftable-backend.c | 22 +++++++++++++++++++---
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index c11213f52065bcf2fa7612df8f9500692ee2d02c..8953d1c6d37b13b0db701888b3db92fd87a68aaa 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2611,6 +2611,9 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 
 	update->backend_data = lock;
 
+	if (update->flags & REF_LOG_ONLY)
+		goto out;
+
 	if (update->type & REF_ISSYMREF) {
 		if (update->flags & REF_NO_DEREF) {
 			/*
@@ -2829,13 +2832,16 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 	 */
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
-		struct string_list_item *item =
-			string_list_append(&affected_refnames, update->refname);
+		struct string_list_item *item;
 
 		if ((update->flags & REF_IS_PRUNING) &&
 		    !(update->flags & REF_NO_DEREF))
 			BUG("REF_IS_PRUNING set without REF_NO_DEREF");
 
+		if (update->flags & REF_LOG_ONLY)
+			continue;
+
+		item = string_list_append(&affected_refnames, update->refname);
 		/*
 		 * We store a pointer to update in item->util, but at
 		 * the moment we never use the value of this field
@@ -3035,8 +3041,9 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 
 	/* Fail if a refname appears more than once in the transaction: */
 	for (i = 0; i < transaction->nr; i++)
-		string_list_append(&affected_refnames,
-				   transaction->updates[i]->refname);
+		if (!(transaction->updates[i]->flags & REF_LOG_ONLY))
+			string_list_append(&affected_refnames,
+					   transaction->updates[i]->refname);
 	string_list_sort(&affected_refnames);
 	if (ref_update_reject_duplicates(&affected_refnames, err)) {
 		ret = TRANSACTION_GENERIC_ERROR;
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index b2e3ba877de9e59fea5a4d066eb13e60ef22a32b..bec5962debea7b62572d08f6fa8fd38ab4cd8af6 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -990,8 +990,9 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 		if (ret)
 			goto done;
 
-		string_list_append(&affected_refnames,
-				   transaction->updates[i]->refname);
+		if (!(transaction->updates[i]->flags & REF_LOG_ONLY))
+			string_list_append(&affected_refnames,
+					   transaction->updates[i]->refname);
 	}
 
 	/*
@@ -1301,6 +1302,7 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 	struct reftable_log_record *logs = NULL;
 	struct ident_split committer_ident = {0};
 	size_t logs_nr = 0, logs_alloc = 0, i;
+	uint64_t max_update_index = ts;
 	const char *committer_info;
 	int ret = 0;
 
@@ -1405,7 +1407,19 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 				}
 
 				fill_reftable_log_record(log, &c);
-				log->update_index = ts;
+
+				/*
+				 * Updates are sorted by the writer. So updates for the same
+				 * refname need to contain different update indices.
+				 */
+				log->update_index = ts + u->index;
+
+				/*
+				 * Note the max update_index so the limit can be set later on.
+				 */
+				if (log->update_index > max_update_index)
+					max_update_index = log->update_index;
+
 				log->refname = xstrdup(u->refname);
 				memcpy(log->value.update.new_hash,
 				       u->new_oid.hash, GIT_MAX_RAWSZ);
@@ -1469,6 +1483,8 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 	 * and log blocks.
 	 */
 	if (logs) {
+		reftable_writer_set_limits(writer, ts, max_update_index);
+
 		ret = reftable_writer_add_logs(writer, logs, logs_nr);
 		if (ret < 0)
 			goto done;

-- 
2.47.1

