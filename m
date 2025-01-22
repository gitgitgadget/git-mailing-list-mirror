Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C514E2153FF
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 18:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737570606; cv=none; b=Z02XZIIF63mjSucTDO/wPVDT8uC540zRf1+Soqhs/g9Z7BW5MGLbu0Xu1GtXOBaBiDyvGvVNIFyiIic5WwgCz7YXYg6JmklZKHR0C66/OCNfXmRLLbAwBQHnM4gJ2rjxBynJtxeXXSaiWwURazNXwhDKBwddguU3Do2pPUmGwKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737570606; c=relaxed/simple;
	bh=hBKu5fEzx3bYL8reWl/6EY0H3NrcruELAcHvvwjuDbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdAQYw3g7F9ST7hZ/tek0o6tN/j19Trx8W+EJptQqwT+tqN2Sx2jLv5z11e+gsXgY0Qbxg4WxgH97CY5iJoOBu1Xv6JeutVdb+4vVMuPX3q5nVgyJxA2Baqk1mjfp43ojKDDjGvaC0oY6JebUn8T3GdQGWzJrM4Ko7wXBzWYjZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=nYUAELY/; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="nYUAELY/"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e549a71dd3dso112432276.0
        for <git@vger.kernel.org>; Wed, 22 Jan 2025 10:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1737570603; x=1738175403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zd5QnNeL6N/IhioC0fUKDfyKGANhRB7gV4Hr+X34apU=;
        b=nYUAELY/dSJxVICaGBUrcl5gAgTcubLYz2+ObKjWOVS6AW4U9/Nzy5R0X0oQJo2ruT
         /bkuhB/iSWoDxK5tmkDqm3ZpKP1sF6S6Xaig4eqL/Z+ca79LQkGyAR+YGWOJBXlHm6+R
         7NyKVb3O+oYo6G7ekCIAlycBgfw0nbuLiqFEkWhjVC0OTEWpE48VRp6lh+5yL+S2DVbA
         3fCvj5qoI5WRiM6QZT8MoyFZU/jQHPeiPSNeur9HCENT3HEKPWKhOORiwkbD+PO4kIEC
         oYF/qXu+bQ5M16RoJu8RmQmccnxYxOZYUKWdM2LGIaHdxFSeIhrzBaJIKKSWtbXwknnD
         R6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737570603; x=1738175403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zd5QnNeL6N/IhioC0fUKDfyKGANhRB7gV4Hr+X34apU=;
        b=PrjIu9tG+DOT+alkCuhep7HDWPdLlIHYkO6U7PoxvK6ayxCz2yz64Jc0Dtdm+S1jjh
         hs9yuEeX5MMm9E7rHoquAcsF/XGk9al9Uyc5xvPhqYxn/M4QontqxUftMFj8ratTtQwY
         XrSZ87hsuvosd46N1KznKti3AFlZ1m4Q3XOYfmxw2jcbpYDqP92IX6WYyLyPmEm2lg09
         fyAcoZpkk4vNSbcVZsOVm8VP7ypENcQsqfyqnoyULp07aUxRFAglG4y+1MuIQ5iLduYx
         qAAWvNm8uPCu1vPkg/iaHURJ61/6CcY95ogIxFarin4SgX3Ly58t1wrwCb58iXZyx15i
         J4FQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLk/E/LqX+ZtrRlqevLFohpSo5njmwZ0rmxqSiOE0NGyFVEZTwrT1z9dhdtZctLZdysPA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/tobiQJFlZnGHatO3YHuIjZB9TvYJ4bj639OygnVb3p3XMIn0
	k/jCRQVfKRnTB0UNTnB3Fbz+PKZWRiNFi0vb5j8EEuZAski7Ab0JTbKBDo4lAZw=
X-Gm-Gg: ASbGncvh19s1+wWqSO4OP9xEpWAHE/n69qQvomKTMWg5Rwz6gWYQDudLxgj1vgJI48P
	4eslv5G8y6tSZ6Dv1ELhn3Rtclj9qbv5J4SOXQ41PioIfl4HQgNh2RfBMVN1HTHuNUK+ooZEN2X
	v9ShmjOm9mKkKQQpiGqy5BQ/LTAU3/9DGTxsABK6wNRfIymfvPNSLDEt8R8yUi1fAp/VrvRj6Zu
	9uTZv7EwGHB5ZQExWOkWlrncpYqM3mi1TqWmRGP9dyGU4VGz5KpAYSNt8KPZDhaTZW7EuYK0pjM
	N5qvAepoeMsRFiuxnZaRxJpbMedvwrMYx9OI6oTk9g==
X-Google-Smtp-Source: AGHT+IFCQSyLPFcOijii9Qu+8o0fE4Bh9rZTE3GBX2JE3wIylX7aW7Gi4o47hAfauAduNKIkahJ4fg==
X-Received: by 2002:a81:fb08:0:b0:6ef:7f89:d916 with SMTP id 00721157ae682-6f6eb943051mr140053957b3.34.1737570603469;
        Wed, 22 Jan 2025 10:30:03 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f6e66f53cdsm21154157b3.100.2025.01.22.10.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 10:30:02 -0800 (PST)
Date: Wed, 22 Jan 2025 13:30:01 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2025, #05; Fri, 17)
Message-ID: <Z5E5KdbwHE7fmiJx@nand.local>
References: <xmqqwmetgdgm.fsf@gitster.g>
 <1331d214-890e-4b47-87c6-44f445172bb2@gmail.com>
 <xmqqv7u7zz8v.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv7u7zz8v.fsf@gitster.g>

On Tue, Jan 21, 2025 at 12:30:08PM -0800, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>
> > On 1/17/25 7:42 PM, Junio C Hamano wrote:
> >
> >> * ds/name-hash-tweaks (2024-12-20) 8 commits
> >>   - pack-objects: add third name hash version
> >>   - pack-objects: prevent name hash version change
> >>   - test-tool: add helper for name-hash values
> >>   - p5313: add size comparison test
> >>   - pack-objects: add GIT_TEST_NAME_HASH_VERSION
> >>   - repack: add --name-hash-version option
> >>   - pack-objects: add --name-hash-version option
> >>   - pack-objects: create new name-hash function version
> >>   "git pack-objects" and its wrapper "git repack" learned an option
> >>   to use an alternative path-hash function to improve delta-base
> >>   selection to produce a packfile with deeper history than window
> >>   size.
> >>   Comments?
> >>   source: <pull.1823.v3.git.1734715194.gitgitgadget@gmail.com>
> >
> > I'll poke the thread, too, but this seems to be the most promising
> > topic in the area of better delta compression. The latest version
> > does not have any comments.
> >
> > The only decision point I think remains is whether or not to
> > include the last patch (--name-hash-version=3) which I would be
> > happy either way.
>
> I am happy with the updated function that gives us better of both
> worlds, without losing too much from the "renamed from other
> directory" while making sure we do not lose too many bits in deeper
> trees.

I had a couple of thoughts that I meant to share before the holiday
break, and haven't quite had a chance to get to it now that I'm back at
my desk.

Let me try and find some time to respond to the latest round of this
series, and apologies for holding it up in the meantime.

Thanks,
Taylor
