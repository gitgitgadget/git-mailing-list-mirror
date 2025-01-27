Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B960518B495
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 17:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737999591; cv=none; b=lP0RwPdL4v2t74058OBdfarDZVp7fcu+TQpf+pXl/7EJ+MoxeLMbwjta8iLwo/enM3MnYAVMG49cOLa6aUkIbQK8lb2kCT4q4wEKJkZHXE8mPLR7MuL21ghjizT6J/GT4UdSOsN8PZK/xEwY7RLybZFFD+NL/GU3zUFX6R8xqs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737999591; c=relaxed/simple;
	bh=WFh9ySK0FzH3dnYQRMK1QXJYuuHq/rQNmtYS4DJhjT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFt4omEpI1C0K09ba67k8/+pZeQTvxByo5W3TWXensoZ0r52EQCTDWuavYcORC/CaQ5L9pMU/0zxBKVZSd0OAaqqxVOHeATIMs+e7M9SXe7kgSAAZHNQIGN8RRxp3DhTo/CPPHz23Qvhw43NUJOB6q2BvHIkNg8HVT/8f+nHuUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+novM25; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+novM25"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5f31d3b4f8cso1054288eaf.2
        for <git@vger.kernel.org>; Mon, 27 Jan 2025 09:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737999589; x=1738604389; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vJVVdjK6TSVH76zNcMaXTmxPZRd+nBjzgxipGuLanS8=;
        b=E+novM252lMyRhLoHEDE4BEBaNDDFXgrvWa3/uAfb17rAEEDvAl7vzKJS0ypLPtkJU
         RB/JmRF6JLhmjRCosVw2z+CU+nnL5U78aw6vicol+l8a4k0DYIacKsULkphISHKM4SGk
         Jd2aiLC8uQn4JYhYAZAVmSSOu3CmTKvejvyeLIoSwdIzNge9ogzgeEA37sorWE6QnyVt
         nwqxQ7EPWuC+XKRdW2p3w/42fAAbK936ypjAhY31lJ2g9CcwyrnjsM5Of37Ef3D4vHm5
         srIMLRMVOkFRVMPJVEd4APABmE1M/vHjCmiaAarGjQNXDxxhfdlwqD1MN/xVMe5NBSx7
         0zjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737999589; x=1738604389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJVVdjK6TSVH76zNcMaXTmxPZRd+nBjzgxipGuLanS8=;
        b=MLiO9p02vjyTc3hez/rnv+ncFwJh4UL3LCESJla7T1aaTjceX8F8bHHHyxqFKx8WqA
         dpnILHpCPFTHMHuG4zz0z2+y6GhuXU9O2ORUbDGSQ4zrZXsHIh2VuxdhwU9QbtivaBnz
         8wV0qopU9tVl/BKxijQae7cFvlrMbbvB74LL+8ob1dU/nDoFK/YxsvRhyW2SdqPVlT7R
         dO3lqW8EsC0/VLDtQlBQX8az/0+svQAyRpXlr0PEedZPx9o9CCMItMn4pg/JyTIf7R7S
         7zNW+Mgp4e0MUi9PjXNoCy/sbTUYJcYM2ZPDEwoydWffZE5skFzRt3Z99rdmecBwvH5c
         /ZSg==
X-Gm-Message-State: AOJu0YzIhJgfS1XUWA9Pr/EXeK9cqDzIZMoF9KAcwG1Zfzv0MLOkcREi
	ex0Pb0FPXKEtg7NeTQrNRY8H+oNLrWNbI1PCq4SSqM4dsZ6DBfPlmSXIqw==
X-Gm-Gg: ASbGncvV60ne4RwbDJnrt7/ebYf+QA+zpDadj1S4fFrHaEfZBPiK/QSkp+iSShVe96p
	jpaF7u5ZnZ+2cdGNR/OqBDWklexJrsK6u5z+0/eJOoqY/SOJau5ZACX4Tko6m36z7pRP1HnHAcl
	kAZLte/QeiG0HxvIZpxdT69Z0nm9zOjLp7ecCb1mWAa4VziPVi83VVw7USaPLHYqFQac2Ilkf95
	qu1Ct1wrRPI3XQSS9iGHHJJPILgqQaz1JNxeKMes99qGJESgA/ywAE7yhDwe64sUQaUAZOTEw==
X-Google-Smtp-Source: AGHT+IFOf9NbvKwBMwQf5/Ki3qA+HPJ0Q6g56MqEvrAlvQHAopF6lJ4PvWGpNAaR5qhKLcmq4Gbr4w==
X-Received: by 2002:a05:6870:910b:b0:296:e366:28ea with SMTP id 586e51a60fabf-2b1c0b5ed45mr25395741fac.33.1737999588703;
        Mon, 27 Jan 2025 09:39:48 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b28f16c1dasm2750753fac.20.2025.01.27.09.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 09:39:47 -0800 (PST)
Date: Mon, 27 Jan 2025 11:36:57 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH 05/19] reftable/record: stop using `BUG()` in
 `reftable_record_init()`
Message-ID: <v3rkbym7a6tm3co6okuleppiabx6t4zxbcn5iei66iv3dxqkrf@wmqsctl2mmgn>
References: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
 <20250127-pks-reftable-drop-git-compat-util-v1-5-6e280a564877@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250127-pks-reftable-drop-git-compat-util-v1-5-6e280a564877@pks.im>

On 25/01/27 02:04PM, Patrick Steinhardt wrote:
> We're aborting the program via `BUG()` in case `reftable_record_init()`
> was invoked with an unknown record type. This is bad because we may now
> die in library code, and because it makes us depend on the Git codebase.
> 
> Refactor the code such that `reftable_record_init()` can return an error
> code to the caller. Adapt any callers accordingly.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
[snip]
> diff --git a/reftable/record.c b/reftable/record.c
> index d1664c47ca..31985bb977 100644
> --- a/reftable/record.c
> +++ b/reftable/record.c
> @@ -1301,7 +1301,7 @@ reftable_record_vtable(struct reftable_record *rec)
>  	abort();
>  }
>  
> -void reftable_record_init(struct reftable_record *rec, uint8_t typ)
> +int reftable_record_init(struct reftable_record *rec, uint8_t typ)
>  {
>  	memset(rec, 0, sizeof(*rec));
>  	rec->type = typ;
> @@ -1310,11 +1310,11 @@ void reftable_record_init(struct reftable_record *rec, uint8_t typ)
>  	case BLOCK_TYPE_REF:
>  	case BLOCK_TYPE_LOG:
>  	case BLOCK_TYPE_OBJ:
> -		return;
> +		return 0;
>  	case BLOCK_TYPE_INDEX:
>  		reftable_buf_init(&rec->u.idx.last_key);
> -		return;
> +		return 0;
>  	default:
> -		BUG("unhandled record type");
> +		return REFTABLE_API_ERROR;


I was initially unsure if `REFTABLE_API_ERROR` would be the most
appropriate error to return here in this situation, but looking at its
documented use case, I would say this fits as a "misuse of the API". The
other option would be to add a more granular error type to indicate the
unsupported record type, but that seems unnecessary here.

>  	}
>  }
