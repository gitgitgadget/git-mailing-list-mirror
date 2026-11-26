Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795727695;
	b=STZt3svbE2VGSmAsqRI6OunHBqD6bQ+5CRRUqrW4aeeN0nMC1a/mED4tmyxXUWz8uVUa
	 1YaShPxOPycA5dOZI1e/ICxRCuoGu8NY4yaXSdFRNKtZGDtOCJEjXJxEfX3V3UbNRj6cz
	 D/LThh2GzFXd+OCTBlWihF0v/KT/dkzilG342QN7hF5N/MQxUB9y97P5e+DXvq43veA48
	 Ng5qCv8GQ5DoJiXoPnhiOsoqC99yfz4ETKAlPnf5BJb/5E9PWxkk1svI6yRZFDPa2AhTo
	 0tIvOgFixdF8xLf+5k03j+ER4dp2k2/z7IaDZFDDd0rTuTEx10zfUOnSf5hl5lwZ0Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795727695;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=SRKWtj3UcnbWwMbg7QrACKE3Qkitcb9DTMIG5NypbTs=;
	b=rJVgqt1N41XydlEfYmYv6Q+PgggoytT3SetrQdN6A787HPRdMLx1/bfTejFu6QjCVIV+
	 FR9s/kKLjHytiU4DIA0yEgxoRUewulYM4PA9/7p4dn+K0e4fh/AyrhzlGpRxapjX92ar3
	 FSdphPChynn4NPScQTnwJsZWIAuTPuqx/mZiY6pRY05IjuObGmx085fYL14NZCPzx+iXo
	 S41sWxzRo7UgN/1GoAEDtRip4E7FWHt8FVX43Wc2/10SDGv6hV2rvyvLuDFvfE5idKzHz
	 0oIwnN7BS1jvtgNEHa27zLEJ2KhulaMckItHaDtxb8EINhklx0Pzbj7CF09463FYoDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=Gv46BIHE;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=JaoIDEZ3;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0811606A321
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 21:14:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0811606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=Gv46BIHE;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=JaoIDEZ3
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BD3D57A03DA
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 16:14:53 -0500 (EST)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Thu, 26 Nov 2026 16:14:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1795727691;
	 x=1795814091; bh=SRKWtj3UcnbWwMbg7QrACKE3Qkitcb9DTMIG5NypbTs=; b=
	Gv46BIHEluAnvx77DZM/K33iNIwDt3QytzVOCmmJE10YMWrjdv0SD9GHzfk2pRNo
	Rdv4/ZdcVmDmiCoTed6nrrqgxH/IT9reSbORSXWzkXczju/jrZPzun2jGS5FV+lm
	tldDQhxyK/Ar7GWwbrxvaG/mAR5WaoVB8GVLU+MHNFx8E40jmHHstuk48CCLdVGc
	zN6RKA8EUCPcx8yub805wp8CVKHtRqYqCw7afJdWwM1udW9lRJ1TxnOZzMaV1rp4
	Fi4NNiy4zI1BEVJx5ioj9uXRVpKKSM3mkAWGDCiVk0jUi6yyGpMazGKDfHzE3fM7
	4wf/kqzx0eNTLasvZ8Tugw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795727691; x=
	1795814091; bh=SRKWtj3UcnbWwMbg7QrACKE3Qkitcb9DTMIG5NypbTs=; b=J
	aoIDEZ3prVbdK1W1e3zSsaY34bkbQrZnEceWQyI5sd7i3GCGJyYhTgfUQI30S9bL
	8uw2JHgILu+Avi21Psbs+Mn4hWiZAnNeV8bhYLnZkTok4AEzceGrbgEQSv/nD8X8
	sLW7BQtf8q9Im9Eg5LN2EdrA/BIINwp80VrO6lRCBzV5Gfg6QpuL8hReur7qJpVY
	u4hgTxs44cQnaf//3PDRkRA4wETY7tCtvEShzKtksXhTtYWYgXi9Q8btKZBNozD/
	vpSpnihVmalEzgNdk2IZaMEV7966NzWANNbQcKT6/ap3tN78qBrBrBK8j/QIryxT
	MaVMswCPLhiXJ7IFW09DA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795727691; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:Eoh8PEkKEdVmx6oTBsivKKDEB6nbXqCmqlPr/rB16wPAnks
	Nyahuyrc55GSEVk4kFStxz3faKwZDtINNOFPxaDof97q2ij+DEyA9RHqU4Y5bvyF
	W0tDHe7+iWK6uZpnKV7pvnLNCRb5f5K7fW5lyEQHGRIvnzoPV0dPkYEo1TvnIqSh
	i5ymxDQF1V7gAAXSAMmNKO6LO0bS/91trSUL0Qtfdsp7rFoU038lhTbtx1HAtr1D
	6nXRST3ADEXZrUNehNk0O/ozgFwgt5IP9qoMYANPZCQOYT8LoI5ytf6aRWOa3r1B
	OE8Jwa0w8rB6D/r9s9R9sYMDyKpH+eaBX1vPKZQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:wHsxroKIoPEBU13a7ofn6/s+KHNaBkjnSGexNfKZ1CE=:rM4J8JUfjHfKuFO//KZV+Hwe1Dg4e/EaLwb196QuWSA=;
X-ME-Sender: <xms:RqEIa69zbBO9oIXVp9G3y0SLoXW4eNRL2hVGXfgMol5tQ48MciH3aoI>
    <xme:RqEIa1hP__fR3-dsWAo8zlEXNpTz4xg_NRKKFYI_yS6GGEOpAVPG4ywc5YaYq7up9
    TBt0RjiX9hquen4a_4k_4ruBGWSp7vtexcqOWrM72kDAs7F088np9E>
X-ME-Proxy-Cause: dmFkZTGuMhEa8KXKNDZ67B2ZEDJ0WTqgCMBTdpFPxJ9zayMx0YNJ39n/j0Okxx5NYtVNWh
    RIlXtJHV1ASVmk6iwDF9h5R442nxa/mzE788TdUYVlkuI9gxhCPqydswFRX2qTFVViiORT
    2KCwIoqiHY8HlHZfy/ttG57ZjGikNa0k3WS/FmBFK3zbX+6jRH5CTd15n/slYybUZN16+9
    HLtcNXQ2E0/yItyadZeTRjKlp/F2SEt8Pg7bNaqK/hPINKx9+rgmpzuZc2REOmzrgtALb+
    e4iOpEP59xUMN/NxBS00DFXTtvA0ekDhUBWvKEBkJgrjbLwqujus9pS0G1tlThdCvYldk+
    itVPDJ6kMzclQ76xEgwmkcSK4xKJ6PEfOL4g+n21K0UOZdUs/Up4fqk74EtfwgFrC3a3sQ
    ZwU9xNzoW2g7OI/fxcfjaViJlZaZxlz+5JK4sf0M50cIe/0R5U0sH2YwnQyP4S5kcYIlYd
    s/maMjBfS9g3J82Z9lTUeJuzKTTjscwOiEV28U0uwo9q9S1qFwJzYeZmtbH8mdahHLclaO
    3GmMN0KhqtvTjEHQSNn1TA9yGBlbKAY07dxPG6wU9WHZz82IernDJBT1F+eW8fOafIkOoD
    dQloPR5nApIrSpf94xydz/nHlWH7PgTVa1yVFlNxPlg9kf0CFsVRE7xB0zow
X-ME-Proxy: <xmx:SKEIa3FErqGIxwudgnC5RX7Y1OCryjgW2HFeJzY1J-bd-Cz-UrX6mg>
    <xmx:SKEIa_z3cs05EdbQGRM0kshj9Gk3bGJAF6K6kSavI8kJU4cWBL7YbQ>
    <xmx:SKEIa8oR-3DNDquwJMZ3WMK5-aIl-LDJXY2ZagpKP23L4g5uEe_1Bw>
    <xmx:SKEIa5j1Rlr25DDYvOog7xmNVXI-ZNrGBDPy4ZC4b6nc11FDU2c2Nw>
    <xmx:S6EIaz3QoveZBT6amhdLXq_zyyZnl8GgjICbyR1kF7xRkbygh3bO73jb>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id B2D3522C009C; Thu, 26 Nov 2026 16:14:46 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AkCwORjixZW3
Date: Thu, 26 Nov 2026 22:14:26 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Phillip Wood" <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Cc: "Jeff King" <peff@peff.net>, "Phillip Wood" <phillip.wood123@gmail.com>
Message-Id: <38a1afc3-92a1-411a-b8e0-573846bc9d93@app.fastmail.com>
In-Reply-To: 
 <6e310e0af58cf693819a8d7384c1560e2e342d4b.1795710343.git.phillip.wood@dunelm.org.uk>
References: 
 <fa8b80af26481e0dc96fd8f80f3c7ba84f60f9d4.1795516651.git.phillip.wood@dunelm.org.uk>
 <6e310e0af58cf693819a8d7384c1560e2e342d4b.1795710343.git.phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2] var: add GIT_COMMENT_STRING
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26, 2026, at 17:25, Phillip Wood wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Since commit 9ccf3e9b22 (config: add core.commentString, 2024-03-27)
> we have two separate config keys that set the comment string used by g=
it
> when creating template commit messages etc. As that commit notes, when
> core.commentString is set to a multi-byte string, it can be useful to
> keep core.commentChar set to a single character for compatibility with
> older versions of git. That makes it awkward for scripts to determine
> what the comment string is because they need to do something like
>
>     {
>         echo ' #'
>         git config --get-regex '^core.comment(char|string)$'
>     } | sed -n '$s/^[^ ] //p'
>
> Add GIT_COMMENT_STRING to "git var" to make it easier for scripts to
> determine the comment string.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---

Looks good.

> Changes since V1:
>  - Fixed typos in commit message
>  - Added a reference to `git var GIT_COMMENT_STRING` to the
>    documentation for core.commentString

Oh, I didn=E2=80=99t think of that. That=E2=80=99s a good improvement.

>  - Added a reference to the relevant config keys to the documentation
>    for GIT_COMMENT_STRING
>
> base-commit: f7de81456940dd6f3274e461149bba12965de609
> Published-As:
> https://github.com/phillipwood/git/releases/tag/pw%2Fvar-comment-strin=
g%2Fv2
> View-Changes-At:
> https://github.com/phillipwood/git/compare/f7de81456...6e310e0af
> Fetch-It-Via: git fetch https://github.com/phillipwood/git
> pw/var-comment-string/v2
>[snip]

I think this is good. I have nothing to add in addition to what
Junio wrote.
