Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DB826983B
	for <git@vger.kernel.org>; Wed, 21 May 2025 13:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747833266; cv=none; b=SZZqKztkxiKEnzsgkhs37DJ/2A8gpEKG+ic14exwYXnznHw9KX+x2h7BHhSWaclFePSqb6HlhyWNuaoBd6CfP2C1Ht99PDDejisTi2hW07BvWjILa3xk3fhQM0B7Rt6wpbLQENuKpmZ/hnupCDE24RHiCYwBQjQKff65dRY1mI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747833266; c=relaxed/simple;
	bh=p+ABMJwQfU1Vh02nl2cM5rJPJ8t5+6IIUK4NSZtLm6g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=klQlZEF6dljtRUFNU7ooYAYAY/S5mxL6SCWgxdB3xt1WlkPpOp4aN3inaaMGingSNIQRZOZxAVUyt3EVWT9DAIYD/RFxtIfxR7o6q2HAjC/2Es4xroyOjInbDSOeAkkT5SGCsixt6Sf269iiFR4phffnKSTEspzoloNLDn4Em1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FJ+txef6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ApxA/xe5; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FJ+txef6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ApxA/xe5"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 106902540139;
	Wed, 21 May 2025 09:14:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 21 May 2025 09:14:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747833262; x=1747919662; bh=qBDd51H2Z7
	JId5DBDC78HYI16FZekiZvPwpzVLEF4MM=; b=FJ+txef6JDXxro23sfsGFvQKfd
	OCQYQYLrr9smzMfvEIkcog3yD6oMjofmtaQn9TDz1AAscE24qaJWpfjzPNj8Rw8d
	6hD+nBf3Bp1hcckPCD29+lyOA5A4bhuSmNndTpXqnaBMEltWVJvgfVdmCNikYfr3
	1lwMr7JZmG0qPyx43GjISoiY66WxgKP3iG+zGuG2lWWFmfzQay/L+yq7PZ+aJAeI
	ryD/lqwkBVLhsS8XYTykhorNPOjM/bsXILgnvnuqa8yCYs9TMGru54B5dmuUX73g
	XNHTtu8WTKFOG9TAQ+s3Xa3ILeORN0XtO4FtnBuOG6BOxemsrjeADsIrFOSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747833262; x=1747919662; bh=qBDd51H2Z7JId5DBDC78HYI16FZekiZvPwp
	zVLEF4MM=; b=ApxA/xe5PE5iCwDuh+cXRiuNW2/7i3whGdiX2l2LCEOPXBNNc18
	5xHxV5ryTm+NQpkE6p2olS8IK9oKah+enVIvYZvH3EHuVxIoQs0U7MFZ+OW2GiPG
	y8NdrvzvgPxGnTIudKl95grhTQicxe4eXcqSMT76r3Zv+y/nEoR3WrKAJUOUE0Ym
	k8gwBf7ql6qC5rp2QLlE9/pqetE07n9dg92c8Y5P0V2viZ9yvacltU+nBWK3ZRkD
	KLMX9KFwy4lSYMxwpm4c4WNP5SMGli3ZkCuZKRnWDr9Y6fbxG2snPJEL9NNret4n
	EjyWHYdnZC/BIF/Lh/ixUQXGVfEnJ1MqATQ==
X-ME-Sender: <xms:rtEtaG_mddv46swQrjgMJwtHe42gYJrJ98M01Pi-fiThcfxRkXunSQ>
    <xme:rtEtaGvzhFarjmSNbqz28isTa9zMz5mYmNis406I3YI0QBzx4h2smg10vqv53bM7v
    H7RgMRcdvDHEdeYiA>
X-ME-Received: <xmr:rtEtaMAeUnE_bTdSIx3isQKX37nFVBM_sAV5nUCwfM-kb-WjRiuE2i32rvdGx5ZsIel19gzaCOksY-1_EtWfn2tWiD1Lojix7viY76o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefudekucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeeh
    ueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprh
    gtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:rtEtaOcDeyXbT77B0YbmAthgZy1kzcpjQ1-6WTiD1CE3XBNQrGmaFg>
    <xmx:rtEtaLP3GaLUkwPX5ieMzxgby4RCZV-w5GSU99LxV4CsI7EvsSiMzg>
    <xmx:rtEtaInlg21WQvGaKxWvGzheyMlwNXnin5LxkYwFr88A3lg0eZS9mw>
    <xmx:rtEtaNtiS_wi_oh2bJt_nNyGn8oSSyPhnSRQT0CKEjbirLsioKsuAQ>
    <xmx:rtEtaAZnl6UW8ZHHGOXb5PUANiCQjA1xYZb56C-uodO2UAmIeFMx3mHv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 09:14:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  peff@peff.net
Subject: Re: [PATCH v3 0/4] fetch/receive: use batched reference updates
In-Reply-To: <CAOLa=ZTyE9myZqy8UHe=YeZ-diy0Q1UDTBTB3d1XGC09XvshAQ@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 20 May 2025 02:05:09 -0700")
References: <20250514-501-update-git-fetch-1-to-use-partial-transactions-v1-0-7c65f46493d4@gmail.com>
	<20250519-501-update-git-fetch-1-to-use-partial-transactions-v3-0-6cdfd4f769b9@gmail.com>
	<xmqqy0usmprh.fsf@gitster.g>
	<CAOLa=ZTyE9myZqy8UHe=YeZ-diy0Q1UDTBTB3d1XGC09XvshAQ@mail.gmail.com>
Date: Wed, 21 May 2025 06:14:20 -0700
Message-ID: <xmqqmsb6ds2b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

>> Not an issue with this series at all, but one thing I wondered is if
>> it makes sense to change the type of strmap_get/strmap_put to deal
>> with "const void *".  That way, it would not be necessary to cast
>> away the constness like so:
>>
>>>     -+	strmap_put(failed_refs, refname, ref_transaction_error_msg(err));
>>>     ++	strmap_put(failed_refs, refname, (char *)ref_transaction_error_msg(err));
>>
>> without harming the other side, namely
>>
>>>     @@ builtin/receive-pack.c: static void BUG_if_skipped_connectivity_check(struct com
>>>      +		if (reported_error)
>>>      +			cmd->error_string = reported_error;
>>>      +		else if (strmap_contains(&failed_refs, cmd->ref_name))
>>>     -+			cmd->error_string = xstrdup(strmap_get(&failed_refs, cmd->ref_name));
>>>     ++			cmd->error_string = strmap_get(&failed_refs, cmd->ref_name);
>>
>> this piece of code.
>>
>> It may not make sense, and even if it did, of course, it is totally
>> outside of this series.
>>
>> Thanks.
>
> It definitely does, The only other typecast I did find for `strmap_put`
> was within 'strmap.h'. Nevertheless, I think it makes sense to make that
> change. strmap shouldn't modify the data provided. Perhaps #leftoverbits.

OK.  Thanks.
