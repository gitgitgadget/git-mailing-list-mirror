Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DA71D1744
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 21:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729544798; cv=none; b=OJ2Cdisl7b3sPGLJw84Q1Ig3kjsRkxjT7ACFecNeMSYIAxKaYkPc1ErPZaMxsFJ90zUxj31onsKFUQLMFCEam2Hj9mHkUDUPV64lcOFrwdoiFVUmAJOd45N6RvEZJti/V5ximiPp5T3TQ8ZcAyb68DwlRsPTbjjXWeE65rFasiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729544798; c=relaxed/simple;
	bh=99c5293eeEdqfWQTRYd3px9Qp8hBLEKVOuWDmVeUUBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Do8SHSA98WgnFrEOahal9HscPbrCI0LLJBw8V0vmamQpaOWU/CmmUYpDhbKBfPiiYqMInk4NRVfwmUU+2HRKHGFa0hYKMGZ3SRBT5r0xNh6WFoqiMvjArJGJeuWnp5i1To5WFPSalrBi9Lqk7pvOoCBvm3NGAtWp977+AMzyiDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=YdDYybSC; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="YdDYybSC"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6e3a97a6010so56577047b3.1
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 14:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729544796; x=1730149596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=88LDQDEzvSDhVmjFgEzIxgfi2u9Ohr+hlj2LnQKXTKA=;
        b=YdDYybSCGAzcOGXOsdA9Qyu+uD6fViKvi6sS7Zs1732Rn1hAbZNWuktGxZgbPP0AHK
         4PiP4QMlA0p/Y1V/ZR6aRoolGweDQo/yvX+qr4/Gn3mB/CVlF7yaEBeuUsAim2rAHBSL
         7lFnfQhXE8BNo3goa2qGyu5JgznujyFLd69ZPX6wlDUsoiKQm57gno0qYiGT2/x3KW/d
         oGBQTUIVvCVMNd6kd4nYLD7t9mSUarcP4CadUMokJYrLWpCpjt6zLpq0tEKDI5AkWeLQ
         +uEBTMZG3AdNm3os1KoXbzzUn8QI9mD+Bk24R+fsDr67tiNxsqVtTEd7DaGVKuSg4OSR
         K3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729544796; x=1730149596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88LDQDEzvSDhVmjFgEzIxgfi2u9Ohr+hlj2LnQKXTKA=;
        b=YfeNe1KxzRCq0GTdMlC6/jXiwLSywcTeqmXBT0RqxAAKr5/aaW5IWPuQHaiKu0xVGj
         izSYNtTpxrwrhwSazDf2+zNH36zfsn+BcFVLuKiafldX2B0tK6Cj0F8neOfECipLmvsm
         gVxwn7O1Nbfaigh6TZ8aW9Mo6+Y6shkDjw3iZDMyy2bt8tMzXUrmW1kKuCXUAPgsGjzc
         46yWvsWu08DJ+fzQU75fD+SYa2qj78fAfBVYRB5Wb9YOClY1Ch0ad2BB9JrB0+ca/o18
         TdUo/mFIBa65g94weD25Lyp+3n4IfegcYh7KsyKQ6lWWflU6L8Xtd0gDXkZn3BXIZLeC
         A3sA==
X-Gm-Message-State: AOJu0YwYJT+iUCpwZg4vj8jOH7lo6IYpnk2uGH7S3cDcMseHM8Zcj+Ej
	cuojvYOh/H4sAxw4IG5oIAdNdz96JrZlbMQQGIoxV7KandtUvnydpRFHjGKTmro=
X-Google-Smtp-Source: AGHT+IFuU3SUpr6OSkXuJG8m7vQ5NUoOSoiN+V2gOvV85Smti9avFicT0EpdYPUYlmowh8+dmwfC9Q==
X-Received: by 2002:a05:690c:6002:b0:6e3:31ee:23ab with SMTP id 00721157ae682-6e5bfc896aamr128324247b3.25.1729544796239;
        Mon, 21 Oct 2024 14:06:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f59faf22sm8323397b3.1.2024.10.21.14.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 14:06:35 -0700 (PDT)
Date: Mon, 21 Oct 2024 17:06:34 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/20] packfile: pass down repository to `odb_pack_name`
Message-ID: <ZxbCWvFo8ZdwPgJd@nand.local>
References: <cover.1729504640.git.karthik.188@gmail.com>
 <c8cc21c2eeb9d1e0bc261143e642eff38fe33888.1729504641.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c8cc21c2eeb9d1e0bc261143e642eff38fe33888.1729504641.git.karthik.188@gmail.com>

On Mon, Oct 21, 2024 at 11:57:44AM +0200, Karthik Nayak wrote:
> diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
> index 5809613002..60f806e672 100644
> --- a/builtin/pack-redundant.c
> +++ b/builtin/pack-redundant.c
> @@ -688,7 +688,7 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix UNUSED, s
>  	pl = red = pack_list_difference(local_packs, min);
>  	while (pl) {
>  		printf("%s\n%s\n",
> -		       sha1_pack_index_name(pl->pack->hash),
> +		       sha1_pack_index_name(the_repository, pl->pack->hash),
>  		       pl->pack->pack_name);
>  		pl = pl->next;
>  	}

I am a little surprised to see sha1_pack_index_name() converted
similarly here, as this patch promises only to touch the
'odb_pack_name()' function.

> diff --git a/packfile.h b/packfile.h
> index 0f78658229..507ac602b5 100644
> --- a/packfile.h
> +++ b/packfile.h

Indeed, it looks like odb_pack_name(), sha1_pack_name(),
sha1_pack_index_name(), parse_pack_index(), and has_pack_index() are all
modified. Were these meant to go in separate patches?

Thanks,
Taylor
