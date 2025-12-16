Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516C134AB01
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 14:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765895113; cv=none; b=iq67WKtYlFy+mm4MVjxFLx+h2We3bWclm2lod0wkDXqaJTI2NL8Bj8hAoiRVCwIbHRblMbMC+q891ZOwJRlKZaD70sEksxuBGnafTcpARhX5VN6y3IbT+cdu8srw26HGfUbGvwujKMkTJpCiCbExQWSoGIzqzCKpb/9aGfnjQcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765895113; c=relaxed/simple;
	bh=5F2XZt5LA7NJbe7q3bpJYn59pUHBPf1mgTsOmEUC7DA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=aleXZmDpeL/5jDtrYEAuhttltjYew6sSzY47czJKPPplfq9BYzrslbPT30/oDA1MweSBqMtSmHytsoVFyScQVibCB+UrFkezzES1War4sxLvcy4xEO0S/iYh4hmGm2mMma+14li3f4fjCN+fGjGdJUj6ap5s+4zNt0JkBUC6qN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EADuZCmV; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EADuZCmV"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42fb6ce71c7so3649130f8f.1
        for <git@vger.kernel.org>; Tue, 16 Dec 2025 06:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765895108; x=1766499908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g4QkbmKwn3o+2gyHD+YJ3mHJhs9I4Yv55K6msfM0ByQ=;
        b=EADuZCmVnjFK4/8zwXXul/I5SFPYglBZWSuJ/e/zaQDFmGjp5ZtIO9n1kFa0V0Uw5M
         e7OH4eaORK1/Vc4fxZ4Cb3hcvMjGMKY9xtYHTwJzBGY2Dq2tZPiWstsFU8NOSuoU73vt
         mUgN/2anPUClaZcYs7TsYKdihMQrS3XX3iD6eGITtlnx/gwB4wXX/TKe9eawLt2l7o2A
         3X8AXM3DTy9nBefBw4AwN2d4ZCyrCX6rAaWTmpC5qreSJ6Zz6QDDFQ64CYODFWbhpROv
         arRpJyDeJE3z/tYOtSuYITwsoAboWVv7LXSNAuS2wpjCrTBp8nJjnDlNRMLToDlrvl0i
         Yogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765895108; x=1766499908;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g4QkbmKwn3o+2gyHD+YJ3mHJhs9I4Yv55K6msfM0ByQ=;
        b=YlqREw/eBw+bXNxjoB1tpCcV8Q07ZMdk5+3xC0MaZxMWQol21whn7GkvSTlWiH40HK
         nS4uxjyP3H+JhXParos3oFKe2sZ4+6I6kkPGrkf5yg2Ee9uNg7aM+cIrZ/xXVXs7LHx/
         v2PUuf884t0FaqKXp/3X4cSDNkjqK6rDwVrf2gh3mJ6/jSLplIKUUR8QntzEpEspQ3Ir
         efdYVm6s9Y6OcvGG829XbHfA8Yu5AGBe+SUWuxdlfqaRyirAJ0UmO6XsCnvgTWp18rZQ
         pgeHL2zWCEMLr7iGWOWgxuouYTRYigB05g8L010o23LDl4q/S9t37H5Vgc6Z/klYhDCn
         +nbA==
X-Forwarded-Encrypted: i=1; AJvYcCX7r54rG9rEe7a34Zh/O/Ti3J4A1iWhzF+oiTQJt4+2S9XftfadVxE1hQZ9Z7W7zD/klrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGndmvf4FCqsyI4FfN9a91kpSrB0KqQIAmwQ/HEORKc45sXKbm
	IT1Gsl8zCPoVtHrYo98jKHxmUB6gN4PfGX7xk1+4H9AwmKVbmCm2iLlh
X-Gm-Gg: AY/fxX6VKyImXFhkgg+vkCn4hxzqKjY+wj63aUZJYQU0YJeM234WWXfZlTxFfAnwvaE
	T0psqwav9/wl7JOorhC7fUmzanVhY7VzAdry5aHPG8qsSYCuxFdqmri18ZvVfdd3RENIo7n62gW
	JQk1Kc3ptLIEqIpKli66bAXzfI90HxJOJdjdd1X54Vocl3nr//WsxShgR3U+KBbAaBjUmMiI8q0
	Q+DyWtN20FtnjrHKMR51fTAy9y9WZqmoudxe3LA+nTl14R6ltq1Ydyn1cGav+2orGRGp0jYJ52V
	n8/ejsIXNpji1ReZ2aWE3hy2C9IQ5p9UCsN5XDhDbcNS8zUBneIwt7YyNnYRuRH2zHTVruoXOqX
	hK577FjdGXfqmLvo2Dh/jnkedUzU5JCAsNAhej7/XwrYwm7ADnStGxAVssTKSXsedfBpIjuVznG
	PFnhN5A3dmFTZz8V4eUtmto5hOF/cmG/vBWT0agkbJrGBEL36RMMXcRZLsrGYQgV9ybw==
X-Google-Smtp-Source: AGHT+IHFMhWY5NKD6lWdfx8NQdHrlDG2aLd3z/5DM7+nGYGpCJgjOOqzUkzsZGd2Dx7W8aU11eTWVA==
X-Received: by 2002:a05:6000:2909:b0:42b:39ee:2858 with SMTP id ffacd0b85a97d-42fb490eccdmr14666334f8f.42.1765895107970;
        Tue, 16 Dec 2025 06:25:07 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8b85d1esm36154253f8f.26.2025.12.16.06.25.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 06:25:07 -0800 (PST)
Message-ID: <df29f24b-f545-47d1-ba4e-9ef25f01934e@gmail.com>
Date: Tue, 16 Dec 2025 14:25:06 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/3] doc: replay: improvements like "mention no output
 on conflicts"
To: Junio C Hamano <gitster@pobox.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org,
 Christian Couder <christian.couder@gmail.com>,
 Elijah Newren <newren@gmail.com>,
 Siddharth Asthana <siddharthasthana31@gmail.com>
References: <CV_replay_conflict.101@msgid.xyz>
 <V2_CV_replay_conflict.12f@msgid.xyz>
 <8fa21ce8-1e02-419f-b82a-0e4a41f7e2d8@gmail.com>
 <bf3f3633-5d0d-4fa4-9706-d99e32a3f91d@app.fastmail.com>
 <xmqqa4zj6zhv.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqa4zj6zhv.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16/12/2025 00:29, Junio C Hamano wrote:
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>>
>> Thank you. But I’m not glad that the commit message is not clear. I
>> would need some guidance on how to write it because it seems clear to
>> me. Something with my brain state I guess.
> 
> commit 03d7c9c457ba68f28269dcd607b9026ea6c6c9c8
> Author: Kristoffer Haugsbakk <code@khaugsbakk.name>
> Date:   Sat Dec 13 14:46:57 2025 +0100
> 
>      replay: improve --contained and add to doc
>      
>      There is no documentation for `--contained`.
>      
>      Start by copying the text from `replay_options` in `builtin/
>      replay.c`. But some people think that the existing text is a
>      bit unclear; what does it mean for a branch to be contained
>      in a revision range? Let’s include the implied commits here:
>      the branches that point at commits in the range.
>      
>      Also use “update” instead of “advance”. “Update” is the verb
>      commonly used in this context.
>      
>      Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>      Helped-by: Junio C Hamano <gitster@pobox.com>
>      Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
>      Signed-off-by: Junio C Hamano <gitster@pobox.com>
> 
> As to the title, "improve --contained" hinted me there is some code
> changes for behaviour, but there isn't, so that part may have been a
> bit misleading.  "improve short-help of --contained and add to doc",
> perhaps.
> 
> I think the problem people found in the second paragraph is because
> it is so unclear what it is talking about if you read it without
> looking at the patch text.  You started from the existing "advance
> all branches contained in revision-range", taken from the existing
> short-help in replay_options[].  But without seeing that "branches
> contained" text, it is natural that readers find it hard to judge
> the validity of "But some people think that..." claim themselves.

That's a good summary of what I found confusing. I like you suggested 
message below but I agree it is not worth messing with it now it is in next.

Thanks

Phillip

> If I were writing this (but I will not rewind 'next' to do so),
> I'd say something like:
> 
>      replay: improve the help of the `--contained` option and document it
> 
>      "git replay -h" explains "--contained" as
> 
> 	advance all branches contained in revision-range
> 
>      but it may be unclear when exactly a branch is contained in a
>      revision range.  Because the command updates a branch that
>      points at a commit that gets rewritten to point at the result of
>      the rewrite, "update branches that point at commits in the
>      range" says what we want to say more clearly and concisely.
> 
>      The "--contained" option has no description in "git replay"
>      documentation.  Use the improved phrase there, too.
> 
> probably.  In any case, it is a good exercise to see if the proposed
> log message can be easily understood without looking at the code
> change.
> 
> 
> commit 9ba08b30a117e6925a9e5e87c92b37de7396d3a4
> Author: Kristoffer Haugsbakk <code@khaugsbakk.name>
> Date:   Sat Dec 13 14:46:58 2025 +0100
> 
>      doc: replay: link section using markup
>      
>      Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
>      Signed-off-by: Junio C Hamano <gitster@pobox.com>
> 
> Looking good.

