Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793346030;
	b=zgtJybMyr7fu6wazJm9yTs1RRSJLhH7VQJxaTNispl+e5rLTQGrhO8nbRdEJ6k7l0rho
	 +gK44/I9E1SlwZkaMytFbx8+hmy2U52OZ2AfrDFPNqlS+UqTDp3ZrSpECDF+DclVpLzPB
	 G+FQudLMVN7OKdhoZSbxDrB7fyOL00JrXo66danVa7X7f72UvESpR5xgyylHdZ6gtd/UK
	 gFL4ZYEt7PRzsBCYH0r5U8NAMXTyG+F/lUh3uehflFbOIFF5NW+i2ouo/E+ZO8ZTHn3XT
	 UdcRzgKBr0UH6tX2kqcBvnag9GCY1auxBkK6wtoOR36S8IBYjaiX1yusZyHMjLnYnmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793346030;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=OHUYXbF1isLdaNTw+mEw5xY0VYJ8paueKgNpf358CLI=;
	b=tsHNvGPfiJRRDk11JntCdE3/keLjw56lQtls6HOk2uvd5Old4ifqc1g1aPe/foYqF1fY
	 zFmCwuyOiSdCCYag0qM4a8N8v3rlXCnQQHj2rg45MhdUxr19PxUFobchCxcpFeUvcg2FH
	 WgKpCTdkyvN1FKusKG+1x0dBgdtFQIP6Sz+a5w9I4Zn5lZfBzcJeYWurhAkOS4bkpeLbF
	 hOFDCB/uZS0NbjSCwFmtzm8U3WCjRV2UK6f5xn8dUB+xurzCL+0tg23JjbKgRD5JopDsM
	 EHRmylE/GRIyd040LFKUZmxNOT3YA/H6+G2Gk4yHmogiSnik6ZOMazohjAd76t2VWmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=fbQ2n0FX;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=c4BE6TFi;
	arc=none smtp.remote-ip=103.168.172.158
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABF2606A31A
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 07:40:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DABF2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=fbQ2n0FX;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=c4BE6TFi
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0BB831400186
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 03:40:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 30 Oct 2026 03:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793346029;
	 x=1793432429; bh=OHUYXbF1isLdaNTw+mEw5xY0VYJ8paueKgNpf358CLI=; b=
	fbQ2n0FXeKZh2TrYl7NDSuzVVv5z3/9B1iW07OIMiSo7q8zmscejsQBNI1iDYgcM
	iG26KsmChegcNpK9jh8i3GCAvyrwLacmTepRT0ZeNF0y+KcvD2Hrhtj1BJrkQG/M
	KM462XGjNZCLvRIlguHrKcZryuUy1ivE2EX/eBTcKQt11W/OwQQekWEQxUp3gdOT
	tJFL8YpeOfRIdvIZQrvr7L3Wg1psTiFDE4b0KxDzzYB47r5RSCOkg/fEKeFGpvE4
	QMIflZUpb+Ch/xZ1+sgRrZESeCPi+eYuy34boCr7318oYa0lKp7UdrhVuvz7xZFL
	I2vzrHbLr142+5HusDgkeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793346029; x=
	1793432429; bh=OHUYXbF1isLdaNTw+mEw5xY0VYJ8paueKgNpf358CLI=; b=c
	4BE6TFix+PZ0DWHjVvFCq5tdm+QbDI2BcqSVZel5ztShStUVhURC1ubsdGxgvNZe
	wfeaNVZNW2yyK81hqUIT+2izMEn58bGTp+5d17GHtpUX33LXVJvyziN51UkLSwVF
	6tl7Kri0vweS9h4N0j/gOgjz9PSmAo7xOq729UjOAbdN7KMKl8KNIHhe1RnA3WOZ
	cVb3/4ZU5pivbWAhpcESvx6NV/V4uOtE14Bp0G27xlZYYNoC8P0CknK659M5nLms
	eDw587oIGZL6oMRn5p5Yo5PYL8Lk+mH6DRqDGV8j4c6O18MGm2AfYLTNm9N+9tS9
	WVhETpVl7k6Xu7BRNsVjA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793346029; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:kOF8ALNshr9za6eSC4FxfnxlQPcvPdNenGJ2neyETo0TJdD
	pedKdQQcacjWBKZAk4QgR8h4ttj5PyBD677Rcik/0HConnzhNGsLA8shh3EY7ywx
	c2gA80MqTPD6CApQwgCx31C0GHvV6rfRcnFaQjW2RIc/UCsKgno9SJa5f2hemPKT
	ZSMDFOXsW+p031bEsINf1sWxlW0d38Q4XPoFI9lG1SueHGhMQ+jaUOnxzp3Jqp+p
	49bfR8tGY6lrqeM3UbikA5wnUZX8OvRmtvBCqScMGxqC3MwCxYvHNVl/sYM881oi
	EbjsuCp95NB28vVo6eMRm9Qk84W3R0emStFuFtw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:DLGYNKIXI/ztbW3PCWb+LwWf6oxNTAniaxiSkA4VnVw=:OHUYXbF1isLdaNTw+mEw5xY0VYJ8paueKgNpf358CLI=;
X-ME-Sender: <xms:60nkarS-NE2aP3lChbXc9Qc5EPE1SWImopD_LjA0Q7jZguPjyT7lOA>
    <xme:60nkaqn42gFs6GNjydIKPKj-Qtz2uVbQLGuAzPifVIJQWXTSUph8NwbbJon6c2hk1
    3usSm8ikDgYrR3Hfs3v8AeF7u584v93eepaK-iHEuvj9wGH5lLeMw>
X-ME-Received: <xmr:60nkarTrsPzDEC_bTj30hXvi4zaklohT8sT-BZMFFCZXLhosiQSGEu1oqTioyv3lorFm-Q>
X-ME-Proxy-Cause: dmFkZTEyrMYLzi6YZVytRVXxXrgLtyCaudG0kfkRfkPEuyux28xEiwIkaHBh1YsTfZ7HKs
    Tx4hILWSkAxjmJ5on30MhHrzS8RiB31zV5s4jQ1H6D7JQ/2Mcv4LS0qcsyZMELgTHOvVRz
    UIvfkGoGpwvrVcteDzvASoiGEC+2Btt8M3tpAC/652mMz32Jbw9gld0ICkGDHe2RiGr0fP
    pGHfNK3Rioc0Zz6hp4EXTWdymKUphQ++JURxPzidI5OiAnrA6VoEMC51d9auoVzbClffIL
    hIJX3ujyF7GAk2nvdOo6G2alhxFTyylmxhq2kHRWzE6IucBIG1FY4PB5fex94ClEdwyQUg
    Z5YEtFUlWVJi3aexQVpoR26Td+AOKQ+1YK13CcWyvjDyVGYoXOPjYNsyIYdruJaylgZ2jB
    co8et1KrFZQRZdND+xdxLKDXwr/OtwIZ/McGbmkhUZ5CXLKFr71BgLUeHre27DOLhC2y7H
    snQZM4OCwq2IW6FezOwEFZYUD5DFxvOcqIcbMMJ5StWmbu+H+/6tEflL3XCtDZyUt6BPHV
    zUkww6pzcI/QhSJwZybnKcPp+lCcm0lJRxP9hc/qEWjVAC4eJZje+r5C33V1VXH5fUB6Aw
    LMIZgCBcUXtcrXF8gUJhy4FCfMTGl+/Brr146qMDkvG7kHkhhinor/ubQwiw
X-ME-Proxy: <xmx:60nkaoNhnjtRfbE9dFeK4MAfvfig91iotbur5a8uGe56e8vJFjXn-Q>
    <xmx:60nkakVKurRcOXY5g36WfKiv2umpXjiIlS33ZG5yp-CAThIBFoofCA>
    <xmx:60nkaveD1LrCtIWcxCG7gTfG50UsRO4DMbHdRH_RNGrpn9EAGepMdA>
    <xmx:60nkagut0vdv2sVYzJjRYZV5zv4W-oj_8lBcF0WOS3xc85JxlR3Cow>
    <xmx:7Unkalrd8bP2zgUSGL84DZ3ZhHJHY51QndoMNbjLAXXSh46UrOOObw2k>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 03:40:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6ce62224 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Oct 2026 07:40:24 +0000 (UTC)
Date: Fri, 30 Oct 2026 08:40:21 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian =?utf-8?B?Tm/DqSBSYW1vcyBMw7NwZXo=?= <chris@nortesoftware.dev>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] doc: gpg: say which date SSH key lifetimes are
 checked against
Message-ID: <auRJ5U_yYZ3c3rZG@pks.im>
References: <20261021030347.565306-1-chris@nortesoftware.dev>
 <20261030061528.27901-1-chris@nortesoftware.dev>
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
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261030061528.27901-1-chris@nortesoftware.dev>

On Fri, Oct 30, 2026 at 02:15:28AM -0400, Christian Noé Ramos López wrote:
> Changes since v2: Patrick's wording, which also says that the signer
> chooses the timestamp.

Thanks, this version looks good to me.

Patrick
