Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E7437F33F
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 11:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790248935; cv=none; b=fsUZA+SAkfzpb9wYvxR+RoAoyltwAkxBKxJ/WsK6wFq19eowBUlzhcYCC/ukVro2/g1ZfE3B2pqB6M2EAL8tRTFA2/mZF3MEAeteEQth6jfVyuEwE95e2puCAlPk7UVm6SM6mG4S9Z7pbBV05EYicFhsnVpD2m2WxqPDAqVe/9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790248935; c=relaxed/simple;
	bh=Qd7q8/PwPgRksXFncbIJ6NMB+YiN1Ah7vTEuKbjX9og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eljdcsE/dG1OcQbJX/1roNtGVNW+z9e19AsMOEb47aKLRPhuLRw0b7WOoJYARMXy28ArwDnDUraJwVNgqkqzL/1T0h2stHtGFNjqZAKu0DsRMfRnwryP+t6z9Ig3LdPtYtL1YE91fuZEqcHJL0c/Hx6w9vlM2SuqtIwecKXhj38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uLxtq+TJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LTTtYvld; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uLxtq+TJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LTTtYvld"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 4E77EEC004F;
	Thu, 24 Sep 2026 07:22:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 24 Sep 2026 07:22:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790248928; x=1790335328; bh=vcmywvS8I+
	cdmROX1F76Qr7aG2qewLn2+zfLr2QV0sI=; b=uLxtq+TJWDEAh5L8+GV4SyDDas
	PgWFqH0BOSb4myXg7t8Sot4s3WZADUC1tsNkrIrAc011X4UAnK5YpHCvGgpwxl/n
	hlvFbr3MCtzM1uGycZ2A/wswUn7dLvd06TYnS4GwQ66DNaaKSmd1XnvwJ+jqIrbu
	ygyZwTfG7Jb2G6jNHtGAPDK/pLHXrcQk24ccoq7OGlwUv5WfW41jbtNpqu84VtFb
	NRYOCHaYSb9CK+3G3Zza9gfyOZvAX9fy13lAThpInlaxsRkVTZQq6wED/D3V6TkN
	aCJU0GYHjbkf9B0xZ09hLzPrbVudAPyEji2u30dXrs+nByAhykZREA3QcyEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790248928; x=1790335328; bh=vcmywvS8I+cdmROX1F76Qr7aG2qewLn2+zf
	Lr2QV0sI=; b=LTTtYvld+n1IWcKwG2JsosKYsQuwHV6hhBnl1fOWmojyaHX4jKT
	I3+s5E4zz57k+FneAhTR4zAZKf24IXhnDaelFpJm2gomtxl6u8pFJxRYYHheBSWb
	+XzFS3OWHRJF1fuaDbGYY8Vvm+KgfGBQq+cYD316i3fSa93IaPJvv+hEZ67KYE3W
	Ok0qOIMZ8ZAJnJKvm+PrbAWKacFap5jDNrk8QW5syoVq8iiZ9ou7Mt1nmp32Zhct
	8i2tuNTHIj03fDmHsww3Mp2ravCuO/hk5UhVxlPdtg9uFpTWx5qxXz9K2FWPq8Du
	4pS1/3gRN4Bf8dmhUdn6pchu1008rwp6TJw==
X-ME-Sender: <xms:4Ae1atD3qxZXlRfDuEU5mJCQ4SkquWDjjv-ricwYriJfMiaw3vtWGA>
    <xme:4Ae1ai9bb61pB2javYh9svEqQOMWA_zuqqFW1mtkCK_S178qAbyaWyuiQe66CY_Xr
    KagIlaZbuJh_zAHvoLWyuVPwdReRdM3rpFcXcLIfxQahzBFOCGQVg>
X-ME-Received: <xmr:4Ae1al8VKOobBLI4zIWhZWYIfKp26zTJxdNFin52C4pgeEsxBpSnDlfiQrextSgvpqGt4u4>
X-ME-Proxy-Cause: dmFkZTFaBR/rMNJJMSeAKdrnHMSqIIgxruUQKv5CSRHEJN2FCOb7X7TOWZ2Vs0gxqTAgci
    YswFLOwgYUJmOfIK/TGHJmWLZqPxs68h+QXM/+MmEiojPzmD6PZ6oe8wp63qmLcIVyYT7Y
    y2CkkOkrEqcW6zkuqCWOGCX02iV3lUX+c5GLnQCkpZ9erNUhGdKAQKGbYfybnFj9U+5Q3S
    w+V9K3BSlvfspMtG3H5P48MV48fpezzKHha6tFz012wY2wwIKn269IK3NU2d38gvlim+9B
    RjfEbbck50oBPYP+Ub15XzvxOjhxY1kK0tpYZqqZHCMYBHsyJtFLmMr7hzNZ/4sgaEkuMp
    7GJEJQjsP80/ds5fgsgMzroYr8T3xUwsRQP0DZnoQStJ2mwkyO2MBZkaXxMrMRP3loWIvn
    6jiBeEVxnp9foimNntWXbou++IUh8nB9gZXVars9XsEZFeZM/M4jtJ4fhsnawlccz0iiGs
    5iifdHUEkvJ9ATSdihrafgrCM3hHuKkUB/vjlsilaZ5SmjWMMPoB0RK7698uUt+x4c3jzk
    hITY74TraGVLarIs0iXB+KBcHeC/0T35AFJSYH3U4dQ06mD++oOKBy/J/82JKEqjxdduPz
    MV60t2CpetisOduhMBJKbbH4ddr104gGw8FznSG9JLtIidf16DqJR/ciGOLw
X-ME-Proxy: <xmx:4Ae1ahf3orTpQF502Z_zfRD0NYah_80m1XWDHakqPZSeSiwxtQTKhA>
    <xmx:4Ae1amFa93gq9iGzBvs8VOv6mv8Ztv-8BUQVk9fUktzRpG1JMMiOPQ>
    <xmx:4Ae1ancigjZyWiG4Ux-oRdLIjMYYJL3vKFjNsfNreigQRw-BUABC_Q>
    <xmx:4Ae1aoGg5oWMR3egh11PD551AVSBePC7DqwUqkjNK4JWkr3d8aWOyQ>
    <xmx:4Ae1ave3YMqr7zeI2Kikg2mASvLfs7DtpdroJWWSrgbLMVAq1vyxIfh2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 07:22:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 756a1b8e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 24 Sep 2026 11:22:06 +0000 (UTC)
Date: Thu, 24 Sep 2026 13:22:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 4/4] ci(gitlab,windows): provide GNU Rust's host-linker
 support
Message-ID: <arUH3Bi26yyVcrOb@pks.im>
References: <pull.2233.git.1789819933.gitgitgadget@gmail.com>
 <1ed79f00cf72b2d5f2e5f55bb11de51dceeeb2bb.1789819933.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ed79f00cf72b2d5f2e5f55bb11de51dceeeb2bb.1789819933.git.gitgitgadget@gmail.com>

On Sat, Sep 19, 2026 at 12:12:13PM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> GitLab's MinGW job cannot find `x86_64-w64-mingw32-gcc` when linking
> gitcore's build script:
> https://gitlab.com/dscho/git1/-/jobs/16593470275
> 
> Although gitcore is a static library, Cargo first links `build.rs`
> as a host executable. We omitted the GNU MSI's `Gcc` feature, which
> supplies the required linker and platform libraries:
> https://github.com/rust-lang/rust/blob/1.96.0/src/etc/installer/msi/rust.wxs

Hm. Does that mean that we now have two versions of GCC available, once
via the MinGW environment and once via Rust?

Thanks!

Patrick
