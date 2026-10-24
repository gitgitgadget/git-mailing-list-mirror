Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792807587;
	b=i2XeIJNHKEs8HqGUy4DELR1OxSaa2CiiXOuDQKrZx15Ql2rYuc+UICkM9zx26y2O96mS
	 to+WyrfQATKkxd/ElG+7LqQGWfeC+TMjCZIZCN6Wh8sx1diHL8KNJK3sFVIuecQBXggL4
	 rROibq3iHjdwtRQAe/YkHWffk1P/r54wwJ1yvwDmu4ppw7Xs7kSI7DsY1yEDm7pqkQhrI
	 vqYGXc3TxtqqY7va1yh4lwIl37v3GsAWN5SLCEH5tjfNmg0fEazN20cWmSNdJ/uIKrYOq
	 EdGbXEY+fBhE3nkw3FBNKRYfOqmS3l0kb5SdTJRQ6gF9bkF9BlP7XN6A/bATCFrj7Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792807587;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=Rqx1Z7ikwtT924owwLN5G//kSDojEZ2Zd1EJxDoLVxc=;
	b=yqXsuWCkfpMlzXvlvwzfNzkI3Pjt9x07Ls8mW0G8LAOu+rzWCjSA41bP71FZ1SxS3aW0
	 EWYQOFYzFvwWS+DtRggGBUxLtF4vEAkfEBfbQ2HaK0FZkMU9Jm8GX+56gkFXR6YHMrzHe
	 tzVVyTlMONCVvxDwFMn0CvjlLw6X2nvaDIwtAy4SusLU3Jde3ABYskNL7tTf5vjGZu/gd
	 kXpa1YeYTGMmxF7OssGevS6ppjk4xzFI/tC4K6O1PLkmXLgLabMZNHjKmMOeeXrzbFETW
	 cgmAFRVoz6cFUvjNSSMxtQPYWNa7xcHe1o+xJgX38PTUrTK41vzJLbM12WC0ijT4slw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=U69Q6iBN;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=wihivF2P;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECBE606A31A
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 02:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BECBE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=U69Q6iBN;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=wihivF2P
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id DE574EC014B
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 22:06:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Fri, 23 Oct 2026 22:06:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792807585; x=1792893985; bh=Rqx1Z7ikwt
	T924owwLN5G//kSDojEZ2Zd1EJxDoLVxc=; b=U69Q6iBNbOTWcynuB80RVteWrW
	5CQ0IHZRUGxnQ1XqFwb9PnRQKfrA9AoD5Qg1oz4sOhZhxDkN0+0a52WuzLtKevil
	DX79LJyN5keml3bPCVZrkzgmoLqHXxh8deDTquCKgq4azKnAiqWapOfSU0wh3A75
	zbrMsCfc+1YE0HA9zgkAF4c/ZBYzQJ/jXdNoPKKdNWd0VoCn9DJnNzwX4VV8eA8n
	+unlEltkcqKpFIl3pCjuyPDOn/an9jbVxrfLEQqc/WC47HFBuVy9xopZh+PFiirm
	bBm6Os1vXnTZVHWpLJo7ZgbUBAZUXlZxGo7ezbZ6n0hAkA8pJJHj7JD7b/wQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792807585; x=1792893985; bh=Rqx1Z7ikwtT924owwLN5G//kSDojEZ2Zd1E
	JxDoLVxc=; b=wihivF2P10kLOm2i/pDFr0joq+TjtzHSMTphEla5NDNtNxDFRXN
	zfvplW3xYh1SvhyHCx0Is371Oe0AZAEJU09FwcQahV5DRVwkCKLX5Fhhj6JUIdcB
	NJ32wKQ/NHE/bHq5vuFTTHEy1mL8KntyxVKcx2A+gl6I33jVmg7jkFFhtc+upCFA
	8ml9/OzeIKH79wQrrRxfkNLil7hn1ZsXqeJGjmikIdAIPX0V+7B7Fug2liktYKe7
	gF/2+Sn7w+bUWqHaO5tagvGZMet9LVs/wVkN1yaJTvHHr6hbtSbg+GlVK4xbjxkv
	zyMfr34PQyMU45T+93OJqCM/WFlOOqct1TQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792807585; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:TSqWeqgIaXrSiGirVzj3iKFoh/qjEqM265Pm2spE9SgJpiw
	mqW6cHHEBWh3NvA5MQgIDbOqZtsTHAAu3TYI6z1cxRJkGoKB8BPBxJYxLRcsoPXu
	lbaFVTSKsW16Np8IlXHcd+BwU7lQdgXTVJi15sqkfPJJO5dV3dN/UiAazd0U1Ips
	9Avjq/h3e8/YbNHyO35v3qHlzPQ5S4DFNM7zSk2tWAfjcuAUz5r4RB2koIkUimq3
	KmX7741R99PKBIbGCX9YrlLKD8gyf8aKiWnHOpR8RFlcreVX5xtUEptEishUz/3/
	JdN6TdvNDyXds+JJNgzWcQhJ/A5gPDBQ0fP1t6Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Of4nmQILKKsNyidbktOHZrXm+dD1ynobedcS0jSwQjM=:Rqx1Z7ikwtT924owwLN5G//kSDojEZ2Zd1EJxDoLVxc=;
X-ME-Sender: <xms:oRLcagWOcmn-rwI6k2eYlpc4xg1rvVKsUYOIBQnor3hH1RWxO_Xlow>
    <xme:oRLcagZhLNE7QSEal_QTBAEFmVp_GzWCG8vuAYLZBDyUoeIJZLKMVixLPgEJR05n9
    8zPD6QtgiXAk-YxI6mpCn6YzaoRpbVKzJE-zex5MVK52kLm4yUxRsc>
X-ME-Received: <xmr:oRLcavzs6Vxj-zXWV7tM5vE0WCQtW42KPp0Rn3Qpq_ngt7emKRSEKAidsMpzMbCRxHHZGCKF7wHIsoAO9EvnljjhBAIvXCrxV4m8>
X-ME-Proxy-Cause: dmFkZTFbLDDMi2OUPpyPZbvk+uYrzCsQTLd7/E0A1JL6pZgUhfe1LMz0mp7e2R59eOwmxq
    5qwjdI7q1GdvZr5cbE8FgCnhEemQNBlUlthEMZXFfdQlozNoNlVnD8rpzLUISxfJSxD+tk
    u3c/01TuZVnu4gVmHFxjGD7HTjHyzQomcu6ts9EfpqJtNvZEhpmmpwLLeQmgMdnJbbW97s
    nTP3bSiCQHMIQljyPuSBoyL1Zr4dhOmGH0LSn1WmNNNDk77kui5MyqMAojSNO8NjwGX84K
    LN2dqnBTqA00fy8YJcbxu4U+F0v26Es15pKG0zBWPC2j56HJJiqS5kjejfYZRQt1KokTZb
    LfqquDAkkfUqGnpNyVSAaBt2UpSe0yc85sX5Ta1nKqKfeArEuaoIYLIkKhaf2kCN/4LsFH
    XqFJB8YE06bTK+RoydAVdzlRdFNOFaRJTuGHanb995BOLUltxNTePAXl1bg1z0/i6e1AGv
    PUlXlXUjXktcBEGjoyHqIOjIwkmfyKdIIK+J1gEkwXThfBsAiBr6gPeZqjG0WR6fxQf3o8
    fDgQPtnLZOc7qYsr5BBt8U9QeC2TEY12/TRhOq/yWj9K1zBGhr1aa64YnURmfq08kIJw1f
    YDHrWDBM1Nz6v87GWrWSJAgmKM8GMGZfTx1AeDHoFksB8lEvMIwZokmQggBw
X-ME-Proxy: <xmx:oRLcao2Mgu1KGx1d0Z6UnjqYM4WMtDHuLvcs_OaLUJliPAr3272VTA>
    <xmx:oRLcaokcY4lQa1AAbyna228k2EmHRsBHM1u_ew2TB31WLu69IQ_D5w>
    <xmx:oRLcav8NIdJVXI9AEDzqIlLYi12CUcuAegqf4rFdpzfX5Y9u5zfthw>
    <xmx:oRLcamIdU_34BkPJvFZEH0bsX7KOm33q3EGoJKDfJlYXGyMsMGLEFg>
    <xmx:oRLcajK_Sj3lsPic352V3VDjKBd5Cfj1aH_U0fLr0ecbxGmqTBRttQiX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 22:06:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <ttaylorr@openai.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>,  Elijah Newren <newren@gmail.com>,  Jonathan Tan
 <jonathantanmy@fastmail.com>,  =?utf-8?Q?Ren=C3=A9?= Scharfe
 <l.s.r@web.de>,  Derrick
 Stolee <stolee@gmail.com>,  Ted Nyman <tnyman@openai.com>,  Daniel Reynaud
 <dreynaud@openai.com>,  Aaron Friel <friel@openai.com>
Subject: Re: [PATCH v2] negotiator/skipping.c: parse parents before queueing
In-Reply-To: <atv1uK2ZIupPgrES@com-79390> (Taylor Blau's message of "Fri, 23
	Oct 2026 19:03:04 -0500")
References: <dc3dfa3647c42da9170bf3289f4e8a4a8a55c8e2.1792441003.git.me@ttaylorr.com>
	<9e9ae442333b5e2ccc0905c44c2c3e16c49481a7.1792704069.git.me@ttaylorr.com>
	<xmqqld7pcqku.fsf@gitster.g> <atqSs0yzXw0cf3cH@com-79390>
	<xmqqh5icbial.fsf@gitster.g> <atv1uK2ZIupPgrES@com-79390>
Date: Fri, 23 Oct 2026 19:06:23 -0700
Message-ID: <xmqqqzhf26ow.fsf@gitster.g>
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

Taylor Blau <ttaylorr@openai.com> writes:

> But looking at it more closely, I think you're right that there is a bug
> here in the default negotiator. So...
>
>> Would a hybrid approach to (1) avoid copying a mistake to new code and
>> (2) document near the new code and/or in the log message that the
>> difference is deliberate and fixing existing ones are #leftoverbits
>> and not addressed in this commit?
>
> I think a hybrid approach is fine, though I am happy to fix the default
> negotiator alongside this series. I have a patch for it locally, but I'm
> happy to send either depending on your preference.

If you have a clear grasp of the existing bug and the fix is
straightforward, let's do the fix as part of this series.

Thanks.
