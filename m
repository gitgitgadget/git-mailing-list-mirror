Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A39179A7
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 16:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722443844; cv=none; b=jkZXu8qfS18D01ACROA4tyjtvd11L3CfOiUQjgzT7SlzBjHQyoZjSEdHHBymAfMUQVBX+CMiyNBSS85WgT0aS4YHMo8Vbf59VTh3JJfabaFvtsLn6lqFndkaGxxcrFj3OCAh1l3mlViZlzwWTOR1beBzqCv/zJG2Q9I6i0pV5so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722443844; c=relaxed/simple;
	bh=CMuU726uMRFI1+fgYoDPh74gg96cnLxvNvNgsEuGfZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZ2oZzAeT4SWGKa89M6mGBMymDP2f4L5yUq6jNbUoGFuw04xg31GOwASbPoD91fFKItbhAkCoAedm831CG7znPUShGdUDZ5anCh/y/Vh1gTzGu9c/JiL/5Z+SmZtTjJMp+U07Yrv2H2c2r6MgQw7xoSggv6ejQ+t7MqocCYU0N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=A/uj5d6Z; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="A/uj5d6Z"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b797234b09so10688076d6.0
        for <git@vger.kernel.org>; Wed, 31 Jul 2024 09:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722443842; x=1723048642; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GQF/IAuwGRiPbZCprW9QKfalp/ftGkuvYDAeaBLIHa0=;
        b=A/uj5d6ZS0XcUhwLGIr5tDX2aZie0x0/1qKBpJQ9nph08a+2g/IdmfPrvcG1fRBq4M
         jNvrnOi40V9kCvK9rRdTB5CqIu27FXcB3yGke2mViAXDb6b7NUm4xCJ5WYegnumOLS2H
         ebeKLLM8kBDd/UyXQ+l0dnOmo8D94LEsAgjmLaOd6xHAz+jrBe5J14+2j2WbEXWUxgmO
         nfpqApfBizNylFFVHwNbrJlCnRGfUofL9g+6hfDUZ5YOZrvm5bWyqJCScQmruAX88Uui
         iDTQosd40Ea8IArAIxwV8wzeluhwsjY8q/YxlYEkVwXZnGyeNydRlfmXKtFsy0sgvdRO
         zMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722443842; x=1723048642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQF/IAuwGRiPbZCprW9QKfalp/ftGkuvYDAeaBLIHa0=;
        b=musojJTo+YAjPuxQcT4zfqfZTngSji+CLj+rYuQNLKLEtuI1lv2GQCY7XTVrIeThJb
         5t03YmDcAo44d16BVAdPuGTszkQCykYWb1EFEYw7GfNewv1FzEsfhTK3jo+sjYwL0E2o
         UEfLTBCheFHZSaqCC8mIaTsUb1mugkFivWkFoW4HJGUfcW+obKrQtBrJOt1IW8q167G/
         7pMwOwAkDzxRs6XxBgPdyHkj5XvWvYKz36i6TM1XogSr1dSk0WUyiyGdcijR5l+HNauc
         3zC9FLCnbpM10vLg3vmiq6CxQckoKLxhQRoo9psCXG4uHR8441k3rf8SC5JVIP6J5eWO
         Xz9w==
X-Gm-Message-State: AOJu0Yx6Tlc9r3nlKHvVJu+TGbS0eANZmKsZsP+5vBqHAOkc7WKOsg4s
	S6oG+8cZ9UmI68K7mB6ostDIzSU0dYXHQ6qxIALDFaVmqKnPz3aV6/D+LFyKIMw=
X-Google-Smtp-Source: AGHT+IELAbkXRqYmxBmMsJoTE85oynBLASZOvAca/E4AiXCsqXeWDmYnJdWWwfS8bW4VT0wElm66TQ==
X-Received: by 2002:a05:6214:5884:b0:6bb:8b2e:8e7a with SMTP id 6a1803df08f44-6bb8b2e9255mr16459936d6.24.1722443842357;
        Wed, 31 Jul 2024 09:37:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fa94a16sm76484356d6.86.2024.07.31.09.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 09:37:21 -0700 (PDT)
Date: Wed, 31 Jul 2024 12:37:20 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 09/23] builtin/remote: fix leaking strings in
 `branch_list`
Message-ID: <ZqpoQFFmGQa25veh@nand.local>
References: <cover.1721995576.git.ps@pks.im>
 <6952fb2ff2cf453de39b63883a716a9f09cab7b7.1721995576.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6952fb2ff2cf453de39b63883a716a9f09cab7b7.1721995576.git.ps@pks.im>

On Fri, Jul 26, 2024 at 02:15:36PM +0200, Patrick Steinhardt wrote:
> @@ -292,8 +292,8 @@ static int config_read_branches(const char *key, const char *value,
>  		type = PUSH_REMOTE;
>  	else
>  		return 0;
> -	name = xmemdupz(key, key_len);
>
> +	name = xmemdupz(key, key_len);

I stared at this for longer than I'd like to admit wondering if there
was a whitespace error in the pre-image or something. But I see you just
moved initializing 'name' next to the initialization of 'item'.

I'd argue that might be a stray diff, but I don't think it matters much.

>  	item = string_list_insert(&branch_list, name);
>
>  	if (!item->util)
> @@ -337,6 +337,7 @@ static int config_read_branches(const char *key, const char *value,
>  		BUG("unexpected type=%d", type);
>  	}
>
> +	free(name);
>  	return 0;
>  }

The patch looks good to me otherwise.

Thanks,
Taylor
