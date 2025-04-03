Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D95619E96B
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 05:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743657030; cv=none; b=Qf8ercx82MbWy4WEPwpa9oQgz/xhoxqACXAQ6fpskFlaNAT+llnMqRI1YRNTgptItHd3LQJBIdIT/pwja9OP47sIAECZ/Xah+hu7S9g1vD4lxDHQ6fUS2Oy+qrkYOtfZrQWTw78nNr+PU0zIH0Dy/TQnv9P+GwxDbg2EpdmO14Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743657030; c=relaxed/simple;
	bh=w7qbKRJIFuxLRnI25YGHKfeCfGHUHEyJmEhwzm5NAZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwaJqgQXPeG6poJUrWzksdQTcndjHHypWjgtLtGSgRZ+oTnnd7ucuhCrrKFi44zfX/2BxFvdOZfs/c0UXflt6R03uTEJl2yGADm66z3SyfU8VuAgQdwTvvFCDex5Mg9NMpgS3eB71ai5VUwU+f1A39t4/YoIAHccRRRkYqUiQNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=U6jv6cUf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iRabAvxe; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="U6jv6cUf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iRabAvxe"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 7A57011401AC;
	Thu,  3 Apr 2025 01:10:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 03 Apr 2025 01:10:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743657027; x=1743743427; bh=9aa4JgjwBT
	Eru/7MjZ+5qo3ytb8cgiXwUpJkPDJUSyo=; b=U6jv6cUfKcUKN3GLlkWC7WC9iy
	9p7G3RYKc8AEhbSvyA5DzeHEC+NHBR0QVDszFJ4HE8rIMv/cnHxn213z5GvNh7Sy
	UUDsjKRJ6hKxoTq63fnQrR6cVVvVVwnzvHjsqA1CTLVm+MDWNOGXra+1JgaD8oSw
	ywMKD7cwYg6NUXlXuxw4TsQCwo87HYXXW473vQgHh+O2gVlCHpoiUiO+jOee+QZ+
	Zg+OTDGwtXysu8KGytNIQXgaXbSBVEANwVoR87q6QYMQP2QrUQoJqHKYwJs3sHvs
	3s/hYBzR6FtuZpxEqwAFXnZVDi6f02u6Rul9L2aUXMt0R9YfMN/eojJ78+Ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743657027; x=1743743427; bh=9aa4JgjwBTEru/7MjZ+5qo3ytb8cgiXwUpJ
	kPDJUSyo=; b=iRabAvxeWE+/gveIKqR8c2SCwv/LMScYl18mHKZH7J3gISDc8Ba
	DXmIuR1kPSdo37SszyvQlw574wk0Kkh+pcGeAoPJyJ/Sqx9xkLNDtkb0rxNmXV4J
	eeWhas2ByI2hz+QnfrbybQwyMn/Qoudh9EkHwKrzgpVAkMdCj8L17oqVywjcaMoF
	kpOdEm/HBGF5isl7NsGTL3LSN++P0mCuKTs02h311/mgbh1cOwPdCzxF2Luy17rH
	8ToD/KWeKpLZHQX+9SrUzPG4ZHMRduqhwZLIhqSg6YE+BLHspHn/STjBPUTvVBl7
	/bpyq3dXxtL7sY5rjB1506NMkGcJVGE4TIw==
X-ME-Sender: <xms:QxjuZ-ChD9t4cD73m786pklRygNwvISvvYBXahDla4PstMl5ctG1NA>
    <xme:QxjuZ4hIjRP1EGiwf5hXrh3af02_Q6775RQySYSLNrfd5_hD5p3-b3YionhWR5pOJ
    1Xj9Y5Uon0eFt_d9g>
X-ME-Received: <xmr:QxjuZxlqEgccyUl0wsnfCyuYrH8hVckvE55cu4rO-tTQ-r36ohmvKx0KY1tIuuSfhWkU6xdkuQ18DHty6wqY_1h5ifArOkLGF7JcQEicFKqplbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeejieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopegt
    hhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:QxjuZ8wOGVDjwo9kltk2bVsHIFZW3vLgIsR9LbEq4CrqIeKeQC2e0Q>
    <xmx:QxjuZzRZSmYTSggX4uBmhLuhARVs8nAyxse2etwA63yzwcUHnEQ7WA>
    <xmx:QxjuZ3ZPoy6H6OLNjGKK8-p7fz-_rD78jFfXUPXmW4CFZNiXYbPB7A>
    <xmx:QxjuZ8RqUpydITPNPNi7D2C9MzEVGcw6icTZPcLHQsuGI9_b-uIxnQ>
    <xmx:QxjuZxay8rCGjKCcZLTkb_NnsM0qshbjvtuuT_DfU1oTNqTs5LJUoEMG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Apr 2025 01:10:26 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 03b7e4c6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 3 Apr 2025 05:10:24 +0000 (UTC)
Date: Thu, 3 Apr 2025 07:10:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com
Subject: Re: [PATCH v2 2/2] help: include unsafe SHA-1 build info in version
Message-ID: <Z-4YP5ppG8Jnrt3z@pks.im>
References: <20250328170121.157563-1-jltobler@gmail.com>
 <20250401203630.285451-1-jltobler@gmail.com>
 <20250401203630.285451-3-jltobler@gmail.com>
 <Z-zpau_DsOGVVtjj@pks.im>
 <46xnrbtafdg2iafownzujbpzjuygpns4g4r26wzxxv6xmi5mg7@m3dw6cfk6f7q>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46xnrbtafdg2iafownzujbpzjuygpns4g4r26wzxxv6xmi5mg7@m3dw6cfk6f7q>

On Wed, Apr 02, 2025 at 10:59:16AM -0500, Justin Tobler wrote:
> On 25/04/02 09:38AM, Patrick Steinhardt wrote:
> > On Tue, Apr 01, 2025 at 03:36:30PM -0500, Justin Tobler wrote:
> > > diff --git a/help.c b/help.c
> > > index 3aebfb3681..1238a962b0 100644
> > > --- a/help.c
> > > +++ b/help.c
> > > @@ -772,6 +772,11 @@ char *help_unknown_cmd(const char *cmd)
> > >  static void get_sha_impl(struct strbuf *buf)
> > >  {
> > >  	strbuf_addf(buf, "SHA-1: %s\n", SHA1_BACKEND);
> > > +
> > > +#if defined(SHA1_UNSAFE_BACKEND)
> > > +	strbuf_addf(buf, "non-crypto-SHA-1: %s\n", SHA1_UNSAFE_BACKEND);
> > > +#endif
> > > +
> > 
> > Should we maybe print the equivalent of "none" in case no unsafe backend
> > was selected?
> 
> It is suggested later to rename "non-crypto-SHA-1" to "SHA-1 without
> collision detection", which could lead to something like this:
> 
>     SHA-1: SHA1_OPENSSL (No collision detection)
>     SHA-1 without collision detection: none
> 
> which could be a bit misleading IMO. It might be best to leave the
> option omitted if it is not defined.

The problem of leaving the info away entirely is that it also makes it
undiscoverable. Anyway -- I think it would be nice to always print this
line and improve the format a bit to make it less awkward, but I won't
resist if you decide to leave it as-is. After all we're already showing
strictly more information than before, so it's a net win regardless.

Patrick
