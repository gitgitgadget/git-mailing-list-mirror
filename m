Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708DF158DDD
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 16:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086569; cv=none; b=OhHt+9lqIRgRwp5EgFg/LHL2g+OLLxUh1n9i8Xk8R+i2T7i9k4w7doHz4GBKv4E0a3mC/GVxK6UYGPHmYiL0mopUlltKT7fJiEgB8TJ3ckeDiojI7IXkS7AeOqoAVopM2BES1WWdYaVTA1HR2jZWEaUK4ccs+iqz+WjGNLR1HSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086569; c=relaxed/simple;
	bh=fuSXLlm3q/ZnSoxPhjEINZ8ik5OGpv7tA7iS24ktwFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BpKxVLMDeyyDxO6mnRa9yUZsndWL+lpG9v4SPcw8p4ghEfOsOFbVCHqHK0X+mo+LGNdR9gKzWch04F8Q8R/9eGBMCnQwQdHHsEJkJTFketvO0xqdxxjvkpgSwmORjWpZLUzRG/k1SaPdm/E9pp/SgdZBP4EL87Klet+v9JJAoNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkGdAlIE; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkGdAlIE"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3db16129143so2415925b6e.0
        for <git@vger.kernel.org>; Mon, 19 Aug 2024 09:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724086567; x=1724691367; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DJFPrjs2ppENJCq4yC3HQsFaY89wlY/L1S0Kj2b4Xew=;
        b=YkGdAlIEnF88Js3oEBVDYoSAuuU2obO2tw5Xs7vZyNDGsfw4dFIp4uvVyMCWG9LtQD
         z6hVDpDSR7FRW2z300xfuvcRKb1AwRK2QELHHV5JbmIQ42Wm6tZVwe0dZwPv4XIqk7EH
         UqJpiCHTx1qUMcijXtJaw3eFkpuaxT5EIOEuEDEl0ejmpeq87obbp4zsBk4vP4zOnxOT
         gFqE0xPcICJebDDRtvWvnTv4qGrEwhmrnUPhOh/oMKVV5cuwwsQMoSsAw2cf/gKCaot4
         MHzs9FC1mZ4WoNW94dg8UTNwna6gvFwjJy/YZkepMlducK8mXJQyjmGTY4FhZEARlYac
         qc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724086567; x=1724691367;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJFPrjs2ppENJCq4yC3HQsFaY89wlY/L1S0Kj2b4Xew=;
        b=UYPxwKahhXQVaqRpEbWWjlqoIuc0Y83lrKH21pO8B2aGEfrr1m5HlacT1ApPQ9n7/W
         YzhjWiOvAWTxkDvR71fH6uWQbYMehWhV6NL1PDnT9q5gvsetPdk7TAl51z0qJYRzTOeS
         uNYZLgD72XPVYep/4iouW7aJ+JaZNuozIAn88OmG+5hmObxjxzVXQGElpJWUroZlcmTw
         n6kzHcELj/OQQlIbYKcsd+2QZUZu0bJpX7nOqiwXHfI/QRx1EA6c1LWDSOgFdDyPf4W3
         co51UvN8b13VTVXxsHLPwDSbUaV6IZsCvqL1dtxgcakdikYodAg+uhVjbSmW0h7zXgwb
         vmtg==
X-Gm-Message-State: AOJu0YxIuEX89/X697Nb8Mw2pO5RcJ57HwV+neKdxD14gW6ARkNawPMU
	ExinMyujuA9cF04/5GLuwbn1/uClKiU7vHG4tX0cCWeC7U9OoQld0DD/7Q==
X-Google-Smtp-Source: AGHT+IEZcST2JUK18rkiO2nCf2OtfclIVYOlkHQx1i3zA9Vfh5l8NHImzOSCKtygsCyB4ojvalzenw==
X-Received: by 2002:a05:6808:150f:b0:3d9:2ab5:c697 with SMTP id 5614622812f47-3dd42e6f02fmr8822649b6e.20.1724086567439;
        Mon, 19 Aug 2024 09:56:07 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3dd33f047b4sm2372451b6e.56.2024.08.19.09.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 09:56:07 -0700 (PDT)
Date: Mon, 19 Aug 2024 11:55:16 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/10] reftable/merged: expose functions to initialize
 iterators
Message-ID: <wb5nteglnm4bfu5pe3xqtdatsv4byyah4py6m2imp6wsh2xspo@bft2kvapv6vh>
References: <cover.1723528765.git.ps@pks.im>
 <404d64effde3bee424e338d858ed507ff83dff20.1723528765.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <404d64effde3bee424e338d858ed507ff83dff20.1723528765.git.ps@pks.im>

On 24/08/13 08:24AM, Patrick Steinhardt wrote:
> We do not expose any functions via our public headers that would allow a
> caller to initialize a reftable iterator from a merged table. Instead,
> they are expected to go via the generic `reftable_table` interface,
> which is somewhat roundabout.
> 
> Implement two new functions to initialize iterators for ref and log
> records to plug this gap.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
[snip]
> diff --git a/reftable/reftable-merged.h b/reftable/reftable-merged.h
> index 14d5fc9f05..4deb0ad22e 100644
> --- a/reftable/reftable-merged.h
> +++ b/reftable/reftable-merged.h
> @@ -36,6 +36,14 @@ int reftable_new_merged_table(struct reftable_merged_table **dest,
>  			      struct reftable_table *stack, size_t n,
>  			      uint32_t hash_id);
>  
> +/* Initialize a merged table iterator for reading refs. */
> +void reftable_merged_table_init_ref_iterator(struct reftable_merged_table *mt,
> +					     struct reftable_iterator *it);
> +
> +/* Initialize a merged table iterator for reading logs. */
> +void reftable_merged_table_init_log_iterator(struct reftable_merged_table *mt,
> +					     struct reftable_iterator *it);

I might have missed it, but I do not see 
`reftable_merged_table_init_log_iterator()` used anywhere in the later
patches. Does this need to be added? Or are we just adding it because we
want a companion function to the ref iterator to be more consistent? 

-Justin
