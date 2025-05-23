Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E65319BBC
	for <git@vger.kernel.org>; Fri, 23 May 2025 17:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748022387; cv=none; b=PqbN49OLkNbh39eUWbHMa2KvjFxLz5emVZ5NOydZB+q9nMZ7Ap3Ve0jhUul6/dQMZQPFGmWXdcfS9xlGlx663lVEj8OJLFU0MxcqOM5AirgGNw+wIBgr9ZH0pWX9FxcfG5dzAVppLdVr+tn80qjshtthydIE42GgEwLlhQvFu6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748022387; c=relaxed/simple;
	bh=xXq9u5XB5Db8Zubn4sF+/JGhp16stub5jtkWGSMBZJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpE3vPOhOStTrWwrKHr3VR62uCyAQXAfXVjzsnGv78fx4t2MeuCn+fbvnRAS11st/bq97alItGgp6wO4FfqKvvt9W/WMkfCCCkMUvyXISEQQEIWM35+GFD4tej8Y12jwa3Gkv+JojPfSYlkVvOEG9GYeuF5CXrHvJwSpkr3ySv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=0ktS0WTP; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="0ktS0WTP"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6f5373067b3so999086d6.2
        for <git@vger.kernel.org>; Fri, 23 May 2025 10:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1748022384; x=1748627184; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DpIbkvMpieyPKZpOE8qDM7LZWT/aV69WXd8LLt6cLT0=;
        b=0ktS0WTPNEsruVnXdGjU6Nr007Cq5hnVZvYn5Jq5DLF/IlJ6sOxxtMVDEuzs/+GuJa
         zJk8Hjbf5wHTEoPYRMCKK260DsiIrVZtRM4EBL8NaHta6lay/VD5yup0rbz74oG/+FOt
         WCdgyJ0l5+bIMVaBXIm4r34Ip6DE0WU3hM/J3jj4m76Q9jrDnxi8tQi01ISMIj3aU8Ny
         trrU8NVk2qfStWkmwmPAp0XT2IzdDuf2ZruURQNKI2DgsLQSOO5Fw165FqvBr3Yo/izD
         GIB3kbVfNnnTyyR1+/52KEfFqDGeY8EegP4kxM2l8Zo7NZCWLTFH+mvMFl7LnKWGyXuZ
         erOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748022384; x=1748627184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DpIbkvMpieyPKZpOE8qDM7LZWT/aV69WXd8LLt6cLT0=;
        b=UmBjPZdHwzAFm0Fk6XZzz59RFoqejOcpZWvMuhY13YDjqAM84OxdfNkfOsqlX1kGvP
         Odig1J4CKEPmGDc5hG4rkAHptomEEaHrH4W4cOhwjuX1szZc6mqW034ZFLgvyl0xKT5x
         CTv2QHpzmILu/AJHQxrGyxEOkMIx75i937+4/JwBULxo32YD7+Yc8qDhwxTGfNHNZU8u
         h38GirqKBJv9S7g+gxqo3j9h4QgcRZC+vqeZCsfO+ONsHFjCPZl7DU5Bco6tPbKjEDVd
         oyB1YGurOzXZDIi8s9h56n75so5rsCSbNmefaXd6aB2Sg1Jlwyjbd6rhcbB4Wpg/7D4r
         FuAQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5lD4VmVFThg6vN2394jy6WH3jy1SHgwAGEKxJqqPetXGjsW0ZjdLxl9mZ7fFKUid02IE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4M6FCoNRbxCKQNciJvK90ZxIQCdqObqNpMG0TK5nYz15xnF5b
	qFr/chnebZJn+HoSIcS4LiOt4dDtZSeAcjvzo4S117tQdLr9lAblSKLY7pqyUJAhbX9ggCXpvDs
	PIimO
X-Gm-Gg: ASbGncuIsrwfm3v9cDqLcUQqqHju8DJNrjOzdIrTxN1Aym6aKAgnmx0WKq73/8wJ4ex
	OogPxTri1jsgVw4aMn5k/fBrmZ9mDArZWgCzs8aNHqeI8HhhxrrFmr2+FMxXLZF4L6SQKID3GlX
	2SD7kCGIjkzpkOwpqexNNnNrzo5BDs1Rh77OgxT7kjeL7JBRniYR0BMxAq6LAJ/N2ipQgVRa0wS
	N5J8/ClfmgzRDe8seupdT8T6AqxLtco6gsHh6Vp6EK5u93y305i/wSYP6Wtswh2DHbhC+8AxtHn
	W0u9B40tNeVjkw+DR64VvhoeBQTIMxQwTgmw7NyTlRhY6w/QkMFixAqX4nsQLtc+FYY3wjRWyt7
	BzdnIQ9M3m+Yvbgy5l0IsQps=
X-Google-Smtp-Source: AGHT+IGNkI1G+rA4teorvKJYyFWCOYuBFsTiaUy4fv4mCKYKGP3O4DIjELzxpYCFgIAzkslX+XMYVA==
X-Received: by 2002:a05:6214:c6f:b0:6eb:28e4:8519 with SMTP id 6a1803df08f44-6fa9d138f4amr5921186d6.21.1748022384298;
        Fri, 23 May 2025 10:46:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f8b47e38fcsm112383676d6.56.2025.05.23.10.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 10:46:23 -0700 (PDT)
Date: Fri, 23 May 2025 13:46:20 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] midx: stop repeatedly looking up nonexistent
 packfiles
Message-ID: <aDC0bK+NOuuVvQtb@nand.local>
References: <20250520-pks-pack-avoid-stats-on-missing-v2-0-333c5217fb05@pks.im>
 <20250520-pks-pack-avoid-stats-on-missing-v2-2-333c5217fb05@pks.im>
 <20250522053235.GB1134267@coredump.intra.peff.net>
 <xmqqbjrk7ikx.fsf@gitster.g>
 <20250522165924.GA1613@coredump.intra.peff.net>
 <aC/Nz2wQgncXzFvs@nand.local>
 <20250523020820.GB559000@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250523020820.GB559000@coredump.intra.peff.net>

On Thu, May 22, 2025 at 10:08:20PM -0400, Jeff King wrote:
> > (As an aside, I think I recall you suggesting a while ago that it might
> > be interesting to define "global" things with a different type than
> > "local" ones to prevent this sort of confusion. That would allow us to
> > keep both "pack_int_id" and the return value of "midx_for_pack()" in
> > scope at the same time, without the possibility of using one when you
> > meant to use the other.)
>
> Yeah. The trouble is that it becomes awkward in C, since the language
> will happily intermix two integer typedefs. So you have to wrap them in
> a struct and access the struct fields everywhere.

Yup :-<.

> > >   - There's a similar case in midx-write.c:want_included_pack(). That
> > >     one seems to have the same local/global confusion, but I do not
> > >     obviously see anything preventing it from being fed a non-base midx.
> > >     So it might possibly be buggy?
> >
> > Yeah, this spot is definitely broken. At minimum it would need something
> > like:
> >
> > --- 8< ---
> > diff --git a/midx-write.c b/midx-write.c
> > index 0897cbd829..54a04f7b75 100644
> > --- a/midx-write.c
> > +++ b/midx-write.c
> > @@ -1634,9 +1634,10 @@ static int want_included_pack(struct repository *r,
> >  			      uint32_t pack_int_id)
> >  {
> >  	struct packed_git *p;
> > +	midx_for_pack(&m, pack_int_id);
> >  	if (prepare_midx_pack(r, m, pack_int_id))
> >  		return 0;
> > -	p = m->packs[pack_int_id];
> > +	p = m->packs[pack_int_id - m->num_packs_in_base];
> >  	if (!pack_kept_objects && p->pack_keep)
> >  		return 0;
> >  	if (p->is_cruft)
> > --- >8 ---
>
> Yep, that's exactly what I was envisioning. I guess it's probably
> possible to trigger in practice by writing a new midx based on an
> existing incremental state. I'll let you figure that part out. :)

Hmm. I thought that this spot was broken last night, but looking at it
again today I think that it is actually OK. I started writing an
analysis of why in response to your email, and then decided to throw it
away since those details really should live in the patch message. Here's
what I came up with:

--- 8< ---
Subject: [PATCH] midx-write.c: guard against incremental MIDXs in
 want_included_pack()

The function want_included_pack() is used to determine whether or not a
the packfile corresponding to some given pack_int_id should be included
in a 'git multi-pack-index repack' operation.

This spot looks like it would be broken, particularly in:

    struct packed_git *p;
    if (prepare_midx_pack(r, m, pack_int_id))
        return 0;
    p = m->packs[pack_int_id];

, when pack_int_id is greater than m->num_pack_in_base (supposing that
m->num_packs_in_base is non-zero, or equivalently that m->base_midx is
non-NULL).

Suppose we have two MIDXs in an incremental MIDX chain, each having two
packs:

  - M0 = {packs: [P0, P1], base_midx: NULL}
  - M1 = {packs: [P2, P3], base_midx: M0}

noting that each pack is identified by its global pack_int_id within the
chain.

So if you do something like:

    want_included_pack(the_repository, M1, pack_kept_objects, 2);

that function will call prepare_midx_pack(), which is smart enough to
realize that the pack of interest is in the current layer (M1), and
knows how to adjust its global pack_int_id into an index into the
current layer's 'packs' array.

But the following line:

    p = m->packs[pack_int_id]; /* m is M1, pack_int_id is 2 */

looks broken, since each layer of the MIDX only maintains an array of
the packs stored within that layer, and 'm' wasn't adjusted back to
point at M1->base_midx (M0).

The right thing to do would be:

    struct packed_git *p;
    if (prepare_midx_pack(r, m, pack_int_id))
        return 0;

    /* open-code midx.c::midx_for_pack(), which is private */
    while (m && pack_int_id < m->num_packs_in_base)
        m = m->base_midx;

    if (!m)
        BUG("broken midx?");
    if (pack_int_id >= m->num_packs + m->num_packs_in_base)
        BUG("broken pack_int_id?");

    p = m->packs[pack_int_id - m->num_packs_in_base];

But that would be overkill, since this function never deals with
incremental MIDXs having more than one layer! To see why, observe that
want_included_pack() has two callers:

  - midx-write.c::fill_included_packs_all()
  - midx-write.c::fill_included_packs_batch()

and those functions' sole caller is in midx-write.c::midx_repack(),
which dispatches a call to one or the other depending on whether or not
the batch_size is non-zero.

And at the very top of midx_repack(), we have a guard against
non-trivial incremental MIDX chains:

    if (m->base_midx)
        die(_("cannot repack an incremental multi-pack-index"));

So want_included_pack() is OK becuase it will never encounter a
situation where it has to chase backwards through the '->base_midx'
pointer. But that is not immediately clear from reading the code, and is
too fragile for my comfort. Make this more clear by adding an ASSERT()
to the above effect.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/midx-write.c b/midx-write.c
index 0897cbd829..991c42d1dc 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1634,6 +1634,9 @@ static int want_included_pack(struct repository *r,
 			      uint32_t pack_int_id)
 {
 	struct packed_git *p;
+
+	ASSERT(m && !m->base_midx);
+
 	if (prepare_midx_pack(r, m, pack_int_id))
 		return 0;
 	p = m->packs[pack_int_id];
@@ -1653,6 +1656,8 @@ static void fill_included_packs_all(struct repository *r,
 	uint32_t i;
 	int pack_kept_objects = 0;

+	ASSERT(m && !m->base_midx);
+
 	repo_config_get_bool(r, "repack.packkeptobjects", &pack_kept_objects);

 	for (i = 0; i < m->num_packs; i++) {
@@ -1673,6 +1678,8 @@ static void fill_included_packs_batch(struct repository *r,
 	struct repack_info *pack_info;
 	int pack_kept_objects = 0;

+	ASSERT(m && !m->base_midx);
+
 	CALLOC_ARRAY(pack_info, m->num_packs);

 	repo_config_get_bool(r, "repack.packkeptobjects", &pack_kept_objects);
--
2.49.0.221.g485f5f8636.dirty
--- >8 ---

> > >     Likewise fill_included_packs_batch() in the same file.
> >
> > I think this one is actually OK for the same reason as the
> > expire_midx_packs() case. Its sole caller in midx_repack() has:
> >
> >     if (m->base_midx)
> >         die(_("cannot repack an incremental multi-pack-index"));
> >
> > , so we are OK there. We might want to add an ASSERT() in
> > fill_included_packs_batch() to make it clearer, though.
>
> Ah, good. Yes, I agree that an assertion would be a nice bit of
> documentation/safety. Though for these cases I think they only care
> about the pack (not the containing midx), so changing the return type of
> prepare_midx_pack() might be an even easier way to get that safety.

Ironically, the same argument applies for this function (and the _all()
variant) as well ;-).

Thanks,
Taylor
