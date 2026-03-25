Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67533A7F62
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 18:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774461787; cv=none; b=e0FFfGIcM46KnADKWR+hhizDnq/pc+5PDTu3BWVIaWtPJZE44BmbzMTmLlDUl3UDckln4V3dta/yLdLpf+0O1cmt2PYzj0fk66FBePiudVv0pzoHQQw1RYCBM7h/UCqTLRgToyOOAUbkXgcxhLedEFS8ClUXh3NxvGhRO3REPhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774461787; c=relaxed/simple;
	bh=/N7omk6FGAJr+0q5dGFUdc2KO3lVgb7YEYLgX9Ke+YA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ss+dG0RV9ncbLlRlxe3wfvLEuzPY+naoDZ+/evO3KTT7jfYZsenVLTVYzEraQ3UOvq+owVI7fmJjfTNnvvYJ3stjSQfiOH3i+DVOpvmSSxdMsXEVHAWQzcKDAwkesF41FhIDDsTHGrVpaabdfSgpFWMl2NdP9ZxeqIwdlhFI6fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ESYWqz0C; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESYWqz0C"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d743cd9e5bso49053a34.2
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 11:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774461784; x=1775066584; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3yeLCpmdd5+hIlRzExlJP37tOGWlnuwcLnThO4l4ZL0=;
        b=ESYWqz0C+cnjx3pony8otXbeMOiS/Gj1xZ3vpjKgNhd0s3HFGKtlgePjLlD92cU2jB
         f/1FnB//3N7rnzBds9+o2mPzoPuqFCF9yoWeL57iQKSX5pw/ozNV2r5sKnnSMYpKeKp2
         pSrX51rBbgBMU4zsvWwqUZDXcxReI/z/aiOJu0KoBjGbEyRfxvTDDRjpOnncAXVgYiBV
         FsuJQGTxt9uXiXDqHiA4j3EhhC0IyUsoxSbhBjqr4FBOIxv1LCpYm3uOKo6tP0GFnk6O
         VJOmMgKCVqIp30tFV5ttuo7DCHWXhdLiqAdz8MapVB3WmUEbugAXixoPiiJYufgi1Fd7
         m/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774461784; x=1775066584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3yeLCpmdd5+hIlRzExlJP37tOGWlnuwcLnThO4l4ZL0=;
        b=gCQNPFI8Eu2aO5QOOYodqR4M/0lAY+ZgKMEjLLFjjjSqZce8CKC7QEu4E/w3ai+0UD
         7YuvcY1ZjVHsSi2w1bksZeFVO9oLlLPNFjc6/4fnAM3xS6Pq8XrM6aDnm86m1FDXwBkh
         O00Sx+OeT4Vcss1aGCT26/V8GD7VZkr8mBvar2ESKSUWlLV1j71YDhxe5wkb6WmGd3kR
         /feXfev3XF5IhxL+1QrtdR6V/hDBlPKJJVOKYQcLFBYrv0Ht65rmfPbMxNiBEp1nLZ2D
         MbjekPv+yLCMjywFxEskAZJhn/P0ISYXLq9Fn+YoCQttSvdDHU3gGvWdunMnmQ10y0Rj
         uJ5Q==
X-Gm-Message-State: AOJu0YzN6Qt+XAuFF5/i4KP0vxoo0zUqkRMktnke525xQjRDsN18NK/X
	vSN+vOpCcYv7J/zt+ZO5lOyzE+3B24mjE57p/PpQekZblEYW2Uy7VENW
X-Gm-Gg: ATEYQzwuzAwaS5MeTUh5+s7/cXAGC+tMd8AnrIRH54B4mySdNitKLG916XjjzkpOJ3a
	/prAxmBHktA0vcEsMUVksrv/Axbo882B6pxcvFV2WhaTBIXqFd8LZGTkWhlI98oXOHwgHa9vPE2
	QhRPmAJ4sWZXpQwNsrPfAnA5nWw1zUULsT8tM/V+nCKFF/jpsmlsgs4m0QXKPek7cW+BNybEglZ
	Imp/ez1WORPX0pyVBY1rjXcuwwTWen6mEDu++C76YTLtzkyBF49lcagbyfJ/hZL+Nn0UwEoQt/D
	klsDcYanElvyaSsJXXwCwaf584pw/FTJLsBfPoplRLIIVg246/IPg5Myz5lNMpd+kXWSZUCztAs
	svVLIL4QqSPcneQFFYANVjAlMTkmWH2/iBhXOBea8hEBP0QA3BDUkKgc69eWaSzhSMQq8PvYYYg
	d2P+mpF+gz7NHvHHdy
X-Received: by 2002:a05:6830:82f9:b0:7d7:fac4:e359 with SMTP id 46e09a7af769-7d9d67be313mr2068382a34.27.1774461784282;
        Wed, 25 Mar 2026 11:03:04 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d9e7272b57sm254630a34.24.2026.03.25.11.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 11:03:02 -0700 (PDT)
Date: Wed, 25 Mar 2026 13:03:00 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com
Subject: Re: [PATCH 1/4] fast-import: add 'abort-if-invalid' mode to
 '--signed-commits=<mode>'
Message-ID: <acQeGoBgsLFM7EWp@denethor>
References: <20260324215513.764739-1-jltobler@gmail.com>
 <20260324215513.764739-2-jltobler@gmail.com>
 <xmqqpl4syijh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpl4syijh.fsf@gitster.g>

On 26/03/24 03:22PM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> > index 13621b0d6a..dcbc5bc82d 100644
> > --- a/builtin/fast-export.c
> > +++ b/builtin/fast-export.c
> > @@ -822,6 +822,9 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
> >  			die(_("encountered signed commit %s; use "
> >  			      "--signed-commits=<mode> to handle it"),
> >  			    oid_to_hex(&commit->object.oid));
> > +		case SIGN_ABORT_IF_INVALID:
> > +			die(_("'abort-if-invalid' is not a valid mode for "
> > +			      "git fast-export with --signed-commits=<mode>"));
> >  		case SIGN_STRIP_IF_INVALID:
> >  			die(_("'strip-if-invalid' is not a valid mode for "
> >  			      "git fast-export with --signed-commits=<mode>"));
> 
> There are a few similar hunks in this patch to fast-export, but I am
> not sure what is going on here.

git-fast-export(1) does not support the `{strip,sign,abort}-if-invalid`
mode for the `--signed-{commits,tags}` options. Therefore we die in
cases where we parse this option with an unsupported mode.

> I may be misreading the code, but this error, and the similar one
> for strip-if-invalid that is already there, trigger if the command
> is given "--signed-commits=abort-if-invalid" on its command line,
> and when we see a signed commit in the range we walk to export the
> commits.  Why shouldn't the user get the error immediately while the
> command is parsing the command line options?  You may be sharing the
> underlying parse_sign_mode() with import side that may support more
> variants, but that is not a good excuse to make these two
> 
>     git fast-export --signed-commits=abort-if-invalid
>     git fast-export --signed-commits=i-dont-know-what-i-am-doing
> 
> behave completely differently, no?

Ya, that is a completely fair point. If the mode is unsupported, it
doesn't make sense to wait until we encounter a signed commit/tag to
declare the user provided an invalid signed mode for the command. 

> You can either move these "no, these subset of options are not
> available here" to fast-export.c::parse_opt_sign_mode(), or even
> better yet, teach parse_sign_mode() an option to say "hey, you are
> being called from fast-export, so pretend that you have never heard
> of options that are only available on fast-import" and error out
> right there, can't you?  Or would it be too _early_ to give errors
> to users?

I think it definately makes sense to move signing mode verification to
be around the same time the option is initially parsed. With this patch
series, the `--signed-commits` and `--signed-tags` options for
git-fast-import(1) will support the same modes. It will only be
git-fast-export(1) that supports a subset of the signing modes. It
should be easy enough to update "fast-export.c:parse_opt_sign_mode()" to
explictly handle the unsupported signing modes upfront.

I'll update in the next version accordingly.

Thanks,
-Justin
