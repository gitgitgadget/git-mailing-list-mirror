Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74062537FF
	for <git@vger.kernel.org>; Thu, 23 May 2024 18:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716487772; cv=none; b=UlpN/tGSgZ47h/U4VL6CYRW8xrXaGHU7jcJokAY9PZJHQk4Mh5u12RiZZrUkhrMK0IXLnZsXwDLDdhBfZ9olJ5fvY4Z+Q7uszNSTwVxYTTpJjtiLq56pvJpeTJcRQCIie6Td11eduUOxztypj23KXDbsextAllIdB+q1loBGT1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716487772; c=relaxed/simple;
	bh=7884G+8nijBp3GkAjNCRMp14nhm8r2Ls58IWOdUreJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCCULLHYi/LVdxbQ28bzk3i7ip8JeubdxODxGoP9ypbKALFfpnpy/FhwMEAzYMsP+y0jxIfjxoJR0Lp7hY6HyPGDPlvOHV96L7IwKqNgR/n1mxMJ3OaPp8k9yrFHxS/qYpsrD+AT0EQyUbRlDThqo5Jr+0YfdeB+oBI0x8mpcPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=0OmL0pm5; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="0OmL0pm5"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-79305314956so180888585a.3
        for <git@vger.kernel.org>; Thu, 23 May 2024 11:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716487769; x=1717092569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QtrBftGqAPffLgWjNspBPb3dPjjLS6rZxF/IaayK6tE=;
        b=0OmL0pm5e9n5e9HFS4NkTqKg0ws6ptUacIhKG3iJvu9L0oqn94YMY3N9RrK/ZpTcgO
         AUEBo37nw+AlmVv8uA/jB5V8dx5stl8FVEUiQigBUlV8YHqgx6XT8wS0L9wnOUuVB3UN
         4wW1A5tLsYrL7NIaEIRqoaR9P2MCxYKMlhk7G53XTn/Dvgm9JXVlk3cwHEIMfxt8vdcc
         i2okWDuOAP7YdxMViCE5JM2RJ93rRgrGdMGu1M3eeT6Z1rzK74hPUJQw/7GMYDzfwAx4
         UiQpuF6tr3qMNOrKHFFDYAf3iZAG4VMByZ+hiO8wG57zUj+HCFXal6fx3/ZyMIzA9DzR
         RwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716487769; x=1717092569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QtrBftGqAPffLgWjNspBPb3dPjjLS6rZxF/IaayK6tE=;
        b=KqnFKau1/DcxoHX0ZeP8NATHZnZMMkLavtDDA4icp8Tz8Qe/OsCMXakPQKilohnZEK
         XTJ8mTGovkPswbX2uiuXsFYkwOjbcylfx1H3NV5NOh/Ygv0Ca5WXAE3MO3yA4lDNS5Y5
         cP3hfI9BakFE+bvhx2AqbXCiaHyo7MkPVORvCQK81ZJlS7sBEvKXJ8UxcMfeYMoUmivX
         DeRzme15Li1NQoSh/8hKzFPJLUCnjobc/WqnMFxIrTHZkWPtmTHzkKE41Yi8k0K0ntXJ
         C+RDW7v3NrW1Cu6KIIHesZBfua0gMVmo0nx7k/7BwalWECWvMCUDr4mG17Kuc4IyycQ0
         gRHA==
X-Gm-Message-State: AOJu0YznDRAwpbRMabGR9fxREa2Sj8N1lkgK+IzrNsHHiew8q2yivlDT
	o5jHjfPqRzKwr8DFWjho+iG793b6/WgnpBX1bfa/QEGNrsvgPTqcs6tAPIn63d0=
X-Google-Smtp-Source: AGHT+IGqsiO5ejHsjGmPyRI/nnIzS1/kOfAInXYaiG4guf2CeGoGdKT63sm2YzdgFfCXvOac3qFfYQ==
X-Received: by 2002:a05:620a:38c:b0:794:802b:a61 with SMTP id af79cd13be357-794994c237cmr570293085a.76.1716487769152;
        Thu, 23 May 2024 11:09:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792e4c1076dsm1093328685a.130.2024.05.23.11.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 11:09:28 -0700 (PDT)
Date: Thu, 23 May 2024 14:09:27 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 22/30] pseudo-merge: implement support for reading
 pseudo-merge commits
Message-ID: <Zk+GV1M815zuE8aU@nand.local>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716318088.git.me@ttaylorr.com>
 <8ba0a9c5402fb154bc316768a8fbb016e302a686.1716318089.git.me@ttaylorr.com>
 <20240523104000.GC1308330@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240523104000.GC1308330@coredump.intra.peff.net>

On Thu, May 23, 2024 at 06:40:00AM -0400, Jeff King wrote:
> OK, so I think this commit is getting into the meat of how the new
> bitmaps will be used. Just to restate it from a high-level to make sure
> I understand, I think it is:
>
>   1. When we are traversing (or even before we traverse and just know
>      our tips), we can always say "hey, I have a commit in the bitmap;
>      does this satisfy any pseudo-merges?". Where "satisfy" is "all of
>      the commits pseudo-merged for that bitmap are already in our
>      result". And if so, then we can use the pseudo-merge bitmap by
>      OR-ing it in.
>
>      And that's apply_pseudo_merges_for_commit().
>
>   2. That "OR" operation may likewise open up new options, so we
>      recurse. And that's the "cascade" function.

Exactly. I think implicit in the above is that your (2) is also a
recursive step, since each cascade step may open us up to new
pseudo-merges, which themselves may reach objects which satisfy other
pseudo-merges, and so on.

> > +static int pseudo_merge_ext_at(const struct pseudo_merge_map *pm,
> > +			       struct pseudo_merge_commit_ext *ext, size_t at)
> > +{
> > +	if (at >= pm->map_size)
> > +		return error(_("extended pseudo-merge read out-of-bounds "
> > +			       "(%"PRIuMAX" >= %"PRIuMAX")"),
> > +			     (uintmax_t)at, (uintmax_t)pm->map_size);
> > +
> > +	ext->nr = get_be32(pm->map + at);
> > +	ext->ptr = pm->map + at + sizeof(uint32_t);
> > +
> > +	return 0;
> > +}
>
> I was happy to see the boundary check here. Do we need a length check,
> too? We'd need at least four bytes here for the uint32_t. Does map_size
> include the trailing hash? If not, then it might provide a bit of slop
> (we'd read garbage, but never go outside the mmap).
>
> I guess the ">=" in the size check implies that we have at least one
> byte, but I don't think anything promises that we're correctly 4-byte
> aligned.

Yeah, we could read into the trailing hash area, which would just be
garbage from our perspective. But I think that adding a length check is
easy enough to do, something like:

--- 8< ---
diff --git a/pseudo-merge.c b/pseudo-merge.c
index b539791396..7d13101149 100644
--- a/pseudo-merge.c
+++ b/pseudo-merge.c
@@ -478,6 +478,10 @@ static int pseudo_merge_ext_at(const struct pseudo_merge_map *pm,
 		return error(_("extended pseudo-merge read out-of-bounds "
 			       "(%"PRIuMAX" >= %"PRIuMAX")"),
 			     (uintmax_t)at, (uintmax_t)pm->map_size);
+	if (at + 4 >= pm->map_size)
+		return error(_("extended pseudo-merge entry is too short "
+			       "(%"PRIuMAX" >= %"PRIuMAX")"),
+			     (uintmax_t)(at + 4), (uintmax_t)pm->map_size);

 	ext->nr = get_be32(pm->map + at);
 	ext->ptr = pm->map + at + sizeof(uint32_t);
--- >8 ---

> The rest of the length check is here:
>
> > +struct ewah_bitmap *pseudo_merge_bitmap(const struct pseudo_merge_map *pm,
> > +					struct pseudo_merge *merge)
> > +{
> > +	if (!merge->loaded_commits)
> > +		BUG("cannot use unloaded pseudo-merge bitmap");
> > +
> > +	if (!merge->loaded_bitmap) {
> > +		size_t at = merge->bitmap_at;
> > +
> > +		merge->bitmap = read_bitmap(pm->map, pm->map_size, &at);
> > +		merge->loaded_bitmap = 1;
> > +	}
> > +
> > +	return merge->bitmap;
> > +}
>
> When we call read_bitmap(), it knows where the end is, and it's
> careful to avoid reading past it. Good.

Yep, thanks for double checking.

Thanks,
Taylor
