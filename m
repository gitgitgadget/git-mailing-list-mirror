Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE3018BB83
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 08:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728290679; cv=none; b=TECSThB1szBTxeYFj+jsA93yTJ3Nh/DWMVUAimquilF9GJkd02tPicgsjnhkH+YDJtSi4xwGrOx0tLTJb/67PCUVG6/7Jpy4hS4/qyWOGBqr7G5EBVyqEw1SPfaiwlwNDIvgSRZqrK5D7uELVMUXLLKQWf/KR/GvKpfpdisGCYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728290679; c=relaxed/simple;
	bh=8M7tInR2y7ycoRzvalLI1DtJ7ZQJIzREQGOU2jo7rbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESMSj6vobtyJ51vicYehpITVtKA8gjVfraUqwKcRFaljwi2Wwvo9JfA9mCLdTu94rCs+RoYC4M37MKTuh//r6KhcxqXbY5o4oA4EijWp/9VUoickAM9p7fjzg0XlziA9h/iCCh8I1OsiK2tDjPlsmMLkh+kMESt4qsVOLJQw6ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSHXou+P; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSHXou+P"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e0b0142bbfso3646959a91.1
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 01:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728290678; x=1728895478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5vc+Wxnc7YjdeS/rT3Mo/Gz380E88DjCVzva9GyH/lI=;
        b=fSHXou+PQWzNUqPr7KVD7C5Gc8MyNVAH6sdw1N5ynnm1ASmaKufjm/n/UGHvlPVfmW
         10S9Go+fdPkTWb87eJ61mHVeCSjNjaWR8Cb7NmxtK19j+fDAKmQA/di7XXtFP1WZBSi2
         J45XFJV6KNV57Hth/vtajXfRfQEDKbS++Nu3pApSS0RC41dUFuSOE0v8PRlvZKwcQl5/
         F//fz16C3laqTpSBNrLCBvCDPTOqrNZeoRiS2IOWG8ga+b27VmhShTp1CdFmUypdEu26
         FCuDqagdztaYdi176q0aHa5ySs0lUGK3t8bD+cJrV1kJgO/1DrVnqFEbVl50TFnf80Np
         g3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728290678; x=1728895478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5vc+Wxnc7YjdeS/rT3Mo/Gz380E88DjCVzva9GyH/lI=;
        b=vP+rskmojFKA5z/QN4tGcwKfTuOjnSD6WvbDWmYgWtbwzMf1lZQQbXPOEv08t/q925
         9GQqM+dsf8Kv47rXlpToAgARJ1n3I8EiUAanKpFr4k6W4mm27XR1tQgp6Vgwyaih/po6
         RJLT/6WMMO+v/8s0tJRwtp8eNzW77gXasn9Jeiqw8R14EpgsHm8EbppeuIYue4zPxOKQ
         e82ZgUP06sWKHCjexe54et/JRaQ9BOWxAmoCf8SYFc5fYcsXJb3NVxTXoJeSoV2faA2z
         zWZZGxvm8cbiBerNjk57IrRu3nfFcdMESH9/04oag2XpGU9SSPj5UXZpawNyYKR40fPW
         hpQQ==
X-Gm-Message-State: AOJu0YwT81e7G4jrEct7Qt0JhkrAnmAmGppcntVVsoGKyjhxIv71jDfV
	VwVnuofANcnTaMN4ZXsVkEXh2hADeNJtvM99SHabHV6A0HUBt9pP
X-Google-Smtp-Source: AGHT+IFueFTQhE7PRDEiKA9kVVcf56EKRtM4anRJZRXps4y0mNEEF17R83WcqPbAhPZVLaeSzpYAbQ==
X-Received: by 2002:a17:90a:3ea5:b0:2da:88b3:cff8 with SMTP id 98e67ed59e1d1-2e1e5b49169mr16996573a91.6.1728290677579;
        Mon, 07 Oct 2024 01:44:37 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e85d959dsm6476540a91.26.2024.10.07.01.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 01:44:37 -0700 (PDT)
Date: Mon, 7 Oct 2024 16:44:44 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 6/9] ref: add escape check for the referent of symref
Message-ID: <ZwOffN9UWX1gP0gy@ArchLinux>
References: <Zvj-DgHqtC30KjJe@ArchLinux>
 <Zvj-xaa_j26Auig7@ArchLinux>
 <ZwOGr4Tv8K_wemtD@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwOGr4Tv8K_wemtD@pks.im>

On Mon, Oct 07, 2024 at 08:58:55AM +0200, Patrick Steinhardt wrote:
> On Sun, Sep 29, 2024 at 03:16:21PM +0800, shejialuo wrote:
> > Ideally, we want to the users use "git symbolic-ref" to create symrefs
> > instead of writing raw contents into the filesystem. However, "git
> > symbolic-ref" is strict with the refname but not strict with the
> > referent. For example, we can make the "referent" located at the
> > "$(gitdir)/logs/aaa" and manually write the content into this where we
> > can still successfully parse this symref by using "git rev-parse".
> > 
> >   $ git init repo && cd repo && git commit --allow-empty -mx
> >   $ git symbolic-ref refs/heads/test logs/aaa
> >   $ echo $(git rev-parse HEAD) > .git/logs/aaa
> >   $ git rev-parse test
> 
> Oh, curious. This should definitely be tightened in git-symbolic-ref(1)
> itself. The target should either be a root ref or something starting
> with "refs/". Anyway, that is of course outside of the scope of this
> patch series.
> 

I am curious here too when I did experiments when writing the code.
Because Junio have told me this could happen, so I dive into this.
However, it's not reasonable. If we want to tighten the rule, we need to
also let "git symbolic-ref" to align with the behavior. That's another
question though.

[snip]

> > diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
> > index e0e4519334..223974057d 100644
> > --- a/Documentation/fsck-msgids.txt
> > +++ b/Documentation/fsck-msgids.txt
> > @@ -52,6 +52,14 @@
> >  `emptyName`::
> >  	(WARN) A path contains an empty name.
> >  
> > +`escapeReferent`::
> > +	(INFO) The referent of a symref is outside the "ref" directory.
> 
> Proposal: 'The referent of a symbolic reference points neither to a root
> reference nor to a reference starting with "refs/".'
> 

That's much better.

> I'd also rename this to e.g. "symrefTargetIsNotAReference" or something
> like that, because it's not really about whether or not the referent is
> "escaping". It's a bit of a mouthful, but I don't really have a better
> name. So feel free to pick something different that describes the error
> better.
> 

I guess "symrefTargetIsNotAReference" is a little too long. If we decide
to convert it to error later. Why not just put it into the "badReferent"
fsck message?

So, I do not think we need to rename. As I have talked about, we don't
need to map error case to fsck message id one by one.

> > diff --git a/refs/files-backend.c b/refs/files-backend.c
> > index 57ac466b64..bd215c8d08 100644
> > --- a/refs/files-backend.c
> > +++ b/refs/files-backend.c
> > @@ -3520,6 +3520,13 @@ static int files_fsck_symref_target(struct fsck_options *o,
> >  	orig_last_byte = referent->buf[orig_len - 1];
> >  	strbuf_rtrim(referent);
> >  
> > +	if (!starts_with(referent->buf, "refs/")) {
> > +		ret = fsck_report_ref(o, report,
> > +				      FSCK_MSG_ESCAPE_REFERENT,
> > +				      "referent '%s' is outside of refs/",
> > +				      referent->buf);
> > +	}
> > +
> >  	if (check_refname_format(referent->buf, 0)) {
> >  		ret = fsck_report_ref(o, report,
> >  				      FSCK_MSG_BAD_REFERENT,
> 
> This check is invalid, because referents can also point to root refs. So
> you should probably also add a call to `is_root_ref()` here.
> 

Thanks, I omit this situation here.

> We also have `is_pseudo_ref()`, and one might be tempted to also allow
> that. But pseudo refs aren't proper refs, so I'd argue that a symref
> pointing to a pseudo ref is invalid, too.
> 

I agree.

> Patrick

Thanks,
Jialuo
