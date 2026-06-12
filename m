Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08123EDADF
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 16:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781281915; cv=none; b=GQYOswVukmMLYEwJlgv8cJG48uoLZFUwJo0Fib1DTBiEUvFG5idQZ5z5WDjoumEHUdGiPCAONSLGCCr0OBPU5ApCMxR6kJ9FVt0ErXfDnDx8kOWUl83tnsS/CdEgnmCb/671u5qZSTGJFPYIkyB7S2RwE1cczRt26L31WHqIhPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781281915; c=relaxed/simple;
	bh=pgeeu4CasU6UVm39cMwpBnqgKffM2q5q2Vots27mDyo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ml1M/zRuBuHW8oYNuPziWzQ9rr2vxlH8QQxCEjS8bvTFrOOHvNdQAVUzdrgTkglIQgEj0bi9H8KumdYPHvEMkEoTSOD1FasLuyn9bb0pkug6A/qKT4blMJSOBVbHO7aALRbNPcXf2lPSdSimwj9QDxTh0sM13P9RbrMIsv/tT2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HtQ5Igp6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WwRNGS8+; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HtQ5Igp6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WwRNGS8+"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 762461D0015F;
	Fri, 12 Jun 2026 12:31:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 12 Jun 2026 12:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781281911; x=1781368311; bh=NkzfoDn1MQ
	btwN/NHQVaF1ca5aVDogLjWs7sMYHMWyk=; b=HtQ5Igp6NvNCLl1HICmdpXb/3a
	X2gl+3mwFs5en0wZRtKzfWPkfa01ohO9wwNaZp5Uua6KrhN/Lc0Sc7tCobnk2BLz
	ltH2duQ29bhnd5/eDidXRTAXlzgH9q/uDrCMrw5NRxQIjqPvaziF7vWiC4jHwg7o
	V/sxl8NQxnJO9OXfVFdKsPL7AHEY/HDCQ0k2gPd/25B/JKXQ4Pq8p1jrYO1GXIQB
	pAdbApnRyAur+bwoR0t/1y5tqj3I1v+pnsMsFT9VK0MmhmXT4UiQnBHm0tEyegtX
	ZxuIqNBs79W+UznQSt4wxdOsJ8AKegL+Gyc6rHobYMQOgU25Rqd5FawXo9Xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781281911; x=1781368311; bh=NkzfoDn1MQbtwN/NHQVaF1ca5aVDogLjWs7
	sMYHMWyk=; b=WwRNGS8+lNIbwTvQw94ZnPtrnRBikfTsF3QlJ59bJAcK22J/x4G
	s286oVX+zdCkgtXZX9lzTWzmIXumn4ZsmRGtIwa6iR1MX+nOuQmH4hiz1LsWEkvc
	m219rQ0qwUO8tpNV/lrjefyKW2esGXsc+pstaY45W7rCHLgL6vsFPP+Y3HkQoJ1K
	835nnKRxsZ1uSZ+Q/DIpzBM364IpNcXJUS6VvYSIW61EGUiVxYyi5pL6qLp3yB8Q
	Kv0ZZ3v1JTkWfX3OQ70h8f6pF+02o+J2FD6+jTzgJBF7r28VSSuxunDRGHrJjMgY
	f7EPztMxtavb1271UbyLC95Y33gF5VLvnmQ==
X-ME-Sender: <xms:djQsaoJ8xCJ794J3eEsfKXGKM_4TYKfr57btKftYQ-mmgmpb2Iy9BA>
    <xme:djQsavnGL4s0APxnhwmYPZDcKQDMunXLISUt_PUoXEGaM8B_usfoUfYrMTLyISPFi
    bylu2Xd3sHpJi4REdHEvHV3Ajevk0U305u3XEfqsNrw-tdH9Qyb9Q>
X-ME-Received: <xmr:djQsamF2JcAchHQCef44HDyOHVg2ZKfLSKuaeWGSFzEIQ6LXG7qJIBUBQOpVJ6E4qRZ6_yxRpk1AsoZdsD7TWG5_I99sUNZK8Rs0>
X-ME-Proxy-Cause: dmFkZTFRUh+gw1+frAmV2Zi7frdhbC89Fh15NkZ/emQIFbWYr5Oer8IZxOxp7CjhdhSTYa
    w37L2HF5rSH81Thog76p372ftF4Xy/2fA0UwswjR1zu/XxL63ivYo8driTeQu40IlbQZje
    /RgqcJGMd4i6DTMtd/4G8trA6uOvgT7xVGYJrBOxTKFniXF1cWM7k9zjttfwdiK59XChvS
    euh9Zk/pwXclY07BqhEyr8Y9AeiTwb0ziXuIEFzcQbvceFEUqNl7qU5+lQOfr1DtnKKzEn
    3k8DED8ERle2tmZmzBu3AvGfOxPZZd2xFCfEMxrxBSDHohYp8g4l/fGLVPl1eig7l+p0W6
    WDE4DPGl7i1OFQ0G/3M77+/XEnPO1/NJLgcETekhFgpNiBFLs5tdMQT9pyRrzqCERxR/7b
    Eu2y0jY3OYhI6h8yRQ/6onKnPvI2T1zY46NUi9qG//LwNZyvif6lolhFDl6Zi6GSzfBRJy
    ixIRDRigrOR2C/k0EHbeJOCwd9G5RcbP79r/q2+ikcPonWvsXuEf/j1EzjiBeLS9zxa6cu
    e/MYedAVFVTmgp2SMZ67GbKmYzgW5NQrbir4vwbo7blD/a3lynfFZqyDtVMVdsUB1xXzy6
    LpJDHabIOpVXx5fbJFCnEiDkyLLZZ0163YEYXB2N7pcpf6XWS+3sA8eFQFBA
X-ME-Proxy: <xmx:djQsavEQhaCaSmHdI4z8Y60REVF_4NOZByw-5FKWf5pgtKB0OgxTrg>
    <xmx:djQsajM4bux3RTOQLkaJlZDJqrfLoxTm92RSMSjBhn_QnBo6yp9gzw>
    <xmx:djQsauFAAcUlWjyz0wET77Xq4A_L5hB792YzovWVxsWSxmXNY7yW3A>
    <xmx:djQsaqPPEV2tj1DzjNBFAwALT5Y3QLs2JuK8q1Ohm-EhH1JnfKlqsQ>
    <xmx:dzQsanslXzFk5D8baYFTK7tu41vEOhgvWEf8OUEUIXaLQqe7mzhHgN3->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 12:31:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] update-ref: add --rename option
In-Reply-To: <xmqqwlw4nccr.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	11 Jun 2026 11:47:16 -0700")
References: <xmqqv7brz9ba.fsf@gitster.g>
	<20260610212800.2892146-1-gitster@pobox.com> <aiqytJD-rcEirhgE@pks.im>
	<xmqqwlw4nccr.fsf@gitster.g>
Date: Fri, 12 Jun 2026 09:31:48 -0700
Message-ID: <xmqqmrwzhg97.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> [Appendix]
> ...  Ideally, these cherry-pickable commits
> that are stored under refs/merge-fix hierarchies SHOULD be indexable
> by a pair of topic (i.e. "when topic A and topic B first meets, apply
> this evil merge"), but this computation is cumbersome to write.

One scheme might be to use "refs/merge-fix/$A--$B" to store the
interaction between topic $A and topic $B, with the convention that
no topic is named with double-dash in its name.

We sequencially merge these in-flight topic into the integration
branch (e.g., 'seen').  When merging topic X, we roughly would need
to do the following.

 (0) Skip if X is already in the integration branch.

 (1) See what topic Y that would also be merged for the first time
     to the integration branch.  This is because a complex topic X
     often is done by merging in-flight Y into then-current master
     and applyng patches on top, and depending on the state of the
     integration branch, such topic Y may or may not have already
     been mergeed there.  Enumerate all these topic Ys that would
     be pulled into the integration branch as a side effect of
     merging X.

 (2) Enumerate all merge-fix refs that has any of the topic Ys or X.
     For each such refs/merge-fix/$A--$B (where either $A or $B is X
     or one of Ys), call the other side of "--" Z.  If Z is already
     in the integration branch, then we found the merge-fix we need
     to apply.

The "topic X might pull other topics that haven't been merged
together with it when it gets merged" is what makes it cumbersome to
write.  If we do not have to worry about it, it would be fairly
straight forward, but then the bulk-merge driver probably needs to
learn a safety check to make sure at the point of merging each topic
that the merge is not pulling another topic (base) into as a side
effect.  It would mean that you prepare a new topic X on top of a
merge of Y into 'master', and X can never be merged into 'seen'
before Y is.  Which may or may not be what we really want, and I
need to think about it a bit.

