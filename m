Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E2C1B4224
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 17:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769190315; cv=none; b=k0FQZXHCGEj7is636oymUvTbJHgrVGrH0Tp2wvebHO41EBSQoUDIveM1D1jXC34KBSBGWmFrlHt8W8po16A7n9wYNU//G/z2H7T+DwDRmrvX/ytGXJcSf8BWZzBAQrSxgILnXVBrgzRoCk8F2uPFVbAmVrGzgbjrgePEtqZu8NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769190315; c=relaxed/simple;
	bh=JtlNZg5LiGVyBO/PG8tWZ4jMLCQge+Ln3RW8jeNvT+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/LjrX1rU5uKcvWlfrybJRDFju6IwoADpTHiAAZNDoYYiWGHhO4yX1GdGCkoLmdw4VDs3Jrkppo+CGzy/OgbH+1mWs58gU5oyDgxLxtB6YdTEqajGfEpIMZBHBL/qGQqGx4f7Ra/iXy0trmaNiasoXXbW3w3mcIassQsCkCQqBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=H6iHDv7i; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="H6iHDv7i"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79405f99b8eso37776307b3.0
        for <git@vger.kernel.org>; Fri, 23 Jan 2026 09:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1769190313; x=1769795113; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0yA5nfssfINVNQ1BYv6jehN5Jau2ZnAQ+p6kLVl2CiA=;
        b=H6iHDv7iOb+t5VhxX7BppCJRs9uVJLcUu0fbnGukvarrKgCO3qdfMO/n+mbVk5+qRL
         eHixra8LXl5/VJDHFGuIitlHJwtlskeLO+nuR6pkV1W9Y00YRIzeLzQn2R4K6UISZ57u
         vA93hOSGexmTQwqIDzB6hH93huMf7GsSY51xq8c+8Zsbv2AsJ/RRlMyVhFZKWGtxd9UY
         htDgDDJxat+KcHusvT79X9/vKcvLxyja6TBSMTogSeIFYghGW94tLAC77bMmNTJUFfmB
         MJUEDDfWECpQFB1Xx8/1NTou3GssKhsg1JH+1hG0rw8tz8GLLqQ21S1jE8hAYZyt8oD0
         TL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769190313; x=1769795113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0yA5nfssfINVNQ1BYv6jehN5Jau2ZnAQ+p6kLVl2CiA=;
        b=IThPtCTA54kQk4KgRUTihNOIZCMJVzxCsl15BGhWxZ1o5vrUnviVZCUscgWxwjM7LG
         J8FUdGyf79D6G93onYIYRTgZ6ek6qPegPDry8AnwEVC4bV34xbYupzaNjHes7AbSHGAG
         5Po6zpWfpqEYTtLbiWzefJHyZmAYQLd91XG0OYCdIkVQjYVpbJcVh85cA9Wq1rNLST8R
         L4/UglVDB6HIwHAVuuvW3dJSPEZnAY5ToD+9bLs5c02pSewRe+eJtOFUZuYxyfva+bVP
         djdeF3xTlgHuV06Z5SjKHiJjlFeStYaPoZLrTNdKMwFLn33fURQCmsLj+saXafzkON2j
         beQA==
X-Forwarded-Encrypted: i=1; AJvYcCV3khDG6GC+IDz+sCM+azR4r1rXuOy9NWjz2ygSTJKcxcQPoeT+7XV81ffG7ewWf+OXOw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUrOywhR68mUKZkwQDlLYicriWbphCqz+HGS6V0Saey7cqPdhX
	XNciRIYNsVU2RmATcGAQPo7LrRzifxMTU6CzmLU8s5Iw9J58tHBwm77hL+sAi0O7Ywk=
X-Gm-Gg: AZuq6aKogtdIulWSx4JXVKL1Ku7H3OTXI4ZPW9uZ5mjyo1U86KercPcmgXwUac5zCwO
	8A2p2y6Iug5cBNDdS2OKarGCmCDWhZimrMr0YO5snxiwDEQ9JTBPCdOEGMJlyeWog3wSldNQYQG
	GiOf6kdaBerBC02czRXVda0jNBGzLQFQ+EkMFsd8bOAPZxR2dJApDNoOeCSZcy4N/UzD1QMQuQT
	q0A/LeUDRIm+WXJZoGQUW1eozhbUkpLp2HHLULkOc93CIVcSKsgzi+2UN005F3nH1IuIhut95XK
	Q+pXpAT6uRh9k1/6BTiMEN2kr7dHzZ6KPQ+a7nkJgC42U/H4B/G1dh72rcC/PUbweDar6bJRYPR
	rFO+0n8EUy8REisNlHCHpUzHogbvc/ww6cb2rUNZM+tpEGcVsUY8urL2wp85hQyMMn3u8/khAMC
	3ip8tkoylB8sAPQc6UK/+QM30C+AErUwV4QSPqAglkC8AgOZFPjhpM2LwaVAUZcKKE1l3tnPFhg
	lCruGrYWwNXbADz6Q==
X-Received: by 2002:a05:690c:c52f:b0:794:8bd:66f6 with SMTP id 00721157ae682-7942a867b10mr61014197b3.29.1769190312904;
        Fri, 23 Jan 2026 09:45:12 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7943b2a2b0bsm13407617b3.31.2026.01.23.09.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 09:45:12 -0800 (PST)
Date: Fri, 23 Jan 2026 12:45:11 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Chris Torek <chris.torek@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 06/14] packfile: introduce function to iterate through
 objects
Message-ID: <aXOzp4ivyYgPLux4@nand.local>
References: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
 <20260121-pks-odb-for-each-object-v3-6-12c4dfd24227@pks.im>
 <aXK7cSJW2syew89a@nand.local>
 <aXNCjT6Al-4YLah5@pks.im>
 <CAPx1Gvd6BGPeVmN5b7WM_r6OFf7Y6KooJ2O1jT5O6LzNzGuEEw@mail.gmail.com>
 <xmqq343wjo2v.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq343wjo2v.fsf@gitster.g>

On Fri, Jan 23, 2026 at 08:22:48AM -0800, Junio C Hamano wrote:
> Chris Torek <chris.torek@gmail.com> writes:
>
> >> > > function is the equivalent to `odb_source_loose_for_each_object()` in
> >> >
> >> > s/to/of/ ?
> >>
> >> Hm, isn't "to" correct in this case? The remainder of the sentence reads
> >> weird though.
> >
> > Different English dialects. The preposition after "different" differs...
> >
> > (It also matters whether you use the definite article, "the function F1
> > is THE equivalent of F2 in case X" vs "function F1 is equivalent to F2
> > in case X".)
>
> Heh, "equivalent" is "Y is an equivalent of X" is a noun.  It is
> adjective in "A is equivalent to B".  Of course, article is used
> only with the former (i.e. noun) form, but article is not the
> essential difference, parts of speech is.

An alternative suggestion would be s/the //, making this read:

    This function is equivalent to `odb_source_loose_for_each_object()`
    in that it [...]

Thanks,
Taylor
