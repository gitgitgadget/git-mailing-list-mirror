Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38616200BBC
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 13:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758721712; cv=none; b=Cm9HgcYLjYBNRAqIdifvbiO7n6tJDq2/KG1ETRSbZSwRdA99x/h3cLikqOTmgEtsUp9xbiBkWNBCuCKHo0iF0FPY8y5H98gyPMWAfXi5M/qjWMRz3q/2ez7E6Si/Me6dwn5/rbadOSmch4JPAPgVAEQdqjKRhAwxWP+5cAtsmiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758721712; c=relaxed/simple;
	bh=sHXhuGR3WxBZJSOKFs3tqxBo2XBVTm327RKLOwq+jOc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=g6rldJK19bDyurGl/hUldxepk7yzUtykZZVGYVtJnHAZR91ZTt0mFrxvCTNWTh2ciLQLCpA+G/+jK34bFyDxQVGEEhRwMJao4CmGCIn23l80IdB6ZEGub0KaFpe/ekgnHYXmWI6KuX7O2bk5s3WEwRqnSVX5THlol3ADdxkR+34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2P/Wak+; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2P/Wak+"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45dd505a1dfso47724845e9.2
        for <git@vger.kernel.org>; Wed, 24 Sep 2025 06:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758721708; x=1759326508; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yGu/I+dQtU+bcQn3wqD740I3acARVkwGGzypEuSeiqY=;
        b=g2P/Wak+LEbBt6ahteDnO+/dqEy392nZZgoqBgpEwO8cRqrGQggTONHKCDcCV+Zigm
         UbzdH3uxQueULxTD+2D/78bXZcZ17T8zLkyjKMZisWV9ypcY/w7x1vnYlzzIx6jdt3Wv
         tEHg1zyOJldTvIRrcq7YAg6RhqvtcyvrBBrrh7VD504DPGH2voKgCcyM7sohK/pr1jte
         tQRX5i4A4HYMaMraI2qVHknWwctp8yJqJEiYgJSF0qJVU87aU6VXCLutOf0fzCdtoRFp
         8fJAKxTqhXUlU+1OtR+nrDaDVP73VhgXbqjYBebsLA1L4ArlhkIz3ugC0EHZDRT9/eDZ
         w8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758721708; x=1759326508;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yGu/I+dQtU+bcQn3wqD740I3acARVkwGGzypEuSeiqY=;
        b=DrdniBm7/RmsNdaembUbikQ3QYhCP1fhr3As6ahyQ/Ab7RrlcQvB2pBHCEtuGRtv+l
         F9L4y0geZBaZF98pkqtMw3nwrZ4hnd0iDhl77c5+j1LOHQbLOaPUvQ90KwWflmzuSxb4
         9YNXNxceCMaYPyAgRaPrMtTEVeD4bZLaSB8vYNN3AEU4TjUr6SxZ3z1T1B0HMGvEMILo
         6iFGArKsnDkwUpkSvDeJfIugoIKp9w2a8zjLOwlO1KJV7OTU9VtUbMIvTj3nDSqGN1Cn
         f3hRG7q2GCOF8GiAYXHes2zORV3NOkKinKZ5KdB+ypowU7B4oLmIbO932RpFMT/V4fCt
         tkkw==
X-Forwarded-Encrypted: i=1; AJvYcCVLs0mc+zMDUzFdgyToXiKPu3KLVbqVEKvHsGDNIS+i39VpZrYTs/7tY0p4gkIgFmybPe0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0GVQWsCV2md9thQqUAdulTymEpQK7inz7hMS3Qg+9355Q3/BD
	E4llqUUyoDjHeVP+dSvJBENrje20oHkUVT64TGmJZsvnKH9Lg3pl2xnf
X-Gm-Gg: ASbGncs9NUT8zPcXwqOtKZeyFOp9KZJokBHW6Gui0e89nCRwG5qDnMpkuVKK1L1y8q+
	eWlcW2ZINaql3AlHxnd8WigmZCG7bu3M0vAVUZrR/V3wRm1O7tPCTk83XFzSZJdFbQNhj9R1UcS
	e1Hj77rgu1Cm1AsqmXVq0BSAmctS90jUMFquT+ln7WwVC78i5nykqGNcelZ/W8+ZYHtgacz4Moz
	6B3oEWAmP+9PA1VaOBVY1ehqJbi7X43oyGyQb+nbvMRwskZ7OlQTIVEztWYzOw4dJGNH1KWNC3i
	KUqQJMF7AxMkFOEtJa8VGJ40UqiHx/MHyUQR0n+mYgRUxnq72Mrx8fHMfcEJQ7ZNdZOkTUSM1/2
	a8NfNGew5Fvayz5Xo7f9mq6RM0yh+6AbVDEHewQuHYezffWIvsBm+saioGkyekl2lLr/15oXw89
	w=
X-Google-Smtp-Source: AGHT+IEzqrXnrpzDi0BhkCQzqE0JXqzRSfQ1DvV7gk7c8HjuUTcY3Fr6tS98vkyVvg36ltknxt05xQ==
X-Received: by 2002:a05:600c:1990:b0:46e:29a3:26c4 with SMTP id 5b1f17b1804b1-46e29a32a8bmr24379795e9.2.1758721707785;
        Wed, 24 Sep 2025 06:48:27 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a9af775sm33293965e9.7.2025.09.24.06.48.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 06:48:27 -0700 (PDT)
Message-ID: <bfaaf26f-5759-4812-9057-b3e0bf7c7949@gmail.com>
Date: Wed, 24 Sep 2025 14:48:26 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: gitoxide-compatible licensing of Git's Rust code, was Re: [PATCH
 6/7] xdiff: conditionally use Rust's implementation of xxhash
To: Jeff King <peff@peff.net>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
 Ezekiel Newren <ezekielnewren@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <5a959c9bdad79cf972b95dcf4324135dd7c94dac.1752784344.git.gitgitgadget@gmail.com>
 <5596e569-6632-c2b1-37af-a978de5408cd@gmx.de>
 <dd3a7ab0-947b-4592-a086-8c7028f02ffd@gmail.com>
 <9818dc92-3569-3e6f-0252-245c2bf0bf84@gmx.de>
 <20250923174825.GB1136654@coredump.intra.peff.net>
Content-Language: en-US
In-Reply-To: <20250923174825.GB1136654@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/09/2025 18:48, Jeff King wrote:
> On Tue, Sep 23, 2025 at 11:57:18AM +0200, Johannes Schindelin wrote:
> 
>> It would not even take more than something as simple as GPLv2+exception.
>> We do have prior art for that: The Git project itself suggests in its very
>> own `COPYING` file to use the following license in new files:
>>
>>          This file is licensed under the GPL v2, or a later version
>>          at the discretion of Linus.
>>
>> Note the exception? For new Rust code (and of course excluding code that
>> has been ported verbatim from GPLv2-licensed code), GPL v2 could be used
>> with an exception along these lines: This file is licensed under the GPL
>> v2, with the exception that it can be freely used in the Gitoxide project.
> 
> I think this "and of course" parenthetical might be a sticking point.
> Obviously taking the code verbatim and re-licensing it is not allowed.
> But I think even reading the C code and then writing substantially
> similar Rust code may be legally questionable. The Rust code under the
> more permissive license has to either be clean-room, or have permission
> for re-licensing from the original authors (which is getting to be all
> but impossible over time as code ends up being touched by many people).
> 
> I think this is the same issue that libgit2 ran into. If it were just a
> matter of porting over and re-writing new features, more of it would
> have been done. But for code to come under the new license it can't just
> be a port, but has to be an independent work.

Thanks for putting this so clearly, I agree with everything that you've 
written here. Another thing I'm concerned/confused about is how the 
exception for a single project works in practice. Does it mean that a 
third party that wants to re-use some code from GitOxide has to check if 
the code originally came from Git to determine which license it is 
under? Or does it mean that anyone who wants to use Git's code without 
the copyleft restrictions can do so if they launder it through GitOxide 
first? Neither of those seems like a great outcome.

Thanks

Phillip

