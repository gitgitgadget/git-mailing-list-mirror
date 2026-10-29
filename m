Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793267864;
	b=s8VHka4M+sa5bMeHj1UeNnEveR6iaJZI8/PzQfMkH4DpyEFwyZxq4n/hukoRCXGl9lNJ
	 61PnHXik/+Ln7hPeraWVamgsqAdua439l2rIv29EZFxTKf/Zwg4Jhjha/Z3UKnXLRpEBb
	 RiAKzMeD79gq2Cp0h2t90rsh1zAzAkIeGzHReEbx6AMeYslxz7kcIbH+zVQFa1zP57I94
	 IlSp8vEnTGl6uVtYTt5pbyMuFQJKdeDYRFJaIcmbr9HQlE4ZegubqFOQXN6qRwNLZUb05
	 W6L93bPZpU6W5IPweH69dE1wmuv08J7AmZqz3pnrlsvIijEuMiQxGWkJQmQa+PFXZvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793267864;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=HSqoplO+AI6oJIjXsYwxhF3PT+bDJOpwi4b1n/D0waA=;
	b=JIUGEbxk+Ow0vv5x44oGIhidfu+wccdbKImGiYW+vSXCfSlkUSPlZQdZFg5cq4WF6GYZ
	 uOha4jzaTRVHJdjFpsCUpMgTKcIfZZiv8mKFVQHZarUe4m0eii/Dg9Ze372AVsWlgFzaF
	 jTy1KoXbAjwR5x6EoFQ7E5z6JWLLWUxhB2ixuPAH6SH2RWzu+DNSIoqtJGavpE4X/khwo
	 9UPArA22MvxEfpT7cOXGi9a76dUPzEs2X3BVoSJ4jCUK2PMBx4WdgVP3DT62vsDEB9CJM
	 CetWJyn2aCDjkwQI/XC4zUi8snj3BrfOctjkqDxziCoN6xs03QlDshSyxKa4Kegx6ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b="d66Lv/nv";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=vyJOC4FN;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A673E606A323
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 09:57:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A673E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=d66Lv/nv;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=vyJOC4FN
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 087DC7A0123
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 05:57:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 29 Oct 2026 05:57:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793267862;
	 x=1793354262; bh=HSqoplO+AI6oJIjXsYwxhF3PT+bDJOpwi4b1n/D0waA=; b=
	d66Lv/nvrVDNjpsfxJ6R/WQfLmB610LDkfN5YG0HitfiyGmiqjfGZtUHbhb+Bm/3
	ZCYx93GkLoFMfC5xyZvTtmejO4WxwcvjV7KVUBBqxWOiA+qgwyBrM9vmCyDoIVrS
	CCX+OJDP/HW5QC87055WsMN1E/N06PvRZP2/EwetTnes2pbN7h6uXB1LxfWiqguk
	7nFD4C9y0DRE6dtWLbskzABO6CkaVj6x7cl5aDEcPd7fC03nYs7mO8PO94t+uiEk
	fS/jgJvTb9RtKtYFoVX84+XMRX3hEJZmeHtHuxOB2IPt3clGWS3AWzs+jWozRi3b
	xmcYH0xrbdfdhN3odSOy/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793267862; x=
	1793354262; bh=HSqoplO+AI6oJIjXsYwxhF3PT+bDJOpwi4b1n/D0waA=; b=v
	yJOC4FNE+/io3/ZdnF5D1LyMO0bKowRt/TmhjQfayPxuVgNPi0rjaxk6l5+0DkDd
	HvFAr0mVUDtDKdvHa5JsIZ98zJ+6XPCGM87uGlENEnqfuZb1axDwUNRciwJHB0m8
	HtgdpI9annJCR0/LOe6JiZL+kNab4n3NdEB15HdYNqlDv+06F1XUyFZ0OASEU8BW
	qU3Lqd/515RUJpXHmIkhEEzTkAL7kpdB0pri7aT/nPgOvOARVXSncZzQyEl/ARz0
	actCWYjvgB7PVvp2E4Wd/xSEDpqDqjX9xrSL2kPIlUMkGT/CIxn89MTNsfNLCI6V
	gi0OXmxAa7BEpFSHObl8A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793267862; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:AMmIOw/1R9phqCN1rDs6yEXRtaUDBM/IEyYQyrTTg4v63XI
	WIiorVz00K0Hf99LXN4PDlnb/BWMNd8UfRMxnK+kadgeDVj7mx/1hluOEMbFnDKH
	x1OGEkREXDG7Ix8hZrW8bWYf8MvOFRGtGJ64M7wRnMaTX/zItdxMJrhzDyMXa6z5
	J5bY3mw3eQMG6lWckonYtdZotgCdBapW2IXrCg71ROOyUrGr8190ivOMb26/y9rg
	xUJdAzLY/xKesmSG4RVBqxYCj3m981qoKZJzawvYeQgA7y2ROCIzI5KfmFxHlS8s
	rI4+ccR6Yh4FOupwP4m3IRAJNeIL9XUrknSenyg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:1z58J/KHxnpUTHphgF0bzu+OCrMC2D2U+lzNVZ5+oAY=:R3ueysOhJEcYO9gqpdBtqnA7EJ8P4W42NJlhuurULXo=;
X-ME-Sender: <xms:lhjjapTp8fxF37ul9lOuQMVEPbC91vwxHGUcVMNELdyYSFaAlvJWcQ>
    <xme:lhjjaqNjHWmifvU-YsTcfRv_PjrzVW0rQaAn8sLMDsEJb8-zE9SvVsX7rLAg-Uxgy
    KP0m6NrvYbXHqnv7fRX5yJHGx0nL9bOzi_cXEpsvBaJVScjpP73398>
X-ME-Received: <xmr:lhjjasPmyZFNoAx0KoJRN2jePElBka12e56Fh0XVexpxdUoI5zLS_w>
X-ME-Proxy-Cause: dmFkZTFz7GEluYeLTTRzglHaRef5X7tlMshWXL90zL413q+2iTysZJNeYL9PtL9HHCzOtp
    RFA2e5BmRIbnnTR0jljp8XIjPKcCHcst+YgXlPZ9LGvgehIed7bSP2+hl7OZpMKQeTbmrR
    c3Q9B3GYc9Q7q9JiNzO7O2Czq5BfhEptKbVsgJf2GB2NOOGbOlHHY62R8BeJEn83nQaq4A
    JWmqZ+HlEtT0Uwbn9zbTAoiHqVUcbkPGDQdAyJVQ5jF+cpPWJO/LzuJb4sodh5A3YCmFyf
    9PtwRxQg5l/gsWDP8ZO5Eh8K1Gd5hGvTJ0flniyroLfmTzAVfQowaizssriHBI0P7SPKPV
    0Cg7I9Tmr2H0cOCdFUEjC3IIpxkWi8PyFfRhyaooe7DLONCAyq8qjPFkqjwtOAsh7ayAYU
    qhmTctp3Gpf6CdOejC1Gh8AsTmKu88YIHNSUeVmAlc7cr0ofbtIH1JM7Kb47IoXKb0ElVT
    uCIIGeCf5VL07n21HgSj5Xn1ecV5S6o0pSKegN6Vt8UtEzmVSs2bdjXLsETwi57LLzu0k4
    KK71YuInDlxT0RhxSQqWHutNPsB6QhvAUO9r0VisP7DkcC0mpPBQ7ghN1++WHr1mS5MmOm
    rcULektkbreDG/O/c67rS+0AGbqclKQpbu+vRAs8spSi0cBP12wH3qmmHfrA
X-ME-Proxy: <xmx:lhjjaqv22Dbhr-e8EfhblSDWnXiTX1z6CoF15Vnj0T4P_gkOHz6s7w>
    <xmx:lhjjamUkBGJ3rFzG0NJIlw_aLvSj6Eg5vFmm3fOJrWCWGqb9R_OusQ>
    <xmx:lhjjaiu-I6ISqUovxhQ-vF0X6kRVxmYQ6lDT4AFdPwMMiykRNG3uAw>
    <xmx:lhjjaiWkiS2orglhkBHy2gX2XssEnAXryfBtyQA_i6TkcMfVgrd09Q>
    <xmx:lhjjaiVfusPJNXvzJrgOEwSwST17Pjpz5M_QU7yMM0kh3zrHzyPGJIIA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 05:57:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a431e45a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Oct 2026 09:57:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 29 Oct 2026 10:57:17 +0100
Subject: [PATCH v2 08/12] builtin/rerere: turn "remaining" into a proper
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
Message-Id: <20261029-pks-rerere-subcommands-v2-8-07d5ba18e882@pks.im>
References: <20261029-pks-rerere-subcommands-v2-0-07d5ba18e882@pks.im>
In-Reply-To: <20261029-pks-rerere-subcommands-v2-0-07d5ba18e882@pks.im>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>
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
2.56.0.341.g393f52fd96.dirty

