Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3490815FA73
	for <git@vger.kernel.org>; Fri, 10 May 2024 10:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715335235; cv=none; b=XOiluMmZxGYamzUFpSdfd1l0Ft8XDV9oT3sU3AncShVfSmW0qD8PUtcHO2nRsiwb7BXILENkmOXfxcSwzzVOFbD6b6DtfoKMCYZA4cZQEcseGDCdRf8sqHQxBSo6sbFncVi5wrVwtvfQi0DzdM5JmcIxoTn/HhO+v2tBqHN48PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715335235; c=relaxed/simple;
	bh=kX6B2nf6Mqz6mtMI7D+rz4U1wizoZiO56YGr4WIr/fs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SayTsO5eZA/Ur53I6aN1Mp4mWvpB9D+FJU6wtYKiKp4NAXtyJuGt2Polim7sdBmcCCWxwFQum1xxRf04UZWPhu1n08HADQMj5+smz6UMo2AvUbVHMnO6f9EbQ/Yi2n5MAr9sWu/y5TH2lHmhChJFK4mYGm07XmJzXakoKyC304c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERFff9sR; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERFff9sR"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41e82b78387so12578265e9.0
        for <git@vger.kernel.org>; Fri, 10 May 2024 03:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715335232; x=1715940032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=93KzrOcIi0HYEi9X8cB/+4KjzRDWptYuDOgtC8BZyaI=;
        b=ERFff9sRjTGORvG7W9g3jHAwgYIAHRPocBHLso9HmtHTZAq1of2FaGmacUabqLHZQs
         1tLRFgENHi121fDRbFDGU11KH/25lRtPcrPII7o1puPjhmNbYwd6Of0Qxr0KUV+FmuUi
         0vEpOox1HvinZoxVu9m1GWbiOf3/7LwRb9OcskfAdSPuc7qbsZztBVy9kMGhwXNhX326
         95CwskcSziLNt63KEEPb/uL/ev3jsHfbGa/vgxjvjGbcvMTpWnd70hb4p2buKsfOu6uY
         pmyb8V7uyQwoNuv4D3OVsTB2B55rTTu/1vX1jomLn6PynVE9ppTez4WpkMqd/uTBPAih
         41aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715335232; x=1715940032;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=93KzrOcIi0HYEi9X8cB/+4KjzRDWptYuDOgtC8BZyaI=;
        b=BQ+xzvAR/fnNtqdZR4YXy3grFrgLWFik+a9WJESbyzm2TDdDUyO5kXI0saWWOsIF+Y
         hSdQPH863ae6N1SaygtPWiK5lYvKz5tRcjzCb+May55eod+5Tcy3L2ZGAWfpvyaWgtfu
         SF3y9VRzQGGFfgtgXYPkaWtTpmx6Zro8Qh+rFWHB6JmnK9LKUE/ujPWthikIirxDDuJ6
         argHu/9P0KQRiXaVcw81hItUtKu4gxW6g+ICSZyZt5/4ZA42xtGpnQ+mSRkSfyxuHl/u
         dluwvRdxEosjiE4nbmWv7hk+LiUnr2kI+L95ndkGeDLT6jgUebISF8Lj7/eytyV2kh/v
         Y+mA==
X-Gm-Message-State: AOJu0YxIHMpSxMx79XsrLYrpSrpLyq1hq1psd98y41wDHoia1dslOuLD
	41YKyN2lF2WvScz0U9vDSR3PRHq8c5kx3b/TQS3HhCIBVFvbud26F4fhtk7D
X-Google-Smtp-Source: AGHT+IF1V448CktjZJQ6txoOC1euWoGRRs/85aRRw/76kKDOuMkmq0bKHFgP40hIV//C+l0YRyfa/g==
X-Received: by 2002:a05:600c:1383:b0:41c:2992:a3bd with SMTP id 5b1f17b1804b1-41feac5a45fmr16670295e9.27.1715335232401;
        Fri, 10 May 2024 03:00:32 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1? ([2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccee92bcsm57094105e9.36.2024.05.10.03.00.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 03:00:32 -0700 (PDT)
Message-ID: <9b42e684-32e0-4372-8da6-40f9b708b6ca@gmail.com>
Date: Fri, 10 May 2024 11:00:31 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: git-cherry-pick(1) -- path
To: Alejandro Colomar <alx@kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <e5pklmijfpbsnl2trj4n4czam7n7i37gx7w56med2pfaf6q3yx@wizseio2ickk>
 <xmqqv83mqxg3.fsf@gitster.g>
 <kk244kap6lhuvtfot55u4yb5k5eddwlzl4izlzqhe4pdj52cx7@slghmpvdswkt>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <kk244kap6lhuvtfot55u4yb5k5eddwlzl4izlzqhe4pdj52cx7@slghmpvdswkt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alex and Junio

On 10/05/2024 10:05, Alejandro Colomar wrote:
> Hi Junio,
> 
> On Thu, May 09, 2024 at 06:15:24PM GMT, Junio C Hamano wrote:
>> Alejandro Colomar <alx@kernel.org> writes:
>>
>>> I'd be interested in being able to partially cherry-pick commits, based
>>> on a path filter (similar to how many other git(1) commands behave with
>>> -- path).
>>>
>>> Do you have any opinions on that?
I'd be happy to see a patch that adds that (I sometimes find myself 
wishing "git cherry-pick" had a "--patch" option to do something similar 
but that's a bit of a tangent here)

>>      $ git format-patch --stdout -1 $ThatCommit -- $ThisPath |
>>        git am -3
> 
> Hmmm, I hadn't thought of that; very interesting!
> 
> Although I have some concerns with git-am(1); basically that it's almost
> clueless when there's a conflict.

"git am -3" should be fine here as you're guaranteed to have the 
necessary blobs available to create conflicts - this is what "git rebase 
--apply" does.

> If I find some time, I'll check if I can program that (although it would
> be the first time I do some contribution like that to git(1), so I may
> need some help).  :-)

As far as the implementation goes I haven't thought too deeply but I 
suspect we'd want to create a couple of trees based on the commit we 
want to cherry-pick and its parent filtered by the pathspec and use 
those in the tree-way merge with HEAD.

Best Wishes

Phillip
