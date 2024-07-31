Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE0A1B3F1A
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 16:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722442735; cv=none; b=MezSy23FCNEEw9ACCN3keBh+OMi0+VLvhxzMaG8NlRSUvfKRFPznUzaYYiyGOGTkH7ZUixIKX73CZ9+mvtkBWvxEJb6KEDbQu5fhywrTB9hk7hupczzQrdb0Zr7HjV2mbvnBLRdOp/nMiJh4GdgCjWYHbrlOthLF0UbZHdJK5M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722442735; c=relaxed/simple;
	bh=Hy2SrQdPn3OJH7t7bl2qgiL8RhgKjee+nNQlEyDj8j8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GycEJk46VEWzaptZ0NjjxsAdxhWqXCXYQccCKrxtlHFpqrxWixaHMw9tzJvwF40mzL960tdXjzldMMMLZouIA/m1eFbjn9qpbQCsjhws+TJkDQJhKLYqewKXn4KqMWKG7uvOSLc0OG1Cu4HpU3HveohicS+R6pzqodc6I3m8BM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDWCsXm6; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDWCsXm6"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fc587361b6so42490725ad.2
        for <git@vger.kernel.org>; Wed, 31 Jul 2024 09:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722442733; x=1723047533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KtzYdqb7U5otkbGk625eNjkMgDRfqo4VK5Rb+kjPp/U=;
        b=gDWCsXm6GaSs6Tm4VPV4DKA0ZuUKY85kb/NQAG61u9oMZx6nPYbkDaC6DJhrXrvqv7
         f5/8AHrG1X6i6pifG9PwUMB9Y4rTZeK0wzUlyNtrNozWuRrIABcqd4rkBmKlGQI4x1nC
         ILhZ3usWPyQDYhbyCQaIne8pXs913nciqdI+QMlsMr9WDMTxZn2TIxAUg+cUW0v+me12
         67sLSNCvCOIHMa4FjBjSagMs/54xorNO1g404JPNlHcfW3hW/OzRraZNTzdslDEmkHUk
         pgn9QaCmx0jJDN7nuPPePhUYsuQGMuUpPXfHY/plffYYxrUdq96Yssy9rI3gl03Tr4dL
         r2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722442733; x=1723047533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KtzYdqb7U5otkbGk625eNjkMgDRfqo4VK5Rb+kjPp/U=;
        b=nMPbFhpirpq5vYm7KaFSm6Y6BY8kav0JERpMyiNqTM+6SbP1fkffCbij2N/2iguky5
         keun7ks2u1K/EorjWxYT2BAKCpoBlcDdRCJHurOmJ4VAGSHiKnafmiRuFMyy6aJjdUv2
         5dvBeg5jdPe51G1pa2+k/kA/2ovOmP+U9XsEv0J8PVxRP4ujHqT0sFreOVbJW9q6v5i3
         dfLO8e9BvS3YsX0bIvQjvvlJHPbzrClq6hmnlkN8k5+Yvf0RSqeXHNtTWqDh2PrCrFXh
         LRUWmGOsSK8BZ8f5fpFSUrSJcaGHtv7sZikrm0pSlphr8t1D6lQ2/LJrVSFzvdSOg0tI
         truA==
X-Gm-Message-State: AOJu0Yx21vXErbsOrirVYXj6WA251l46j4rZMVDwnZuBSczMYv8iZttG
	e9y63A67DJcg8DYaXfVlHwK6k/LbOd/4KPjn0l+7nQuVLQO2h7Sd
X-Google-Smtp-Source: AGHT+IG2FdrjaLqtdyjuDRR8kwS5u5VmTcoqEED8mXSW9boWUTUseAdfCCF+iTY9KDf0rOq6xYC96Q==
X-Received: by 2002:a17:902:ea0e:b0:1fb:6ea1:5e with SMTP id d9443c01a7336-1ff048e4fc0mr104659295ad.44.1722442732317;
        Wed, 31 Jul 2024 09:18:52 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ffd12dsm122418285ad.308.2024.07.31.09.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 09:18:50 -0700 (PDT)
Date: Thu, 1 Aug 2024 00:19:13 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v13 10/10] fsck: add ref content check for files
 backend
Message-ID: <ZqpkAakuNkm8qJMM@ArchLinux>
References: <ZqeXrPROpEg_pRS2@ArchLinux>
 <ZqeY3Dhj-Fo-bZ2k@ArchLinux>
 <xmqqh6c6a61e.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh6c6a61e.fsf@gitster.g>

On Tue, Jul 30, 2024 at 03:06:37PM -0700, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > +static int files_fsck_refs_content(struct fsck_options *o,
> > +				   const char *gitdir,
> > +				   const char *refs_check_dir,
> > +				   struct dir_iterator *iter)
> > +{
> > + ...
> > +	if (parse_loose_ref_contents(ref_content.buf, &oid,
> > +				     &referent, &type,
> > +				     &failure_errno, &trailing)) {
> 
> The function parse_loose_ref_contents() needs to know what the hash
> algorithm is, and it used to implicitly assume that the_repository's
> hash algorithm was an OK thing to use.  Patrick's recent clean-up
> series instead passes "struct ref_store *refs" throughout the call
> chain so that "ref->repo->hash_algo"  can be used.  This needs some
> matching change, which means ...
> 
> >  	files_fsck_refs_fn fsck_refs_fns[]= {
> >  		files_fsck_refs_name,
> > +		files_fsck_refs_content,
> >  		NULL
> >  	};
> 
> ... the function signature for files_fsck_refs_fn must change to
> have something that lets you access repo->hash_algo.
> 

Thanks for your remind, I have scanned this patch:

	https://lore.kernel.org/git/fe0e2c3617c8040c632dbc3de613a1d22e8070f7.1722316795.git.ps@pks.im/

I guess I will handle this later. It seems that this series has not come
into the cooking tree. I will update this part until Patrick's patch
gets merged into "next".

> 
> By the way, unless the most common use of an array is to pass it
> around as a collection of items and operate on the collection, it is
> a better practice to name an array with a singular noun.  Name the
> array as fsck_refs_fn[] not _fns[].  This is so that you can refer
> to a single element in a more grammatical way.  E.g. with
> 
>   struct dog dog[] = { { .breed="shiba" }, { .breed="beagle" } };
> 
> you can say "dog[0] has brown fur" instead of "dogs[0] has ...".
> 
> In this case, you do not treat the collection of functions as a one
> thing and do something to the collection.  Instead you'd repeat over
> the functions in a loop and individually call them, perhaps like so:
> 
> 	for (i = 0; fsck_fn[i] != NULL; i++)
> 		fsck_fn[i](...);
> 
> so it is very much more appropriate to name the array itself as
> singular to allow you to say "first fsck_fn", "next fsck_fn", etc.
> 

Thanks, I have learned a lot here. I will improve this in the next
version.
