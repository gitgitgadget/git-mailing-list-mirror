Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED4A207DF9
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 19:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741117736; cv=none; b=nwO53JVSSCrtno5SL15h+orzVD4ZeMXCQdJBHXPe1Cg5Ux6/gFB99V4yt9ycAYscqD/3e9CK7PTXIpzw4fxrMWd+7Oy4S3bOt2Ujh3EGkuR1EjKq3QfUbR+VBz7QprLnqEfIlj1tqOZNUJaKBirGdXrOYASRlwV4ZgkUpvBfNQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741117736; c=relaxed/simple;
	bh=0SI5hV6QilV+C/YULHkEb3kN91frUvxVD+lHC4nkCJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEHJ5Aa8VEEqhB9vbh2YAo0Ku/pRwAdIcb53rjNEZjf9F/D3n/QZC6Gwmraob3qOmk5PuBh0pNsXguud71DMnwak8yDK4N3+XBpaFDEKsp0CMUx55hxS5Ik+U/i8QCA5VyTL48tKNeWK10xJBEXeMdY/WCcZn8bHbzN/bHgY2ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=er2gF0up; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="er2gF0up"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3f666c8b952so1499720b6e.0
        for <git@vger.kernel.org>; Tue, 04 Mar 2025 11:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741117734; x=1741722534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9P6RgmBR/MmCNF0l0lUwA5msOm+HIAB6F3m2RCgcsLc=;
        b=er2gF0upjqkk/cBByPzoFrTIKV22i2UI78v9+m9J3i5J+YMvsFBURgrlFNXZiUmyu/
         sDMTJxORnYXosCaYldfcmKKn8UgA1Zvwa/WHjUp1aKOx769VqDiKb+MCDmuylRaLraY4
         nJbHvWC9uspCe3cHZbElepvJ6GZQWZ/i7LFNxjeMPefu2QzqBwXW0Ltt5mQEDyFTxEgL
         F9mKPnKJUcQne25oAkoXSMVyqw3rb3/gQteK1HnyP8wHxxrhJDjQ5LGlscWQ0G+LwiES
         1HmghwtBWYOfYThE2JStQfATC66fTBPlMepaoSalHmhelo8eXZUIw0P90ZCBzKxCTpXT
         v0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741117734; x=1741722534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9P6RgmBR/MmCNF0l0lUwA5msOm+HIAB6F3m2RCgcsLc=;
        b=cCov56Ij8cAivbzH5Eburuk3Ayq77sy0MecIbK9kBpnvF+rzCNh94HNR8FN1jOojA7
         k3kN+swXklRt5AhZ1Tq3uw+/7yE2WUHqJ8XiLrA2xTo4CwuljA928E6XTpoHC6bAuMf2
         rclhkAEdwbceFf1z2bnOSqg0HX8bx4y2bd31UAaIopixSo2DdljqCm0RotWSH2g+YNmf
         30MKl33IXrPOS8sni+wNT1k205suwFBdrts2kSXBhyScumDbYArQAK3LsXs9fVc8mdMj
         AcKeXpOUssbcx/1bRcciuRumvUJrZcO/hn6HxU3Z3wr/eBgPn5sxTEmo6ufCVnyS333N
         5D/w==
X-Gm-Message-State: AOJu0YyRNcGg/2WepK6GMQHfmdv25zBXzwsgxv+RRktm6pD4XRQ4zOTC
	vNg55zYuM9vRHfwfIu2R4qsgiwEsatzpQdBtUajRBOuzGr4DKYWI
X-Gm-Gg: ASbGncsiVv//6JZNbh4T/ZuCAd6pRS9klMmOMJjBEsm7qgNMVItLb6FoT8Qj8rAxOKR
	Ivh9Xkg4DIn0DzD/UQBtd7reHMZvggOmG69lEgpU3FzaaPLakaBz6Acz5MULU1uRF2T396ez4YL
	24gyJWJIx0Npjx03gJgP/GbF4ZWCy6w881csjobhwJ4hNhKPnjWR3NsVTY5md8mpQsqwkQN/yzd
	PYxjE84nzXkKEsmBQ0brVRTSx71yxVu/Sop2is+1bV/Z743CByor7aN3NJqnvig5Ga3iToTyoTL
	xgV2QwlSlHYuDjRL3PZZxE4neXY0nVk9XK4MoQ==
X-Google-Smtp-Source: AGHT+IGZzvD7V1dMbjPi05/b3W0QmzYZb6nZZ1dU1nRoa5N702sGHFShYvzwV3O0sPI0kbo41nGdWQ==
X-Received: by 2002:a05:6808:1b25:b0:3f4:7f2:a773 with SMTP id 5614622812f47-3f68313cc04mr165364b6e.7.1741117732772;
        Tue, 04 Mar 2025 11:48:52 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-3f6767109b3sm588522b6e.20.2025.03.04.11.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 11:48:51 -0800 (PST)
Date: Tue, 4 Mar 2025 13:45:31 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 08/12] object-file-convert: stop depending on
 `the_repository`
Message-ID: <walfo6kpxvjdenutznkb56yzlqgjetayquszinhjte2krq5dh6@3qkm2zk4gbwe>
References: <20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im>
 <20250303-b4-pks-objects-without-the-repository-v1-8-c5dd43f2476e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303-b4-pks-objects-without-the-repository-v1-8-c5dd43f2476e@pks.im>

On 25/03/03 09:47AM, Patrick Steinhardt wrote:
> There are multiple sites in "object-file-convert.c" where we use the
> global `the_repository` variable, either explicitly or implicitly by
> using `the_hash_algo`. All of these callsites are transitively called
> from `convert_object_file()`, which indeed has no repo as input.
> 
> Refactor the function so that it receives a repository as parameter and

s/parameter/a &/

> pass it through to all internal functions to get rid of the dependency.
> Remove the `USE_THE_REPOSITORY_VARIABLE` define.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/tag.c         |  2 +-
>  commit.c              |  2 +-
>  object-file-convert.c | 29 ++++++++++++++++-------------
>  object-file-convert.h |  3 ++-
>  object-file.c         |  7 ++++---
>  5 files changed, 24 insertions(+), 19 deletions(-)
> 
> diff --git a/builtin/tag.c b/builtin/tag.c
> index d3e0943b734..7c173535cb3 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -172,7 +172,7 @@ static int do_sign(struct strbuf *buffer, struct object_id **compat_oid,
>  	if (compat) {
>  		const struct git_hash_algo *algo = the_repository->hash_algo;
>  
> -		if (convert_object_file(&compat_buf, algo, compat,
> +		if (convert_object_file(the_repository ,&compat_buf, algo, compat,
>  					buffer->buf, buffer->len, OBJ_TAG, 1))
>  			goto out;
>  		if (sign_buffer(&compat_buf, &compat_sig, keyid))
> diff --git a/commit.c b/commit.c
> index 6efdb03997d..48aeefaad31 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -1380,7 +1380,7 @@ static int convert_commit_extra_headers(const struct commit_extra_header *orig,
>  		struct commit_extra_header *new;
>  		CALLOC_ARRAY(new, 1);
>  		if (!strcmp(orig->key, "mergetag")) {
> -			if (convert_object_file(&out, algo, compat,
> +			if (convert_object_file(the_repository, &out, algo, compat,
>  						orig->value, orig->len,
>  						OBJ_TAG, 1)) {
>  				free(new);
> diff --git a/object-file-convert.c b/object-file-convert.c
> index eba71955cf7..7ab875afe6c 100644
> --- a/object-file-convert.c
> +++ b/object-file-convert.c
> @@ -1,4 +1,3 @@
> -#define USE_THE_REPOSITORY_VARIABLE

Looking good :)

>  #define DISABLE_SIGN_COMPARE_WARNINGS
>  
>  #include "git-compat-util.h"
> @@ -63,7 +62,8 @@ static int decode_tree_entry_raw(struct object_id *oid, const char **path,
>  	return 0;
>  }
>  
> -static int convert_tree_object(struct strbuf *out,
> +static int convert_tree_object(struct repository *repo,
> +			       struct strbuf *out,
>  			       const struct git_hash_algo *from,
>  			       const struct git_hash_algo *to,
>  			       const char *buffer, size_t size)
> @@ -78,7 +78,7 @@ static int convert_tree_object(struct strbuf *out,
>  		if (decode_tree_entry_raw(&entry_oid, &path, &pathlen, from, p,
>  					  end - p))
>  			return error(_("failed to decode tree entry"));
> -		if (repo_oid_to_algop(the_repository, &entry_oid, to, &mapped_oid))
> +		if (repo_oid_to_algop(repo, &entry_oid, to, &mapped_oid))
>  			return error(_("failed to map tree entry for %s"), oid_to_hex(&entry_oid));
>  		strbuf_add(out, p, path - p);
>  		strbuf_add(out, path, pathlen);
> @@ -88,7 +88,8 @@ static int convert_tree_object(struct strbuf *out,
>  	return 0;
>  }
>  
> -static int convert_tag_object(struct strbuf *out,
> +static int convert_tag_object(struct repository *repo,
> +			      struct strbuf *out,
>  			      const struct git_hash_algo *from,
>  			      const struct git_hash_algo *to,
>  			      const char *buffer, size_t size)
> @@ -105,7 +106,7 @@ static int convert_tag_object(struct strbuf *out,
>  		return error("bogus tag object");
>  	if (parse_oid_hex_algop(buffer + 7, &oid, &p, from) < 0)
>  		return error("bad tag object ID");
> -	if (repo_oid_to_algop(the_repository, &oid, to, &mapped_oid))
> +	if (repo_oid_to_algop(repo, &oid, to, &mapped_oid))
>  		return error("unable to map tree %s in tag object",
>  			     oid_to_hex(&oid));
>  	size -= ((p + 1) - buffer);
> @@ -139,7 +140,8 @@ static int convert_tag_object(struct strbuf *out,
>  	return 0;
>  }
>  
> -static int convert_commit_object(struct strbuf *out,
> +static int convert_commit_object(struct repository *repo,
> +				 struct strbuf *out,
>  				 const struct git_hash_algo *from,
>  				 const struct git_hash_algo *to,
>  				 const char *buffer, size_t size)
> @@ -165,7 +167,7 @@ static int convert_commit_object(struct strbuf *out,
>  			    (p != eol))
>  				return error(_("bad %s in commit"), "tree");
>  
> -			if (repo_oid_to_algop(the_repository, &oid, to, &mapped_oid))
> +			if (repo_oid_to_algop(repo, &oid, to, &mapped_oid))
>  				return error(_("unable to map %s %s in commit object"),
>  					     "tree", oid_to_hex(&oid));
>  			strbuf_addf(out, "tree %s\n", oid_to_hex(&mapped_oid));
> @@ -177,7 +179,7 @@ static int convert_commit_object(struct strbuf *out,
>  			    (p != eol))
>  				return error(_("bad %s in commit"), "parent");
>  
> -			if (repo_oid_to_algop(the_repository, &oid, to, &mapped_oid))
> +			if (repo_oid_to_algop(repo, &oid, to, &mapped_oid))
>  				return error(_("unable to map %s %s in commit object"),
>  					     "parent", oid_to_hex(&oid));
>  
> @@ -202,7 +204,7 @@ static int convert_commit_object(struct strbuf *out,
>  			}
>  
>  			/* Compute the new tag object */
> -			if (convert_tag_object(&new_tag, from, to, tag.buf, tag.len)) {
> +			if (convert_tag_object(repo, &new_tag, from, to, tag.buf, tag.len)) {
>  				strbuf_release(&tag);
>  				strbuf_release(&new_tag);
>  				return -1;
> @@ -241,7 +243,8 @@ static int convert_commit_object(struct strbuf *out,
>  	return 0;
>  }
>  
> -int convert_object_file(struct strbuf *outbuf,
> +int convert_object_file(struct repository *repo,
> +			struct strbuf *outbuf,
>  			const struct git_hash_algo *from,
>  			const struct git_hash_algo *to,
>  			const void *buf, size_t len,
> @@ -256,13 +259,13 @@ int convert_object_file(struct strbuf *outbuf,
>  
>  	switch (type) {
>  	case OBJ_COMMIT:
> -		ret = convert_commit_object(outbuf, from, to, buf, len);
> +		ret = convert_commit_object(repo, outbuf, from, to, buf, len);
>  		break;
>  	case OBJ_TREE:
> -		ret = convert_tree_object(outbuf, from, to, buf, len);
> +		ret = convert_tree_object(repo, outbuf, from, to, buf, len);
>  		break;
>  	case OBJ_TAG:
> -		ret = convert_tag_object(outbuf, from, to, buf, len);
> +		ret = convert_tag_object(repo, outbuf, from, to, buf, len);
>  		break;
>  	default:
>  		/* Not implemented yet, so fail. */
> diff --git a/object-file-convert.h b/object-file-convert.h
> index a4f802aa8ee..9b3cc5e533d 100644
> --- a/object-file-convert.h
> +++ b/object-file-convert.h
> @@ -14,7 +14,8 @@ int repo_oid_to_algop(struct repository *repo, const struct object_id *src,
>   * Convert an object file from one hash algorithm to another algorithm.
>   * Return -1 on failure, 0 on success.
>   */
> -int convert_object_file(struct strbuf *outbuf,
> +int convert_object_file(struct repository *repo,
> +			struct strbuf *outbuf,
>  			const struct git_hash_algo *from,
>  			const struct git_hash_algo *to,
>  			const void *buf, size_t len,
> diff --git a/object-file.c b/object-file.c
> index b3e0276b2a4..b0e237a2acc 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1793,7 +1793,7 @@ static int oid_object_info_convert(struct repository *r,
>  		if (type == -1)
>  			return -1;
>  		if (type != OBJ_BLOB) {
> -			ret = convert_object_file(&outbuf,
> +			ret = convert_object_file(the_repository, &outbuf,
>  						  the_hash_algo, input_algo,
>  						  content, size, type, !do_die);
>  			free(content);
> @@ -2510,7 +2510,7 @@ int write_object_file_flags(const void *buf, unsigned long len,
>  			hash_object_file(compat, buf, len, type, &compat_oid);
>  		else {
>  			struct strbuf converted = STRBUF_INIT;
> -			convert_object_file(&converted, algo, compat,
> +			convert_object_file(the_repository, &converted, algo, compat,
>  					    buf, len, type, 0);
>  			hash_object_file(compat, converted.buf, converted.len,
>  					 type, &compat_oid);
> @@ -2550,7 +2550,8 @@ int write_object_file_literally(const void *buf, unsigned long len,
>  					 &compat_oid);
>  		else if (compat_type != -1) {
>  			struct strbuf converted = STRBUF_INIT;
> -			convert_object_file(&converted, algo, compat,
> +			convert_object_file(the_repository,
> +					    &converted, algo, compat,
>  					    buf, len, compat_type, 0);
>  			hash_object_file(compat, converted.buf, converted.len,
>  					 compat_type, &compat_oid);
> 
> -- 
> 2.49.0.rc0.375.gae4b89d849.dirty
> 
> 
