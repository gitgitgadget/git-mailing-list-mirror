Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098047;
	b=cq+UvRiZiClyPnRXozq8QiCLrx/BC4KgUD5z+oy+5xiw5vIj9dtgi1n4KCHkVa8pch+m
	 MO/1vnW6vsUPEuOEjaNuLUFzka3LVnoPCpII96kpoKDJHGrZU7YMKxWFPD71dy3Vry4Gm
	 ej5oA4nicLhQA33DWKlMPbsHM1V2b1Hl/9vxpagPmXtyR7ev+FaM4oN2qD8KkHWZ0BGx+
	 tgv3QCIAotG9dB8tObxz8DEwUpiiGE6Sb/UbSoywwdbwIUDogYosJigOnzY11RbtEeDUK
	 IB3oL99MablkCvr8Xs865lMFMXgNUo3iF8cJGlQUgWTMsYA843iYRwOs+awgC7XeYpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098047;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=oMJY1OmmefFWKaFkXQeMCvx8/82S+lPnBPyNwqpHb7s=;
	b=Gg5raupPn8Iaq937WNaNunXefckefrTTwcu6n+5XTbCaH40xwqiq4FlhFXqryjWgSDkb
	 X8Y1h9nZtnAkBojY95GlwnbhFyK6EtAwYHcXE+tXzi4v29ADSmx6R9gOnNcSxPKipOR9R
	 CrKMYqVssGjSVdjF4ReOhI+IMfXJEl10y2GeQkGcoWo8GQCe/NA1+4eoFS5GPs0+ArKI8
	 cMIsut3o+P/YzIqeDHYz/95Q7sjO83vxf2Zx558BD15ZFTiKmeq0NIeVaZGMIlMYL8fkO
	 KWZlf70zJI5NH6ifTKZL5pVGrbtfHULKwBb/2CsmXyPTy+tp4OpdA0Eu/IQT61vpkGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=IZKj2GXI;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Eg3Il6En;
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304F0606A323
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 10:47:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 304F0606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=IZKj2GXI;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Eg3Il6En
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7EC397A0086
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 06:47:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 27 Oct 2026 06:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793098046;
	 x=1793184446; bh=oMJY1OmmefFWKaFkXQeMCvx8/82S+lPnBPyNwqpHb7s=; b=
	IZKj2GXItRNtgSz+gCHKyfK2hbkYQj0Qoz23ytwkvf3Lmfns99FvyLgH3JDrGfZ+
	BgEY8MYGsezJ+/eh5GvVhZXqzeIv5EEL3Gv3g4NE+yI/sAMaLE1JBOAGayikda2E
	vNBpUgIvby2QiAYUc0JgC9/czy2bEp5Csqi8PWQ8lOzCO26fQLd+KxUFb0xWOfet
	3XeDOZZ3hq4eQEhFiK0RY3jn4MgMatMR8Z9VRkmi3eX+MI/r2MOYGevsRTMyIgkz
	FsY3xnmesai1RUOk83am4DCK5Kb8UvdIwpUmlqgPyD1408Bgq9xebHYiWsYhfdap
	lYB9Nx8aTXfU0mLme9zO/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793098046; x=
	1793184446; bh=oMJY1OmmefFWKaFkXQeMCvx8/82S+lPnBPyNwqpHb7s=; b=E
	g3Il6EnwAIRTUVYcNfVxDYD6l7VKRBUjWIeuGs1p65RWpcrd5ct09AdhVWvrpvfO
	U0EU7tISxPuy2Zzbq/Og/OLVr2z5DUTyvsoM7ZOjaCjIuM7PWtTjI/ZCVJn56HlH
	W/rD0uWH6QgpyutljP3D6KMrT16BCN/tG9CpeFZE4O7Zy1pfJ2PV6sflPHXyub5p
	qSi1HMq3whaWaOZ9euOxbH29MfYnL7eP40Y5L2KKU1qGn1f+WoQPBG5RPnUKRXKO
	5x8VwVTpKPh38x1O9rj7LmbJahXegcb/hNYc4d7/7WdKMs5nfXAsXzt3FGjEanji
	pb2FfH5S0LZqtwFwFnu7A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793098046; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:V+wM55VqW//0VmaNtQkV54reEl95h2dej2N212lNiZtRLIE
	xjEWw2Otoivh2QY0/b1FOgYY47b/Qtn2JFd0cJppoKl4BAywrJrGtsFWjkeudGO/
	qrJLku8162m9kLCcnlkdrBDheWb6rJDPfmwMg2ITpo4oPs3ntY7NrbM0VjKc769y
	OZdqTx5Wj9aQsTsTWWU0cv/V4KKVaBVavkl7RM6jvlnR1bTjBF3oOfWjW6Xc2+Yp
	LWHUApkt7aqcctFWAAw32LLa+hXnspjEY8MHnbytBqM657Utf/aOBSFGidnwhFHT
	o+9GoYnmXi6ods8UUmBVhkknXeDipSohgZAL09g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Y1P7KgKW5lWjlKHmrvrJHclJpERCxkBJ6aKL/UUXUu8=:dWF8dHcVBEQ5kHdoXnettmNkN8a9ommDt0fvoXja+Sc=;
X-ME-Sender: <xms:PoHgaiEZGp-9ZicbwfXt2R-qPpFYwk9YSQLha7CiObeaev7Hb6mNhg>
    <xme:PoHgaqRtvJ9oe9Sw10_q3NZd6qblT50xKp8KKQ2IbbJD1CD4H-8ooXRqmSvvQ5ZaL
    eZ5nrQZpwF1a55iW-z2K9nL6b3qBQPfTrqXDhGNGTGhoyfOFsHktQ>
X-ME-Received: <xmr:PoHgahxyDhVInqQu9txIyHLLtNbdfGUAvKR4XmHZ2uXEWk0hANcFVA>
X-ME-Proxy-Cause: dmFkZTFQAhMj+d0VRKgbWkhQwzvS4rn6woO60XWJgpMQw13+GFEJ7sBYn1M9REZbRMminc
    RV4HpjduuDdThTCjnqvWCotDxzb41XrrctGzW39RSaf3bCqRXQVyuBlJpA6NeQKCmf8Rcn
    YhvWf9p3ep+Rx4eE7VUYOyHZTFzVJD3BoV22KZdB1856Bsa6txC7gvZtr4r5EUiPFvuIQP
    v3xzl5KrEOx7einZ5pRDQDHnGKWM2TfCMzw1sxuo2PA8whmwT3udzd4Epz6l1Kg35uo/Gy
    F+NTFyuktJVVE1HRJX1RSJxl0p0jrURqk2jdSpsm3DvLx9EvAQgO5G2SJTmtA/kzNjBzJ0
    bo7WUSYIXW5xYTfw0D2IyV6vPCPRlprQcccdttP0r01wL5g4eZ0fiQCgi+lismMi9ZEkI8
    4ufxn29lMALibBYVKjcuJj6tXyxYMJTdbbRHiPJ/zCff0Ef+2CKdlJmZ+5dB2CPCeiAojJ
    X2PAWnodE2uFsRkGx+Lnk7NJUpmqSvvAKtUIYZ7Ma9GjXUj+ReXer0KI5TbvmDGUzr92KM
    YtwuuORbRFVzXNChay4U2rscS0KVNyldYtThAQZJx4XAB5mt5LZOF0HGZ+/WHaGISNYmbB
    UACJkN9DULrPahn1BoOh8S8k3QoLF9rgbS/KXDWksX8F2HkSH5YI+DRZbG0Q
X-ME-Proxy: <xmx:PoHgahM_8dOvYGO7RceNw4qLqsnoBTHa9JRbngza7rf_CR3JIFbq6Q>
    <xmx:PoHgaoPiCz3PUyCmmr6_DLkXYwmEGzPoHTiCNACNmVWHMmud8vWifQ>
    <xmx:PoHgarQQANg9HxiNMf7e6fHYHiQ2zJkzPJa99R_fYvuEFyY_ba7UZg>
    <xmx:PoHgaiDe95PrN9G21QSwu2mYjsKFfIAyInbR5yt4cBnl8Y3WQNm9zg>
    <xmx:PoHgakV5T8nvPZpg5C_FGlTf2PvCV3JmBuQ5SbEaVwcrLUzSCt2iRfCo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 27 Oct 2026 06:47:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4644d114 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 27 Oct 2026 10:47:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 27 Oct 2026 11:46:52 +0100
Subject: [PATCH 09/12] builtin/rerere: turn "diff" into a proper subcommand
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
Message-Id: <20261027-pks-rerere-subcommands-v1-9-d836c36ce0c5@pks.im>
References: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
In-Reply-To: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

As explained in a preceding commit, a subsequent commit will introduce
proper subcommands as supported by our parse-options subsystem. Refactor
the "diff" subcommand to use parse-options as a preparatory step.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rerere.c | 56 +++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 19 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 31c1b37540e..87ee4eddd0a 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -72,6 +72,40 @@ static int cmd_rerere_clear(int argc,
 	return 0;
 }
 
+static int cmd_rerere_diff(int argc,
+			   const char **argv,
+			   const char *prefix,
+			   struct repository *repo)
+{
+	struct option options[] = {
+		OPT_END(),
+	};
+	struct string_list merge_rr = STRING_LIST_INIT_DUP;
+	struct strbuf buf = STRBUF_INIT;
+	struct rerere_cache cache;
+
+	argc = parse_options(argc, argv, prefix, options, rerere_usage, 0);
+	if (argc)
+		usage(_("too many arguments"));
+
+	if (rerere_cache_setup(&cache, repo, &merge_rr,
+			       RERERE_READONLY) < 0)
+		return 0;
+
+	for (size_t i = 0; i < merge_rr.nr; i++) {
+		const char *path = merge_rr.items[i].string;
+		const struct rerere_id *id = merge_rr.items[i].util;
+		if (diff_two(rerere_path(repo, &buf, id, "preimage"), path, path, path))
+			die(_("unable to generate diff for '%s'"),
+			    rerere_path(repo, &buf, id, NULL));
+	}
+
+	string_list_clear(&merge_rr, 1);
+	rerere_cache_release(&cache);
+	strbuf_release(&buf);
+	return 0;
+}
+
 static int cmd_rerere_forget(int argc,
 			     const char **argv,
 			     const char *prefix,
@@ -190,25 +224,9 @@ int cmd_rerere(int argc,
 		return cmd_rerere_status(argc, argv, prefix, repo);
 	else if (!strcmp(argv[0], "remaining"))
 		return cmd_rerere_remaining(argc, argv, prefix, repo);
-	else if (!strcmp(argv[0], "diff")) {
-		struct strbuf buf = STRBUF_INIT;
-		struct rerere_cache cache;
-
-		if (rerere_cache_setup(&cache, repo, &merge_rr,
-				       RERERE_READONLY) < 0)
-			return 0;
-		for (size_t i = 0; i < merge_rr.nr; i++) {
-			const char *path = merge_rr.items[i].string;
-			const struct rerere_id *id = merge_rr.items[i].util;
-			if (diff_two(rerere_path(repo, &buf, id, "preimage"),
-				     path, path, path))
-				die(_("unable to generate diff for '%s'"),
-				    rerere_path(repo, &buf, id, NULL));
-		}
-
-		rerere_cache_release(&cache);
-		strbuf_release(&buf);
-	} else
+	else if (!strcmp(argv[0], "diff"))
+		return cmd_rerere_diff(argc, argv, prefix, repo);
+	else
 		usage_with_options(rerere_usage, options);
 
 	string_list_clear(&merge_rr, 1);

-- 
2.56.0.341.g393f52fd96.dirty

