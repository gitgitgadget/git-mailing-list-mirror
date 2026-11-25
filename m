Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795635612;
	b=Bmue2JqtrgY/SKLWHXB3y/PDO5lRG8o9pbFJTQmwrl4tuycVgxdKhSgdP6IDsgIfEb5+
	 dSJEdHmQEcLfpqpmgIHUcLxN05KUel/WB69urZmG2do1CQ8U54MqfC9w/+LQnFGn84PWM
	 7MDvz6lGwUQ9jX5ntYldGCnLqgFZeGaPijVReEQ/736yI+Zbrp8IY+/3TRJy7tBRqMW3B
	 sfEM2NGkV+BoZ8pyo/M7evDrDTXIetwG44ZmVtRYUkI4i1q4GS4iPS8QI+EZtMFa3dvjd
	 CFQhUsqdVxmzFwo5x20O8hyMDVUK+JdgQgoWr7PYQ4edHKavsHhK2aq23qqVFPOxing==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795635612;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Jle5psRBAYuHNZSa72Gof5p38fYQHt+IXvvdtTC6mmc=;
	b=GkxDvtyrJcqGOqPIuS+vqvGmUkT7STugrIZ2VVEOvo5fRSftLOMCNEEztrqFj8Ae6Hai
	 6rBxbvTeS/MmfqC0RKC1niobuy980Z9rvx/kDdmzNR74JZNLahvC30UZGem9fHgBorFSO
	 LRgXh499F0vF4fWx9JTSnB7i8XA9DbTAD/dnbpZjYPr9zha1iAxpxwy+y1LcedlaZA9Os
	 G18XvhmmjBvEmw6lxdMX6QNZNTqp3ywddrCDz1yFbarkgPLASZ34sxo2vj4qv+bR/Y5Fc
	 XXsGlrgLL/rCHpvUYK6Xrjy2WTe9urSYz7tvelinVg8xZySlmoJvOspCjytu8LzqH3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=S2Dne8zU;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Rf9YvX5N;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77245606A31E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 19:40:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77245606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=S2Dne8zU;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Rf9YvX5N
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 524ACEC0C8B
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 14:40:11 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 25 Nov 2026 14:40:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795635611;
	 x=1795722011; bh=Jle5psRBAYuHNZSa72Gof5p38fYQHt+IXvvdtTC6mmc=; b=
	S2Dne8zUouen+upFVRtrbnLkvUXPJuU/d5D4N/lfaVqA/I+IuKELTaCTVrZcRqNn
	P2BfmDnwKt6JtASciyxIJbv1ympL5jv+FY0wrO1LZzMK3IktBNR7v8x38zzjaWdI
	/sBFf8qzpombR20jWOTZIrxaV8hIlcIStVVnqrpZNwV/c09zqgIszKlIA6GrVMfa
	In4kr4vDF+8y60Qgx/XghREfzKSu/VJNsHnaM5pjnA6OOAqrhewAQFBjU2I9rZ9x
	4V0N0fDOhxhHfgIcUngKGVRcC3D75fNrmK2A8n2bBGsN/7smnC12OHvMhl92cn9r
	gv7UuicwuUY2Ngm3q8f2RA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795635611; x=
	1795722011; bh=Jle5psRBAYuHNZSa72Gof5p38fYQHt+IXvvdtTC6mmc=; b=R
	f9YvX5No0P5Asx5vJ7CQcx/ihJiP7bMVMXX1AuD3KE2glYeKRCU1c617Z+z0f0ET
	HWrT+mc/ioBAYYxnZ4lVKBWca+5j+qWU1VVFRXnmeBJMZkPz3Zw7xMv8cyq4geBD
	wL/jxJsTImYcGX4GictodkrPpGmZOdzpgIF7fOQ9kFESGkWmlTfNHW4X5B0U26Oq
	OvTQl73Y0lLDMrvtUI7Nlh0mCPNy5PDZUH/pKMxSA6IAtFd0PXMuPAQsGfaInie7
	4Lf0+TJkBLLdQTY4lDPQzh7RTBLL6UPeCWLVnBxc5o3siHitygLMwaHyTuCa5M+a
	1P25RckIzfJMvFnZ2NsXg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795635611; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:IoDxPhpvDz7jgFz3nJeL1Q9gHQSdR4z7xLAb30FteWtXGPm
	GJ6awjkUqMtEaxL5l4NWKHOA9h2Ro5k8b9IzWopeVTNsfxuyhGMyWA7VvXphk+3p
	RBkfxoFvGWwgDAxivWi3+CMvwO20LgnqLIKd+TZIbpjg9qWCy+ckxxT0tC0feOKs
	P2OsHAPhpHERpr7fqh/vzbis8QK8JuQsxZKsEBauCVEzwLQWAME5kq6c6zJ98I9e
	ON/gmIFro/ykSRtFxDs88TQ0SgEpAtiu3ESDrUdikEyGUz4SoKjt1us0Ew1blJuW
	AnK2NW7UKP/ORuxicR4DQ4w38UyGKG76YSkJ4lQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:wLrKiiDw2UPtEQb71ky/FtiDsG02kgwG24txhAUVFkM=:HjKtHxt7cc0zcZo5nSrR0QgqJAOuptkZfGSQMok+tn8=;
X-ME-Sender: <xms:mzkHa3de89NBLvmG6zcteJJ6G7MIt_VUOlDtgaE5Yxyu7kSTRCRdvw>
    <xme:mzkHa0EJX0iksZLP7FX1wga2KjKhAarqyXUKwRpMm6mQt_nmonXEHieCBDdqHnc31
    NPJJAuKSsehxWnXXL-Pq5WaimIzsCxEU8qYjQK8MvRy_RiDs6s8Gw>
X-ME-Received: <xmr:mzkHa43pxbvbnRPRdV-aoLbxLVZz442ol1ietmR7yQy_xc4tpcPxWxhREl3gLbmgNFVGm3Ai4KqHEidNEeH6cn6RuHJ6N6cOVdj4Deo>
X-ME-Proxy-Cause: dmFkZTFqxBEkuw71mFVmvByYVMImg7uLlhFa3+nF3p3dpRZtDKfQS5LuV9iIeHrXFlB83D
    mCBvss1arfaNjEOck25npg04Sx9PXCuwFwE97SXz1sAaujbS/+48bSiIG4GKPR9SPGZDIY
    ujc252wlrrrBJ3fYw2u/ouMi14QzSAppnA3MJXEoW7fFaHkv5FrSZqf8Vq3VOg7CWiHmQL
    mHbbu8fAzVJjn2oe+Vrpy5II5+s3k7AWbVKIPrTkqaGUVjvk+KFoxoGSNaH2pEqdKkc5IG
    dpthU1nb5bZKmyNJPQwe5XSgIIpaGZWQH34/XeNQCflFY9Ixw5SFfevUwp3FxtrRrFAVeJ
    gckdlpuL5sFBe3bHpuKxu0tEm23GnBWSy3+iCH2MqXhxaZs4c3zwXBILho/Sk7hOeVTwLn
    qPRR3gFozCbBs8a1Y3AabacT4OV7H/NmsnYd2rnpK1EK2CYa+wkaa4SPDZbUAvGNHXBYI/
    MmdOYObgwff470lEpgn+rxGtlMJRb+fm8zVxT1g/uJAYeuPgDOlR932FBdib+Tr8TmFDk5
    XY4Ln9lM2sc2aEvp4aMdLDMItS8qFf4rU2MOff6ueAnThtR7/09kHdB1q0PHoOXa7I2nGz
    vOsSjp2Fralsb0rdg59jmNpaZpOnX9N756xKCspRVNgMZRKBe/v2xRUdjFwg
X-ME-Proxy: <xmx:mzkHa0lJttwVwUruXsC5vgJ9JM44c0IJTaJcn93xV5EgiaOD_XD6YQ>
    <xmx:mzkHaw-H1tHXPpYpe4TuxPPeq4zpNjwroe76tJ4tpSQS53Imv0JGtA>
    <xmx:mzkHaxpVf53b9zBtv7-4D0TcQ-FXWpfAaGR4CQsngefEZUSLjo_u4w>
    <xmx:mzkHaxng3csmWw1S4PYte7KzSIjXSQxlivhyiJOlA0p5R-4k7Hi2JQ>
    <xmx:mzkHazBE5-1DBv9jLbJ_x_ctsVvayJRDuowdwxAUFJTJpw4AqRYdx47a>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 14:40:10 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Dirk Gouders <dirk@gouders.net>
Cc: git@vger.kernel.org,
  Junio C Hamano <gitster@pobox.com>,
  Andy Koppe <andy.koppe@gmail.com>
Subject: Re: [PATCH v6 0/4] utf8: bounds-related fixes and a doc fix
In-Reply-To: <20261125-master-v6-0-cb60af83d189@gouders.net> (Dirk Gouders's
	message of "Wed, 25 Nov 2026 19:19:40 +0100")
References: <20261122-master-v5-0-313bd1bb3c45@gouders.net>
	<20261125-master-v6-0-cb60af83d189@gouders.net>
Date: Wed, 25 Nov 2026 11:40:09 -0800
Message-ID: <xmqqjym01yzq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Dirk Gouders <dirk@gouders.net> writes:

>        • Don't use the _counted variant in strbuf_add_wrapped_text() where
>          a NUL terminator is the string's boundary.
>          Reword the commit message, accordingly.

;-)

>     -@@ utf8.c: void strbuf_add_wrapped_text(struct strbuf *buf,
>     - {
>     - 	int indent, w, assume_utf8 = 1;
>     - 	const char *bol, *space, *start = text;
>     -+	const char *end = text + strlen(text);
>     - 	size_t orig_len = buf->len;
>     - 
>     - 	if (width <= 0) {
>     -@@ utf8.c: void strbuf_add_wrapped_text(struct strbuf *buf,
>     - 		char c;
>     - 		size_t skip;
>     - 
>     --		while ((skip = display_mode_esc_sequence_len(text)))
>     -+		while ((skip = display_mode_esc_sequence_len_counted(text,
>     -+								end - text)))
>     - 			text += skip;

This update is really nice.  We do not need to measure strlen(text) and
instead let the display_mode_esc_sequence_len() take care of it cheaply
by passing SIZE_MAX.

All looks good.  Will replace.  Thanks.
