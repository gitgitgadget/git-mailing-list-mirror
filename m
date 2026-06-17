Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3143B318EFF
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 18:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781719768; cv=none; b=VjbE3reslhKp/5VS0odluZ7fu5Z/bftqYzn94Os+toRxiNOm5L8uBHP74IrVsndsU8Fo4I1QvmLsLRuqbWnJ+zWdISNrJTyIFYiyCGsZXa2OZWGRUgLM+SZ7UL5DFvh9QrINL4BSQSHt4+xpL0+u1pG85+LH+B4wHVSHCwGf2yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781719768; c=relaxed/simple;
	bh=1qlY10x0Reck4GgmrCs6D4Y6NgzCjh0ReN4L9lnDdZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7HwcnWAXJjLRq1pclSOr4PdYtVAYEb8q/BY7rq1LxMa4uNLSFulSGIdLb0qyuMtp+vLQaql9mg6sFu1SxaK5bkgVhphAzMF9SqpQNeuVsKyhz+IOO5uXON6QbFkyVm81JgIVdRBGqmSUO8F9LkcnNcPtHbsK0mISefaGFT3ML4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtv0i1ik; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtv0i1ik"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-43d23173511so18488fac.0
        for <git@vger.kernel.org>; Wed, 17 Jun 2026 11:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781719766; x=1782324566; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zy9aBp/1TqgJY22ITgkU8rjsKkiui+StvNQI3mRJwoM=;
        b=dtv0i1ik9ARO+uJnYUkkr6lpe8nDhiV6P58tZ/1b2+A/61ojkBME4mU7mvpfvQ9Zby
         pdKtfcleaBcXTBrr7A07P99c2yvxKp7qQwmXh6jF2u3S2oXwzHdl4su5WLWxbe1tKPxU
         KJu6KFl9Du8oy2q1w8DJxHXnm2kJ8RUSZd/dPELQ9lSr3/KngDRGyN6EI7UUoXq2TX+e
         fHFBjV3aLrF7WNjbKl8ETo8BE+LqPbeSKy1OX5BoI5DpB05dBQk+KClOVWV1TccvYWJM
         1bir3QxfzC3EtjJaGg/jN5LzOCxMMUOFqXg/Ta38KHWapW6BeCEuJlrXYBSivgbRwKTR
         zelw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781719766; x=1782324566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zy9aBp/1TqgJY22ITgkU8rjsKkiui+StvNQI3mRJwoM=;
        b=s9MTI/Jlm3SfNpxQAnvtbO+NMZ5vAHIy0rwmfZk0viGimRiWpsEnyyasU1QZ9Ui6J1
         gqBDoKhn8yOBjmX/pgiLscP1c5iRvtHiJZxF/sOFpfVsEMCrDK8+vQGVZucasg7ih5z4
         DzPzoZgkmz00l4c7XCNeiWs6KGRFZ5+h2h7awihbYzk7UbnHBhNpaWG3i8PvtFu6WjQ8
         152zNprUih9DrJ3P+7kL7v3W2ko5010B7JP17Co7DxBAdnKY32iVpLpaprB/nlXcIhhN
         cBNXm7uWlUA4heYOyUPqz4FFRp1g0X9KSolUlOJzKjPgjDkYDdjIFDxgxB3P0byVqptV
         WWXw==
X-Gm-Message-State: AOJu0Ywt3ow8dPzrtJyRlk9P7SLlVPg4TmOZFpwOONnvBXhNM71CMCLV
	b46pIWVaDTEsZBJwJtKQDQNaAQF1JK3FcxxG/gaJD2Y4+xWVrssQAPTT
X-Gm-Gg: Acq92OGTnngd+5my1nSbEr69LKayr8HNJWaOQmgNa6Qpzy980EcEON/cxvtqwkS6lvN
	zSv9e6PHjr1oVaPw0v3vd1fYJeYHbDH9NQ1lZF7uFQSxyYHhrCK8i9Y1EhrTk+9o/KsKreTQwLn
	bsGR1IlDtdPh6c1U4UrYtRTBzpjSPwHkVTgpL8zTijMDBfZnsqVWSVAWOGU7xu9AN2wWIeoujDT
	+NnNCVy17hiKVFX1EeWvfH1YGOJ88bo5WQ2yGbqtV9M5VdZ9LbBrtdg3S3STjeh06UGO3HvNaAO
	7aS59G+lyp3yHNu0YK7UZiK5+4k7XdmB3YGWWTZ2KZd/HTrsdYEQl5HIsGoKc3wWN+p3o+VqeIa
	A2jVKexauIDyJ8mjtIb53UTyTv5T5NysdZghVyDi0MXZ0z3aLJc+0E7b+Oujp4QWrQDogy/sTP4
	UEM72eZw==
X-Received: by 2002:a4a:e913:0:b0:69d:d865:92b1 with SMTP id 006d021491bc7-6a0b5f49d43mr3613189eaf.25.1781719766034;
        Wed, 17 Jun 2026 11:09:26 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44308b0057csm5143586fac.8.2026.06.17.11.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 11:09:25 -0700 (PDT)
Date: Wed, 17 Jun 2026 13:09:24 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 6/8] repository: free main reference database
Message-ID: <ajLixYJTl3c-lSn3@denethor>
References: <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-0-f4854aa99859@pks.im>
 <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-6-f4854aa99859@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-6-f4854aa99859@pks.im>

On 26/06/15 03:56PM, Patrick Steinhardt wrote:
> While we release worktree and submodule reference databases when
> clearing a repository, we don't ever release the main reference
> database. This memory leak went unnoticed because its pointer is
> kept alive by the "chdir_notify" subsystem.
> 
> Fix the memory leak.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  repository.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/repository.c b/repository.c
> index 187dd471c4..e2b5c6712b 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -421,6 +421,11 @@ void repo_clear(struct repository *repo)
>  		FREE_AND_NULL(repo->remote_state);
>  	}
>  
> +	if (repo->refs_private) {
> +		ref_store_release(repo->refs_private);
> +		FREE_AND_NULL(repo->refs_private);
> +	}

Nice fix. :)
