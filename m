Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4AC45974
	for <git@vger.kernel.org>; Sat, 30 Mar 2024 22:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711838793; cv=none; b=YkkNxDK/nZMexj90wPIx0K0znlzWmwP7uHKXoCF5fIhy4+NtMbpTGTxgdTBl2MkGaFaPjfQYbKNAfJWqq/yFc4EOFOVy0UPGHpyHwzcK15PgvQo7/m2syuptf6evmXAlCvFvCqKAMjpjHU2hSre08QhKfG7Wh2isjV3cQy3nnrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711838793; c=relaxed/simple;
	bh=h3OaLZRZFk9Fwrs4Xo4aFSzfuQmhttrjkaBtk+29bVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AWE/1SNqJaB1stOTar6F0bwXUNqHiPPyptOYS03/Z3r8MQUk7JVtKpOkjU1eiYvH7ug+FLoz2fs8jqjMqoBtMJXWcPwN++lmD6TojG5Q3YkHjNPtErhhQR0I6th4NglziBn3V0Yv9SlM3wx+P+7b3aGAd3qjnTehnafZ+V7w3mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SeTuROE1; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeTuROE1"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-515d55aaf5aso770645e87.3
        for <git@vger.kernel.org>; Sat, 30 Mar 2024 15:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711838789; x=1712443589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+grWuy6CASfl5OTrcaKpId72tS98FfgYwyv5Wyx6I4o=;
        b=SeTuROE1EhPPp24vjn2OgaR5unk1JHsWwj9O6CDo9xdtbg4tYV7h6DXEWOyu7IrKqm
         ckVnfW5DOTg4QMth/IaD2EXU/PiES30DYtUQVRqSE98aqXWObimSGc31+/gdR+K3yAE6
         4FXjqgudGDKgL9Zp+1YaACzpV+Z/Ytglnkqwa3nUc4VAAr+1kiqel06rcqhwWCtzh//s
         ZgRGzhuy+eS2Gppi8rlkXzp2w60FzKSJE1unkPcpKXBsJ5fgfOjw5ve4OJeXvirWpkPf
         fHIS5bYEq5zYzvFMVLmfreWuhCaLF+ZSDDme0ySQBlci0UoLWx3KlDWPSvNykiP/vKkk
         P3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711838789; x=1712443589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+grWuy6CASfl5OTrcaKpId72tS98FfgYwyv5Wyx6I4o=;
        b=uCytQFEKzXc7r/03QFjtR+CbfCiA1dok5vdMjZ/nd1VYYeCVGEXGW1zTOuq9cwirLr
         r/jo4YFUS1GL0jOS2GE3OcRLB6eN7hRc3WYP1GH9w/nbcLEng4QswlJrgcfvc9K5H9V0
         ZdhdJ/2k35WBMGk7mSzUe8b0knJIooAShiilXsWy14zLZJBy4XwPVsqkpSGL1CIviQWf
         f79fXz9DSpu8hEdhNRJDRZtUsOAB6FA4o57XXqb2sT0OaXgx82pQN5wiYrJMbKPP/DAl
         gsu2oA6DTj8+u/mAqfNfMGovVf8/BteiyhgP852Qyc8o6Z2r0xKV5P/uh9i2kJBFB4IT
         8ziQ==
X-Gm-Message-State: AOJu0YwMFwQnKJYdOUrPVPCdfiLhvWEEHdMSehA7NQfyCDDxvFvbgImg
	ywqCTVtDcYIyGRe+6MfbwGpkUmZ55jbFZLrtrkaIdxIY4trw9BdsIGI6vjTgFFg=
X-Google-Smtp-Source: AGHT+IHAO1sujdsJwBY6ZkIM89LQ+tnjiXA6ojSvjEZkD58FIcPZCkBgTAquv/FyMijq9sUkUPuHxg==
X-Received: by 2002:ac2:5e62:0:b0:513:fad:3a79 with SMTP id a2-20020ac25e62000000b005130fad3a79mr3484805lfr.41.1711838788799;
        Sat, 30 Mar 2024 15:46:28 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:9f01:e67d:4cf3:c3bc])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090637d300b00a46cc48ab07sm3533580ejc.221.2024.03.30.15.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 15:46:28 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 2/8] reftable-backend: extract out `write_symref_with_log`
Date: Sat, 30 Mar 2024 23:46:17 +0100
Message-ID: <20240330224623.579457-3-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240330224623.579457-1-knayak@gitlab.com>
References: <20240330224623.579457-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

The function `write_create_symref_table`, creates a
`reftable_ref_record` for a symref and adds it to the writer. Then it
also creates a log entry for the symref. It does all of this while also
obtaining and using a new update index.

We extract out `write_symref_with_log` from this to provide the
functionality of creating a symref without making changes to the update
index. This will be used to add `update-symref` option to the
`git-update-ref` command.

Rename the `create` field to `arg` while we're here, as `create` is a
bit misleading.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/reftable-backend.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index e206d5a073..282a08e3cb 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1222,23 +1222,22 @@ struct write_create_symref_arg {
 	const char *logmsg;
 };
 
-static int write_create_symref_table(struct reftable_writer *writer, void *cb_data)
+static int write_symref_with_log(struct reftable_writer *writer,
+				 struct write_create_symref_arg *arg,
+				 uint64_t update_index)
 {
-	struct write_create_symref_arg *create = cb_data;
-	uint64_t ts = reftable_stack_next_update_index(create->stack);
 	struct reftable_ref_record ref = {
-		.refname = (char *)create->refname,
+		.refname = (char *)arg->refname,
 		.value_type = REFTABLE_REF_SYMREF,
-		.value.symref = (char *)create->target,
-		.update_index = ts,
+		.value.symref = (char *)arg->target,
+		.update_index = update_index,
 	};
+
 	struct reftable_log_record log = {0};
 	struct object_id new_oid;
 	struct object_id old_oid;
 	int ret;
 
-	reftable_writer_set_limits(writer, ts, ts);
-
 	ret = reftable_writer_add_ref(writer, &ref);
 	if (ret)
 		return ret;
@@ -1251,25 +1250,35 @@ static int write_create_symref_table(struct reftable_writer *writer, void *cb_da
 	 * not resolve for new repositories this ordering will ensure that this
 	 * never happens.
 	 */
-	if (!create->logmsg ||
-	    !refs_resolve_ref_unsafe(&create->refs->base, create->target,
+	if (!arg->logmsg ||
+	    !refs_resolve_ref_unsafe(&arg->refs->base, arg->target,
 				     RESOLVE_REF_READING, &new_oid, NULL) ||
-	    !should_write_log(&create->refs->base, create->refname))
+	    !should_write_log(&arg->refs->base, arg->refname))
 		return 0;
 
 	fill_reftable_log_record(&log);
-	log.refname = xstrdup(create->refname);
-	log.update_index = ts;
-	log.value.update.message = xstrndup(create->logmsg,
-					    create->refs->write_options.block_size / 2);
+	log.refname = xstrdup(arg->refname);
+	log.update_index = update_index;
+	log.value.update.message = xstrndup(arg->logmsg,
+					    arg->refs->write_options.block_size / 2);
 	memcpy(log.value.update.new_hash, new_oid.hash, GIT_MAX_RAWSZ);
-	if (refs_resolve_ref_unsafe(&create->refs->base, create->refname,
+	if (refs_resolve_ref_unsafe(&arg->refs->base, arg->refname,
 				    RESOLVE_REF_READING, &old_oid, NULL))
 		memcpy(log.value.update.old_hash, old_oid.hash, GIT_MAX_RAWSZ);
 
 	ret = reftable_writer_add_log(writer, &log);
 	reftable_log_record_release(&log);
 	return ret;
+
+}
+
+static int write_create_symref_table(struct reftable_writer *writer, void *cb_data)
+{
+	struct write_create_symref_arg *arg = cb_data;
+	uint64_t ts = reftable_stack_next_update_index(arg->stack);
+	reftable_writer_set_limits(writer, ts, ts);
+
+	return write_symref_with_log(writer, arg, ts);
 }
 
 static int reftable_be_create_symref(struct ref_store *ref_store,
-- 
2.43.GIT

