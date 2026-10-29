Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793267855;
	b=FGEa7ofiaESwWnZT87Sf0DYebUhh1RTnwPbn3ovFxe1w1PXSN+mv6iOv0I/6ThoBbwjs
	 AJpQgySrwhGtBBKpy70rywaR4x53gMD4S53zjaA9B3hk3b74SVyxvRiqyMvW5BpLO7VRO
	 ZajfOSy0p60cY9yDIY3EEIhh/GHhJXnJJA/5J75GTm5PMPXuN8gy5AZpNQKty0tf9rHOz
	 rHfH66lBagzxYDY7T1HU5PEyFEppcxroMU9Cy5DK7cBiD2ohvXMi9QkSaYVxSgVlVyAkS
	 75wzIDD2CZ4e6Gt1hK/AMd/kEDk/b0O2wchdqVWr+J7oVj9zfohfT0HfNbB2XNq8D+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793267855;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=LYBZvxeYLYwSQr+7t2f+DkIl73VWPTbvZP1I1z3J2JE=;
	b=pxShD9CDsbcGlJyxZW8wKZQTSs+GQAiSJy6URduzbHIuQbzxyA6e6tDXogv27G46lOZ1
	 4vyLuead3nnEXGAmMLXm3cVpfKs+AGuEYu7Mzi3OIOiauc1Eqmnsw44nKaHSNR72oXUMn
	 W+gHWFec/a746tVliw43u7t6KvmavYidlNoZzpqVkKP89vGbDjvPhWsvKWkIo4vyc+m2w
	 V9ee4eDks6QEXw8Z9e5CbE083oqJpUjX0jaKMDrVXaLQglUxbwlvSMsUFI8q+CSOEVoGZ
	 uIZ2ppgYP9e2+i6+/vH/cOhNV8ytH67AWE8J1iwOqRksVkKEkkC5vvGNti4g28wikhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=HXOnklUl;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=cGAPVZYh;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54412606A571
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 09:57:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54412606A571
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=HXOnklUl;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=cGAPVZYh
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 966691D00087
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 05:57:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 29 Oct 2026 05:57:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793267854;
	 x=1793354254; bh=LYBZvxeYLYwSQr+7t2f+DkIl73VWPTbvZP1I1z3J2JE=; b=
	HXOnklUlLowng69NiO/qvYTPZViZmUixDyBjDlDF5QNZPwAm61EAXOoHPXJMqE6Y
	1inmO4PqXcN5CFXyWVevCFKEikh85tKK+j+VinI+B83sQEZmplWFOz/9N4Yc1Z6W
	jIjgAt3iKW7Mk1viUqwwwhYJLChzvNV0lil6EMkSWOI3NTVfgrHbiepzV/bP4mzN
	+yFp5bH5inmMTVkATLIkkA9O9vS0Jkph5dl2yAjnPwv4p0tCde84aKHyJBApEhAB
	KYYk5UOp45Bw1hTZFhKS/lMyvfd6WuTABRqeJk8XOYqRQ0PnNpbCKogvBF4A+ep4
	gpX2UPmGTuqFOki0WZ/9lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793267854; x=
	1793354254; bh=LYBZvxeYLYwSQr+7t2f+DkIl73VWPTbvZP1I1z3J2JE=; b=c
	GAPVZYhUrGyz8pMJKmO2h86GMMfdBDc0IYdQo3uprcELHnyCJZAppoY7jpSpr2YZ
	RF0IzsH6u0seScnuXnAt8C5Z5j9w033yBn8U/8zG476GNzWcfcVSrUrQ+PbjUbcG
	XT2pQbMNFH72Q39ST6JiL7lfsHS5D0A9J89bwq72JYuApmXgycW6RmpjfJii6XG4
	hyFNQv8UTKH5FGSWprdQxcFCkEGOfhBIK0d56YHMaxOvG+IKzdnbHSYsJ8sDyXTa
	vApb3KF+p2pBpZUgZ05aroF7UlH7GpDL3pkZEKFPtmm1gPSNe8LZj3paAEzQtNy3
	45zG+h100wbodTw1xXkGQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793267854; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:pMIFGMOnJFjTS+ElpLgrVv/r2+gP3HQLgPaGGUvInfvVL9S
	qNIo3Mfz9KSCDS764zKywwzD6meeAyxOJBN8V5iXj8mRLROmwXM2hfmdhwsqqtaC
	UvzYXWwZaXk5O5EF8q/nvy5oks8oA/mcehvBq7otaWHfUFC2TwsMQHZF8mPo453Q
	1WHJtWbkiY/gaV1hy1rhXNZd2oTnGei9bsY5aPi13AmTaVLSe+B96xTOzbjXi6OF
	VDKlzl3smJYhqm2/HSfnbEy6wadq0BWH2A8PEa1P+0/euMHUiWWChTSkVqZsQZ+h
	J/rd0p0TPySp/DSWVDQZcDkTVvfbD9ijDgJoTwQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:zBP0yUsE58fu5mFBeu54/QUrmnZIQoNcoKZxnCr2ITs=:W2OQRE+hwiYVDk79O/wBpRUPy/zRf4WjHYADfTwQ4fE=;
X-ME-Sender: <xms:jhjjahsk4YSL0pAHjk6zfgELtraekG4qiH8xKm2DcRosR6CDhWQcdg>
    <xme:jhjjah6ZAj88CQ7rQ-7Y7U_vDEueumZU_CBCmgd9woxzW24aZvqlomdPemmu4P7Kq
    pfXHE-YwTnc_oh8oev_Dv8cpLS052yZaKAMcGozWr9I1hmjnqc_cjo>
X-ME-Received: <xmr:jhjjaiIu0olcOWRjzAuoipXf-maeKRLFH4PyMhdcuUvrTmQIDB9aUg>
X-ME-Proxy-Cause: dmFkZTGN6oeJR7otfSSVvdw42gSnuM/vOiOuTFBIRXaaTX+WyfNptir2dKNLWXae0Ccg/H
    Dw0kdIlCEIriHaB/16Z4yhETxZy9WpWVbCV5No/000ftN4GNucPScoQ5KkAWUzjoZWT0y/
    4K+z8cN8RbbwmEbCVA2o3dxUR234Pvg7fa8zCjVDYwZ4a88+TvOSFTJqaXKepL5aLugymQ
    94eqDXIHH+KgCM/ysQAVHXtzWZ+jp+UH8ANfqy8XQANds0O69Nn3IcrRQjn65hWQ4o24gk
    +sSNI7PSlqQEftXcXQKG4q+6scpPc+oCvIFhg4XMKrhkbLuMtLc2NHSNJl7zBq44s+shMm
    xR91R1VdYmRZOq23OOHkX8eaw1F35pB04lz1m7g0yrMffXqKBhwJS4Ep9X+eN592NmfMLq
    4rJS138EuSH4hPiPfH+LLWMJ5/fhna9WmpYg5F5t+481pLkyp36E0N93+izWTu+Qi4Qrgg
    OoER4EG1yr+4L/IaUbNbMorgofGz1ZwqIDBVTDTefkQJMq2R1oLu4iT7g29sf/fv4GXLYa
    N6nFbUw3iP5nkHo9t96MzgWnTy3eAzvueCKfHP8lRA3qzzxildRBU2q+vZWEh0xJtBQYtW
    VCz6t/irWpXaqpomSg2zwk60bmTc6TqqYXpc7T6q7WUlQGC/Q118o09eyXlw
X-ME-Proxy: <xmx:jhjjah60EnDdWLmxgwuHiSflQTJGBCrmEdhcl0bBvc0C2XOkKi5dMg>
    <xmx:jhjjalwg0_8VuVKDBC8wz77sOMtmyO7Hbkq_2J5huD78KKrM0xaF2A>
    <xmx:jhjjalbwWEPhYj6vIVFVq8lmiiSA_RzgVjq_WPxKZ0nKIDkoyt7N_w>
    <xmx:jhjjanSi5iV4fB-ZkPhfdWbxuQTwRQtCiC0idw_O9ikFOGOBQ6m-6A>
    <xmx:jhjjaiDuRgW9opNSeOSK2_oukHF48CZE7FwWFJBtwGXGwqsn__zJpH5O>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 05:57:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ca1279b5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Oct 2026 09:57:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 29 Oct 2026 10:57:14 +0100
Subject: [PATCH v2 05/12] builtin/rerere: turn "forget" into a proper
 subcommand
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-pks-rerere-subcommands-v2-5-07d5ba18e882@pks.im>
References: <20261029-pks-rerere-subcommands-v2-0-07d5ba18e882@pks.im>
In-Reply-To: <20261029-pks-rerere-subcommands-v2-0-07d5ba18e882@pks.im>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

The git-rerere(1) command has its own, home-grown implementation of
subcommands. Of course this implementation is inconsistent with how
subcommands typically work:

  - Options from other subcommands apply to each other.

  - We don't have proper usage strings.

  - Running `git rerere <subcmd> -h` doesn't print the options that are
    supported by that subcommand, but instead it just prints the help of
    git-rerere(1) itself.

A subsequent commit will thus introduce proper subcommands as supported
by our parse-options subsystem. Refactor the "forget" subcommand to use
parse-options as a preparatory step. The other commands will follow in
subsequent commits until all of them have been converted, and then we
switch over to `OPT_SUBCOMMAND()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rerere.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 405276cc94b..5d2ae154ff8 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -52,6 +52,28 @@ static int diff_two(const char *file1, const char *label1,
 	return ret;
 }
 
+static int cmd_rerere_forget(int argc,
+			     const char **argv,
+			     const char *prefix,
+			     struct repository *repo)
+{
+	struct option options[] = {
+		OPT_END(),
+	};
+	struct pathspec pathspec;
+	int ret;
+
+	argc = parse_options(argc, argv, prefix, options, rerere_usage, 0);
+	if (!argc)
+		warning(_("'git rerere forget' without paths is deprecated"));
+	parse_pathspec(&pathspec, 0, PATHSPEC_PREFER_CWD, prefix, argv);
+
+	ret = rerere_forget(repo, &pathspec);
+
+	clear_pathspec(&pathspec);
+	return ret;
+}
+
 int cmd_rerere(int argc,
 	       const char **argv,
 	       const char *prefix,
@@ -83,20 +105,8 @@ int cmd_rerere(int argc,
 	if (argc < 1)
 		return rerere(repo, flags);
 
-	if (!strcmp(argv[0], "forget")) {
-		struct pathspec pathspec;
-		int ret;
-
-		if (argc < 2)
-			warning(_("'git rerere forget' without paths is deprecated"));
-		parse_pathspec(&pathspec, 0, PATHSPEC_PREFER_CWD,
-			       prefix, argv + 1);
-
-		ret = rerere_forget(repo, &pathspec);
-
-		clear_pathspec(&pathspec);
-		return ret;
-	}
+	if (!strcmp(argv[0], "forget"))
+		return cmd_rerere_forget(argc, argv, prefix, repo);
 
 	if (!strcmp(argv[0], "clear")) {
 		rerere_clear(repo, &merge_rr);

-- 
2.56.0.341.g393f52fd96.dirty

