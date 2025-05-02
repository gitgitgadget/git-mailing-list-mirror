Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF16235BEE
	for <git@vger.kernel.org>; Fri,  2 May 2025 23:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746229106; cv=none; b=k+rxw+X9Bf9jAUjaD0KwD3kK39ol54cX9LI33oY6Lp9jLQd/H4FuRxjzHUcaeNYpsaYeHQlHYGEp5fZKezCQqUFUs+1Rlrg9PIMBpQBtjBo5jYp6yJIRbEN7Z8TIS+o9F/qBI6qTNKLyMtgqhwc3ZpJAltP2U51TKGjREhboG8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746229106; c=relaxed/simple;
	bh=ZTxzpkMNFsI0e0f6ofoQ3COtEom9JTjOKPozrsO+nRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qREy8zkosBNvAF/33kCbYyoOr2xJENmIpqmb0tOyb52HIYJQ1NPByWbNz6sNei5ktU3uY83IS0Na96/XRa9+iYk0j6djoNAyliEJAqPaLzw/lXx5HwUy7shjRT1tHuaTzrQvahvNItDKELtbCp5vnS8LJcKR47ReQoK6eOHOtkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=FVfi0qP+; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="FVfi0qP+"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e8fce04655so28222476d6.3
        for <git@vger.kernel.org>; Fri, 02 May 2025 16:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1746229103; x=1746833903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XIZxNw7TIG+jhxHvIBswEiCFkndrPUsqXNcztgusT7E=;
        b=FVfi0qP+ETzHNQFl4UGV3WrIgq2jzxrfMIRd0jj6T0423bsMs30KV1x21rcT0UK/81
         uwPL5NMOT2rV9fFsJf/2r6W0FIccu329MmzCmlpmz7XVG/YxENpFakcoDDzOytZsrUKe
         9/pjCv+B7AWP4hRKudNqmQ/uK9UiRFvlW3NWhOu92nPkv+GpmlZLpyBfZRs6UKz2M/uW
         fmCpW5sCofkg8LrKjJfHE68DKD5KBNN8vwHVP+TV43h9Yk4WxSyV0y/jHYkXh6FCbrE+
         ZzfCeIx4lhVJXTEZIo8WsItGnnGa6KqA+6sicDFxrwCSzp9XPVaYflMDQSt+VDFcVWWE
         liHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746229103; x=1746833903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIZxNw7TIG+jhxHvIBswEiCFkndrPUsqXNcztgusT7E=;
        b=uY0DzrwyvBpc5HBjuyWpLwXhUdn2H/9C9AljXtJplXpg0anh1+l/0I6uAMytkiuSL1
         TFK/QB1M9g3sKqaoT40x3Teh4m1f+QHcwicCSWoNMRKopWuJMkUZQu2f69FOeZL5qlf8
         UC5YpjjZeNA4l/4WAUmwYdobJ7QsSRMxeV8P3WUwoZbk21c8Ic6nwknr3VFzMZ4tSXe9
         CNMJlmLs4X6mkPIspNJ4gnG0ukXgm0Y5WzW74kbEWNMxExhaQvf5PWQdgCsHMSImjBnS
         /aNNGXwpD1Zcr1Bt6FI3WPtOy7btya4kOfhTwkXnLlsD74bDhbaFhC9T50MgfYgOzqUD
         m0LQ==
X-Gm-Message-State: AOJu0YwOuWvhUbK15Ia8rxDM2WokjM3oRWIWq1EAHdhjCIay5JsE1FyZ
	94bz6V6Yv0PWiK8hPn08T1dxQDmrenNLMOwBSp4Ms4GWvGVNeSVeVPDK6U9IdGU=
X-Gm-Gg: ASbGncvWmXV9jzL3M/gVSG6ibGBpT3sS0PDRa7iaGkBI3JxwAL8/bUee05MJt5sPrzK
	je+oQefwP3FFnI3ORTzAl4t6DKWrGR9rbyyNZm4dtLbE6eRO5a+vbqoOjs0Gw3BHU6UVMIRiJ9R
	4fKneO97+OaQcUBn9aK4AVVU9HVB+ahOgvjSoKg5//3aFTNTm3oCvbJKkjipLLIaObX3ymT+pwZ
	iFAYygyFMrl3ZuZBkXXr7/Q12S1Q7ZF/Cfu2lD5KGImJnJc+zzcevSpI1U+lp2a4A6I8pQxR+Ye
	q5/Y/ToHjd2HwipL4zWy1U9o2bW+b88n1DVzu+u5dqgfz6kcgqIEYo5afvxx4gmoNnVK254WcUf
	J5uunIYRVx6vQhKCxNy7cK7o=
X-Google-Smtp-Source: AGHT+IFcuVyuoH5uGsW8hFeUYNjjKiSx4usY5+MoodjHqrhzRPLIybU9OImll2cUDmVNwvwUGpaY5Q==
X-Received: by 2002:a05:6214:404:b0:6f4:c8c9:c4fb with SMTP id 6a1803df08f44-6f5237552e3mr11930816d6.11.1746229103036;
        Fri, 02 May 2025 16:38:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f50f3c382dsm25094306d6.41.2025.05.02.16.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 16:38:22 -0700 (PDT)
Date: Fri, 2 May 2025 19:38:21 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
	johannes.schindelin@gmx.de, johncai86@gmail.com,
	jonathantanmy@google.com, karthik.188@gmail.com,
	kristofferhaugsbakk@fastmail.com, newren@gmail.com, peff@peff.net,
	ps@pks.im, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 07/13] repack: add --path-walk option
Message-ID: <aBVXbSPYxhajUI8A@nand.local>
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
 <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
 <11767e7653e5212622ed7f82cad3b1a118621e8c.1742829770.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <11767e7653e5212622ed7f82cad3b1a118621e8c.1742829770.git.gitgitgadget@gmail.com>

On Mon, Mar 24, 2025 at 03:22:43PM +0000, Derrick Stolee via GitGitGadget wrote:
> diff --git a/Documentation/git-repack.adoc b/Documentation/git-repack.adoc
> index 5852a5c9736..2199eb3b94f 100644
> --- a/Documentation/git-repack.adoc
> +++ b/Documentation/git-repack.adoc
> @@ -11,7 +11,7 @@ SYNOPSIS
>  [verse]
>  'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]
>  	[--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>]
> -	[--write-midx] [--name-hash-version=<n>]
> +	[--write-midx] [--name-hash-version=<n>] [--path-walk]
>
>  DESCRIPTION
>  -----------
> @@ -255,6 +255,18 @@ linkgit:git-multi-pack-index[1]).
>  	Provide this argument to the underlying `git pack-objects` process.
>  	See linkgit:git-pack-objects[1] for full details.
>
> +--path-walk::
> +	This option passes the `--path-walk` option to the underlying
> +	`git pack-options` process (see linkgit:git-pack-objects[1]).
> +	By default, `git pack-objects` walks objects in an order that
> +	presents trees and blobs in an order unrelated to the path they
> +	appear relative to a commit's root tree. The `--path-walk` option
> +	enables a different walking algorithm that organizes trees and
> +	blobs by path. This has the potential to improve delta compression
> +	especially in the presence of filenames that cause collisions in
> +	Git's default name-hash algorithm. Due to changing how the objects
> +	are walked, this option is not compatible with `--delta-islands`
> +	or `--filter`.

I was going to make a similar comment here as I did in an earlier commit
message about describing the direct effect of a command-line flag
instead of describing it in contrast to the default behavior. But I
think here that I would recommend instead abbreviating the description
to just:

    --path-walk::
    Pass the `--path-walk` option to `git pack-objects`, see
    linkgit:git-pack-objects[1].

, which is consistent with options like `-l`, `-f`, -F`, etc.

Does it makes sense to have a separate `--[no-]cruft-path-walk` here to
let callers determine separate behavior when repack is tasked with
generating cruft packs?

Thanks,
Taylor
