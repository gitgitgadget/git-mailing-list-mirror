Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBE3273D6B
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 15:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643165; cv=none; b=I+vDss4AU1+aG/CvczsDx31kxIEhxDJw1LDeKkQ7QwDxUHVlanG3W1qmYFBICQ0Q2vUEOD8ZVC4694dcP4gT+YUGebaa7XFWmY6VLBjUguUT+QGqhYbVQwsXtRFP3Gw2HNBLLh8ldtlfB3V53lV/m9EZMjzPRIOKuLSBE2jygMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643165; c=relaxed/simple;
	bh=8FtDsrDUM9yRVpTqgPwP3z3/bDHw7JzEkdTLy+l7r/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDeZUNj14ja5uu0jlKcLGOmakBKsW3tQvSVa24KbOTHjZKvVy6xNvY9aWvH9qyl91XpkHKx635ScpqxsekJ+iQPcpyPA2hUKm7TSuJbFgGXKxaDHNDxAaTRVe4S4OSDcC7fw8AbtL2EUO2nw/mkli5W+s9nJ6EQVdUcp5758FmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/jcaQ6/; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/jcaQ6/"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-34207c1bdaeso1002678fac.3
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 08:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758643163; x=1759247963; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ofzKFGQQaF+cUMMncIRhevJBtAzZXeytkTBkLJ+BbfU=;
        b=K/jcaQ6/Vk+mbp6W5Iig8m1Vr+h88BaQXI1z9SK+O2EkS0iASUXWxqalLWsN+g8Jmy
         0nmSeJoISnd35LsCanW2yrzquKMopa2tOjEgPmOs5l1p3e2QmkkEuZ8zbTKcdhcTKEhE
         SI8WN+lTvoYjUMC+4NSLZmczBvIbBKNgj+ISbD0tE4+swHNwVW3c9O0v2dkAQw6lu+ew
         FTc+/igbdpQaxN0VYyR7qC9OPcx9/bmTRi9BjvhDnDFitnovt5XpAZTe1/TBL+QaEQ36
         UTmriAI80of9gP9sdKunybLUdvALlUE8byjDuj8bkdBX2VOvWjPIxUXHFFtmjYHTEgiu
         ZStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758643163; x=1759247963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofzKFGQQaF+cUMMncIRhevJBtAzZXeytkTBkLJ+BbfU=;
        b=AcrcBrldfkmgi4t06/SBRZ9oac4VHEJwh/SQpvpbp/8hGNYx/amR5pbPev1N6s1Ze+
         bNXNWgxmmUJYFpUkD98I6SCv+uaUyNMUqJc3rSBfxi1JkLFu8Ybhzm9+QNZ6lDJw9YW4
         hScdxxlwDSNIGQ0OH3TMIPHtrFLv+eRBANgUsbHwCnD99zwoBhqdL1Lp5BQOdtYUpzAh
         3jo5S2VhoF72VEKvfq7LYa+FikImG3O+qTt7q0C9IvbI/QLDdx2FvNOcP9rW2bEvHVCy
         VrkYMMy/YFVE28JZgxW32IDslK3NL3kfX4fFZWHHRMja1Sygg6I/kXruDSuufjeYwef1
         3gEw==
X-Gm-Message-State: AOJu0YxBzoDSQKl4MowwCOb6flpLZXsOeMvztnhIRZ7QlHRhVyeV2AHU
	f8v/43LFKtp5dTFyddOfNj3Iu7UWf17aeGo8Ql4gj+ucE1+2VAU6tWhiApJg8Q==
X-Gm-Gg: ASbGnctVwn48wIxGR+Af/P6wOeXajX1faZtR5/DgvshD9pWZGvHow06+yyudI5Sj/5i
	xY4xVsG+0uRG+s1SRIqIupGXoD7VFvTlWMaxLdyjkRm0jQ3yuJ37HznkZxO1OS7OzcfADNvvq38
	G3clfXmFNgdm4I+LU6Nm3QxgVE59XK84HzjIC8zY8IafH5jKM2YlXEQq4XrvSLrIyQoLwNJtyqM
	SR3fX+TupBACS4jT3fb2Y0B9V3WZ3f+/IBT6tXZBesavCw8w6TNwlFRjazThLCshEKAxdHEZiUi
	pQU8xrGfw7ikqXdQVqZLZDMEnIQQg3yU0f+v4+7PcUwx8rhM6W8FroTIldOuMvzJgHiJKxNEzXq
	6f7jLOXG94LsDU/v5
X-Google-Smtp-Source: AGHT+IGcd/x51ewe0RxtbUIWQnLCpw+DLkHOoBxHQ7XA9xJGKNHovTQMPHLwuUBY7SPDZokgJMR4Aw==
X-Received: by 2002:a05:6870:3894:b0:314:b6a6:6877 with SMTP id 586e51a60fabf-34c88732800mr1817140fac.45.1758643163320;
        Tue, 23 Sep 2025 08:59:23 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-336e3afa7bbsm9633919fac.2.2025.09.23.08.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 08:59:22 -0700 (PDT)
Date: Tue, 23 Sep 2025 10:59:22 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/4] builtin/repo: add keyvalue format for stats
Message-ID: <hapuro77uciopotqmkjrapnomyojsys7mfmurkuvecu4fy6il5@echgeotkgcmk>
References: <20250923025700.3046260-1-jltobler@gmail.com>
 <20250923025700.3046260-4-jltobler@gmail.com>
 <CAOLa=ZT0y-WOOFz8FdLm40AqwEATzNsg2fzvnJKPzx2mkPiz-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZT0y-WOOFz8FdLm40AqwEATzNsg2fzvnJKPzx2mkPiz-g@mail.gmail.com>

On 25/09/23 11:39AM, Karthik Nayak wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> [snip]
> 
> > diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> > index 2a67abfca8..7d0341e4f1 100644
> > --- a/Documentation/git-repo.adoc
> > +++ b/Documentation/git-repo.adoc
> > @@ -9,7 +9,7 @@ SYNOPSIS
> >  --------
> >  [synopsis]
> >  git repo info [--format=(keyvalue|nul)] [-z] [<key>...]
> > -git repo stats
> > +git repo stats [--format=(table|keyvalue)]
> >
> >  DESCRIPTION
> >  -----------
> > @@ -44,12 +44,22 @@ supported:
> >  +
> >  `-z` is an alias for `--format=nul`.
> >
> > -stats::
> > +`stats [--format=(table|keyvalue)]`::
> >  	Retrieve stats about the current repository. All references and
> >  	reachable objects in the repository are categorized and counted
> >  	accordingly.
> >  +
> > -The table output format may change and is not intended for machine parsing.
> > +The output format can be chosen through the flag `--format`. Two formats are
> > +supported:
> > ++
> > +`table`:::
> > +	Outputs repository stats in a human-friendly table and is used by
> > +	default. This format may change and is not intended for machine
> > +	parsing.
> > +
> > +`keyvalue`:::
> > +	Each line of output contains a key-value pair of a repostiory stat. The
> 
> s/repostiory/repository

Will fix.

> > +	'=' character is used to delimit between the key and the value.
> >
> 
> Does each value end with a newline or with a NUL? We should mention
> that here.

I was thinking that this would be implied by the prior sentence, but it
is probably better to be more explicit here. Will update. :)

-Justin
