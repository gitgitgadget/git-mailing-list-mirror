Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795651061;
	b=zklybmJ0GP7xDsefJA73n6PLPuSdDHBn5P4awzYhEcTutDkxxd3uZXvloEb+4XAjpiQC
	 vNEnnQDd9Zptl+xh2RKdPJkOGC3sL3sV59xZdPM2u5u+X6fWBJ+rTMUrdS4hmJ8sQ4O3W
	 jY7ZX5xXmgzKV8NBuagzGqKPo18ngikgzEHSZW1BY2pbL4JgIddQgLZqYb7pydTqZIzI5
	 KSFOMy8vEsolB8sV1rbJJWMSpeU5UWw1MTm0JTRRrThUjrAaKsEEgMXNQfcsZ8L4+hJlj
	 47xMnEbF/Az6com8ARN520/HHhBXCrsVmgL+A1saKd61glC1Oikbu2NszLC076otc3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795651061;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=EnywwiTQrcZqelGnv2BM/lEHrJaLyW7bQa9bM4nKeGU=;
	b=YrpagSm+ihQIoyDr6KcZIbjdLwZuCtuO3T4uaMp8AL6luPOmT4x4P1WjkZ8Hub8yV5n+
	 3foCVCCvbotD7uzbqZjB4XW2X1F/njEeL76tMVGyGqWpegD4hUJebkv8PHri3XGPgTDnJ
	 zcWPeyK7wKSvPsK8vcSP9wDp298ug07wux/x5DTkR6pwyhpgvoJ7vFSckpLKEiKPkCI9v
	 W5xrjgqvtOSb94DBSekhG2qpdG+BPlQIYRty3uJTFCgWbubZHBTsnmdn9eHvO5Qb03f3R
	 P1k7LW0/5XMSobR7LxXfMB4BZLpGYGHVkxMorePlQsCioJH69QoAI4eqk4+qP7DhOUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=AAhx5tLU;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=UfxLXbhu;
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D3C606A31E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 23:57:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99D3C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=AAhx5tLU;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=UfxLXbhu
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AF8C71400365
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 18:57:39 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 25 Nov 2026 18:57:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795651059; x=1795737459; bh=EnywwiTQrc
	ZqelGnv2BM/lEHrJaLyW7bQa9bM4nKeGU=; b=AAhx5tLUmjr1ARn2yQEvxpDpM0
	OjYuNTInzoWGwaWs834CfsWV66AAa8NKprbimKepMXbzz1a5XCh04LudCDxMNDel
	mmTGKGMGmM0qxNy2UVsJHpVAxx74+VBrfmIDQzKYaJL4wPImus+rAHK3fgwovoOJ
	wUqas9xUbAc2Nq8rYmhvaqL66ZIObrDgKgGokWQKWSNQqcRedc6KziDlEhKYyLLG
	c4/Fu4IVrWu71UReS2oPi1Px/k8BoJGgtYxUj78sWI8efy3Dwz6RcOJrgAfgZ7O8
	eBTggYIAAwsPJHTi0dgOfZCKzCr1Ri9Uv0n7l6h2QnUSxhBKa0oIV5wGjvLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795651059; x=1795737459; bh=EnywwiTQrcZqelGnv2BM/lEHrJaLyW7bQa9
	bM4nKeGU=; b=UfxLXbhuq+zsRvQ+WMdialTdiHAYmU1q6OfO3YIXtE1Ub5v/B6a
	pw3DhMB7n6ofK7gfVWNz4K2cYJUxUTqPjBbo/wyzjmVsWLpXRfIurYRQzhhdnS0o
	oqwUH9UTgLcV2JzM0FO4LcMNj98ZqBYRcUNFMzLVk0/4OUhSRe+LzRHWw+HfiUWx
	qZw+ZKpsYLNfDgpVDomEyLahXBXzqisHIO8ahu8Bbnkuj/BEupVpaheyK14fAlHi
	oYdMAyz+eCreWc4oiDCR7yp+b0O4Wdlia77rl/eS4In1TzEjHtartTOD+yURHPmH
	zrNZgNoPXANgPMab7f9l+/R7cOcMMR8fksw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795651059; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:gn0qWcXoVIVCNOC/zRsaWizZL7cgmkiN7Qx8Rmb7JiApwFA
	cYCTfh/duLVxKrojHtR2utEL/VJ0roHKDH0c2WXaoIXmd21/WzK2s52mIFiNJSFC
	rNy+uYeWbM22sfwIpnQ/hc7ln2vVPZYUaF+upxsyNwG6NBDNiaYSpl/xoeGflKEs
	FzueSpCBITT7BoB9Tzvg06g/1QBvK4alqW3KkIoS24fLe0OhceFOfffjSZjYBVgZ
	FHeRIqNaC+W8f0LxCAqv+7gKJ2nwaGKHa4jC61Ap01s+Uumg5eMr2O6QHeAbER9z
	ouqnpCnrKXd1+vYCvyp3ShHClD+Y9WPsH74aXJw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:bhSV4SyN4QuuAZN0MjBx5ImUu0rbVge8KHlB/GZEUZw=:kgqNc6ofSRAwDGCu3dLKsZqll+X428IOAM10uH+uPlE=;
X-ME-Sender: <xms:83UHa6zb8jZsW3LUpPCuoXENsJ39A1Ubzu2QOnCAe1mR2DvQBgCcLg>
    <xme:83UHa1ULvc_L42d6OIeVBsBVnVrKOvaYDBZsB7Du_dJRJFBHvqH6WGVcgQIUczUcs
    PhOm5JhC7LQ_r6XwbwgazjWrw_6TrhxRhaAoQhwiunnwZVI5o-6Ygs>
X-ME-Received: <xmr:83UHayjvlAfA-ZLYtqvIBb2ozqK8vqxgHx9lsOtG7qA8AZvZFlxleyp5OkZqvkX3A_FwJ_Mo5DG1AxpwThIoHv-m1hmKyqGcltmNkPQ>
X-ME-Proxy-Cause: dmFkZTF6ORVJVMkuVujgGv9LoLbLF7mxEB4KtnMA8tFOza4K8JyLPUaJESf1vCMEsVFLkj
    iu88zjM7Gq2hsTJXLQkARz1Ic8De2AK+/1r4iTbTcvCIwOPtftecJ0COql2QSjAXEzBist
    UAhhbSPlwahdhUpE2HtKwSTd/+DmJZA6ceGhhePLQsVfhY2A1xAgKF/M/uUMsVUOuYSB4X
    UaJ+/moTavg7D9SbNu4qxrtCiLjQhu7jdey5VnROqz+5ILuWrSSrlEVUPY9V6IutQYhkQs
    nE9wCGGt+HDnE6MbsmsTcSEPXpinc2/4YhICY0+/FvXeNDfhmdq4M2M5BDYxYc74e4e6ji
    Cz3w6F9ux67hmRjj1Eui0IbOuKwpVLNO2ODPC++LmLRqhG43BZ/aaFAw9PggpcdFxA+8p/
    WRJ1qvnJHio3ui6wvj+d4IqvSvigLPJnF4QZlaMkMueSuSxtfy+ycW6YWUUhinpaYdW4he
    /xffxajdxWvO3d8kHzC7pcyc6T4cp3co1nuxGJsj6P94JY27DGsuJlEmpyarMrbGKwJ/j3
    WljfNyugbwScJw6QesRjfOwxZLEYVTCAgsYr5PabU0bE23HzoKJ68RASrs6onmLZ4VifzD
    I8EH/sfvuoeE2rAQSPnQSkX/4tmx9frWofWcvV+2xdsiAapc5hdRDxOVtRBw
X-ME-Proxy: <xmx:83UHa9DhEKfpkvz4PCdZXDFF-DZk5UQWgusn_yiXfNMFYuRZHMP6sg>
    <xmx:83UHawuUDwFQ4w4gfeRz70Fxgj0aFclEtWPhyWUeAW7xrsNc2WSkGA>
    <xmx:83UHa5fof1eButSk6wYrcNp-xIwqtLlPv6nAS9WRiR0l8XAn_an7uA>
    <xmx:83UHa98CZQwqranbL-hEV5D1zwD1cSAs_uvrcymeoZV4GrPLt_gEig>
    <xmx:83UHa-EqyPcj-tMFrCFH4hIRjYlxOQ915ybakrUb7YGc_OUfYBnrPdGU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 18:57:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Harald Nordgren <haraldnordgren@gmail.com>,
  Simon Richter <Simon.Richter@hogyros.de>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 4/5] wrapper: add read_in_full_or_error()
In-Reply-To: <d45982f1ccfcb1d945b0be32f138627fc3552b55.1795640149.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Wed, 25 Nov 2026
	20:55:48 +0000")
References: <pull.2253.git.1791958171.gitgitgadget@gmail.com>
	<pull.2253.v3.git.1795640149.gitgitgadget@gmail.com>
	<d45982f1ccfcb1d945b0be32f138627fc3552b55.1795640149.git.gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 15:57:38 -0800
Message-ID: <xmqqy0agv4zx.fsf@gitster.g>
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

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Callers of the `read_in_full()` function want to read all requested
> bytes, or get an error. However, limiting the return value type to
> `ssize_t` is insufficient, as file sizes can easily exceed that type's
> range.
>
> For those callers that do not require the return value to report the
> number of read bytes, add a new function, `read_in_full_or_error()`,
> that returns a Boolean to indicate success or faiure.

It returns an int to indicate success or failure (not "faiure").  It is
moral parallel to returning a Boolean, but the polarity is reversed (0
is success, a negative is failure, following our usual convention).

> +static bool read_in_full_1(int fd, void *buf, size_t count, size_t *out)
>  {
>  	char *p = buf;
> -	ssize_t total = 0;
> +	size_t remaining = count;
>  
> -	while (count > 0) {
> -		ssize_t loaded = xread(fd, p, count);
> +	while (remaining) {
> +		ssize_t loaded = xread(fd, p, remaining);
>  		if (loaded < 0)
> -			return -1;
> -		if (loaded == 0)
> -			return total;
> -		count -= loaded;
> +			return false;
> +		if (!loaded)
> +			break;
> +		remaining -= loaded;
>  		p += loaded;
> -		total += loaded;
>  	}
>  
> -	return total;
> +	if (out)
> +		*out = count - remaining;
> +	return true;
> +}

All two callers of this file-scope static helper passes &total, so this
reporting of the total count can and should be done unconditionally.

Looking at the whole working tree after applying this series, all
remaining callers of read_in_full() are small or explicitly bounded.

The only exception is worktree.c:should_prune_worktree().

It passes size_t len that is computed as xsize_t(st.st_size) for a .git
gitdir file.  While gitdir files are tiny in practice, converting it to
read_in_full_or_error() would be consistent with the other st.st_size
conversions.

Thanks.
