Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DC81FE473
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 13:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737121147; cv=none; b=tCK/ALBApLNLU7wB/D6BTdNI+Pq/dy6ERv8SclwNFgTJu0WI2Ot6D+glv/Zk7UBKiHSP82hP19e0Q88k4MAR8KycdRvJ739QVbJ1ZFbKzi2AvS/PLA+2+fMSNQbq2lu14SmveV+AqafHu8pP7wcP8HNesIn2n+uLtF6v6cIyr90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737121147; c=relaxed/simple;
	bh=37Lwvz49puLUBWi5jsSNX9IErOl9SsLex0xhH0J5MfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbSz+q6QBIjjDdVise8orOxdmXuctFHAqkuC5799M0bhXC9BPOfi9Lzul8sz7dk52vDT3xdXZH49HjKD6N7ajOsQz8TdWBeoRjm/mRNURvh+Epv1DYSDKZtidKKnCXtIwmVreP/coUcSeQ8iY7LdieapWyEtEjQNp4O23uxCEvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLliGsq7; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLliGsq7"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5f88a93dceeso589083eaf.2
        for <git@vger.kernel.org>; Fri, 17 Jan 2025 05:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737121145; x=1737725945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T1aRZFVYh9KmbBQ79Iw/xgZc5dYddmfnxsJwrs8scTo=;
        b=eLliGsq7F9jHVwEggELTCd8XtgQQmtDV054jVh2DWUgKM6J60ke9Puq8B+HetXPxyQ
         tB6JQvQd842QftkK9kgcOnjDTKT0/Ts+M91L2uSt7EoFY0mMjFpeolw/gFEj5d+S9eCW
         saC3LjV94ATTTeooL4AqhbBuWUm8anYdjNrFTuCQ5rkhCcxVcW/xt/AJAKL/jWKgvvxr
         nhD0LVpWDLRcrzezmNDIR8S/Ihkx5pe47VuCFgsfL3T97kLoYTDaftlRlxHwThXYel+A
         NMG6HhWvlvdlbpjEpI3JSrctUpYEJUQa0bW1zlQIpoNETzgmeuUn2OC4a14Iwr5DWjCj
         kzJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737121145; x=1737725945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1aRZFVYh9KmbBQ79Iw/xgZc5dYddmfnxsJwrs8scTo=;
        b=sPjAdzD1SRRHEvaLJhyCLdyUi0R/zs4VeW6eVyH3elj6ecRY0k5OWjDVLkpSssUrId
         aFchebx3Z2a7V271ALzF2xDApksjB5jgmG3nB91JsgJifLgf0sinMDdWYCtInRClp8cV
         LSDQIZqQxeMWlVvLLKdfeCHJxVpT0PzurxADA64eg1bpkSeh2vvG4sLFSd9HK544yxVY
         9AkKRExLzaLk6sAgvKzrlPJzGQKrJ9uqQSGkACg6Erx6x66FuaL5ZKeD5Nf6BemRFi72
         02bilZwec2Cyytey09mUNfyB3PNC910K3sdXpRkFe1oMsGmsMqIciE6oa7oM8eQQq14e
         Z9yQ==
X-Gm-Message-State: AOJu0YwNm8TKSWd4Xi+ZouHno8nUnE1f1xcGpR1fvIFO9vQUVALUga1I
	pYKfNmjsWYYKmgY1BJ8nknL2WmJeOb3smXFgOrR98ml1PRWjIcWWJsAdlH/t
X-Gm-Gg: ASbGnctIN34ktLC/PTPzYki1bozWphFCsYtGhnEbs3XopOTP5mvPWweuFMlNfR0lVIY
	9fB8FIQAXVzySDUSy7FrREYAKh51ql8ykw6xHnGl3gYNmXCvqLd0uyLqWEfsX79/2DfnTrDN/aV
	S66YzlyHHiCzFShkXUtUtjaIQOJJVXZmPpaFb9juUT2T3BW1+cVq0waTcL9lKvMtI3AEbiIZPpE
	9+69vQkMDope5KomoxsuW3qGkaKKQFxIDY=
X-Google-Smtp-Source: AGHT+IHVaNlz1RSbD09G4za7xzbGW8idYvxbshtNgKPWkRNFqNc/eeEJiDKlcQYKn4Mmp+Ay+bjo5Q==
X-Received: by 2002:a4a:e843:0:b0:5fa:2139:400 with SMTP id 006d021491bc7-5fa388d1e56mr1796231eaf.7.1737121143491;
        Fri, 17 Jan 2025 05:39:03 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-5fa35f053e0sm760101eaf.9.2025.01.17.05.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 05:39:02 -0800 (PST)
Date: Fri, 17 Jan 2025 21:40:18 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 01/10] files-backend: add object check for regular ref
Message-ID: <Z4pdwiBvDlyC9TZW@ArchLinux>
References: <Z3qNUizvHJLgMx1y@ArchLinux>
 <Z3qN1T3lJoj82ckl@ArchLinux>
 <Z4kQP5PBlgjXYNhs@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4kQP5PBlgjXYNhs@pks.im>

On Thu, Jan 16, 2025 at 02:57:25PM +0100, Patrick Steinhardt wrote:
> On Sun, Jan 05, 2025 at 09:49:09PM +0800, shejialuo wrote:
> > Although we use "parse_loose_ref_content" to check whether the object id
> > is correct, we never parse it into the "struct object" structure thus we
> > ignore checking whether there is a real object existing in the repo and
> > whether the object type is correct.
> > 
> > Use "parse_object" to parse the oid for the regular ref content. If the
> > object does not exist, report the error to the user by reusing the fsck
> > message "BAD_REF_CONTENT".
> > 
> > Then, we need to check the type of the object. Just like "git-fsck(1)",
> > we only report "not a commit" error when the ref is a branch. Last,
> > update the test to exercise the code.
> 
> I wonder whether it wouldn't make more sense to put this into a generic
> part of `git refs verify`. This isn't a check for whether the format of
> the files backend is correct, but rather a check whether the refdb is
> sane. As such, it also applies do the reftable backend.
> 
> So should we maybe extend `git refs verify` so that it also knows to
> perform generic checks that apply independent of the backend in use?
> 

I somehow understand your meaning here and I think what your meaning
here is that we could use internal ref method to parse the oid after we
check the format of the ref files. Thus, we could totally make these two
different kinds of checks separately.

However, if we have already parsed the raw ref files, we could reuse the
parsed hex and then use "parse_object" to get the object id to check.
This is the main reason why I add this check now.

And I agree with your thinking here. Actually, we may put this into
object check part. Because in "git-fsck(1)", we parse the refdb to know
whether an object is dangling or not.

I will postpone these checks in the later patches. Really thanks here
for this wonderful suggestion.

Thanks,
Jialuo
