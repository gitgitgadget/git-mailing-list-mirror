Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224F72FFDC2
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 09:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761643031; cv=none; b=TXaeVo2cbfP3wizBnGmGSncud5C5Vsg0getQT/o+2jYK3ixKbEKB1aR9fSJyTdAWnDIyrWPj6aLS+aN1x6ZZylFaNtP38ZkMHNGNfLTeuZkiFe6jdoWqGmNr01iFJkfYIvu+Z+m7UWOaSAktk6WLrb+K30L1cE9SbMf3vrcuUxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761643031; c=relaxed/simple;
	bh=LXW4HUoveh/8RTLcmsVofxTvx/KeF1zWSY3vmJQ8LPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icGn4g8QhZETevFR2D98n1fYdwtual+ONjTxKZgHRLRc/ivcIHW9Cyk3iVkG+NwfsLGMC6noAuuONWurqUsTyLdUxIGp44uu3Zb2ObQMT35Fu339yxkFARS21bq9hJvNAIDmh6xzNvLIWHZ7mi61tBdbkrk0sD+BI/lUbQXYoMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mnnx2Zpp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wE9sxmdx; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mnnx2Zpp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wE9sxmdx"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4E8C914002E2;
	Tue, 28 Oct 2025 05:17:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 28 Oct 2025 05:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761643028; x=1761729428; bh=l9N4E2TSEw
	nlzWCPAhBTFVLP7dF4+W+9ti8+jlV7+PI=; b=mnnx2ZppvmVSNRxE2v1FClKHRv
	lNNgMUv6UIRPfFemWt77gwQotA2A+HJCHMPu31FWYVxj82c470CX6bZXkZoS0Zn0
	VcAvDLLljJAOxCE6sG8KE3RvqINDS/TYd8PgaCGv0w7y8bpL7WXsoB7Pg2T0v5KG
	6mv6PbVrlTI6j8WIADAuWYazOfiqpxxXBlinJuUDtWTrVXBk2m9rnTQjwrzg6FU2
	5sw0IWK6w58xos1GElfrCAGdxovE2MDTWwlAgnC1pjBFAwfhUFbz4XBC3nDIZdmB
	u18u+FrKrv4dcnWfk8X4G5g4BQBPeTCinMW5kT82ikMeSdq9nGeluKHe4HJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761643028; x=1761729428; bh=l9N4E2TSEwnlzWCPAhBTFVLP7dF4+W+9ti8
	+jlV7+PI=; b=wE9sxmdxyguU1Xu6pp8pLwLAYjHRsf/tNkF9v7yUT6K61girOD0
	C5ZbduX0dfnGRGuoC+5bnAaMxFa0nazgt+MxIvZ+RWg6tCFifbiu5HpMiVw+1SeS
	b1/74hIpEq2Z7goiK8Jgwdw1gMjmNoNTNwLbJ3OCmilfWwyHgA3ct47HtkL/F/qI
	SJpn6CeZATAwV8UpSjZR255p34G5EaSEbeBaFaej6vtd6H0O3hc0tr6hKp6Q3DL2
	eBh0z1ki/2Z8l+tiSuUEHwn7xxOT+xaYC/7ZJrq5yFcch/y7mP8Strvr9UNVl1Qr
	ptc0OSyecRWBoAtjl46eV/kqfpt+DNm01VA==
X-ME-Sender: <xms:FIoAaQaYe5HYg0wfJ-Eh2vNfofuXJO0B7R4xKH3z-RYLk4_0wMWFmQ>
    <xme:FIoAaSbf67ic5RRhuzfkVKYyHImDOZQ0Q_gbwDstuGv87eke7K31AB-jAuyJhI3nZ
    SoMaWVYUAOQuI5apkrHz6RBOW22yud98vLLJk45tRq5yUqsFMk6>
X-ME-Received: <xmr:FIoAaf803L-t7Xx2u9w6eeaM-jsg5GjACyehIQpJ0YJ7NZUnKATupHHdyvXI4qNnkP5HOJ2--R0r7SKEgKvm9UVjMQq7uz9O6mV9St2HSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedtgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epieduieeitdehieeutdejudehkedvgfejudefgfeiuefgjeekudegfefgffeftdehnecu
    ffhomhgrihhnpehgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
    dprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghnug
    grlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:FIoAaZi4k15Jdvp-OQxBWd4QUi6BgZ_dH67EprpxVrtBjXLuiit1QA>
    <xmx:FIoAaXdeH6bET3VmB29Q84yHh0CieYfQuBnRxdr_-EYPb4fOygxKdQ>
    <xmx:FIoAaYpwhIAacti3VP-On8_JZ6uMpaRTuBE2pXWI-jgkdWwemTLG2w>
    <xmx:FIoAaUD6oqjvohKOKRE4m6A_yfzklwjmwuoCN15bcTCGKw5sMritAA>
    <xmx:FIoAaQD0kkNcxzRpkKGAxjZDku-PCZYOMrhuQAQf5tJeQwClLY5EvTRr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Oct 2025 05:17:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 43f1ee3f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 28 Oct 2025 09:17:07 +0000 (UTC)
Date: Tue, 28 Oct 2025 10:17:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 04/14] rust: add a ObjectID struct
Message-ID: <aQCKD--ZmKnwBWs9@pks.im>
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
 <20251027004404.2152927-5-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027004404.2152927-5-sandals@crustytoothpaste.net>

On Mon, Oct 27, 2025 at 12:43:54AM +0000, brian m. carlson wrote:
> diff --git a/src/hash.rs b/src/hash.rs
> new file mode 100644
> index 0000000000..0219391820
> --- /dev/null
> +++ b/src/hash.rs
> @@ -0,0 +1,21 @@
> +// This program is free software; you can redistribute it and/or modify
> +// it under the terms of the GNU General Public License as published by
> +// the Free Software Foundation: version 2 of the License, dated June 1991.
> +//
> +// This program is distributed in the hope that it will be useful,
> +// but WITHOUT ANY WARRANTY; without even the implied warranty of
> +// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +// GNU General Public License for more details.
> +//
> +// You should have received a copy of the GNU General Public License along
> +// with this program; if not, see <https://www.gnu.org/licenses/>.

We typically don't have these headers for our C code, so why have it
over here?

> +pub const GIT_MAX_RAWSZ: usize = 32;
> +
> +/// A binary object ID.
> +#[repr(C)]
> +#[derive(Debug, Clone, Ord, PartialOrd, Eq, PartialEq)]
> +pub struct ObjectID {
> +    pub hash: [u8; GIT_MAX_RAWSZ],
> +    pub algo: u32,
> +}

An alternative to represent this type would be to use an enum:

    pub enum ObjectID {
        SHA1([u8; GIT_SHA1_RAWSZ]),
        SHA256([u8; GIT_SHA256_RAWSZ]),
    }

That would give us some type safety going forward, but it might be
harder to work with for us?

Patrick
