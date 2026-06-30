Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921A93A59A8
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 15:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782833366; cv=none; b=ZaJJnyMSe0sbKjZrCCNl3XCfDYXO+uE+GVZcSxftqvpqb++7vzQmQoqz+avbJbxsbWLZpBssS8MaramunCSR7wkr0A4WWmp4Zw/jomHzeCgggDEPVz3JDcxcroFA5duH4+BZCTMQ0FkhSUJR1GjYumjGbdOLMm4HkWGZGiNTlhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782833366; c=relaxed/simple;
	bh=vhm5/HL5fUj0ngcJQAUIYyavFUoSXAery3TyYdEo2as=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f2mOdT4zjqvM4WZ1yBnTqs1lWZjYkAOSpEcAlBA/GhkTrjND/hLeY5QfLd7xByHuaTSk6tBquzdMWy7f6iZUgT+Bu+5zTlqSLPZjJUbO/CUGOZCJ9jnuM4fbc8xekVCZ3XL+A/81syN+GxXwUJT4DAcPYbS+mfxFfBamFCjTEF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUIPTMnm; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUIPTMnm"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4758bd3731bso681053f8f.0
        for <git@vger.kernel.org>; Tue, 30 Jun 2026 08:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782833360; x=1783438160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9cYjramI8t8a7nOB9991g4fi9v1A7TB08qUnXWw8ta0=;
        b=aUIPTMnmqy8eOFEfS0MlgSlrxSHKWsTFMjMN3ZqYz9d98bgsGoXV9nQYQ5bfyxu+OT
         9/eJpS0wTh/mXQYIhnGk1TUUwiQudYyWW9sJSPMyu0Xcjsdeu0WPVxJkHQ0uTIc/cZ8L
         mTqHd/b42KpENl0Sf/+Ir8op1/KW9E9Mcb5LZWRXQbbye7ZptQQ/JfRR3hEUlkjxaAPh
         h6onzDZUOOlk1RWniWMz+qIIYaXUZy5lXKe58KlHa5QUYnhINtPQformo+WN1tdF5jWA
         n/1zpOW1sIKi7lc9sGOxKznAY7q1szzSTPpNnM2eAlSZ17/xcfbWYcQiZ1MDuhvA55bO
         J3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782833360; x=1783438160;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9cYjramI8t8a7nOB9991g4fi9v1A7TB08qUnXWw8ta0=;
        b=hyMTNEQYblF58FfSlpTXJ/i3+ds4bEQ/12f3s5/tjjadG7gDDkXL6b+ho3HfduGVRz
         dglzwm27ImH/QA5pX04y0cI2whzQXf9Zys+/6k6T9fycvS7gpcnSrRHCX1ZKKuV7MqVd
         n0xjbJeb7U2FKMrViMRp36tafnkppN4VEMcvJQJKf90RqMWMggadpcJ/QVYrONDaMxHX
         kB3zfqbyBN1FWKFtz3QOwwudqGWjDKHVjHxiKbr2tpj3fhNdjptgj1K5gA4LjAax+z7c
         Qx/EH4qtvp5bIQqGKY0611i1vUG2kxS3AfFvkJmdGaFeCLFqRQBln/O1E0X/ZKFQXCNe
         SccA==
X-Gm-Message-State: AOJu0Yy5CayFtf9DuGDAnUllLmpCBJbG4sjTZOsGR3BfWUmiFqmgHVAu
	rkxzFZG+gLePQPwXuh4Bfo3RzWV7G5zeN0kVxpQWeAU5YWf5doJvZkouZojOBw==
X-Gm-Gg: AfdE7cmC5hKL3FD3wr9V5jGhxihRTGzxnyBv33qCjhD+TYIZ+Y5fRMvqMTqPxddyYR/
	kBVH/gcGWsFcxtysNz/YMG/MIAn6zZh61vEgs4dyqKulkvzdijeZr6I85xs8oKVTLojHum7o+If
	61Ux3dX4O/8yC0x0SXCbcwsuaGY2pK1FmZLlqh+LeSKQBtYMB+nAP5s/nQINCbuUlE27TnT/HjA
	20fG/GRCFaZbDTvS7vNLO8ERv7pz7CCjzfZR6nBkK6+n2sO3SU9h2ZfFI12dPzRmOvBF2sOlUuz
	SF6ycupWgX7RZCYLOaUo9REFuBFugbbEOri51rq8I2mZLsffCEQ3ocjaDa4J7tERiIDqbSMUkju
	qL51QkGF4RCwEy92QzW3j6GHIfxwfxpcmcd68q308OuZQ22sCxPYr4FTHhZJQffk30sK/mzBek3
	222mSao+qFKxhkiE4t
X-Received: by 2002:a05:6000:616:b0:473:1e79:87e6 with SMTP id ffacd0b85a97d-475f4fb663emr3342468f8f.3.1782833360333;
        Tue, 30 Jun 2026 08:29:20 -0700 (PDT)
Received: from berwick ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47567979eafsm8477378f8f.34.2026.06.30.08.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 08:29:19 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 06/11] sequencer: simplify handing of fixup with conflicts
Date: Tue, 30 Jun 2026 16:28:56 +0100
Message-ID: <1585d47e2ea72c9d70160071109ce1ed23021495.1782833268.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.200.gfd8d68259e3
In-Reply-To: <cover.1782833268.git.phillip.wood@dunelm.org.uk>
References: <67dbfb5c-5f07-49b8-aa32-a4635c585028@gmail.com> <cover.1782833268.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Commit e032abd5a0 (rebase: fix rewritten list for failed pick,
2023-09-06) introduced an early return when res == -1, so if we enter
this conditional block then res is positive. After the last couple
of commits the only possible positive value is 1 so we can simplify
the code by removing the conditional call to intend_to_amend() and
call it error_with_patch() instead.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 39cbb7b6e3e..bcfbda018a7 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3874,7 +3874,7 @@ static int error_failed_squash(struct repository *r,
 		return error(_("could not copy '%s' to '%s'"),
 			     rebase_path_message(),
 			     git_path_merge_msg(r));
-	return error_with_patch(r, commit, subject, subject_len, opts, 1, 0);
+	return error_with_patch(r, commit, subject, subject_len, opts, 1, 1);
 }
 
 static int do_exec(struct repository *r, const char *command_line, int quiet)
@@ -4986,8 +4986,6 @@ static int pick_one_commit(struct repository *r,
 		record_in_rewritten(&item->commit->object.oid,
 				    peek_command(todo_list, 1));
 	if (res && is_fixup(item->command)) {
-		if (res == 1)
-			intend_to_amend();
 		return error_failed_squash(r, item->commit, opts,
 					   item->arg_len, arg);
 	} else if (res && is_rebase_i(opts) && item->commit) {
-- 
2.54.0.200.gfd8d68259e3

