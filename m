Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D82802
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 01:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737939693; cv=none; b=qnm3QuexnIpB/Y8HCX5ocXB2rJtWjpe8CK4gFCarXP8BetIxBBiLm/2A6GD14KKEUOFPMacSBNNhDlYn+gIicgGrfp1sr5+wEzPRDjVHbdKnskA80LVLplt5hQoJMmTXPnAjLlDfhv4QDw9xsHiajTTc/ck0wZ3pJpGVnjbNq9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737939693; c=relaxed/simple;
	bh=lr1emDUYosAzLyLkMKMqx1WS43kzlHr4k3jtc1tgVVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCAnimJBm7OIMy04j/AC/7g9d2UjsGQ9fuUNPKi5FOjGZGafeF1DGpOu3KO/ilJ7B0BMln7gKLF3CoahfrOC9QIlYhsuiJ/Mzt7cRZQP02umeMkdKtnjKydL4oYMZGPmVuRbrh2KK+lOBwcHcMTkjiuVnfcFScPFnTJzt8uEp0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVKHyGTu; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVKHyGTu"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5fa9778fa2cso662000eaf.0
        for <git@vger.kernel.org>; Sun, 26 Jan 2025 17:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737939691; x=1738544491; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xTyVSxbi09zPjldHD2YYucX3eBzHB4LGGAiczWTXk18=;
        b=DVKHyGTuK1XRe0LHf7sixKCFSGkhbMCQ9ZKP/Y7iUQgZEFPTpEXAyMOFrlYs8fge74
         6oZGWkSaGzK/H08rkTMR/WwweWb+VYvfqWU5FrucK8s9WXF1aO0jPnH2cHs+IGk7KfQe
         IqxPGPjGePhge2srhU3lKDWyF3Wi3UOaBdeswWR9UWRwNRFJnxLK2CVF+FAKEdyVkslp
         zjbqHbkgZuswG3UUJmqhsLXuRjpXJlqeTNadPXNzEzJXCIPuys4XrQc+fx/7tdj4tDm/
         Xp0fBfSf/Y7wYnOfgLbgzSphLeDFKKrd0yKHfuI52nP72M7lP4oCOf8DHdLvlBU+Oemv
         J29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737939691; x=1738544491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTyVSxbi09zPjldHD2YYucX3eBzHB4LGGAiczWTXk18=;
        b=LhGI887RHmksOZuRaII7jft/MgfWRXktVhWQ3CASGH3RnDlk/Fisv2HFLdb/evuAAX
         u5xwAlZZNEDR+5LNHzv3d9n1yx1vO/qpLLFoJdHV5aDvI1mQ58VJVu43kL0KBLDEr7g3
         r4JH3NUsTfDQjezVb+OQMg2hCc7dPDJEgAOWyHTv9Tfvd37SK6z7nbL5SbObJPWwxgAa
         IRCKx1CgvuBGxeo5LuyIBh8MzYd/O7w5wg9Bz2G1CyCzgbRF2P6d6EPEEta6q65DhWR0
         3WbxpNb1K5xP7N9fCz2RK/J5yPMPsPQOqjGox2ie0C+QrVfxR4oe0NwBEeeLmHIMcgpz
         r8Ug==
X-Gm-Message-State: AOJu0YzhCkyDy5u7fkn2gIj2/Ke5T0HY46zOs9uVLWUKsCnaJhllRAVI
	nFkj1B6tl0DmWfOy9ILrEz5hrMuT4U8QSffo2Afz+LIMDY7kvFtN
X-Gm-Gg: ASbGncvnpez+RCQ4YYV/W0KDrX1Z3P5XpwK6vW1HqEHaptrKvIo3MIzSFJNiQms2oC7
	230BiFPr7RbFRxVhmWkvcRCLWcfSG5oMkyQARB582yjqgFW0vJQoQtxl1zJny1FGnUjgJkTlkur
	LzPx4urPSkGyh8VvaSGD8skKgZQNsmf9ZSvac0WtoVu0JB7kS2LV4IWcY0PEH95hW78yYRyjaGi
	3Gwc5kiIkOKt076qehF55SqCHYgIOXKUf0sq9Ctu9Q+dgkObPP8oK2jIF+zjvjZOtROsk0zYw==
X-Google-Smtp-Source: AGHT+IEJQFQAKH3XGqyvES5VB1ub0MJypDlaeU4aF6fVFe1xzLRSBVHBHtVW06xE1AfMp78PCgb+8Q==
X-Received: by 2002:a05:6870:5706:b0:297:1d2a:a718 with SMTP id 586e51a60fabf-2b1c0956886mr23499675fac.21.1737939691390;
        Sun, 26 Jan 2025 17:01:31 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b28f1d68bbsm2323002fac.22.2025.01.26.17.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 17:01:30 -0800 (PST)
Date: Sun, 26 Jan 2025 18:58:40 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 07/10] git-zlib: cast away potential constness of
 `next_in` pointer
Message-ID: <jofg2g5hpvxq33cikq2jevqunrmmvwfqfcsjuipt5m3umz46sb@js5qlbp4jkxn>
References: <20250116-b4-pks-compat-drop-uncompress2-v3-0-f2af1f5c4a06@pks.im>
 <20250116-b4-pks-compat-drop-uncompress2-v3-7-f2af1f5c4a06@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116-b4-pks-compat-drop-uncompress2-v3-7-f2af1f5c4a06@pks.im>

On 25/01/16 10:17AM, Patrick Steinhardt wrote:
> The `struct git_zstream::next_in` variable points to the input data and
> is used in combination with `struct z_stream::next_in`. While that
> latter field is not marked as a constant in zlib, it is marked as such
> in zlib-ng. This causes a couple of compiler errors when we try to
> assign these fields to one another due to mismatching constness.
> 
> Fix the issue by casting away the potential constness of `next_in`.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  git-zlib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/git-zlib.c b/git-zlib.c
> index 2e973320c2..519b3647ac 100644
> --- a/git-zlib.c
> +++ b/git-zlib.c
> @@ -59,7 +59,7 @@ static void zlib_post_call(git_zstream *s)
>  
>  	s->total_out = s->z.total_out;
>  	s->total_in = s->z.total_in;
> -	s->next_in = s->z.next_in;
> +	s->next_in = (unsigned char *) s->z.next_in;

Without the context of the commit, its not obvious to me why this cast
is happening and looks curious. It might be nice to leave a comment here
explaining its purpose.

-Justin

>  	s->next_out = s->z.next_out;
>  	s->avail_in -= bytes_consumed;
>  	s->avail_out -= bytes_produced;
> 
> -- 
> 2.48.0.257.gd3603152ad.dirty
> 
> 
