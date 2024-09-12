Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4340628F5
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 03:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726113544; cv=none; b=BH0HxYB9AD0fHJ4I7RvJWNUXbyClZooMZ/NxH3lZmDNG0HQrCON/Rm4zEPDONiJuiy472huCRM/pFu7boXBhLFPft4WFacT5wzc/QQBBVBYpL8jLUXZb9etUYBFi7qItkQP599iiQJ8yEPTZAWvPrsus9A4rtDFT6ql0PBh8zEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726113544; c=relaxed/simple;
	bh=WN1/6/izPYZMmVqdo4lfTk/3/3sURlDfKyfOew3y4xE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CkR2Akssl7ARdCwhMICFv2b4TIQMLbkDxkSKfHGlE+8UD6oAafAk0aFuZ8/zl5T8FcLAJgz391+EBP8TZc1zUVUefBFd182MVIKUGfuXm/aSXzMuumWkO31TvbLltiiNbhhRdRLSLfZcy07uNZ8wvIsNwMrDBG/lwn+kS6yDQOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xjjm5TWP; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xjjm5TWP"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20551e2f1f8so5314475ad.2
        for <git@vger.kernel.org>; Wed, 11 Sep 2024 20:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726113542; x=1726718342; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5WS7l3B6jiLff3GgUG3lCTF9vL1XSySnjeTMDwnQHcA=;
        b=Xjjm5TWPaCnStwmcxUaAnRXoCO3Y2mnAoufUTUJQatROTDUsqbZfZazDmaVDtlum8i
         sO6gZqk88aXOudLQC1PMAg+65I3yG9iPRciLCiCQViF3v8WdH4Vkq3dRkDVxuHubuX6J
         LplLnhfdZjsoYAEeOYhs0rCZpD2shbOp5c5FD8qDGQ2XHi8VFNQSUcoVywZSYwzYK54A
         Hvg/zLBO1v8RLv9LKPajw1UmZXmxmnoTxiiY6s5V64JC9VC+jNRmnJl5SLmnn6HR7efx
         f+SQ1nZ1Uhw8z8jUYV4pN24muNgGHE9DTED02PYp74kYtigqU+QTLtysHZLi5TWuzXM2
         4kWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726113542; x=1726718342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WS7l3B6jiLff3GgUG3lCTF9vL1XSySnjeTMDwnQHcA=;
        b=luRPeiKlK79nG1iXOUND5oTOsOpkSFpOtVCZeo5XTr3/BazB+rxPocrQwobKa+Ncvo
         bY8rgrOrpW1xel6V5bUSQAMInZ7CVsRsVVyCB+IgBaVhbIfpMXxINgmPzKXiLMz1jSAh
         bwtaBXJ+ee/4oX3dwtEdkAOC7t+1xoOnP3zcha5XKSBc/DZNxXSsexp9qKjV+qJB00Pg
         YnRsQBafrLLKTSEpIYFVO6kqtUh8FiWyH3qlDp9jXV2LRr/psqTXvXxoOmERAGLfLgyE
         tL/yEAdq9AGJuG5dR47lK05sqeAhwqwaR86X4yBcQVQ1qlxGKW/9lJMklfLgCZJ03z3L
         +z5Q==
X-Gm-Message-State: AOJu0Yx6RwamGjBOyQfIBJWF4rzLlf6wmmbVDOxV4B/r6DWLsJbWJyA8
	NYGe7HdnPG/raYpqmocFIN+75pxbicE48dBftZaN5y6eITxrennP
X-Google-Smtp-Source: AGHT+IGnqmL4cK1mzdDr3Rwhc+OG/wQyCy1fr7OeTW58Gkube6PMna1KL+NjlVull8VftIIwngYafw==
X-Received: by 2002:a17:902:ea02:b0:205:5582:d650 with SMTP id d9443c01a7336-2076e44b8bemr20900305ad.52.1726113542351;
        Wed, 11 Sep 2024 20:59:02 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076b01af3fsm6351395ad.301.2024.09.11.20.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 20:59:01 -0700 (PDT)
Date: Thu, 12 Sep 2024 12:00:08 +0800
From: shejialuo <shejialuo@gmail.com>
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/4] ref: add symref content check for files backend
Message-ID: <ZuJnSHXJw6AVzbxL@ArchLinux>
References: <Ztb-mgl50cwGVO8A@ArchLinux>
 <Ztb_JuMjaoAbIZXq@ArchLinux>
 <CAOLa=ZS2TsRAeAHJ6B9h82-H2tSG-vZMRBSpspQ3hOW5GBdciw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZS2TsRAeAHJ6B9h82-H2tSG-vZMRBSpspQ3hOW5GBdciw@mail.gmail.com>

On Tue, Sep 10, 2024 at 03:19:49PM -0700, karthik nayak wrote:

[snip]

> > +	if (referent->buf[referent->len - 1] != '\n') {
> > +		ret = fsck_report_ref(o, report,
> > +				      FSCK_MSG_REF_MISSING_NEWLINE,
> > +				      "missing newline");
> > +		len++;
> > +	}
> > +
> > +	strbuf_rtrim(referent);
> > +	if (check_refname_format(referent->buf, 0)) {
> > +		ret = fsck_report_ref(o, report,
> > +				      FSCK_MSG_BAD_SYMREF_TARGET,
> > +				      "points to refname with invalid format");
> > +		goto out;
> > +	}
> > +
> > +	if (len != referent->len) {
> 
> Would this work with a symref containing:
> 
>     ref: refs/heads/feature\ngarbage\n
> 
> Since we check last character and rtrim, wouldn't this bypass our
> checks? Isn't it better to find the first `\n` and check if the index <
> referent->len?
> 

We will check the above example by "check_refname_format". It will
report the following message:

  error: ... : badSymrefTarget: points to refname with invalid format

From the context, I guess you suggest that we should report there is a
trailing garbage in the ref. However, for the above situation, we should
report an error which is align with the behavior of the "git-fsck(1)".

So there is no need to check whether there is a trailing garbage when we
encounter an error.

And we cannot use this way, for example:

  ref: refs/heads/feature   \n

If we find the first '\n' index. In this example, index will be equal to
"referent->len". And we totally ignore this case.

> > +		ret = fsck_report_ref(o, report,
> > +				      FSCK_MSG_TRAILING_REF_CONTENT,
> > +				      "trailing garbage in ref");
> > +	}
> > +
> > +	/*
> > +	 * Missing target should not be treated as any error worthy event and
> > +	 * not even warn. It is a common case that a symbolic ref points to a
> > +	 * ref that does not exist yet. If the target ref does not exist, just
> > +	 * skip the check for the file type.
> > +	 */
> 
> I think the common terminology for this is 'dangling symref'. Perhaps we
> could shorten this to simply say:
> 
>     Dangling symrefs are common and so we don't report them.
> 

Thanks, I will improve this in the next version.
