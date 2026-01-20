Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4A543E9F4
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 15:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768921306; cv=none; b=F3VUa6Ig2VFC8PZqZWx2gzxiPgtE0/gHkHZUhrXhVlfeXHhZBWYBgT61S4XIe9wXo1Djm2rqBEn2KnW1sUyfriGzu8S9vhHx+LmlnAftMvzS6YMW3iXJFZT4sWov7hjXalB19ltfDdevFHcVGh9OgchfP+vxbR560GvXz+YBw1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768921306; c=relaxed/simple;
	bh=4hUTRR9UjKRXU8SY3/mkxUKHSKMCC72Xxknx1+h87gQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gKThFZwPyzJD3p4hremQUKkChUFE775sBbI0wz/FMSsYGM9oFG+OGR0zHf5VPTEKBRTxxmN4IQMy8Xh9JoCZ+Wbc1I5mvZ6M1PddBL5nb7yDPrzpIzoPbUG+Ox3mDJv6KmSX/7Jtvdq3G3HtJ5aee8Z48+sKuXcN/UJWBFyTY4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IaeI4u+c; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaeI4u+c"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4801d1daf53so38890685e9.2
        for <git@vger.kernel.org>; Tue, 20 Jan 2026 07:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768921303; x=1769526103; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wgRJjUwDDilHyp7WRgMRtDVCPfcg1we+otfZIMWTyFQ=;
        b=IaeI4u+cmt3irZCqEZd7KQTKACvsZ8t8LFaGGy0lXcYzLvGAzHd1i44LgRfs2a+dL8
         XkmvzxmBEHT2FFC3mkQ+qFJ06nhkZPeiI7u3BgIyMKqF27RCFwHu4O15EWUW+NPX7TI0
         GzK+uWMyJyHADCocwJkcuc4ZSu8TJP9N8kJKM7f9QNsxWPPjMssm6vNuIJ4jXWQK7A5Q
         0RYTzTx692Pi9n+DYgSUtyzmuRIFylhD8T11lM+iDQzrQ9c6VwovBa66etLiVwre1O6D
         hhHQJDmJAJzToRezYvjGSdDIbdrZxfmfZgky7PaGGyv38iBmt2K8AsNN6N+IW/cBV5ft
         SMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768921303; x=1769526103;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgRJjUwDDilHyp7WRgMRtDVCPfcg1we+otfZIMWTyFQ=;
        b=BTRXUNnXwNEELEQ6UK6G+PUGWv6u5DlKDAY/vImkkp0wWVzXfsTzs4Z/KzydzOUTDM
         CVDhlSeSMB+IFgqxkL+zuZAjHYzbwyugDW5va8fTfIeLLuQR3EjVqPZB9vcuVkJ7km6j
         S/GxeUtEHumL4qVMcKURefU3MS2vfOWPNgCz+uZZPcMSvRM8HSuh4x+kD8se/iFiMzGe
         yqFAV9bNO7xmnImTYszfZs1RO/686FvEUvgbGqVV0pqStlZtPaOmt9PxmJKLOdZgUGC9
         JMk1M4XBrw+6oIFSWR75nskyuhu5cwHxXSkDO+lvcvdjbBSphMGVvyQHuC5Sqj3W3YAg
         QsrA==
X-Forwarded-Encrypted: i=1; AJvYcCWawyleyHIHZw0A/bEsM5xHYbRzziIONlFKkCP8jANnGIK9cxs3U160cuE4agGzCRglbkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnH0w29r1TdrxVZ/iNJRsSWRuL3jlZdkvb2WKXkGhmkBqR/J5p
	n/Un7ck11n9hWzY6E0Q2iywMeAi2HmagbTwbbjN9hSzeNFxf6vSEK/VY
X-Gm-Gg: AY/fxX6NZTrzCtTyWmJMxRbzG6Sh8p6EeHPa9UF5iWXabrKutGuvR8ABSht2KTi1qac
	dbcsP30k5AqTqvnt0+4TDEvORk1GTJ1AnWOrDUL9N/cytNA1AgX1upc6xGj9VYE96ezHqQ2oERh
	jOYlQ0IJmS2gqK7wOz8sOn5fTy4/7vKgDm/Ot4tGnnuVSL1qGmDXQiB2KPkzLMGwsEpkde41Y+5
	mHV5AAclH4tfwcbQ1TXYeW0H4uKFRdnyuk6OkW3Pb/rFqzPErzVFVGvwjzBOhc29TPvgcz31DPi
	qUwMLww5skX2dMVJtF6hHKDgdpINUO1XnH99I7WwUtJWDfZxjVn9zJcsI0Ssdpqpe1ciBTUKwhW
	7b2VHrMD9OfgqWnzby3B6p3MXs0DiW1cshiCxQv/RuXqHISEp2DjtRv2dDm8eYEWgM4E/nVVX8t
	ycMluXIPnmpQ6XGHB2OUGU6tdrTGPaK8zJJHmhfSb/Z41fcMYBWaaeRTIuUMulNqtRFNKSSlZBa
	TuW
X-Received: by 2002:a05:600c:c4a4:b0:477:7bca:8b2b with SMTP id 5b1f17b1804b1-4801e2fef34mr218628835e9.15.1768921301534;
        Tue, 20 Jan 2026 07:01:41 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801fe65883sm103614025e9.15.2026.01.20.07.01.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 07:01:40 -0800 (PST)
Message-ID: <1c46f551-0040-481e-9476-bc1b85f92636@gmail.com>
Date: Tue, 20 Jan 2026 15:01:39 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 02/10] xdiff: make classic diff explicit by creating
 xdl_do_classic_diff()
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
 <9bd01bce9f0763d9dcc962ff94fcda36346bafc4.1767379944.git.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <9bd01bce9f0763d9dcc962ff94fcda36346bafc4.1767379944.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/01/2026 18:52, Ezekiel Newren via GitGitGadget wrote:
> From: Ezekiel Newren <ezekielnewren@gmail.com>
> 
> Later patches will prepare xdl_cleanup_records() to be moved into xdiffi.c
> since only the classic diff uses that function.

I assume that's to make it easier to covert the myers implementation to 
rust without affecting the rest of the code? If so it would be nice to 
say that.

> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>

> +int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
> +		xdfenv_t *xe) {
> +	int res;
> +
> +	if (xdl_prepare_env(mf1, mf2, xpp, xe) < 0)
> +		return -1;
> +
> +	if (XDF_DIFF_ALG(xpp->flags) == XDF_PATIENCE_DIFF) {
> +		res = xdl_do_patience_diff(xpp, xe);
> +		goto out;
> +	}
> +
> +	if (XDF_DIFF_ALG(xpp->flags) == XDF_HISTOGRAM_DIFF) {
> +		res = xdl_do_histogram_diff(xpp, xe);
> +		goto out;
> +	}
> +
> +	res = xdl_do_classic_diff(xe, xpp->flags);

This might be clearer that we're calling only one of the three functions 
if we wrote this as

	if (XDF_DIFF_ALG(xpp->flags) == XDIF_PATIENCE_DIFF)
		res = xdl_do_patience_diff(xpp, xe);
	else if (XDF_DIFF_ALG(xpp->flags) == XDF_HISTOGRAM_DIFF)
		res = xdl_do_histogram_diff(xpp, xe);
	else
		res = xdl_do_classic_diff(xe, xpp->flags);

and then we can drop the out: label

Thanks

Phillip

>    out:
>   	if (res < 0)
>   		xdl_free_env(xe);
> diff --git a/xdiff/xdiffi.h b/xdiff/xdiffi.h
> index 49e52c67f9..8bf4c20373 100644
> --- a/xdiff/xdiffi.h
> +++ b/xdiff/xdiffi.h
> @@ -42,6 +42,7 @@ typedef struct s_xdchange {
>   int xdl_recs_cmp(xdfile_t *xdf1, long off1, long lim1,
>   		 xdfile_t *xdf2, long off2, long lim2,
>   		 long *kvdf, long *kvdb, int need_min, xdalgoenv_t *xenv);
> +int xdl_do_classic_diff(xdfenv_t *xe, uint64_t flags);
>   int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
>   		xdfenv_t *xe);
>   int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags);

