Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794816555;
	b=TUw5fSFNWcbl8ryGYa1j7W5WREFrcp3c+dHlA8Bry8pyaXsbsHqyhqXkqHF8+iyyfW3B
	 G53q/an58fIzRwfdygObrc0+kCe7NHnXc4kttBpQI9LiaIZzxQEax+YQhyw/OfxrvpxF9
	 6TGLgMgyRPy5V1IrbRmquYtxaDLK5vu+4LyBWVY8YVQC3GOVWmY/6YHxchBJmizpqWxJg
	 vmErps0GHbC5NjDH0AXx9RF3Cf/gI9gLmYZkUvPOfkAKJNx8yUL9H2nKf1btiLPelkQPC
	 PRNfM0OoAlj7SXCcHXD1j9VGtLcMK0x/lpFLio4RT/Zz/7zQjSHX1s9vOA41RTnCMgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794816555;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=pYxbaDsXonCvwiO2pWzyrLm7sMbtuoJH6Fep1Rh2xHE=;
	b=rV/eypQ/gm47OU0/X/JRcRLmsQErPb+9pb3npJHaaCRFwNYGkH0mC1S5jHncyUW7Raw9
	 EeYjBMl5wLSkOXlrIREVmz89FEq9GwaQ1dvvOTiF4WR4CZ/EkaTvUW2qOhLG2PS+5bMFW
	 Nupm79Opbm6Hl9YaOWzkAEqj60yzmGU/oLLwkr1Bu4P3aEmf49SJlQEDbbNI0hDF6x+Oj
	 JzKIvS3uwwl4RFSF1oD6Chs1YmSQkKYD1CvTGBb0G8rCe59W9cr2ThwfYbJp5RwmZaL1q
	 ydEG8hvxXLNf9TZ3filMFKDOS62VWxZnbEFHQpqFZ6JRtAxlj7AY9GaC5uTCkXfQrIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=sV6L9xQX;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=V8vcOqQg;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBFF606A31C
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 08:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCBFF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=sV6L9xQX;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=V8vcOqQg
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 49D611D0011A
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 03:09:14 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 16 Nov 2026 03:09:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794816554; x=1794902954; bh=pYxbaDsXon
	CvwiO2pWzyrLm7sMbtuoJH6Fep1Rh2xHE=; b=sV6L9xQXsRdtYZZ+3juWzkbqvf
	OMNf3Rw4ZMxdZpR1C6NBhVvtsCiiDDmJeQBj/rz0ml5DLX5N9LE+20wYaHUGjxo5
	GZBipI5y9Zm0w5iSkglMAlDPg9/l9tKRlcq03CGVC3kLPMFG4PeUa+t+n7is6Ju/
	xe3XCe21dLenSy/v4l/b2Ii9JCO/nRdMjCs0RyCP2TXgFbXYVSuY08l/G/Bg7WTe
	0vxksw6aZ59GS8PS3HrSMueVGZAFkL+S6SBSonkvwiF7lw9iCid6KGLybvMix/Wp
	OIfDfq8piEO5r7EHINZfgQrMzkZNXjUPJu6EEHfipogjul9jk23W70WAl0xA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794816554; x=1794902954; bh=pYxbaDsXonCvwiO2pWzyrLm7sMbtuoJH6Fe
	p1Rh2xHE=; b=V8vcOqQg01yLpyUwNhzqrOnXs2NJt1hZhQxbe5eICvVX8Z6H6re
	XGaGWFj0PZDfnHUYpFDf8DUhuZNMhB76yA2zOaxvn//zaujMxUzGRYM8wKGwAut9
	ubqm97dvzr71P4NOjl65JgTFtJNfkcaKsTb/e7eE7rORI/l00nqdK9cMN66wAExL
	mCxWymJoNq+9b6nNSTRUiHSY7sF97jAkPpDAElM6/H3mzhEXUN6dvpK/d3lrewxa
	WG57aZ3NEeXbnNF+wSQ8woW2zTSihJLgtrhc+nTntvCh3jOU5NoYlQAf2U/AbvyU
	3A22PMhTWChlIIkwBPtBCOgjcOowW4GDFxw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794816554; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:wHqIlJROCSh4i1p6li57UmY/Q2/4XBZ5uOID2y6GetMCtah
	TbXGubDRYOXOq8mcXLzUeWawQ2b1mLfCJx3rvGtfr4CPcK0RGDPn9pxBdjstjF4N
	/gDwmgyOwoTKGBsOXh11sDnfhPFWry387TLogPdw4QPRf1nNT37tWHswdID0nR1w
	r+wGg9KVW2r7wu30KeRCIWl98yPkZYvPljBTn+nCQBORanXo5QkH0DxzOXOKlXvu
	8KzPE+wJ3TQLaisKVEm0BE6nNd5gh/m+/GZ8cr98zE55+vPtBBHJem4Q5UMqZSz+
	FiSh52EUTUCwfGY4qrhtlaOJNPMSekPqLHYkC9A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:X2zc+K8ZJOSuz45Xs2Q6R9ILAQH/n3G4o5OEaXujpu4=:v4SSLTFYAj+fRz/CqVcet8V1LdVD/aUD8Xh3u+m37lM=;
X-ME-Sender: <xms:Krr6auuiKpQ5BgraNEsl1ZArkfWmvm2Mnp3PNsECcUFbnaPSemMFmQ>
    <xme:Krr6aqVmV3oEGL5_2hnspIGVaY2iohyEnYt7ZYzfhRy5AsDa6Bf82Y3_-gwuplWyf
    TwJ-yTZEnyQ_w-rGGp3z79lkqYKNqZn5td9U9RQQLslBZz0lvx_G5s>
X-ME-Received: <xmr:Krr6aiGFnfal2oxECej1oTRmSnP76704qxmsFF5XuAR5oC0_Y9OQccjnF0OHNvNKzQX6eWM>
X-ME-Proxy-Cause: dmFkZTFrHtYaLM0dndMiVpUnfM4AMzLuAmLeAKS/+ItPOHDbOROpn3LnEvaV7ud6ue/uHh
    6mmU0K/xYRAJQ+tmqm6CSX4sEYW4UFPwRvb/fq6QFS3ieD5JDdNUED5rPUPQ5E2X2UEExZ
    X8+KcLCzGJsNEgJ/0qbvSXwd3150tJQfIWIMD8k9+FbWMrtgRPjtUkdwqR2SVdvYgQBeHH
    VOUCy2PAzdgmtvSPH/uvJoU8WYXK2LQz2v56Ed1264ukbmVXZz+K7YsV7Ac3556x/1c+Ar
    laS9rFfrGMW+85/xwBxXDzfL9aiZWhs2OxqOuNqCnItCnJ64/j427Gp3gdhcrVESJE3Yt8
    K9yTc1D03XHxiGjVciUWNGjysW9YgA740RDKYaCykuyTFG1ubUD/JQov6UNuFb7X1Qm6hO
    cQJ24y3GpQt6Y56R+wTnlO944uLDFPpu/ykRKCCDaLY0gB9eSQSsTB7nfZCZCjRu4vSalH
    C/ED53nN5Kq3lfIy6Y1Mju1I+R20FzPIazRqLeZ+Gd3VlrKIS9flFSfirUQF1H7zlJIDbQ
    rDXW4r+mH6ZRAyGdrn3gT2WAgD7a+YLGw9et8ObYjYweYODBABNWFgWUQ1Vdl5Z4Qkj0rF
    2gOYDl256+vQZl9OAbKOFZJ7TabwUg2DHtwCgzJWRBW8f4N6/gGsh7DiNy2Q
X-ME-Proxy: <xmx:Krr6ak1_umR4mSiKgVBSFt3nbR63CUt59bwN7HTWHLH-XqNgUAUuTQ>
    <xmx:Krr6asMe2cey5_7XUF9mKPNYjF1xQ4SQj16KRVHgbgUVG2cOlgw-bQ>
    <xmx:Krr6ar6k1aIl6vsbRJxrKXU6AGS7mw4g5J03KjgVR1Xs86SlohY3Zg>
    <xmx:Krr6au0gW0AvC_ZjWtGn6MruJDfC2sGJgp1whFUrr5HksFo4pJk-Tw>
    <xmx:Krr6asEjx9i3QDndKi_CV5v6MmB4yVSyvhFwukHkNTCexUmFoXo07O10>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 03:09:12 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5d62887d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Nov 2026 08:09:11 +0000 (UTC)
Date: Mon, 16 Nov 2026 09:09:07 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Andy Koppe <andy.koppe@gmail.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>, Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v4 0/5] root refs vs pseudorefs
Message-ID: <avq6I8J2DGXRzNWl@pks.im>
References: <cover.1794000450.git.andy.koppe@gmail.com>
 <cover.1794520948.git.andy.koppe@gmail.com>
 <xmqqzevdfyn1.fsf@gitster.g>
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
In-Reply-To: <xmqqzevdfyn1.fsf@gitster.g>

On Thu, Nov 12, 2026 at 02:55:30PM -0800, Junio C Hamano wrote:
> Andy Koppe <andy.koppe@gmail.com> writes:
> 
> > Changes in v4:
> > - Glossary: stop contrasting pseudorefs with root refs, mention
> >   remote-tracking branches in the "ref" entry, and state that the list
> >   of per-worktree ref prefixes will not be extended.
> > - git-ls-remote(1): describe what is shown by default, including
> >   peeling, and describe --refs and the example in those terms.
> > - gitdatamodel(7): mention the root ref naming rules, and drop
> >   "so-called".
> > - Reword the description and error message of rev-list --merge.
> 
> What I saw in "git co ak/root-refs-vs-pseudorefs && git diff @{1}"
> looked all sensible.

Yeah, agreed, I think we're hitting the point of diminishing returns by
now. So from my point of view this should be ready. Thanks!

Patrick
