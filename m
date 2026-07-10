Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AA81E531
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 16:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701450; cv=none; b=Vta7Tjqz0Ppm1aqxc7hOEf8foy2ozHIsOq2ZYJoP0Mylg6R4pzlSgeG8PO6OqeaOUk/YYhtd4IK+/fe3IEEXO8SYRONs0oHBg6AJEbJWEfulbzJ7+JLfcuz5yFG7cmJeOO4ljGcM4jYPEeMKz5HDzdgc0+vMNT2g0onuMnsizM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701450; c=relaxed/simple;
	bh=hJb2Hz72612uNfTb6BHOMmfNnQO3ILgpEI8PI0VQ5QM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J3ghLqXqVe9DLGd+2v3mlupTnJxsluTYkjRYLQ28ZQuDB1116FXGbvLmFAgumZ84om4PSH9cYEAjVz81s7J1XvjXSRxS7JGT54ZEZAUPYP7OqnY7B2nwQ7vNxYBbA1OBsTGeKaldaqMCUbbUCldO3zViTSwbX7vddEiW61CVoTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TtFIDRQw; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtFIDRQw"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7eb34c17b96so763245a34.2
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 09:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783701448; x=1784306248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n1Md2pcpXHrnH+moAy7XgQ4j5IbBDAwBlJdzKofYeOk=;
        b=TtFIDRQw4QoEkjDcauTT14UUBMeMw0E2P/p8SHXazVaO4KBauqa9JmPQyV+5b5K8zV
         TSfaPyZeIadQ/DPlJypJZ8CW3TenQ6jQiGxMjuToWwc3H3yeOPgAUvArxI05+GXa4zYz
         4r9/v4cm5E7lZx+6MCVMW4tHycnMCgrOAdQtGvCjiOf5WWOzVp+RDcAYSQSf77nyEvr8
         XVMSwe13jM+zVq6vEHb1JQYCj7NJZqsxYS6OrkoBaqw2S6RQCaAik6U184eBT3Ncl7/m
         zrcSg63UxqRoH8keaygjnD8pezoIK4dx0LijJvdPNk5P+uNdRnEQS765AQiX3jeXnlnR
         cbkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783701448; x=1784306248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n1Md2pcpXHrnH+moAy7XgQ4j5IbBDAwBlJdzKofYeOk=;
        b=qFFc5MQOWnCqjuPNQ/aokpBELQRuUP9Nuitd6dfRd5yKYX3rOrbtCqhid+JPQO+63z
         Ry99Pb4e+czgXSq0rKaGgUS2lpAR5Fb+cle9JiQaAOGOUPqY527po/mkq5DgHYfYVTOB
         OUHGdM+l8h/UCjS6Q3mAm1ysGCfZV1mIjjdp9j07Ad2oxc558I9Q/SFKxkJxiOmf4sk1
         wwLXyeKmWy6DgUxaxlVYzS31uVR0SW6TWayF3fh4fBGbqFF3yGYs+/X8c/ZC5tmoAPRy
         386irWfcr7UgUVRswNF7NeNAcFp9jaMkSMXy7o5wqVWysxi97VZX9meqvfpPYOhDeSGL
         nuzg==
X-Gm-Message-State: AOJu0YycWFaxQjPHPqv6ebbXfPo9t1h/63E1UgxZ7JGjOGeUa2WqPiKe
	L58vRx7QhmkCmV33Epi9Swk98PZgu1HwK6Qz7lHDOAvdyqLCpYfL8HDEJi0BEg==
X-Gm-Gg: AfdE7clZk+0c5R36iSIOq0a5gSu1/ArZd4854I12Stlq/eG/VA4iuATFmeoJEnv8O8e
	V79B1Defwm2y/EtUfBhiIcKePbLnkTdwJwXjXXtVsTHz6ceyprNWqvoxln8cjo1YRuKYhdZbjF3
	zS1w5400/DKO0B6YkQhsTykw60dS+JNvjDtUrtJPovr7wkghxCykN4wqAHp19IR9L56KbE2YAcK
	sEFv7119hOHYzL9JB2BjBqeEhBQ1h4JJtnpuHNLRer6Mb31t+NeGbp3B+SG4ecJioyw6SN7MJ1Z
	G5GezZHYyHOIH/r7WgkmnD6HMlzAmFU2vNljHSnqV8CEZqjQbfnoogXrKZpGaoqAI6sp1Uh39SW
	WqkPWGFRTST8/0ssk9esCBiAM7IZs1fpaUbEZ+AxRvDKtcO+5SQ/p3Lh4Gv4VWObNWzHKyoHAjA
	VJvlBRcyEqpzLKOQDrDFbW
X-Received: by 2002:a05:6830:67fe:b0:7dc:c7aa:22bd with SMTP id 46e09a7af769-7ebcff349b0mr8640337a34.6.1783701447921;
        Fri, 10 Jul 2026 09:37:27 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcaf742e1sm6882147a34.8.2026.07.10.09.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 09:37:27 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 00/11] receive-pack: use ODB transactions to stage object writes
Date: Fri, 10 Jul 2026 11:37:11 -0500
Message-ID: <20260710163722.2962278-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.122.gf85a7e6620
In-Reply-To: <20260708235925.3992097-1-jltobler@gmail.com>
References: <20260708235925.3992097-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

This patch series replaces direct usage of the `tmp_objdir` interfaces
in git-receive-pack(1) to instead use the `odb_transaction` interfaces
to create/manage a staging area to write objects to. The purpose of this
change is to get git-receive-pack(1) one step closer to being ODB
backend agnostic. For now, the object writes themselves are still
"files" backend specific due to being handled by the git-index-pack(1)
and git-unpack-objects(1) child processes. This will be tackled in a
separate series though.

Changes since V3:
  - Removed ugly line break in commit message to prevent eye strain.
  - `odb_transaction_begin()` now only sets the repository transaction
    on success.
  - `odb_transaction_env()` now bubbles up error when failing to create
    the temporary directory.

Changes since V2:
  - Clarified commit log reasoning for embedding
    `flush_loose_object_transaction()` logic in commit function.
  - Started printed some error messages on transaction errors.
  - Removed include statement.
  - Fixed transaction leak on `odb_transaction_commit()` error.

Changes since V1:
  - Adapted other "file" ODB transaction helpers to be more consistent
    with current naming scheme.
  - Removed redundant NULL transaction handling from
    `odb_transaction_files_begin()`.
  - `odb_transaction_begin()` now returns an error if there is already
    an inflight transaction pending instead of setting the `out` pointer
    to NULL.
  - Updated `odb_transaction_env()` to return an error code and append
    environment variables to a strvec provided as an argument.
  - Removed redundant setting of tmpdir environment variables for child
    processes after tmpdir has been migrated.
  - Split changes adding ODB transaction flags into a separate commit.
  - Consistently wire the ODB transaction throughout git-receive-pack
    code instead of reading it from `the_repository`.
  - Updated user facing error message.
  - Updated some comments to better document functions/flags.
  - Clarified some commit messages.
  - Fixed typos.

Thanks,
-Justin

Justin Tobler (11):
  object-file: rename files transaction prepare function
  object-file: rename files transaction fsync function
  object-file: embed transaction flush logic in commit function
  object-file: drop check for inflight transactions
  object-file: propagate files transaction errors
  odb/transaction: propagate begin errors
  odb/transaction: propagate commit errors
  odb/transaction: add transaction env interface
  odb/transaction: introduce ODB transaction flags
  builtin/receive-pack: drop redundant tmpdir env
  builtin/receive-pack: stage incoming objects via ODB transactions

 builtin/add.c            |   2 +-
 builtin/receive-pack.c   |  69 ++++++++---------
 builtin/unpack-objects.c |   2 +-
 builtin/update-index.c   |   2 +-
 cache-tree.c             |   7 +-
 object-file.c            | 161 +++++++++++++++++++++++++--------------
 object-file.h            |   8 +-
 odb/source-files.c       |   9 +--
 odb/source-inmemory.c    |   3 +-
 odb/source-loose.c       |   3 +-
 odb/source.h             |   9 ++-
 odb/transaction.c        |  33 ++++++--
 odb/transaction.h        |  59 +++++++++++---
 read-cache.c             |   7 +-
 14 files changed, 244 insertions(+), 130 deletions(-)

Range-diff against v3:
 1:  9c14b219ad =  1:  9c14b219ad object-file: rename files transaction prepare function
 2:  5703a9e93b =  2:  5703a9e93b object-file: rename files transaction fsync function
 3:  76204847f2 !  3:  70267741b0 object-file: embed transaction flush logic in commit function
    @@ Commit message
         subsequent commit, the transaction temporary directory is used to stage
         packfiles and not just loose objects anymore.
     
    -    Lift the helper function logic directly into
    -    `odb_transaction_files_commit()` to more accurately signal to readers
    -    the operation being performed.
    +    Lift the helper function logic into `odb_transaction_files_commit()` to
    +    more accurately signal to readers the operation being performed.
     
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
     
 4:  c97eb7763f =  4:  34cd3822c5 object-file: drop check for inflight transactions
 5:  1f3a1f7714 =  5:  240aa3475f object-file: propagate files transaction errors
 6:  09d13272d5 !  6:  0d91310fac odb/transaction: propagate begin errors
    @@ odb/transaction.c
      
     -	odb_source_begin_transaction(odb->sources, &odb->transaction);
     +	ret = odb_source_begin_transaction(odb->sources, out);
    -+	odb->transaction = *out;
    ++	if (!ret)
    ++		odb->transaction = *out;
      
     -	return odb->transaction;
     +	return ret;
 7:  12833d6773 =  7:  5e4680ed75 odb/transaction: propagate commit errors
 8:  f2586f2f34 !  8:  babcf6b156 odb/transaction: add transaction env interface
    @@ object-file.c: static int odb_transaction_files_commit(struct odb_transaction *b
     +{
     +	struct odb_transaction_files *transaction =
     +		container_of(base, struct odb_transaction_files, base);
    ++	int ret;
     +
    -+	odb_transaction_files_prepare(&transaction->base);
    -+	strvec_pushv(env, tmp_objdir_env(transaction->objdir));
    ++	ret = odb_transaction_files_prepare(&transaction->base);
    ++	if (!ret)
    ++		strvec_pushv(env, tmp_objdir_env(transaction->objdir));
     +
    -+	return 0;
    ++	return ret;
     +}
     +
      int odb_transaction_files_begin(struct odb_source *source,
 9:  9d082b5e47 !  9:  96f2a21eec odb/transaction: introduce ODB transaction flags
    @@ odb/transaction.c
      
     -	ret = odb_source_begin_transaction(odb->sources, out);
     +	ret = odb_source_begin_transaction(odb->sources, out, flags);
    - 	odb->transaction = *out;
    + 	if (!ret)
    + 		odb->transaction = *out;
      
    - 	return ret;
     
      ## odb/transaction.h ##
     @@
10:  e11d8a6676 = 10:  56718f1190 builtin/receive-pack: drop redundant tmpdir env
11:  fee57c2817 = 11:  5197a19fbf builtin/receive-pack: stage incoming objects via ODB transactions

base-commit: ab776a62a78576513ee121424adb19597fbb7613
-- 
2.55.0.122.gf85a7e6620

