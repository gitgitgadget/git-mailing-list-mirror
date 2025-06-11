Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6303C1A9B40
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749655417; cv=none; b=DxbRy1Gla/+VqPNH7sb5pcKHRzXWpA7qfhsvZR4GtoCbe4VJP83Yz79El1ANSqn0UtAGANiIxGLVUW/7Xde1AL2XJmCTuGBquqST9Sgl96BogTy338tYnyO6OuR3J3N7UUc6/QHjOTBjO5R/acwiRLBfSGdYgDfaP7zlBPJMoCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749655417; c=relaxed/simple;
	bh=CGh/XDL5rNQl1DZfKakyd/VLx+NTecJDlKiTGD9nbn0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xgemf6/dUBaLcfM5nsXT2W/xT2YLZqSkGE+TAd069hACDR+ycEnTkfa+SxkUIj2ohhEOFOMixY+q00yElghBCTxSZ2eGLNTRndcyYRdu0Umag8cjQC0as2WERt8VQhxObQGzi7HyLItG5p05PCSDGEVK901ca++YtF5xxWoMpko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hzlTgnL7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k5GEFPu8; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hzlTgnL7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k5GEFPu8"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 851C5114019E;
	Wed, 11 Jun 2025 11:23:34 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 11 Jun 2025 11:23:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749655414; x=1749741814; bh=R3DWBIaDgv
	UjV0zBhzcD8MUkkd/jRE+vfbn0KEIE5LM=; b=hzlTgnL7n7Jx9rE+biD4IMIuGV
	QP17WZkX1uUnoPrlAszwUWCiZQ2l08UqxWECLGjRvmKbpyX+OEe9aDqCsMWVXuqe
	G4H24c5tUzvvGgxEJhgc5dLVU8gcebODaaqEIGKNLejbDhP23FIyeyMwDLYB2Wgx
	S8KPM+8sZsrUmMGDIXzOd0Fox7+/UcbAfF5nZdbsw3pCHBd+JfNTpgfONONFWOPl
	Mt/gaJ0nYDKkKHl3xLSMNvn7BoKtQKDT8ZCWce7F2P9+wWyvQ5FdxbT04zme6U5l
	XXj0XTpk9iKXy7JMTdHB8yLQzQsCUVmpmb+bLuCdppro4o4xdUmF0COzIQqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749655414; x=1749741814; bh=R3DWBIaDgvUjV0zBhzcD8MUkkd/jRE+vfbn
	0KEIE5LM=; b=k5GEFPu8vRPFqwgRfgOuekudyj0hVTHaxiQS5cGWEVkTQsgIWuQ
	NYelR50bm1nLknEcxq/fzaPZ4l/hV2bSTo8hMsj2uOAdAb9+Dzt7COnCu+ZGTuFq
	4nMxjLkPYxaCUutj2ihRoh6Zm3DIk5smFqLDsO7Uua+mTRDpSIjDlFt00RLbar6n
	8eDcLpix9Y+judD73wGIyZeNHTijWCHoHDkkOORfTkxIf48H0YnOxM191jqz3oLc
	MACY1EPRTmVqvxrd6SvWjzaf4R1+0QZLrvwuRx5GKwlRjXb1PrNv42czVHg52pP8
	MqOPu/XrUeWcqJaq5VdivV0Q41WEn3latoQ==
X-ME-Sender: <xms:dp9JaLRLzDBTGuJ5dY6AjB2H_-AWCIFk7LkDpZ1dF_ZpTL_pE6UBTw>
    <xme:dp9JaMwP5ny8kiM2Wp5DIYa4XFtii8w74m1XAVpfa5Bkhq5lGRxI9w0hw7wAqJ4CA
    a4XyFi4JC-78nrAqQ>
X-ME-Received: <xmr:dp9JaA1alk8LeiKME4cz_KriouziemJ6XsRl3Cu-zzBOlS69Qv9l2C6A7c3r5i2YeQJNdAr00FYQRgRJBMFxbo1y4rFh2lZAXluo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduvdehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmihhrthhhrdhhih
    gtkhhfohhrugesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:dp9JaLBxy4a57Wnv-NMwhTp-_i4oNHzWLtQD54pvR855035AuCIo6Q>
    <xmx:dp9JaEhMR9dIXsJ--wyhXmYSf1lgh4AZTiDQE_R_-wbzpgiTHwBF6g>
    <xmx:dp9JaPrGKvvg9Iwh56gw20KlQwWF34_OxeO8D7TxmGU1WTYUT3wOvA>
    <xmx:dp9JaPjlEA2Zbe4uc69TwT0aPsAij9wGpU9wC_1ofsELaTWOu60urQ>
    <xmx:dp9JaIeyqsn9-KGplC0jJl_YJr6h8Xmm6-8-FszKd3f-TX4_N6UnjQDQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Jun 2025 11:23:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: M Hickford <mirth.hickford@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: Fetch remote only if remote hasn't been fetched recently
In-Reply-To: <CAGJzqs=Xur+=0=KUSR6TQA-A3zt-Bpyd5-T52_ntuV+mCUrAQA@mail.gmail.com>
	(M. Hickford's message of "Wed, 11 Jun 2025 08:00:00 +0100")
References: <CAGJzqs=kJtPcMrWC8Dayd+VW7BvC1rmzS0zT+EwQXfLOpZ3Tfg@mail.gmail.com>
	<CAGJzqskDumbMSbC3rdYT8fZ8gNJ5MOjR_o8RAo9QS-nuvbBinQ@mail.gmail.com>
	<xmqqtt4u86x2.fsf@gitster.g>
	<CAGJzqsksmQmY4o-_7DoPFK8VP-h59ANUjroVv2+++ZG3gDBdUA@mail.gmail.com>
	<xmqqtt4puhwq.fsf@gitster.g>
	<CAGJzqs=Xur+=0=KUSR6TQA-A3zt-Bpyd5-T52_ntuV+mCUrAQA@mail.gmail.com>
Date: Wed, 11 Jun 2025 08:23:32 -0700
Message-ID: <xmqqjz5ijo97.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

M Hickford <mirth.hickford@gmail.com> writes:

>>     $ git fetch . 'refs/prefetch/remotes/origin/*:refs/remotes/origin/*'
>>
>
> Thanks, that worked.
>
> To support Git users with sporadic connectivity, might it be useful to
> add an option to git fetch? Perhaps  `git fetch --offline` or `git
> fetch --complete-prefetch`?

"offline catch-up" is probably the phrase I would prefer to see in
the documentation page to explain the concept of the operation than
"complete prefetch".

"complete prefetch" sounds like an oxymoron, in that the prefetch
has already been completed long ago, and the operation being
proposed is more about using the result of that operation completed
long ago to get yourself closer to the present state of the remote
without any guarantees that you would end up being close enough.

In any case, to present it as a first-class option to end-users,
there needs a lot more thinking and a bit of work need to go into
the way "prefetch" works.  For example, the longhand I gave would
work as a good solution only when the user _knows_ that the prefetch
is more recent than their actual remote-tracking branches.  If
refs/prefetch/remotes/R/* is older, then you wouldn't be bringing
yourself closer to the present state of the remote at all with such
a fetch, but as far as I know, a normal "git fetch R" from the
remote R would not clear refs/prefetch/remotes/R/* when it
completes.  There is no "last time we fetched from there" record
kept anywhere in the repository either.  So offhand, you'd at least
need to do these:

 - teach "git fetch" that updates remote-tracking branches to remove
   the corresponding ref in the refs/prefetch/ hierarchy;

 - decide on what option name to use for this new operation and
   document it;

 - implement the option "git fetch --that-option nickname" to

   - figure out the remote-tracking hierarchy for nickname and call
     it R

   - when refs/prefetch/remotes/R/* exists, do an

     $ git fetch . "+refs/prefetch/remotes/R/*:refs/remotes/R/*"

