Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE481DB520
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 10:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734086220; cv=none; b=k/tS9AxbZFVj42fYjhsvcbFgUCRQFFiu0uO/PdlSoAf3QbOC0sSWONSmNpVXEkq9cr7nsx7EnhYwMKqIIHm9w6y6+uMNtFJ4sGndCYTsOwosq62M5a9S7JB051zx3eSog42pDoGVe+CcRX0ptc+hoaVBSnwgcBHJ1lF+n9XMgH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734086220; c=relaxed/simple;
	bh=f/A/BCqKAqzM0pLs1kG9GIyqPDtQjwybZoyZG7dxK2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WtE2Lvq1nJqlQbhn+zmSfTzh1cOC9QjH5FKTDyqb9H1f9hXA6O1+F6Re0zCU1fwA9bpWiJTIl69lGrkIClu6S6fJXua57H38eUHwCs8mvENzHBXCA98svBrZyxrZmgGRIDuqMFcmDf6EKJOCeipzAkRP1kin9PJGOJzOw7RJzPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WxoV1fB5; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxoV1fB5"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d34030ebb2so2773017a12.1
        for <git@vger.kernel.org>; Fri, 13 Dec 2024 02:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734086216; x=1734691016; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sBFYSTUfNJIIVk7ZutMhrrImhHuoVlb/4NnmMbqvDNQ=;
        b=WxoV1fB5/y9OdKYMqj+PsUmxjF+ShHiPZ2FHMzruCODb7F6ndR4v3SKtpsX5w5PMnV
         CLWa6h1AqjGTu4MmHLYdfaEEv22N+BHqqhJBERXbT18J8S2wEOianTPwR+aXmbdgMcPm
         6F4p1u2UWgWKvmXWKFLLSK1Av1XaRt6eOyN9P3QzZ2J0JsTQIMDj3n0FBcuc+oH3iY/2
         tz/JA5MRW7YwWGrwIZEQ9Nga0TYKniNJhU64aYXJppyBwsRjNhXk5R/m3pNsyB+kZ5qV
         yWQvAuoqx7sAmAdQVpz72yL9++6ZG2HtRcEg+SDmM/RJNdTfVPJ0GihCqPLHSOK7pmTq
         4bHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734086216; x=1734691016;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sBFYSTUfNJIIVk7ZutMhrrImhHuoVlb/4NnmMbqvDNQ=;
        b=iNTzSZ0LbcRt8+aXPAF8Er+oX6BchApecT3nMYlHx79oVfJtlk0w36WhlczuegH1mx
         yk9VtByTMlzREstDBDqRXZbcj2gM6AHz3ugtqfq0UtTldWbd4D7GK8tImewx2Erz/zC6
         A+HhXHhEPQIv1qd6dc0DbNLaqkP00BxYFMa3B1JSkGTQdpG+KGx5EN9FAiEGwE+uciC0
         YsZ6kmzHvBUn1ZQ1NVY5SNb+kZsWMufKXQHEMZyDFKdP7FjVhRqQ5wbcAn4b86RkG394
         00139tcA+4JFixZkjMMdPS+BQeQ5Mq4W78S65FvTbcEq85Zhp+agkEcGnDm3IejEPwgJ
         EeCw==
X-Gm-Message-State: AOJu0YxAPBtB7TxOtK0DYt/5M2CgdIB65zNBTjsJPp+WmUymTjMpYcvI
	o2JVAMKDrAhMthpSLA08LnXcOVNWjAzwLn+wV4W2OvNl++nNTYby
X-Gm-Gg: ASbGncv7phLdSGfRcrrFe8kgvfGmAgNgmZB5zieZvRFoYLGKd36rKhnCALaqtckEz0o
	pwtDkC54iazQdya5b/wG8Bo8WG3HDrmSLLKcXGzVCOAd2zUpVZkjYOzcF9vlqz1/q85QsdbXfgM
	Wjf0pw75pVzA5aWOe3EJ2MIEKHFAxOhECFhy8ZPflu4WwNlpeqf9jV8NvheQBATb5HOjuLrJePn
	x7xb+z+namlmjqgFZdFHwfclheecsz1cIMQolFcd1TZzQ8pd8uSqHgRVymN/xrYSKNHQw==
X-Google-Smtp-Source: AGHT+IGL8GSwgdNNgsJmE92GMvA3hnymUZiQIfucOXz9d6XmK14yI4NlWC/BDHuGBH/tNk7W1IM0ug==
X-Received: by 2002:a17:906:32ce:b0:aa6:77e6:ea3d with SMTP id a640c23a62f3a-aab77e7b4d0mr194019966b.45.1734086216184;
        Fri, 13 Dec 2024 02:36:56 -0800 (PST)
Received: from [192.168.178.20] ([2a02:2455:8256:2d00:9c39:c2d7:aedd:294d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6883f65c3sm686785266b.157.2024.12.13.02.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 02:36:55 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 13 Dec 2024 11:36:52 +0100
Subject: [PATCH v2 7/8] refs: allow multiple reflog entries for the same
 refname
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-320-git-refs-migrate-reflogs-v2-7-f28312cdb6c0@gmail.com>
References: <20241213-320-git-refs-migrate-reflogs-v2-0-f28312cdb6c0@gmail.com>
In-Reply-To: <20241213-320-git-refs-migrate-reflogs-v2-0-f28312cdb6c0@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4948; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=f/A/BCqKAqzM0pLs1kG9GIyqPDtQjwybZoyZG7dxK2A=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnXA5BSPsR2ftTdYnX7sPEb2WvT/fyZbpqSAU2C
 6+NMFxkEB2JAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZ1wOQQAKCRA+1Z8kjkaM
 f0D7C/4wlB2jQIJyKNhLs/CppFAN47y8APmf1hv5wG4D4XTkkCYDM1CBeEx8XC6zu8P4lv+8zRt
 X08EPsCwdZZvz+FDUKQlSe9ryXWcxpYZGNpnIdSNFzXPI4QZFIv8GvfWOSTAF5PWA/OnPp/y+Ss
 HAI3obpzSRRtIaKDD/npe9plNdMASwLwkY7aLEjUJ52gyi05JggILPowhlCmjbqA+ycyeXAo+6W
 WW1Z/hWJUfVt8p27NuOYgoXRYPhyW/O1ETFxPrYdDg2aCKZRdGDvYdRCUOudIhjXXO+EdTw1WcI
 o8NdMHVoNnjuMzQ8WyoC9qt1nWetMWoa8ACMU3UH8/oUmGdVbio19NtObygPBMjpWn8tsA23rCb
 qD665uJ/+OAAQzf/yDck9fIH1/pmA+AylHzpTaupHwDfKMR0eku08zskcEXym/G2tvXZmegZXCe
 476gVt+i6fHHK1Q9FCCk7O3wAEZgKkZwjvhyLjNJ3YdhsFyL7e6wr4l/aa2FRPrrKoXE4=
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
The `index` field is only be set when multiple reflog entries for a
given refname are added and as such in most scenarios the old behavior
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

