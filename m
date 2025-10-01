Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96191286D44
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 16:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759336651; cv=none; b=oAyRW7tuSIiM+s68lhREtQjVTtowsFqKUpWpb4oG//I0nu2Q3rT6ljGDgKcOTOBn72OEK27ytH+8412GEVH9FaCe1OfTiS5jVKQ3HUCEU/nKYvGEYGL3cZyrd9xg8Vf4m2kc2sZFGwTg9/ufL1AnDUlC97NKUGagOXeVF/GR3bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759336651; c=relaxed/simple;
	bh=suHJc1pJZIp88YYdyVUy98gSGRnObUJYd4KNBiW8zOg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZsQJ7frtOrwjrYzXt0MGxUoFkfKqcDB8LQHmILN0+6UFW+3wivDnuu0rnVmKuug+YQ2HGPnutZmGxh08ILUK31rC+S35UKb1lFGcdiePMFM55R+QxWr/1bYi/cYwQ/ySbpVQa8ZR0/OZYawtIluXF5+6BI5PRela7B3ZBWPhyRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fKcYmUhs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PdcSMDV/; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fKcYmUhs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PdcSMDV/"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id A67121D003D8;
	Wed,  1 Oct 2025 12:37:26 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Wed, 01 Oct 2025 12:37:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759336646; x=1759423046; bh=W7IXHMmUCQ
	+Ny6wZwVF/re3JNVv6EA0vpLuBoPXR4aI=; b=fKcYmUhsvJSKAl6LQlqdWs24+S
	N1STfVGkOKSzNt6fjJEa90DgZOVGz2XIuozl3FpBPvwAVXyfj2TCCiy7LgV9Kluv
	dC8hqhUZSKJCNCs8aoMOQ2hK+BMC8dvwYKmTsOopiEEU+xWSfDEMjfcWVGA5NlWx
	4LARUQVilkWaI/Zbc2RFixX7z7URMCtEDaZPRwd4ULaT1Zl/BtDFmX7Tatl/bHgK
	JNcVoPEaI4noN33K5DUZGmGk3aM5sqpARFfj4VzCRIS3Z036lr9P7/zhEsX7rG88
	4VKcJrlA0jY1IaKTqyNNTEH6LPKfuEm9iu3uhTp3w+Lzq45YUioeWOm/Dq9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759336646; x=1759423046; bh=W7IXHMmUCQ+Ny6wZwVF/re3JNVv6EA0vpLu
	BoPXR4aI=; b=PdcSMDV/fvcHvUVRo9lNezZfPDw8i0NJHxOSeq1hiLO0qR0uN8c
	vq/Iz0Ss5wcq5aVAkzMNw/oh+auqy+XApx4g3w6LW0dR1/YI7af/1btcXCPZOHWZ
	U0HWoiUFqon05XIUk778vtHN18Bx2r0iNmmY3bG+0RqSBxU5nxzICv3OqxQabb1u
	1hCRBOw8zW85Ur/x1n1DhPI1AIoaG6PhPBT1jBuGbEzypm5JCkEftOdMOdamoaLD
	emtM3T3JydAf1wGc7UWI5peibE/sceScZM19efnSk2vNWQxlD7ndLdgXoGgO+iuA
	JHK6Rsyj/ql2cynIFve83DNFGTvPXXbTRxA==
X-ME-Sender: <xms:xljdaMB9MVREny982vMdBV09Z4tn47X5Gbuqe-VFYSyabSSHEKmR7A>
    <xme:xljdaFjLOyBTwqqHHTmqf_5tO2pyORWRubp5WNYnhidDq9_2fzYL_7CuQIcqcL05i
    dtRIVBlEN8nm--woduHEyh1t60Nl1yXsYFJBfIoKzOVyG1dQgO-3A>
X-ME-Received: <xmr:xljdaEmyMKX8RDMh62U418DAJxLrWu8oDnvHoM-O6B0ZElpzNUrabv4KqR5_jf3TaZcht1IQJ0-jH12IuFU44xE0QHYO1IexCE5l>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekfeeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgurghl
    shestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:xljdaBqNVZh0UWPXEiKKwCGZm5D_ewySFg01HVhkeRHSz32sq5NE4w>
    <xmx:xljdaNGlawaKHXJMjR5dQQupw8dMP5f-Qks3ZZXhlCfBucchQLV0tQ>
    <xmx:xljdaNytEdyPNVd90x0_mI_eR0uCs8wKAB3taceGiM9ytqrSKAYpnw>
    <xmx:xljdaCrCdSxIXjSSQ0OQjrxpxJHDPydg4gAHCas8x_YmwEdS7tlW2g>
    <xmx:xljdaBHH2XU7WOGlER29MWAWvZ0seS1kJU_m1bCyRZRQFKuCTvN9tAHC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Oct 2025 12:37:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH 1/1] Define an extended tree format
In-Reply-To: <20251001005814.846992-2-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Wed, 1 Oct 2025 00:58:14 +0000")
References: <20251001005814.846992-1-sandals@crustytoothpaste.net>
	<20251001005814.846992-2-sandals@crustytoothpaste.net>
Date: Wed, 01 Oct 2025 09:37:24 -0700
Message-ID: <xmqqldlu37ej.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> +The first part of what is traditionally the file name consists of a modified
> +BER-encoded integer representing the number of bytes in the extended
> +information section not including this length itself; that is, the number of
> +bytes which must be skipped to reach the file name.  This allows parsing
> +unknown values in a graceful way.

In short, you prepend extra bytes that contain no NUL in front of
the pathname part of the tree entry, but that extra bytes begins
with the length to allow skipping.  

The tree entries must be in sorted order, but I presume that this
extra information merely happens to be encoded inside pathname
field, but does not contribute to the ordering of the entries?

For debuggability, I am not sure if modified BER is the best format
(it is essentially binary gibberish).

For extensibility, I wonder if we should allow more than (type,
flags) to be given in the future?  I guess a new <type> will allow
extra things after <flags> (like conflict tree takes stage number),
so the format is already extensible (we do not want to see people
willy-nilly add extended stuff to the tree object anyway, since it
would allow the logically same object represented by multiple byte
streams that are not bit-for-bit identical, so extensibility is a
double-edged sword, but still necessary).

When we have more than one stage #1 entries (can happen in a
criss-cross merge) or multiple stage #3 entries (octopus), what sort
order do we apply to them for conflict tree entries?

As you said, it does look ugly ;-)
