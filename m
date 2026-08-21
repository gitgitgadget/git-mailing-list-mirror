Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC0A45348A
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 09:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787304569; cv=none; b=RNBAQcHQzRg39vUwnot6Oc5UjmJ+4Lcil8xFZIdKlSKfe7qYaP/meonIDuefj6CBdV4ffnCa3Ra1FkQLdNpu0Jnkq14Y3TrDfK+kHnG3Q5qLhZXlwuy4aVHOdTzWcVzfEklL8xYXN3Gk06puR/tfX9mm1quGA2sMfwB0XxyTVgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787304569; c=relaxed/simple;
	bh=VK/3GfnaGRcN7ZDtaB0gINzKsKCzhYEEX4Tx1azBkCM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LKapDTpNhWfclp+XA+q/ETAv1SP0dfFS7u3QZ5qppN0gt99g/MPqMt1HZkOBe2Lkuk9N7tHASor9bKH1MNWqDOSmMPZPW3vyVYEhuUoWan+SnjMYUHkV73DDdnOe6OjndXStEoBpedZ2SnngwZ6vatz+mCZ7R5mabAuGw14xbJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=w6VquPVY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T2kCf9lH; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="w6VquPVY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T2kCf9lH"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AD03114001BA;
	Fri, 21 Aug 2026 05:29:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 21 Aug 2026 05:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787304560; x=1787390960; bh=LqXrzAWe8O
	B+Zt7jTNUhNlaILorttMS0zgnhFBjOrTs=; b=w6VquPVY1bt+Xa2EYg7rox6VeU
	p3HA7V5j++YPnXia6eycAI0aQ96VyteUng8RGzR+iKS9Jz1FcKPDd0gIxpDvP9E+
	9TPptX+QyoOwVNQzQcgkbVfXqfUCX513ftRvRROyaf5S77d5pEibUO1btBq+85JT
	6hJ+zHl7uqZv4OiZgh2WAP+JBNcAGqLoQVYI9sTrPv5kTZHfL0ROD8AtbT3UurRz
	JKgYIpZF9oM43zuN+fys49pfl4ZiM2VaHOG5fvn2f8EHIvcjgPuZhAeSyAY4eBau
	R9iXZbtRzV0R1/413qW/P/GTaA4lWZs7VO2qQXNlaPzNkH0Mf07Ew7Dl9Oag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787304560; x=1787390960; bh=LqXrzAWe8OB+Zt7jTNUhNlaILorttMS0zgn
	hFBjOrTs=; b=T2kCf9lHIEzGEFUbFo4z7qqcKqRx3LoQms/Dnhv+3FD0Oq/shzm
	tTxH0/PNq04HTqUp2QYrQYZlgAC+SvZ03h2HctgPdIIVLc6PQW7WcdtWGc0PGpiH
	obMrIKQADY+FjOeHKteJTv6/7vvGDS0S1pD+Pr7acOuRbYkfBP14VxgF6MTsUE1k
	Le8BHKqyHL35tg8akblYSIbPy7lrwjpBWTHHnYoRu201jBReDp1G2FrjB5rsu90e
	Ise8xdBLEmU9x8DCy/Te5eqksN9ry3TqAqvt7YR069MYvHWg0OK3t1rgmcM6D9Yc
	UkObg/qTFL1GaSapLfkkHYSe3hDX+uIV4Cw==
X-ME-Sender: <xms:cBqIanBkXHrtDTdpJ42rGAvDZFZiOgAHfmO0JTVoEnc8oAsQmfDR5Q>
    <xme:cBqIakZKAO6biRDRJ4_HsXqIbyCFQGblT84gv07twq1VLP3we-5BhZnaDH5M5ZZqV
    HqdFY7ABJqDIiOTJfqkBUDhinYtSDauzvhyNDwVV1xVCL-p6IKgbg>
X-ME-Received: <xmr:cBqIaq4WdWifdtv5j6866yjLKuY0uV65WYD6iv6RrCPCllehzI-3ldzPOuWy0Kzcl2GUY9peTq_wFJLHGKVyP0Hu1_SLOIZmMQ>
X-ME-Proxy-Cause: dmFkZTGR54aMEuRo+lBaSRBY7vsaagDjpDlBY7VGkr+ltQEymbpc9X+cnSRORGgDvQD8fv
    kjKkx3L/cmrujXixjHwOm93/K6rrYWN60tbb24flFY7W95VhLXPCDFKAkZnx2TYxgVj5fZ
    +XZLomxLIe66Jn0JgqU+X9Q7gdaG8EvibO0AdrYwnuBfTmCUoWKDr8ODQJuuGntaWKqr9v
    msCzqE35lvRs5alaDewoom2M0+Km4nlhlugb6najThlIgOzTAtZgFEMpbGlfcWQr+0L9S+
    DLIfMSMZn66TA6ewSNLlqlLHZ+AOqEU05QwFkvxtuOBRgqTjQgzA8+I6w8+tTVStD3uiRz
    0sTFyPDFLjs613Wos/vmrSGCytG2ZElPSpYslRqVACf5fIeYbuq7w4V1ytWf6D5KMbCntc
    WuI1MuhEc7rRyXOeLxAuW9MH12bV46ZO4gwZf69Aw9WWEJupd0MBDBbHdyfhzt13HBi2Ur
    E2nUeOi3ZwVzryLSllAO1sBaWltXTWsSTmV78E3vq6uO3dg2iLdMdKz0I5fD/ktNKihnba
    xXRxo5ypnJx1f0lIfcaN3pU61CU0l6V8siS9/1BGSV/oJ39YWARpXJX/HsC33tccGqzYKW
    4F5PBn3Y3fW7W2mBilidWsD3ixRf5ApsKk6h6DlRwZAE0B4zYenSp4lnyBng
X-ME-Proxy: <xmx:cBqIalYmRP7QlBO9M9-QpH-sjG_RTBn43pvqdJekIH1_TGb3CRMtDg>
    <xmx:cBqIaphT0515k4un-kpNGLj4lKv4bv-kO1ZJCB4ApYGg7ZcmNMQzeQ>
    <xmx:cBqIam-BMfTluk-Bi_5CWRhfHZIp9hHp-gAk9t-Lmr40smLpaLgbYg>
    <xmx:cBqIakoe612Bh3A7zF4f38wyqJKZkEA1YP4KpkcwELV1JiHe_ysjSw>
    <xmx:cBqIagqQm6EBclMU0_YmgCFLikMXv3AhM2w9iJPw8Kt4LQ64Ta99Gz_M>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Aug 2026 05:29:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Nikolaus Schuetz via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Nikolaus Schuetz
 <nikolauspschuetz@gmail.com>
Subject: Re: [PATCH v2] t1402: test forbidden characters in refnames
In-Reply-To: <pull.2203.v2.git.1787264417682.gitgitgadget@gmail.com> (Nikolaus
	Schuetz via GitGitGadget's message of "Thu, 20 Aug 2026 22:20:17
	+0000")
References: <pull.2203.git.1786653837190.gitgitgadget@gmail.com>
	<pull.2203.v2.git.1787264417682.gitgitgadget@gmail.com>
Date: Fri, 21 Aug 2026 02:29:18 -0700
Message-ID: <xmqq5x13stxt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Nikolaus Schuetz via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     This adds the remaining forbidden characters in embedded form, and
>     checks that "@" alone is rejected even with --allow-onelevel, where "@"
>     is otherwise a valid refname component (as "refs/@" confirms).

Many funny characters are not allowed between 'foo' and 'bar', but
are there characters other than dot that are not allowed at the
beginning or at the end (e.g., "refs/heads/foo." and "foo.lock")?

IOW are we testing exhaustive now?

>  invalid_ref '.refs/foo'
>  invalid_ref 'refs/heads/foo.'
> -invalid_ref 'heads/foo..bar'
> -invalid_ref 'heads/foo?bar'
> +for c in '?' '~' '^' ':' '*' '[' ' ' '\' '..'
> +do
> +	invalid_ref "heads/foo${c}bar"
> +done
>  valid_ref 'foo./bar'
>  invalid_ref 'heads/foo.lock'
>  invalid_ref 'heads///foo.lock'
