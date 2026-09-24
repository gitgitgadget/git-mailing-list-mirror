Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E933349CFF
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 06:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790230434; cv=none; b=ocUA26xriC2wTdnHxsdRkb/AbQ+tLhEYJUbkPEXeOUmcwDdRiBrtPosSc84QtiwaO/rFaK66xyig7cwQNyWtHlk4lu27LBpa3tvWTQmZ7L2Wi0Lt+zpRiLLXlmQha3EvzaZWhiqRs+Hquqjlq7s+wTz0TkZO5j/vB+OnRBrFNaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790230434; c=relaxed/simple;
	bh=3T/VUcSGR51AjP56m6j3J4SrdYKSLltg8odkG2eJvaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCk5cO44ifwvCYC4I30Yw73/azI4hYHKbRn0er7RwP1BXZ0nkK7eAeFfL2QzqzJYlLL0Jt43nAcizquIla6h9rYU4N3kKBuo2Zx46GRQKQouOKOXLUrdhjg0OkLOjFU4jqrcTpeGjVb3w/vpz8970Cy2TnltVS9B+hVPR8CA3to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vbv8TKK8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c2RkEy0o; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vbv8TKK8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c2RkEy0o"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 623FE140005B;
	Thu, 24 Sep 2026 02:13:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 24 Sep 2026 02:13:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790230432; x=1790316832; bh=NItmf+N+JW
	M5zmgwpKUs0bqr2nbodUBYvPpiKOLwZo4=; b=vbv8TKK8mZSPCtJ09G9h6kbiSl
	DYdkpZYa2OENGR/6fwPuEEwvMOGyK4r2BK+a/stCdJKfuVHAuSADERFalnrh/mtn
	nwFEUe3fvNitLA8CjKiFhRa+MOArOUr8POZt/WqfrSmS8WR4p5q+co6rLHDnMv2J
	j+jbrsX/uyf0N/OHeR01FgmjxZBNfagQRXa6qwSYlBRfxjb22GWCWwfccdPre0CU
	jaqL9nGwJDzfi3TbWVSo+icG04AfYbdbi5L7T8bn7uHpQKJcSeIhpHcZQkWiFLGS
	mM12MNYAorYu7QT31Ajfgop1F378PS6lceCEc3BiNbliDrOaaSRhtHMkocWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790230432; x=1790316832; bh=NItmf+N+JWM5zmgwpKUs0bqr2nbodUBYvPp
	iKOLwZo4=; b=c2RkEy0owdDSd+yoVBDLkpV9qnby5f/oqAaSO2MoZW8Oea6ZE/0
	X7jeMadsnCdn8AIdjc12AxRqAWY87+ehG9zUo+8J/8SFHrHNjpUhbGhMLhN6W8cV
	IxDWFtNYTvBd7aj/1UeT8fOSqiZCzmza2VoTLyNYl0+ohZuSpCE2LvArwk84yOrv
	fWEbhnoj6jGsFMQmoT1w+XZmxDHrCGtKQ7KNms5U7V3bBvTZKi091A/ACWuRhYEy
	Fz2p4vGFyDQyWiGbGaZYMMd38kQbAvWK5jQO9WtzSrmF9qyV4ui1fhTvsmD3GWjj
	ygkru0rD5gJih1auacqVXg4wijewdghQV3g==
X-ME-Sender: <xms:oL-0aqlAm1BV2k2sIoiE0r3LqsrZt2IiAb3CEKBRBhhMdCIZvQRN7w>
    <xme:oL-0apRV0Kmkn4ELk8_gsnaZwqamAGttYKwYFhJRP8oPrsdvBdE-TDoXYSLTK8G0k
    SYHvdmy_3vmDqrf50KqNc6V71zfrxFKnjlHlQq5eWdrBxygk10OzA>
X-ME-Received: <xmr:oL-0amBwheuKfDsKeLDXUlnwhPLJ66ml7ycBmyyR42fivXCTKJpylVzSPWBV4DxXKMXI8bA>
X-ME-Proxy-Cause: dmFkZTGVNSYmBsY1DUJIDrUoMga+7nM3JommT5cdgBAvClTMNiRJ23FT/LvWlzW8h9KxIv
    1tZo22OW6QJkYwKVQDfN950X4utuM2WRlB5eVCna40C6hiTcOVDpX69eJnd3yE++3LPHYM
    zEJTln7a0HXQ04N6JND/OKV5/x05e7kH1CTcWm11fhAm98TRnm21nQ/Sp4VkL68yVu1aah
    FxUD+fnXm9xV0AjFnkVJSRVzZmkwom7BzbRSNj8WnPgzDqrAfZ4iVqFASOlHlWn9jyZhZ/
    OiurjdcetRf2SY3mO5jVy9NMVWZ8ZzmQbwQiwaVIzjvQooEI36FnOD+kLFI3b1QKZXEGTl
    HOyowbVuj49X2OmiVOj73ge9+oTH4tdyFjN3w0T4a1F2bZ2MPzszdvjte98ruR/Yl33hK7
    Zd3e/Eh1u4/o4THXcQSvaO4ynTytISTc9sY621Qo86mpPzUO/tpnmlMBm0yjPl893XERqg
    XHeP/1FID3z1UYkcLoFOT4c3RoQkg8KFaWBNdPW/8NfUmIdH55xi9rWqfZbDMEGNEF2aPG
    1bTvqxB5tvDThlMm6eLYxuLxqBTe55RTpdUmFw+2ZoVHYOxFNDAIBII8zEVmTcbVicDZUn
    0v7nGfSFdmUYSHZhhbR+xEwnULsLhzDm+z3Vi+YBNF3SuWq0P4fG+EFErZ4A
X-ME-Proxy: <xmx:oL-0aoScEey9QUUSBocKdZAJ6Q59341AJ8R66g2YmDLI8TGtMilFTQ>
    <xmx:oL-0asq3L4IEN7LX6294PC9hBuwdwXGHXtSJ0eUJzA2vO2Cbgc6UZg>
    <xmx:oL-0aiw-OvLcnEiOwjZdRSFvBu0SmRlahK27q0Gvl6Qbr1wp-TNv5Q>
    <xmx:oL-0apIKC130e62-9C96ZeYVqWouI1yRBPhmG8fhyE_LAv2Fy9SnNw>
    <xmx:oL-0atRAlUmgonwq5gZWPAKKUzYc-A_2E068CUAIgB5vOVH2MtXhXv89>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 02:13:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c0a2b243 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 24 Sep 2026 06:13:50 +0000 (UTC)
Date: Thu, 24 Sep 2026 08:13:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Tamir Duberstein <tamird@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] ci: match Linux jobs to available CPUs
Message-ID: <arS_nA3g-on2RdIL@pks.im>
References: <20260923-ci-large-test-resources-v1-0-c28416d59475@gmail.com>
 <20260923-ci-large-test-resources-v1-2-c28416d59475@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923-ci-large-test-resources-v1-2-c28416d59475@gmail.com>

On Wed, Sep 23, 2026 at 01:13:29PM -0400, Tamir Duberstein wrote:
> GitHub Actions runs ten Make test suites concurrently even on private
> Linux runners with two CPUs. Pull request runs enable the long tests.
> These runs hit ENOSPC while multiple multi-gigabyte clone and repack
> fixtures were active.

Again, a link would be appreciated that demonstrates this.

> Use nproc to choose Make and prove parallelism, as the GitLab CI path
> already does. This reduces overlapping fixtures on small Linux runners
> while keeping the long tests enabled.

It may avoid overlapping fixtures. But what does CI runtime look like
before and after this change? Does it improve? Does it regress? Would it
maybe make sense to oversubscribe at least a bit?

> diff --git a/ci/lib.sh b/ci/lib.sh
> index c6ccbf8c17..0855026dad 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -228,6 +228,10 @@ then
>  
>  	GIT_TEST_OPTS="--github-workflow-markup"
>  	JOBS=10
> +	if test linux = "$CI_OS_NAME"
> +	then
> +		JOBS=$(nproc)
> +	fi

Makes me wonder whether we should have the same logic on both GitLab and
GitHub going forward. There probably isn't a good reason why these two
should differ from one another.

Patrick
