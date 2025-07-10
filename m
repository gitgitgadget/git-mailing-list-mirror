Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C8F2C031E
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 22:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752188058; cv=none; b=M83Zw/ZP9RC7cFh5X1eJXVhYGqWSwttqpgEK+MJK41ESNyqlY0L7drBV8u370L9l3GSLD6VHRyXtQ6zdC+O33Xo2A+6NI56o9aKFfHPvcfOBPc7jA1mi9L1/IcHL9Ab4e3H834xzCdRS6299TiFPtNMklHmRfq1KACPML5bEJ6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752188058; c=relaxed/simple;
	bh=3uMjOp0cWrdVTiha44JTiMbLFOXrGk/UYi2bJNHNx88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGOUJ4E0sYL4Q3R6zmEXfqeJwfBWeZAMH3gE67hK05xSw9UvYeODTzbNfaEzvOHQSa+eztr/XKpZBG7S7819uvtwve2YfB8xjRuU6DSZrIc41O2HJK3Iu57EpVfArO9HI3dxz/J8IC4t5W19shakg8WuCAOpRb8JfpkYGUdpY9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+uKg3I8; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+uKg3I8"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-40b54ee16ddso966932b6e.1
        for <git@vger.kernel.org>; Thu, 10 Jul 2025 15:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752188055; x=1752792855; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dyiNtpf6VXtlqWSPzLb4gMxgji/um0T+/CeEs3Ia2Pc=;
        b=F+uKg3I8Y7bnHbGqao1yRzHJcXNIFmui6SRfZCUvZOwKCX0YT0eG77c0olgIcDC6Hq
         E1eNMZjLBHaY3FKGGejJa22gieBnP7sq6lN86twydDPMmosSMiAO3k9p3X0Shp5EJ7BT
         Goj+PFQ/rx+sQClr0DLKqlxNt539Pq3R9kQ3X6JacRrSu6Xaxqe0llw5rrEhaJ277ioe
         Um2Ne8h9m1guX4kNgKhm3ufu9jTCIFzCk9oOCzpzMPJr+13u/aQolIseRIcF+t/umFT4
         LOTdjMIdq6sZAofV/bEgMaMMp5Idg9vxfsOSFNSGdAfCf/dxa0bN12HpUXZ13Twl4ioB
         DAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752188055; x=1752792855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dyiNtpf6VXtlqWSPzLb4gMxgji/um0T+/CeEs3Ia2Pc=;
        b=Uu925ggk01KXOOYkFCXHf+Y0hYI9EOYOLFBAfH8pvMfhAW1pLx7UnyQQpQ1VGoINT1
         odHzmpxR9YRkm2r3575vql4laAqO6WOLjbZ3fAQQR99cy3KNvSdJwR9mnGllXPaE6993
         8oj4k1dR9lITY25zfpJ8GGoYaikvpalzTF64H17WRCKGsGtKjXodPoC4bBvqHW2CkRvb
         xCqjmFHstAwLInh9pwQc7r8a+oJF22wjGInq62+q5E5z6ObTlhYhLPFTUsS2Aj8nk+sl
         a7gV5O5Yxf7RjUqhnbncRnZCTM2j2BbSxjq6uQSNwIIGz4+cf/xXl/TXtZ6wUVP3+OpL
         aiMA==
X-Gm-Message-State: AOJu0YyjPSCY9xcL57ebxziF3BZcw62HY2TfhORVqh0PJIRoXS3XkfUE
	6RiTgCj+IqZFWdlt0ILht5ovNimOBvAWDPtdXoAsYghYyGr3NkmVOAGw
X-Gm-Gg: ASbGncuhSuQiIBDELSkgndqrtkp6xVhiK0tj/pbXsRc2KjpcCMsZOO7wocZR4R5FDly
	g/SVH/Q2qozxFL4RBXwVqyhTleK4wN0KVIkrjiPbnW/aIPAPATB5uI+XkxVrYnKPQRprhJr54Vy
	Yd2w9VBCpmfAaNtUSBHDDP8DDpU08y2hgqjxTn+I7o/NUsE8XvTqzUazWeeRDrVtiU0Kydy0O7o
	JUxuge1wx6iSren+t4lBmpT41z8yFEROR6HFyB16EV+ZUA0SRyk88lOF3cGMmHLEwxlGUU2qyDv
	TdQdCag+SR1l1Os3vC6P2EUxi9+s4AiYgRb6omW6E5eKZ0g3455jZYVfQjippvEdL+hk9EANORs
	njSm0tQGHoysA57X5wIlfDRwfkA==
X-Google-Smtp-Source: AGHT+IGTOvnKxexqofXWkegWJqBEXMYhiBAwtJ1lu4bCVCdlHMSGlV1gObVbZHj/NM5GfYIGvWrBCQ==
X-Received: by 2002:a05:6808:3987:b0:401:ea47:2c4a with SMTP id 5614622812f47-4150faa27acmr1003403b6e.28.1752188055156;
        Thu, 10 Jul 2025 15:54:15 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-414191e562bsm355701b6e.12.2025.07.10.15.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 15:54:14 -0700 (PDT)
Date: Thu, 10 Jul 2025 17:48:37 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 8/8] midx: remove now-unused linked list of multi-pack
 indices
Message-ID: <34spkce2saz3qto5mxqs3vhnnwjk7r7rt3hoz6mk34ethyr667@mmlwajnl7jb2>
References: <20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im>
 <20250709-b4-pks-midx-via-odb-alternate-v1-8-f31150d21331@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709-b4-pks-midx-via-odb-alternate-v1-8-f31150d21331@pks.im>

On 25/07/09 09:54AM, Patrick Steinhardt wrote:
> In the preceding commits we have migrated all users of the linked list
> of multi-pack indices to instead use those stored in the object database
> sources. Remove those now-unused pointers.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  midx.c     | 16 ++--------------
>  midx.h     |  2 --
>  odb.h      |  7 -------
>  packfile.c |  1 -
>  4 files changed, 2 insertions(+), 24 deletions(-)
> 
> diff --git a/midx.c b/midx.c
> index 6d3a166fa01..27623e8cbb7 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -726,7 +726,6 @@ int midx_preferred_pack(struct multi_pack_index *m, uint32_t *pack_int_id)
>  int prepare_multi_pack_index_one(struct odb_source *source, int local)
>  {
>  	struct repository *r = source->odb->repo;
> -	struct multi_pack_index *m;
>  
>  	if (source->multi_pack_index_loaded)
>  		return !!source->multi_pack_index;
> @@ -735,19 +734,9 @@ int prepare_multi_pack_index_one(struct odb_source *source, int local)
>  	if (!r->settings.core_multi_pack_index)
>  		return 0;
>  
> -	m = load_multi_pack_index(r, source->path, local);
> -	if (m) {
> -		struct multi_pack_index *mp = r->objects->multi_pack_index;
> -		if (mp) {
> -			m->next = mp->next;
> -			mp->next = m;
> -		} else {
> -			r->objects->multi_pack_index = m;
> -		}
> -		source->multi_pack_index = m;
> -	}
> -
> +	source->multi_pack_index = load_multi_pack_index(r, source->path, local);

Now that we are dropping the MIDX list stored in the object database, we
no longer have to store. Nice and simple.

>  	source->multi_pack_index_loaded = 1;
> +
>  	return !!source->multi_pack_index;
>  }
>  
> @@ -840,7 +829,6 @@ void clear_midx_file(struct repository *r)
>  			source->multi_pack_index = NULL;
>  			source->multi_pack_index_loaded = 0;
>  		}
> -		r->objects->multi_pack_index = NULL;
>  	}
>  
>  	if (remove_path(midx.buf))
> diff --git a/midx.h b/midx.h
> index b1626a9a7c4..c4192c92d44 100644
> --- a/midx.h
> +++ b/midx.h
> @@ -35,8 +35,6 @@ struct repository;
>  	"GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL"
>  
>  struct multi_pack_index {
> -	struct multi_pack_index *next;

We no longer need the next pointer since each `struct multi_pack_index`
represents an indepented MIDX chain.

> -
>  	const unsigned char *data;
>  	size_t data_len;
>  
> diff --git a/odb.h b/odb.h
> index b39534dd55b..8ff523a33de 100644
> --- a/odb.h
> +++ b/odb.h
> @@ -124,13 +124,6 @@ struct object_database {
>  	struct commit_graph *commit_graph;
>  	unsigned commit_graph_attempted : 1; /* if loading has been attempted */
>  
> -	/*
> -	 * private data
> -	 *
> -	 * should only be accessed directly by packfile.c and midx.c
> -	 */
> -	struct multi_pack_index *multi_pack_index;

Now each object source specifies its own MIDX and this one can go away.
Nice :)

> -
>  	/*
>  	 * private data
>  	 *
> diff --git a/packfile.c b/packfile.c
> index 3eeec20906b..453a38395bb 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -375,7 +375,6 @@ void close_object_store(struct object_database *o)
>  		source->multi_pack_index = NULL;
>  		source->multi_pack_index_loaded = 0;
>  	}
> -	o->multi_pack_index = NULL;
>  
>  	close_commit_graph(o);
>  }
> 
> -- 
> 2.50.1.327.g047016eb4a.dirty
> 
> 
