Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795710604;
	b=bhSKg75dchR3HNuOsrc2afg3Idwzonl89UQjWmJlQrBWqTTwnqHMt3lXa+yhQEawJ+9D
	 xyvDyr+bmLLIG/7nb2Tu/8TsYdwsKXLSBIv+E791BkqHDA+AN3RaVe1DmogFpPbGSc9b0
	 s0SQz6krHEqIYPqtrgX67jq2x0qFwwvPdUpRiHY7HGz18gLRPiYrKszm6ihBxr18bZeP9
	 DbYuzobneahx4auEhILIpvPvzh+LJb+2To5D2uvuS0vkw7NerOR3wgHQSKr19YuHrnFcH
	 yjO+FaNTJkZQgC4jlUyDp3aZHVsmdRWWpMRISLUFtZvq0seK14SgWBF6ZZFvc5nk5YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795710604;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=v/ans/a8EbeNhTShuhbrmmp3H+YqTQ0AsHhJ4ORuE6s=;
	b=SbdvKBXuP/XMT36X1Oz31P4h3OI4d2GcEJGYR2ev7TucScmgR/msyfoduCNnFQJrBb/U
	 M9OSs10ubMkWAlVKPctVRg9eyMw9eQUG4WcN/1hDSQdNw+oj5bJzT0kxUcXcKGTj0UviB
	 m8Uai4V4aVp1bkwlkR5OJoc75Eqfgmx0WVusa4ZwUoAmUGGFDvunSoQW6arPUwDDIo7Kk
	 AW5/rGVc26nXsc1G/pMirhHMtoVMaWLETnz+MvQiMGFyH94xA/kK9oawBuz1NtHBoYNn0
	 P65VI7L4ZOprRuB8mMhV/Gyl4izxQEroTwcUgau/PEAeiBbhsYXWUKntFPIrZ6RtSaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nBhlHznU;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6D1606A326
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 16:30:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C6D1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nBhlHznU
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4bba5e17cbeso19221545e9.1
        for <git@vger.kernel.org>; Thu, 26 Nov 2026 08:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795710602; x=1796315402; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=v/ans/a8EbeNhTShuhbrmmp3H+YqTQ0AsHhJ4ORuE6s=;
        b=nBhlHznUt+MjtJYvS707JGRKQ0FCe87m+bi/1BBWPZ2PUpwQbfn3LRTdP9b4ADyYU6
         9xBTQE+H3RqBUxOJBoJxYHGS3bFvZQKbW/NapDz+uwkuMN4Btdd06omz+rT4PJNAuCXd
         1E/1OeV94pR9swH5kPPz07lbTz7+qmI/EAjw0Wsd9rq5D2ANtlN0LmF0dwcSrdHR9JdL
         XeY7y+gwgcSYxUnoKDXZAnuCmFaT/4qNCexUITZ2P31/X4/135ZmLgIZ3dbDSJi4+2kx
         yGOZdtIIkyC5y9BqyHQ5KJi+t3/5hmsy1neKf50f1e2F/qOtuZaU2NUPSVjPOT9by3r8
         0TnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795710602; x=1796315402;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v/ans/a8EbeNhTShuhbrmmp3H+YqTQ0AsHhJ4ORuE6s=;
        b=LFEwUVxKFcIMR7gEvHlsI0OsVy+OiUT64ex1WYVwHrBCuVI8Ba610QaBgxC+tYnxxq
         8wYOqmPK/17fUT4/jZogIhgBBFx1+bMdRC5c0z2Hw2XtoAkFNynPz8wr3L6G1uqR3VZE
         x5gHj8Ue80X/Z8sTMcADSYYDH2ZqZ9o7yf9VrUQAey6RFckuT8WvnemThyNJti8LVuoT
         O7OYKzxN8LWKlNr2uQ2bjpssu1oJLFHL+6blF2pzRjRe8hgOluCZaKkPFomC/a4ta3c+
         CQZjGETfwp1msOg92aK2ZXU4kyMKKDd/YFe0aObDxvmUdU9gW2EpTDzF9fWv3WIE6bR6
         ASAQ==
X-Forwarded-Encrypted: i=1; AL+hErFz+dBEpdx1Xk1hoo5KEeCmY5Ytphoci22WcdcOt8e/K7v97APjBXTQhc6UqPGr35UpYGk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8lDVWTNu/g2z7Yj5i8tRx3El7BclX7nAsQoJmAlkOJHbffMefc
	tZsX/+NYaFyTQdrkfLIVyU/YMQvNuuIBjpW/YmmJiyDvSAlrHTU6nNlC
X-Gm-Gg: AZFdTZdJzfbS82uHggfxSQ/4JCgTaNsh1FM5f/fOkyNMNz2X62yiirnbjsnKPmm6GxN
	pvcf6nPacXLBcTuRxaSkUZaxOXVIOTr/ecssFTeB1TC2VtpygFE456dSbM+Nr/qv4d3Oj+UIo5J
	8OivEhCJl3aLlSi4p+cw1610Uqnz0z7yogxPP0SsjFcw1y9nqBH1DTpI0MDlOZZsfb3bSwXf8w7
	Aml9v5XDaPUg12DQ33oIAPMzVZNTqviR4zYwmGxYKVZGErHwLhzUUYahqiJzblura3dEtxscwGP
	R6XiExiaquqMCtPKV4pDFiHmm34+jqqqkNzzk2dwonxfWpQQwl/j2VNPUHL+xbvj6XD2gu/74nm
	VT0eMkpLDFxDZACdQ8ilclROjGP/Ei0PP31AfD5b+66q/QoRFhzFsFAmZEG1ow+PJVWcBR9pCi8
	LdoYdgdtDcyurXJduREhCUaGQVhP/v7B2y0QZ1J+o9Wv1VcFLQuS0EZDN24kutDD/Y9eMvspa4x
	zTfHAYRSQNjARTYsfXIXr2c6dK49KDW0e/gB9IFbYBFiRFGJkHV//VLQFAonx0cNUaHaFQ07wQB
	2cITe4+CjGWvd2pITO8hkHojtP/H/PN8F98nNud0sIx107Op/0iG8N8NgR3YCs97mmS3fmEcUo8
	v+DaxABg=
X-Received: by 2002:a05:600c:1548:b0:4a1:e00b:a10b with SMTP id 5b1f17b1804b1-4bb88800020mr465184705e9.7.1795710602275;
        Thu, 26 Nov 2026 08:30:02 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bba6a0d65fsm140502435e9.3.2026.11.26.08.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 08:30:01 -0800 (PST)
Message-ID: <9e53b717-fe1d-42f4-b359-6b7a42a58e88@gmail.com>
Date: Thu, 26 Nov 2026 16:29:57 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] var: add GIT_COMMENT_STRING
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
References: <fa8b80af26481e0dc96fd8f80f3c7ba84f60f9d4.1795516651.git.phillip.wood@dunelm.org.uk>
 <b8c40805-90f2-414c-ae70-e2f79a19170e@app.fastmail.com>
 <608b25cc-6ec8-4f0a-8eeb-863ed44bd0db@gmail.com>
 <b9ab8baf-0b87-498b-a37c-64af0d06b9be@app.fastmail.com>
Content-Language: en-US
In-Reply-To: <b9ab8baf-0b87-498b-a37c-64af0d06b9be@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/11/2026 20:09, Kristoffer Haugsbakk wrote:
> On Wed, Nov 25, 2026, at 17:19, Phillip Wood wrote:
>> On 24/11/2026 15:02, Kristoffer Haugsbakk wrote:
>>> On Tue, Nov 24, 2026, at 11:37, Phillip Wood wrote:
> 
>> Perhaps saying "as set by `core.commentString`" would be
>> more better as it does not promise the reader that the config
>> documentation contains additional, useful, information?
> 
> Yeah, this sounds like the sweet spot.

That's what I've used in v2

>> The documentation for GIT_PAGER, GIT_EDITOR and GIT_SEQUENCE_EDITOR
>> mention the relevant config settings when describing how we determine
>> which program to use, but the documentation for things like
>> GIT_DEFAULT_BRANCH does do not.
> 
> After reading just a little, I much prefer the verbosity of `GIT_EDITOR`
> compared to the terseness of `GIT_DEFAULT_BRANCH`.

In a way that extra verbosity is because determining the editor is more 
complicated than determining the default branch name, though we could 
mention the config settings for that and also GIT_COMMITTER_NAME etc.

Thanks

Phillip

