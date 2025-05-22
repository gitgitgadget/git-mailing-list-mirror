Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7404825FA26
	for <git@vger.kernel.org>; Thu, 22 May 2025 22:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747951426; cv=none; b=K0L2fuS4wy2NOyo1gV9zWHGAqFNZkoHr+wSiNvd6ZUePNZuwTwbA6pKlIUH0QO5dt4nBDSGH3k60X1ln2sT2nra48JZblqZOmZE/IvmGGSCvIsJw3VRY1jfVZ/itB1yHAMzoCLrL+bsLxK1dgGE1CLassTVaC11wCvCXeKcojU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747951426; c=relaxed/simple;
	bh=Qt8m2DbL1ISevMfaHTgveknJTWQMTiCtMz6oAqX2QQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ph3XIusWzOS1ihtq8DN6BThazyVZwZeFXMijSon8auDa0UxP2qrO3U/afPBHN4HIs2GRK+vAYMYJYg2ELWSNT71hXpQgWnaU9Uf6IBOTLrTdaH4qGxueVnXfMXvCJTT5CcO2Dh0kHgBiIjKz4tfou5gZ4b9VT3b6HnGnUt8Wfzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1z0Myah; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1z0Myah"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3feb3f54339so8727755b6e.1
        for <git@vger.kernel.org>; Thu, 22 May 2025 15:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747951423; x=1748556223; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PFyVNc4o+1tBbCuUqFG8TsUcsgwrBkpRaR3mB0SBMIc=;
        b=X1z0Myah3di3ChOpOy9082vEAZSm1wzUnK/kcLwDyRdZxzDvF9dkePMsT+Ka0WQOOh
         uF3Jnd2zk9rljWVkvx2PtZccNe/8aPY2tmNbFU2TcUo7snBKiGPt85LZMahMVM1fZvBr
         wcv7eviL6Z+IP2ywxHteJK9KlOW90j5MjqVsK4rBtT5G+TtZLIZXIYAiwOD1/mqSEc+1
         tdvt3N0HowHEpvMe2Y2i5eax02xdt5L4MjpqlHe/Jw9UHiqF+MLe+xOYRC0UCNo5UuK3
         55h3PrUSDj+127ZRfD3X1Q0HVCj6C6f4WRg+GYsQn+QcbyvnwMK8IHRUSD/9x9CZJlHN
         Ko7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747951423; x=1748556223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFyVNc4o+1tBbCuUqFG8TsUcsgwrBkpRaR3mB0SBMIc=;
        b=P4ufKBo6o8naXh8BhadOUhxkAWY4vImOvjvxRXcjjGJEZN4RkIE/QCFBKzaFMmccNH
         UXNR+ZIHE9i4KCzYwFdUICAopg7+PdtW/GW2HVTHtakg2GBcnoRL9wgaKJQ0jlhkr94a
         arq1VSPvEczrEe1apP/UIhaHBsci0zH2D2ykcLM6prkfD4fpII1NMfIRUI8pSNkVO6gl
         UeskJN5SxhohEkLQjnURPPoys+5MmzeeSskEvewZ2B3m5z799urDgbefZdpuxsoKtLcn
         /ZB2oHA5HI0CabRcKjFGr5axtsYrMnsePEU/0z5DiJS3U7i3Wae0T4ZYippvV1gtt8Er
         kLZw==
X-Gm-Message-State: AOJu0YzrvGUqmxd8Ecjc27Ez1XU68YBNEv+wTGBJnVTMBQU7ZKobcEIC
	CzhC8cyWcBUK1DFJxqQxa/RoYnxYLqs515EyftaLLBCeLgXOWQdyWz7iq5fhfaN2
X-Gm-Gg: ASbGncvbTZNK77QfI7GK9AMmTdN1s2vK+UBT/baES7WTr50C6Zd8RnXDgEPRQutJWs/
	kejFXjASow3o58mP7XXsFdlEXxOKlPQJf7CUDqtx5t112spYjvksshsXLA4FFpl5JR4Uzlyn5AY
	LQlP8UF6C22394Z2DM3YvqNj193l2Mym6p24rCnblFpHV2SHhtu9eJ0hmJZj+BiwGio1dtpFrrY
	jMk2Yttokwgowc1UCRIzLwmjmF6GnJRFIYtkEuV7rUn0HhcxM7WWgNq4mjzF+bjF/cZIQVknDaR
	MRSokfZoOYy4dgwn8oZTOSshkRiepRAhORE63QVNIYUDdL6OCD33yIw=
X-Google-Smtp-Source: AGHT+IFVVd+RBtz4GaHVrgrYtbkk4NxNixYi0+cqN9lKGr8T4qG/kr4PPBpW3Ij+vUakjv5IDvhyGQ==
X-Received: by 2002:a05:6808:2029:b0:3fb:2e8f:4de5 with SMTP id 5614622812f47-4063d9e4051mr638077b6e.17.1747951423307;
        Thu, 22 May 2025 15:03:43 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-609f2f58d19sm2956027eaf.21.2025.05.22.15.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 15:03:42 -0700 (PDT)
Date: Thu, 22 May 2025 16:59:02 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v3 01/17] object-store: rename `raw_object_store` to
 `object_database`
Message-ID: <mghywdyktv654vqywde2exazfr2zproisnojmb62vjsrhdessx@nxmj3m3pfuxn>
References: <20250514-pks-object-store-wo-the-repository-v3-0-47df1d4ead22@pks.im>
 <20250514-pks-object-store-wo-the-repository-v3-1-47df1d4ead22@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514-pks-object-store-wo-the-repository-v3-1-47df1d4ead22@pks.im>

On 25/05/14 07:12AM, Patrick Steinhardt wrote:
> The `raw_object_store` structure is the central entry point for reading
> and writing objects in a repository. The main purpose of this structure
> is to manage object directories and provide an interface to access and
> write objects in those object directories.
> 
> Right now, many of the functions associated with the raw object store
> implicitly rely on `the_repository` to get access to its `objects`
> pointer, which is the `raw_object_store`. As we want to generally get
> rid of using `the_repository` across our codebase we will have to
> convert this implicit dependency on this global variable into an
> explicit parameter.
> 
> This conversion can be done by simply passing in an explicit pointer to
> a repository and then using its `->objects` pointer. But there is a
> second effort underway, which is to make the object subsystem more
> selfcontained so that we can eventually have pluggable object backends.
> As such, passing in a repository wouldn't make a ton of sense, and the
> goal is to convert the object store interfaces such that we always pass
> in a reference to the `raw_object_store` instead.
> 
> This will expose the `raw_object_store` type to a lot more callers
> though, which surfaces that this type is named somewhat awkwardly. The
> "raw_" prefix makes readers wonder whether there is a non-raw variant of
> the object store, but there isn't. Furthermore, we nowadays want to name
> functions in a way that they can be clearly attributed to a specific
> subsystem, but calling them e.g. `raw_object_store_has_object()` is just
> too unwieldy, even when dropping the "raw_" prefix.
> 
> Instead, rename the structure to `object_database`. This term is already
> used a lot throughout our codebase, and it cannot easily be mistaken for
> "object directories", either. Furthermore, its acronym ODB is already
> well-known and works well as part of a function's name, like for example
> `odb_has_object()`.

Renaming to `struct object_database` is a good change here. One oddity
is that it still contains the `struct object_directory` field named
"odb", but that gets cleared up in the next patch. So no issue there.

The patch itself just a bunch renames to adapt users of `struct
object_database` and some function renames to use the new prefix. This
patch looks good to me.

-Justin
