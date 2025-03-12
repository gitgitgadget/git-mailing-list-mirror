Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A561EE7C6
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 21:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741814060; cv=none; b=hV89CHNej2JKB335FvTzuirM94Scgy5apHaj5Td4CatTm9759ZeDzPWUkbXP24IbidAanZpRz/XRJwsrW5nyg5DXs6C44VQVJHkN7MoCC8KT0KEM+0qajLkbZW4RAppQuXf31o1i09RYumMBFZHLk/tU3SC4/8O3o+qUIizkrko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741814060; c=relaxed/simple;
	bh=hJWdvt8dK0weAd7s+H2VS4e03i8Bboc4gOyJDwmQbf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSKnwZelEvCwaSi1BUoU18v2FvS0STj72zOab5lryhsLMuXPyqERZv71EpMGqRzmKFWKL2jgwpZys/5ETRm4dS+jKiqdzN41RSXAWucZ/Hp0B2JUAqI2SK74FdyOXktGikW/xsqxM/u6kkjo5O9B+dccK8zb0zKBXojIr3tN8SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=shcMEXc2; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="shcMEXc2"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e549be93d5eso305086276.1
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 14:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741814056; x=1742418856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SHu/gQPFOnr6fJItjaaPtdnvmLAZW8Q+IeIzv+7KT58=;
        b=shcMEXc2DVDif6DMAVbdhqI5y0msq/h3XNn9ucPqSNacq9U6NkILO4TAYM3ZGjgCZ4
         Vs5mT+wGLhRPG6LwwDtCZhdZ8Q376qNKcGr5e15UaTgOU2PpDkWHTJvUm0XdHhyEofsz
         Z7tyTGwHHT+3fwATaH8M6qpGWSVty2CJ/X0XSFVtB8LVoBp/b9yEiSEkhwemiTX2jssl
         GcYL2Gg61k1gBceMxYSzOCppH9fcERvrR2spuCkHNJLcZnqD2NY85V6bG/rAN4Z/bfSt
         rQkko9BfFBijPUMKvWPjCyGLyv03bWhd6u3RVa4i6vpN/b1XSxpT3eFDComH64E7DBlT
         tM+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741814056; x=1742418856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHu/gQPFOnr6fJItjaaPtdnvmLAZW8Q+IeIzv+7KT58=;
        b=ADcgMbJvzMs405j0s+NE5gzHGRXC0lPN1Q/CIbiAb/OFf9nsTWKpWOLN6rDPXCisD9
         oUBO6sSCL5bhetpD/YX6UsKZ+zy7M3mLMtahmXqP8F/Lk6MDNLxRK+9yL8tnQTyvGgiz
         BuVG0410h/30vhnyZau4quR0NH7WP26hP7VSMuRNhE2a/wONKtR4SqbbNAd3iqeiiIgk
         hdHZEHCwcVDKoUZxbb0X4jPiAz4hQTEa7aofxnNd9xU55i8mN0of2063rl50CcbZiwrv
         EYujo8djWs8ozDPzACMK5pWez0/BAFd6mHuK19BMx/iMZzXvynyX7ldqUI2MYZjtYraL
         zd7w==
X-Gm-Message-State: AOJu0Yw5IUDz9MMGw5gtCa3r4Uk8wa66GmrQB0HcnNY9H86Uun2NcOxx
	kP0VFv74unHSrSa74vqI696M1fBJZwAItLaZnpUi5jGRbjPO40L2yNKPZxpmtVc=
X-Gm-Gg: ASbGncss8cPYH0d1cXyijwrIYSo5rSElN5s0oV3rCeh9W3dtHT5e8oBtM2KBGvXz+Xh
	Dle9r15TJdZEKJn/KIQU6bUVVzz92LVKGS3R8xvQo1vOV6+NpqcShBnALPJkBc1zDdA/gxGnutZ
	BAi50sykVJDUFrqM7lH1PwmOrrdl5nmIP3BbFme++0UL9eCwPKG8d23cbU1zlo6stFlxt5tY2dP
	RB8IDXgdi3P8oovYXDnMMoTZOk6x7chYOBx4kZuBAA87HR8fLhhb7q4L+VwV/pjvsVzDIZ9qVMP
	hXsq8CbBHmyHx/NsycDk0mi3LGQI16rGB5rlrAQsXHWpka/Nt1zvuhw1cDthoD06BOeHdx5bMoI
	WKQ1atZ4hqLMg2t+MxPaRSBl8MiE=
X-Google-Smtp-Source: AGHT+IF6culrnCNbjyVkIu9hGxHIEENtVbDVjMPazGojhed595/mEBswBfEiVi/HgdlbAF1pH3xRbg==
X-Received: by 2002:a05:6902:98e:b0:e5d:d8ea:8c96 with SMTP id 3f1490d57ef6-e635c18bcc6mr31977270276.29.1741814055838;
        Wed, 12 Mar 2025 14:14:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e634b8fde4fsm3353833276.49.2025.03.12.14.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 14:14:15 -0700 (PDT)
Date: Wed, 12 Mar 2025 17:14:14 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
	johannes.schindelin@gmx.de, johncai86@gmail.com,
	jonathantanmy@google.com, karthik.188@gmail.com,
	kristofferhaugsbakk@fastmail.com, newren@gmail.com, peff@peff.net,
	ps@pks.im, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 02/13] pack-objects: add --path-walk option
Message-ID: <Z9H5JsicyLWXagxS@nand.local>
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
 <9b31dc87bb61f4d73eced02a24baea58bc51aa5e.1741571455.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9b31dc87bb61f4d73eced02a24baea58bc51aa5e.1741571455.git.gitgitgadget@gmail.com>

On Mon, Mar 10, 2025 at 01:50:44AM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <stolee@gmail.com>
>
> In order to more easily compute delta bases among objects that appear at
> the exact same path, add a --path-walk option to 'git pack-objects'.
>
> This option will use the path-walk API instead of the object walk given
> by the revision machinery. Since objects will be provided in batches
> representing a common path, those objects can be tested for delta bases
> immediately instead of waiting for a sort of the full object list by
> name-hash. This has multiple benefits, including avoiding collisions by
> name-hash.
>
> The objects marked as UNINTERESTING are included in these batches, so we
> are guaranteeing some locality to find good delta bases.
>
> After the individual passes are done on a per-path basis, the default
> name-hash is used to find other opportunistic delta bases that did not
> match exactly by the full path name.
>
> The current implementation performs delta calculations while walking
> objects, which is not ideal for a few reasons. First, this will cause
> the "Enumerating objects" phase to be much longer than usual. Second, it
> does not take advantage of threading during the path-scoped delta
> calculations. Even with this lack of threading, the path-walk option is
> sometimes faster than the usual approach. Future changes will refactor
> this code to allow for threading, but that complexity is deferred until
> later to keep this patch as simple as possible.
>
> This new walk is incompatible with some features and is ignored by
> others:
>
>  * Object filters are not currently integrated with the path-walk API,
>    such as sparse-checkout or tree depth. A blobless packfile could be
>    integrated easily, but that is deferred for later.
>
>  * Server-focused features such as delta islands, shallow packs, and
>    using a bitmap index are incompatible with the path-walk API.
>
>  * The path walk API is only compatible with the --revs option, not
>    taking object lists or pack lists over stdin. These alternative ways
>    to specify the objects currently ignores the --path-walk option
>    without even a warning.
>
> Future changes will create performance tests that demonstrate the power
> of this approach.
>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  Documentation/git-pack-objects.adoc        |  13 +-
>  Documentation/technical/api-path-walk.adoc |   1 +
>  builtin/pack-objects.c                     | 147 +++++++++++++++++++--
>  t/t5300-pack-object.sh                     |  15 +++
>  4 files changed, 166 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/git-pack-objects.adoc b/Documentation/git-pack-objects.adoc
> index 7f69ae4855f..7dbbe6d54d2 100644
> --- a/Documentation/git-pack-objects.adoc
> +++ b/Documentation/git-pack-objects.adoc
> @@ -16,7 +16,7 @@ SYNOPSIS
>  	[--cruft] [--cruft-expiration=<time>]
>  	[--stdout [--filter=<filter-spec>] | <base-name>]
>  	[--shallow] [--keep-true-parents] [--[no-]sparse]
> -	[--name-hash-version=<n>] < <object-list>
> +	[--name-hash-version=<n>] [--path-walk] < <object-list>
>
>
>  DESCRIPTION
> @@ -375,6 +375,17 @@ many different directories. At the moment, this version is not allowed
>  when writing reachability bitmap files with `--write-bitmap-index` and it
>  will be automatically changed to version `1`.
>
> +--path-walk::
> +	By default, `git pack-objects` walks objects in an order that
> +	presents trees and blobs in an order unrelated to the path they
> +	appear relative to a commit's root tree. The `--path-walk` option
> +	enables a different walking algorithm that organizes trees and
> +	blobs by path. This has the potential to improve delta compression
> +	especially in the presence of filenames that cause collisions in
> +	Git's default name-hash algorithm. Due to changing how the objects
> +	are walked, this option is not compatible with `--delta-islands`,
> +	`--shallow`, or `--filter`.

I think from reading further below that this feature is somewhat
incompatible with --use-bitmap-index, at least in the sense that we
implicitly disable the latter whenever we see the former. Would that be
worth mentioning here?

> +static int add_objects_by_path(const char *path,
> +			       struct oid_array *oids,
> +			       enum object_type type,
> +			       void *data)
> +{
> +	struct object_entry **delta_list;
> +	size_t oe_start = to_pack.nr_objects;
> +	size_t oe_end;
> +	unsigned int sub_list_size;
> +	unsigned int *processed = data;
> +
> +	/*
> +	 * First, add all objects to the packing data, including the ones
> +	 * marked UNINTERESTING (translated to 'exclude') as they can be
> +	 * used as delta bases.
> +	 */
> +	for (size_t i = 0; i < oids->nr; i++) {
> +		int exclude;
> +		struct object_info oi = OBJECT_INFO_INIT;
> +		struct object_id *oid = &oids->oid[i];
> +
> +		/* Skip objects that do not exist locally. */
> +		if (exclude_promisor_objects &&
> +		    oid_object_info_extended(the_repository, oid, &oi,
> +					     OBJECT_INFO_FOR_PREFETCH) < 0)
> +			continue;
> +
> +		exclude = !is_oid_interesting(the_repository, oid);
> +
> +		if (exclude && !thin)
> +			continue;
> +
> +		add_object_entry(oid, type, path, exclude);
> +	}
> +
> +	oe_end = to_pack.nr_objects;
> +
> +	/* We can skip delta calculations if it is a no-op. */
> +	if (oe_end == oe_start || !window)
> +		return 0;
> +
> +	sub_list_size = 0;
> +	ALLOC_ARRAY(delta_list, oe_end - oe_start);

Makes sense, and seems all reasonable.

> +	for (size_t i = 0; i < oe_end - oe_start; i++) {
> +		struct object_entry *entry = to_pack.objects + oe_start + i;
> +
> +		if (!should_attempt_deltas(entry))
> +			continue;
> +
> +		delta_list[sub_list_size++] = entry;
> +	}
> +
> +	/*
> +	 * Find delta bases among this list of objects that all match the same
> +	 * path. This causes the delta compression to be interleaved in the
> +	 * object walk, which can lead to confusing progress indicators. This is
> +	 * also incompatible with threaded delta calculations. In the future,
> +	 * consider creating a list of regions in the full to_pack.objects array
> +	 * that could be picked up by the threaded delta computation.
> +	 */
> +	if (sub_list_size && window) {
> +		QSORT(delta_list, sub_list_size, type_size_sort);
> +		find_deltas(delta_list, &sub_list_size, window, depth, processed);
> +	}

Interesting. I like the "regions in to_pack.objects" idea as a way of
threading the delta selection process in the future.

Thanks,
Taylor
