Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978073;
	b=1GeD//q/5Wx3mksneoA1ZTvzBzRFTuGYfVRlVuQ+aoIbG2z2rvKHdaxZfm5mkYmNmLw/
	 f8rNeGj19J/mi+9//OOhYlBrZjm9bhuiI1zt+/L0rHXM8tCWcM22BL9Gxy3wMvYYV+GI5
	 0r/KDPGp9N3a95+IEfB1K57kIH4l49ZWBMPHU+Gyys1jzsV9SLWdzaR6/yFkdyieSAFc4
	 obc08kGeeULHv8sQ2iJWeFZpvcBp6Sk694NTIyN3AcVNLrMb1O/rrbBHQyxhVdKiTxJWa
	 asHn/m32NA6Fu8W1aKy7Aj/kPeEVo1VL3qhCoDjxihu3Xk+S4sSSd/2Vx6neh9GNXlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978073;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=AOQ8Z7fMWZBHR6kxSXbUlIxGnSrR6DZ79MtFKW17Zls=;
	b=HUBYCzuBF2nk8CbxqyyD5BWOboVRWL3JVN4IpESYjOx/sfV6Za4XUZMKBAzCL0rdJYmX
	 xiqew/tl/1sW/AcA3Na/909hIn4C4o5mET0ySntJWBQhnsntgnFV9TJeDxhefVbVUBTyx
	 r5lZkb1yNffKMAAikEHVRXuV9uZ/o//GSxyn6CVdAbZoiz3r/T47rfnC9SLJTStP//MLT
	 CdqjHScLMJQyRORpHvW2W4DnbtbnROZrOKdRv/ZKtcis1N8T99g07RVS7CrquA4I7y0yW
	 unskH8+9rW20pq58OHjziCXx3xwlVcvvj0b6CRj6HsogMz1+P7OLvcsnGK9af+4VFRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=FpzFM7tj;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="ZmGo/meG";
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1A4606D808
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 15:14:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F1A4606D808
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=FpzFM7tj;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ZmGo/meG
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5F54D7A008A
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 10:14:32 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 06 Nov 2026 10:14:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793978072;
	 x=1794064472; bh=AOQ8Z7fMWZBHR6kxSXbUlIxGnSrR6DZ79MtFKW17Zls=; b=
	FpzFM7tjWD3MGlyr7i6dOypFTFqAWglYDZwkx/zd4PfYQn5hHMB8rjvp40fmjcva
	GaMgZfv7cXhpt6gtwLS+f3MStagHLJo5PPp7W1OLJvOgLD6DpBiXC3gOtTdfodhE
	iiky9CoItF3/lpAEygO+89FQ4SiwI8A1z0N4v9YLRzKUvDqrblc0KsrVNpgoN7IC
	WjR1NmUyrINP8NYGBCjWSE1zyagz+ZTl6tq182ToEH6st1NWRxIsb7fzj24wWgGo
	gwtGiGdshharUzUt3bXy8if6pfOESE9JO3OdXGSnxHs3gvOeKAO8hSRO57KuYR//
	zr1OJ4vQ7e8W5aklzLYbqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793978072; x=
	1794064472; bh=AOQ8Z7fMWZBHR6kxSXbUlIxGnSrR6DZ79MtFKW17Zls=; b=Z
	mGo/meGtOocapEEdFRj0fimuJATOPwEVbwT19olCDg4/8wbgEWKWka1dtM2MMAMn
	4FPwj2vqmXaU7pZg/FMJD++Tf4l+WFnYMAKxIXs8yECfzEJ/ukr7EX9rPFKm2U4I
	5mDeHM1w9R3faQXr3PYeyEINFvseqRQByeCb0nJiecc4o8Kbc8Rs/HB1qLkP0ocJ
	EbhtmAsozcz6fpEfjYVqy6o3jk4b7qoQV8JfgGuNyvjV1Nn2y1feDwC+tZ1/jBgW
	knEm84kznjQfhJLudxlkGRqBiiPi5ZLWARKwfey3WEICN6O+IYUEk+JVGk82nNJ9
	1dD1FgJBWw0Wu3+gYl6bQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793978072; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:y4lZ/Vx63NCRAyf0jqd5/ntbw9xToClZI2Cm2DEHBhAfYhb
	W395r6eIQvoYjOz+oSsjkwqt7dd6+2ghNaCxmHmaj0vAYQSEAKaaf+Sxs4ibWmi1
	73VFP11eEGKWKyE2O3wAHpac9tKlztOAKk3pjAXfE9GfGfTP7lgNqyCw3Lk54194
	Iy18/aHuyYzNlSkKhiXGyQecvncLjFcsKsYLimET+g7xPyXG5YdcDOPbwdMS9DSn
	Qd/PW8OKf0AjK13x/XhaZ6Auoe1FiRi9OVQluuNXIh3RfvePy1M5upHmNQ5xpfm/
	YuACg1prmo8jYjLdBcil8nHDnh5SSuPJyRB35Kw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:bBZjA+7ujUhb1mKF8ykPuEZll1pTaJXuooixyNfvRH0=:lEekShppJmBuAGct56Zclmz4iqBAp9gUoCkjWeWbX1k=;
X-ME-Sender: <xms:2O7tagp7wz7iaQx5eDEZSVIkxh1bMPqtspGSeIypj2xRSjFb7PQdLA>
    <xme:2O7tatofLdYeOnbA48spiGS3mTPLjgoeemi3fZ2LC6P7PUgYTQxw5VGWXQZA2G7n5
    0PGs6oK2yCF0o8s6ypV4XErjSlJ1lFKuzn7zUiGNSESVOCZxwAKn6A>
X-ME-Received: <xmr:2O7taqN5tpIBBTV6dOyHC_ptQQ7LbnuAuJuMSmDskuL_qyc8YlBmcXgvr9svovUhfAAiIA>
X-ME-Proxy-Cause: dmFkZTGiZi4I3D3CFJhnJomFWQgm7nh8fATounvHJJfJTKhJBDSXwFkf1UTNQevRgOo/XS
    B0fO+LwfdZ/bVUfdSuMB1rI9hxrRIUUzGqtg5r0mZwU9GqbnYsAJ9TYE84IT8txAPorJbn
    NHN8gdy0sDIRzMTLMfTG1SxQ9FhHmC4Yb+T18pDVlgOMkbZViM13BXioSzd+HshVnOA4CA
    hqqMmliZ65/IjfPQyvweLauBA9UpUdkd9ioUeNq/OTed1TrI2A1Y22k4iBYwYD8kqUFvJc
    Bt5wfnc3+XBqzyHwL4SNO5UZ/abkYXxesxYHlJVHJguw+GJ9QeFSxn3NE/5/+bILf359Yz
    6jYBTZyXxvoyY8hogIgwY2FYh96OX1rsGDgZg/BuMMNCjXT/Y7NDqAwwq+iFxnvZyWILbN
    Q7ukqOtADyhrNb6KqrRI1JPJ7u0Ide4iMvJeuYJALHzsc5P5BrIKNbsHjwcQB5jtBRxYQA
    Kqf1+iryAe1JIy84EMGxYyl6Hzz58H0o7bW1LMEvlglXjOO3chQ57mMa/lYb1pIGCGB1rL
    eaLmd1RobKsZebpjLyfFl4ACK0WFoHLTzoou3tBvq6Z993yvs/A1M0tB1PLYDHYP/J4w+z
    EyWwpZ7KBdCVbr4Bzes2SOWYvq9QyT5DdA8V2Fj1UQdEzbdXfPmfC2BXHacA
X-ME-Proxy: <xmx:2O7tamxKXr6K4rTkEg9ZmwlEJvdTVDWnqvvOucC5TwOrJV2X-RzuIA>
    <xmx:2O7tarvt07VQeGXMvtFpY_WYD8Zty6s3Mw3UkX9SuJcte0aEu3UZYg>
    <xmx:2O7tan6IzHN0EniGG9T_wkXOOQpkufY2qvtZSPTZ4TjjF-Zi7HTKXQ>
    <xmx:2O7taiRlyrDIm7yQCohLnBpm_yzjaJ7xN4kvTnH0YTF4wS0t0QdWcA>
    <xmx:2O7tapvpER-Dv3MbFk_U8mfFliSMBkvv_2a6td83fV93DRenU-5b0YFr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 10:14:31 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ff79f1f9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Nov 2026 15:14:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Nov 2026 16:14:02 +0100
Subject: [PATCH v3 08/12] builtin/rerere: turn "remaining" into a proper
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
Message-Id: <20261106-pks-rerere-subcommands-v3-8-4ff164d8fb81@pks.im>
References: <20261106-pks-rerere-subcommands-v3-0-4ff164d8fb81@pks.im>
In-Reply-To: <20261106-pks-rerere-subcommands-v3-0-4ff164d8fb81@pks.im>
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
2.56.0.500.g5d06dc02cd.dirty

