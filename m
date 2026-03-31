Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2C0370D4F
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 07:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774943324; cv=none; b=uw9oEyMppkzAhNrn425dnqgh8Y+xYAxI0qk5aMvWSltLbo5DVZb4RKK0Uax8g0lRUlp6E/5HxlTv8N2Ioxa7URdaVZ2TSH0bl0BH0uLL/6ly21fO0OjdT7e9RY1ORF3qmhe85ssRgjF5kEH7ww0GJ4ekCaGEdKqLr/bimgRelos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774943324; c=relaxed/simple;
	bh=oqgC6c/8HO4ScJfYsjMh41R9qwRdnifQcSzTlPvQPao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbDyBPyI+l0Bvmyzv3AqHPmyQL6xbNTalGqECIGFJQhZAe0qKPZnBAbGuRuXSw9rDKW8oP4tG5iAtZeKv5RmgrZgSosHXj5pGfPA1UBb7R1qRZwV3xyEjb5ag77+3Y5e2JmfUqoIk6RibL3JR9b7FuqBrQ5M97br5gr8oICAw/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PNowq9r/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nswVk2ou; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PNowq9r/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nswVk2ou"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1E3131400259;
	Tue, 31 Mar 2026 03:48:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 31 Mar 2026 03:48:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1774943322; x=1775029722; bh=thkNANhxtt
	2CyFUMCKmJ7ttvzvqX9Dy7fcmZxuM9DcQ=; b=PNowq9r/L11LimMX1Y4ODCjpRq
	twZJ6KMsbkgtFmfMZhWHfOMT4TCN9bric96mBMFw53GlpcuJPetPCNsUeQu7CcWt
	Elj1JMH38ZV+gDyEHZ6jIb/exuOnZY/9dREHsU3L87aaYr0Zw9yjQWU/uYr92GiD
	MipiQ9Aq8BaCVhl0qX6NPj/95BJaRKZkP6fJGpEeQsw/huh7ASnTKwhpSUm6WPPR
	6/ZpJWL+uxsHj8VSsRNDlrmUS+JikOttX2gJ4e2Q15RlzE/Om5guHuTox3i+npdL
	jSsSy3nlZBJGnWw7UoG/lOVIoL3W3J8ihS2gGDAJwz7a7Y4k1roMFdJrJAeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1774943322; x=1775029722; bh=thkNANhxtt2CyFUMCKmJ7ttvzvqX9Dy7fcm
	ZxuM9DcQ=; b=nswVk2ouRofG1SkpiTAIcDdoRuZRjKH2sUVnMVU6HkLvIEl8HJk
	IdTAu1rdP+96G7har+3aM3TUXMHZfwrHnWyY8XEKYlA0DzUNCgyUTHBgNKi2dj5v
	De8Uyhr7NzagZl/peosrAH4Rz4qsBrw35qUqDsgms3Rd0bJiRISYK4ofdcZ8XqvN
	928EtN2u625MbhCgqsDsJhEnwsdAMjnZlNE6lUJL/knTPZYJerh4/idSRJue3J7h
	y6VaiHJNdfLaGLpPg1BLw4lBYqa6Ejnf5GLnaocipQo2/eo6GpMRkOSvJTMqcKII
	rn8luBhVP5NmA/fd5wwrwQ1VZuTzRt68J/w==
X-ME-Sender: <xms:WnzLaZUUPrFYn2taiqA09bm5PLS0jaiXK8kkfM9cVUclxRisJK4wNA>
    <xme:WnzLaflA3EXTdoMC7BD515Ff7iEauY5sangT_1-quWXfBOO1MYvqK-SSQqKvhxhqR
    b0PelQGY7ybyiN8yDzpXSb_Pvbkv0hwzR1Jih3_uTB0ch8qcCk6cg>
X-ME-Received: <xmr:WnzLaTBW_KjkrafjA-ZVh7n8qlGLSK2cL1fO6cMRlCyFRrVQsnPJWrBSVV0_G1qT02Gdk7XWg4Ndn8qzwwXDwq8zM4aPRJ7IG9rw3Eg8Vlg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefgedufedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:WnzLaXcb-uQ84E-eAXXItcP_t1Cdih5Vq-tX_08ZQVweSG-ii8hMTg>
    <xmx:WnzLaWIZpaBjvt1rOcdvHRL2-VtB1F1UYI0kMsb9BQG0J7Gw8bwzGg>
    <xmx:WnzLaSfGCbv2k9Dx9Z5l3j_nwyYEJSvtbMJnG4S6FOIEhnZsfncX8Q>
    <xmx:WnzLaV0bucSuQ5nImbon-_wEJDd4pSQ9JKirkf_tZci7QelVxJC-1Q>
    <xmx:WnzLaeGQcdYhSBWDkIsL74JwhnPlDoulkQje8D9KytnC7BHJl7Q2kJGz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 03:48:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 342f6b09 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 31 Mar 2026 07:48:41 +0000 (UTC)
Date: Tue, 31 Mar 2026 09:48:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/6] object-file: remove flags from transaction packfile
 writes
Message-ID: <act8VlnYzyTGOY7Y@pks.im>
References: <20260331033835.2863514-1-jltobler@gmail.com>
 <20260331033835.2863514-4-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331033835.2863514-4-jltobler@gmail.com>

On Mon, Mar 30, 2026 at 10:38:32PM -0500, Justin Tobler wrote:
> The `index_blob_packfile_transaction()` function handles streaming a
> blob from an fd to compute its object ID and conditionally writes the
> object directly to a packfile if the INDEX_WRITE_OBJECT flag is set. A
> subsequent commit will make these packfile object writes part of the
> transaction interface. Consequently, having the object write be
> conditional on this flag is a bit awkward.

One could argue that we can uplift the object into the transaction
interface. But I have to overall agree that this would be rather awkward
as we're now starting to mix concerns that really shouldn't be mixed.
Most importantly, it would be weird to have a transaction where you can
write some objects, but not all of them via such a flag.

> In preparation for this change, introduce a dedicated
> `hash_blob_stream()` helper that only computes the OID from the fd. This
> is invoked by `index_fd()` instead when the INDEX_WRITE_OBJECT is not
> set. The object write performed via `index_blob_packfile_transaction()`
> is made unconditional accordingly.

Makes sense.

> diff --git a/object-file.c b/object-file.c
> index bfbb632cf8..493173eaf4 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1405,6 +1404,34 @@ static void prepare_packfile_transaction(struct odb_transaction_files *transacti
>  		die_errno("unable to write pack header");
>  }
>  
> +static int hash_blob_stream(const struct git_hash_algo *hash_algo,
> +			    struct object_id *result_oid, int fd, size_t size)

We could of course change the interface while at it to also receive the
object type. I'll leave it to you though whether you want to go there,
we don't have any use case for it right now anyway.

> +{
> +	unsigned char buf[16384];
> +	struct git_hash_ctx ctx;
> +	unsigned header_len;
> +
> +	header_len = format_object_header((char *)buf, sizeof(buf),
> +					  OBJ_BLOB, size);
> +	hash_algo->init_fn(&ctx);
> +	git_hash_update(&ctx, buf, header_len);
> +
> +	while (size) {
> +		size_t rsize = size < sizeof(buf) ? size : sizeof(buf);
> +		ssize_t read_result = read_in_full(fd, buf, rsize);
> +
> +		if ((size_t)read_result != rsize)
> +			return -1;

It would be a bit cleaner to first check whether `read_result < 0`
before casting.

    if (read_result < 0 || (size_t) read_result != rsize)
        return -1;

Doesn't make a difference in practice though.

> +		git_hash_update(&ctx, buf, rsize);
> +		size -= read_result;
> +	}
> +
> +	git_hash_final_oid(result_oid, &ctx);
> +
> +	return 0;
> +}

Overall, this function really is simple enough to pull out, even if it
duplicates a tiny amount of logic. Also, it has the benefit that we can
easily skip deflating the data, which we used to do even if we didn't
ultimately write the data to disk, so it was just pointless busywork.

> @@ -1642,7 +1655,7 @@ int index_fd(struct index_state *istate, struct object_id *oid,
>  	     int fd, struct stat *st,
>  	     enum object_type type, const char *path, unsigned flags)
>  {
> -	int ret;
> +	int ret = 0;
>  
>  	/*
>  	 * Call xsize_t() only when needed to avoid potentially unnecessary

In practice this doesn't have to be zero-initialized

> @@ -1659,18 +1672,23 @@ int index_fd(struct index_state *istate, struct object_id *oid,
>  		ret = index_core(istate, oid, fd, xsize_t(st->st_size),
>  				 type, path, flags);
>  	} else {
> -		struct object_database *odb = the_repository->objects;
> -		struct odb_transaction_files *files_transaction;
> -		struct odb_transaction *transaction;
> -
> -		transaction = odb_transaction_begin(odb);
> -		files_transaction = container_of(odb->transaction,
> -						 struct odb_transaction_files,
> -						 base);
> -		ret = index_blob_packfile_transaction(files_transaction, oid, fd,
> -						      xsize_t(st->st_size),
> -						      path, flags);
> -		odb_transaction_commit(transaction);
> +		if (flags & INDEX_WRITE_OBJECT) {
> +			struct object_database *odb = the_repository->objects;
> +			struct odb_transaction_files *files_transaction;
> +			struct odb_transaction *transaction;
> +
> +			transaction = odb_transaction_begin(odb);
> +			files_transaction = container_of(odb->transaction,
> +							 struct odb_transaction_files,
> +							 base);
> +			ret = index_blob_packfile_transaction(files_transaction, oid, fd,
> +						      xsize_t(st->st_size), path);
> +			odb_transaction_commit(transaction);

Okay. It's a bit sad that we have to reach into the files backend here,
but we already did beforehand, and maybe a subsequent commit will fix
this? Reading on.

On another note, it's somewhat curious that the commit doesn't return an
error code. Probably something we should fix eventually.

Patrick
