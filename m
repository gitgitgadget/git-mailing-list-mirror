Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794612519;
	b=A4MCo71E4dicA3dzXDQMbd4D/IrQPpxAQpgquj0O0qX2ZxhJYmi1QwBQFN9MyUfHQfZJ
	 Kk7/UAlTv0RfPcuj+PxyOdhCi4KQIlTBZn+yifWydoGgMdg6beGioUUf8rihaMb6Cup9H
	 eM+LARvIzS6KPLetalYVBkDb7Ym5A4C6NX8Zi+yW+kbN0ykYM2cZhLZNrT1KBn5nVkKmA
	 oVpsYnHraNMvaw4X0FUF/B4aU+4Rb8zJIGnGKLAuLzYO29eDyCGYxCx2e23aVPKMTupnE
	 jyv6RrTM9qVb4rc1q7RV0lQGcsQw2QXyt8XtiZ/e5TWMJkybxREHp7XWkGYPvq6x5qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794612519;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=pbpSY2rAffzOjfO/9F86rJ6aqJLpJ8zLYAvLbt/PMIg=;
	b=Mbi2MIJaq6G/IpzqNUVsn15uGYQGLZKiSnjIW9tbYsJTiJJONT/d0wZG3QqqvExNtaxh
	 jifNMZToDvq7pd6cCkK/5Vlmfy6WYOfOnTl8d81LYHIHTLMSMtPriGvtn7VWUQHPeXsM9
	 GVpyRJDOWeH5Ggr1K6Ant0HvkuhGeKRComODpc3pEOQHAd0/XyGYJzzd1+Ne2c8RUBAMQ
	 E/5l21h1SXGjtNgc/TpCccgINds173figciLhSz+ZReV1n6UMI2ona0LOb16vBKQW9+40
	 v9Zl/Q6H9lD8pwLF/oTwz66eoxEihdcuJEIp3JXKUPB+qB98ZKu+d3ZVrFcG9Sfxjyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nortesoftware.dev;
	spf=pass smtp.mailfrom=nortesoftware.dev;
	dkim=pass header.d=nortesoftware.dev header.i=@nortesoftware.dev header.a=rsa-sha256 header.s=google header.b=Mjn7VTq8;
	arc=none smtp.remote-ip=209.85.161.51
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA61606A32D
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 23:28:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BA61606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nortesoftware.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nortesoftware.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nortesoftware.dev header.i=@nortesoftware.dev header.a=rsa-sha256 header.s=google header.b=Mjn7VTq8
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6de2f213b7aso603552eaf.0
        for <git@vger.kernel.org>; Fri, 13 Nov 2026 15:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nortesoftware.dev; s=google; t=1794612518; x=1795217318; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pbpSY2rAffzOjfO/9F86rJ6aqJLpJ8zLYAvLbt/PMIg=;
        b=Mjn7VTq8PwwkOtD4kJ5K9pow+bNgWT0AHxIdVSME5GB7ODrughUA0z5xfP/YPMYTe4
         +OEkJwqkMCEODrnIdlNGoHIiWip4X4DqJQpgyENKdQ2fRArCFUty9kcL2rpro8zIoG8S
         g88P7qcNQ46EomRu3GG0A3pIfyRbn78amjBJ6DBAQ/B6n0xHmpXBuy4/b7rhoPuHBVcR
         b3HlDcq6DQflL+JE1ShJaiyhwfb0a0D+hdickHa1PDg9jOUU2DgN7BnbtiegdPX13dj1
         ScamfUsUX7O3y+oxPjYx1vl5Xah4EkPAYQG7HjnXcebVX6cGq9pxmwsufoiAH6prRv/C
         r8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794612518; x=1795217318;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pbpSY2rAffzOjfO/9F86rJ6aqJLpJ8zLYAvLbt/PMIg=;
        b=Zp4hjNXGoQitOzheVv5gbqF9xSWD8jX7oUUAReL5e6+ZMKssBXkj07Z+SZZkRyGhkV
         Wkxxt7xu+Kz58kio0iS76ZvLjonpZZIgTUCWyxfuSEPW3r5FDBTV/0sxRqvFwqsdjxUa
         hXrnQa8Cc8rNETfQFxwuXwQSyFOMbmyan/4n/nMuUsV1LmozvBCUSYYSUOokj4LkbCBv
         oZffVghhHgb/ATvr3AfZNk22WdJKA4joxqoJewbXaaTE20Bk44Fz7t9+OohLNe+FGkEg
         qA5FitG+iMl/T3UalzR6KCFismBDnGLRPg2D2i/OgV0NyLrE7ZB4ii+1vnjyo3OiTEVI
         eF0A==
X-Gm-Message-State: APuU4Z/idHWc7TUhSYZZdOaCKLRA7H3vGVAzBH2eqUkAARYEf1I6X4iA
	EZljyWWElERkYbB8m0LnSLE7TFkdjcKGZMXB99/11cfmUPU5sLE1IABWBeTd9tXtdUA1OM/9xzq
	tCTDbahHB
X-Gm-Gg: AYBFou39pN3sTFWBYrW7lbUaUEaL//6M+kQCOL1OE78yuzyCqPOpfrivwUVnEbSXPjv
	zI/u20gYXpsz/WM/wsQrzOyZpnN9lcS/+oO0+vzfEOLxO86H42FNjKKTgBzvd6QULW7yHxN/isP
	ZC2sZI4rRNR9siCJ5XPToDkaHVPqkTVK02qS78jq6kQRmU4zMKw4IzYvho/vEKOGwlbY1Ctmu68
	IxYkxlwbMSB9Jt+iNbq0MTlMC1T9D7GFRg1Ny68U5RcV0HpAsjpekZOsJWBzC4E/5ENOhLg7+PT
	wOH7bD/pbYOe6YFjaP5EFHfpRgruQ9gqmNzqUeMZZ6Jj7KhzXIBjWIrMHUivl0wqAU8JfQxxEfD
	RP+8p8Z7jhGvBwBIBqY2W84odB8/il+9cQVS4dE37sM7ihUCD22HSFeld3Y9pr48yfpQz+nVBv8
	bQd5TCJO3/2Kj3+EyNwlNh/1jC1aDLdZHDk1uDHLoTMq5kOtmw/6D2WBBPDetQHOjq6HXXScocW
	d2/UBz12vWKAFI65ZddVJeD91Ft15o0WqAM+Wwn0RoiX/c2qarORwVm7N3F3nS0oXIyfl/OkGGb
	OVB+mjYRxHU96K52VXym67gGxj15BhCtSsHJX8mWf0x3zaYOQ//tkYEpO6SF9Ydqx2dnOPO1oQJ
	1NDIEAZ86erAkA/njm5wbQATgzYBj0cl93HO30IsNPh79hqld3IOToVlr0w==
X-Received: by 2002:a05:6820:1354:b0:70b:9806:c916 with SMTP id 006d021491bc7-71ab508c853mr2172940eaf.51.1794612517814;
        Fri, 13 Nov 2026 15:28:37 -0800 (PST)
Received: from nortesoftware.dev ([189.150.57.229])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71ab4291ac1sm2939532eaf.3.2026.11.13.15.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 15:28:37 -0800 (PST)
From: =?UTF-8?q?Christian=20No=C3=A9=20Ramos=20L=C3=B3pez?= <chris@nortesoftware.dev>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3] gpg-interface: fail when the ssh revocation file is missing
Date: Fri, 13 Nov 2026 18:28:24 -0500
Message-ID: <20261113232827.1325175-1-chris@nortesoftware.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021041720.572035-1-chris@nortesoftware.dev>
References: <20261021041720.572035-1-chris@nortesoftware.dev>
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
Changes since v2: none in the code, the tests or the documentation;
v2 applies to the current master unchanged.

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

base-commit: ebdc087dc99d68bb340c282b2ba5f722def28d19
-- 
2.47.3

