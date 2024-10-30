Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B35BA4A
	for <git@vger.kernel.org>; Wed, 30 Oct 2024 20:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730318412; cv=none; b=kSt/PWlEb7Lg9jIySO4KZNV3BM6tesTX3Wk0XZwBp3klG+dJU3hdwzwu097WwbjgZrGQGfwboiRYkqgRLzGYjR1XO3v+pTOYMNzzEH0gJoCv6SiJaB1JLT947xa9KEExL6waOiAumQ1LstzEqistxMtLx9BbWohpB70E8vW7E40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730318412; c=relaxed/simple;
	bh=NsYRPZkD8unyxmGUWZNwWrIQS/RE7Vx7TKI3QcX2qHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6Lr0RoCfliwlLgYvxzwHPNdj44ozZCvX3Pp8SrctpqdPS74gxRtH5p8L2n3tbayLU8pfcZniFDBorG7llr27AFBC+BpMrpbr8aZDUe2d950zey2KMqwjpodIM4s9ydon8Fw3VRBz2Ec0ZZTNnF8lJ5qIAIWzZTkHCGN4tUbweg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=2BRrF1MK; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="2BRrF1MK"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e330b7752cso9689107b3.1
        for <git@vger.kernel.org>; Wed, 30 Oct 2024 13:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730318409; x=1730923209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=islfsC50RsqFZecxCGkeBx3PNlRvHd/OHbmPXyl5doE=;
        b=2BRrF1MKrb80CwrFkUnPgW/KbS+Ua0vt/UcQneAxCpIvrjAay2vhPpgZw/1/VQcdEN
         JsTWVS6VD0p9f9ROlG314Gk+w8t43PCTGbihfT5WFOuFMxmemn6q2bdjSEtHAKR9jlJq
         dQ+xzHWohW/iM9/9PHQBny1tceAXg/hVssTbe4NINOtOR56SE7DLlRRpoO+VZ/Fh45oG
         Tf7odNd1TmUD8MoaWI2SJx3pFQ4qA1rx08Z7uimtXzHLWZdvGFnLKwsayC8Ljfr2U5fC
         WI/3Ib7DD0ECFKyf3oM5VoNa3wec9MQTuz+XBCIm+wTqjGU2MCd5rXNN+0ZLBfqUu/2X
         YtdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730318409; x=1730923209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=islfsC50RsqFZecxCGkeBx3PNlRvHd/OHbmPXyl5doE=;
        b=IgF9H6hdorCtkwYV8X1xSFlGldK0jJDtmAH2yg0eOCHIyCqI+d8wY6CCEn4tauTGIG
         M+/Jcd/C5rIkrMMvJxbvduX1tecBGeIxdRkw6zhSi/kM3aWHFh8pJHd347BaQYPOyJrS
         tW8NNJth6QHZOpFEgZYdLq0gzZkX1G3XZX/Yt+sFCC0owY9fu4UxelXgrNNXvEJLfYuG
         wVBPHzWq/Y5PrJWNf3AViIBALWxZp0bgP2B+Dzjj9Uo5lLyioiQynK1B5UxsM1urCvyI
         M8APFeBtxrmOuUXamJV1VZTUdrXsG3z/4hGG+mFaQnblXnnyz7S7gCpV/wMoLAnKrA2C
         /eEQ==
X-Gm-Message-State: AOJu0YywqgpOajKnOg/VG371JFDn/2l+wMYEXpuCloGru87yluHIViRn
	tmeE2SsVXAtsk1DiX/2P+Gv5jfBtNS13fWQfNSzHdH7Af2rQSH2gT5bGbFF25oE=
X-Google-Smtp-Source: AGHT+IEHE2DjVM6wnesJHCaWVe4mohDyhYIgi3WCz7kZzI6nqSN0RSaYEdgd0vSKgYuIARwBu9AeRQ==
X-Received: by 2002:a05:690c:4a07:b0:6d4:72b7:177e with SMTP id 00721157ae682-6ea3e7527e1mr30883067b3.5.1730318408607;
        Wed, 30 Oct 2024 13:00:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6cb004fsm25703127b3.145.2024.10.30.13.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 13:00:08 -0700 (PDT)
Date: Wed, 30 Oct 2024 16:00:06 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v3 1/9] packfile: add repository to struct `packed_git`
Message-ID: <ZyKQRu+1v6IJjbSR@nand.local>
References: <cover.1730297934.git.karthik.188@gmail.com>
 <5afb9af0afdf6062b16dea2d1347170485e7d73e.1730297934.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5afb9af0afdf6062b16dea2d1347170485e7d73e.1730297934.git.karthik.188@gmail.com>

On Wed, Oct 30, 2024 at 03:32:26PM +0100, Karthik Nayak wrote:
> [...]
>
> We do need to consider that a pack file could be part of the alternates
> of a repository, but considering that we only have one repository struct
> and also that we currently anyways use 'the_repository'. We should be
> OK with this change.

Nicely explained.

> diff --git a/object-store-ll.h b/object-store-ll.h
> index 53b8e693b1..e8a22ab5fc 100644
> --- a/object-store-ll.h
> +++ b/object-store-ll.h
> @@ -10,6 +10,7 @@
>  struct oidmap;
>  struct oidtree;
>  struct strbuf;
> +struct repository;
>
>  struct object_directory {
>  	struct object_directory *next;
> @@ -135,6 +136,10 @@ struct packed_git {
>  	 */
>  	const uint32_t *mtimes_map;
>  	size_t mtimes_size;
> +
> +	/* repo dentoes the repository this packed file belongs to */
> +	struct repository *r;
> +

Hmm. What I meant in my earlier suggestion was that we should leave the
member of the struct called "repo", but change the name only in function
arguments.

Sorry to split hairs, but I am somewhat opposed to having such a short
variable name in a struct. In either event, the comment should be made
consistent with the variable name.

>  	/* something like ".git/objects/pack/xxxxx.pack" */
>  	char pack_name[FLEX_ARRAY]; /* more */
>  };
> diff --git a/packfile.c b/packfile.c
> index 9560f0a33c..1423f23f57 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -217,11 +217,12 @@ uint32_t get_pack_fanout(struct packed_git *p, uint32_t value)
>  	return ntohl(level1_ofs[value]);
>  }
>
> -static struct packed_git *alloc_packed_git(int extra)
> +static struct packed_git *alloc_packed_git(struct repository *r, int extra)

This spot I would leave alone.

>  {
>  	struct packed_git *p = xmalloc(st_add(sizeof(*p), extra));
>  	memset(p, 0, sizeof(*p));
>  	p->pack_fd = -1;
> +	p->r = r;

And this spot I would change to:

    p->repo = r;

The rest is looking good.

Thanks,
Taylor
