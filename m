Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229FE26CE09
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 10:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751364826; cv=none; b=h6BHD2t4cCNaj2FoEtGnc+/RtXNl7IrZ7DDKRH/F5e+PSEl7lkRPaMdDWTxPyIzxED6SszbIbP31XnvUcLjbUNSPG6mHwWAgu+1L5C2zefWMubma4ipQlrH1dupXrRFEFiSMl5blczeCw8VV3CYpYgb9nRkn5pcOW51x+7UT9F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751364826; c=relaxed/simple;
	bh=qJNheJNP9bBeWa7fIkanxCPnr/92kInx65DzOtk4lJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drbB/qUpYcdI1MGqhABmaO5YqOEGh88wQExvR3/5qIkotx3b2Yu8LAsOTSfLAcLIQd+BChro62rPMf3NmsW5Zjp/1yIv/ejiPu7FHupbp7U94QuNNDmqfaFPcQ5XLvxiED3mT2oCIm7vHE2gMeguVIO4iDrfLOjs04RmEWykl18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=yHxx4nRM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QH8F0Tfk; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="yHxx4nRM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QH8F0Tfk"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 28C1E1D001F1;
	Tue,  1 Jul 2025 06:13:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 01 Jul 2025 06:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751364824; x=1751451224; bh=paCB4e4aEe
	PSWOR7Mobbox8QyXzix7is897Ox8V/0uI=; b=yHxx4nRMga1xV2ecT9KsbVIfiF
	6+3CECu8f9JsfH4phKAmGp1Sz7JOTLb2WcRPIBx/4le0rlfKxM9Uf4vmvb4MaRWQ
	fq/cMDCPEE93vQV1rSghj+X3D2gojDx1iU+8cvLbektffsJ9XwWD3rtoRXaAjLmA
	88qqI6Bw/xuR37+KQMT818Nus0+YtNiOICI7YLQv1n2zXJuAw1leI2IohjSIEJHq
	cta3W7vmdUWj2J9rWbCapGZUbnahz0yCSH/h66M7jl4cd/SC3R+F6+nTeCIIstlU
	GiYQ5xa8XEDY794ziZ2zaORM7jWTsO7uDYEyavIn+sz/qCJ2wDBNclfuW0Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751364824; x=1751451224; bh=paCB4e4aEePSWOR7Mobbox8QyXzix7is897
	Ox8V/0uI=; b=QH8F0Tfk1BoCUsWfquTIADS/XK5OlLzxfUV0nvl3BuD2kh1jHiv
	j4b9RVS5ip0DEY9lNHKgQ//ocQXIWprTt9ULZr85b0vgOwK0BxJ12wr6aHNp2ncv
	6M7uDwGhJLRWlF+N1NU87nVcaBoQYqjGnFzqGs4LE/kruY4RR50Zui2V0Ge3nv8w
	e8ZfKRjgISM3sU3QnW8D6RrIjCrW0HA0lODDBxhrFCJ3S0qMmo5qIVNbD/NWqYBn
	z/CcA2Onj4qCG8y1NFvFvRWSf/FEQz+Vnryq+8QxdSS1W0pFZ0AUmj4JeUqdkOf1
	MntjZdAM3Ync/XcyFOQHQTD4FLH1f8xG/mg==
X-ME-Sender: <xms:17RjaIGNql5lFZHT_X1X6cMG6Pmp9HqY7oStZAPZkx3X9Bkv0R-nkQ>
    <xme:17RjaBVCoiJi7lRSvJcYa4cIdl30Hm-G3x_KLgkxCucKTaP8mvCNMXePCwDZZ_Nf4
    T8T5jJenimVCO3p-Q>
X-ME-Received: <xmr:17RjaCJZMZ-Fs7UOFte1Bbux3YZJ6TOnhX5wa2LY6e07WYRnn_HztYlquyQ4Zb_JrP-SD_51Isxa7eQSUgDEwE0EPBm1RqWQY0d9XbTZ3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugedvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishgtoh
    holhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:17RjaKHrUgohKtGW1x4keVHjkKTnepTY0phjc54moYw9C9lZZjrFCQ>
    <xmx:17RjaOW9sPfQF1E3VGUPwp6gyVBRnP6PWwtFqu2DJRB5u5D4jsVhLA>
    <xmx:17RjaNM032YsPxElj0MuMEjjwfQaaeNe7fnNlz88N8H7F2xQ82mYWw>
    <xmx:17RjaF2hoHXY7UwgdB4xbfTmsUk4a5WeJM2roukmtyQjxCpayVSA6A>
    <xmx:17RjaJt59_GzLfyF_-RhVKNHb_7ejOOno0D4n-cZuEYGQBZrn1-ueMz1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 06:13:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6c8971b6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 1 Jul 2025 10:13:41 +0000 (UTC)
Date: Tue, 1 Jul 2025 12:13:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, jltobler@gmail.com,
	gitster@pobox.com
Subject: Re: [PATCH v2 3/3] meson: add rule to run 'git clang-format'
Message-ID: <aGO00T4c2Q-EYXZx@pks.im>
References: <20250630-525-make-clang-format-more-robust-v2-0-05cbcdbf7817@gmail.com>
 <20250630-525-make-clang-format-more-robust-v2-3-05cbcdbf7817@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630-525-make-clang-format-more-robust-v2-3-05cbcdbf7817@gmail.com>

On Mon, Jun 30, 2025 at 10:38:22AM +0200, Karthik Nayak wrote:
> The Makefile has a 'style' rule to run 'git clang-format'. While Meson
> intrinsically supports a 'clang-format' target, which can be run when
> using the ninja backend by running 'ninja clang-format', this runs the
> formatting on all existing files.
> 
> Our Meson build doesn't yet support a way to run 'git clang-format',
> which runs the formatter between the working directory and commit
> provided. Add a new 'style' target to Meson to mimic the target in the
> Makefile.

Hm. Meson already knows to wire up clang-format automaically if it's
available. But it indeed doesn't know to only format files that have
been changed, so I guess this style makes sense regardless of that.

> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  meson.build | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/meson.build b/meson.build
> index 7fea4a34d6..20ce0525a1 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2144,6 +2144,18 @@ if headers_to_check.length() != 0 and compiler.get_argument_syntax() == 'gcc'
>    alias_target('check-headers', hdr_check)
>  endif
>  
> +git_clang_format = find_program('git-clang-format', required: false)
> +if git_clang_format.found()
> +  run_target('style',
> +    command: [
> +      'git', 'clang-format',
> +      '--style', 'file',
> +      '--diff',
> +      '--extensions', 'c,h'
> +    ]
> +  )
> +endif

Do we want to call this target `clang-format-changed` though, so that it
is consistent with the implicit `clang-format` target?

Patrick
