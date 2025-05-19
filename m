Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5791A83F8
	for <git@vger.kernel.org>; Mon, 19 May 2025 09:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747648702; cv=none; b=SErl+8D8iB7PGv5JNiporRWIIPMWX1loek69+DpOLT7mPBD1djikQjNNMbpXY+ovpDQOJvLNM49SNv85ZYxlIXd0aRGE4tyX6pq4TFgow+FbQrfFqXndhq04IerG+0lI+uQxju4shTavTPsqKnRxSJI+2Rz2nKnBlhsjd++w/iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747648702; c=relaxed/simple;
	bh=JUCJf/7Auzqqzr7Ko9cw4TUVTg50QlOv0Y+kU0XwBxo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NuKbAwsMpT5PmG+akZpKxzY9MFHRuBPqxpht80Fw4Ebjdy5Jj78hy8SkvG4v6ZMkIzKbWMjMFzogrfCnhjI/xXntEuTOmnrZT/Wh6KWKPcgCKOwQhhiKWMh+W30rkj8nTsPtXKHlf7YQEzH8b2B1hOE/Br2e/F5wp9XDndONROY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcpcUILV; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcpcUILV"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so45643295e9.1
        for <git@vger.kernel.org>; Mon, 19 May 2025 02:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747648699; x=1748253499; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ivvOtbozsJhrddDwe+xfrP4UGJkA0GQ+HGkj70EVFFw=;
        b=hcpcUILVubNHE4g5KOSzw93DUbE+O/dNlz0RLXycT4ThoqXOHaNxfdxP4Thl84GIZl
         3Kk791M5r6EuRkT4PoOYPPmXde261WWib7WJgYocwnmSX0T+vsZbVVsFivZR2k/sw14z
         ktMyBjaJX4MM9SN3JpRitlw8H9qmXxOtQSDo+SSsr6Tfu0IJu10QE/R3OClXhwJPq8iY
         /7nrrmS6ZuTrRmjVUyKjCmfqVXPKY5eePfeNXVLHlDaqa/Gx4aw5klMZm1sTrSmISnX7
         Ez3FpqaRrGLuGBby8d+VVfOZTmqFNGJB4TxyEyjOzm+1qvOpW9AIFWZ3vKp4UWuCehjO
         RMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747648699; x=1748253499;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ivvOtbozsJhrddDwe+xfrP4UGJkA0GQ+HGkj70EVFFw=;
        b=xKvNGqTzpQoMapdHyct7gX5qJaHZNKB0dfuDF426eUwtrk/P/QSFJJCmJg5xq+Lro0
         Z1EU8cc29g21GNOCT8yIY/DS2EEtzOxoi9YcXMPWA/rUnrAYByHxWQJctNgDKNBd+IXd
         UGXECo0ozrUgA6jIYtgBj6l12uq4YBKT3L28PIWHL2L76HhRo0rGVkcFXRtBhp5M0D4y
         AoSrJG3EkCSKFfTReiCOioBTZEh+XtjrLFPoaKNTzz/7x6WRf89irNnHV+DFAQDa14bw
         w4wGgXiOzKG8LFQLhFbH+3FEkj5F0WSonuuS5ny0tlLxZ6dA2ICGbWIuBz4dZ+xRo1UP
         iXTQ==
X-Gm-Message-State: AOJu0YwM7RYBAiunivjmbT+hF7pjVejH1JTy9eS3z0Lo0wKY4527z9iL
	Bm6AYDGK7HikyQ7kPzfTtrgJ0yS8e9a7h9601PbfET/il2c7XSzFAH0c
X-Gm-Gg: ASbGnctSi5guX/JRzpCj/BYW70lEzxFCMVXHCCHbQbOdkQCDAca1PHPrn6GRRpagNNR
	tDGnMIduYZSe/CNF+fbvS1alBcguGBrbVuYswaWRU5osya9uUPLtq0BbXrne9ag/55eHhN9JwhL
	ZJUOMz2ZG9Fd/NYZaZF4k78OtkifVGxhWyn3wewqgBGQKSsur3WAIDlVoqsV7M+bVqrXjpMf5m9
	/EChb8bP7dXB325SRWZqIvh7vkiZJ+R8RjcIPJkaPpuWSHWbCi4wQjh4NlAx68DcHaUjzJixna/
	wBxmCafwOExPZUc6qXWGiPvPphb3CqQu2xA=
X-Google-Smtp-Source: AGHT+IFVp3oHhyLh0HcuQZu5lp0sI/SsguAayTz5tWuIh9PNYU8KpvkdsvhUE6ipHyC+sbTPjALWsA==
X-Received: by 2002:a05:600c:1d07:b0:43c:e70d:450c with SMTP id 5b1f17b1804b1-442fd664797mr74593295e9.22.1747648698696;
        Mon, 19 May 2025 02:58:18 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:b2fc:6161:a86b:8382])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fa3e2ce5sm152811285e9.13.2025.05.19.02.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 02:58:18 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 19 May 2025 11:58:09 +0200
Subject: [PATCH v3 4/4] receive-pack: use batched reference updates
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250519-501-update-git-fetch-1-to-use-partial-transactions-v3-4-6cdfd4f769b9@gmail.com>
References: <20250519-501-update-git-fetch-1-to-use-partial-transactions-v3-0-6cdfd4f769b9@gmail.com>
In-Reply-To: <20250519-501-update-git-fetch-1-to-use-partial-transactions-v3-0-6cdfd4f769b9@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
 gitster@pobox.com, peff@peff.net
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=10619;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=JUCJf/7Auzqqzr7Ko9cw4TUVTg50QlOv0Y+kU0XwBxo=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGgrALVw8V8jfpMJZEG8oKqQIYmA/OKPbU5tF
 DdoPHn+PBhof4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoKwC1AAoJED7VnySO
 Rox/ETgL/0DxGa3JQev5Y1Cwa1IsC/puvah27fmBtrHScGmelNSwNEXP4vyApUxoST7Ad6FTNMi
 lnxS3q5a4R5P6Rvw9wBzL7zNd03L/6Ua7S042WoCGH//rZBw3cDoF5WEThzzaKQ5tVjpK846uE+
 ZgcYrtt6MXwPkHOIhUEMJG7sGzuvCYU1KW4XosvM5OawgSnbbfAe2aO+vwGkhl/wtL8ExuMpUmn
 kOo9XJe+QSUuPSm8QqpJ7rmS0JQhF8tvIWb4VtyKRMYqcSlTynSHnlhS5NmkbJTblUAnpuKy1kQ
 /6VpU6FkT3fkEdbnB6gu/m004zTIFMqHAmcmzaBxfZ7EU3RwxoZ6UbB+hh9VRTpScfMJ3tbAZYX
 P6f/GW4UE1wirtuuJrM/RWhIpFWRNuowF0jzriJFIrBG9oCuS0gK6vMdrhXYa/RrJxgtJeIPNNh
 K4IB6FJRgwXcq0PK3mlttmDz9xM7leo6BUV4ajmChya1Tbob7f8mzsJjz0ZikRH5bXQsGFAE0d5
 t8=
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

Helped-by: Jeff King <peff@peff.net>
Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/receive-pack.c           | 64 ++++++++++++++++++++++++++++++----------
 t/t1416-ref-transaction-hooks.sh |  2 --
 t/t5408-send-pack-stdin.sh       | 13 ++++----
 3 files changed, 56 insertions(+), 23 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index be314879e8..2a302c836f 100644
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
+	strmap_put(failed_refs, refname, (char *)ref_transaction_error_msg(err));
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
+			cmd->error_string = strmap_get(&failed_refs, cmd->ref_name);
 	}
+
+cleanup:
+	ref_transaction_free(transaction);
+	strmap_clear(&failed_refs, 0);
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
index 45fb20179b..ec339761c2 100755
--- a/t/t5408-send-pack-stdin.sh
+++ b/t/t5408-send-pack-stdin.sh
@@ -69,21 +69,24 @@ test_expect_success 'stdin mixed with cmdline' '
 
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
+	test_grep "multiple updates for ref ${SQ}refs/heads/foo${SQ} not allowed" err &&
+	test_must_fail git --git-dir=remote.git rev-parse foo
 '
 
 test_expect_success 'refspecs and --mirror do not mix (cmdline)' '

-- 
2.49.0

