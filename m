Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A871805E
	for <git@vger.kernel.org>; Sat,  1 Mar 2025 00:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740788401; cv=none; b=CaqePLXew0I/wS9mhhCZwMwNS3mkNICFH8WxFa1bZxhsbotYqCtTU6T2UpNDMrEX23zVpzyh+O/xRX4JH3BfDyo6TdnIJVv/u1sv4jwgF9iKxbJwPBt8D4QzkUC/KPbDAcpaQ6BsEXSohH2NlP0BMX5fNBiyqQccLgTuDImkVWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740788401; c=relaxed/simple;
	bh=tkTZmVuCq35UIEWfY6NR3cUEqdj7EsRXtCBCI48MGDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AIlyDptyjVT4ysnzpp8xAh+2xcHcSFZdD8cPFMqMQYNraAiH5j8MXvZqMLd675GqjupDFxwzA0LWnuMepgv6Vp5TN3znSiCSh5xxJTwAj/pUoygWABwYvs/E9J2AREQPp6jwnUy8pRWGzpHw+RPYtVpJDOCBkd54sOuuoc97U7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=W2x95oSf; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="W2x95oSf"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6f754678c29so25873317b3.0
        for <git@vger.kernel.org>; Fri, 28 Feb 2025 16:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1740788398; x=1741393198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mNRFf6B9f7JBw1n0+hBvdSzfHlGUWwhDUt50P7qMJrU=;
        b=W2x95oSfDKv+Ld0ke9/WjGKfPD61GjGEt34ivOd4tbJ/flz1Qlna0dO4fcRRZpGRkt
         TowgGgt4UdjJxE3x5W7x8AptxkgohgM6Pzx7XbzxHA12Fsgl7O+8fCHCitI3Gkx3X4Z/
         ryObKS+a/7IF2yYfJ9/t5ozTOJLPaI08up6jk76QuK1kUthVq4/UNeEmZkzY76+d87rR
         tLCO+DbvvfGuuOhnjTVzhq3yWvKM5/0FFVb46YTNxZMvmZ64r9TEVFRCun7dREkr8XLM
         eM+BTmJ7nIpgXTM7GfMmHesV9CsdamX9XlUa6kwkEsT4Ju2xvq98unuALB2BUwOeC3GP
         O51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740788398; x=1741393198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNRFf6B9f7JBw1n0+hBvdSzfHlGUWwhDUt50P7qMJrU=;
        b=R8F922xCn9X9VlDTotBQVQEolGuxwXshP7Yac2HhTKA6Un5gZMLcmp5cRgiVjn4Mo8
         +oGFr6ZI+qmHjcGtHk3De/849BC7MXwf5ir8FwGkZlln/LaqZfsHlRCnWZfNd0ztA8Lh
         rYCbSsRuhbvMpJ5oVELgt6azoqrvNNU7SpzcgtzJ3UGfUSwX1r7gggG7RBy1rY53Qa4d
         //TPEicwyEJaq9AycJR5yeujnI55Y4ohhzjFUeqlM2NksHjjI+R8lR4kwvevOY/SWGR5
         gmfVIjLU09buAcib0ADHqoOIW/YH82i4ptAiWzPybJhB6pS5gJi16Xq8Qw/JxTIo2U5Q
         xu5g==
X-Gm-Message-State: AOJu0YwQhCK+iXyIXAdrLl9c9wvzS2trcPpld4u91elKYbI0b7JpTWaQ
	aPi3wbpB+nz7VDxOfDsPVonh58Gu9UWXw1N53+AfnyVEOhceVhoAoX6Q2YtSxcs=
X-Gm-Gg: ASbGncs8gtb1PWk10S3KEeC/U3G8u1gIEN+AiA5y/NI6DBhBoGTxxUdAM91eaqbJFEs
	Gz9bXOovLnZlf6NiQLFBwAwh2wm2Q7hfUhV9vyQfycePY3fMVO8R4iArzcYYAoQTqV8EBV6iSZe
	4k8X7xOVizlP1WbQDtpco5Lrj3qjyYvZdbscS1u0HenSVq7xsu7BP6S4SkCXET/h6dmH7P0346z
	Olnsx6HJLsV/1CPk8bowSwrUL4v+shZwokpSjUIR7F++3RF/SxqaSMmvMhsi3uAbqBKwa/ZjsYY
	vFjbLEahOzjC0AbFJLJ6eWHl4zbzm8s+Q3EXpylvLnBiFwmsyoXxk3g2/Bw8opg6WKfiwnavU5F
	y48PWG1NAAtIC5JX4
X-Google-Smtp-Source: AGHT+IGrCLqmHpi3hU5+lZtB08Qh2wdrnvtIh3UtXAhZtcWCEonloN641okEpzp9bWgJSDC68lTKKA==
X-Received: by 2002:a05:690c:74c4:b0:6fb:9c9d:134 with SMTP id 00721157ae682-6fd4a09211amr80442557b3.19.1740788398617;
        Fri, 28 Feb 2025 16:19:58 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6fd3ca0f4b8sm9605337b3.18.2025.02.28.16.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 16:19:58 -0800 (PST)
Date: Fri, 28 Feb 2025 19:19:57 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 07/13] pack-bitmap.c: teach `rev-list --test-bitmap`
 about incremental MIDXs
Message-ID: <Z8JSreTnEFlocYQ9@nand.local>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1732054032.git.me@ttaylorr.com>
 <17ab23dd76dce076275873e96991acd2f2b2a994.1732054032.git.me@ttaylorr.com>
 <Z8GJdv5FwDP_k1et@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8GJdv5FwDP_k1et@pks.im>

On Fri, Feb 28, 2025 at 11:01:26AM +0100, Patrick Steinhardt wrote:
> On Tue, Nov 19, 2024 at 05:07:38PM -0500, Taylor Blau wrote:
> > diff --git a/pack-bitmap.c b/pack-bitmap.c
> > index 1dddb242434..02864a0e1f7 100644
> > --- a/pack-bitmap.c
> > +++ b/pack-bitmap.c
> > @@ -2564,13 +2584,57 @@ static void test_show_commit(struct commit *commit, void *data)
> >  	display_progress(tdata->prg, ++tdata->seen);
> >  }
> >
> > +static uint32_t bitmap_total_entry_count(struct bitmap_index *bitmap_git)
> > +{
> > +	uint32_t total = 0;
> > +	do {
> > +		total = st_add(total, bitmap_git->entry_count);
> > +		bitmap_git = bitmap_git->base;
> > +	} while (bitmap_git);
> > +
> > +	return total;
> > +}
> > +
> > +static void prepare_bitmap_test_data(struct bitmap_test_data *tdata,
> > +				     struct bitmap_index *bitmap_git)
>
> Nit: according to our style guide this should be called
> `bitmap_test_data_prepare()`.

Ah, I didn't know about that part of the style guide. It looks like it
comes from your 10f0723c8d (Documentation: document idiomatic function
names, 2024-07-30), which is semi-recent ;-).

> > +{
> > +	memset(tdata, 0, sizeof(struct bitmap_test_data));
> > +
> > +	tdata->bitmap_git = bitmap_git;
> > +	tdata->base = bitmap_new();
> > +	tdata->commits = ewah_to_bitmap(bitmap_git->commits);
> > +	tdata->trees = ewah_to_bitmap(bitmap_git->trees);
> > +	tdata->blobs = ewah_to_bitmap(bitmap_git->blobs);
> > +	tdata->tags = ewah_to_bitmap(bitmap_git->tags);
> > +
> > +	if (bitmap_git->base) {
> > +		CALLOC_ARRAY(tdata->base_tdata, 1);
> > +		prepare_bitmap_test_data(tdata->base_tdata, bitmap_git->base);
> > +	}
> > +}
> > +
> > +static void free_bitmap_test_data(struct bitmap_test_data *tdata)
>
> Same nit here, this should be called `bitmap_test_data_free()`. In fact,
> it should be called `bitmap_test_data_release()`, because we don't free
> `tadata` itself.

Noted, and adjusted!

> > @@ -2579,17 +2643,26 @@ void test_bitmap_walk(struct rev_info *revs)
> >  	if (revs->pending.nr != 1)
> >  		die(_("you must specify exactly one commit to test"));
> >
> > -	fprintf_ln(stderr, "Bitmap v%d test (%d entries%s)",
> > +	fprintf_ln(stderr, "Bitmap v%d test (%d entries%s, %d total)",
> >  		bitmap_git->version,
> >  		bitmap_git->entry_count,
> > -		bitmap_git->table_lookup ? "" : " loaded");
> > +		bitmap_git->table_lookup ? "" : " loaded",
> > +		bitmap_total_entry_count(bitmap_git));
> >
> >  	root = revs->pending.objects[0].item;
> > -	bm = bitmap_for_commit(bitmap_git, (struct commit *)root);
> > +	bm = find_bitmap_for_commit(bitmap_git, (struct commit *)root, &found);
> >
> >  	if (bm) {
> >  		fprintf_ln(stderr, "Found bitmap for '%s'. %d bits / %08x checksum",
> > -			oid_to_hex(&root->oid), (int)bm->bit_size, ewah_checksum(bm));
> > +			oid_to_hex(&root->oid),
> > +			(int)bm->bit_size, ewah_checksum(bm));
> > +
> > +		if (bitmap_is_midx(found))
> > +			fprintf_ln(stderr, "Located via MIDX '%s'.",
> > +				   hash_to_hex(get_midx_checksum(found->midx)));
> > +		else
> > +			fprintf_ln(stderr, "Located via pack '%s'.",
> > +				   hash_to_hex(found->pack->hash));
> >
> >  		result = ewah_to_bitmap(bm);
> >  	}
>
> I'm a bit surprised that this doesn't result in any changes required in
> our tests.

That's intentional, the aim of this commit is really just to get us
ready for the eventuality of having incremental MIDXs. In the meantime,
we don't disrupt the behavior of --test-bitmap for single-layer MIDX
bitmaps.

Thanks,
Taylor
