Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35B515219B
	for <git@vger.kernel.org>; Fri,  3 May 2024 12:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714740084; cv=none; b=Ee7rYyvZ1zlPWL/DlZX30I2v7cl6iD7KThaABmRqg9QhjwlTh3AmrWBdphyIdHKEoIzGDSUODA7iQKb1tQPbLXUzcrFKj6XyPJ9mA038S8FIvy8hJyY3erzvXEoCDPsHK5eWXkezk/Kw+l7yokbFdcaE8tBGsejqTGARFIPtFWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714740084; c=relaxed/simple;
	bh=J3XeoV5nK4oO06ErdSoXYkZHupjSmcQ6E+RZ+e2434I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AOuPsaUUuQgDtygeDUEIu4KarJT93mkx0YOdsIhVXmFsmtxeWnOGEL6geOmH6rDzKd135YrANdflqJAmtApyKd6q54Y+ps0IE70yF8NsldH4lCu52/WDSC7VSgdFIuEhy4wGv46yHslyWlTk2j4mPRy7lbHnOluR57Skv+V00VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ks3hlRUt; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ks3hlRUt"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a58fbbcd77aso871356666b.2
        for <git@vger.kernel.org>; Fri, 03 May 2024 05:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714740081; x=1715344881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmW6xXSQ5+h67vylxhJjiPfg1sbJtAkdP1MeiqW3zzs=;
        b=ks3hlRUtIORTn6V6SGBzwBBSDEbFmlKV3fEXAdvZji7YCwBC3D7SwvL3LFG+4pYSY8
         ydrceubkXh96CJgk1/HJxDeTB2u4R4ta7QCUk2+x+cVJfhhDRJVuoCqzAUEk/PpPNcDl
         CD2ATGgRHiJe+Qn405QC5VmcwHrE6S7/J3h4bcFdgkaShy9d9sTKt71lXPbdAtuiKsnT
         +6TJJcS4duMs9hHQtNMtXQtlHtrne3UyWm6m8Rp9LUu4JTWNKuOb2A8/8Kt1+Ojxolgj
         B3j3/oUuQLh2hHcTCxQLHa4xLYapN2JX4GqN/KxtB1V+Twfy4fdmKYqbM3txCJsnxFwH
         XBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714740081; x=1715344881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kmW6xXSQ5+h67vylxhJjiPfg1sbJtAkdP1MeiqW3zzs=;
        b=QIwmKQEgJA9gVXc4dD51omJUHxKpGV7+FpxWtVmzvzQGgm29D6t7NJQYsx+1bSL/qX
         sy6O0XWfwBhr5Gt/KMmGpzdHdRCWk635fc1UavFHm2KbR7ZSMhXsRruOlQZsN1rFue9i
         H9VDn14WowgEFdpmaPk5jwMo00FqCryoT+iGYcS2TMQ7/a88ofcT5PBGU1IlzCzx+mp+
         a1hwWhWg4BxLKurb5swVjdNvl7b72nKG6Y7mCZdczN5VCqf/XAQD3zOF9cuozk0K/X5b
         qH5ZiIrDuPaGX3mcOgWYSZ3dkU0Zm630P2SHYTL57S6+spKVec/dypxpYB6qb5ozBvyy
         Eqkg==
X-Forwarded-Encrypted: i=1; AJvYcCW2RPDm5WF3/gN9dDB33E3Y6uuMrde74Fi+DVrTXmdfzR7bKfopTg6GAxV3uxAZZyPEIMuVjy/HKcUZEQ+KXhyu04Rz
X-Gm-Message-State: AOJu0YyRjnHF6z1F7Ks54uYgqPrF17R62tAC4Ec/jxoj6vcntAxY6IAE
	0YTDx4MwDVO0t00fOTO+taWBwOTjbVdO9Dyl9JT6tL2NP3dsK+MJ
X-Google-Smtp-Source: AGHT+IFwPvT1OtdGueRSQFyO5EPBWBYCBI6JUDjn7Na8MaSMl7ncGpOq/vDZ1s9ZmiYRbzeHQRxSzg==
X-Received: by 2002:a17:907:3ce:b0:a59:9b75:b8c with SMTP id su14-20020a17090703ce00b00a599b750b8cmr573837ejb.14.1714740080942;
        Fri, 03 May 2024 05:41:20 -0700 (PDT)
Received: from localhost.localdomain ([185.223.147.210])
        by smtp.gmail.com with ESMTPSA id ot38-20020a170906cce600b00a5994c5c948sm533323ejb.133.2024.05.03.05.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 05:41:20 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v6 3/7] refs: support symrefs in 'reference-transaction' hook
Date: Fri,  3 May 2024 14:41:11 +0200
Message-ID: <20240503124115.252413-4-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240503124115.252413-1-knayak@gitlab.com>
References: <20240501202229.2695774-1-knayak@gitlab.com>
 <20240503124115.252413-1-knayak@gitlab.com>
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
index 47bc9dd103..203a101988 100644
--- a/refs.c
+++ b/refs.c
@@ -2350,10 +2350,22 @@ static int run_transaction_hook(struct ref_transaction *transaction,
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

