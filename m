Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DD055C1AC
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 17:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789062377; cv=none; b=rute0JOvY9C1PYPTXX21XT3sAwsjregVg9n3qbFli7T+uoBt0XgnXUSlfsA4hS5xUhL2ynL939gkPJAW3m26d38TraM/JAkutnd7B9p0YBfJnRYh0B7mxurg0ld7sHmzqoQcJgkpdhbsKAlq6/wmd7GK163nYIoL5/f6k4AWJ3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789062377; c=relaxed/simple;
	bh=f9EiR8YY9b+cjNj0VQ0uLnTlsyKLM4kpkc3D0E4eVtI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ye256AcAit6m+iM81mz9NmezWxbV5RTIIFRJIvUpfDGRk1ex6Br41l5CA76SwVrthHzzczT46OkVGPuYMisA+TVCTDEwEXLhNcYEEF70CjgNS214P45Qna/yUmhU9N50AMToRxhIwh9nDWI+XgElcU/GkdUgK5+C3Jr9b2QnZWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=asouqH4U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iI+6gKmC; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="asouqH4U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iI+6gKmC"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 72B05EC01DC;
	Thu, 10 Sep 2026 13:46:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 10 Sep 2026 13:46:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789062360; x=1789148760; bh=f9EiR8YY9b
	+cjNj0VQ0uLnTlsyKLM4kpkc3D0E4eVtI=; b=asouqH4UegAyPJByhWKSdFuPWt
	B4xCxvg5OCnws8QAq3Gou/GpXk+4DyXUxwjCqtBnhmP4aWcQraOcczfmWfz6jGaj
	n5pfGpSBdSYpTIUVbmDiV3xfTTc2UDgGwT0xUxFK4oDfe3YSoqgKCc2uFOgAzSr4
	f0MEnDn9piQUPaaFi1iF7mqkyy1nkiXVMoJid1FN/iL0gHMnZIGNngnXNzvL3p31
	ZaDatZmWhjdnknQ2ueLPfzkvwaMuVCdIKTutnL91saDNhjNPv9ggjq3NJtzCM+gs
	BeX2J7yWkXX8nSljv40/Wu0JHquIX5kH8Y/WOj+EkOEwmJg4gwm+D3xmDcGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789062360; x=1789148760; bh=f9EiR8YY9b+cjNj0VQ0uLnTlsyKLM4kpkc3
	D0E4eVtI=; b=iI+6gKmCFV9jt4EdQZ6CU2QAyeFnoxht7sA2wGGnsz3o5Pc3ZEd
	AmjRIfTB0iKwyQc1xF1Wfe5kKo1/bo+GbTU+nX4VTHcAEYb/2XA8ej7kwD+B4rXL
	MtNDfyO5/sZ6To3G6lfQ/JFwk0wnUwv4pK4/avBI6gFoa5zoL8D+weGAlS0Z2lQN
	684cCYRlJZyG9N7iEv86r9seyb2/LbsBh/ZvAFGS0UHbqX1xBTw77nxXl7qqgB5k
	WbCi5ONSHEqL7vqb+HP/bT+Cbrgc+/SKBH+h8OKT7dupKjiAW4FLg8zmsV0ds0IH
	IRxS7vH2C1IBehxZdr/RK/ahwtysPol2NTw==
X-ME-Sender: <xms:2OyiajAAHBdYXdeerSFF_VfQRhy8P54sci4JJTiYuDKP7gCVIgL35A>
    <xme:2OyiagYbhOZnuOFb9FbizwzDa4GzdqRh5_MdsuSUzghWQgLxfJzyNZIid6lLayrBq
    WgnfRAChv7ChBZw5HQV5fk-I7ufrUYyMAUKFsfpZ1g6R69gRJkPs1c>
X-ME-Received: <xmr:2Oyiam54IZf9LCZjFLwN4CMUjLEsqiC_fryK0C6bPBBnxhkY9Lfh9QfQ-JjmaKyn64llyKa3K_RYAF1ZKbh6A8PrVd_tZYxxDCdm>
X-ME-Proxy-Cause: dmFkZTF9IyF2tVyz7RuOOW5wWNEhKfF6HExz17dwqIC6t/+smF0NNT654gKd++rFNalJWO
    yZaCeoD1meF6SZFb+BTrEsKha4H1B+JfUrRHiVxlk2bG65pbTR9ui+XG09ZtLUBoCx1aYM
    vdRgUh525vjma7NagC67gB1wO2Qr7cX0+hBm3SBrNblANIJNqVUS+WWY/1VTtRflqidAsv
    xHF63toiwDf96HxeJf8q972uVj1jOwouJ+EgGrg9n8keVg0mJxr9Z7tWauvXurQjfkYKVb
    G/ZlgGz3e3YWjABRx4ymuZZCBqWdmGgRmBB9MZsuJ5KhjKW/9GuURO3ZS5SZ6DRC8HZ6lQ
    Z1A1KI0trbUrTOrbxQafJ8BwHHXW79kmmPhLxRrc9u8w1CfxV3IAdatpU6XLUcEY0FB1Q9
    znejpYWldNqW2VJk1u9MBJiO8R8sSPi9pgIoTjlfee5aPiBO/OOxWmwPyT1WRF5WLSpA/E
    ixZPiuZ56G1MCx7x2qlcmBXQ3g9VTzYHs3/wS3JixfY8hQQvptLpjQ6aWHlZdMJCfhpBHe
    UnTucOFllKajBIULd7sM9nRvsb0trKsp0dFdPigo/7utw1Jl/F93B/qu4B+ilbFSVHvgJt
    6WhPpur+MDWzHIrzTbNAfIAV1/wLrPpf+PUeoH/yEiwcvXii68s+TFMR7JTA
X-ME-Proxy: <xmx:2OyiahZFfFr_GF-v9aSESzWD7lM3BuNlYDyl-CiHf4Gw2iDeLE38vA>
    <xmx:2OyialjrWCZuzqxj753J8DGJ7vkbJ7vkNTbpV2Kb2I-t-ELCKHMqQA>
    <xmx:2Oyiai-eaYBGPn078CvKDZSYokZKk5znz-gbmvG21GA5UhvCZ2pPdg>
    <xmx:2Oyiagrco3xn66tiX3QICr5UPPTzJOlS9ruOZo39HBZDZkT9pfwSmQ>
    <xmx:2Oyiarkqw1rQvNDvUydELuswmEffp72ToA9ZSzIZDa-oeT2GtJQmKCqn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Sep 2026 13:45:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mike Hommey <mh@glandium.org>
Cc: git@vger.kernel.org,  ps@pks.im,  sandals@crustytoothpaste.net
Subject: Re: [PATCH v4] Move rust gitcore crate to a different subdirectory
In-Reply-To: <20260910121056.2749578-1-mh@glandium.org> (Mike Hommey's message
	of "Thu, 10 Sep 2026 21:10:56 +0900")
References: <20260909013858.1729643-1-mh@glandium.org>
	<20260910121056.2749578-1-mh@glandium.org>
Date: Thu, 10 Sep 2026 10:45:58 -0700
Message-ID: <xmqq5x0df19l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mike Hommey <mh@glandium.org> writes:

> Subject: Re: [PATCH v4] Move rust gitcore crate to a different subdirectory

Documentation/SubmittingPatches::[[summary-section]]

> Having `Cargo.toml` at the top-level of the repository implies that one
> can run `cargo build` directly, but this doesn't produce anything useful
> on its own.
>
> Additionally, when including the git source as a submodule of a Rust
> project, it prevents the git source from being included at all in the
> crate package because cargo skips directories that contain a Cargo.toml,
> assuming that everything in the directory is relevant to the crate.
>
> Move all Rust-specific files into a dedicated `rust/` subdirectory.
>
> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---

This still leaves the source tree in somewhat inconsistent state.

https://github.com/git/git/actions/runs/34505483626/job/102966561269#step:5:120

I do not offhand know if ci/run-rust-checks.sh needs updating or the
moving of files needs tweaking to avoid the breakage, though.
