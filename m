Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23E2382
	for <git@vger.kernel.org>; Tue, 10 Dec 2024 01:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733794124; cv=none; b=FhuUaP3ZoHOkuZ/n/+9U+aOCRJ2UO0TYbzkFpa84UWaHCy/T6JbNb05MUZLfGcFKOlz7glPzVcOv+jegZQKsEeWCeFwxfVepTqBYMCrmj64qQaZ0PwAx5xxYb2LAReb11v1vI1ryEXb1YlsGA/BczNKWqhOirzDffNEYC1BCzJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733794124; c=relaxed/simple;
	bh=mjFKuqFgBrVxyP0uwneOg+Uxf+XkFZTBBk2MEGT2hz8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jZ5i2mNT1vVt2ZQ+GS3kcTgUbXU+yOXUG0RKSXwk4pVh8imilgdkbmkjou5JB1JiqncmNZJmEOYiEZnjKwiwgWIc+fjtRfYavbQ5J0VJ62W8n6IxKO1y0fywl5Bb5WCFoTTrXvbSSBxVx8uzXZfLb8sbQTYiHmK6lx+nA3pePno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wgA7Mrxf; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wgA7Mrxf"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id A35C413838C5;
	Mon,  9 Dec 2024 20:28:36 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 09 Dec 2024 20:28:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733794116; x=1733880516; bh=qyrJTFhM+zrifOLRJIk5oitJKIVty53qsqm
	3fpoX3nQ=; b=wgA7MrxfAFJGtO403OJGV1B1ZutAALLf9udEZhxcPL6q49uXf/z
	P50FmgvYILdvkdIdCHkTiQcJ087KDl6+LUzLJWas7VnBd81LjRblZzKaE4Tmny6v
	/T561g/BmcEJRWFYzQ2Ts8diEPqIlKDjfgNJEz0Km79wVj4I4Aob1HBjZOAFYUGQ
	oOixGa7YFyXqoHTW1DqjVyWKcqHIEbTVzM1St3neLMFzpmBZh5x7BHQlsfve4do0
	aKjJITbZAXQS4nkv4jHIRluwBIGucfWbCiI+6+/Y4dolXQ22h3zAdtHSmepf/unI
	JUZwLdP5EXoMstgoJdbxIqIy/epJyAkDvDQ==
X-ME-Sender: <xms:P5lXZ6KnqqidbRyiXZzw-Sg3bBrX5-tx8wC38ykeAjiLd9GizTamGA>
    <xme:P5lXZyIIk3Btv0eLflvgFge2hLIvAbnOMibZBdT7-8h0a289mIW67N6BAf-wA_8EY
    Gl5IAV8ukwMyjwuuw>
X-ME-Received: <xmr:P5lXZ6taofrPwSURCgwG50FOoYvQdS9A5l3tUrZNf5IjUiAWTSLT78qJRPhYgRKJKEy4hW-plLRE2yU3yLbrjUMX246znXJ617oNjAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeejgdefhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrd
    gtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhhntggrihekieesghhmrghilhdrtghomh
    dprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepmhgvsehtthgrhihlohhr
    rhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtoh
    hmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:P5lXZ_aosNK7tfiuuGQX5r_oqArvsLBAyO2VEPs0Z0OQFmFZbpuuCQ>
    <xmx:P5lXZxa5EMD4WPTV0GJNwSEahGdlZcLWNH4VQDAa3cgvNeEohmxTwA>
    <xmx:P5lXZ7AulwITtU_D-7e8Y814jxkJ-cj6kXHOb-5AFoT5HnsaDOSLRg>
    <xmx:P5lXZ3aSLgso05dE1SKtiC_BICI_Y3thwm9h7AFoP_h8Us6EXHiOfQ>
    <xmx:RJlXZ_ND2FIYp9QOsrgnIuTQ_yHzey-Kc6Kxw7R98hdFmXdrE9nfVn0U>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Dec 2024 20:28:31 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Taylor Blau <me@ttaylorr.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 5/5] doc: add technical design doc for large object
 promisors
In-Reply-To: <20241206124248.160494-6-christian.couder@gmail.com> (Christian
	Couder's message of "Fri, 6 Dec 2024 13:42:48 +0100")
References: <20240910163000.1985723-1-christian.couder@gmail.com>
	<20241206124248.160494-1-christian.couder@gmail.com>
	<20241206124248.160494-6-christian.couder@gmail.com>
Date: Tue, 10 Dec 2024 10:28:29 +0900
Message-ID: <xmqq5xnsmima.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> Let's add a design doc about how we could improve handling liarge blobs
> using "Large Object Promisors" (LOPs). It's a set of features with the
> goal of using special dedicated promisor remotes to store large blobs,
> and having them accessed directly by main remotes and clients.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  .../technical/large-object-promisors.txt      | 530 ++++++++++++++++++
>  1 file changed, 530 insertions(+)
>  create mode 100644 Documentation/technical/large-object-promisors.txt

Kudos to whoever suggested to write this kind of birds-eye view
document to help readers understand the bigger picture.  Such a "we
want to go in this direction, and this small piece fits within that
larger picture this way" is a good way to motivate readers.

Hopefully I'll have time to comment on different parts of the
documents, but the impression I got was that we should write with
fewer "we could" and instead say more "we aim to", i.e. be more
assertive.

Thanks.
