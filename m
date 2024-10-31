Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554771CC8B3
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 20:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730408369; cv=none; b=jqf93aNSsVLp03Em50qK+4GsMI7W5JCfRwGRpbFPuLZ2vIeGvQm/VbCR4XMuJrpdFRxZ4WXB7rZqBQMU6IFAd418zonsgV5+Aii8Wyb+soxDisf8jqRBXouDOwbtb4gTuSFtfo+poJsVRC5PPWK+H6eQ9QMHVOJNon/QadK8vlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730408369; c=relaxed/simple;
	bh=W6oRFCpkKkw6BVEZBV48Pd6ttNM46JvDvedzudOBuw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkCFKG5ErpQosgBM9qqjjevnFUhTJs6E1u8FvyAdT+oGedrHiRZiJIKmLXfVh0QM8Y74norJfn/oGmhSWOkVMbh6rawfjPuA+s+DK0tUyD1M+7g2ymJCCb/MnjqE8gIO081ma3K1Bc8Fx5A9HFc1isV7JnlM+ke7hMHYn0H5qI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=WhmTOA8J; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="WhmTOA8J"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e30cef4ac5dso1283255276.0
        for <git@vger.kernel.org>; Thu, 31 Oct 2024 13:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730408362; x=1731013162; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wkBnu3RmvAItPnvxS38ilONvfBCe0kp+EUK2jiu7g2Q=;
        b=WhmTOA8J6cSaWwiPjaRN/5UiCjjxQs1+GthrvtNq6bzYIT1SCmVy+uHOR/IxeZT9jS
         W1HKgpqvsKFZZ+C40I37K4XL7BQLiMulRINg995VmzBJja4Cd/OG6QPaxRrxBertot20
         etA4bOf3AvWhXb7pAI+GrhxJtC6f2ZGedr30HMA363+cSmkNHjCIv9A+sVyM5jaRHs0t
         JBxlMZ2QF9YhAn87wEuSNxSd1aLSnJ6XD6Ti5irf3nX6D5dMEZ+rbl2oecNzNYwfN1tk
         NiaZFWVxv8K6R0hDZb8+9ZdwqOQyUOuHifYBNkd5VZwerpWKWIkMkDOj1IMqWC+uZdKM
         nycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730408362; x=1731013162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wkBnu3RmvAItPnvxS38ilONvfBCe0kp+EUK2jiu7g2Q=;
        b=chZfCdvPj6+L2fnFOtodkMKaCzx9fmdU42S2gUp3mpJ2U7ltf5vJdg1OTf+wHOG78M
         hsqj6y9kDjU+2nDy9xx16Vmr0WfNWzRnkUQIRvyjn5SsxH2X6OrzyCDXQ/1ykbgJeT/D
         oiitAGEUMlE+xtuVMAGTPhJPN90zQNrO9wlbnQjvJ11iWMqfL+ALKMjUVluYLIaW9WZ8
         e4GI98FORdUhm4pheZ2IpjuAdg6JVwfZKEw8yqtYFhEn9cCVjGYbUkLg7aD3So/S+Ck0
         NgUiwLAHvgblNO7Zt8EPvVyH86GfqNmtfStv2glT1dP+p5QHSo8y/iF+Iu+81fqcusRr
         7z1w==
X-Gm-Message-State: AOJu0Yxa19urvf+Z91chGbMK00q74tASLLZ9odpIH9Hk4eNlmb3eA1ci
	nZLk+st6Madf8FD3XlHh6woL1tnZtwsrO6eiu81oTJPFAOaRY+9two6Cgn/kCV55wkt6zQNA1K5
	Ug7g=
X-Google-Smtp-Source: AGHT+IEGNagBx0/EmaGXacTRXAQqNJBircNTGJSbxVa8zK8Ud104XNjnjJemyf8gNVORmeXnylHnwA==
X-Received: by 2002:a05:6902:2384:b0:e2b:d505:86a9 with SMTP id 3f1490d57ef6-e30cf3e5b5cmr8599934276.4.1730408362026;
        Thu, 31 Oct 2024 13:59:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e30e8a7caccsm432214276.23.2024.10.31.13.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 13:59:21 -0700 (PDT)
Date: Thu, 31 Oct 2024 16:59:20 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] fetch-pack: warn if in commit graph but not obj db
Message-ID: <ZyPvqPK1s5lUtH+N@nand.local>
References: <20241003223546.1935471-1-emilyshaffer@google.com>
 <cover.1730235646.git.jonathantanmy@google.com>
 <1027ff2cb7d9af5cc9ce6b653d28150457db8703.1730235646.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1027ff2cb7d9af5cc9ce6b653d28150457db8703.1730235646.git.jonathantanmy@google.com>

On Tue, Oct 29, 2024 at 02:11:05PM -0700, Jonathan Tan wrote:
> When fetching, there is a step in which sought objects are first checked
> against the local repository; only objects that are not in the local
> repository are then fetched. This check first looks up the commit graph
> file, and returns "present" if the object is in there.

OK.

> However, the action of first looking up the commit graph file is not
> done everywhere in Git, especially if the type of the object at the time
> of lookup is not known. This means that in a repo corruption situation,
> a user may encounter an "object missing" error, attempt to fetch it, and
> still encounter the same error later when they reattempt their original
> action, because the object is present in the commit graph file but not in
> the object DB.

I think the type of repository corruption here may be underspecified.

You say that we have some object, say X, whose type is not known. So we
don't load the commit-graph, realize that X is missing, and then try and
fetch it. In this scenario, is X actually in the commit-graph, but not
in the object database? Further, if X is in the commit-graph, I assume
we do not look it up there because we first try and find its type, which
fails, so we assume we don't have it (despite it appearing corruptly in
the commit-graph)?

I think that matches the behavior you're describing, but I want to make
sure that I'm not thinking of something else.

> This was discovered when a lazy fetch of a missing commit completed with
> nothing actually fetched, and the writing of the commit graph file after
> every fetch then attempted to read said missing commit, triggering a
> lazy fetch of said missing commit, resulting in an infinite loop with no
> user-visible indication (until they check the list of processes running
> on their computer).

Yuck :-).

> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  fetch-pack.c | 22 +++++++++++++++++++---
>  object.h     |  2 +-
>  2 files changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 6728a0d2f5..5a0020366b 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -57,6 +57,7 @@ static struct string_list uri_protocols = STRING_LIST_INIT_DUP;
>  #define ALTERNATE	(1U << 1)
>  #define COMMON		(1U << 6)
>  #define REACH_SCRATCH	(1U << 7)
> +#define COMPLETE_FROM_COMMIT_GRAPH	(1U << 8)
>
>  /*
>   * After sending this many "have"s if we do not get any new ACK , we
> @@ -123,15 +124,18 @@ static void for_each_cached_alternate(struct fetch_negotiator *negotiator,
>  }
>
>  static struct commit *deref_without_lazy_fetch(const struct object_id *oid,
> -					       int mark_tags_complete)
> +					       int mark_additional_complete_information)
>  {
>  	enum object_type type;
>  	struct object_info info = { .typep = &type };
>  	struct commit *commit;
>
>  	commit = lookup_commit_in_graph(the_repository, oid);
> -	if (commit)
> +	if (commit) {
> +		if (mark_additional_complete_information)
> +			commit->object.flags |= COMPLETE_FROM_COMMIT_GRAPH;
>  		return commit;
> +	}
>
>  	while (1) {
>  		if (oid_object_info_extended(the_repository, oid, &info,
> @@ -143,7 +147,7 @@ static struct commit *deref_without_lazy_fetch(const struct object_id *oid,
>
>  			if (!tag->tagged)
>  				return NULL;
> -			if (mark_tags_complete)
> +			if (mark_additional_complete_information)
>  				tag->object.flags |= COMPLETE;
>  			oid = &tag->tagged->oid;
>  		} else {
> @@ -809,6 +813,14 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
>  	save_commit_buffer = old_save_commit_buffer;
>  }
>
> +static void warn_in_commit_graph_only(const struct object_id *oid)
> +{
> +	warning(_("You are attempting to fetch %s, which is in the commit graph file but not in the object database."),
> +		oid_to_hex(oid));
> +	warning(_("This is probably due to repo corruption."));
> +	warning(_("If you are attempting to repair this repo corruption by refetching the missing object, use 'git fetch --refetch' with the missing object."));
> +}
> +
>  /*
>   * Returns 1 if every object pointed to by the given remote refs is available
>   * locally and reachable from a local ref, and 0 otherwise.
> @@ -830,6 +842,10 @@ static int everything_local(struct fetch_pack_args *args,
>  				      ref->name);
>  			continue;
>  		}
> +		if (o->flags & COMPLETE_FROM_COMMIT_GRAPH) {
> +			if (!has_object(the_repository, remote, 0))
> +				warn_in_commit_graph_only(remote);

You discuss this a little bit in your commit message, but I wonder if we
should just die() here. I feel like we're trying to work around a
situation where the commit-graph is obviously broken because it refers
to commit objects that don't actually exist in the object store.

A few thoughts in this area:

  - What situation provokes this to be true? I could imagine there is
    some bug that we don't fully have a grasp of. But I wonder if it is
    even easier to provoke than that, say by pruning some objects out of
    the object store, then not rewriting the commit-graph, leaving some
    of the references dangling.

  - Does 'git fsck' catch this case within the commit-graph?

  - Are the other areas of the code that rely on the assumption that all
    entries in the commit-graph actually exist on disk? If so, are they
    similarly broken?

Another thought about this whole thing is that we essentially have a
code path that says: "I found this object from the commit-graph, but
don't know if I actually have it on disk, so mark it to be checked later
via has_object()".

I wonder if it would be more straightforward to replace the call to
lookup_commit_in_graph() with a direct call to has_object() in the
deref_without_lazy_fetch() function, which I think would both (a)
eliminate the need for a new flag bit to be allocated, and (b) prevent
looking up the object twice.

Thoughts?

Thanks,
Taylor
