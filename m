Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792556252;
	b=bnej7El3ruGr+kXH3UOTXnuBXeZaxAai2p/NxBl1z6YDllmV2m+jJDkgRT+SxscfUhDR
	 lHOtLOyQDg/E5HiV7+Mzh4GkCY7wsZRrWtChb2/BWAV/zHR7KbORsoNSsK+oLNQtTiL9X
	 Hy/Dn30CLsz9TeyY3P6ewtS+SIaCNgmi8q0ocvuwFZHE7t4cgFghojgoEW+RCgqUgtUwl
	 lTmXS7FRkD0l2GmZy2YS9SjQtTPl32Q47kpj9Q29CnzDoH11nIFjkx5tG4l/Z6JctGRKT
	 TkNM5evU1TP+5fdwYMtnBdFiKr9U+a/0eK5B88QF+EEFNRhRarjM6fJ4xPBF2R1AxjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792556252;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=JNYq49Bs6zTTHEPSexhDpZx2drihiZMO7rw3GdBUEKg=;
	b=clcW/2OW0awVl02f4UimpSmNK+fWwQw5rShdrFIfVllVGlMhGvVEIDOrxxB2pD6AO727
	 uekDRnH66D74m3plMR7rRqQTMM9wXgCkjyVkO5FgQZ5XXPJktzFDoD8sjPk9kAJTBp7kv
	 KltXgq/xqjnSSBKbcto7akK6IluDhzv8qyDpwErUu/NdLMDjkQ4GgzOtHzqcvVN6zDdnj
	 wRrQd/rmTMQlWA/nUAWZgCiksw7PibzztYQ1yqQbZyDMkKiYjCdNjdDSTeeoDYzkxhf0q
	 EvhriQVZy+WAfEZFzdKMV5dTs9LQLHFI4rZxINoKqZFAkVnUI79fVihrqD9Iq1XAXIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nortesoftware.dev;
	spf=pass smtp.mailfrom=nortesoftware.dev;
	dkim=pass header.d=nortesoftware.dev header.i=@nortesoftware.dev header.a=rsa-sha256 header.s=google header.b=GfPSsaRd;
	arc=none smtp.remote-ip=209.85.210.51
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562F4606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 04:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 562F4606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nortesoftware.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nortesoftware.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nortesoftware.dev header.i=@nortesoftware.dev header.a=rsa-sha256 header.s=google header.b=GfPSsaRd
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-823e4047037so244608a34.2
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 21:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nortesoftware.dev; s=google; t=1792556251; x=1793161051; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JNYq49Bs6zTTHEPSexhDpZx2drihiZMO7rw3GdBUEKg=;
        b=GfPSsaRdvU8OXRy30zYJT9bREhz8OSuwwZfcRRvbG/177kJskfcdQgFQSF4+SgV52D
         /iECaJm4aSBO+9/utgThbdZxpdS/WHwLwKPumzcbtWPNOWigG8zM9nH71mjGMLOWJbap
         ZEtaIfO4avl+4E2DYsxL1lu5e2Xh1Eubgv6XCmATxRf4Q2ITyW7r5KO2gWzlIEAdjnAL
         ZPqu7RgkggcMFuX97h3l7cQS+P8Oqbacs9KtezOJmByNfVwdWcu5LAIc1cecd6dNZAyd
         7rfxlaDsaHm20DzX/H8WBEqh/USqpNGPXAf4u3T/YAJQ/Z7/NYoLpDAL1gQRRinlsXxq
         y2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792556251; x=1793161051;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JNYq49Bs6zTTHEPSexhDpZx2drihiZMO7rw3GdBUEKg=;
        b=Mg0cu/du2cF6XbZNPOS12+xVSGh8EM3+xR7q8wpwqXb3nYO1ps0aJX21FFPxiR9QO+
         7Z7KBSHCyjDvT1S5QmPFH8KEls6LkNAaBGMzpYxB8DpHn+Lo12IxQ7g8epUcA7U9XBBY
         UR3ek011LGL17E01mnlHvTI4hESMhwnw75egys89BZdnAfKlWQWjpvMEthi+VdC1UjYb
         msqgh7aGPkRwLvnlFulGslafmWL6Gwg5zcShmxdtahxWJ/4JaECwjWyJ8M8TI91OWWzW
         N9H2X2dr+t43xdHhmhcC+VLu1+b+8qH8/Ru7aOU4bgiA/cs5KMWyouyeROIgKgE/lLDb
         s6Xw==
X-Gm-Message-State: AFq9FYLjOCaWaZLfzYtb0yyt1UTEQ4X1iDXPL2A/AlOZ6hIBXfYpr/By
	+6StCZmJJX8JpTlqMWYly8wHxiOvPCn0VN4l2J87vIOCAxYDVK1wQdB57SJGyYlwLVN/rFOgaSM
	NUHLipw==
X-Gm-Gg: AYBFou1/xfbUOV5U2DueZ/lvVQVTLwsFh/Y9mvaEFWDW1N6Fcxi8EQqEnDyfdtn0bo0
	C2xk80OMh1YDwBGR7iELCEyNoBDKKEG64mHYxjwE1WO6JZP9onXi8ROBbO4ekT4bq4xNQ1AgKXg
	NceRXONTIP8rFIvghMPr4DLBu9F1QgFcnpqfAbYJOEdWxDFoLKV4bH3Aw+nlrHVfiQjAgS+o3fU
	yhI6reIkzBlA7HDP4c/Npj6KPkTi/qkLeJIOMJSDKki77ImItII0M4Yn8CD0bl9cYiuvJZI6j56
	RVDEuk923JZ9h1uU8ZiTFnKQ3/1mh0A+KPyO6qRhDhmvt+ITUK6XrMvI5lZhOfhrCg3wHB/5kyp
	SWtCHii6ritOYreVFcL1CJCYvZ0tzQyPtm7gyu8K6g3/xZ2lG4tcYpIH71Zvut18FVGqmLG5Kws
	wRvaSLbd1NjaRO35U09rhiT8WAyX4q89c5i6R2IfpGUhqtCnzHRK7e+n8lOxJQQ+hsgOWhmleWQ
	488e/6K53CTTHCx2O9iZscjSYv53Ms0eK+lUcDV+yzF5j9zafBmyXwmSGOck32bpCStU2nqxMhm
	3mmc6FEADCPGgvm9K5XvTmEsGulOs11TgMn9NQ403/h819fL0z/JO3YuL8W1CCw=
X-Received: by 2002:a05:6830:2304:b0:80c:d34f:5f65 with SMTP id 46e09a7af769-84d0a00a684mr467623a34.30.1792556250992;
        Tue, 20 Oct 2026 21:17:30 -0700 (PDT)
Received: from nortesoftware.dev ([189.150.78.131])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84cbc7d9b1asm1286453a34.8.2026.10.20.21.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 21:17:30 -0700 (PDT)
From: =?UTF-8?q?Christian=20No=C3=A9=20Ramos=20L=C3=B3pez?= <chris@nortesoftware.dev>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH] gpg-interface: fail when the ssh revocation file is missing
Date: Wed, 21 Oct 2026 00:17:20 -0400
Message-ID: <20261021041720.572035-1-chris@nortesoftware.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <ec4de165-c7d1-43d9-979b-08c1cb67022d@gmail.com>
References: <ec4de165-c7d1-43d9-979b-08c1cb67022d@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When gpg.ssh.revocationFile names a file that does not exist, Git
warns and runs ssh-keygen without it, so a signature made with a key
listed in the intended revocation file verifies as good. A revocation
file that exists but cannot be read already makes ssh-keygen refuse,
and the signature shows as bad; sshd likewise refuses all public key
authentication when its RevokedKeys file is not readable.

Fail the verification in the same way when the file is missing, and
turn the warning into an error so that the reason is shown. Users who
want verification to go on without the file when it is absent can
prefix the path with ":(optional)", which makes Git treat the variable
as unset if the file does not exist.

A setup whose configured path is wrong now fails to verify where it
used to warn; until now its signatures were verified without any
revocation check.

gpg.ssh.revocationFile had no tests. Add tests for a revoked key, with
and without ":(optional)", and for a missing file, with and without
the prefix.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Christian Noé Ramos López <chris@nortesoftware.dev>
---
With or without this patch, a local `:(optional)` value naming a
missing file drops a gpg.ssh.revocationFile set in the global config.
That is existing `:(optional)` behavior, not introduced here.

 Documentation/config/gpg.adoc |  3 +++
 gpg-interface.c               | 15 ++++++---------
 t/t7528-signed-commit-ssh.sh  | 28 ++++++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/Documentation/config/gpg.adoc b/Documentation/config/gpg.adoc
index 240e46c05..cce49d53e 100644
--- a/Documentation/config/gpg.adoc
+++ b/Documentation/config/gpg.adoc
@@ -83,3 +83,6 @@ gpg.ssh.revocationFile::
 	See ssh-keygen(1) for details.
 	If a public key is found in this file then it will always be treated
 	as having trust level "never" and signatures will show as invalid.
+	If the file does not exist, signature verification fails, unless
+	the path is prefixed with `:(optional)` (see the `pathname` type in
+	linkgit:git-config[1]).
diff --git a/gpg-interface.c b/gpg-interface.c
index 60c315fba..ddbb29e78 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -533,6 +533,9 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 		 * we still call check-novalidate to display the signature info
 		 */
 		ret = -1;
+	} else if (ssh_revocation_file && !file_exists(ssh_revocation_file)) {
+		ret = error(_("ssh signing revocation file configured but not found: %s"),
+			    ssh_revocation_file);
 	} else {
 		/* Check every principal we found (one per line) */
 		const char *next;
@@ -576,15 +579,9 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 				     verify_time.buf,
 				     NULL);
 
-			if (ssh_revocation_file) {
-				if (file_exists(ssh_revocation_file)) {
-					strvec_pushl(&ssh_keygen.args, "-r",
-						     ssh_revocation_file, NULL);
-				} else {
-					warning(_("ssh signing revocation file configured but not found: %s"),
-						ssh_revocation_file);
-				}
-			}
+			if (ssh_revocation_file)
+				strvec_pushl(&ssh_keygen.args, "-r",
+					     ssh_revocation_file, NULL);
 
 			sigchain_push(SIGPIPE, SIG_IGN);
 			ret = pipe_command(&ssh_keygen, sigc->payload, sigc->payload_len,
diff --git a/t/t7528-signed-commit-ssh.sh b/t/t7528-signed-commit-ssh.sh
index 991678264..080ebf9db 100755
--- a/t/t7528-signed-commit-ssh.sh
+++ b/t/t7528-signed-commit-ssh.sh
@@ -211,6 +211,34 @@ test_expect_success GPGSSH 'verify-commit exits failure with high minTrustLevel'
 	test_must_fail git verify-commit eighth-signed-alt
 '
 
+test_expect_success GPGSSH 'verify-commit exits failure on revoked signing key' '
+	test_when_finished "rm -f revoked_keys" &&
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	cp "${GPGSSH_KEY_PRIMARY}.pub" revoked_keys &&
+	test_config gpg.ssh.revocationFile "$(pwd)/revoked_keys" &&
+	test_must_fail git verify-commit sixth-signed 2>actual &&
+	test_grep ! "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
+	test_config gpg.ssh.revocationFile ":(optional)$(pwd)/revoked_keys" &&
+	test_must_fail git verify-commit sixth-signed 2>actual &&
+	test_grep ! "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
+test_expect_success GPGSSH 'verify-commit exits failure on missing revocation file' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	test_config gpg.ssh.revocationFile "$(pwd)/no-such-file" &&
+	test_must_fail git verify-commit sixth-signed 2>actual &&
+	test_grep "revocation file configured but not found" actual &&
+	test_grep ! "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
+test_expect_success GPGSSH 'verify-commit ignores missing optional revocation file' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	test_config gpg.ssh.revocationFile ":(optional)$(pwd)/no-such-file" &&
+	git verify-commit sixth-signed 2>actual &&
+	test_grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
+	test_grep ! "revocation file" actual
+'
+
 test_expect_success GPGSSH 'verify signatures with --raw' '
 	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
 	(

base-commit: 47fdf2208c5b94c8cc01c106b8f7c85efb91c926
-- 
2.47.3

