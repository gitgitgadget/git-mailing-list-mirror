Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4174E16EBEE
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 22:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732143182; cv=none; b=nUnKinyXWU36Ut9pgSe8PccUKw9NzMRu4DroQaeiT0rlQv8o0WoRNfwCD53tk5+M5k83qHzd/N5AkULSEgmgdV5onk+epXeAAY0ivptt1eeNdlYeNQOhl7xHULPCEyz15aEO11QnJnPRD2ubfn8ZB7xzR957hOyaGJJmO7ov1W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732143182; c=relaxed/simple;
	bh=I9Q+Zfl8bVkTyx0OCdWiRtnj1nU1WZ3QJfPscd+kWa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmvPAXH3t2El6aSYBajfcZFWWt3MSqi2MA/OKGH0114//ZuqLRAmSpoC9lZy/SHbdXHbamqfCS1nLWyWrKHDyFGS6eSFFkQFJVeL7euj07Me3V91Lu3aFNsFWn+cM2SOlFj9sq1X1eT8qSwkQ61kPDhZhL1JpHkJy7TBveJkFPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=VOC/GUBY; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="VOC/GUBY"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e0875f1e9edso221483276.1
        for <git@vger.kernel.org>; Wed, 20 Nov 2024 14:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1732143180; x=1732747980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v/a/sAJDUQW9M9yq0pJnAaqx5b2kKniQxBhVfJ0vt0U=;
        b=VOC/GUBY5SU7BOHcaEswFtRwE8X/hwUV94MeA2bXJ5qblT8O0VCf4scYAhldXXdPwX
         AEWUQsF7JBtY+MdbRz9PchPztzCOzu/0PB4bdBnhdjqY7CXfDzeKQm0Hdgu4Yilafuv3
         4OIWYm7R6Qhv+PW+dRUCv+77DskoX5GaA4jsS52ejjrFoEgnyVqnWzc6pip2caoDn1LD
         BdNkgbG4TUHh0Ck92PUDWgB+kwEPt0OezYLrjaOGzGYQo4tSXx/m7Ze1mK3ctRUWKbdt
         lkjhvK8MMwKWlaGkoWL2SccOzrJ0RgBxs51xN8NPv70OiKztWe24zNsp4cTimXXBxzmY
         s/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732143180; x=1732747980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/a/sAJDUQW9M9yq0pJnAaqx5b2kKniQxBhVfJ0vt0U=;
        b=ZyYIZtUM+os21KbMhelVCgEZGrcD9zzkFcmHXxWFsMACDEqQGwZqD8xxopppaD8zOs
         cNucYxK3jW16f49LayTUtOkNJsnmXEQaJ6d+kk6/Oz507LDXsqV4tmVRoW6fbx2EcArx
         IXL9jXw5KJKUsSIjqD8PoSi90cdDtRt5KqQ4bFd0/yYmM1wULFj3PxXjDsGinrO63Pt9
         S0Wi7PkMWqUV9Qtvd0XYIvtxdZmH93s89sb6U2xmn4aD1CVRXYxJFRfUfCpj15t6Zwco
         B3xiDy7rQaGt9mvSAGD32kwvbtFm9faQIZxankV7rQi+gMJ89sx87wGTBxZYhT1MYCrp
         mYpw==
X-Gm-Message-State: AOJu0YykkTwmN/wHy5uT0GZjQmrMls/PbRGHiCrT1d7G/OaTgIG+Y9O3
	oQNwu0gYuKpQlFrFbjZ+DT9WL2tGaDhygKa3wNmiYEdKXofDNTeo2Yoik1c59vPNxd1LQXIDhR6
	Y
X-Gm-Gg: ASbGnctBjn5Py/MDfK6xNCqwsOeCJPNfiIprGz27BY5GnQL2UbsZLG8PjBaBMtYwHmE
	pObncPS2HCctdBLm8amIAGdSIDyyq1tTkZ7L6ylz2e91ecO2CkV2qRkmHqepkL9ULSkAwve9IJN
	7BS+zeaBhoFQWQv2ETglJsNLwzyBnXtzQ7vAOBemqTQPAcOQp7At50PYCaQX2C9H5YXWnjUVd6/
	+c6/iCirt4RVArV9OGfymIouQA/F6c322CdOFROTjrrmQ+QMxQvyp8fPow7Zqm+Yqkn2S4ftZUy
	S01S/Elgfu5oofravhSZDA==
X-Google-Smtp-Source: AGHT+IFiMGdQwoqsA46fAWcLb98G4T2aY24MNbAqK1BJCJK0HoIzODKjevjaeC9Xodr1zR4S45Jywg==
X-Received: by 2002:a05:6902:dca:b0:e38:a031:bbd5 with SMTP id 3f1490d57ef6-e38cb5a9686mr4099188276.31.1732143180250;
        Wed, 20 Nov 2024 14:53:00 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e387e73bc22sm3420984276.15.2024.11.20.14.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 14:52:59 -0800 (PST)
Date: Wed, 20 Nov 2024 17:52:58 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Subject: Re: [PATCH v7 7/9] config: make `delta_base_cache_limit` a
 non-global variable
Message-ID: <Zz5oSqu8IlWbZHvr@nand.local>
References: <cover.1731323350.git.karthik.188@gmail.com>
 <1bdc34f4d8161a3b70f21124cb857908e4fac53c.1731323350.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1bdc34f4d8161a3b70f21124cb857908e4fac53c.1731323350.git.karthik.188@gmail.com>

On Mon, Nov 11, 2024 at 12:14:07PM +0100, Karthik Nayak wrote:
> @@ -1697,6 +1701,9 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
>  	struct unpack_entry_stack_ent *delta_stack = small_delta_stack;
>  	int delta_stack_nr = 0, delta_stack_alloc = UNPACK_ENTRY_STACK_PREALLOC;
>  	int base_from_cache = 0;
> +	unsigned long delta_base_cache_limit = DEFAULT_DELTA_BASE_CACHE_LIMIT;
> +
> +	repo_config_get_ulong(r, "core.deltabasecachelimit", &delta_base_cache_limit);
>
>  	write_pack_access_log(p, obj_offset);
>

Hmm. This repo_config_get_ulong() call will look for the configset entry
in a hashmap which is faster than parsing the configuration file from
scratch every time, but still expensive for my taste in a function as
hot as unpack_entry().

Should this also go in the_repository->settings instead? That way we
have a single field access instead of a hashmap lookup (with multiple
layers of function calls between us and the actual lookup).

Thanks,
Taylor
