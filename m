Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E26EADC
	for <git@vger.kernel.org>; Fri, 17 Apr 2026 00:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776386057; cv=none; b=MyYAJoIru0y/qN9t2MY3K0/mzJCqzlZ3tNUtGWdntVQ1r8UHus9Yn83c8ApO6R7KxeiY4pxuUW65g4IFqL5jtSHFUKIwFnSWeBp7afzxQI94Lcq43Hg18/6cqv5d/uwVqu3KmAm9ygKfOwh1eshWBDZYQsdRHzMeuDisTp3L32o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776386057; c=relaxed/simple;
	bh=kg415iPqjMUD4K7Ii0ayRKhYLi0tiITJof2i1dorV/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CPvgnXxHZLkhEDwPyHRAW/7SbPQLNLlsbhm6dMAGIhcJ16hiv9Un+X8OiqNUgrowmSWwKMafstFD/X6ygNJkdDGZFK1r3o5AxCsbTp1j2DUFVy/Ll1T5nmg06YxeqS87E3wG9uG0sRTMxXSz11noFiZ7+1yOfyJPR0ok3284Arw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pdDO1xOA; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pdDO1xOA"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4887ca8e529so926955e9.0
        for <git@vger.kernel.org>; Thu, 16 Apr 2026 17:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776386054; x=1776990854; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q236RwxuO1FNzhE9g5TF04jnMRA+oxI8KPMJDgWGkns=;
        b=pdDO1xOAR8CcHZy/7ZagGl5O/4V3R/AJ63vcvILie3KwqnlXi4+TzgQ1+EjPFjjHW3
         1taxroj7+FMBLnB0hXRbkPq/c7+lm2hVW+ay9DSlkyGC26MozUgkJwQGGqIEJW/TQfAS
         p72WKFQAD57KjaLi9Z9Gc9YoYUh61CUoAzWkkQoqzcnFUlGd0BhuLXYuEVN+jLoqeluo
         e5qmATvNkeCtcjAhZgov9d2uuT+R5yf75/NtSrr821c0EET4/AR17PeP01Xtj6BY+ICi
         WjsL6lxHfZn34drDYXy2I/7KZqwnEjdaJGuYblVJaJPWhZgPPNiordYWUdflpg1mUhKQ
         DAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776386054; x=1776990854;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q236RwxuO1FNzhE9g5TF04jnMRA+oxI8KPMJDgWGkns=;
        b=Jgm4s2L9PdpiK63D0CAHkXO4k4qIukbNkwLQncL/t0Lciz3kNqfdijVjW1WrnWtJJZ
         LKfs3jBG89m7m7ap6UA67/gCABgQiTzEQXfQ0QIX0+Qo8t31LrWUZ+6bGjcLAlO2vws+
         gt6KLLZGjCbTlNhQ71LE/cybin6L0UlYza4mmAgJRQvfVIhlgTnqCIhjT++3OWHOHWcd
         VRa3nn9jyYunTg68SsMiMocbQaSxkhen0MCapTQe9JxiKFvqWhs2bgJEwCK1i8JqF60d
         ub89OTt1KTDZoH+uEyRzqh0rqHtzi2BxppQCxhu/6rsolfYEm2vYmE33QH/vX+//oFFh
         n40A==
X-Gm-Message-State: AOJu0YyhP0VjJKBh1aQcazbR3twsDuycBNOBQOJBL8Mf5ybxXM4yE+ja
	yrlJm1OpcjENlv7MN0IO8NlWe2hJqcPajuBpTWUitFy/KN27YeRzC9Lx
X-Gm-Gg: AeBDiet17k/Qz3VgglY/1NbNMXXOfDCSYUAP3PMAQqJT4ZA6iEa8Wd/NWROkoLDVXwQ
	FikBui0/KU2NEeTuaH3AUG0qvYXzaf9tPOs0Co6BkUGu6Yz4kDB0cMLcItU3SMIzdwnCaOcSY6X
	4vFw9eG4QsY/VmWmp184GV12Tv3JLDWjWzHBAIDeX2ImM4P/K0nqHwAoIv2cfBIK7sKjSeeZeAm
	9fDwNcO9T4/PPAzCMNzEJVVeix+wDxHriz+Nl+PsvPih1XwzVIwDAE5GGl+RAL+Qc0fmWfwUhmA
	2YksSNUtwkzfoUtJd3M425Bx/o7dZm1JvwJbsBsEkwi1bCXeOWqFFsPXJG6deMO0lI70DYUhEEp
	VeGwghgn3nmYGAW+cWzGID3Y6J9muoJTdnWKovQJV1/hojZgLIjD7Fle1qBEpw0V7gxO6TZA9CA
	Sl8u1B4fr1cIjvimQlXGvAA+vj/efgru6YQbN8rLM7B+ba59yHFVDPLvccKL3940uNjG9/3h2uE
	vsxlvJQZaLKdrXm8j4=
X-Received: by 2002:a05:600c:3ba0:b0:486:faa8:9e4 with SMTP id 5b1f17b1804b1-488fb8b91a7mr6349255e9.12.1776386053777;
        Thu, 16 Apr 2026 17:34:13 -0700 (PDT)
Received: from lorenzo-VM (host-79-19-37-238.retail.telecomitalia.it. [79.19.37.238])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc0f82bbsm4350295e9.3.2026.04.16.17.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 17:34:13 -0700 (PDT)
Date: Fri, 17 Apr 2026 02:34:11 +0200
From: Lorenzo Pegorari <lorenzo.pegorari2002@gmail.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [GSoC PATCH v5 3/6] repack-promisor: preserve content of
 promisor files after repack
Message-ID: <aeGAAx6_o6f_BN3A@lorenzo-VM>
References: <cover.1775832056.git.lorenzo.pegorari2002@gmail.com>
 <cover.1775861047.git.lorenzo.pegorari2002@gmail.com>
 <b483be7558f0efc1a6780b5cff13f4ccc3afd069.1775861047.git.lorenzo.pegorari2002@gmail.com>
 <641a7a4c-f836-4811-bbeb-ef534716c3a9@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <641a7a4c-f836-4811-bbeb-ef534716c3a9@malon.dev>

On Sun, Apr 12, 2026 at 02:25:50AM +0800, Tian Yuchen wrote:
> On 4/11/26 06:55, LorenzoPegorari wrote:
> 
> > @@ -171,19 +172,15 @@ static void finish_repacking_promisor_objects(struct repository *repo,
> >   		/*
> >   		 * pack-objects creates the .pack and .idx files, but not the
> > -		 * .promisor file. Create the .promisor file, which is empty.
> > -		 *
> > -		 * NEEDSWORK: fetch-pack sometimes generates non-empty
> > -		 * .promisor files containing the ref names and associated
> > -		 * hashes at the point of generation of the corresponding
> > -		 * packfile, but this would not preserve their contents. Maybe
> > -		 * concatenate the contents of all .promisor files instead of
> > -		 * just creating a new empty file.
> > +		 * .promisor file. Create the .promisor file.
> >   		 */
> >   		promisor_name = mkpathdup("%s-%s.promisor", packtmp,
> >   					  line.buf);
> >   		write_promisor_file(promisor_name, NULL, 0);
> > +		/* Now let's fill the content of the newly created .promisor file */
> > +		copy_promisor_content(repo, line.buf, packtmp, not_repacked_basenames);
> 
> Here, the file opened by copy_promisor_content() is an empty file. Is this
> line necessary? ;)
> 
> ...hold on. I recall you mentioning in one of the versions that you had
> downgraded this helper from a generic function to a static one. Since it now
> only serves this particular business logic, I think the implementation
> should be tweaked slightly as well.

Good point. It makes sense to modify the helper function to create the
empty ".promisor" file, and then fill it, so that we won't use
`write_promisor_file()` at all.

> > +	/* Open the .promisor dest file, and fill dest_content with its content */
> > +	dest_promisor_name = mkpathdup("%s-%s.promisor", packtmp, dest_hex);
> > +	dest = xfopen(dest_promisor_name, "r+");
> > +	while (strbuf_getline(&line, dest) != EOF)
> > +		strset_add(&dest_content, line.buf);
> 
> If file contains a large number of unique lines, dest_to_write, which is a
> strbuf, may keep realloc memory until the loop ends, at which point all the
> memory is released. I wonder if this might be wasting some heap.
> 
> If it were me, I might write it like this:
> 
> 	struct strset seen_lines = STRSET_INIT;
> 	dest = xfopen(dest_promisor_name, "w");
> 	while (strbuf_getline(&line, source) != EOF) {
>     		if (strset_add(&seen_lines, line.buf)) {
>         		fprintf(dest, "%s\n", line.buf);
>     		}	
> 	}
> 
> It also prevents file pointer misalignment.

Makes sense. Will use this. Thanks!

> (I think we still need to discuss what should ultimately become of this
> helper; at the moment, it seems a bit disjointed, doesn’t it?)

I feel like keeping it a static function only used to generate the
".promisor" files after a repack makes the most sense.

> Thank you, Yuchen

Thanks,
Lorenzo
