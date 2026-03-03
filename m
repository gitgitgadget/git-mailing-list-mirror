Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2601388E40
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 09:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772530088; cv=none; b=iBii1oQfHnKAL8utLMFU1IP6NEpj/sMVpy7xNZPkLeaOLlJrEZSNhtKwmdcbsDSMEXFp/q+VZ073IIxGiIy98A/pwKehCPCgDAW0V9Y2F4K4vuQfjpkIEeWn8TIkQ7dqg9y7knmNeWazvSsXzxzCTEpd5mGFcaJX19Celo2Y2so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772530088; c=relaxed/simple;
	bh=GPAzT+j/GN87stelsvC5+JUOhW30Mh/B6pBBtKdc74s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ILKWx2TsSBDDwodjrdaC+QJwlasSMYbeq0eWNn68biyMBFb8/HgQey24aKLUwmRoiqvkMyzFaLZchR3aMR8zVcyL3+VrrDkFszL89IEyYEJLWUkMIBUxvofp2OHjL39V2z5lBgCxwedllPIeD+Rfeb7qzEYDp1ihSyi3dDX7iS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKySZXoO; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKySZXoO"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ae471aabdaso1028915ad.3
        for <git@vger.kernel.org>; Tue, 03 Mar 2026 01:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772530087; x=1773134887; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dmONzeH9CL6eFIU8lWx2IsfbXhP2aObnfQZjq5udB+E=;
        b=ZKySZXoO+o+1xr6ya4cdqZNvpaWTr/NRT7Cm039/s3sEL3UPPmP4Rtce03DFp97EJn
         8VFb5/Fi5aqMl/d5rWt5jq/UmGnudoNnZuzTm9ZQdviJoxud9o8S00XIjIp8Y+IEwsav
         Xr8jOahhrgNPK2ZSqw0WV37lNxVtvIyzB5jOFtE88y5ry5des7ihqqNoYv+te3D9CyJL
         TdfTbOe7ZS/qDf7xcGtBf8lA5JNekYcC6ZFq1XGA6TkCs3kbc78UZWyMk9eJpavF9HOW
         WB0NR5/dNXiszMexWQUCHGlLW98aIaWgjM+mYWEsgBtk+oBMopaspmulNkZUlGonab6w
         6hyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772530087; x=1773134887;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dmONzeH9CL6eFIU8lWx2IsfbXhP2aObnfQZjq5udB+E=;
        b=o16d4XEnJOcnQfAycs8Z3fZ/iktkZRp3a8nvnLpB7462fHvTG3MUi3gIRTpBNmt3Hb
         5gfMuout+SO7d9TzKc4qHnz9EUnkZzOhzWfVGxP6x+fTyzaRVkgF8k2Qa8h0uCdUrR/y
         HMo8s472oW1yg0IGwSGkvs/rkqxgR7xqzB9oe01BxX7Wb4n9tUxZlSsWodrmrE8KXpNK
         xolE7tFaZfcLKkBjd+IvF3Aes8TW+AXQXSG4cYB19PRAy6s21XBhv+JaK6EuyYYXWBUU
         dtyRR/xRcC7CO/4G0JmW9GsSdRSmFNKYiJ8IJJg4br1aNcv+XECLOJVs1A/ngZCtocDg
         eRaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAZDkybkAEkGrdQ0ps9ox7T+c/VaIhXVSctB3c1T8dKHEzdfTQ7vQ+W/3Z9k3QRu6rCkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuJ7XpOFtAADGzijoQcni+bFXdXKELhmElUW41/nJBcQGz5fHv
	VtTc7SPTY7HKQclKKH1fqqzBZ6U3HieDWBlJB1xYn8HTbl+lMrEPvlB3
X-Gm-Gg: ATEYQzxEH4brOZB+ZD4OpKiDrwuFXCAi49KN5rlhgKxpVdv5TLRGlEAVihCni+DCkAR
	VI5QlyLvieyWkyex4lPgV6Itbvnu06u2DEu2MCDiU5PuPOSCaSKq1KEKGDtiBSQSxOPUUGx9TcW
	JNA9517v+bV+13yy0c4rnG3KM+qTqiYP0/kYuyYSUdXADRxo5lukN6j7aiWaV1uZ0VlwYCtmiYI
	WvGZvUdi/pd0vMnItTnIsN8Jz/Apz+azS5h7xsHTrUpy+X/8kAIYOdXFO7OAvlLaBB74fVB2ncD
	c8ARtufev4jL3WannvZYAzMJUSDLNlj9qCEokOobSNc7nuwPHSp1IJnlnhlpAbxcjOLS41S9BVW
	n5Z16o+s9SsJqE6vysJqyBTQy0weBUrvOy3nq20KHRO2MuwGUE3e0OsaCIh7DVowkksri+G8awJ
	gZA4ePYxNL7jl9ah1BdK1Q5hmrTTKcaawdzc3EiR+SxPWQJmb+ZG33GVWKV3HUeJYOVB5KvTJmT
	5rTu5gQJCrLu0DbMu8fq4c=
X-Received: by 2002:a17:902:ea0c:b0:2ae:6220:1539 with SMTP id d9443c01a7336-2ae62201d01mr8105115ad.6.1772530087187;
        Tue, 03 Mar 2026 01:28:07 -0800 (PST)
Received: from [192.168.0.109] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae4802645bsm73847365ad.12.2026.03.03.01.28.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 01:28:06 -0800 (PST)
Message-ID: <46c60949-87f1-426a-aeb9-706e97fd8e8a@gmail.com>
Date: Tue, 3 Mar 2026 17:28:03 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] repo: add support for path-related fields
To: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org,
 kumarayushjha123@gmail.com, valusoutrik@gmail.com,
 pushkarkumarsingh1970@gmail.com
References: <20260228224252.72788-1-lucasseikioshiro@gmail.com>
 <aaSusXil9nDHYGMR@fruit.crustytoothpaste.net> <xmqqbjh64262.fsf@gitster.g>
 <3983da40-bf2c-4665-a7d9-dfebaacb8bd3@gmail.com>
 <CA+rGoLfbzXqP1Tw+94jMmWcSGPoefMv5E_fvwriad-O5CUeKHQ@mail.gmail.com>
 <108ccc9d-5777-4c84-9dad-c2d0f5dc2e42@gmail.com>
 <CA+rGoLc+ULYUZaDCdAHxuL8T-qyjJKTRJfSe6Muhb7c6d12e_w@mail.gmail.com>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <CA+rGoLc+ULYUZaDCdAHxuL8T-qyjJKTRJfSe6Muhb7c6d12e_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi JAYATHEERTH,

Thanks for the reply.

> To clarify my earlier comment: I wasn't arguing against ref-filter.
> In fact, I’m more inclined toward using the best tool for the job.
> My earlier point was mainly about behavioral similarity and how both
> belong to the same camp even though they might seem different.

 > I just meant both the ideas are in the same camp just unrealized.

That's exactly right. I was just reminding that there's a ready-made 
solution available that seems to work very well. Wouldn't reinventing 
something that already exists, with only minor differences, cause 
confusion? (´;ω;`)

> something like this:
> 
> static const struct repo_info_field repo_info_field[] = {
>      { "layout.bare", get_layout_bare },
>      { "layout.shallow", get_layout_shallow },
>      { "object.format", get_object_format },
>      { "path.toplevel", get_path_toplevel },
> };
> 
> This array contains all the keys
> You do not need to hardcode path.absolute.toplevel,
> path.relative.toplevel, etc., in the array...
> 
> Instead,
> 
> If the user asks for path.absolute.toplevel:
> You detect the absolute. middle part. strip it out to find the base
> key path.toplevel.
> You find path.toplevel in the aray, the array works with default
> values when entered --all
> 
> /*
>   * Helper to parse the key variant.
>   * Takes "path.absolute.git-dir" -> returns "path.git-dir" and sets
> opts->format.
>   */
> static char *normalize_key(const char *raw_key, struct repo_info_opts *opts)
> {
>      const char *suffix;
> 
>      /* Check for "path.absolute." prefix */
>      if (skip_prefix(raw_key, "path.absolute.", &suffix)) {
>          opts->path_format = PATH_FORMAT_ABSOLUTE;
>          return xstrfmt("path.%s", suffix);
>      }
> 
>      /* Check for "path.relative." prefix */
>      if (skip_prefix(raw_key, "path.relative.", &suffix)) {
>          opts->path_format = PATH_FORMAT_RELATIVE;
>          return xstrfmt("path.%s", suffix);
>      }
> 
>      /* No variant found, return raw key as-is */
>      return xstrdup(raw_key);
> }

I see. What you've written matches what you described — it essentially 
replicates the functionality of ref-filter.c. While I understand this is 
just a simple code implementation demo:

 >          opts->path_format = PATH_FORMAT_ABSOLUTE;

This implementation appears unable to support input like 'git repo-info 
--keys=path.absolute.toplevel,path.relative.gitdir', meaning it cannot 
handle multiple paths output from a single call as previously mentioned 
by Brain. The 'opts' here should be a global shared state, right?

I think it's better for the parser to allocate a separate memory for 
each arg it encounters. But then we'd be back to implementing something 
like struct used_atom, hahaha (ゝ∀･)

Thank you again for your email.

Yuchen

(I feel like we've been on this topic for too long. If you don't want to 
reply, you don't have to :-)

