Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257F52080DD
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 07:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743578189; cv=none; b=h6rAvcVYcKOJqL7PqkER5dRjLH5Oqdl96E5e1YQXU/HW2LbhL04aY5dklU2n5KiFZ0Gv0eatWehPAuWk5vcTkDcDjk+Qv7pfFCUJkLXLrEB6Wx2RnXZ6yfwgxQ0F95ge7JwRqJmajemZZ8HnsedzWhGpb+yHJQsVmoKA994zxZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743578189; c=relaxed/simple;
	bh=A1pbY33tbEb98wIH/P+N9R/vDyQL6zORq34L9Zk031Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XbckurjT+MbXCcFkU0GeeRVQiqW+CfPTb6CwJ2uAqOaJGEbOSi+o145CtAo0BYE6PQmP59nhUeDTkMPHNEvgOI0go23PRVyxdRvQTzXOE6SYUuRPoNzc2MNkqM9IAv3sx+VYMe2xZ+Cdk7F49QoMzf+aKn/A60jmfCN35RJTlGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VuOvxTBg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lvVy1Ii0; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VuOvxTBg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lvVy1Ii0"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 681D425400E5;
	Wed,  2 Apr 2025 03:16:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 02 Apr 2025 03:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743578186; x=1743664586; bh=iZaKCfepwT
	OHfpGw2pm6oXgV8urY7+PemQ2hqV8c2/A=; b=VuOvxTBgOr03ACy10dcfNDlGxP
	NWfMeTm08B9rPuJFByO89b2IbXTtJnfzwwHse+69STlzyYWtBlQPfZ2dUIjBt+Fc
	M4gA6TT+BSP4FxjwDqLCp1fEyEVGIV1xf4q79GjbRlW494Rxt9/IV2FYw7BUCLCv
	yMV0OQCg67HRM+qtPrC1DHa3GWvkjeitgSuaKuhN8n66lZghLlp1amh5Y5hxQaGU
	KG24KhEVjLZ0l51Q+IO+7rrNO85IyQHwTuh0BPxI8CXKkBS+lCFJH9yZcbPLcF/+
	WZLIkeYPV/1Fte14SAnCOuTSDVWyMOsfCUqKAA1ycEydjEFuV2HXyFBk2w2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743578186; x=1743664586; bh=iZaKCfepwTOHfpGw2pm6oXgV8urY7+PemQ2
	hqV8c2/A=; b=lvVy1Ii0uKljuM92Z4pWck/v0ozuC7jKZ8cCmzbR4sRXlHj1ybP
	sjYQRbW4TjOlBV07RvkGAUq4gToL36ERvBnR1l74kZSSqgcrikpy4Po6C9+5GGSp
	3/ft7zwusCBAsrpIN5iZFWB0LpJE3QLTZk+3x+KJO3RamAkX/S2Y2lsPXZcRTKEL
	HXYJeKKlVOsfHzg+ZyB31dafIMk66NfNOF5Yee/3rgQBEuezJwRH/mc++rY0KKKG
	bfYe9QsFKYepvuKLPR/iDHXxxNh2+I8g7E8pFboP/b2UJXgxEtzKLkKgyR/N8qGc
	/osseRWkCbJz4HyLKK/xEegBj9B1zaq8rdg==
X-ME-Sender: <xms:SuTsZ49_dBXmSaulZafmQpSVgOKkEmoMPWeJzC3bdd-9Qaq21-7g6A>
    <xme:SuTsZwvm_q4Lbh_IqzRp4soRl_r6K2fnPZDGsriODX1QeM0E4bK2kxNXgnks0MZBr
    icuPAI4dmFWI-VZOA>
X-ME-Received: <xmr:SuTsZ-AsuhgE4ifJHn3nR27XJfk_4h_B8ZRG6ymMcyiEziS5JoBLEtc2-RaqL4os414wzgLQhEzV0-RH9yR7PCQzYyyiQNuGF9nEAPtaI6hgPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeehtdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtoh
    drtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphh
    hilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgr
    nhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:SuTsZ4fH-a46h3-GMFB1K3qsgQXeOBpxgIpsMDU8lMoSOYSfi0FzHw>
    <xmx:SuTsZ9MCVShaiPhQsbeu3twxUOpDHPcvh_okQzVdCdIAojF85jOokg>
    <xmx:SuTsZyliJqJwiWyKoVwE-TFGR7IKQkvnMMaH63y_iNlf-5J3Q0pZYg>
    <xmx:SuTsZ_sy8gQsFZ8l2PFToIc8pfv0QLJ63axEa3U-RdHoXfXK5hHxiw>
    <xmx:SuTsZ2HdIColVag73D97b8yGCdmTzZMji-m9X9hiIxZ34XCB7bhsUnpV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Apr 2025 03:16:25 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f63d1526 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Apr 2025 07:16:24 +0000 (UTC)
Date: Wed, 2 Apr 2025 09:16:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 11/20] t: refactor tests depending on Perl
 substitution operator
Message-ID: <Z-zkR_9CCVA57wKV@pks.im>
References: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im>
 <20250327-b4-pks-t-perlless-v3-11-b436de9da1b8@pks.im>
 <70026fe9-8c99-ab00-531f-1556db63b0d8@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70026fe9-8c99-ab00-531f-1556db63b0d8@gmx.de>

On Tue, Apr 01, 2025 at 08:32:02PM +0200, Johannes Schindelin wrote:
> Hi Patrick,
> 
> On Thu, 27 Mar 2025, Patrick Steinhardt wrote:
> 
> > We have a bunch of tests that use Perl to perform substitution via the
> > "s/" operator. These usecases can be trivially replaced with sed(1).
> 
> ... and sometimes `tr`.
> 
> In fact, it looks like...
> 
> > diff --git a/t/t7508-status.sh b/t/t7508-status.sh
> > index 14c41b2cb7c..cdc1d6fcc78 100755
> > --- a/t/t7508-status.sh
> > +++ b/t/t7508-status.sh
> > @@ -1064,9 +1064,9 @@ test_expect_success 'status -s submodule summary (clean submodule)' '
> >  	test_cmp expect output
> >  '
> >
> > -test_expect_success PERL_TEST_HELPERS 'status -z implies porcelain' '
> > +test_expect_success 'status -z implies porcelain' '
> >  	git status --porcelain |
> > -	perl -pe "s/\012/\000/g" >expect &&
> > +	tr "\012" "\000" >expect &&
> >  	git status -z >output &&
> >  	test_cmp expect output
> >  '
> 
> ... this change is not about `sed` at all, but only about `tr`.
> _Technically_, this hunk would therefore feel more at home in the previous
> patch. But practically, I actually do not mind it being here at all.

Yeah, the boundaries between commits are fuzzy at times. I mostly wanted
to split up similar changes so that the review load is somewhat
reasonable and not have a single patch that does it all at once. And
this site here did use Perl's substitution operator, so it's not wrong
per se that we do the conversion as part of this patch. But it's of
course wrong that I only mention sed(1) in the commit message.

Patrick
