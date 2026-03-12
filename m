Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5A43F074C
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 17:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773336445; cv=none; b=LC8rhu59V+vZapoNFzQ36YMsYq88Ai4bBo4+OcOXbnj408/XKuOknnHy17e7tXgs9QnwifPeO64g40NYBbw0533unyzpkpwUVWKW8Hj3JrJTz9OoQXjSv7k8CGiK8ntFw63lL/ldo1b0Iw8Q3r/CVNxWnV/nzc0w9dnXdvKn7Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773336445; c=relaxed/simple;
	bh=wdK3wC3ysjB7kJ/JO0ouMxvOTLWUVjcUAvoCFJuIaSM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MjCpjXxWJRSbBrqvNCnT4CE2KilI880IBGnqYfpzcGKhVYKU7/kjxO0WMWLnOE3WuHPXCn+VjU24qT1Y2bmxx7dkxjg+DG61gWSQ6EhmSrp+Vog+M41qZd21FQRZ0T8o/D6Py6Chwkjdgm8CUi5+gLTbtveo48X1bA/vdvj/ZiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UJP9S4SS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C9FbV4dL; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UJP9S4SS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C9FbV4dL"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C6FD67A0113;
	Thu, 12 Mar 2026 13:27:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Thu, 12 Mar 2026 13:27:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773336443; x=1773422843; bh=GGl/uIn0Q4
	d0UgufQlk8gzQMtCPZLv9Lz+LACeXmEG4=; b=UJP9S4SSPLOis4Ttx0j2y7DANx
	B6D8Jj9wm3cA9uqivKos6jSeAB0XttfPBI6J0NNzJ49N+u/I/aurnJvaNMRlVr34
	Zh/lriD2Y1PsNRPKVppiNUgVaz0syQSEHkuZ3h/TKi+ysuuWD46vsClQ47AvQwtl
	wJ1DU9cQNQQqczdvmj9RQZpd/s3hxeBAcyQBG/h2/5X8JGcBhyVAja/wptjFZkJr
	/g12KOo9zQyba+RzH8mhczbpb0IOk9J6ipGgE85QiVhtqRlHFqrqNcpsa/EiDRVp
	tyIzuZ8EwXD04UrSmGJPXuOHUl2aqUp49podo0BxFUSGbsbz4Hr6RzWxwY3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773336443; x=1773422843; bh=GGl/uIn0Q4d0UgufQlk8gzQMtCPZLv9Lz+L
	ACeXmEG4=; b=C9FbV4dLRHANGjc1iujh3rlDb5L49K1ArXJkM79U0qbVutDsk9Q
	yDHHWb5hhxF2ywhE6thi8z85n9bRdSxnNyxDpKR63E5inu7PXbDBrwXxapEfbMgu
	tpgUnWalbql1b9eXmdllrfCxofNEqMFjxDD2CHkDIqQqhfhQuqrfZzE2utbn3urI
	q0T1+GSExeUhaBhxew4IRx9iFU7KCfQBODhE/GYk1r73Cb+MgHv8KJihKEgLKVtn
	+V7ekSgVwbpOR9+6jiS+oXW0GIri5xDqXGZVX3osdz8XVEsdJysigoHpZyy3o/Oi
	8Ofutl4uzdMQMkYy1VTFjILeqIoIZbMZWEg==
X-ME-Sender: <xms:e_eyaZ5NjB8-fVV6dcYDtb6gkADjhF9ZE4bW9NXRZe7U1Z6q1_HwPA>
    <xme:e_eyaalBkgXbvqp6GnEJcWTgIL9AnSgEKGEYEa45Vo0iXf54-gmlZevt_UpQ-eqm_
    pC4YE2h1C8IfOawyonkcyrGqEecYiQZliK7-RozHEoxUvePP6JtNQ>
X-ME-Received: <xmr:e_eyaaQl0yR8v8Etygfbk6NKR7QYJoCfiBs7SRurVwDFWW08pRwwwHMSfsRI-ffo2p6Gx66u0ZxQQet3uve8cxgXF67CTRJk8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhhrohhikhesuggvlhgrhigvugdrshhprggtvgdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgv
    fhhfsehpvghffhdrnhgvthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvrhhtrdifvghsrghrghesghhoohhglhgv
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:e_eyaZHO1TAILCH3JY_8K-WalV24eeJZheugcGDwCKkaJdyKnKhiNA>
    <xmx:e_eyafEIwXRscVpaZi-CayLXSCE4hPmvKUoxBb29PGWkr-cD6BSZ-Q>
    <xmx:e_eyaXRzle_eoDhdPK0SmR3dHJggTtDoAwcqAKQSPePFwJ07Na3TZQ>
    <xmx:e_eyaQLXVF0wdv0Nn3dC-bkpecUauDQ6rEbNY74_Ez6tqr26Hm5tSA>
    <xmx:e_eyaZJIptl6EAaccHKKyqw0QOn5hwrhEgiGi4Lfyl-8mtxCNBEA5BgK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 13:27:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH v8 2/4] format-patch: add ability to use alt cover format
In-Reply-To: <xmqqjyvhez96.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	12 Mar 2026 10:25:25 -0700")
References: <cover.1772839973.git.mroik@delayed.space>
	<cover.1773331753.git.mroik@delayed.space>
	<225065cc0dd54d1a592939d41783a904a98fb2ad.1773331753.git.mroik@delayed.space>
	<xmqq5x71gfci.fsf@gitster.g> <abLw6vUUh36zFK4n@exploit2>
	<xmqqjyvhez96.fsf@gitster.g>
Date: Thu, 12 Mar 2026 10:27:22 -0700
Message-ID: <xmqqfr65ez5x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Mirko Faina <mroik@delayed.space> writes:
>
>>> future developers to introduce something other than "shortlog", no?
>>> If the version of Git in 'next' supports "longlog" and user gives
>>
>> Not really, anyone can introduce new formats, it's just an additional if
>> statement.
>>
>>> "--cover-letter-format=longlog" to their version that does not yet
>>> support it, it would be mistaken by the version of the code here as
>>> a "log:longlog" without any placeholder that shows a fixed string
>>> "longlog" for each commit in the series?  We'd rather want such an
>>> input to cause failure, no?
>>
>> Isn't that the same for any feature that is in next but not merged in
>> master yet? I wouldn't expect subcommands of history not yet merged in
>> master to work either if I'm using a version built from master. This is
>> an issue with the user and I don't think it's grounds for any issue.

You need to remember that some people use multiple machines with
different versions of Git installed.  Yet to be enabled option
should be diagnosed as an error to be safe.

> Or misspelt "chrnological".  What are we gaining by removing it,
> which would rob safe extensibility (aka "future-proofing") and typo
> detection?
>
> It is a bad idea to drop "log:", period.
