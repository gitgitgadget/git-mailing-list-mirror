Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED7427A103
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 20:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759956089; cv=none; b=qZKr9876xBCg9mgDfMZ3aD2q65gfwy8kMCknwpu5AMSh0qx07qvR0ZVlVwwl9Od+u3rPyBYviXMpiDDyBKGClD6rBPYwGCG4TNqaQ8CY1jdVy8XHniiph3lgBMoAVASOArfeldvP2Jf/Tgrt3wZuSrr9YTnIHHKTC1ynddLylPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759956089; c=relaxed/simple;
	bh=gOcQnLyUHhNOoo/xSdJ5zfhv/8yIKfWMzbpUsYUlEfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JA2kFyyq83WEp5rlwAoTpgIhrjZgoEqwExnEiNlFpjQadrCzDILAyriJH/TLjgMW0H26IjnU29sWqzlbV7JKcsBqDFHZrzIhS8SbYV0mg/XCC664XvPArPNlh8PCF/ROtqsz4ViSROTb2NuMALMJzIw/ipPn/GNszTlzrkIWR0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTgEKQc0; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTgEKQc0"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e3af7889fso1494905e9.2
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 13:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759956086; x=1760560886; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Uvn2RDCYaNis5470LRWzhoAQfrClI08PoyZQD742kMY=;
        b=TTgEKQc040BklrgYZ5CU6xWVxah9TzPx2voAifqH1KKDsPrC00CQnEs6GyQHtTedxO
         a6YRZgBkPRQ8KWWrnyQS+j31GzFxXPIB+jOPKaF3hFjsIIpN4W5dLGF/mPq/r7KXdnQK
         P0WzHcZvNQpVV//u5aK8ymbfQXLqKLqLCXReMnfpKwyybvuUeTpqUKyuqqKGDROePU+4
         bc5m7RoAo7m6QYP+77S/g6RqSiH1Wa9BBzUPaPyXG5gtn2eto1hJwSyk/aK+ygAZ64Jj
         LRn8n12G4iez8ga9afrl95KA2lQ6874oVpzcDyOdewIE+Xz8PNt1/LNsTjgBkZY5UtkQ
         9HxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759956086; x=1760560886;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uvn2RDCYaNis5470LRWzhoAQfrClI08PoyZQD742kMY=;
        b=NTy0g84rpqaFaQ2VhYcq25uGiGArhuPXM1NcNJw7K/g3+p/Vv9zN/CGyL0Efqdm7sm
         ySxZIkj+VajSbXU7GDgI0I+TyX845Ospf72Gg+ikYYqfwV3+KM8PGftUWeLGvyZZ4d87
         lMlQV20YLjgkTVjjvW+JxCtbQWFgNf7mZICkDYNeoMu0FXSCpnx+EGfoYbBYVFg2GEyn
         3Xgc8qja+DIxCyukmXIR8WrCnEkxL1t6eJoz0+whXjM6p9OhfOWW2fe7unrdp7CED/rd
         f/vN6IXrGKu4zTgfpwHpOZZfTLQ6+r5jAxb4zVwXM7EchgP719W2KJNtC6a+loyU1QYm
         6Fow==
X-Forwarded-Encrypted: i=1; AJvYcCW7Vzdg7VeUzbrnUIclKflgRdrEJqbWeFpMD9YZcGgDxA+7mX7iKOzcZi6dLwXmgEiok40=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBkjn2zstlSz1wRx9uwV0HwuBvopqRj6YLFnsbtNQymCFvx3V2
	T1pdKvI75iQY2oZYg7uMaR+vwECEX57Qf5gqElG9paRTZtJAmmAYCPx+
X-Gm-Gg: ASbGnctc7gMmUNsSzymZk/LsP3hvRQafX1HaVwM0y2MkLLY9MY2HckfR8lUvwZlKMgE
	kfIJGihp+TfnlG7GfzNnxH/q6JYEa6RgvyHJ6bvdaCJ4PIo5S4G7JDDoIXWmueK1aZxIj3b9RQD
	fvG1LYSdvguv6YO3sGg7HqG0plSAnAXvXS6O9rgYw0ieMuYCBXStHihMug5K5difVNyMSwgZvLr
	T6jLi5d80FhAvmCcBTAeASjfZuTS0MN2hwFHjmcPx3wSOUqVDhnO3LfsE0bTnpVMnNc6ZtIsIGS
	URgIK9ydkehUObIQavg59++srzs4E5AUybXRqLp/TFYYM+5+6qAG76I8jPsyCURv+3vJRbQSAYq
	Sd5Tv7EfdnmC8Yd26fNkxUUarBP4u3xac43hMhyczquytjgepp4ZrPDjHKgyQO2mVyjQXKCGRiP
	t8
X-Google-Smtp-Source: AGHT+IER+TuWMnbv6S7tdfI8uxp6VhxZUVqcMCVWp5UHmk2Df3jf7hNyy8VnyXBssd4c5xUB8dqIfA==
X-Received: by 2002:a05:600c:1d18:b0:46e:3901:4a25 with SMTP id 5b1f17b1804b1-46fa9aef67bmr35343685e9.20.1759956085884;
        Wed, 08 Oct 2025 13:41:25 -0700 (PDT)
Received: from localhost (94-21-146-170.pool.digikabel.hu. [94.21.146.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f01a0sm31220769f8f.48.2025.10.08.13.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 13:41:25 -0700 (PDT)
Date: Wed, 8 Oct 2025 22:41:23 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: How dangerous is --committer-date-is-author-date these days?
Message-ID: <aObMc2GV8fAE9IX2@szeder.dev>
References: <6af09726-e3bf-4903-87ae-9524ad334678@kdbg.org>
 <aa981bb7-dd3b-4e63-9769-0fc2559983e6@gmail.com>
 <6d6b2ff0-b4e4-4442-a3be-9b31742db280@gmail.com>
 <93041214-4774-49eb-b8bd-24648134cded@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <93041214-4774-49eb-b8bd-24648134cded@app.fastmail.com>

On Mon, Sep 30, 2024 at 04:49:32PM +0200, Kristoffer Haugsbakk wrote:
> As a Git user, I don’t understand why some people want to fiddle with
> this field in rewrite operations.  It’s very hidden (apparently you have
> to use something like `git log --format=fuller` to reveal it).

FWIW, GitHub and similar sites display only the committer date.

> I can’t speak for power users.  But regular users?  Well I see questions
> about being very deliberate about setting this field on rewrite
> operations on StackOverflow (at least one time).  But I can only guess
> *why* they are particular about it (this part is often not explained).

Perhaps they prefer to see the author date even on GitHub, and try to
work around its shortcomings.

