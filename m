Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795201832;
	b=440ej5Pb3wr0UkPZFlBcR+HDs7Exn+kAs+W9zVIU3hSIEHO9hKWmuRO5INER+6zS51rk
	 LOKflUy4/MWsKh0XlbU+yOB4VC8XZKTFAbM4pHLVITnCmtPGFUhS8WSd665gxEmYk91TY
	 InvKYlpwGte88XKHEjEWTI9+Ls5pjkpCuQoigsrztCuB0tNTmzMGnIRkkTrZXnhQeb1Al
	 61bN/vb6UDvqoWft1bizWgeQ3Agt8cFMbsiKZci5hsUuqftEXN7Sz5yPg0JNrnz7f+IDZ
	 bh4GKqtJe/frrYRWIHdPic0D5WHl3GYwcfyulDZ1Asb0d+MYAdkuMkd2dCcSN7d6e6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795201832;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=5Tgs7PioL10LAPhh52A6tV5IPbsbB3jfUfpu4a+z5wE=;
	b=DhBsbiZDWm3gGk/LXeuH6va9v1fm26q/dwh3FPYIngx91PCQ1Kljkae7dKJ0k9homOm/
	 ExUqC1EKCJY4pTa9aakF9dnpC73930dpDbKCJfxE9d4M3fXNncgS55FMMm7gPwSRG3dNt
	 RbobvEQggjeddp1l8lpJtR2rUO8SqTEWSqvbAHwyjVJ+RX+etukDkn9PIBYRWnW/+k/Hm
	 MjB0mBH2u5NDWYG1d4NuYz7trvH1kKf9fsmGvag/eH/KfCUezvW5a+7wrOGOI4YXo7xQ0
	 U7DgC9gAfDfCh2qCicaBfF6l06Dn8K2Msdb0vevAECQkx0rKEfAy97ENRbS1NOApYOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=XsGUBl3W;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=zt+6Nrn6;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF45606A335
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 19:10:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEF45606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=XsGUBl3W;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=zt+6Nrn6
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id C0F1AEC0B2D
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 14:10:29 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Fri, 20 Nov 2026 14:10:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795201829; x=1795288229; bh=5Tgs7PioL1
	0LAPhh52A6tV5IPbsbB3jfUfpu4a+z5wE=; b=XsGUBl3WqzhVGfF07nKq20Fp6M
	rT2bEOlISBpBua+EUydG3yLxmPYpdRFnNABazka1qe/omUe7y/fd46uk3biVkfXj
	vGcbabZUXZb2ObwqhBHrn4FKH4ilxvPyYhnUvcYIwSsF9jDs5usgdQC4qStLCf1A
	arZjAGLFIE4uGVuJfOV7Uq5M4Ha7gCma8kDVfiTf20jSyjstBVVUg4vAbmARblFi
	OdI7SZ6MzqOzKxgoVGZ/NhNdWiN8B6d7wtjm5pVd0Efqbno8UsPnDZZaILmCvzLm
	gDyUrd+3t5N4iFA/r30468HU8asTl77rDHX8zIGpLNMYDd0RhNRw7RUA1LQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795201829; x=1795288229; bh=5Tgs7PioL10LAPhh52A6tV5IPbsbB3jfUfp
	u4a+z5wE=; b=zt+6Nrn6fZln/FTJ6XIWcBtamZbXleJsCyB7c2g6dBd012vSVr9
	kOGcO5ERsBCF/QeEYUuoAaYOTYutEtK/5ug9ld8IgfqN5ZCf+KqT9pafXwMfMPPF
	bbWSLfa2M8YgMZrnaSsZDLvAe4R6nR4RA8UCo3ynM3gCPOa5/P21YE9HPXdXyQXk
	hULoz4k/l/00QOLI++Mc3abQaBu1jkcPBFP//OF7zdli0Cofzf4CaXF5f+g44+tY
	MxPFLC8NnLFn+Sg0C4gs2YlbjgflCOsiTyBsrvK1oFNFgtQ8a/vf2GKNoGzDw7Ez
	eYnXhw+ovFdaEPVxiIe1PZoAGRRdXx8mDcw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795201829; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:mcKD1w7vjgLX+nqXQIOPVgtO8EzizQcyDI44TK2zyj2ensI
	xkh20sZseCLsNrp6MvF9kGD3gAnVDDklZa7Bl8xwLAnLjZKd7YPp9/PG836Szum7
	sCS3QcVh8PZYamNOl5zIo1TmXGLOV9/gD6l/vFP876gZspky3MuBOObLTPZafgXt
	FdZBkIRVe9CeZe75QbEVXGGiDMjOR2iWD0777bpPG/XOn8yC9Tdxjsrolaq0leJR
	XRvS3EfCGqin+AYnDFqVkm8cfKFGTwAgyrP1Fe7MjrfbpADJ/4rTJIXMD16boSBL
	FMFakVjtossobqbQSgjPZVjWfJ7ZHhX51hEGG+Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:bzptdxd3tNjJaqESyQUKxY7NJ3G4cqkcCCt9Dj1FKKQ=:6DX3KkDjA+UbR0bRHdGM7CFwNvNXmrEgiHMSRIDa/AU=;
X-ME-Sender: <xms:JZsAa7wZnKIhDjJggJao-BkHMeiN_UbkTzjcXneV1LD2tlOztP-X6A>
    <xme:JZsAa129mW8uNdNqr57lS-0r4sd7FFGPg4InHpeeTrFBfL7IiPLO7y5HQIGEQx1ut
    wM8RrLo5vzzZQg2EBEJEhuTRG5HTaWmFGl1C9ZFJOENVdUCo5jaCIQ>
X-ME-Received: <xmr:JZsAa48DcWP4sGBjNtlzQfwxHW210wIGO06FHcFNguYJycVsfsZFkeFAMlMUt2MlyaLXTgemL-LcX7L9IuDQL_FURWVJocmoDy9c>
X-ME-Proxy-Cause: dmFkZTFE3zHI7mJH7YWq/Hi7k1cpxUWv6FmMvuua/ShMVoLjUlkRdrfrdV3BaqT8Zsrfq8
    tOmVRqfNfHfVaCVqnr9WhItv5Pus6TW0KoHuFM4ehgZu09Dpx6nZe7B+G0Q+W/Ge8XjmpI
    DHJ7yNIvuGZwFdmLQxRZ4M6DNi28Jv0b15NYWfAegXyPafKlZ1mSEPMq/mYZVXDfM6Llrj
    OfCfEbp0hE5PQjQXeUbXA+X/68t/2TvkucpsLs4+VOE+W7ceyDy5qbbsNGWa5x4cD7gOXR
    VOMul4eiq5ncnTFyHxX0h9P1E9gl66EJcwe3v6Mke+lfy4lK17A2EYNWxwlBFKTmKHEpfS
    62uOvM4p8lRWdYZ+SlO1ULbMhy0MoDjMXGC0ic+S82cHBlpHNfE93IsW9/2F4scY4ntoHk
    C5ZyPUHQtJfuGYtjT/FWL54s3W/9M1eBAsmfdC4lk630L/p2vCOtI3bSLV9MKTpR1oV6HP
    kZs166XBYakWhmWE1NYWFuVoXKJRbsDgJydaku0ixaJDjm7BKU1MedEgkOuCDlKZJaDmou
    eIxlHObmUkTW4UZghXUte2uoZT3WJKlfxzh6B6wES5jSLlbb+VgsJgRjiZZPUQIGMcTeqN
    eeQSYXREwd+decd46BMAb/xB4B6sBveazHrbpkGO/YZqGscmn3YXEHciN44g
X-ME-Proxy: <xmx:JZsAa1qzsTdsi4_j1udK1oGSCX3ORCV-np4elMjIxECa67wWf5ArwA>
    <xmx:JZsAayRpREKjlUZoMKEYVACAz2TJIp3DC5h59UsYiEldCSXJDoBVcw>
    <xmx:JZsAa4PSaOTib4XOGvNHFTubKaHtCVome0NXVjCbAkKHSpFkPDoYXw>
    <xmx:JZsAawhQjuFZoRMzEaLBIQAYyNuPt8ba1NzYbm_x61IbJ6x2AQmiFg>
    <xmx:JZsAa-rQenVUFLeAopeMsx9FSX0szuSZFYMKM5Hj4KOWRtepnO5psz5M>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 14:10:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>,  Jasper
 Mayone <me@jaspermayone.com>,  Tuomas Ahola <taahol@utu.fi>,  Harald
 Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v9 1/4] branch: move the deleteMerged opt-out check into
 a helper
In-Reply-To: <xmqqy0anpbzb.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	20 Nov 2026 10:57:28 -0800")
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v9.git.git.1795184664.gitgitgadget@gmail.com>
	<37ef7636e069ce528728c43cd79f678293e0d035.1795184664.git.gitgitgadget@gmail.com>
	<xmqqy0anpbzb.fsf@gitster.g>
Date: Fri, 20 Nov 2026 11:10:27 -0800
Message-ID: <xmqqmrr3pbdo.fsf@gitster.g>
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

Junio C Hamano <gitster@pobox.com> writes:

>> +static bool branch_opted_out(struct strbuf *key, const char *branch_name,
>> +			     unsigned int flags)
>
> I am afraid that this is a somewhat selfish choice of a name that we
> would regret later, as it assumes that "delete once it is merged
> elsewhere" will continue to be the only destructive operation that
> people may want to exempt some branches from.  The configuration key
> is named very specifically for that destructive operation (i.e.,
> setting branch.<name>.deleteMerged to false is a way to say "no,
> even if it is merged, do not delete it"), so there is an impedance
> mismatch.
>
> Either
>
>  (1) naming this function to make it clear that this is about
>      opting out of the deleteMerged operation, or
>
>  (2) naming this function to make it clear that this is about opting
>      out of ANY destructive operation, and renaming the
>      configuration key to something less specific than deleteMerged
>      so that the user will be saved from any new destructive
>      operation we may add in the future, e.g., "force update to what
>      upstream says", by setting the same configuration variable to
>      opt out of it (e.g., branch.<name>.noClobber=true)
>
> would work better, perhaps?

I forgot that there is a third option.  

branch_opted_out("main", "deleteMerged") can be a boolean function
that asks if the user is OK with subjecting the "main" branch to the
"deleteMerged" operation (and the implementation may be done by
checking the "branch.<name>.deleteMerged" configuration variable).
The function must continue to be purely about "is the branch opted
out of operation X" without adding X-specific side effects, if we go
that route.

Thanks.
