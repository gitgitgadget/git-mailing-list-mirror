Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402A1339875
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 04:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773636680; cv=none; b=Jzz8yrgIeiPq5RJWyMPQToaqs3RfmixpifUkHFutjaYvl3VIjwb+ti4DAQ3kKqYfIpeFgqcspEn8ZpUPUIszjyvUrpAS++mo+6AiXe4rqFY1EOdUEoSIngvgGen/d5sg01KhkG4oKYAwYvakBWGQ97D6z19Nsd80am9YsUDbO4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773636680; c=relaxed/simple;
	bh=wTa9EBJj1TTN5nOOXINj0He2iLn3q5jmutu7PlfIbHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K4CqIe7mT9xZx/z8m6llVL+jmICybW/qaUmBuPqmFBikocU6LcKbRy/OG3jGVtqOwK7KbgxFqS1OFxbhnAfMQndUPqpec3TB8LXEy/8XVdzbnw6IYWBwOseFvFxub2QEbu+A3vcLi9QTxNM6j8hp+J4y/XOOATK1Be9hXELyw+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8sn1q5H; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8sn1q5H"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cd8a189f44so431260185a.0
        for <git@vger.kernel.org>; Sun, 15 Mar 2026 21:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773636678; x=1774241478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ar9rhJlcsQaxbnLE84a2ObhyMUQrS43nOXiDPFufpmU=;
        b=R8sn1q5HRk1IEM3Ggbn/7cjF08l039O5hC/6Fi15U7i2rDgCad3ewdZHf8gbqYUnYQ
         UrekGL2nLl/4OIWh38aA4smImvj5VwRk6z6lzZSiPfHfrq2q89aknqvqANshIYYF2pk3
         3xHtlgXQDKSZikNP2/7XYi8sIZd8pakS3/2/wtBKuT6ptKmpFYL2xTtlRXffun0Tbx3n
         WdxxaYIscevHn2/tE1cMWNtPiSf+C3lzmLtf0oZu4xe4qaecuJ/NP7k/VW0a+R8m0Gne
         DSekD/Lgn79t+nh/Nbakjz2aecTFz0iRBIfXk7J7TIR0qssqxIRRmZxZAp1wWaCW1/f0
         Awwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773636678; x=1774241478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ar9rhJlcsQaxbnLE84a2ObhyMUQrS43nOXiDPFufpmU=;
        b=dGhfQvyIcV+R7J0knatb8CVaNhM5aLl5ZTZ7tvIVaVz72G1WlmvGOLmzl5jJmS9ZOU
         ru6KwF02EHzx6GiooqL7etah7SGYK0aRi+XeN7pmmrixyUwc/0CA+FzRK8C2S8iggqWV
         BuVDIO59w8S9tPGZxXNF6kqOOHYCKH8CBQh7ymH3Tt3XoX6ozyMRnaNiNVO25sbBXXrI
         5UU7s2YnZLV+KsxlKo5b7HP58T/BMD3QREXutaWZO4URBgr376q89QWSJdVygI30ZH4R
         qDmYDJj6EFBjOgJfKvI7n640Cltlv2U/33SuynSL/AfdNejsZIWF+Cp5CC7p4jS7otq+
         hsPg==
X-Gm-Message-State: AOJu0Yw8iL/SX7FmoQpsGi3a9rZTRSI6/ot6cLl5cv3Z+I/HpXB1piOc
	ZLoJmbieOmSfGBAhacMR/vx/EpuladS8Wtb6O9bzgW0WU/STu2PrN//Y5el5Yjl3
X-Gm-Gg: ATEYQzzYPrK2xZnlUmLz/xqxKzJpGD7r2g05xFtSvbZmBSQZ4wezVVCCVl4FKmyM6aV
	Z2Tk3+hGiZqdGyNFR41sNIUtRFH1bdBt/JZyUmboj64RIoHW5C052S44o45sYsilR4PJEKidMiq
	hyld2XAvEQ1PBbm04goqFBtSYh6tPv0/ljw4wE0UcoI834pvbG7eMMQtpmHSBNf4FE/gAhcoNMD
	RPJ9oHB+WkaY6nY8FajlUWI7m930do+AZXO7ba0tw/mBb9803KbfeWsF+/jSnLpZsZnL/90qQQJ
	fDfz1S82TXVHmHAyVyo028z3gQgwAuczqq/TLjdhbowdnzlo8LLR90XuwRAWXbqSeA7+ojaoKbF
	IR+N1EM/MxtmFjPb82TVEOI5IyD0O6MxiIlP+orUMv6Id2nLQ8aWvupb09maSPE5LMBunXpQKUm
	Z7d4su98srTq/gY8yyE9pp2RMWJRjsEmPMJXiqZJ8/j5KG059tIg==
X-Received: by 2002:a05:620a:40d0:b0:8cd:8f18:d1d3 with SMTP id af79cd13be357-8cdb5b65d4fmr1531322685a.58.1773636677842;
        Sun, 15 Mar 2026 21:51:17 -0700 (PDT)
Received: from eju--20230906-5R2TJ ([74.15.89.125])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda210daa1sm1147606385a.26.2026.03.15.21.51.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Mar 2026 21:51:17 -0700 (PDT)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	jltobler@gmail.com,
	eric.peijian@gmail.com,
	ericju711@gmail.com,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 1/1] refs: add 'preparing' phase to the reference-transaction hook
Date: Mon, 16 Mar 2026 00:51:02 -0400
Message-ID: <20260316045102.70551-2-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260316045102.70551-1-eric.peijian@gmail.com>
References: <20260313193537.62827-1-eric.peijian@gmail.com>
 <20260316045102.70551-1-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "reference-transaction" hook is invoked multiple times during a ref
transaction. Each invocation corresponds to a different phase:

- The "prepared" phase indicates that references have been locked.
- The "committed" phase indicates that all updates have been written to disk.
- The "aborted" phase indicates that the transaction has been aborted and that
  all changes have been rolled back.

This hook can be used to learn about the updates that Git wants to perform.
For example, forges use it to coordinate reference updates across multiple
nodes.

However, the phases are insufficient for some specific use cases. The earliest
observable phase in the "reference-transaction" hook is "prepared", at which
point Git has already taken exclusive locks on every affected reference. This
makes it suitable for last-chance validation, but not for serialization. So by
the time a hook sees the "prepared" phase, it has no way to defer locking, and
thus it cannot rearrange multiple concurrent ref transactions relative to one
another.

Introduce a new "preparing" phase that runs before the "prepared" phase, that
is before Git acquires any reference lock on disk. This gives callers a
well-defined window to perform validation, enable higher-level ordering of
concurrent transactions, or reject the transaction entirely, all without
interfering with the locking state.

This change is strictly speaking not backwards compatible. Existing hook
scripts that do not know how to handle unknown phases may treat
'preparing' as an error and return non-zero.
But the hook is considered to expose internal implementation details
of how Git works, and as such we have been a bit more lenient with changing its
exact semantics, like for example in a8ae923f85 (refs: support symrefs in
'reference-transaction' hook, 2024-05-07).

An alternative would be to introduce a "reference-transaction-v2" hook that
knows about the new phase. This feels like a rather heavy-weight option though,
and was thus discarded.

Helped-by: Patrick Steinhardt <ps@pks.im>
Helped-by: Justin Tobler <jltobler@gmail.com>
Helped-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: Eric Ju <eric.peijian@gmail.com>
---
 Documentation/githooks.adoc      | 19 ++++++++++++-------
 refs.c                           |  9 ++++++++-
 t/t1416-ref-transaction-hooks.sh | 30 ++++++++++++++++++++++++++----
 t/t5510-fetch.sh                 |  7 ++++++-
 4 files changed, 52 insertions(+), 13 deletions(-)

diff --git a/Documentation/githooks.adoc b/Documentation/githooks.adoc
index 056553788d..ed045940d1 100644
--- a/Documentation/githooks.adoc
+++ b/Documentation/githooks.adoc
@@ -484,13 +484,16 @@ reference-transaction
 ~~~~~~~~~~~~~~~~~~~~~
 
 This hook is invoked by any Git command that performs reference
-updates. It executes whenever a reference transaction is prepared,
-committed or aborted and may thus get called multiple times. The hook
-also supports symbolic reference updates.
+updates. It executes whenever a reference transaction is preparing,
+prepared, committed or aborted and may thus get called multiple times.
+The hook also supports symbolic reference updates.
 
 The hook takes exactly one argument, which is the current state the
 given reference transaction is in:
 
+    - "preparing": All reference updates have been queued to the
+      transaction but references are not yet locked on disk.
+
     - "prepared": All reference updates have been queued to the
       transaction and references were locked on disk.
 
@@ -511,16 +514,18 @@ ref and `<ref-name>` is the full name of the ref. When force updating
 the reference regardless of its current value or when the reference is
 to be created anew, `<old-value>` is the all-zeroes object name. To
 distinguish these cases, you can inspect the current value of
-`<ref-name>` via `git rev-parse`.
+`<ref-name>` via `git rev-parse`. During the "preparing" state, symbolic
+references are not resolved: `<ref-name>` will reflect the symbolic reference
+itself rather than the object it points to.
 
 For symbolic reference updates the `<old_value>` and `<new-value>`
 fields could denote references instead of objects. A reference will be
 denoted with a 'ref:' prefix, like `ref:<ref-target>`.
 
 The exit status of the hook is ignored for any state except for the
-"prepared" state. In the "prepared" state, a non-zero exit status will
-cause the transaction to be aborted. The hook will not be called with
-"aborted" state in that case.
+"preparing" and "prepared" states. In these states, a non-zero exit
+status will cause the transaction to be aborted. The hook will not be
+called with "aborted" state in that case.
 
 push-to-checkout
 ~~~~~~~~~~~~~~~~
diff --git a/refs.c b/refs.c
index 6fb8f9d10c..7da37bbb71 100644
--- a/refs.c
+++ b/refs.c
@@ -2655,6 +2655,13 @@ int ref_transaction_prepare(struct ref_transaction *transaction,
 	if (ref_update_reject_duplicates(&transaction->refnames, err))
 		return REF_TRANSACTION_ERROR_GENERIC;
 
+	/* Preparing checks before locking references */
+	ret = run_transaction_hook(transaction, "preparing");
+	if (ret) {
+		ref_transaction_abort(transaction, err);
+		die(_("ref updates aborted by the reference-transaction hook at its %s state"), "preparing");
+	}
+
 	ret = refs->be->transaction_prepare(refs, transaction, err);
 	if (ret)
 		return ret;
@@ -2662,7 +2669,7 @@ int ref_transaction_prepare(struct ref_transaction *transaction,
 	ret = run_transaction_hook(transaction, "prepared");
 	if (ret) {
 		ref_transaction_abort(transaction, err);
-		die(_("ref updates aborted by hook"));
+		die(_("ref updates aborted by the reference-transaction hook at its %s state"), "prepared");
 	}
 
 	return 0;
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index d91dd3a3b5..c3b1a3c735 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -20,6 +20,7 @@ test_expect_success 'hook allows updating ref if successful' '
 		echo "$*" >>actual
 	EOF
 	cat >expect <<-EOF &&
+		preparing
 		prepared
 		committed
 	EOF
@@ -27,6 +28,18 @@ test_expect_success 'hook allows updating ref if successful' '
 	test_cmp expect actual
 '
 
+test_expect_success 'hook aborts updating ref in preparing state' '
+	git reset --hard PRE &&
+	test_hook reference-transaction <<-\EOF &&
+		if test "$1" = preparing
+		then
+			exit 1
+		fi
+	EOF
+	test_must_fail git update-ref HEAD POST 2>err &&
+	test_grep "ref updates aborted by the reference-transaction hook at its preparing state" err
+'
+
 test_expect_success 'hook aborts updating ref in prepared state' '
 	git reset --hard PRE &&
 	test_hook reference-transaction <<-\EOF &&
@@ -36,7 +49,7 @@ test_expect_success 'hook aborts updating ref in prepared state' '
 		fi
 	EOF
 	test_must_fail git update-ref HEAD POST 2>err &&
-	test_grep "ref updates aborted by hook" err
+	test_grep "ref updates aborted by the reference-transaction hook at its prepared state" err
 '
 
 test_expect_success 'hook gets all queued updates in prepared state' '
@@ -121,6 +134,7 @@ test_expect_success 'interleaving hook calls succeed' '
 	cat >expect <<-EOF &&
 		hooks/update refs/tags/PRE $ZERO_OID $PRE_OID
 		hooks/update refs/tags/POST $ZERO_OID $POST_OID
+		hooks/reference-transaction preparing
 		hooks/reference-transaction prepared
 		hooks/reference-transaction committed
 	EOF
@@ -143,6 +157,8 @@ test_expect_success 'hook captures git-symbolic-ref updates' '
 	git symbolic-ref refs/heads/symref refs/heads/main &&
 
 	cat >expect <<-EOF &&
+	preparing
+	$ZERO_OID ref:refs/heads/main refs/heads/symref
 	prepared
 	$ZERO_OID ref:refs/heads/main refs/heads/symref
 	committed
@@ -171,14 +187,20 @@ test_expect_success 'hook gets all queued symref updates' '
 	# In the files backend, "delete" also triggers an additional transaction
 	# update on the packed-refs backend, which constitutes additional reflog
 	# entries.
+	cat >expect <<-EOF &&
+	preparing
+	ref:refs/heads/main $ZERO_OID refs/heads/symref
+	ref:refs/heads/main $ZERO_OID refs/heads/symrefd
+	$ZERO_OID ref:refs/heads/main refs/heads/symrefc
+	ref:refs/heads/main ref:refs/heads/branch refs/heads/symrefu
+	EOF
+
 	if test_have_prereq REFFILES
 	then
-		cat >expect <<-EOF
+		cat >>expect <<-EOF
 		aborted
 		$ZERO_OID $ZERO_OID refs/heads/symrefd
 		EOF
-	else
-		>expect
 	fi &&
 
 	cat >>expect <<-EOF &&
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 5dcb4b51a4..6fe21e2b3a 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -469,12 +469,17 @@ test_expect_success 'fetch --atomic executes a single reference transaction only
 	head_oid=$(git rev-parse HEAD) &&
 
 	cat >expected <<-EOF &&
+		preparing
+		$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-1
+		$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-2
 		prepared
 		$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-1
 		$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-2
 		committed
 		$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-1
 		$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-2
+		preparing
+		$ZERO_OID ref:refs/remotes/origin/main refs/remotes/origin/HEAD
 	EOF
 
 	rm -f atomic/actual &&
@@ -497,7 +502,7 @@ test_expect_success 'fetch --atomic aborts all reference updates if hook aborts'
 	head_oid=$(git rev-parse HEAD) &&
 
 	cat >expected <<-EOF &&
-		prepared
+		preparing
 		$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-abort-1
 		$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-abort-2
 		$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-abort-3
-- 
2.51.0

