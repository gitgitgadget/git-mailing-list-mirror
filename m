Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BB4165FC5
	for <git@vger.kernel.org>; Wed,  1 May 2024 20:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714594959; cv=none; b=E+w4Li7LLI5hrTlpaPXtenMylQUxxdeo5yCbU5bZFhm1GxSXFfDAOKig0iTrKJrC9gSgkxZwy34l2oWpQ/rLjfWcfxsGNCEnbqyG+Zdgfecpd2JnecFOOHeuOrraPPzG+tQube9bwUKod6yFYPE0J+Rgn2HQGKGKWXrCdHra/0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714594959; c=relaxed/simple;
	bh=tNau28/kWT7gWuGq0I2i4h/8J6eVOH+t1b5X3K5eur8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zrx0DH8xwqhDHLdv+xcPrBU2ypm6y/qZJkhafymBkeck4iY4RF12ZLS4y+IXS1W3e0v8GINxO8R89fuM7hTBvuFudkHoC2sVYUm3mFxvYPUqhr6IkU3LtuR8o4QrtPthKSjW525GwFDYPvS9FzhWZa4hsmS6+lau+8S4qnqR73M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBuuvR/f; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBuuvR/f"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a58e7628aeaso595005566b.2
        for <git@vger.kernel.org>; Wed, 01 May 2024 13:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714594956; x=1715199756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDBi/vh6nevrE2yhPPWTvhbAx3BXNhEFjWktKsy6gac=;
        b=EBuuvR/fGygzeHCODijwttJviKA/6qwv5DPaXp72qRm6bm5oRawOmB2YAV04vIpvim
         mxuyl7XkZrwfQqGHmHjF+88HwRjsKZ3mbIxaZLf6bnQg3ml6gOiOUBXgGGIA4RxwszXv
         m2zAjcNbqLtne5w7WZOXAELl+sdrqb6V1uh0oPxj06b4vxV6tlsQg5Lt0XEpKW+rzNfw
         rsACSfGPbCnk62NJn8HvJFsGSnWybpGmR8RY6NtLdGB7JZjswwznj9ss4o3vWlE7BtCk
         dwMPZDbkk0JyUSWKu3BxuMpthOvaq+D7oUxzUut7PPAqex3tjK+SvqX30VUVkhx9NOEL
         vpxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714594956; x=1715199756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDBi/vh6nevrE2yhPPWTvhbAx3BXNhEFjWktKsy6gac=;
        b=Owce5wLYR0gs/0A4/5XhGcMcEWyvdMs1BObRwfFZYYwGyrl/fXgFqjZaxQl3boWO1X
         h3HJIudZNdIcsme3fQ/BwQCtAa1dKeCjZrSN+p2gRTsCUaLK/BGxC0FJA7D5dincEVMz
         CLobq6OJ5KRrR4dAhLwCkjurHH2eoYo7U40oOyyta2m78mn0lcUH6qq9a+etI/+utQxw
         VbDD6L9H7nZL90bmxhK9rmqFb+o0Z5zeK3Xt+kGEZTC9N+NcUNvvGgroQ/ANkcq4pzxL
         fii3SmfXb07BwCjgJkaFh+1zK0cXmqNgJMB/rqBUNVCm3gs888yCCdbLPYo7JFuaNvRB
         i7yw==
X-Forwarded-Encrypted: i=1; AJvYcCUzGtOt6Kg++jFM7xzbXz3i1u/DQNZUuR5iwVENxKfNx5bvFPh0DoqM7+CpFtdVv7Uoxp8Bt5gQRqO9uiSsa8u/PMRp
X-Gm-Message-State: AOJu0Ywue1MUILklr/7SQbRPd1Kojtc5TDlMj4RtVtUgYgtMhErdRrlG
	N+pv1M0fECKi6L4jyPcQHnBDOrL4hO7FrKsgWO9EHLzk4P0kMN5W2aEeaQ==
X-Google-Smtp-Source: AGHT+IHbaTmj1CiGcWn8FRtTJ9+sBb+DjCpqcjbnNnMRaReuXnSR0dDI7JdRcSILiaTqwx5yAonfEg==
X-Received: by 2002:a17:906:c791:b0:a58:e969:1435 with SMTP id cw17-20020a170906c79100b00a58e9691435mr2372179ejb.56.1714594956196;
        Wed, 01 May 2024 13:22:36 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:8270:9642:2bfa:e177])
        by smtp.gmail.com with ESMTPSA id hg25-20020a170906f35900b00a58eec6f5acsm5290686ejb.102.2024.05.01.13.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 13:22:35 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v5 3/7] refs: support symrefs in 'reference-transaction' hook
Date: Wed,  1 May 2024 22:22:25 +0200
Message-ID: <20240501202229.2695774-4-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240501202229.2695774-1-knayak@gitlab.com>
References: <20240426152449.228860-1-knayak@gitlab.com>
 <20240501202229.2695774-1-knayak@gitlab.com>
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
 refs.c                     | 16 ++++++++++++----
 2 files changed, 21 insertions(+), 9 deletions(-)

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
index 47bc9dd103..5dfe93060a 100644
--- a/refs.c
+++ b/refs.c
@@ -2350,10 +2350,18 @@ static int run_transaction_hook(struct ref_transaction *transaction,
 		struct ref_update *update = transaction->updates[i];
 
 		strbuf_reset(&buf);
-		strbuf_addf(&buf, "%s %s %s\n",
-			    oid_to_hex(&update->old_oid),
-			    oid_to_hex(&update->new_oid),
-			    update->refname);
+
+		if (update->flags & REF_HAVE_OLD && update->old_target)
+			strbuf_addf(&buf, "ref:%s ", update->old_target);
+		else
+			strbuf_addf(&buf, "%s ", oid_to_hex(&update->old_oid));
+
+		if (update->flags & REF_HAVE_NEW && update->new_target)
+			strbuf_addf(&buf, "ref:%s ", update->new_target);
+		else
+			strbuf_addf(&buf, "%s ", oid_to_hex(&update->new_oid));
+
+		strbuf_addf(&buf, "%s\n", update->refname);
 
 		if (write_in_full(proc.in, buf.buf, buf.len) < 0) {
 			if (errno != EPIPE) {
-- 
2.43.GIT

