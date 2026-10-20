Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792457649;
	b=QdQ+bjG+XxCrd8KcwUchW5LR3FC0oEkzpGixZTRS7DBToRYFuJSvX5sOLfDjzfxSjAd2
	 HETq6tZNLBaIn8kUI40EjDnd0MONxig37/YWJOWPXjDj56Ex9dkkQuRv2OvxvXG/EGUa5
	 MVQz8RwX2DQOyNf1A+uSXHEmUDEqwaJXwPeVR0KfLX/PtFtQ6z1ggHUTkdktsWo9cUEO2
	 /Hj4eOriakW1KpbxzLIsdO1XLTDa4nSVMQBrZiMj9RGs4EHA459mIyFM4EmRJsAZeh+zR
	 TdiWMpkb97CELvy5B82w9CXtx3ClXrGzv7j+UY2jjjRNeIhH96lo9Ca2WKiNJkhxmYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792457649;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=2P+Csubq8Owbt8eSuyGx7LKApAs3dL1sbOmJtVHBPhQ=;
	b=QYr1RDLxnzSuEkUvhY9vs/IiDVssk3cPeVTfgtOK6NEg6V+6bpsED0q11jHdtwEP0+82
	 Gm9ZsqBEzsKq+umGzu1RMMOAbMETWg91ADO5aj3TQzyf5ekOcevHEsUCAI7KQpnHjxTr2
	 p7q9g+D2Nf6AAhlj5FDnjul3af8jORTfsu91GkB21nkYSfEKQqV8uASArYsm7oWp9cs+A
	 Azbc3pFn38ULGYV+LBTtdL6gDL1aJh1lM0ueN/oRVAyIDZeWAhbWi+M+wjlZlXdBVaRrH
	 dzCcWmztnIJTda8E3UHJaG1Q0dQU9e5S7qUoAmzPlPl2+TOffcDcmfynovolOLmUBhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=eBhQ39St;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="s/B3AaTt";
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C08606A324
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 00:54:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8C08606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=eBhQ39St;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=s/B3AaTt
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 1A641EC0175
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 20:54:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 19 Oct 2026 20:54:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792457648; x=1792544048; bh=2P+Csubq8O
	wbt8eSuyGx7LKApAs3dL1sbOmJtVHBPhQ=; b=eBhQ39StyrXCututTpFZM3jFuz
	eQQupe4yfaPWwV6W2SIaho0awyAkn1cKE6At/nvx435LQypSXhfPRRFkkILETLqS
	hwV15LZjZUb64B7oyPYghiEWvBzlyO4MT5stho44iNghkDq8Gqzv7uOEojOP12Si
	3kTInGY+PS9RSOJORGV2NxguHtt7spxyjoONjWXbKqaC4dAR36N2tQqdGk24r2Sw
	j+HfstmZ9UBW6BAWBJM181ObNfVq/AdHFMWezoDo3DTEucKBnCM74rvwZxnsSSqp
	bThG+Jo61Xi8MWA5n0+458h/R+kTN7jMN/Ln04ohgMrV8gEAka19a7CHZRTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792457648; x=1792544048; bh=2P+Csubq8Owbt8eSuyGx7LKApAs3dL1sbOm
	JtVHBPhQ=; b=s/B3AaTtGsolPJuMZphtiO9zpg3bGe3DOH7M98QVm9RvlpPRkG0
	oMT38JEDK2JatndvRnJNTa5j05NnEbh/ifPqx5404Tx7lfMjc3AkRY6ARSLDBlm1
	wIE5plz+FRAcYHBSXSPlXqcygi8OXUfhm2Ra/98eVpsGAQ17SYfrsaFfe//KNnTf
	fKTEDATtXpIS28GDXF/3wjAqKEAuyrqF0fxwbnAj4Ww6+FmPK69cN0VnGIY0hCLh
	qI+TLBdr1emO/H7NAwJpW/ephwi0B2p9Jn0NaWi9Vpj1dwaiPXlyGUwlSXXLdX4E
	vfVpocyZ+9soPEHQlI2VMjtFZZ+INIXiZ3Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792457648; d=pobox.com;
	mf=PHRtekBwb2JveC5jb20+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:EJXqmYg3lUZo10kJNWaQGz37pkymrnP12RDIS8813aWJ9q2
	Arm/99QcE4OL20NaI47jAsoZfpJEM0d6Ca1qu1JVKKpXetn0qqCsAkIeGqOcZ9ki
	6jdidjgmwYvtEAdXIQXbvX/pGHh1XmE+6dPqx4oUgZxl7ON2QyH+Hh3zINO5V4L3
	NdM4BysqplUBtAcQfNk079Yv2bMB69pKYXthPDN1p2MxvBEUQPNNqRMCkIWxpb6V
	jD2y+qCZeCC3YYuDh9SWASE6omVe98XfI1IjmunqxjheOsCLat0c1Ytlg96dfUza
	veQf0yrG9x5gsaI+ajzBZ+cie06LgOeSSWpKXAA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:xtF9N/LsPCUcDzogEQRW8vIpiuCT4WCWAhe+nO4mUrY=:Gc2OTyDuSjku+5q9pgIBzApLI4Z6+CjyWEB7NMTgTFY=;
X-ME-Sender: <xms:r7vWasRZS-2QShEwsKQqKSUmAsWlWopjL_6XYyDAgMd9HeYoS3j9qQ>
    <xme:r7vWagwRmtctfgWC6BXFW7wY-aaEtQ7_ipDEzZsqpWWJuU3l_iW2JwGtMNOMMNUnY
    BnXr67DqY6UPtEouzdFBgrRQAHW_2odMCd1qX9cMTQYQQR1gcGTlf0>
X-ME-Received: <xmr:r7vWau0X5MSQ1WsxkYu6M7zun_Jxos-R9Agx2hN_f__1AhOvTyTUpQzDA7EuT_I4EuAbWOHdvxBooc1epNLccq0wYRi20ekbsWeGp_kqZ-8cqFTL32KIZfo>
X-ME-Proxy-Cause: dmFkZTEmYc9I/ybo/Oem8QWwGM/8VKPRIPmrP3PaFAnw0EJKInlmXgU71xTZPUo0lZjIDO
    TXPwQZxrWeRhs5JPHGbYlm29bdBK+Kw/cA1rBZ1GU3MkeQTdS7+c0QFBTwqN7GjcCe1TgK
    wKB1eX1UkxF3Ntd8SxU1QzFmIOp2LYha41J2pgXVE3CCIyZDYq+si+Cit/OyDNtGcBnQ7I
    8cDt0W6rFj7C5wQFam9Z1YDUT7/BF+41AtUPqkrvs1rsA6kjJZsfPMjHwnPsJSOwIl7lPN
    R0u6JQPucyr2zSRQtRtgRuD7nFw1JthDh7RxgATICgNvLTOIHnL2vzZh0eMiMFhw3rzHof
    8TfbAHN3okD3+kbI1ctRbZwUpVGw+KbLmc5yu7IZsqztMg6GjK686OrSAwRmG/PRMw067I
    YPEgnFSvpz6YVp2yL0FEjjCf+6/VfLry4eNfAuPaPC5nQWfH4/1Pcg4ScMLViPeunPX9b0
    mzA2PdChkNv9uHopcvyJlQ9XKW+Knd/hsVBJFRpqkcT3ZU/Pwp4la4pCh+mGG/uJaKKau5
    WNlkOTqx0PgLwKurAOr76Z5a7IdNy3aZQxbRXRcOlD0Um/deNj7G9QKWq0BDdbjNVsRDrT
    Spaqk3sZFZ9Sq5XBIbj77PmubHQkdSB1Tb/gg7Ut/rqXR62GT3aX+VAWzQFA
X-ME-Proxy: <xmx:r7vWau4rOTC1fxA2RHlyAZvw754ynUtXytFvTHrUccupkS9SgoPcRg>
    <xmx:r7vWahW-eHa72fZ4QOo6Wcb1AT4IP5G5gGPDde-ENkCFB4GnKv4AhA>
    <xmx:r7vWatAaIqwUPb5pb0JDlWcawkEM7Tsf1Llw4fytX0NkntdAcmFdJA>
    <xmx:r7vWag5eR45nask16bKh0oWyhV3C3OSxUMuN-iZ40d4PRw3x8CHMsg>
    <xmx:sLvWagbRdujoXTc52rg3JWGvBV9oGK3pWPPlsUdLYj3kib0C_1cOcgsA>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 20:54:07 -0400 (EDT)
Date: Mon, 19 Oct 2026 20:54:05 -0400
From: Todd Zullinger <tmz@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2] github-ci: update macos jobs to macos-15
Message-ID: <20261020005405.yfKQxutD@teonanacatl.net>
References: <xmqqfqy5clgz.fsf@gitster.g>
 <20261019194152.907881-1-gitster@pobox.com>
 <20261019234724.H0mV3jqQ@teonanacatl.net>
 <ata2Jg5_0Q6HnN8u@fruit.crustytoothpaste.net>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ata2Jg5_0Q6HnN8u@fruit.crustytoothpaste.net>

brian m. carlson wrote:
> On 2026-10-19 at 23:47:24, Todd Zullinger wrote:
>> Is it worth using `macos-latest` instead of `macos-26` and
>> letting those jobs move along with the current macOS runner
>> as it changes?
[...]
>> I don't know if that moves to the next release too quickly
>> to be useful to Git or not.  If not, maybe using that will
>> be a more convenient way to get macOS coverage where we
>> don't have a strong preference for the version?
> 
> I believe macOS releases once a year, so I expect that the macOS version
> for GitHub Actions will update about once a year as well and that one
> version a year will be removed.
> 
> Using `macos-latest` would be the easiest way to keep up to date, but it
> would also mean that we wouldn't test older OS features.

That's where the macos-15 jobs take effect.  To be sure, I
wasn't suggesting setting all of them to latest, just those
which are set to macos-26 here, as a way to get rolling
testing on macOS.

-- 
Todd
