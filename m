Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794317703;
	b=tvW8NAqGMP+HMSvAuDn41/lGvv/syk5OtIiJJfRyEybF8WelBo+kZk4gE8L9bZASh4lQ
	 IFz188D3iptVdWyvDmmgzhNhqovcpYlHkX07ArAZ+iRV4GSZI4ElAMclnQqo4wVSwRGGJ
	 iZEI8x5u/pGO7XXh7qv32FXXbErMrVwhqA5gezth+ehjmVw4aujFppsVpG+TfCz8QYKmE
	 S1MX7ZS0XjslNhiYu6fXis/7yZ5Ct2jtkDvcyjPlfnx+XIhF2gYpGqmqwlHgIsEXovdpD
	 i2GwGQq18YZhQaCfmUgjuAmV3bk9EDTxp5wIMUFUXq73vkg467iWqO3FLlRKugnKiSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794317703;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IMj4oFYGJkaPFJoBrljRqvjf4mZGMZDcUmLZr/DuWCg=;
	b=xwtFNNrhA6FT1XsoAc3P1YzZGuFcAJfD6YaXmsfrmk4ji5HKlvdLOCUtAuSHDSLrZuD9
	 u6nR7s7fwmiDTPiWuQhvdyj9d2Qb5dnjBxU25BhquxW6QNpz/YEf3tbN2r5dCmDRRWyHu
	 gWNjYHjw3Vd2js1WlMxTFlBckPO2SIyLetDgEQdqGTUFj4KXL/dOKDSo0DQlDmXNGg2ej
	 3cpqKSHVkR3x764A2kvRlKUugWNOJ/5LVrHp2ypS9h+SQ5AZ/8lsmHRfLpdkv9gmBGrh6
	 mvkkazcjeO5q7ylIcYUA0oCN5gQnRtVi0eiya3m8bmDApwFXCgbmLSuqIN943MHLrNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gLKhZcJR;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28971606A33A
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 13:35:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28971606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gLKhZcJR
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cdb2fcaafb7so83664a12.0
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 05:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794317702; x=1794922502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IMj4oFYGJkaPFJoBrljRqvjf4mZGMZDcUmLZr/DuWCg=;
        b=gLKhZcJRG47soAoe4FTWXW8vFbx8xdZ0xmI5kJUlL1hA6KmrGDGArhZcMyfkYS7/19
         R8QRwdfMxh8HD3KfVTqUsLEEOzHlFCmB9jtvz1RJtRq+zAWRCaZTehLoyXz/INtPXLmu
         O3kXYQNkbq88vmGW1cwpjDdGdiWYj1KTtNlNYYeuDNLg3Hbj+fN8W98+VaNAsdpXuwAv
         /cJZZKUX5T3aEySZ+UA18kIeJbrmw21CalirOAOCJwqJ6oude5cwyNtQ3oPLyZGfWVqD
         nefkf/g9kwx9xxXZg0AWpGJguEb9aHNaTagEVi8JcRx3vOGjaMoBjcgR087VZFnguy5w
         2Irg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794317702; x=1794922502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IMj4oFYGJkaPFJoBrljRqvjf4mZGMZDcUmLZr/DuWCg=;
        b=IUbuintV/mgnw9Hjl85OZ6pmnPeFyW2XH1EnrwZJVuNwBQbgtnAOQaJAhyaWJPy8NK
         EYufcNp6VHVCGXYgLQ9aQAw5uwiPep49Lg37iZgaugn9bZbEfN+kzhAUtR8vo/c6GqYR
         bagH0hgrqGVzNeoN1iyfhfz08Pdzl14M9oLhKpCgb9z9VDQZFp5U5iQLD024RgDRW4Zy
         ujN/HwIyds1MGmbrx2zKWpNhB56ztVlZkwIuWeTdrdcqCpsVnMa+yxSeAxLpwzw7zK/i
         xysjjx23n7t4WEaBLCReW2uVG8MA2+YRoA+PpMLFjZQER9w6qREDuqLk2yVNWEQRCxjH
         3ovg==
X-Gm-Message-State: APuU4Z/l5ZEMvjujxDc1ahkruRspl4h8hHXPY0EJNadnc5HPkeMeftti
	MLKfdT/Qil41j6yVXp1TcwMX8JA2YOLu3epPnPPFjaprAMQeMtggHYCmyhwyykFk2Ig=
X-Gm-Gg: AYBFou2pyV+3e3t3zhb8C7e2yAT1Kj7AjpiDuDKPd+1V14JMpGFCFNHuGxL+CtJqKfe
	WwwhiyWohvpLm7z9YChRXIogTSXgl+KXHgpRSiIeRJ41NGJcD2UIhyZcpLJbwJb8F3XnVeA8hex
	+i9Q3TXu4mHqY1wDUl2aFBuNMsvqNrgW3Fjt3fotFR57jhaIcb44hWSYzKuogAj3mOi8EDltEVF
	/7B14isMrW6TRNtLDYKdM1yPJ8V+n+Pw7ivxitN9TW5JAnLCWfY8qK8U9DRm8kkbiZPBtUZtyl/
	wjh50eJ+AHQVMSc7XTivHxv+TEQE32FkYiA/KYZ2yu8fstD1xRbZGQZ7YIZsfk/HnVB+8P+YxyM
	Rp6CNkdHcQZZutAamPqPKNcbrw/VYkZXnU62Jq7O193QHLQzXxQsTTkrWxRWKbc4GLWnikUuwcA
	cx7fJcGhpcBvX95NGBBViQO3SaMboiCZeSQPjtYiEpksi6Wesy5ai0j++xjdxVEWuFBy3wQtVCu
	HJmsKBGLyDXqiAD31sg38YslQr3VKu7imR9NPMt74C6DF8UySUefLryiK9htbABKNfchwNolTVR
	OcHknc8NM1SKZw1jWJ+ndu00vr2rpDNAYTJVByw4NOWIdDxwxJMG+p521IsTKyrRWQn18qF/Eor
	NDgaMXZi7vVTS
X-Received: by 2002:a17:90b:53c8:b0:3ac:a7ee:6785 with SMTP id 98e67ed59e1d1-3b166ad51d9mr4779947a91.1.1794317702376;
        Tue, 10 Nov 2026 05:35:02 -0800 (PST)
Received: from localhost.localdomain (softbank126036045011.bbtec.net. [126.36.45.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b168ff86e7sm1872046a91.2.2026.11.10.05.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 05:35:01 -0800 (PST)
From: tsukasa inoue <inoue.tsukasa.4@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	tsukasa inoue <inoue.tsukasa.4@gmail.com>
Subject: [PATCH] refs: fix reflog of a symref whose target is in the same transaction
Date: Tue, 10 Nov 2026 22:34:57 +0900
Message-ID: <20261110133457.43700-1-inoue.tsukasa.4@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <CAOLa=ZTYevwM0YF0iQFnEwKG_buV7qg0QdjoaTkw0c8OQSd-mQ@mail.gmail.com>
References: <CAOLa=ZTYevwM0YF0iQFnEwKG_buV7qg0QdjoaTkw0c8OQSd-mQ@mail.gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a transaction updates a ref and also points a symref at it, for
example

    update refs/heads/y <new>
    symref-update HEAD refs/heads/y

the reflog entry for HEAD should record <new>. Both backends get the
value for that entry by resolving the target with
refs_resolve_ref_unsafe(), which reads the refs as they are before the
transaction is applied.

The reftable backend writes all updates into one table at the end, so
it always sees the old value of y. When y is created by the same
transaction it sees no y at all, takes the symref as dangling, and
writes no reflog entry. The files backend commits the updates one at a
time in the order they were queued, so it gets it right only when the
update of y comes before the one of HEAD.

Add ref_transaction_resolve_new_oid(), which takes the new value from
the transaction when it updates the target, following symref updates
within it, and reads the ref store otherwise. Use it in both backends.

Signed-off-by: tsukasa inoue <inoue.tsukasa.4@gmail.com>
---

Notes:
    This follows up on the report at
    https://lore.kernel.org/git/CAP8tz2L3Dfhd+ec4+SFkZgXmzQnBg+3Y0REAV+1Hf5X415qnfw@mail.gmail.com/
    
    As discussed with Karthik there, this only moves the lookup of the
    target's new value to refs.c. Moving the rest of the reflog logic out
    of the backends, and resolving conflicting updates within a single
    transaction, are left for later.

 refs.c                  | 47 +++++++++++++++++++++++++++++++++++++++++
 refs/files-backend.c    | 10 +++++----
 refs/refs-internal.h    | 12 +++++++++++
 refs/reftable-backend.c |  9 ++++++--
 t/t1400-update-ref.sh   | 36 +++++++++++++++++++++++++++++++
 5 files changed, 108 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 951db56113..3a5c225fc9 100644
--- a/refs.c
+++ b/refs.c
@@ -1388,6 +1388,53 @@ struct ref_update *ref_transaction_add_update(
 	return update;
 }
 
+static struct ref_update *find_ref_update(struct ref_transaction *transaction,
+					  const char *refname)
+{
+	size_t i;
+
+	for (i = 0; i < transaction->nr; i++) {
+		struct ref_update *update = transaction->updates[i];
+
+		if (!(update->flags & REF_LOG_ONLY) &&
+		    !strcmp(update->refname, refname))
+			return update;
+	}
+
+	return NULL;
+}
+
+int ref_transaction_resolve_new_oid(struct ref_transaction *transaction,
+				    const char *refname,
+				    struct object_id *oid)
+{
+	int depth;
+
+	for (depth = 0; depth < SYMREF_MAXDEPTH; depth++) {
+		struct ref_update *update;
+
+		update = find_ref_update(transaction, refname);
+		if (!update)
+			break;
+
+		if (!(update->flags & REF_HAVE_NEW) || update->rejection_err)
+			break;
+
+		if (update->new_target) {
+			refname = update->new_target;
+			continue;
+		}
+
+		if (is_null_oid(&update->new_oid))
+			return 0;
+		oidcpy(oid, &update->new_oid);
+		return 1;
+	}
+
+	return !!refs_resolve_ref_unsafe(transaction->ref_store, refname,
+					 RESOLVE_REF_READING, oid, NULL);
+}
+
 static int transaction_refname_valid(const char *refname,
 				     const struct object_id *new_oid,
 				     unsigned int flags, struct strbuf *err)
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 87d04557a5..d8878f4df3 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3156,6 +3156,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 }
 
 static int parse_and_write_reflog(struct files_ref_store *refs,
+				  struct ref_transaction *transaction,
 				  struct ref_update *update,
 				  struct ref_lock *lock,
 				  struct strbuf *err)
@@ -3179,9 +3180,9 @@ static int parse_and_write_reflog(struct files_ref_store *refs,
 		 * We want to get the resolved OID for the target, to ensure
 		 * that the correct value is added to the reflog.
 		 */
-		if (!refs_resolve_ref_unsafe(&refs->base, update->new_target,
-					     RESOLVE_REF_READING,
-					     &update->new_oid, NULL)) {
+		if (!ref_transaction_resolve_new_oid(transaction,
+						     update->new_target,
+						     &update->new_oid)) {
 			/*
 			 * TODO: currently we skip creating reflogs for dangling
 			 * symref updates. It would be nice to capture this as
@@ -3377,7 +3378,8 @@ static int files_transaction_finish(struct ref_store *ref_store,
 
 		if (update->flags & REF_NEEDS_COMMIT ||
 		    update->flags & REF_LOG_ONLY) {
-			if (parse_and_write_reflog(refs, update, lock, err)) {
+			if (parse_and_write_reflog(refs, transaction, update,
+						   lock, err)) {
 				ret = REF_TRANSACTION_ERROR_GENERIC;
 				goto cleanup;
 			}
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index c3ac7b556f..33ba285dc4 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -187,6 +187,18 @@ struct ref_update *ref_transaction_add_update(
 		const char *committer_info,
 		const char *msg);
 
+/*
+ * Resolve `refname` to the object ID it will have once `transaction` is
+ * committed: if the transaction updates `refname`, use the new value of
+ * that update (following `new_target` of symref updates in the
+ * transaction), otherwise read it from the ref store. Return 1 and fill
+ * `oid` if it resolves to an object, 0 if it would be dangling (missing,
+ * or deleted by the transaction). Meant to be used while committing.
+ */
+int ref_transaction_resolve_new_oid(struct ref_transaction *transaction,
+				    const char *refname,
+				    struct object_id *oid);
+
 /*
  * Transaction states.
  *
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index d0de066355..46142a4f73 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -940,6 +940,7 @@ struct reftable_transaction_update {
 
 struct write_transaction_table_arg {
 	struct reftable_ref_store *refs;
+	struct ref_transaction *transaction;
 	struct reftable_backend *be;
 	struct reftable_addition *addition;
 	struct reftable_transaction_update *updates;
@@ -950,6 +951,7 @@ struct write_transaction_table_arg {
 };
 
 struct reftable_transaction_data {
+	struct ref_transaction *transaction;
 	struct write_transaction_table_arg *args;
 	size_t args_nr, args_alloc;
 };
@@ -1014,6 +1016,7 @@ static int prepare_transaction_update(struct write_transaction_table_arg **out,
 			   tx_data->args_alloc);
 		arg = &tx_data->args[tx_data->args_nr++];
 		arg->refs = refs;
+		arg->transaction = tx_data->transaction;
 		arg->be = be;
 		arg->addition = addition;
 		arg->updates = NULL;
@@ -1332,6 +1335,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 		goto done;
 
 	tx_data = xcalloc(1, sizeof(*tx_data));
+	tx_data->transaction = transaction;
 
 	/*
 	 * Preprocess all updates. For one we check that there are no duplicate
@@ -1557,8 +1561,9 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 			int create_reflog = 1;
 
 			if (u->new_target) {
-				if (!refs_resolve_ref_unsafe(&arg->refs->base, u->new_target,
-							     RESOLVE_REF_READING, &u->new_oid, NULL)) {
+				if (!ref_transaction_resolve_new_oid(arg->transaction,
+								     u->new_target,
+								     &u->new_oid)) {
 					/*
 					 * TODO: currently we skip creating reflogs for dangling
 					 * symref updates. It would be nice to capture this as
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 1a164c96f9..19f0987d2f 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -853,6 +853,42 @@ test_expect_success 'stdin delete symref works option no-deref' '
 	test_cmp expect actual
 '
 
+for action in update create
+do
+	for order in branch-first head-first
+	do
+		test_expect_success "stdin symref-update HEAD logs target's new value ($action, $order)" '
+			test_when_finished "rm -rf repo branch-cmd head-cmd" &&
+			git init repo &&
+			test_commit -C repo one &&
+			test_commit -C repo two &&
+			new=$(git -C repo rev-parse two) &&
+			if test "$action" = update
+			then
+				git -C repo branch topic one
+			fi &&
+			echo "$action refs/heads/topic $new" >branch-cmd &&
+			{
+				echo "option no-deref" &&
+				echo "symref-update HEAD refs/heads/topic"
+			} >head-cmd &&
+			if test "$order" = branch-first
+			then
+				cat branch-cmd head-cmd >stdin
+			else
+				cat head-cmd branch-cmd >stdin
+			fi &&
+			git -C repo update-ref -m "move HEAD" --stdin <stdin &&
+			echo "move HEAD" >expect &&
+			git -C repo reflog -1 --format=%gs HEAD >actual &&
+			test_cmp expect actual &&
+			echo $new >expect &&
+			git -C repo reflog -1 --format=%H HEAD >actual &&
+			test_cmp expect actual
+		'
+	done
+done
+
 test_expect_success 'stdin update symref works flag --no-deref' '
 	git symbolic-ref TESTSYMREFONE $b &&
 	git symbolic-ref TESTSYMREFTWO $b &&
-- 
2.56.0

