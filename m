Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4673161AD
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 00:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769128362; cv=none; b=E+KMZlymENausUlheg6HIZvn5pV8RvW+rb7qSVGe3qcn92qNgbL4ZXhBlJUx4VetJJgYBXfpddWEI+LDP/KjUlf6Id0wB/bRemlclOzvBNtZsTtRMKrk7Fvsk3XDvW9CNfnLE4+vGQsf77f0y4uj8pWk0jNKnKO0S7gx4VM0FmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769128362; c=relaxed/simple;
	bh=f2V0vdLu0b1QAB7Czok1yEP+saXE2ws4C6JzkqqoXVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o6YLxLxo4R9J96FvaWWOJ8A75LxXNC0sDuxv49NB+KDjPYRiMxLWxLO2PG/zaD2vWMxpDyLbilh8sN+RbPCeUSfLARWAhHObWOKTqavOidNM4xyx027QlF+c2uLWLddEMgHqKH76DZAVcK7UAhv3eVPPgpY2ImVkh4VC9WXRqtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=EqAd4RUD; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="EqAd4RUD"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-88a367a1dbbso30529056d6.0
        for <git@vger.kernel.org>; Thu, 22 Jan 2026 16:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1769128354; x=1769733154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/BdZWLHnBETRgCpwnhkHvFy9a7/w8OlKErPSLxUZYjM=;
        b=EqAd4RUDzwy6pFbpTIjvR6ERqX22slqWixvUz0wNZha0QH06LGYRyHV1w48kxR0tOq
         Yv6pthKWMebo9QBUJRm0dloL93x8fDXV96xZjVnxwz+p9wkcrKSFEy1Z0HABcWK9eSf8
         kLgccFBS93mDM5SXEvcJLhx9C6KCA7PRyfX+J+WhyT7wl//HXhFIwJc3wIGItX4SgKW9
         RHU/0DDxs9ofr6imqrCNyHs08dlzlXLwf9ljQdF2M7YJGj+u+ZZid+EfA0PFUnsvdfGk
         393Qi+oVpgMeDELTTaStecW19u0ZWtmda71z9pMSQgj9B0mQGpyOJpUT3z023b4Son0c
         uk4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769128354; x=1769733154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/BdZWLHnBETRgCpwnhkHvFy9a7/w8OlKErPSLxUZYjM=;
        b=bevhdk1EwTymodb0B3yjOFi+8Ls232dzdt5wN0fX0pKAiZr028nqBYA1fUYQnEVZoC
         V+VRY4dTxW7r2jx9xvs/rywyIItqrmsFniGFbckEE16BKDxcMyP+R7ryeTKePVGs3ao2
         7noFU9HbFrxLmf1lYAR6XZ92SKQYULAt1JnrSeTmkZfLuVyEjnFIF8uoeiVvmwCCvWzA
         Fckpn9ihaOI8gaLGS9USXqLjq45Z30h/eXn3uBdSbhx8R5qKfEmDm+82bHB0Z9nw8OYd
         CgbRADpXxxB1v/xtugC3KS1llpuXAGjELzsUKoTcqjdQXw7ENHghmVd/r4giqwFDM1YU
         wWFQ==
X-Gm-Message-State: AOJu0YzFEBzJMYYMbfE1yxB4+4lfkpm8bCzzjKtHtCQRio8fL4QwuQ6H
	FEkluGvCPOTcn/xhHAwBJSR2BZt4gsigmCgF7IRBOKQiZngsjM5s8FOwNt/6OZlMW1s=
X-Gm-Gg: AZuq6aJTCGTzal0KIWa+Ci4UK+1aklzaVLjQLHl0PGlhA8RO0uqEaUljEMux3k04hQX
	yCzZk2Nh8YjHFcU5xumMwnBDmrrLIy57APFB+PhEoZjSVUlcMNT3fkOM+DIPNYOwDGZZZ7qKOnw
	QZeTvN6vG+jSXh/C0ZXN3jfCO7ZEswUlUaCnpWmvf2qPggy+9+sZEIu0COhdClI6DVwIi1MUFsH
	WZOnBfBFdR+aNe1CemSd32coq/vHAPcY3x16QmkfhpWUORMzwlZv8PVsHk1x4+ghUUp8+nNxzvU
	2SSCPgpmwbvXUc8dQcB6DkM6OPsjuypUOM0M6L7LnS6TCZdG2YYUSk+Gj2hn4aLOQkLXJBAehvF
	4SIFuWDLxsxzb5aeTCamkL4f1Ni2NEZl4NOBYeOfXREWLOYdnb7zwk5cNs7WfHqeBGU4h+qqLlr
	a3tzANQmpTz+WwoTix+W1q1uwtiVSTWKYh6ZNvJ+WqbiXLovb6z+A/CPhctL3hmQqf713/oTbqQ
	ebK/SDEcsVfwOiDWQ==
X-Received: by 2002:a05:6214:d8f:b0:894:6d0b:502 with SMTP id 6a1803df08f44-8949021c291mr22687076d6.59.1769128353785;
        Thu, 22 Jan 2026 16:32:33 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8949183272csm5310666d6.13.2026.01.22.16.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 16:32:33 -0800 (PST)
Date: Thu, 22 Jan 2026 19:32:32 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 08/14] builtin/fsck: refactor to use
 `odb_for_each_object()`
Message-ID: <aXLBoFnqbnCcylCD@nand.local>
References: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
 <20260121-pks-odb-for-each-object-v3-8-12c4dfd24227@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260121-pks-odb-for-each-object-v3-8-12c4dfd24227@pks.im>

On Wed, Jan 21, 2026 at 01:50:24PM +0100, Patrick Steinhardt wrote:
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/fsck.c | 57 ++++++++++++---------------------------------------------
>  1 file changed, 12 insertions(+), 45 deletions(-)

This patch was a really pleasant read. It's really great to see both
pairs of functions collapse into a single one that acts the same over
loose/packed objects as opposed to two functions which do the same thing
but need to have different signatures to be able to plug into the
iterators for loose vs. packed objects.

> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index 4979bc795e..96107695ae 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -218,15 +218,17 @@ static int mark_used(struct object *obj, enum object_type type UNUSED,
>  	return 0;
>  }
>
> -static void mark_unreachable_referents(const struct object_id *oid)
> +static int mark_unreachable_referents(const struct object_id *oid,
> +				      struct object_info *io UNUSED,

s/io/oi/ ?

> +				      void *data UNUSED)
>  {

The transformation here makes sense (and I think aloud through the
similar mark_object_for_connectivity() transformation below). One
thought that I had while reading, though, was how this function behaves
when it is passed the same object more than once, since you mention that
as a possibility in the commit which introduces odb_for_each_object().

I think that this is OK, since we already likely send the same object to
this function multiple times if, e.g., we freshened an object from the
cruft pack, in which case we'd see it both when iterating packed
objects as well as when iterating loose ones.

As far as I can tell, that's OK, but it might be nice to provide a brief
analysis of that in the commit message, just to be sure and to help
future readers.

> @@ -848,26 +831,12 @@ static void fsck_index(struct index_state *istate, const char *index_path,
>  	fsck_resolve_undo(istate, index_path);
>  }
>
> -static void mark_object_for_connectivity(const struct object_id *oid)
> +static int mark_object_for_connectivity(const struct object_id *oid,
> +					struct object_info *oi UNUSED,
> +					void *cb_data UNUSED)
>  {
>  	struct object *obj = lookup_unknown_object(the_repository, oid);
>  	obj->flags |= HAS_OBJ;
> -}
> -
> -static int mark_loose_for_connectivity(const struct object_id *oid,
> -				       const char *path UNUSED,
> -				       void *data UNUSED)
> -{
> -	mark_object_for_connectivity(oid);
> -	return 0;
> -}
> -
> -static int mark_packed_for_connectivity(const struct object_id *oid,
> -					struct packed_git *pack UNUSED,
> -					uint32_t pos UNUSED,
> -					void *data UNUSED)
> -{
> -	mark_object_for_connectivity(oid);
>  	return 0;
>  }

This is really nice, and everything here makes sense. Both of the old
callback functions merely call mark_object_for_connectivity() but are
different in order to accommodate the different function signatures
required. The new function uses the common interface and does the exact
same thing. Looking great.

> @@ -1001,10 +970,8 @@ int cmd_fsck(int argc,
>  		fsck_refs(the_repository);
>
>  	if (connectivity_only) {
> -		for_each_loose_object(the_repository->objects,
> -				      mark_loose_for_connectivity, NULL, 0);
> -		for_each_packed_object(the_repository,
> -				       mark_packed_for_connectivity, NULL, 0);
> +		odb_for_each_object(the_repository->objects, NULL,
> +				    mark_object_for_connectivity, NULL, 0);

Makes sense.

Thanks,
Taylor
