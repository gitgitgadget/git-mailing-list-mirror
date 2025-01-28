Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1285614EC4E
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 08:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738053350; cv=none; b=nGmcGFEg9Z6SQWQ8uFKeknWrWEf+4mtRIaFP3LXqLhHXLrWdZQmDcobXcdMOpsRJ/+w2jRq9GA5kErP2Y0s8Tay1u+MSAAfnLRwggP8Jx7zAWSXc45s0iG/Y50YMjtznlCewsF69vlgRis9NemaQ3AQM08kpSrS6tmSDXOhgkQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738053350; c=relaxed/simple;
	bh=eTY6TUv3/bdt+VmKQO3gwiGJHAx6PHsbQx4Mv8S9FQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWO/jVjs27J8wcyHSdz/utSa9lXucpkw1ZXzGZofyZ8DsAoSZr5MCLUP2yH2BUUG9x3cGmor9H8zZ2eN1pcEzZ43MR1G4QWSyh3zi1s1iCUpnKCf9rnjcpOb9xLWKlOBHAJ2V0gsYT9txXHVdbhjdzLQFRv/t+jsfldlvuQUjGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R3emmh/r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BRk6Ka2v; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R3emmh/r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BRk6Ka2v"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2496F2540219;
	Tue, 28 Jan 2025 03:35:48 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 28 Jan 2025 03:35:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738053347; x=1738139747; bh=oMUeIDNWP1
	28he/SxNzQyJ4gORNgXceMxaDTfWXHpqo=; b=R3emmh/rPoz2JMeqEl8Pro+wBC
	Mz0fBRu6lXr3xzc9j1Vscp516/CkICHtCMsAl3/9vxO0VS2BLGLU8v7vur5HfHdy
	WSJYXfKan7YHkYg3zD4S8kYJdvKGTrTsj5Df42wvbIkTJnBmzVlIYVGE78F59BL8
	dyKINWUFIMWkom5PCfth9rUXOTxPSlYONSZF+YNyIPKZiZce7cMCQuYE40zNaXNz
	3VRfhMYU7w+MjcEfGaMkcmb1MnBgrfH3QfZzfhjRml8YlE5C2cyKMEWvJyy6faGI
	u+eDug7/sKfP2J9Mqa/Izkg2D8dEENNg5YjGpPzZgDkmj4WpoMAWK3jt+Jtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738053347; x=1738139747; bh=oMUeIDNWP128he/SxNzQyJ4gORNgXceMxaD
	TfWXHpqo=; b=BRk6Ka2vAG1Mnvy2w6kFDknRLOSDu+m7/7qfnzzXhcMINw5mRCH
	EV00Lg0hUsDO+rADUNKtmMSy1aRDi5QF9LygVF/hvqal0Tfr/kuhcyHNSPNBNXNy
	Xy5teYuti1Y56QLdAZ1F0Y3W3A6wnbMGUAedx9OjspNvIHbFU0Pbatd8IAKWeC1b
	5bAU8wnv8jzG0klWIzXGLD2JCPevB0M34OjVdsdf74o+TN1qKktAnLZUtEDntbPl
	wT8pVgMgKfYnCj+rZ12UPijmF2WfIlhjRZOaxmNeGZ0lsvcdhAjUeJrGZXY9++x4
	uyR9Ycn5pYFzY8r9LGXIBlmei+8I2nISonQ==
X-ME-Sender: <xms:45aYZwcLRUXz5pTkttJe_Ti4XI-m0pPKjiunMD5uLwFtRlkz1N2q3A>
    <xme:45aYZyMYuApgtAAo6agubjN05EyhkSxjp8XXqKgJa8KAW-39KQAXGh9ZB1NWvWTCE
    AN_dFx4-eG-HP363w>
X-ME-Received: <xmr:45aYZxgRtodxKceZLy_hGLruN6L0BuK3gwC36W2Uf8k4jariYTwJ7zNbtmdcybRq7QLtJ4D1gcfpnYE-WtUfHaWL-grTdRl8R8uGxAiS0jA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudehieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomh
X-ME-Proxy: <xmx:45aYZ19D5DIbXDSgrAgNawRM9cBPYV35moNO3f0jLbO2NKbn47R6Ew>
    <xmx:45aYZ8vNj3nz5dQYTPgYu6HfuGai4SwkI4Cw4iSK2WHis3zZlkxJkA>
    <xmx:45aYZ8GdKTcsSztuJEbdDTbFA6jZBLmZSPPOlLwrto5pYdNonXfvpQ>
    <xmx:45aYZ7Mi_R5LlFejblrTaZ79pnyraOF1Bf7mxu0Ji7-yYuBmBbcDqA>
    <xmx:45aYZ-I0_7yONoIBfDYskBcaC-9HcrSoESXqEDx5hCTnMEOGXwYi5KvC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jan 2025 03:35:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8d040eb1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 Jan 2025 08:35:46 +0000 (UTC)
Date: Tue, 28 Jan 2025 09:35:45 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 07/10] git-zlib: cast away potential constness of
 `next_in` pointer
Message-ID: <Z5iW4dFgSQaN0I3U@pks.im>
References: <20250116-b4-pks-compat-drop-uncompress2-v3-0-f2af1f5c4a06@pks.im>
 <20250116-b4-pks-compat-drop-uncompress2-v3-7-f2af1f5c4a06@pks.im>
 <jofg2g5hpvxq33cikq2jevqunrmmvwfqfcsjuipt5m3umz46sb@js5qlbp4jkxn>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jofg2g5hpvxq33cikq2jevqunrmmvwfqfcsjuipt5m3umz46sb@js5qlbp4jkxn>

On Sun, Jan 26, 2025 at 06:58:40PM -0600, Justin Tobler wrote:
> On 25/01/16 10:17AM, Patrick Steinhardt wrote:
> > The `struct git_zstream::next_in` variable points to the input data and
> > is used in combination with `struct z_stream::next_in`. While that
> > latter field is not marked as a constant in zlib, it is marked as such
> > in zlib-ng. This causes a couple of compiler errors when we try to
> > assign these fields to one another due to mismatching constness.
> > 
> > Fix the issue by casting away the potential constness of `next_in`.
> > 
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  git-zlib.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/git-zlib.c b/git-zlib.c
> > index 2e973320c2..519b3647ac 100644
> > --- a/git-zlib.c
> > +++ b/git-zlib.c
> > @@ -59,7 +59,7 @@ static void zlib_post_call(git_zstream *s)
> >  
> >  	s->total_out = s->z.total_out;
> >  	s->total_in = s->z.total_in;
> > -	s->next_in = s->z.next_in;
> > +	s->next_in = (unsigned char *) s->z.next_in;
> 
> Without the context of the commit, its not obvious to me why this cast
> is happening and looks curious. It might be nice to leave a comment here
> explaining its purpose.

Fair, otherwise someone using zlib might wonder why we have a seemingly
unnecessary cast in the first place.

Thanks for your input!

Patrick
