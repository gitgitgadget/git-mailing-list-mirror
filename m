Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718281F03FB
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 01:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756258732; cv=none; b=SDajigEUckiyeaHQiS7TA/G7UZqcP9GCjcffpoViNQ9CBMEUVMp9k79En+BPWG7DlwRPpeZ65X31PAiLSXy1hbnZOodAwHp/Wq2dbU8ou0m/6fipmr5vjC8iP4qzOmcKOMxhZlICoaO7BrPl4bEJZ5j0rf/d7l+LdR+7ywMH1Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756258732; c=relaxed/simple;
	bh=Shrkt3KO26MhveaI1T9cDsjLX799JCLPMZkOmFTcoGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Za+9XPAygxK2f4aq4Xi8bLsey98U/CRlVr+Ez8YzX0TkM4E0NobaGkbnp7lxrfj3EFGOB7Cq2cTNSmaGXhEnpm4u+yL9QHe2u4GGYOMZTq9iif08SxFKTIwp8y8dPjeC55xK3u98gqGWWPCYoarihWRiTCKavmODqZ6e2MQoa3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=h/UqsaiU; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="h/UqsaiU"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-886dd6e5c2dso241858239f.3
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 18:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1756258729; x=1756863529; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jjj86W9KHBbxagkHAFfKaDSqNMToUjpFTevQJ1+d5/k=;
        b=h/UqsaiUNXKasYwFiDOSX1SYxdOX67X12c5iK4eiMRWE1pwwVREXahNtyFnIc7IzFs
         ygyAAdFMblfrokaMjjURwtrrBkB0VaEFi7d4uFPkuQT4uWm35te5jCV0j+GiE3q7tyya
         8tAMWKyi1bL7B/C46Rn/2EblV7TVW4jcWfZJwkP33kWm5fM3w+xGqIJgYJ/mXH12yjhg
         DK5DG9IWrYRlaG+MKC7TeMyk7+omh1IBbS/xUJ3vy15DGWsuDuDTgblEH/W1yk+5cLVk
         5aCbAHTUaf5DzUSvsMIkNMI9py4NEcTZOzOMoz5VImI9THZVngzm27nn+H2VoPND0rq/
         P05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756258729; x=1756863529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jjj86W9KHBbxagkHAFfKaDSqNMToUjpFTevQJ1+d5/k=;
        b=kzxnjr7WPJecMtzVK2osavM4VBS9vz5on4u6AN5MSD5KEahnsGhgu59hyFsNW0SxTV
         kEnou5UNJlkcww87ISlPZ+lUUSWkZ9AJpp4QOGCNUowPMBWIUI5tXC2c6K36neW/gg/n
         h3ZR249Vg1cI7oFHP8U/E7BIsZiORrcgsMcJD4gDb1c+nIkt5iYMDdYBn7s431XBy6dQ
         w0h2Mv/vkY2kw7un7yb+YJjvn+7DqwKwGMJP3LYLXsQnoIyD1ogTGhpCMBwMDdG4fJBC
         ymyGKTcGyZ6Ae8NqJvAns2hDMSgGmjkKpwD/Wa9mhqgPntfADonWnIRIWFmX7lU3qPhP
         TegA==
X-Gm-Message-State: AOJu0YwJvm/4azUGI/0dqj1530C7CpYwNx3mFd5QieXEy4ht8dXDXm3/
	DDmgnBiZ21kNFLn+l6qSbHowuZGd8fUD3FCdd8gS27dSkKN1YbK2tsWQS2ua54Sy7XBtFPXNcix
	2y0dp
X-Gm-Gg: ASbGncvj41lGt4UAC2SCjhvKJU2z5+CYbXHubcJphcPFy17vn4Vbx4Aa1Ij+tjmZrki
	ymry6ZdMccJNRmNOCLqRZSPJrysFAS3Gnm9bTVmhkihPhdbTcEmFfm/Oc2r/Oxk2CdnIDR7rXbt
	O2ZnuPfrsEkcsa5Oj+qBIAcqusGmPS3SbH/pJMskSwsvGuiYgDAhy9Xag6EJTHl5qbDpSbmkEX+
	uEFqQiO9XLpWgptJ/lIiwnfsg3wj3+2dX+EakFLEtrWJYUZamj6OIIChjMYUhmLPPZyguLrHIPU
	5BI3YLm4SrJE52Pv0aSZU4/tDBRS4QqSyYyesCRfTl1tmTmeYaGXg3LcLaXN4jVFrHSj7kvH8fm
	1s10tdKIMcPPiNOhS8iH0NXZR2dMtsUZc/VqEI9JHBOW0P+ZTd6GRoUx3k2EzZhZxh/2zayY4Bc
	x7CzS4qmMsd0wUIKds0WQX0pHUL290nhLv8j28
X-Google-Smtp-Source: AGHT+IFMF548fZKWxnrq+uCZyAHDeWlGn06RKebJqc5nGFPqR7Q0IhIIjSq5P0UTvJwqlO52mZBctQ==
X-Received: by 2002:a05:6602:6c0a:b0:886:c53c:4649 with SMTP id ca18e2360f4ac-886c53c4a14mr2059987839f.17.1756258729367;
        Tue, 26 Aug 2025 18:38:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id ca18e2360f4ac-886d8779b31sm526908139f.6.2025.08.26.18.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 18:38:49 -0700 (PDT)
Date: Tue, 26 Aug 2025 21:38:47 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 14/16] packfile: remove `get_packed_git()`
Message-ID: <aK5hpwcCgjkgQB1N@nand.local>
References: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
 <20250821-b4-pks-packfiles-store-v2-14-d10623355e9f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250821-b4-pks-packfiles-store-v2-14-d10623355e9f@pks.im>

On Thu, Aug 21, 2025 at 09:39:12AM +0200, Patrick Steinhardt wrote:
> We have two different functions to retrieve packfiles for a packfile
> store:
>
>   - `get_packed_git()` returns the list of packfiles after having called
>     `prepare_packed_git()`.
>
>   - `get_all_packs()` calls `prepare_packed_git()`, as well, but also
>     calls `prepare_midx_pack()` for each pack.

Yeah, having two of these functions that are named so similarly as to
suggest they do the same thing (even though they don't) is unfortunate,
and I am glad that we are looking at it here.

> This means that the latter function also properly loads the info of
> whether or not a packfile is part of a multi-pack index. Preparing this
> extra information also shouldn't be significantly more expensive:

Right; get_packed_git() only loads the non-MIDX'd packs, and
get_all_packs() loads everything (regardless whether or not a pack is
part of the MIDX or not).

Are all of the get_packed_git() callers prepared to handle packs that
are in the MIDX? Looking through them:

 - builtin/gc.c::incremental_repack_auto_condition() skips over
  'p->multi_pack_index', so this one is fine to convert.

 - builtin/grep.c::cmd_grep() calls get_packed_git() but doesn't
   actually use the result, so this should be fine to convert, though I
   think there is some subtlty here.

 - builtin/pack-objects.c::want_object_in_pack_mtime() takes a separate
   pass over the MIDX'd packs before calling get_packed_git_mru() (which
   itself calls prepare_packed_git()). I think in practice this is OK,
   since we will have already handled the MIDX'd packs, but this
   function is now iterating over packs in the MIDX twice, so it may be
   worth adding a "if (p->multi_pack_index) continue;" in there.

 - object-name.c::find_short_packed_object() handles MIDX'd packs
   separately, and unique_in_pack() is a noop for MIDX'd packs, so this
   one is fine.

 - object-name.c::find_abbrev_len_packed() is OK for the same reasons.

So I think that want_object_in_pack_mtime() may need a small tweak, and
I am not 100% certain that cmd_grep() is OK to convert.

>   - We have already loaded all packfiles via `prepare_packed_git_one()`.
>     So given that multi-pack indices may only refer to packfiles in the
>     same object directory we know that we already loaded each packfile.
>
>   - The multi-pack index was prepared via `packfile_store_prepare()`
>     already, which calls `prepare_multi_pack_index_one()`.
>
>   - So all that remains to be done is to look up the index of the pack
>     in its multi-pack index so that we can store that info in both the
>     pack itself and the MIDX.

This clearly shows that get_all_packs() is not meaningfully more
expensive than get_packed_git(), but I think that may be obscuring some
of the details above on why it is OK (or not) to transition these calls
over.

> So it is somewhat confusing to readers that one of these two functions
> claims to load "all" packfiles while the other one doesn't, even though
> the ultimate difference is way more nuanced.
>
> Convert all of these sites to use `get_all_packs()` instead and remove
> `get_packed_git()`. There doesn't seem to be a good reason to discern
> these two functions.

The last sentence here threw me off a bit. I think the patch message
would benefit from some of the reasoning above about why it is OK to
transition callers over from one function to the other.

As an aside, I am not convinced that having one caller (in pack-objects)
that cares about whether or not it sees a MIDX'd pack is that great of a
reason to have separate functions. But I am also not convinced that it
isn't either. If we kept both, I think they would benefit from having
more distinct names, like get_all_packs() and get_non_midx_packs() or
something.

Thanks,
Taylor
