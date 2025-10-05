Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A193C25A65B
	for <git@vger.kernel.org>; Sun,  5 Oct 2025 14:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759673177; cv=none; b=aYOr+k+stcsP9zfC8+w3wUxXIuh5QizKnW4N3j8o5dj4LrJHC/M2cBYCYLcKfOdhK2oeXEposxnYD8NjUMstilfXYYXSIMi33zALnoMKAWx2u4yZ1eiIL2Ek20ZdTULIYQzbl/Vf0UMgIX1bCnjqRJ5qJk/X2zfUiqladOePybM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759673177; c=relaxed/simple;
	bh=hSllAhRsWNnoSS7pblCo6z5neIKziyKWAKq4r2SDcAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mFLmud8JGsnJtqpl3OQGTECsBAqbsr0FDftAScoyreKyL6e9zg1vXQWCNWckw4Wtejr0fjceMOxt1vzHPdWsg+O4dUY6ypRCH1pjaaImEwiLoNcKZHt7Ppi3caE4qsMrZTSk4PQ4+bAlCLy1jee4t+UJxySfGiNwJAeYe0AVZMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1rXVdYD; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1rXVdYD"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b5579235200so2798149a12.3
        for <git@vger.kernel.org>; Sun, 05 Oct 2025 07:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759673175; x=1760277975; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oE9TBUDAat9BjdSn3hGBBbQEVSy7rxD9Ghl93irQ5NU=;
        b=h1rXVdYDMXiPybjxWLNXBe6oukxTk2+K1Bddh83iNcuV9FcdcAaYF6lLaG6VRkJOrf
         wEI6Sh8JJDmAhiHw/Zr6+y3lCRf7r58bBC8VYkB2ZiIUQCE7uwvowqEIcPkTQgzPJa23
         L+qUVsQwa6l4PURQxllN4oKOQC803LrjkVpyP8eiU9M5T+xX3G5daWr0ApbfWF/9AZBB
         mTl9Usg5xSQv8yTi0P+Ye98rzxLaiayEaSwZhfFp9Nq1+n2KMlFKeo22s3C7BCEYhcEZ
         jlPUb02/ZX0LfagmAMbLxY55lOJktcV2FfdLtsJh7YIn5kSSiso/f/QqV9ZR0xDMZL3+
         4lFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759673175; x=1760277975;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oE9TBUDAat9BjdSn3hGBBbQEVSy7rxD9Ghl93irQ5NU=;
        b=XYpGKB8LI3hY9lDJjyCjAq0t7VdDPKCDLGacMJ2l5gLfWlyV03FH3finvb1Eh2EabY
         K5pH8G+BueapMfhLfTrnAB5KE9K9d7hzehE6WybEsBCi8B+vaxqDAGDfM/6iF2vDmi/e
         WYLfr+kPDgu9fpDhMtrqk4QqvnQIKgQx23iG5ANEJHW5N6sGCuZDejstAGCDrC1iTseU
         RbiWfnV8wagdZb2AAyGU6gmqDZqVFiTbN2/K8uNsi8xmPpdtRpcLkMGJnQqCQU5iBr+u
         qbP/F7/hqFgfDExe2a2iHZVjbScEdTXZYVmq3rKYIBetlwpRMZpOXHzOabMVEykkA15C
         t/lQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuu6IS6qB4sKfkHFRA+0FfvmL9T8sGGUI+QxaT3ht1uYfEqJANNBAvHO0gPUkv8L0xssM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7bqRbklhvqWSPc7lCw+jsLmKK0wcHH1Ox+KR1Akv1KPxvv55T
	dSPLI7A9c99iIGcPNehMPnL5uafjxK7FGxwS8oP4FpY0/+3mDz6XWv9e
X-Gm-Gg: ASbGncvkb/8fdU8LRwtrDwhhZRIABffoxUFvDDQjJ22FXTyyIRqO06hIsdNUeUfZ6pq
	JegoRrLMbzwEzXw7uIGjwHJCgBaPcbj4XE/fxU3/kPAyM6gqtj+UJzbomozTjX/uziPl2IGJPTh
	rnmHcedWbAVnZFU86x50oLOfUPH6HGJzo7QNGOH2Z9OPO8HnpduQyKHHYTeA06+YktAoEH3eqSY
	0BnaN3xLTZFm8Y+RMh55hzg2SuoMo9tPTZtzJkmymrCU5rkviGEu753MYze0z0EYjYB94A4lvFx
	2UINrzv3NRIgiW83Q4IhytBKSo9YQsIOiNw//RZAwXJxyRILGBhBiWf9DQQytHYkLZbFUnFeRns
	vYN+GRbadaPqewy8O0ljuM/7nfjaRZcHEVLGupMQ9wV6DAZzODmc3LlmfWFKRcQk=
X-Google-Smtp-Source: AGHT+IHRMb2ENIPTTxPeQe3SKy/WkUl3AJMeuIPGk6wOy8zW9oF/2PCsKFZAFqKuZGExonHHBm77hg==
X-Received: by 2002:a17:902:fc4c:b0:261:cb35:5a0e with SMTP id d9443c01a7336-28e9a64a97bmr103910565ad.57.1759673174777;
        Sun, 05 Oct 2025 07:06:14 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-28e8d12c07asm104313795ad.56.2025.10.05.07.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 07:06:13 -0700 (PDT)
Date: Sun, 5 Oct 2025 22:06:13 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 2/4] string-list: replace negative index encoding with
 "exact_match" parameter
Message-ID: <aOJ7VTkmFgtuCjvf@ArchLinux>
References: <aMp8yNFiXDyk2hP4@ArchLinux>
 <aMp9OtXLfRw7dEwA@ArchLinux>
 <CAOLa=ZShms1D-cq=x04dtT2ULTVE3ZDo8DODFnJRP2wcJz0EgQ@mail.gmail.com>
 <xmqq348dovi3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq348dovi3.fsf@gitster.g>

On Tue, Sep 23, 2025 at 11:48:36AM -0700, Junio C Hamano wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
> 
> > shejialuo <shejialuo@gmail.com> writes:
> >
> >> We would return negative index to indicate exact match by converting the
> >> original positive index to be "-1 - index" in
> >> "string_list_find_insert_index", which requires callers to decode this
> >> information. This approach has several limitations:
> >>
> >
> > Nit: It would be nice to start by explaining what
> > "string_list_find_insert_index" does and then talking about the negative
> > index. Perhaps something like:
> >
> >   The `string_list_find_insert_index()` function is used to determine
> >   the correct insertion index for a new string within the string list.
> >   The function also doubles up to convey if the string is already
> >   existing in the list, this is done by returning a negative index
> >   "-1 -index". Users are expected to decode this information.
> 
> Yeah, such an introductory statement would help those who are not
> familiar with the convention.  Thanks for suggesting it.
> 
> >> 1. It prevents us from using the full range of size_t, which is
> >>    necessary for large string list.
> 
> It is a disease to think that countable things must be counted in
> size_t and it needs to be somehow cured.
> 
> It is a type to count the size of memory allocations, nothing more.
> If you are holding 1000-bytes per the stuff you are counting, you
> would not need the full range of size_t --- you'll ran out your
> memory way before you fill size_t with the things you are counting.
> 

Make sense. We don't need the full range of size_t. I would improve
commit message later.

> When there is no external constraints (like you need to specify
> exact size to describe a file format to be interoperable), the most
> appropriate type to count things in is a platform natural "int".
> You wouldn't be handling billions of strings in string-list anyway
> (and that is smaller than half of 32-bit size_t; 64-bit size_t is
> much larger).
> 
> >> 2. Using int for indices while other parts of the codebase use size_t
> >>    creates signed comparison warnings when these values are compared.
> 
> The other thing may be (mis)using size_t when it should not be.  If
> they were also using "int" that would also squelch the warnings from
> "-Wsign-compare".
> 

At first, I feel quite hard to understand above. After reading below
mail and the blog

    https://staticthinking.wordpress.com/2023/07/25/wsign-compare-is-garbage/

I get your point. For sign compare warnings, the most intuitive way is
change all `int`s to `unsigned int`s or change all `unsigned int`s to
`int`s. However, this is a bad way as it does not solve the problem (and
it might cause other problems). Instead of simply making the type match,
we should check the value range.

For some cases, it is always ok to compare `size_t with `int` as long as
`size_t` does not cause overflow. Sign warnings might be a hint. And my
commit message is bad as I just want to express because others are
`unsigned`, so we should change. But the true point is that at now, the
returned index may overflow. Because we may have index that is greater
than what `int` could count. I would improve commit message later.

> For an amusing read:
> 
>   https://lore.kernel.org/lkml/CAHk-=wg+_6eQnLWm-kihFxJo1_EmyLSGruKVGzuRUwACE=osrA@mail.gmail.com/

Really thanks for this insightful hint.

Jialuo
