Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C3B26869C
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 14:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741877713; cv=none; b=MM3dkhaqvrQHx6Vbuarckjci+RAdX99Iex0awPgDw/pUq6nUA4PHhhdfHscqltM1gWUrageYievULBYB4LmzIzXPh9zw/21MI/nj066oOt4/jAgB3n5b5Nknyf0zmj+84If+IqR37H2j++VUvHeI/bnXWDTAj6IE0IEB+YeG/2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741877713; c=relaxed/simple;
	bh=/erXnwYXK6wXVqnla8dqIFfKJvEzVcJsnE/MArgXeCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e42v1rKxRd5m794XTOmzA85SlGojRBqvz1w9xuaTYlGkc/es7cx6t7IVFyUyqOudHh2jd265KlN5oeD25DjNNxBas4juNQJDA+fXnIDLks9ZUCRt7FZN+WZWQ2lDJKRrXi9Z2T6qzNjTDY+RajKwiRwhdR/HE0FiWbsmyEcFmD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdrxMOE4; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdrxMOE4"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-72726025fa5so272823a34.0
        for <git@vger.kernel.org>; Thu, 13 Mar 2025 07:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741877711; x=1742482511; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ObUjYvkvE9Ofa/NUQlmQSLk70YGSU0BB/sQhYd2LSZE=;
        b=UdrxMOE4R8DN99rXSY+ugWH1qKVp3SyNBk9c90Muqn/m+fdMhY9yxe7uxWfdVSBNDP
         JLerjOV5jv/QMLJcxO4+aAvQqA1LETCYFgM1hJjjnkyFHN0Etk1fBGglMKsA7O6bQb8W
         HAJCHZH0bOdeK6MJ+0H2OVlcRbQDaWYr1Hlfat5TolyIs4ylR/+N7PXIzbBBNXL9Kc0H
         3crIZGkbsdM1liGHC/0sviVu+/eXd9TL3Mar0dVzdLkl7QI6DnekpcFDgv04kefgjCE4
         H5DvOOKg8Q3FIsRIoNpBZ/yUruYGKFRDMoUKW/W8Eb8U+RHfksi6Rd+mxx2TFO46+CV6
         vjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741877711; x=1742482511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ObUjYvkvE9Ofa/NUQlmQSLk70YGSU0BB/sQhYd2LSZE=;
        b=FwDzTRchX+f3Lx27HTweuRHwPs2ePRwiAK7G7RNes711cZDAD2/dudqy7fwKf4M5QC
         c6ge0NJatTfiqXiTTdaApvg0smNwpzgVbMKLRD9pktQN7zeIo1Ehe6Jdlw1KpqTzYMRb
         rOj3PsdOjMyYRgsvinh4LsNBt+qcHnVyGeNMrt25YJWwMXdwb8zjGSc8SfXAbGeZ8ZPP
         EcHISn0S4pMpQJlGgoIbLt0sRlNV67IWBc0lL06Gfy9i0e/aSvDUmJKJ7vjOAv45/pZ8
         2OLijGo6qOZ6YRax6VABXIqe9TmYvVkdW1Hxxfv3N7oiM2qf9CfUgzpMLjRwyP3lCqTe
         +h4Q==
X-Gm-Message-State: AOJu0YyyBHrlQ+KUiRso5zB8OrSGvgEI3Tgehw8hJ2it1WDuC4jN0Ta5
	VBDLUlw0+/pwNhHiKDBjU9gQ/ajmS+VAtm9a/2FLGZQcMG7HiVil
X-Gm-Gg: ASbGncsBBoi0/C8SvGIC/5pOEPUCRYJ4aCdfHaAm7EiWLd7JhTA1HsqWFVNvcqi+Zna
	law4ZiEtuhCs2ftCOAGg0IhGpw32jKeOVIf4ZOHV5UT4xYD1L+TXSkRlJIODV1YsP2XRz408nCq
	rCJ8SMOrhPfJj3rjqTv2EI5Ptgv4qvIhN1AZ56+FooPTy3v5U2HDGY2jQ7ep6lozjh37Bu7Ma43
	ohMHoRTkfl/fWVL7LjcVRJ8gbf5vAqI8kUWoobNoNVb2nVt6HsR/9w94VYgVABKTZrIabDYvQoI
	mMKL/AGcieyvZU7oh4FteTCTne33S/GVuUl3Pg==
X-Google-Smtp-Source: AGHT+IEfxPpAmJ9Qhp/cu2ccvN/b/DPk5iKfKDrElsXqEKtBtfZjKc7xqUsPsVmg1a3NcWBuy305Xw==
X-Received: by 2002:a05:6808:1529:b0:3f8:3eeb:1192 with SMTP id 5614622812f47-3f83eeb1b7bmr9357764b6e.27.1741877710993;
        Thu, 13 Mar 2025 07:55:10 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-3fcd403b070sm253325b6e.10.2025.03.13.07.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 07:55:10 -0700 (PDT)
Date: Thu, 13 Mar 2025 09:51:41 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, christian.couder@gmail.com, peff@peff.net, 
	ben.knoble@gmail.com
Subject: Re: [PATCH v2 6/6] rev-list: support NUL-delimited --missing option
Message-ID: <kmfjcyib7ur2qcadzjfq2gjmi5rdpdehjtb3locsw4emmnbr54@qyrnghyf2jg6>
References: <20250310192829.661692-1-jltobler@gmail.com>
 <20250313001706.3390502-1-jltobler@gmail.com>
 <20250313001706.3390502-7-jltobler@gmail.com>
 <Z9LVzWX4-6KGV6S7@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9LVzWX4-6KGV6S7@pks.im>

On 25/03/13 01:55PM, Patrick Steinhardt wrote:
> On Wed, Mar 12, 2025 at 07:17:06PM -0500, Justin Tobler wrote:
> > diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
> > index d400d76cf2..145ded5c78 100644
> > --- a/Documentation/rev-list-options.adoc
> > +++ b/Documentation/rev-list-options.adoc
> > @@ -371,8 +371,8 @@ ifdef::git-rev-list[]
> >  <OID> NUL [<token>=<value> NUL]...
> >  -----------------------------------------------------------------------
> >  +
> > -Additional object metadata, such as object paths or boundary objects, is
> > -printed using the `<token>=<value>` form. Token values are printed as-is
> > +Additional object metadata, such as object paths or boundary/missing objects,
> > +is printed using the `<token>=<value>` form. Token values are printed as-is
> >  without any encoding/truncation. An OID entry never contains a '=' character
> >  and thus is used to signal the start of a new object record. Examples:
> >  +
> 
> Nit: I don't think we need to update this paragraph here as it is
> written as a non-exhaustive list anyway.

Ok, I'll omit this change and only keep the added example.

> > diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> > index 7c6d4b25b0..d7b4dd48ff 100644
> > --- a/builtin/rev-list.c
> > +++ b/builtin/rev-list.c
> > @@ -136,24 +136,39 @@ static void print_missing_object(struct missing_objects_map_entry *entry,
> >  {
> >  	struct strbuf sb = STRBUF_INIT;
> >  
> > +	if (line_term)
> > +		putchar('?');
> > +
> > +	printf("%s", oid_to_hex(&entry->entry.oid));
> > +
> > +	if (!line_term)
> > +		printf("%cmissing=yes", info_term);
> > +
> >  	if (!print_missing_info) {
> > -		printf("?%s\n", oid_to_hex(&entry->entry.oid));
> > +		putchar(line_term);
> >  		return;
> >  	}
> >  
> >  	if (entry->path && *entry->path) {
> >  		struct strbuf path = STRBUF_INIT;
> 
> Nit: the variable and its cleanup could be moved closer to where it's
> used.

Will do. Thanks

-Justin
