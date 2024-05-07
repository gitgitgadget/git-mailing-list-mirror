Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B5E6EB7A
	for <git@vger.kernel.org>; Tue,  7 May 2024 06:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715061650; cv=none; b=etvc1tYFBaUhkAT85+NuxFgThUtPAUmu+usmVL7I5C4j7FcD7IJvPtqGmlva1Mbc0CzyZ/73ufElwhdYWh7/y1v2Ig58OaKzv/R4j+ycJul6j1e+4lKn0nczUe8uTlqEN1N8YH7qlFmoUnBVewfKzMDjc6mmDQPsPNmitkMwfaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715061650; c=relaxed/simple;
	bh=7Pf1fx0P4z980EmQ+ovkbhphpSd8ZE2uzC7W9ZQebKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eDCA+VVj3BfEpEy4+uQb3/9MQe3uVS95TXNSJJieYazX6i1lAByr1CDRJ5xijz8uJzXbxfmfqBiEP5ADat+XVpVsKhBMp8xUC9arj/eHeFFjdCv8ScKXlM05ULVqO6ylrGpeo4EyCPnT+uL4d0bTN8GYAGoSUHm85ZNcUzqQyc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A309qOWK; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A309qOWK"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a59ece5e18bso65185966b.2
        for <git@vger.kernel.org>; Mon, 06 May 2024 23:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715061647; x=1715666447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P02ZmJE6RNT/N2lLFf2c/XtYHhmAMQqkNxwNabNxb/g=;
        b=A309qOWKMb0fZ9TuHTvGuMCEHPULt9MCrYukF1Om5H8tvV7XFV0aRgUqhHuhkz5hbJ
         OAUjQEGT2+N2cT4Zpm3wzG0A0X/+ZK+j6Bgp6r7YsmeZ0PJ8G053jNZDZ8hEuO6CHBRZ
         fWDOi7vI73ClaNsjKRuscCuJMZuzRhimEHp1tnaock8PC52r36f/k3dmxcLKfXTWUoLH
         Kzho1F8M95UQf7irCnju1KvQWZvshxlCk9Q5aOlpWURJx+jTF3S9fRIkHD4wfgqy2mUG
         cpzK3JZjjjjeqL5M4xoqoneeExiheitinkOOBmi+wQ5nIfdLiOB0MXZALBi3AvVIBb8y
         Rrqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715061647; x=1715666447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P02ZmJE6RNT/N2lLFf2c/XtYHhmAMQqkNxwNabNxb/g=;
        b=CN9BkB7nhODy1tilJPBFfYnmixmbEKBAAvRHVUplDXDtzrf/VTCoUV/QGYm1MTJXsD
         I5tQTxq86FfOM4so9oEwtxzqRCZp2Sfm5BardojK3E7yXPHxjkH4eyAwcBlKKSL5R5zr
         0h4SAUylhjVmIKGTCba3CzKoQ5OmoxxmhKo2zh/XojVUkVxUOfc+YxJPQs9L4PkR6j2Y
         004y43XcooBYIGI21ts8jA/ULmwid939o/yvqhnHW36VTJb9n+r7hy3mTmuHpawokaAm
         pJs5wCio9m/q+stidT3MMvlXd/gYC+NdtgV+uwD9hHf1z5lRmnuDpEe6muReWxYLT1he
         6KwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrO6jSwcd3NpzujFECfixcGRS7lxkT3SYNJ7xqgBatXNymctSnkdN+xmdS5+ECGoqcIL9dasTV4NfIpi3ASR4SJADf
X-Gm-Message-State: AOJu0YwixEJ1Wun0l7rRHwrmnFFPwxEOAtjO6QO0bP79AxQf6B2VsFI8
	MiGONB8trIWUT5piKHy5e6uYVy58HudIhp18+eSzPVL8YunH8NtF
X-Google-Smtp-Source: AGHT+IE0MzIbUSGMhN9zqcmXjDTeGJfapTNVCAA61CpgqQLc65Pk/tW7NBHI7DDOI2mqZjWR0INmmA==
X-Received: by 2002:a17:906:3cf:b0:a59:efff:e795 with SMTP id c15-20020a17090603cf00b00a59efffe795mr761621eja.59.1715061646730;
        Mon, 06 May 2024 23:00:46 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:1aa1:adf2:4cd1:ebdc])
        by smtp.gmail.com with ESMTPSA id y27-20020a1709060a9b00b00a59baca79basm3066691ejf.60.2024.05.06.23.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 23:00:46 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im,
	phillip.wood123@gmail.com
Subject: [PATCH v7 3/8] refs: support symrefs in 'reference-transaction' hook
Date: Tue,  7 May 2024 08:00:30 +0200
Message-ID: <20240507060035.28602-4-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240507060035.28602-1-knayak@gitlab.com>
References: <20240503124115.252413-1-knayak@gitlab.com>
 <20240507060035.28602-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

The 'reference-transaction' hook runs whenever a reference update is
made to the system. In a previous commit, we added the `old_target` and
`new_target` fields to the `reference_transaction_update()`. In
following commits we'll also add the code to handle symref's in the
reference backends.

Support symrefs also in the 'reference-transaction' hook, by modifying
the current format:
    <old-oid> SP <new-oid> SP <ref-name> LF
to be be:
    <old-value> SP <new-value> SP <ref-name> LF
where for regular refs the output would not change and remain the same.
But when either 'old-value' or 'new-value' is a symref, we print the ref
as 'ref:<ref-target>'.

This does break backward compatibility, but the 'reference-transaction'
hook's documentation always stated that support for symbolic references
may be added in the future.

We do not add any tests in this commit since there is no git command
which activates this flow, in an upcoming commit, we'll start using
transaction based symref updates as the default, we'll add tests there
for the hook too.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/githooks.txt | 14 +++++++++-----
 refs.c                     | 20 ++++++++++++++++----
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index ee9b92c90d..06e997131b 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -486,7 +486,7 @@ reference-transaction
 This hook is invoked by any Git command that performs reference
 updates. It executes whenever a reference transaction is prepared,
 committed or aborted and may thus get called multiple times. The hook
-does not cover symbolic references (but that may change in the future).
+also supports symbolic reference updates.
 
 The hook takes exactly one argument, which is the current state the
 given reference transaction is in:
@@ -503,16 +503,20 @@ given reference transaction is in:
 For each reference update that was added to the transaction, the hook
 receives on standard input a line of the format:
 
-  <old-oid> SP <new-oid> SP <ref-name> LF
+  <old-value> SP <new-value> SP <ref-name> LF
 
-where `<old-oid>` is the old object name passed into the reference
-transaction, `<new-oid>` is the new object name to be stored in the
+where `<old-value>` is the old object name passed into the reference
+transaction, `<new-value>` is the new object name to be stored in the
 ref and `<ref-name>` is the full name of the ref. When force updating
 the reference regardless of its current value or when the reference is
-to be created anew, `<old-oid>` is the all-zeroes object name. To
+to be created anew, `<old-value>` is the all-zeroes object name. To
 distinguish these cases, you can inspect the current value of
 `<ref-name>` via `git rev-parse`.
 
+For symbolic reference updates the `<old_value>` and `<new-value>`
+fields could denote references instead of objects. A reference will be
+denoted with a 'ref:' prefix, like `ref:<ref-target>`.
+
 The exit status of the hook is ignored for any state except for the
 "prepared" state. In the "prepared" state, a non-zero exit status will
 cause the transaction to be aborted. The hook will not be called with
diff --git a/refs.c b/refs.c
index d7df137904..2bb3e09425 100644
--- a/refs.c
+++ b/refs.c
@@ -2366,10 +2366,22 @@ static int run_transaction_hook(struct ref_transaction *transaction,
 		struct ref_update *update = transaction->updates[i];
 
 		strbuf_reset(&buf);
-		strbuf_addf(&buf, "%s %s %s\n",
-			    oid_to_hex(&update->old_oid),
-			    oid_to_hex(&update->new_oid),
-			    update->refname);
+
+		if (!(update->flags & REF_HAVE_OLD))
+			strbuf_addf(&buf, "%s ", oid_to_hex(null_oid()));
+		else if (update->old_target)
+			strbuf_addf(&buf, "ref:%s ", update->old_target);
+		else
+			strbuf_addf(&buf, "%s ", oid_to_hex(&update->old_oid));
+
+		if (!(update->flags & REF_HAVE_NEW))
+			strbuf_addf(&buf, "%s ", oid_to_hex(null_oid()));
+		else if (update->new_target)
+			strbuf_addf(&buf, "ref:%s ", update->new_target);
+		else
+			strbuf_addf(&buf, "%s ", oid_to_hex(&update->new_oid));
+
+		strbuf_addf(&buf, "%s\n", update->refname);
 
 		if (write_in_full(proc.in, buf.buf, buf.len) < 0) {
 			if (errno != EPIPE) {
-- 
2.43.GIT

