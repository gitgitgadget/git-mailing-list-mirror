Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCBA1D5175
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 21:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741815766; cv=none; b=DEf76D5WMYrKpYXuTVs+vZ259yUOhUYb6tO4QKCHh5o+ueHC4d94I4Vzus8xeUDnVsat/aAwc4JfB3xFLmaDv0quMrZjKcZUqUPOuyphszQXe62n3m+Ek2R8+eX5ZcXT6XDa+uyQwCQkzmGc1WYZC34L1vhNqsKAhT5zK5/N3NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741815766; c=relaxed/simple;
	bh=POLI70XYulzO9oFBwcIfMws06UfoXLzoAVI6yaXjva4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/WqtTa2o+k75BhENkV46Gx/XknDoEaa3NUGpVTRMbfHrYH3hqmemJ8pUIBjMcPUJGg+iOOEXOdC1T/RSTgfNGp+uJwoWg5SacNJC+1jgoGaOZ0ny91VcNcrUAU1x3CDsMrSuf4B5zskyAQV0KkO9XCZK+ZLsFJTBfZmahN3X74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GEeQ7N/2; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEeQ7N/2"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-72a145521d6so205581a34.3
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 14:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741815764; x=1742420564; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ORZEPHw3ErKYG2n3OqlljCNK/SxAp1uEHUDiL0Jc5ZM=;
        b=GEeQ7N/2WUgCz+d96WoyPyb1Dc3b34PG0gzlOYcqLcuXR/+mh7bWBSf963pkJgJDFq
         hxzlt6QmfbbJQw72RzxqS6h5sAWT6HS7G6wgZmqOrH0icV/lTpwBEMZvmkgKIF7dZv8w
         BrPxZZIJy9F692rN6VfF2uH+I/bkub8nMybgM6GMTEScOVlO0PvOXzC9ynUa/u7UVi4Q
         E3Fz6FmYo2LC3tTXVLvMK9KSQON8Gu9O2B63fD0zDGl1+1AQwBMRN9ewRCHgEMVw4eYO
         OE80Z+VHjBVWXjP64boPyR+mr7zM+m7ju9qsiEr3d3mupzcniKD+ui0f1GxwyUC3mlco
         gEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741815764; x=1742420564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORZEPHw3ErKYG2n3OqlljCNK/SxAp1uEHUDiL0Jc5ZM=;
        b=dlpDtN2FmV4dofxwP4VXwj1McY97KRXFGgPcfbLuNtrsgpSQVGdDjaDirnOZ+91G8p
         bn0kW83jeTf2gNrfTs0u0jl3dlH9gEmS5dq3jAPF/sq5mUnNzn+fQWgTwsXbDyreQ50l
         0rrLPxGkSTGsvydexOtLh78HeFMD3SWewxDsWwEVq4Y4A0Y61PbzqPO3rdOjwacKKmPA
         rN2HMOVV3CdXWdyLzjMD313g1KqAFzZiGzVpvNorKCBM/KdjHaXseDEmh7s0vq5Xj4rM
         FJipWcJqxJx608tNPp1eOIvMO3IyMl9PSGuipw6JEvMYACV8lM2Ws6EZdB8bipAAA9PN
         wXWg==
X-Gm-Message-State: AOJu0Yx28BtbD2ixC/MGbsvFiqIU7Mrf5wHUoLF9fZg0hmkxPMJ9sVbu
	BCAKH3bnbBuONJSOt66HDhO0WUf0kn8qmLhq/d8aF3QkHmY7ybn8
X-Gm-Gg: ASbGncvF4ou1TzVoNCxsrF9DPftuak+ugKTHf+2HiWFR/YVo7JLDfIybZuvvT3pMyvy
	ov1vxr5ZZbfIqvxc9ianrb4EE/ayjwWTkzEuhLzodJVu7M5ITiYUl1t6Ufw6ZnwBBClA+q9/OC0
	TQdOLg2IMN9OKdc/B21wYt1agsnzaLlNop1fTDzy6m/Bc3lzx1h8feG2XL6R9YonHIPsvZ4wK/D
	Q+sS/vi1rEDcMnUfd4t+WAitciaHcLd3zexUJdB8eK0GubVpNogHw+knF9Z9m52Xy2rOAbvAwDw
	CmB5AjYKHuPFy5oMO8eYDsUKOz1sZuUB9+rAjxkdUQt3x3TT
X-Google-Smtp-Source: AGHT+IEIRgtSkosaMBx1mo9mLQXrnWlQbs32yXaNdRuUCISvVqWfHlYZ9T4fveX8lIjDXEJt/fViBQ==
X-Received: by 2002:a05:6830:6e8f:b0:72b:8974:e3db with SMTP id 46e09a7af769-72b8974e6b2mr8034396a34.25.1741815764311;
        Wed, 12 Mar 2025 14:42:44 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2c2488338b5sm3169264fac.6.2025.03.12.14.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 14:42:43 -0700 (PDT)
Date: Wed, 12 Mar 2025 16:39:15 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, christian.couder@gmail.com
Subject: Re: [PATCH 3/4] rev-list: support delimiting objects with NUL bytes
Message-ID: <rrc53bb5433gkdoboubhjrfk4pr6uaykiugiqghwbyhwtigaws@dyzt2buwbasl>
References: <20250310192829.661692-1-jltobler@gmail.com>
 <20250310192829.661692-4-jltobler@gmail.com>
 <xmqqmsds61pw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmsds61pw.fsf@gitster.g>

On 25/03/10 01:59PM, Junio C Hamano wrote:
> > +static int nul_delim;
> >  static int show_disk_usage;
> >  static off_t total_disk_usage;
> >  static int human_readable;
> >  
> > +static void print_object_term(int nul_delim)
> > +{
> > +	char line_sep = '\n';
> > +
> > +	if (nul_delim)
> > +		line_sep = '\0';
> > +
> > +	putchar(line_sep);
> > +	if (nul_delim)
> > +		putchar(line_sep);
> > +}
> 
> This looks, to put it mildly, strange.  The concept of the line
> delimiter byte (which can take any single byte) is wider than having
> a NUL as the line delimiter byte.  Why would we even want both?

This is a fair point.

There are scerarios where the printed object format varies more than
just the delimiter used. For example, in the normal output mode printed
object paths are truncated if they contain a newline. In the
NUL-delimited mode we want to print the complete path. Similarly,
missing object paths are c-quoted if they contain SP or LF characters.
These should also be printed as-is when in the NUL-delimited mode.

Due to branching behavior, I initially thought it would be easier to
follow if there was separate variable that signaled printing behavior,
but as you mentioned, we could also just use the global to hold the line
terminator being used and check if it is set to NUL when there is
conditional behavior.

> IOW, wouldn't it make more sense to have line_delim as the global
> (or per-invocation parameter to this function) and have
> print_object_term() just use it?  If you want to make it behave
> differently only when line-delimter is NUL (which I do not
> recommend), you can switch on the value of line_delimiter being NUL.
> So I do not see a merit in having two separate variables (except for
> confusing future readers).

In the next version, I'll use a global to hold the configured line
delimiter. I think it also makes sense to have a separate global
variable for the metadata delimiter since in normal mode, it is usually
a SP character. When the -z option is detected, we can set both of these
to a NUL byte.

-Justin
