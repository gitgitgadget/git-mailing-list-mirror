Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D49383
	for <git@vger.kernel.org>; Wed,  4 Dec 2024 00:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733270982; cv=none; b=rXi5Pgz3sbLOtWUlwxN6dUMBH4UI0rA9uLIgw3H9Y7eLugWhGSnP3MLiDMgSwT8lK4fd55i1cMm565n+YX9SIZnb7+4zwURQ9p5pXirPU5mZQS++mXI7ctq6tpulmM/ZEqFgHv3SO7zXnKOJZ7iX7TzusYA5S8/T2sqWWHLFJzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733270982; c=relaxed/simple;
	bh=ugDy+/eN+RlOe1v8NHyolCrMTv5qbpDRv5e5BAnBIVU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XVZKWfX3NE+xEKEhKskDeiEOpfFvVtYg+m/ssiiHj/nqrgXLehNmj6HWyw6c+VVufsw9BkoqXAICAJ3Wnvxz/ARbPaRVMZeF5BIcs9MZPKRJJSKlcLz0DV2X5+hHVeX8l5qQOP1JhlbOryC5xhuB6gwXFdUhJgvMojXazESB+QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ckjszv1i; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ckjszv1i"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id BB3EA13805F1;
	Tue,  3 Dec 2024 19:09:38 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Tue, 03 Dec 2024 19:09:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733270978; x=
	1733357378; bh=3wTAVBltY/9jPmLtRjKbyxMlDPQzPJKxUsXZ9CQR4iU=; b=c
	kjszv1iGu7hYz/Wb+qNn9bfTFdfvocj3Rt761cF9L62/TLrV4RDlVbDFkczhSu8i
	Xd0DQk0+JqOWcs/8y/4qRZvXwUKFpL+Dbl9FiudU4EtbuSTTWUnQhJZCu21UNKHg
	l+DyerKDsFIvQfpLPZUj7EtXicAVA/MjbfWyB7Zns5L0NlnfxBXNplF+RRB9NCkP
	+lmD1PS5sUmeGmb4VFGEADmFes2oSe7R24BeMt0VrQQ+65djOK1qzrVNwOD3VgLg
	NiMp5PTZp40hos+E6SctkCRMo/jXt+1CfpKDKHUcnyIC57zShnetvvnMiDly6VBz
	LT3hF44m2BQJNWGyC2hTg==
X-ME-Sender: <xms:wp1PZ_J18AFny81l1WIDDhJxNDt10fFCT3C94TwvAJdyyFkltV9Ohw>
    <xme:wp1PZzLAZ7yCeCYUjTeAWj99iuJu7-OG0UmEkXcah6fgaPb-QSGzs1gULqFWrtnei
    Kej3QYhAaDKXBjQ2g>
X-ME-Received: <xmr:wp1PZ3sZUvCxMPuColOXNai19m5hDiEQBNfZTgwbrOHCngPcOjrIkmOUthcT4-HdJQKX1-FqgWmN_KFiV0Dc34MMS5Z4En2vFeChlwI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieeggdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeen
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfekfeeh
    iefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhjuhhsthhosehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:wp1PZ4bHIIKxDAi3R6Ng9P4sTmGpsnSTAKdjSy22RIurr6e5egzTcw>
    <xmx:wp1PZ2YcAzvtepQ9xx89MSMNw3iXFkwnH5GfAabnFNj64WuFv7zYlg>
    <xmx:wp1PZ8BXxQ4zLCCAO2LC8BtABkHWX2xccSKfeN92HX-ojPZqizYaSw>
    <xmx:wp1PZ0Zuem6OQ_EIDTnjpMwJO-pLjpDjNhCeJBaj_AnOoJ3LClXmmQ>
    <xmx:wp1PZ9U_VQeyLf8T-hRlDm58h4v4IOrIccSgY1FrWp7opZJN4MAN9iVF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Dec 2024 19:09:38 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2] strvec: `strvec_splice()` to a statically
 initialized vector
In-Reply-To: <5bea9f20-eb0d-409d-8f37-f20697d6ce14@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Tue, 3 Dec 2024 20:47:43 +0100")
References: <37d0abbf-c703-481d-9f26-b237aac54c05@gmail.com>
	<5bea9f20-eb0d-409d-8f37-f20697d6ce14@gmail.com>
Date: Wed, 04 Dec 2024 09:09:36 +0900
Message-ID: <xmqqplm871hb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Rubén Justo <rjusto@gmail.com> writes:

> Note that an empty strvec instance (with zero elements) does not
> necessarily need to be an instance initialized with the singleton.

Correct.

When (vec.nr == 0), vec.v may be pointing at 

 (1) an allocated piece of memory, if the strvec was previously used
     to hold some strings; or
 (2) singleton array with NULL.

and vec.v[0] is NULL.  This is to allow you to pass vec.v[] as a
NULL terminated list of (char *) (aka argv[][]) to functions.

That can be said a bit differently and more concisely like so:

    A strvec instance with no elements can have its member .v
    pointing at empty_strvec[] or pointing at an allocated piece of
    memory, and either way .v[0] has NULL in it, to allow you to
    always treat vec.v[] as a NULL terminated array of strings, even
    immediately after initialization.

and then you can lose the strvec_pop() illustration below that talks
about an allocated piece of memory that was previously used.

> The recently introduced `strvec_splice()` API is expected to be
> normally used with non-empty strvec's.

It is perfectly sensible to expect that you can splice your stuff
into an empty strvec, so all this sentence is saying is that a
strvec is more often non-empty than empty. I'd recommend dropping
this sentence.

Something like

    When growing a strvec, we'd use a realloc() call on its .v[]
    member, but a care must be taken when it is pointing at
    empty_strvec[] and is not pointing at an allocated piece of
    memory.  strvec_push_nodup() and strvec_push() correctly do so.
    The recently added strvec_splice() forgot to.

should be sufficient.  Notice that I didn't have to invent a new
term "empty-singleton" at all ;-).

Thanks.

