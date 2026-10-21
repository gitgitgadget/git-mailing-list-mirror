Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792605869;
	b=vMZep6+SJ6FzoWFCysSThekWBsMEPlcWbBjPt7f5zFFQpyY341aW0RoPbXxrLXAJYOZg
	 uqqfuKoLRT/0urAszAcmvLp9Pxb+qNdzXg9cj6mV0f6P9sGtH6BviRuGErdkcrxJKVisG
	 4l4D60Xh/J6Y/W/w5IAHvoFYmrK8MQl60a69Te0oTd3CJ87ZvyRAqdkstofY1RGy1egTg
	 XVWVDGgT6mY+tud9DVMiVKZThEn8OFvId97JjmOsCKayWANPiCBbtY4aDNugmrKwcF6ke
	 w5rklmBoBOcQ9PwMB9oRzLnVWiSNH67190BEI5bZ+55n4glV+k7JdNixnZ/BE70BnIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792605869;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=u8cMaZkm4BAR/xYBUK0dVlDfcYbQiORlPUqUnw1NFHU=;
	b=BPmO8CNMlbrTEzp8y9hzMUuBO3XFjnc9v8GMurPfNX8FyZ9XkWyomMbrk5aakmABEmOM
	 j9hg1NW0jsAGs4I2cH/wfZnYe+ZKpJ+KCvFsErkjloJBLzHPbaYJStEVHpZ5UPMPGKlM1
	 mVmDV+UiDT2ZK21iZ5WuK1+OOT9TW9uPE7Jk22gurj/qiyUZm71z+9XaZ1tevO0+u9P6r
	 fTMGwo89YrCHV8vIMe6wzqCN6IhLGM3Paq5vm23yoqrWU7PwkIzN3FbrzA28NagyF2RVN
	 finoWiIYa6XJV9vUyHJzT7QL5IAaZjbV0IcnCiRXeDpmdjMEgULKHKzJ5U+RLH21jMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b="YRFz/uyh";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=B13Tcc34;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3882A606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 18:04:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3882A606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=YRFz/uyh;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=B13Tcc34
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 817B87A008E
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 14:04:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Wed, 21 Oct 2026 14:04:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792605868; x=1792692268; bh=u8cMaZkm4B
	AR/xYBUK0dVlDfcYbQiORlPUqUnw1NFHU=; b=YRFz/uyhvhTU2vp2xF9XGAuMqC
	WoiCITx4gZh2JkdQ3TnZ2tpmkFVkUcPkVwCN49N3uzHhMCsyZ5nbdVIQBoDkTZif
	tzn/Zmna+MI4WiwA7z9IPC1Be5Gq2uiYMpwADCstJN6GaGCdxyTO4ecrq/7RTk9n
	yAlAFBNxy7UJ4vT2F5eREQBb8bsOLu5gv1mlJCL2TNiAuiBf2Eks5YTOxFIYdGwg
	QigYbBZFfVHpHJPUAbfi3Q0gIVc2pEzbTpOBv4jBucFsopl+VA+D2QeEPZdoXfup
	M4b41Q3P9GNtPZl5xoshNqBV7aWJs00uKQu75VsjGDstRBhoFrllz3AST2hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792605868; x=1792692268; bh=u8cMaZkm4BAR/xYBUK0dVlDfcYbQiORlPUq
	Unw1NFHU=; b=B13Tcc344QcPb/WZ3DVUOD/24nj/PFpLlKGtpqfcV2VH72+V0U9
	6Cyp1PqiL5dgl1WfrDc1D7OEO6N/GyzWsWHNjpgPz6L0lL5//SszDp5LtJ7UV7uR
	yh4ghDPAF+2oNko1hV8kYQ9zykyUsZn6K0lu5lJs4n0F9rdR9VSioZNI/5o2avpm
	w6oNTWx94mkymKqwjIN9BOfB4vl2v9Do9FUew1yVFdlM6D9M7mifpmlga2dcVpXm
	Lx63ocPsZ+JuO+xddrLtFQj77wJBAbmEHsG6r54g4Q4Yje/vryOPeMyI1kigMFmF
	xP9i1Ck8wsqN1dr+a7JacQtUioiwnYtwoNw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792605868; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:lIk7EKJnzirh0MlCYFsyzuCyfrFhQDnMySnyAclYXWBfXgy
	eMLDfB4kcjOZj/WuV/zQ2/fbH7OrD5kyXjA5UeMOLk1f5LL1ft63mpYfU5MDlZ0B
	k/iPqHEuS3hD7fg/xcQGRp9FdXqnFvG7JY2vI/a6AtcIZQ5HmjPUujmtBYYljeRr
	Gu/bMAII0RAysHSPhc1zOYILtVWVZDHnpOUUFjcfDt8BHhx0cmlAHRl3KkvUd5CK
	PZrg1a3KE+YLNXnDgq2BOGP44xtVBtc6hkvcjfa4/rgpUggXMtGXnkz0nmEE53Vb
	8zMfrhuJvbwxkGwGLKO2TB5J8zjswjwLyDVkyrg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:lvAFxI+2DU3Go1FxA4vTkOfy52D7m6zRBdjaTW9hRfU=:2OuaCJQyZscS6lbNAcBLe7mRDPh8YEwIvVFPYEqpXLM=;
X-ME-Sender: <xms:rP7YamHPDvf74x7gjnmZaUupRsTp7AeJFh4y4Tcr8gkkCIBM_Nexnw>
    <xme:rP7YauNYOOayg7yOL-I6OurMnH81TF0b1TR_zx7pNBm7o2E5hADdODAExfwPW1brx
    YcSSKIfXC0d8Is-R1Xwj5kaP1NuQU8DxiaQdW4IlTErn2N3pWDU3X0e>
X-ME-Received: <xmr:rP7YaoddMBQRnGsdeM5ySNgxEDtV2SOnuEt6KA3H87jb3ES1jkUzchrt-I4Ycz6e6fHS-akycinAkH9AbGleiKjrcklHuz664ra4>
X-ME-Proxy-Cause: dmFkZTGglF15bDFe4wd6pc5unSaTgSWja2a2xQo5i3CFHOFz/bhKOG7qUiB4yjSmKi5U5Q
    ZuEoKQobe58Qwr2OFKWYOdbC38a4nlEMJaGk0tQMxc04fRyBO0i4C/b2eFd5uPLXwFx0Uz
    zseSHLme8kOUJEN4MCfhN/PiCs7mO8AfkksbdTC1uzRjv+nJDLPMTcWpE0XR896EqBLbh9
    hB1fhQ8r0BZTIuDoesXfxFU8xXBQ4L1KpmKszFKa+Tq1TG3UcVzLgYMTelbZLucc6wGSvq
    nYs1qcij1KV2mqNEv2aAckc7Xt6ufFsSdZpc44tgq8P1XEMzjP0xWf6x9TNnrFBY8bl9Lm
    wXs8hCOkl5DSWuX7VcEjIEmyaQ/vYvxI3ILuaYAK8C1Nh6QSUB+KrKsHOKKOrNCg2rORQD
    E0VyrL7lAbHQqBtGc4yERXkNMfW+0tez4FnNLnfb4Q3uTCKut+dwuCvBxmLe24oGthzb2w
    aLmBSTMYq+6MIeJg8Rr6KhPtzN+JyoIYFOuqa8IndAecpRLks/g7Z/kHVxv5bk0wIdNCMB
    pxXAVVK63f3NWFwoZn1fLfcW7TBiP8Gg/tZnpoo+nrtEJPHpPgKe284F0gYC6v88VrnkwP
    xYjFWl2+a6y1P27kLDoXD5FOd7BjhFryf7+jJjqaCv3OBeMx8/uBhiV47Slw
X-ME-Proxy: <xmx:rP7YartGtNw8OX-mYoAKCxrNyK--JuoXgUN7qSwDN1N67G9DkoBaGA>
    <xmx:rP7Yapncx4NiGw_2zY8BAbhVkJyNtlbXA_nQt2QkQbgCor_45Jjw8Q>
    <xmx:rP7Yaty8Uru1cuYY916XaeFcPctlOv64d9NQCgN29YQjZHm2CwQXxA>
    <xmx:rP7YarNZ8VDvgN1U9V5Dr_4BXlw91OTdYE-vt25wTCuzGsM24I7qLQ>
    <xmx:rP7Yaq9Azddd-EcmtXzt2_3eVkEqCs4-ax8eXMSWF7EsziLMESTUYLbF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 14:04:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tanga Joris <tangajoris@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  siddharthasthana31@gmail.com
Subject: Re: [Outreachy PATCH] checkout: use Q_() for the "... and %d more"
 message
In-Reply-To: <20261021022156.119947-1-tangajoris@gmail.com> (Tanga Joris's
	message of "Wed, 21 Oct 2026 05:21:56 +0300")
References: <20261021022156.119947-1-tangajoris@gmail.com>
Date: Wed, 21 Oct 2026 11:04:26 -0700
Message-ID: <xmqqv76vnd5h.fsf@gitster.g>
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

Tanga Joris <tangajoris@gmail.com> writes:

> When leaving orphaned commits behind, "git checkout" ends the list
> with " ... and %d more." using a plain _(), so translators are unable
> to give the correct plural form of the count. Use Q_() so gettext can
> pick it. English string output stays the same.

Is the last sentence worth saying?  I am having a hard time
imagining who it helps.

Translators of a language that phrases "2 more" and "3 more" the
same way now have to translate this placeholder twice.  At that
cost, however, we help translators of languages that need to phrase
"2 more", "3 more", and "5 more" differently.

That is something we may want to say instead.

> Signed-off-by: Tanga Joris <tangajoris@gmail.com>
> ---
> The count here is always 2 or more, because when only one commit is
> left over, the suggest_reattach() function lists it instead of printing
> this message. I still used Q_() because some languages, like Polish,
> use different words for 2-4 and for 5 or more.
>
>  builtin/checkout.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 2d575a4f57..49239f029f 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1085,7 +1085,9 @@ static void suggest_reattach(struct commit *commit, struct rev_info *revs)
>  		if (more == 1)
>  			describe_one_orphan(&sb, last);
>  		else
> -			strbuf_addf(&sb, _(" ... and %d more.\n"), more);
> +			strbuf_addf(&sb, Q_(" ... and %d more.\n",
> +					    " ... and %d more.\n",
> +					    more), more);
>  	}
>  
>  	fprintf(stderr,
