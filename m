Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB3D1E47B3
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 08:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749199286; cv=none; b=gZo3DSb6JXGY8gBndH+uiLdjwyip0JcOqYitlsD/jdXgtYsHlwjUGguVD2e4bDEncNPcPvXnt500NnAK0ZTWqF1XIEEbFG5hAUFTH/BVhhngOV3r5XZUWKUf2HGBuoHvB8BRwlX8FaD55DVQ7eP3JyYHrD5y6HLeofYcXFMyyJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749199286; c=relaxed/simple;
	bh=oXwq7uIAEJo2NPJ2VLPEcmW/lJnwtPOA0rLw+mdec7Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=mpgBmt5LEprwba9w7Vv3c2gc9xMEqxSO40MYIi5NVKgKXOEUeyRWEGDh4AueQNlRifoN67UM+yqeo4J2OmExFsmDZaGBXaqB0KK10SkmsbAxUPfIUsHGPwM5ch0D5RSeWZAmGNyEu6EXXK8N6YKVDJZIeFAtSZfelg4JXUtL7k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndKd5BM2; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndKd5BM2"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-607434e1821so1372849a12.0
        for <git@vger.kernel.org>; Fri, 06 Jun 2025 01:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749199282; x=1749804082; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zFeSR0rnuSl+XIE/Igkb3xHQLh6KDu/ShaSLRhW2kbY=;
        b=ndKd5BM28kCqSdC2aa0oChu+ugeB8Q7XAURZIhJYVZa9tOVr2fYPTiEwwZX0Jc6dGQ
         pakqedzU72VCZTZ42Ln+vzCTWg7xhxR5xhU4aEFtlVZeJPVas/s8p13MtJQWnqzTVsCM
         bULivQqq7SfRR3pWBg6cyU+IAF/hcB5BNlT+p0iOw4AccfkTqTM798Zixpezd8MWkLxL
         ASRBI23faPeOZSoO7D8WPWn+wZ7L8OGf3jGeBATr+qav+xafpsqbeUamn7HE4Pltxbhq
         wsd4NWHYr1QSNS/iy9M+Dw7YeXRGo5c7hSckrxeFhNlbDekrem1h2CmMsWKqiI7zw4YV
         z9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749199282; x=1749804082;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zFeSR0rnuSl+XIE/Igkb3xHQLh6KDu/ShaSLRhW2kbY=;
        b=ZROl1xzP3DVygmm/XzthPMOwL3efxdVa8ws3QyMkYUNTbQ1QyfdVu1/3VfCnmeiN7/
         94oxHKShwOco0rH+MgLhTPWY0Cy9kEdEsKC2zjg2CsqzbNI+/kvV6FAc7oA4qVOdr4l2
         dY3SVFe1e+dv66Ht5kh9FYW6VvAByLW65Sc0KFlhiYXsqxo3p36NudEykD3DfgflBGrV
         9iq2s2TCCRb3PlR1Lf8S3SOTEkxst4H2PAKQS6Bf6F8VOrLnfUQax703e2mgZ5dMII2R
         2ISztUDcFUbtFwpRbZQOAUSqZ9VIy+DfECyGoZoSLnVFVq78lUgHXAVjoGdkpbrblVl2
         RByQ==
X-Gm-Message-State: AOJu0YydJC3fHW5ifd63gl3DrZytlbLfH+DWZO2lFYBl+WJzDRJz5djc
	ikMY7Aywup5kydaj23JBMZ8JS95P4yPk46ro4uyFAhoUWN2r7kEt9ixq+BAP+e8N
X-Gm-Gg: ASbGncvDdiP1tu0w8w2z7OCM/PnOYEJNV6zmJQjo9xidM48OV4BVaPicrNG6lL0IDFh
	B5vOMEmQQSDl3Ec3GxzO0isAMQx5sKFEl90AacIIfcsV233QZeEWM7dZDWjZ4gJbTDtkRN2CcdA
	MWl/ynRAVNEw0YrDEXdsaD2DkYq6HDfuYJYe0FZkuNIfl/m0EbD4+khjvIVPLbaymZ8YSxNj3Sw
	sEj0tKUuY9xDsMgcn+tlLBCO8bwZ83u5Y9sUXBG9R69kQaS1biEB6htoVYZuFaVOFwZGMXVO0DL
	k+UkKoIjb99j2abKz8+2hUGX+W0tBmufHGpbQUKQwtcDlQ==
X-Google-Smtp-Source: AGHT+IEUSrHIGL/vogGcmu7iWZ2EKzUSaliXDeafpcE5IMBwhzes2TbOQpoWSjddeTjasTAW/IEXDw==
X-Received: by 2002:a05:6402:3588:b0:607:f1c:bfe1 with SMTP id 4fb4d7f45d1cf-6077498decemr1893571a12.30.1749199282230;
        Fri, 06 Jun 2025 01:41:22 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:1baf:dad2:9556:ca27])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-607783e654asm706910a12.69.2025.06.06.01.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 01:41:19 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 0/2] refs: fix some bugs with batched-updates
Date: Fri, 06 Jun 2025 10:41:09 +0200
Message-Id: <20250606-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v3-0-e1c41693bd35@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKWpQmgC/7XOTY7CMAwF4KugrPEoSZvQsuIeiEV+HBIJUpSkF
 Qj17hhmM3MAdn6W9fw9WcWSsLL95skKLqmmKVPothvmoslnhOQpM8ml4koOoHd6BON9wVqhYW0
 QTLrMFCFlaBEh472BLSa7CM7MFT3YB1jTXKSxYMCC2SHMN2+oAGQfgur0wEXfM/p7o5N0/5iOJ
 8ox1TaVx4e4iPf2V6O5/IJmEcBh5J0X3nZBcDycr1T546Yre2sW+VegviGQJJDaea7sYHbjP8G
 6ri+7HzYItAEAAA==
X-Change-ID: 20250528-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-24ff53680144
In-Reply-To: <20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-0-903d1db3f10e@gmail.com>
References: <20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-0-903d1db3f10e@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com, ps@pks.im, gitster@pobox.com, 
 sunshine@sunshineco.com, Christian Couder <chriscool@tuxfamily.org>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=9467; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=oXwq7uIAEJo2NPJ2VLPEcmW/lJnwtPOA0rLw+mdec7Y=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGhCqa4L3yduTWYSn37Ddp6YoHnxFSsDT7Bp4
 nZce23j0Bhu54kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoQqmuAAoJED7VnySO
 Rox/q28MAKGSBz2lGtfaYRXf2sQO8KvJ0scgUEBy/pSh8BF8Fhx1egISs3XjwaBXo94umYTAfqR
 rE+VQV+/d0dEZqXuVpjIMxC3a1Uob2akWI5+BdtpU+nU3EZkFu/s6GTeYpdv47kKE8wHwVSJFPb
 AUY5uSF4JSnEHUSPS+KZZdIXMPaKowWRvbs+sMLUPVxCfHOfHjER+oJaVOGXpGENGeJWH67BNXL
 OUIONFf2kAwGT3fMbXx06xPxZxKXZI40FeJcobuNW2Lt7+EVyu6QF6mhMhLVfhpPp4sw5Cp4Trx
 WweVQmY6qMgq6NFyKbm/QI9Iohnl0Uze4U6GTaDY3LwPwm56gT01xl6GzMCaZ9X1kaT77Y5fdgW
 95L1w7AYpwxrxMC+sKGt7QFTiBzCuAZWkYsWqLmXOtkuZ4fMpGDtOQZvldzv8QA/mYE+2nqTS6+
 fodo0blo3ey9mti6F5r7z8q6QVMd3JSUCkmoqtl5AG0mDSbJZLlRXtSng2GoAjLaugFMihhPwz6
 sk=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In 23fc8e4f61 (refs: implement batch reference update support,
2025-04-08) we introduced a mechanism to batch reference updates. The
idea being that we wanted to batch updates similar to a transaction, but
allow certain updates to fail. This would help reference backends
optimize such operations and also remove the overhead of processing
updates individually. Especially for the reftable backend, where
batching updates would ensure that the autocompaction would only occur
at the end of the batch instead of after every reference update.

As of 9d2962a7c4 (receive-pack: use batched reference updates,
2025-05-19) we also updated the 'git-fetch(1)' and 'git-receive-pack(1)'
command to use batched reference updates. This series fixes some bugs
that we found at GitLab by running our Gitaly service with the `next`
build of Git.

The first being in the files backend, which missed skipping over failed
updates in certain flows. When certain individual updates fail, we mark
them as such. However, we missed skipping over such failed updates,
which can cause a SEGFAULT.

The other is in the git-receive-pack(1) implementation when a user
pushes multiple branches such as:

  delete refs/heads/branch/conflict
  create refs/heads/branch

Before using batched updates, the references would be applied
sequentially and hence no conflicts would arise. With batched updates,
while the first update applies, the second fails due to F/D conflict. A
similar issue was present in 'git-fetch(1)' and was fixed by using
separating out reference pruning into a separate transaction. Apply a
similar mechanism for 'git-receive-pack(1)' and separate out reference
deletions into its own batch.

This is based off master 7014b55638 (A bit more topics for -rc1,
2025-05-30), with the changes from kn/fetch-push-bulk-ref-update merged
in.

---
Changes in v3:
- Cleanup the second commit message and remove stale comments.
- In the second commit, only create the transaction if needed.
- Link to v2: https://lore.kernel.org/r/20250605-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v2-0-26cd05b8a79e@gmail.com

Changes in v2:
- Modify the test in the first commit to no longer do a quiet grep,
  and some more tests.
- Remove the second commit as it was unnecessary.
- Modify the commit message in the last commit, to also talk about how
  we now use 2 transactions at minimum but this is still better than
  before.
- Modify the logic in the last commit to no longer use an XOR and
  instead loop over the two different scenarios (deletion updates, other
  updates).
- Link to v1: https://lore.kernel.org/r/20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-0-903d1db3f10e@gmail.com

---
 builtin/receive-pack.c | 100 ++++++++++++++++++++++++++++++++-----------------
 refs/files-backend.c   |   7 ++++
 t/t1400-update-ref.sh  |  45 ++++++++++++++++++++++
 t/t5516-fetch-push.sh  |  17 +++++++--
 4 files changed, 131 insertions(+), 38 deletions(-)

Karthik Nayak (2):
      refs/files: skip updates with errors in batched updates
      receive-pack: handle reference deletions separately

Range-diff versus v2:

1:  50f318714b = 1:  695cc3b9d4 refs/files: skip updates with errors in batched updates
2:  d7293b64b0 ! 2:  a20bb05dd6 receive-pack: handle reference deletions separately
    @@ Commit message
         similar mechanism for 'git-receive-pack(1)' and separate out reference
         deletions into its own batch.
     
    -    This means 'git-receive-pack(1)' will now use exactly two transactions,
    +    This means 'git-receive-pack(1)' will now use upto two transactions,
         whereas before using batched updates it would use _at least_ two
    -    transactions. So using batched updates is the still the better option.
    +    transactions. So using batched updates is still the better option.
     
         Add a test to validate this behavior.
     
    @@ builtin/receive-pack.c: static void execute_commands_non_atomic(struct command *
     -	for (cmd = commands; cmd; cmd = cmd->next) {
     -		if (!should_process_cmd(cmd) || cmd->run_proc_receive)
     -			continue;
    -+	for (int phase = PHASE_DELETIONS; phase <= PHASE_OTHERS; phase++) {
    -+		transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
    -+							  REF_TRANSACTION_ALLOW_FAILURE, &err);
    -+		if (!transaction) {
    -+			rp_error("%s", err.buf);
    -+			strbuf_reset(&err);
    -+			reported_error = "transaction failed to s1tart";
    -+			goto failure;
    -+		}
    ++	for (enum processing_phase phase = PHASE_DELETIONS; phase <= PHASE_OTHERS; phase++) {
    ++		for (cmd = commands; cmd; cmd = cmd->next) {
    ++			if (!should_process_cmd(cmd) || cmd->run_proc_receive)
    ++				continue;
      
     -		cmd->error_string = update(cmd, si);
     -	}
    -+		for (cmd = commands; cmd; cmd = cmd->next) {
    -+			if (!should_process_cmd(cmd) || cmd->run_proc_receive)
    ++			if (phase == PHASE_DELETIONS && !is_null_oid(&cmd->new_oid))
    ++				continue;
    ++			else if (phase == PHASE_OTHERS && is_null_oid(&cmd->new_oid))
     +				continue;
      
     -	if (ref_transaction_commit(transaction, &err)) {
    @@ builtin/receive-pack.c: static void execute_commands_non_atomic(struct command *
     -		reported_error = "failed to update refs";
     -		goto failure;
     -	}
    -+			if (phase == PHASE_DELETIONS && !is_null_oid(&cmd->new_oid))
    -+				continue;
    -+			else if (phase == PHASE_OTHERS && is_null_oid(&cmd->new_oid))
    -+				continue;
    ++			/*
    ++			 * Lazily create a transaction only when we know there are
    ++			 * updates to be added.
    ++			 */
    ++			if (!transaction) {
    ++				transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
    ++									  REF_TRANSACTION_ALLOW_FAILURE, &err);
    ++				if (!transaction) {
    ++					rp_error("%s", err.buf);
    ++					strbuf_reset(&err);
    ++					reported_error = "transaction failed to s1tart";
    ++					goto failure;
    ++				}
    ++			}
      
     -	ref_transaction_for_each_rejected_update(transaction,
     -						 ref_transaction_rejection_handler,
    @@ builtin/receive-pack.c: static void execute_commands_non_atomic(struct command *
      
     -	if (strmap_empty(&failed_refs))
     -		goto cleanup;
    -+		if (ref_transaction_commit(transaction, &err)) {
    -+			rp_error("%s", err.buf);
    -+			reported_error = "failed to update refs";
    -+			goto failure;
    -+		}
    ++		/*
    ++		 * If no transaction was created, there is nothing to commit.
    ++		 */
    ++		if (!transaction)
    ++			goto cleanup;
      
     -failure:
     -	for (cmd = commands; cmd; cmd = cmd->next) {
    @@ builtin/receive-pack.c: static void execute_commands_non_atomic(struct command *
     -		else if (strmap_contains(&failed_refs, cmd->ref_name))
     -			cmd->error_string = strmap_get(&failed_refs, cmd->ref_name);
     -	}
    -+		ref_transaction_for_each_rejected_update(transaction,
    -+							 ref_transaction_rejection_handler,
    -+							 &failed_refs);
    ++		if (ref_transaction_commit(transaction, &err)) {
    ++			rp_error("%s", err.buf);
    ++			reported_error = "failed to update refs";
    ++			goto failure;
    ++		}
      
     -cleanup:
     -	ref_transaction_free(transaction);
     -	strmap_clear(&failed_refs, 0);
     -	strbuf_release(&err);
    ++		ref_transaction_for_each_rejected_update(transaction,
    ++							 ref_transaction_rejection_handler,
    ++							 &failed_refs);
    ++
     +		if (strmap_empty(&failed_refs))
     +			goto cleanup;
     +
    @@ builtin/receive-pack.c: static void execute_commands_non_atomic(struct command *
     +
     +	cleanup:
     +		ref_transaction_free(transaction);
    ++		transaction = NULL;
     +		strmap_clear(&failed_refs, 0);
     +		strbuf_release(&err);
     +	}
      }
      
      static void execute_commands_atomic(struct command *commands,
    -@@ builtin/receive-pack.c: static void execute_commands(struct command *commands,
    - 	/*
    - 	 * If there is no command ready to run, should return directly to destroy
    - 	 * temporary data in the quarantine area.
    -+	 *
    -+	 * Check if any reference deletions exist, these are batched together in
    -+	 * a separate transaction to avoid F/D conflicts with other updates.
    - 	 */
    - 	for (cmd = commands; cmd && cmd->error_string; cmd = cmd->next)
    - 		; /* nothing */
    -
    - ## t/t1416-ref-transaction-hooks.sh ##
    -@@ t/t1416-ref-transaction-hooks.sh: test_expect_success 'interleaving hook calls succeed' '
    - 	EOF
    - 
    - 	cat >expect <<-EOF &&
    -+		hooks/reference-transaction prepared
    -+		hooks/reference-transaction committed
    - 		hooks/update refs/tags/PRE $ZERO_OID $PRE_OID
    - 		hooks/update refs/tags/POST $ZERO_OID $POST_OID
    - 		hooks/reference-transaction prepared
     
      ## t/t5516-fetch-push.sh ##
     @@ t/t5516-fetch-push.sh: test_expect_success 'pushing valid refs triggers post-receive and post-update ho


base-commit: 931c39f05e078e0df968a439379cb04b5c4666ef
change-id: 20250528-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-24ff53680144

Thanks
- Karthik

