Received: from mail-yx1-f68.google.com (mail-yx1-f68.google.com [74.125.224.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025D09463
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 23:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761263820; cv=none; b=SDy8MQWerTPpNQ5CCEycuAg4Ndz4h56cN9QDb09JyM1Svj3dIAvomAKVTM0xx4sg8Vy5L5M0P02UvBKhEHvwX0MEuMjdr9SmiY60rN1gymcXnRafH/b8cOTU7ljCEKP/hdZq6fAXxlhC3cs+m4RlFgFhIGe8jZbe3CSZ+OPFRfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761263820; c=relaxed/simple;
	bh=aLq9/TICgIPLANNist+6U1C8JTyCd8AmGT/99KNU36w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brFEVz6eonQJ4rtAuhGK+O3gQML4rTnbVmlP4BNKBK3HhB/rooCcrKUF2ZO3GMZz7rl/O+W6mjdvHXAJOil848hCQg2cx3riB1LzPyI8Lg40RrB5X8oT12ZHZjGQWdArWMPnK0Jj7vF0/gsw6m4AMG9pbs4vIHBq7RTmKSiUlyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=pH2e1Eyf; arc=none smtp.client-ip=74.125.224.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="pH2e1Eyf"
Received: by mail-yx1-f68.google.com with SMTP id 956f58d0204a3-63e19642764so1527046d50.1
        for <git@vger.kernel.org>; Thu, 23 Oct 2025 16:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1761263818; x=1761868618; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WgwtIaymqgJO2WG5Wx1Bprp0ij5z43gdiElcA1vilWU=;
        b=pH2e1EyffKJh+LywjDl14WEBzOA8O+2j70U1Ik6fImAVYXThdQ/iSvlKLaNZVC11xv
         PlmDEkBJiLanurbOw7NnEFVKnzKDDNewJlEajlxhm8EsgV8WF9rNFJM2Wgk9/lAa/BBB
         w0Q8QlOZFC/MG5JrsK+5ZXRzgAXOLtdARho/5+0Af0mYMn/KUCng0VGv2D2yfK+/Hp3m
         oTYDjJs7XKxX3cSQwkLsmsR4pPAJno/WrcWMzTvOeZ619fTOsP416dV7sAAYYleYl5O+
         RYADuGIqcTzxaPgtQkvwzyr3QntSEP8ZgrfXq4ZJu0BCnBRHVrv3rKGWY9jdZVmzNtFB
         n1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761263818; x=1761868618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WgwtIaymqgJO2WG5Wx1Bprp0ij5z43gdiElcA1vilWU=;
        b=ZEdD5hPHQGys872bWFaqL2Uj1H94Xq2T/7hINyMmqo2Kavs8qr48lfCRXysQmQor2f
         Jw2weEfW0ksIWblAquwQS3/PP9QIdBtXFzQ+jB1/nKZmWvdPgyF/xXulxXDvDIZdFbHn
         3ppbKK3DmrFaKK3KIQmn172xhSQsbNUcStPbHERkKB/hmJncC5HJzdIz7xeUYS8A8Gul
         xDEQhh6NpdkHkO91Oll2/bd+lgqkna+2cARjwV2oFmz8laUPH4lYo62LdZyYJFfK2CCU
         oL1V01Q+Y8yws97//MjzrnW5PgKK+mcxoeIGb9xZuBltWukfwcgQkyySOwu7o9W1Dypl
         CRfg==
X-Gm-Message-State: AOJu0YxzMFWlDzKrWwvP2foql8aP5uf4+kIBK5bxsyAD9KlJr3XCdcRw
	m9vbS9GPsF455UQzTlTxTcTB+LGJiR6YH8tAvK/UjoXkpuIwJH18+WFmp6FvggTsSfY=
X-Gm-Gg: ASbGncu/Nbx7u08mvqpaj9g23Hxokgao1SbaP7D+vd5sK7C+UlbztzHbb6OnjC1OyO9
	ZSQ57WPMgTHbv8V+UZINMHyTfi+Ud/iJPFbzfJQ43y2VdL7dCn6nCohXlxWXxz/B94GH3lnqHV8
	3Ro5JgBLyxU3npUF5lDaO5IUhIDMfXiYyZx34KdfrRaSL2tMZjm1F/xh6sWHvkhPJFQtf7qz0IF
	rEJ3YZ9yptldUi2DsXiiBpyNsYrKLvRXNBsXjFSPTjz3+fHubQZKqVvA+Qs3ZwVRQ8FveW3yS2A
	gjpC9tLMDnSSdjmEYeQnJesPe5CCjo3qAsb3nv2cg37kYcEkwGbnq2N5WZbBw3Gx3WV+2vSE/tj
	1VlVGpOykNOwqUwV+3TWOa5wNZpxgnG1f8zb0TdEvmMN6nrEnb4O0NNqPqPlmn8jXnQbs6hR1L7
	WOvTf9bWWy6HGLv4PH9wqkrRoOZh65hVwo1yCDnf7nx/jpyWXj63fksSpMeqZUskAsNPleA6+F+
	alDhHI=
X-Google-Smtp-Source: AGHT+IG3I2Fj6gG3mZfR9v3BEocUDNzs88LFKov7Chr6dhxITEQEg5cvHPkl2nRm+gyQ/rs42ucr8g==
X-Received: by 2002:a05:690e:1c1a:b0:63e:428a:17b4 with SMTP id 956f58d0204a3-63e428a18e2mr10052932d50.36.1761263817842;
        Thu, 23 Oct 2025 16:56:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-63f378f0201sm1096691d50.10.2025.10.23.16.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 16:56:57 -0700 (PDT)
Date: Thu, 23 Oct 2025 19:56:56 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] last-modified: implement faster algorithm
Message-ID: <aPrAyJYvWtlvmiEx@nand.local>
References: <20251016-b4-toon-last-modified-faster-v1-1-85dca8a29e5c@iotcl.com>
 <aPGB/FJtjDmyNLvG@nand.local>
 <87jz0tu3yh.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87jz0tu3yh.fsf@iotcl.com>

On Fri, Oct 17, 2025 at 02:07:18PM +0200, Toon Claes wrote:
> > Regardless of how you handle the above, I think that the commit slab
> > name here is a little generic. I guess it's OK since this is only
> > visible within this compilation unit, but perhaps something like
> > "active_paths_bitmap" would be more descriptive.
>
> I struggled a lot naming this thing, so I'm open to suggestions.

I think calling it "active_paths_bitmap" or similar conveys that this is
somehow specific to "active paths", and since the slab is static within
the last-modified builtin, I think that's fine. It's a little word-y, so
if you have better ideas with fewer characters, I'm open to just about
anything.

> > Likewise, I wonder if we should have elemtype here be just 'struct
> > bitmap'. Unfortunately I don't think the EWAH code has a function like:
> >
> >     void bitmap_init(struct bitmap *);
> >
> > and only has ones that allocate for us. So we may consider adding one,
> > or creating a dummy bitmap and copying its contents, or otherwise.
> >
> >>  struct last_modified {
> >>  	struct hashmap paths;
> >>  	struct rev_info rev;
> >>  	bool recursive;
> >>  	bool show_trees;
> >> +
> >> +	const char **all_paths;
> >> +	size_t all_paths_nr;
> >
> > I wonder if all_paths should be a strvec here? I think that this code
> > was all written when the type was called argv_array (hilariously, that
> > change took place towards the end of July, 2020, and the --go-faster
> > code where this patch came from was written just a couple of weeks
> > earlier.)
>
> Ahha, that might be a good idea. This might allow us to get rid of the
> hashmap, which stops us from storing the paths twice. Not sure what the
> impact on the performance would be, because the hashmap now is valuable
> for path_idx() lookups.

Looking at this a little further, I don't think I consider this worth
doing. Using a strvec here is awkward since last_modified_init() really
wants to assign lm->all_paths based on each entry's diff_idx, which is
not what strvec.h is designed for.

You *could* use a string_list, and shove a pointer to the
last_modified_entry struct in the ->util field, but that is also
inefficient since we remove paths from our hashmap as we mark them, and
repeating that in a string_list would be wasteful.

> > In the GitHub version of this patch, we pass all active paths to the
> > parent, assign the PARENT1 flag if it doesn't already have it, and put
> > it in the queue as well.
> >
> > In your version, we'd skip past the next for-loop, and do the same
> > pass-to-parent dance below, along with inserting the parent into the
> > prio queue.
>
> This is the "shortcut" I'm mentioning in my cover letter. In my testing
> it seemed it didn't provide any performance gains to keep it. I consider
> less code better code, so I left it out.

Fair enough. I don't think that less code here results in a lack of
clarity, so this seems alright to me. But in general I am not sure that
I always agree that less code is better ;-).

> > So I think that this is all functionally equivalent, but I had to work
> > through a little bit of the details here, mostly since I haven't looked
> > at or thought about this code in many years ;-).
> >
> >>  static int last_modified_run(struct last_modified *lm)
> >>  {
> >> +	int max_count, queue_popped = 0;
> >> +	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
> >> +	struct prio_queue not_queue = { compare_commits_by_gen_then_commit_date };
> >> +	struct commit_list *list;
> >>  	struct last_modified_callback_data data = { .lm = lm };
> >>
> >>  	lm->rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
> >>  	lm->rev.diffopt.format_callback = last_modified_diff;
> >>  	lm->rev.diffopt.format_callback_data = &data;
> >> +	lm->rev.no_walk = 1;
> >
> > This one is new relative to the original patch. Why set no_walk here?
>
> This comes from
> https://github.com/ttaylorr/git/commit/e8ea49705873d28f64b815bd00d14bdf6d48ca4d
>
> Well, it basically squashes various commits together. There are various
> commits doing different things here. I don't think it's valuable for
> anyone to see the full history of the iterations at GitHub, that's why I
> squashed it in.
>
> Would you consider it better to not set `no_walk`?

Hah, I forgot that we added this one later on. Adding it here in this
patch makes sense to me.

Thanks,
Taylor
