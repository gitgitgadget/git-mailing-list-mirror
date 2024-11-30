Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A7315539F
	for <git@vger.kernel.org>; Sat, 30 Nov 2024 10:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732963466; cv=none; b=ebBJ5HW9nnBxvEdYYiJTmaQ+fa39roxr48t3Tr5GSfXSd8P4nAB4SL0GB+GcLxscD+SMu6vMvOoUFmEDO68po8/6tenSfWdJhgRgiNBNA4DCXOGrCgJ5H7V4mcmcEtUeMpMt6WEATiS0WBl6+zV3nVgDm6vDzD4vt2Ro7Olwqbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732963466; c=relaxed/simple;
	bh=TAp/LJzWjY6/hRdDDpzzh0nfanVYfBDiw5h5r1dbpWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p374TjC9KxbO+OwfsSMld2pw03zz7Ep7169lJGIfvYapPJTn+7E6ry6rg7ZJ/5/CKCxA3iA0EavmOSmyU6DrUcfTNKsUZ1koXWFG/VBhmXqWMwnSDpRmF1kx2J4Y6ExKfgQWIVi6gIMGzmoSknlBCHUMVRwo+eYoxB8iadB8sY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FVRRWG+2; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVRRWG+2"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7fc8f0598cdso2509785a12.1
        for <git@vger.kernel.org>; Sat, 30 Nov 2024 02:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732963464; x=1733568264; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mn2WocFlgkWQqileASdZjwoIytwZeeCEa4jgE3K+qQw=;
        b=FVRRWG+2t5MhU9uvlacWQiniywrJ1kr3VvQaOLrvBTCwxWMglD3XV01xZDBuVwXHKj
         +x8nNp+6H06a9B/FHjrmB9jOqeqPXkIXQITe4+KuFfFaLo8nHcM9FsncU5yysupMCnqH
         6M35fjTmYRiBTiOJEJBskufhRenVqf6+K7bp+tJu/h1WHoSwcbUVjMODIsqCtkjnoLJX
         bMy36lStfr+10Fwktp7W7QYEret7MZ1AIVV4vpT67U/Sk7X0pd8AkZ0VLF6X9XxX8JPD
         lDF2G4DuUzfUOoJx8/PcazAQ7eiGtm4PAB+gQArru8/QxrBqsqSl4Gl7MTsIuhPziQwi
         Lgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732963464; x=1733568264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mn2WocFlgkWQqileASdZjwoIytwZeeCEa4jgE3K+qQw=;
        b=C5NsKdFUGsiGRmq38sok5Xri1jf5ahperZhgtFvjkLadQRHYWKM99A6R7d7XtoJClP
         urbmHGJJhFoxyEfspiss5Pck6Xbc4sDERCnvROD5tp+Zb/XXemb+eU9KwQ4zk0eN9RTt
         08jJ/SUhtFjdACPg32zLREXZj0LaQHQLAIqr6ZwVPtJ2UlEfC+N2cvaRMLgOM1QXUtYp
         vh/gmZ6q+616XM72zm2psSi/o/nQQdsZd4Q87PZqKmMQXIahM+zcsLNOEwrQowzxbjQb
         OmK2IiWZbJNhxShDTOz6gMBlsFkeoUB7tJSK7NxQEBc4X9g/zEpc2+vrO4K7uc42EWaP
         RFNQ==
X-Gm-Message-State: AOJu0YylkJNf2r/EZ1ueL3CpEessAOHpcfSe/pIsQ9xfIi1lUhaHWUtw
	RBe6i5V/CrYuCFDGhFTZxu4icI6nEbOQzf4SxOjZAIOCpOuax0tnlI+hAA==
X-Gm-Gg: ASbGncuhbyeLjrAIpCNhLVSuzWhCuWz7PqSF3jXags7Yq0wW5lARfJgvnUFV8MFC1G8
	biaDY6RlsjOc1ZRFLbBj+9uipMzLm0xkySsvoQ0+sW5Kc5sskX/dpBFIy40aoBfWNOxDm2MMwK0
	ZAs7VrDrCa4OL/4Ocgy+d/4DEYMeyhNZ2EjWxYLN4RJ+fGv2w0h8yVAvqdNJmfR6kCpOIxfBp1J
	X1r78ScZSq/+58wYuDrtwPSwHuMa0KuFu79v5fAeAXO9Q==
X-Google-Smtp-Source: AGHT+IErU0YSaRGdbmtXFksj3NQxAMtGjsG+XkmGhngvbtG78Pn9WWn22wpnOUDtrN0tOa45eXZb3Q==
X-Received: by 2002:a05:6a20:2583:b0:1d9:3747:fb51 with SMTP id adf61e73a8af0-1e0ec800265mr15765073637.8.1732963464008;
        Sat, 30 Nov 2024 02:44:24 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c324943sm3906779a12.48.2024.11.30.02.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 02:44:23 -0800 (PST)
Date: Sat, 30 Nov 2024 18:44:43 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 06/10] global: fix unsigned integer promotions in ternary
 statements
Message-ID: <Z0rsm8X0jkjtrjR8@ArchLinux>
References: <20241129-pks-sign-compare-v1-0-fc406b984bc9@pks.im>
 <20241129-pks-sign-compare-v1-6-fc406b984bc9@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129-pks-sign-compare-v1-6-fc406b984bc9@pks.im>

On Fri, Nov 29, 2024 at 02:13:27PM +0100, Patrick Steinhardt wrote:
> We have several cases in our codebase where the ternary operator changes
> signedness from a signed integer type to an unsigned one. This causes
> warnings with `-Wsign-compare`. Generally, we seem to have three classes
> of this in our codebase:
> 
>   - Cases where we know that the result is well-formed, e.g. when
>     indexing into strings to determine the length of substrings.
> 
>   - Cases where we want `-1` to mean "unlimited", counting on the
>     wrap-around.
> 
>   - Cases where we may indeed run into problems when one of the
>     statements returns a value that is too big.
> 
> Out of these only the last class is a bit worrying, but we can address
> it by adding a call to `cast_size_t_to_int()`. Like this we're better
> protected in case we have unexpectedly huge input as we'd die instead of
> silently doing the wrong thing.
> 

That's good, without using "case_size_t_to_int", we rely on the compiler
to do the conversion, which is bad. Now we will die the program.

[snip]

> diff --git a/builtin/patch-id.c b/builtin/patch-id.c
> index 56585757477911c96bbb9ef2cf3710691b8e744e..87fa586c4d552ba61cd2ac2cf079d68241eb3275 100644
> --- a/builtin/patch-id.c
> +++ b/builtin/patch-id.c
> @@ -163,7 +163,7 @@ static int get_one_patchid(struct object_id *next_oid, struct object_id *result,
>  			after--;
>  
>  		/* Add line to hash algo (possibly removing whitespace) */
> -		len = verbatim ? strlen(line) : remove_space(line);
> +		len = verbatim ? cast_size_t_to_int(strlen(line)) : remove_space(line);

Here, we convert the unsigned "strelen(line)" because the `len` is a
signed value. In the first glance, I think we should change the return
type of "remove_space" to "size_t", because it will always return the
unsigned value.

However, in our codebase, we use "int" as the return value in the most
situations. So, this change make senses.

>  		patchlen += len;
>  		the_hash_algo->update_fn(&ctx, line, len);
>  	}

> diff --git a/gpg-interface.c b/gpg-interface.c
> index a67d80475bf9d8452de0c3ae9bb08ceeb4c11c4b..e1720361f17e8b3b3315f0a5d93a827e11b2b036 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -700,7 +700,7 @@ size_t parse_signed_buffer(const char *buf, size_t size)
>  			match = len;
>  
>  		eol = memchr(buf + len, '\n', size - len);
> -		len += eol ? eol - (buf + len) + 1 : size - len;
> +		len += eol ? (size_t) (eol - (buf + len) + 1) : size - len;

When reading the code, I wonder what if "eol - (buf + len) + 1" is less
than zero. If so, we would cause underflow. We have created a helper
function "cast_size_t_to_int". Do we need to create a function to safely
convert the potential signed integer to "size_t"?

> diff --git a/t/helper/test-csprng.c b/t/helper/test-csprng.c
> index ea9b9b656307d32bdc1f2e15a91793b1dda9c463..31dbe7db4ac61639541f15d262cea64368fec78f 100644
> --- a/t/helper/test-csprng.c
> +++ b/t/helper/test-csprng.c
> @@ -1,5 +1,3 @@
> -#define DISABLE_SIGN_COMPARE_WARNINGS
> -
>  #include "test-tool.h"
>  #include "git-compat-util.h"
>  
> @@ -14,7 +12,7 @@ int cmd__csprng(int argc, const char **argv)
>  		return 2;
>  	}
>  
> -	count = (argc == 2) ? strtoul(argv[1], NULL, 0) : -1L;
> +	count = (argc == 2) ? strtoul(argv[1], NULL, 0) : (unsigned long) -1L;

Here we use "-1" to represent the unlimited, and the type of `count` is
unsigned long. So we need to explicitly case the type of "-1L". But this
is strange, why not just use the "ULONG_MAX" directly?

>  
>  	while (count) {
>  		unsigned long chunk = count < sizeof(buf) ? count : sizeof(buf);
> diff --git a/t/helper/test-genrandom.c b/t/helper/test-genrandom.c
> index 5b51e6648d8e698b09f400efcf67a0708c226e9d..efca20e7efff46bf66c2b8888ce88db02e545cd5 100644
> --- a/t/helper/test-genrandom.c
> +++ b/t/helper/test-genrandom.c
> @@ -4,8 +4,6 @@
>   * Copyright (C) 2007 by Nicolas Pitre, licensed under the GPL version 2.
>   */
>  
> -#define DISABLE_SIGN_COMPARE_WARNINGS
> -
>  #include "test-tool.h"
>  #include "git-compat-util.h"
>  
> @@ -24,7 +22,7 @@ int cmd__genrandom(int argc, const char **argv)
>  		next = next * 11 + *c;
>  	} while (*c++);
>  
> -	count = (argc == 3) ? strtoul(argv[2], NULL, 0) : -1L;
> +	count = (argc == 3) ? strtoul(argv[2], NULL, 0) : (unsigned long) -1L;
>  

Similar with the above comment.

>  	while (count--) {
>  		next = next * 1103515245 + 12345;
> 
> -- 
> 2.47.0.366.g5daf58cba8.dirty
> 

Thanks,
Jialuo
