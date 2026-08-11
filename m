Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B75047DD4D
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 22:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786485909; cv=none; b=bUWwHV5muWqMYsXBU1+Gnk9PklsjO+SQNDFrZGoGYwe82VCG0H2uaZGUDxGmI4aiYut35xErYvF6GvAqZqXcbE/HlbYuX0jsnciqzAQpO0P7IJ55U8PyrAva2AYBzD3snxBUIynPeGj6vDgufzyxErUrp0bbsveNEiCTrg6vvY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786485909; c=relaxed/simple;
	bh=MeeA5uIPfOeUZaUtTtbpj0LHPiFSz/WWK+JO0fZZRfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5OUbetKBPVoqUua8LdFtFukCTdoj4CBXzyx5A9qRHOBomZkqTmlJNDx0j3ZuI/4uefACP2HK+y+cFiTOytJ3cKGW4nzajl7kiqjOv/eQtzfen3LKsiDocykGmS3eDaw+q3X6EN/Z+Ez4GFGN6PoodQ7F6sCQhutcfVfSalvdlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+WTfr1E; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+WTfr1E"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7eb29ed2bbdso65591a34.2
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 15:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786485907; x=1787090707; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KI4Gcduwv3qyonwOddTSWJUGDNV1lcXVzkMx7c2lfqM=;
        b=H+WTfr1E03UQIwsOvn7BASsgO+xZAbfBzwP5xHj6wRZppOAeyPR2TA4KvKJTqt5/Pi
         f4Pg7PzOlW/ITMr2TghH0erPVeSooKz2VyU/p3OMPDw6jfYxkSxJctOAq85TwbpSwCit
         fTmHgDnwiTuHI2o5DNcdmNWnAO7p+ZKQTOwj1TgYd+ylXdZ3/GG4ITqUyAvl9ZOJM4lq
         Y3NGhhg+pCoqyeTXfuyBwJ8VnhtO1ccll9B+ZqZCIbV5Gg2j+7twKA2sKee5fezPlvCy
         bad9o4chRcU8T2IgaOvuInpRoqI0wgLrSg6263sDSqVhM1Z+n/jLPpOLKEKjyjsOiIf3
         6WQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786485907; x=1787090707;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KI4Gcduwv3qyonwOddTSWJUGDNV1lcXVzkMx7c2lfqM=;
        b=g1kH5ZBe3Xw2m472n4bCAhlUUYwM0im1bnRK/VxNh2h+NjCKWcIIhGCviUPlk8qQyb
         0PlIMeZJ2pGCWpWZ/mEMou+cPCrrFriJv0Pup92rRQzC7DbOzlfNQh3k1TAAZJrIO8E4
         kwf9vRKUF4NWrRH9H3GiEnLu2qePBM+lWokJQHuzjeWO4fln/HNJxQqpu0MAqSk5PziX
         gSPqcC2U+2DKooPGSUJro7xHx35ezwIgm5IubcjBDimLcWHQLJ3E+Hql/O8YFTzi0VTt
         qat1MtmXtRxmiB8agoWtxgMK1oo24RIRjeChXyA+9bDQxR+P1cJzYvBmD9x6jRR8aOSw
         Cj1Q==
X-Gm-Message-State: AOJu0Yw1oXk8w8HQPiQkwHjhD9XMWCnZza0vspMAARNEo68YBaN/nYF5
	nmqnRL9VONxEDgCWZ+G2CiWN00nqtKmYh1KBiojY9hqTJUwZkDhVMsh3zCgxTQ==
X-Gm-Gg: AR+sD13Um7Y03D0z9YzVp8t0h7nut+HsNa0LZjFl285jN7PzJHi6M9WHLi2OMxZQX+k
	Lsk2DWclkHp+M08531TbxyMovd+UuPzFKJeUnF8kkF6BbMbLUy5c7YJvQiQjQyS0X8P7rE7N3Cj
	g+kVvP5eE14HBUfw4SXrZW3wXfrUZJRcP/fkhays8U5S8qFKIhUjI21QyX45RLWQZWezZz7gqeP
	gSId/qfha+42kZhf2DPZ2tXFL1bHBVGOdrubg1gbcpCtRpPy64zMFQdmpGlwBmYmjceC3MGInY2
	GbxLyrKIOz/UyV0ZORiA/kxPqqgWe3TKQPUiwuRnqNieTacdQM/uU3me0oD+P5vrAl2pk4nemlP
	tmk6rXSN/gzhXd0uwq5IXMngih15eROuhppUnoO1vcyg5d+iy1h04zq1W0JvNt5nVlVEVA/Pvp7
	IUNFbDF3SGMo7IKDZaVuafEquTzgYIDKcL8pfWm5eFJypFmpHM7R34R99wpdYfWG2HZA==
X-Received: by 2002:a05:6830:2aa5:b0:7e6:c9eb:535a with SMTP id 46e09a7af769-7f3b76e11f1mr505568a34.6.1786485906563;
        Tue, 11 Aug 2026 15:05:06 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f3b320d5b9sm1008593a34.9.2026.08.11.15.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 15:05:05 -0700 (PDT)
Date: Tue, 11 Aug 2026 17:04:58 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/4] odb: decouple source path comparisons from
 `the_repository`
Message-ID: <anuP0Mh9aBz9VdBK@denethor>
References: <20260810-pks-odb-eagerly-prepare-alternates-v1-0-f0fa4a4004e1@pks.im>
 <20260810-pks-odb-eagerly-prepare-alternates-v1-1-f0fa4a4004e1@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810-pks-odb-eagerly-prepare-alternates-v1-1-f0fa4a4004e1@pks.im>

On 26/08/10 03:33PM, Patrick Steinhardt wrote:
> When registering alternates we deduplicate object database sources by
> their path so that the same source won't be added twice. Ever since
> cf2dc1c238 (speed up alt_odb_usable() with many alternates, 2021-07-07)
> this duplicate check is backed by a map keyed by the source's path,
> using `fspathhash()` and `fspatheq()` as hash and equality functions,
> respectively.
> 
> These functions are problematic in this context for two reasons:
> 
>   - They implicitly depend on `the_repository` instead of the
>     repository that owns the object database.
> 
>   - They derive case-sensitivity from `repo_ignore_case()`, which
>     returns a default value in case the repository's configuration has
>     not been parsed yet. Object database sources may be registered
>     before that is the case, so the answer may flip depending on when a
>     source gets registered.

Are alternates currently always registered after repository
configuration has been parsed? Or is this an existing bug?

> Fix this by making the comparison self-contained in the object
> database. Instead of using `fspathhash()` and `fspatheq()` we resolve
> "core.ignoreCase" manually and then use the correct comparison function
> based on the result. This requires us to migrate to a `struct hashmap`,
> as the khash interface does not give us the ability to change these
> functions.
> 
> Note that we can unconditionally use `strihash()` to compute entry
> hashes regardless of case sensitivity: a hash function only needs to
> guarantee that equal keys have equal hashes, and a case-insensitive
> hash satisfies this requirement for both case-sensitive and
> case-insensitive equality.

Ok IIUC, even if we want to be case-sensitive, its ok to use
`strihash()` and have hash collisions because the compare function will
still properly distinguish between the cases. Makes sense.

> Overall it's quite debatable whether all of this complexity really is
> worth it, or whether we should just linearly search through all sources
> to find duplicates. But the mentioned commit cares about cases with
> thousands of alternates, and a linear search would of course regress
> performance quite a bit. This doesn't really feel like a reasonable case
> to care about though, but I don't feel comfortable regressing it anyway.

Ya, my first though here was also whether all of this song and dance is
really needed for alternates. There may be someone out there with tons
of alternates I guess though. Probably good to be on the safe side.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb.c        | 63 ++++++++++++++++++++++++++++++++++++++++--------------------
>  odb.h        | 15 ++++++++++++++-
>  odb/source.h |  7 +++++++
>  3 files changed, 63 insertions(+), 22 deletions(-)
> 
> diff --git a/odb.c b/odb.c
> index bd02d8ad54..51da386f22 100644
> --- a/odb.c
> +++ b/odb.c
> @@ -2,11 +2,10 @@
>  #include "abspath.h"
>  #include "commit-graph.h"
>  #include "config.h"
> -#include "dir.h"
>  #include "environment.h"
>  #include "gettext.h"
> +#include "hashmap.h"
>  #include "hex.h"
> -#include "khash.h"
>  #include "lockfile.h"
>  #include "loose.h"
>  #include "midx.h"
> @@ -29,8 +28,32 @@
>  #include "trace2.h"
>  #include "write-or-die.h"
>  
> -KHASH_INIT(odb_path_map, const char * /* key: odb_path */,
> -	struct odb_source *, 1, fspathhash, fspatheq)
> +static int odb_source_paths_cmp(struct object_database *o,
> +				const char *a, const char *b)
> +{
> +	if (o->source_paths_icase < 0) {
> +		int icase = 0;
> +		repo_config_get_bool(o->repo, "core.ignorecase", &icase);
> +		o->source_paths_icase = icase;
> +	}

We now parse ignorecase configuration here directly and store the result
in `source_paths_icase`. This ensures configuration is correctly applied
regardless of whether repository configuration has been fully read yet.

> +	return o->source_paths_icase ? strcasecmp(a, b) : strcmp(a, b);
> +}
> +
> +static int odb_source_by_path_cmp(const void *cb_data,
> +				  const struct hashmap_entry *entry,
> +				  const struct hashmap_entry *entry_or_key,
> +				  const void *keydata)
> +{
> +	struct object_database *o = (struct object_database *)cb_data;
> +	const struct odb_source *source = container_of(entry, const struct odb_source, by_path_entry);
> +	const char *path = keydata;
> +
> +	if (!path)
> +		path = container_of(entry_or_key, const struct odb_source, by_path_entry)->path;
> +
> +	return odb_source_paths_cmp(o, source->path, path);
> +}

Here is the comparison callback that is used for the hashmap.

>  int odb_mkstemp(struct object_database *odb,
>  		struct strbuf *temp_filename, const char *pattern)
> @@ -58,8 +81,8 @@ int odb_mkstemp(struct object_database *odb,
>   */
>  static bool odb_is_source_usable(struct object_database *o, const char *path)
>  {
> -	int r;
>  	struct strbuf normalized_objdir = STRBUF_INIT;
> +	struct hashmap_entry key;
>  	bool usable = false;
>  
>  	strbuf_realpath(&normalized_objdir, o->sources->path, 1);
> @@ -76,20 +99,18 @@ static bool odb_is_source_usable(struct object_database *o, const char *path)
>  	 * Prevent the common mistake of listing the same
>  	 * thing twice, or object directory itself.
>  	 */
> -	if (!o->source_by_path) {
> -		khiter_t p;
> -
> -		o->source_by_path = kh_init_odb_path_map();
> +	if (!hashmap_get_size(&o->source_by_path)) {
>  		assert(!o->sources->next);
> -		p = kh_put_odb_path_map(o->source_by_path, o->sources->path, &r);
> -		assert(r == 1); /* never used */
> -		kh_value(o->source_by_path, p) = o->sources;
> +		hashmap_entry_init(&o->sources->by_path_entry,
> +				   strihash(o->sources->path));
> +		hashmap_add(&o->source_by_path, &o->sources->by_path_entry);

The hashmap is lazily set up with the primary source. I do find some of
the variable names like "source_by_path" a bit vague, but that isn't
really anything new here.

>  	}
>  
> -	if (fspatheq(path, normalized_objdir.buf))
> +	if (!odb_source_paths_cmp(o, path, normalized_objdir.buf))
>  		goto out;

If the path matches the first entry in the sources list then we know it
is not an alternate.

>  
> -	if (kh_get_odb_path_map(o->source_by_path, path) < kh_end(o->source_by_path))
> +	hashmap_entry_init(&key, strihash(path));
> +	if (hashmap_get(&o->source_by_path, &key, path))
>  		goto out;

If the alternates source cannot be found for the given path, then we
also know it is not a usuable alternate.

>  	usable = true;
> @@ -172,8 +193,6 @@ static struct odb_source *odb_add_alternate_recursively(struct object_database *
>  {
>  	struct odb_source *alternate = NULL;
>  	struct strvec sources = STRVEC_INIT;
> -	khiter_t pos;
> -	int ret;
>  
>  	if (!odb_is_source_usable(odb, source))
>  		goto error;
> @@ -184,10 +203,11 @@ static struct odb_source *odb_add_alternate_recursively(struct object_database *
>  	*odb->sources_tail = alternate;
>  	odb->sources_tail = &(alternate->next);
>  
> -	pos = kh_put_odb_path_map(odb->source_by_path, alternate->path, &ret);
> -	if (!ret)
> +	hashmap_entry_init(&alternate->by_path_entry, strihash(alternate->path));
> +	if (hashmap_get(&odb->source_by_path, &alternate->by_path_entry,
> +			alternate->path))
>  		BUG("source must not yet exist");
> -	kh_value(odb->source_by_path, pos) = alternate;
> +	hashmap_add(&odb->source_by_path, &alternate->by_path_entry);

Here is where alternates get registered and added to the hashmap. Makes
sense.

Overall this patch looks good.

-Justin
