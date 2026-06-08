Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484243D1A82
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 17:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780941263; cv=none; b=GZvoHO8YB7vSdJT31Vx6vHxHj4J0Il7uUFtvpogtryfD+2DU8gtqZRh25IoXMZjHQ0a+jcfYt0myRBGC+mDibttx3aEIhwEUS4EFO1ro07NzQahOEW5sKeLhDcbYTpmp6lewVCWpfbWsUI3SotCgcW5a8PNWc/cWflGMQZynpaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780941263; c=relaxed/simple;
	bh=0CNr85EbKmrjQGlMm/4I7ErBnEI/V4jx7teAS+JybmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWTf2sPuG5tZTGZB3jsnVLORbPwgyI088lgC37ZswfpzU4eYH5Rb9iO1OZLRyYdW/9V2wW/d63VnpiRDK7TsL335afoXfkYIyQ21b/IHEDGFnqbRTjdh82Lrlm82Oe06Some9p69/9Ux9bj/d83dnwXqT8oy82IHEj4NkBtu/5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VysEpbX7; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VysEpbX7"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7e615efd7d7so4099415a34.2
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 10:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780941261; x=1781546061; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c1av7VhXB2Y12zPdc3WfsPp4hwuoACF/WM3OdA6ho8o=;
        b=VysEpbX7uGZtIbmW5GZQPPCCvjBQ/QiZRo/kudp5WpJ0Otk025VHIMCIFeRAcYByOt
         AxCFm+jExQuUM5d5dn/099toBUpk3XbfeiHQVpbbSTD5DwZXcpKHMdGQ1CiWhzvT6+85
         0co3ai+0Y9mSXqcwHEEgz4chkV/LSY4IwDNZndpCLVbcR2NPaSNqfKC+My0/pP0v0vi8
         x6YimcX3rkkRGwdt3uptFS8c9o2Itg0MM8WHOwbQXb2NNOEnI38HXs4zTS8JUt9RaEgw
         ulHnkN6hKE8h42Y0MWStR3DllL9lb/a9NXL4bs0d64VMoUqfADc491zQ0hrXFY+mOMaG
         xSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780941261; x=1781546061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c1av7VhXB2Y12zPdc3WfsPp4hwuoACF/WM3OdA6ho8o=;
        b=Cf+dMBPHLOEyaZdy9b086996Wb85aDBXbtKpgfOqSoyHkGe336C7bbl7QZ2LSBx+es
         Aec93vNw0T3WA5sOj7uK/aVdOVvvoZOhI2YO42edgidim5QvXFFxCbtaTstv06boEHXi
         hOKJm20Ocxuo82twlak4xAZebK5cDuGMkH6LwYKE50T3epV3LPePN+kvStozKzKcFK0S
         E3w4trQkx0udyUu2RikpeXg0ZoYEZjVSYuV4xKAyMDP/aeezdTGG9BjAEwSUCKDALjbz
         i+pAT/4tn0sO7NWYXp/o9ePx9lirDuajLhCXSNGMjFKxLNqh/Sikp53WnG9DLBZAEpVY
         nbtA==
X-Gm-Message-State: AOJu0YyQ292DTvDFfrISx5l5ac67D8cET/jwL5Kjo2msD4ezX5ITNEER
	jLYf8wXSjidre5+LjkR3R/XPTRzXs9cOReozyGUghefF39SMbzPTkGyW
X-Gm-Gg: Acq92OGMhP7ny3IlrhI6tWUmVc1G0vr8dnk//tMtrn3BoUOSPLBlbzc2qsaV6YsdvBV
	j/i3gXa2VOK4xOZTCz9nXPACVA5WUW2IDkFmgBY2tBaDzoLeedBSrGJID4OHAeCAHr4Y3ng1kbh
	Lq+8Tsais2naS+Oa6Okh1e57aZAasqcp6HufjyHth0y0wAulsOxV/tT/4/9E9NCv8zCNq9z5rTd
	AnzgdFHpxq42PMnK69+8hCzMv5g6DGG6YE/VB7zrdz4EjIa9q9eOvCB+uSJSOj67/6kw6s1bki1
	QYVQuh/YugAKkRi9rzju5ngeU65KNWDBp5zoUmJQH+0p89vT8NzjYscCzHARFKt/S26s2W31vBz
	//IlOQVXBo5KfvQpuLVL+wmcjBR1gebY6uUUsRzQ2gtygjibZB5MXxmGrDanxYkhRCJhKTlchyH
	N8cWcqTV2dzZhcryofGQEz4CesJ7g=
X-Received: by 2002:a05:6830:381b:b0:7d7:ed69:81b2 with SMTP id 46e09a7af769-7e70c5c16efmr10010682a34.5.1780941260999;
        Mon, 08 Jun 2026 10:54:20 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6e75b2017sm11920158a34.8.2026.06.08.10.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 10:54:20 -0700 (PDT)
Date: Mon, 8 Jun 2026 12:54:17 -0500
From: Justin Tobler <jltobler@gmail.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org, a3205153416@gmail.com, gitster@pobox.com, 
	kumarayushjha123@gmail.com, lucasseikioshiro@gmail.com, phillip.wood@dunelm.org.uk, 
	sandals@crustytoothpaste.net
Subject: Re: [GSoC PATCH v2 2/4] rev-parse: use format_path for path
 formatting
Message-ID: <aib73oQtXYOOQqmW@denethor>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260605163012.181089-1-jayatheerthkulkarni2005@gmail.com>
 <20260605163012.181089-3-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605163012.181089-3-jayatheerthkulkarni2005@gmail.com>

On 26/06/05 10:00PM, K Jayatheerth wrote:
> Now that the core path-formatting logic has been abstracted into
> format_path() inside path.c, remove the localized duplicate formatting
> mechanics from builtin/rev-parse.c.
> 
> Drop the usage of the old local format_type and default_type enums,
> and update print_path() to act as a light wrapper around the new shared
> engine. Resolve user-provided formatting flags directly within rev-parse
> to pass the final determined path_format to format_path().

So if the format isn't explicitly set by the user via the
`--path-format` option, the default formatting strategy used depends on
the path being printed. IOW, there is no consistent default path format
here.

> Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
> Mentored-by: Justin Tobler <jltobler@gmail.com>
> Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
>  builtin/rev-parse.c | 103 ++++++++++----------------------------------
>  1 file changed, 23 insertions(+), 80 deletions(-)
> 
> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index 218b5f34d6..c78bdc04c1 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -632,73 +632,16 @@ static void handle_ref_opt(const char *pattern, const char *prefix)
>  	clear_ref_exclusions(&ref_excludes);
>  }
>  
> -enum format_type {
> -	/* We would like a relative path. */
> -	FORMAT_RELATIVE,
> -	/* We would like a canonical absolute path. */
> -	FORMAT_CANONICAL,
> -	/* We would like the default behavior. */
> -	FORMAT_DEFAULT,
> -};
> -
> -enum default_type {
> -	/* Our default is a relative path. */
> -	DEFAULT_RELATIVE,
> -	/* Our default is a relative path if there's a shared root. */
> -	DEFAULT_RELATIVE_IF_SHARED,
> -	/* Our default is a canonical absolute path. */
> -	DEFAULT_CANONICAL,
> -	/* Our default is not to modify the item. */
> -	DEFAULT_UNMODIFIED,
> -};
> -
> -static void print_path(const char *path, const char *prefix, enum format_type format, enum default_type def)
> +static void print_path(const char *path, const char *prefix,
> +		       int arg_path_format, enum path_format def_format)
>  {
[snip]
> +	struct strbuf sb = STRBUF_INIT;
> +	enum path_format fmt = (arg_path_format != -1) ? arg_path_format : def_format;

hmmm, so `arg_path_format` specifies what the user-provided format and
acts as a sentinel to signal there is no value provided and the fallback
format needs to be used. This feels a tad bit awkward to me.

I wonder if we should introduce a PATH_FORMAT_DEFAULT to the
`path_format` enum that maps to one of the existing enum values in
`path.c:format_path()`. Here in `print_path()`, we could then intercept
a PATH_FORMAT_DEFAULT value and override it to the specified
`def_format`. I'm not sure if this is ultimately that much better
though.

-Justin
