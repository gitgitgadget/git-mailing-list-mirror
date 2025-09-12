Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19579313275
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757691587; cv=none; b=qULYoCdtKM7xRvfvWo577H04t6af3y8+nBAf/d32SNbU6pZEhqaAzUe9WH5IiK9ZZKlVtvAEeL4J7DTaogn8G7LhdiNvlz8SPg8N3FtuUw+ayr9eTs+wIQwvlC0vAwkflZpqfMgVXnRWBIaH8pDlBl53y/WuxCvq51JUm+X8jHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757691587; c=relaxed/simple;
	bh=L1ldzkGtCV4BMmKi4k3B2FN/ZU+iHi5NF1JREAbnHkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Xdgz81RNeH5wnm7iSKzrLvggKrYtYL6dlia4BjI+h6yvs28CwGc0+j3uEjWf16HiRdKGKcoLKWb6ovdkMFwuoPWAO0pO1jdAognjAtAEeKWWz9GdbmiGbTYrmM59pNKu03EmNmWNa5NDqGiJSMdWSqxRUccByZDEty7sh4e/C8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbF3TH5F; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbF3TH5F"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-770db3810a7so1150946d6.0
        for <git@vger.kernel.org>; Fri, 12 Sep 2025 08:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757691585; x=1758296385; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G2NOnPMyu1a7eyIW1aJjucovnx6g2y0nyZmprb49M7I=;
        b=VbF3TH5FZ+f3EhgeZolNzhC3nI1as+KDFVMMdfcdamfHjO9AwAl2PI4BxH916hcso+
         pS3CW2piLk9mKfyCrUPis0kNvUF4sChLEhqDkwoONQZq02lzWh7NEHd0Un7QUaZYvwYF
         KMHK5rF2XdDklRT4iejYaYPK92L7oA5+HlLHZprxc9bdLzI4huumduOrGm5O+i7DBfcT
         jO92M7mI/utkz8JYp8dHZCESug2scIWUQjn86o+wllTSGfmlaisl4XiPWT2viGeTYy1H
         v5A055ZjqFN/eEyBH/NYOhl+Q/AICC7K4XymHdXKl9/uDm+0vvpBX/zwoiXb+qyX8G2f
         Rb2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757691585; x=1758296385;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G2NOnPMyu1a7eyIW1aJjucovnx6g2y0nyZmprb49M7I=;
        b=rmRSHxfNaRBSPT692z+ZDyj1gxjess2emppY8bGtF3dPvFQ1TjwWWKYKEDlQhPiMGT
         enDxWNvOugdJHStRHqpVKPwi4q+8qd0vn513wildDyNQzcyj6vpnF2JnFTeXkFT8nyWV
         Sicf+sd7Se4GUvvAL6mRX9ohm4A2KqNdVgSyhu3/NjcKot2mNd3sfGDIDDc4Ul3YIF8Z
         u751DS9mDpUI4r/vJpPVs+FvaAMmAK7ul4Gtdc9sqQ+KdGTw3E+mCwGKHfz9qvbIUIrB
         TdbgCjlze9RCHQrmQ0r2bICfERN4R+SU7jvNFJe/3nYopIIzQ723VN6q9s1uEA3SAWQW
         BgLw==
X-Forwarded-Encrypted: i=1; AJvYcCV0DlQi3QrR9ewip1/ZFl5ZkGOPWQv7BDsuDq8zVeM5J1r0NCtC7b6ZtgXiDWBBSFe1QTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMR2Lgt1YTuAXI3diIhbGUEUDf9dh71TvuXbCTk/v1/pf3gpSX
	f8Cu75R/UI7oPrmLOkT82lzQhNeu2kwwRSKKU3WXF/g+YrtG3EsTAN2rpqNCdaXU
X-Gm-Gg: ASbGncudWcj+KY2jdcWUeAVkPtfB9Kceu0BEF5bSpzB7AVYqbGns3aqxR09BwGQkNIP
	W3Jz9Myjj4iGZMHnndDPUuUO5EbWZn0Wfb6qE120e4bWQTnJMJOT0CeXp44bsniRFn64dID+J3R
	s/u+AcThSH2m0bmHMm1sZb7ZYIeaWkILvKEwInPZJt3kj/3Va7DKkNqm7olaK2/MeVCaBpiMJyi
	v0n2c31MV1mYJfaCzWOs20EjnYD8AIoOKiZOP+LRJxG8LOHCZ5p9sPscxykCMWJevY3ZSb4UQRi
	GBvAJXm4m75c4EodMq15uB7MNznnxJjRIJKyzM7W/PB9W7XvIHkgw/I3l6hhBuYG1a5Fe4PDgUb
	+wt+f/X1i65VaWFZ5sxsR8HtKyEdG6anqkhv2O2UD5AgZQqXfXEgZbks6evU0EfCUGkBOwfW3NQ
	c6
X-Google-Smtp-Source: AGHT+IHWcFVoLWzXuZMuli9onVqyW+13z9jd9PObd2/b4zjVykGeg5dxV75nFyjV/HXORFOkEHCSXg==
X-Received: by 2002:a05:6214:20a5:b0:72a:d613:317e with SMTP id 6a1803df08f44-767c46cdaf2mr43637586d6.53.1757691584513;
        Fri, 12 Sep 2025 08:39:44 -0700 (PDT)
Received: from ?IPV6:2606:6d00:177:b6ad:6c36:549b:bb20:51e3? ([2606:6d00:177:b6ad:6c36:549b:bb20:51e3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-763b642312csm28917596d6.24.2025.09.12.08.39.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 08:39:43 -0700 (PDT)
Message-ID: <45640ca0-b3c5-4627-b41a-0b58ff559d2b@gmail.com>
Date: Fri, 12 Sep 2025 11:39:41 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DISCUSS] validation on git config user.email
To: usharerose <ushareroses@gmail.com>, git@vger.kernel.org
References: <CAJKmQvf-sLxowLJLitvqDmyL1BXXDK+anDE2jaBSEabApMNVoQ@mail.gmail.com>
Content-Language: en-US, fr
From: Thomas Guyot <tguyot@gmail.com>
Autocrypt: addr=tguyot@gmail.com; keydata=
 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
In-Reply-To: <CAJKmQvf-sLxowLJLitvqDmyL1BXXDK+anDE2jaBSEabApMNVoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-09-12 00:13, usharerose wrote:
> 
> I'm interested in understanding the design philosophy or historical
> reasons behind this 'lack' of validation.
> 

Hi usharerose,

To add to the other valid responses, email is something that can be 
validated by hooks server-side to enforce not only proper formatting but 
also valid users are being used, ex. validating against an LDAP directory.

This is much better that validating it at the command level (although 
IIRC git-comit does warn about possibly unset/invalid email addresses). 
In addition, unless git starts enforcing stricter rules on the commit 
message format (which would be a breaking change), nothing else can 
prevent someone from constructing commits with invalid emails, so checks 
by git-commit alone can't be strictly enforceable.

Furthermore, imported commits from other SCMs may have odd user 
name/email and it may be desirable to keep then in their original 
formats rather than turning them into fake email addresses.

Regards,

--
Thomas
