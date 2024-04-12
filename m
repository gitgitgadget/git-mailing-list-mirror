Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5C654656
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 09:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712915971; cv=none; b=m0WTdN5Vg7wnnq/me/TBVqUisOekWpCqrAD7xlupdEFJ3wtXAaNAE8TISJ2/9Vm7d4y6wlIu0JwGgZIh/8s55I7YRCFSF6T3lwtuViFznalPYBlAOgBkGDKHdXuqVRLy+3+ZWPDHd5Y0YcfjUF42pT6Q9h9ZnPxoaFIcuewM8zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712915971; c=relaxed/simple;
	bh=Gm4YFFDuA0e7F7KY8uRuhGwbFNAJymmeTFwkCm7ZkIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJcu53UhXYSO0sEqrGXOLiCQoD/evPQQ4Yqw6sXzQeFiYmx01FFKmKdMOgvTSKDbv73ELHkWDdLImYg7qNR2OQ4u7varP2sAsZG9j9jJtfIAOQSQKhfiRg4fb2reNxsWEjo0xyuQaZEYa99HiTnFLicfosfi7pAwh4m3WJmRYIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1tOQYi1; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1tOQYi1"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56e1baf0380so744460a12.3
        for <git@vger.kernel.org>; Fri, 12 Apr 2024 02:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712915968; x=1713520768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bc862XlvhnxLy4PdKcXE3TkVgoH51vn9JJWMS3/mq4c=;
        b=E1tOQYi1wAE15ZMyXZ1XkdlxasErt3P5Xh06ewGwqz5UbMu7WhSO6EE5WBTEq+v3uP
         djIyopZDAJr69vZzgbm2CwQPsjxzdJD9QBqEHgR4nxUXRZUDTNBSf92HwBECu6r7a2/p
         T1YQWRCILWn3K6jEzJz/TFIsbw00cw2SZYniFfKaDGGU2UkG5RGNmfnzWNvOb00xbR0i
         qYv80L8MnP86NXkV2eXb6ccyUE8+NSgSZIG40qQxRvgoyH1f2tSvvzF0E2BWEjw8n7No
         t0FZx0NpTGjx1HooFkbzP5pRJIvnQVQ43AWKr6XTxUHIqTEefCwzbH+nzpN98SkYKjhE
         vSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712915968; x=1713520768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bc862XlvhnxLy4PdKcXE3TkVgoH51vn9JJWMS3/mq4c=;
        b=UyaUFmVua6yg9j6gH7+aTfLjaxbcwMR+T26Au2+ePRFj7wd9eVkGyqi97FTt+BWz1q
         zjWNhGnrde6rQQyLo9DVRCBb4eMK+/txZoyqiXdR0QCHMbngjwjUAWNR1BXgkvqbM+Mg
         eqqFS7aSxk88UUraIg9lSQcaM2y7GXRPD/9kXDloQ7WDwE+9vDylkEMY5T4AgdMnLwCg
         a3F9L1H/ou/jdoAlwVqsYbDJ/vCkV866a1aFI/hLfpyVIl6jX6u0I8kdpiOMGmv2Qkhb
         I2xPSZZsaoRGUDe3gIe6nib/lUyxdxvDYsm547U+2pv56M+ziRjTTZRdockLjf8rR7jJ
         fEjA==
X-Forwarded-Encrypted: i=1; AJvYcCXxuMSV4csA/nfAIdUiYnjGoXQu+26w7KjLjef2hL2ku/+wrTcKgnBk8gcQ7Juem/D1fT7KJIzqAXHGvXzlciuI+eke
X-Gm-Message-State: AOJu0Yx5iplWEe53xnxesvliHHWfQhcvFFgbEiEZGcO18yh6Hfnjurh5
	q32+CRMN2uT8f+GKIvikuV6H52E1+obVeDkWQ8W4s/GHGdV/7q5y
X-Google-Smtp-Source: AGHT+IEM7kGPzpUCj68XlaNZCrIIB4K2wfCpu151iOOL2p1tyWQZxI09iiMU3k2foJwbeZUu5QiGDA==
X-Received: by 2002:a50:9fc8:0:b0:56e:3293:3772 with SMTP id c66-20020a509fc8000000b0056e32933772mr1417718edf.29.1712915968246;
        Fri, 12 Apr 2024 02:59:28 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:355c:c013:66aa:c838])
        by smtp.gmail.com with ESMTPSA id et4-20020a056402378400b0056e67f9f4c3sm1498552edb.72.2024.04.12.02.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 02:59:27 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: chris.torek@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v2 7/7] refs: support symrefs in 'reference-transaction' hook
Date: Fri, 12 Apr 2024 11:59:08 +0200
Message-ID: <20240412095908.1134387-8-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412095908.1134387-1-knayak@gitlab.com>
References: <20240330224623.579457-1-knayak@gitlab.com>
 <20240412095908.1134387-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

The 'reference-transaction' hook runs whenever a reference update is
made to the system. In the previous commits, we added support for
various symref commands in `git-update-ref`. While it allowed us to now
manipulate symbolic refs via `git-update-ref`, it didn't activate the
'reference-transaction' hook.

Let's activate the hook for symbolic reference updates too. There is no
new format described for this and we stick to the existing format of:
    <old-value> SP <new-value> SP <ref-name> LF
but now, <old-value> and <new-value> could also denote references
instead of objects.

While this seems to be backward incompatible, it is okay, since the only
way the `reference-transaction` hook has refs in its output is when
`git-update-ref` is used with `update-symref` command. Also the
documentation for reference-transaction hook always stated that support
for symbolic references may be added in the future.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---

We did initially discuss the possibility of having {symref-<command>} as
the prefix [1]. But this information is not propagated through the system
and we don't know which command is actually registering at the hook. We
could use flags for propagating this, but this simply complicates things.

I then thought of adding 'symref' prefix to the symref updates. But I
realized that that is no different from not having the symref prefix, because
even 'symref' prefix entries received by the hook as input could contain
either object IDs or refnames, like updating a regular ref to a symref. So
the hook needs to dynamically read inputs anyways. So might as well keep the
current syntax.

[1]: https://lore.kernel.org/git/CAOLa=ZTLv39b4Q=AAUA39tXKgOSuu54xk3-r9OUenzxR-6qcag@mail.gmail.com/

 Documentation/githooks.txt       | 13 ++++++----
 refs.c                           | 17 ++++++++-----
 t/t1416-ref-transaction-hooks.sh | 41 ++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 11 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index ee9b92c90d..1db5ab02d6 100644
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
@@ -503,16 +503,19 @@ given reference transaction is in:
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
+fields could denote references instead of objects.
+
 The exit status of the hook is ignored for any state except for the
 "prepared" state. In the "prepared" state, a non-zero exit status will
 cause the transaction to be aborted. The hook will not be called with
diff --git a/refs.c b/refs.c
index 31c09c3317..010f426def 100644
--- a/refs.c
+++ b/refs.c
@@ -2362,15 +2362,20 @@ static int run_transaction_hook(struct ref_transaction *transaction,
 
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
+		const char *new_value, *old_value;
 
-		if (update->flags & REF_SYMREF_UPDATE)
-			continue;
+		new_value = oid_to_hex(&update->new_oid);
+		old_value = oid_to_hex(&update->old_oid);
+
+		if (update->flags & REF_SYMREF_UPDATE) {
+			if (update->flags & REF_HAVE_NEW && !null_new_value(update))
+				new_value = update->new_ref;
+			if (update->flags & REF_HAVE_OLD && update->old_ref)
+				old_value = update->old_ref;
+		}
 
 		strbuf_reset(&buf);
-		strbuf_addf(&buf, "%s %s %s\n",
-			    oid_to_hex(&update->old_oid),
-			    oid_to_hex(&update->new_oid),
-			    update->refname);
+		strbuf_addf(&buf, "%s %s %s\n", old_value, new_value, update->refname);
 
 		if (write_in_full(proc.in, buf.buf, buf.len) < 0) {
 			if (errno != EPIPE) {
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index 2092488090..104e2c5da4 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -108,6 +108,10 @@ test_expect_success 'hook gets all queued updates in aborted state' '
 	test_cmp expect actual
 '
 
+# This test doesn't add a check for 'symref-delete' since there is a
+# variation between the ref backends WRT 'delete'. In the files backend,
+# 'delete' also triggers an additional transaction update on the
+# packed-refs backend, which constitutes additional reflog entries.
 test_expect_success 'interleaving hook calls succeed' '
 	test_when_finished "rm -r target-repo.git" &&
 
@@ -134,4 +138,41 @@ test_expect_success 'interleaving hook calls succeed' '
 	test_cmp expect target-repo.git/actual
 '
 
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
+		refs/heads/main $ZERO_OID refs/heads/symref
+		$ZERO_OID refs/heads/main refs/heads/symrefc
+		refs/heads/main refs/heads/branch refs/heads/symrefu
+		committed
+		refs/heads/main $ZERO_OID refs/heads/symref
+		$ZERO_OID refs/heads/main refs/heads/symrefc
+		refs/heads/main refs/heads/branch refs/heads/symrefu
+	EOF
+
+	git update-ref --no-deref --stdin <<-EOF &&
+		start
+		symref-verify refs/heads/symref refs/heads/main
+		symref-create refs/heads/symrefc refs/heads/main
+		symref-update refs/heads/symrefu refs/heads/branch refs/heads/main
+		prepare
+		commit
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.43.GIT

