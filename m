Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1B920B80B
	for <git@vger.kernel.org>; Tue, 12 May 2026 01:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778549031; cv=none; b=ZPXJ6COqqFf0f8RR1hAZNRY4cVBq86Bg0iZsXFKezQbaZ9hWkIJRCXle/qsMtDIJiVLSSh72G18UpokFEMQ+sCT/a80orOud5HXas2uZhrFg1DWXTY5lZA23Rt9bmavY3dUZmubfEaLd6Q8dBI+9LQILxbdaBH1JWTRVnM4c1v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778549031; c=relaxed/simple;
	bh=9twfXTRt/djK1lk2wXmsay6B06fJe0XfUmzrG7IPI/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pb0cwiI/oPeDXTYMYsJ6e4esO0pr4RUDCm7+p1Xvw5LBxQeA0iKqE8MajBge5pgpXArjzX5JB9ubIv2t1T6mmUHng4GO6AeA82YM7gzceGGYCjnXq9Go1xDoKKvLUflIVSwbzRySIZkUUfJztOl/qJm2ksFdEItDhME//YczV0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=I6DVFfZ8; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="I6DVFfZ8"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7bdec52f48dso68749337b3.0
        for <git@vger.kernel.org>; Mon, 11 May 2026 18:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1778549029; x=1779153829; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pw0M1MclfQeeG/yPnPJYBLO3v8hWnF+eT8clEFUaf7k=;
        b=I6DVFfZ8jXvPRpKgR5xUDBBfcjQ5pZQzGkJTedtMaHPCjJXspf0a8DBFsWYXQymhVU
         xyhSijZqEVniDc/p7Pxrnyr86T/1r6XQxxSfgqxE0mjNze0zwMXug8YfQU+pijewu2sh
         ZN6F6ucBjOYQnLGqmnUztPXAR0JEcAGcA4AMgC5H2Oh87yTt5kiYeVVE0PhtXwo58rc0
         Qxddc/7hQ+3SW3iHwHNNniKkgEuenjwPikCbXcdThD4FkidvEcTt8a592dryU5yLiMmt
         iywC+fRqPVpw9gmKlfVdmigTNcy2S2DJjSS8pvUDVsTOY8PRr2npiNVUEuJ7zezQ8atN
         K3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778549029; x=1779153829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pw0M1MclfQeeG/yPnPJYBLO3v8hWnF+eT8clEFUaf7k=;
        b=imzmav8r7Ggczk7j4IfjjWwu9fV16sPyLzg5bF/N8W1MLWHuPOjofd3xuTg2YlW7UL
         EH686CBpIuSBO1GkVZJKa8zOEBQIy65N/qbYZgGCxl1z8jyV1GH6kxvmVBnpca2zlQdP
         DlRqsylYQCBjqzElFzT/0seGpyDEUr9haKFL3JQMEvIdsKjaI2GFeyHuCJdYCUbKKZRQ
         ShxkZRCl0dr0cILPeKOpqLM696SMksFT9+Sub/yS5+mZ0XK+YuKPoO/GA8B8s03CpEsN
         a+F/2bd4PGBsKLQppv66I4HyHChP0PS3aaWg+P84FVfWixo8QMf18HC0j+AKV3N+G23V
         NYBA==
X-Gm-Message-State: AOJu0Yz82ksDZc1aSV/JfusvNXTMGSSotrQw2hfGvvi9zxL0XZOKwa+5
	6ydMsZ48kYOz17wKNgsxDsn/pjFVAenfPCAAPDByd9MoTZxe+10vMSj57yQoaCVg/9E=
X-Gm-Gg: Acq92OHrOkeBHtjU4RxlddTyaH2Ag/5VoHJYBq/v5nJ7Wbxu+ip63N2Dp76WwLNvY5E
	3fWMH3yMry3bXmRBnTPUk6N8Wibaub5G0xqzksyM9Nv7h1Kw0Nf9sFCWTdWKmqj52EgNqTuHP/p
	dqEb9lnoEzBMXNanAioGSeBKgDQJ4GE6+9dokobVNoc0E38AAXMvIwp62kgzgzTZ3F1Yq3mFuBS
	qTgDjgipU5p1IKGLwKeSSat6TCaIen2UdW4Kj38nSZv821tcnKZ4AKT+GCpGu2R/xFlUGWxucqg
	S+dgUJFDt+nrx1pKnQSYzft/EeE4Nr4H6G5Pi6hSONDur8hDRhmEdYbAJm6FZJ9hH3mZ4tu3s/Y
	BJk+oak/oSdAA86Nejaf1X7kE9coAyB4NuKrpCvn2zMv69An4E+n1EAo4ddBNX+CHEqeeQ70X1u
	iXD77W2Tmzwq034Gcl6LMfnOzkOJPZbWOZlZL7WdzhCUCUA49tT/Tm3DQniziqH+Tf4VuOjN8st
	YrBGVGp+URieUtSZ7AmZ0mJdpqcn+WbMp9mlKKUDGGcdjgXTqdxeOl0TrqDppHNxsd0o51NCqqQ
	s078wkkFKXEmOafZ
X-Received: by 2002:a05:690c:3:b0:7b6:783f:2122 with SMTP id 00721157ae682-7c50e70daa6mr18241227b3.9.1778549029669;
        Mon, 11 May 2026 18:23:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66558f35sm156577927b3.15.2026.05.11.18.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 18:23:49 -0700 (PDT)
Date: Mon, 11 May 2026 21:23:48 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
	johannes.schindelin@gmx.de, johncai86@gmail.com,
	karthik.188@gmail.com, kristofferhaugsbakk@fastmail.com,
	newren@gmail.com, peff@peff.net, ps@pks.im,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 04/12] path-walk: always emit directly-requested
 objects
Message-ID: <agKBJJvBP/PndPMP@nand.local>
References: <pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
 <pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
 <50933cccf508f71f47d955d5aceacad0db612fc5.1778523189.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <50933cccf508f71f47d955d5aceacad0db612fc5.1778523189.git.gitgitgadget@gmail.com>

On Mon, May 11, 2026 at 06:13:01PM +0000, Derrick Stolee via GitGitGadget wrote:
> We can tell that a path is part of the directly-referenced objects if its
> path name starts with '/' (other paths, including root trees never have this
> starting character). Create a path_is_for_direct_objects() to make this
> meaning clear, especially as we add more references in the future as we
> integrate the path-walk API with partial clone filter options.

I don't know that I have anything in the way of a better suggestion, but
I can't help but feel like the `path_is_for_direct_objects()` check is
somewhat brittle as-is.

I am not familiar enough with the path-walk.c internals to come up with
a good suggestion off the top of my head, but I figured I'd raise it
here in case you had thoughts on alternatives.
> diff --git a/path-walk.c b/path-walk.c
> index 6e426af433..59a7670c5b 100644
> --- a/path-walk.c
> +++ b/path-walk.c
> @@ -248,6 +248,16 @@ static int add_tree_entries(struct path_walk_context *ctx,
>  	return 0;
>  }
>
> +/*
> + * Paths starting with '/' (e.g., "/tags", "/tagged-blobs") hold objects that
> + * were directly requested by 'pending' objects rather than discovered during
> + * tree traversal.
> + */
> +static int path_is_for_direct_objects(const char *path)
> +{
> +	return path[0] == '/';

If we do end up keeping this approach, should we have a NULL check on
path itself here? I think that could even be an ASSERT(), since
something has gone wrong if we have a NULL at this point, but I'd rather
die by an assertion rather than a segfault here if so.

Thanks,
Taylor
