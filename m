Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC51C3624BC
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 14:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774361482; cv=none; b=HLMH078CQFc4W6u3ahq5MonF3y5ehUhtv+6aKweXbfKkjN9lmE4p/JSBuIfXFOdbbFmjw4wJwkJOJBqsB5BIC8PIzMmqKPd7NURJMMlbxsY9E6WGQjqRpzwAXxZpRg1koceGxWVTG+1uM2bDEx2KYCJeeqZtXSbLtmoTVBni/YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774361482; c=relaxed/simple;
	bh=xneOmz6xoBANVNFBq7x8MCpw25E7IJhSjNiVHYexVIg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nlohPC/yoQqFxaV9T38r7bVrRUJ+EWGtWR1KGNX/eAGPwZJ234J5JFXbjzAPD3P01bgys3jyj5upAUh93EDnfpQ8FiBcJKb3J6EsYT0KjRwRVCxFScvC9xBtJRDtJcUsa/eKSTJqoZ3Cy6EkScOEunWa4olWjSsnzDOQile2+us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APgIC6tK; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APgIC6tK"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-486ff201041so34627505e9.1
        for <git@vger.kernel.org>; Tue, 24 Mar 2026 07:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774361479; x=1774966279; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GkWm+fKJg/C2G/fMmPVlLVNEOHo5oHMVjzJQ30rCyM0=;
        b=APgIC6tK8PGXT20eVhsWgUe2zBooMS4G22cXUUOlPSTGP1Lbq4F7/aoC1L9XzO/C8Z
         bloIvw1WnfdSrHICdI2ayM+oz4c3iW0eB1J0UFlfv5VQVB4J0Pxv4HhxE48+bqaeeNuG
         OoAjLPlzZO/jjkEp0/u0PKViuf29SJzJ5uGR0ksLkuatWTfsU9O9WI4Z9aPfQHdCwfVA
         42Ml9TQM54SwSe2/00EgouXq2HgRV+seW47Z24kOGC3AL6Ron9QKVXhNkIR+Z+GaAS4U
         gWSV13GV56vg+ks847mJvMAY4xRqPSYKnY6l+p6M89aKY5YZ+dy0mjWuifwMWz/qmWqv
         eE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774361479; x=1774966279;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GkWm+fKJg/C2G/fMmPVlLVNEOHo5oHMVjzJQ30rCyM0=;
        b=bE0sCNmrDTXekelQnPAFHxdfuaAe3PQ235zUBhC8+N9m9l602dItt5Ij4Uuz9ACse6
         rQX9xcKG3eYR5VLOMILOojTdrEVtmpcydgh/pN3h9ueXWehj+4cDxfOokLvz8VjFgxDD
         gDIrwtF7iIzowaKTPG1NnzAF4+ZMk3sb/nbC/ruuE4BNGI3tDQOqYCEfNoqvbC2TUW+P
         vUl0MvxiyRjohy2++C7juFdBr5Q2/Vebp/e/h982qyicKI+gO5/FGHfgwjocvBU2KPlu
         X8am9fGmq6+mrw0lll8X8VjFSeBvHbq6mt7iyKXBc21kEheZhkZamq2Z2ZdVUhiDb2em
         ELrA==
X-Forwarded-Encrypted: i=1; AJvYcCVWATOoV/TagWxr9qFfj++2p61nrkaml9rZWZpgeFsBWM4O3UbzAc4VVOOAihy8MEuelA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjxY1ta+QqudIviiIvXWGVARD/9nBEQ8+v3181rz8fKQErHFG9
	6gotzUxT5OwWcssgGqedzUH+lEfpj0KblTwvmT4qEQbdxgONr6eEUKDUMq3Btg==
X-Gm-Gg: ATEYQzwJ9OiQmGDs8OBotHpj1369e6yazcEZZIW0DyAakc5IpzgXBAZ3le6hedGMOxD
	FFtSX5cD6DsI9+ZRZEodxTZHo+x2mFaIPzZgI3ryouizS4iQrNyR9/vVJpFi5zvrhRhmyUxmaOI
	dhrmbpSm3FQWr2ifL3btP0X38tptkOfAoXlaGFo/BJxhphmVdTFyKzHFrFTSXRUXiOeythdi1jt
	iqZSdc6ZIxjV01aejkXvnorBrOTP2PXMF2yNa8YC98MtMSXIGMmeabLzvS7mYlV82hOtlSOjEbz
	V5AzDgCEXCts/ebOKjyQ6iLQUVelXvjL96iB+tGyNAEPZWb6VhLwwn3LIDWDICfAoneLixZUYSH
	KntDf+CGH7LOyZFQDl80KhKdwVmdFZ+5aB7c8O74KG+AlTlaQgxvTV6nqXkKT5vz3Cg1wMZqGF6
	NMBK+qeSGS/q7n92TbhhECZVEAn4r5pbX658/DFnC5KYOW2vdv0Fr8uP5LKWA5YOymjsjn8vf/J
	4dfmQ==
X-Received: by 2002:a05:600c:a085:b0:485:3ec6:e634 with SMTP id 5b1f17b1804b1-486fedcc6e7mr233061645e9.15.1774361478998;
        Tue, 24 Mar 2026 07:11:18 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48714bc9ef9sm10846545e9.5.2026.03.24.07.11.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 07:11:18 -0700 (PDT)
Message-ID: <5e7aa1bb-1eb7-4b8c-8bd1-032be6a02a82@gmail.com>
Date: Tue, 24 Mar 2026 14:11:13 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/2] rev-parse: use selected alternate terms too look
 up refs
To: Jonas Rebmann <kernel@schlaraffenlan.de>, phillip.wood@dunelm.org.uk,
 git@vger.kernel.org
Cc: Chris Down <chris@chrisdown.name>, Jeff King <peff@peff.net>
References: <20260323-bisect-terms-v2-0-8d6bdb2c9c7e@schlaraffenlan.de>
 <20260323-bisect-terms-v2-2-8d6bdb2c9c7e@schlaraffenlan.de>
 <d366fc82-efcc-46cb-9536-cd38b1fd18d4@gmail.com>
 <888f8670-856a-4ce7-8177-da78ba4f0c8a@schlaraffenlan.de>
Content-Language: en-US
In-Reply-To: <888f8670-856a-4ce7-8177-da78ba4f0c8a@schlaraffenlan.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jonas

On 24/03/2026 12:30, Jonas Rebmann wrote:
> 
> On 24/03/2026 11.49, Phillip Wood wrote:
>> If we fail to read the terms because there is no bisect in progress
>> then term_bad and term_good will be NULL and so the next line will
>> segfault.
> 
> My understanding of read_bisect_terms() was that it never sets the terms
> to NULL, that if no bisect is in progress, .git/BISECT_TERMS does not
> exist, and the terms default to "good"/"bad" here in bisect.c:
> 
>      if (errno == ENOENT) {
>          free(*read_bad);
>          *read_bad = xstrdup("bad");
>          free(*read_good);
>          *read_good = xstrdup("good");
>          return;
>      } else {
>          die_errno(_("could not read file '%s'"), filename);
>      }
> 
> So is a NULL-check really needed on caller end?

Oh, sorry I'd misread it, you're correct that we don't need a NULL 
check. Looking at the history of "git rev-parse --bisect" it was 
introduced in ad3f9a71a82 (Add '--bisect' revision machinery argument, 
2009-10-27) which also added a '--bisect' option to "git rev-list". 
Looking at the implementation of that option I wonder if we should make 
revision.c:for_each_bisect_ref() public and call it from 
builtin/rev-parse.c rather than building the refnames and calling 
refs_for_each_ref_ext().

Thanks

Phillip

> 
> Regards,
> Jonas

