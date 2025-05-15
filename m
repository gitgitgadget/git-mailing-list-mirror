Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019151B07AE
	for <git@vger.kernel.org>; Thu, 15 May 2025 14:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747318057; cv=none; b=rtbTT01e4HvLs/bFBqU12wM8EZ5iCFCB+/Vu5p89B2jqMY4adYfeShRBFgNhOjvlhnKVvBTRhVeZ5rqNttg8hqfLdm53OWubhC0Sn7dqobORujSn8PoDV10bJH5FMFOY2gJqQUIG+URegSA/F0Rs3Spf1WX848g2XFSjFZy+O1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747318057; c=relaxed/simple;
	bh=GTvh/f8NBQfgkExNciCcTWFSM9ZvEIUGFc9qwsaNPVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W0jDoHxTCZUIunUzejQblcDXg6na+E1b4wLC9mYpUCOw5d1Qk6VN1KyeKRfEQiuWgymlTki2t3HPNLACLZQLFu34lOKlq/6HavmLSv6n/O7s4jh17yEO3IVLY6XuJcznfnH3Rldpg1l6sRZxLEEpdq9cj8t2ervbj3XCu+972Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kx38I45k; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kx38I45k"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5fc5bc05f99so2018374a12.3
        for <git@vger.kernel.org>; Thu, 15 May 2025 07:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747318053; x=1747922853; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9bP1seM2bQtlPDKvNQe9eVaTH9MnfS+1wfAye2xHaqg=;
        b=kx38I45kkQamF8e5NHhi5hFuJuQMxWl5gaJCG6Eecn6sYQUs/66ktjHpexh50HTrGV
         5dMZluAi7L8qYRUPfrvseJqYT24Q8uVrhLGv47VhX/1hb4Kcc/cpOtYWohU1v+FVRVt0
         TQ/KO3lLM4HJoonQthS/uXLWonWQx1luGEPRAfhSXLk09cocKva6xq8Lt88Sh/uvHUk4
         VwWAaqUiuP0Q9O6WRTCaPey2oTmDaRHbuHCu7jAplaEh9f7uBY1hPa5ehGtNK3lsGaRN
         rZ7pCD95fHT6BSeF8gjF2Fhb0lwQPObwspJhZHNAjXLc+12OemvTBAyvTH586EJTrew1
         XLSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747318053; x=1747922853;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9bP1seM2bQtlPDKvNQe9eVaTH9MnfS+1wfAye2xHaqg=;
        b=xUR6PuEfROMhddlsJ3F6TCYD+1CCqSoGRqQn300MULgTG8k06WSKcpYIlAP3XisyI3
         YJ0KS/hIgFZS0YKWC52GbK5Wx8HNuEFiNDIUAO89cfVSnvveSOfWm7oN05cFz31RbWjv
         a8wcGpUIm2N+bGkylF6DyzMGPOEtH28LY91tK+zcJEKpfvLMNjlx2sM4tds/55NyU6kG
         2e+Qph1evhbYD8fWnhKsNNypkt3cAVHEWGhXS09L9fKC27TL9KyCZaJbMscOcgBJhCRH
         arRi4gDP1w/lkSkK/FKQZesiFQDl9EfGtU8NkzxSCbCvzBm67AghMdcE26eXpL5yh74o
         NpZQ==
X-Gm-Message-State: AOJu0YzNkfD62n0imbVWN5bTGvDLjYH3sHYY3w65l/3VYfFm3xNAJwEE
	5JhlE+8a4k3cM5IDzNWlHq4DDAya/faDnM8zC35cyvhjo+hJLrMw
X-Gm-Gg: ASbGncs1K3Y5SPbZ7JbKRhTNWqoeMls986VBqRwpgx0zhaSLL4WQxvdB0TLQXTlc9Rr
	luMcSil2G9rp7fWwVtuBucVpUuVRCeG2PIy2D3bXgDpRDPZ9j+jRpAFVOfsFZ2uCSWJ9qUNw8qi
	nYjN8kur9g39qPkJITPct3XF2J4RQgmitK4Qpi6bByhRA+Bi1rRtsC8Rr5MJgQUGBWI1wVfjE8n
	iz1vAY2i75uclcYkkinNHR7azxBJfd9JFjOw/gYVzdH1mFwascVA2gpWlaWzMlsBSiuyPwXgQ4h
	3RZtnB0O+BALt8pmGRFCf3rM2WeZmmik3rz90c33QMxvLXuDleA=
X-Google-Smtp-Source: AGHT+IEconh7sRXCMisz7TMdVhgJ1212AgoBEvaBLJFIQ47CZ5e1GHO8N2lqShn/fIiqhOy53svenQ==
X-Received: by 2002:a05:6402:51ca:b0:600:298b:5948 with SMTP id 4fb4d7f45d1cf-600298b7c75mr304476a12.2.1747318051856;
        Thu, 15 May 2025 07:07:31 -0700 (PDT)
Received: from [127.0.0.2] ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d70e296sm10259434a12.75.2025.05.15.07.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 07:07:31 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 15 May 2025 16:07:28 +0200
Subject: [PATCH v2 4/4] receive-pack: use batched reference updates
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250515-501-update-git-fetch-1-to-use-partial-transactions-v2-4-80cbaaa55d2e@gmail.com>
References: <20250515-501-update-git-fetch-1-to-use-partial-transactions-v2-0-80cbaaa55d2e@gmail.com>
In-Reply-To: <20250515-501-update-git-fetch-1-to-use-partial-transactions-v2-0-80cbaaa55d2e@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, toon@iotcl.com, ps@pks.im, 
 gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=10498;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=GTvh/f8NBQfgkExNciCcTWFSM9ZvEIUGFc9qwsaNPVo=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGgl9R89C3krXHzNA3ysb0h4vGksexWFSAclx
 H++1yadWIMiEIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoJfUfAAoJED7VnySO
 Rox/2pML/is1I/l/nFZF2vcj1cctjf0E7Kkn64a/eW7780bOfZICvAk3Ynqq3A87p/v8cWXMM7S
 V65+XCKewF3pjhglGBxYAykD9eGbCNex+xy0IRqO3mlFtJZWuuuKXXjvQMHxZ3MLDrQoqsTt8wA
 YTh7+bMve8MIOnHnNJsG7ogxNhPJUZBNxaCWzguv8qon4UYpn6HCXOuMpG+b17pxaZc+bp6X6zr
 BVhX3/FzRvFHZWXkYCWQzF0rY7OLdyHy9z+nnA30RRFrobEyULPQjrVavNNtAFIqBo/Iqn0N+m0
 bqZI7NsyfozX/WDvGPSADDwENoI6FyA90LJ7vFhUXDeIOebek//jWsKARXpzFXzfuVUjm3L32XJ
 BxmsGwu0zrTXaQlvVen/RFLSmeJZprDGlt3hSD7Y8CzJt5akuuLguDtTu5+SWYzhntkziO/F41B
 dbx2rMWQNYMIO1+fcSCVrxQev1W95XUyEnquWc14wyswIJGJMgu781ZmWbtuLDXoqQ1xLQwVUU6
 Oo=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The reference updates performed as a part of 'git-receive-pack(1)', take
place one at a time. For each reference update, a new transaction is
created and committed. This is necessary to ensure we can allow
individual updates to fail without failing the entire command. The
command also supports an 'atomic' mode, which uses a single transaction
to update all of the references. But this mode has an all-or-nothing
approach, where if a single update fails, all updates would fail.

In 23fc8e4f61 (refs: implement batch reference update support,
2025-04-08), we introduced a new mechanism to batch reference updates.
Under the hood, this uses a single transaction to perform a batch of
reference updates, while allowing only individual updates to fail.
Utilize this newly introduced batch update mechanism in
'git-receive-pack(1)'. This provides a significant bump in performance,
especially when dealing with repositories with large number of
references.

With the reftable backend there is a 18x performance improvement, when
performing receive-pack with 10000 refs:

  Benchmark 1: receive: many refs (refformat = reftable, refcount = 10000, revision = master)
    Time (mean ± σ):      4.276 s ±  0.078 s    [User: 0.796 s, System: 3.318 s]
    Range (min … max):    4.185 s …  4.430 s    10 runs

  Benchmark 2: receive: many refs (refformat = reftable, refcount = 10000, revision = HEAD)
    Time (mean ± σ):     235.4 ms ±   6.9 ms    [User: 75.4 ms, System: 157.3 ms]
    Range (min … max):   228.5 ms … 254.2 ms    11 runs

  Summary
    receive: many refs (refformat = reftable, refcount = 10000, revision = HEAD) ran
     18.16 ± 0.63 times faster than receive: many refs (refformat = reftable, refcount = 10000, revision = master)

In similar conditions, the files backend sees a 1.21x performance
improvement:

  Benchmark 1: receive: many refs (refformat = files, refcount = 10000, revision = master)
    Time (mean ± σ):      1.121 s ±  0.021 s    [User: 0.128 s, System: 0.975 s]
    Range (min … max):    1.097 s …  1.156 s    10 runs

  Benchmark 2: receive: many refs (refformat = files, refcount = 10000, revision = HEAD)
    Time (mean ± σ):     927.9 ms ±  22.6 ms    [User: 99.0 ms, System: 815.2 ms]
    Range (min … max):   903.1 ms … 978.0 ms    10 runs

  Summary
    receive: many refs (refformat = files, refcount = 10000, revision = HEAD) ran
      1.21 ± 0.04 times faster than receive: many refs (refformat = files, refcount = 10000, revision = master)

As using batched updates requires the error handling to be moved to the
end of the flow, create and use a 'struct strset' to track the failed
refs and attribute the correct errors to them.

This change also uncovers an issue when a client provides multiple
updates to the same reference. For example:

  $ git send-pack remote.git A:foo B:foo
  Enumerating objects: 3, done.
  Counting objects: 100% (3/3), done.
  Delta compression using up to 20 threads
  Compressing objects: 100% (2/2), done.
  Writing objects: 100% (3/3), 226 bytes | 226.00 KiB/s, done.
  Total 3 (delta 1), reused 0 (delta 0), pack-reused 0 (from 0)
  remote: error: cannot lock ref 'refs/heads/foo': reference already exists
  To remote.git
   ! [remote rejected] A -> foo (failed to update ref)
   ! [remote failure]  B -> foo (remote failed to report status)

As you can see, the remote runs into an error because it cannot lock the
target reference for the second update. Furthermore, the remote complains
that the first update has been rejected whereas the second update didn't
receive any status update because we failed to lock it. Reading this status
message alone a user would probably expect that `foo` has not been updated
at all. But that's not the case: while we claim that the ref wasn't updated,
it surprisingly points to `A` now.

One could argue that this is merely an error in how we report the result of
this push. But ultimately, the user's request itself is already broken and
doesn't make any sense in the first place and cannot ever lead to a sensible
outcome that honors the full request.

The conversion to batched transactions fixes the issue because we now try to
queue both updates in the same transaction. As such, the transaction itself
will notice this conflict and refuse the update altogether before we commit
any of the values.

Note that this requires changes to a couple of tests in t5408 that happened
to exercise this behaviour. Given that the generated output is misleading
and given that the user request cannot ever be fully honored this really
feels more like a bug than properly designed behaviour. As such, changing
the behaviour feels like the right thing to do.

Since now reference updates are batched, the 'reference-transaction'
hook will be invoked with all updates together. Currently git will 'die'
when the hook returns with a non-zero exit status in the 'prepared'
stage. For 'git-receive-pack(1)', this allowed users to reject an
individual reference update, git would have applied previous updates but
immediately abort further execution. This is definitely an incorrect
usage of this hook, since the right place to do this would be the
'update' hook. This patch retains the latter behavior, but
'reference-transaction' hook now changes to a all-or-nothing behavior
when a non-zero exit status is returned in the 'prepared' stage, since
batch updates use a transaction under the hood. This explains the change
in 't1416'.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/receive-pack.c           | 64 ++++++++++++++++++++++++++++++----------
 t/t1416-ref-transaction-hooks.sh |  2 --
 t/t5408-send-pack-stdin.sh       | 12 ++++----
 3 files changed, 55 insertions(+), 23 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index be314879e8..4c47d6d444 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1843,35 +1843,67 @@ static void BUG_if_skipped_connectivity_check(struct command *commands,
 	BUG_if_bug("connectivity check skipped???");
 }
 
+static void ref_transaction_rejection_handler(const char *refname,
+					      const struct object_id *old_oid UNUSED,
+					      const struct object_id *new_oid UNUSED,
+					      const char *old_target UNUSED,
+					      const char *new_target UNUSED,
+					      enum ref_transaction_error err,
+					      void *cb_data)
+{
+	struct strmap *failed_refs = cb_data;
+
+	strmap_put(failed_refs, refname, ref_transaction_error_msg(err));
+}
+
 static void execute_commands_non_atomic(struct command *commands,
 					struct shallow_info *si)
 {
 	struct command *cmd;
 	struct strbuf err = STRBUF_INIT;
+	const char *reported_error = NULL;
+	struct strmap failed_refs = STRMAP_INIT;
+
+	transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
+						  REF_TRANSACTION_ALLOW_FAILURE, &err);
+	if (!transaction) {
+		rp_error("%s", err.buf);
+		strbuf_reset(&err);
+		reported_error = "transaction failed to start";
+		goto failure;
+	}
 
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		if (!should_process_cmd(cmd) || cmd->run_proc_receive)
 			continue;
 
-		transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
-							  0, &err);
-		if (!transaction) {
-			rp_error("%s", err.buf);
-			strbuf_reset(&err);
-			cmd->error_string = "transaction failed to start";
-			continue;
-		}
-
 		cmd->error_string = update(cmd, si);
+	}
 
-		if (!cmd->error_string
-		    && ref_transaction_commit(transaction, &err)) {
-			rp_error("%s", err.buf);
-			strbuf_reset(&err);
-			cmd->error_string = "failed to update ref";
-		}
-		ref_transaction_free(transaction);
+	if (ref_transaction_commit(transaction, &err)) {
+		rp_error("%s", err.buf);
+		reported_error = "failed to update refs";
+		goto failure;
+	}
+
+	ref_transaction_for_each_rejected_update(transaction,
+						 ref_transaction_rejection_handler,
+						 &failed_refs);
+
+	if (strmap_empty(&failed_refs))
+		goto cleanup;
+
+failure:
+	for (cmd = commands; cmd; cmd = cmd->next) {
+		if (reported_error)
+			cmd->error_string = reported_error;
+		else if (strmap_contains(&failed_refs, cmd->ref_name))
+			cmd->error_string = xstrdup(strmap_get(&failed_refs, cmd->ref_name));
 	}
+
+cleanup:
+	ref_transaction_free(transaction);
+	strmap_clear(&failed_refs, 1);
 	strbuf_release(&err);
 }
 
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index 8c777f7cf8..d91dd3a3b5 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -120,8 +120,6 @@ test_expect_success 'interleaving hook calls succeed' '
 
 	cat >expect <<-EOF &&
 		hooks/update refs/tags/PRE $ZERO_OID $PRE_OID
-		hooks/reference-transaction prepared
-		hooks/reference-transaction committed
 		hooks/update refs/tags/POST $ZERO_OID $POST_OID
 		hooks/reference-transaction prepared
 		hooks/reference-transaction committed
diff --git a/t/t5408-send-pack-stdin.sh b/t/t5408-send-pack-stdin.sh
index 45fb20179b..76fb8bbc68 100755
--- a/t/t5408-send-pack-stdin.sh
+++ b/t/t5408-send-pack-stdin.sh
@@ -69,21 +69,23 @@ test_expect_success 'stdin mixed with cmdline' '
 
 test_expect_success 'cmdline refs written in order' '
 	clear_remote &&
-	test_must_fail git send-pack remote.git A:foo B:foo &&
-	verify_push A foo
+	test_must_fail git send-pack remote.git A:foo B:foo 2>err &&
+	test_grep "multiple updates for ref ${SQ}refs/heads/foo${SQ} not allowed" err &&
+	test_must_fail git --git-dir=remote.git rev-parse foo
 '
 
 test_expect_success 'cmdline refs with multiple duplicates' '
 	clear_remote &&
-	test_must_fail git send-pack remote.git A:foo B:foo C:foo &&
-	verify_push A foo
+	test_must_fail git send-pack remote.git A:foo B:foo C:foo 2>err &&
+	test_grep "multiple updates for ref ${SQ}refs/heads/foo${SQ} not allowed" err &&
+	test_must_fail git --git-dir=remote.git rev-parse foo
 '
 
 test_expect_success '--stdin refs come after cmdline' '
 	clear_remote &&
 	echo A:foo >input &&
 	test_must_fail git send-pack remote.git --stdin B:foo <input &&
-	verify_push B foo
+	test_must_fail git --git-dir=remote.git rev-parse foo
 '
 
 test_expect_success 'refspecs and --mirror do not mix (cmdline)' '

-- 
2.49.0

