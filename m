Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1130833E373
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 09:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769161382; cv=none; b=YCt01WUKK9WFp5IUVIpbbvShe77g830459jB4TC8G/HlcfBge5dr7Ucug6SRS4l4r1exilES/exI3C5zTiD+xiHU1CcxjZRcgOQEnHyQk1ivCkA1BTscr5RXDGbempGpl1m4XNUW552pWjhNHxl66G9gDJNMZbIOSgVUiXUKdd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769161382; c=relaxed/simple;
	bh=y7vJ3ugOyuU9+LIV7CTQM/xU0GVLCoats6fGJLY6VDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOYjXEpAmwA1TFm/BwBfHsuh3bOMjag9n+FOsnAS8dqyNknrWEREJDvPQob49gj4Uqd/ZSqg77jwXw5jvp4TyXkLjCHZjSge7EXBjBxNsqVwr76G+OUeVCBHbAf+NARQU41KMPyW0kM08FI6ITJm+xmQjxmG/sGSnZWYQ6zudbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=h+l3hdz9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e+z3V+6R; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="h+l3hdz9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e+z3V+6R"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 15BAD7A006E;
	Fri, 23 Jan 2026 04:42:48 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 23 Jan 2026 04:42:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769161367; x=1769247767; bh=vvc8m3PQLB
	xwivyHKjh+tW93RehiTuF7OUGxM5mDZ4E=; b=h+l3hdz9MRHKojH9tBnWMLlYgR
	ybP+rwPSHeZ/vq99GuGAFXZ5Bs8M3onv5eK3ZiCZDLuRpy2JOYsl/zFYn/EDUBop
	esB3y5PPm+HmtBY/jeV9a4CFV+X8Un3B4tbgkcTV2Ts9n/Iskd/VwlunSM/K+WTj
	ZaG2qylzXm3m+n2H9uM6eF2TSDLK3nXBVKoNz00RnH41O/lLtA1pfJWbbYePbUbj
	sWmHJSjjn7+pn2D3WznTms927Pn7SkDm7/7mGq3/XQK9EPsnoWc7//L+eCAD2EUf
	XHwKfffwYvMFXPCUxC12A3UDjJ5Zxov+qcWs+i3d2xDH09WYsc2/kGSOWizA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769161367; x=1769247767; bh=vvc8m3PQLBxwivyHKjh+tW93RehiTuF7OUG
	xM5mDZ4E=; b=e+z3V+6RUCYJUAAuQt1NEsxY9EDcQRcFgjhAkfsoR9lo+JgAOmW
	AcN+Bolh76jxsP8XAsWAh5jB1Znkntx3Vn3GDoonfLJyV/IXSXGPOfEFEFBAXEp2
	Y7BhwdNODmz7uybcOz6l+bKMxsRKXj1rDfqX8x6t4Qo+aF1sTI84gd/FRevwrp2G
	4UtsR+ZsOHEcCYcatl/qNI1xTE2rDMcuVbqi22DpBlq1++ScTsgDJgpVY4Mv5xan
	6+DLJXQxyshB/CCkhtQR1L/cnuhF1ZHiyRXKaypcCvYvCaNv0WFGl373jM45U3LW
	mfJxI2nc+4lWEp1XpT0dZoV/Q3rOGBrZBzQ==
X-ME-Sender: <xms:l0JzaSDNjX6L_EBy_1LlgVslY1ib667VZT3YacCZYt4sDjVbirXyjw>
    <xme:l0JzaTb9Vz1etGG56Hjl_Gni9F2wWiBm1mcNIj0Qx8RN8dzVJGPm9zK-JXqX0mtP1
    jHsaMgXMqF-KrbiPI0MJXG6W_kBVaQjImiaup2GeEu92yvAX07adhA>
X-ME-Received: <xmr:l0Jzad7mzxB-VlGDDEsuD5cqorbUtUTyVl_jhL41XJQLePZ9m3rVSkJniRPiW4S3ZQvoTUGD463wmph6l5Cx_jwsYxx8o7P7FF6ZjfmrGzHz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeekjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:l0JzacbqOdBbbRUUvoXLNgjkWIIQzikcpXyxvw1dm7gnhwMzNJQEYw>
    <xmx:l0JzaUiXNAlXupcAoc7igZHPbEwa8HhhpHTmRmYEpLx8VlrdRcUmnA>
    <xmx:l0JzaV9zqxWWSwAfmzQsqAfIHIvtoOaCDkTzKMflSTq3sdLwMjEb6Q>
    <xmx:l0JzaXrBdFfE_zI9SaAymDK72phDXWGSrzUOyH-H_RZb0hR4Y6Lpqw>
    <xmx:l0JzacxdKtQ0AXvAQD4Kk5modZ7YnMp2euEi9E2eUzByg9CPiCMobaWI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Jan 2026 04:42:46 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2f8ff044 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Jan 2026 09:42:45 +0000 (UTC)
Date: Fri, 23 Jan 2026 10:42:37 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 06/14] packfile: introduce function to iterate through
 objects
Message-ID: <aXNCjT6Al-4YLah5@pks.im>
References: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
 <20260121-pks-odb-for-each-object-v3-6-12c4dfd24227@pks.im>
 <aXK7cSJW2syew89a@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXK7cSJW2syew89a@nand.local>

On Thu, Jan 22, 2026 at 07:06:09PM -0500, Taylor Blau wrote:
> On Wed, Jan 21, 2026 at 01:50:22PM +0100, Patrick Steinhardt wrote:
> > Introduce a new function `packfile_store_for_each_object()`. This
> > function is the equivalent to `odb_source_loose_for_each_object()` in
> 
> s/to/of/ ?

Hm, isn't "to" correct in this case? The remainder of the sentence reads
weird though.

> > that it:
> >
> >   - Works on a single packfile store and thus per object source.
> 
> s/thus per/thus/ ?

I'll also rephrase this a bit.

> > diff --git a/packfile.c b/packfile.c
> > index d15a2ce12b..cd45c6f21c 100644
> > --- a/packfile.c
> > +++ b/packfile.c
> > @@ -2360,6 +2360,54 @@ int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
> >  	return ret ? ret : pack_errors;
> >  }
> >
> > +struct packfile_store_for_each_object_wrapper_data {
> > +	struct packfile_store *store;
> > +	struct object_info *oi;
> > +	odb_for_each_object_cb cb;
> > +	void *cb_data;
> > +};
> > +
> > +static int packfile_store_for_each_object_wrapper(const struct object_id *oid,
> > +						  struct packed_git *pack,
> > +						  uint32_t index_pos,
> > +						  void *cb_data)
> > +{
> > +	struct packfile_store_for_each_object_wrapper_data *data = cb_data;
> > +
> > +	if (data->oi) {
> 
> Interesting. Is it the case that if the caller provides a non-NULL
> pointer to an object_info struct, that we will reuse the request portion
> for all iterated objects, updating the response portion as we go along?
> 
> If so, I am a little uneasy about the potential for us to mix portions
> of the response from an earlier object with a later one. Skimming
> packed_object_info(), I don't think that we are in any immediate danger
> since it overwrites all fields in the response section. But that feels
> somewhat fragile to me, say, if packed_object_info() were to at some
> point conditionally assign a field.
> 
> I wonder if we should split the request/response sections of object_info
> into their own object_info_req and object_info_resp structs. If we did
> that, then we could invert the pattern for providing the response,
> filling it out ourselves and then passing a pointer to it back to the
> caller via the callback function.

Yeah, I agree that the current interfaces we have around reading objects
is weird because of the mixed in/out behaviour of `struct object_info`.
I didn't really feel like changing it in this series though because it
would lead to a lot changes all over the place.

Maybe this is something we can do as a follow-up?

> TBH, I wonder whether we should push this onto the caller entirely. If
> they need to make an object_info request for each object, is there any
> cost to having them do that explicitly themselves?

There is, yeah. The nice thing about combining iteration with the object
info request is that we have more information available when reading the
object info:

  - For packfiles we already have the info where exactly the object
    sits, so there is no need to do another search for the object.

  - For loose objects we already have the path available, even though
    this probably doesn't matter too much as the path is trivial to
    compute.

For other backends I very much expect that we'll be able to make use of
similar optimizations. For a remote database for example you could craft
the query in such a way that we yield all objects with the exact info
required instead of having to perform a separate query for the object
info.

Patrick
