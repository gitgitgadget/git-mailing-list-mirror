Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794252610;
	b=FQjk5qf/mp/X9JukTJ+ZV4rNLSMaJ7RSYMjsqbZ7Sdp3FnnRD53jbpqe335nyqYM3wWE
	 Ol4bFkxRmE+BeHI5cyXcn1f+AtPMZlnrQMPfVmxvEdtLZq4HcVALNCTzhxtGhbjU2JfVi
	 mcmuWE6ZA9KHuD924J6XXt+TjuAGoOAU8hcP3iTzFFg7t/Eoh6g8pweXwov42/Tohi+ah
	 c98q4lQv5SIT4ygRN6gyDUzD5OVbtk2r/VoRUXYoVQij6F/lhhguz2asoMhQjgd1R/1NR
	 twNP5rQfKc0YMYPg5Sn+V3wzPVJWkuzT8RXHSBc4NtB+7cChA5Bo4HVUFS47h8OmbgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794252610;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=Q1c3l/FuYhvLnEjdaxrnJXdm053aaSQrIFy1I79vRIU=;
	b=We1bBNbDUC96P4Maeb+y3zmAWaaP/Q2P7AVfW71U2S+8KjE10pP27eHW/paJXcj853P9
	 iCZboza7qahsHxNvWcCfEzYdfiM0OD6tdWmd6qFdeGsH9fNI42RGjpEPEnEto4XWgrpgu
	 st2DJrJ35yaQ5oIO51b3htFD2BErQUnEPHV07CycCVStpNiUivGz86WHwgSfnHBs2I+YO
	 uyWhXB+PtuKoi3UeP3+TOX7n/yq0ijbfuf5t7m5LeOw9caq+Sg//1pxvMDuB65+Y+bOFK
	 B98GLKdM1ccY6nanlPpZ1nW7pREYC2jrq2v4hFD/vfVNRD/v6Reu2W9tsWDbpimxzzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=hA7wmbhR;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=B5UMqBvQ;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A364606A32A
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 19:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A364606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=hA7wmbhR;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=B5UMqBvQ
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BA31614001A8
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 14:30:08 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 09 Nov 2026 14:30:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794252608; x=1794339008; bh=Q1c3l/FuYh
	vLnEjdaxrnJXdm053aaSQrIFy1I79vRIU=; b=hA7wmbhRQnLPwc6DJx2DEO/qhi
	dKej8z0JlG1IGJq8aygf9NXXNRQip1gUSfQR/BqaXsUSJgCNEl395UlEA18BNm5y
	7to2nXZlEj3zdEyn2EnoR8t3zry+5yFb89+kary1eaBspaiJztz1rbO2JY8pPLzr
	r6GJ+yzHE4LM5eb9uWMgIIwx6oa8Kn9izcjHTyWXiZqd7r84VkuGalNJxSGDVcP+
	kc/76M2XRoxHmSEu7lthz3rS4h7f9e+eBfmF8afoorJXYicS4KbucMXEsFzBVmhi
	FDZALHMnrzP3J6w5CQn0E8ylSY/Z1HxcZGW0vnCrBqYfGlObSkyQucd3BMYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794252608; x=1794339008; bh=Q1c3l/FuYhvLnEjdaxrnJXdm053aaSQrIFy
	1I79vRIU=; b=B5UMqBvQjX+jEnz3pQwaAvqxE3b2pYBAhKBLkkHSBMXw59KCIwI
	pmWH5rRV8hGc3HMGMt5h8LUX9ULONP0+PSnSQFr29Woo159UGkRJ7l+Ih6QPKr3L
	6WqeAFl48R7ZJNwhZh2UWTSDUoei+Kn/c01P6yxY2i7/6TwMpO8NezJeusbmN/WM
	WPntQJ5zDHIgxq53RPPAAuvV8hVkBtCTd1RW4x4J0o/xmkt8u8TBNfHKp4NcOenD
	gyv94aCWgbiwyRWZOOUcySG7HM+KqcVhCeoAU4NVTX9JlQCVgScqRfJTguGuu9iV
	fSI8pj0DpZ4c1Pbv+Km0dqX0Pk6a6RNGhYw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794252608; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:FaQYvW6eN0nYMfgUWrJDrQhDV2JPcUHSbkpOdcs4ox5Rh1l
	obzVV00D2Wt3Hg0OzIp6m5dpun52BB4USpRpWPwsG6sd9t7hXSDyQ1KdkaDOdkHK
	+qw21wsqpuYgvkqSvSRt4wuz7k1ZK08bWdh39nN7aVKN+c+yCwVdqXaHVRcd+ePf
	Smb7BO651osJT6qqlYrGnaDz+JP+HOFZMF6EQE5Lnelg41y7q8ocqDB1yVJrq/Jd
	tZWTTpFuX5i4scDTlzCkg/n+pDJqhoKWQZ8c9C4zp6V+IMfqconb+NKTp+CwEr+f
	+KCZ0Ty1Qrad1clkND/3HJWXXpnRxlwuUaj4v2Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:gI8+Gavg2bbpbKCg7s8plbBQV0AQxY0sR6g97/L2IJU=:QeE5wCWih+o9L9fKQchSfXCl0vW5JIFmKbzTy4VzFOw=;
X-ME-Sender: <xms:QB_yaurUA-lcotezA3L_rGQHTDRMIj1PwO8IPOq_BG5pQ3NcHueumg>
    <xme:QB_yakHbdY3OfU9jimIafk82Mbq590ujGVJZesFo65LLZGkSFX4xe3SYw_MbBkiq3
    BXtv7M0JFvDJFPjdghcdf661DPYwMJTQsZt1pur70tpmD_HxDBXPw>
X-ME-Received: <xmr:QB_yagnJlNAXvexE63F7rKTHExsPBELuU_snLfYJY87L2AmKi_pTP7mtse33PSnbTKJnhCJbEwcvdGnxGFtFGxdiiPqsOtEaRrtx>
X-ME-Proxy-Cause: dmFkZTEAGWfd2UfhrK4W95OzLpPCfe2+AK5Q1xdrwqC/+WAE813Al7isJDYqbzzugSa3Ou
    4HcsforlVJV94k/2SpV8XWwwjYRfDftWBle4yhRX6tPiAmgf3EdngBri75RA2ZNufcM6eW
    36AsOiO7tSQSvw9+lK6k2kQYylaZ8SLk9dDbvNmBlYeR4rWxT0ksjhIbVB58SwaaLENSqP
    w4oNQgUNYQwmxHUFroh+GGiXyTGgho8OP6vdhtiBrtZBofOF5eDgm7g17jcim4L8Y09gly
    cNysLLxMyZQzW5rkdkOaTVaGxy6e0q1icAq013gLQN/0b7FfNvLuA293vOkI/I2SLeM1aA
    n8gv2JY7M5JiZMGt9HcoQcwDs6aY/m9KRcVgncmNEPPmmlI3BHqZaIiElr6LbIFwGn2U1k
    OOc16K9+Jj9T3pTg1tAufwAQxE8zy4oxkOXAlbm2byIQjLAk/aiLsrU8oz5ynRYT70YNgz
    wj+EK4d8qCv3hURDugTCasLH+9pbpdpYrke1ahUZx53XBxmPKHAPbqEpasHRgAwIKNrIE5
    xzeddRR4Bpo0DW9DgkEJ/h2QXrya3l+xxNty/PmMWKhUAVf8UG3efbU2FN4n10kfOjHzqa
    6fRoZcG3BBgLt+3l/i7qFp/VVzkg86HYH07pdMsEnwdBpwExOt5O5psgeqww
X-ME-Proxy: <xmx:QB_yankyDochvujpgmVTFd-8TbWhPtyS8CETDlnbkLRxRl_GCe_peQ>
    <xmx:QB_yahuvUSI2B5AXpT5fex_iPoQ_PvO2nbJVdrHUlyBigmCHjFHbVA>
    <xmx:QB_yaqlRj-GtnCtg8WgxtNr-IWLCxPp6rUROQ2GPWws18vdTpzjWuQ>
    <xmx:QB_yasukAhHT59PThtZap1wUtOAy3nfxKbWN0FlMI2SnHQZAEDnp9A>
    <xmx:QB_yasP97GYjQy4UVdfr9aNKym-MhpMpPSrlhcs5Qt6L4T9bfXh8wW1x>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 14:30:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] unpack-trees: lose USE_THE_REPOSITORY
In-Reply-To: <avHNf-aaxdsyim7g@pks.im> (Patrick Steinhardt's message of "Mon,
	9 Nov 2026 14:41:19 +0100")
References: <xmqqtsltbfdv.fsf@gitster.g> <avHNf-aaxdsyim7g@pks.im>
Date: Mon, 09 Nov 2026 11:30:06 -0800
Message-ID: <xmqqecctzttt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> In any correctly written clients of this library file, the
>> repository instance that is pointed at by these two structs MUST be
>> the same one.  For now, make sure that is the case (and otherwise
>> BUG out) by introducing a unpack_repo() helper function that takes
>> these two structures (when available) and returns the repository.
>
> Fair. It's a bit curious of an interface to have this kind of ambiguity.
> But as an intermediate step I think the proposed solution is okayish,
> and I do like that we at least verify that it's the same repository.

Yeah, while I am reasonably sure that all three (when they exist)
must always be pointing at the same repository, I may have missed a
legitimate use case where that assumption does not hold.  And that
is why the initial implementation is checking them with paranoia to
easily detect cases that I missed.


>> +	if (istate) {
>> +		if (!istate->repo)
>> +			BUG("istate->repo == NULL");
>> +		repo = istate->repo;
>> +		camefrom = "istate->repo";
>> +	}
>> +	if (o) {
>> +		if (o->src_index) {
>> +			if (!o->src_index->repo)
>> +				BUG("o->src_index->repo == NULL");
>> +			if (repo && repo != o->src_index->repo)
>> +				BUG("%s != o->src_index->repo", camefrom);
>> +			repo = o->src_index->repo;
>> +			camefrom = "o->src_index->repo";
>> +		}
>> +
>> +		if (o->dst_index) {
>> +			if (!o->dst_index->repo)
>> +				BUG("o->dst_index->repo == NULL");
>> +			if (repo && repo != o->dst_index->repo)
>> +				BUG("%s != o->dst_index->repo", camefrom);
>> +			repo = o->dst_index->repo;
>> +		}
>> +	}
>> +	if (!repo)
>> +		BUG("no repository for unpack_trees()?");
>> +	return repo;
>> +
>> +}
>
> So this overall surprisingly complex, but I think it's sensible to be
> defensive.

Yes, we could do

	if (istate && istate->repo)
		return itate->repo;
	if (o && o->src_index && o->src_index->repo)
		return o->src_index->repo;
	if (o && o->dst_index && o->dst_index->repo)
		return o->dst_index->repo;
	BUG();

but then you'd need to start a debugger to tell which assumption was
violated.

>> @@ -345,15 +394,16 @@ static void load_gitmodules_file(struct index_state *index,
>>  				 struct checkout *state)
>>  {
>>  	int pos = index_name_pos(index, GITMODULES_FILE, strlen(GITMODULES_FILE));
>> +	struct repository *repo = unpack_repo(index, NULL);
>
> This conversion here raises the question what we want to do in the case
> where the caller has both structures available, but we don't end up
> passing them to the pointer. This could in theory hide a bug where we
> have mismatching repositories when the entry points don't verify that
> property.

Puzzled.  Here we do have an istate but have no unpack_trees_options
available, so it is natural to pass NULL for the latter to tell the
validator "we do not have unpack_trees_options".  Are you worried
about a case where a programmer who writes an unpack_repo() call
passes NULL by mistake efven when istate or unpack_trees_options are
available?

Thanks.
