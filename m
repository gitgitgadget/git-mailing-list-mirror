Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378B0224FD
	for <git@vger.kernel.org>; Sun, 10 Nov 2024 21:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731275284; cv=none; b=swefvugTYYR86qVCScW6GP0iqyCJFXkWpf/KKMnUdpiCiv2BTSgJnmsFwtE0bZ0KWvBtW4OYr5R2d1LLuIobTSS33AQjECnUgOrdVIFuztRp0JGuXFyYpD+WcQNt52vrzu0XUglU9XpMLYruk1MxqHtoBvGsxLsZS8OuJnx1owk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731275284; c=relaxed/simple;
	bh=CtbgenybpuwQ/dXZBfNTDQIj+FTlHxlcL2Xa0U31JKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Qwiv5LdIMVH/ODsW63t9lgIUBKk4cYu5fYSXgekiJHzGqmwbvqwJ37kyau6wXAz+SDbCdqrIS2voUVtVThQlsTkla7/ecxSkSSqbLwmzexpOPKS40YbfsWWL4p19ZD9s20spPvs0VHFuLogGKPzpVfSXxcn9rZ8cxogz4zilcRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CP1cSQbv; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CP1cSQbv"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d538fe5f2so2869338f8f.2
        for <git@vger.kernel.org>; Sun, 10 Nov 2024 13:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731275280; x=1731880080; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A1ty+vpAjz+aS1cmFyLOKljdfy1fln1hS/UPaUMiI9s=;
        b=CP1cSQbvd3hj07Z4FDDWdX9XI/xAefshpZveXrOtLdO/gs9ymiQUSn7egVcYqAjrut
         voXyrabddQ7m/xLKawDYLiet0V5uRSZdP6C3ZrHcTRvk3WsEq+7j46yy5Vy6nqgk7lH7
         eLOLCwiXo+j6OtHCDdwtnAZHZ0eIuv5WZg1KZSoNNw9pjcp0Ct+KILwPBRndaBbAwc0b
         xYMF1tEiObwQM7QWUFlvxsyus5JKqhlK/vbQ7wQQJVBRViuwpYWSGuWCAxoaX/OTG1Vd
         Veqgmbr0EX6JTnVC5ggpnTgsU8PI2XHYZi7mPIh8994q5ingYD262/mIm7SL5JoVxTS2
         whBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731275280; x=1731880080;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A1ty+vpAjz+aS1cmFyLOKljdfy1fln1hS/UPaUMiI9s=;
        b=Cnfn3I2bjdML7jTdZvvg9HSgTzRPXQ76M0L4k+SY1TcdFS0FNUZ/kNkJdY2NhSYv05
         XGZxjm2qsN6HqqElvu20Ss/IwdNmcVN0uZJDn4RZ2a+C/On0EMkzb7Fkl6CLMzsN/RwD
         aD31mP2myVjCLAl8j775ltZnQoQhqYX/4cNMW4r9ynQBxwfwD722KkyNwuLNJP15HPN8
         unf/UHYnfP7yX3H60FZA2scfcSJUZbO/Uxpj0yWO7OCTQqM8Cru+xNQVrxr1RWNCHebF
         mGbIw8+u3bjxOyAqH5lzuiwUlbBHHL16qnvUPWDQhT6GxoZD9SCzA5/6YprU4TD9m1fN
         Ov2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7ypRcHgkL6k/1iKOTsUHhM762M5glRelYf95y3UmWIoak4HPFWjNgTIB/TcaLDYfT3uY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCFX75qL0rsvbRv/83JQGf3YPk68WspgXERfjx9ylMAoND4WEV
	QrH7l+Cn2z/xdcd7mjw4ddmWL33ux18BhS1RjpCetbBdor/BeNmY
X-Google-Smtp-Source: AGHT+IF9Os4SRMftr69B9ndMrcjFIk0Jy3de0MgbkN8Waz1fUpGRGUuMrPkGZgkQXEGD6bMVIA0XFA==
X-Received: by 2002:a05:6000:21c8:b0:37d:5129:f45e with SMTP id ffacd0b85a97d-381f1721434mr7068665f8f.20.1731275280451;
        Sun, 10 Nov 2024 13:48:00 -0800 (PST)
Received: from gmail.com ([178.237.229.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b054a3ebsm152081585e9.12.2024.11.10.13.47.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2024 13:47:59 -0800 (PST)
Message-ID: <f3c10656-94a1-42b2-94bf-253978c278ab@gmail.com>
Date: Sun, 10 Nov 2024 22:47:58 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/26] git-compat-util: drop `UNLEAK()` annotation
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1730901926.git.ps@pks.im>
 <2d64a941d511a88a25c1f8258b5c5682089fdae9.1730901926.git.ps@pks.im>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <2d64a941d511a88a25c1f8258b5c5682089fdae9.1730901926.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Wed, Nov 06, 2024 at 04:11:21PM +0100, Patrick Steinhardt wrote:
> There are two users of `UNLEAK()` left in our codebase:
> 
>   - In "builtin/clone.c", annotating the `repo` variable. That leak has
>     already been fixed though as you can see in the context, where we do
>     know to free `repo_to_free`.
> 
>   - In "builtin/diff.c", to unleak entries of the `blob[]` array. That
>     leak has also been fixed, because the entries we assign to that
>     array come from `rev.pending.objects`, and we do eventually release
>     `rev`.
> 
> This neatly demonstrates one of the issues with `UNLEAK()`: it is quite
> easy for the annotation to become stale. A second issue is that its
> whole intent is to paper over leaks. And while that has been a necessary
> evil in the past, because Git was leaking left and right, it isn't
> really much of an issue nowadays where our test suite has no known leaks
> anymore.
> 
> Remove the last two users

OK.

> and drop the now-unused `UNLEAK()` annotation.

Perhaps it would be convenient to do this as a separate commit.

Just for reference we have this annotation since 0e5bba53af (add
UNLEAK annotation for reducing leak false positives, 2017-09-08).

> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/clone.c   |  1 -
>  builtin/diff.c    |  1 -
>  git-compat-util.h | 20 --------------------
>  usage.c           | 15 ---------------
>  4 files changed, 37 deletions(-)
> 
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 59fcb317a68..e851b1475d7 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -1586,7 +1586,6 @@ int cmd_clone(int argc,
>  	free(dir);
>  	free(path);
>  	free(repo_to_free);
> -	UNLEAK(repo);
>  	junk_mode = JUNK_LEAVE_ALL;
>  
>  	transport_ls_refs_options_release(&transport_ls_refs_options);
> diff --git a/builtin/diff.c b/builtin/diff.c
> index dca52d4221e..2fe92f373e9 100644
> --- a/builtin/diff.c
> +++ b/builtin/diff.c
> @@ -628,6 +628,5 @@ int cmd_diff(int argc,
>  	release_revisions(&rev);
>  	object_array_clear(&ent);
>  	symdiff_release(&sdiff);
> -	UNLEAK(blob);
>  	return result;
>  }
> diff --git a/git-compat-util.h b/git-compat-util.h
> index e4a306dd563..a06d4f3809e 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -1527,26 +1527,6 @@ int cmd_main(int, const char **);
>  int common_exit(const char *file, int line, int code);
>  #define exit(code) exit(common_exit(__FILE__, __LINE__, (code)))
>  
> -/*
> - * You can mark a stack variable with UNLEAK(var) to avoid it being
> - * reported as a leak by tools like LSAN or valgrind. The argument
> - * should generally be the variable itself (not its address and not what
> - * it points to). It's safe to use this on pointers which may already
> - * have been freed, or on pointers which may still be in use.
> - *
> - * Use this _only_ for a variable that leaks by going out of scope at
> - * program exit (so only from cmd_* functions or their direct helpers).
> - * Normal functions, especially those which may be called multiple
> - * times, should actually free their memory. This is only meant as
> - * an annotation, and does nothing in non-leak-checking builds.
> - */
> -#ifdef SUPPRESS_ANNOTATED_LEAKS
> -void unleak_memory(const void *ptr, size_t len);
> -#define UNLEAK(var) unleak_memory(&(var), sizeof(var))
> -#else
> -#define UNLEAK(var) do {} while (0)
> -#endif
> -
>  #define z_const
>  #include <zlib.h>
>  
> diff --git a/usage.c b/usage.c
> index 7a2f7805f57..29a9725784a 100644
> --- a/usage.c
> +++ b/usage.c
> @@ -350,18 +350,3 @@ void bug_fl(const char *file, int line, const char *fmt, ...)
>  	trace2_cmd_error_va(fmt, ap);
>  	va_end(ap);
>  }
> -
> -#ifdef SUPPRESS_ANNOTATED_LEAKS
> -void unleak_memory(const void *ptr, size_t len)
> -{
> -	static struct suppressed_leak_root {
> -		struct suppressed_leak_root *next;
> -		char data[FLEX_ARRAY];
> -	} *suppressed_leaks;
> -	struct suppressed_leak_root *root;
> -
> -	FLEX_ALLOC_MEM(root, data, ptr, len);
> -	root->next = suppressed_leaks;
> -	suppressed_leaks = root;
> -}
> -#endif
> -- 
> 2.47.0.229.g8f8d6eee53.dirty
> 
