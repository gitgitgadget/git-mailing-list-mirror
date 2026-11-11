Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415485;
	b=zLDSBYRmG8uZBNFXqtQb8OuYwX3a/3i8OQBu9rDHIfRxcAUbxq9DHXdMLcs82TbnyMsD
	 aj+NuXmHVv6yol4Oer32lIe2xNXT1OHREw3ddRRkzcd49INPWobCGMPoAdvqyECsRYuN3
	 c/4sW6RmLIEyJa2CBGPiroxAboh7D83E2zrlTZlch3HsruB4FtT5NOMOjS0K+zWPIUslx
	 Mag9ky9yl/LIeEjbpgckCAqreqpWNnHjv4eoGfj17yj1u/Y0aGUrQ8X+Av6HPskMztTeZ
	 K90xOl/mnp7yo7JM+RUs3PsstCU+imZKSYIkXDEfZL2LdzuPzIi0LplFKfcVQW+X9Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415485;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=z0b4iehW+Cflo4DAdtMlHH9Dtcev3BncGBtXnOAE8LE=;
	b=QfgiBGBEGpn7hOrN0IeskGFqWP8lf7cZrEGDwiTeJR20g4lgrMIe4ePM33C2USQhkYD0
	 FbcLUS9JGzsjKc6zQGF0RJ1gnDH/AdBYUQObRtbVQt4/8xarsS2Nu7/RIm6yO3xQCruaL
	 Ed7tcUgZblTb3e9hTRsS41+kB4bqU8AgUqfHy8YVE7UcZ24ivNm07ttUzIbtlxtMxaP/a
	 eokxJCQZRB00wcvjNEp4qfsW3sIaUx0xQ+itkla99ZAIFwAqoOZsAP279DPqDLP3/K8sC
	 8xiTmBD/mwPYbJUY8/79ebQK8VmGmIvkBkvz1jbtOYOKtqU0Gy2hvUwQkDDDoPJNliQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=RmZ8NXRU;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=xA8U+qlC;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6A7606A31C
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 16:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB6A7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=RmZ8NXRU;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=xA8U+qlC
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id EB516EC0110
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 11:44:43 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 11 Nov 2026 11:44:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794415483;
	 x=1794501883; bh=z0b4iehW+Cflo4DAdtMlHH9Dtcev3BncGBtXnOAE8LE=; b=
	RmZ8NXRUWJd932WlExMm+BxBFm97ANqgsXhiATukv8y6F1pq2Mhv1hnChQ3qkIG0
	c7Zp9hq7vSZMWm8wJ9eBDFhefSh6BNoeWuPn0gPK+igpjT+Ikp3g6McIF7CZRjNJ
	0c3n+r07rrBAYUyzEhZbXq+5ztn8bW60i9E7PH1RXF/0j4YRrNKWQ+S2uykVpqZZ
	Mig/mtYc29aDVGeVSw3XN8vQFRcUPVGb4vTbZmHILG2A/OLNdVvoGU86wSuYGtcn
	+AK26eDiaPnMvB38Ra8nT9mcfzwLl96RGgok5UQCylK3g7qI4IVynRv9kZXQ6u56
	/AgTI1ZV1+4KhtZvGwymJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794415483; x=
	1794501883; bh=z0b4iehW+Cflo4DAdtMlHH9Dtcev3BncGBtXnOAE8LE=; b=x
	A8U+qlCnyee5oTBTP47LD/VwiAtUMkk2i1c/Hq2S0PgwwqnwHYy4jJPu4kjfKYvS
	HVPtNnqJOXyvIChiKUccF7Pz6444UZWrcwuJPYRmBkbgLibNx1ZeRIrS+euvbstf
	H010pD/sCdtyzxEizFj8cToa8a0msjdRgRyKVPzGDJQjsSzit65PuaRRS28qD0RT
	ZkLEHXkQvMWKXRr3YqGoWd+pxJtxjMPyUIdzvNDgulsLIz40DaQ50JtNKEYhz8/2
	25BCGLNSmF70s+oOUwZ49Qi/697e7Ef1bJqTtvcM3quFAmJwrDCzweYLmYJPXduZ
	mVKwLmqJsKs9XKpo3F4Bg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794415483; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Nkr5UPCJYrlLQ1ZTMzjBjiIQo1cYGrJ8INuG6I9WCmG1Zrd
	Im3Kz1tU+uwEXX117VEuKIOyukK9ecthvAC+Q+RQnptvQ8WnTY3SKnOxillf5Y0H
	8cwsEzniUbXWsieDAcGcpRJ49b+jX0h28i5iheGFAtOTeqIPf06gnSzdYG4EK0/8
	A6i2chWeU+j+CiaKv6L/v31mPBfxFp8vvqFd7QZ5jsyQ3ZWQ7FSN5VWN8M6DJcBQ
	D1o9h+M0T88R17T0Hal/GWWnAla7LPmGiU7yZbNCIt31RMphSPzT+AXh9ZRlfuhU
	3SBL/1gVJAhP2Gb8RC2RWo4Y6w4t6NMDevzgkVQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:NwIsAAj5zMNsfWum8b5WRgCzsbSO1UaxwFgKIWuY9ww=:eHJ0k7nOGIINE291bbLm0ngIlkic5f71BeJij9GnKeA=;
X-ME-Sender: <xms:e5v0aj9dvzXMu_oyaJokepvW3aNUjsMKIfhLioItYJWYZDO0tdtWsA>
    <xme:e5v0ajaPxl_6eol2nqx0UU7QQpmQekSDjX5ydmdHNmu-pI8Mw6X1ARe75Vjdz5pBB
    A9ynhQmcRsCc64NczJkYXlNZoPLjZH5WywlwooDOlwDph9M5gPkSkCF>
X-ME-Received: <xmr:e5v0aq3YwE6_8VgSh67UNlM7BSWSeGmQH3SCgA3uceSCLX1yNh619p1YXhTzsBgkqV0QEeACmpTLl2W-4GJCJHfbe8xqm4Sm1G7Z>
X-ME-Proxy-Cause: dmFkZTFbgmzOXRSAy85dKn8SaGdyoOFjrYXJUMbXDm4qCQIAXe12onbGufv3kkMvvumH84
    FXGECDcq6dtNNEQ9NwqOQggDR4L0RSYPskNqeXB0ivNJxkJNlwEqOkRUv4gQ+aNXIqEm/Z
    t/LtHx1aQhFOo7Gp2ozY+q82ChxdmvT1jFolR6Y1leKFNYOko/AVN4AHRztPRGVX/NX4zN
    gEkF6zoYMXM/IHk02iiOgQekIQWRhqabWUgnxKTWi25SXnNMStZc+gVvCT/ZYndyT4eAZF
    utbAumNZ5vxqJOF5DwCKtKBvm45sdsnGM9u2YUztOr0J8wVD3vUcmVbqIR2eF30a5OkUW6
    pElQiUvO1IwouYDplKAnSX/cGeCV+fBNl+Wdm3KuGw59MO1Pidtc8wQH2BLiMMfy1NBuz7
    EOJFboCYjVTfYTTpnMiU+isLrhPD3a2TuLz51mPdXIotcq7SlZhzcyhqEzu+IeDxk5y0y4
    0K2KxAS3T979RoYOHBSSS3zIrGjTGRdKSIUXx8WUfoDePjU+3OV5CchCGa3c7pbZDEoHcd
    UuJnSfiED25qzM8QL5XSC10emLj86cjsR4UgrNmqjA8VQOyx8m011UNGeYQOnzGZpk7uaY
    wujA9dN7IKA9kW/seS943V/HJxLMB1dZon0GRxaNeNJtiUCrgRJitr8KFx9A
X-ME-Proxy: <xmx:e5v0amYfMXTy3RZ_PElcwzLzJTQJTK6lnMyf3yal99oORNZAheOy9w>
    <xmx:e5v0aqLRnWf1PC8Bok2NIAFNNvOAtDVAER9wJyb_Mr0FOyvExSVttA>
    <xmx:e5v0atHsETV8WUafeDC6A9KEDKLiMuqIFOUKKYe7MQAPTvVnNQqZEA>
    <xmx:e5v0apsRGlCayI060w3pLRex6sJcLksO_Y2ZE1qpb0OP3w2CdusGHQ>
    <xmx:e5v0ao7xlTJKHoCZRDpi1U0M7FMZM0UGdxJQ7TP9vE77b2fT_3rtGw_M>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 11:44:43 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: Miklos Vajna <vmiklos@collabora.com>,  szeder.dev@gmail.com,  ps@pks.im,
  git@vger.kernel.org
Subject: Re: [PATCH v5 0/5] log: speed up --follow following renames for
 non-linear history
In-Reply-To: <avOzVCHdGBNIG8sT@jtobler--20250820-SHC54> (Justin Tobler's
	message of "Tue, 10 Nov 2026 18:40:00 -0600")
References: <cover.1793298331.git.vmiklos@collabora.com>
	<cover.1794078554.git.vmiklos@collabora.com>
	<avOzVCHdGBNIG8sT@jtobler--20250820-SHC54>
Date: Wed, 11 Nov 2026 08:44:42 -0800
Message-ID: <xmqqo6bvnwqt.fsf@gitster.g>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Justin Tobler <jltobler@gmail.com> writes:

>    Summary
>      git log --stat --follow -- include/linux/rsc_table.h (rev = 304812ed33 reverted) ran
>       14.30 ± 0.44 times faster than git log --stat --follow -- include/linux/rsc_table.h (rev = 304812ed33)
>        1.65 ± 0.05 times faster than git log --stat --follow -- include/linux/rsc_table.h (rev = v5)
> ...
> While the original patch and this series do improve correctness of
> following a file through history, I wonder if the increased cost is
> ultimately worth it in most scenarios. Maybe this could be something
> opt-in with another flag instead of toggled on my default?
>
> With this in mind, maybe it would be worth it to revert 304812ed33de
> (log: improve --follow following renames for non-linear history,
> 2026-06-22) and restart with a fresh series. IMO, it might make the
> changes here a bit easier to validate also.

This sounds sensible, and is far better than reverting and declaring
"The original 'checkbox hack' should stay here forever because doing
it right will be very expensive".  Giving it a fresh start would be
valuable as following a single the is an important operation in some
workflows.

Thanks.
