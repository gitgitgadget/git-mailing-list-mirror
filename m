Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E932A2AD11
	for <git@vger.kernel.org>; Tue, 23 Apr 2024 09:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713866258; cv=none; b=eAA9OtVHWb9mCS6rhHy4BS2X6wS1d5+krXKH6hFk63lOlwEIUYNSSOZHK1KJstyDDCeabKjAw8S+jMHr722IKE5jAMpqQUyNnpY+92RtCI/5pQ6JbEV+VSz/mGyLIf+rthsm3nHZZiPT8efiWOKS9hrIV/DjrUhSsCOJrgRc8hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713866258; c=relaxed/simple;
	bh=8vwlz0VhlgZ7EtIAxiPoeTQXPbe3vTBZMi8d8qJ3Fdg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ehg4/3LQAV/Tz38tHxAbSu3CsWXbZOl0jm3+iOuL9SpCo3YKJuMcklaQBrB34iIhlKKtrE40aeKgxQcbpajHfpsUz6ubG80u74Mkyd7IkjiOACxJjcLA7v32KrzDFwKlTNezqpFudJDcwMi96xAxiSzGxOKC3Pztk7JaeIaaCyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9qk6qD4; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9qk6qD4"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41a72f3a20dso12952615e9.0
        for <git@vger.kernel.org>; Tue, 23 Apr 2024 02:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713866255; x=1714471055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aaxoM/hfANI3tZu0rXzlFCv7VsrLRmUo+4EJU+jEnBk=;
        b=H9qk6qD48sMxsaIQPVEH2iKhT0sDtGevN1CPolcNuVWMFEoYdJKmQAfvxewYQJprrY
         2XCkZ+T4pdWLWJ0TOR4FboXtq52CunMIfh5iNk1DSphRnxILpnVaLc8fFToS/25Yo4Ar
         ZfWyS5r3tQz6NMufmw95+TWMNyKVbkKP4E6X9sgrQLFNiTjlK7Q3TBrEmMtlmn0LZZ5f
         ef5Vr3ysyOpbik9LYoCz8yaqPOlPbalUd8tg7YfyIkjqhEYJ+V5ZG/QjXcI1XLE+1AMn
         a+BlWr0UPp9vF4Q/v9wyKcu5vkbe9h78XsNscz4jvaux3STqkIf3lhgE/Jhk57IVyzRi
         RqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713866255; x=1714471055;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aaxoM/hfANI3tZu0rXzlFCv7VsrLRmUo+4EJU+jEnBk=;
        b=WNh/dTcaAwcoidCLo2iB+EAIgRK8xowz3Ie0hH6Zi7K4t9C3EkzGlv1va/79OxSC3Z
         +9uJBw7tj+9XDw+gxUeLk7DiHuNewBz7EWDNuob+U9XzCGoX45IAJk9kLx6QkNPBD+ca
         VNz5EEOULePTRWZI0GpVemXX4HIzeY1zA9baAnypX8ODQcdAvdiSp/eblC3fCcxiCszm
         zyzYAzMjTFXYcdJdK8ZZTj9LElKIsYoEa3XwuvTXViEVip8tK7c0ZRIUoy+7xfO5rW2F
         mMIqeq1aX9n7OiexRiA/sDd0IIm0fbgLiUz26OyNJMwhTOwyHcQddOokWKR3I+qr8gTM
         /lvw==
X-Gm-Message-State: AOJu0Yz2m8EEDsDAX/MKzyMIPmAk2mL7RonRPRmS8I84lotroq0bk00s
	7Vey1aEunNV9Mz5WTSXIseC5SVoGYxqccTYfpG3T7ydeKCcQgabO9yzGAg==
X-Google-Smtp-Source: AGHT+IHMEVXvM7DQeIoZQUPEBYFChsTWDdiWJ3Wax28WA6JbXwmmQ3FP+pyZhKJIoWs498Nyc+W0BA==
X-Received: by 2002:a5d:628b:0:b0:34b:55dc:9eaa with SMTP id k11-20020a5d628b000000b0034b55dc9eaamr1901866wru.65.1713866254868;
        Tue, 23 Apr 2024 02:57:34 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:701:9864:4109:be00:6ff6? ([2a0a:ef40:62a:701:9864:4109:be00:6ff6])
        by smtp.gmail.com with ESMTPSA id v10-20020a5d590a000000b003437ad152f9sm14032183wrd.105.2024.04.23.02.57.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 02:57:34 -0700 (PDT)
Message-ID: <cb2ffdb1-5e6c-4dd3-89d4-f0b31f2f17ec@gmail.com>
Date: Tue, 23 Apr 2024 10:57:31 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFD] Libification proposal: separate internal and external
 interfaces
To: Calvin Wan <calvinwan@google.com>
Cc: Git Mailing List <git@vger.kernel.org>,
 "brian m. carlson" <sandals@crustytoothpaste.net>, rsbecker@nexbridge.com,
 phillip.wood@dunelm.org.uk, Kyle Lippincott <spectral@google.com>,
 Josh Steadmon <steadmon@google.com>, Emily Shaffer <nasamuffin@google.com>,
 Enrico Mrass <emrass@google.com>, Junio C Hamano <gitster@pobox.com>
References: <20240422162617.308366-1-calvinwan@google.com>
Content-Language: en-US
In-Reply-To: <20240422162617.308366-1-calvinwan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Calvin

On 22/04/2024 17:26, Calvin Wan wrote:
> The first idea involves turning `strbuf_grow()` into a wrapper function
> that invokes its equivalent library function, eg.
> `libgit_strbuf_grow()`:
> 
> int libgit_strbuf_grow(struct strbuf *sb, size_t extra)
> {
> 	int new_buf = !sb->alloc;
> 	if (unsigned_add_overflows(extra, 1) ||
> 	    unsigned_add_overflows(sb->len, extra + 1))
> 		return -1;
> 	if (new_buf)
> 		sb->buf = NULL;
> 	ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
> 	if (new_buf)
> 		sb->buf[0] = '\0';
>          return 0;
> }
> 
> void strbuf_grow(struct strbuf *sb, size_t extra)
> {
>          if (libgit_strbuf_grow(sb, extra))
>                  die("you want to use way too much memory");
> }
> 
> (Note a context object could also be added as a parameter to
> `libgit_strbuf_grow()` for error messages and possibly global variables.)

I agree with Junio that this is a good route forward and that we should 
not consider removing the wrappers to be part of the libification 
project. ALLOC_GROW() can die so I think we'd need a way to propagate an 
error message up to the wrapper even for relatively simple functions 
like this. For the allocation functions we'd either need to use a static 
string for the message which is not a good fit for other functions that 
want to dynamically format their messages (for example to include a path 
name into the error message), or pre-allocate the error messages.

> The shortfall of this approach is that we'd be carrying two different
> functions for every library function until we are able to remove all of
> them. It would also create additional toil for Git contributors to
> figure out which version of the function should be used.

Hopefully it should be clear if a function is part of the library or not 
so I don't think this should be a big problem.

Best Wishes

Phillip
