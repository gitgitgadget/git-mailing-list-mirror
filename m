Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FE37483
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 00:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731890381; cv=none; b=EwveH2WRmhfNFVcA7/QriZD0cNw9cYErpbOM7S3mLrFAMkL03lEj2/ymbC+KnpekEqO/RBnDRh9dIn7k47NH0QgkgaB/jA775SZQ8cydCA7ZCM1Mj2t75I8qZ21U6Lf/mxVoFSQLQ2nV4QAB91zetJiL5E1dzJ+5n+FiAI/e1KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731890381; c=relaxed/simple;
	bh=u/vUvtEOzePIEZHgagK6YoV7ITHLnrA9kKM0s2vdm8g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E9i0K1ngv2s7/8P2mV2NHVfXtF/u/9YLNxHoGqqcSWICPTt6j9LH+LgcvHLOIJG7CTLhVZpvUi2T+8vmrzmme9Pcx4+WNSABBAzGYfzil3AV1LIhs/wPAgZ3gLd7ofBohVhBVG43LUv4U+SWtixPW8PKD1ZiJ3yc8Kw7rgQ2wgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D9FXgFyE; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D9FXgFyE"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 8640D114011F;
	Sun, 17 Nov 2024 19:39:38 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Sun, 17 Nov 2024 19:39:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731890378; x=1731976778; bh=FVXgjOEaP0riw3oSl4xjBGrzxrIoxeXxZLL
	9PKOhn+o=; b=D9FXgFyE5QDKSGAVD7s0+X2sOk8KIQCPLCSYwZNXMojOk9agoLl
	GE6I6j7gcOd4wETc+jPO9Qy6cJB47Du7v0SGd9X6Nx0hPar4HlIAqeR6tHe+U8SD
	IlbrPlGsR6acasiscOx+RjOc5msPWgq6aIc+xbko4DoSkNUrac6yrfY622MnS25J
	GWjSfqk5b1PSWkXonhuh+95ajnluQ1kIyyyb9By+V75WI2bhVKh2NTFt6zouBIvn
	z+3FxS61c20NzNMFyIzp6RZHozoITS6dSeoy/jj5BoHKclW+9ujZ2X4ouaytTaz6
	0LQDsuWYfC37dChl3xJjjWXD3PikCuLanpQ==
X-ME-Sender: <xms:yYw6Z0W3_0p0nVnA7b1S-bZfBWoAkNFzQlIgjpO0WpkMBa8X7wxUHA>
    <xme:yYw6Z4kiG78UlVt4X9-M8ccz3dvTXTXMB4aZmnhe24WFD2o8Bb279dpy03L6HaXWV
    PByCcRZr9exgILiFw>
X-ME-Received: <xmr:yYw6Z4YiQVtIhmYxKixOSMUwi1QvKwbST6-3x79XHXHTP9NzGi1GBDVsiBB7U3I0KhhoqFwlJS2Gklj3IiFfnclD-h4tB4mmVbFM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdelgddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfhgvrhguihhnrghnug
    ihrdgsvghntggvsehtthhkrdgvlhhtvgdrhhhupdhrtghpthhtohepphhssehpkhhsrdhi
    mhdprhgtphhtthhopegsvghntggvsehfvghrughinhgrnhguhidrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhi
    phdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtoheplhdrshdrrhesfi
    gvsgdruggvpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhm
    gidruggvpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprh
    gtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:yYw6ZzWDK6xxAu7m-9skWhspZBPztqecKF0NDG9W4SdkR0hMMtrxng>
    <xmx:yYw6Z-k_iI2NAXiaWB6B8GM7NVV7yjPOrhO0gMBt58eoqVxUPtrRkA>
    <xmx:yYw6Z4coISZnaVtQntI6sludV9WHYjqDgbP3SavmVip8nPc2IfQ_Tg>
    <xmx:yYw6ZwEdmeeRs7sXl36hYsV8k0oDutZPBkNLW7qap6Fl_fTPEbqMew>
    <xmx:yow6Z3eeEubTb1LWdovpxtEWHLG3-_VD8oxeAU50BQ-mpQnt1X94kgg9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 17 Nov 2024 19:39:37 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Bence Ferdinandy" <ferdinandy.bence@ttk.elte.hu>,
    Patrick Steinhardt <ps@pks.im>
Cc: "Bence Ferdinandy" <bence@ferdinandy.com>,  <git@vger.kernel.org>,
  <phillip.wood@dunelm.org.uk>,  =?utf-8?Q?Ren=C3=A9?= Scharfe
 <l.s.r@web.de>,  "Johannes
 Schindelin" <Johannes.Schindelin@gmx.de>,  <karthik.188@gmail.com>,
  "Taylor Blau" <me@ttaylorr.com>
Subject: Re: [PATCH v12 2/8] refs: atomically record overwritten ref in
 update_symref
In-Reply-To: <D5OUMKNX6UU5.23Y4V7NHKGUWX@ttk.elte.hu> (Bence Ferdinandy's
	message of "Mon, 18 Nov 2024 00:39:43 +0100")
References: <20241022194710.3743691-1-bence@ferdinandy.com>
	<20241023153736.257733-1-bence@ferdinandy.com>
	<20241023153736.257733-3-bence@ferdinandy.com>
	<xmqqr07d11wt.fsf@gitster.g> <D5OUMKNX6UU5.23Y4V7NHKGUWX@ttk.elte.hu>
Date: Mon, 18 Nov 2024 09:39:35 +0900
Message-ID: <xmqqh685xtmg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Bence Ferdinandy" <ferdinandy.bence@ttk.elte.hu> writes:

>>
>>>  	} +	if (referent) +		refs_read_symbolic_ref(refs, ref,
>>>  	referent);
>
>
> So I've been working on detecting a detached remote/HEAD, and it seems that
> "refs_read_symbolic_ref" behaves differently for the files and the reftables
> backend. These are the exit codes in the various states:
>
>
> 	     reftables files
> detached	-1	 1	
> doesn't exist   -1	-1
>
> I would assume this is a bug in reftables? At least the behaviour of files is
> more useful for this case ...

Interesting.  Patrick, comments?

> This now works fine with the files backend:
>
> 	if (referent && refs_read_symbolic_ref(refs, ref, referent) == 1) {
> 		struct object_id oid;
> 		refs_read_ref(refs, ref, &oid);
> 		strbuf_addstr(referent, oid_to_hex(&oid));
> 		ret = -1;
> 	}
>
> And 4/8 can now also detect being detached, by checking the return value using
> the test you suggested, but this fails for reftables. Just in case it might be
> something about the test not being correct:
>
>
> test_expect_success 'set-head --auto to update a non symbolic ref' '
> 	(
> 		cd test &&
> 		git update-ref --no-deref -d refs/remotes/origin/HEAD &&
> 		git update-ref refs/remotes/origin/HEAD HEAD &&
> 		HEAD=$(git log --pretty="%H") &&
> 		git remote set-head --auto origin >output &&
> 		echo "${SQ}origin/HEAD${SQ} was detached at ${SQ}${HEAD}${SQ} and now points to ${SQ}main${SQ}" >expect &&
> 		test_cmp expect output
> 	)
> '
>
> Should I fix the reftables problem or should I mark the above test as a known
> breakage? Can that be done for just reftables somehow? The only problem
> reftables suffers this way is to incorrectly report "creation" instead of
> correctly saying it was a detached head.

Thanks.
