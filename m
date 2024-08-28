Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E99913D889
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 15:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859352; cv=none; b=c9Fg47OO3mL7bfQAUccv3QrPxsCEgQMAOJGIhFwJwcfzTmv6Cu2rKhzJN5L0hgJmnplNeXdC88f7kPao7W/q+NHUQYBPmxLpBACcXRNMLHB2GNLNiY8B9sTuWXKAVUDJvb/o/SiDgnf/qsMaqphGi1lV3S+dBpkWAVb+5G5jnKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859352; c=relaxed/simple;
	bh=Hf4Q1y6Kd12bbcAkUdXRGhQHi0BI8t470QBtZl1ryDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdHVSwmFMJo6cCoC/G1Qn78DIlnwFmWj/H1V3lPzvplOwrsRCAayOlsf59YfMGJ0Iow6sNuzw4wVr2G4l/9De6fgk8Zhp17pYV08LxdbPyFIT6obUwijOM52X96M4DO8DJYbvOhlR/98XWqMyGcaBAN4DNvglXewvQiPDtPaHbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7ZJ72tn; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7ZJ72tn"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-201e52ca0caso49113495ad.3
        for <git@vger.kernel.org>; Wed, 28 Aug 2024 08:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724859350; x=1725464150; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hIVvzrzANlA8ELG06qtdlbcj1YtgXDOxByrPWmdFjZk=;
        b=a7ZJ72tnhn1/3PK4M0CFRIehnNJPzz+lODoWnwvZwJcjj1nO8KsJ8GU9KShjAS/ZN1
         Q4Y98zR7wK2nQwjR3/gnL8loQu7b7hzwsZykBIJidzw3M0dMmWsDE2TzlkurmlY58AF3
         JetE3/7EgBd1mDa2o39dY8FA0ntSpBYpAVYWVQsouYtNWuTl+YXITvcbQDla/91UF20J
         wP9GfGoTuNkqnMUw0pFucr8/ifO2EtA+5rhHFaQoiI86sgroB8oOhWj75ukCoEIeCrOf
         95p4NPKh7VPmi2KNEWCcDpsRmvxcUlKzvP8bs4s/x1w7ib3HtiLRQmlB+rIOxv7D0EC4
         vXpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724859350; x=1725464150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIVvzrzANlA8ELG06qtdlbcj1YtgXDOxByrPWmdFjZk=;
        b=dc5DGbAgjzD0e1AEeofcLA3i3YdLg6Btq8GAFd7HFJGx66FfuZSdqBmGAoPNMm2j1W
         e4hEhhKlNxUVWG6eLy4Er/Bbo3dMN36NvYwv8TYBggVB/orVtvKVIB7I4qoFGJdqn27n
         aaAnD4Szc+E8NzBH6CYqIX4A1MIv+7ChOXYPWlFuKtt0lIdhDKWwVYOyWHPZG9YjXtYk
         fkl0hVqAgO2O2l62GiMU7p4HkZvmbvr3eFRgCCFsSKNSUkGmVEcR/gNnBjGUDqh2RZ2U
         +v+5J45pbNZ3sVGhfOO6WRLlemm8x++OqU7MLZyCAs/H+i6yZWDY0A9MNCDztCHfASDn
         0+Lg==
X-Gm-Message-State: AOJu0YxkGRTxxNcOFpORzxqjn7h7hDLSoSq7LM/fU0/BrhE+uegKK0dk
	Kwvf6unwoyb68VINvvs/OHcvC1btatrPP4ixQZAFlkQGgKO9YDnk
X-Google-Smtp-Source: AGHT+IH3I/6zDcJQICmE/4/u17UZXYlXIyEzoVICSr+h/XIqRnEWOQjGEoiRK3BnBm9TEJ6s9DTnCQ==
X-Received: by 2002:a17:902:ce92:b0:202:54b8:72d5 with SMTP id d9443c01a7336-2039e4fe39dmr190603975ad.59.1724859350096;
        Wed, 28 Aug 2024 08:35:50 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203859ef0fdsm100143585ad.248.2024.08.28.08.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 08:35:49 -0700 (PDT)
Date: Wed, 28 Aug 2024 23:36:41 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] ref: add symbolic ref content check for files
 backend
Message-ID: <Zs9ECY-EOyz3M6LQ@ArchLinux>
References: <Zs348uXMBdCuwF-2@ArchLinux>
 <Zs3558scHssaG_XS@ArchLinux>
 <Zs8dAc0ss9KbwIDs@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs8dAc0ss9KbwIDs@tanuki>

On Wed, Aug 28, 2024 at 02:50:09PM +0200, Patrick Steinhardt wrote:
> On Wed, Aug 28, 2024 at 12:08:07AM +0800, shejialuo wrote:
> > We have already introduced the checks for regular refs. There is no need
> > to check the consistency of the target which the symbolic ref points to.
> > Instead, we just check the content of the symbolic ref itself.
> > 
> > In order to check the content of the symbolic ref, create a function
> > "files_fsck_symref_target". It will first check whether the "pointee" is
> > under the "refs/" directory and then we will check the "pointee" itself.
> > 
> > There is no specification about the content of the symbolic ref.
> > Although we do write "ref: %s\n" to create a symbolic ref by using
> > "git-symbolic-ref(1)" command. However, this is not mandatory. We still
> > accept symbolic refs with null trailing garbage. Put it more specific,
> > the following are correct:
> > 
> > 1. "ref: refs/heads/master   "
> > 2. "ref: refs/heads/master   \n  \n"
> > 3. "ref: refs/heads/master\n\n"
> 
> Now that we're talking about tightening the rules for direct refs, I
> wonder whether we'd also want to apply the same rules to symrefs.
> Namely, when there is trailing whitespace we should generate an
> INFO-level message about that, too. This is mostly for the sake of
> consistency.
> 

Yes, actually this patch does this. I think I need to mention we reuse
the "FSCK_INFO" message id defined in the [PATCH v2 2/4].

> [snip]
> > diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
> > index fc074fc571..85fd058c81 100644
> > --- a/Documentation/fsck-msgids.txt
> > +++ b/Documentation/fsck-msgids.txt
> > @@ -28,6 +28,9 @@
> >  `badRefName`::
> >  	(ERROR) A ref has an invalid format.
> >  
> > +`badSymrefPointee`::
> > +	(ERROR) The pointee of a symref is bad.
> 
> I think we'd want to clarify what "bad" is supposed to mean. Like, is a
> missing symref pointee bad? If this is about the format of the pointee's
> name, we might want to call this "badSymrefPointeeName".
> 

I agree, bad is too general here, we need to make it concrete.

> Also, I think we don't typically call the value of a symbolic ref
> "pointee", but "target". Searching for "pointee" in our codebase only
> gives a single hit, and that one is not related to symbolic refs.
> 

Thanks, I will fix this in the next version.

> > +/*
> > + * Check the symref "pointee_name" and "pointee_path". The caller should
> > + * make sure that "pointee_path" is absolute. For symbolic ref, "pointee_name"
> > + * would be the content after "refs:".
> > + */
> > +static int files_fsck_symref_target(struct fsck_options *o,
> > +				    struct fsck_ref_report *report,
> > +				    const char *refname,
> > +				    struct strbuf *pointee_name,
> > +				    struct strbuf *pointee_path)
> > +{
> > +	const char *newline_pos = NULL;
> > +	const char *p = NULL;
> > +	struct stat st;
> > +	int ret = 0;
> > +
> > +	if (!skip_prefix(pointee_name->buf, "refs/", &p)) {
> > +
> > +		ret = fsck_report_ref(o, report,
> > +				      FSCK_MSG_BAD_SYMREF_POINTEE,
> > +				      "points to ref outside the refs directory");
> > +		goto out;
> > +	}
> > +
> > +	newline_pos = strrchr(p, '\n');
> > +	if (!newline_pos || *(newline_pos + 1)) {
> > +		ret = fsck_report_ref(o, report,
> > +				      FSCK_MSG_REF_MISSING_NEWLINE,
> > +				      "missing newline");
> > +	}
> 
> The second condition `*(newline_pos + 1)` checks whether there is any
> data after the newline, doesn't it? That indicates a different kind of
> error than "missing newline", namely that there is trailing garbage. I
> guess we'd want to report a separate info-level message for this.
> 
> Also, shouldn't we use `strchr` instead of `strrchr()`? Otherwise, we're
> only checking for trailing garbage after the _last_ newline, not after
> the first one.
> 

Yes, I totally made a mistake here. I will try to think about a new
design. I have already replied to Junio like the following:

> > And strrchr() to find the last LF is not sufficient for that
> > purpose.  We would never write "refs:  refs/head/master \n",
> > but the above code will find the LF, be satisified that the LF is
> > followed by NUL, without realizing that SP there is not something we
> > would have written!

> I totally ignored this situation, and in current patch, we cannot check
> this. I know why Patrick lets me use "strchr" but not "strrchr". I think
> we should find the last '\n'. But instead we need to find the first
> '\n'. However, in this example, we will still fail by using "strchr".
> This part should be totally re-designed.

> > +	if (check_refname_format(pointee_name->buf, 0)) {
> > +		/*
> > +		 * When containing null-garbage, "check_refname_format" will
> > +		 * fail, we should trim the "pointee" to check again.
> > +		 */
> > +		strbuf_rtrim(pointee_name);
> > +		if (!check_refname_format(pointee_name->buf, 0)) {
> > +			ret = fsck_report_ref(o, report,
> > +					      FSCK_MSG_TRAILING_REF_CONTENT,
> > +					      "trailing null-garbage");
> > +			goto out;
> > +		}
> 
> Ah, I didn't get at first that we're doing the check a second time here.
> As mentioned above, I think we should check for trailing garbage further
> up already and more explicitly.
> 

Well, I guess the implementation about this is totally wrong, which will
make the reviewers hard to understand. I will drop this way to
explicitly check the garbage.

Thanks,
Jialuo
