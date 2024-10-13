Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD87381742
	for <git@vger.kernel.org>; Sun, 13 Oct 2024 09:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728812081; cv=none; b=sALJaoSzn5xvt5D574pHte+8jwtkLCNGn8sGhPYRlY/OjmlbyFLoVYQHKhkhrzEJREGIXzPmS9hJIWcTQE2c7+W0lRMjE/r0zCQRrnlAKuF/q7aufyGI56U4l+2GZLpFz5rRGKqmkFEzycHR33HfVjCKgeN1pIQ8OsjPmKmmY9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728812081; c=relaxed/simple;
	bh=CAlRtxa5TAUepa6jk/vqJfe3Phx7Wp/gcryADHsgBz8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jYwc7Kc27DuIOjXnKxvlmxmpmEh1uVmP0B2wo3+VDR9aWwoldtQvWRPgO8Dn+KVeDDXKaOOoKif39c1Q1yqKEJ2kB2md/M6uibX0hohsKxRiH7/krahH8UCZvk3Cs1x+uc6Zg+gG+OpuySmLACMmBqCuwdMofpt+jRRLNnKeIdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKm7ozpN; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKm7ozpN"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-430576ff251so28987905e9.0
        for <git@vger.kernel.org>; Sun, 13 Oct 2024 02:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728812078; x=1729416878; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U9KLMzMBkdpR2t4XYsn0jbb2UalyKReu+ay8F27xQWg=;
        b=cKm7ozpNzxeCecxspBPAO0ntOfgk6DsvXnmL8gRc8RJj3ApNhA2ZU0EbPN0El48PTp
         9y4zboeKlMCWvYv4J1keV88TgGIh0GGYU6aRELFe3UufAMznEK9V4aRiDAbcYUXGcy4S
         wBZ2q2IlARwMfoRSGSzG+QQoO77VYbHL8HnIuwdMyfHPfUJqpUi1Xm6bTfHb50Du0mZq
         PLHNw6r0fPe5lQBc34GsKgrELYGWZ+ACwHM/EUgZejEKNJMDw+CAfoQILKAaCR0XrHi3
         qfFGXk3zWKPU4wyJo0LoQ8mLbIhyBPQHrBcg8vrrys1y85qO62tn/FUkHvHDsTTiLX9O
         1Ttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728812078; x=1729416878;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U9KLMzMBkdpR2t4XYsn0jbb2UalyKReu+ay8F27xQWg=;
        b=ZVC2pWzaw0BLCIlXlssJU94PfU4GaJwZxlBqXtdEULWhjuH/zX6I/iON8/uYlhD9lt
         22ATveI5aD9lTMTvlTHtxep9nhmbbo/jOk3TVyZ9993gESauFV8ZyovUH4uuQQA3sKYx
         or06XQoCEPX0ABqzt0TCqQuRyXzKep3rO+xMgzZelDusg5A6p9WyDHZJQVLkFkOL+SwX
         /Tgwt8LrHXgCeaf46lFQLWRzEkE0BVaoAPYhZ/+brCpCp2BuV93F24eSBDlg0xrsrS/g
         T0T2co9X7lvoZUViR2vlb1vLQF9zvcETgNmLJhTvACYUyvIBUQ6owF5GICCe4Hvdiznn
         BgUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyx3w/hGLmQxhGZ/5FMQqBZeYLmR+YGDfXES7cOeyf/rRwT5pdLeaIDdm6cfTZPNlqh4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD3u3ZLMPiwvEJ+sB6j48+h36JtQm5hdFPNdoP+N47cCzYQeX1
	Qem2guwhxFGyd+0XgARH0Lcv9L3nums6jbIcnHPwMTvugva/AyF/
X-Google-Smtp-Source: AGHT+IE8lJAlr8MZrVcCB1CNZ2q5N4lnKoIicp/A7PVLNxGt8U63J+AhiqM9qav4B1FAv/7gX1Y6nw==
X-Received: by 2002:a05:600c:5129:b0:42c:b750:19d8 with SMTP id 5b1f17b1804b1-4311deb5f3cmr59942585e9.4.1728812077708;
        Sun, 13 Oct 2024 02:34:37 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a? ([2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b79fdc2sm8121407f8f.88.2024.10.13.02.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Oct 2024 02:34:37 -0700 (PDT)
Message-ID: <f7a7046c-020a-4365-baf4-49184bd2c60b@gmail.com>
Date: Sun, 13 Oct 2024 10:34:36 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: with git update-ref?
Reply-To: phillip.wood@dunelm.org.uk
To: Junio C Hamano <gitster@pobox.com>,
 Bence Ferdinandy <bence@ferdinandy.com>,
 Karthik Nayak <karthik.188@gmail.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
References: <D4T9VCF8OS6U.1FMB8P6YU7I3S@ferdinandy.com>
 <cb60b7ad-7902-4293-81e9-06d1b1526842@app.fastmail.com>
 <D4TA5EXQFFA0.1XVEK1RM2Q6VA@ferdinandy.com> <xmqqa5facosb.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqa5facosb.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/10/2024 22:28, Junio C Hamano wrote:
> "Bence Ferdinandy" <bence@ferdinandy.com> writes:
> 
>> On Fri Oct 11, 2024 at 22:56, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com> wrote:
>>> `ref: refs/remotes/origin/test`? (space after colon)
>>
>> I tried a couple of variations and no:
>>
>> ❯ git update-ref --no-deref refs/remotes/origin/HEAD 'ref: refs/remotes/origin/test'
>> fatal: ref: refs/remotes/origin/test: not a valid SHA1
>> ❯ git update-ref refs/remotes/origin/HEAD 'ref: refs/remotes/origin/test'
>> fatal: ref: refs/remotes/origin/test: not a valid SHA1
>> ❯ git update-ref --no-deref refs/remotes/origin/HEAD 'ref:refs/remotes/origin/test'
>> fatal: ref:refs/remotes/origin/test: not a valid SHA1
>> ❯ git update-ref  refs/remotes/origin/HEAD 'ref:refs/remotes/origin/test'
>> fatal: ref:refs/remotes/origin/test: not a valid SHA1
>>
>> I guess the intended way of doing this is via git symbolic-ref anyway, but I'm
>> curious if this should work somehow or I'm misinterpreting the meaning of that
>> sentence.
> 
> I do not think update-ref is a tool to modify a symbolic-ref.

Didn't we add support for symbolic-refs to update-ref with 
'kn/update-ref-symref'? Maybe it only works with --stdin? I've Cc'd 
Karthik for clarification on how it is supposed to work.

Best Wishes

Phillip

> Moreover, the mention of "ref:" is meant to be for those who are
> overly curious for their own good and go peek into their .git/
> directory; script writers should not have to know such an
> implementation detail.
> 
> : ask what the current state is.
> $ git symbolic-ref refs/remotes/origin/HEAD
> fatal: ref refs/remotes/origin/HEAD is not a symbolic ref
> 
> : set it
> $ git symbolic-ref refs/remotes/origin/HEAD refs/remotes/origin/main
> 
> : inspect the result
> $ git symbolic-ref refs/remotes/origin/HEAD
> refs/remotes/origin/master
> 
> Thanks.
> 

