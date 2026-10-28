Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793171015;
	b=ynJmad4FzPPQc5RLNfsaJrkvGI5W9+m64VU4Lv9d6ICFNSwWDWeLrwzfPZE+ET5T4+og
	 0oWrIy7XZpxmwphHwxnm5llWuikvsBgkNJnroS12Z6nkx9ktMxDIyL7x/33++6/yyIfsl
	 IYbOJMsMLiT/1nQzIr4TBkkXKFCGlvhCHj3v+IgPi1ObauT4H2dKggMXEFrzkIeSbjAes
	 SwNhReKGiTtp0qrjDkXymYeiz6lbHrm4SLmYBGiaE4w780gf4sRXzq5GtduYcxzUUD/Ah
	 K/WA/q+JyiHVU7U5JqZoow0Ltws+LR3GRPutlCjwayXp0s58xMymr2M/OKEsGD1eCAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793171015;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4EF1irBUNl8IYNwncVzn7IGIqbwwY7zs7jA/8EGy65o=;
	b=2T8jHGytjnq799LH6BhXTV1LelvaLVuxLYINZ+FQMUscHljhOop9+z4dVwggWetjp0hd
	 8lzxd35u5cWc+hyiSOhmMBfgxzcwkXQkp1Rh4n65yx5A/RZT4ppD16304iOZ5D4xFWkcg
	 Cz/m5dEi38nl+S0MjX+6Mns+UJiZ1bE5Y1h+Uwi25F4yWaRWV7K3MnXbBTj4wHXvGEKEE
	 6+6Ka+vIu/5GUhVz3RVFcDYhxEufOsSvZLgZ/TZg6rtfgMmXmfmwnFRBzXel8tOxdzeJM
	 6x0Eo3wo+e2hBrEQsdVg2HRXXi00t+6SuOZdEFZp6/rubtPaDx2lzQMYspW3TuNziow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=EClypZwX;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=JspDZkuD;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A84606A31A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 07:03:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1A84606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=EClypZwX;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=JspDZkuD
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 193AD1D00211
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 03:03:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 28 Oct 2026 03:03:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793171012; x=1793257412; bh=4EF1irBUNl
	8IYNwncVzn7IGIqbwwY7zs7jA/8EGy65o=; b=EClypZwXFTxAV/2+emYNFhTBHR
	KeAfh1gp/2dDNAKTgXtaRKoML66Q1yoakNGy/UQrNb4RvwCs4JkzWe58FNRrBHuj
	5514Fx0UzmToDV8i3M1345ihx8pUuTFIBR+nH+cl6pUnqS8XSfCOQaNRQfJoFCtS
	pukdED3cirkl8dqkYsnCtlKM8gsHnHt9nVIpKvWJlSB3PSYjIwj00ql1Vm4hEElG
	7tL7H58nTig7o6mCEiPuYo2ux4SYZIFfqtMO4ypoAnv+4QDABAbFLHPYxMvJecSm
	mAjEeUlyFkg0kpmIVfwzs8zufkpSUCp6iIw4/oVXibfiw10n5NTzF1PCk75A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793171012; x=1793257412; bh=4EF1irBUNl8IYNwncVzn7IGIqbwwY7zs7jA
	/8EGy65o=; b=JspDZkuDIkvB54G7CmoNe6UZidDRtDbZw9g7aqoXUoLCJSA+t45
	1h/m5oMZmSZWZ1QHw9Bu+6SMpBuobRUf5CuUQpB2l3Gdt5Pk2q1sIx4VVZYmBKW1
	hYJitYcE0lUINGnjAOasy+gAHLItVbJKcosURTuB7pBBuNjfCmNCKSzo5CU94szQ
	eXZgaO+1FqHVZEyxczqoV1N8spq/Ui1SLRz5nm/jXqWTa3GDF0zo7sVrEJ3iw6pL
	vZT4ekRhk8qCGwsshUD9yUH0uBZblE9TNwLMkPdWKkZeh/Fn7K3sKnj3IuXV/pFx
	Eo4ZhtcBOpe3xkzn44RoFJpfWCkIvwnv/kA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793171012; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:f3WVESaGao96u4MfUr4NZPKHpkrSA9EfaTmJkHH2KOYdx3+
	8SUtfR8DI5GE+HXcRRsH78/ZrPI2cz1/TpthFhYlUWA02oyiJVwECugEXzmN148n
	QIRJSnwPL+UvaVo4hvhAzqebi/eogQ2XZ7gShgqjpKN6fE/qaUJrBwjRWfDGKETA
	iRrZ58x4hsQCjU6UZ27GEmv79iJ+uPr/aqnnv/T19LEx0CszS8BE8yKHsR4UnEfJ
	CuU1kvS2hSivevJa8nVe7+B5YJwiqnDpnPAsYKg73SS2aPyHAc5YBBkbPxnhhJKG
	ltBjCgmCv+0RmusbgD2n0N7jL0ZWkLYhgfNVAwQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:B1iP6MJlkNoVI8zmuyUWyFhzsLXRBVwSLklTQnLhvEk=:y9+TREIalSdjWfswCm0cqApuKS/zplQ9/AA6U4F8NLg=;
X-ME-Sender: <xms:RJ7hang11gxmxRvnu9oZe2_mD7XSlyQFrtjeH-l5S5YW4omt1UtZGQ>
    <xme:RJ7haumhyLMXlgIoGRYyan5cpISAbir4Qo5ie67Q-E5wBDSqweduNpFnMa5xHYJ2f
    F59-w5Z4LQbEg1svBD9QKK9w1oXuTc83Pfoh0LzJXpihIYGokkC8Q>
X-ME-Received: <xmr:RJ7hajpU0Pesi3M1c6iDSvtsnOevo9z7W0Q4MpoY2SVP0Py_HRAfsA>
X-ME-Proxy-Cause: dmFkZTFsF4+ovJrKbKbuUqhgmTf5+zdTYY4nMtMPjvQJw/lCA7eqiTM3PwJPL9QemTAzg1
    1UozBOn6i+NBhMINZ4YhFdgEM5At6rs4Gch68pu3nRcs/pOLxN4xt7rG/s/xZCK9P4KtLU
    zuqTd44ER7nQwx+Y4FtNerwMIT3qukTCvuyxOUlMGWdp+6f4jU0izKAJNyL0vXlCUqOpMT
    rP58Ln4NlZp/SafBARHgq54PeEM4yfYI5CbSenurGrnd3eBv7vB0mt5yLSLkbxXgCTuGHF
    TQB2cvM2jFqHwuipbKpkOxwGxJ3VySZyVCkW9Y9de/4B+45Z7wTEHHxl1bD5MMLON1COSa
    nFmoRYpyK5DcFJQ9i1B4mfqvTT0lzqNHxfna+zW7odJkNNGusgfsLA2fQwk5JEtVtIyLzk
    jRZxC8yPG/Ju7jPG8GHoAqUVy4o6SdUkM1rFIHd31vS2um2omd0l8/IkFTSOPM9f+Gfn6e
    AYurL9cY31vVzKqyZIaPlaF2t+YJ2s05F3v6c2jT3py0rElemfr0iHdZme2CfnwCME4ycG
    sdUnozwLKZQoa6ZvBlonzCVPVNauMwEGfyGT+JuRh1sGhjk7eSPpLq6Ou56Mz1wG3tm0uG
    xbrLuJZypp1Z508QVJWk+53TGyIm5StyWebQFk/0bm22IxBl1oxmuK5G/8aw
X-ME-Proxy: <xmx:RJ7hanEuGU5h1XNrpeVT1hh5ox5rhdZe2tTxThhDrbY87WRaJxYE7w>
    <xmx:RJ7havyZNP1a4UdoSh2eTMfqvw124Xty8sDa643OXxR95PHazmg2FQ>
    <xmx:RJ7hasoL-RVPhswcG_9WSGwTrPm1qOxMd7gy0Bn-U8n463AEIqkGDA>
    <xmx:RJ7haphnBkG7W_br2FAdpAnKKfA0qwQdt-lYAhbjT9HR5Z0aIy8U_Q>
    <xmx:RJ7haohCQHgrXShrUKzdC9eM11S9yKh-pVBgv3oFpoYtIDq9weVNarN_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 03:03:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5ac39623 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 28 Oct 2026 07:03:29 +0000 (UTC)
Date: Wed, 28 Oct 2026 08:03:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Matt Hunter <m@lfurio.us>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] init: show absolute path of (re)initialized repository
Message-ID: <auGePs3hkgJ85JlV@pks.im>
References: <20261020053932.1274210-1-m@lfurio.us>
 <20261028051704.2759358-1-m@lfurio.us>
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
In-Reply-To: <20261028051704.2759358-1-m@lfurio.us>

On Wed, Oct 28, 2026 at 01:16:37AM -0400, Matt Hunter wrote:
>  Changes in v3:
>     - expand test to cover the full output of the init command
>     - Link to v2: https://patch.msgid.link/20261022120749.3567828-1-m@lfurio.us

Thanks, I'm happy with this version.

Patrick
