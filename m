Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794399553;
	b=ZLs8XB1E88OTLfD438r6rcjdT8trkq94XWey243KyuweIaaKQQwyvF7W5M9sz4A3z2Tz
	 F9Wx4lS4OC+RZZ28RmN8eMyG9kWk1uLDFfKmxn3tJmDwQSGphKhV7q/aZW4auAku5FjHr
	 oEp/apa/EfRzMqF7liMaIi4cKwS5Cd/LG6BKih8tpwX/HsdhmBblRAmIjJUnBFjArPzFo
	 a17clOOXFQUlB+8zkMZiwmg6Nxyzh4NLI4fFHo1kBLCfOPlRCM/Ug9PPA5cy+F4zO6KtE
	 yCRsH2ivZr7e3YQa3q2ZQTMCvXQOkGns580FoozBKGe07O3Ns5nKXMGUkmHFCoARxaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399553;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=fOxPoVu+UyB/dOsfQsvoewO+psDAVMAoj4nKiY6UcIY=;
	b=2cCrX5GGqwPgB1plvaq3xR28NQ+WorxOKwCiicQUxCNDTvhhqNyiodLf3RHfNuXdfQex
	 UvaLmEiY1IhD+UVxyoWm/mFkHWTK8qofCiFFr/jrX9AAHLVjRNoxRG8lqH2U7DGIK0SnF
	 IOqluFpny5ec6XaKn5G1LHzoB0XmsIuJka0tosyqAW7/C5W2qtx1u1rofksV0MdEveCt0
	 F/PxFWwvsC8149zyXWkEMikLcLljl1ClfEa8LfOS+xf/ntHZUa6MbsS6rCKWjjw3syBVP
	 NIkgZcUHmZHsExVjdKl/XcDY1odV0U88yZttKG4BiDklPpf2FwqaKP3aNWevG3CdEmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=0MZ+xIOI;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=1jHlktj5;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B51606A326
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 12:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2B51606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=0MZ+xIOI;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=1jHlktj5
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 4DE7A1D001EF
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 07:19:12 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 11 Nov 2026 07:19:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794399551;
	 x=1794485951; bh=fOxPoVu+UyB/dOsfQsvoewO+psDAVMAoj4nKiY6UcIY=; b=
	0MZ+xIOIwv4tYY8LsL5oYk5HiAuuCuiBGLfZyba5ETbV52OMS8hWC/qY1NNflOzC
	dhUSSSdkCkGgAyv/zhEwkxnvmwuvPj+py7u9OlmVHECy5t2SPxr7zYW9/4uLzyKA
	AFLkD/PtUHPuC3gMqlf0/VhwnycfxMgE6jA9jt8EzaACnpG8iuq9OLMg0NNbxJMf
	0z9TEAobJXM7wTSM9aGcKRMQbMBIevRP1EgrEPqQQMZ/YDxRA/Q75yTEKQoYiReW
	rtRPQYUtANyN9Mvp03CGEsxntNEZabgPKoyc4DkoARSJY0/B8kPZ225cKdWHV7rI
	mvqp73Cfor5aoPHxtPiVGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794399551; x=
	1794485951; bh=fOxPoVu+UyB/dOsfQsvoewO+psDAVMAoj4nKiY6UcIY=; b=1
	jHlktj5OK/Bp+A4BPc4A8WeiwCcq+3CHyDS2nkjiVc70JDOt5qYcCeLIW6hEypLJ
	6IlPiyYswF5x9YZ//uO5TzHRXSaEsoZTab5U0dS2zSyrIUw26++MES8lzheAy0ba
	rFHmcaOClK1cLwpK7dtBze9fF3ukDpKzTYIQv0QZDiDUPFZOEi0A3HYLuSgionrM
	v7aPC4989X/lXbhBUbj8y4RemcZKN1EAudUCMLfWIgH7HvZ3O3rS1x9p6lmDzjio
	4QUpQ0nsqxawNSD4ks26Uep/oyqoB6EQUZ6C9Z65RZpG/jwENVdxSH75N7+NANQK
	LfaK8rl1JOw09CXt/GlOQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794399551; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:qOg2jQPgK23hP3evmvrMC1S9lJYxvHyHxzu/lSuYBFAdFOs
	o+p21RWygr0c2JVeXMbknZwrs9My2anQvOKQb4G5U7/Q13lGyt1e24iUEmXyHRk4
	VxI1LdfRD12ubl3NjhlwzP4Gb5HxuDHxcmNt17AAUV4L0wQTBXnWbIDBkB0/x6dE
	GBL+0CAG6D1SQ1qpUZl9tk4D2WFShav6NHRVL00QhGwq+ZB2QXg4+X7tkzCKBZQd
	pk1HhDf2uOfPYQ+5lA0CkXSTZqAmb6X+dp7OsDUl3a49QVDQ5dTRdo/9KukhJn0O
	K1Y8vWAbJX00Sr087AfDhsZNbJ5YRtlc+fr9y2A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:aieUHS094TCmuC9/ftDCDfSuwGOJnbOUN5+zHkxaoFY=:OxejvOhd26bDgMwxqUY/smusECQ2xT5ZEz+L2FF9HKY=;
X-ME-Sender: <xms:P130armznA74_knc5POxnrmodM2L9ZHM9DZDTDOWLhldWxWHT806nw>
    <xme:P130al1864Gubb7OfRfpijtO_MqniJ3AmvAzDyeSM5IQ54DdR3QAo0L_8ZmAsg8sN
    Ho4d4X3xd1FvQrV4RRjiYFun2_ogbggIXv8ynmc3U1jKT-p9Pvegsw>
X-ME-Received: <xmr:P130amqPpZyHgsRNRw9MNDUhGEwF7SMyTFZliz8IArYsZW9A5BXRIqv12sOOw2LScR2vyA>
X-ME-Proxy-Cause: dmFkZTEs55qCzWsYoLPbwZcukLNmniUbeLDTcdDKMeykKEfUVEL1m88jrC01ekZ+bSWJoa
    E+sFoYwZ2KKV5gxeH/ExdGc5CSVyfPST0RqGE6Bbggl/uEHeCPByTgFXNeBnwva+Z0XW2r
    UZoU7LISJdZGQMCtFN0csNcTpVz6UT/yk7B1tHyfQIJhGE6JSSH3Khft8I3OScvVt+9r2J
    JCr7yS7gYfv0KH/6Eoau/bELm1wIa+G66GK1YjevJqlqSZiPrxhXg0OCkDVjeE10B5i3Eq
    5W9VBCcRDFn/N/p0TXUPA3RQGg1OrrhL1N5yTTXXzoA84sYsO7dJi+MFVMyScSRkiTpvbo
    PZi0KgpTGKb44fN8t6eC1OIK6x7za5rd/wQ+SKweC5erDTZt/iyM6zw6mfETjJV0AId65S
    w/n2ZE4yojkocHIQJl+AeGq7B6FVKS3L1xTjX9PeOQU8A5Dc0elWWhWM2UkeGJ7TU9Yfzb
    Kyq0O9gtNYxu0HxVkY4i0q2K0kQSxmv4rRWChjtcFF8HAhpMvPqgYE5ji8NWOszBskayUh
    TNZV4JN7QntbypMru5GPDTHg3vu9DmDlBBuavIWx4LB8P/4djFM4qegaRlSqzaHgnoUdg0
    yVgZowqdL9aYQEFdhza5j8wEtbC5jBqTEjR1UD7PpZ5nf+/LWKfkj4urBvBg
X-ME-Proxy: <xmx:P130aidaL2x9riDqCF84LoeWmmm6R_kTdErgFpIYIsb5kHerjETa1w>
    <xmx:P130alqiXTbQm60gDRc20ekjZpTsUXuEQjXX8gFOXDC3w2wrvtiw6Q>
    <xmx:P130ajFKSUsFk1VyUvTbXHFSY-x7vkYuNn8nRFgnkTaUrUypuiDlYA>
    <xmx:P130aluw81E-M3sUoc0ROzcG898Tn9K3oljJpDNPpsfCH4r2OI4VBw>
    <xmx:P130aiJeZGKscU6L0bgb4ZCEoU-DfIZAijmLR1FSSn0737Gy8HWd1RUG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 07:19:10 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0e51ddd8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Nov 2026 12:19:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 11 Nov 2026 13:18:44 +0100
Subject: [PATCH v4 08/12] builtin/rerere: turn "remaining" into a proper
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
Message-Id: <20261111-pks-rerere-subcommands-v4-8-df0c8bf79e16@pks.im>
References: <20261111-pks-rerere-subcommands-v4-0-df0c8bf79e16@pks.im>
In-Reply-To: <20261111-pks-rerere-subcommands-v4-0-df0c8bf79e16@pks.im>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

As explained in a preceding commit, a subsequent commit will introduce
proper subcommands as supported by our parse-options subsystem. Refactor
the "remaining" subcommand to use parse-options as a preparatory step.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rerere.c | 42 +++++++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 2bcd270a1f1..3f82bcbeb10 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -94,6 +94,34 @@ static int cmd_rerere_forget(int argc,
 	return ret;
 }
 
+static int cmd_rerere_remaining(int argc,
+				const char **argv,
+				const char *prefix,
+				struct repository *repo)
+{
+	struct option options[] = {
+		OPT_END(),
+	};
+	struct string_list merge_rr = STRING_LIST_INIT_DUP;
+
+	argc = parse_options(argc, argv, prefix, options, rerere_usage, 0);
+	if (argc)
+		usage(_("too many arguments"));
+
+	rerere_remaining(repo, &merge_rr);
+	for (size_t i = 0; i < merge_rr.nr; i++) {
+		if (merge_rr.items[i].util != RERERE_RESOLVED)
+			printf("%s\n", merge_rr.items[i].string);
+		else
+			/* prepare for later call to
+			 * string_list_clear() */
+			merge_rr.items[i].util = NULL;
+	}
+
+	string_list_clear(&merge_rr, 1);
+	return 0;
+}
+
 static int cmd_rerere_status(int argc,
 			     const char **argv,
 			     const char *prefix,
@@ -160,17 +188,9 @@ int cmd_rerere(int argc,
 			  skip_locked ? RERERE_NOWAIT : 0);
 	else if (!strcmp(argv[0], "status"))
 		return cmd_rerere_status(argc, argv, prefix, repo);
-	else if (!strcmp(argv[0], "remaining")) {
-		rerere_remaining(repo, &merge_rr);
-		for (size_t i = 0; i < merge_rr.nr; i++) {
-			if (merge_rr.items[i].util != RERERE_RESOLVED)
-				printf("%s\n", merge_rr.items[i].string);
-			else
-				/* prepare for later call to
-				 * string_list_clear() */
-				merge_rr.items[i].util = NULL;
-		}
-	} else if (!strcmp(argv[0], "diff")) {
+	else if (!strcmp(argv[0], "remaining"))
+		return cmd_rerere_remaining(argc, argv, prefix, repo);
+	else if (!strcmp(argv[0], "diff")) {
 		struct strbuf buf = STRBUF_INIT;
 		struct rerere_cache cache;
 

-- 
2.56.0.611.g1030f0b940.dirty

