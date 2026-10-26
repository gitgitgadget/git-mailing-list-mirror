Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793030040;
	b=IM9D05cU4EejBdoscEb1yVCSV6KS8Z6RC3TFRKdRPlupa0UqjQM6SFcwLC9iu8ysqZDm
	 4u8dfAWQ2ZAmkMwsBIIMvaYFBU3vfUTC23GRBU3xp2DdD7ha4hN1yisJkQFNU71j3EnqA
	 Qzc6en90wmyIrU8eUDQG4vowt0NHqNTehmf9NaT3+zywW8viRArs1mxg7NALrcsuFbRIo
	 YeF/F+5KlUWpBWBm1caA8riwW+Jpqjg2fcBL5PqPMEzpQxGHCIXzY97HK9zEwj1GajXE1
	 7q/0fXa/bAQzzWlhf4C3qXhCXlckE8xE9krMJ6sO8HuDw5jRQWoxLQ/YIwcldJCJ/ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793030040;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=RhUJNgj9tus/PNnm0Fnj0xaSWnmv2sO5zXsF8bBic7s=;
	b=ck87OWWdnE1d8YdAZwlTvN6vHDUqwSrH3dQupoSpFqUcIbWRdd1YxbBQwSCw0ggpDk62
	 Xtvfa6SwOQvF3pAZNoaYYsUpk/UkgBCuKklyWphXtx+62cNNyfTvCSkKxYcgeEdPB0CJ7
	 KgBUkyvC1GfTKV4IWgbf684OO3erzKMZIm6mysO8/GVjZ9FkkRFjMXA+F7x1dcl8+lBWm
	 Ynf1wVJmYc7QhjXbuiQgE59vI6dJFDkkIkkQE9N3MBDT7vr42Kq1jd52ATCSOvXUpKq4Z
	 09KdKXMNWm54JgMQk5CZQab+ne0KoImYAaXS91OIi5cTStKYVIn0FvFLWRjLDGi9fKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=L2Utp3ZD;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=LzSoBed8;
	arc=none smtp.remote-ip=202.12.124.150
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28777606A31F
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 15:54:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28777606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=L2Utp3ZD;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=LzSoBed8
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 85E711D00294
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 11:53:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 26 Oct 2026 11:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793030039; x=1793116439; bh=RhUJNgj9tu
	s/PNnm0Fnj0xaSWnmv2sO5zXsF8bBic7s=; b=L2Utp3ZD67unm9F9aTdZBvpd9l
	E66euz0cz0icQWreqW0baOAOq/w5WjXzLGQwo1vob9HiPHw8/d12Z5Si4+XO+zxK
	y1aNpBIvE2sgTTX29eiu7AP9+FyFTf76dqo5/ga6WAnrgJ68ycUjuyF8mLriewp0
	+MKtq0kkm0V9pGn55FwCJDjosT1/zwNFDmWl2M0a48yTz8ahso6VbBnjFcuiYsHD
	iFzyjFsMYLkUhNFzSb4FPGaWOZWnrNgfue2geKdgXkBRfzEe/xl6osMQ8ZjXo1hr
	jlEHJjF5V/Uj8oseAjpuw0wMDwUft+jTomPqt21coUUJoLiHrkrguYqWyyFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793030039; x=1793116439; bh=RhUJNgj9tus/PNnm0Fnj0xaSWnmv2sO5zXs
	F8bBic7s=; b=LzSoBed8azyXcmXuGDZ15vbROKAtBl1ezzmaVs2ujqNbtQM7Vom
	Cil4TPRCDL5UXZ2ew/Khpy36O2BNgZLYxyQw2JBa0MWgwtqrgHGz6FxQtCNv0Vy7
	W2n3ZVO2SWuJm5aE+tDpGa52nEDFJegWdLmRRwMcpiAkBvHH+Ci8tfmLnQIAnYhi
	D3A5nOmGbesYkMefqxbKfmq4DJhKz9+pSByCUo1Qw2ukFwBqeM+vZ4p5sejGVssr
	1o7JiMDzB1r6JJiWL/Tci+LfwL4GM3tgpwky/hizdpXXywOYee6WGkIP2Kj4j3Wh
	PRL1F6XVeuA2kRf6ar/1/5Fe2zLc8QpdkQw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793030039; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:M6MMy1CTshW4oIFU6hD2rrSYAQTlSsvDswvR2x4aZRnuqdx
	4eNLN5aIh8RMEtHxiC/yE3lOdz0M/7g9JFM70GQ1HwGME5DV7vkti5C++rcyosp9
	zkUgZjYyqHMHa0IMaVwgrvPJUPT0BtZVeg8Rt3/v6wKItag0pWJiSFzgpw3uy6xH
	YsQJa0E2WVTOp/iGL6vj5VEPEhKplE9PMmsZo9vbsp3+RgPhemdXTRJSlee/Rae0
	qrEyDcL7oXKsMUXgmu6unVJt4qq1nw4gwhuWXEJsOe/AZvuZl47OHw8FIiEbEeyH
	zCCSn9AnwgsQN/viaoFo5oXlrA0cRHJM5gSSjvg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:2wDCJtTI/vDpAZIP+kf77CMfQgmjhsGt/H4+cHC5hRI=:RhUJNgj9tus/PNnm0Fnj0xaSWnmv2sO5zXsF8bBic7s=;
X-ME-Sender: <xms:lnffar9A0cSVTHgGxacwK3r9jWIvxHl_2tpEhfEy7TrXUS2M31A0iA>
    <xme:lnffamwmwa1Ek9CWJrdaTs3fNfe16XVirzT-et8IIIf8ope3zIeZge4i7eIsQcX6o
    nj9_J71ZF_Oqco0vuY_pnnCvQmb_OGSwfKCXcpT27Ykf5aN-QlAEY0>
X-ME-Received: <xmr:lnffavMh3yrmPEG-DpXtnoPO00_bqiVKVIx9Dw67cv72fex9lbdgD-woISGfZc9zIxXT44mivkL4tJv4Q3Xh79TvD1j6E62cMDwA>
X-ME-Proxy-Cause: dmFkZTGi6YIcuY+L1Sm3Ciq23HzVGN68bAwJDOfDyR0Zbpg/XnBgvWBOeHpwDOD/AgLqUt
    RPQEPL+Y9kywf9D5bwMrzqQNREMn5MWvavcSJ2QNySfYo3THyyiRg0eZh3isLrmwLi9D4y
    CtZefG8rSGHMylI/xmdBQVIT5kPMgyygwUqlTxpQEHzrAPZ2A/TQ0QT38bthqG/orUwpHv
    JYYfR8xKO26MAlrL8tC4PW4jBWhJ8mgBnp9ytg22s8hfw79W0WpLqw5jUCkTG3/D4KC78P
    9ohQF4icApnPo/yLdepUubkaM08+eCbgU0UPbl2xVxEsPWGpI1lep9UGGB8VdZAAepbdb2
    e3unVVqZmYitrtgOgtluJx8I7uh4ghtYwSooukQ45UVUXPdL5+AzV/MxI6TFHs0f8sjMxe
    Ab626CnG+KaMUeDI9VL4aKwEVmKueC5tLx0HIoL56Jds1elMiaQ0Me55+qDmJtQDoPeyfc
    LtA6eT5GRrYim4YBghjgVzQ/B0pGkM1QmBYK0nirzSfnYT20bX50gaJDdbgleyHrpzkoDL
    1X9bC/o2HhTAIDgYZS0ZXI3iEVjUDvSufnhjP37RRpEUzgp5lilABMLwdzYvt1+i1jm52R
    fyaGQ8WjzQHIZVaSbt2t3rjKvkkIplRBkNkCaAa8RLFX5t3PjJqcwh4yQ5oA
X-ME-Proxy: <xmx:lnffaj_kbjSJoMc_G7XJusoMiwaTDqY19jhmIsLh3_3eCe41SMY2fA>
    <xmx:lnffak5XmigWDFp8hJDuQz216JOsWJuiiFod85tUUKMUJ2IAxkJp7A>
    <xmx:lnffah4-x_Q26yqeUrXJUGJtPWP0MQsu2RwicsLUQbxJYzCUG6XuMQ>
    <xmx:lnffalq3DwV-6ict-RxLdonA0-pXOi8mUxMZHvoKo_VoRvw05Y6drA>
    <xmx:l3ffaioPMzZ4oUXHIRJ42ADSGyS_FP_IgtmX2VFH8XDsnkAYS_W4ckRx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 11:53:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Aniket Gupta <aniketgupta3001@gmail.com>,  git@vger.kernel.org,
  christian.couder@gmail.com,  cat@malon.dev,  belkid98@gmail.com,
  phillip.wood123@gmail.com
Subject: Re: [PATCH 0/4] environment: move line ending config variables into
 repo_config_values
In-Reply-To: <at9HOXZhVcl53CGX@pks.im> (Patrick Steinhardt's message of "Mon,
	26 Oct 2026 13:27:37 +0100")
References: <20261024220012.486-1-aniketgupta3001@gmail.com>
	<at9HOXZhVcl53CGX@pks.im>
Date: Mon, 26 Oct 2026 08:53:57 -0700
Message-ID: <xmqq4ie8tq3u.fsf@gitster.g>
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

Patrick Steinhardt <ps@pks.im> writes:

> While these patches _look_ like they libify Git more, they actually do
> the exact opposite right now and tie us more and more to
> `the_repository`. So I'm inclined to say that we should hold off merging
> these patches until we fix that issue, or otherwise we paint ourselves
> into a corner.

Could you please volunteer to add a quick patch to add a comment
next to the problematic structure to tell people stop moving things
there (for now) and point at the message I am responding to?

Thanks.
