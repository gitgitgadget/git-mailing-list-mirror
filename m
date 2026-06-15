Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97627409617
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 17:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781543901; cv=none; b=nr4GYDF1AlSuKAYTc4sn1e3s0/MKMukUuQ5oYC7FGg3NvFAeeZ4Wm+MssKuPxAvazQ2nkBY8U0YdNfZu7ZzfBVaFIgOmGcBh3/nDUVvPzAavFBJYHoo0STzI+fclkE23Pnw+wD28BxH9KucptTuyN0SFiOQqzYvx3lyFu01hhZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781543901; c=relaxed/simple;
	bh=yIUNXpPnQOXPo5kJe39MudAZ7NBt3yXkF/uD3U74aB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FaR6VQO7uQI03gNRJ++ibzZHCyBNkjMYt191Ze4sHGX80bwUhemNrJM/57HMoxicqvynljAs163dycdqQShKyLBuH2qBh7h5O+IHASPLyceMYga1fQljMYeck0c1kkYsvp2Pa0rlQxRmVUB9yvt7RlMBla7jJM0a5yCITQORW/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0O1oN96; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0O1oN96"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-69e43b02308so1603901eaf.1
        for <git@vger.kernel.org>; Mon, 15 Jun 2026 10:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781543899; x=1782148699; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E05Vel2RPo9UypSaUi1HXkVwTsjJdB/Zx1tyTfPyhb0=;
        b=B0O1oN96Tl86u52sHBR/3Bl5fBup6FP04WASWOZtu+nWvghQdAnvN9bPMYPfLNN5Xm
         iSSgvjK324v/w8MoZ++CuOp4sO9hoyg2p2zLSW/1/MJ7qvssQPmArWQKv3cUKiaXdvF0
         grMs0Le3hnyE1u+CBRhuVZNGKL/dbD8Q/LW1mYWDyTlHMcWgfe+154QPbRK5XhbO+eYW
         FmgQvFYv4AIkSPLKTpogvxP0kl8DpoHWaM/zAJJisyy8pvtH+kdypkeqgsAF2Zd1tiOo
         NYYtuoMIh6KQxPS40AgIb7neGxss0DUm9PpNAbM/7myDpJWiheoExTEVtdEmpE9owoZQ
         2m1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781543899; x=1782148699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E05Vel2RPo9UypSaUi1HXkVwTsjJdB/Zx1tyTfPyhb0=;
        b=McCbSczck3dLEhCWzdB5hWwGFP0Up2utysoARHdqU9gvQ93cHDoyp7+WeQ0yN8p4ji
         sTFTP1OXZ6A5SImnF06Zbx84VScB97sO4GJjHQbYl5ylVgv4j/VPSwk6+w8Ycr/xpwo7
         J/NmNj7WuiO2aEvHbTXPZhKA3bRacfVNJbLN5eRud3l3rgVVOFTndm1zDA8gtuaNUnMn
         iDH4m5LjD9lFoInmfnWCLCIwu3VhYfq2GEs8xf2lJdOHAEQCOrAXyXIIWTQXzw5jfPwb
         OzJVWf0y7p5lqkQl4ZZJrzlfMadbMtcxRWsN0LVHd+EPfpiS3/PfEwotU93ejPF1FIxV
         +RrQ==
X-Gm-Message-State: AOJu0YyF5eS8D1bfWqiXi30p03yyJS2xomZKA1WbInXKBDMktRhgS+SM
	NJDQLrXUVnCy+v7TQit6OBONnK/S4/MnMx+ZKkWSWwZNF9skeUG22Qh7
X-Gm-Gg: Acq92OHhRjM6ETWnqmxLv0HPje4Cj11N9ibaqjjDYmt7XoXIvt02VPsp6ObOLpd2jKF
	MHvCLkKZ0F6IFK9hEY2MWAUVV8t3oX9BQu7z8YFMjleHkOvGHVNkFDifxjliIdBgi70KRn0VjT7
	ajEukvxLAmXhb5afnwT3sq7M2tttXpnPSa/IUcRnXzwZ2GaqTa49T7f5EOU1UoKVg0Xx951EHqp
	XdQi0ubD1mo7F3QfqRIA/k473znF2dKgYYApIb1JqKxIQzwkgWWZI051lkfcVJg5+iJkyvtpS9Z
	zV31uBbNk27oaGbHGRBcXZfWfOgfc7VUP2ypVLUOP6s4SlqfO9acCFb38W1Lx9A/wTzOhv8d7Gk
	M1kgG4JCIG+34vTo085imfS5m6MM+H7Turh9AF1VlLAtqxeabYSeoQHXc6PDTAKdFasglRWkQRp
	kWNsFFpTbHAGSHfdwR
X-Received: by 2002:a05:6820:f00d:b0:69e:5d3b:e7d9 with SMTP id 006d021491bc7-69eeca2e7d0mr6947495eaf.39.1781543899511;
        Mon, 15 Jun 2026 10:18:19 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44308afc5a5sm297906fac.5.2026.06.15.10.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 10:18:19 -0700 (PDT)
Date: Mon, 15 Jun 2026 12:18:18 -0500
From: Justin Tobler <jltobler@gmail.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org, a3205153416@gmail.com, gitster@pobox.com, 
	kumarayushjha123@gmail.com, lucasseikioshiro@gmail.com, phillip.wood@dunelm.org.uk, 
	sandals@crustytoothpaste.net, kristofferhaugsbakk@fastmail.com
Subject: Re: [GSoC Patch v4 2/4] rev-parse: use append_formatted_path() for
 path formatting
Message-ID: <ajAy1it6CGDQzVes@denethor>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260615045112.50686-1-jayatheerthkulkarni2005@gmail.com>
 <20260615045112.50686-3-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615045112.50686-3-jayatheerthkulkarni2005@gmail.com>

On 26/06/15 10:21AM, K Jayatheerth wrote:
[snip]
> -static void print_path(const char *path, const char *prefix, enum format_type format, enum default_type def)
> +static void print_path(const char *path, const char *prefix,
> +		       enum path_format arg_path_format, enum path_format def_format)
>  {
> -	char *cwd = NULL;
> -	/*
> -	 * We don't ever produce a relative path if prefix is NULL, so set the
> -	 * prefix to the current directory so that we can produce a relative
> -	 * path whenever possible.  If we're using RELATIVE_IF_SHARED mode, then
> -	 * we want an absolute path unless the two share a common prefix, so don't
> -	 * set it in that case, since doing so causes a relative path to always
> -	 * be produced if possible.
> -	 */
> -	if (!prefix && (format != FORMAT_DEFAULT || def != DEFAULT_RELATIVE_IF_SHARED))
> -		prefix = cwd = xgetcwd();
> -	if (format == FORMAT_DEFAULT && def == DEFAULT_UNMODIFIED) {
> -		puts(path);
> -	} else if (format == FORMAT_RELATIVE ||
> -		  (format == FORMAT_DEFAULT && def == DEFAULT_RELATIVE)) {
> -		/*
> -		 * In order for relative_path to work as expected, we need to
> -		 * make sure that both paths are absolute paths.  If we don't,
> -		 * we can end up with an unexpected absolute path that the user
> -		 * didn't want.
> -		 */
> -		struct strbuf buf = STRBUF_INIT, realbuf = STRBUF_INIT, prefixbuf = STRBUF_INIT;
> -		if (!is_absolute_path(path)) {
> -			strbuf_realpath_forgiving(&realbuf, path,  1);
> -			path = realbuf.buf;
> -		}
> -		if (!is_absolute_path(prefix)) {
> -			strbuf_realpath_forgiving(&prefixbuf, prefix, 1);
> -			prefix = prefixbuf.buf;
> -		}
> -		puts(relative_path(path, prefix, &buf));
> -		strbuf_release(&buf);
> -		strbuf_release(&realbuf);
> -		strbuf_release(&prefixbuf);
> -	} else if (format == FORMAT_DEFAULT && def == DEFAULT_RELATIVE_IF_SHARED) {
> -		struct strbuf buf = STRBUF_INIT;
> -		puts(relative_path(path, prefix, &buf));
> -		strbuf_release(&buf);
> -	} else {
> -		struct strbuf buf = STRBUF_INIT;
> -		strbuf_realpath_forgiving(&buf, path, 1);
> -		puts(buf.buf);
> -		strbuf_release(&buf);
> -	}
> -	free(cwd);
> +	struct strbuf sb = STRBUF_INIT;
> +	enum path_format fmt = (arg_path_format != PATH_FORMAT_DEFAULT) ? arg_path_format : def_format;

Without context, it might be a bit confusing to readers as to why we
override PATH_FORMAT_DEFAULT without our own provided default. It may be
worth leaving a comment to provide some breadcrumbs.

The rest of this patch looks good to me.

-Justin
