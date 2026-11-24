Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795541646;
	b=Q6IrcEhKA6NIilQ7iYeUZ8s5zgImbqDkjh1cFeYmvCjtDuTA7HW/vy5gN1awIJP4IYs0
	 PjUL+6kWEWdKVzmUwerYR8Po67i1pMzf90h+2yVCfXSNKiVyIfF4BF4vq8/5VXGy2BgtP
	 nzN5n+3Hk46GWIHLvTT9C3CQqJjnXkNx+P8d72gPwQfNIkbEB0606MD0XRYerOkdNw1GK
	 mVId2Ns76TM2aW8iRKRtHpcvq4dABb1JzzsJrGpz55oRYq/Ogi9S/3yhh5K8wdcntnP3i
	 BkZkY+OSNv01JuPOqDqo/lbc7ZZKFo2VMJIcvyG6bcV6lkTqR6H6PyK1jTUs2x/OnIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795541646;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=fc8y+pKyRY5pCpoFllBg7YkXlJrPAavQNQzrJi0sdRc=;
	b=qORV2ctNAf7Y3JxScVMUbFft3/ieWhUyYiKbb9s5wrdZmHoJn+z39gjcZRGfcDFGJfbl
	 BViek0uw4yx7WEfi6l2mbHgD/S4hV6mieVHMR94InGispCHshJIUjVROy+ITOCeIrkWyN
	 oZ5K0f86wgiNgbT5sfZw+vQG9p/yJk2pKo7m4mIquXKAtOy8V1ag+BWlBcxjCtZ5VaRju
	 s0hd+PXZSARCVpX/MGzBxXpE5eJ6Duerf/luzi8uEn+ABQCxKL0+3FCIcibP1Whs/bv2U
	 ji6sDES8r4MIDHVfN0V6juJRD1d7b4t2evlrhhRIir7C8xvFN4mnM6v+SIBCdTwyWJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=StP1vFLu;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ojKTCyDB;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88451606A321
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 17:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88451606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=StP1vFLu;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ojKTCyDB
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id AD128EC09AB
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 12:34:04 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 24 Nov 2026 12:34:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795541644; x=1795628044; bh=fc8y+pKyRY
	5pCpoFllBg7YkXlJrPAavQNQzrJi0sdRc=; b=StP1vFLu9zo1OTsAzFZ/c81hYN
	CzqL7AuUJtxs/8lBtMwcYxWSKmrvo8Dj5MQTPRdVymMy3C4uQGX+pZs4bu6mVXMH
	ezFRBdBiQ/a1AMXNXvI8e3Oh4gyYSj+XWxkl9d72M7jB+EbMBisqsvCgTvxX+fzH
	Rkk83hGoqTT6bLEKQJ44JMvZo23j7Lf/v9hV9BbM9FyDf/vW5XtBke0IbHR6Hzm5
	gqugZWRWEF5ftJVHEMX5eb3+vFxllP5bfnCYw5rXjAWAKhEPrI44kDEQDRvEbOCt
	n02L+5QZAheXj8IIuEmyjaqBmXHS0yfxZqI3qEeyeJzf1NMFhyNCbVVnKbTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795541644; x=1795628044; bh=fc8y+pKyRY5pCpoFllBg7YkXlJrPAavQNQz
	rJi0sdRc=; b=ojKTCyDBrIQGoVXNjh5Q9btXc4BO3DaR9o4i5bKwlaN1cAEA3qc
	HB7T7Q3GEMmrGRbfH9lPRKaMQYyk8JcXe1h1CZlU66cGXyWVHwC98m5weRonOkbh
	mFKy6c9zIYBRIkxJPrQUZFFg3G3cmSAuohfr/rOowtvAd6AIphuKej0EYQkPbd5d
	nsYUatXBihOhl/nsWvRybzpE+IUV0IShC4BKJoPGr99aclEJTpkpgmc5eoxp3L0A
	hcvQo1UxJ0gZdvmT1medmF/idmbhyfEnjfQWQTtz10m6Z4mG1URz0eDuHzGVt303
	GyX29TT5yxUKw3SiGEGLPRS4FH9qQH5YByg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795541644; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:BPVW8ZanOSFY0NmcrToC6tvnbaDKpbJFd4l1JlNl6nEJYtK
	ypFJoR4MxOl0XM7e66tOtjd6FZeiyLGqGpGDYo7TUR3zrWLNacI1IOisGsK5N05q
	O5aNgJDG4iJJ7i5FQRRbJE9MJOyoQBItQgAl/3bXu4imCwr/9cnylzdC10LOAexM
	t2pi1cwgcOBbD2ykVlt5s6wU09JPOEDFmatdth1l0w7vbMcMAmKx6qSzZVw4dlCY
	+SNQjcaCA8qTAkzBpjFqVUG/avNBGEjEIskOZtLLsnE1tZx1BvD0Un7l+/RUeigg
	RoAjpxeBkr/j3BkhtsORtsRywmLhVhXErEKhOtg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:NvqaaH2gGBKNkLZbeyqEMRkTEhCioebjoD8ZkabqBeI=:191oSuHrYGuIR8qVqz1jiVlraoFU5XQ0Kclv6HKA2XE=;
X-ME-Sender: <xms:jMoFaw9LlB-X2TlIxYoWa2uAcSlp4IFiR1OqfZdOKXveTOEWP4oWUA>
    <xme:jMoFa3xq0G9dEWYZoOBw-1y7xGY5mkYpawbDoOIaofaP5ilnTPeUKEP9WYmRvfcHU
    fGmnddOY3dwHYiL7hK3nthN6hzax4_TzW1kWmypnoRXL2uF9_dhWbU>
X-ME-Received: <xmr:jMoFa8N8RSGcQW6feuFjr3NsLvADJ5nN3lA0X5H7X1DKjvTrENpPpgUgpvz1A653QNNj7E_xj9390ZkoEEtTWleXQ6_buLYuotJ_DRM>
X-ME-Proxy-Cause: dmFkZTESkUpTut9PaStZk75vyrV1fjbgdSEUeAPWjFnziONGgqJk9jhSwnH2Awo9p8LsCX
    /vjHpDr1Yn1LOaGrs90e+Drrz1FRBXoPJGEUvDLF+0TC+lTn48WhZM+2DL1eOv+W5vUEtZ
    1rg/VefX+5SBzUcT5TME1D0C0leHkLYTKi9pcXimjTSAxYv/rbqXJP9DiLbPGXN+8WOCl+
    RZZuu8Z2QIkfbcTnbYLyyUujIUH8l40IjzmRNd9hGLoHtryp7Bb2X8VQvnwbdLrTKNV+7X
    iDxTCfGrJHEqaoDQXudNSVd/1eQ3gJjaawyQnEA5Tzc+lOfBFPo1m5I6VwR0RPZRdDoDkh
    Vxlvhy3/QgJA2OBSC+0zZHLtyppycH/HC5nk2ldY+DM6O0vwTaGRdf2+f0jKq+Eteu7PcN
    HdjVYP+Mxt63Gu0JZppCYcpS462z2hP30uhre0puuqm1FgYs6tCrHAhRu3X5wrSkdWquKd
    LWkvNaP/N/mHgpT05r9088lSxEdpVWL+A74vwAvpGJDDC6dJWXzj7NYu420+bjusQiHoaO
    K9YCAGYlJFYaien4FHao/ubq/gG5RJ5+0lLFdtuVxGHBbfykGTG62fheIyC+c2kx6gMP/y
    ppfEBM+kHveXbyY0/52E09vuvi9NMNvjQ26nt874gw7+mT6W/+T9tc5HZoJw
X-ME-Proxy: <xmx:jMoFa89uWivDhfEekL3UKHgvPNX9pu_K_tk6Zc3La_f7v02PISnqvg>
    <xmx:jMoFa562IYaGhqF60mXLvyx11ya-GIN0hO5gUzjvKlKzgTy2kp4yrA>
    <xmx:jMoFay6zzKQg4l1iliY6W7_OzJhhQfvs4BUsqu8EKybymPKrenuNOA>
    <xmx:jMoFayrvTqn1pyxkOWtkCXLhQk8hE9dpebHyZefyuUE40hzq_N-lLg>
    <xmx:jMoFa65Tp4Xakh1DSBdqgLXArAuvCq-ZuR9IQtdYu1zSaDVk4CiJYcFR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 12:34:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Harald Nordgren <haraldnordgren@gmail.com>,
  Simon Richter <Simon.Richter@hogyros.de>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/5] archive-tar: guard get_path_prefix against
 zero-length input
In-Reply-To: <bb8225547fb67224a199137ff50a24720b4e506e.1795472027.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Mon, 23 Nov 2026
	22:13:42 +0000")
References: <pull.2253.git.1791958171.gitgitgadget@gmail.com>
	<pull.2253.v2.git.1795472027.gitgitgadget@gmail.com>
	<bb8225547fb67224a199137ff50a24720b4e506e.1795472027.git.gitgitgadget@gmail.com>
Date: Tue, 24 Nov 2026 09:34:02 -0800
Message-ID: <xmqqjym2t9px.fsf@gitster.g>
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
> The `get_path_prefix()` function uses a `do ... while()` loop that
> unconditionally decrements the `size_t` index variable before checking
> the loop condition. When that variable is 0 on entry, the decrement
> wraps to `SIZE_MAX`, and `path[SIZE_MAX]` is an out-of-bounds read.
>
> The current caller (`write_tar_entry()`) only invokes this function when
> `pathlen > sizeof(header.name)` i.e. when `pathlen` is at least 100.
> Therefore, the bug is unreachable in practice.

There is an off-by-one here.  Because header.name is 100 bytes in struct
ustar_header, `pathlen > sizeof(header.name)` means pathlen is at least
101.

It indeed is unreachable in practice ;-)

> diff --git a/archive-tar.c b/archive-tar.c
> index a1c66024d4..2da6e55484 100644
> --- a/archive-tar.c
> +++ b/archive-tar.c
> @@ -210,6 +210,8 @@ static size_t get_path_prefix(const char *path, size_t pathlen, size_t maxlen)
>  		i--;
>  	if (i > maxlen)
>  		i = maxlen;
> +	if (!i)
> +		return 0;
>  	do {
>  		i--;
>  	} while (i > 0 && path[i] != '/');

Guarding against 'i == 0' after capping to 'maxlen' protects against
both zero 'pathlen' and zero 'maxlen' before entering the 'do ... while'
decrement, while leaving 'pathlen == 1' (e.g., "/") and all longer paths
unchanged.

Looks good to me.  Thanks.

