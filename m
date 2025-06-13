Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18F345948
	for <git@vger.kernel.org>; Fri, 13 Jun 2025 08:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749802228; cv=none; b=ABRi1do9uwK41WBL2lukKYXznnMXMI6gLMXo1l9Y9Xqlt433aUOURvIxxW61Roj88Kofe+8sLenmxNWIoZnDctTaicSpcLqy581e/LJOJqr76DKslUuYN+GIc5wcPF1wRKjB74SYdm1sWhetjXjuhoHwxNR3oAbXgHyjcWkfjJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749802228; c=relaxed/simple;
	bh=N/ci96ArWVtXakTEHHKRmTGRwM/ZMlOdm2kxKhGuhlM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h50I0iuO5/O04P8dvVvReMiqM707oQlDKAvPsuZKjet/B77KSB+Wue9zPc9onuOgm4UphzZnI/qoKtTym5r81JTM/BjhjdDC+/xbYR3ptkz3A8MDgzGf6pn62LlK8Zepj3AnjULzAerYqlmxSGdLiw7PcKkH/o1qKJb0VS2YbnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRSO5q2P; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRSO5q2P"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so15486385e9.1
        for <git@vger.kernel.org>; Fri, 13 Jun 2025 01:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749802225; x=1750407025; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ol5FVVJCSNq53IGeQaJtSULqI042bo4FGpBxT0ndco=;
        b=VRSO5q2PF8SE+JZLoOnnn70bFL7Q7yamii3xwhQ/5rKJSScaj8UW6RiDA5r6LjP8by
         7dDBMt9XbM/IgnyIQS8eSGmPIFxzs1GK05Hqygx9qMMUfHKXizv3/28XDggEdMH0b1EZ
         lQraUBLGkBumvHanSJd7leW7wlROrOzuTYgTICP8nNeE+ghA1z10GJoxK1Ykn0/j98DY
         72spt74qx+LmqjX+tHcAIdrmGNQXwvJd/0CuOEldyxJNZustrTMb/BokN0ipx2ewDWfv
         Pa/sJOLuSfQPh4spUF9iUxHzmxWQiQeF7cmF8J0qZNgvLzdMeFz9aiAcLotM5EpKY/qj
         cDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749802225; x=1750407025;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ol5FVVJCSNq53IGeQaJtSULqI042bo4FGpBxT0ndco=;
        b=UbnVM+4Lk7dSoqkzp2qrAfwL6qUacGQu0nq0diF5LsGEqQdwxis1oGTpLZoPxxlzNf
         x7acGT1Pe8Bn2wsz7/KXE3h+ISEovzWbMrvY+qEaynat157eatBWNhI6GOr/turi5hRI
         B/fEWs8kiXWHsJK0QKgm9g4y/1sdpGfVRAYHt1TEcddt6PlNaTJ8y/hz6aBtUw2QTmUX
         1ueMxtjiQklUoiLbNcP8oVKc5EC+3gTtymBEKHiSCiUCQdOgIN6v0SerOeYUgh6edJ64
         BVJ9E9ToVogLQxZ8XWCC1ujPWyUJpem0bx2xtc//B6vxP29c6WNYmFya4roYl3y1RVFn
         c7hQ==
X-Gm-Message-State: AOJu0YzmizX/fwRwXblzUzPNBAQ/W19s8+64BtnvUSyycG9FEW2uPhPm
	pm/2PkkZcjn906JToZ/6G6ts8ZzTG533xSgCbNALviyNHHOkYTmllgaK
X-Gm-Gg: ASbGncuG/c1ZdT9su76wgdkl6kRSGCvyIkby65lny8cY1xfTVpLwhNNkim+oGS4mM6P
	6Pa2f65EB8oeTSPJ5PuZGFSOPtqAnGYb5R5ik6QUVsduzLM7emC77/gtvEBkASsgZ7PF3f4VruP
	PbhXTCFYC//g0xpKRGxIXalVaZltkTtSIdEItrT89EACdeloWj9gXuprTNeVkfTAkAAqLevhPx9
	VkTLsSsMo3DqDOa11pPXSxDPfDT6T1dWLLnHW3gYdNa40d+LW5Y+cQA/YLEozOWdNWgEDqjEcOQ
	/IbMLeCSpTHUUwpYD+a+8ECNFfiMgiNrcE2d5LIBh7U4pg==
X-Google-Smtp-Source: AGHT+IEwSdhMaT2V989zf2BcRfHc/XpfkOO20pZqtP9btSflAB9rizV90YsWihuF5v5/oNnNHCk0Dg==
X-Received: by 2002:a05:600c:3f89:b0:453:b44:eb71 with SMTP id 5b1f17b1804b1-45334ad06e9mr18050585e9.19.1749802225124;
        Fri, 13 Jun 2025 01:10:25 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:9a6e:abf0:b0ed:9106])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a54a63sm1615191f8f.11.2025.06.13.01.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 01:10:24 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 13 Jun 2025 10:10:18 +0200
Subject: [PATCH v4 2/2] receive-pack: handle reference deletions separately
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v4-2-ebf53edb9795@gmail.com>
References: <20250613-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v4-0-ebf53edb9795@gmail.com>
In-Reply-To: <20250613-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v4-0-ebf53edb9795@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com, ps@pks.im, gitster@pobox.com, 
 sunshine@sunshineco.com, Christian Couder <chriscool@tuxfamily.org>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6676; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=N/ci96ArWVtXakTEHHKRmTGRwM/ZMlOdm2kxKhGuhlM=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGhL3O5NTDpTMhCXXVQrkk2wYS8qna5LWXUFL
 C+E+n1MpEJUg4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoS9zuAAoJED7VnySO
 Rox/n6cL/jq/28n2o47wrgonDBHG7bwN4sUbb9/9s26t0fEHYdMVCNjusfvv4F/4GRHr+b9LSRl
 t4KssEnz6FeVopHM2c0c2ntGsbEPrjt9FUZVKg4SX1gXoBfs/9/Txfr01xozWGXNiXrbRg8RKcZ
 XQKQh4HmuDfDosOFfiiCpr6m7qJreA8ULQxFWBqLGzqU5kDJuTFOBoyFJ9XhdHGcDSOAM655dI7
 XOLyasvRTfj3Xt1EOUWaW3dIDjGvbE8Ni0ceH906WfOSE+zegY90EhCvdRF35nvLH1UbfIYa9iW
 z2SotVyrTnPSMxwD5QR+1DmVYzsj8c2i1uqYOOu7TSXIwOXxLRKG2aa7DbnBC1mweO8JXZJqFmk
 IZJyBcfsXEuiQSlOlWxBbL2d6OsyR7cFkCi8ZSJhCD0owXKpt/y0qdfMq411gtalGF7c57KM+Lq
 vMZCFax1d1EoMG6c1MVTytUkQBmig5WxziIrbmkQIS/bU/LnZcnvf1E8g/mWzaW7oVqORpilaB5
 UU=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In 9d2962a7c4 (receive-pack: use batched reference updates, 2025-05-19)
we updated the 'git-receive-pack(1)' command to use batched reference
updates. One edge case which was missed during this implementation was
when a user pushes multiple branches such as:

  delete refs/heads/branch/conflict
  create refs/heads/branch

Before using batched updates, the references would be applied
sequentially and hence no conflicts would arise. With batched updates,
while the first update applies, the second fails due to D/F conflict. A
similar issue was present in 'git-fetch(1)' and was fixed by separating
out reference pruning into a separate transaction. Apply a similar
mechanism for 'git-receive-pack(1)' and separate out reference deletions
into its own batch.

This means 'git-receive-pack(1)' will now use up to two transactions,
whereas before using batched updates it would use _at least_ two
transactions. So using batched updates is still the better option.

Add a test to validate this behavior.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/receive-pack.c | 98 ++++++++++++++++++++++++++++++++------------------
 t/t5516-fetch-push.sh  | 17 ++++++---
 2 files changed, 77 insertions(+), 38 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 9e3cfb85cf..3fb2776e9a 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1867,47 +1867,77 @@ static void execute_commands_non_atomic(struct command *commands,
 	const char *reported_error = NULL;
 	struct strmap failed_refs = STRMAP_INIT;
 
-	transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
-						  REF_TRANSACTION_ALLOW_FAILURE, &err);
-	if (!transaction) {
-		rp_error("%s", err.buf);
-		strbuf_reset(&err);
-		reported_error = "transaction failed to start";
-		goto failure;
-	}
+	/*
+	 * Reference updates, where D/F conflicts shouldn't arise due to
+	 * one reference being deleted, while the other being created
+	 * are treated as conflicts in batched updates. This is because
+	 * we don't do conflict resolution inside a transaction. To
+	 * mitigate this, delete references in a separate batch.
+	 */
+	enum processing_phase {
+		PHASE_DELETIONS,
+		PHASE_OTHERS
+	};
 
-	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (!should_process_cmd(cmd) || cmd->run_proc_receive)
-			continue;
+	for (enum processing_phase phase = PHASE_DELETIONS; phase <= PHASE_OTHERS; phase++) {
+		for (cmd = commands; cmd; cmd = cmd->next) {
+			if (!should_process_cmd(cmd) || cmd->run_proc_receive)
+				continue;
 
-		cmd->error_string = update(cmd, si);
-	}
+			if (phase == PHASE_DELETIONS && !is_null_oid(&cmd->new_oid))
+				continue;
+			else if (phase == PHASE_OTHERS && is_null_oid(&cmd->new_oid))
+				continue;
 
-	if (ref_transaction_commit(transaction, &err)) {
-		rp_error("%s", err.buf);
-		reported_error = "failed to update refs";
-		goto failure;
-	}
+			/*
+			 * Lazily create a transaction only when we know there are
+			 * updates to be added.
+			 */
+			if (!transaction) {
+				transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
+									  REF_TRANSACTION_ALLOW_FAILURE, &err);
+				if (!transaction) {
+					rp_error("%s", err.buf);
+					strbuf_reset(&err);
+					reported_error = "transaction failed to start";
+					goto failure;
+				}
+			}
 
-	ref_transaction_for_each_rejected_update(transaction,
-						 ref_transaction_rejection_handler,
-						 &failed_refs);
+			cmd->error_string = update(cmd, si);
+		}
 
-	if (strmap_empty(&failed_refs))
-		goto cleanup;
+		/* No transaction, so nothing to commit */
+		if (!transaction)
+			goto cleanup;
 
-failure:
-	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (reported_error)
-			cmd->error_string = reported_error;
-		else if (strmap_contains(&failed_refs, cmd->ref_name))
-			cmd->error_string = strmap_get(&failed_refs, cmd->ref_name);
-	}
+		if (ref_transaction_commit(transaction, &err)) {
+			rp_error("%s", err.buf);
+			reported_error = "failed to update refs";
+			goto failure;
+		}
 
-cleanup:
-	ref_transaction_free(transaction);
-	strmap_clear(&failed_refs, 0);
-	strbuf_release(&err);
+		ref_transaction_for_each_rejected_update(transaction,
+							 ref_transaction_rejection_handler,
+							 &failed_refs);
+
+		if (strmap_empty(&failed_refs))
+			goto cleanup;
+
+	failure:
+		for (cmd = commands; cmd; cmd = cmd->next) {
+			if (reported_error)
+				cmd->error_string = reported_error;
+			else if (strmap_contains(&failed_refs, cmd->ref_name))
+				cmd->error_string = strmap_get(&failed_refs, cmd->ref_name);
+		}
+
+	cleanup:
+		ref_transaction_free(transaction);
+		transaction = NULL;
+		strmap_clear(&failed_refs, 0);
+		strbuf_release(&err);
+	}
 }
 
 static void execute_commands_atomic(struct command *commands,
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index dabcc5f811..1649667441 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -744,8 +744,8 @@ test_expect_success 'pushing valid refs triggers post-receive and post-update ho
 		EOF
 
 		cat >update.expect <<-EOF &&
-		refs/heads/main $orgmain $newmain
 		refs/heads/next $orgnext $newnext
+		refs/heads/main $orgmain $newmain
 		EOF
 
 		cat >post-receive.expect <<-EOF &&
@@ -808,8 +808,8 @@ test_expect_success 'deletion of a non-existent ref is not fed to post-receive a
 		EOF
 
 		cat >update.expect <<-EOF &&
-		refs/heads/main $orgmain $newmain
 		refs/heads/nonexistent $ZERO_OID $ZERO_OID
+		refs/heads/main $orgmain $newmain
 		EOF
 
 		cat >post-receive.expect <<-EOF &&
@@ -868,10 +868,10 @@ test_expect_success 'mixed ref updates, deletes, invalid deletes trigger hooks w
 		EOF
 
 		cat >update.expect <<-EOF &&
-		refs/heads/main $orgmain $newmain
 		refs/heads/next $orgnext $newnext
-		refs/heads/seen $orgseen $newseen
 		refs/heads/nonexistent $ZERO_OID $ZERO_OID
+		refs/heads/main $orgmain $newmain
+		refs/heads/seen $orgseen $newseen
 		EOF
 
 		cat >post-receive.expect <<-EOF &&
@@ -1909,4 +1909,13 @@ test_expect_success 'push with config push.useBitmaps' '
 		--thin --delta-base-offset -q --no-use-bitmap-index <false
 '
 
+test_expect_success 'push with F/D conflict with deletion and creation' '
+	test_when_finished "git branch -D branch" &&
+	git branch branch/conflict &&
+	mk_test testrepo heads/branch/conflict &&
+	git branch -D branch/conflict &&
+	git branch branch &&
+	git push testrepo :refs/heads/branch/conflict refs/heads/branch
+'
+
 test_done

-- 
2.49.0

