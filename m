Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50472340DBF
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 15:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034849; cv=none; b=CIdP5GkgIr2MQuJf5LQVHgFkshnqoiYjnz/ZnH+8IvLliDRqp3/b6lEzZC2Mcsm+e3iMS+/cDpvnDXMHWQFVuQQSDnvfBZJv734aD1kWnUo4qWzxPQPZ6Oh94uV/0MlB8nXd+ChBIPgW36nBC1InPzrKqobWkNVXyHAGBIfPDxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034849; c=relaxed/simple;
	bh=5NU4CaKYaQgYWp6sFthK+IAkhVNPHJQaF0Yalvip63g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fiekfpEe2uFW30sL4I0vcgtaXqYhhcnAvbPMo88BnmDw2UrMqi99t01BPKe1w3s/qQiWBnJf6OK1mQxdde7DCHFc9GACuDINi2aYTzUNyttPg/gAHJzieiEW8N9SlQakwLy084gJZcS72tmO3cY+ciCmNTQUEaosgGO/hJiFQYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yn51Msfq; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yn51Msfq"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-74526ca7d64so5527838a34.2
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 08:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758034846; x=1758639646; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=asmpLdBAfgmewOtQZl04+hP1XaNx64otJsKPWc+0D1E=;
        b=Yn51MsfqwTlJP/wIzYmw9KyvwBc2vG8EnSlx+q5xLOAQp9lC5k7QrOptDtvhcnGNUe
         yB12iW1fJRmRv39D5CaI0o/kxp2iAGEc6q8AW5avUTUONaJAVSUKW1YlACBtt/uqaYfG
         pbj3QGYra2gm2jOjtUwxf6+D+3KjInLM85oyvjMbbEXCks9d2TYiDCE7gVESisCeockJ
         ZXee4wNv+klzhwkqhR3E/JukGyWxTn+M1U5JoC8tYVYYEkTmA5UjUEac13tS/ohsHGsG
         KaCrunW78R39K93XrZxV4Pu9ZMag0oBBwPPCMeAcbGSji9SI8W27RpIYblxDm9Zc/rsd
         07Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758034846; x=1758639646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asmpLdBAfgmewOtQZl04+hP1XaNx64otJsKPWc+0D1E=;
        b=d1i8//qQ7iBcWGtxUP+fqswmOhhziKh1QpLG8Kla6NGLMO4F/RgImxAHzYv9AXBh1G
         xAafrM7NzoGke5DPbIdewNSn5B6yhrpe4D7pVnM7aM/hka7FBrXPwTi2brKYBU3pzFYu
         e77aU2dXe2FL5HqPoiAbcyKoumvohav+N1yn6CWHN6xYbnaDdLbnCGhBnnblzhiVQlg/
         4+cJeM0ArUAeYpywT2JtXd9nknbSOC61yBMu6jgHxVcbc/L/K/A6+773dH3jypZ9ofti
         xY7zpZkMySgJjIk9LJyebUQ73IEO5+UfjrIIzrRYlMiIN53DeYYFZ+2CG8cnv85h2xAZ
         8+5Q==
X-Gm-Message-State: AOJu0YzZf3Gc19ODS2Oh8nTi7AAwpEQn1UZHq0KCSLv6I2oG7I2G8YIq
	VYFPD4yLzEklVbG4YkuRoEYKqUbd//PTRXOsAzkGz5cnqw/OXSY9N0kW
X-Gm-Gg: ASbGncvxs/7zkhxCVv1yxGTWZ6ePkvLVDPe6dupxzSIisZYbR0M1HM5fYT8/oUN+4u9
	zn9jFSmhqGSRMFpXezdSU+cEJfXuSUFt4kqKIV4mJLkQpUUfkanlyU7hYK6fBHgT9VdtZcRPPNx
	QWiCxbI/8BJ2Ai/sIWdvQif13Y0FVvebs0KBuOZhHIm746Wz//ypJq9m5aLdFv4pWl1HCc31wgf
	mi95iR0OD5nkgRh10aQZYB5CBxx2VfbtLxTjq5bqdpCSASMESoLqbz2P6vxJrmThJPKWBYeE8AN
	GA68IHwxX1FjkCTNpMm/2R+3PRjXxV3C2ncoiK0qObb6AqOvw4fbUdoWVLApP+oeTh2G6JwgqPK
	BhSk6gLq5Jx2ciK7i
X-Google-Smtp-Source: AGHT+IET/VMGvkMXA08+NICDfUOJl6FVlKOp6mVk9UeAub6TyQHcIBNs1LBKd9j49MjFb+Qoa2Eccw==
X-Received: by 2002:a05:6808:6f91:b0:43b:5cee:14c with SMTP id 5614622812f47-43b8da6275cmr7082194b6e.43.1758034846035;
        Tue, 16 Sep 2025 08:00:46 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-43b82af7ab1sm3317261b6e.30.2025.09.16.08.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:00:45 -0700 (PDT)
Date: Tue, 16 Sep 2025 10:00:45 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH v2 1/6] bulk-checkin: remove ODB transaction nesting
Message-ID: <h7yqajyyilmcjb4lfco2oooqwradmyrhx4aystush3klpbgl6d@3zrii36y6kk5>
References: <20250909191134.555689-1-jltobler@gmail.com>
 <20250915202956.3784935-1-jltobler@gmail.com>
 <20250915202956.3784935-2-jltobler@gmail.com>
 <CAOLa=ZThwF0LTd17Wxa3AJnpQuEkcSyp5kHm=D-cZ=Ay0pWa0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZThwF0LTd17Wxa3AJnpQuEkcSyp5kHm=D-cZ=Ay0pWa0A@mail.gmail.com>

On 25/09/16 12:57AM, Karthik Nayak wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > ODB transactions support being nested. Only the outermost
> > {begin,end}_odb_transaction() start and finish a transaction. This is
> > done so that certain object write codepaths that occur internally can be
> > optimized via ODB transactions without having to worry if a transaction
> > has already been started or not. This can make the interface a bit
> > awkward to use, as calling {begin,end}_odb_transaction() does not
> > guarantee that a transaction is actually started or ended. Thus, in
> > situations where a transaction must be explicitly flushed,
> > flush_odb_transaction() must be used.
> >
> > To better clarify ownership sematics around a transaction and further
> 
> s/smatics/semantics
> 
> > remove the need for flush_odb_transaction() as part of the transaction
> > interface, instead be more explicit and require callers who use ODB
> 
> The first sentence doesn't flow into the second here. Perhaps s/instead//

Thanks. I'll fix these in the next version.

> > diff --git a/cache-tree.c b/cache-tree.c
> > index d225554eed..f88555a773 100644
> > --- a/cache-tree.c
> > +++ b/cache-tree.c
> > @@ -474,7 +474,7 @@ static int update_one(struct cache_tree *it,
> >
> >  int cache_tree_update(struct index_state *istate, int flags)
> >  {
> > -	struct odb_transaction *transaction;
> > +	struct odb_transaction *transaction = NULL;
> >  	int skip, i;
> >
> >  	i = verify_cache(istate, flags);
> > @@ -490,10 +490,15 @@ int cache_tree_update(struct index_state *istate, int flags)
> >
> >  	trace_performance_enter();
> >  	trace2_region_enter("cache_tree", "update", the_repository);
> > -	transaction = begin_odb_transaction(the_repository->objects);
> > +
> > +	if (!the_repository->objects->transaction)
> > +		transaction = begin_odb_transaction(the_repository->objects);
> > +
> >  	i = update_one(istate->cache_tree, istate->cache, istate->cache_nr,
> >  		       "", 0, &skip, flags);
> > +
> >  	end_odb_transaction(transaction);
> > +
> >  	trace2_region_leave("cache_tree", "update", the_repository);
> >  	trace_performance_leave("cache_tree_update");
> >  	if (i < 0)
> >
> I wish the parent transaction would be passed through to make it easier
> to understand, instead of deriving from a global variable. Nevertheless,
> this is a great improvement.

This should be cleaned up a bit in the next version by making
begin_odb_transaction() function as a noop that returns NULL when the
ODB already has a pending transaction. This allow us to at least avoid
checking the transaction state from the global here. We will still have
to derive the ODB from the_repository global for now though.

-Justin
