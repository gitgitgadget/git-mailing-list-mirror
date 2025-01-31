Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C7EEAC6
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 14:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738334059; cv=none; b=dcpy9dvtF3N8VI6pblWV1wAT7OEGzlaUsfyfj3dKHBbfUAAfcEeWXs2ZnYjM2xsNJn5Q/gYYj/nHWmciIu3+XT7zvJcALy6G/HYppnNjJiynNP3/p3+amLqErtRBmgX+nIFjszzykzINPCynkpZNYnTovhiSB/b6m+coBrr7neY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738334059; c=relaxed/simple;
	bh=9brKmeWloXmsfLTWOGefgdz5ybGBsl8uKcW0gSrwu0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LH7qa3Ci9qIIIbiXXCyMOnFYoc7U7CdIAejRRbB8jEmHbTo5OELdCYFquDlFJSg4N3qfBGq9tNF1H+l3PlpMgmj3zGjB9nK8wCsW+X6pItSnmGtn6XQMZ9+VfueU7OEC+Vj5VtHZn/Ne7VipDm+RhcFpGBzc7w+LsYlQLdK3U98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LkPkDbQQ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LkPkDbQQ"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2164b662090so42156435ad.1
        for <git@vger.kernel.org>; Fri, 31 Jan 2025 06:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738334057; x=1738938857; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Aubf0/XZzOuYdEEmWuMxmdo7V09htcjYD9R1+i7Ees=;
        b=LkPkDbQQ4Gvozy+S7l3XTF94YX+BlufKFxvWA8knXRZKTz4uLkXwpZmmqSBbO/4oLz
         tNq2NSm2vFvplaKdleIVbayk1wzISWLtrOmhvku6g+bzh4MC8C917cm5Uq2SeUo1jXrI
         mTR8adhtftylCPxsI1/CGzwpYwK6CmdqciLfSCGFUwb4cI/fvhDynZtD43XDhO03hlJR
         Bi9mrnHcAlK0c6yzcz3uZcOo9UdwY1Me2F0rm8XC5KR3GeD7lUg9nNC8uoW/cHOztQpA
         hZeF+e699HQFZ6V7hrkYjm0u5Xs1w67iAJ/qXuY0K9gPPE5keLkCovWtvQKZkNegArts
         BwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738334057; x=1738938857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Aubf0/XZzOuYdEEmWuMxmdo7V09htcjYD9R1+i7Ees=;
        b=vl3N3YL0X6oaZKsqzmOe2hInE13GtVJU7VV0OyqdQsM76n7+wUQv+c+QO8Ks5C+Zxj
         q+2XGT2hdzCKusdqtYgSU9L0lpraewpjgwI1VPc9WbI+gz2xF326aMC3HwQFCRITMQms
         tEDEs7EAhOfhC2G9qFWAb4cQ8EDmrjrb4OckDdbjvAE75N9WTC8yiuxwt2pCrSFYQVc4
         3vXD2kKfydxIpJ0ZDr8e/cleI3ojNScfJb88spT7qaz9DsbsD1J5e706iOT+tTIQ0kxd
         ZFBT390tXqv95uGnYhDwjM+DimW1EuampQneMCU1S7x6vYYIg3FxGw/C7GveVltR+T3s
         zmjQ==
X-Gm-Message-State: AOJu0Yxc24bxNcTuXl5z0izS5UPB3fP+NO2NuYP1hGYl/arfijdeSndJ
	OKjgZf6hWYvdJ57nvT85oTjVk9J/xU/M/vrqw2CpvJ2wJYKkADJf
X-Gm-Gg: ASbGnctdOsszOik7zZExAlYIJf/fxH/u68iEDBfggEjb12FDvwYAK1yO7ydxBG/gfJ0
	Nqg0NBPViImoq/G3TCHPI/xmtpzHlRZ+efUT7dCUVpBVLvifFVi8EB/7nMECqorVrkdkcVzQQeh
	JXFYf+qdf5Y20QCXCI07402CO8bBrQI0FeqPUVkmfNBCPa7yQHH54JndvhJVrczD6NqcAbytLwP
	4Li5ZokLmF27sLnQPFR30nOUQp0F0tQjuOOMudcqE3tRMPGui4+emLOoirGgv3VPs2pLA==
X-Google-Smtp-Source: AGHT+IHwmPi8i6jOS1T43A2GbPF1e7l9iyy+U0BjfWDvZ5f3f4MBwhXGQEkTrZYk9lFmBkSYWfC6Lg==
X-Received: by 2002:a05:6a00:4c09:b0:728:e52b:1cc9 with SMTP id d2e1a72fcca58-72fd0c62101mr18071076b3a.18.1738334057066;
        Fri, 31 Jan 2025 06:34:17 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72fe64276ccsm3499319b3a.50.2025.01.31.06.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 06:34:16 -0800 (PST)
Date: Fri, 31 Jan 2025 22:35:51 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 7/8] packed-backend: check whether the "packed-refs"
 is sorted
Message-ID: <Z5zfx0E2neO5MNKs@ArchLinux>
References: <Z5r6ZnLH3Ee8IQnN@ArchLinux>
 <Z5r7KvL1bvSO4UQY@ArchLinux>
 <xmqqwmecceh1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwmecceh1.fsf@gitster.g>

On Thu, Jan 30, 2025 at 11:02:18AM -0800, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > We will always try to sort the "packed-refs" increasingly by comparing
> > the refname. So, we should add checks to verify whether the "packed-refs"
> > is sorted.
> 
> Do this _ONLY_ when the packed-refs file has a header that declares
> "sorted" trait.  Insisting on a packed-refs file that does not would
> mean you are stricter than the runtime contract allows.
> 

From my perspective, we should check whether it is sorted when the
header has a "sorted" trait. Actually, in the runtime, when calling
`create_snapshot` method, the following would happen:

1. If there is no "sorted" trait, it will sort the "packed-refs".
2. If there is, it won't sort the "packed-refs".

So, we DO allow refs unsorted.

Actually, I have used `git show v1.5.0:builtin-pack-refs.c`, in this
version, it does not sort the ref. However, I quite don't understand the
comment from Patrick in the version one about this patch:

> Makes sense. It has been a source of bugs a couple years ago, and it can
> silently make you receive wrong results, so this is quite a sensible
> check to have.

Patrick, could you please help to explain this. I don't know whether we
need to check whether "packed-refs" is sorted always. It seems that we
truly allow refs unsorted. We need to know whether we should tighten
this?

> > +struct fsck_packed_ref_entry {
> > +	int line_number;
> > +
> > +	struct snapshot_record record;
> > +};
> 
> Not a huge deal, as 1 billion is still plenty of a large number, but
> the same comment on the line-number applies here.  We might want to
> consistently use ulong for line numbers of files we read from.

Yes, let me improve this.

Thanks,
Jialuo
