Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEE8C2D1
	for <git@vger.kernel.org>; Fri,  9 May 2025 15:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746804100; cv=none; b=DUP3nvPjE+wb2r/N8ZGm9Bk8pCCBX2GiBpOBWdwKKNEEAG9WnS0AgJ36sZZhogNNItkoJKqZX9txsB5djAQrs6yEKrUKXM7jC+OJ5gFBdJcszedneHR7slIjAAtvvbaiuWIE6bVolDHUQaVMOAWOnEMcjmPNLIKGB/qe3c7zeh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746804100; c=relaxed/simple;
	bh=mNWSjO6J0p70asNzG5zPYZQPwT4qR9jJfjl925wF9pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZBNYj+IpGtSkpipVKKg425TJgdAdDEOxHR1TjG84aMrUKaQP+8bWkyIDOBjXKFF8hZ//8/cCbb7xBnFljf/H7Fofr06vZGGPfmn50hDdSR86aXOakSC7L5OtIWeY7wIW6nn3day0OI9rX42G4+ZYyDdo1NNBc4a+TifnQJljA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YunXgI8e; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YunXgI8e"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22e76850b80so17304385ad.1
        for <git@vger.kernel.org>; Fri, 09 May 2025 08:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746804098; x=1747408898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H87f985D+tfyttKVfRgpkW+5Ev7knamWCQYLWCZ8VIo=;
        b=YunXgI8eq5POrIrKcfPN6vVQb/DhXKcV2y+lPFzxMtTP+Tt6Q7morkLY0aW96PkBc7
         5pip6Ga/qVEH4t3vNRitM352ofaayqtf4diHIDNA7nzWdCIDw2q87Nl/QqiNxx1c++9X
         a3MFPqAisRpAuDW5/L6+d/DPRRrXIss6tjv6z7D+vg7K+prPzaQcdmki1msFyh7F0AiK
         GtKdN2buuMtl48wJNFmXMve1Zn3k6gO9Esliashx9cB181qjtmIbtkou4d2GRCUSi6Zh
         kc2hhdRpXoyzHQdLEDWs9V1a4irYiOCE10zGu5bnRtH+2+YiBR5BgrmLVf2nYUS4pVPU
         53qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746804098; x=1747408898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H87f985D+tfyttKVfRgpkW+5Ev7knamWCQYLWCZ8VIo=;
        b=iVAns8HLafVo+hHn9esw0PGJfu2jyAkeA9yCC9Olx6LvDVtAHWDhbapvHne4O0bHwa
         5Lq9R2WSHAR97aMkZKms6C0o9c8ckxKGb8zwj/IE8FgJzf56yJjMN9JXChDLYcvRSC4d
         POutnbwIpDJOA356dENhBBvHKDXnUoiqc9s40rhJf+IAiE5rBMs0t6Eixk9FZXYGvCtD
         aBWby1NoXQapK+4R65UKpeA7EzSEf3xY/wxPwG7/qHdRRidtDxG1iVFkcGLQqsGO7Qr7
         o5QD81/lRyVBgukKr3/6BNpRXn4dtDXI322tgrU4gsfSHA4Ia9mLy4QZLtQoxJsYJ9FI
         Ok0A==
X-Gm-Message-State: AOJu0YyJsWzOVQrfSkALic7qEI36eM74IT0ivvdGx5GBklVwtWcvgGeD
	uhBeYKDvr1VCpbTQqWwt7wH7mXcw7EkgjOoIg7rXIeRET30qKK59
X-Gm-Gg: ASbGncsOvMXSypWU8gG/sxAIR5oYLblPMM3XPzd9X0V4RQFlG7n09jjdB5h/bfo7hX4
	kV7w07dV+3U4E3AFsbMMDOsVZXaJYvDOyl5KLV/9mdbcbMlAV3gUIKL/kYzmTl6LBG7uuShA4ZM
	cX4sAPu2CJ5Gl/PoemaCwtemCGIN0+1L20tbnzvaXbkzIlwMrcOUCWO7u8VF28sm7dE2r6aGvoM
	Qjwig/+UuRSn0L5QnYRKT4ynHX33VsUymbq7peRNa5TH8bapVkfNy+oGsS/NS9otT8YitnuWKmD
	klEiQxurITB6sMS1d93Srv3gg5AGSXvpG4+/uUAv8z5EhFU=
X-Google-Smtp-Source: AGHT+IHuoQ+/iWBG802ROC5yxXYh2eCMvGVinn+eKNOJzGy+G8l60Rha9CFafLsf4IM4Tn2dZxyGrA==
X-Received: by 2002:a17:903:2f8e:b0:216:7926:8d69 with SMTP id d9443c01a7336-22fc91ab409mr50570145ad.47.1746804098565;
        Fri, 09 May 2025 08:21:38 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22fc7743bc9sm18434395ad.100.2025.05.09.08.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 08:21:37 -0700 (PDT)
Date: Fri, 9 May 2025 23:21:34 +0800
From: shejialuo <shejialuo@gmail.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 4/4] packed-backend: mmap large "packed-refs" file
 during fsck
Message-ID: <aB4dflpFNW4mJlq6@ArchLinux>
References: <aBtzn4nwLsI9p5Cp@ArchLinux>
 <aBt0C8gdBecq5f8U@ArchLinux>
 <20250508200741.GB18229@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508200741.GB18229@coredump.intra.peff.net>

On Thu, May 08, 2025 at 04:07:41PM -0400, Jeff King wrote:
> On Wed, May 07, 2025 at 10:54:03PM +0800, shejialuo wrote:
> 
> > diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> > index ae6b6845a6..ff744f1d4c 100644
> > --- a/refs/packed-backend.c
> > +++ b/refs/packed-backend.c
> > @@ -2079,7 +2079,7 @@ static int packed_fsck(struct ref_store *ref_store,
> >  {
> >  	struct packed_ref_store *refs = packed_downcast(ref_store,
> >  							REF_STORE_READ, "fsck");
> > -	struct strbuf packed_ref_content = STRBUF_INIT;
> > +	struct snapshot *snapshot = xcalloc(1, sizeof(*snapshot));
> 
> Minor, but is there any reason to allocate this here and not just:
> 
>   struct snapshot snapshot = { 0 };
> 
> ?

I simply copy the code from the existing code... I will change.

> 
> > @@ -2126,21 +2126,23 @@ static int packed_fsck(struct ref_store *ref_store,
> >  	if (!st.st_size)
> >  		goto cleanup;
> >  
> > -	if (strbuf_read(&packed_ref_content, fd, 0) < 0) {
> > -		ret = error_errno(_("unable to read '%s'"), refs->path);
> > +	if (!allocate_snapshot_buffer(snapshot, fd, &st))
> >  		goto cleanup;
> > -	}
> 
> Looking at allocate_snapshot_buffer(), it will return 0 only when the
> file is empty (and thus there is nothing to allocate) and will
> otherwise die(). So we do not need to report any error when it fails.
> Good.
> 
> But that makes the "!st.st_size" check in the context redundant, doesn't
> it? It can just go away.
> 

Good catch. I remember in the V1, this does not exist. I may make
something wrong when rebasing the code. Thanks!

> > -	ret = packed_fsck_ref_content(o, ref_store, &sorted, packed_ref_content.buf,
> > -				      packed_ref_content.buf + packed_ref_content.len);
> > +	if (mmap_strategy == MMAP_TEMPORARY && snapshot->mmapped)
> > +		munmap_temporary_snapshot(snapshot);
> > +
> > +	ret = packed_fsck_ref_content(o, ref_store, &sorted, snapshot->start,
> > +				      snapshot->eof);
> 
> Why are we unmapping here before we use the content? That will create an
> allocated in-memory copy of the mmap'd content. I thought the whole
> point here was to avoid doing so.
> 

I simply follow how "create_snapshot" does. Actually, I am also quite
confused about this. If we would eventually copy the content into the
user space's memory. What is the reason that we mmap at Windows in the
first place?

My understanding is that after mmaping, we need to do some sanity checks
and then if there is a need, we may sort the "packed-refs" file. So, we
would improve some efficiency at Windows for this part?

> It does shorten the amount of time we hold the temporary mmap in place,
> but I don't think we care about that here. The whole point of
> MMAP_TEMPORARY is that we usually hold the packed-refs file open across
> many requests, and on some platforms (like Windows) we don't want to do
> that. But in this code path we plan to mmap, do our verification, and
> then drop the snapshot. So we're always "temporary" anyway.
> 
> I.e., I'd have expected this code to allocate_snapshot_buffer(), do its
> checks, and then call clear_snapshot_buffer().
> 

I will improve this in the next version.

> -Peff
