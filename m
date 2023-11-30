Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="JZo3VyiA"
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6298510EF
	for <git@vger.kernel.org>; Thu, 30 Nov 2023 11:27:27 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-77d89b4cb96so112045885a.0
        for <git@vger.kernel.org>; Thu, 30 Nov 2023 11:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701372446; x=1701977246; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Co6SuyhGgOATJqSCMSaVB+0sT1vifDD7yujspSZbeOM=;
        b=JZo3VyiAMY+L8q96857RleMS6zilSmEAMjpWi2Hgubt2+b3mjjiHzdB+p8uviJATP4
         eDhLNKX6aIWF+Q7ZsDuje2IlmsKRyHr0drgTF675lo+gpJTnxh956/tF1RY+W1s+NPid
         yUmlKBxilSTjNifaiNAE0PSPnV194i8qxIuuwRH211rynr9DjG3B70JAVzhe9pebH5Ki
         ICpuLdhtGDLr7psGsNqP0Od/EG5YiRx8gr/dXVBYE3WFWqJOW2g7cAL8/y4OyOSMBFrn
         uy03cNzY/vrm7J7uf4d3qfotmG/OJr8WgeQhZsV/CkTeRUlpEQts5WsJ4M3VWfAyY1jt
         XWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701372446; x=1701977246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Co6SuyhGgOATJqSCMSaVB+0sT1vifDD7yujspSZbeOM=;
        b=EdJNjlgVlS4runyirH0/4X/AeKCu8BbMmegSv6BSJARQ5cVQnQy7pcjjZnCVC7Kel/
         R13hCk/NVeUf62+KDGrzcNbWZbNDvmRyS3yBuQA8jIcwk9TsGG7xx6fYdB/J3s4aWMer
         ZxbkQZKIqSv8fimRRsruETT0zeBhRFmQLcczSAzBZYjhglPNSYydwan7dl2lhmGhWGcC
         CgVBl8Qkfx9LI3SnOJBiVe98ogL4AelktwWNaoGNPVBA+tjZPX5Ul7SG7m7HZ/BCYrXq
         rr62JJgJYowMrV2cXxeYqL89iQ7Tb0Sd3wp0mo0e9r//iCYAWuB77s6TLwENmlL/AjcC
         zz9w==
X-Gm-Message-State: AOJu0Yzx8ldjF/TR1N6ahmvnCURodtZa+PKBDfD5LVIl1ueZ3rA52MVy
	F5Oq14gxtXdCaZSgijXj3C2JBQ==
X-Google-Smtp-Source: AGHT+IFqBEAmHxwA2k6JTfjc83zF7Afy34w5paR7Trjvb9ce0Ed8SpoA9jE5JdNXW52VCZA/CrXigw==
X-Received: by 2002:a05:620a:3954:b0:773:aa77:91d5 with SMTP id qs20-20020a05620a395400b00773aa7791d5mr38271665qkn.33.1701372446273;
        Thu, 30 Nov 2023 11:27:26 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id pf20-20020a05620a859400b0077dcd786533sm767614qkn.16.2023.11.30.11.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 11:27:25 -0800 (PST)
Date: Thu, 30 Nov 2023 14:27:25 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/24] midx: implement `DISP` chunk
Message-ID: <ZWjiHe/roQCqpjsu@nand.local>
References: <cover.1701198172.git.me@ttaylorr.com>
 <c52d7e7b27a9add4f58b8334db4fe4498af1c90f.1701198172.git.me@ttaylorr.com>
 <ZWhhhaXiF_wC3er7@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZWhhhaXiF_wC3er7@tanuki>

On Thu, Nov 30, 2023 at 11:18:45AM +0100, Patrick Steinhardt wrote:
> > diff --git a/Documentation/gitformat-pack.txt b/Documentation/gitformat-pack.txt
> > index 9fcb29a9c8..658682ddd5 100644
> > --- a/Documentation/gitformat-pack.txt
> > +++ b/Documentation/gitformat-pack.txt
> > @@ -396,6 +396,22 @@ CHUNK DATA:
> >  	    is padded at the end with between 0 and 3 NUL bytes to make the
> >  	    chunk size a multiple of 4 bytes.
> >
> > +	Disjoint Packfiles (ID: {'D', 'I', 'S', 'P'})
> > +	    Stores a table of three 4-byte unsigned integers in network order.
> > +	    Each table entry corresponds to a single pack (in the order that
> > +	    they appear above in the `PNAM` chunk). The values for each table
> > +	    entry are as follows:
> > +	    - The first bit position (in psuedo-pack order, see below) to
>
> s/psuedo/pseudo/

Good catch, thanks. Not sure how that escaped my spell-checker...

> > +=== `DISP` chunk and disjoint packs
> > +
> > +The Disjoint Packfiles (`DISP`) chunk encodes additional information
> > +about the objects in the multi-pack index's reachability bitmap. Recall
> > +that objects from the MIDX are arranged in "pseudo-pack" order (see:
>
> The colon feels a bit out-of-place here, so: s/see:/see/

Thanks, I'll fix that up.

> > +above) for reachability bitmaps.
> > +
> > +From the example above, suppose we have packs "a", "b", and "c", with
> > +10, 15, and 20 objects, respectively. In pseudo-pack order, those would
> > +be arranged as follows:
> > +
> > +    |a,0|a,1|...|a,9|b,0|b,1|...|b,14|c,0|c,1|...|c,19|
> > +
> > +When working with single-pack bitmaps (or, equivalently, multi-pack
> > +reachability bitmaps without any packs marked as disjoint),
> > +linkgit:git-pack-objects[1] performs ``verbatim'' reuse, attempting to
> > +reuse chunks of the existing packfile instead of adding objects to the
> > +packing list.
>
> I'm not sure I full understand this paragraph. In the context of a
> single pack bitmap it's clear enough. But I stumbled over the MIDX case,
> because here we potentially have multiple packfiles, so it's not exactly
> clear to me what you refer to with "the existing packfile" in that case.
> I'd think that we perform verbatim reuse of the preferred packfile,
> right? If so, we might want to make that a bit more explicit.

Yep, sorry, I can see how that would be confusing. Since we're talking
about the existing behavior at this point in the series (before
multi-pack reuse is implemented), I changed this to:

  "reuse chunks of the bitmapped or preferred packfile [...]"

Thanks for carefully reading and spotting my errors ;-).

> > +object. This introduces an additional constraint over the set of packs
> > +we may want to reuse. The most straightforward approach is to mandate
> > +that the set of packs is disjoint with respect to the set of objects
> > +contained in each pack. In other words, for each object `o` in the union
> > +of all objects stored by the disjoint set of packs, `o` is contained in
> > +exactly one pack from the disjoint set.
>
> Is this a property that usually holds for our normal housekeeping, or
> does it require careful managing by the user/admin? How about geometric
> repacking?

At this point in the series, it would require careful managing to ensure
that this is the case. In practice MIDX'd packs generated with a
geometric repack are mostly disjoint, but definitely not guaranteed to
be.

Further down in this series we'll introduce new options to generate
packs which are guaranteed to be disjoint with respect to the
currently-marked set of packs in the DISP chunk.

> > @@ -764,14 +807,22 @@ static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
> >  		 * Take only the first duplicate.
> >  		 */
> >  		for (cur_object = 0; cur_object < fanout.nr; cur_object++) {
> > -			if (cur_object && oideq(&fanout.entries[cur_object - 1].oid,
> > -						&fanout.entries[cur_object].oid))
> > -				continue;
> > +			struct pack_midx_entry *ours = &fanout.entries[cur_object];
> > +			if (cur_object) {
> > +				struct pack_midx_entry *prev = &fanout.entries[cur_object - 1];
> > +				if (oideq(&prev->oid, &ours->oid)) {
> > +					if (prev->disjoint && ours->disjoint)
> > +						die(_("duplicate object '%s' among disjoint packs '%s', '%s'"),
> > +						    oid_to_hex(&prev->oid),
> > +						    info[prev->pack_int_id].pack_name,
> > +						    info[ours->pack_int_id].pack_name);
>
> Shouldn't we die if `prev->disjoint || ours->disjoint` instead of `&&`?
> Even if one of the packs isn't marked as disjoint, it's still wrong if
> the other one is and one of its objects exists in multiple packs.
>
> Or am I misunderstanding, and we only guarantee the disjoint property
> across packfiles that are actually marked as such?

Right, we only guarantee disjointed-ness among the set of packs that are
marked disjoint. It's fine for the same object to appear in a disjoint
and non-disjoint pack, and for both of those packs to end up in the
MIDX. But that is only because we'll use the disjoint copy in our
bitmap.

If there were two packs that are marked as supposedly disjoint, but
contain at least one duplicate of an object, then we will reject those
packs as non-disjoint.

Thanks,
Taylor
