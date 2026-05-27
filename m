Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53D712CDA5
	for <git@vger.kernel.org>; Wed, 27 May 2026 23:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779923919; cv=none; b=gX0wNC9uhPEWbgEnVEgCtoBtoBvl90MWxljn9wzXRugvG6k+mbfpCepd1mUE7QWlL8H9n3DdFrpi+oFOl1ySqf54bUfYo1kduGtyZgXWDC0uGrcBEssmpLA32fwiXyTsq9HRMZUgVLieBlmGL2luJri52dBlkO1d8VLjNvGILmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779923919; c=relaxed/simple;
	bh=l1cIscof9UmJeIgM2qeDxHEXKDLueqk6jFO2DrsARxc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SYN2oH3OIYuIYTMEZrZI4rUOpUjfg9Tu2zGWHrO4J8ZvLAvkA6aA8jtiTykbutyIQDov2FUcQshsoMny+0PR2ZiW+SOu8bGDzb3iYLqTOzvcr9QOJE2z2SLQbEm47JV8gNRCYV4ORd7y3KFmI3y52Jy7QCPyj+iqZOol69/u+J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=TVYioIv0; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="TVYioIv0"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-65e15fb394bso8613000d50.2
        for <git@vger.kernel.org>; Wed, 27 May 2026 16:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779923917; x=1780528717; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oFuwJOS6c3bE5wPc2XjLWsZibM/SYIFior3kGdYqbQg=;
        b=TVYioIv0LSOh92cxItPlc+zqV/WKCdvOTsTFoCWSr/Vvya7jbK1O4wQORIHfagccvb
         y7emMk37pFMS5vwh/mAKjsLwpaxt1x2Cs5Wdnv1swSO9e+qOMciiBV9fU+Wjx7P2pxII
         I3NG8MlvabQoOaJmv5wY4Eb2kcEnMYBmv2Smmd0MuwdTavsGL+3tJV9XXEAbC1b/lm2y
         Uh9BVWVMxD+E9j8FsZZboUV5lqg1CV5YY9Looii3WGpQ2dtOdHMMRU371XE9MkK+wsq0
         /BZ3F3q5VlgHMb8INJAOQH08PkNsRWrpgh+Nxgh8BcSBYlrNhXJ5NYj57Srqj4hVl+h3
         xVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779923917; x=1780528717;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oFuwJOS6c3bE5wPc2XjLWsZibM/SYIFior3kGdYqbQg=;
        b=hAifZx6H/PIm2PVma/+0bmc9Hhf3Ok6sIyLKPGIlqNA5HBAa5Cuc6ZwGrZRPm2NkFm
         pqfYqHN/gLryzfUXDbPortkIksv5OPSlNbBDuBvtg1v5N8B85T0o1JagUj7D9OlhjQox
         nZTmHFN8v1lwMuWDEf29IDZJ8e8F/K089ARsy4sVeUiW4qkS9Mc2Y58ifqv7xdvlgKNG
         q42P7LAVpFIwVoTNmzs0a6fPiX9b4PsZhm1AfGjnqRaPRKNzKXY/iYj5LpPYIfbxk8P9
         Pb7UparmqFxKv8RsZKp2Ofg4gpYsZeC0da5X7X2VtQ1UkgM4WkGFS45hhFHTNTTnWqmr
         hLeg==
X-Gm-Message-State: AOJu0YyQJX+TSPXvT0rUBpXhKErc6ucZqM54CkuhmNZVRFR+sGP3qkGK
	uDdkfva6BT72xzsE8cwSh570fAANf0Iusq3p99kaW9J/aUo9aRYdhyN2fPKfdMZwHd6jqlECkMI
	bbMR/SMI=
X-Gm-Gg: Acq92OGjH0iR3zHV3z5bqUYjAi4PvcNGIVlNqPBrRT+8W3eHKk3UU81L69qO0XM//cM
	CeEWk3x2oMTl0FJs8fp9EobwEvy7if7/3JwNXZDGHLIoWtsDWaH6CFFyE8/LtBiYZEo6bE4JiCv
	9jFu/6un0uYes1iiQmjIgtdzVJ0dn5Hm1weG7w7UzZz6VdcjOSKvkEE9FFTHVBBV+3eLN6cGuE+
	70V6TrkLT9zgcNBgVfDahErLS7KPjG0pYFyalxOtM+UelnCBzGUDjDt8BujLP/VFY/CLSVfCa/0
	T6m+ktLU3w0sOk2Qa3SpxvxiQoC1gt1xd6LuET3WMupmtaUhyJvvIJlPJ9ZRI+B0sU9HbHzGb0b
	L97bFMOU4OY9gd65y4+eeqEm/Mx+Vekldc/uIRGv+TuJF7CbrqOcPQCgUH4ZdpNKffE92CiGhcp
	FqjwL4F/RJM4ZyEK+Nw8eykg11mllZv8vzUN3Sh1jHJZuJDfm6+aGZccp8QZRmIfT71+G6VIfnK
	HnAaH+r+BO4q6J/FbYJb4ASYZFY7HYntkKltVIqZN0dXpUlkQfxwzF2cHewyD3q7z60YmzIrVNM
	p3xixAWI9XU88arStLLiiHF6ABs=
X-Received: by 2002:a05:690e:1596:20b0:651:8d82:acc2 with SMTP id 956f58d0204a3-65ec99cc4b7mr18800423d50.63.1779923916663;
        Wed, 27 May 2026 16:18:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65ecfdf4bd7sm8168464d50.19.2026.05.27.16.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 16:18:35 -0700 (PDT)
Date: Wed, 27 May 2026 19:18:34 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: [PATCH 0/3] pack-objects: support bitmaps and delta-islands with
 `--path-walk`
Message-ID: <cover.1779923907.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Note to the maintainer:

 * This series is based on 'ds/path-walk-filters' with Patrick's
   'ps/clang-w-glibc-2.43-and-_Generic' merged in. The former has since
   graduated. These are the three remaining patches from my earlier RFC
   after Stolee's series incorporated the filter-related pieces.

Here is a trimmed-down reroll of my series to make `--path-walk` work
with reachability bitmaps and delta-islands. This series was originally
an RFC that was a companion to Stolee's recent patches to extend
`--filter` support to `--path-walk` [1].

Since the previous round, Stolee's series has graduated and incorporated
the filter-related patches from my earlier RFC [2]. What remains are the
three patches here that implement support for reachability bitmaps and
delta-islands under `--path-walk`.

 * The first patch allows `--path-walk` to use reachability bitmaps when
   they can answer the request, falling back to path-walk enumeration
   when they cannot. It also lets bitmap writing see the same commit
   candidates that the regular traversal would have shown to the bitmap
   selector.

 * The second patch is preparatory, and factors the
   delta-islands-specific tree-depth recording from `show_object()` into
   a helper.

 * The final patch teaches the path-walk callback to perform the same
   delta-islands side effects as the regular traversal: propagating
   island marks for commits, and recording tree depths for trees. This
   gives `resolve_tree_islands()` the same input in either enumeration
   mode, so the existing island checks can be reused unchanged.

Thanks in advance for your review!

[1]: https://lore.kernel.org/git/pull.2101.git.1777731354.gitgitgadget@gmail.com/
[2]: https://lore.kernel.org/git/cover.1777853408.git.me@ttaylorr.com/

Taylor Blau (3):
  pack-objects: support reachability bitmaps with `--path-walk`
  pack-objects: extract `record_tree_depth()` helper
  pack-objects: support `--delta-islands` with `--path-walk`

 Documentation/git-pack-objects.adoc | 12 ++---
 builtin/pack-objects.c              | 68 +++++++++++++++++++++--------
 t/t5310-pack-bitmaps.sh             | 36 +++++++++++++++
 t/t5320-delta-islands.sh            | 29 ++++++++++++
 4 files changed, 122 insertions(+), 23 deletions(-)


base-commit: 45a9ecee26839cc880fdd5e704339dd3cf4ffc26
-- 
2.54.0.22.ga642305e3c9
