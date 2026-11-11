Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794423156;
	b=xuXV8z4ZzYbhMq48fFJYFGymlQMa4atSuz4ndL/kpY2+Ozz0KEU8/oQCFrnzEE4uq49O
	 Q5c3y/EiF87o3gBeJZdSt1tx12362A4E9B69YfFUNnz2Jqj1CiU734nMWi+KkKjqlwC14
	 BIaIdC1r/jQPaGspV71fvc+kIS/I8IliROlgRStWJXbBGRe6rz6URN46Go9lf5WtO9raB
	 0fIeyZNLviWLdPV3mxCFjQavCZvS4PVBoGrh+bX8ASIM3fCvQCyGMIY4VMYpAqXVC7IgO
	 dwc2zdR8mwZgmesbU4DPOIXs1aG+j0diZKV+7vKtAiUtKSd9sLbDPXXvyUsIpkvY9Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794423156;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=9oufyeCAR+SRZMOszjNFMBXVWGqH5aFY4wbUWY90HHI=;
	b=wrllevRbym8N5sgFZb//PmSc3etzddXvdE+QdqfY60l/8sOgWqXCmx/bIvLGqUV18KIN
	 dJwNncib4q8uLXExwoHjZ94zOdC+5Dk+8fQ0iFbtxU31C7pWzgb5Pgwrqtn0HNt7u2rpG
	 fLoj5LqaNJGdMvicK7nR69VsCbGAzrJeL/w6R1EbCQyjEU6iqtLD9kdAY2N0kw4GkgpVj
	 QdYFud64iBY1Fzj0yrAMFHE7b+JPRV+U6b1WMKr2nLKgwyV0Mv/F+6PUIRetH6z9eYuTy
	 7+1qOMb+QWXejMT3OHLi1W+XHGYqTBXUE/C6TCaj12yvs3nRreRi5kGJTNIT0WtjKIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=cvF2PWJE;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Vwtl5ObB;
	arc=none smtp.remote-ip=202.12.124.146
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC77606A31C
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 18:52:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABC77606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=cvF2PWJE;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Vwtl5ObB
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id F06461D00181
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 13:52:34 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Wed, 11 Nov 2026 13:52:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794423154; x=1794509554; bh=9oufyeCAR+
	SRZMOszjNFMBXVWGqH5aFY4wbUWY90HHI=; b=cvF2PWJE/Yzy1m8/mHRPbvLaej
	EqcnwesWVOdCDfckWp/rK2Y0PMbmKKDdOuXwtR1C4vyedSrVATRKSD76gxnoBwDT
	U2p3qIHEXXIkvX9E5Z4W38Q1vfNNHncBqZvb0AtFtVaJQyerQ7yvXTjg1BzKBHXT
	3lzf3mNB1M5ss5c1IceHv8SsOskLa6+x4xZf23H1TWSIzfDozc1Hz2yjmP+MotYX
	WCTN+b58ZUlXLCirm9SbScRiYGnJEU9UoeCiaRLmz/LsPm9v0mZHnXNkMYYqwfYG
	/n/2PORaloFszHkVWFpbct6JhGBanFoh3b3Rg8cxywZrkk0GLDUBKlrhf2lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794423154; x=1794509554; bh=9oufyeCAR+SRZMOszjNFMBXVWGqH5aFY4wb
	UWY90HHI=; b=Vwtl5ObB0/CMcoXisL3fNdSXNJds7cE208YKJsUlwaMg/M1nOPb
	eOVtjP38492h91BFucAP+yjM/nEmmk9dNIkbCm3Dyr5kL0plPtp/Zn4TI2VnsijR
	25eqT/alfIMAW6pBeqdSBQyVBkwMLoZ8P8cRV1yoMlZgN/tA9C4djSrrBLiq8IA8
	dv9dQIOe/Y1iH86vXq4J122N5zZQjeJ4Kr6+b1HCBRQS+0ahOsDqNIiFgpevwjIa
	62iND0ucayxrtv7R5K3y7HDAHWy/c+L0vntXqYdqJ7i1sNZ+H5FApY+1MoFomZ/D
	aCrBXAlujYYt2GRrFabVSI7whA7tr/u6kxA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794423154; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:aGJldmSWXjEcqO2shGWyGHYUp0TxPF98QjQZVt5h8vgH33S
	qgyP/yO514LTdevzVdN45pxj3xb8ppdfMODrVe6+Ppq1Rx2khWMBSMtjpg7BlNih
	reNsNZfN6PF1Di1M9XrD0TqXZdg/wQtFMxYWjCuPFT2UTtPc5YJgJTOZbJn11NfP
	P+QA0XDChbUau6ckXZRjIVp42PCUzti9tC/Ui3ep6MM+KbH0ib0JCt+lObpll1rG
	Jt0v+t4YIKaQ+B3ZptEkMoJqe4yS7a7mEYL88/SiOWHW6NwvohSInYNs5DV1UQZn
	JkJcJHdPVG1EhpjLknaSe26P5Tne9rLtfB3MFyQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:KLE1yW0Z6J6ks3q4isCpJLcXksMrSF6PhowhPnp3/7Q=:uxPuA7eS+sZGtSyolc7sxC+MKss1kk9knTHXoPrWVvE=;
X-ME-Sender: <xms:crn0apwlqSXsmEb2q4uDNr1p225lwTWs14X50kVBKK3IaH-JuzmGLw>
    <xme:crn0as9sEOx8BMuVyQ-LuY7E1SfyDaB4lgbQu-3nLfv1A4XJur79cLk-ruWmdX5J6
    CDZ9LuDK3If24-me63MRLMlfP_2334vHiHs6-UsTf2kbaMX11_GqHmv>
X-ME-Received: <xmr:crn0atKoV145wCHTYUrLtLDheeKsbW-KLVPOyZCm3hbl7XpeuEmtEWOihyrpg_JlM18gLYWNG9FGV-okBjzGm6unMlffx4D03HLs>
X-ME-Proxy-Cause: dmFkZTFF5NRp0tQnT4PxOuRu7yi0EhELrVYij8y+xIz7s9AJAxe+HG4SSXi4ReTFoyArt1
    YG+/uKCfNlucXNnQaOPZC31BnIY9cnhCEENLV1fmgOosca6S6v9SxWz/owa+r6tfn/aQ7L
    Yy5/8fppE/xn300fZvtVkpNEBNZaMrk1VAFniKED2pmZDgdOiHWIOwjMrzok4Twwf3WMfU
    nwwlYHoIs9IAwQnmZO90H9504hQY1a2bRfaK5BCBnR9vqtZtomyN46FBKWcNDnw0bng+7v
    5v9HUjyLR2zIqQow5ntPMPdVGzOy9RHiFy32jBzrbOgTpR64n8JJpDhFcXQkq51CuaBjGC
    D5L6xs1Py/F4xvnISK2Tk8jRqIi1BWCXg85BHtRAd84j3t4sDH81fwCwNG+ZkYIdZggp7t
    10rmA/5MKS+IQgmL3PAQQeHkWywhFf6Nnxovy7H/9G4X7wX7VbUDdrTrKJ5bVUD83X5+yU
    AfXpEytgKDebCsuphedxMzzlgEQzoSCOzK1bo+28kt8uOfu7/VLA0X8xhrM2LTdFKnlzMV
    x48XVM9ljL+8Nd5hArC+ycFhWWSmpwSn3E2x6nzKAJg18tt/gaaI1g8orwXB71bduAhTjk
    vGv34AWkLrh/fewTNdTn/uBsGvQa0CbTZJofVXh8+n9PpDnmJw4It9KwkmXw
X-ME-Proxy: <xmx:crn0aif9hI7QU4OKiPYpBmEqrfpyOUg-m40C2hZrAO69ZD9PWM8B8w>
    <xmx:crn0as-iesLxTpABKhU_4F39OU33h6sTugmv-N1ZQTKlM75o3_9dBA>
    <xmx:crn0avpqgSQo2WouafsUD1mt8X4G9RsvEOvSF7EZ0QgmDLFQfIuXgA>
    <xmx:crn0ahCft0ncBHkT4zNP36iEsWeIkfpd63vgvuUkhiV54dYArHSW7g>
    <xmx:crn0apH_8WWfZk8aJWmQ3cQwHhjQ_Czz7SOddxQjPOTgd2tKxO1VjJCR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 13:52:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Wyatt Holden via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  stolee@gmail.com,  wyattj.holden@gmail.com,  Wyatt
 Holden <wyattholden@microsoft.com>
Subject: Re: [PATCH 2/3] checkout: advise when orphaned commit checks are slow
In-Reply-To: <a9b81eb87684fa9bfbc83e845eb67ded8d7cb6d9.1794337920.git.gitgitgadget@gmail.com>
	(Wyatt Holden via GitGitGadget's message of "Tue, 10 Nov 2026 19:11:59
	+0000")
References: <pull.2264.git.1794337920.gitgitgadget@gmail.com>
	<a9b81eb87684fa9bfbc83e845eb67ded8d7cb6d9.1794337920.git.gitgitgadget@gmail.com>
Date: Wed, 11 Nov 2026 10:52:32 -0800
Message-ID: <xmqqtslnmc9b.fsf@gitster.g>
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

"Wyatt Holden via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/t/t2020-checkout-detach.sh b/t/t2020-checkout-detach.sh
> index d21dbd5b72..7dfaaab1b8 100755
> --- a/t/t2020-checkout-detach.sh
> +++ b/t/t2020-checkout-detach.sh
> @@ -186,6 +186,46 @@ do
>  		check_not_detached
>  	'
>  
> +	test_expect_success "$command advises when the orphan check is slow" '
> +		git checkout --detach "$orphan2" &&
> +		GIT_TEST_CHECKOUT_DELAY_WARNING=true \
> +			git $command main 2>stderr &&
> +		check_orphan_warning stderr "2 commits" &&
> +		test_grep -E "^hint: Checking for orphaned commits took [0-9]+[.][0-9]{2} seconds[.]$" stderr &&
> +		test_grep "git config set checkout.orphanedCommitWarning false" stderr &&
> +		test_grep "git config set advice.checkoutOrphanedCommitWarning false" stderr
> +	'

This test will not pass in the modern world where the advice message
suggests to use "git config set --global advice.FOO false".

It probably makes sense to grep for something looser like

	"git config .* advice\.checkoutOrphanedCommitWarning"




