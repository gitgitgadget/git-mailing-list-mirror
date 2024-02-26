Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E36E249F9
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 16:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708965602; cv=none; b=GAbQKGgXquz3HjS1ass9wu/dx8zhOFI1edlSQuUbDNcaH/9SJWH7ZLbyd78faQPwCv9ahFxgrsVG8ga5r3HafmBtZ1JZvIIXFkpn034w3Q9cBfGmpx9KdsoHjyE8nYC9PchZF+XkSGW/vYCSdrjP1kJi9q9Or42tgM+3klxGMYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708965602; c=relaxed/simple;
	bh=He7uhA4zQLOFWebBhifgiaIl7vDy6CKjlgLkn2eAJ84=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eAfWX1EKAPQGuB1t9znjW4Pwvlc5vgksMB7drTJjT+Icvy15dGiEtwxcTCsMaPDGnBZ+nziO/yXL1G6DHLCd8IMzkazEANXgBV+Nrp2hHVtXSWS1X+Sm63jEzI1HdesKkRlmLB2JN3ftzRByRGuMqpsFK429Rjxg25yS285QK3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GiHM54Gp; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GiHM54Gp"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 554011D2009;
	Mon, 26 Feb 2024 11:39:54 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=He7uhA4zQLOF
	WebBhifgiaIl7vDy6CKjlgLkn2eAJ84=; b=GiHM54GpcIFwST/UDQIOXh7kAI/r
	56awbRSQeGhbTcShVczZkxJSu2akAJpn/bpi5wpuTm/6zJigRMp8+3VVvJVNKMEm
	npvhpX0sV5FkK/fCnYtuex6tsYhZs7QOPWDxyVsXrapVCG3vKST5wE99CvUioSfk
	ySoHf2kCjiAD9Zw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 493401D2008;
	Mon, 26 Feb 2024 11:39:54 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B2D321D2007;
	Mon, 26 Feb 2024 11:39:53 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] Remove a bogus empty file
In-Reply-To: <pull.1674.git.1708958183225.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Mon, 26 Feb 2024 14:36:23
	+0000")
References: <pull.1674.git.1708958183225.gitgitgadget@gmail.com>
Date: Mon, 26 Feb 2024 08:39:52 -0800
Message-ID: <xmqqedczdvs7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 AAFDB8B4-D4C5-11EE-AED2-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> This file has been added as part of 2232a88ab6b (attr: add builtin
> objectmode values support, 2023-11-16) and most likely serves no
> relevant purpose.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     Remove a bogus empty file
>    =20
>     I happened to stumble over this today. It is a regression in v2.44.=
0,
>     even if admittedly not a terrible one =F0=9F=98=89

Indeed.  Thanks for spotting.  Will queue.


> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1674%=
2Fdscho%2Fremove-bogus-file-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1674/dsc=
ho/remove-bogus-file-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1674
>
>  neue | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  delete mode 100644 neue
>
> diff --git a/neue b/neue
> deleted file mode 100644
> index e69de29bb2d..00000000000
>
> base-commit: 3c2a3fdc388747b9eaf4a4a4f2035c1c9ddb26d0
