Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05BD22331B
	for <git@vger.kernel.org>; Wed, 14 May 2025 09:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747213442; cv=none; b=Rx/2o4uTbHTSyVgwTGWVtL7FR35E91hqH5n8DHrOA5NVdo0yhDsj/HcQY58mnGe5wnoMc52nB8qpa0AqRPdFbbvHhK7Rw3RVFCtjzbGbBK2ZcsjsjVMqcUFOCOz8qjxeczJ1Dxg1CvRemqlTaO1CMM4eZKMav5T7CvQJAs31254=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747213442; c=relaxed/simple;
	bh=Ly1ek5b8bKo3Up2S4r15MPDyaN3MmHKgsWJwHL9ESVY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nqaj6kxcFJagoOqtCrVAM1PKpmB1Syu3W9nByFSyjcgSYpCeIP2kdzC/rN+vx3jQCvzUNauxz31gYKyhjL9t5deKAMKb7y9t3xfoEYJvxgW1uqSNMPsvOMOGfOkVKPFvwosYC/phGX0OpYZZVg9ReHUkyZLck/il8ByAgiBXiHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CK3AR7yY; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CK3AR7yY"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a1d8c09674so3714769f8f.1
        for <git@vger.kernel.org>; Wed, 14 May 2025 02:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747213439; x=1747818239; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2gnVQFMs2uqIHvi0HNrocg1VqM5Z6xkdleocIgClakM=;
        b=CK3AR7yYpH9/LAkPHhtgINN/DWnOCfmoRSLok0BGykIfREwG4/VE+Nn4kQcvhOm1VC
         CFGJoZuOyTD/t7211cgtvGmG+SPvQTaGPbMFNhzboSUrVccamkeZRI0C3vU/DREUWwHZ
         2ytP/9ffIS/lVKEU3Sbd5ZtggtkipBhXIv0XPn9xyzmd0ebQyK8QiyHeHUUv4Om/2uVG
         vm2px7iX/fKolZV5vSC99qajuoIWHOMh9rjjCzsXrCto4KRcybDU1bjB2wpwO8pR7Uiz
         C0CF6oQN3DuQxw3RofIgyvGwCAC1Z6NhKS1APKd5EiVzxQJULLHplonLeOxFTmU0jS0M
         XLYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747213439; x=1747818239;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2gnVQFMs2uqIHvi0HNrocg1VqM5Z6xkdleocIgClakM=;
        b=KqqY/ldoef0nlwSOil/m4pqi1nMgIT0VKPuYrEFVplwtLeuFdRaRRrMchl4jlOtBTm
         tODCqperf0TF1dCG2kI07ael7aoRVybiW1cJYKbYnnQV3eprk/Q6LmBcEbsIknen9jZD
         ITlKbeloX1kqxfA86Z4XtcTpc5h915swGoBU8PiFthPRLiTY9NdZ4+sa38SgPGXP2Sqe
         g0yeuVLEysHwRNWpZmzSxwxcAzOv/KcWMqD1Dzpi1lM8B7dMXFQ858PacZxywvcAqzsk
         RB3eJ3mtIM7fnZdk7zndS/H7LF3uaw9xide2fzSNyIhI9QrfkpZeS2YSs/TZ03koz+Lh
         JFMA==
X-Gm-Message-State: AOJu0Yzct+tyhIo2squoRBld4bSOIpz6P291QF2oiUNatIQkFmKO1/yW
	3kX1naFMlFKbcxa/4iERlCU0vz+Hs5ISJQzqpSCRJRLKB7RZ4Nzz55D3yWAF
X-Gm-Gg: ASbGnct+xNKJ0qArj5hnBmM8atrWhrpJPex2b9M3QKSQgrHl9ive9UO61DxSLW6ACR8
	ckZHDknyGw1sB3pk6goBpXyA7RhOpXRh/y8dxfeGbkIVjHYcN/d3cmzA7CQDy4RHeSwyU21vKf2
	y2yW0CTGS54Kvkqp7yyZs0KzmBINsYGPixHStq0dy/ltkzdBm2u0i/mAP8xYVVVSg66nPsxXNc7
	dbTYwuHE6HN6sCVtF4NCbAeOoF/bgsw9Txgcv/pvfZuhe03E/eOzgztA/lYXESy/JjzwQmNhy+B
	I0yKOz9Bygu+/sCQKaDVTEkOrVGcqT0s02zaXff2cjd83NB2yNe0RRNLMJRwyW3iijI7
X-Google-Smtp-Source: AGHT+IFpbySqRvBagye1fIXqF1Y4dCnuCbQNsjW8ch3YIAnGRFxaPtdDZTuxEJFJNDTXMDIv7zsw4g==
X-Received: by 2002:a05:6000:430b:b0:39e:cbc7:ad38 with SMTP id ffacd0b85a97d-3a3496c28cemr1867276f8f.32.1747213438732;
        Wed, 14 May 2025 02:03:58 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:768c:74a5:aa9f:b39e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a4c5b9sm19084461f8f.91.2025.05.14.02.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 02:03:58 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 14 May 2025 11:03:49 +0200
Subject: [PATCH 3/3] receive-pack: use batched reference updates
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250514-501-update-git-fetch-1-to-use-partial-transactions-v1-3-7c65f46493d4@gmail.com>
References: <20250514-501-update-git-fetch-1-to-use-partial-transactions-v1-0-7c65f46493d4@gmail.com>
In-Reply-To: <20250514-501-update-git-fetch-1-to-use-partial-transactions-v1-0-7c65f46493d4@gmail.com>
To: git@vger.kernel.org
Cc: toon@iotcl.com, ps@pks.im, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=11168;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=Ly1ek5b8bKo3Up2S4r15MPDyaN3MmHKgsWJwHL9ESVY=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGgkXHsmAf5h5uQnUl5g1sFswwKm+aBr6wQV1
 LWm0/gTygZu/YkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoJFx7AAoJED7VnySO
 Rox/3iUL/j2TQ28T1N7W76MpjcbXQ77J+ZQhR+xb8UEiOEDH0v6R0ZpQZOgciwu1f3dnq4akB4O
 zWlMjtQWhN5MeW4cdmWls+FZ1QDW1VTold4G5DzX3WzBN9Qeo4dRrZd8tzvmEE0a9Q1ra2ZsLDh
 EwNJyPhvDfmQFRgT/XKYks9qUVIJFjcLKws7Gkv1m00LyPan1t1ADpUCbGLv0w8z5Ob+pCIWtHD
 cYp3ed4mO7/bOg+wlpH6yrxkfDGGKpdWjZl1ihfHMDqoc5ikgajxNa7xZuBQ/SDWyy6FbyGtgKv
 4tL2Rs8T4ZYcJI8MLS4ng8D87SzOewRvPZGuCt6RfpazNTa1wsHtOIBmMzC0nW0uMCznv/u10Ko
 QqQyerRMb3wB3y61zKHJCF7+Kv7cUCvqd397j3PVjB7p1gfHir2Q9B36bMTFneMHCHFTZWHpCXT
 4OPZ71zNdQ8SfbTLuLcuGw3/EtpO/uPI6Oas94UsEsck9oju+ramB5p+PEEJ4TYJydbAAA8LvS7
 QY=
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

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/receive-pack.c           | 88 ++++++++++++++++++++++++++++++++--------
 t/t1416-ref-transaction-hooks.sh |  2 -
 t/t5408-send-pack-stdin.sh       | 12 +++---
 3 files changed, 79 insertions(+), 23 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index be314879e8..b4fceb3837 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1843,35 +1843,91 @@ static void BUG_if_skipped_connectivity_check(struct command *commands,
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
+	struct strmap *failed_refs = (struct strmap *)cb_data;
+	const char *reason = "";
+
+	switch (err) {
+	case REF_TRANSACTION_ERROR_NAME_CONFLICT:
+		reason = "refname conflict";
+		break;
+	case REF_TRANSACTION_ERROR_CREATE_EXISTS:
+		reason = "reference already exists";
+		break;
+	case REF_TRANSACTION_ERROR_NONEXISTENT_REF:
+		reason = "reference does not exist";
+		break;
+	case REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE:
+		reason = "incorrect old value provided";
+		break;
+	case REF_TRANSACTION_ERROR_INVALID_NEW_VALUE:
+		reason = "invalid new value provided";
+		break;
+	case REF_TRANSACTION_ERROR_EXPECTED_SYMREF:
+		reason = "expected symref but found regular ref";
+		break;
+	default:
+		reason = "unkown failure";
+	}
+
+	strmap_put(failed_refs, refname, xstrdup(reason));
+}
+
 static void execute_commands_non_atomic(struct command *commands,
 					struct shallow_info *si)
 {
 	struct command *cmd;
 	struct strbuf err = STRBUF_INIT;
+	const char *reported_error = "";
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
 	}
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
+		if (strmap_empty(&failed_refs))
+			cmd->error_string = reported_error;
+		else if (strmap_contains(&failed_refs, cmd->ref_name))
+			cmd->error_string = xstrdup(strmap_get(&failed_refs, cmd->ref_name));
+	}
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

