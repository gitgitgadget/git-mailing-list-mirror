Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795106501;
	b=IYEouLNvESTwm/wwW12BjMPgThDTDFo5H/dHnpo5Yc00vWRedvdlj8NfrzRx4meBySfY
	 xr6D1uggyOklB5LRyurm+5Qf0vq3IPAVpy5f2w8yUciHLKd23rOjanE7ggrJnbFRsWHCZ
	 7W92TaCcdad18C/HPYQqrygW5Cfw2x94vJN4lo4T+kSldA8gQOzO+jm7UfHXX3MSCSlIn
	 nyTulRtzXbmeVJyFI74FkRn1NLbtnjPfErpzzGr0tC3qeEC8DR+3c0YdYDACewzPVTuv4
	 0AN1sANaAcodRM5VxJWcWVT5/tI6TVFWcB4GcpTXt9WEKRI3hcw91G6xnDAShovhpbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795106501;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=VNlLChnwFSdNBkRx+PcPtyJx4DOIOCHUVmGnITR+stI=;
	b=USzRBWAndCNNaqLLR0zz0uZX5Wf3K7HvVMuTf0x2qXSEhgCnZnbNIADSIPfv0sDXaGD8
	 aBjK9Q6PnrVIqQZzR/etj4YSYtG1rhqz1o+Pw7e1BXfaSaO4dwFsa4B2rgvaopCIGpqj7
	 YVwEVpzlcoa133mdP6KaBSwegfMFOz4E4sfk6+/E2ulAT3+xlan4nlweQ5g/7PlImLvkK
	 YyfPDMMKviI/1xAoakj3doq6M+eRm9aBRVcxSquKmbPAuOsy6qR5MMGHG5bvmAgA6qhF/
	 tgU69BlBG260/dEwGMLH6/vx7f2MeVpg9ni0E+H5UeE+EY4s4xOgmu2Gj5hBqahpXsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=hCoa9D6Y;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=B3dp3oGk;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0E7606A320
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 16:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B0E7606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=hCoa9D6Y;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=B3dp3oGk
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D4ED97A0124
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 11:41:39 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 19 Nov 2026 11:41:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795106499; x=1795192899; bh=VNlLChnwFS
	dNBkRx+PcPtyJx4DOIOCHUVmGnITR+stI=; b=hCoa9D6Y6V0Baoybmvn2grg7b9
	oKQFZpuh9KhHrCuI8A7xYGYDx6CVTH976ykBUav9hpCvqxxlSj9PV0CgQUmAi9s9
	1mSFD/g9Pxn69wPbk0zc/vubIm+ymTDMhvGJE0L0xcQrSW4SmReZenh/xMYhSzOn
	HeFYCZ+Sl3O1xdHRy+E8DuGNOUJhUxWegPOkwOsU0tykG41kwFti5q7GpOu+Ler5
	+mBgwWI1pSwrmISwreTj7ga2zHg/x08kOP6qMy11RTIwhTkZlnBluBU3YBnEp+vJ
	YJB7UrjySVnNepCszGpNV2Qyk3inEdOeJ9txuw3K8kt5eGDqCb0awAT1aVeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795106499; x=1795192899; bh=VNlLChnwFSdNBkRx+PcPtyJx4DOIOCHUVmG
	nITR+stI=; b=B3dp3oGknymxEj3n0ok4rrHkrmhnJUqtnq0WRPs66+hRg1gTPyR
	tpHuSRq90f+5Ana89Rk1I6UVa+wwDeLVGKNxy6PUHm8GptIknGueqSxER69tYNo3
	MHGurfsYybLbNzyy1DQSpdi9EFF2U/mQzqaDhdEkpnKBCk0l/R6WY4SSq4WpdKRj
	mwQw2q35Gu1+5ZOjNO2ivGH1HMnlvAmyDHxfAKqirNvmcTURvawOeW0zSM4NJGJ9
	v9clXF02hJRz6VxGkZKWt57mcuz/JdWOBnL/HKzc9HmaeGrBk+Mht7+0hYac5veC
	m1Gp7j2wt27O1ve+bCZYqbAy59OF7jSEILQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795106499; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:FcSgYKZne2+wGqUYGpFvCFtgKqBZY88Hppw/0x3ZfXjPpG3
	KOQWqPWWG1seABeAzj5fSQ5Z7az2plreoqMK/OXk9OYN2ofjvykly5zCldBscLq1
	EE+NWP3fX3XMmfcNVE/ZaQ9vJBNqSpbWgSPBcxZY6uaoALlFxa4tcKeJkPHq7BcZ
	CZZMuVJEnOAh4rThYY/bq4aQhV4V+ossE2qeXkBstQreWRBB+GK3VGRqinJkj0s8
	tsc+ML58Ur/+HE73hEb6AcQmjaeVghMy9B0+7S5sgR1Cg8D2L9cMSvDLCkxcR/6W
	1wRkpjafhf0c7aXsItwWoPsYf/X/VZQydQrOAIg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Gg2Fu+JYhPHcqXpmRXxj80RpiCHwsraecbVgOol7oKI=:BJZbekwf7FY8ouFdgEwwnZkp62oRuMZ0rP6aGvRYedE=;
X-ME-Sender: <xms:wyb_aldgXWKt_iQiY4_5b1NJqec1I5_DWMWTYr4wuoAf47Orx130WQ>
    <xme:wyb_aqEVsSMh0TCj_DjW0VqF621512s3FS5gfnoHqle0GicZBGw_mjGpgk3U-5FRe
    h56L31GMQ_TvAuLAZ1Z60zcH5LZHlLXhSdMqvjKrEjbDHMbcUwzQxA>
X-ME-Received: <xmr:wyb_am1uU31O1qvBsQAEiTvdEdboggKTM4UOwnrSCi4tQxTHpxwFJYX-NoOOIsR8MGAaGAs_gcUSJXCSZWYyxYmVUWEQkH707_fx>
X-ME-Proxy-Cause: dmFkZTEpajWiMxJU73aMLzbkk3p9j8AT2fcfnJLp+GRYoe7Bcqp24qoactR+makjOonW/4
    fCrLJbyFjz+O9OQSzmqn5Z0RzfvVPpFUOroHNzQOPqxujgpw2dmrUxuuYST0aKT74Ci8j/
    xJaRgBj6A3JErbHCzpfRYwf1BYLf0zQrw6+4mHCcynwL7vMhVHnt94p9cqzNmL8CTIJ6RB
    Ergz8QCpJjLpbHyn5FCJuDGllcorcdjARl4NSZ0o0+yxPk/5IcG0xBEnUGFdfBD/phK1+7
    m0Hs5kKsY6X2pIe55oMo9Sjk7YWdR5dMnqNLZg8h/f9owFYZjgnhDCyFXqOD9ELn7zRSER
    pU61tODXlpRYe14glJX9ZHLHuvJph2FrZPnKBn67cuc6EaL4OUWezg+W9248uba7zTx4eg
    mzRpVBTkoI5+ctim1fvmC0ud6ZLFxhe7L3+qd1/V1dzv+yy1zPyAcdhMHmwiU4D4i774Fe
    CSCqHMwEWR8UrGIN0OBOjlSxb+iIRl+OayTiMhCrL4uwcUY3+ly7BdjxOeu8elBSVgHdAO
    qeces4mTLzoJ71d0sQdU2l25GsWqph8CHvQ7j46Q3hMeYl0lkh1UKbUyzMhen4J+Xd/sGW
    gf6xGK97fAh+ZxcV2gvoyPiP5hF5vV4OGjg92lTqk2frTo8OZDNnhqdk7IHw
X-ME-Proxy: <xmx:wyb_aqkc2SnbJnfhUl3xt2e07cj7x6N89UdrqKB7Brkx-uwWanrm5g>
    <xmx:wyb_au_GEhC7X9lYzkjlvkoCjj-zmdjNnPSQRS_Pi_2BqkqZAnJm8Q>
    <xmx:wyb_anrHCWFDP4pMmu99EtMHT0eHg7YQV77-IKNMsejjmFHdHM-nDQ>
    <xmx:wyb_avnSEiE5BmIqIJt-_CrBbhRPUn86wrHg6J6BeKaCtuzxB7Bm6Q>
    <xmx:wyb_ah2McYymCLzRv24N_60w3N__LHuwe_YrV4_op3BQHx5juikxqmwu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 11:41:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elia Pinto <gitter.spiros@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>,
  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] status: reword message for a missing upstream branch
In-Reply-To: <20261119055026.759205-1-gitter.spiros@gmail.com> (Elia Pinto's
	message of "Thu, 19 Nov 2026 06:50:26 +0100")
References: <20261019175722.5223-1-gitter.spiros@gmail.com>
	<20261021072137.258934-1-gitter.spiros@gmail.com>
	<xmqq5wxu87es.fsf@gitster.g>
	<20261119055026.759205-1-gitter.spiros@gmail.com>
Date: Thu, 19 Nov 2026 08:41:37 -0800
Message-ID: <xmqqik1szsce.fsf@gitster.g>
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

Elia Pinto <gitter.spiros@gmail.com> writes:

> The same check again: no push refspec matches 'master', so
> branch_get_push_1() fails with "push refspecs for 'origin' do not
> include 'master'", push_ref is NULL and we return false. The refspec
> and mirror tests only come into play once we know that @{push} is the
> upstream; they are there because push.default is not consulted at all
> when either is set.

Ahh, that is where the trickiness lies.  So the "mirror or has any
push refspec" check is about "should we check what the default say?"

That may deserve a comment, as you said below.

>> You mentioned "nothing" in the log message; shouldn't that also be
>> special cased?
>
> With push.default=nothing @{push} does not resolve either, so it ends
> up in the same place; 'status (missing upstream, push.default=nothing)'
> in t6040 covers it. "matching" is the only mode in which @{push}
> resolves to the upstream although "git push" would not create it, hence
> the special case.
>
> None of this is said in the comment above push_creates(), which is why
> it raises these questions. In v3 I will spell it out there and add
> tests for the mirror and the narrow refspec cases.
>
>> But we call push_creates() to compute suggest_push whether we have
>> advice enabled or declined.  I wonder if it makes the logic flow
>> cleaner to give a few more arguments to format_missing_upstream()
>> and move push_creates() call there, not here?
>
> Yes, that reads better. I will do it in v3.
>
> Thanks for the review.

Thanks.
