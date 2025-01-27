Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382E1846F
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 00:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737939574; cv=none; b=KQt6RRRwSO7vkkbEnZZ9ERe4TUHl/ZlWF+Lyr9rvJmIXQtJsF2PmO/yX6P6YE/wy7sGyHI6KJ5kgV0QiQDPx7RPfCdzodDo1m28rDsoI5MsNGxFaojDXmvBiLcYnxw5LMWYAgSnwzI9A5LCB9k4a1S7D5X589p+Y3k8TQy+gjPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737939574; c=relaxed/simple;
	bh=B0Yb3+vo/eypWKW6mQoJ8kEBnj0exNEEuXLKcC6NR+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POV9BPRur7JnEQwLKttHXVJ9znmspD6qgjHRt2RECm+bJwgZWjDFFPs+1fHsvrhBWfuoPajWWfBuFQL7+ezP6+qGG/h5drctwEiASoQWCUiQ/TJZyJOiCV3hFZboYQKQrcbElqRExleRwrn1e3UhZFMaIvNI4cjzUoYkBlDYgZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efDDpngc; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efDDpngc"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2a9ef75a20dso2354428fac.2
        for <git@vger.kernel.org>; Sun, 26 Jan 2025 16:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737939572; x=1738544372; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AJ7k2yX2S9kME3OAGzzJv/GedyfXhFCEgYg2ahQ4/Nc=;
        b=efDDpngcCcKDDvl1kK1nOQG/e12HBbNCtqeqdKUnl4jVhXW4T9jBvJv2m0TCwXI9ba
         McquCf/hN/Wx3WUriqYbWHZ6LCAa9yt7lHRdBg7APx6waDXzKbbRKnKp0TniUvhrXzH+
         hW3eNbUDkOFPwjd+2uHf6DNXxfIE4sVkS80J8cCse9muCtKQ7kagi9fnu3YFThvW9T4y
         BnQJzURG37fw7CUdrwBwXTFmSwz7rZ6mIHGiESEQh2dlKETVkjE9Iy1XBeaaFom0h8Qt
         rInmqr+m1MgUKo1FFmpr8cykvv8DB1JEvLsGLoHlrDdkuug+IR0Bf1iXbB08cF/Tbflk
         pLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737939572; x=1738544372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJ7k2yX2S9kME3OAGzzJv/GedyfXhFCEgYg2ahQ4/Nc=;
        b=vKJIhpJ4WDGP5NKrSwc3Cmeq7YobE3L211axKA346xehhqPDPSDocS1rW/u8Ka7rfk
         lVg/EL7+iahY3Elgt2jtoWLemmR8ev6zTRKNBUeSSDMYOx6abbyGOAz/gzQh7UuUczUi
         Jc3CpyEoNU4nozDxsaP7veaDIit2k7nn3CRjWgWpd+ClRjOXOUIx11JNC+l6/srPh8gL
         9nIQqqd5F+buY4FpYsvYkzaI4YFRrHPECWvEPNYPbKw8MuWMAR7GSbLVMGodzzDTaG3a
         cI1hczAwN0sE3kQE030klyGDJlhx5zRUF1aqFvBSUhrEFaacIaPwhYfV8T15DfqZJ3qe
         zWMg==
X-Gm-Message-State: AOJu0YyqtTC+K4DR/JiZck4neraep5gMAU0Y1Rsozn/EIt1ylkoDNeel
	/2+vfPaxh4QS0f0Y0auTIHdyVCrDyN60uUqmh6gCMtkBIZ+O/VMo
X-Gm-Gg: ASbGncuKPFacLAJKNbWX9kH65i9MHHrZc610156Tx4Atb0CnxlBlfnxgpYlR3T5XWKL
	BdI+VxPry8ddCP1NFmlglvZs/uSxfbRqqcqMoJhVBEez1nBeULN0yX0Bgt+Y99H6lJa2NMNZ8P5
	fc42UVmvBDIS+PDX4EGWg5D9TfkOlVtJw70wh6HqlsBiqw1fPEAUd9aXZ6V2mn2JRdat3QbbqTm
	AXHn+oTVPyKglZl+C/f4Q+Ud5OmMzla/lNih5nTRJDbU9x6X0oSpDhLTQ9oFluSvq0cGflWWA==
X-Google-Smtp-Source: AGHT+IFJyyEQL8feR4Z675uJ7p0rba2KiH+1Rpmmy61Z+1bQuuGXYSn4Dtp7tmd3BjjSQDsnx7j2DQ==
X-Received: by 2002:a05:6871:2109:b0:29e:6211:1262 with SMTP id 586e51a60fabf-2b1c05caafbmr20198971fac.0.1737939572205;
        Sun, 26 Jan 2025 16:59:32 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b28f16c27bsm2302720fac.15.2025.01.26.16.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 16:59:31 -0800 (PST)
Date: Sun, 26 Jan 2025 18:56:40 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 06/10] compat/zlib: provide stubs for
 `deflateSetHeader()`
Message-ID: <n64enlt3wcjftyz74evkdh53romwvmnwwd4qdpfaw6jedktcvh@fdy2zmdgmqm2>
References: <20250116-b4-pks-compat-drop-uncompress2-v3-0-f2af1f5c4a06@pks.im>
 <20250116-b4-pks-compat-drop-uncompress2-v3-6-f2af1f5c4a06@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116-b4-pks-compat-drop-uncompress2-v3-6-f2af1f5c4a06@pks.im>

On 25/01/16 10:17AM, Patrick Steinhardt wrote:
> The function `deflateSetHeader()` has been introduced with zlib v1.2.2.1,
> so we don't use it when linking against an older version of it. Refactor
> the code to instead provide a central stub via "compat/zlib.h" so that
> we can adapt it based on whether or not we use zlib-ng in a subsequent
> commit.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  archive-tar.c        |  4 ----
>  compat/zlib-compat.h | 13 +++++++++++++
>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/archive-tar.c b/archive-tar.c
> index e7b3489e1e..0edf13fba7 100644
> --- a/archive-tar.c
> +++ b/archive-tar.c
> @@ -473,9 +473,7 @@ static const char internal_gzip_command[] = "git archive gzip";
>  static int write_tar_filter_archive(const struct archiver *ar,
>  				    struct archiver_args *args)
>  {
> -#if ZLIB_VERNUM >= 0x1221
>  	struct gz_header_s gzhead = { .os = 3 }; /* Unix, for reproducibility */
> -#endif
>  	struct strbuf cmd = STRBUF_INIT;
>  	struct child_process filter = CHILD_PROCESS_INIT;
>  	int r;
> @@ -486,10 +484,8 @@ static int write_tar_filter_archive(const struct archiver *ar,
>  	if (!strcmp(ar->filter_command, internal_gzip_command)) {
>  		write_block = tgz_write_block;
>  		git_deflate_init_gzip(&gzstream, args->compression_level);
> -#if ZLIB_VERNUM >= 0x1221
>  		if (deflateSetHeader(&gzstream.z, &gzhead) != Z_OK)
>  			BUG("deflateSetHeader() called too late");
> -#endif
>  		gzstream.next_out = outbuf;
>  		gzstream.avail_out = sizeof(outbuf);
>  
> diff --git a/compat/zlib-compat.h b/compat/zlib-compat.h
> index 96a08811a9..2690bfce41 100644
> --- a/compat/zlib-compat.h
> +++ b/compat/zlib-compat.h
> @@ -7,4 +7,17 @@
>  # define deflateBound(c,s)  ((s) + (((s) + 7) >> 3) + (((s) + 63) >> 6) + 11)
>  #endif
>  
> +#if ZLIB_VERNUM < 0x1221
> +struct gz_header_s {
> +	int os;
> +};
> +
> +static int deflateSetHeader(z_streamp strm, struct gz_header_s *head)
> +{
> +	(void)(strm);
> +	(void)(head);
> +	return Z_OK;
> +}
> +#endif
> +
>  #endif /* COMPAT_ZLIB_H */

In zlib versions under 1.2.2.1, `gz_header_s` and `deflateSetHeader()`
are not defined. It looks like we are defining them here, but so they
behave as a no-op where used. If I'm understanding this correctly, it
might be nice to have a comment explaining the no-op component.

-Justin
