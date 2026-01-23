Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F82F369988
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 01:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769131330; cv=none; b=APq1m7eUlNcI0Vgyqqcu87Zulh4unou8pq5c+hA386RwClaHkss4gJ1Ybf0heP/alaX1i4iCs0PCrJYMJ0SAKJdWDn1r7+dc+kt96eiVI89d8ydZbzTYDMY5HrEW2xCxXERzJSUXWELeW9pS7cbSlPpmuCKdMlTXH6h1hysKcYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769131330; c=relaxed/simple;
	bh=9V+qXRUhceHZL5tOqvnuFTpQPnk/xXndMdKIhedff/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FchH+LoGOz0RqYeLQNhir/ioTM1ElCuyvm6tMWrm149ebPaAVFFNZzeRBprByHoc6/ZyoE9K72uiNSF0h1MnL9nt3NaUDLMkR2vixsWqnswGQVcnOQjUMbgkSLfSVvcl0oqxCiD6gTLCyNywK92nXEOLR45bGHVMc941LuPOX1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=PWD+QC6Q; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="PWD+QC6Q"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7942fca0da6so9277797b3.3
        for <git@vger.kernel.org>; Thu, 22 Jan 2026 17:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1769131316; x=1769736116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G7Dtn9Uf+Kd2t+BDs6cIGBGVEYxoSWtxdrNPPz2EulU=;
        b=PWD+QC6QQgYkY+UrVfq0uojfR3bEud+VRYfmll1oz5I0044ZX29G9dvPoFX/bs7zQF
         oFzt7kUGbBd5J1jWH3z8n561smUAUSOZQPg3y0bo+NK2m66tCn2fIgPn2d4G6mAErVfQ
         6+GIyWrqtf7EUY3sx4K/jd5xxfOU2JuYREQqOamsru3i603VoaO+k2XGZQcbgPH3A9Om
         hJpUJ84ZVI+XgXjOm6n8nL/Gx+mv/oiO1smIxLdV/ar3iQn4wcU/rcDazzMzfwUqtNq1
         W2LIENmd7jb6/wmkpMe98w+hrw4TwrP5j/dd7XbNBPLHXWg9EJT8XwUffvIE+vN3QMhK
         K18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769131316; x=1769736116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G7Dtn9Uf+Kd2t+BDs6cIGBGVEYxoSWtxdrNPPz2EulU=;
        b=L0W602jXKbmgWK5LeCOPLzg/s7h0y+NuXOHVv9WvkQ2nxI9235Y9IHrLm/Uv7UjeXD
         2WBbX8/ibvWQjW34p+ghJXeiQd1devVcNLOL88aoPteJ1wWTT8w0AqHAWK2VcyKgC9IP
         rnjP+tZIsQAmclOPiFNbkybf1AFnUh6NxbDVnp0ORT0wx5+JNAWxj7qM0mrF9mb8tBjg
         +udPZMWZsc6cMqCAxPqaiv+cUT3YfGLxlk5Jr1rw84RiH9xWtBG4femiy7g9rQkVg2Z2
         J2q+p+0GbI7w2gZr8MLKThcLFnBwScKfJJ+X6I/7tg8x4JuXDhdAiOVK1H0r9OHSRDWG
         Z+dA==
X-Gm-Message-State: AOJu0Yw05nwjpOCH/MeJgJi82O/EDYXkkrtimXkqWYupZO7OS1pEoM8Q
	pShvJl68rrWR5UfI4G2LAP9s6oIRWk6QIYDBGdE3yqdHZq5nuF1618C+l2xRotmJZVw=
X-Gm-Gg: AZuq6aIWx8pZxamfSugqS5mmOhBfYwqCHdf8lS77WJ4neMU6b+88pMcKyDUixCyf4+7
	jOjm4kdTXXDmdZ4jZO/jX6m49Ir7aDsgUAUXiiPtvRSVIhC/fsxk7L8rxWIyju3B5c/MjbZw4Kc
	tFakTOHl1hfMwtErGRofOLmA1p0ZY0HPRZVTr0zmNli1H5+54oZnc0tBzWSzBPclcvPl0l9DjCk
	rEpB9GFDZzfxihe66uCYHCciDCQA27rtaZFiXngTNOHutB55YSj/28IeRKyG/kSjMpl+M40Iwa/
	B6OXPjleADueBkVzRcaANkPtwFmLuWEGST39TCS3wzEBAio6Pne2q99EZ+DPjk58y140TCUN2b2
	nPFHrJnDISq9fFuKIRgcjDqV657CsNFkjIR4XFPjkeWqy+lD2tpEo4/87deuXQnVPZvHJxtqp0H
	aCD3TvtVN7QbTBBvP/HAVyATm0+mvfxgYlCtu7UrJZSM+pKmVzrAtDhGCZmU3hUiGoVk32xUcsj
	X7CmEx8EGqeXv1xYQ==
X-Received: by 2002:a05:690c:6307:b0:794:18b2:1ea with SMTP id 00721157ae682-794399f155fmr13842437b3.59.1769131316639;
        Thu, 22 Jan 2026 17:21:56 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7943af13d62sm4457677b3.11.2026.01.22.17.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 17:21:56 -0800 (PST)
Date: Thu, 22 Jan 2026 20:21:55 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 12/14] builtin/pack-objects: use
 `packfile_store_for_each_object()`
Message-ID: <aXLNM+AOpdQtmisC@nand.local>
References: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
 <20260121-pks-odb-for-each-object-v3-12-12c4dfd24227@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260121-pks-odb-for-each-object-v3-12-12c4dfd24227@pks.im>

On Wed, Jan 21, 2026 at 01:50:28PM +0100, Patrick Steinhardt wrote:
>  static int add_object_in_unpacked_pack(const struct object_id *oid,
> -				       struct packed_git *pack,
> -				       uint32_t pos,
> +				       struct object_info *oi,
>  				       void *data UNUSED)
>  {
>  	if (cruft) {
> -		off_t offset;
> -		time_t mtime;
> -
> -		if (pack->is_cruft) {
> -			if (load_pack_mtimes(pack) < 0)
> -				die(_("could not load cruft pack .mtimes"));
> -			mtime = nth_packed_mtime(pack, pos);
> -		} else {
> -			mtime = pack->mtime;
> -		}
> -		offset = nth_packed_object_offset(pack, pos);
> -
> -		add_cruft_object_entry(oid, OBJ_NONE, pack, offset,
> -				       NULL, mtime);

OK, here's where we see the existing logic for determining the mtime of
an object in the GC sense. I see there's a subsequent patch that also
makes use of the object_info->mtimep field, and my guess is (not having
completely read that patch yet) that having the same notion of mtime
between the two callsites is desirable.

I still wonder whether imposing that notion of mtime at the object_info
layer is the right choice. I wonder if it would make more sense to allow
the caller to have a "statp" pointer filled out (or alternatively stick
a "struct stat" in both the packed union type as well as the loose one,
though the latter doesn't yet exist).

Then the caller could do something like:

static time_t object_info_gc_mtime(const struct object_info *oi)
{
    if (!oi->statp)
        BUG("oops!");

    switch (oi->whence) {
    case OI_CACHED:
        return 0;
    case OI_LOOSE:
        return oi->statp->st_mtime;
    case OI_PACKED:
        struct packed_git *p = oi->u.packed.pack;
        if (p->is_cruft) {
            uint32_t pack_pos;

            if (load_pack_mtimes(p) < 0)
                die(_("could not load cruft pack .mtimes for '%s'"),
                    pack_basename(p));
            if (offset_to_pack_pos(p, oi->u.packed.offset, &pack_pos) < 0)
                die(_("could not find offset for object '%s' in cruft pack '%s'"),
                    oid_to_hex(&oi->oid),
                    pack_basename(p));

            return nth_packed_mtime(p, pack_pos_to_index(p, pack_pos));
        } else {
            return p->mtime; /* or oi->statp->st_mtime */
        }
    default:
        BUG("unknown oi->whence: %d", oi->whence);
    }
}

I like the above because it encapsulates the GC-specific interpretation
of an object's mtime outside of the object_info layer, while adding
information (namely statp) that is generic enough to be potentially
useful to other callers who may not be interested in the GC-specific
interpretation.

> +		add_cruft_object_entry(oid, OBJ_NONE, oi->u.packed.pack,
> +				       oi->u.packed.offset, NULL, *oi->mtimep);
>  	} else {
>  		add_object_entry(oid, OBJ_NONE, "", 0);
>  	}
> @@ -4341,14 +4328,24 @@ static int add_object_in_unpacked_pack(const struct object_id *oid,
>
>  static void add_objects_in_unpacked_packs(void)
>  {
> -	if (for_each_packed_object(to_pack.repo,
> -				   add_object_in_unpacked_pack,
> -				   NULL,
> -				   ODB_FOR_EACH_OBJECT_PACK_ORDER |
> -				   ODB_FOR_EACH_OBJECT_LOCAL_ONLY |
> -				   ODB_FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS |
> -				   ODB_FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS))
> -		die(_("cannot open pack index"));
> +	struct odb_source *source;
> +	time_t mtime;
> +	struct object_info oi = {
> +		.mtimep = &mtime,
> +	};
> +
> +	odb_prepare_alternates(to_pack.repo->objects);
> +	for (source = to_pack.repo->objects->sources; source; source = source->next) {
> +		if (!source->local)
> +			continue;

OK, we dropped the ODB_FOR_EACH_OBJECT_LOCAL_ONLY flag when dispatching
to the packfile_store iterator, but that's OK, since it's handled above
here.

Interestingly, packfile_store_for_each_object_internal() has a similar
check:

    if ((flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
        continue;

, but I'm wondering whether these are subtly different. Would a
non-local source ever have packs for which the p->pack_local bit is set?
Or is the locality of a pack determined relative to the source
containing it, in which case we'd need to make the check here?

> +		if (packfile_store_for_each_object(source->packfiles, &oi,
> +						   add_object_in_unpacked_pack, NULL,
> +						   ODB_FOR_EACH_OBJECT_PACK_ORDER |
> +						   ODB_FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS |
> +						   ODB_FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS))
> +			die(_("cannot open pack index"));
> +	}
>  }
>
>  static int add_loose_object(const struct object_id *oid, const char *path,
>
> --
> 2.53.0.rc0.250.g0ac79233d6.dirty
>
Thanks,
Taylor
