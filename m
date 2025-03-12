Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6824B241C8B
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 13:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741787142; cv=none; b=jVLkt9zVVUhcgVS/7uy7cf0xedQW7LJ6NpAQz/sr87fsOQg/LR/VJbyOhyAxvdcB+mSF7XT7uxf0fWcM0hIcma8KL0FYceLJKalqSeGCdmjTPaZk7RJc86YM0BRnwEq1HWLSvd9MenZ6yn7Bf5MdtANiHRc0jqXCfZV9xiONmdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741787142; c=relaxed/simple;
	bh=T/ZbwAYip2CMLgm31LZ3ICGcLmIK2atfogdRlv0KZZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WGnSJ3M4mfnUjc4lkArhNN4sZ5ihh9A8Iz98Iui2m2Jj/Dcz1GZPqWN5V3w3VAmzoCHl2R5uj/r1v+qm8/58JNvvp2cF71aoaqae99NwSYs2ng06m2yPpmk4uMYQRSSecNkqNVw3em44WZkh0I1lreZdEO4IgJWzUCyAgcv7mjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lP8ijI++; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lP8ijI++"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2243803b776so126123165ad.0
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 06:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741787139; x=1742391939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0srLC73+W+JldNwZcFbakcKXEZhzPwMuhswWox8SdR4=;
        b=lP8ijI++VfXgqxjH0ubkpfkIKg0GSgn7iigTjIP33TbXf+dlrSkGBz+El3dTB6J2SZ
         tXPgq2Tw4tDnxMk9Itg0MFwg8wtIbQjamX9vYMqv5ZupytI+JHxuZZfNIFr14YiRQCYz
         /i/G0aAToiZImD1zfbxh7Mwa0IXN5ncigjpLVzGIGk0MNec6HmXHL/m2kGynhYTjuaRi
         uY+ORu8MQhiuZs/2cXXIxrRZyECR34p2z+8rcHTSwFCC+2ZpKV2sDXRRFT2lkE9JqQAQ
         V2QeolOpHnd8nMxqFD2RAxs8jZYUOVtUkggZQlqUKlGv6SzGXhwdfx/OX9ADTAgKESKH
         XWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741787139; x=1742391939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0srLC73+W+JldNwZcFbakcKXEZhzPwMuhswWox8SdR4=;
        b=aVoCpMJIhF8ER11JV0XQn33PzUR9/Zogi193RbcxvZU+fsMFItQS665OUBxH7rAXU5
         77OqL7+7Ik/IKwKA9l8ziU0VWlvCnZg4ANGy6o/j6UJ6swNB1xAuIZa/i1NhuK6TEroU
         QLpjPjxvDfxZltZJ2JUUgU7rgMFr4uSuUJNOnN7HBq+AfeGvYWG764Rhk+7ElNJj+UJx
         dgiYNBEO7fqtLZBVNamM5lGZPdz9sid8bOjOTCPlOHOjBfAVr77oSrEvl6mew7MYc5+X
         szVEsCd7qVS7OkNi4qDs18Zq45/YBVpx6JLD0V+Ui3b53DSkRksYqu1iE25tYyjNZlMS
         49og==
X-Gm-Message-State: AOJu0Yz1o0jSULZz7tbpPoXR9EhepRhMEWeY1WeAZ/hVKKlDcN19ykRg
	9TNwhebOvETTKGEpyurVvevcEtLSjOe0M1fazOgm0GBkHu10yfTv
X-Gm-Gg: ASbGncumzplCV1JZM4rmtQNT/CGO2PzU0GQuuUJvJ1Y5LGt2duvzCCCzKA2u+6jYeGs
	bWFqd7KRTQWw45FVVXX6RD6lb6UPSIHVQpC0fdRo/79gcm/Oj+f2H4Ao0gNlqWX13h6F52nLffz
	1iZp/t1WIFo42E+zUSkdIcVjTXCPIjOw1ylIlH5LZ7IYPeyM5A6pyfEep2WzvWKe4RFwn0Az4CR
	RWkxWhLXh17E7S2HGRD8uKRnJ8BkU0brOrdhgGZ0H+VXYkGzlaAVQNUVFFu8bMdVrjVZv00zAoT
	ygTsaUH0Z1V9pKxJmGCNVr9FryeI7cOU2lq2ybhv
X-Google-Smtp-Source: AGHT+IH3f6TIQO3vWq/+sbTlBjxtmW8FWH/v/bbWf/vPHnsjtzg1IsT+O2YMyKtRCbLcxgNAPl4hug==
X-Received: by 2002:a17:902:e74f:b0:224:76f:9e44 with SMTP id d9443c01a7336-2242887b531mr286791575ad.8.1741787139669;
        Wed, 12 Mar 2025 06:45:39 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-224109e84desm115518895ad.70.2025.03.12.06.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 06:45:38 -0700 (PDT)
Date: Wed, 12 Mar 2025 21:45:48 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 09/16] refs/iterator: separate lifecycle from iteration
Message-ID: <Z9GQDJxT1Gu9nzGp@ArchLinux>
References: <20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im>
 <20250306-pks-update-ref-optimization-v5-9-dcb2ee037e97@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306-pks-update-ref-optimization-v5-9-dcb2ee037e97@pks.im>

On Thu, Mar 06, 2025 at 04:08:40PM +0100, Patrick Steinhardt wrote:

> @@ -350,19 +338,10 @@ static int prefix_ref_iterator_advance(struct ref_iterator *ref_iterator)
>  
>  	while ((ok = ref_iterator_advance(iter->iter0)) == ITER_OK) {
>  		int cmp = compare_prefix(iter->iter0->refname, iter->prefix);
> -
>  		if (cmp < 0)
>  			continue;
> -
> -		if (cmp > 0) {
> -			/*
> -			 * As the source iterator is ordered, we
> -			 * can stop the iteration as soon as we see a
> -			 * refname that comes after the prefix:
> -			 */
> -			ok = ref_iterator_abort(iter->iter0);
> -			break;
> -		}
> +		if (cmp > 0)
> +			return ITER_DONE;

Should we maintain the above comment? Why do we delete the comment. I
somehow think the comment makes sense.

>  
>  		if (iter->trim) {
>  			/*
