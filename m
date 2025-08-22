Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189531A9FB9
	for <git@vger.kernel.org>; Fri, 22 Aug 2025 18:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755886061; cv=none; b=M8db6eotd9ZHUuNCnPns8dyQSfbId1vPqw40Xa1aMBWjPTSVz5XPdPNa5h5T/nJTuH08FGmS01IyV9rLX4U++SYzBL1uglFtBH85dGmcWvwkMbtLoWPCgeDbkKmviUHZ/sAsdZNPY8RVDyR2cr0noQxPhPMQ4sGm664Sdedc8nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755886061; c=relaxed/simple;
	bh=WN4fvRwLWh77NQdojMQnK2+i7Tr5c4NThoM6MVdsTBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWEovwd8OeOsndkQ83ookb5ZsfyfxY7yblqj0/LssmBuQtSqxQCzmojzwK8aqsZQ7oKr0m20VwlXrjB7BGnfnWWFGoc0KAKP/YtTrtr2o/1BffN0TIfP2sCv1Mjl/1p1YmwApUE6abt5bm32xiTtFNTUxMQ1+2QsZ8Eu8NSv3Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJDr5/Lg; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJDr5/Lg"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-74381fbc6e3so1126678a34.2
        for <git@vger.kernel.org>; Fri, 22 Aug 2025 11:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755886059; x=1756490859; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WeQSbl1ks+PowqQXL6INjN83eDK5RO4+/J0lBie1Ous=;
        b=eJDr5/LgDr6zxn5dKpFc0pGm5tUjZOGxEMWwIfogG1arZqxZoHEbSxw7a5C2euGvF/
         Mork81OpHLai/E5YHKgD1SZmpio94EF1aPk5vxn0TohXQo9gnpn9MekMiqtSFju0uOaL
         RP3GOATSzbV3aV1VvuBPEljvFNSkWSqzoe9qtyRCh4dWfjfNq4ODKNyCIz2dNHlWL+Ks
         NbKb9ijTg5ErXs3J+8W35iQ34DWhqKNhHOGSwApaxHnnYWYRmPaUaSMl36qhNupEZ7Pu
         jc+gWuA9NmVVWaGm15ns5L5KC8/U1emSztN5npbQ2zEqTstkzRUlt6SFCsVxLMlWQDUe
         ZFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755886059; x=1756490859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WeQSbl1ks+PowqQXL6INjN83eDK5RO4+/J0lBie1Ous=;
        b=VNbL+P+b6fXJXLwTIAanLVcACT1CgN1fohMaKH8Vp3Dmdhdlej+pWczZ+/p43i58X2
         ywMEeEjWTSTWcCSWT5aoxH0LcqtENsDdi/QMYBsLJSDC6vjyySOSOgITUCR7S7GrS1Ie
         W3JtvBE+Xgi+qrrbaEiOJBdxAbKFX6M1KlAPTbdAKkp1bSdUH0SlGXbLiIkTlaqAuDYs
         afdGahNXpXqS1HvAfDpUwqwVs1n6jtU4MJva+/scbsOf417OQRPsA2gwmbaDReIfnxge
         dSofCIWN8jCZlLT43IO5m06gY5X4VgLv4eREdCWK0e312iGuL6w7lgja7oTB90lTzzXf
         LwCg==
X-Gm-Message-State: AOJu0YzoyVdAzf73yHh72wBayEpCxCV0lGfogJhKaPJUqAtJ9fGuY9AG
	+7oZ/pghKUUoHG5oHm2cC0VBo3rbyahxcOKKlj8eaAUUdSlVvF270z+V
X-Gm-Gg: ASbGnctQwn47FdS835ZnsIDCc8T4ZMaDacOrcLMmAW5RFwr2RUyBjAAcmqkY5pREMlR
	XwbwUGO5vKAl/I+LNNFRW2638sqJuMSyfJi9J52TzjoKm5nfiH93aW37bOvAHvhDshYeYjo2gA9
	E23xVOoqtJm8FyDlmghFjXDKv3y77wohWShe9q3xJLhqQLZWE688qJ2SM2WvzVlsMjDuOSwPW5B
	TYKcRUgbtwjho5HLGnIq5mIcySiknwL/FkR/5PeGHY18rTSSSnSUCC8Doa8m+H1Ga2xV7ZefO4A
	4Lg4BAPGL1IDb/6r4LGnX8Mlhkc5XR329H/dCjrkBeIUXztFL9IuBnOe4ltVHWnzRA8WR3XQBhd
	e4Z9oYx5gg06sh6NU
X-Google-Smtp-Source: AGHT+IFx8d3RiJnzVOPY55KmkGO+4skDERH1z3FwlwlokX7ZUtkcEVHP2Vh0UlULPH25aO39iR/z6A==
X-Received: by 2002:a05:6830:6187:b0:73a:96e5:19cd with SMTP id 46e09a7af769-7450095b688mr2250663a34.10.1755886059080;
        Fri, 22 Aug 2025 11:07:39 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-314f79bbcfdsm72275fac.7.2025.08.22.11.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 11:07:38 -0700 (PDT)
Date: Fri, 22 Aug 2025 13:07:37 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH v2 2/4] bulk-checkin: remove global transaction state
Message-ID: <njvcqkkcotesqznalieuwhzow7lxbejxlfw3knbhalmqjcb7cs@3vwea4r2zljl>
References: <20250820225531.1212935-1-jltobler@gmail.com>
 <20250821232249.319427-1-jltobler@gmail.com>
 <20250821232249.319427-3-jltobler@gmail.com>
 <xmqqv7mfxqg2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv7mfxqg2.fsf@gitster.g>

On 25/08/22 09:37AM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:

> We now need to be a lot more careful to make sure that everybody has
> access to a valid bulk_checkin_packfile struct, which makes the
> implementation of index_blob_bulk_checkin() a bit awkward and we
> need to invent one bulk_checkin_packfile instance right there.
> Luckily it goes away in the next step, I guess?

Ya, now that we cannot rely on the transaction singleton to provide a
bulk_checkin_packfile, we have create one if there is no transaction. I
completely agree that this is awkward which is why the next step
requires index_blob_bulk_checkin() callers to ensure a transaction is
created ahead of time.

If it is preferable, I can combine these two patches together. I kept
them separate as I thought it would better explain the steps, but maybe
that isn't the best way to structure the patch as we are largely undoing
the change in the next patch anyway.

> > diff --git a/odb.h b/odb.h
> > index 3dfc66d75a3..a89b2143909 100644
> > --- a/odb.h
> > +++ b/odb.h
> > @@ -84,6 +84,7 @@ struct odb_source {
> >  
> >  struct packed_git;
> >  struct cached_object_entry;
> > +struct odb_transaction;
> >  
> >  /*
> >   * The object database encapsulates access to objects in a repository. It
> > @@ -94,6 +95,13 @@ struct object_database {
> >  	/* Repository that owns this database. */
> >  	struct repository *repo;
> >  
> > +	/*
> > +	 * State of current current object database transaction. Only one
> > +	 * transaction may be pending at a time. Is NULL when no transaction is
> > +	 * configured.
> > +	 */
> > +	struct odb_transaction *transaction;
> 
> Once dust from this topic settles, we may want to rename the
> bulk-checkin.[ch] to have "odb" somewhere in its name, perhaps?  I
> usually do not like renaming file for the sake of renaming to make
> the result look "pretty" (people may use "consistent naming" ),
> though.  I dunno.

I'm hoping for an eventual state where the transactional interfaces,
{begin,end}_odb_transaction(), are moved directly into odb.{h,c}. The
current implementation of transaction handling is specific to the
current object database source. In a pluggable object database future
where we could have different types of object database sources,
transaction handling will likely have to implemented separately.

With this in mind, we could move the current transaction implementation
into something like object-files.c. This is already where the vast
majority of its call sites are and would enable us to further simply the
interface we expose.

I plan do submit a followup series to do this. :)

-Justin
