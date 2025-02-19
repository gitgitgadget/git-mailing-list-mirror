Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF5E1FECAE
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 17:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739984754; cv=none; b=kthxcVHxoYtPEX4QQvo0FFkSFUNIDTCGPaoEmY/FOzxt8cY6HTAICNJ8Sir77ZszLXY8t2IkmvsBcEHbK6qVjClplj1ncuA6rn7adu+C105dwnYiwk9NfrxAr15nmm1jowoWgmHGSjU4RilsZ1cU4BpkBSaI8vg1m29bt+Ejvm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739984754; c=relaxed/simple;
	bh=DYhi6w+LzypmX88xjrjzw0nwo33CTkxc3tUpaI5tOD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkxUCvrxiuS/ymcGRDZcmXMYNxmwWHFYRlzbT4Phwr61jujXBbD2RT5QoQhDNIU63avTgZGUZqwwSsEM3H75kATY1Q+JsUHXgc9hrzHkzVDrS0r94aARgvv3Nfh5gQH97hjAWIo/bi5LDkH3gracpbQlPCjLilmYQihqunLvakA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ES3g9TOV; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ES3g9TOV"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5fcd61e9bcdso28407eaf.0
        for <git@vger.kernel.org>; Wed, 19 Feb 2025 09:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739984751; x=1740589551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fEKV3lC1SN1UeVzfNwNf1NEo1e3z7yJbfxxUtcmaYiQ=;
        b=ES3g9TOV9iw0wEP+qLvFvX5yu6VrLZJxNZ5gHefAzW4ZU5LHcmRA0nU94juv67OYML
         jYX5IhRl7/lg0NTQqjtUDuPdoUrgzPWEZ/IldbFOYwvFKIEMPt2uN70Nsnanqctb11yX
         pXXnope8wcRW1X/TFgekgFZWVsGXNxK/Dr3TiL/So02INaw3Hwzz1S5AQSE2h29yavRX
         n+3bccrFyzrcR8OheK/wN9ubxH7cjyhzoTGE2wTO1fHLx1O99jRsrsPEheXWlY0l+vCm
         3AeiPMDbcqWXbNi1FB55Jdwc0VSo/LD7ON8i+NQ7jd3XmiYuwFKfYq8i3Aaa49KtVGDh
         YgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739984751; x=1740589551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fEKV3lC1SN1UeVzfNwNf1NEo1e3z7yJbfxxUtcmaYiQ=;
        b=UuKZCByasQDIswM+ta8h0bItggfHRrREPW+ITIugwwc5gW/ujX8xAkww16AocFuTPC
         c7itnJV5jhOoV3MDFHcKkbNLFIKMM1nDfufoCaRB2Pkx+ln7Eu7dCv2qKkNQODCocZmT
         6TSUkO4oBMnCPReezJvs8kntR7tNFy+vm0rHfhrFejrE8Lm1S5HVwKbMwUeMMUQIifMC
         /yC/1jNK4+GUEwgc/QGotLnMJsGr0xogjHP39UyAJQVfaNUgBMiRjUgT7HpR4PzERg4C
         vnXO9oMyoa2XYf2qXZ5bYCbFrPMC9ux5ETopF9c6ofDKFzl9wbKKkcbV3AWC8df/RYDm
         UI2w==
X-Gm-Message-State: AOJu0YwiK7pjqrvBWOF7MIVpwqnoTAT3tS4ZrsOMMZidMHHXN/t5025t
	tc3IyS2xoC8FfdeQLq02RZqLZi4L0+3sxrpC/AdGWq1L3Ip6KitM
X-Gm-Gg: ASbGncuWcnaPB/UuW7pOjXp8bFjYmJwAePheMVuqHLmbTa3eBWnKhtQ40YX6sET7+TO
	I7WoZHCsnKI4KoPIubtNeSsukReND9CMeQtsSkOW3IHtng694twI/yfijCnhfN73HN74e1l1Nrr
	rZReAEeHB7AHvrhTziqXx869BfABM0jmKH03MhnKouLdA17P0emsgaOboZfdVHdyNhfhPWETg43
	YWL9yXj65MhE4ojIgbjeqF++uCvNptOK4ujgGUT6m99Veyf7iUttZtKYjOQjD++hM+v5dUhLXGY
	jbiL1W4y
X-Google-Smtp-Source: AGHT+IGI1+dj4Q+wub26z1yktYUxah6Xp1wRVl3B0I8JtNL0bBPISROuQUTko/yCMCj1cFo9CEqvLQ==
X-Received: by 2002:a05:6871:b1f:b0:2b3:8b27:c352 with SMTP id 586e51a60fabf-2bc99dbb5b3mr13270312fac.33.1739984751515;
        Wed, 19 Feb 2025 09:05:51 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-72726385f4esm1898515a34.15.2025.02.19.09.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 09:05:51 -0800 (PST)
Date: Wed, 19 Feb 2025 11:02:43 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	shejialuo <shejialuo@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 01/16] object-name: introduce
 `repo_get_oid_with_flags()`
Message-ID: <5qatn3wcp4ili3dyz6edzvp5ydsydh523cfz5syqz75afiuvbh@67ndxkvkbxnb>
References: <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
 <20250219-pks-update-ref-optimization-v2-1-e696e7220b22@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219-pks-update-ref-optimization-v2-1-e696e7220b22@pks.im>

On 25/02/19 02:23PM, Patrick Steinhardt wrote:
[snip]
> diff --git a/object-name.c b/object-name.c
> index 945d5bdef25..bc0265ad2a1 100644
> --- a/object-name.c
> +++ b/object-name.c
> @@ -1794,18 +1794,20 @@ void object_context_release(struct object_context *ctx)
>  	strbuf_release(&ctx->symlink_path);
>  }
>  
> -/*
> - * This is like "get_oid_basic()", except it allows "object ID expressions",
> - * notably "xyz^" for "parent of xyz"
> - */
> -int repo_get_oid(struct repository *r, const char *name, struct object_id *oid)
> +int repo_get_oid_with_flags(struct repository *r, const char *name, struct object_id *oid,
> +			    unsigned flags)

style: The function signature runs a bit long on the first line. Not a
big deal, but we could reformat it.

>  {
>  	struct object_context unused;
> -	int ret = get_oid_with_context(r, name, 0, oid, &unused);
> +	int ret = get_oid_with_context(r, name, flags, oid, &unused);
>  	object_context_release(&unused);
>  	return ret;
>  }
>  
> +int repo_get_oid(struct repository *r, const char *name, struct object_id *oid)
> +{
> +	return repo_get_oid_with_flags(r, name, oid, 0);
> +}
> +
>  /*
>   * This returns a non-zero value if the string (built using printf
>   * format and the given arguments) is not a valid object.
> diff --git a/object-name.h b/object-name.h
> index 8dba4a47a47..fb5a97b2c8e 100644
> --- a/object-name.h
> +++ b/object-name.h
> @@ -51,6 +51,12 @@ void strbuf_repo_add_unique_abbrev(struct strbuf *sb, struct repository *repo,
>  void strbuf_add_unique_abbrev(struct strbuf *sb, const struct object_id *oid,
>  			      int abbrev_len);
>  
> +/*
> + * This is like "get_oid_basic()", except it allows "object ID expressions",
> + * notably "xyz^" for "parent of xyz". Accepts GET_OID_* flags.
> + */
> +int repo_get_oid_with_flags(struct repository *r, const char *str, struct object_id *oid,
> +			    unsigned flags);

Same here.

>  int repo_get_oid(struct repository *r, const char *str, struct object_id *oid);
>  __attribute__((format (printf, 2, 3)))
>  int get_oidf(struct object_id *oid, const char *fmt, ...);
> 
> -- 
> 2.48.1.683.gf705b3209c.dirty
> 
> 
