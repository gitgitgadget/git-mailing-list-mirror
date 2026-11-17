Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794909387;
	b=RLKCPnSy9E7xs5imHxahO7lK0ymtMCmt35lkRTSznuFVQNRkRuUmvhjGYOZrCb98X9oy
	 PrizfMIjwQX43cvDdA1WlBO2cT5wmuSPy1nqsxJVsS8uKord47SGsxUeqlsfwsFNauN9n
	 U7p42R6iOkGHZjxYSKtuY+NzqvJX4tQBcRzlntYILvw1O8DqQtark/4Mxzrl7hf5s/7Wr
	 32yBiKWmTRAu5Nj1MkW6lVwg3D5Kva0V5Dvi33M8YqtknluD6S+yC6+9KoS6hyycXgtlJ
	 lunKg9YsEtBFeyUExNCrmns9USSWImaDNWohknbu+kdOwMa+eJkjjJ0KmywAaaT/X5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794909387;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=b04TrnizSyk4f7t1p2CjV5vWvWT/M1LIaE/97adBoC8=;
	b=ugZYKsFF2P/JzGN5rKbtsWldWRAYbt5CWbnLJPfoebtq0bRZtf/5z98eMwyMJirQuvZ0
	 XAiq0J2k1PL8ynB8cPm3H5lhl16JEkI60Vz5MEktDlbf2hopuqBvLygwr1U8jD/ahVlvE
	 JaND7tQOSyA2rX34ppjOcCfuXGk5WYMqeV13J0gZ59rhtWB/hDuDCkpvHdKDedBUfoESW
	 7qobrQthpnguGFjp8VQlwUz1D627pr3dVjzc6Yk4YPxuxtNofL1Xvun5fHYcFXDS8375q
	 JxFYSg0fDaK9W+4zQ7VuXwJZoTaUFxaOtCDhK1D67m8iQJDBrEep+ivj4Md1kTD4D7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=chRfFHL+;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B79606A337
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 09:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95B79606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=chRfFHL+
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2efdb4499a3so499915ad.0
        for <git@vger.kernel.org>; Tue, 17 Nov 2026 01:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794909386; x=1795514186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b04TrnizSyk4f7t1p2CjV5vWvWT/M1LIaE/97adBoC8=;
        b=chRfFHL+RAjx5epS802tk4D0X2EIFIr4CzxkAFy86tyHiPcbGvRTZM1Ff1d39t5BMF
         27WYR22RxhHkhnbwChOLt7YAfbkpR3EKVxNQSDWq2iLA6d1ySfYMk9sgCmIGTfqlQ7Dj
         u1wFNNV0ejg8waISIIHKZOTXZSyn73g4q+zebd8QpJZSCLA+wt8zLvlEFepebUrWC5rb
         eQpQuLlsQmzPoEDFx+fmc74BzvZ91VQJPBeVUSo5SZfelROb2Sg1umE8nzrZDP4/FdWJ
         5d71xttBjnsIkyLnf87TrLtTiJiSVw5HgnBc9YGunZ8Im+n8cqmlm9S9cx/j65LvUQTb
         zYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794909386; x=1795514186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b04TrnizSyk4f7t1p2CjV5vWvWT/M1LIaE/97adBoC8=;
        b=PXgAVZXvPPENZMuhobswRj6wmCFZyM4mSgq0ebUx5i+H9ym0ar5hTxJuIq8+AwGxcL
         KqGUDH0PFutg4+5tt9JfsdjuT7dgELIH94z/lgOlKfgTSNksuY7scXv511qMSxdJaf9S
         4OsxGZ7fruRT8rk7PnLj2Rp0qSQWQ/Cn5VpCsb1vh26xvnhiWmJQkTJdy+RzfHah0DLj
         qyTEYEyPi4r3CCOLyAtBnK7l+ouFA62GUZ7HGi152FlpQ59kZZg3LOLEcp2WyC1mfoa1
         MPDZFmt02Ecj37+Ozfkt1x9rdeCVGgGAnyYW/kU8ywIrCoigOKgCYNE0Ne3b1+UaN4iz
         nJEw==
X-Gm-Message-State: APuU4Z/Qs2Ev8GW9tPfeYWeE1i4qrZzbVUFVviW84lvroWPoa06XZpEZ
	a8ekV6YuPz2TKKPvefzAwncM3Z8NZL7D1dIl7WDbqXU9BkdXftxSkRvwU30VqPlA
X-Gm-Gg: AZFdTZfwSzialqO56gcYVkNKpsdbIAsZxQoKxFcpOIdElHb4ZA1oms6ejCMoKmQv8Qg
	liiziSiMNzawvWK57qknbYhGGFdJ4bHEPnhYckSh3nO00krKJ5mZicJsSlamUN6vOHO3k1A49GG
	O8lXGjAWFtK5AO6958fVnYvkx4XA4ZjZi8SPp1ixqX1XzIl5vLQR1av32FF3f42ED/wagbWmOmU
	fhEF4MpZYwJreP2gQ2axJnnIVyiWYQzp5uE7DW4hfh/zrwNw5Tcj0MOsZXsGDyCVbzQ/8RT74zZ
	7jFAvh1RyjwuFzGHYOMg7adeyO5/EVe5JDlxCa7TJ6ecNe6PzWyqBf1J4WFks2Bt5R8KPSDnZCK
	ydhxVlUVUgx3gwEdIYv1F7nCi2fq+mhfspGmVN4Dy3yM98V2UHhiF4HHGA63uU0O4ZrcZJkYxo7
	jSDBmmHgHnaMhAG/9gNMUU37R8HSzOCpECQcLgOXxC38HQtWQg9V/uMJ0JFo9TpdRo+58jMc9lX
	QS2TjKk5ic3Rqpr6kWcl3Uv35s9mxvdUNJOiP9EWaoCRVjrvOIjg8gzdf3eMnVOs6LDirNHBc4Y
	7Pe7rBjJWyEQ2DOByI7yOvhgcnHBUVPmT69iKqy8N29vUda8EYgB5b9dlpC0yNg=
X-Received: by 2002:a17:902:b708:b0:2ef:d2b9:48b6 with SMTP id d9443c01a7336-2efd2b94a99mr28826745ad.0.1794909385655;
        Tue, 17 Nov 2026 01:56:25 -0800 (PST)
Received: from localhost.localdomain ([27.131.11.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2efd7a85f56sm12240655ad.61.2026.11.17.01.56.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Nov 2026 01:56:24 -0800 (PST)
From: tsukasa inoue <inoue.tsukasa.4@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	tsukasa inoue <inoue.tsukasa.4@gmail.com>
Subject: [PATCH v2] refs: fix reflog of a symref whose target is in the same transaction
Date: Tue, 17 Nov 2026 18:56:15 +0900
Message-ID: <20261117095615.70423-1-inoue.tsukasa.4@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261110133457.43700-1-inoue.tsukasa.4@gmail.com>
References: <20261110133457.43700-1-inoue.tsukasa.4@gmail.com>
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
transaction it sees no y at all, treats the symref as dangling, and
writes no reflog entry. The files backend commits the updates one at a
time in the order they were queued, so it gets it right only when the
update of y comes before the update of HEAD.

Add ref_transaction_resolve_new_oid(), which takes the new value from
the transaction when it updates the target, following symref updates
within it, and reads the ref store otherwise. Use it in both backends.

Signed-off-by: tsukasa inoue <inoue.tsukasa.4@gmail.com>
---

Notes:
    Changes since v1:
    
     - Run the tests in a subshell inside the test repository, with blank
       lines between the steps (Karthik).
     - Add a test where the symref target is updated through HEAD. That
       update is added to refnames after it is sorted, which is why the
       helper scans transaction->updates instead of using
       string_list_lookup().
     - Add a --batch-updates test where the update of the target is
       rejected.

 refs.c                  |  46 ++++++++++++++++++
 refs/files-backend.c    |  10 ++--
 refs/refs-internal.h    |  11 +++++
 refs/reftable-backend.c |   9 +++-
 t/t1400-update-ref.sh   | 101 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 171 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 951db56113..d7bed9d7bb 100644
--- a/refs.c
+++ b/refs.c
@@ -1388,6 +1388,52 @@ struct ref_update *ref_transaction_add_update(
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
+		struct ref_update *update = find_ref_update(transaction, refname);
+
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
index c3ac7b556f..d4e8834627 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -187,6 +187,17 @@ struct ref_update *ref_transaction_add_update(
 		const char *committer_info,
 		const char *msg);
 
+/*
+ * Resolve `refname` to the object ID it will have once `transaction` is
+ * committed. If the transaction updates `refname`, its new value is used,
+ * following symref updates in the transaction; otherwise the ref store is
+ * read. Return 1 and fill `oid` if it resolves to an object, 0 if it is
+ * missing or deleted by the transaction.
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
index 1a164c96f9..7bc4aaaae9 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -853,6 +853,107 @@ test_expect_success 'stdin delete symref works option no-deref' '
 	test_cmp expect actual
 '
 
+for action in update create
+do
+	for order in branch-first head-first
+	do
+		test_expect_success "stdin symref-update HEAD logs target's new value ($action, $order)" '
+			test_when_finished "rm -rf repo" &&
+			git init repo &&
+			(
+				cd repo &&
+				test_commit one &&
+				test_commit two &&
+				new=$(git rev-parse two) &&
+				if test "$action" = update
+				then
+					git branch topic one
+				fi &&
+
+				echo "$action refs/heads/topic $new" >branch-cmd &&
+				{
+					echo "option no-deref" &&
+					echo "symref-update HEAD refs/heads/topic"
+				} >head-cmd &&
+				if test "$order" = branch-first
+				then
+					cat branch-cmd head-cmd >stdin
+				else
+					cat head-cmd branch-cmd >stdin
+				fi &&
+				git update-ref -m "move HEAD" --stdin <stdin &&
+
+				echo "move HEAD" >expect &&
+				git reflog -1 --format=%gs HEAD >actual &&
+				test_cmp expect actual &&
+				echo $new >expect &&
+				git reflog -1 --format=%H HEAD >actual &&
+				test_cmp expect actual
+			)
+		'
+	done
+done
+
+test_expect_success 'stdin symref-update logs new value of target updated via HEAD' '
+	test_when_finished "rm -rf repo" &&
+	git init -b a repo &&
+	(
+		cd repo &&
+		test_commit one &&
+		test_commit two &&
+		new=$(git rev-parse two) &&
+		git update-ref refs/heads/a one &&
+
+		cat >stdin <<-EOF &&
+		update HEAD $new
+		option no-deref
+		symref-update refs/heads/s refs/heads/a
+		EOF
+		git update-ref -m "move s" --stdin <stdin &&
+
+		echo "move s" >expect &&
+		git reflog -1 --format=%gs refs/heads/s >actual &&
+		test_cmp expect actual &&
+		echo $new >expect &&
+		git reflog -1 --format=%H refs/heads/s >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'stdin batch-updates symref-update HEAD does not log rejected target value' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit one &&
+		test_commit two &&
+		old=$(git rev-parse one) &&
+		new=$(git rev-parse two) &&
+		git branch y one &&
+
+		cat >stdin <<-EOF &&
+		update refs/heads/y $new $new
+		option no-deref
+		symref-update HEAD refs/heads/y
+		EOF
+		git update-ref -m "move HEAD" --batch-updates --stdin <stdin >stdout &&
+
+		test_grep "rejected refs/heads/y" stdout &&
+		echo $old >expect &&
+		git rev-parse refs/heads/y >actual &&
+		test_cmp expect actual &&
+		echo refs/heads/y >expect &&
+		git symbolic-ref HEAD >actual &&
+		test_cmp expect actual &&
+		echo "move HEAD" >expect &&
+		git reflog -1 --format=%gs HEAD >actual &&
+		test_cmp expect actual &&
+		echo $old >expect &&
+		git reflog -1 --format=%H HEAD >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'stdin update symref works flag --no-deref' '
 	git symbolic-ref TESTSYMREFONE $b &&
 	git symbolic-ref TESTSYMREFTWO $b &&

Range-diff against v1:
1:  337abe33a3 ! 1:  acd2808b3a refs: fix reflog of a symref whose target is in the same transaction
    @@ Commit message
     
         The reftable backend writes all updates into one table at the end, so
         it always sees the old value of y. When y is created by the same
    -    transaction it sees no y at all, takes the symref as dangling, and
    +    transaction it sees no y at all, treats the symref as dangling, and
         writes no reflog entry. The files backend commits the updates one at a
         time in the order they were queued, so it gets it right only when the
    -    update of y comes before the one of HEAD.
    +    update of y comes before the update of HEAD.
     
         Add ref_transaction_resolve_new_oid(), which takes the new value from
         the transaction when it updates the target, following symref updates
    @@ Commit message
     
     
      ## Notes ##
    -    This follows up on the report at
    -    https://lore.kernel.org/git/CAP8tz2L3Dfhd+ec4+SFkZgXmzQnBg+3Y0REAV+1Hf5X415qnfw@mail.gmail.com/
    +    Changes since v1:
     
    -    As discussed with Karthik there, this only moves the lookup of the
    -    target's new value to refs.c. Moving the rest of the reflog logic out
    -    of the backends, and resolving conflicting updates within a single
    -    transaction, are left for later.
    +     - Run the tests in a subshell inside the test repository, with blank
    +       lines between the steps (Karthik).
    +     - Add a test where the symref target is updated through HEAD. That
    +       update is added to refnames after it is sorted, which is why the
    +       helper scans transaction->updates instead of using
    +       string_list_lookup().
    +     - Add a --batch-updates test where the update of the target is
    +       rejected.
     
      ## refs.c ##
     @@ refs.c: struct ref_update *ref_transaction_add_update(
    @@ refs.c: struct ref_update *ref_transaction_add_update(
     +	int depth;
     +
     +	for (depth = 0; depth < SYMREF_MAXDEPTH; depth++) {
    -+		struct ref_update *update;
    ++		struct ref_update *update = find_ref_update(transaction, refname);
     +
    -+		update = find_ref_update(transaction, refname);
     +		if (!update)
     +			break;
     +
    @@ refs/refs-internal.h: struct ref_update *ref_transaction_add_update(
      
     +/*
     + * Resolve `refname` to the object ID it will have once `transaction` is
    -+ * committed: if the transaction updates `refname`, use the new value of
    -+ * that update (following `new_target` of symref updates in the
    -+ * transaction), otherwise read it from the ref store. Return 1 and fill
    -+ * `oid` if it resolves to an object, 0 if it would be dangling (missing,
    -+ * or deleted by the transaction). Meant to be used while committing.
    ++ * committed. If the transaction updates `refname`, its new value is used,
    ++ * following symref updates in the transaction; otherwise the ref store is
    ++ * read. Return 1 and fill `oid` if it resolves to an object, 0 if it is
    ++ * missing or deleted by the transaction.
     + */
     +int ref_transaction_resolve_new_oid(struct ref_transaction *transaction,
     +				    const char *refname,
    @@ t/t1400-update-ref.sh: test_expect_success 'stdin delete symref works option no-
     +	for order in branch-first head-first
     +	do
     +		test_expect_success "stdin symref-update HEAD logs target's new value ($action, $order)" '
    -+			test_when_finished "rm -rf repo branch-cmd head-cmd" &&
    ++			test_when_finished "rm -rf repo" &&
     +			git init repo &&
    -+			test_commit -C repo one &&
    -+			test_commit -C repo two &&
    -+			new=$(git -C repo rev-parse two) &&
    -+			if test "$action" = update
    -+			then
    -+				git -C repo branch topic one
    -+			fi &&
    -+			echo "$action refs/heads/topic $new" >branch-cmd &&
    -+			{
    -+				echo "option no-deref" &&
    -+				echo "symref-update HEAD refs/heads/topic"
    -+			} >head-cmd &&
    -+			if test "$order" = branch-first
    -+			then
    -+				cat branch-cmd head-cmd >stdin
    -+			else
    -+				cat head-cmd branch-cmd >stdin
    -+			fi &&
    -+			git -C repo update-ref -m "move HEAD" --stdin <stdin &&
    -+			echo "move HEAD" >expect &&
    -+			git -C repo reflog -1 --format=%gs HEAD >actual &&
    -+			test_cmp expect actual &&
    -+			echo $new >expect &&
    -+			git -C repo reflog -1 --format=%H HEAD >actual &&
    -+			test_cmp expect actual
    ++			(
    ++				cd repo &&
    ++				test_commit one &&
    ++				test_commit two &&
    ++				new=$(git rev-parse two) &&
    ++				if test "$action" = update
    ++				then
    ++					git branch topic one
    ++				fi &&
    ++
    ++				echo "$action refs/heads/topic $new" >branch-cmd &&
    ++				{
    ++					echo "option no-deref" &&
    ++					echo "symref-update HEAD refs/heads/topic"
    ++				} >head-cmd &&
    ++				if test "$order" = branch-first
    ++				then
    ++					cat branch-cmd head-cmd >stdin
    ++				else
    ++					cat head-cmd branch-cmd >stdin
    ++				fi &&
    ++				git update-ref -m "move HEAD" --stdin <stdin &&
    ++
    ++				echo "move HEAD" >expect &&
    ++				git reflog -1 --format=%gs HEAD >actual &&
    ++				test_cmp expect actual &&
    ++				echo $new >expect &&
    ++				git reflog -1 --format=%H HEAD >actual &&
    ++				test_cmp expect actual
    ++			)
     +		'
     +	done
     +done
    ++
    ++test_expect_success 'stdin symref-update logs new value of target updated via HEAD' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init -b a repo &&
    ++	(
    ++		cd repo &&
    ++		test_commit one &&
    ++		test_commit two &&
    ++		new=$(git rev-parse two) &&
    ++		git update-ref refs/heads/a one &&
    ++
    ++		cat >stdin <<-EOF &&
    ++		update HEAD $new
    ++		option no-deref
    ++		symref-update refs/heads/s refs/heads/a
    ++		EOF
    ++		git update-ref -m "move s" --stdin <stdin &&
    ++
    ++		echo "move s" >expect &&
    ++		git reflog -1 --format=%gs refs/heads/s >actual &&
    ++		test_cmp expect actual &&
    ++		echo $new >expect &&
    ++		git reflog -1 --format=%H refs/heads/s >actual &&
    ++		test_cmp expect actual
    ++	)
    ++'
    ++
    ++test_expect_success 'stdin batch-updates symref-update HEAD does not log rejected target value' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++		test_commit one &&
    ++		test_commit two &&
    ++		old=$(git rev-parse one) &&
    ++		new=$(git rev-parse two) &&
    ++		git branch y one &&
    ++
    ++		cat >stdin <<-EOF &&
    ++		update refs/heads/y $new $new
    ++		option no-deref
    ++		symref-update HEAD refs/heads/y
    ++		EOF
    ++		git update-ref -m "move HEAD" --batch-updates --stdin <stdin >stdout &&
    ++
    ++		test_grep "rejected refs/heads/y" stdout &&
    ++		echo $old >expect &&
    ++		git rev-parse refs/heads/y >actual &&
    ++		test_cmp expect actual &&
    ++		echo refs/heads/y >expect &&
    ++		git symbolic-ref HEAD >actual &&
    ++		test_cmp expect actual &&
    ++		echo "move HEAD" >expect &&
    ++		git reflog -1 --format=%gs HEAD >actual &&
    ++		test_cmp expect actual &&
    ++		echo $old >expect &&
    ++		git reflog -1 --format=%H HEAD >actual &&
    ++		test_cmp expect actual
    ++	)
    ++'
     +
      test_expect_success 'stdin update symref works flag --no-deref' '
      	git symbolic-ref TESTSYMREFONE $b &&
-- 
2.54.0 (Apple Git-157)

