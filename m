Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792647977;
	b=nN+S14EB8Rs4wqHebY277/tEiuR0I3fsfQ8HG6p/NH0MXQxUFQ/Sme2pYLXBbmM4/t0o
	 981LOh5u+HK+YXzEgBm3nzi+pnoBdkaZcFmG97j95UyUafMsYZ3Kn+YDRzAo44YFGKriy
	 fcjJNFx2RIOZZgBUjUAPoxXLFajBQwzPt7Vg0MD9VXot7QVDlUIiuvTVMfsoVkhFY8Tvh
	 Caewz4c7jY7meN6SXZ8E2JXPAWja3H3o9Oh+d0/Rc1R7ARncRZfFFM4duZBnoI2zmn1yJ
	 B0GiXggry4+09+egrAjrmEzUUFXwLxdhLgca9SugT/JffMc6EsbmyhZ6Z2xHEW6uiZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792647977;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=7+LF5Pv00YuHQkM6uNHChKmEhE2HLhk19aSLNW82f00=;
	b=BsG7oF/VGtZsa7cWxmKhabPXk7tWktoKhb7msRGcdlevOeuz1O4EwFfXxK38zBupnIee
	 W35ksLBvAvyiCurSO/0c4FlyVYgJOm8f3d/zOG7bYgmhMHm+OackVgteIiHy3DR8quEPA
	 FTpa1REE2Hf6nNxUiZAYS2PDhaHwRx8kBUOWTsg/7yB5DxfJLpfhta+IXINUdVs0zmfGe
	 7nN7uJeWaGyVTgx7jAJYdlQfoR5E3p3V5AnuxI1yyNbl6w9NzrP45LNIqJ4Osk3B0KE8n
	 KhqlPNRqA0RzNh4B30pRhbYYARu5yEO0f9O0rW/99bYYPcYRuYRt902/CvSzE1TZhEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nortesoftware.dev;
	spf=pass smtp.mailfrom=nortesoftware.dev;
	dkim=pass header.d=nortesoftware.dev header.i=@nortesoftware.dev header.a=rsa-sha256 header.s=google header.b=Nzo8Far2;
	arc=none smtp.remote-ip=209.85.210.48
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AE0606A31D
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 05:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1AE0606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nortesoftware.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nortesoftware.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nortesoftware.dev header.i=@nortesoftware.dev header.a=rsa-sha256 header.s=google header.b=Nzo8Far2
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-81ae6aefdceso1445557a34.0
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 22:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nortesoftware.dev; s=google; t=1792647976; x=1793252776; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7+LF5Pv00YuHQkM6uNHChKmEhE2HLhk19aSLNW82f00=;
        b=Nzo8Far2X1OPtI+5BfpKlvEMl1b4PtnC6C2bSmtwdwKNBjyzzpfDSqS6BlhpEDOxKl
         flhY8z7lNqJ1aXb3qr6c/Hlc0x51FHw/ZWFc4T3+s1HncbN7qGTQaOt1+dIsPiAT5h/r
         HlyLy+ozLzoZx6hDgf/iSGPF3x0Z2IT85bnD7s5l/QaaX/p8BTUV54VKC4WMxCGOKD/V
         rlyAcdU3eSInOMi4sy1sXc2spb9x7lO9X6r0mXEkCsb1hYq4bTDMLlckN19r2Y6CUOpg
         OMgMC1RcNDmFCU3JT17xGArPNnxazvE+b9WBzzwhdZolvb1knzs7h5OX2CcCwfbyUhPW
         hN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792647976; x=1793252776;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7+LF5Pv00YuHQkM6uNHChKmEhE2HLhk19aSLNW82f00=;
        b=pL29bH90UIgPFGB/RIugrTLEkhjz1fgY5v4q5UZ8TGnJhsGntBTshhuDoE7jzLltkB
         qDXfHZGLxgjKJUuTD5leuOqQp5l9S/LXIjwY2N5q/Q7QmO/U8SZYpesTdeL3lbnjKdGu
         1y7qiN+b2Ld0PIGwnILm/B4e1MYvt4LsMlRJ+QNXYzSS3QD+SkAz9cQlZSTtzmORPOTl
         /LUnc6vyyuww2vtd8IHE5ygcedRqa6pUB6FH6DB35OWKsEv960dpWBCa44/q/pqbhi+e
         r1dSpL+37Ep5Z+6TCVqdv7dv1x40g1mU+WvA2Y2D0eN86zT/lBU0in9aOcIJTT5gTnWV
         gJrw==
X-Gm-Message-State: AFq9FYJrsjfB0nLqx8gy/QQpkaeUly1Bzzdc6XUL0fANPlJVho4+PZxX
	d0MezhF50RfMtIo32iTzKUW/iT+H8KNGfHfGMgi8iaryG2bgiYKvnxPoW2v/PX679dYLaXuDaxI
	BJ4QLSw==
X-Gm-Gg: AYBFou1SfaQnu8PzhC+nRKHwRUfq8638PXdfeNF8Gg8jQqRI9Vgh+dR0Sp1JQ8gZUSy
	JmxEQ70mJpSYNujWZ80Qf/Ez42ooIkIB2BRF4WVkOWxPYFFDwFosiwvF3guOuwyFfvD+T68ytAl
	VBgfH9ERAmPbJz45p1D/FioZmmbfKrT6o0ZZlCRSNlxg9NLIZOpkAEkB9aRci4fHC69A7cz48VO
	L2M7gScW+4yleFpynVY+PUAE9vcCOu+AXMERfxx5BL5ogj4XoaWrdf/mQOV9BI286j3okOayDnv
	hTJGbJmEFHpZxqmPX797iK7XHpIMXGW7QJ+hhjYpgBLEiGofHzq/RTJMMn6WXZF0WilKyRFWapP
	5j56ZiKs5HZIRSXHOJuIHtYesfB1XJLmlomEJh/g0Lf35x1SYNqYrpCbWrrgEvXvP1BXOGuEQE1
	r/rjxUGUwoz3M7qFss6QG7pYpjzx5btIgCXeK51fsMTULaGYOn4RihcCwCC5U8/mZ52gmstl3Ob
	jYl3eTRpMR0CGKRXCKDC1glacnFGNU8cP+ZLmLFGGEDECoKt/M6B0Gg/F4jeucOzo5xAh9hNqbp
	HYp+bubpiDmdX6FnH6gIr6jE4Q3o1jTr2S2RN8tjYTarCzwa9o20MbXtRwDaJ+I=
X-Received: by 2002:a05:6830:2aa0:b0:822:b35a:a2c5 with SMTP id 46e09a7af769-84d063deab5mr3133701a34.1.1792647975560;
        Wed, 21 Oct 2026 22:46:15 -0700 (PDT)
Received: from nortesoftware.dev ([189.129.139.54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84cbd2d453bsm4267063a34.17.2026.10.21.22.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 22:46:15 -0700 (PDT)
From: =?UTF-8?q?Christian=20No=C3=A9=20Ramos=20L=C3=B3pez?= <chris@nortesoftware.dev>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] gpg-interface: fail when the ssh revocation file is missing
Date: Thu, 22 Oct 2026 01:46:07 -0400
Message-ID: <20261022054607.766255-1-chris@nortesoftware.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <xmqqa4o6oq1y.fsf@gitster.g>
References: <xmqqa4o6oq1y.fsf@gitster.g>
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

Fail the verification when the file is missing too, and turn the
warning into an error so that the reason is shown. Do it in the block
that already fails a key that is not in the allowed signers file, so
that a key that is in it still gets its signature info shown, and %G?
gives "U" for both. While at it, reword the comment in that block,
which read as if check-novalidate were to be called again later.

Users who want verification to go on without the file when it is
absent can prefix the path with ":(optional)", which makes Git treat
the variable as unset if the file does not exist.

A setup whose configured path is wrong now fails to verify where it
used to warn; until now its signatures were verified without any
revocation check.

gpg.ssh.revocationFile had no tests. Add tests for a revoked key, with
and without ":(optional)", and for a missing file, with and without
the prefix.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Christian Noé Ramos López <chris@nortesoftware.dev>
---
Changes since v1: the missing-file check moves into the block that
fails an unknown key, and that block's comment is reworded. With the
file missing, a known key now gets the error and then its signature
info, and %G? gives U instead of v1's B; an unknown key now gets the
error too. The missing-file test checks that the signature info is
shown.

With or without this patch, a local `:(optional)` value naming a
missing file drops a gpg.ssh.revocationFile set in the global config.
That is existing `:(optional)` behavior, not introduced here.

 Documentation/config/gpg.adoc |  3 +++
 gpg-interface.c               | 30 +++++++++++++-----------------
 t/t7528-signed-commit-ssh.sh  | 29 +++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 17 deletions(-)

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
index 60c315fba..f36ba8dd0 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -466,6 +466,7 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 	struct child_process ssh_keygen = CHILD_PROCESS_INIT;
 	struct tempfile *buffer_file;
 	int ret = -1;
+	int revocation_file_missing;
 	const char *line;
 	char *principal;
 	struct strbuf ssh_principals_out = STRBUF_INIT;
@@ -513,11 +514,17 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 		error(_("ssh-keygen -Y find-principals/verify is needed for ssh signature verification (available in openssh version 8.2p1+)"));
 		goto out;
 	}
-	if (ret || !ssh_principals_out.len) {
+	revocation_file_missing = ssh_revocation_file &&
+				  !file_exists(ssh_revocation_file);
+	if (ret || !ssh_principals_out.len || revocation_file_missing) {
 		/*
-		 * We did not find a matching principal in the allowedSigners
-		 * Check without validation
+		 * We did not find a matching principal in the allowedSigners,
+		 * or the revocation file is missing. Either way we fail, and
+		 * check without validation only to display the signature info.
 		 */
+		if (revocation_file_missing)
+			error(_("ssh signing revocation file configured but not found: %s"),
+			      ssh_revocation_file);
 		child_process_init(&ssh_keygen);
 		strvec_pushl(&ssh_keygen.args, fmt->program,
 			     "-Y", "check-novalidate",
@@ -527,11 +534,6 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 			     NULL);
 		pipe_command(&ssh_keygen, sigc->payload, sigc->payload_len,
 				   &ssh_keygen_out, 0, &ssh_keygen_err, 0);
-
-		/*
-		 * Fail on unknown keys
-		 * we still call check-novalidate to display the signature info
-		 */
 		ret = -1;
 	} else {
 		/* Check every principal we found (one per line) */
@@ -576,15 +578,9 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
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
index 991678264..d67f9b489 100755
--- a/t/t7528-signed-commit-ssh.sh
+++ b/t/t7528-signed-commit-ssh.sh
@@ -211,6 +211,35 @@ test_expect_success GPGSSH 'verify-commit exits failure with high minTrustLevel'
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
+	test_grep "${GPGSSH_GOOD_SIGNATURE_UNTRUSTED}" actual &&
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

