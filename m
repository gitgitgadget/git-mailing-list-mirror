Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6455BA20
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 15:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732289071; cv=none; b=bZRlpX7DXAbU2lOzGj7Zw2mj3PXSdVUpOsPsvfWpHrtByi2o2L7NceLEZ/UgqR2SlqIRGiG16KMSrVlaJQZa6kAGRxgXI2GxbIF5mDBLVoj2rT7fB5rjUVWaryNm/JKnxEaLWFj2MZ338Xc+Es46YfEgi/nYqlUdkBKIyeN/rYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732289071; c=relaxed/simple;
	bh=CdNQAWUuArK4gRRrIhQkrz7lOMWFMm70gCPELrooMwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mu2UQr1ZnkIUJYJTeHQa+xOY8NoIzJpt9TXaz0aIEMWnetkEnYgkIB1Q8jCctVHTnUcVfcksdN0DLKpPGu31Fh7nS8dcfl+xb+2lUtGEBFjMD+lIwRyh11fuM8+Uhpj4oBGMRAUTx9hkC5oiJbcYNigzPS7qSGXO0bmGcqDh5X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UzND5lfS; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzND5lfS"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-295cee3a962so1479161fac.3
        for <git@vger.kernel.org>; Fri, 22 Nov 2024 07:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732289069; x=1732893869; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5kHws8zaG1kv6RUWdfScOeTPLBjbDcF/qLuWDdbSsbY=;
        b=UzND5lfSR6I0Ex39Aat+DitOBymoiV02eBeaNRgVXamSAgTX5xP2TTAl+CPut+it1x
         Z7jMtvvJSx7t6eszobCPhseeb49bCSkVF9D6B/JLW9sqfs7gXF/pcMuWgoUdG5/3QncX
         JXa32yVecq3gBrIdvx75kdaKDUxHWe7NE6DG+l67zh/3zN9r3fy/QQw3Z7kCaIZlfIzh
         TSVQehU26vacQOlJZkgIdzCNVTKmqHFwyFJmYxYsi/346uyRXwFXUHlFVCWd8j31/Gqp
         Oe4J4xx8IhAqPTvn4Uoi1fR0VwqKTbmhG3DSNkq2Y+plWnMgxH5gujFq9jef1Non//rz
         p7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732289069; x=1732893869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kHws8zaG1kv6RUWdfScOeTPLBjbDcF/qLuWDdbSsbY=;
        b=Oc0QI68TqAG2gxFwtR09xsqdIYS9l5zarR9fS6p71dzuV160m3xvxRvLmJvgtWS4FX
         bnzW5lxRi8umlh5n8OqjRyyfimyyTlEAyLBQYGHhobSuHMHTcEwZg33NCt79V9mz3pNh
         5sTXdKeAr0MQ+Ne4682E7Npyd/w83f6c5amFICGGsSe/SGtGjVlFveeuRTEtkSPhAtrK
         wY3IsQhXZDpwifDR5yk6AwD8Zz9t5sYvb8PmbKd7bZ0xZWcqrFgz+w62b0mqc8Y7J4RC
         45WIvBSH61lnNgDafTh0IyMhw0TiKARFiYCiBlCQXpzDOkL+yDsJSZ/g79V+JrzpSBru
         K1fw==
X-Gm-Message-State: AOJu0YxwGZIW9jLwstDe2O8xr2TE3mtEnUfDBzxSCW8yL6CtJHifZ3k1
	nsPVrk+KaoscN4ydOytXTqUDq7pMOdf840zi5csLezufwF/YdBh4
X-Gm-Gg: ASbGncvG6LZLzzfE40ph1ipJnknO53SiXr0kwftQfO0Y8a+e+CwmQqJR5Z6tY3ZmtqE
	KC8QDuifRUNH7MAkM0CsdfFB7/2lwQxvPWSzOMjxNhfhPJWOID/v14OShUWUQAYmWyb0c2ocrcI
	kYGk2amP+Gz0xmUaV76P+XQpFm9JyepcXl0JNAXjuU12PaGRZYQjuPOX7JlSP+7HBlhcESjDbt/
	5Ozg9QaG2ow+Pa+mnd91HedezafQ3HN/qkiDxjhqt0=
X-Google-Smtp-Source: AGHT+IGu4J00IDio8RAgeFpl/0kcotz247Kb/nDQ6ZeS1HPR67xCcOdWwpwx6kbzjF5V5aO9mjiYGA==
X-Received: by 2002:a05:6870:d109:b0:295:eebe:ea1 with SMTP id 586e51a60fabf-29720adb9f5mr3220131fac.9.1732289068949;
        Fri, 22 Nov 2024 07:24:28 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2971d56e63bsm589097fac.10.2024.11.22.07.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 07:24:28 -0800 (PST)
Date: Fri, 22 Nov 2024 09:22:35 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/5] bundle: add bundle verification options type
Message-ID: <o22ukwk2b6pewcz4t4coplhu3nnygrlescyko6hj33ak2yynx2@zkq4oa3pnguw>
References: <20241121204119.1440773-1-jltobler@gmail.com>
 <20241121204119.1440773-2-jltobler@gmail.com>
 <xmqqy11ccbco.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy11ccbco.fsf@gitster.g>

On 24/11/22 10:21AM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > diff --git a/bundle-uri.c b/bundle-uri.c
> > index 0df66e2872..ed3afcaeb3 100644
> > --- a/bundle-uri.c
> > +++ b/bundle-uri.c
> > @@ -361,12 +361,16 @@ static int copy_uri_to_file(const char *filename, const char *uri)
> >  
> >  static int unbundle_from_file(struct repository *r, const char *file)
> >  {
> > -	int result = 0;
> > -	int bundle_fd;
> > +	struct verify_bundle_opts opts = {
> > +		.flags = VERIFY_BUNDLE_QUIET |
> > +			 (fetch_pack_fsck_objects() ? VERIFY_BUNDLE_FSCK : 0)
> > +	};
> >  	struct bundle_header header = BUNDLE_HEADER_INIT;
> > -	struct string_list_item *refname;
> >  	struct strbuf bundle_ref = STRBUF_INIT;
> > +	struct string_list_item *refname;
> >  	size_t bundle_prefix_len;
> > +	int result = 0;
> > +	int bundle_fd;
> 
> Unrelated changes to reorder the lines, without any justification
> worth describing in the proposed commit log message, distracts and
> discourages the reviewers from reading further on.  I would avoid
> making such changes if I were doing this patch.

Thanks for the feedback. I'll revert the unnecessary changes in the next
version and avoid doing this in the future.

> > -int unbundle(struct repository *r, struct bundle_header *header,
> > -	     int bundle_fd, struct strvec *extra_index_pack_args,
> > -	     enum verify_bundle_flags flags)
> > +int unbundle(struct repository *r, struct bundle_header *header, int bundle_fd,
> > +	     struct strvec *extra_index_pack_args,
> > +	     struct verify_bundle_opts *_opts)
> 
> Again, unrelated rewrapping of lines distracts and discourages the
> reviewers from reading further on.  It looked as if the patch is
> adding an extra parameter, until I read it again.
> 
> The real change here is that the enum is replaced with a struct that
> has the same enum as one of its members, which is good.
> 
> Name the external-facing one (like this new parameter) _without_
> funnies, and call it straight "opts".  The internal stand-in object
> you create below can use funny convention but using "_" as prefix is
> usually for system stuff (and the language standard forbids it, even
> though people often do so in practice, from programs).

Good to know, I saw this pattern used in the reftable library. I'll
update per your suggestion in the next version.

> >  {
> >  	struct child_process ip = CHILD_PROCESS_INIT;
> > +	struct verify_bundle_opts opts = { 0 };
> >  
> > -	if (verify_bundle(r, header, flags))
> > +	if (_opts)
> > +		opts = *_opts;
> > +
> > +	if (verify_bundle(r, header, opts.flags))
> >  		return -1;
> 
> This is an arrangement that looks strange, especially at this stage
> of the series without reading the rest.  If verify_bundle() takes
> the enum and not &opts, there is no need for stand-in opts struct.
> You can have a local enum "flags" that is initialized to 0 and only
> when parameter "opts" is not NULL, assign opts->flags to it and use
> it throughout the rest of the function.  Reviewers will be left
> confused wondering why the patch does this in an unnecessarily more
> complex way by using an extra structure instance.

Good point, at this point in the series its not obvious why the added
compexity is good or worth it. I'll defer making this change to the
following patch in the next version.

> 
> Until you start needing other fields of opts in the function,
> perhaps in a later step, that is.

Ya, this is its intent. Having a default options to fallback to is more
useful once there are other fields present.

-Justin
