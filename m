Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274A61F30BB
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 14:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781880730; cv=none; b=tgziFIeKqjsbh8SrvS8EEEWnanCPTF7x9e/y4LgKO+Vdf5aFM92AJwPcNCKYRUVN+HtZng0cmwmxvLodhbYfuwDswNhjkR2h+a1e8ji6x6ZR4D69er75TFfL+VPYWHVbO+XyvzuQh06kZfDEXsl58XG0Tv2vnHHhtZxB9lsJjmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781880730; c=relaxed/simple;
	bh=bjARHvmYx+0jdecatEwCY46bjpIivqYV5jRVJSfFus4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SokihgfZ3qvIHtv3znK72HYkP+fD/NYMQD2fXBVcueyvcIkqTyTtGidN0SvSuEV4CJ4RKz2hhtlzHo3uluSETIZR7+9No5ypVoHSEtjokle/JrycEkaxJ0ra0lBQZ9RIFZxZw70MLRAJnmGabAImT5Gc1mEPeb9nLwr6d7/SdnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=fn6aHPed; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="fn6aHPed"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7dd5a8dc8a2so17042827b3.0
        for <git@vger.kernel.org>; Fri, 19 Jun 2026 07:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1781880728; x=1782485528; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZzSuUmNFWJTpdO8h69Pj1aEUSSOo2HqzoWTxDaOIT5w=;
        b=fn6aHPedCOhram2kBZxn9k/p0JFefcCLkdMaoUsuH2xfKciAwnp167TEYdzro7W1pi
         E5BsTJWg8sGA5m+/hzGQcqXOBD23hzuAO9FyJOyrgQNSwDdpybst1aFxDrpMJgJDxA3y
         rrmN6uRBRrbxqxlFbMvOLvKLVTbVo3qOtk+uZvDz/UwncFPgJslJK/F8oMgJeMOnnUl3
         zne9DpwjZVVuwYvKSQWMrmCGG/+Xa/iv9OYnrRM1sslzZRW8S0YodgAggRvzjE62vPry
         ZZUAhEnsA7tN+3J7Vr9XOOhxzk5FBRbPYCPmyzVb6ceslDQLyA/rbpnuYQUK8qSbQ4Zt
         fhiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781880728; x=1782485528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZzSuUmNFWJTpdO8h69Pj1aEUSSOo2HqzoWTxDaOIT5w=;
        b=SZ4fxneK0C4f3PmvPV9+7qmcGgR/2qNEKWiNclOXZt6AVUm8yMn+AVhlbUupIzHlvg
         lw0/G4BSgvQy7GcDR5dpVewE9VRVQpPzpYPb0slL8Gcd5LXacWEMBGWJkYcpJlr+gstX
         1znadg5cvpoDYS4e+lwl3+o0/jnPkYXKlUUC5lDDPr0NhybgzDXGlImNFNlAEXEktXjy
         s0yNlRION3V2NPK/oaxt1ASlN99aCKdqDZFFIiTHeD9JBC7a4jwvqL07sYfhcYDcRrL+
         bSDPVxND/Ke8iNYTZPVaK99745HK/2uKzjJHjaZx/mn6q3VS3U/hz7W2E0P+BblSA7yO
         zg8A==
X-Gm-Message-State: AOJu0YxysMlSXZHt58BWZgE1Vh1O4Up4xf4kDCGgOPyYWY2qNciUZb23
	EfoRjgvQkTU2cXsD3EJzHXQWODG8miLpxCKi43aHNr2hi2PIWPtdrEPJ+6bQUYNeig0=
X-Gm-Gg: AfdE7clqlVXNOlrIa6K3fgvISemfMfTy+ZIQLggUriUpYblKu7zXrPFxGvrqBTVuMyQ
	zia/PXzFI4bXBjxXtUIWf+mVR9wiMuK/Jhms5ehn6NXMw3BLr5QUYgZVe4iqORVpMwcC1rUzmaD
	3O7YTjemuc38hJBzbBLI3zgrVUGSQ8l6eJUd3shMii0CIyNV+KYDuGIF+Type8I5Gawayuao/TK
	Wy24f3YPCKiNuDioBSfpeKBo/Kz3iAjkDJfka0zVl5pNaBJlC+cw0RRqtS20HD4umaVEq5Rg/FS
	rAmjQyqla2K98Zz+FJ88Pm+SMkErxMtbtlnUVhz06k748VuIvV062QwEOqX28s4aFz4X+gJAjL3
	nu+SIXRGc/t2ViYLUGo3vP/ELWidgtsyL/OAWd7BVcp/6NABxsFvEafowCDeEe4p1KZqGSP2IAz
	OqjixX8aRyQBVLkDEs0GV5aF2mR0kuOfEZsgzy06zOmlVXyi90s/zdFZ/S53Ir0mpYhx6yXPqAc
	DMu0T4fR7ERWkM/FNwxW9CFax2QC/HvY4w9Vuky+aZA0DAgVexwbKfoe2lca3mkdmW8k8SC+dKp
	O0aK1A==
X-Received: by 2002:a05:690c:63c7:b0:7fd:e030:23db with SMTP id 00721157ae682-8013237064amr31415827b3.31.1781880728017;
        Fri, 19 Jun 2026 07:52:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-80119810889sm12427987b3.1.2026.06.19.07.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 07:52:07 -0700 (PDT)
Date: Fri, 19 Jun 2026 10:52:05 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 2/4] pack-objects: support reachability bitmaps with
 `--path-walk`
Message-ID: <ajVXlcHgIF2XkmMQ@nand.local>
References: <cover.1779923907.git.me@ttaylorr.com>
 <cover.1780438896.git.me@ttaylorr.com>
 <ffad584a43ebf3cb2138e8dce7daef84ab72712f.1780438896.git.me@ttaylorr.com>
 <849c659f-efa8-430a-bfac-0c26a3ed1aaa@gmail.com>
 <ajVSHvL+On9AEV+g@nand.local>
 <131d7ad3-7791-4d6f-bdf3-afa6b0831a71@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <131d7ad3-7791-4d6f-bdf3-afa6b0831a71@gmail.com>

On Fri, Jun 19, 2026 at 10:40:51AM -0400, Derrick Stolee wrote:
> > [...]
> > , which gives us:
> >
> >     Test                                            HEAD^             HEAD
> >     ----------------------------------------------------------------------------------------
> >     5311.3: size of bitmapped pack                           278.8M            278.8M -0.0%
> >     5311.38: size of bitmapped pack (--path-walk)            278.7M            278.7M +0.0%
> >
> > (eliding other tests). I considered whether there are other interesting
> > tests, but I think "repack" is the right layer to run perf tests, since
> > you're always writing a closed pack. We could try different subsets of
> > the repository's objects (which would also have to be closed), but I
> > don't think this is that interesting.
>
> This sort of thing does help to show that we're getting different
> behavior when repacking with and without --path-walk. And this test
> is showing the slightest change for git.git, but is likely more
> impactful for the other repos I've used to demonstrate the benefits.
>
> So this is the kind of data I'm hoping to see, but also with data
> from other repos whose data shapes benefit from --path-walk more
> than git.git and repos where name-hash v1 is sufficient to give a
> similar result.

I'm glad this is the sort of data you're looking for. I'm happy to run
this on other repositories.

> I'd also like to see if the repack _time_ changes with this, but
> these direct size comparisons are the biggest indicator I'd like to
> see.

Unfortunately a timing comparison is kind of a pain here. We'd have to
use test_perf, which will perform the same repack multiple times. We
could do that, though it's wasteful, and changes like bf4a60874af
(p5326: generate pack bitmaps before writing the MIDX bitmap,
2021-09-17) move us in the opposite direction.

I'm not opposed to changing this to test_perf if you feel strongly about
it.

Thanks,
Taylor
