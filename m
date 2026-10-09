Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2A24DE735
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 13:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553061; cv=none; b=HOwE+YOLyW5S4515tURfqNerrUM9TpL9kvP2EqVTcdv59EScLk57P+5FFtabWXNXO9vwygOlZzi9LXBz0L2+MYJtKG0raHjwrxf3liCUmC9GGn5f+kwmgQipLLydnJZoLdLMiI6fea2TNjSZevCK/HC2b3GosFqpRNIUdNB1m68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553061; c=relaxed/simple;
	bh=2iXH3tRMX9+H9QgOLqt0yyHYuBVDswHKhWYJPZwz+PA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pAIR6etrk/af0eh4jCfAMs7ZfgRytRQOGk5uiJyBDKCuNXKqVXr1Ciye/E5dp+9pe5sTj4xfdaJnJ8OLOClw+QO9RGhJzPv4bTs4jQ/9vZwEbk0UHhmG2E+QN8GmoJZSQdA6QpCZBRwxB9ej1UXHeFDnW3zt5hjXDW5hqr//EPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p6fyyBAm; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p6fyyBAm"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a16af2a232so34957065e9.1
        for <git@vger.kernel.org>; Fri, 09 Oct 2026 06:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791553058; x=1792157858; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8IvA65wjQ1ko2WTC7XDHT6pJZAPx4zQy88VhntXdAEI=;
        b=p6fyyBAmbPDXNKhbaX/15OYVQD227cP+NxSbTx+IWxk3885nQMQfBoYqF+wexb1C1Q
         Qi/6TRkSYEO6rqFzBKYIsxFN1pLN6suLqOq70SZWVdJc7S0g3zTbTOydJLj8ww8eQriM
         RH5G6r3Sdw2r1YCW/jGcn8sT7d3UK4xFYNAvNaq8ebwajKOBWNekZSJVElU1mTwsMn0d
         qTq7yl3ZewuqMpGsP66JCitXhftwltckI0yIwe+Ji5cEVzy6neA8RUZet+NnXi3wt2Ur
         5ZlGbpyqSXo4nSC3xyrvZY1yofOk5tZFDJDfLlGNvv02HNEA6RlUyXIdGwYr9aBntswR
         Y1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791553058; x=1792157858;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8IvA65wjQ1ko2WTC7XDHT6pJZAPx4zQy88VhntXdAEI=;
        b=UvDuEDJ81YUJryZpI7CB+ae5AqSnKjWLyo57ddXffQ9uvUAqwJU5ntHjRfSk1UjktX
         c8NjGppA6yXoesnfpz9gTKIzwCczdL3pEEjB/UDKGkKSvp7fB66ADqy/OrZLUQDX3daO
         r8qXZ2WAqjNvhXK0OvP/W661Jznk3y8OX0e3RQJrLge+CNdqqikZxUjyzZJjy4dPMP9g
         0QVEe3E33EUezO/b/lJHDgRdIiRZmhEdHTGCbvulDgN+ofN3ozhFycywIDg6tmoMkRA/
         rCdIKThNwhsl4+eeo3+My62owb3gzRfd96HezjvQ45/TKHIJpZksmovaQs1x1W8dC3ks
         Xiuw==
X-Forwarded-Encrypted: i=1; AKwUvBwlC09uTsgB8e+9OJVssiJ/D4j1NlEuedFFzVam5XhyVe1XftH1H8XHxZ8k1aDooANdeWY=@vger.kernel.org
X-Gm-Message-State: AFuF++mvxtnzjjFUbXLbKcbCl56JkvWOn+rtVBROWXUgkV7L9YDx8H9C
	Ei8bjdzh9LLHa4B70+sVYQYqtD5qALwDS5YWBt/NgrwHzCsI2uxHhuo8y+UgCQ==
X-Gm-Gg: AYBFou07pjZVe+d9gKZfppq+JU98PHEDQk19TM1NLC5zjE3CnU5qYp+Ohy7ZbArAbhc
	Hh7M1Etqjuid2f1s8zUw6O+PdnFlZ0cayMe6bIEnm6OTUOsuMMpGISOb8DYqeMSvPZCqySgG4Oy
	GobQx+lgbJ08VuFseGkDRc9JmbMQTjPmRFvavvNlChZRD7mHWYmAE3VwpC1i4pO0/lVwBEcb+3i
	9LlPEEUQzcqpCGSN78DqNdsDP5he77UEGFZLVD+7P5PhszVG2oIQHSboXw8oCpZ9Peq5ffbCP4R
	vn0cr2ZyBNUBNUxgI9pB48+DPmfBBONwld1yjN76yT4gaCvvkjx0TqiP8OlZepMWAik0LNUl4+r
	ln2oARTsMJWBiX/upuGk9S9toYx9B1s6I8vQupYXBRueMzdxfpxsXv4nUEObjMF+iTZWcth9wWo
	Rd83dn03OIlit8KxvYkn1RfHNyDWIwVvl3nEdpL5uap4hhF9MfUuyGmvFtembfx+5jH7izb9+XG
	Mp8hUq2dG0P/Gb1P52c5D/xYs/jNBogtR8yLNfTjolAXGykl1J8
X-Received: by 2002:a05:600c:3b29:b0:49f:ce78:3561 with SMTP id 5b1f17b1804b1-4a18e49c420mr35914455e9.18.1791553057861;
        Fri, 09 Oct 2026 06:37:37 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a19303d518sm4417515e9.0.2026.10.09.06.37.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 06:37:37 -0700 (PDT)
Message-ID: <500a1b40-b877-4970-b279-f0a6fb42f810@gmail.com>
Date: Fri, 9 Oct 2026 14:37:36 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] branch: let --delete-merged find squash merged branches
To: Harald Nordgren <haraldnordgren@gmail.com>, phillip.wood@dunelm.org.uk
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
 <CALnO6CBwWy3aafyDJPKFk5vuWy2EF1n1Oc=W7+RVAE3rxpXwiw@mail.gmail.com>
 <39a28064-1698-4971-a80f-4a4c4dcdd8d9@gmail.com>
 <CAHwyqnVoMnO_fYGJ0N29bQv=Lh5naZ0jc5uSpiS2urQMZVG5-Q@mail.gmail.com>
 <61ae371a-225c-4400-b878-8547547d1269@gmail.com>
 <CAHwyqnWkTvicU+U99j0MzzUUXeVnUj=FJJwUDR1F7DGk1hmtrA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHwyqnWkTvicU+U99j0MzzUUXeVnUj=FJJwUDR1F7DGk1hmtrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 08/10/2026 19:42, Harald Nordgren wrote:
>> Even an efficient implementation is going to be a lot slower when it is
>> trying to find branches that have been squashed, so I think we probably
>> do want a way to turn it off. That's especially true in partial clones
>> where we'll have to download a bunch of blobs to do the squash
>> detection. So long as it isn't diabolically slow enabling it by default
>> is probably fine.
> 
> A bit slower (depends on how much!) could be worth it for improved
> usability. This is not a command that users will run multiple times a
> day.
> 
> I would hope we could have it on by default and add a flag to turn it
> off instead.

That's my hope too

> For partial or shallow clones, we should probably warn the user that
> detection won't be able to search the full history, and offer them to
> unshallow, etc. It's very reasonable that some parts are turned off,
> when the user doesn't want to hold the complete repo.
I've not really though much about shallow clones, but for partial clones 
I think it is perfectly reasonable to go and fetch the blobs we need to 
calculate the patch ids and warn in the documentation that it can be slow.

Thanks

Phillip
