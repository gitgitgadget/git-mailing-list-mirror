Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793985661;
	b=DaHp1nUA6fWV9fd4+KWmPM4zAnO+/nEpV2wBvu5u/co/7iRu6/quv5SzVCEqNUGtI7ER
	 USy2eVao9/SJe9p5dLPHGvxIDAubOsDEOFmD2b38zaiTJerLHnfbOfbYoG8iJ2vE3lTpF
	 RTMlWJ5ho0MY0FilWAIZa9O2YCfAUsf2/XRcwXEJjIjeKpcIKcWkxypgMQoh7owUM+3AS
	 wXkkHMK/cxBPmEkpt93qE/RIBjkC53w2SG9wZS05U72Gv++IDhfIE7DG4ifY9Dj9rrVFD
	 QsJ7gw8HhsEG7TmrerCu0nLaXGLsc6zXBgz+qvAFHIdWai0O/op4a41CMhwZtFL79ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793985661;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=jnNb9x6Bx7dPKO1E6ruoX9y1upV0PUsQld4MrT+CbwA=;
	b=vCjRa5evwkacHQYQFPLry9Lm3RRoKrt8d6c3CaBJquFRpjJT9Zqm+AUoiNY6wSVAbjGg
	 rV2w5EuIA6yCOEE/lErbUFFO10we5pTikNtkY8tAuM7wYpiI3DkK5h5Kq/p33b0N3vays
	 zHnS2E8XW8VXJXEFvhpo0KP1KaHwZh19OCWt8d6E6ArK4tQ1gTkSCQp6cxQK1nWr9uX2S
	 VpEf6B5T+aAbxvG+UsMYIhZgB+6aRahgCCjvi3Scdo9n1ddge8qa3Wu/iz/AO0LJxaoWw
	 9wS/vUExDU1iGvX/muwQD3UrSUpOmjSjHNDYdrSr72rSrs1VODxxfGwp19YFg0W+WNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=ArjCvKql;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=zF3pOb40;
	arc=none smtp.remote-ip=202.12.124.145
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FBB606D801
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 17:21:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0FBB606D801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=ArjCvKql;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=zF3pOb40
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 025A71D0016F
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 12:20:59 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 06 Nov 2026 12:21:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793985659; x=1794072059; bh=jnNb9x6Bx7
	dPKO1E6ruoX9y1upV0PUsQld4MrT+CbwA=; b=ArjCvKqllJo48KM6A9axcDhWKW
	PZpyNaWejAY9Sz0NhZHBkceN9TOWjDn7/l31hZ2+X3+RrSJb5itz6Wgn0CCEQeJp
	dR8eBDO8rFm9KI9Vyp3P/j2lsuyGPriNow4Xz2DwtSgtJFc1d6C8TiC90vjLis/D
	iw8/U6pkDptFEB1S3o1YayvK2RwTubAQeQ94D9EbaghoC7eZZ1MsD9h/pmoMeOly
	LZQE+lMGPnN6D8a2GT3TqxGaxSlITgrDkLwo8YQPrO31FvPEoWrh88xlpBTv4QPH
	8zDSwkaEp0H0O9Wrjptaqwjlm5FBLg3BqW+e9VazBZ+5ZU/WGmPHPq6sLu6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793985659; x=1794072059; bh=jnNb9x6Bx7dPKO1E6ruoX9y1upV0PUsQld4
	MrT+CbwA=; b=zF3pOb40aqu9i8t4NDF8J3g3feMPDlDnAFsWDmTCtm0euPmjgoz
	GmYAB2Ag8vuHFstY2veCA6yktt0SH9miZGuEJK5VpN1s0DfewxKteBDop1DDQGi5
	tVdfSn7Ac+FlDBzhoDs+UNEJvJUwTyrRe/qDeUBBxjaLtF5zHrlcZpeI6H0eSZJC
	SmfZngbMjSdefHv9ekEMoS+1aXLVAeG1j9ou3DqnzPBVp4qNf1XfskNZ3RdK3XW7
	1Xoc65nX6WnkQ7NJ27ImPdEDK/1SDsQgXy/R7CN5NNsLTnz3WSjLuji3C3WF2rRB
	z8AmV3Ymh5MJiua+9zihzD6Qhg6AFvDKNvg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793985659; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Z22BaYmdnOtt9oBlHN9+bZmMH2a2ckVnslg3BCWatlSkA30
	TyfwAkQkViXkFvLmnnpavd8pyCj1nJBsP+pCBQvKIpvuf3ExZ/xSf05Myvr5Excl
	mBC4zCU00/gmnfIF7hu1ecmFkH18n/2Xl3REov4p35pabU2dYUGOgsFdei04TEI4
	SG19Q+JRymFpqQmPTzLNwIJf+c8kuTELoZ2rDIXyxgXxU0dgFB1tpfXVthlqqve5
	VKiczTmKyoLYl2JGrTKiyE8hdJbTLzwFGkIL9+SxrptwMjNUZPHPVSc+DR0lE04y
	BFnAurZxf5Dygzp/czkt8oJ3Hdtl8RLtQ5v849Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:hnWJ8W9MAuYwj2tBtSAnwnGE17R34Zg6/t3EYM4wWWI=:opsqifeOOsfu5fLsluUsPxfjkohjFLYwqGAX1FDfofY=;
X-ME-Sender: <xms:ewzuakP8o2rfWKvr0S4t_cAZfu6FJpXaKvGB-o1ZhhINmxhQntA2UQ>
    <xme:ewzuah9bacey5Y-6MUld2T2EIDqTMCghtebr9nOtwH6nu4EpWPH-mrFySWXmRgIST
    6tqT3F1X8PLsdtutSR4nJ5mDsYI4cmR_I7oDE_DspRgkjVf0ZLMzao>
X-ME-Received: <xmr:ewzuagS0N-BFrb637gx4jVsQW9AtCwXoGtftnNxgjzGlF73VSC5sI7Z76eJtbmCKGzMU5kM50CYZCPhm_0_eNUu_1BGc5XWa9sgy>
X-ME-Proxy-Cause: dmFkZTG2AZsztUPeVO2V3LbujkGJjqv8LsSqQTAj+T92piGXwEEdAtc1n5FO3ZK+ErjxrV
    czaFhq4JigSylBUbSYf64qpminAgN0wDEU+LgNQgWyVMJf5ofvWMlPPTPSe/m4amoTnfoe
    XOs0TbmT0NtacKsGdA50kv5c13jT1Kf8HwvmQ/SW1qvircvEtIVKQi4Kbf6f1LkZojPPfh
    0Fw6AFnty44KjE+5lgHmiuI/nVg+OppL1b5+CPQhi1CWKEwFtypMBejAbsNMXWOXFjgP7v
    wsb/wrtnSpRq+vkZmN7GY0qOl4ubE+G9zNOlproQDLOxXe9Jp/w/GinSwxkKEjA4m/u6KC
    I+jUs/bp2kki+OWXZhSUV6ibMhbxIzsPDISRI0nRMx5dMFvNhoRLTUjz/EvNKutwdN7nDg
    iWlFv6hMYJOZBN/fANdNfBgaExqtupvqOP1lOzN5m+SBelY+XUy7s/8PI0qFgzLYMLwOxh
    b2ZqI1uSDlLeTAW/VLs4EBRKfg3B1RclV/8jEKfk7qEQ9ncfExXHhj/DyDvz94/ti74Cos
    qePkeXkILNwUKjpjoumj2A++xQYdVWumPOlAkEcs5X8KifR2NAsYK6JPgyBOYzA9v/Nk7S
    NDhOXJ12mGd106vQbFhVzXUufRwtxdhAOdjwY6d1ed4Cc5j0qinwsTdDCqEQ
X-ME-Proxy: <xmx:ewzuarlLQ8iP920Ok7noJAXfqfJoWqUZ8j4TN6QOvwJJeMBS2Hc6Ww>
    <xmx:ewzuaoSpfKQkX8DDzJqIMfK4mBq2QvIYIFjUqAZCpkwhW6HBcB_SKg>
    <xmx:ewzuahMTpxX0-_GPP_zefo5RkGqg-sV4vuk6q6zFakRejug96tPjqw>
    <xmx:ewzuapVEteoVQj6rm-MQeRqY4O4VeyEUmb_bk2ZjARoqqnjarT6m2A>
    <xmx:ewzuauOK1f4IM1FIe98iYdTpmLcSYoK57qphzkfeN_TxYeejyFSznX3F>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 12:20:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/7] gitlab-ci: speed up installation of Git for Windows
 SDK
In-Reply-To: <20261106-pks-gitlab-ci-speedups-v1-1-1fa0374c7287@pks.im>
	(Patrick Steinhardt's message of "Fri, 06 Nov 2026 11:30:01 +0100")
References: <20261106-pks-gitlab-ci-speedups-v1-0-1fa0374c7287@pks.im>
	<20261106-pks-gitlab-ci-speedups-v1-1-1fa0374c7287@pks.im>
Date: Fri, 06 Nov 2026 09:20:57 -0800
Message-ID: <xmqqa4nllvuu.fsf@gitster.g>
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

Patrick Steinhardt <ps@pks.im> writes:

> The "build:mingw64" job on GitLab CI downloads the minimal Git for
> Windows SDK on every run and then extracts it via `Expand-Archive`,
> which is expensive.
>
> Improve this by caching the SDK and by using tar(1) instead of
> `Expand-Archive`.
> Note that caching actually only gives us a win of a
> couple seconds. The bigger win here is using tar(1), which speeds up
> extracting the archive from 3 minutes to about 10 seconds. Regardless of

Wow, is a tool to move the bits from one part of a rusted iron
surface to another part really so much more expensive compared to
another tool to move the same bits, to make a difference that is
worth doing this?

> that though, caching the SDK feels like a sensible thing to do as it
> removes one step that may spuriously fail.

One thing that may make readers curious is if we need to worry about
this cached copy going stale.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  .gitlab-ci.yml     |  9 ++++++++-
>  ci/install-sdk.ps1 | 26 ++++++++++++++++++++------
>  2 files changed, 28 insertions(+), 7 deletions(-)
>
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 9b7698a0037..15419a954b3 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -127,9 +127,16 @@ build:mingw64:
>      - saas-windows-medium-amd64
>    variables:
>      NO_PERL: 1
> +  cache:
> +    key:
> +      files:
> +        - ci/install-sdk.ps1
> +        - ci/install-dependencies.ps1
> +    paths:
> +      - .dependencies
>    before_script:
>      - *windows_before_script
> -    - ./ci/install-sdk.ps1 -directory "git-sdk"
> +    - ./ci/install-sdk.ps1 -Directory "git-sdk"

Is this change essential to understand this patch, or is it an
unrelated general clean-up to follow some style rules?  I notice
that ...

>      - ./ci/install-dependencies.ps1 -Mingw
>    script:
>      # The minimal SDK's profile resets PATH.
> diff --git a/ci/install-sdk.ps1 b/ci/install-sdk.ps1
> index 66f24838a40..1dbcef04a18 100755
> --- a/ci/install-sdk.ps1
> +++ b/ci/install-sdk.ps1
> @@ -1,12 +1,26 @@
>  param(
> -    [string]$directory='git-sdk',
> -    [string]$url='https://github.com/git-for-windows/git-sdk-64/releases/download/ci-artifacts/git-sdk-x86_64-minimal.zip'
> +    [string]$Directory='git-sdk',
> +    [string]$URL='https://github.com/git-for-windows/git-sdk-64/releases/download/ci-artifacts/git-sdk-x86_64-minimal.zip',
> +    [string]$DownloadDirectory='.dependencies'

... we are making a matching change here to upcase the parameter
names here.

