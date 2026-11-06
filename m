Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978068;
	b=l01eXp404EfvEt9PJICbPaAyEI6kyegDfIsaCPBUJ++/IpWtAI6r+uV+BWibBhyJH/aQ
	 0GU6TfLOcBISotj4hJTEn9VZvT9AAtJFi4+3M8orLoT1nunNq3gepo+Qco+OX8hD3yKrm
	 jwfq8hKT5ljiz0qtkiaAzIuwlGVahLDF2m09PuVuYpqrMkXMUTY808M+WgTylkX2Lx5BT
	 MP1NFdNowMHerafrvalYoL3Rqvzp6yeLukAAr/D0gfbI9WP8gn2R9pXEh+7qUiaa7PWOq
	 pkz6Z4TaVm6L7a7RPdys/7vJter/DFT0JPIO+kKiW4EWRHeEQXx20fBKl5NkIdoHavg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978068;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=MQnUc85eEMEp3HDDX6GDhUETZ/FzFVQljwknasnjAFA=;
	b=MLX2n6Yul/mYxcvjJIrd0qn3QHz1TjHyUeZocE69j5fEbkpyG36JBJm3d0K9IR5/AI3a
	 2sqnmFbZp78+bdUQ7Ewt3uTdW2mFIRU22fW23VuqtyOORs/RTQT2rr7CFFiFAlvuyuNHh
	 sWlymbQkXs4MU86taJTTbAAcYdfFB6pD25QwADs6jWByww+iS9Q/AJjw39GWZW8KMB7or
	 2LzWWI8+hBFlw06LSQUH2cc+2MjnZBwvqmgyo++sitw0hZT6AiUNJkotWjk79Bzs8ZtHQ
	 Q0BNK+MTNu+iw8S8A2n4v89s+4m+ROzAfSi0JA/7xtPwK5HT/XyeTpSISC8/FKHPGnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=XQYIc32G;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=r0PD2+cw;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFAD606D81B
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 15:14:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BFAD606D81B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=XQYIc32G;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=r0PD2+cw
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 729001D0016D
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 10:14:27 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 06 Nov 2026 10:14:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793978066;
	 x=1794064466; bh=MQnUc85eEMEp3HDDX6GDhUETZ/FzFVQljwknasnjAFA=; b=
	XQYIc32GYYpjHgtg0No+Q0FZh6zXhEupn1/j068gi0//9w9sHv8jiEafagrr7yHG
	RYRdVxJMLDwZ0BnKl7RELA1JboGAyX6T3llOnWzHseK6PHEEMyQ3ZALlzVchX4xE
	NslltYQ7MOYc9SokDmCED/Fa1DEUuiUI3pUa8JTDvL+M9jvPXh3sHAVIoarTLJDR
	7EF1UPTs5EaRYCAI0pV7FG7ut0aVmiiHEysKnRfg0FEcr6g28Q2KwuvBAFGqBQ5m
	eZBOEyhpRJaTDaVfgWoR+UAtGXR7vKV7SAwP7w6uLQPqYmnKEz+fm8r24EfZc8Ho
	zwG+70I1ROtK4K2dS1mm8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793978066; x=
	1794064466; bh=MQnUc85eEMEp3HDDX6GDhUETZ/FzFVQljwknasnjAFA=; b=r
	0PD2+cwGddN/+g2WL22cipdGNUanuprjDkJ//7TCZqHrYF2drCGRHLZ2mM+Opunr
	VMWGBSbQkwco0rEOHaaa7+bPuKTw9Pgzrdeqww4mejOmY6sornqfmVSzJg/P+H2F
	MS1z5ATu03fLc9QbKbPjec2fP2B5MH9dkzyiiqzsHf/Zyz44elZbeym0sYNL3QVM
	iGgmmtDLHqWICeNDI01p/xUDo9gBnLcvAMMjXS3UO64fcL7ixBYS/s2GdoFP6mNr
	wI+3RcNS0y7bNHU1YKi3piY5YrTOiwrVBnRQlkp3+cHLJihHH8W7LtRRtPUALnvi
	p9f1xbr71D+UR5LhUAHkg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793978066; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:BNh8Py4LuSXTTWg4dWn6myJamZNzpDyewt6aTfYHlrSCazu
	WPaFjQgMNI05FB9roQEvWCrol5kSOs3huX0hGqv9QB/cIJPVat6MLAN1pkVXqabJ
	TUeua/lT6ng1WQ52QBQHmvKxZTFrrxDeDtCpWYMabZKWp3M1Nyb+O/ma6qt0Z9el
	ianlk9Er2w9rNXA7751P8W/K2YTPWT2YJajObVEOOMbaslhVegGZOimMgDTY2Ved
	ue0GAc4O4jGtFEQQXldiJ1LeZwsiuIlxCviQ1TjRZw9U0RYFt0VXPoMQnRLcu0aT
	nVzvjhshAFB109jbJEmGiKhPsdISbZf1QYQytUg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Sfht3vwmwfiR7tbKPoRLLZ3famK0fMyIvaWf2lbxEgw=:rsa+9mWncgjijchDE7nU4ZJth3TavCaiRs9/L4zb4a0=;
X-ME-Sender: <xms:0u7tahAvFTz1qenQnBTqnip3EZb1vjl_Vc3z-S445CwNt7dPD_bdFw>
    <xme:0u7tamgqPEMaYSii_HMMJ5mX4AUB-JmnrmskJCNTnNSCM6bFkDNShZdEQ9JK_6FKJ
    lwti_ef0-ltkZxhwwd3wHoGVd8Hc2zJcUm4zk_YYo3H0iX4rV99_Qo>
X-ME-Received: <xmr:0u7tahmMgWSbrADEY3HEZmsvLj3IIlDUpTll8mYg1a-9HnIsN4qwSk95nLlOEDcOZhcPkQ>
X-ME-Proxy-Cause: dmFkZTEw7tFw6dVAxhe+nBO80R0Ez45/MpWEWDKogOQwDsUS/FIZ5z6suLfJHGy+XGzaqU
    5vG9YQO/2J6AqJy0LsOa5BZsSlVIFRCn4kB/BpYxstRd1gDa4QQLGTvNWlGdzsJN+wYXiW
    Rd/jwklub9c7FhbhevjdqeSEdtpUedcWI4nApZlcGZK1xMhbFMKn9tdcIvpBGzhq7/cfyX
    lkRdtClDljsDB+Rqx7V2GhEzQ8nDArm3WALKaCjECRYeGr7aNsJPwc24YF4lXdnHmqq9w+
    INluda4ITBcImGnCZixdUh9CQ2ALx8EYr+XYvYdCdO2eA6DvxiOY6kuQw9IL+z5iLIs7dd
    T66PG9uKDRHU9iXn5/ta+ZCvMbnBus3eBXHIGJ2KFNIaO5qIWjlFo1NmCgLC5167SgUMlv
    mjDleMowW6TujzhBpIQrcRAED661CluOi7khicl4RKQCd7tYir5dWpMQqHmiJVOx5KM9Fk
    8fWioy5ozyrxJ7WtEyYIZz3rw+pDM2eQ+QZGLaEM25CVi0GORHsGUhySDE83I6vJSsVE9m
    RsgDcmKrjveDCzWvNboNnWVGjWVJMSQYV1CogEiUNjAiep0a4aYrhlw9Yi4yoXKSQwcvtG
    GaLZRKCZUWO1WhsdAP/T+9EsmHN3rU/JdbUDmMlailtb9mtHfVmtdBVyuU1A
X-ME-Proxy: <xmx:0u7taqoqM90IAiUT4xWp5zHV-w3RkXdIRYAdlie1p3ujutBIvPlYsg>
    <xmx:0u7taiEcF5Vp03wD_l5uG-rePRl66QIqn9I-F38w-LU2WFdSWhhkBw>
    <xmx:0u7tauztHhniM6sd3f8pi2YUsJOrpHER7FbfS_QM-oLA5emcSZUoJQ>
    <xmx:0u7tavpoaAG1ZeHeAGe04EjDorY-FTaxzMW2eaqA6FVz7Xh9Gdongg>
    <xmx:0u7tapFrSi55Kh1cRr4Kwf4a_yg58t2OxquH84Ete4fGTMVsOnbCTCly>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 10:14:25 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0abfc478 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Nov 2026 15:14:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Nov 2026 16:14:00 +0100
Subject: [PATCH v3 06/12] builtin/rerere: turn "clear" into a proper
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
Message-Id: <20261106-pks-rerere-subcommands-v3-6-4ff164d8fb81@pks.im>
References: <20261106-pks-rerere-subcommands-v3-0-4ff164d8fb81@pks.im>
In-Reply-To: <20261106-pks-rerere-subcommands-v3-0-4ff164d8fb81@pks.im>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

As explained in a preceding commit, a subsequent commit will introduce
proper subcommands as supported by our parse-options subsystem. Refactor
the "clear" subcommand to use parse-options as a preparatory step.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rerere.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 5d2ae154ff8..62f69b488b0 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -52,6 +52,26 @@ static int diff_two(const char *file1, const char *label1,
 	return ret;
 }
 
+static int cmd_rerere_clear(int argc,
+			    const char **argv,
+			    const char *prefix,
+			    struct repository *repo)
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
+	rerere_clear(repo, &merge_rr);
+
+	string_list_clear(&merge_rr, 1);
+	return 0;
+}
+
 static int cmd_rerere_forget(int argc,
 			     const char **argv,
 			     const char *prefix,
@@ -107,9 +127,8 @@ int cmd_rerere(int argc,
 
 	if (!strcmp(argv[0], "forget"))
 		return cmd_rerere_forget(argc, argv, prefix, repo);
-
-	if (!strcmp(argv[0], "clear")) {
-		rerere_clear(repo, &merge_rr);
+	else if (!strcmp(argv[0], "clear")) {
+		return cmd_rerere_clear(argc, argv, prefix, repo);
 	} else if (!strcmp(argv[0], "gc"))
 		rerere_gc(repo, &merge_rr,
 			  skip_locked ? RERERE_NOWAIT : 0);

-- 
2.56.0.500.g5d06dc02cd.dirty

