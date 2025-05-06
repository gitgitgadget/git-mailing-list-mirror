Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C479280A4C
	for <git@vger.kernel.org>; Tue,  6 May 2025 13:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537843; cv=none; b=T9hYicmqVte6KLnW9+IJqw1J/aJoyk0PCwltMAN7qt+BJC6LcNAk/6ljrBPnJSc59F94yDDBgKqju2nKAZnXkMR2vQmp7edMwW3TPHZeTrqvm1/vv7X0IPq+3gOlmnOVQw0pIVr4flyMjMnd0ZKkqg8t0VLQ2kLH8Ejxnfcw9Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537843; c=relaxed/simple;
	bh=z4XsFeriS14PODQFvx6Oz6q+ujkxsBrWOfBuTf8NkXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYnh7Nsb0qcFnJQ1v7bYHxxrc7EIdZlJinjkFaavsV5+GY87VHtkf3qgX3IykK4OGqfA1wTNubsr8IPny/W04zwENodXR3Ue0IUVg0kcyDPcNvyGh0CyHyViUioX1gUAvdMU4A5qJqA581URl8NHInbEV4wz9OIy0oV7va5utiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=evjITvlk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ws4ICrD3; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="evjITvlk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ws4ICrD3"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7436411400BE;
	Tue,  6 May 2025 09:24:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 06 May 2025 09:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746537840; x=1746624240; bh=gO+woshugo
	CE3cqKVVzCuTeuH4X8veedg+XNS+sLExo=; b=evjITvlkExOrFuaPZZK/PK5vf/
	kZOeKPEtLee6aYVFklw9CeVZFkKNDRTf0EE3hzK8EevAaZGEw3btsaSVzOfbsWov
	3ehM4qNJuCFOVe6u7AzTHTdZzQYSggv/eQ/fqkpf31s8WyVHfalNnPAYVedFLiyx
	c7GsVyRK9+DvutKUZfPNS9faVbZ3QRoj0i3CQR7bG3MoQZbJ8nL14oYyBXGJg5nL
	QH5jHPm+yMwwCIwqTwMG0pfmgkht8idmNirXU6r/vNJroHVSarK52Zr7bGXI3VV+
	yX9VTQ8DKF2Y4vbflC+GgagQaWSs1Ttq2cIOgNZnbqaVhh2CSKIjc62y8u5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746537840; x=1746624240; bh=gO+woshugoCE3cqKVVzCuTeuH4X8veedg+X
	NS+sLExo=; b=ws4ICrD39fcwqbYh5X1+xDr7GQdl8aQodpdQ9KteMo3KtSCDiDY
	GJdDEZ6zQZmKCs1ziZDzvq2zkvVCSZOq2eG9a5QjMokRPqyiDg3kzGftGZ+tjxpx
	rerESsbQX0d9Vr+Bsxv7UvqjRGlSbiPZqBDg45x8VXPIvQwI4V7VaT5ad3wTlMLA
	tIFeVkwb7OurH6gFMeSe8f0PwotgicWjSy3T1OiPCUun2Y2CVI7HdzIVgEkuZLQr
	EA5eFjETnUHad6LMnMu5RM51IPDMZ8PgO2WFPdIeUtgefeaX699EOC3vbElGI90P
	NjEWCOpctkgSYoHUps2gHOzrqpDcJ9pJ/jA==
X-ME-Sender: <xms:cA0aaEV-VQHYvOySdU3D7bjC9b73kd_PFg9hRxxJGUTQ0YbxBA4fVA>
    <xme:cA0aaIndauZIIjD6Xvnjpf-od2deBdDukZgCr3AQpY4R6uorySAcXxgT46tBchKWO
    0QTh3n7e2v-EJN5LA>
X-ME-Received: <xmr:cA0aaIbBNR4ca8vLRVIHmqL6OxIZBlHl2dB8bo9sFCsOohqPutWwIMf5RDoa_EINFp6ceMlhz4dCCDADlnonDK7nMJgrxrkwX6kKAZJU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeegtdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthh
    hprghsthgvrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtoheptg
    holhhlihhnrdhfuhhnkhdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:cA0aaDU2LQl3Se4Nw_L0b4x0JBI8FwTCJHC4ndl-KsM7WKaCRb7NHg>
    <xmx:cA0aaOl2E7K7ZaA_-OvoX7-5lNXC54YpzFX0_XrE2avmHvgwKLjknA>
    <xmx:cA0aaIeT0XzDderzRFgkf7e4qbztM45sxSHKO4Wlh4JmYjKGPeIKOA>
    <xmx:cA0aaAGs2PTa7xNcOvzMwNtTF-e2oJ3mqdw_03inyvzaIXV_BaHDSQ>
    <xmx:cA0aaKxjCh98qM7S_iK1qUc4MhIRQIHHNddcdXAImiCK9NDKSWO0Fi7X>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 May 2025 09:23:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 28d047f4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 6 May 2025 13:23:57 +0000 (UTC)
Date: Tue, 6 May 2025 15:23:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Collin Funk <collin.funk1@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	shejialuo@gmail.com, sandals@crustytoothpaste.net,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] wrapper: NetBSD gives EFTYPE and FreeBSD gives EMFILE
 where POSIX uses ELOOP
Message-ID: <aBoNbDgHncAeGW4e@pks.im>
References: <20250502233403.289761-1-collin.funk1@gmail.com>
 <20250503041718.42195-1-collin.funk1@gmail.com>
 <aBheGySF1FTsIVzx@pks.im>
 <xmqqo6w6okni.fsf@gitster.g>
 <87ikmemtd8.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ikmemtd8.fsf@gmail.com>

On Mon, May 05, 2025 at 06:16:03PM -0700, Collin Funk wrote:
> Hi all,
> 
> Junio C Hamano <gitster@pobox.com> writes:
> 
> >> Nit, to make this a bit easier to read: our style guide says that nested
> >> preprocessor directives should be indented by one spaces. So this would
> >> become:
> >>
> >>     # ifdef __NetBSD__
> >>     #  define SYMLINK_ERRNO EFTYPE
> >>     # elif defined(__FreeBSD__)
> >>     #  define SYMLINK_ERRNO EMLINK
> >>     # endif
> >>
> >> Note that the `ifdef` itself would also be indented because we already
> >> have a surrounding `#ifdef O_NOFOLLOW`.
> >
> > Hmph, it does look easier to read.  I think we used to have some
> > outlier files that indented CPP directives by prefixing spaces in
> > front of the whole line, but these days we standardized to express
> > the indentation by inserting spaces immediately after '#' that
> > always sit at the beginning of line, so what you showed here is a
> > good example to mimic.
> 
> No problem, I sent V3 with the suggested changes. That is actually my
> preferred why of indenting preprocessor directives. But I saw a mix if
> CPP indenting, so I was unsure what was correct. I guess I could have
> looked harder for a style guide, but at least hopefully I followed
> 'SubmittingPatches' mostly correct. :)

Yeah, the rule was only introduced rather recently in 7df3f55b92e
(Documentation: clarify indentation style for C preprocessor directives,
2024-07-30), so we're still wildly inconsistent.

Patrick
