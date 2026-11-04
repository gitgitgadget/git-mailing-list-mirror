Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810047;
	b=hXeeic8KoXK1wZoJnrxJEDcX95GQE27xL595OGpBVBV5m18stTfOzkwNsNfFkfvpnRYA
	 WIwHUXvNIYzn4nn0PyoI7muxtHK/oYEfN9J+F7WtvfzZiIj2YN3qNiOwBylN896o5B9io
	 81oPm/yLemKdvmC1pdwx97xUUERbEqv45d5RLkOXBN024KxkL5r+7TSfLBSuzl4dPjnZl
	 k1Mx7ex1qAYPsNIEO19jOBhlSLQJ51MtM9/rxlYuRGIKSoae/IDEMqJdMBbllvaeTfWrA
	 ssSOGDo6MHJcS1EJ0dOOWGhpr1CFN25vwuuH5dXnMLjHdKB7DepCtEXeYc2DiROR2JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810047;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:References:Content-Language:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=8Ak8wtO0GRwbaH5tqwVMBFrznjoaHPzKYws2qHQUSus=;
	b=D/4hCtJLVB+qMazL5c1f1/jw2yyDqwH9cZdOxDmNBRIOqsVO4mnL/YTaFl6HNFD1v+P/
	 d+SVLMpc40uzOTtdEVN47do77G29x0pHKhREVKi792iuA1nLMadZsdU2pJ3ry24EpRslg
	 7NubIItFqeYSpE2ausWldSn59PAroA6YErnBW6GseDQD41LCV95jqeA5mwUO6+iVofspY
	 97MLxsypvv4vEDOCKjfbhKFotljMfaZ0fYBUCj709C7ROeuAlu0WX+itGviwgO6T1UIc5
	 Gic8nZjWt63S1n7YID/G4L7rSfdtyqRDEMRoZAhJxo6HWW27lPXX1oLGlD5Ye3N07hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cXi4tr9Q;
	arc=none smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FF2606A328
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 16:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35FF2606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cXi4tr9Q
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91c63449320so9580726d6.1
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 08:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793810046; x=1794414846; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8Ak8wtO0GRwbaH5tqwVMBFrznjoaHPzKYws2qHQUSus=;
        b=cXi4tr9Qi9kAk/tVv2tncWQql5lIopPbc/c+5ARqiJkRsjADY31vvBWOTtIywYL+uN
         An3PJZYXH2LSXzEZ6PcG5IChdc9or1wU2TCRqotXwhJGbM7v+tyzcurwP9lDqrSmvVQ8
         /PW6kpd2z6sP28mWmzKMFlRfkuk+g23LvUWIYqE9nE1TKQrzOFx+qPVS6/b9qiipkJyU
         K+9muxXLLGYRme/Fxy4jqTgt1uF1CaPpY7GV3uPVbzSiJEvHTEH/6P45fZ6ySdPmz5Vw
         uKTqZ03Q5MJTo6di41u1iHwJCa0gwgsfoXyAjwy4j7Lhg5PH6RDZhD5T5w8om9eGUfxk
         Mc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793810046; x=1794414846;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Ak8wtO0GRwbaH5tqwVMBFrznjoaHPzKYws2qHQUSus=;
        b=NqWsQdEbZmWi+tGDwKm1N/65Rh1BAXrWCVrQVo+/SOfoHPNSvbNS6DEBhrBgN3Kekc
         XNoLO0Ua4VoypZq4Db0y3x873yBh+PFNq8d8PblII3JUmHImzrRMSCIM1rVqgRR4T1Gd
         8eI60pjtQlR/WqX3PCpXWCiILg9pamulj4DQWo5O4gmnP2eroArVM0A0gKvIT1uTPYXf
         mIkV9PU2HonzhuAmqYqyqygq+I4onjT9aE+RAi+5eO2FCLrkMnel4YgZofNP+A8bLPVr
         3AsTIvd2GVkfgqhEUlkVdW+RD5IRr7UyOPKNfx/jQbKHfRGhrBFHKmPcp6N2TlWTNVfR
         WbxQ==
X-Gm-Message-State: APuU4Z/47esXfVJKLa+IOfQYPJjk5ERNYPSB+q2wmaluSbJRmi6TMf3j
	OoY0WU6AbCUoKcL0Eyrh2R0mjo/u5Oudh+DM+5ZwbtCak6SyyKWsGWJ3iYO1TQ==
X-Gm-Gg: AYBFou1Bt+e/o59PWT0I9wuDJPKrs4/22TQz0/VMFU4kawE8CmJ9/uLRmP3Z9l0vBzA
	lgLp5frF4qbDW0GbBOhsrTxj1AD7QO+EKpckDOi6gWDp8FtVAuP+XPyywjeXbRRFIRal4hs7fWy
	509Wku3RISOsPd1XyBUCqjdfSt1DtJQ2b89zxfb7oBAN/4TsoDZa5XdXreqPW1g3g5wmudWyGs+
	JHLZ+XPB2ZXu1SPVHOMa5cskti4NwTQdVzHGOmMABCdEOGyAdThfEvBl0RPnOvWGVDbjBM+fsnZ
	FSfrFxAoUlgmD7ES3ovTZQVJd4CbRb4nimnecGSXxpl7gDhipcww6zQ3P9Ia1p5tC9vzeXdnPtN
	MrYVzblyjPW1o3ResMI4G73hkyPrGOB0oKEF+5NQEzMc6sGppDXQGPhJO3lPDP3FlCtJAOUB/FP
	7c/0ip0PGfOAKfbeD+LLVL6dek0p0LsajwHA7q84qT54bYNNaczStmdK6X548VHC+m+lgplcIgH
	smveoTKakA8Ir6qqEru4/uPfpcJPHnoMQUHvm5l9s1lRZTDyUPCqDpm52W1RXoAuNo2FefDKBm0
	Uu+ayZKgOkJ9qRI4Pe7FFXzigxpk7nIcONxCa0s1wJ44IvO7fDFarnzzyNqNey1b86lfy4AXnyG
	e3IbpbWQlo7qVDDzfywEzr2h4ZFFl0UT/S7Tt6hA7dGYevQZHN59IrB6OiIvaT1E5lmngJq9gjW
	8D3T/UdFVwm6vmtUa5LVH+g5SlreQFl8UCr19KuhkouSxFhINf1XjMIw==
X-Received: by 2002:a05:6214:5c45:b0:91e:8ad7:b608 with SMTP id 6a1803df08f44-91e8ad7b719mr25047416d6.28.1793810045868;
        Wed, 04 Nov 2026 08:34:05 -0800 (PST)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e939fc1d9sm973496d6.18.2026.11.04.08.34.05
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 08:34:05 -0800 (PST)
Message-ID: <57322050-95b1-4faf-ae59-30a355d90355@gmail.com>
Date: Wed, 4 Nov 2026 11:34:04 -0500
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] commit-graph: move remaining write parameters into
 options
To: git@vger.kernel.org
References: <20261104-pks-commit-graph-write-refactorings-v1-0-d013d9401a59@pks.im>
 <20261104-pks-commit-graph-write-refactorings-v1-6-d013d9401a59@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20261104-pks-commit-graph-write-refactorings-v1-6-d013d9401a59@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/2026 10:57 AM, Patrick Steinhardt wrote:
> Move the remaining optional parameters that can be passed to
> `write_commit_graph()` into its options structure to simplify the
> function's calling convention.

> -	if (write_commit_graph(repo, dir->abspath,
> -			       opts.stdin_packs ? &pack_indexes : NULL,
> -			       opts.stdin_commits ? &commits : NULL,
> -			       &write_opts))
> +	if (write_commit_graph(repo, dir->abspath, &write_opts))
>  		result = 1;

So much cleaner! (Even better in other hunks.)

Thanks,
-Stolee

