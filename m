Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793834005;
	b=k5tpU1Vf+UCkV33w6/Y9DveGAV/tFs36JLCu1mF63Vw0kZeBwvlv52OagIoTNx+1/Ic0
	 YUqJDNeAzF/TZ/AXW/ivdzUI6QcRZgL78Y8Dw2+usikgMzBpqFgIKTj/cBdqB7KOSMvfw
	 OqT9ff/CMeTYg2YtsM0JiX/r0jVGjFeaH6cNA55NbLeE5AwL0B6gxd7+eZkm5muhJnKR2
	 DiXvBKohoSBThpfEimOjGnaH1FKL7hIn07w90+oswmT5Rbn4unk+PKXypGxwLw0KXCPkV
	 Fjw8lCMEopMo6MfhyLx755MkRfFYBVWTfeQ07EHzXQsZ+uTG05dWT5KEyQ3IXc2VKCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793834005;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=pF+SV/OCiwh156LDpThv35zYbJRDWUY6TfZJRkyVVXo=;
	b=F76LmIuG5xk738TcU0Iq5WyiosvNO++peqpUGPwVgDg5NotM9iZQnF3wkyC9zFAtMZ4I
	 eQcQb18DYP1YNF9W5eS0FIZhiR4WO4Z9oCM/vuz5yjOKqaxRGjLRZqCkEZ49p5H8qW8Hi
	 YWlVP8f9st2MjHfMd06+gGuA9LZkgx9a7XhVSby+pMUsqOOUXRBEwQQaBxS9SQUmJCV1q
	 wMPhSW/isRRe7Yi7ypa6dt0oZZ3rts9uyljd87uLAx7vnjXuxMSwszh2WdiL1FEjj+nL0
	 b1v9MZb6HkFsFuxV4dNm72BlBjLYlXROU6jpeGTNJwQBRvayoICospkfkGRhMXobdgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=TdmsDtuY;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=TdFoLDuI;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3038606A32E
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 23:13:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3038606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=TdmsDtuY;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=TdFoLDuI
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 21078140018E
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 18:13:24 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 04 Nov 2026 18:13:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793834004; x=1793920404; bh=pF+SV/OCiw
	h156LDpThv35zYbJRDWUY6TfZJRkyVVXo=; b=TdmsDtuYZCIFEHB43MxF7yFXfv
	q75Yx0sEjsl76Ja7rJdHuXj0lXR8F6RDDEBE6OReq6U2bwZl2lKIbv71JiEaG6DU
	1hLz1OQwbFW5CgfUML1NvLBrOz4AcVA+FRmzA3hKlKfymWOMQPCsHuSC5pWSBEvb
	oIkoFDsHedOaMrDxzLKjamkijlrtIsANYLXJqiq3KTDvIS3j2anAjmrtR1wDbFgA
	d6p3Wrf/xLA1Zqg5tyFyP4WuiSe2FHpuamUznN5DvhCOet57p8ISFUzsunHvaLXl
	xC2RZQOsxQ/38mF3DIf8cKOzdLDAoDVOjfC9rz/vcEM+7sStsUYfaH7XE3sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793834004; x=1793920404; bh=pF+SV/OCiwh156LDpThv35zYbJRDWUY6TfZ
	JRkyVVXo=; b=TdFoLDuInQx9JlzZZ7cqliP+UiIdE+L8qg5hzl8efAbZPIjcmXD
	3SpfcuEZxSp2+Qs1BZ0sHcLm5NqFeRTeDNe7jphkkkEvMoTZfgOVidY1gVk+uiQe
	CT1P/xx+u57/MN7t5B1m4Pwdlv7mkTDw1AlP3LA+pRgjkXSz03BgAzYj338v1qdE
	SVMW2gv8KHiwKs+u2L5iFjSdDyHYmWRw3CswCvu4ODnz2vPqkqP+bX9F2V0BCFWY
	K6Tq9e0yCHWZDc8CLFH4n3iFwIyxHqhPcu0Jo/oXSyoKG0WOAd32nDC1E/Q4pZv7
	owkL4j2Zv4CJv/bAlrkIx7SCbCcBkL4uqag==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793834004; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:VNJjMi5TJ6HnL6ukTxSusHZhH4tkDP2Hg5fhRGhou2VGlOV
	/qDcWL56ekhFxD1hCs5J8anaHQjPzV+K9dw2gz2YkETVUqxz3hPDrs41QxwcU/Ex
	mX064rhALnzPjcX1YyYF2zU9cByWUShpDM76KZPNB1uJvhfF2z7nHdaeToQkpwK7
	zhGDbLzusvEGrUMVw4O03leuhQR+DrDlKkFXk4R0wETh65FScToa3ngpYPuAKPtg
	DcWyvpVCeYmfg993bLpljLCLubPC7jMMRla69l2jOGTXlGXa99tmHH/FmUGmBVcB
	wL4nsC+VkGMkWZrTu2ZcqGEH5rbVnBAxtLXo/DQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:FllfNPcJoXXopbe1vtZ7jlf1G2bB61W6DuNz3FoioYc=:naRqha+yXexr2ghatKBPosGw0tr6Ef95vQDm+Q0D3sI=;
X-ME-Sender: <xms:E7zragy1cK8Y7xTQ8fnV7bLE2WsxpzrDYO42E_PhDI2MladxFilQFg>
    <xme:E7zrajXZHtO10jM8VEa4NHAx0eky_cnTqp9_IrFFZ42pW0o3O_gyEkdxNtE3q_hK0
    nEBsoWFuZYzK7rArXQYFETrDuoqMeBH5W66StPXBqL1nNwwM33WlQ>
X-ME-Received: <xmr:E7zraojXsGGivoNxHWu2Xo8kueyq89krerRoKEZ-rHSZKWeoNYSy5mo7UOktHnTyhPcx3N2rlPXrpJcsO1RjQ6ouE_Oayd7sKrZ9>
X-ME-Proxy-Cause: dmFkZTFpe9H74Rejf9MaEqNQUvo6cXZZedgQfpdhhgjeu41XMO9m9atiMqVICaFFEQVzUA
    t4nmk7WuvskZhD8UYO3UChv8QNqati5bY6N7FzhakC6most65Xb0fsVjMVPdmD4OpAoxSS
    u2pJZZN5nlmSOcOO02zS6hl6ITH6K77HQBJi5AvLB5L4X4mfwG7Ae1S7zuy9XX2IPCQILA
    QpRE4+ZfKbt+BQ+Vw/z5xCgPGmLwdKGeh3Qoa5RdbZ/ZCGmv1UftxKosfFzUbJgrKsnloK
    uUCM++RvQNi7+Z0jEw0pLwr0e6O54//f2/3XGByceOLXB3ZGDfQ39hUl3odE50611KTwAm
    tTcnkkav4wCe7WAFBRcEzkQwwmzbvve+lO+ZjXGrnpAkJYH/LDx4hxc3wpSGYTJVwekUZZ
    z+AP/3QNRBMi8CYoVPIK6qp3AVMlTx7bmsDdAEVQJCSHECgsy47O5S/UK47pm1RPkbi3KL
    RroTEJrNdcsp9cwrp8X+svyF9dzeiCIe3SZ5yNAKqeyagyxIWAkRrqK4dPLsEViWCLBNDn
    fseTsAMcLNIIe4YTDsTk4NqJbCLECjAxIFzrKzKWZ9G6jz+h8Pmzv57t3BsIG1kO0WFps7
    NDzR4HxzVwS4BcimsPvyft1nrU0rQv0Lyl0lYQsWu7EAhk9tTn3jYqadk2tQ
X-ME-Proxy: <xmx:E7zrarASOZBgDzTUkG2kKrRieGB_pefAECslQk-LoO3Bs0Uv7hYX5A>
    <xmx:E7zramujlbHrFXuJZHH9k1njckCVPsjKOgKHdZk_YoS3Y-fX87M_wA>
    <xmx:E7zrane05F4uXnVZxqnjm1lf3jUGjbgAzqLGzZOWCobyyFB8qSjdlA>
    <xmx:E7zraj8R-_NQDLvGu13Fpmrw25zGZP3oA4U_fYcCUgJpTsv2yBAyCA>
    <xmx:FLzrasNPqcJ9jHbalN7ktX4WYvfvdh8pKHYZPhxTMVoBQj7WWwhNeu3F>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 18:13:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Cynthia Uche <herroyalpriestess@gmail.com>
Cc: git@vger.kernel.org,  l.s.r@web.de,  christian.couder@gmail.com,
  siddharthasthana31@gmail.com,  kaartic.sivaraam@gmail.com,
  usmanakinyemi202@gmail.com
Subject: Re: [Outreachy PATCH] api-parse-options.adoc: restore a dropped word
In-Reply-To: <20261104224559.4197-1-herroyalpriestess@gmail.com> (Cynthia
	Uche's message of "Wed, 4 Nov 2026 23:45:59 +0100")
References: <20261104224559.4197-1-herroyalpriestess@gmail.com>
Date: Wed, 04 Nov 2026 15:13:22 -0800
Message-ID: <xmqq1p90yyul.fsf@gitster.g>
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
Content-Type: text/plain

Cynthia Uche <herroyalpriestess@gmail.com> writes:

> The description of PARSE_OPT_KEEP_UNKNOWN_OPT ends with "..., the
> parser early.", which is not a sentence. The word "stopping" was lost
> in 0d260f9a09 (parseopt: prevent KEEP_UNKNOWN and STOP_AT_NON_OPTION
> from being used together, 2009-03-09), which rewrote the end of that
> sentence.

Makes sense.  Thanks for finding and fixing.

>
> Restore it, and rewrap the following line.
>
> Signed-off-by: Cynthia Uche <herroyalpriestess@gmail.com>
> ---
>  Documentation/technical/api-parse-options.adoc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/technical/api-parse-options.adoc b/Documentation/technical/api-parse-options.adoc
> index 6dfea34220..14f0d2b572 100644
> --- a/Documentation/technical/api-parse-options.adoc
> +++ b/Documentation/technical/api-parse-options.adoc
> @@ -127,8 +127,8 @@ Flags are the bitwise-or of:
>  	`PARSE_OPT_STOP_AT_NON_OPTION` is set, the second argument in
>  	`--unknown value` will be mistakenly interpreted as a
>  	non-option, not as a value belonging to the unknown option,
> -	the parser early.  That's why parse_options() errors out if
> -	both options are set.
> +	stopping the parser early.  That's why parse_options() errors
> +	out if both options are set.
>  	Note that non-option arguments are always kept, even without
>  	this flag.
