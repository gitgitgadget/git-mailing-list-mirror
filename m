Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1051B2F7464
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 11:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761046381; cv=none; b=iT9e2z31hc2znNAkDsrkw9ND93Cmnftg+l+BKzParWfZSPwnNqXUwhjLdJF4+dqwKk720ZaPSfWWXRnLi0iPNc3ToXzMQROaHZF2D7n9uM4R/V65TbhsPept4hqh7MAyny52iFWB3l6vfdpsXO2JytgmUCX+/R0rR+0YagpT4NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761046381; c=relaxed/simple;
	bh=Eqagv63yiGg0J9lRQkQc9cKhcMFuiaYi7zGGdp+dYiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MbytVQufHgKyYhaHwHnuvJqMylQFsgLQPZG+rpHT842lk9vfG1QSFahnbtQH/ZUnGyXMey3Uh76WB/GHly98ZuhtwJEeAloCC3kOvBbRCg9xaKzwUxQXS0dsqzputZwiF1NG9ULErMfLjCqrW4bJ1AF1ThAD2Z2WIKtgRu7ZrWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8eIMRYU; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8eIMRYU"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47106fc51faso64884645e9.0
        for <git@vger.kernel.org>; Tue, 21 Oct 2025 04:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761046378; x=1761651178; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GIWtB4GyltQyXuTUJy4zdwY4snyawjFTXwI1Q0tebDs=;
        b=a8eIMRYUiowez85iaXFxxoHGjU60QDztYfJ2saXtNCNcpp1hf6duAPInPGg/q3Kdrc
         Jv8fhvpeJrdfYWPO7ZwW8ZV8qpww0Jz51DOpTZ3fTR1z1ZhxVlYhAqcWn3iyjBRgVZUJ
         ocOTmgDOi9AOEOppYl1Z9KrIE5S3HMjekYDA8QRizx23GcFhyfcDvQV2VUiDimbNl5wF
         Xg8/CL6AcCmzvPHj0xMcsGIqtADOnhHGHngwqNDhULYibZvn2IxQtrhLBRqTHkbFUmXm
         x1Pxe9mMyvD9Dl/ezcguj8KI1piJrH9gzXpPzlTc9Rk4Gue2RQIHJBnlnNSW+N2+oJod
         jJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761046378; x=1761651178;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GIWtB4GyltQyXuTUJy4zdwY4snyawjFTXwI1Q0tebDs=;
        b=DiD5NCbtXrgl8WSHqAUASeYGPvH19vOiFvIWvc+RiRzVecTrpYW7n6UM0RFKy8bsIH
         cI69EnYrl51d4d+y/qkLbSd35zLjXGce42fxas5ArU5v1ZzXxfI07+Pegpf4ceSF5VAD
         m/HP3wpMWGoPuUal9lSRFH0L8zlwRJPJx8dyFuA3KA2+bj+UCXho5QD5AOr56KNmF8Il
         HyMUi/F6selePwNXgHY3v3XmKIruNywqLv7LY0PajVkG7URZfxuqflNrcEIQV5rg3DZ/
         cN18uKzptvaNm2Iz2kVZhSH6VEQv+PZPAD7wFPD/JoS4i1x6NUQOaIQ6Xz9vuPQ1p8su
         iePA==
X-Forwarded-Encrypted: i=1; AJvYcCXRctJxZzH6xS5Kh6GFRr8bkb9Z+lHV+W8/GTG+nZb3B3hB8KXx4CeApJT2CNAePCkHey0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpDdZPy0jr8tRoDCbvYfKjTB9AYWEpNGAX5CRQ7BX0w9PTOyOB
	ktVvXLjYefQ+KcXVGNoKsn8WycKkQJTxZoqvbme6yJSMiMwW2fHIRzER
X-Gm-Gg: ASbGncvtlWtYtGfOlt6mBU7aw8cpSBmCF99TXB9NIkv6Mou5jMhUa8y/KfJ+PfPZFHj
	YDsCSDKu4iGiluGFNl64YgvnOTyoqthwyZCQSo67amVpGbep4dadQhwLol/KFcVkf9yomApmyES
	ggEkuktO1L+PXeXoGW0ZYNL00fguLvTSiWXLsjAvY7oyhUp6Qs0YxjmlY+sQYQGwaq5WbWsWtdA
	ko1wt5ZsxLgzppsEW7hQ085PEjslfTG/dZ4Onm8HSALRsb4M/eVZ/N7x09x+jNZZA2JkIs5R/z1
	RUZxvpCWGCDQ/Jy2wTe74O9UUDar5k9CnNXz1Ypv/OY7wArjnEH2MedyYTP+yxSk0T0wvNN5O3F
	/qRPcXdyRZTqWwsXiX+uEmc5UASvc+Fdl33GZNR8OD6k812oVWB0tcJ/aJk8YX2ENXUqtED6R+q
	PGi+vai6IDqz3AxHRK+1SqEVG51bYapV4rmhMSOHudOHoHI3wqHbjg
X-Google-Smtp-Source: AGHT+IHl5AbvBkKVSIW/a+eUypAeHemssBhpdFw8+/Ne3dw+RMtHYgtpGt/qRPVd3mdvk0aoV/e2ZA==
X-Received: by 2002:a05:6000:178e:b0:3ec:2529:b4e5 with SMTP id ffacd0b85a97d-42704d966c5mr12863953f8f.38.1761046378100;
        Tue, 21 Oct 2025 04:32:58 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ce3e2sm19958827f8f.47.2025.10.21.04.32.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 04:32:57 -0700 (PDT)
Message-ID: <9eafee4d-ea94-4382-ada0-58000d229d2e@gmail.com>
Date: Tue, 21 Oct 2025 12:32:55 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/9] xdiff: use ssize_t for dstart/dend, make them last in
 xdfile_t
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
 <1fa9a7d7d1c309f2f651da351ba7bc0b36272d91.1760563101.git.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <1fa9a7d7d1c309f2f651da351ba7bc0b36272d91.1760563101.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/10/2025 22:18, Ezekiel Newren via GitGitGadget wrote:
> From: Ezekiel Newren <ezekielnewren@gmail.com>
> 
> ssize_t is appropriate for dstart and dend because they both describe
> positive or negative offsets relative to a pointer.

Isn't ptrdiff_t the appropriate type for an offset to a pointer? ssize_t 
is not guaranteed to be the same width as size_t (this has caused 
problems in the past[1]) and is only defined by POSIX, not the C standard.

Thanks

Phillip

[1] https://lore.kernel.org/git/loom.20150207T174514-727@post.gmane.org/

> A future patch will move these fields to a different struct. Moving
> them to the end of xdfile_t now, means the field order of xdfile_t will
> be disturbed less.
> 
> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---
>   xdiff/xtypes.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
> index f145abba3e..3514bb1684 100644
> --- a/xdiff/xtypes.h
> +++ b/xdiff/xtypes.h
> @@ -47,10 +47,10 @@ typedef struct s_xrecord {
>   typedef struct s_xdfile {
>   	xrecord_t *recs;
>   	long nrec;
> -	long dstart, dend;
>   	bool *changed;
>   	long *rindex;
>   	long nreff;
> +	ssize_t dstart, dend;
>   } xdfile_t;
>   
>   typedef struct s_xdfenv {

