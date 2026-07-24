Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8F3248881
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 00:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784853659; cv=none; b=I0INSX3Hmj9hBnm2RGesjUbV/vXAor/NLBZlA+OFaYtcHYzBdqIgQaWbyNMvokRgu1Rj/KubXO+wyA2WVfaJbjZj4ewWTIthwbfMLBy1JndSVJgrxxMQ3xLD2LQn+gxvrQc1DC4puk0uLUfWHRcRCjkwAqUcEyFys5a45jX1xyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784853659; c=relaxed/simple;
	bh=mlpXr7uLG6DKUxnMrUHj04jZwPJFlmhCS+IHRaUrwa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qXemmzlzDbKVxQeDnaYEy5Pd5gPXzMrYRClLfNgG0xzE4sVHdDp4leK1MIksd8XSB51LY0l/2FDu+UdrH1v72BCgLoy6naoidmHHvjuAKYLJDFd0yyhSh71STOnaBjX2YrbQayVHVvry2uZKG2XO4tpU4xzkQ42E0EXkJYa56wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=KTpl44Vt; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=algatB3r; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="KTpl44Vt";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="algatB3r"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4h5q0l2zcDzMlK8;
	Fri, 24 Jul 2026 02:40:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784853655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7m2uynznbhstFFI6Whs7S9brrvan1D69zMnnTNb2Npw=;
	b=KTpl44VtldjgyLkBYPO+LDDMqziwL3+ghFT2qQMr16qPuU5YiiVxE3rrEYRPFFYsbsqiw6
	6gWxCK3mVIlhJDRBd2j4EXWLsQjNA5s/wlCSo8vjEFKnfYAhcmFX6lJdfAkFkMe2boLS+Q
	Kd98SJKSDDizde/bCzTioAZtt9As5E65ps9qt0QEpGhA6melYC2IsSHzwRarYBpGENQXrC
	scU3xTapkQpbqujYJ9momF7ErOyQ0ispIVKaLHItY5ERsSKMJmE0+2c82A+ucl1DHVXb2S
	0uDhjZbbq42MYvrY9epCTIVjh2dqSQhUg/a1Ms1plbPXqQQu5aNsBR2kT5pL+Q==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=algatB3r;
	spf=pass (outgoing_mbo_mout: domain of fpottbaecker+git@mailbox.org designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=fpottbaecker+git@mailbox.org
From: =?UTF-8?q?Fabian=20Pottb=C3=A4cker?= <fpottbaecker+git@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784853653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7m2uynznbhstFFI6Whs7S9brrvan1D69zMnnTNb2Npw=;
	b=algatB3rll1eMKzVj1YSQbsOXWiR8ZWS5PL9SYC5hbXktpFBmLdzCeEAzhK0Q3LLotQ22/
	5QpvziRrw2OV6uLRTy0rCQvnOZOg1jkiTT2QaoF80Y1Tkb20bh7V5pST+JZvZhKYeEUFwO
	R0CMFxgBmlFBjpb0fD5A30151/WSKMgC7+Jt11DlFKoZcK1UEqCNaXrjJ6yI4RcZuMRHkU
	iTYdvPdC/SktR81ApTIPxa00XnX00tqRHEwFQ7P9YSXUy4YeRxTLIytmBkYM2kBy9xkEyM
	/7VXD4n2nV1BFBfmO5wF4NePU09MJzJyKZRj4G4lavk096AelRrI0mAV9k+pMw==
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?Fabian=20Pottb=C3=A4cker?= <fpottbaecker+git@mailbox.org>
Subject: [PATCH 1/3] urlmatch: normalize ssh and ftp default ports
Date: Fri, 24 Jul 2026 02:40:09 +0200
Message-ID: <20260724004011.41795-2-fpottbaecker+git@mailbox.org>
In-Reply-To: <20260724004011.41795-1-fpottbaecker+git@mailbox.org>
References: <20260724004011.41795-1-fpottbaecker+git@mailbox.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: tgn36wtsa9trgka8fs9qugnix5pjkqff
X-MBO-RS-ID: 01810cadfbee7ee58e1
X-Rspamd-Queue-Id: 4h5q0l2zcDzMlK8

These protocols are still supported by git and have well known
default ports. This leaves FTPS, which does not have one default
port.

Signed-off-by: Fabian Pottbäcker <fpottbaecker+git@mailbox.org>
---
 t/unit-tests/u-urlmatch-normalization.c |  9 +++++++++
 urlmatch.c                              | 16 ++++++++++++----
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/t/unit-tests/u-urlmatch-normalization.c b/t/unit-tests/u-urlmatch-normalization.c
index 3595d893a2..1808e5e51f 100644
--- a/t/unit-tests/u-urlmatch-normalization.c
+++ b/t/unit-tests/u-urlmatch-normalization.c
@@ -141,9 +141,18 @@ void test_urlmatch_normalization__port_normalization(void)
 	check_normalized_url("http://x:80", "http://x/");
 	check_normalized_url("http://x:080", "http://x/");
 	check_normalized_url("http://x:000000080", "http://x/");
+	check_normalized_url("https://x:8443", "https://x:8443/");
 	check_normalized_url("https://x:443", "https://x/");
 	check_normalized_url("https://x:0443", "https://x/");
 	check_normalized_url("https://x:000000443", "https://x/");
+	check_normalized_url("ftp://x:2121", "ftp://x:2121/");
+	check_normalized_url("ftp://x:21", "ftp://x/");
+	check_normalized_url("ftp://x:021", "ftp://x/");
+	check_normalized_url("ftp://x:00000021", "ftp://x/");
+	check_normalized_url("ssh://x:2222", "ssh://x:2222/");
+	check_normalized_url("ssh://x:22", "ssh://x/");
+	check_normalized_url("ssh://x:022", "ssh://x/");
+	check_normalized_url("ssh://x:00000022", "ssh://x/");
 }
 
 void test_urlmatch_normalization__general_escape(void)
diff --git a/urlmatch.c b/urlmatch.c
index 20bc2d009c..0c2ddf2e40 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -274,12 +274,20 @@ static char *url_normalize_1(const char *url, struct url_info *out_info, bool al
 		if (url == slash_ptr) {
 			/* Skip ":" port with no number, it's same as default */
 		} else if (slash_ptr - url == 2 &&
-			   starts_with(norm.buf, "http:") &&
-			   !strncmp(url, "80", 2)) {
+			    starts_with(norm.buf, "ftp:") &&
+			    !strncmp(url, "21", 2)) {
+			/* Skip http :21 as it's the default */
+		} else if (slash_ptr - url == 2 &&
+			    starts_with(norm.buf, "ssh:") &&
+			    !strncmp(url, "22", 2)) {
+			/* Skip http :22 as it's the default */
+		} else if (slash_ptr - url == 2 &&
+			    starts_with(norm.buf, "http:") &&
+			    !strncmp(url, "80", 2)) {
 			/* Skip http :80 as it's the default */
 		} else if (slash_ptr - url == 3 &&
-			   starts_with(norm.buf, "https:") &&
-			   !strncmp(url, "443", 3)) {
+			    starts_with(norm.buf, "https:") &&
+			    !strncmp(url, "443", 3)) {
 			/* Skip https :443 as it's the default */
 		} else {
 			/*
-- 
2.50.1 (Apple Git-155)

