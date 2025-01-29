Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034681DDC2D
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 15:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738165790; cv=none; b=eqPZiQ9UVHmYQ+Efu30vpFTa/7xq19bpyq1fDySwEbnylLkghCbu3AnX9opSjew6Bfdr14i/e1UdGy7NfS8dmnVTcSvxQPzGzeuM5CTKNEln3McKTVuh3mSe47tc0vrNdsEVrRKsZJLO0DSJ3VHUpHw5g+NL+30r4V7Gjrp2d28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738165790; c=relaxed/simple;
	bh=Nanc2rid3Jag4Me3e6/w/01VXLKoVfHE8uucjSzNFFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2SiXw5wAQWv/v2lqalsrmG5hJBjDJpCcR1RRm22syhDOnN+z6iqQhoAMhRu6DbhU4yqqoDrquM0TUIgTqWB8/IrnHmLaS2AImsxVQkJykidnxlSI1eZ0FS6ubfz79hebYM/ebQwV9dbNQQLz6TLOSZwMMvBCkZON4Y4ukVP/6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XrLIMOJ0; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrLIMOJ0"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-71e3f291ad6so4109909a34.0
        for <git@vger.kernel.org>; Wed, 29 Jan 2025 07:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738165788; x=1738770588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T0QhhtLX6Xr9tIAsjZ+wSjX/2STILjyp7WJ4em1amKc=;
        b=XrLIMOJ0MB0/4FLZvN156BK6+CRvXRexYpreDQVezlA2pTewHYsVpXoN6nu6bNiiu4
         xWOdWeBbnXwM8zB7bBL/MgpyKOInQ4axSGxxb/yx0krNYTRj1vnbe3vk20S9+VSDchec
         V3bnh869X3rs+42GM+ffIoZOBSBsltuZjiNGAygHHXh+zVuXgUvOdWxSlqU1SBmDe50N
         yPfxWWk48sic/JyNZTCfOsaaAKrecQuUOYPlAyWAobYI6sjuil/VcSL+NcjwScg0gW6W
         BhEn/uReR4cbmJowMZlJvA+/A0Ya+9+Cg/f1b8NhorfFlP4O4fACnzUzcFLPCBeJruKp
         mXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738165788; x=1738770588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0QhhtLX6Xr9tIAsjZ+wSjX/2STILjyp7WJ4em1amKc=;
        b=urlONCprDu5MNFKc685qMV4x3NPyElVS7JtunGuG+jqXb/GALquM/Krmte/c1B5dyH
         CVUW8qc/6Ggfq+NDRCHo9kvrfBJvaftKYG3q9Tu2INFdNrIZ27Q9fWPAGNKkYH+CCmWt
         kHE+hernXm5blI1zi4Sj/g8XsIpSluS5KzAkPDWk6oV8cSzeOPx6pLnb9KWKMS37BnaL
         t34GBfp5OdJM1lNPtU58bFqx4zVz4HtkrenaHCrJlGC9eSrvlKxjR+NaLLte11v9bHEg
         21bnnZAlegnWADDveFOrXkd5zzF1QwhhX0mMpaYY3u6B5MBPsds23R07TSKwREWUgfnN
         RAAg==
X-Gm-Message-State: AOJu0Yza+TsSjZC3ossZIkd0qfYST0F0Y+MbILNiiawRO6+r9vbNSVQH
	0HFNHbvDBBKDE2YVJIo0bgUwqbGqX/hjeqm94OBbEEDNCNXHz1Ak
X-Gm-Gg: ASbGnctHzhz1FpaVeQcaoLVA0xxImNFvJ1BtepwqtJugmtHKrQv8r2vO3MQo/bC8YZi
	NAoPD83ex1kQD5+U9fMFwvn7WfSwSqNO9NcA/F4S0Cymd147/dd8ay/inkb2dNxtIHFtcLUxQHU
	dWAPW8W64v6J0Y5XRM3xylBeQyAjk/9gWG2N0gfOzRMH6Q3gb0jhN0FVha9Bj19uiua3RsCHNR4
	rhzdocKB3C8pCHti0Pau/VX6AfljP4JCeISegpb6eBQOO9GRya4dKpkwj5z50DLcppd5ITGWVVl
	vuWfCtbMBBK9PHSUhNk=
X-Google-Smtp-Source: AGHT+IFmhYs5sNkLpwKiI4xOrdkTa/F2Yg1c3P9/ruygojW7W0dMVS4upm0uiYux4/BvUcXClRr6CQ==
X-Received: by 2002:a05:6830:730a:b0:71e:17f2:26d8 with SMTP id 46e09a7af769-726568de9f1mr2101616a34.22.1738165787818;
        Wed, 29 Jan 2025 07:49:47 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-724ecf9cfa1sm3813780a34.64.2025.01.29.07.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 07:49:47 -0800 (PST)
Date: Wed, 29 Jan 2025 09:46:54 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>, 
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 04/20] reftable/record: stop using `COPY_ARRAY()`
Message-ID: <ctx7men3stwyasz2xnoaxpp66yn6yfggnfzbawzly57puarazc@p3hpzfn2a7rk>
References: <20250128-pks-reftable-drop-git-compat-util-v2-0-c85c20336317@pks.im>
 <20250128-pks-reftable-drop-git-compat-util-v2-4-c85c20336317@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128-pks-reftable-drop-git-compat-util-v2-4-c85c20336317@pks.im>

On 25/01/28 09:28AM, Patrick Steinhardt wrote:
> Drop our use of `COPY_ARRAY()`, replacing it with an open-coded variant
> thereof. This is done to reduce our dependency on the Git library.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/record.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/reftable/record.c b/reftable/record.c
> index 8919df8a4d..d1664c47ca 100644
> --- a/reftable/record.c
> +++ b/reftable/record.c
> @@ -508,7 +508,8 @@ static int reftable_obj_record_copy_from(void *rec, const void *src_rec,
>  	if (!obj->offsets)
>  		return REFTABLE_OUT_OF_MEMORY_ERROR;
>  	obj->offset_len = src->offset_len;
> -	COPY_ARRAY(obj->offsets, src->offsets, src->offset_len);
> +	if (src->offset_len)
> +		memcpy(obj->offsets, src->offsets, sizeof(*src->offsets) * src->offset_len);

The `COPY_ARRAY` version uses `st_mutl()` to protect against potential
overflows of the size parameter. Does this variant need to account for
such situations as well?

>  	return 0;
>  }
> 
> -- 
> 2.48.1.362.g079036d154.dirty
> 
