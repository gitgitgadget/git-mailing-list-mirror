Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B323F789C
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 16:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773332822; cv=none; b=WsnOI74J556NcyT5eJeCqqe9S5kao69HHmbRyoJz19koSpN1/PtBk14e9YLdI2tj94SmMh133kArMynLgiAojzz5vXTkLgga6XI4RwFAdec+tOOOO1PowPmlG8rKHfD9d3VPyXgRuOOew4sbUdmQSirHY19RS9q1mNq8dqWwWQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773332822; c=relaxed/simple;
	bh=XSH4iavp5mGEe6qsnQgzMBgfouevRlzQOw2Ou3hEatI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s3m2yUO6/evWMcRMTs3uyxKV4NskuQkB7olqx/kv0nT7n0EE6wS4lEZuWBbJ2YwTA1yDPMAlvh4C6qiZZ8V++y64X+FS6/9mi7IOaNa0qpVPpF5HHbzniPIlU0T7VUv+WFw0ghmXNa0//8tNsPb2Obtv4Fl659+YNoSXrafgS1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2wpmJ1r; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2wpmJ1r"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-38a3225d59fso7813051fa.0
        for <git@vger.kernel.org>; Thu, 12 Mar 2026 09:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773332819; x=1773937619; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Jos0f4qQ2NEQborSRkM+b8nJN420kKxDvmfUJ9mN1x8=;
        b=a2wpmJ1rHZ92nuwupfOh9LQFaoay3GZOtI3pagu0d7b3oLlZkzTm2g2xbS/XjRBuaN
         cu+OXEsOLWNPSySWm5N+d4ze1Y/TTbzLXRIkIO8y0KmDZL1hKF3eBuTgLqzhKX9sYzrA
         0zltN9pSta6kBWzOvV7Ul3ZgAKwM2v5l/7lKwg2zZzFo5S9RjnbrW+QLiryMvaJHlnxy
         VHFYIRO3zcy6KWpa8nxtrnJ44h7yq810WLiS0Q+wUGwLn6oHvuiCaJ9H/1CDgCLJrJm0
         0fgYA4GXYIaci4A1Y6LFB2yg/o+0DTJmqCDpZUcXefb0PjVLCSHeQtoFMtJPPKxpVOLD
         gO7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773332819; x=1773937619;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jos0f4qQ2NEQborSRkM+b8nJN420kKxDvmfUJ9mN1x8=;
        b=a+wiDPY92PeXKCPVDEFLj5qQ1F16Oi76PaOvQbPD+oSFwWiVqtsd/SMKMRO4gyVtfS
         XioSsS8ZgeENoCOyurEXodDoRW6a19czOVOWY7W3JE8M3gaF/CsYI882BfWFJgisAEDF
         arNqwPkDUxQIaA+XgZeF4MGtoiVJEFbN5NI9Ao8ELxOj/ykm/tm/RNmlbt1HANfwLVZO
         XjvRFVShJe6AhHVfJIzL6pyTw6zQT5SWwrisvJ7zOMzdsLsU1tdhWmAoFzkCvM25emSc
         eGAFKcH+nk/ZUi2o1YcO/TUMA4hjH7HKDLwEKgDh6uuVFZbn70n/j2phvNoL9nJIgrwh
         ZEZA==
X-Gm-Message-State: AOJu0YycikFHbUmEFtnlLJWMKntLTRamqH7Or23SMgqHDGFgrGuqB9zN
	AJaE29rspNho7kBLKKTlbW5W2uTJka+RSqLLYNqL5oa57TMKdsS7dBctlDhZhuA/rwY=
X-Gm-Gg: ATEYQzzmoNkHKd7Dfgdal9iSQ8FwE9A3J7V51iE+Dt92krQ42zGrainK0O62Ov0FEGJ
	2Ou0n9G+Os5UPg39k/ZqrQ7BUoi+tk+K70LMijzcjgm5jVk64QaIQALLOQRkNIS3MlWQnQBFckb
	+KQUbteX4HD6iKFWUpwZZIBvUFL2hJ+K/nh73c/yfhzA+xc4cycDxQq2oQTXkufgbqo1QOh0Wk9
	/TGLcVAb83gz/CgatkpKM7CUxWEf5UjScouTx1G5RlWpEiNkzosESDQr8EUls8/P7i269/OkqqK
	R61S8Oti9nBpYJvQIgNmmjFAS5AJpqFSAj/hstjpCGOgzNv/7yjnQMtvQRk9rdKotTe1iYpsHyc
	entPA3F9F07cIKpEj5+LgOTz/HrYCfgql3/juDOiXRiDk1jdPLRd9+sQNtnf08PfP0EwQSwtyRM
	b9duNJIxG3gjggVSZXgToTxIGVvEVWf7EjluExW3t3grDelC9Sf9S/07DDnV3Wk/V/DdfGkI+p
X-Received: by 2002:a2e:b8d1:0:b0:38a:55b7:dfa8 with SMTP id 38308e7fff4ca-38a67dd7bfemr26657941fa.13.1773332818449;
        Thu, 12 Mar 2026 09:26:58 -0700 (PDT)
Received: from ?IPV6:2a02:2168:8772:9800:eb6d:4393:98f8:641a? ([2a02:2168:8772:9800:eb6d:4393:98f8:641a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38a67e70dcesm9862661fa.39.2026.03.12.09.26.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 09:26:58 -0700 (PDT)
Message-ID: <edc6cbe7-905c-4eb7-9829-5c41f2a8beb0@gmail.com>
Date: Thu, 12 Mar 2026 19:26:57 +0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bash completion bug: "symbolic-ref" subcommand doesn't complete
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <c1e0c05b-c767-4fcc-859a-4da6b90c4497@gmail.com>
 <xmqqikb1ggri.fsf@gitster.g>
Content-Language: en-US
From: Andrey <butirsky@gmail.com>
Autocrypt: addr=butirsky@gmail.com; keydata=
 xsFNBFpWP0sBEADdnQLkXcwaJnoXWO4o9vlWHsLqsbltZ1MEIewNV/7jfhQ6mBBW43O4wK0/
 kdICUpH3Tv2iGQtWszAxBotWhEjFii6naG5FK5nHtO/qbIhpRA0I3nHn0tNJRxIPbtM1rFHh
 xplEEPRqL04EG0C5iC69SdKPQdHCDEP+xFrBSmANQ7Zi2ipUG9ctHiWA85iatbK1Y1T/AhfS
 d0dOkKXxH7SWz1w8TiinhIGlHDtKdul8W/g2pUkSE0iW9j2Yipr4YRMSVJPMYiilWrC2ofth
 1gH8rUI5/a4ePatVBh2GZInpyUImjGbC3r7vzig/w7tdrq8dXQYramHHs4xpCQZ+kW45nkS6
 aNY1AWvwGKJBzVIyqflVenn/oElIvaviiR4txl+HfaIcSwRfVLIym2ywa1ZUGFfVF89U5kh8
 WSp++JDIAEflm3Yh+56H0L2th81mV2XzjEJhS87isDnQLvBYvW4GSwUTwgHbGvU6yuHGC81y
 d4bGdYKEJtPLjGpFMRAdin2YRHyKZbbcQknOJCOSOZW/H01H5aix1FqklZp+jwAvXRAT+dPR
 77sYVu21IDe/glcuTxHRvk7fgMnJt5+Gdv6nWEtg1r4NLAik1eWMKJnc7Ho52T9Zw/Fie/UX
 mQ4iZDJFmOmckxLLoRJnvGBmQJD+dHQLW9LHIM4aKwSqAIbZXwARAQABzSRBbmRyZXkgQnV0
 aXJza3kgPGJ1dGlyc2t5QGdtYWlsLmNvbT7CwYcEEwEIABoECwkIBwIVCAIWAQIZAQWCaXyn
 cAKeAQKbIwAhCRD8txru3lAhIhYhBJhAidEwFbzdZP55C/y3Gu7eUCEi3U4QALaYKHNoZMMA
 v9wz+lRTade6vgD7dLTfxvWK5Ahy+3N/RyMe4yH8Vg1t5gGAtTqIV6xB2sGC69f86LLSa9+H
 Wj+9FYGksqd2B9STVjSRC754hMwSObM8WPMFj6qoP8I/URgH5J6rRhPQuk9Ltc0Kb7ws4BTi
 gT1Ss4+aEizcwiahH2JjHrnYFHAM/IkCQEmxHZFrtlODCPpQvSw1iuL6hL3iwYFLZkkcNIDr
 FYnNKAF+0t28Upq0Opd12NpIvOtBaqJ1+QeP5FqpuuuDMW350pr/oieCUS3XfAEV8ilcABCJ
 kK5EpwkbNW5KdOuMYjchP1UfkdT5vz85YhhAW/MC9DpC8Ade3Jdo8c4dmvgrYduhHyJ7xLfS
 soJbD68mUcJ4aG0uiZR8XBrca2e99cG0QfDyVl5NqbYj289Arhs+26LMEBu3wECUqQSlXL7V
 A2iUShH3Tp06XOyMkbUv8gDIzD6vrhaKK+MkDjeTOHC8pZzFeh7n15e1V1vdiwsup+9Lcz/J
 J822sR0ivReRRM1jQKW8O6t+eZDOSw71WUdGU/ySQXkPQUcsy/20kXZ+8JXMZ/OSOhzp2wdw
 Fw9iokn/mYUXKLqae3MHp2s/FPV+AqyfEUFCXOePii8nI/GvG4VDA77V8dNi5LqPnDsULW2y
 Ym/vvid8aBO1HOtRjpGnPlWwzsFNBFpWP0sBEADxNpLRM8haulFf+d8g7SRS38t3AUBou1cS
 lym08+djQVUXCpNLPj0LSsV4zKzmyGs5rn4R0kin+EIjhJEVqfiPrE9FwCV5tk3r5kP4X+oK
 LHxworYy7E+nBtw7GHvXvLvtWyMGstC1dVhU3lLmIPfwwNpjvE6LSDS+xwZLZeeoIO07Png1
 KjYZ+T7FAdrClhhwypMFwM3kimBUifZdzSPwnxww6G97Vqm8hFP2Oxyh8AEWBTeya0ayfV+k
 BEdnSw+Uy7sRt0L8Pvs5bk3lm+Qi6NMzDGsT6ezvOVSAa5meDULmdjkett8lbRRE9IndSGhx
 CDXQDeRC4NLcHdWVDHir0tHvZZxCuD6FSlDXZtnYYL3PhWef9q3nTdpXzfKhNxUbFU/4AKAv
 UiNTvypvgsrbhHnGKWBX3/oNPSY5ISuGYe5BCgeBKBCc/5MFvPAT8/YOJbZUkHNiN3Y4xGQ0
 tNCcgxmffQPDt+F7XLDdfnvIlgDPI0yxr7tp07uW8QItp/ArTfknGzZNOT0T0HjiWojD8TqY
 YKQzsEh5Acszh5auNMOucGMV89TG4o8PMAgGlyQvUVix3TI9JWG8LYEooSFttkf8iE4/6Plm
 hlkr5I6lCyguRo2+o88+o6tt7Y/f3LDYcV4JtMhye/BSrhjv4xd26yYWpTmGf3avU5UsNcBf
 XwARAQABwsFlBBgBCAAPBQJpepOJAhsMBQkYi4yFAAoJEPy3Gu7eUCEifCQQAMEP1VOnkIEt
 jXQ6qgpuBvyPZkudJ7w38VHpL66cQn8ipQE6YEeE4bpQmw5x7TvyHiATEnI9cWK9dhiNMe8D
 QXrKuLIxEW6sEhhd/lpfMWCAERmvZw4rGW9KDjhr+O3i3we88VVl+5eWW+A7cwrcavSZtGhk
 Jdb9KeUFFplVO1MBcKnO6DST42S5oJ3xOyHXuXGZjbfKv7HL2leQ0mVOmBG/2pgz1YbCFE4F
 BtmMjP82dEAJYJChM9uvw+OaJDOc8HCSOT/OHJT7exl6XGBpwAzz+LRw5wybf5llafPFv42H
 W68z4rewUh5lFZFsQHcBYsaUmLKg4HaiVNQNSNhkCjTaS0Ns4Sw2muvwSwHT1EkWgEhOdAFc
 fRFHtu4LW6eZIQAcyzjt+9cnvCz5/FRpGzLVHFVhkHNi9qkdbnGNNz8B0nbAxYQJgQ5TWDsa
 uiVzj4EZrDZSbZHl9sjfFSer2bzCK9bfVLhM/fjOfoyLWJuZ5kgGJqfDyfPsCHoiqsJfamJ+
 PsWRKZFcB3U+mbaMzFUqKDCskpRE6+frm188LrSf55BLmL5XnIykO+l+zAH8u9/iy6NHSjEK
 0ft1PUXja1u52zJ4FNtW/PVbeYP2Thow1izzyA5L2b35FVfpz1wlQ2WHkJ3x4CpaET/6H/dY
 VVOdns/k4krQA8QXLlOOXh+F
In-Reply-To: <xmqqikb1ggri.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

 From what I can see, the file supplying the completion is common for 
bash/zsh, but still, the behavior is different:

|$ head /usr/share/bash-completion/completions/git
# bash/zsh completion support for core Git.
...|

|
|

On 3/12/26 19:21, Junio C Hamano wrote:
> Andrey <butirsky@gmail.com> writes:
>
>> Bash can't complete some commands, e.g. symbolic-ref, bugreport, maybe
>> others.
> Isn't this working as intended?
>
> Our general principle is that the plumbing commands are not designed
> to be "typed" by end-user to use interactively, and cat-file,
> commit-tree, etc. are not completed to reduce cluttering when the
> user does
>
> 	$ git <TAB>
>
> If zsh completion includes plumbing commands, then zsh completion is
> buggy, or those who designed zsh completion did not understand the
> general principle ;-).
