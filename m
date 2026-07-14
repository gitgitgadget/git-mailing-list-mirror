Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF53C4D8DBB
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 16:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784047407; cv=none; b=sVq14TTxfoIPJD5bDM7BYHQGLl0JMRHu0LpIOMzNpmR1E5tNhfnqd/PpYO5bnMBM3AssIsumlyx1XvAX8SK78ewWkLIAn4yfjVSGfB6BZwBmYMKYB1Tr63Yzja94X/aRdbf3twQjvqBt1OR9Hj/EesJ9PRyMBEBIE+vgt9jJqHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784047407; c=relaxed/simple;
	bh=7vd0aG1M9FpqxfIMXTfksTyzyFIAvMYNgDHqOi8Zv0A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iyKy4j2EykgHeDH9WitHzdLrb4BU8OUDGxgv7llUJwemyqSVj6UmngWI+ur/KkAiCT9FYYZ4H+dTkDXf3BgtKKc17yTvPwY1Ov4X3v0327ThOZo9Xpf/wKHvr2gIDjp58QP1bTrBnR1yTOWacGr0n6atxuAItnaTB2oeH44UWKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LdQtkOca; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DGuPHzg+; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LdQtkOca";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DGuPHzg+"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id D5E95EC01AE;
	Tue, 14 Jul 2026 12:43:24 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 14 Jul 2026 12:43:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784047404; x=1784133804; bh=qNUgEpoCKT
	lL+4SG3mbfH/2VcGc+2LGrH4j1eZ3W9BU=; b=LdQtkOcadBT9UJ6Hcyc3tV1Jnd
	r37FxOD7qJhbxIRlv4lqZt7fQEgRgL0SmwDq4VXkeq9AoZtoJnPKcwaqG3CRcJno
	H8we9qbdFQI1CAUdyLx0U5ENcxpT+HjcJcy8tmDJe5l2kTJ5mhDLZoithOlQayna
	LlWrm8Yd1zo8P7HBEnYn8bNGB5ftJfYG000Mbrtn7YBf94v3VZoMzPYURT1hupev
	3SbEayzigjlfLUdA4RguUc0dOcniq68SFvh05IhF9vc0jUwAQJCG7gcMbylW8cur
	HmxEaVMw78qUrD3S/qp4X+Kmoe/xTpUoC6tLLyfQXy0zWrmiY3qaHs/V/5HA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784047404; x=1784133804; bh=qNUgEpoCKTlL+4SG3mbfH/2VcGc+2LGrH4j
	1eZ3W9BU=; b=DGuPHzg+tlpLfdQypaxaJyyQJS1xmP9rvUslRmNsqFm5SRUrp07
	RV5aJ1AFwCOFMcUhZlqW7fh9TQVIsqoIP9dJIzPIRw9jUbZcAmr25o3BoxtiLDFT
	tFsRLMK3cVzvUDHO5nQAlmdlUuMFqXzIrB23WGfA5spezJukFbkW+TtuHUo6f1ha
	AVV/P+y5mX7pjRxjkBK9O4XpsAvfljrKgzkcDrFiXYxpTER3+LHdod1XAVRuevsb
	D2mIJZafZuFryFU4DFv/9deYQu9dVicn/eWB2OrD7EZxza/MUWyKxl8cGmwvauj2
	qE7ByT9C9lsFQTZs58QA2qKT4o4yqV3K5kQ==
X-ME-Sender: <xms:LGdWasqLCnyG8jZw1uBegvMcxdgKX4iM6iPuvo8KkMDpQU-IFP4dkg>
    <xme:LGdWaprBe7fAiBI5Wd1cd8ocx-NpIIqguhiK5y17fKJBaiOiJCBcCO4uhYG8FXnU4
    rkkH6CK8r2g4yEaN9WcBCQbB6czZ9XnYA3kgRJiBD_cYWUjYIPtnQ>
X-ME-Received: <xmr:LGdWamPYg8N2g1rTbCnru7t-pP06TobfPu73BQv1fNM8Ad3pXodlPqCLQgVxDZgkwteIvLKeL-0F5P-bkwIMOUp0EGRIiJtmTW9myoc>
X-ME-Proxy-Cause: dmFkZTGdsInysu06xMtJLnomoQbLtH/YrZ0CTRuQ4kxt0yaauBZP7xz0Y22Qso+zIhVvix
    koGSOb3F1STtca3o7CuvZhpvOrFTMqA5UuPnGUiysBDxCiPXrnOvO5mQAKJUsDojtQ4x4k
    A5lw2BptO3L0frdy4o8SsPZ35GMM0kbkun5kxBxn+F4oOo1+jN9/ZwYUAhr5A8thtebE3s
    beA1kac7xNNhxi/Zd8Wemhq0WCxQPnZP+lD0ve5y+Qs5VRhdpA7IquzJFQwsujb5Lf1oVA
    1xRPUW9GZn7URCMXE9sQnUUatwq8l6+f+1KFJHEcroxt5AdO3KlX9zSlPoyhjk9v9IJuUp
    iLcHG9ZQ5whl53j+zm5+ecgcDSc6IjLZzdMFRKGSmR+yot1JeMBxM1oedwqRZeSIWzM/gu
    n3ZIWfA2Q5VTTe4u8/WXlnAzH5flQitoWxm7BlPXhtJvQ7HmzP01lEE33jcDyrtvCrF2pG
    MSbBCHYxLVSYelHZSsS7R5ZGeIKLuT2j4r4VqczRodY7s/osD65pzCu80wolWjjFee3ab5
    fv/3YDk3UHLS5DLvlgm87d6H00qKf0jXIeNiH0CXvUpAVhXSI9ZE7BOBQDAHLLT4wFSUxg
    zyXTwJwUItP8pMXkkzO55gwePF6iY3vosynhS5L+ysMwJaqmoQ2R9QS0VMbg
X-ME-Proxy: <xmx:LGdWaiwi8OEzJ8xPn43Rt9RInVBzgGXiAXvvXAhMeqAbRWjGCE4CHQ>
    <xmx:LGdWantKw0c6OMYvegb393BZ094Q6E9vg-kjITf_m2i5NC0d4Rhtzg>
    <xmx:LGdWaj6GC6XyPysT5H_qRAKExQ2XPKTOZ7NEs5YC6Vg6Q-xlnrRZbA>
    <xmx:LGdWauTvlq31vPHPZSlOceE9OxUmx2gnBVh9JQgXyj0b79CPONxYdw>
    <xmx:LGdWals4ATyJq9guR9SGVPqxJPtLwUEGHynUozhBpVOPKXehq8qXzCko>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jul 2026 12:43:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Shlok Kulshreshtha <diy2903@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 0/2] t1100: modernize test script
In-Reply-To: <20260714122033.61947-1-diy2903@gmail.com> (Shlok Kulshreshtha's
	message of "Tue, 14 Jul 2026 17:50:31 +0530")
References: <20260714071633.35446-1-diy2903@gmail.com>
	<20260714122033.61947-1-diy2903@gmail.com>
Date: Tue, 14 Jul 2026 09:43:23 -0700
Message-ID: <xmqq4ii1v7x0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shlok Kulshreshtha <diy2903@gmail.com> writes:

> This is v3 of the microproject cleaning up
> t/t1100-commit-tree-options.sh ("Modernize a test script").
>
> Apologies, v2 crossed with Patrick's review of v1. This v3 folds in his
> feedback as well.

Looking good.  Will replace, and mark the topic for 'next'.

Thanks.
