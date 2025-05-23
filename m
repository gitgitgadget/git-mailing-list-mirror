Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CE42DCBE0
	for <git@vger.kernel.org>; Fri, 23 May 2025 01:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747963921; cv=none; b=TFzn6iS5z0dg9MVpiycRFLA7y/xmlFQoASBu9xNljJSM7vk2EMk9Cll7y+jLc7c9XaJkOtW9+vZpA+2LYE1HSxN82apXbVaVRt0nvszPUCU2dy60HeoKB158+2uZu9yVoBX/epw88Mbs1eRzDtLhItjJrRfCDfGJ/6n4cA+pTt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747963921; c=relaxed/simple;
	bh=ND9tXcO+iasEQa2x/kW+PiCuyn2DeZ2APjtFfXiCIak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzmjcuPTiZ8dtExJK3aj3pMtHvHTpu9CFNDTDFPRJNVxZlhqOysrVLIQwBSlL695/qHGuM9/JLY9lZcDXWi/7v7xlYj03vy2MeVrFVpzw6PYtqWKimHG9BCMyaB8WFA9B1pAGvS3j794uSRg6ClTKabeknI/WQR0j4RiiujsFfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=lcdO8owq; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="lcdO8owq"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4811fca8658so98750101cf.3
        for <git@vger.kernel.org>; Thu, 22 May 2025 18:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1747963919; x=1748568719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=75RDhrxv59dJ9R+HYxLamrFbv4MPmi2M3HerP4/4zNg=;
        b=lcdO8owqB0QlcVr4QsmTxU+UWRMSSVBgJEvC9ipQQm3Xuaoe2eCV00+Kuyjw+Hv4vG
         nJ2mp7DG3yL2a0eA2sRD7eh+8dNkOpM1zde73Ac63VRbXUYja+SKg+hCFR0/ByqKdj+J
         3Qd8m+Qcbc7s6meWAQLoje3wj2uwTddycBV7/1yFmeFTfEjOiqo6HfvsS1OdbLNUXNID
         Dfg8kOWGFLppeG+nPpYAzVRk9OWi4zEg4TgELvrz/e4hyGgNcry40JK/T2fg9TtpCcyr
         BL0aXZcWVh6fqzdnZ1JE20j+8nS4jWdi1u4ydDa80cckoGS8AZbgpTrnwIGKBaJyfLZn
         hnjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747963919; x=1748568719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75RDhrxv59dJ9R+HYxLamrFbv4MPmi2M3HerP4/4zNg=;
        b=n4M4dXBoo7tMuEM7XMlLM3GKDVYYQK9j3z58pEwY4qB8WqzfIyJm/CiQHxsAIBu3yt
         blTRGoL63zCrMpCFrwYy16+tTvDQXZP6hKpI99Vh6ug6BvKh/6H0/qBt3H3gdxb+r8EF
         7dKkJEKrsJTQyeukkD0TWysWiWVk9U7JBbtBOCXpKxi/2WDsA+kdVEi0/8pUJbnp3DkB
         nPFAT5qxZN9Zft8fi/8kHJVfc0RE+hlDv5IkV05Ho6WgOXpyMhBX/oAtXGjOP7jqpqZg
         FCbB7kzBJiznrYqRhEzfVx115xdJwbTTn6SMd9GLeVV1pAfyr//iF7LFIU4a0aGUnEMv
         Fs5g==
X-Forwarded-Encrypted: i=1; AJvYcCW5Nh1uWdnLaMF3NQ+UtSlPq8tVKOoXTwR/0pu0x6zQCmBb+209f3BLsOSjq2pxgW7+oQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZsk2nu9jqzx9828p2ZtiJHCy0oAn9hTYtmzgwRgMm7QMZ4XrI
	LoDIunTmDTTlU1ECb4NXvnK7LJHyjV/r18c5Kwa2/GnTUl7i+cTkLki8fOWkD4z1Xjo=
X-Gm-Gg: ASbGncsjUbqVcb6u2xrl2ZvB+zhVdhjLMol0GVkCED4eQoQiFuHt5L5XouZYroy63oB
	N79uvO5xGG3HnvFf7B9u8CNi/wjk+R53lPj3XMNl4knhqtpg4z/uFUKqUxTFRiuhJmK6zOJkE3O
	dpKmcK3NWl+k4U8aLcebweizoz444iXI/2N/Tow7ZyLT850iSdywqxF3mth4En+C63GRBPN4aRA
	ZHWtmeTreJE80FyXJ2JH39qDEDJf9MAlxh5KRZHGDx/hoa5NHYpXywGV0bjrTQzTBUuAMTbJ4y3
	56h8Wsd8/uFoeGaza4OyWYSkt005vccJFoUCWoj6CFIWKRthiaLrqZFapBKtUJjKSMOIkYNO2aX
	AGgxlX4x8C+dKGYM676lh+/8=
X-Google-Smtp-Source: AGHT+IFDYS0YfMaZiYwB97bNlzeA3pWvo3mr6FV/o5NkOEeBZQNkKfDqeleyi3kKshoO5BgVWHDxDQ==
X-Received: by 2002:a05:622a:5c09:b0:477:6ee2:18cd with SMTP id d75a77b69052e-494ae3361dfmr509393091cf.5.1747963918668;
        Thu, 22 May 2025 18:31:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-494ae2b60bcsm105417641cf.0.2025.05.22.18.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 18:31:58 -0700 (PDT)
Date: Thu, 22 May 2025 21:31:48 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] midx: stop repeatedly looking up nonexistent
 packfiles
Message-ID: <aC/QBHBbmYaVUzHV@nand.local>
References: <20250520-pks-pack-avoid-stats-on-missing-v2-0-333c5217fb05@pks.im>
 <20250520-pks-pack-avoid-stats-on-missing-v2-2-333c5217fb05@pks.im>
 <20250522053235.GB1134267@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250522053235.GB1134267@coredump.intra.peff.net>

On Thu, May 22, 2025 at 01:32:35AM -0400, Jeff King wrote:
> On Tue, May 20, 2025 at 11:53:10AM +0200, Patrick Steinhardt wrote:
>
> > @@ -458,6 +458,8 @@ int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
> >
> >  	pack_int_id = midx_for_pack(&m, pack_int_id);
> >
> > +	if (m->packs[pack_int_id] == (void *)(intptr_t)-1)
> > +		return 1;
> >  	if (m->packs[pack_int_id])
> >  		return 0;
>
> I did wonder while writing this if we might be able to hide the magic
> number and gross casting inside a constant or macro. I think just:
>
>   #define MIDX_PACK_ERROR ((void *)(intptr_t)-1)
>
> would be enough?
>
> Though...

I agree with the longer-term goal of having prepare_midx_pack() just
return a pointer to a struct packed_git. But in the meantime, I do think
having a #define for the "oops, I tried to load this packfile and it was
broken" case is a good idea.

> > @@ -495,6 +499,8 @@ struct packed_git *nth_midxed_pack(struct multi_pack_index *m,
> >  				   uint32_t pack_int_id)
> >  {
> >  	uint32_t local_pack_int_id = midx_for_pack(&m, pack_int_id);
> > +	if (m->packs[local_pack_int_id] == (void *)(intptr_t)-1)
> > +		return NULL;
> >  	return m->packs[local_pack_int_id];
>
> Yuck, yet another spot that needs to be aware of the new tri-state
> value. One alternative is using an auxiliary array to cache the errors,
> and then only the lookup function needs to care. Like:

I like this direction, though I dislike having a separate array that we
need to keep in sync with m->packs. It might be nice to have an array
like:

  struct {
      struct packed_git *p;
      unsigned err:1;
  } *packs;

, which would allow you to keep the error state next to the packed_git
itself.

I wonder if changing the signature to:

    int prepare_midx_pack(struct repository *r,
                          struct multi_pack_index *m,
                          uint32_t pack_int_id,
                          struct packed_git **p_out);

would be a good idea. It allows you to pass garbage input (like a
non-existent pack_int_id) and get a useful error back. It also allows
you to pass a pack_int_id that is valid, but cannot be loaded and get a
useful error back via the return value.

But I think without actually trying it and seeing what the fallout looks
like, it's hard to say whether or not the above is a step in the right
direction.

Thanks,
Taylor
