Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B191121CA0D
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 09:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765185038; cv=pass; b=Cd0XWT6FAdaHbTqArDFwYHmvp6QjANYpIsI4jkeJAU7EWN2pDLYlN6AQ8Iu/JH7E2X/Lg8XzvRtGaRi06HxzwldQhhb0frQ3Tsl2oMriWBfkkPZQbpQC5gMjepQDscNAUmYx2Y7WqZa2mw9s+gRckyOqoCRcvlDuWAd6DDdPqM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765185038; c=relaxed/simple;
	bh=Zrd8OnLSA8sSMvdQAfIGcNVxYoCb2UsgZMPiXZbO/Qs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bu5FidQDDtKEevOtThlZpYBdxCziyAlF+TeHTVNd7nIWHMq0HtPqCEeKiQk6AXNUu51ykW1lTQQYfhGstxQDPbK8mVNjb1I0WdaK4gCfn2nxJQN7NNj4xFV2YvN+bxrixZxGoVWdQWx0dImudZXC4T3R1/whKpdmQbiarM6m7Sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=FdbdmrtW; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="FdbdmrtW"
ARC-Seal: i=1; a=rsa-sha256; t=1765185019; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Z4f2+mXLl4BXpZvs9qyGA16QsC3yaXIXnd2Dy6RbSYpIgLKRMjMdD7rZYGx+j9tfebj0NHDtNONrFs2gs0IEw6jl39azrbiqht3Sist9ylYdWOxJ+3v299lnbQ1PK+GkZZ7XVMGOv9DWGPCC/W9qYVJq/iZDDeVheU9yzzkvnUs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1765185019; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Cn1mLEarWYZ/bKkc44HyqFhdZ92d2sAjMc42gyqd1iQ=; 
	b=Yd5lbBpHHDjPFN1kRPqgmVVLoitMkr1KST+VvmkqKHyz0Hxy2ZMD6Yb12CwyRhqel5IjnV/ziXOMup0sRzoNC9qGs7NLc0Fyq0nfAnYFKlwBCtBwnLA8io+EBoQMnBhO39jnTMqu5H/YPor2KtM0DgY/vRkacC1Y/u+y3/Ny6YU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765185019;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=Cn1mLEarWYZ/bKkc44HyqFhdZ92d2sAjMc42gyqd1iQ=;
	b=FdbdmrtWHnSW/fSNC4Ivq+Tbs1qG+HvMX41MtiDzC0u+N1+fwihHCClw9fgMC1Am
	3pB09+mFll8soptXo+wWBdocbKHT1x7+cdoXEUbcgvdJS3xECN2l5bx6hrY22aJ87+Q
	IbF/YVsgH9UZUBR8SYyp7Ysd7Mn4y/sL7MI/elF4=
Received: by mx.zohomail.com with SMTPS id 1765185016763320.0118917735233;
	Mon, 8 Dec 2025 01:10:16 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Aaron
 Schrab <aaron@schrab.com>, Jonathan Nieder <jrnieder@gmail.com>, Josh
 Steadmon <steadmon@google.com>, Ben Knoble <ben.knoble@gmail.com>, Phillip
 Wood <phillip.wood123@gmail.com>, Brandon Williams
 <bwilliams.eng@gmail.com>
Subject: Re: [PATCH v5 4/7] submodule: add extension to encode gitdir paths
In-Reply-To: <aTQanNSlj6VxDY-n@pks.im>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251119211030.2008441-1-adrian.ratiu@collabora.com>
 <20251119211030.2008441-5-adrian.ratiu@collabora.com>
 <aTLNwHpLUcy-WsZs@pks.im> <87v7ikeng2.fsf@collabora.com>
 <xmqqqzt87dgj.fsf@gitster.g> <aTQanNSlj6VxDY-n@pks.im>
Date: Mon, 08 Dec 2025 11:10:11 +0200
Message-ID: <87qzt5uyoc.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Sat, 06 Dec 2025, Patrick Steinhardt <ps@pks.im> wrote:
> On Sat, Dec 06, 2025 at 07:47:56AM +0900, Junio C Hamano wrote:
>> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
>> 
>> >> It feels somewhat fragile to me that we unconditionally handle these
>> >> cases and try to find old submodule directories. If the extension is
>> >> enabled I'd expect that the submodule configuration is the _only_ source
>> >> of truth.
>> >>
>> >> May I propose that we instead always error out in case the submodule
>> >> configuration does not exist? In the best case we'd then give the user a
>> >> nice error message that tells them how to run the migration manually.
>> >
>> > Junio told me to not do any kind of manual migration and just attempt
>> > new names until one works and then use it consistently.
>> 
>> Indeed, but I do not think that has much relevance to Patrick's
>> comment.  What I meant say was
>> 
>>  - With extension, we know that the repository will use the
>>    configuration item as the sole source of truth.  Unlike the "we
>>    now store submodule dirs to munged paths" design that we saw long
>>    ago, which would have required us to sometimes move the existing
>>    directories to match the munging scheme, we do not have to
>>    manually migrate the existing directories.  Instead, we can just
>>    record the pathnames they already use.
>> 
>>  - And with extension, when we add a new submodule, we would need to
>>    give them an entry in the configuration that does not conflict
>>    with those used by the existing submodules.  As Patrick mentions,
>>    this name does not have to be done with any reversible mapping,
>>    and third-party software and Git reimplementations can always
>>    refer to the configuration to learn the path without knowing how
>>    the path is chosen themselves.
>> 
>>  - The above two would ensure that the configuration would always
>>    exist once a submodule enters our system (and "git submodule init"
>>    is done to cause its gitdir created).
>> 
>> So, unless I am missing some corner case that still exists while
>> bootstrapping a new style repository with extension, Patrick's
>> "error when configuration is missing" sounds quite sensible to me.
>> 
>> I am officially still on vacation, so I'd stop here for now ;-).
>
> I guess the one edge case is when somebody manually turns on the
> extension after they have already initialized submodules. In that case
> the gitdir paths would of course not exist in the gitconfig. But I think
> blindly falling back to a source of truth different than the
> configuration is wrong, as it would mean that the we have "a single
> source of truth unless we don't". It would kind of defeat the whole
> purpose of the extension in my opinion, as implementations cannot rely
> on it.

Haven't thought about it that way and indeed it makes a lot of sense.

100% agreed.

>
> Maybe the right approach would be to tell users to never manually enable
> the extension and instead to provide a command that both:
>
>   - Persists the submodule gitdirs for any populated submodules in the
>     gitconfig.
>
>   - Enables the repsitory extension.
>
> If we had that then we could count on the submodule gitdirs to exist in
> the gitconfig, and if they don't we would die with an error message that
> indicates that the repository is broken, maybe even with a hint for the
> user on how to fix it.

Thank you Patrick for clarifying this, really appreciate it.

I will implement this design in v6.
