Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFA83F7875
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 14:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774966446; cv=none; b=I3OpPmlaXJ7W9yK8FCB5fzHZVvdms3UkMPTWFPFMIfnihlkZ4g4H5LuT9qAFxf6V/frTHpvx8mTec8vyvx/q/We3vY31v7pmHI1ZHoJ0qPQrQpV+qIi4CUoOSe+A6yqnNTlXcayC9pn7fFnymZl0EaB1Qutl7Dgn6/8sp7NMTNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774966446; c=relaxed/simple;
	bh=C0dRDu7B07XkoXQ0yc9wBT5a6FO+Sn9wY5QzUb4YRsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+fAbgyPtelpKQZMbv+QaOpu9GlXdAanjDhviAI1U5XvBYffxAVaCPY/W8ISUEqdDx7R4gBNLDViesPJrO5r7RBOwGa5BjW2L87x3ZPFDnQmstDTIRRs5vLLH9m77/CqXMYHMJ9KdOp0aayJJMOEY3cz5YdbriiTGjlh0Ht8NLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDGPh/rD; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDGPh/rD"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4648447e29bso1859631b6e.0
        for <git@vger.kernel.org>; Tue, 31 Mar 2026 07:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774966444; x=1775571244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U3F0PBG7mTgaaEJ5dSSMfhgZrZ0ZFLAGQD52DKZNNHA=;
        b=HDGPh/rDBNuO7Co9ezFpNykDT84KdTvWN5m76vgMEG0HyOvLxTLbModB3NiJjkoZQv
         UHWlxIE6sKZAB4i0h/0P80j+Xc21ohi1shpmnEG+hRZxSlxnZuHnCz3a/V97xaXOb6x6
         ke3f1oyW7hyBQCPF0x45p7sWvkLiCxKkw/Gs4XTEwVs31WVLZlpdPGpOcMT0Zn78huSH
         SD2l22a0b6vHKNAMZAf4/Kv1+Kt8pu9nwWy9t4oMWMRMvJhUV+O2N1E+pFyMGfMJJP3X
         TtVouVHnrVRXUr88eeA7+HtUCn3IEqP+OlEX9YyeFxDSXNLDOXZaTgM7SsvRJLxZF2kE
         2DBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774966444; x=1775571244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U3F0PBG7mTgaaEJ5dSSMfhgZrZ0ZFLAGQD52DKZNNHA=;
        b=b7InL8PzareWomdEh9pQ4kV/eFSqi9OzodEXEwXZlLdigi7x2T7z2GosjQTC//TojR
         VyGe8reZcSKq37Ry5n94cRlWFYDINHseMeIo9HYtTtJKtSBp6vYB8fNmWeVIqxO3L8n6
         ITc2NCHql0QH12EbMpSRgb47K/nx3fv64fWjZ/mONP5WnSedEJeoBOLYyefg5p03Yr2q
         srXr6y0OzyMJ595bUciacg1qMk3XuPtKfkkNBgzfIC1zRqLy+4uWm+u01EBwx38Zkm3I
         I/98mqS1AqtQtxi7TSUMM3rIhc8kc09aJspvmr7VGvQVRJtojfVbxM1OWN/dF7kPL/K0
         ggiQ==
X-Gm-Message-State: AOJu0YzJUOXkJYBve/tHsJkQ/ykTsvgVaadz8QBxFS6faPjO1u8ej+LV
	h3h3R8IE7wTvMRy/8Qw1MWHWO3PUSjidURH+m9r0Iu0oqkkOtSs5ixEdS7XT+w==
X-Gm-Gg: ATEYQzx0Hpg04OI/LI/gKGSeTH1PK60HnQbAs85nEYnEzxwmQEXWXP5PvRyZw+n5oLd
	f8Zz88VBKDv+crPYY60hTQB80pd8ssL44IySgWIP4dQ70HWmWrgCoIkowmAJuwLLX487CucBu4E
	3QXE1t7pkBuFftevtHwEePmY1Mms43QG4b1EXssCYoLJsjqdaYFBWTR1c5+UwflTH1HIIiy+/F5
	ps5LDffSd7+szAmGST2V95h5GHZ/u1wmv7csD+L1O/TSToMO0EgjcneazTlzfWTsfAsUNgANs/I
	5lYyZUsit/RViZwjUXcV+00qupnVDsNLQdNzYp6ui4JkHWiTcb56mq4+MsLrhuFfyhIh7GS3FGI
	ULN8SYZvV8nqScSyshdEULiPR0iY/6j/BjDKbFaDfHdykw1coqzJbhc/Hd83Gb4zYmcM+3ahEY7
	nykt7Tddp1C2yRF67N
X-Received: by 2002:a05:6808:4704:b0:450:bb4e:8395 with SMTP id 5614622812f47-46a8a5e0413mr7383219b6e.53.1774966443597;
        Tue, 31 Mar 2026 07:14:03 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41d048e1961sm7772428fac.2.2026.03.31.07.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 07:14:03 -0700 (PDT)
Date: Tue, 31 Mar 2026 09:14:02 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/6] object-file: avoid fd seekback by checking object
 size upfront
Message-ID: <acvV0_7DqGy_q9GY@denethor>
References: <20260331033835.2863514-1-jltobler@gmail.com>
 <20260331033835.2863514-5-jltobler@gmail.com>
 <act8W1BEg6iyUpHB@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <act8W1BEg6iyUpHB@pks.im>

On 26/03/31 09:48AM, Patrick Steinhardt wrote:
> On Mon, Mar 30, 2026 at 10:38:33PM -0500, Justin Tobler wrote:
> > In certain scenarios, Git handles writing blobs that exceed
> > "core.bigFilesThreshold" differently by streaming the object directly
> > into a packfile. When there is an active ODB transaction, these blobs
> > are streamed to the same packfile instead of using a separate packfile
> > for each. If "pack.packSizeLimit" is configured and streaming another
> > object causes the packfile to exceed the configured limit, the packfile
> > is truncated back to the previous object and the object write is
> > restarted in a new packfile.
> > 
> > This works fine, but requires the fd being read from to save a
> > checkpoint so it becomes possible to rewind the input source via seeking
> > back to a known offset at the beginning. In a subsequent commit, blob
> > streaming is converted to use `struct odb_write_stream` as a more
> > generic input source instead of an fd which doesn't provide a mechanism
> > for rewinding.
> > 
> > For this use case though, rewinding the fd is not strictly necessary
> > because the inflated size of the object is known and can be used to
> > approximate whether writing the object would cause the packfile to
> > exceed the configured limit prior to writing anything. These blobs
> > written to the packfile are never deltafied thus the size difference
> 
> s/deltafied/deltified/

Will fix.


> > diff --git a/object-file.c b/object-file.c
> > index 493173eaf4..1de2244ac5 100644
> > --- a/object-file.c
> > +++ b/object-file.c
> > @@ -1473,15 +1461,10 @@ static int stream_blob_to_pack(struct transaction_packfile *state,
> >  			if ((size_t)read_result != rsize)
> >  				die("failed to read %u bytes from '%s'",
> >  				    (unsigned)rsize, path);
> > -			offset += rsize;
> > -			if (*already_hashed_to < offset) {
> > -				size_t hsize = offset - *already_hashed_to;
> > -				if (rsize < hsize)
> > -					hsize = rsize;
> > -				if (hsize)
> > -					git_hash_update(ctx, ibuf, hsize);
> > -				*already_hashed_to = offset;
> > -			}
> > +
> > +			if (rsize)
> > +				git_hash_update(ctx, ibuf, rsize);
> 
> Is this guard really needed? I wouldn't expect that we ever try to read
> zero bytes into `ibuf`, and we bail in case we didn't receive the
> expected number of bytes.
> 
> And even if we did, `git_hash_update()` works just fine with no data.

Ya you are right, this guard is not needed. Will remove in the next
version.


> >  	header_len = format_object_header((char *)obuf, sizeof(obuf),
> >  					  OBJ_BLOB, size);
> >  	transaction->base.source->odb->repo->hash_algo->init_fn(&ctx);
> >  	git_hash_update(&ctx, obuf, header_len);
> >  
> > +	/*
> > +	 * If writing another object to the packfile could result in it
> > +	 * exceeding the configured size limit, flush the current packfile
> > +	 * transaction.
> > +	 */
> 
> Do we want to document that this intentionally works on the inflated
> size, not the deflated one, with the arguments mentioned in the commit
> message?

Good suggestion. Will update.

Thanks,
-Justin
