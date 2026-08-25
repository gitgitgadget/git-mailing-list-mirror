Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DB5C2EA
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 00:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787616328; cv=none; b=uo4fnJbqkJo1VzZXI70vQ+LHFqfDKep7ROetmB+vE7jhzb+Wt7Fy5JPsdLaAN4R3YQj7OA1t5J0QyHdJ5sWPRXbEUdC56Bm2LBTn7a8AfkBiahYogGgfcGsCVwKJrPH5sF6gA0VwEXaZ8a7SmU5gwAaqrGYJeKU79qGN9u4duuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787616328; c=relaxed/simple;
	bh=hcbcZbA7EDVu0k3kx8Fy4rmbh0n+TGkWvZWhMQiJWVM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VG2alBuigR629AdGn5earF0pI0CAMHsxWZlagkDfSg/dDupZ+eZMeVQ44ef1qkDe/7Ia5dzfY2foZHFNSYfgBE6Ghhl80U3mrY+YrECF4r0Limy/4Yfa8ZTz4sJEG4PURM40JNxlSzYEs7WJQ7BxTWXN/6siCfgnxcZYnN/8Lhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MMo2Ca6j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=klvmUt+S; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MMo2Ca6j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="klvmUt+S"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id B04DDEC0501;
	Mon, 24 Aug 2026 20:05:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 24 Aug 2026 20:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787616325; x=1787702725; bh=AGaNpBSM/l
	47PsGPFW89g5OFerm0hvemgE4j6rGX73w=; b=MMo2Ca6jKONvsqrxVdDcPI7Emk
	8OCdM/FIvR1pXMr9l81ZrNpVBCynKJfbvYUsfEUrx5NHk7nRoi50RcNzYquqtvy3
	EruKt/yJt/LZef2KN2YjTDoV5icS/ZLUPlcgrEaWrSZ4c2bD9p5Zxb0UuNomgqPF
	X7FQwhNmSkKH6t6hJ+GEvfJk/99WYx0+DC+x2fT5TWNFIorYan4Nj4J6qLz2b8Ng
	rdeF8PxZ2J/i8pohVq7D8dnzzMgbCgAZcztkP+wML9x7k301zwCwXdrzaRRrjx7N
	IkxEFxJEMNcLCIucZcFRyFXg4MdYjnnTmVqKGSelDbnSDn/2Y7XMJqj9M1sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787616325; x=1787702725; bh=AGaNpBSM/l47PsGPFW89g5OFerm0hvemgE4
	j6rGX73w=; b=klvmUt+SdBEH1tNb2mCam4ecmVl8ptg1oiwzPwIQXOLUhRwWW6I
	v79vqRq3Ig7V7+tWq2WGgnXiNWiO60F8YqaJYLtgaU6Y6e8KpkEOSODjFIPzj0Kq
	S0ZvpyWjdpk1JTK+Ssa3aInkFSJg6Vl0jZ3vL+OrJ9zZ3M0e3uqAeTChhr9dL6Jh
	mKS+/+qfsyc0mT0rAEHL04pB6KXKWe7mBwRiOYGhYRwiWGAk4qqiGMJE8mZd6puD
	YIyf1/PW6xstLGH9PsREmcF2tN3a4by29sMWl90Bdt2/PYF4cGoPKrD+bAg20e+f
	+3LKwwJyUT7N7sSzpjlbSSZcJZhTBPeVzjA==
X-ME-Sender: <xms:RdyMalQuHaAzyIWVL8eTUatZJ0y_P3gi1jS4mF7-8wPjgA0yi3wZtg>
    <xme:RdyMaloYqQz1Qx344mG1c5XVze_q4JWLpc0A30sm0RqOKybt1yrM1NDPlYMoz2iC8
    Dirvoii91S4Zvg11bcMo0edPhMfhgrTwAvB7Uvvdcmcli0_KD9DOY4>
X-ME-Received: <xmr:RdyMajLN6nHA-FG6vQ4EB1Ek0lapvlTn4asf_tF_-5yT7J-e4Tkfn-iwreS9cRaj0P6mlr3lmxB7IB-yEKIqbJQSwPLVYV571A>
X-ME-Proxy-Cause: dmFkZTERvCZAakTORtY20bpqaxPbx8Ev6AEwzNm4HD/iLvhggHmeyKubhRrRjJMUEM6sku
    kINvRPZ7GeprLDo8HQIntpRXoidEz0GGUTrCVicdWg1aEy4osb0IZApwPfwbsNQzsBrMea
    MJ06i5DZKoGkA4hIZTtzzPO2C2y+EZorBQx/dmK4iApguuh3IbTjNvFB/JHksz3WzapfFf
    Kj8uoJgThJg8nQEgBAxFabPedI+Ktea5WH8v/BO8e/RqFQwnjmedeHytUrDIEPbJaHFjuy
    MtMlKCWeTjUMVtBaaDQbEbdMdJKar6ZE9e0VPfE8JSy8JOpH3t0xd9cL5rmdhHmqe/+xsV
    uiV0XaXvgda+b0H+kZuiDABz+1LkDtDpjmlhvTWU0/ozxyLB8kEJ+ddAHLySMUfIoSzP7J
    Bu3uxijj0F5jPHYk6d8MaL08hRGY+H9XCS9/Rn9df6/xu1fYLayLrwONSGs62AnubdPl0a
    CXg8EezeIZy6zl/LX0NYjr/WABIP5MHN7ClMHBjdVO692dEIc/9PzEnN6ulTPV0KRMGsEE
    LBRmIKSvq6trlwvwcofHualfCrdL3gXPYsggm+BcfcPSpOJjjuX5nKdEjP/m/7Xy7HwxSy
    Bl4306VCPjAGKXHWNcPKHBGqatXg4+RIOUSUI0bMKNY4LqhOuNko9e9I5y/Q
X-ME-Proxy: <xmx:RdyMaop0DYG1PaTX75X43h2Id-UqKFkw-xaFutA33WA0SXCojrSP-Q>
    <xmx:RdyMarxXvFndmUgVIwYFr7Pw8ZidrdtPyhNhDf-rwr-AJvSa3GGokg>
    <xmx:RdyMasOcUFkL1IV2Ukbbmjt1tGTOs75QnSiWMTWZxh_YuIr6AqK65w>
    <xmx:RdyMag45J2gpd57wIoQ-HmyqraxnlGLRRgj0gffzDRv06KJsnUBqWQ>
    <xmx:RdyMaj4nDekkebBloW1H2wRNRJ4eYJPPO12VlbUxk-vP6_OMaldyA6gh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 20:05:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Nikolaus Schuetz <nikolauspschuetz@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2] t1401: check symbolic-ref exit codes and --quiet
 silence
In-Reply-To: <20260824230527.24163-1-nikolauspschuetz@gmail.com> (Nikolaus
	Schuetz's message of "Mon, 24 Aug 2026 18:05:27 -0500")
References: <pull.2204.v2.git.1787264402361.gitgitgadget@gmail.com>
	<aoyBxOCdAq3qeAvW@pks.im> <xmqqbjarqswj.fsf@gitster.g>
	<20260824230527.24163-1-nikolauspschuetz@gmail.com>
Date: Mon, 24 Aug 2026 17:05:23 -0700
Message-ID: <xmqqfr03oyik.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nikolaus Schuetz <nikolauspschuetz@gmail.com> writes:

> I would favor continuing to not test for the exact error code, and
> would rather not disturb anything scripts may already rely on.
>
> In either case the git-symbolic-ref.adoc NOTES are out of sync with the
> actual behavior:
>
>   'git symbolic-ref' will exit with status 0 [...], with status 1 if the
>   requested name is not a symbolic ref, or 128 if another error occurs.
>
> To describe the actual behavior:
>
>   'git symbolic-ref' will exit with status 0 if the contents of the
>   symbolic ref were printed correctly, with status 1 if the requested
>   name is not a symbolic ref and --quiet was given, or with status 128
>   if it is not a symbolic ref and --quiet was not given, or another
>   error occurs.
>
> If that sounds OK I can update the adoc and call it good.

This is the kind of "casting wrong behaviour into stone by either
documentation or tests" that I advised against in my earlier
message.
