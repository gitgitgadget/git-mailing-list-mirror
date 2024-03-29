Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7ECB225A8
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 19:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711739795; cv=none; b=Ii0kWc15/2vBhxmO7YObROCaDejI2Yvn1fpK2AuawHTWIo2/qmLZLb+NfZX+WUl0QYcS66GEHI+QV7goUtNF3nlXnVrJPsqpEhkcJhufs09PRz7lEEEUBT/j/sRTVadGpbng14A/Wf40fC8GkCxMApN01N0ukS31o9HD59G0tzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711739795; c=relaxed/simple;
	bh=700GH3in/fq1VSLnsMlXW/pi8oH99CvcUjWaEhBCeoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fmCR6/ohTpOJY3ZvUWWsoZBlSSDn/IuV0NPXcvxJzR8d2PGJNYvpjw7HGwp7sUwO6tyUS3ko6liGaKKh5o5poDx9AOtPnus07tReWd9vcAjlO7pph1S3l9ZbKIVxjRRuK9Ws0IGOIxdbnWIUhPsWGCs8mRVKjS1Ey1ctbG/ReHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTMeNius; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTMeNius"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-415573263bfso530235e9.0
        for <git@vger.kernel.org>; Fri, 29 Mar 2024 12:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711739792; x=1712344592; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2ouAB85YA6iakzSS+8JadfgzqvQ96pHXEvuIvYvLzMo=;
        b=WTMeNiusx+t/+hoKO9HZ59LfI2u0nytNfGROuiIEhZcgT5+zZg9JpQzVo7RTW60yw9
         IIBm/IoLDeTTcloSCJvhkPtwqQz2FjCEM/VTvocIzAN02tuRUSQZYpRIVOeqoTtRErep
         EwUqUlHCINeRljRe1ET8Lek4vj72WZ/fhJYBCdhwoLJ2NhXbgSGQ6M5Ev6Zb4Y/rBy33
         Ve7gdTt4uBE+wMrZQ02x5a8tHuA83NwxNLq1XAXveskzSa0L7FnsDLxwdUwewyDu/Oe/
         CwAbedmQsYJK3k1NWgjwMzjYlcjDMGxqLvm3gIhLVFemJP7g+Um8t/gZDZrp6+l4pXrN
         iDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711739792; x=1712344592;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ouAB85YA6iakzSS+8JadfgzqvQ96pHXEvuIvYvLzMo=;
        b=UABwOrp4fo6XCDOgVCu44Ku8IebcqpnmCdAqsMLg3EVjgQv/sCYfuB9VWbuXxkIe8T
         sfR2F72YuDIcnml3kjuzVdDN00FeLReyZo99ZxhrAvLMq+gKYqB0K03x5m4iNGha0kn5
         +n+8Boid4nNw4IKW/kjly4AoZ0c4eCLwpiAN7axgXozq/JggPZDs5ZVTXzr329QwViIA
         PP9ctWee9xk+dFiIv/AHqrXMJnEjC/QFCTkv17Gxp6XANV6V0J937K6NQqsa3sQfcCFS
         xiviPegCe/FEqqYSW+TJAW3q4KJypul11/hxmwtjzAPzzmGKmV/9WZJeiM4zdp7TsGTT
         e+hQ==
X-Gm-Message-State: AOJu0YxZXssS6zazWpUXvTwNQb11ecgzW9SIVE/+i/E8yzpyx3TlldGd
	/MHeNHoElSTWdOfAanipkFP1wpWIfanB5CEnZxkSRS2Bnw41ROF9sWeUTgky
X-Google-Smtp-Source: AGHT+IGL7tIVFH21vXnjSrmFQG8oul/fyl7tHOOB3zfygPdtsx0ZD5qWtq3nyd2grUtLMP/4UsbzGQ==
X-Received: by 2002:a05:600c:45c7:b0:414:204:df50 with SMTP id s7-20020a05600c45c700b004140204df50mr2254970wmo.4.1711739791946;
        Fri, 29 Mar 2024 12:16:31 -0700 (PDT)
Received: from gmail.com (118.red-88-14-46.dynamicip.rima-tde.net. [88.14.46.118])
        by smtp.gmail.com with ESMTPSA id q15-20020a7bce8f000000b0041547cdfbc7sm3019150wmj.0.2024.03.29.12.16.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 12:16:31 -0700 (PDT)
Message-ID: <1c3bc5ba-0093-4a34-ade2-d6762e9754b3@gmail.com>
Date: Fri, 29 Mar 2024 20:16:27 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] add: use advise_if_enabled
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>
References: <06c9b422-b22e-4310-ad5b-1686616ab860@gmail.com>
 <xmqq1q7t0wxp.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <xmqq1q7t0wxp.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, Mar 29, 2024 at 10:28:34AM -0700, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
> > This series is a simple change, in builtin/add.c, from:
> >
> > 	if (advice_enabled(XXX))
> > 		advise(MMM)
> 
> I wonder if a coccinelle rule can automatically identify and rewrite
> these ...
> 
> >
> > to the newer:
> >
> > 	advise_if_enabled(XXX, MMM)
> 
> ... to this form automatically.

I don't have a solid opinion on that but, after a cursory review, I have
doubts a simple rule could catch enough cases to make it worth the
effort.

And, let's hope that the new code will utilize the new API for its
convenience.
