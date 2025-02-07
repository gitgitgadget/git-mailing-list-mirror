Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09D318B476
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 06:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738909720; cv=none; b=WPMDpoSoWwgEtqt6gqlA7PMATXlfW6W+m2CaSh1cGIQVTwFx897xR+v/ac7VqGr913r/cXr6ar59/F0QGiQm7Tb3Y5/ld/pZpeqjsR4KF+QLjPsJASmF1PMEmuyskl48yhntbWw/2yWNxq9DKVEwbA6HZYHbpxrdAT0eUhVU7SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738909720; c=relaxed/simple;
	bh=4V+g1mfqM4okYWHJsDnLzKtEXV1rO6D6loxvSGKAjzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZCGXKqy725vRP+bKMnGgs2rDH5LyBI01ASbragiCC/B0nDdg/Vbqg5uc9IqMaV660mDbPKjnNTHOqH5OBw9P35c1PmxvZ8Qjxuw2ldb/BjRWS/39ot6MS06Jxb6vD8X3sVNvjhx3YlgCGexpFN8oKPKuNFQHsSGyjOrjnVIt1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=D1hKSiRu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yRUx/t0j; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D1hKSiRu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yRUx/t0j"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 902C2114017C;
	Fri,  7 Feb 2025 01:28:37 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 07 Feb 2025 01:28:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738909717;
	 x=1738996117; bh=1IlpCt9x2A+HZH2l901V2xMNlktV8iu2Adwc4Ab9CSw=; b=
	D1hKSiRu857ZWzk8iWagJQRfVL/6do4NVWLgDV3fDEmk5Qjf4VCYBHjR7XmRPPHa
	ICSUCH3Mhq1iB7l5+uy+VLTTD2YAwaaT01P5sroPpWKqSYE4nzGuJpG16Q1Nwata
	EHlbbWcxt+a8KG6B87mup5Rc8o8o63bjLJNgwtMFm+7ROWGq9IZ/s26UaaR1Iupk
	JIdOTpHt4cp5cJPMVCmU4xAZhf6A/cg1gcRpRLK8C73TTQ4h1bQVNxuOp25mLtka
	Zx26bnySrs74cqp8qBubJTx/0Vu1bTUtXJEkHR+9kjq1A7LIufuZbMbMFauBNve1
	+nzyugrXc6gr+skN+OOnIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738909717; x=
	1738996117; bh=1IlpCt9x2A+HZH2l901V2xMNlktV8iu2Adwc4Ab9CSw=; b=y
	RUx/t0j2IrEHl/pauIAFoM5yjTc+Eyb6y3fBz0jshd33X3p/KYevc5+X2qeCOYXs
	crwHpB15l37pGodh7AiUma04rkjvWVUSC8Cm80YaCXDWg2xw54/ozTDuIz9+se0m
	by4DVnKmkKA0UZ5Xy0FsKpyaGRbRm1467CkY08mv0eIjx90LTrsbP9hX9surhNhi
	RIZndpgM6SeOXDVIHGBj7BXbkAADW21WpsaJXJUmtAKIoqLQ2+k1/v/G1GzcOVhm
	M48jfm+ghf8xHfsYt7rsRLGmr/6gsHlvJ23nIpo/qWw+TM+QOz5kxnX8Dw5+5emm
	MZB/3iQaz4CLEnYF4YMyA==
X-ME-Sender: <xms:FailZyhBImRvRBvxmTdMPTd0eLfvkGsh0CYxz51Wq4AzGzH4pheW1w>
    <xme:FailZzDK9XEgzh6DzPj-t9r6yx3nsYtEv-NaHU8xD9rdZddl30a-bJMB8W4EpeYau
    thsjKMQoEMt9ejwGw>
X-ME-Received: <xmr:FailZ6GO7lR5X16vcoAi4w9S-dkBOZlD3M9DvKiwc17HX7UYMulraN4Acuas-AV9RY1dK8vkwUtu4q3rnZqjR5NPuwqWW_EbeWyJmEQX9eMjRMcJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvheekvdev
    teffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepuggrvhhvihgusehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidr
    uggvpdhrtghpthhtoheprghvrghrrggssehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:FailZ7TMBt1bt65iVSoHTNlwW2neuNPNNF1thBfEUpwSFZfupYn92g>
    <xmx:FailZ_ykAkLwiCNg1Zw-jqenZg7G-W8XBbMWlUdwJswjpRjI4Oxm1w>
    <xmx:FailZ55DkZwcmfoo-IZH6EGa1zIFczGWWqD2r37o2X32Q02JsFs8bw>
    <xmx:FailZ8xP3_hMt8vOttB7BmzHlyUCbKcKremUKMKrbMXUkkyQEgxORw>
    <xmx:FailZ2lAwuLuPMqObLgcZ_2aOk_JXChntIobeWe5TCYyzsT-yDyd9iVi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 01:28:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3a2abb76 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Feb 2025 06:28:35 +0000 (UTC)
Date: Fri, 7 Feb 2025 07:28:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren <newren@gmail.com>
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 3/3] difftool: eliminate use of
 USE_THE_REPOSITORY_VARIABLE
Message-ID: <Z6WoEjEo9Seffm_q@pks.im>
References: <20250206042010.865947-1-davvid@gmail.com>
 <20250206042010.865947-3-davvid@gmail.com>
 <CABPp-BGi51EQvPOgaz8p0RjAJ0zDDeTpMDp__puz_wQH5wowXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BGi51EQvPOgaz8p0RjAJ0zDDeTpMDp__puz_wQH5wowXw@mail.gmail.com>

On Thu, Feb 06, 2025 at 12:31:14AM -0800, Elijah Newren wrote:
> On Wed, Feb 5, 2025 at 8:20 PM David Aguilar <davvid@gmail.com> wrote:
> >
> > Remove the USE_THE_REPOSITORY_VARIABLE #define now that all
> > state is passed to each function from callers.
> >
> > Signed-off-by: David Aguilar <davvid@gmail.com>
> > ---
> >  builtin/difftool.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/builtin/difftool.c b/builtin/difftool.c
> > index 81d733dfdf..41cd00066c 100644
> > --- a/builtin/difftool.c
> > +++ b/builtin/difftool.c
> > @@ -12,8 +12,6 @@
> >   * Copyright (C) 2016 Johannes Schindelin
> >   */
> >
> > -#define USE_THE_REPOSITORY_VARIABLE
> > -
> >  #include "builtin.h"
> >
> >  #include "abspath.h"
> > --
> > 2.48.1.461.g612e419e04
> 
> 
> Nice; thanks for working on this.

Yup, thanks for rerolling. This version is much easier to read indeed
and looks good to me.

Patrick
