Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670821A0B15
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 15:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722352140; cv=none; b=Ch53NMi4SXuQAu3BnFTz5uPPXIUGZhjp1tVKYsmyTp2PBZQDAGoiXCAJomFbj2gslWLGpW3VZZS297S2qd2565rMeDJYBj00Ic0TU4vuRQWP7uX9ti9m3pQv8n7+PwTXH5tp0d6SViIPA4LmVVDXPF/XRz1p2urEZaqauaNYi18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722352140; c=relaxed/simple;
	bh=1nSoeHd0HrXQtatmr6fSwANJhvdhjCnN4Q4e6Q8JOcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzQ7z6fMTean5jCG5EdCDbamQX7NTdx9iBXwxxEHmoZLI0HWcESuYaF41FEnLpEcYrPWEFoRq8upfRv5GFilw4ZiCIbqrGVNQOeJM+t4t6AGwSaYJECm2Kbkwu5gEcotjYqua2j/wjtyEXhl5HI6jl4Og3I5G8CACHbmUIeoLBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyoCbuD7; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyoCbuD7"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fd9e6189d5so33560215ad.3
        for <git@vger.kernel.org>; Tue, 30 Jul 2024 08:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722352139; x=1722956939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IN8PtwDlhlgDzDJwJGKQCYMOBWFZl5S5yIQiiMw45bk=;
        b=DyoCbuD7AKmuGhWaOlPZrMIMllJCuryivYwDBRrPBnQ/yWt9rRTqCwQvghov5zPdI8
         Q4got+UDrRwIDvT8IYuJWRH5TGpFr776nqZpzzsjqNQ9A2dhXwd15Nc8o+b40dHn8NvS
         UiuiXiF8Z/TqwzLRqLQ/N7q7LiNE7QaPBedk5hoUz+PC5Jrc2BBAv0BtcLDdOZPR+lfp
         MKHSFRcammUjxCeZ0+yL30M0YovCFjbXI2ZfghgM6m8ztAoBRGNeUm5wfKQLaVFVKNoC
         +ZHX+sqqKTfNR1SRUK0vO3mtdCo+5vMNFYOsbbZbz8+vVazrEhC/QOUnh8gbgrrRAesQ
         wiPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722352139; x=1722956939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IN8PtwDlhlgDzDJwJGKQCYMOBWFZl5S5yIQiiMw45bk=;
        b=fXAEMYS2uJpQdsUoqlMEChfP4b0S7YzKhYbb65jogP9GGLVcpp05res9xhmXo4UF+U
         WN5RHYzaXTviS4vYT0WSjpMGBTcPWk4bdmHqe5KB9F48l72oMBsjR7inY3ujBFl/Lf2l
         MfBaTopquU1anT8gYCqAi3Yn3xvNmIMhrvLoit03kzdSnU5DJ/nUeUHEtA+NIom1zSLR
         ReHGAB7mg11wkgO128krZSM22c35rdd/y3qUDyQei5VHZQTm9+3N520WbzTq7NQxrDsR
         8K2YIewonHjEmr4rjiRR3sBCTVLlxh+DwPh0yM+RkT22Cwqt13/i8/OzUUv2GO5e7DbH
         HTUQ==
X-Gm-Message-State: AOJu0YzWQAiJd8aM5Ls1WUO7aglHobyNIaofbr5FNnutC/zbjz/7Gnyu
	x2DFNftPKKysXbso6y5008cjfpG2vuDh08HN8n2kxkL3IEnbw1QQ
X-Google-Smtp-Source: AGHT+IFvWUtivJf09J/tmzRNHnh8VDhsfmcMd0RNhEGrPAIJGSJcaw6lUG40ab8ldYmuqtAUPvn7Bw==
X-Received: by 2002:a17:903:228b:b0:1fc:f65:cd8a with SMTP id d9443c01a7336-1ff04810fe7mr105933095ad.18.1722352138551;
        Tue, 30 Jul 2024 08:08:58 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee3f74sm102952345ad.142.2024.07.30.08.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 08:08:58 -0700 (PDT)
Date: Tue, 30 Jul 2024 23:09:19 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v13 04/10] fsck: add refs-related error report
 function
Message-ID: <ZqkCH8BEE1mX9zfP@ArchLinux>
References: <ZqeXrPROpEg_pRS2@ArchLinux>
 <ZqeYm2J1LeXn_1-4@ArchLinux>
 <Zqik3kQivsfetIQj@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zqik3kQivsfetIQj@tanuki>

On Tue, Jul 30, 2024 at 10:31:26AM +0200, Patrick Steinhardt wrote:
> On Mon, Jul 29, 2024 at 09:26:51PM +0800, shejialuo wrote:
> > Add refs-related options to the "fsck_options", create refs-specific
> > "error_func" callback "fsck_refs_error_function".
> 
> We should have an explanation _why_ we are adding these functions in the
> commit message.
> 

Yes, I will improve this in the next version.

> > "fsck_refs_error_function" will use the "oid" parameter. When the caller
> > passes the oid, it will use "oid_to_hex" to get the corresponding hex
> > value to report to the caller.
> > 
> > Last, add "FSCK_REFS_OPTIONS_DEFAULT" and "FSCK_REFS_OPTIONS_STRICT"
> > macros to create refs options easily.
> 
> It is a bit unclear to me what you mean with "create refs options
> easily". Do you mean to say that `git refs check` (or whatever this will
> be called) will have flags like "--strict"?
> 

Yes, when the user passes `--strict`, all the warn type will be seen as
the error type. So I create "FSCK_REFS_OPTIONS_STRICT". However, I
didn't think too much here. I just followed the way the codebase does
for the objects.

> > Mentored-by: Patrick Steinhardt <ps@pks.im>
> > Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> > Signed-off-by: shejialuo <shejialuo@gmail.com>
> > ---
> >  fsck.c | 25 +++++++++++++++++++++++++
> >  fsck.h | 14 ++++++++++++++
> >  2 files changed, 39 insertions(+)
> > 
> > diff --git a/fsck.c b/fsck.c
> > index af61fa90ba..56de29b4c0 100644
> > --- a/fsck.c
> > +++ b/fsck.c
> > @@ -1251,6 +1251,31 @@ int fsck_objects_error_function(struct fsck_options *o,
> >  	return 1;
> >  }
> >  
> > +int fsck_refs_error_function(struct fsck_options *options,
> > +			     const struct object_id *oid,
> > +			     enum object_type object_type UNUSED,
> > +			     const struct fsck_refs_info *refs_info,
> > +			     enum fsck_msg_type msg_type,
> > +			     enum fsck_msg_id msg_id UNUSED,
> > +			     const char *message)
> > +{
> > +	struct strbuf sb = STRBUF_INIT;
> > +	int ret = 0;
> > +
> > +	strbuf_addstr(&sb, refs_info->path);
> > +
> > +	if (oid)
> > +		strbuf_addf(&sb, " -> (%s)", oid_to_hex(oid));
> 
> Okay, so we do end up printing the object ID indeed. But wouldn't we
> want to potentially do the same with symbolic refs?
> 
> Also, would it make more sense to put the `oid` (and potentially the
> `referent` when we also handle symbolic refs) into `struct
> fsck_refs_info`? Like this, the whole state would be self-contained in
> that structure, which would also make my proposal from a preceding
> commit more feasible where the subsystem-specific error functions only
> get a void pointer to this structure. It would require another
> refactoring on top to move the object type and OID into a `struct
> fsck_objects_info`, too, but that shouldn't be too involved, I guess.
> 

Yes, I totally agree here. I didn't consider symrefs here, actually we
should provide "symref -> referent" message if we have providen the
"regular ref -> oid" message.

I think we should do this. And I have commented on "[Patch v13][2/10]",
it is a necessity we should refactor this part.

> Patrick
