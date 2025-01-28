Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B0A42AA3
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 15:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738076915; cv=none; b=MXXX2ApFhNPqkTU/sZqsXZXX0mEwKKZwOselgzxzldgSQF4j3LMvEPEC2Z77qiwpInCMwsFQlQ5Vdq8GPPhmZZ6zb6qSCBpTOoXFQO6LJRoidYPfdbWCtcDDDRizMxo1uX1Qtc7PI5ZCg2tYKbYxeZg/r2IpTGgJ68+dcSryrXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738076915; c=relaxed/simple;
	bh=SZfqg8CQwHm/q5irtJ/kdVqTC0hTizrvxsPk704raIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ifvo7cf4cdFXwPa+BmgVsilPFqWue7mRuMO/y7hIXNUCoFr4E4p6c2J5WWemqQd3GR9mqnZmteUdyL++o0xM+OROfbA8bXYH2tJldwuEZzCCttPsw1qkaMp5LdAFLDzepAzRfRyUcbUHR1x/a8ex6N+Nzmf76dj/lnZwcINWrMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crkZey5s; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crkZey5s"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43675b1155bso65930715e9.2
        for <git@vger.kernel.org>; Tue, 28 Jan 2025 07:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738076911; x=1738681711; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nPB0MsIMVeAgR7pugxnLnOS3ns6QEtthOo2wK7mgDrE=;
        b=crkZey5ssL8tH3bPJkaGsfjJPfn0kwuz2Ppj6FAuc5VejfZFZEz5kXLXQMP7/zZ2jC
         2nSRTD0Wv2vFsh8VDh2Vu4lJtEC/rNDaDcW/cwYWlEIDIGK0/9x4oagGipRwVoicT/4D
         FMkY/ES8qNqI9I8XEm781yyAB+MWJ0+H78GqgY2za6uuJgbBin+2oGB/Ka9ExGA5gpH2
         zKLDrbhY6L5I7k/M7Ve5QnF3eAYNCHZoDP+CXlGztjd363leMyhPZ7arAVJiOulx3Z83
         qdqD/lmNUQ5DwqA5XTkS4AW1vgdII6QFN5m4cwk6qm2loGjmHWyF//RYmTZOMuE7X092
         5kRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738076911; x=1738681711;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nPB0MsIMVeAgR7pugxnLnOS3ns6QEtthOo2wK7mgDrE=;
        b=OawvQheKDoHtbQBx3lcinqb620ES0iw9b/7dBlk8aZLBIcm2U2I5GMBwzjuRMMBP8D
         bFRqSZlfL/TL6+j3TACeY4cRMfe/4TTOxE+8BFR8mUZhjCZn5DMGwyFgXjAEfnvmZuvt
         7FqX+qNrr0YvN/Y7mHTPjyhb8EeHW5hPBANjJzWtDolB2QhwxSQyRQuS1jdBCIq7Zq++
         D4XPfb7sVzKrknkfpIb7r/KVuVKfJjMq32BZPFp1iKtsHh8SeVvYdpEgQybBZIEvV48x
         Uz8KRc9EbdLJzKPiPv51pWlBvw7+Podz9PoITKG8c4cyJCs25m8JogLvVyAjbKEd5//+
         6KWw==
X-Forwarded-Encrypted: i=1; AJvYcCUNhLuYZyGOe/f6Zmc9NPyYTWzRL8AkyvfMrNhvpXic6GC3pk8RvkREkscimlf4fyaNzEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAtgyrtqCoAH5GKK3hoyinwqWiMdnaTlQew6W3l7rRfTSVvfxm
	xhFfQjlC68sQQe1GF18pGK8HzqkpwdY65c1TP+HqATbQmdvJskbF
X-Gm-Gg: ASbGncuMo1kDhCQqJklbrZ75jLcevqdYBbgvlBOgrVj3RCaWmItO15ahe1cz5gcn1ha
	wBj9iRA261gpnKvLvzhusjThGLLepaOYXNvgjOkuwL5CT+0XL5FiYLbNy9LQyyDUnsKuPov0t8Q
	tvjgdppWzApRkIMLuH7WtyfWPitUdU4WZE9HJTWZuUateu3tgsHgzSwLGn4hxkkl+AFAKqWsaEl
	6Tj3EP93MCTPf/LS6AuhKrLV/B0KmcsnpHHqa42+MvR610TPbzGScPZHSBdZr+3W5chEtq5iV8I
	BmmYm0WWJHXb0RDaAKNnWQ5oHA0WDo7QIYMHGx89CQjVaQD3NbiG8FL2YpsXy8wO/JAanNeoVfT
	VwCNi
X-Google-Smtp-Source: AGHT+IHAHnKIueykHCgBHrcUSy04Bv6JbqVlZ6NpbRAEPJopai/RsfE0KuwKZIpn4Tb559U8MG2dIw==
X-Received: by 2002:a05:600c:46cb:b0:436:1b96:7072 with SMTP id 5b1f17b1804b1-438913bebe7mr415576245e9.5.1738076910758;
        Tue, 28 Jan 2025 07:08:30 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd4c75c0sm170954585e9.31.2025.01.28.07.08.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2025 07:08:30 -0800 (PST)
Message-ID: <8ed463cb-1191-4106-bf30-87e9e8bcc95a@gmail.com>
Date: Tue, 28 Jan 2025 15:08:29 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v7 3/4] libgit-sys: also export some config_set functions
To: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Cc: calvinwan@google.com, nasamuffin@google.com, emrass@google.com,
 gitster@pobox.com, sandals@crustytoothpaste.net, ps@pks.im
References: <cover.1723054623.git.steadmon@google.com>
 <cover.1738023208.git.steadmon@google.com>
 <d67d3648d1bdb7dde5e475f3a8eba834cc0ea891.1738023208.git.steadmon@google.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <d67d3648d1bdb7dde5e475f3a8eba834cc0ea891.1738023208.git.steadmon@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Josh

On 28/01/2025 00:19, Josh Steadmon wrote:
> In preparation for implementing a higher-level Rust API for accessing
> Git configs, export some of the upstream configset API via libgitpub and
> libgit-sys. Since this will be exercised as part of the higher-level API
> in the next commit, no tests have been added for libgit-sys.
> 
> While we're at it, add git_configset_alloc() and git_configset_free()
> functions in libgitpub so that callers can manage config_set structs on
> the heap. This also allows non-C external consumers to treat config_sets
> as opaque structs.

This interface is looks nice, I've left a couple of comments below

> diff --git a/contrib/libgit-sys/public_symbol_export.c b/contrib/libgit-sys/public_symbol_export.c
> index cd1602206e..a0297cb1a5 100644
> --- a/contrib/libgit-sys/public_symbol_export.c
> +++ b/contrib/libgit-sys/public_symbol_export.c
> @@ -4,11 +4,40 @@
>    */
>   
>   #include "git-compat-util.h"
> +#include "config.h"
>   #include "contrib/libgit-sys/public_symbol_export.h"
>   #include "version.h"
>   
>   #pragma GCC visibility push(default)

Personally I'd prefer it if we actually defined struct libgit_config_set 
here

struct libgit_config_set {
	struct config_set cs;
}

Then we could avoid all the casts below. For example

struct libgit_config_set *libgit_configset_alloc(void)
{
	struct libget_config_set *cs =
		xmalloc(sizeof(struct libgit_config_set));
	git_configset_init(&cs->cs);
	return cs;
}

> +struct libgit_config_set *libgit_configset_alloc(void)
> +{
> +	struct config_set *cs = xmalloc(sizeof(struct config_set));
> +	git_configset_init(cs);
> +	return (struct libgit_config_set *) cs;
> +}
> +
> +void libgit_configset_free(struct libgit_config_set *cs)
> +{
> +	git_configset_clear((struct config_set *) cs);
> +	free((struct config_set *) cs);
> +}
> +
> +int libgit_configset_add_file(struct libgit_config_set *cs, const char *filename)
> +{
> +	return git_configset_add_file((struct config_set *) cs, filename);
> +}
> +
> +int libgit_configset_get_int(struct libgit_config_set *cs, const char *key, int *dest)

Style: this and the one below could do with being wrapped at 80 characters

This whole series looks pretty good to me

Best Wishes

Phillip

> +{
> +	return git_configset_get_int((struct config_set *) cs, key, dest);
> +}
> +
> +int libgit_configset_get_string(struct libgit_config_set *cs, const char *key, char **dest)
> +{
> +	return git_configset_get_string((struct config_set *) cs, key, dest);
> +}
> +
>   const char *libgit_user_agent(void)
>   {
>   	return git_user_agent();
> diff --git a/contrib/libgit-sys/public_symbol_export.h b/contrib/libgit-sys/public_symbol_export.h
> index a3372f93fa..701db92d53 100644
> --- a/contrib/libgit-sys/public_symbol_export.h
> +++ b/contrib/libgit-sys/public_symbol_export.h
> @@ -1,6 +1,16 @@
>   #ifndef PUBLIC_SYMBOL_EXPORT_H
>   #define PUBLIC_SYMBOL_EXPORT_H
>   
> +struct libgit_config_set *libgit_configset_alloc(void);
> +
> +void libgit_configset_free(struct libgit_config_set *cs);
> +
> +int libgit_configset_add_file(struct libgit_config_set *cs, const char *filename);
> +
> +int libgit_configset_get_int(struct libgit_config_set *cs, const char *key, int *dest);
> +
> +int libgit_configset_get_string(struct libgit_config_set *cs, const char *key, char **dest);
> +
>   const char *libgit_user_agent(void);
>   
>   const char *libgit_user_agent_sanitized(void);
> diff --git a/contrib/libgit-sys/src/lib.rs b/contrib/libgit-sys/src/lib.rs
> index d4853f3074..dadb4e5f40 100644
> --- a/contrib/libgit-sys/src/lib.rs
> +++ b/contrib/libgit-sys/src/lib.rs
> @@ -1,15 +1,44 @@
>   #[cfg(has_std__ffi__c_char)]
> -use std::ffi::c_char;
> +use std::ffi::{c_char, c_int};
>   
>   #[cfg(not(has_std__ffi__c_char))]
>   #[allow(non_camel_case_types)]
>   pub type c_char = i8;
>   
> +#[cfg(not(has_std__ffi__c_char))]
> +#[allow(non_camel_case_types)]
> +pub type c_int = i32;
> +
>   extern crate libz_sys;
>   
> +#[allow(non_camel_case_types)]
> +#[repr(C)]
> +pub struct libgit_config_set {
> +    _data: [u8; 0],
> +    _marker: core::marker::PhantomData<(*mut u8, core::marker::PhantomPinned)>,
> +}
> +
>   extern "C" {
>       pub fn libgit_user_agent() -> *const c_char;
>       pub fn libgit_user_agent_sanitized() -> *const c_char;
> +
> +    pub fn libgit_configset_alloc() -> *mut libgit_config_set;
> +    pub fn libgit_configset_free(cs: *mut libgit_config_set);
> +
> +    pub fn libgit_configset_add_file(cs: *mut libgit_config_set, filename: *const c_char) -> c_int;
> +
> +    pub fn libgit_configset_get_int(
> +        cs: *mut libgit_config_set,
> +        key: *const c_char,
> +        int: *mut c_int,
> +    ) -> c_int;
> +
> +    pub fn libgit_configset_get_string(
> +        cs: *mut libgit_config_set,
> +        key: *const c_char,
> +        dest: *mut *mut c_char,
> +    ) -> c_int;
> +
>   }
>   
>   #[cfg(test)]

