Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B044161
	for <git@vger.kernel.org>; Sat, 16 Nov 2024 13:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731763001; cv=none; b=FwhjUdnwASJFZtRLawa+pn8hqO1za0E4CGTIw02cjZbHAQCWnDvnEe7p+6OTaoYReoo2IawImP1WjsqT6PVwSfOU7xj5c2sc4ILGL1mgDiPw2TFVf7pDRA1ZiB7db/F4bSwW0FBTXnfkRELXGiOBrPL37/5dRK251VY97KIacto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731763001; c=relaxed/simple;
	bh=svj8m/qZyKMcqQuLAyhFlDdsmDCS/dpFYhik24qzq3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htoFCLV5oT3GWAUzuadWTmQUkGkbnY+FR4iCjCUj/GHuxjnrQ5XYrqZMP716ly0yds3pz2OULdFkXpiFj5QiM4cJH06qeJcywBAGBqybayGBbLvziff+3KOegUFavXM7eZ82rMFdRmH+aNMk3HXkcSTXlz0iNi0JTW3WaNvX/sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjqASlPS; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjqASlPS"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20c714cd9c8so3666465ad.0
        for <git@vger.kernel.org>; Sat, 16 Nov 2024 05:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731763000; x=1732367800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wjQghNM7JU7uDBIiDnFzCDtor6K7KMXH+5lFiOroF24=;
        b=kjqASlPSpk0+TOLPIDNNcrTFm+7mqJHLOxeJZGUJZp7oXsH8UV2p0G7wVsD4QQT4+c
         pviIGvkEGgBbSMMW49SFKdbciwLbKfcDxBbdq9+V/Qgw/RzOS9DnhQLMynlvPcngcera
         g4abwmJRpHVa5H72friElP5k3xhaUTa163fnHR4W4vB9n0QYXNoKZqMGFnq8h+2wrcU1
         X8Kmcm1z9/52WEPpEjryWCqrOdtu9u0HRFE57UUu2tL03wvG4vSJJXx0Yn2AhOquHapl
         tmF7Gnrq9ySMw3fABjHp6shgLxqfm6xSfyIaZxXn5EvaXzw49qJg8H2ccJFw3plG80Sh
         /osA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731763000; x=1732367800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjQghNM7JU7uDBIiDnFzCDtor6K7KMXH+5lFiOroF24=;
        b=uru8JKG9A5Kfjg+AmtRh69MnXtT267ZEdR9g/O6z2CIfHFkIzrMqZTFITVndN4Qrfp
         AQV5zQNJpFMJiTb78wFkv34ZEifjSkepyUwQItnQLy9uCl1X8C16MOuRseuWdYWbAvER
         GbpIY2X+42FlstgyRP+N/N/HxmWNHI4cm2QOi3fxuWtn9U2zo2Q+i6J8YjI4DhFePEjY
         cGUgWfYoRV2EnTeIfGbzC95B0413rtJW82msx4Ic7fo4F1sz2R5u4nRXNlE9P+t459t/
         pCndvNghE2Fe2YDZv/RSslQRIsAgBv2xaY4kNNLuywWRi+6H+eUkKLE6cP8bwJZ3rmKg
         +TpQ==
X-Gm-Message-State: AOJu0Yz613GMrGW8rqsttfWLSkLRyKlUTtvrNKAPFM/7odMalFNeHru1
	5eB1RB+eGhLaFq1C8Ao1O3c1S+DeXFgn6butruUMMo+7m/UWsZQM
X-Google-Smtp-Source: AGHT+IHA+uxPtL+foqqwUcmKOUsoseTvGzxCd+q+99kNpPKNuojIpm67vtFo9/wIxht+8clo3fY37A==
X-Received: by 2002:a17:903:32c7:b0:20b:a9f3:796d with SMTP id d9443c01a7336-211d0ebf9aamr94672785ad.44.1731762999643;
        Sat, 16 Nov 2024 05:16:39 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0dc5df5sm27645695ad.10.2024.11.16.05.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 05:16:39 -0800 (PST)
Date: Sat, 16 Nov 2024 21:16:44 +0800
From: shejialuo <shejialuo@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, me@ttaylorr.com, peff@peff.net
Subject: Re: [PATCH 6/8] midx: pass down `hash_algo` to
 `get_midx_filename[_ext]`
Message-ID: <ZzibPPpDw518npNp@ArchLinux>
References: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-0-761f8a2c7775@gmail.com>
 <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-6-761f8a2c7775@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-6-761f8a2c7775@gmail.com>

On Fri, Nov 15, 2024 at 02:42:19PM +0100, Karthik Nayak wrote:

[snip]

> diff --git a/midx.h b/midx.h
> index 78efa28d35371795fa33c68660278182debb60ab..7620820d4d0272926af9e4eeb68bfb73404c7ec2 100644
> --- a/midx.h
> +++ b/midx.h
> @@ -7,6 +7,7 @@ struct object_id;
>  struct pack_entry;
>  struct repository;
>  struct bitmapped_pack;
> +struct git_hash_algo;
>  
>  #define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
>  #define MIDX_VERSION 1
> @@ -89,8 +90,10 @@ struct multi_pack_index {
>  #define MIDX_EXT_MIDX "midx"
>  
>  const unsigned char *get_midx_checksum(struct multi_pack_index *m);
> -void get_midx_filename(struct strbuf *out, const char *object_dir);
> -void get_midx_filename_ext(struct strbuf *out, const char *object_dir,
> +void get_midx_filename(const struct git_hash_algo *hash_algo,
> +		       struct strbuf *out, const char *object_dir);
> +void get_midx_filename_ext(const struct git_hash_algo *hash_algo,
> +			   struct strbuf *out, const char *object_dir,
>  			   const unsigned char *hash, const char *ext);

I don't think it's a good idea to put "hash_algo" in the first argument,
we should put it at the last to align with the code style where we use
"git_hash_algo".

>  void get_midx_chain_dirname(struct strbuf *buf, const char *object_dir);
>  void get_midx_chain_filename(struct strbuf *buf, const char *object_dir);
