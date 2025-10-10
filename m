Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF342798EA
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 22:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760136976; cv=none; b=HFq9E3Iar0BLmh4VabnZ7o0Pqv3EDHUHwOFZgnEgzrxzDIxh0cNkhV9dzm9BKVrQddM/XjPjfnTfjnZX7mJmMdAvdu4K+m4DCB5YnxY++zBSfOtpjOhP/qHlHC9o5SwTGIkzUfYla6S1sPqAd3ur3VlXJB71RRKq3v9M0hHJI4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760136976; c=relaxed/simple;
	bh=KWh8C4XY9OcxyMruurv0lrgxBfPPOrBAu8Ryp7bqMMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fg2Ke+XQsIXSgw59DxVerRvbPwqZkDgql7lWtLgd5XABUPtnk1W+3TNzaebHHe+RGuwtBXRjMeqTv6Tx5c9gIYfONdIFkrA4g3Sk1cVeOu2KIUjZyghMiSLNR6FXxqNUYOXKGcToEkoy/GuFnf4EM+coz5tBVnZhvJLeaeFlaTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=PjJBhgqw; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="PjJBhgqw"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-71d603a269cso26255837b3.1
        for <git@vger.kernel.org>; Fri, 10 Oct 2025 15:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760136973; x=1760741773; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RmZqaN3v+S+eoqtIDKy6NO+D0eP9baXkDzbhsYGuRQg=;
        b=PjJBhgqwXFR0BWa8q0HrKSEgDWq2bMo41HAu/wyv3T1wh0Vfq7FY99B3/lV6sAaNKh
         8llXDpUerp0IqWDjci3QwIyULSsm8bCZmKfGJECULlH8MsbS39lSShsH+x3ZMbNYZR/g
         HiKIjEn/eI0WwLZ+AAzXbzb+0hNTspGo5YwW3eNCKuGTfevCY4rbAQLJnUrFzENF62EE
         iXH04RkgvZtpYsfs5vcDvEmac5uY/U3TLpURdOV4VR54aDiBZoMfkmdxfenJ8Pvem0bo
         gQ6/AAeTBAA6u6zlLW5IrojVdVzG0iqpDB+ybL5DEUyvjSAzhLODX66ZLnKFi0NnRc+n
         mPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760136973; x=1760741773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmZqaN3v+S+eoqtIDKy6NO+D0eP9baXkDzbhsYGuRQg=;
        b=sKu8IIgkK0K5+75Hu4IAoUig4m6cEWDk2BaMDgjfxmbX2KNDRILtAIgHQuvHf84/CH
         pmoiWrAX9Eq4zWEyXYnRFghIgtJ+EGAoilXYT9ypHEAsQkGNtMoYZZypl/AGck10FSzb
         WRID6HL7ANrw18ceX6T59CMOtFW6EhU2CGCX0UKFSX4dy1fhEjvy30/haHkFtrWfKw2M
         ZG3riyibpC7v0UbeGAf4Jy2JazoyXS0hwkLQ5KFx9Y63E2cQqO7zzYzvXV2Eiy0Fpcn8
         4S2CJlDz4QgczbRM8SeNHbqBVY4hlsL2bAcROK8Gs0GpFqOBA5/QZEfijpLvweU5YPSn
         J/jw==
X-Gm-Message-State: AOJu0YzMu8DHoRjucPgzQpNKvpenI8188lPp9/AFn6xHWO71DL5u1YbI
	AcbNioB/+AoxprziHzkAAxFQPs9//0IaKFbrWGbCZXl+cWZFqH3VyCkHkAR1svH2V80=
X-Gm-Gg: ASbGncvWFMj+AGP7f1eLh0U4QqxxHeGaZSlmUF740J1GmsL+KRlGzunrtxYCx8LdKT0
	5nv/7RJtk/Ock9sVP5AsIaOC59OqefOugP1S1fFVc6CeAUi4ei26fMtGJ8d6/i50bx5B0h1an60
	qYLA1vb//rsEe0HtHlijAkmSUnp48EqcQMn2+LLoovXKY+CuP1Voetv+8mnITqtY6dcNgBLqqg/
	U+UcooMe8l2zkWOq/T9FgK0JR6VC8KPejMo6vtthf6S1c1qKTuqGLoUqQ2CqXNxR8qSRzn9e3nw
	oQ8tjbV7bYwV1Dz0y1M5n43CBeN3Gulw1Ssfv/53lyBkeqpZQ4zZXaJjWK2eU/JR4b15a8joBkN
	0pV64YebbHkCwl7y5uU/FTLlhEIsGKtUTKKc8QsfsppbPyvRgIOvi2Yi8cWUd9roULGiHFp1smy
	WH1g2IDhUYVXMzk57Grena0tCyOGaRw/tTbswZueNWyH5Goyjs6TT9CmU=
X-Google-Smtp-Source: AGHT+IE1L1Ay8HW6UUCOK2aayvhSOQzq9YQZfDJ8iNiwvG6IDl8G5BWC8hEpb22SwUIsiIXqeIYkOg==
X-Received: by 2002:a05:690c:6810:b0:781:64f:2b67 with SMTP id 00721157ae682-781064f35fbmr52711367b3.67.1760136973168;
        Fri, 10 Oct 2025 15:56:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-781071f868bsm8896557b3.39.2025.10.10.15.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 15:56:12 -0700 (PDT)
Date: Fri, 10 Oct 2025 18:56:11 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 17/49] builtin/repack.c: pass "packdir" when removing
 packs
Message-ID: <aOmPC6J3equX1rPC@nand.local>
References: <cover.1759097191.git.me@ttaylorr.com>
 <df75c3130bced8d5489dc9184701a0a544617049.1759097191.git.me@ttaylorr.com>
 <20251010060401.GF1965904@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251010060401.GF1965904@coredump.intra.peff.net>

On Fri, Oct 10, 2025 at 02:04:01AM -0400, Jeff King wrote:
> On Sun, Sep 28, 2025 at 06:08:16PM -0400, Taylor Blau wrote:
>
> > builtin/repack.c defines a static "packdir" to instruct pack-objects on
> > where to write any new packfiles. This is also the directory scanned
> > when removing any packfiles which were made redundant by the latest
> > repack.
> >
> > Prepare to move the "existing_packs_remove_redundant" function to its
> > own compilation unit by passing in this information as a parameter to
> > that function.
>
> OK. I don't think there's anything wrong here, but it feels like we
> ought to be able to pull this from the existing "struct repository"
> context that's in the existing_packs struct.
>
> I had to dig a little to find it, but I think that always comes from:
>
>   packdir = mkpathdup("%s/pack", repo_get_object_directory(repo));
>
> in cmd_repack(). So we'd have to recreate that string ourselves. It
> feels like object_database (or I guess odb_source) should have an easy
> way to get the pack directory, but it doesn't seem to.
>
> So I dunno. I think it is mostly academic, as you are just moving around
> code here. But as an API, the separate "packdir" argument makes me
> wonder if I can pass anything I like to these functions. But really, it
> should match the packdir used to create the lists in the existing_packs
> struct. So it's kind of a brittle API. I'm not sure how much we should
> care for this series, as it is mostly about moving code around, and not
> providing some kind of flexible repack API.

Oh, it's extremely brittle, I agree ;-).

I agree with your assessment here that packdir can easily be derived
from the repository object, and that doing so would result in a cleaner,
less brittle API. I'd like to make those changes, but again would prefer
to do so on top of this series, since I want to change as few things as
possible here.

Thanks,
Taylor
