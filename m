Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAAF1FF7DD
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 13:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733145495; cv=none; b=siibg4ps2TtcqHgcDIBnrYRHfvgfM1UptxOOHecvfDbF6yooBsFjrk3gu+OU+Jbn6FsxUpttQ8GVH72KlMRSG5DO7Y1DI5z7cdr76c2ORKpTM3rRHW/IAttyI/gBEMxdF1oTbF/AwQCfeOzquRWaD4xE2fCcFRUEk9OedI2aSsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733145495; c=relaxed/simple;
	bh=JNljNFBl5vvh1U6gt1QoTaDheTJuS8pXAsxXvckWkvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aeAzGQGi7ThcF+GDINTKo+ZUyKpJD6ndpoj7Az0KzsMWXkdLCi49CjgzucpPO+foLPABl3bDjMDcLuD7XI3dAHblkOOU4z3hiccvsxkvo7iPQc+YSASJS8EWcqh6QiYHQW/mwsMgsYQF0s5Z7jPEo2hYssA/E9US/XI1mTFJSjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nmdfvq6B; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nmdfvq6B"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7fc99fc2b16so2380647a12.3
        for <git@vger.kernel.org>; Mon, 02 Dec 2024 05:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733145493; x=1733750293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zlai1rM4xkKBkkVv/HoeUySKEOivm+B4tKGlKhmADSw=;
        b=Nmdfvq6B5imIzclhOIzjUnSQifxalYf/1l3iXR8gjcJikp11urKpkfUVP8+FWIPIWp
         BLOGBRZKdDzgbD+uV7JyLok+F1Hy1jJEGBYwTqdSAfnkp0eti3MB17ZCnqppe349inhV
         QRTEysh2claUff+jcfmK9g60lMS+14vuA5oVQBYp9qhJ8UUK+NxPYZTkO/W9zJkQpfAy
         bzzGyqaJqvoIxgBeeFvQLJaNflSbiXFNoZtsUv+DFq7K6GG81jOOZ7sDr+O64kjI1F6V
         QufrlbQ/SlpQicfRhX6mFcE3S9Vfk53ch1lOG7YSkDZmJymmsByXwHUo2RcCdVnEZoCT
         c3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733145493; x=1733750293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zlai1rM4xkKBkkVv/HoeUySKEOivm+B4tKGlKhmADSw=;
        b=wVVAvrx6UeHZqEsj2mu3wIEIESlcvBJeVavn7YYF3AeTAvXzqhysMGIHAavM1lmCjJ
         jzu0QV5i9mOeH287QWcbe7c3C3ckUIXAOb5mRznQb0kgwehhTAnDGOe2ojJU4oXn99OF
         HfcOGFngB3uGV3+LGNKU7QAMHTRVJWBQfRwsSKrse6MUnSaWyW7eXAkPimSlf5COHKug
         F093u40pdVk0rDTqdp/dagWhJp+qsGK1IeOq9XCasBfCeMz00eZ2Sxadw58VyoBwuHDp
         iVO6nO9W5O71wGEj92tZcYU0Qwn220vLRn1cAM/qKmfEntFhU1Q58LLDlTzM3m5L2LpI
         7ENQ==
X-Gm-Message-State: AOJu0YyPGsq+CpY4y+JdO8NpjVnRUasQtWbzs/oorngEOnNef3fBPWHM
	zGGRTbklLDlq7dDBikixaHLZYqFjJEGKO5SfI4KUlmqBCGapKKbtSkvhSw==
X-Gm-Gg: ASbGncusZENErVbuIoz9nZEpyfWo7KnKudBllX0FtomJoAxxyEqzLib1zsqlgQB7PKf
	MYtbxj7tLGr7UJFr+uEtJs9+J5ddA1ny8hUygaOuFiCzCtTehaC2IDwZ/rIU6JW1ObU/58h50fV
	eFtUaAp30w7dNkDIR0tUGwhzE923nJo3wD/1BPTD8/aQTFy6S/aEShIoJkT0rKv6sdT05/A1isa
	GXlqgCZkgo8HkvF0WT1LV9c2bXlHJOhrbt4+iLTc1hMnQ==
X-Google-Smtp-Source: AGHT+IFL2QEJZLx3YUmaJ7EOz1soEQce7/ynyrlRxsyvOdGkWKc2dhzXUmQbB0XGEK0SYdJVkL3OdA==
X-Received: by 2002:a17:90b:2887:b0:2ee:9d49:3aef with SMTP id 98e67ed59e1d1-2ee9d493c47mr9184771a91.23.1733145492707;
        Mon, 02 Dec 2024 05:18:12 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee45ec551asm7003796a91.16.2024.12.02.05.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 05:18:12 -0800 (PST)
Date: Mon, 2 Dec 2024 21:18:35 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 12/14] builtin/patch-id: fix type of
 `get_one_patchid()`
Message-ID: <Z02zq7Wc1A2ot-Oe@ArchLinux>
References: <20241202-pks-sign-compare-v2-0-e7f0ad92a749@pks.im>
 <20241202-pks-sign-compare-v2-12-e7f0ad92a749@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202-pks-sign-compare-v2-12-e7f0ad92a749@pks.im>

On Mon, Dec 02, 2024 at 01:04:44PM +0100, Patrick Steinhardt wrote:
> In `get_one_patchid()` we assign either the result of `strlen()` or
> `remove_space()` to `len`. But while the former correctly returns a
> `size_t`, the latter returns an `int` to indicate the length of the

It is a little misleading about the statement "the latte returns an
`int` to indicate the length of the string".

Should "without spaces" be appended into the last? However, don't worth
a reroll.

> string even though it cannot ever return a negative value. This causes a
> warning with "-Wsign-conversion".
> 
> In fact, even `get_one_patchid()` itself is also using an integer as
> return value even though it always returns the length of the patch, and
> this bubbles up to other callers.
> 
> Adapt the function and its helpers to use `size_t` for string lengths
> consistently.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/patch-id.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/builtin/patch-id.c b/builtin/patch-id.c
> index 56585757477911c96bbb9ef2cf3710691b8e744e..f540d8daa736b027649c8c64ffe5100cf4044037 100644
> --- a/builtin/patch-id.c
> +++ b/builtin/patch-id.c
> @@ -1,5 +1,4 @@
>  #define USE_THE_REPOSITORY_VARIABLE
> -#define DISABLE_SIGN_COMPARE_WARNINGS
>  
>  #include "builtin.h"
>  #include "config.h"
> @@ -10,13 +9,13 @@
>  #include "parse-options.h"
>  #include "setup.h"
>  
> -static void flush_current_id(int patchlen, struct object_id *id, struct object_id *result)
> +static void flush_current_id(size_t patchlen, struct object_id *id, struct object_id *result)
>  {
>  	if (patchlen)
>  		printf("%s %s\n", oid_to_hex(result), oid_to_hex(id));
>  }
>  
> -static int remove_space(char *line)
> +static size_t remove_space(char *line)

So, eventually, we have decided to change the return type from "int" to
"size_t". This avoids casting "int" to "size_t", which is good. And it
would be more natural, because "remove_space" never returns negative
result.

>  {
>  	char *src = line;
>  	char *dst = line;

Thanks,
Jialuo
