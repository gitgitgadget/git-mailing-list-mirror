Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793275933;
	b=SD+bE/4hyhcywf/1R2Jj13a4ZkCJ6Q/wjpEGgdIPWmP5lrIf3VNNscpLVcYdx8ogtpNb
	 Impkaa8FO+tPK3vRUaX3T20RoOJCn0JGaHnhC87W5vmR/0i9FA9/J/qWCtK1XY/ivxMJz
	 MNYtPMMUrkCR6q8auxoVMCmKWiUXhNszEnxU9pdeMBaxPDlSvaP3KCVmzuLe5UHJzF3rf
	 xxgmzTimFxB+hgjrvKUdJO1cd8PNIq/g+bv6hw3rEdHuljerhvBSfJYqH+1a1jg4AxwwM
	 0Zafs6lZNcs2Bco4LZ+SFq6oKO7CX1OJNxCXlqQnC+03vglgGja5z8cJegoYX1Jr7ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793275933;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=5M5AE0AQkOwbWklLxShl5fI3KLtzYLaJm9+qDIZNAQA=;
	b=RESmYpV7chCiSSnLafdpHt9WtzC2M0bUTdbBEZU2DPt/WdvpxN6xgktmsjVmqhNpXX/A
	 sIGawai7xeLVzD0NtcsLwC/MHON7PA0MTvyNDxPCZfUWYP1fr1uhkWdh7BlkyM3yEhx+B
	 2ZYYOEOWKUjeJKxj/D0m3bIKVzvhcabKuxggGqtBpEkmcBcM0zr+XTqitPFAb1vlU3ESF
	 snfK0vtw6WARV0SR3hCD4EiwODZYGg+BjyQDVcxbEtaXRYfP5v2unHni1kelH5FCi/632
	 Wqb74cxc9UBgY5GVxVegd6SjzjnkhV69rIxD28meGqovoFf333OEKBr0h4MHArKOvgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=nB8R548o;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Xxc32V8y;
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2FC606A31A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 12:12:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C2FC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=nB8R548o;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Xxc32V8y
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 69BAD7A00E2
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 08:12:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 29 Oct 2026 08:12:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793275931; x=1793362331; bh=5M5AE0AQkO
	wbWklLxShl5fI3KLtzYLaJm9+qDIZNAQA=; b=nB8R548od+zqNN5MLdSjUboXL7
	tPJvDdeG5w0TCagWwU2XbPk+sakQKn1p+Dsg+VaGe/1zregW5fR9B/5ISnYXdTTV
	hiCer8t+3crjmq82eZosHnOsyA5ryUzXzQuK66bMG9zTPji4Nwuf8x6gSISW+wpL
	gVxsImMaD/ci8Jrpx4YvUNhvnwT1d5OwXAzR2Htw5ixm+iVrvOtR0tO7soAio3No
	9m3FVabuGzWifXEuQC8yRvqxN8YsNoQzR9uVMgaHcsrpEZhRv0c+gVaKaV6gktBB
	CJ9ZEVkzNf/YL9oIRaIkra7tHxI3+vREz8DLnRhYtOS+bQdOqiQocP7P8w5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793275931; x=1793362331; bh=5M5AE0AQkOwbWklLxShl5fI3KLtzYLaJm9+
	qDIZNAQA=; b=Xxc32V8yN2znZUdFqnLHMIT7aPUMEoMC8NlW2lsrdT1Awdsgr2j
	yW2ptquCouCVldBC6QDsmwYJPj/ZYzr3L7ctmcttxTrrGxWnegmnNtzlfRwq6G5r
	spYqxxcOp9I5CgBoGj+qsfzc9IPD9hcI1OVCSMvaiRYHasgX0QhEY0izq4v82I5n
	bdQ7MezrFUOC04pLQi3s2T6NaRaoBjfwzjf034T7iSvaZgineaMwZRRT2wmlnege
	g4elQWacjNFE4wYBBVeZDApLf40pe1FoVgwl5mV1jbfBKglx1o0msigaMw6gJ0xB
	bHDq3uqq4mnGDDS8mkFEdeiuNeZPpxm4WrA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793275931; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:sVqzHnqTCfotVrzqC374LQUt6W7G49J53tJT1O/cjWi77dy
	6RooTBqWLjelsctlTEaa+KD3wkaDW/7df5sR8Df/aIkYg4T30ZR8y8E/jMioWDLg
	iyaL9kGmASEsBf42HtP/aIbriKU8hrRh1zxR8CKuWVnpV3tvkPQHsWwsmwRXxDy3
	n3jYVQngr/MzEQQI6aj8PtZhZrySXaAZ7MzgE7/Qf+T5Uhd4dlM1+uocHxNrDZ8y
	sQU4x+dxy+YfIs8bZOFgZ0RzKtCSwUSCQl13dSKnqeo28o0Hl1A4iWpg60Krmllr
	W7194+Mc00CXgRHLFA/pMEjMPA3ca0/wRadKGgg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:+hop4U0Q1XRZBSgROG45Ru0Hi9QGLo/WE98t+5ZooRY=:0qQWL/6udGvE8/LQlaW6KmzBuKLWlegvyqxF0H3+YJk=;
X-ME-Sender: <xms:Gzjjat2X5kDtEqFX3w6U7NJLc9RDogOkes6XzukOuH3ORK7QO1nxRQ>
    <xme:GzjjarH3idec9OHSRpsH4PuWPYN0iCvMAkvk63LCbbrfRKj6yxybXBCAakwVCr6uB
    b2nER93VYgFZwf2VPdqQGAR08OTBzjDyEKY7_vLXdvUUC2-xplv1wU>
X-ME-Received: <xmr:Gzjjai6KXf31FMJu_zqOJwHRLWqR_OMgrQIsdCypIH1WCSTLOrjtNg>
X-ME-Proxy-Cause: dmFkZTEQXfaB6Gsnkb9IHcEDWI4uWdOTeRDeeDYUT+dbPiS4Rc91C+sWmzMPeO8XFzslhB
    nnrYVEIFcdSUGy60uAFKY+v3p4SPUgDiBVMIhCcybMJR4L3McNLfVf5NDmclKltEwUG7Vn
    GBU+AwpwhrWxVj4jXr2LOvW1T2KkZjxqB5+sYJFD5hnU6h+BAwEDs0MHeE8RE2rBiT+e/J
    Nh+3iNn6o5buJZRGJ0F5wwGibgItg+AcOZyIm49SCkriCV+wbAs5tnKwFVk5I/WT1MY/kW
    js6JMWpJ44dU4YvrnBojnFtai683g+WtCdK4gu4JqLxd1R8kvzZ9YYZ7PJPboB96QSZUXb
    7rd5ciBqjxOWPBp8dDIQ8pLa+dGB+unT6gAHrhwPYS9X32dXCaGfb2K080DpIXE3Mij9Lq
    Zi1kI5vj6Oiz51nAr638CgA3hGsVs5+r9Jz3qT9d2z4XeJN3InLKvhuItUWGk2e1CGmTJt
    PT/FxUcov0pDnP9zP80XNnsBUqqSvtXehPAExLhC7ps8STgRJIq4k8dTMopFMR1nQf9zs0
    maIp8IWMa84Lqkb3oFHqyXYohZ/KvWZ6cNa9VHp67KImNQbkGYVQPpwFOsPof0usxF8gTu
    lys7uoMPlag52Cy5WxFi2YgKUokdnwrYC3LhvI3ayxC9j5oPPBh9rlcLKm3g
X-ME-Proxy: <xmx:Gzjjaps3gQo3tX21xzW64UqbUmqENGtwkJobqaXOElTleI7HfbwD7Q>
    <xmx:Gzjjar4kH-uBCdo8OuXngFTVAGZUWQMsiV1nKHz6RM6JLY_wWzlT_Q>
    <xmx:GzjjasWmAwm7ujM3X82zluNxlf_mIIU7DFhGwm_IMXmBlWyXu7x8vQ>
    <xmx:Gzjjal8T6jkLLAbIuEoLlVYKHs8it60SIa_REmgz0aetsFiKcpUHlw>
    <xmx:GzjjaoP32V9CRzxLLLE_uLT0ADlxf7d3OC4TnZpR5bq1TAloXEtKaO4Y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 08:12:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bfe94ae0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Oct 2026 12:12:09 +0000 (UTC)
Date: Thu, 29 Oct 2026 13:12:05 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Srujith A Poojary via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Usman Akinyemi <usmanakinyemi202@gmail.com>,
	Srujith A Poojary <poojarysrujith@gmail.com>
Subject: Re: [PATCH v3] [Outreachy PATCH] t0001: avoid pipes in test scripts
Message-ID: <auM4FazXNNwLzM3-@pks.im>
References: <pull.2260.git.1792299301663.gitgitgadget@gmail.com>
 <pull.2260.v3.git.1792732388827.gitgitgadget@gmail.com>
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
In-Reply-To: <pull.2260.v3.git.1792732388827.gitgitgadget@gmail.com>

On Fri, Oct 23, 2026 at 05:13:08AM +0000, Srujith A Poojary via GitGitGadget wrote:
> From: Srujith Poojary <poojarysrujith@gmail.com>
> 
> Avoid piping output from git version directly into sed to ensure
> 
> that any command failure is properly caught by test scripts.

Formatting of your commit message is off a bit with an empty line in
the middle of the sentence.

> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index f1d227f271..c8c74f681b 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -678,7 +678,8 @@ test_expect_success 'default ref format' '
>  		sane_unset GIT_DEFAULT_REF_STORAGE_FORMAT &&
>  		git init refformat
>  	) &&
> -	git version --build-options | sed -ne "s/^default-ref-storage-format: //p" >expect &&
> +	git version --build-options >build-options &&
> +	sed -ne "s/^default-ref-storage-format: //p" build-options >expect &&
>  	git -C refformat rev-parse --show-ref-storage-format >actual &&
>  	test_cmp expect actual
>  '

The changes look good to me though. Thanks!

Patrick
