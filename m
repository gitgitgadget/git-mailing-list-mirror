Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E5C144303
	for <git@vger.kernel.org>; Tue, 23 Apr 2024 21:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713907713; cv=none; b=Y+tLHN4rAXfpue3/WG76G2RkYW45NKGLibo4K4AEXLlSAptdAbX4YB06DUloBVradCtFOVthW4Xkx3oUAaFpRfxVZI51mvKbwhRtym+EZ60mOgGKDN6QVapc74iCdUPwGX0nJ7LVN4T/SRQXKKY18lTgMaqPWKJ8b6ZfsulqzIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713907713; c=relaxed/simple;
	bh=6r0yQ70bduEocKoDsIHvb8qrURky95sisuMv7OYIrZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C7Tb8GnPCg+KDZxCOj4cyhMjomm7TmWQpgfuDYdnaUTW/7/YQAhJ3dEf7kVDT1JdEM8jarstguK+AXbDwdkvU6lalBKn4ZJfwPtiaop7S1l3p4qPrRjjfbzQIu3gTf9Owk9r60wRr1CAvx4KDRZ5TildASUTPGhFssK1GZftJPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XPitFhs+; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPitFhs+"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a519e1b0e2dso712857766b.2
        for <git@vger.kernel.org>; Tue, 23 Apr 2024 14:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713907710; x=1714512510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q42Vdyip1qfE4ddcpzduG9+YyyuKi5i6SWIVglG/zv0=;
        b=XPitFhs+0SQbwvM9+MbUS3jXhXHZHqe8uqU1rLWSlDSQdo5y87BFy/1E2y5zdENs+i
         6gQi+f56hcM2r4i+e28UsvASIQu4b/h6GNTtAnqihBs6ZjY8LtWap3iBRYLygOMPe01w
         3ZjBZafgKF0HQRes6BuBZbpsoYP+JRm9NZUALHlbxibzaJTvPzOOWtKo1HQ8lRocEgw6
         uDiZO5/fEm4ll95OYdGvV/rni6kowLBcbJd6DWUdsskaC7qFV051uZ06B7ow1weL+1gI
         tdFC6R/1me4DkHrXbEj2kH2P96eTf5Rt+BgmHkGRBrjSuo8HjWULJOFXYYQfUNaohLhM
         pNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713907710; x=1714512510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q42Vdyip1qfE4ddcpzduG9+YyyuKi5i6SWIVglG/zv0=;
        b=ULYGRqZs8cMI59iNXN+8sLpPf6dC4bG6/Y19tLBXdwiNFPwr+Rg97dvMOK0G7zOQqc
         gFYo5dFhLBzmV7EGIr2OiZFebCLCM+ppwN8z6RIiX7BkfMLRPCzqeymYjP+z7fAM49pp
         nMJjz7BelVBYlD/w+vEtiRw2xQ2d8+UL8Euzk7MW3VJK4vTiQc1akmOHbQVbN6iYTigD
         D1MkfQNURI081PV0jAUAgTKldTayIqID4BxxlT9OWN88Ql3+A0rt4BmVuEwMS0JC4STv
         qGiFEQ29vBOVzhLmyJz2SXD6+3uHbsjGuXrhuPHGOL5+Q2i5ZD8+fHGwAwvRPiMWiKMl
         EHfA==
X-Forwarded-Encrypted: i=1; AJvYcCUHIODe1XLjEDRiCj5iXdhM6N6xSYX99TXVtC0Izk4Lzu+LUSYL/GODSxeWfLCeW+5N7Sc4jGIlScnLznNo6U6tRQZe
X-Gm-Message-State: AOJu0YyCMWf10C/LBSh+IZJqZQKQJ18jzhpeh5f1RlOLQWQ15P1/NA9D
	Kh43sWUknpOTGu3NXmb5Noq0TX1hmviTC2yRJXtZAGjdPofU7gMxDOA1uQ==
X-Google-Smtp-Source: AGHT+IE1MX+X1dJasoxI/HOZEpmZvfM0GHAOu8ia3w/G8D7QOBB5m8MqYIBORo45DBxUF2HCKfe9ig==
X-Received: by 2002:a17:906:2412:b0:a55:5a0a:a74b with SMTP id z18-20020a170906241200b00a555a0aa74bmr379043eja.33.1713907709797;
        Tue, 23 Apr 2024 14:28:29 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:23ba:342:e06:b489])
        by smtp.gmail.com with ESMTPSA id f17-20020a17090660d100b00a587236e646sm1864275ejk.174.2024.04.23.14.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 14:28:29 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: chris.torek@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v3 8/8] ref: support symrefs in 'reference-transaction' hook
Date: Tue, 23 Apr 2024 23:28:18 +0200
Message-ID: <20240423212818.574123-9-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423212818.574123-1-knayak@gitlab.com>
References: <20240412095908.1134387-1-knayak@gitlab.com>
 <20240423212818.574123-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

The 'reference-transaction' hook runs whenever a reference update is
made to the system. In the previous commits, we added symref support for
various commands in `git-update-ref`. While it allowed us to now
manipulate symbolic refs via `git-update-ref`, it didn't activate the
'reference-transaction' hook.

Let's activate the hook for symbolic reference updates too. There is no
new format described for this and we stick to the existing format of:
    <old-value> SP <new-value> SP <ref-name> LF
but now, <old-value> and <new-value> could also denote references
instead of objects, where the format is similar to that in
'git-update-ref', i.e. 'ref:<ref-target>'.

While this seems to be backward incompatible, it is okay, since the only
way the `reference-transaction` hook has refs in its output is when
`git-update-ref` is used to manipulate symrefs. Also the documentation
for reference-transaction hook always stated that support for symbolic
references may be added in the future.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/githooks.txt       | 14 +++++++----
 refs.c                           | 21 ++++++++--------
 t/t1416-ref-transaction-hooks.sh | 41 ++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 15 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index ee9b92c90d..0bf8ca87a6 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -486,7 +486,7 @@ reference-transaction
 This hook is invoked by any Git command that performs reference
 updates. It executes whenever a reference transaction is prepared,
 committed or aborted and may thus get called multiple times. The hook
-does not cover symbolic references (but that may change in the future).
+also cover symbolic references.
 
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
+fields could denote references instead of objects, denoted via the
+`ref:<ref-target>` format.
+
 The exit status of the hook is ignored for any state except for the
 "prepared" state. In the "prepared" state, a non-zero exit status will
 cause the transaction to be aborted. The hook will not be called with
diff --git a/refs.c b/refs.c
index 42cb4126a7..9a510744a7 100644
--- a/refs.c
+++ b/refs.c
@@ -2365,18 +2365,19 @@ static int run_transaction_hook(struct ref_transaction *transaction,
 
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
+		strbuf_reset(&buf);
 
-		/*
-		 * Skip reference transaction for symbolic refs.
-		 */
-		if (update->new_target || update->old_target)
-			continue;
+		if (update->flags & REF_HAVE_OLD && update->old_target)
+			strbuf_addf(&buf, "ref:%s ", update->old_target);
+		else
+			strbuf_addf(&buf, "%s ", oid_to_hex(&update->old_oid));
 
-		strbuf_reset(&buf);
-		strbuf_addf(&buf, "%s %s %s\n",
-			    oid_to_hex(&update->old_oid),
-			    oid_to_hex(&update->new_oid),
-			    update->refname);
+		if (update->flags & REF_HAVE_NEW && update->new_target)
+			strbuf_addf(&buf, "ref:%s ", update->new_target);
+		else
+			strbuf_addf(&buf, "%s ", oid_to_hex(&update->new_oid));
+
+		strbuf_addf(&buf, "%s\n", update->refname);
 
 		if (write_in_full(proc.in, buf.buf, buf.len) < 0) {
 			if (errno != EPIPE) {
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index 2092488090..abd4777819 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -134,4 +134,45 @@ test_expect_success 'interleaving hook calls succeed' '
 	test_cmp expect target-repo.git/actual
 '
 
+# This test doesn't add a check for symref 'delete' since there is a
+# variation between the ref backends WRT 'delete'. In the files backend,
+# 'delete' also triggers an additional transaction update on the
+# packed-refs backend, which constitutes additional reflog entries.
+test_expect_success 'hook gets all queued symref updates' '
+	test_when_finished "rm actual" &&
+
+	git update-ref refs/heads/branch $POST_OID &&
+	git symbolic-ref refs/heads/symref refs/heads/main &&
+	git symbolic-ref refs/heads/symrefu refs/heads/main &&
+
+	test_hook reference-transaction <<-\EOF &&
+		echo "$*" >>actual
+		while read -r line
+		do
+			printf "%s\n" "$line"
+		done >>actual
+	EOF
+
+	cat >expect <<-EOF &&
+		prepared
+		ref:refs/heads/main $ZERO_OID refs/heads/symref
+		$ZERO_OID ref:refs/heads/main refs/heads/symrefc
+		ref:refs/heads/main ref:refs/heads/branch refs/heads/symrefu
+		committed
+		ref:refs/heads/main $ZERO_OID refs/heads/symref
+		$ZERO_OID ref:refs/heads/main refs/heads/symrefc
+		ref:refs/heads/main ref:refs/heads/branch refs/heads/symrefu
+	EOF
+
+	git update-ref --no-deref --stdin <<-EOF &&
+		start
+		verify refs/heads/symref ref:refs/heads/main
+		create refs/heads/symrefc ref:refs/heads/main
+		update refs/heads/symrefu ref:refs/heads/branch ref:refs/heads/main
+		prepare
+		commit
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.43.GIT

