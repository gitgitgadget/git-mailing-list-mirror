Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DCC84E15
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 15:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714404335; cv=none; b=h/ELfsM06Ho6DpCBksJtSUdLWPhNH/XXS+iPrJW4dOxklNP3dEUUOUby7NFzkyNTDISwAMSd26ItDSeF0UnqINRFYOnDDFqIfzUOSFEds4OiTRPBUQTnCnwIwI8PdY873Duddl3vO8IcdPARoAc6KAHjzWIyH7Aph2eNpXWum5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714404335; c=relaxed/simple;
	bh=PGakqhIECPKjcPtzowVMMluekzDI7LHNxss/ca+ZWos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hJQIxfcWO2Aq/9CckoBh4rWGgMRiBSUI6nXuVP7Pq1xHeIPRcYkCDCxb4hgb/YNzAXmhpt5816NcHFvmVQmfdib4ShCRxZG6aReCCBjj1560dX8rYWmI1saLNOvUJw/SdHUrC+PSdXwWoRc5UkNCMwKAu6ex9r6b3gNoZRqvUwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCZc4vFC; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCZc4vFC"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41b4ff362a8so41184465e9.0
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 08:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714404332; x=1715009132; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GSUtKG1mNv+YaO+wfb8dxRZDSASNKRmaeV12SElbZNM=;
        b=eCZc4vFCJA5F38MRypKPN7xDAe3cY0V4JkIu7+d1A8SZbUsBG6AuStDVbc3Pu7NWxD
         bJqvYuyl+ffR1AjGZI6WT9LPZ6iFfhhD2usXcC3lwM0D5VXZv0eThD3XK+rsLMH38ID/
         yBhMFu+cg5lHCpiuvSzZeIY2r9Gf9np6oDz5tY2X/8PyfW77QZp5MezElof2ukgk+XF2
         xKkg52JeXT5PGemj4a3RPrFArutB6T1LNRUxfK7Sul5AhI7/tUPdDCWMToJistkET8dA
         yKGgXMcfNC2VbUOuBxYyhIGhCBDVjd56RNUEYDnvXGbxRQNzbUIl6a9DXH5nZ/nLBouY
         CJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714404332; x=1715009132;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GSUtKG1mNv+YaO+wfb8dxRZDSASNKRmaeV12SElbZNM=;
        b=udVK0UxKp10fD5NFsdgyxpZkc/vtFMBp6lER9C4aj4VS/e6MihkozkaIW8YUXzZ8n6
         aPsnn8y0mR59izAQ+0O6YqotAkNrBFbI7rkyRnINnK72i24sR/IQolXkchQoqrPFVCsG
         8mpLYTL5KivHKDxTEYXYCx4XxeiLT6vPovWhvBY7dtoJdNxod+rrxkCBjid0fP+FYfZP
         QzM+R3XpWnqCtLIn8FEPvrNuJIPE/4oM4Zp1LglHAEuizCZEjXI3uf7nmsA/t7wzoVtF
         qGJDIehXf8LG9qbJ5yKoGvfCXLnEXuwvKlQq8y6bTFxXf44hfxI4PHbutfdDM71h2Jyw
         IJuw==
X-Forwarded-Encrypted: i=1; AJvYcCWLSpLN2t6Lp+KpUaPA5XuWOITRcoArPbmQ4v6v5wCFCxHbMaQhgVoQTL/er3nxqeJUfFctHNU5ifjytAQNtdvkbJMl
X-Gm-Message-State: AOJu0YykDyu9whh/IOZW5Z6LowdFAKk1GYtw/pyW7ni6miHQPgVY8Lu5
	+M3app5q163fUXnAZYj8q8ZtPfL38ppj85QeC6ZKRQPHgoXql1R5
X-Google-Smtp-Source: AGHT+IHdgsGB6M+eXNm201eTA0gdZ9dxlEjbF42tvUS7HfAnV0Zba1ZbOEmuhtZgzrQB75cZljaSRw==
X-Received: by 2002:a05:600c:4f8e:b0:41a:fa9a:d863 with SMTP id n14-20020a05600c4f8e00b0041afa9ad863mr10779825wmq.9.1714404332273;
        Mon, 29 Apr 2024 08:25:32 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:701:9864:4109:be00:6ff6? ([2a0a:ef40:62a:701:9864:4109:be00:6ff6])
        by smtp.gmail.com with ESMTPSA id n3-20020a05600c4f8300b0041be58cdf83sm8984677wmq.4.2024.04.29.08.25.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 08:25:32 -0700 (PDT)
Message-ID: <dbe3283c-7814-48ca-af47-2246965b2794@gmail.com>
Date: Mon, 29 Apr 2024 16:25:31 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/3] refs: fix segfault in `is_pseudoref()` when ref
 cannot be resolved
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>
References: <cover.1714398019.git.ps@pks.im>
 <88822afe950318c0312de5541a411942a163b139.1714398019.git.ps@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <88822afe950318c0312de5541a411942a163b139.1714398019.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 29/04/2024 14:41, Patrick Steinhardt wrote:
> The `is_pseudoref()` function has somewhat weird behaviour in that it
> both checks whether a reference looks like a pseudoref, but also that
> the reference actually resolves to an object ID.
> 
> In case a reference does not resolve though we can run into a segfault
> because we never initialize the local `struct object_id` variable. Thus,
> when `refs_resolve_ref_unsafe()` is unable to resolve the reference, the
> variable will stay uninitialize. We then try to look up the hash algo

s/uninitialize/uninitialized/

> via the uninitialized value when calling `is_null_oid()`, which causes
> us to segfault.
> 
> It is somewhat questionable in the first place that we declare a ref to
> be a pseudorefe depending on whether it resolves to an object ID or not.

If I remember rightly Karthik added that check to avoid the files 
backend calling a file with a name that matched the pseudoref syntax a 
pseudoref when it wasn't actually a pseudoref.

> And to make things even worse, a symbolic ref is currently considered to
> not be a pseudo ref either because of `RRESOLVE_REF_NO_RECURSE`,

s/RR/R/

That was a deliberate choice to fit with the definition of pseudorefs 
excluding symbolic refs.

> which
> will cause us to not resolve them to an object ID. Last but not least,
> it also is inconsistent with `is_headref()`, which only checks for the
> reference to exist via `refs_ref_exists()`.
> 
> Refactor the code to do the same. While that still feels somewhat fishy,
> it at least fixes the segfault for now.

Alternatively we could call oidclr() when refs_resolve_refs_unsafe() 
returns NULL

Best Wishes

Phillip

> I have not been able to come up
> with a reproducible test case that does not rely on other bugs and very
> intricate state.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>   refs.c | 17 ++++-------------
>   1 file changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index 567c6fc6ff..b35485f150 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -900,7 +900,6 @@ int is_pseudoref(struct ref_store *refs, const char *refname)
>   		"NOTES_MERGE_REF",
>   		"MERGE_AUTOSTASH",
>   	};
> -	struct object_id oid;
>   	size_t i;
>   
>   	if (!is_pseudoref_syntax(refname))
> @@ -908,20 +907,12 @@ int is_pseudoref(struct ref_store *refs, const char *refname)
>   	if (is_special_ref(refname))
>   		return 0;
>   
> -	if (ends_with(refname, "_HEAD")) {
> -		refs_resolve_ref_unsafe(refs, refname,
> -					RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
> -					&oid, NULL);
> -		return !is_null_oid(&oid);
> -	}
> +	if (ends_with(refname, "_HEAD"))
> +		return refs_ref_exists(refs, refname);
>   
>   	for (i = 0; i < ARRAY_SIZE(irregular_pseudorefs); i++)
> -		if (!strcmp(refname, irregular_pseudorefs[i])) {
> -			refs_resolve_ref_unsafe(refs, refname,
> -						RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
> -						&oid, NULL);
> -			return !is_null_oid(&oid);
> -		}
> +		if (!strcmp(refname, irregular_pseudorefs[i]))
> +			return refs_ref_exists(refs, refname);
>   
>   	return 0;
>   }
