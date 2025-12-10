Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FC31FA15E
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 09:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765360702; cv=none; b=e8rGYl5LkZOtElhM4Gqx1gvkK9KA3/2lRdtpYFbWkwmpmJRX1u9EkBr+z6YbYmaxQAoKjXqZgKE1xGmfq+2mEAensGrYh/65/nCf/w/nYnIhoIEvrePUyhWErG+k7o+Xhswz7utVlfdJorgFOixJsRbuyTXxtnYwGVz+cPIcoNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765360702; c=relaxed/simple;
	bh=Kl+y1brG9lDnGfNn3ogoWTxwwCclFGWp4lZUEcEbplI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uqe3r+rdVsvB7mZKF+50ddv7cmVij9kbiOtB4hQj3Sz5tqok/r1xosaz5uY/n5XuglRmDmaxRYRKoePF9lqLs1mMPWFDdlK8BzmyAiTmwGfZL9d/3sTiYMnQGnNIsl/uDH+0IL33qcFkUWDYTjq0aNWxb2pdltu7IuFBCItUA4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+r+MaDr; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+r+MaDr"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so56022785e9.0
        for <git@vger.kernel.org>; Wed, 10 Dec 2025 01:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765360699; x=1765965499; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8yZ+lYMBYR8r0kv/2BMbUOA6wtiTyGQJsl8nlsU448A=;
        b=N+r+MaDr9c4BVfe2Y7Y/blkJSV+lA8N7NhrWbu0Ym0465D3fIuV6E3K+uuVOln2lf5
         LwE1NhiGrtkrKWD6Av98V4lTceUY42VyKes8602kxwwHpewrKgJN5zKsfL+E0ackunZJ
         Ycm8va0i3GSZrTx9P92zU3lWpQ/OCxskOMBcYAvQnp1jRa/U0arycvAymnFK6EW5+m5F
         SvIlHPMDqGdmPGLblRROadbCv5PskpORw/zJveM7iHSJ4/Rh0a3isj6RN8Xuhn22uiqz
         8tM82f6KxMbc27YGCyKeKF6M/uRL5puL3SIYqQwlQD7ITg8K/r9gVdYTDXtkHo4vLoZg
         y85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765360699; x=1765965499;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yZ+lYMBYR8r0kv/2BMbUOA6wtiTyGQJsl8nlsU448A=;
        b=iOCY3heTMIfwRFMt36P1ItKFtpU/esqCf0rCGVIkfdsg4VRnXNxI+T2rWhuqegfHYA
         X4Ca8hT0cfKT2w6YvCfm8AyTbqsAVOns0tyNhFEapJ8qGLjRcGjCnkyTQGZJ+fsaR4Ng
         AuKtwu88u6knu3HRDPXXuJRbWhtLm6Ue2yJ+4OirvQ5HriXU9jx2XtmW/h89OUE9tEsK
         M5VK+IK8Cf0v/EmFFcgOTW8TF+DGVj6mRzEIudMPM0LPCk3/i6kkMKpURrO/XSiNLpam
         mxQ2jCqLWw20JI9LhG2zd4uP3OtiTRjZ7fUF6z+B8cUo4tx+ZROaUZHFFDfxOiiOWRlr
         Xb2A==
X-Forwarded-Encrypted: i=1; AJvYcCUGFQLrMSj4VXer/Q7P8OoCCWxTsuN8tGINQCpfAQeRKOs9BMJC3g4SrfNbHVyPxXFaZUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsbZY1aJTBzmK7g/qQIO67hCpZiio3cgY9pZSeG1C/MzmyM/Nw
	j7oj9d5r1Xj8Q17G1RATTtJpZNMMt8LDy5lQn2RLOoLMZlVXVlhteR2/
X-Gm-Gg: ASbGnctKvSnOribV9Q/IULTC5S8lmsX7qHehVb17W36CetNxEO89F0sgSaHLnvdjktL
	l6mFN5lXk+q6S5T/8luRrxlCf8DmKI4rGfuBCGwo8GLnVribk/D2dMJesIzurPtFXZcfiavlQtV
	GhW86eUqiiCxa1uSTQyeLq1qYUWX6EXx1k6lf2iRQQ644fxO3LPEYKgQAGJnr1WWgDWlTPSwFH3
	UGNNphyOoWYmZ4oEUssp7dZnJkGlZ2B7Lj8uQuzgAbnFEblNs66hPMaU+Tred6zn6/TTZTlf7ph
	ugNi5TfZqxRBlL6bCxthQj0vBmppOwxmDu/H6JD545IO9vTzTc+Qep6VAJUmwgI45WkZMdexhOH
	dpciapCzsj6qm1RZUqhPYIYKFva2kaLxOu86zVdP64iPFn19nl0+57ekYZQjWExQV11SNg4aP1N
	fLN6MT1wRHZMIXTvxtq7W8e9Jjiv3ZDrysJuU7rEcu+ukUvLy/VdjocE4wgsBHSYQ=
X-Google-Smtp-Source: AGHT+IGpRPEsM9t+Mb9G0MhPXl+g9Cp6GsuD4CqoPM/bE+R40kDq6okOATyqVxFpdSyFPYZj1NOzGQ==
X-Received: by 2002:a05:600c:190e:b0:47a:7fd0:9f01 with SMTP id 5b1f17b1804b1-47a8380641fmr18404095e9.16.1765360698910;
        Wed, 10 Dec 2025 01:58:18 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbfee66sm36471403f8f.11.2025.12.10.01.58.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Dec 2025 01:58:18 -0800 (PST)
Message-ID: <bc01706e-b9cc-4cd4-953a-971a3ccd6c79@gmail.com>
Date: Wed, 10 Dec 2025 09:58:13 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH RFC 00/11] Introduce git-history(1) command for easy
 history editing
To: Matthias Beyer <mail@beyermatthias.de>,
 =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,
 Martin von Zweigbergk <martinvonz@gmail.com>, git@vger.kernel.org
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <CANiSa6gXbrZaMLVq-AAg38sm+7qgzn4w98WWowLtUHA2P+BdLw@mail.gmail.com>
 <aKs3tqjE510MF0T-@pks.im> <aMsWL2cSoytbmRjA@szeder.dev>
 <4m6rmefbv4hftclimitz5rp6yapswjtnjsxymrsdkuan4jbg3u@dm5jzdiq5cxz>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <4m6rmefbv4hftclimitz5rp6yapswjtnjsxymrsdkuan4jbg3u@dm5jzdiq5cxz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Matthias

On 03/12/2025 18:18, Matthias Beyer wrote:
> Am Wed, Sep 17, 2025 at 10:12:31PM +0200, schrieb SZEDER Gábor:
> 
>> Let's suppose I have this piece of history, I'm on 'branch2', and I
>> drop commit B.  Which commits will be rewritten and which branches
>> will be repointed?
>>
>>     A---B---C---D   branch1
>>              \   \
>>               \   E---F   branch2
>>                \       \
>>                 \       G---H---I   branch3
>>                  \
>>                   J---K---L   branch4
>>
> 
> Just speaking as a user here, but my expectation in this scenario would
> be that rewriting B would be denied by default here, as branch{1..4}
> would be rewritten although I am at branch2.
> 
> In the scenario at hand, I would expect that I can only rewrite G, H, I
> while on branch 3 and J, K, L while on branch4 (without passing some
> extra flags for "yes, please also rewrite the other branches").

Is that because you have branches that you don't want to rewrite because 
they've been merged upstream or is there another reason? If we start 
rewriting multiple branches we should probably check that we're not 
rewriting something that has been merged upstream but if I rewrite a 
commits that's an ancestor of several branches it would be very helpful 
to rewrite them all at the same time to keep them in sync.

Thanks

Phillip

