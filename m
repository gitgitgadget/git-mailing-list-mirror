Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAB11DE883
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 16:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730131569; cv=none; b=MK74bcugXKtQa0mvEZGmkgbGKWnObx+7jnyS9ZOR4L7Da1irCfhB+kswUFJ3oMVq7O0tLg8SIDPDh63ajwOR5VAHmC0alfBBfAtugJRTE2/9ex4eQ5/BlK0gnxvB0dFEwUjkyzTkrSTb+cdGcFUOSDKGl4Zu6pM0LxWeW9oIZOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730131569; c=relaxed/simple;
	bh=MtYzPIet58kslscLhx9hhy0y3t5Z8r8o2b1VVOvj8zM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wez8Qpt+Y2iY4UrWFwjtDVY442lQFcVRHh03OVhMDcSCIBMNjJS2Xi6SpBeBylPTA1ZuR7gLyn9TeKhw3myBhlH5FQ5Ek5PyabQaV3/Mxs7VEnEwnmGY1mgJJoAveA1hWmgQrbqokylN/BO6bTHhdho/nwA/lEJpvgAmpXDriVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=u+h6JZIw; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="u+h6JZIw"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5ebc0dbc566so2412295eaf.3
        for <git@vger.kernel.org>; Mon, 28 Oct 2024 09:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730131565; x=1730736365; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+iIM5DuZJgaYcIXswFYR+ajnqYcqocPe3aA+jOqp6gU=;
        b=u+h6JZIwu9hitFkKCKzxHhwCz8180C0HDg9ZNOps4kYPSqI3doy+cbw4a/ENSoS9Nm
         QhidSpKNPok7zNkueBtoRGN75nPB8+TXnlXlbdJFTCrD2u67ogVXC8nojx505NmyHfMp
         0zajILWxDtswKEmUtnTwkdNSF/o3z/lbGCEqW5XicPsr1RiFEJTYZrRnjRYVvY3W8mnq
         u2la45NsOaCN3MHp1XMIIeCNMs5E1+wZ+ttkgw8nYwRY5kMk1SBHYcHTdjla2eRkPBYJ
         q7MrUJImRW6w7K6FrAVLjyNN8oThlUaILC24e6VcING2OP9fQvmpW93EwdJDCGzH7VQF
         UsEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730131565; x=1730736365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+iIM5DuZJgaYcIXswFYR+ajnqYcqocPe3aA+jOqp6gU=;
        b=FiX5ppgQRuSLnLVss8+4/Ocz8r7TyF8kVI+jJMdZxNzJaRaU8tiApxNZhJ5ilnPl8K
         wIarXN4Aruabg7WuKjfh14grn2SRT1ZdeWWsVuaUrk03gICvSrBdgR6irZ6OWB6z9FhE
         HphI5iScyF9i8uTv6Ec5SVUdSOFsWCzrANlQ5iMGP497PA1ebCTZC02C0v+2XZJ6P5Ud
         7nc1c48GIhtg+/KbdxENp0lAOU7aTdFAzAK5JrBjz/x7Ia8Lvh71DpINBH9w59UQA2nq
         ckDDzLYtfP21N4eEn5sYqraNz98F2e+zpO3TozAV2nmKrs35RwUmeD/B8SycUPkAC6VA
         dYiQ==
X-Gm-Message-State: AOJu0YxbzPXGebPi8UV18edLDnDUCYZbJmV+1RuD5Qyjdiqq/dJUopLN
	LONjlYMbm1uXirJ+hRKcy+37saoQLZ2x1Y2fRpdWICQljCUwRsyVzF2NGhUaBP+7Cnw4/5CcJv7
	Z/SM=
X-Google-Smtp-Source: AGHT+IEa3OaZ0B3BI8KCQHZh1iiAqZb3A/9T/iDswu4QhcOp4od6Dn2nqcMJSLFcjnhU90meFLieGg==
X-Received: by 2002:a05:6358:e4a2:b0:1c3:38a:212e with SMTP id e5c5f4694b2df-1c3f9b4b192mr282758155d.0.1730131565054;
        Mon, 28 Oct 2024 09:06:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6c97b1csm14870767b3.111.2024.10.28.09.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 09:06:04 -0700 (PDT)
Date: Mon, 28 Oct 2024 12:05:53 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/8] packfile: add repository to struct `packed_git`
Message-ID: <Zx+2YRqoIOwE0ysU@nand.local>
References: <cover.1730122499.git.karthik.188@gmail.com>
 <26d2461cc349c14b05d2713ee411bb058251f45f.1730122499.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <26d2461cc349c14b05d2713ee411bb058251f45f.1730122499.git.karthik.188@gmail.com>

On Mon, Oct 28, 2024 at 02:43:39PM +0100, Karthik Nayak wrote:
> The struct `packed_git` holds information regarding a packed object
> file. Let's add the repository variable to this object, to represent the
> repository that this packfile belongs to. This helps remove dependency
> on the global `the_repository` object in `packfile.c` by simply using
> repository information now readily available in the struct.

Makes sense, good. I think it would be useful here to capture some of
the discussion from just before you sent this series to indicate why
it's OK to use the_repository even when we have alternates.

I think it is now quite obvious in retrospect, but let's do our future
selves a service by capturing it here, too ;-).

> ---
>  10 files changed, 30 insertions(+), 16 deletions(-)

Oh, good. I am glad to see that this new approach is already yielding
far less disruptive of a change.

> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index 76d5c20f14..ffee7d3abd 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -765,6 +765,7 @@ static void start_packfile(void)
>
>  	p->pack_fd = pack_fd;
>  	p->do_not_close = 1;
> +	p->repo = the_repository;

Makes sense. Here we are crafting the packfile by hand, so initializing
->repo directly makes sense here.

It would be nice if we could rewrite this in terms of
packfile.c:alloc_packed_git(), but that is a static function. Exposing
it as non-static is probably showing too much of the internals, so I
think leaving this as-is makes sense.

> diff --git a/commit-graph.c b/commit-graph.c
> index 5bd89c0acd..83dd69bfeb 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -1914,7 +1914,7 @@ static int fill_oids_from_packs(struct write_commit_graph_context *ctx,
>  		struct packed_git *p;
>  		strbuf_setlen(&packname, dirlen);
>  		strbuf_addstr(&packname, pack_indexes->items[i].string);
> -		p = add_packed_git(packname.buf, packname.len, 1);
> +		p = add_packed_git(ctx->r, packname.buf, packname.len, 1);

I wondered if ctx->r was the right choice here or not, but it is, and it
is (currently) always equal to the value of the_repository, so it's a
moot point. Let's keep going...

> diff --git a/midx-write.c b/midx-write.c
> index b3a5f6c516..c57726ef94 100644
> --- a/midx-write.c
> +++ b/midx-write.c
> @@ -154,7 +154,7 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,
>  			return;
>
>  		ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
> -		p = add_packed_git(full_path, full_path_len, 0);
> +		p = add_packed_git(the_repository, full_path, full_path_len, 0);

Ugh. I thought we had already added a repository field to our auxiliary
write_midx_context struct, but we have not, so this change looks right
to me.  Doing so (adding that new field) seems like it would be a good
piece of #leftoverbits.

> diff --git a/midx.c b/midx.c
> index e82d4f2e65..8edb75f51d 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -464,7 +464,7 @@ int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
>  					strhash(key.buf), key.buf,
>  					struct packed_git, packmap_ent);
>  	if (!p) {
> -		p = add_packed_git(pack_name.buf, pack_name.len, m->local);
> +		p = add_packed_git(r, pack_name.buf, pack_name.len, m->local);

OK, so here we're trusting the value of 'r' from the caller. That comes
from 64404a24cf (midx: pass a repository pointer, 2019-04-29), which is
doing the right thing. (As an aside, I thought that that change was from
when we added the --object-dir flag to 'git multi-pack-index', but the
change is in fact unrelated and has to do with adding installed packs to
the repository's MRU list).

>  		if (p) {
>  			install_packed_git(r, p);
>  			list_add_tail(&p->mru, &r->objects->packed_git_mru);
> diff --git a/object-store-ll.h b/object-store-ll.h
> index 53b8e693b1..8b31072b09 100644
> --- a/object-store-ll.h
> +++ b/object-store-ll.h
> @@ -4,6 +4,7 @@
>  #include "hashmap.h"
>  #include "object.h"
>  #include "list.h"
> +#include "repository.h"

Hmm. Do we need to include all of repository.h here? I don't think we
do, because we never peek into any of the fields of that structure from
within this header. So I think you could do something like:

--- 8< ---
diff --git a/object-store-ll.h b/object-store-ll.h
index 6f9f4276e6..bcfae2e1bf 100644
--- a/object-store-ll.h
+++ b/object-store-ll.h
@@ -4,13 +4,13 @@
 #include "hashmap.h"
 #include "object.h"
 #include "list.h"
-#include "repository.h"
 #include "thread-utils.h"
 #include "oidset.h"

 struct oidmap;
 struct oidtree;
 struct strbuf;
+struct repository;

 struct object_directory {
 	struct object_directory *next;
--- >8 ---

instead of #include-ing the whole thing, which would be preferable.

>  #include "thread-utils.h"
>  #include "oidset.h"
>
> @@ -135,6 +136,10 @@ struct packed_git {
>  	 */
>  	const uint32_t *mtimes_map;
>  	size_t mtimes_size;
> +
> +	/* repo dentoes the repository this packed file belongs to */
> +	struct repository *repo;

Calling this 'repo' makes sense, but...

> diff --git a/packfile.c b/packfile.c
> index 9560f0a33c..45f300e5e1 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -217,11 +217,12 @@ uint32_t get_pack_fanout(struct packed_git *p, uint32_t value)
>  	return ntohl(level1_ofs[value]);
>  }
>
> -static struct packed_git *alloc_packed_git(int extra)
> +static struct packed_git *alloc_packed_git(struct repository *repo, int extra)

Here and elsewhere, I think our usual convention is to call a 'struct
repository *' (when it is a formal parameter of some function) just "r"
instead of "repo".

At least that's what my intuition told me, and a very rough grep says
that '*r' appears as a parameter 815 times, while '*repo' appears only
577 times. It's close, but I think that '*r' is preferred here since
it's fewer characters.

>  {
>  	struct packed_git *p = xmalloc(st_add(sizeof(*p), extra));
>  	memset(p, 0, sizeof(*p));

Not at all the fault of this patch, but it feels like a bit of a
foot-gun to allocate a bounds-checked version of 'sizeof(*p)+extra',
while only zero'ing the first 'sizeof(*p)' bytes. I think in all cases
where it actually matters via add_packed_git() we fill out that extra
space anyway, but it might be nice cleanup to do something like:

    struct packed_git *p;
    size_t sz = sizeof(*p) + extra;

    p = xcalloc(1, sz);

, or something. But that can be dealt with later and/or as #leftoverbits.

The rest is looking good, nicely done. Let's keep reading...

Thanks,
Taylor
