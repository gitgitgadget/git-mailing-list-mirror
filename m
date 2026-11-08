Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794112980;
	b=pUp2cd6FJ5BtM4rr44A5/5w85RjzKqBwTTzjgyqpCe/YrJcMSNPw3cyczY4HN419ZS3f
	 W9dGJM+cPc27jRjWlm8sa6iBNIXHwKRu+4VGFrcZRuopbVUSDO3LEutfXPo4VgGjED/x+
	 krcL43SwuaMHNOq5+3A+gBrmPbZ2OJC8I9d9P39+tCYLDSZvlBDmb4Art7/hlpBzMz1Uc
	 zKdbgC/8gwAvR1fqwTytcEtlnyVQTBx5tpgOHm6oHs40Dey8Cd5QQO78gNvocN54RSTiO
	 X938HWkMkQC/SX0rY8Rog9YWoGB5P8/h8pk5l4qRyPIzecgA//teaCJNN9lUaF8mrfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794112980;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=IdVgKSoL/vSjQ9pHDup1V+mMLkMQTSs6yZ1FGAwq3X0=;
	b=hML+rsCKZCUEaKnKT5puN9AMhLS+UOiYTx7fkhv3ufqOf20hEJ82QbOub2UPep+5DlmM
	 gm7usdjxglZx+8i0LdnIzIVeZ7nUUOvfUUu7mlhX/JECilz6FlQzDrvraBNGta4Pznqv9
	 /wQG9Dw2KRO8tCmc2yZ3+/KQMtAFIMU+NHo4kbBoS7t0lSHCm7zzXOfgcV25x6qKfvHok
	 03mfeHujVrtPL9luZessXAd5Cumy9wZFknY2ayjHyYb8gN2WfzyUqyb/dzc/1TF3lR8z4
	 ty+fZNQ2f77sp/BuL0X6SeWlRaJMO8wK1KXX8pOBgT8Ga7Lgmfhs5qWbUy1RY2ovJyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=N+QbOfa0;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ChTu5TqZ;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1783606A31A
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 04:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1783606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=N+QbOfa0;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ChTu5TqZ
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id C360E1D000D6
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 23:42:58 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sat, 07 Nov 2026 23:42:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794112978; x=1794199378; bh=IdVgKSoL/v
	SjQ9pHDup1V+mMLkMQTSs6yZ1FGAwq3X0=; b=N+QbOfa0wBJjH0Sd3NKvHKzw6p
	5p6HqXyrygH4cIrzb54Yf4uZni+n8kyMaFplAxgQLdRyvuJ/widSO3DBVkptLM2b
	xRcZcD5+8ISR/omxoRxzCFyjgBv2cG3OxbM4ZEMwB4qy9rS8pRLGc7j2AzHZ5rRa
	K4PcQyQ1jwtLlfns94ZMLakOaGTYWQsaG76/ORiWfYwEVFriIooUL33cxfe6+CoT
	X+F8HmYfYPKudh6jI9tk+5nJR3dg7w474bo4GegTFwh9EgB/wwgAzkIzLg+ACrMd
	iIrk/7n7afA6ZGw2AFnJHpM8SjpjxW/fTkHK+m2R2kcac1fOok8vY7An1W0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794112978; x=1794199378; bh=IdVgKSoL/vSjQ9pHDup1V+mMLkMQTSs6yZ1
	FGAwq3X0=; b=ChTu5TqZnzliFjz8pYoFOHt/1h14kEF8VMUpSXlSukR5A81I5Ff
	qpCtp49Pi+CmWUZ0Mevoyo7Ska1+YeX6Ko0sDrO72FEYVfIHwByVgGaFFN9ctelI
	6G+tDgFYxdAYR5gKGFOadhd5fb2QGZXw0PRF0m6DGJvzJv0mAQ+XdP7tkmkTRX8V
	6BeghpeDLZhCwI+WEs56YQtx0e2273Hd7p+f8Gu+R8SAA39dK9uf+y8+fuYACxKK
	mBHar0iPCn0wGh9PBtlvQ1xq0S5mCJWwhIe5wIu3FC4ey1iPYT4Vr3qEpjSFokyG
	MDwUd2Zqc4t3KlyXyj93q5qZ235Quns/mPQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794112978; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:CcnNGJUBeKz/0XGcFWXtNXUqo0mJOcCw+9f4BI//IUaVgnz
	AXb26OFjV2jpymnmfShEjrawa8b56NCJjSQv4DtOAWF4YN2twmonmIi2RU27/1uW
	qyuXD7hnQTxa2oGkoo7R5PBuTDs3K3qVS0hcZlLN4WpqbgxAkzZ1Jv95E5tqtscc
	ALdFBQ/OsX8YTmukXCGC8cIAB0zDyi9YnTn8zTTyerOpW7MAk87s3iwrRHZFu7l+
	k3IRx/EdmQ1pamqL5n3CTioJ2c4N8f4RSp37qPmlgNWCc/N/hiepofQTNm7vDOmW
	NBftC/iwjGaPdS/d/ASRcrpEv++IMXGzNi/SS+Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:XX9G5O8U55IcF/Vbf+J7YwrYH4X0xX0ZRTihGFfBtU4=:K2HKApTyaGcapGCNlbFY4xEqwtwI3BMerxMgnD5iAFo=;
X-ME-Sender: <xms:0v3vaifkzN9z4cFltb9GwgRdnKrpx03jl7SMCSV-T-yA4pIZ4rTDHA>
    <xme:0v3vajPvWugvN62Fru9cY01OPuC7pJnf9tZWCx3hjSB1PNRDplBVTvBk_VXlPH3W3
    2WY_-Egme1GowBYSxjGwjmGZBaeA1HmvNqTxnGCIiLouMP6wfn7>
X-ME-Received: <xmr:0v3vaoi4jcx2HvgquA1RJ3F-GYX4zML8NO_BsTMXpt9FdSoSyatEy4Y3w3fKozlbrmLxKBeD_az_T8ERNsAr5yVCKWzJXPJfjCR3>
X-ME-Proxy-Cause: dmFkZTFMzT0fav3fwU6hTZJ8Jdygi4TBCBoQqpdegfarKaBkCj6gJNNjKsF1Jbpv2Z7UoR
    98AfNIV1z8cuUiG1tUhStaQ8/M41GU/AlF9yPcP5oh2fhIUxts6IugiarU1aOPtXas8lcg
    RYGGulp9mj9odmRLe4OG80zoeVRUViIxktSWtIoVdde6BwsXrMeiojUFwFKCMa82IyYjlO
    mHmnixthrm5k248YDLZ6J4h61tH54rNt541Ur2osH5d+IPxwjVqp63aeffuoRknA5WokRq
    no11WQBDgWh95uYEMoJPraYxd2HF8TCJeukkRLoVdl4t66bwBnj7wxTnHUtgMKd9YPeOpx
    pRCrQed6kQLUcfnPElSEMQU+ehBcVOISOFwgwVQil2CdciEjD8X8FFowAsyuOgNDE5J7cY
    txr2LzUZ4GS7TQUCc0PNtmWdMFwBB9WHCtAeZl7I1pC+492epDNUQ0GNWV4Y9qiOX8Rpt2
    y21SAAz76gnbpmozsecGq9wUa2QXKOHqX23RfAmAWHXPkv8UmLaiFSh6MAsUX20UI9PpK8
    +JjJa+KDta78q3qEyUt4QBn0zh2tGaciXoIuvOuU5S7GKMYkjbMuP/ceji6IpVmcGFMqM7
    l8SOt31HEnbV+9/RjWM0HyhB4hRGjbEm9iufteE5U1kSS1eMtbyG3XeDgfxQ
X-ME-Proxy: <xmx:0v3vau3PoVKhzYyHmeYQoPboQXEAqqnIdfujNC2l5_JE5PFOF_GYGw>
    <xmx:0v3vaqircXEMUJfm06XTmS5ST4A_VDT9HKfygnVpiRXfydIjbChu2Q>
    <xmx:0v3vamdUFauFx9BJqFz1kdEFE_JxV1SWTLsSCsSj63wA4rGPggLNng>
    <xmx:0v3valmNyKpfsxYoRYCjVXchm2zz5Z3s5Q6TwVz02pgpyWo7H9uPsg>
    <xmx:0v3vaoR-391kw-9GWfEbm2n1NQt9tqWbPyE1epTXxGAdKuYdPE3YqlkG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Nov 2026 23:42:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Adam Dinwoodie <adam@dinwoodie.org>
Subject: Re: [PATCH] setup: default hash algo to GIT_HASH_DEFAULT
In-Reply-To: <20261108011633.1772000-1-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Sun, 8 Nov 2026 01:16:33 +0000")
References: <CA+kUOampvjU3=VK3VGhYw2L5-E+LBsk=Q0UrAxhhR7hC5SUdJg@mail.gmail.com>
	<20261108011633.1772000-1-sandals@crustytoothpaste.net>
Date: Sat, 07 Nov 2026 20:42:56 -0800
Message-ID: <xmqqtsls53xr.fsf@gitster.g>
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

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> When we have no other hash algorithm to choose, we set no hash
> algorithm, which ends up with us defaulting to SHA-1.  Instead, default
> to GIT_HASH_DEFAULT.  This means that we will choose SHA-256 in breaking
> changes mode and in Git 3.0, which is what we want.
>
> Reported-by: Adam Dinwoodie <adam@dinwoodie.org>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  setup.c         |  2 ++
>  t/t0001-init.sh | 16 ++++++++++++++++
>  2 files changed, 18 insertions(+)

With Git 3.0, we promised that SHA-1/SHA-256 interop will not have
to be ready, and that SHA-256 would become the default.  And this
patch would be a good thing to have for the second promise.

But didn't we also discuss "empty/initial repository whose hash
algorithm is undecided can take a push of either SHA-1 or SHA-256
payload and that first push can decide and freeze the hash algorithm
used in the repository" or something along that line?

I am wondering if we want to reserve 'HASH_UNKNOWN' for such a "was
just created, not quite finished initializing yet" state.

The patch looks good for the goal stated in the log message.

Thanks.




> diff --git a/setup.c b/setup.c
> index 61bcdafe82..4a0dfc8908 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -2830,6 +2830,8 @@ static void repository_format_configure(struct repository_format *repo_fmt,
>  			repo_fmt->hash_algo = env_algo;
>  	} else if (cfg.hash != GIT_HASH_UNKNOWN) {
>  		repo_fmt->hash_algo = cfg.hash;
> +	} else {
> +		repo_fmt->hash_algo = GIT_HASH_DEFAULT;
>  	}
>  
>  	/*
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index f1d227f271..98c7562f32 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -516,6 +516,22 @@ test_expect_success 're-init from a linked worktree' '
>  	)
>  '
>  
> +test_expect_success 'git init uses default object format' '
> +	test_when_finished "rm -rf repo" &&
> +	(
> +		sane_unset GIT_DEFAULT_HASH &&
> +		git init repo &&
> +		if test_have_prereq WITH_BREAKING_CHANGES
> +		then
> +			echo sha256
> +		else
> +			echo sha1
> +		fi >expect &&
> +		git -C repo rev-parse --show-object-format >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
>  test_expect_success 'init honors GIT_DEFAULT_HASH' '
>  	test_when_finished "rm -rf sha1 sha256" &&
>  	GIT_DEFAULT_HASH=sha1 git init sha1 &&
