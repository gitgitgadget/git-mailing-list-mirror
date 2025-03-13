Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F263E47B
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 02:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741834651; cv=none; b=Zxa5kxiViL0eaHN751v3+gIoQLoWOgnV1MMnqIWwmyNtmBSqhCcC7WnQnpJSzJBoFey8trGmHdXKoK3OqDtu8JSVKCtFDrCPqAQc62do7wMuyqjocgHk61qcEaDLZx96sHx7M0I1s5we6F9iU9NuFd6rc84ae+OK0t8mEVsdzFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741834651; c=relaxed/simple;
	bh=w5ld+1RS4VijpRhcXk9s3yYexRnZ9ghBt1lRZPxfZ5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lg/9l5haz6WLwfp4PJwlXUnwvP2shoPg0t28PoEWhNxMRtBGJUTA4q5kosLznt7T0gFlRYd0y6iJeKF0ja9NY4qklCFS/ucfMdsvdTspgJyFCvmBgHcpUedaV6T17S4GdtHcyVBzjK7629XM4xmA77M+ZTQ6YIOKiICV8W5sX80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Em3htjSA; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Em3htjSA"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22113560c57so9081485ad.2
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 19:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741834649; x=1742439449; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dEzXYxv1mmqzDl9nkgRe05pWYo+NExgrIRQ2hJeMTd4=;
        b=Em3htjSAXlC7+Do2gxcXQYNqfoj3C9JwB45S6U9aNKc46A+SnJSUFRG1iylE7f8jLZ
         jjR+lO7U9b6QErRf79HCj1+NQ1FLhXrtnjHTi5Q1dJSMPZzZ2LO/4L4onkvmC2LjaqwW
         NmkcV0gF4iAjc6Q8F1P2l0J+mNSKbSvnswp4EtmG4xfDaEkVTi07StdeEBuzzRYp5jIR
         54oT6ugr8bon3Tg1yVlz+Nrf7EGUhErMeFV5k66+Rkhjji/dbJjbve2Lyrmh+UmOcn1+
         4rJCCVO8yh70sDzXPuGsFws6npLWDbKRvj5gU2iU8higKxRRR/ZEnSZW+M+iCjKs9iRR
         viTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741834649; x=1742439449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEzXYxv1mmqzDl9nkgRe05pWYo+NExgrIRQ2hJeMTd4=;
        b=eI+g+wjExf6DgalSwZ+h/54r/ao/ZUxlMOuiPE4lThGs9wzIcxdGOjEmLcjabI7OTK
         nWN3FVpRN6g/DzqkeIssx7Urxjcm+2ai/D0QcKWksjkorK2j4L6/hS0HZp2H83BbFFRT
         Re+dhWqdekh1HV4F7OgAhDfn9U6RDjMp2pxukx9tbMxhtQOS4KCAuPTPEQUgrUZO1AKJ
         VG7YOlL8jspyveTRJiSEnbJF3zshh4Nuc2mpVKYHtEYV4gOj0/zIP4sPDcu3ivJ8ROh5
         FR8caw3pdNUrPKzvsYL3qcK5/q/P6nwYdqlUkdfCUIs9QTOng282lI8r2wINxCQBmxPH
         QXbw==
X-Gm-Message-State: AOJu0Yybjayl6/zTRcf2rsLmg8ffbM+pHG/t32LFcFCVO+cBhrq/KWJw
	Q15Apsu0t+UjS5Uvkh0L6pgIlnRtVVaChv3SWWMgsdzLeJ2/qcPd
X-Gm-Gg: ASbGncsq6XW2VkfBqtkgloPMw3hMqN4U3eLqgIb1oNnhecJf3wuotIL37i0yyDSEN8U
	xCQWeYVzToAQJGk4bCu1uHXNfdr3IrspqUJ+3SrHDtdYR7lMbjQkfJqgnzgLe2caDP/Fm8IUIqW
	8s1fMX8x8g2RjR6RNyRZVtdQI2VeisVVlsbNbkpP3jIeMGBcbca1HgBOlM8K2jnTXZYiYakyx0P
	cGE0bgl1IKtWRFtteg5tydjCV3og7/1bcCyeAvLOqnYL70ef4onAVq7jggkis7SaKBIbB14c1/M
	eX1qEOioGTeZt36OWcu6IKq7jb6NTNxs5OOjUUFD
X-Google-Smtp-Source: AGHT+IHjLwX/evqEjXg4ayYqf0PYqU8i0f0wf9MNXXF6mSDW285hTAySvVzFWQ5N+YXeI/zF83qy4A==
X-Received: by 2002:a17:903:8c6:b0:21f:35fd:1b7b with SMTP id d9443c01a7336-22428ad49f1mr354101705ad.50.1741834649379;
        Wed, 12 Mar 2025 19:57:29 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-225c6bbcdd2sm2923335ad.172.2025.03.12.19.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 19:57:28 -0700 (PDT)
Date: Thu, 13 Mar 2025 10:57:40 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v6 00/16] refs: batch refname availability checks
Message-ID: <Z9JJpJkz66VVgDLy@ArchLinux>
References: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
 <20250312-pks-update-ref-optimization-v6-0-f778e0414f55@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312-pks-update-ref-optimization-v6-0-f778e0414f55@pks.im>

On Wed, Mar 12, 2025 at 04:56:06PM +0100, Patrick Steinhardt wrote:
> Changes in v6:
>   - Use `for_each_string_list()` instead of manually iterating through
>     the string list.
>   - Stop sorting refs passed to `refs_verify_refnames_available()`.
>   - Revive a comment that has been deleted during one of the
>     refactorings.
>   - Link to v5: https://lore.kernel.org/r/20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im
> 
> Thanks!
> 
> Patrick

The range-diff looks good to me. Thanks for your efforts.

Thanks,
Jialuo
