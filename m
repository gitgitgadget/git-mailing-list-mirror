Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795129578;
	b=VCNT6RGiupR0eyjIQzMKHDeJU40l2i8778SRYlQb40lyuWniahVZWvPf/p76Vrnn00ym
	 dzbKLpPdSgPYhSMwWIV9Dg+O9UubxwwBdEYHafktoV5n9EIaFQAYvX6oa3wgGI8Tl9LES
	 OcPhEWTMi42GwT8SA7g4DBsTfz55AHLyQf/sxPfe1MyxMn1AFPkxX0YAsbKf+63VsoE4J
	 VFV8gkVMfbBaj3wWax44QhC/ihDzkVIaLRAvCfo+xTyDacQ5Be0kHrnE6FaD9YpTZuAmX
	 DIPU8TQLrH92NeP3zEgDfKEiWnmv12G2No62x9P7OLJp+YTCvJVWKISKEmsIvDTX+cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795129578;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=CxHexcTPWgSeqO2rsJV/MzwNGNy5sOJxWexwkN5Khmk=;
	b=MAGbprdHXkRLNu/63x3Gnjbdb8rUlIb2ipiy7IduNdJUu4HNevFA7Qxs0RLx5r5SJPNh
	 3p7SAYnuQcxukiZ7pCAhgAQeQjqbArkfvxDnHNrIORmi8aos1CKfbuQGU1pSlFKlWmEyK
	 qSq+lW7ThxM6lN/1wbLij5ZoP4ftAgLbTFJq+AXYapx+R51TfcSG1LFcGpqVJsLuKJenX
	 LcPILcvj0GRVke6SNLY5QP1srHXlpi5azPwCL/hANHTqBIYQCdEneDSLz1onC3cz5f5n2
	 /PlTu/6DG5e4/i7LmP/Nef+VtDbwkQ89czZp4+yHFwlXip2214Zp70D0YuilZNK6TBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=BJBstdTk;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=GiK9Y0HV;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29E2606A336
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 23:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D29E2606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=BJBstdTk;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=GiK9Y0HV
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 2DA191D0029F
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 18:06:17 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Thu, 19 Nov 2026 18:06:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795129576; x=1795215976; bh=CxHexcTPWg
	SeqO2rsJV/MzwNGNy5sOJxWexwkN5Khmk=; b=BJBstdTkCbFZlmtXTtd8aBLT3b
	baAKDw1Fj+xL3kumVzUZqGZUmoQ9Iap7GWQIdS2+qU70lABGyj9/ko5M7oTMAg4H
	0XxkYXvqS69D9/ls0iAYqOZ0/YA0YUsNLf9OUSxBRaNPsZIO6/6PmNM2sevCwOaE
	J6axSn+Kyqb4kq1KOycsja+IeqVz12Bl5sGM54ZVJHd2DnPn4N3ixa7lhXtmI9V0
	EXTqloYFH76BEQIo9Q+6SdQAK1eAYb2fFADftpW1wgspudi4atEpPIDgcg86PXZk
	qR7ZwSHoXLIbfs1hQbhaMuLWxtUVED8OAQyhhm3p5QocTfXoiJRPVvtqG2Qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795129576; x=1795215976; bh=CxHexcTPWgSeqO2rsJV/MzwNGNy5sOJxWex
	wkN5Khmk=; b=GiK9Y0HV4vAgsA9avoL0GvKyNIr07p+RavCKhi7iK2UkojU7hFr
	Jd2Rf4VMCzkrhpfQrYH69vcDllOi/MJvrcMMnCfMVgKCOzK1pdhCxbDc1DP8x2Nk
	JPnxkWxooFWXima3wUVWus6fNjKTdelS25JgZ22Pe18Yyu9m7yt1AdcOw1I202GI
	Vh+FzMtbpsjvSsaOtdPn7B6SBS5iyLGGGoHoEUA+qLxYHvYQL38qgz5CBnjVUcs7
	JnX0lkUGm1v17iApc6S0AcrAihYVjAI5waDjfvHLoOEA92lVoZ+0FeM5G9leNOW6
	q88ndZ11ZSnMy2ylwxhGCi78VDu4wFeKbdw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795129576; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:mMup5B0cwjjVJCAkaWut/cEwH8zGInVmrjT4+VjHNjcFWj1
	4eBhqMlWS9G0YvL+xMX5IDMyYvAAImgvHBgZFja9m4oHKUeY1eOh9XGIdMW93SNY
	oC8FLZmrac5A9uZ/xa0t9KPhD+QJOsIWbf+Qxbo9+hRKveiSsGD2AfHRw1Mk7Gin
	gHslmTANf4i1Ayg+pFVTsDtqWLo0X5RvrckQCeGtPKfyiKNej3ytJG2jKFT7sR9i
	PELAP7OHjjSVHUG3cc+WVfEpPPX82Jlg68V9hNjgvEbJkCtxc0+40brWMrkrZ3Z2
	l54CdsWKaQ829Cj42nEloGADnP410NoGIosl4jg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:VNOWBPoh64Pw0jm6XLgqGvp+0MgaLRCd2sia14urLos=:2CtvfXH5+M90/wPwdLT/GTL+aTGjAgwADcmnbag8oM4=;
X-ME-Sender: <xms:6ID_akTFqKOezbOGpTb1E22-y4-E29UM6D9-QkbgEJDvjPn_bqHCkA>
    <xme:6ID_aor88z1TSAGYdF1cdC7XAHdxKP499WfV8RGaj1Ew4s_rmwteM9kZ0lAntgihv
    8GcHO9G458HDEno6iv0KrienGV4aWzFeqIfrfXQKqcCA50epmRL5_g>
X-ME-Received: <xmr:6ID_aqIVEbRF1JO23dDwlFQgT89SPYPlOMHZSWIMZ1gtP30iBgDi-RMqWTFdOtULDusF9dbeoDdBznZoWv7KR6iwGqxawc0V8MMv>
X-ME-Proxy-Cause: dmFkZTF06LgRVN4oF5I+97ev3nIRlIOpTmc30zJlKT+P6w46Op58Nxx/3Ou2Oa55EUVYSl
    0dR6bc6099smCzZYEC59tiI5x4EnTmniYqSvFXIovHnSwWjFA/8efuzajaDQsqJPBxiLwy
    lZUTntkg6septt00OdioBQRumb4AIQ4mI+56E++oDWqbOQSLJftWoFkRj3zzW/k/uvN0ps
    Ggxr9BKuVoSd/SXg3y5l5ucwq7KPphdBZEzrtEH6XkTlZS7RNesXL02IrS8/rSf7FsUAnD
    gxffKb4FlLpWpaJNRyD2EICkm+Z11fCitmPHLxM6YGwuh9NX5Y1+jRb0+LXFWFtqxABEhD
    Yqj24Ysw0VVGCIk9VV+CYeYLgxSH43mpytQrhs2AO6CuCWiZVQIw2zOyhhw48RCk95wsxV
    q8ShaMvCjW9z6Z+6xDjtyT9J7E8W01xMNTzpbhC4JZXaaqRs/htD8Lmb+xjrt93UOH8D6W
    G6EjG1n7R/Z6YpfcGSCzuwG/r4R7LTQwrgTSvv2omUUYEeU16xmgsv5AaWv/uIPT5XNKMP
    XhRAN10qFs1FbuuHqEak1ap23y+v7KZys9OFmsqtu9ScfwVKNuM96pByIwjgK0aOH2chcL
    kclbfK2PHFngzq/VD/9p90nPXFmCx2JmaFNh+HTHuzZpvO/8EgXhRWkwPc4g
X-ME-Proxy: <xmx:6ID_ajrsrveOLAsfNjVROe0VcSeckHvFEcSsDE_4z_Yq44WjvHqSUg>
    <xmx:6ID_aqxtROTZhAUFd3iwL_y-aBuojT52PzBBK2JDJHm6zBTkVpeBdQ>
    <xmx:6ID_avOTN_JZqp-Q9PIiq5hV0PMdTPvp7eaw93zix_3rP5G-zRZGmw>
    <xmx:6ID_an6Y04TMQcyEuK43_BBvNfWbfoatqxy0b32swxkH1qfNeari3Q>
    <xmx:6ID_an6qLXhqGB7ROnt2tsBZk6DjC_KIpfR2YyYJ1p54vsNepVtYoRPs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 18:06:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Adam Dinwoodie
 <adam@dinwoodie.org>
Subject: Re: [PATCH v3] setup: fix hash algorithm detection
In-Reply-To: <av92KlePF0GKyQDh@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Thu, 19 Nov 2026 22:20:26 +0000")
References: <20261108011633.1772000-1-sandals@crustytoothpaste.net>
	<20261119010612.687733-1-sandals@crustytoothpaste.net>
	<xmqqmrr4zsi2.fsf@gitster.g>
	<av92KlePF0GKyQDh@fruit.crustytoothpaste.net>
Date: Thu, 19 Nov 2026 15:06:14 -0800
Message-ID: <xmqqse0wto9l.fsf@gitster.g>
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

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> ...  The difference is we scream if the former
> mismatches with the repository, whereas if the repository is already
> initialized, we ignore `GIT_DEFAULT_HASH` and
> `init.defaultObjectFormat`.

That makes perfect sense.  Thanks.
