Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794990318;
	b=2cFLfSmiK8cHxsAh8GKGe67MnYd0ox5pbPvxHgE2pm7fMSbWLAiw8G/SIo18DPX/r3YU
	 5tC//FPUtD0RW3mRFzqmdlB0kFguI+P9Y8Fu/AEEAVH9wm58w4gUKfleA7bpfjVGkq7GT
	 KJmxMJaufF2GUa5uKoB/EPqRXTMAvaZnBxl7EFC0gqeH5nKGMb8Zuwc7Oe4nUyfE26gNz
	 p+q5Ow/eASSmI5PiqWlj+rDKzu+t15ee8ACj7IDZQmgC6j19KlrvECjnpp0QRpo0nMFUj
	 HrbRbNmaLWIi2bNdaMKY8vBnzMmmvmVZa+3W6VTl9CxwT/vFJBUukmTsixdaxk8b1cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794990318;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=SN4AnSQa9xHJVIvxuaZJyS3NIZub3Ft8N5tGpDPdQPs=;
	b=RYfQmmDX4sQWmavVpP+QIfWSNe3b08O8R41v/K+31wQj4oVYhiedS1aNQw3dmmHg2+2x
	 XfavCSTz4MDM0hw9VnfNxdkIa6tvBZQGn2rdrhJLgs8Gm44WCqRz4OZUF9dTvuReg3aiB
	 hXXRU1SBjL+bhHuvyp8SO7hPhmzmCXfldug0u8F3HEScI0UUw/AuyB9vp5WQuRtCU57ly
	 AqmhiUqpA+Zj1JFfwKmROSkiGAuHTjcZwa3a2Ni/Mvhsv7e0sK7Cm/TGRRWascW8XQ1xK
	 bK5Cnp8zSfldVOwZPdTtAfiR14QxUUWmbROFKcdfIRyXfB1Woht7kmClNwLo1iFCkTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=SkAqgegh;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=M4Hwkpr0;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DF8606A31C
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 08:25:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2DF8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=SkAqgegh;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=M4Hwkpr0
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ABC62140016D
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 03:25:16 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 18 Nov 2026 03:25:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794990316; x=1795076716; bh=SN4AnSQa9x
	HJVIvxuaZJyS3NIZub3Ft8N5tGpDPdQPs=; b=SkAqgeghaTB18JJu4weyeNp3Zu
	kKHaJ8NkfutKjQnqE1xyAgzK7iyXzlNaZWbcoCkNXu098zIDXTOdxzLAovvHZ36E
	p6MfZCekJaCnJcMHPRGxymhLUObrPBh5J9X+THsAVcu9hRXN7uRzCYP9ynt7zTKy
	l/UKTtAit96zdljGlcy3GMDgHcFKekcObUZXNwUadlcGANgugU+0NDTjGhJBpuA3
	qaFTGREVNwS4VTmID7Hg+6EYrTb+A28ThJpozcSVbgqo5p215dOU1FJeW67f2ji7
	+pExFUTjfAYV6i+wvMfM4336B0lpVC+qyNxwulX/8TJ5gtuuseQpSXmlniTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794990316; x=1795076716; bh=SN4AnSQa9xHJVIvxuaZJyS3NIZub3Ft8N5t
	GpDPdQPs=; b=M4Hwkpr0Ph1MlGzjEkgp4wPvIgVvilE0CekY8NKZ9Ci5g9oqvPh
	yOubmaWNd71pyto/39J3T9atRM0ias7tSeOxgUscQcrFLDWeyrBfxeLt+Q5docaR
	x98KNzcN7w29mNrELr7G+uCs/dRjhZ5ghF5q06tmj6/1hnV9Fk4uA6hjmURLvjb9
	VOIv0ohECiBMQUR+61Ryd2DiIYbJ3f1jFD8dDnAKuizrEqJkxl1QFPV7F9iPAC7v
	tRmZ6OldmLU1cawlyiEXvvNPF7IeGbJ1uybxqPz3sD8T52oyvG83zLq0xzjhr+ZT
	WBlY/r9f8Xb0FbNVTKrH1TGomYxbBoozlDw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794990316; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:tZ3rAlw5Ekv+9VPPFzr4LPHG8xo9+p3qjrp9E3iPVfFT+kS
	NJX9d7vxffpAWDrtkm+IIq35HCAQ4KqzTocq27kJOO2HE3wExsHX1u/EcGXMdR/u
	FdfQpwWJqgYqYydxlt8Nc90novQeaRvKszVmngGET1B0wqZ/hzX2SuvjuV2kVCZA
	dW3sf6quRbfAUsvRJecCwgEyTnopCh4ljR9le0xT3Md4aRyPw+VkvEfriRTwiW0b
	291uTnQIXtulZ+oMzwI90jG9CA8ZDV8QffegiWx+6REmgYUr4T01NbFC15XO8yAP
	E7V+ZJOzyVbOogD09J8qecJR0yLkhPYRWF2O8pw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:FnNvgErvG8iDuj5TwWS0hC4k3yHUuiA4vbeOfFOAYXg=:+TWMPZ5nscHWOaUUA0X/gWdzHbyPWcO4Z0pr3HxSMwQ=;
X-ME-Sender: <xms:7GD9aj7i6V63SddkvzEd0aVAnz5IGmKBtjTn0ypUo0dwTalB0yZPNA>
    <xme:7GD9aslJctf0u21ZA6fgDYogHynp20jxfvPxCtE5oJYwtKnEr_WObEFrITerrDn9w
    Tr7sdv3l5CeMfISh1-c8_pwVw0m1yBsuM_-SWbbcADUIQNCsAJbS28>
X-ME-Received: <xmr:7GD9akRbAwb34t-f9ey0j-VpXdNcKnrjRlIAYwO_f8J2gOdXaMw5MA>
X-ME-Proxy-Cause: dmFkZTE55K3u9ahwWSLJ9WX6+RIaO3TJDWTAKz393EzLQGQUCE2cE3ExOSEvw8R66I/TPg
    Y0WFBr2+rfZjBIjuonTRK//T3nsmWFKqP9rPQoHKEw5JpJaqvJODCzmaBzJI0qblLf3R4a
    u4VkOztGnxYtv//+i4+fsj9XT58VL39W30wPSO1UA70iIvrzyI9e80evUq1fSf1Yf8tpGi
    YOl4JxDbnI+7FgVIV2LXC+3MDRpum6Vg4t20JGzE+IwSnOvMWrVV4cZrdrivyHdKlAuYlw
    qVYN1jxZvA43zFmhRQjMImiT6xxXSjwOZaM0k+j45qlYwFMlm9rk6LVbzJGyDvTgp9pldx
    ENZbgyeIjTQTDOnl3ey6iJZZSPCdWw+cpcjXNns5vArerwyxWFuJ1DELIXEqYC9P2ROeuk
    gKfc73XTy0p3pYhTiGxWwLTAnLLGcZ8zpzP0/THai2STgjz2cfGGG9ouJenJ1yroJwFQgz
    TRuSp+3LhIWWSMuoBVADnVyTxU5by+xlX6E49u+uwPOP2p3xEudB13v1M69NBtoilJPL9C
    XJveHdOF2cKjdx6/NkcjJh5H+jv7rXKuYJ1tpZt+G3mR/ecgs4gfn0VMj4hrIf5RbUiMkH
    h/6v52hShdIJJtwm5LzOELiH4YgsNDpLun+5XXlr0P3kAzJ2U+hOl6Jo91BA
X-ME-Proxy: <xmx:7GD9arFjCpIe79ppnW_1kN1ib2LMCOLJcewb9w9912-RljQ_R0jo3Q>
    <xmx:7GD9apFHn09xN0-FR86pnEQ9o80i00VUK-E63etUsTVhMiyXR1Czvw>
    <xmx:7GD9apTd-UfyFK7QKHmOyTXUInXQgKkDVx531CdxP56pPoEpOwplnw>
    <xmx:7GD9aqLG7szWRSXOrvef5DWsqUimhmNK_tWLTMSkuj6j_I4HxQIkaw>
    <xmx:7GD9amB8U7KP5-KDQ-puTudH62NzPHlx0h8ywo6m5DVneZf-aDC69g3x>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 03:25:15 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 347c1b6c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Nov 2026 08:25:12 +0000 (UTC)
Date: Wed, 18 Nov 2026 09:25:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] notes-merge: use size_t in write_buf_to_worktree()
Message-ID: <av1g1O5AG7wR7tjb@pks.im>
References: <20261117174353.1158905-5-christian.couder@gmail.com>
 <20261117174353.1158905-6-christian.couder@gmail.com>
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
In-Reply-To: <20261117174353.1158905-6-christian.couder@gmail.com>

On Tue, Nov 17, 2026 at 06:43:55PM +0100, Christian Couder wrote:
> The write_buf_to_worktree() function in "notes-merge.c" has an
> `unsigned long` size argument, while its two callers from that same
> file:
> 
> 1. write_note_to_worktree(), and
> 2. ll_merge_in_worktree(),
> 
> both pass a `size_t` to that size argument.
> 
> Since c6a4629e32 (odb: use size_t for object_info.sizep and the size
> APIs, 2026-06-15), the first caller reads the note into a `size_t` size
> before passing it on to write_buf_to_worktree(). On LLP64 platforms
> like 64-bit Windows, where `unsigned long` is 32 bits, a delete/modify
> conflict on a note of 4 GiB or more therefore silently writes a
> truncated note into NOTES_MERGE_WORKTREE.

Heh, this feels like nobody would ever hit such an issue. But fixing it
is the right thing regardless of that, of course.

[snip]
> To fix the truncation issue with the first caller and to prepare for
> getting rid of the check, let's convert the size argument in
> write_buf_to_worktree() to a `size_t`.

Makes sense. I've been lamenting about that before, but I really wish
that C wasn't so painful to work with in this area. All these implicit
casts are just so error-prone.

> diff --git a/notes-merge.c b/notes-merge.c
> index d361e70a48..4b010bcfc0 100644
> --- a/notes-merge.c
> +++ b/notes-merge.c
> @@ -310,7 +310,7 @@ static void check_notes_merge_worktree(struct notes_merge_options *o)
>  }
>  
>  static void write_buf_to_worktree(const struct object_id *obj,
> -				  const char *buf, unsigned long size)
> +				  const char *buf, size_t size)
>  {
>  	int fd;
>  	char *path = repo_git_path(the_repository, NOTES_MERGE_WORKTREE "/%s", oid_to_hex(obj));

Looks obviously correct to me. We pass the value to `write_in_full()`,
which already accepts a `size_t` as input parameter.

Patrick
