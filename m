Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE733E5A20
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 18:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785867828; cv=none; b=anCdloLhAmtFeS2NYEGW2VrlGmT6PKYzZXSF+Ad1cBEEeJD/NLKij9iVxt9xHt9EhOJ9gmIk8vLKeT+uwwATj5ww0kLm9SP+QBNpd2mDuBZU0g/lggMSaRaQdaPtP7ywh1gCII+aaPu6lPXVFgd1RsDRNfldm+UZHp0Rk6hZEkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785867828; c=relaxed/simple;
	bh=Ihu/lnfRwi+vhLc45T9PK6IQBY/Zj9grMN4debw1YgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RGKM3cwK19WikJfYY9hlZNHxVYtb0Y+NpTTDnxbneyws/7nhV06a25A2htZXOT2llpvRftyyxznEdhnJZvFbBoyJ748cBiYXOfoFKwRoinZCgDGvshQCKfRnX093SAgkleQ7mPP0R1mkDhhaa8XmUlsr7/9DjTj2b7QaQN/T7Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kphyXqE8; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kphyXqE8"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7ee4399c3abso150338a34.2
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 11:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785867825; x=1786472625; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S3zMLzPgmVW2Y+PsHem+VfE15nLdOObx2XxjlNqWiNg=;
        b=kphyXqE8B08be/UkDaZOJYQ5W20dejeaXsIhjMrMiqD1jpkzyv977XCT2xUZ9O615u
         +4ynaCBG9rYLNVrX0sZRip0vvejjW2jiuWwo42pkcr1Ie0CGTWzZq2qUBca1CDyo2Yyy
         uY58EcT2Vq0d/wr6V+BH+iMw9IbBmGKPvfrFtYuwLgO4RkVTX1CeQ2ot4Z08+cYg4rWB
         f9MAOw6oMAaW8k2BZ244O1EOS5jjK1bJiOQ2r3jY4Fd7E23s2eakshhlQMKTqN3OS5uD
         TOY/uAvn54JQCqLSR78vd+vRHWT3sGP4EDLc+WWu4W7/cRQYbw7aVsQhOlyq1mugViHq
         BcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785867825; x=1786472625;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S3zMLzPgmVW2Y+PsHem+VfE15nLdOObx2XxjlNqWiNg=;
        b=o/TIk1DHzxuZ6SyKagA6KvDtbKJViFTbUOPiukBlDCPaN7rvuAypM8TvloDXS9E2FW
         ECn882YAaURL8Wym7pCYzxtNb+tjMJuRHPzmuy34oOArR5NffvmQHjSkN2DJeQuyPVty
         paKgJCQzgVbfCd7QrBuefctFZmewTIa+SKB1+szbB1PFoBvl/PZEwHv2gWT4ashNG6Ca
         VI4dzKB/j8hkJ1eRyI6gfKcoAMiomSzs/rOziZaMWsuXXCICUgFiopj8QonzHPuKUMAK
         iPRxcYq6YnGz+h9NoWp2JOdTH6h/KwuZ1hkEBTjU0FQPYmn2aI8LFh0CwSdrTLozQgH8
         SjlQ==
X-Gm-Message-State: AOJu0YyvlVq8Fqc3EemRZAK10U/ArxbJPcZZ/bJkzLgk2g5hnC4P3Tis
	8MXYDE0tYXn/8xKbM1/8mLc+HT096NkSp9on5iVJD2G86BR27nrLJcWLV+qAgA==
X-Gm-Gg: AR+sD136Rj4KjadLkt8H1nIxVsXO6utOE71Y9tgcnTyHdM2HWzjK8O6BoFOYQ6akthD
	geIsh69uhSpuoYoQMsxOJkJLl6Ph2NWbVOgKvhZRe34jIrctz3393OITmV/m64JIVnlA/2V2WfW
	1D3Kae7KItyh5jnqEgE/FBmKrUDj0ewOxILRUB6vTYKJxhDCXPyVege1PE2qbduWnm0xQ3+ESBu
	Q1cr49zv5q4GWcfGMcSkwK8qqnNkbVIlLhURtHxTeE2RLCuV+DCQQ+wcOSNmDb4WBDtJ9DE1IMN
	OWxtqjEE1tp+EMFqQKT8/sjk8Qoro9UyZnR4TtErNaqSqArKEEqxTds966x+GUGHjs35vNPpkaI
	goCXQ/xs5kPDdAvkdhC0GQ8e4WR4LZpx8L9LDt+ZkWNb7Ze4pvESBafX6/96qIyj4dP4b0Aep67
	LbRrbQOy45WaxoeYvkcoaiy/CGPX8bE3E/rmj68Tzv4JaCpRRo9C1sKIf7/AgvZojy
X-Received: by 2002:a05:6830:4393:b0:7e6:e162:915 with SMTP id 46e09a7af769-7f1e5cf74ccmr695450a34.5.1785867825551;
        Tue, 04 Aug 2026 11:23:45 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f1df59d551sm1441032a34.20.2026.08.04.11.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 11:23:45 -0700 (PDT)
Date: Tue, 4 Aug 2026 13:23:42 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/7] odb/streaming: consolidate read and write streams
Message-ID: <anIrtigj0L7PU2hl@denethor>
References: <20260804-pks-odb-stream-unification-v1-0-86d70e82345e@pks.im>
 <20260804-pks-odb-stream-unification-v1-5-86d70e82345e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804-pks-odb-stream-unification-v1-5-86d70e82345e@pks.im>

On 26/08/04 09:25AM, Patrick Steinhardt wrote:
> The `struct odb_read_stream` and `struct odb_write_stream` both provide
> the same functionality: they allow a caller to read object data from an
> arbitrary source. Historically, the only difference was that the read
> stream was used to read data out of the object database, whereas the
> write stream was used to write data into the object database, but the
> interfaces were mostly the same.

Ok.

> Over the preceding commits we have refactored the write stream to have
> almost exactly the same interface as the read stream. With these
> refactorings we can now easily merge those two streams into a single
> interface that's used for both use cases.

Nice.

> While most of the changes are mechanical, there are two sites that need
> special mention:
> 
>   - "builtin/unpack-objects.c" creates a write stream from compressed
>     object data.
> 
>   - "odb/streaming.c" creates a write stream from a file descriptor.
> 
> Adapting these sites to yield the new stream type requires a couple more
> changes. Most importantly, instead of embedding the pointer to the data
> in `struct odb_write_stream`, we now allocate a structure that wraps the
> new `struct odb_stream` base. Other than that though, the changes are
> rather straight forward.

Ok, creating wrapper stream types for these sounds reasonable.

> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/unpack-objects.c      | 31 ++++++++++++++++---------------
>  object-file.c                 | 25 ++++++++++++-------------
>  odb.c                         |  2 +-
>  odb.h                         |  4 ++--
>  odb/source-files.c            |  2 +-
>  odb/source-inmemory.c         |  4 ++--
>  odb/source-loose.c            |  6 +++---
>  odb/source-packed.c           |  2 +-
>  odb/source.h                  |  4 ++--
>  odb/streaming.c               | 35 ++++++++++++++++-------------------
>  odb/streaming.h               | 31 +++----------------------------
>  odb/transaction.c             |  2 +-
>  odb/transaction.h             |  4 ++--
>  t/unit-tests/u-odb-inmemory.c |  6 +++---
>  14 files changed, 65 insertions(+), 93 deletions(-)
> 
> diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
> index 7439ec53be..05a2d48011 100644
> --- a/builtin/unpack-objects.c
> +++ b/builtin/unpack-objects.c
> @@ -359,20 +359,21 @@ static void unpack_non_delta_entry(enum object_type type, unsigned long size,
>  }
>  
>  struct input_zstream_data {
> +	struct odb_stream base;
>  	git_zstream *zstream;
>  	int status;
>  };

Ok, as mentioned in the commit message, we now embed the stream instead
storing a pointer to the extra data. Should we also update the struct
name here now that `input_zstream_data` is really itself a stream?

> -static ssize_t feed_input_zstream(struct odb_write_stream *in_stream,
> -				  unsigned char *buf, size_t buf_len)
> +static ssize_t feed_input_zstream(struct odb_stream *in_stream,
> +				  char *buf, size_t buf_len)
>  {
> -	struct input_zstream_data *data = in_stream->data;
> +	struct input_zstream_data *data = container_of(in_stream, struct input_zstream_data, base);

Callback is updated to fetch data from the base stream.

>  	git_zstream *zstream = data->zstream;
>  
>  	if (data->status != Z_OK)
>  		return 0;
>  
> -	zstream->next_out = buf;
> +	zstream->next_out = (unsigned char *) buf;
>  	zstream->avail_out = buf_len;
>  
>  	while (data->status == Z_OK && zstream->avail_out == buf_len) {
> @@ -388,24 +389,24 @@ static ssize_t feed_input_zstream(struct odb_write_stream *in_stream,
>  static void stream_blob(unsigned long size, unsigned nr)
>  {
>  	git_zstream zstream = { 0 };
> -	struct input_zstream_data data = { 0 };
> -	struct odb_write_stream in_stream = {
> -		.read = feed_input_zstream,
> -		.data = &data,
> -		.size = size,
> -		.type = OBJ_BLOB,
> +	struct input_zstream_data in_stream = {
> +		.base = {
> +			.read = feed_input_zstream,
> +			.size = size,
> +			.type = OBJ_BLOB,
> +		},
> +		.zstream = &zstream,
> +		.status = Z_OK,
>  	};
>  	struct obj_info *info = &obj_list[nr];
>  
> -	data.zstream = &zstream;
> -	data.status = Z_OK;
>  	git_inflate_init(&zstream);
>  
> -	if (odb_write_object_stream(the_repository->objects, &in_stream, &info->oid))
> +	if (odb_write_object_stream(the_repository->objects, &in_stream.base, &info->oid))
>  		die(_("failed to write object in stream"));
>  
> -	if (data.status != Z_STREAM_END)
> -		die(_("inflate returned (%d)"), data.status);
> +	if (in_stream.status != Z_STREAM_END)
> +		die(_("inflate returned (%d)"), in_stream.status);
>  	git_inflate_end(&zstream);
>  
>  	if (strict) {

Stream set up is now updated to use the wrapper stream. Looks good.

[snip]
> @@ -299,14 +289,15 @@ int odb_stream_blob_to_fd(struct object_database *odb,
>  }
>  
>  struct read_object_fd_data {
> +	struct odb_stream base;
>  	int fd;
>  	size_t remaining;
>  };

`read_object_fd_data` is also now set up as a wrapper stream. Should we
also rename it accordingly?

> -static ssize_t read_object_fd(struct odb_write_stream *stream,
> -			      unsigned char *buf, size_t len)
> +static ssize_t read_object_fd(struct odb_stream *stream,
> +			      char *buf, size_t len)
>  {
> -	struct read_object_fd_data *data = stream->data;
> +	struct read_object_fd_data *data = container_of(stream, struct read_object_fd_data, base);
>  	ssize_t read_result;
>  	size_t count;
>  
> @@ -323,17 +314,23 @@ static ssize_t read_object_fd(struct odb_write_stream *stream,
>  	return read_result;
>  }
>  
> -void odb_write_stream_from_fd(struct odb_write_stream *stream, int fd,
> -			      size_t size, enum object_type type)
> +static int close_object_fd(struct odb_stream *stream UNUSED)
> +{
> +	/* The file descriptor is owned by the caller for now. */
> +	return 0;
> +}
> +
> +struct odb_stream *odb_write_stream_from_fd(int fd, size_t size, enum object_type type)

Should we also update the name of this function?

The rest of this patch is just renames and call site updates to
consolidate the two stream types. Looks good.

-Justin
