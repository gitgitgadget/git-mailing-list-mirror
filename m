Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1965208BC
	for <git@vger.kernel.org>; Mon, 21 Sep 2026 22:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790030088; cv=none; b=fjpxizdHDMjJJyQBx0NAIXOm3uPP4dJJ4+3wrx9KG6lL5P+52rmjmjWpuIHmJlHrTj1EqOxAeJnMz63+CF5SLp2la2R0fCBeqZ5ZegxNRjrQPjlJFfUS2SZiZH+v8ja622fxzJTx3wotW/vrf5gy1EZGoqr9noNco5GXgqzZw7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790030088; c=relaxed/simple;
	bh=G1tSlQQ7AH66Mdp3ijFGPTQmvH5OU5Axr+xJaSWbHOA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JHh3WDmK5146jecLmbYnbNYJfqTkMUIzwfKN9TFBPzKvDdphm5yYL004ObufF5AI4PVfQW/XAWQ+vsZhQ44Df8bGKF/Xg8GNiH7G/yrYLtZUgdLXDVSCN5sSJdCfQZpBQwaFxHmNbkM54ucUSBfdFrUNsFqGe7VWi9o2ht3Gl5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GX3oRgp4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bYFzLYMC; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GX3oRgp4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bYFzLYMC"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id AF0E4EC02B6;
	Mon, 21 Sep 2026 18:34:45 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 21 Sep 2026 18:34:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790030085; x=1790116485; bh=k5t8Z5wotM
	F+3r3rH9UKFmoKXsN/sGW1bDsKFwclikk=; b=GX3oRgp4U7+Hyp+OOxRoj1Z+fS
	alybiJKHO4dvHmTJsJRRvkbbazEj+IyVzR4e6ReK8LKrikE8EVoyu31irigToMpK
	ZkrDjywGdIYcBtokJtqvFIXDQYNllmg4a+32Zpz+vpsF37UjHEQF8JHnK3cMeKHb
	N+bt68jJGvVO6zdwU+V3R7n1pAGf/No3GBn1BtkcEcVjHGHWAEh1s64qoxFcuFbI
	Vmteb1y0U8E/H7hWodz0BwwNIsGPmHyh5Y+GAHtr+qhnZztUmV1W5JcZHdAOMe9o
	ukJ9fIDnePTnvSrb9YT6H0vei1cZglp+s4dR2+ntWCjcLqHJHKuER98IaQ9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790030085; x=1790116485; bh=k5t8Z5wotMF+3r3rH9UKFmoKXsN/sGW1bDs
	KFwclikk=; b=bYFzLYMC5L0sRxc9yD8ZvRLIOMtzLdQ+vWFUwUwBSQnAsbvVJeX
	EIgGYBlM7gT/R09EsA1qKjYTuACKHEYacwxfPtxuuEyL7rOrrAvVQ0IJuUvmK368
	QLp+LCRsLbz7frRsyUxPgJJBWHrzR8I6jadwlVYJ9eIsgHAYHs5iaZGIM2cC9YOM
	LefCyKfsVs2PrjvkIYc/fdSdA78mRDr9ZfAms4V+qaCChV067+kseFrZpupNCa/x
	0Q3ZTjqFdNQO5FuD3uLqmk0W2LJK42dF88BkGmSdA32zkhFRyLSS5BoVPCH0rywo
	93gkjDht/fjjsBJklKhURqzpU/gjgXiFqYA==
X-ME-Sender: <xms:BbGxahyrINNKEYwPvZEShCLAu8LZhD-WqCKI7vC0d6js2KIsofEfqA>
    <xme:BbGxak9E5TvsZvDTGGdbUpRE293DxCjVNjtEMxJu8maIklNrq1Lt_wzPCCaRj0LaU
    g2kGTeoZXkJTcUyj5h_wfALx-VfPNYlx76tO-sQo70YHTxbJwwHsMc>
X-ME-Received: <xmr:BbGxalJqlD_yMTx7sIkQU-mg1j2SHGNURO-hZc8lLUY3QtNTOM4cwcGgWglK0ypQJJ0L65LuvYVW9z6MPgikgjlggrzX1zRabpoP>
X-ME-Proxy-Cause: dmFkZTG0tuRG9XrHhrwDfZvDDHxZiRGoY8l3930ykyHJgBzfGUIYsjF/RRiSINGePcfbbx
    5TTvBj/svDsHPBXlajSbGPNzzP92HROngxtqtMr3wubeQbMe49CNuWsB4o4+Xen/ffpBMr
    5L7lzoqGo487eMlP9G+K3V9rKxveGBjC6/GlPV4tiwpfqnskz8qzFc8uSfUDn+5pnCym3x
    W7QloIRgbHbudx2rx+zogO6DutOvHyuQIa11MV9ekZR+PHIf9Xm+a3uM/3dyO7kqWJuba1
    pBcfZXO/HlaLcdLA7U1PwLm82EqgC4VNMhQDEDp7VR9osklUIfTknwIQSi7KEB+3Sh4hrk
    dbYwBhz1E3ScBUSWBlzy1k9sAH2XpdH03Uv7C4XMmjTGNgtLDRluzjlYtrGc1Wp2gc2et+
    3IZ+vEVoS3k9llhtrPO0wC+i9x+5XSgTdZBe9nvA+zzt9qb1gGavQ+2mbjuXaWyAxslZHt
    6Nle/bS7sUMVm70BT9NFsgsYxSfcjqKt/Btcz5SGxFAO3dULl7mtkmA9Kx5XlCTVq1MTp5
    Nh3peX+R/ITdfAcKG7Xa3CgvhxfVdQp7vsNTh+xuCI5QfbZHESn5eBxoBpf2RsjA36QNW/
    sqfPF/IXfHSfPAvE5mOgYWTFeCECVJIcaVZf8yPhBP3KGFbtJrgnt2V9CRKQ
X-ME-Proxy: <xmx:BbGxaqdgPG31362dAYVkjeTv7ac3dvvTBluY9sgWsgcP6WXKzVmPhA>
    <xmx:BbGxak8A9RNFjIcyybEqrzJPgKtnIkGwQx92lja63HPYQk82X72l_w>
    <xmx:BbGxano6nPfUVXfHNHjwyX38aT8B3a9i5dDySvinz1R83h2jxNR_LQ>
    <xmx:BbGxapD4joyrnunbc__I0N2Hv87XJEd_yDhQOoYkXvL9fb5ezpI73A>
    <xmx:BbGxalhgSZEvClA4_DxWHC6NG--bCXM931XBp3JAGvdkFOJjcujbREG1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Sep 2026 18:34:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  peff@peff.net,  newren@gmail.com,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH 6/6] strbuf-safe: add init and release methods
In-Reply-To: <xmqqld8ul1ny.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	21 Sep 2026 14:44:49 -0700")
References: <pull.2230.git.1789736540.gitgitgadget@gmail.com>
	<dea925f31647e7c08f3fa467b8058351b463f593.1789736540.git.gitgitgadget@gmail.com>
	<xmqqld8ul1ny.fsf@gitster.g>
Date: Mon, 21 Sep 2026 15:34:43 -0700
Message-ID: <xmqq1pamkzcs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> +int jw_release(struct json_writer *jw)
>>  {
>> -	strbuf_release(&jw->json);
>> -	strbuf_release(&jw->open_stack);
>> +	enum safe_result result = SUCCESS;
>> +
>> +	/* attempt both removals without short-circuiting. */
>> +	result = sstrbuf_release(&jw->json) || result;
>> +	result = sstrbuf_release(&jw->open_stack) || result;
>> +
>> +	return result;
>>  }
>
> This is puzzling in a few ways.
> If we mean "enum safe_result" is an enumeration of different kinds
> of errors, then the "result" variable and the returned value from
> ...
> On the other hand, if we mean "enum safe_result" is an enumeration
> of bitmasks, each bit representing different kind of error, then
> ...

I forgot the third possibility.  Regardless of which interpretation
of "enum safe_result" we use, if jw_release() is designed to say "0
for success, non-zero for failure", then almost as written but
declaring "result" as a plain "int"

    int result = 0;

    result = sstrbuf_release(&jw->json) || result;
    result = sstrbuf_release(&jw->open_stack) || result;

    return result;

would probably make sense, even though the "|| result" construct is
a bit unusual in C.

Thanks.

