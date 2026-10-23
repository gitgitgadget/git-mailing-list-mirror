Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792796149;
	b=n76ajGktpPXWWgQUGG9rmCgx3OG9R4hMqxfarjGHkjpoYZhZF8OxiF4Pez5cskLxgE5I
	 +TXKYjyVrEDRFiG8h9DxMGd03oWsr2MFTH9k6lG8XGLaRmyBg1rhzJNXE8Z79pNwRD1Ev
	 QoX9UDFSbrr+16O5jDaZaZjwC/plSlB0Q5T01A3Fx5KHyTS345cGSSKl1ydLgh3qhm7ty
	 99WwsRJ4+jdtFIWQnnY0ZPh5O2g5j0iXGkKYJRCs6MF8UhBDsxf6gDPoqL7qRCfNLAYwt
	 PHRpXo/EvwvTX/AeoWKknIBK/BHRuBtYHRO2cXyA21mEhaC3AkbzBEiyjy0Hg80q9AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792796149;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=XnK2F1cPufC/cAfzkh8XUtBd/Nr90R7gxgxcAARmx84=;
	b=K2F2UreS4wyI69yuGWCCtOiJ0qLfI01JMrcIUZ3SU5l5g+g73zALOnA+ysE0fAp79Hta
	 +P8cJSWJ+nntyQCK/9wvzJzzja0LwflvTKUSZt1frAQ8m2RtGCcfjqPBZmwDs87PdCoP9
	 BKCrViNZRTyW8fTZDxyCHCN/3fbN4r5yVb2tZj6h0c2+weFq43szmv7YVIoXM4+sGqyZw
	 /r/23wRD34Su4q3aJLMXsDMjvlXy0SCBYomTQxx3bQLG3ulqe6bOrNcNU5B84XVFvIuvY
	 Y0XYmQH62VzKZr+6y68GeFpgdye8RXHq+V4t4iDIpNrYsuYLCNT7d9FzT8iMS7Dlaww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=mJESOOql;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=AGIfXN6i;
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0ABE606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 22:55:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0ABE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=mJESOOql;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=AGIfXN6i
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 055F47A0111
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 18:55:47 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 23 Oct 2026 18:55:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792796147;
	 x=1792882547; bh=XnK2F1cPufC/cAfzkh8XUtBd/Nr90R7gxgxcAARmx84=; b=
	mJESOOqlBYY8wkk7ICpcQucqiKLYxVQDrYsHV8clqpy6lPLIk6YZDOxsUYvXkgi4
	XHWLR3lhGWz2UU7D6vMwfP3sEMFLgGi5gYYy8p1GpmNyUYGJJS2pPYyasp+5la45
	FkO3C1I7m1NSuiToWwpJNlhkXWAy1BMPuHCHgefRXpzbZ2+h+HEx/WIYa7CP/MBF
	FS9TV2s24KmFciHNPKaARY5pcjD3I9jUqRBoUw146rFVWS1SNd4I0U3SGjZkjZPB
	E6gS89bD1cvFFSyRXHffDfZhx53Z47i8S98OtUobZYnD/YKl+azD2yIlj3akQHgE
	Bb/jKAi6VlVh1Eksj5nyUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792796147; x=
	1792882547; bh=XnK2F1cPufC/cAfzkh8XUtBd/Nr90R7gxgxcAARmx84=; b=A
	GIfXN6iusS2YMtPpi+LHpCAuVJe5RpBfneKQ5p7Jd7QaU3IqIwdvoLBPKuJY+2lx
	yHGvKE8J7rkZKt1an8S6fb1gbcjxYtwoIhSDkGyiSxXTSWKS++TD0MDjhRBK/7u/
	SsuqtuDIUnqQtfjHX//+oG4o0cSH+6DtDYisQ7od/kbPMFVnGSsE6708nxDn5Ke/
	RPiK+eIyR3EVNB8rG7BVo4UFaE+U0blJjJ8LfWjgssSRz3GsHr0oG1sHPgpa6d1f
	gL/WBti1N/y9tHqF7Ogz4NoltBHy3VBjB53OEmyVI97GmoXj9diJ0LKc0Tslu4c0
	3xW+eqUYW6yQLyYbac41w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792796147; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:ajyRR2gujOjoOsccXIoX29RXxHhVh4Zr1x30mcUaCBBIjeb
	etyzGqIHDNXIe/6ZGLyU3Y3XwvqxE3t0fzaWhgg/BhT0kP6a3as24QhA6tDtBC5u
	IKu+F8Suwd4mkSirS0zNIwt2fPfi0wScXPzMCXPDQOyE+BOVRWTzIVEsGG3Qnqdp
	dcwYPV16xrL6DOuAXpFm9l3z1tXTJo9NQYNgjzNXgn3nleO/VTYgMG0ZBmTAsKxt
	n46+FKHjI2uwR5dLukjRsUehLRIpO7MsNBdb5XgYFc88o272teyYNhB3PgVH48ff
	ZHUiJtn+z6quI2yHUbogyK5MqIr7tJRERr/d3Fw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:zzBAfnxaEmt4iixbrerNwkja240PHXUB0UOAcyeeKMo=:XnK2F1cPufC/cAfzkh8XUtBd/Nr90R7gxgxcAARmx84=;
X-ME-Sender: <xms:8-XbaoG8CYFe0gwurqmuTKpLMTNtOrC87n7JtAWlbmd6mPOMXe8caA>
    <xme:8-XbalBq3kxvg1PAEjUJ1F27QhvjQTaq9PyzK8-YQgnpq6jmv5zyraZhvBNXzM1SX
    ewg3rl8f3HznxOtizBowYoGxPXtA1N7bxoIKLxlGpUBo_nAy3ZsyA>
X-ME-Received: <xmr:8-Xbar9-ujhpQSXDMSmHLzCxEjibPK1fqFlf75U05QrFYJt9ocnK96qiI8skH0swLM7irpsYk0IttyM5hGou5HqP5poloAEW0u0E>
X-ME-Proxy-Cause: dmFkZTGQZZW2rG07BEpx6yVf/8olwAO+OWrJB70xWNRM9aLeooLclMB+m+Okl4cDUol9lm
    l5NhATXn/ZIAr9nQI7HUgxopJJqkRml8ScuDUgrvqlcKybzWohv6HzuaUosF9vsXEbKsKw
    LyExGgZ7XWli5AWuMH2s4vpKbjwGHKkgzMYG5QRLoN0TJJPSpOODV0DWdVGeJG2PeRszaG
    v0pD+fTbo/h5Ki0/NDAx2B6crIuAHD9Lpob5IQj2GJMG7shfIZLhvg2Xpg4E2hI+RChF34
    iYBieOuz1ztTHSTM5UCwGz05dsBg2wMa+F8oGNi417vs9YugW1meGGG+XdDVCMSfDVoCZA
    5N7votY3HGdTJ6kwctRxswErSCDJZhpT5C1UsARlpx8tAn5wKJfOMyMxq/2qr1QD0mB0Xt
    FEcTfZ8WPLeeV86jQlKYr0sFtDUYKNlabcnpctbz2xtofzpofn4yHYQ/10etYiGwZfqQXG
    UFBPyFC1YY+BDcw1enDPWx2OiBPiSPiXHilYpo+0s/iIrN3gkqhq+i4ALM/mlAVX2LWXJv
    QXnANZiMOTKkqIQR/rqD2192+bdxycFxKxQwRG84V1ZaI/ryVPxfrPr2BiNnbRBLHpCI1j
    9tv/StyUnLhMMVDtZtmqFRURUpcvHUrtMwprYfTGdehAHvm2PS9KvxMZllOQ
X-ME-Proxy: <xmx:8-XbahABSRP4y84XijKZCn0Zm8UV1dELg2wwyGEkCD0evHF3ATyIPQ>
    <xmx:8-XbagSjPw49WF7sWHDsJ8mjEKEk6pI9dfveI3eXIv4sj4swzLmDCw>
    <xmx:8-XbaosfboyTLyjTviHji3zuHgY7jLV7Yq9mTFv5C_tMaK71Jfa6iw>
    <xmx:8-Xbas3GZmcLg5Q1cHBNWnT9UFjkI8OleZsvz85I2XSl9gv_ipDmgQ>
    <xmx:8-Xbaiq0TSS5rnxkNs9AjfxsY_GzWvCFKv03fqPtt9cGd6pdODm4fUAF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 18:55:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>
Subject: Re: [PATCH v2 1/3] reflog: name the strings that mark switches,
 renames and rebase steps
In-Reply-To: <CAHwyqnXN+OM0CMCKY8s=V8On-597xtc7NjPsu0i8L=WrAyy2hQ@mail.gmail.com>
	(Harald Nordgren's message of "Sat, 24 Oct 2026 00:47:12 +0200")
References: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com>
	<pull.2448.v2.git.git.1792348037.gitgitgadget@gmail.com>
	<745929bd805784bebeccc7e3ddee638aaffaeded.1792348037.git.gitgitgadget@gmail.com>
	<xmqqmrs43yj2.fsf@gitster.g>
	<CAHwyqnXN+OM0CMCKY8s=V8On-597xtc7NjPsu0i8L=WrAyy2hQ@mail.gmail.com>
Date: Fri, 23 Oct 2026 15:55:45 -0700
Message-ID: <xmqqpkx02fim.fsf@gitster.g>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Harald Nordgren <haraldnordgren@gmail.com> writes:

> On Fri, Oct 23, 2026 at 11:19 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>> > Name the strings once in reflog.h and use the names wherever the
>> > messages are written or read: the "checkout: moving from " prefix
>> > written by "git checkout", the "Branch: renamed " prefix written by
>> > "git branch -m", and the "start", "finish" and "abort" steps written
>> > by "git rebase".
>> >
>> > No change in behavior.
>>
>> Would it make sense to test the behaviour to demonstrate this claim?
>
> We have previous tests for this which I think would break if this was
> incorrectly refactored.

OK, if we have sufficient coverage, that would be fine.

