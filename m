Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BF73546CA
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 22:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781647834; cv=none; b=UajWhZMjAusCJKuzOcI3gHvqfldEtk9RA35S0aydDTIN+vRg+RQPPbL3U0BMdQubCjVEDOu45fNd21La5gE2dDTfkGpxxTFmaMLVof01nCy4sHjHGk5Eol9bivwO5BCUNoQOKeukplUa/AJOE3wqe9xvpwZZl59/RH22rQ7gmEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781647834; c=relaxed/simple;
	bh=m8ijBX+S03BwbFRdqI7qC872j1lyAQbQBwOoqmx8KTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9bcw0dIBlLzQiUjXzlMxy+r1VyDhYENKhANdQbHwa6KXkpXaQ8x3V94SJbKFMZPGZCYq5JFtlRFhVoeN0XkYWVkUibU3R6n8qsHr2plou9kVT9EdaxAmvbM0EJuXFkvK2TSm4JZeEqq40NpOYojfmcK44yw0zozPcqFygJ+Irs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WDZabehM; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDZabehM"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7e6e41cf7aeso2745836a34.0
        for <git@vger.kernel.org>; Tue, 16 Jun 2026 15:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781647832; x=1782252632; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xftl+aX3BHFMSHdpdMlVhFdLZIppM72/xfNyAgwBAPI=;
        b=WDZabehMrDBnOF8vDuLtEBSqEwG00mIbPAQYg0Kq6aGF080Ry0VAZosTw7o8X7ypI0
         15JcDuO3/xI5ORNhHTy5eri7vtIqqWvoRwt92CpjwZz2jWZ6obcQizCrDhp9h5MhRDMs
         zGEg86WRsTxD0mBj0i8tIxw8JdSDzRutdzknHXqr8+gehdjPNC4xtAbouEwbT2TpdEDM
         hAgVjpbHPu56QjbHL6ofrQV9Mj11P7g2HVkEyiAcd6q3CxUxi587ijxd8AY+k6t3pf2D
         IPPFfKUXzj/CdY8F3CCXl/JyfFMUOo0c0SZ42J+UFhDMZG+QwCIy3ONlIg9ambvXKECV
         8eOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781647832; x=1782252632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xftl+aX3BHFMSHdpdMlVhFdLZIppM72/xfNyAgwBAPI=;
        b=GeVHT4cE30SaCSz5RhgkNJIXK/YkeUEtuQapjVJxadCNXV5rJYkJH91YlBP/oXZ33o
         nTSTnHv7apKdMnFHgVr0EqyXSuoJ7inCslWoeEQeoFwgCmEYtuucwOqcOamcKYRQtgSJ
         qvddFyRIzmZYlJlOatjvDuY7izDu4TOhPb1e5ySRy7ZwYyIdu2gVBNTwN0WULS6XFwBh
         fpOKz0Mpw5dAs0b9hYJJndWXCqPJ2TM6KE7rN6muJkGfKFGPTSDLKviGRXBE2vR7L5l2
         weTjEH/D9Y2GnZpKJuSQ/FGmJYeFRWnyjSN5XsAUB4+7hlP1S7wOvOYUnqRSPTbPoEL3
         LjQg==
X-Gm-Message-State: AOJu0Yx4UXvxwRnAnjxBM/1P0zr/REpBqIM84n5fKfLIjR3eqgpOI/OF
	YYLEzJ98LTyVby6mtBaazrqz+YxGp70elsRHzNuEFL1qPw+Gb7OTpccg
X-Gm-Gg: Acq92OF6kB6Gy6UmI6jsU1dyjTxEPtNGJeB+9ALHWSfIzaacur0FHuqruKwvzmskCqg
	cxlzW3eRx8a0yDF0IPLnzA+sHR9mCXbwMRePL05X3ZM5VX/oEQFBQYqDY8l3DKzkR/YmLl9lIoY
	2civ6IoxHtqHl7tRn5wWF/RzuCLQ7/NyXiVsrrZNlJ1xTR+9ClX2jTHYojjmTn84kacz/zt2gNg
	QU2gZjFT79VELaxyMSFEx6ImO+1kfJ9yNhJanVgm3O6snZbXBrCUg+Qtxtao2LnDCWMNxF4sR1V
	gRfjTRqUHCR/i7yzeD2gy7yeiUhVgRqA+8kfv4KwSz/KNIc9UXacRKPIcaREffLSEc8Mujl5Bem
	PaePpsC3rDUt8RpimX0csal/D++0BcdfdoF9kc1m180Wwit8xwSOK40p7x0fIZLmcIyfY41RCom
	3Cd8HGub4tfBw8ECdj
X-Received: by 2002:a05:6830:2405:b0:7e6:c9eb:535a with SMTP id 46e09a7af769-7e90c65fd58mr866602a34.6.1781647832268;
        Tue, 16 Jun 2026 15:10:32 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f5a1de6sm7583862a34.4.2026.06.16.15.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 15:10:31 -0700 (PDT)
Date: Tue, 16 Jun 2026 17:10:28 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 11/17] odb/source-packed: wire up `for_each_object()`
 callback
Message-ID: <ajHIjrQJvWtbCrZp@denethor>
References: <20260609-pks-odb-source-packed-v2-0-839089132c8b@pks.im>
 <20260609-pks-odb-source-packed-v2-11-839089132c8b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609-pks-odb-source-packed-v2-11-839089132c8b@pks.im>

On 26/06/09 10:51AM, Patrick Steinhardt wrote:
> Move `packfile_store_for_each_object()` and its associated helpers from
> "packfile.c" into "odb/source-packed.c" and wire it up as the
> `for_each_object()` callback of the "packed" source.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
[snip]
> @@ -291,6 +548,7 @@ struct odb_source_packed *odb_source_packed_new(struct odb_source_files *parent)
>  	packed->base.reprepare = odb_source_packed_reprepare;
>  	packed->base.read_object_info = odb_source_packed_read_object_info;
>  	packed->base.read_object_stream = odb_source_packed_read_object_stream;
> +	packed->base.for_each_object = odb_source_packed_for_each_object;

Wiring up the callback. Looks good.

>  	if (!is_absolute_path(parent->base.path))
>  		chdir_notify_register(NULL, odb_source_packed_reparent, packed);
> diff --git a/packfile.c b/packfile.c
> index 42c84397eb..b8d6054c16 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -1362,8 +1362,8 @@ static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
>  	hashmap_add(&delta_base_cache, &ent->ent);
>  }
>  
> -static int packed_object_info_with_index_pos(struct packed_git *p, off_t obj_offset,
> -					     uint32_t *maybe_index_pos, struct object_info *oi)
> +int packed_object_info_with_index_pos(struct packed_git *p, off_t obj_offset,
> +				      uint32_t *maybe_index_pos, struct object_info *oi)

Looks like we are also exposing `packed_object_info_with_index_pos()`
now. Not sure yet if this is also intended to be temporary like
`find_pack_entry()` in a previous patch though though.

-Justin
