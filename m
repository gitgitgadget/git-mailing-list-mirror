Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0109C4207F
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 03:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754018342; cv=none; b=V1v1RZ71RSsw6c7lbBLHf4lXRkCWNnfpyWvT6mFzGmMex7YuohCn7lZe0AC3pfp1rylgfvARxtCGVGxwxLC//R8GyWUynT3+E/LBe29JXKkMp4pwwl5QJ9fm1kwLlyrZQFmFg5t+Y3V5dDFPKe0Pjjx6L8tZo92ZOtZXZ/Q69SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754018342; c=relaxed/simple;
	bh=Hnl067RmrRSrC8OcvMb6hCrzbRfd4Rk4TjJP3JUYJzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pv5VarlHRDColuRHsz/aAWXqSbJpQ65+6addM1S9fWy+Iymg8jjWMPb3H2Ofi7W20WnLMmpoDUIzQXstvY0/Qa3DynfBUgFxBl3miLW+doVeDkzDIlUbaCQAlbXBDntYxO3YdEp/KxhcgHK0fFnusBD1fwh7ToQbDWJCsgWZdCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ikHKHK+y; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikHKHK+y"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b422863dda0so331629a12.3
        for <git@vger.kernel.org>; Thu, 31 Jul 2025 20:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754018340; x=1754623140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R6mr/KRJ1vcqPx5D/ipNGN6nb6ZiR1xVX/O7cIU1h5o=;
        b=ikHKHK+yDrXLPhqJUhgwp+PmVKMGoOKmk4APPNKQLMCgExke/L0/YIDG3QZ6aoe/JN
         Yc9zesw9M2djFT4GwPQzT8MA5vpoRl8QZ+5yWKDiAXpee2qWAheRuMPykoUHaT5RafIx
         P2f4bAAVoa7C8mqZdBZ/lsHjfTsnUpjQf2mA6UKMZ44cQrStBPX/sTKEAnvFaflKBm5e
         nxQL6TwM9Z03nYFUkdEGCOylI4p4mx6kBbLjgIX/alCYLjAvvJo78o0uvhRV66TTvMGm
         Md8ffdz51Bu1Fc0Wuf9IkoYlQwInmERWPHj/5h5uAZ7GkidWjEvv6DhVLFmKQ9DfT2it
         UVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754018340; x=1754623140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6mr/KRJ1vcqPx5D/ipNGN6nb6ZiR1xVX/O7cIU1h5o=;
        b=nT7Q7d+mWtZLh7xq8ObbzSxoRwb/vRljg3KHKWIuE3xATMpXu4KQEYo4eGd439gMEi
         6JKEApd5cd8449ZMFkXrz1CWjgbQ0c3G4fh8eNM/c7/qySGZLJ+n2nxirvgB5FKfxIST
         R28fA3Kz+hbxhNbKd5SRgosdjvi+MeBAJG7lt3r5pVxcjsCgUHReW5p8MliuOoljwxUS
         EahxWyJ8U2sUHDlaxTCRGMIFeGkk9kP309TuZxwMJgGq9f9f1bdDkJUd4aYFoE0YVIYa
         0me0gvaM/98EkGyKB58rif1ck0sBrb0GS3GwUu0o6itQ3xzjfNc2n5Le3RY9rENSfSjd
         JL1A==
X-Gm-Message-State: AOJu0Yyp4pHu/3zMo3fT2a3OBYugqf/zZVA8AFwDoTDye2c5bVNLJJcA
	scFX9nyyELLQsXebz/Zl0XCL6k5dRBUTXfN7mZS8QLvODmF8Qbdri9kt
X-Gm-Gg: ASbGncso8HQZOQQ5aiqc8wGoKEhkwSwYenGD+mdhOngnbg4jtcVKsBg4zGPwL9O2k9R
	ITpVe2+qrJuBBPSHDeZjgDWTdN0zDapmmzpcVE7YVkPTvOpim8ZsYZWLwLogvjyw4GdxiUk1pDF
	8MvYB0C+SqBFShftssYD1fTdvQrc7UcLsR9Hic6+t+Hw5ZLPvK8LsE0PuJgpEw22IZgUtqCugby
	/nZu66gD6OZSqHiYw5bOnEB2dOnCGN8ue19iZHNUF9s+wuRVG7pp1n188PDq4mDIufwCiF+4rCx
	sd3SN1yAJzP7tdub/Jpz8L4LvBkLSJYKqiT3X/Ebu9ghPEzjzKuXLOQo/abEADf5gJjIh6tuYyo
	NKXsHoOZgeVTOYGAVd5ZigmqGCLMj/CI+1w==
X-Google-Smtp-Source: AGHT+IHN9rT1nVIcgiT0YKfajO8ZU0TA3a8pQiYbSsigQR+dWFYUsmGzmzWSEktFqKEjeBAsEJsIgA==
X-Received: by 2002:a05:6a20:9184:b0:220:2a63:732f with SMTP id adf61e73a8af0-23dc0d61806mr15169291637.19.1754018340111;
        Thu, 31 Jul 2025 20:19:00 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-76bccfe9003sm2852242b3a.125.2025.07.31.20.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 20:18:59 -0700 (PDT)
Date: Fri, 1 Aug 2025 11:18:56 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 4/7] string-list: optionally trim string pieces split
 by string_list_split*()
Message-ID: <aIwyIJqEIdSdKINz@mbp>
References: <20250731063949.1601669-1-gitster@pobox.com>
 <20250731224607.3942417-1-gitster@pobox.com>
 <20250731224607.3942417-5-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731224607.3942417-5-gitster@pobox.com>

On Thu, Jul 31, 2025 at 03:46:03PM -0700, Junio C Hamano wrote:
>  static int split_string(struct string_list *list, const char *string, const char *delim,
> -			int maxsplit, int in_place)
> +			int maxsplit, int in_place, unsigned flags)
>  {
>  	int count = 0;
>  	const char *p = string;
> @@ -320,12 +327,18 @@ static int split_string(struct string_list *list, const char *string, const char
>  	for (;;) {
>  		char *end;
>  
> +		if (flags & STRING_LIST_SPLIT_TRIM) {
> +			/* ltrim */
> +			while (*p && isspace(*p))
> +				p++;
> +		}
> +
>  		if (0 <= maxsplit && maxsplit <= count)
>  			end = NULL;
>  		else
>  			end = strpbrk(p, delim);
>  

In `append_one`, we would tell whether `end` is NULL. I somehow feel
strange why we need to do that in `append_one`. Should we just set `end`
to be `p + strlen(p)` when `end` is NULL. And then we could do rtrim
inside this function instead of `append_one` to avoid passing "flags" to
`append_one`.

> -		count += append_one(list, p, end, in_place);
> +		count += append_one(list, p, end, in_place, flags);
>  
>  		if (!end)
>  			return count;

Thanks,
Jialuo
