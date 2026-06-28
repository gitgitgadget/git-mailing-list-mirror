Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C431A1548C
	for <git@vger.kernel.org>; Sun, 28 Jun 2026 15:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782659740; cv=none; b=BqhbyDoKaWaGHuMo9w9y+vqGkFWNrJh+GFITs6WmuFv1a6r+devRx4y4KnCMVM7kiBAssSGo6vY1B4lvI+sq2uCeC/5FQe3I+S2XjbWjR+SpK9X6SjYABfqqmtKJHHnELNiw7/qAltBPHRmFPevSEGbPie5NY5Uv+oH3fGQRFYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782659740; c=relaxed/simple;
	bh=gWwOCHqvhzW1wmr5yFg/X60fYd062pvar8y6YmE4Rco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WDw8SVz6XHImVUPCy5JehU6dVYT6ui0xozOtjxvTh5jCD87587SnJRmy1mccfbyfpTko67K1WZU+OkIe2K4umq9rQcyx1YGCV/6H4wYEYb1jptTaxSfVuQFMSOxeGM2eRaoI+bButKWOtlUKwt+UxXdy7L5r29zJXY9inVDkObE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYZ7IkNz; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYZ7IkNz"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-519f758bd33so21781041cf.0
        for <git@vger.kernel.org>; Sun, 28 Jun 2026 08:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782659738; x=1783264538; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2IFqMk+Hp7on7yVL29kHTCd39F/JwtagHZ9M2ZhORTU=;
        b=XYZ7IkNzTZWflvugacA3mqBbrvMmw1AvvB7vyeEBt6n3dLruZaCFSbB7Mmpi5gt8sm
         lJ9HXlhLRm5XSk+TMFUJc0bbx5HuYMCG1msMBCmU4lCfDXzuPb26cHTczflTfVqk14mv
         AdqhIGISFioWiUuJMBA1dGe25AoG7uU/5Vts6ilJZV8JzVGoM8WAC/Gf7roxGtRa8Dz9
         SFRXmOxfog0l9VKM8QCKZ9YX/h4a6uVHDdzLdp3+a2+UqQKWt7Herd4tF+Wexz36u4dG
         0B8Ojy59O0qlZPf2BU9c3gWNmGSOAYb5uOJSffMOqu5gUo4aHS2/YpKie04jI5CY6yBO
         dxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782659738; x=1783264538;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2IFqMk+Hp7on7yVL29kHTCd39F/JwtagHZ9M2ZhORTU=;
        b=M+VHP/F99RpVJsJ0ZKnSODlH0fZ2hqvNfRxBjhnOVKYQU8vGVWWPEbvkJS/aMdXt6L
         +653/75qZthnkQRRY2Zdpjtw5rLLXLz4e7x+Vh+i0CsN6PNKK5D5VrDXnwrUUlIXzkly
         NQwH3ErddL3eND07P3QQf99otCCldK3rYjlYeH3Mv+a9e74QP/fTe1D43VwNNw/qmKvm
         mf2mELsDjhre0BxsECqdHdzUZ9ZD4Pub50nva32ZXZFMlTINKjtHApgBuEo29bmNI2WA
         VC8Y8mLTEqNsk4Vp56HiX0gJzrdb60Q/LZFpczqJM0VJrkWx8UbCuE2UVR1EzAA4Is58
         flIQ==
X-Forwarded-Encrypted: i=1; AFNElJ8tvT90mpTt4uYdCnPitsYM/YzpZUDBG+Su6y78M1jjv/1IivoD1K3zkViyZ3fL9g5ruJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuZuOJiEmYQqsOY1/mEFkiJw6cWclWo+uJDpWIvSIeF5TA1jcJ
	QwIn16IhFUEqS6BF4WGTE7veIZvywu4gqol4Zs3PweQmHXTD8+DFWqVA
X-Gm-Gg: AfdE7clNrBp8qWX84KQrxUi6bVOR3YgJCXqLlLQQEMStgJZCHJBtEN8m5cskWGVLa8F
	o0zVqUFsYJSww2aWWUzkVOCeGXK+Ai3NCNb3OV36upv45pQJQljoYaV8zgmYuUwWbRW+u2cyyjk
	YtK7U/updrnR65t2SqbeDt9h2IhMqKvO8LyD6ZHcFJkEJDcE2L5HAPCbmx++F04l/JtIRWLJnV6
	ryXrRsbbn8hMeZOygDFizKRvAPwH4KI8fGU+IqIsQLzAZcZmBgtL88XhMVFas+ugwS1PiTB6KEN
	s7oYX8Hi8K7de3tx+DZ9w2YgTnimMKwzLlsYwXS6VeGQbVAwQ8LwQhMqSI5yb8G2EpROpXiJnn3
	yVBObxkkiBtgg441VR9B9qlhcOjfHOBw4Aq/Unwa5/diJ5y+vl0euOx/+uA6Tu1G478Tjk3S3vm
	tpbe9wu54q3yL4i4QRhREm4hoX/F9TiYVw+zUROzpe2CLqEDaKNMfdr0K9BVGYFOsOEfoRnEiRm
	hi2JcqhxEa7ZLvjFZaHol0y1X3M4zraxUo67Z4hdPd4rx/XieA=
X-Received: by 2002:a05:622a:58b:b0:51a:8c97:9385 with SMTP id d75a77b69052e-51a8c9795c1mr91818231cf.60.1782659737637;
        Sun, 28 Jun 2026 08:15:37 -0700 (PDT)
Received: from ?IPV6:2605:a601:8115:5f00:1cfc:ba7d:cd84:71ae? ([2605:a601:8115:5f00:1cfc:ba7d:cd84:71ae])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8e8ce95b5c0sm87025416d6.39.2026.06.28.08.15.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2026 08:15:36 -0700 (PDT)
Message-ID: <f77c0834-a001-400d-a8b8-a1e2398bf574@gmail.com>
Date: Sun, 28 Jun 2026 11:15:35 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/8] commit-reach: move min_generation check into
 paint_queue_get()
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Kristofer Karlsson <krka@spotify.com>
References: <pull.2149.v3.git.1782479286.gitgitgadget@gmail.com>
 <pull.2149.v4.git.1782649547.gitgitgadget@gmail.com>
 <8dd15d44e6a60fc39bbf6d894628507e839f9248.1782649547.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <8dd15d44e6a60fc39bbf6d894628507e839f9248.1782649547.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/28/26 8:25 AM, Kristofer Karlsson via GitGitGadget wrote:
> From: Kristofer Karlsson <krka@spotify.com>
...> @@ -138,11 +140,23 @@ static void paint_queue_put(struct paint_state *state,
>   static struct commit *paint_queue_get(struct paint_state *state)
>   {
>   	struct commit *commit = prio_queue_get(&state->queue);
> +	timestamp_t generation;
>   
>   	if (!commit)
>   		return NULL;
>   
>   	commit->object.flags &= ~ENQUEUED;
> +	generation = commit_graph_generation(commit);
> +
> +	if (state->min_generation && generation > state->last_gen)
> +		BUG("bad generation skip %"PRItime" > %"PRItime" at %s",
> +		    generation, state->last_gen,
> +		    oid_to_hex(&commit->object.oid));
> +	state->last_gen = generation;
> +
> +	/* generation cutoff */
> +	if (generation < state->min_generation)
> +		return NULL;

...

> -		if (min_generation && generation > last_gen)
> -			BUG("bad generation skip %"PRItime" > %"PRItime" at %s",
> -			    generation, last_gen,
> -			    oid_to_hex(&commit->object.oid));
> -		last_gen = generation;
> -
> -		if (generation < min_generation)
> -			break;

I'm just stopping in to say that this looks like a clean code move
in this version, without mutating this chunk in the previous patch.

LGTM.
-Stolee
