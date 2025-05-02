Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EA91EF372
	for <git@vger.kernel.org>; Fri,  2 May 2025 23:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746228094; cv=none; b=JG3+C37PNlROBhvyE98ym+hFlH3HXwrfUQhTKpDZq8P8COieMJcFDWCcM5UhHNAlUTN4I4H7X2g37dK6nYfiThEhg+5NTFmVLcp7Y3nCKOtu1aTgg73g+Jvyw+lwZzOk/1N2ae9NEIBkkuXpzd3iuMSRh5CIXIfojqv2GUY3VCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746228094; c=relaxed/simple;
	bh=dru6ILqhMZtWjde1l6/M1C9h6xvEPsZRTnlNAMDPh1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h49VVfwijqrN7sE+ysmTerSQYf6/DTtAoZESSNs+ncsY+UnotQacS4qsqa0rno1TmV7qrt9vcPUbV+UPfI3Bt6PbP6iUzHbcMdwIamZoo5MU+dmyQlgUYnFritrRCGz5ex1IJe9tbKPXf18ggCHOh0sCRVdeuRPqjhUcEI3GYI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=tDDC19Y2; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="tDDC19Y2"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c56a3def84so251567585a.0
        for <git@vger.kernel.org>; Fri, 02 May 2025 16:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1746228091; x=1746832891; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gRdO7akMND3mC2mlDsLhbcQKhR2ko5mvKkAkKoJKwFs=;
        b=tDDC19Y2Kmv25wynqjBu6NwzCvGee7wfqdqHbpRgWuFZMqe5bQBn7PZXSYRXjF3Zc7
         zfrmrwFO80ETQIJRY3UEpXltRBsPg3ZXxdX3tU4ZUZi1SOQNAyEKKM6fUqLrf4Vz5N2t
         OJfxHtvBTAuHS8IZGZQ9kci4bNozPN0vSaGWMYVwHNWIdAr/dmozngYYzhycFdUMno/H
         kDLJZmZXVcIIhN7A3JKQwxXMcP0v241QNLzTT9ivTK5KE/X/L5+2whBgNiW+o1GhHjX0
         orVGQij4Bo+W5PYDMJzjhw1i6Sr4NEVSgAAacitVF4AlLuNVQa2b2UGnmjXRTLI72Hxz
         OvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746228091; x=1746832891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRdO7akMND3mC2mlDsLhbcQKhR2ko5mvKkAkKoJKwFs=;
        b=BnXM5LoHchTkASyFXqrVe+4Hhdkp1ClPY7JBZvlUosJjuUp6M2VlPNbI29sWD6LmYy
         Sav5u93MtcN0xkJ5SKNO4K757FVBWhHnNgOYV7mezpaJqbzIfosyneYXgUs9R0kU2J0s
         6lULarSYurMJWPR+gJRe3I6ZS8L9WIjqWwioyyeRFaharZgXYfw3YRo/VQumHEo1SlpR
         WFuQesRGa0aAUJSyljTF4qrNsCYs1vOcelwlrZgt/2mjC+DLwLUZ7b/M76t74rvTn0h7
         TCRm2WS4wibmTvFC6C9PdSWmkZ3ubxS7iyjuUamkBAmPVbJlLskmZ8uqYcvaw6VQlcll
         j0UA==
X-Gm-Message-State: AOJu0YyXRzYPFPbq2iW6WCAuz2GVyPyE+3KBc3OAI74duFj1Kxm6fh15
	Q5TYk5q5VWaXdUxTlsupzj9jrPJxiVb13KIlgFhi7IK2+FFWmDl4aDOqiwrsgQ0=
X-Gm-Gg: ASbGncu+LvazoHyO9exxqZxA9BrrgXxl8ruCCtC7zudtT+F0Q/zb7ttYkNdFBl93beE
	zvMt2gANraIB7656RjfKi3zYUkDa7ObpWGDS2aL+nN0pmx8JA776nY4Z9vYTxjkms0Hwe73dBnx
	uvZIU1D1kGGjnIogUrNMMUNOC0K44KzQ12Avf4ELjrwsq1fTaUQXdcRE0R7QSDTCStWZUvVg4Ms
	bregfzx49lFtyFbhf3mLZwNssFvmx5vl5wGfBUPpvMwIGWFx4R24+4QyNRDUbQNiLECiCLeFNDW
	SgEoIy4nOKB72fwBD7p2ii7SZ0Nj2XGreYTjDBOTtrr37EBsE6tet1Fddrwuge3VPRnOetGV2l9
	5d0V0LZ3zAmxe
X-Google-Smtp-Source: AGHT+IGcg0mk23H41aIPz9zaDOnSrR9+9LNWecgzqBDTEGPH+O98oohEy4ihv/ZvmDJ+W1eNeYVgWQ==
X-Received: by 2002:a05:620a:171f:b0:7c9:2383:afef with SMTP id af79cd13be357-7cadfea91aemr132428785a.37.1746228090626;
        Fri, 02 May 2025 16:21:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7cad242b657sm253356685a.69.2025.05.02.16.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 16:21:30 -0700 (PDT)
Date: Fri, 2 May 2025 19:21:22 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
	johannes.schindelin@gmx.de, johncai86@gmail.com,
	jonathantanmy@google.com, karthik.188@gmail.com,
	kristofferhaugsbakk@fastmail.com, newren@gmail.com, peff@peff.net,
	ps@pks.im, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 02/13] pack-objects: add --path-walk option
Message-ID: <aBVTcvhW+lW0GLpQ@nand.local>
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
 <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
 <a271d6245c243d50d95ea6c7e624b3165f7da558.1742829770.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a271d6245c243d50d95ea6c7e624b3165f7da558.1742829770.git.gitgitgadget@gmail.com>

On Mon, Mar 24, 2025 at 03:22:38PM +0000, Derrick Stolee via GitGitGadget wrote:
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

Thanks for the clear explanation here.

> The current implementation performs delta calculations while walking
> objects, which is not ideal for a few reasons. First, this will cause
> the "Enumerating objects" phase to be much longer than usual. Second, it
> does not take advantage of threading during the path-scoped delta
> calculations. Even with this lack of threading, the path-walk option is
> sometimes faster than the usual approach. Future changes will refactor
> this code to allow for threading, but that complexity is deferred until
> later to keep this patch as simple as possible.

I can't remember if I called this out in my previous round of review,
but I definitely appreciate you separating out the threading
implementation. When I first started to read this paragraph, I thought
"huh, I bet this is parallelizeable", and I was glad to see that you
both (a) called out the same thing, and (b) deferred it to a later patch
to reduce the complexity of this one. Thanks.

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

Much appreciated to likewise call out the (current) limitations here as
well.

> Future changes will create performance tests that demonstrate the power
> of this approach.
>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  Documentation/git-pack-objects.adoc        |  14 +-
>  Documentation/technical/api-path-walk.adoc |   1 +
>  builtin/pack-objects.c                     | 147 +++++++++++++++++++--
>  t/t5300-pack-object.sh                     |  15 +++
>  4 files changed, 167 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/git-pack-objects.adoc b/Documentation/git-pack-objects.adoc
> index 7f69ae4855f..7065758eddf 100644
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
> @@ -375,6 +375,18 @@ many different directories. At the moment, this version is not allowed
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
> +	`--shallow`, or `--filter`. The `--use-bitmap-index` option will
> +	be ignored in the presence of `--path-walk.`
> +

This is perhaps a stylistic difference, but I don't think in general it
is necessary to say "by default [...]" to explain some existing
behavior, unless the alternative behavior enabled by the flag is
impossible to understand without contrasting.

In this particular instance, I think that "--path-walk" can be
explained in isolation rather than in contrast to the default behavior.

I would probably write something like:

    --path-walk::
    Walk objects in batches grouped by a common path. This can improve
    delta compression, especially in the case where filenames cause
    collisions in the default name-hash algorithm.

    Incompatible with `--delta-islands`, `--shallow`, and `--filter`. If
    provided, `--use-bitmap-index` will be ignored.

> +static inline int is_oid_interesting(struct repository *repo,
> +				     struct object_id *oid)
> +{
> +	struct object *o = lookup_object(repo, oid);

This function and its caller tripped me up a little bit while reading,
but I was able to un-confuse myself. Here are some notes that I took
while reading, which perhaps you can validate to tell me whether or not
I'm on the right track.

Here we allow lookup_object() to return NULL, and then immediately
return 0 if it does. But...

> +	return o && !(o->flags & UNINTERESTING);
> +}
> +
> +static int add_objects_by_path(const char *path,
> +			       struct oid_array *oids,
> +			       enum object_type type,
> +			       void *data)
> +{
> +	struct object_entry **delta_list;
> +	size_t oe_start = to_pack.nr_objects;
> +	size_t oe_end;
> +	unsigned int sub_list_size;

Could you help me understand why sub_list_size is an unsigned int and
not a size_t here?

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

...here we only skip calling add_object_entry() if the object is
excluded (which lookup_object() returning NULL would cause above) *and*
we're not using thin packs. That makes sense, since if we have a missing
object, but we're using thin packs, then it's OK to skip.

So I think all of this looks good. However, I find the interface here a
little awkward. The function is called "is_oid_interesting()", but it
determines that fact by checking whether or not the object has the
UNINTERSTING bit set on its flag, and then negating the result. But then
we negate it again here at the caller to obtain whether or not we should
"exclude" the object.

I was wondering if there were other callers of is_oid_interesting() that
don't negate its result. But it doesn't look like there are (at least in
this patch). I wonder if it would be cleaner just to inline this instead
of having the result negated at multiple levels.

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

I'm nit-picking, but I would imagine that sub_list_nr is probably more
conventional, but this is textbook bike-shedding ;-).

> +	ALLOC_ARRAY(delta_list, oe_end - oe_start);

ALLOC_ARRAY() will barf if oe_start > oe_end and we wrap around the
range of size_t, but it might be nice to have a sanity check here just
their equality.

> +
> +	for (size_t i = 0; i < oe_end - oe_start; i++) {
> +		struct object_entry *entry = to_pack.objects + oe_start + i;
> +
> +		if (!should_attempt_deltas(entry))
> +			continue;
> +
> +		delta_list[sub_list_size++] = entry;
> +	}

Makes sense.

> +	/*
> +	 * Find delta bases among this list of objects that all match the same
> +	 * path. This causes the delta compression to be interleaved in the
> +	 * object walk, which can lead to confusing progress indicators. This is
> +	 * also incompatible with threaded delta calculations. In the future,
> +	 * consider creating a list of regions in the full to_pack.objects array
> +	 * that could be picked up by the threaded delta computation.
> +	 */
> +	if (sub_list_size && window) {

Do we need to check that window is non-zero here? It looks like that
check already happens above.

> +		QSORT(delta_list, sub_list_size, type_size_sort);
> +		find_deltas(delta_list, &sub_list_size, window, depth, processed);
> +	}
> +
> +	free(delta_list);

Is there a return path through this function that doesn't allocate
delta_list? I think the answer is "no", but it might be a nice guard
against future refactorings to initialize this field to NULL just in
case.

> +	return 0;
> +}
> +
> +static void get_object_list_path_walk(struct rev_info *revs)
> +{
> +	struct path_walk_info info = PATH_WALK_INFO_INIT;
> +	unsigned int processed = 0;
> +
> +	info.revs = revs;
> +	info.path_fn = add_objects_by_path;
> +	info.path_fn_data = &processed;
> +	revs->tag_objects = 1;

What is the purpose of setting revs->tag_objects to 1 here? Do we need
to restore it back to its original value before returning? A comment
here would be useful, I think.

> +
> +	/*
> +	 * Allow the --[no-]sparse option to be interesting here, if only
> +	 * for testing purposes. Paths with no interesting objects will not
> +	 * contribute to the resulting pack, but only create noisy preferred
> +	 * base objects.
> +	 */
> +	info.prune_all_uninteresting = sparse;
> +
> +	if (walk_objects_by_path(&info))
> +		die(_("failed to pack objects via path-walk"));
> +}
> +
>  static void get_object_list(struct rev_info *revs, int ac, const char **av)
>  {
>  	struct setup_revision_opt s_r_opt = {
> @@ -4237,7 +4340,7 @@ static void get_object_list(struct rev_info *revs, int ac, const char **av)
>
>  	warn_on_object_refname_ambiguity = save_warning;
>
> -	if (use_bitmap_index && !get_object_list_from_bitmap(revs))
> +	if (use_bitmap_index && !path_walk && !get_object_list_from_bitmap(revs))

I was going to suggest something like:

    if (path_walk && use_bitmap_index) {
        warning(_("cannot use --use-bitmap-index with --path-walk, ignoring"));
        use_bitmap_index = 0;
    }

, which would avoid the need for this check here and insulate us against
having to make similar changes to future conditionals that care about
use_bitmap_index.

But it looks like such a check *does* already exist below, so I am not
sure I understand why we need to check for path_walk here.

>  		return;
>
>  	if (use_delta_islands)
> @@ -4246,15 +4349,19 @@ static void get_object_list(struct rev_info *revs, int ac, const char **av)
>  	if (write_bitmap_index)
>  		mark_bitmap_preferred_tips();
>
> -	if (prepare_revision_walk(revs))
> -		die(_("revision walk setup failed"));
> -	mark_edges_uninteresting(revs, show_edge, sparse);
> -
>  	if (!fn_show_object)
>  		fn_show_object = show_object;
> -	traverse_commit_list(revs,
> -			     show_commit, fn_show_object,
> -			     NULL);
> +
> +	if (path_walk) {
> +		get_object_list_path_walk(revs);
> +	} else {
> +		if (prepare_revision_walk(revs))
> +			die(_("revision walk setup failed"));
> +		mark_edges_uninteresting(revs, show_edge, sparse);
> +		traverse_commit_list(revs,
> +				show_commit, fn_show_object,
> +				NULL);
> +	}
>
>  	if (unpack_unreachable_expiration) {
>  		revs->ignore_missing_links = 1;
> @@ -4464,6 +4571,8 @@ int cmd_pack_objects(int argc,
>  			 N_("use the sparse reachability algorithm")),
>  		OPT_BOOL(0, "thin", &thin,
>  			 N_("create thin packs")),
> +		OPT_BOOL(0, "path-walk", &path_walk,
> +			 N_("use the path-walk API to walk objects when possible")),
>  		OPT_BOOL(0, "shallow", &shallow,
>  			 N_("create packs suitable for shallow fetches")),
>  		OPT_BOOL(0, "honor-pack-keep", &ignore_packed_keep_on_disk,
> @@ -4549,7 +4658,27 @@ int cmd_pack_objects(int argc,
>  		window = 0;
>
>  	strvec_push(&rp, "pack-objects");
> -	if (thin) {
> +
> +	if (path_walk && filter_options.choice) {
> +		warning(_("cannot use --filter with --path-walk"));
> +		path_walk = 0;
> +	}
> +	if (path_walk && use_delta_islands) {
> +		warning(_("cannot use delta islands with --path-walk"));
> +		path_walk = 0;
> +	}
> +	if (path_walk && shallow) {
> +		warning(_("cannot use --shallow with --path-walk"));
> +		path_walk = 0;
> +	}

Here's a tiny idea I had while reading this code.

    if (path_walk) {
        const char *option = NULL;
        if (filter_options.choice)
            option = "--filter";
        else if (use_delta_islands)
            option = "--delta-islands";
        else if (shallow)
            option = "--shallow";

        if (option) {
            warning(_("cannot use %s with --path-walk"), option);
            path_walk = 0;
        }
    }

This may be too DRY for your taste, and it does have the disadvantage of
reducing the grep-ability of the error messages. I don't have a strong
feeling about it one way or another, but I figured I'd at least write it
down.

Thanks,
Taylor
