Received: from mail-yx1-f67.google.com (mail-yx1-f67.google.com [74.125.224.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185621391
	for <git@vger.kernel.org>; Mon,  4 May 2026 00:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777853478; cv=none; b=L6jk4Dvm3T6vDitYLc1wSpOeW+WtaUtT7CvWh/Lkg9BlmW61w8aA2JhwDcuH+9vs8HolyZ9x3OoXV5jxPcFXzZmZuljIntm3SWU/K0ElFUBEQD0lQtg27MfMK1WiXM6qSg0Mh7lxMlf5I67ATjbrn92F+2yHz9vVbrHmNf2NgOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777853478; c=relaxed/simple;
	bh=Sku1S54gVQSLF4WxYiR6ekGdxuT7ByB2xOOi4dubSn0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F2g0rYKlcC6ilv03l32zu7+ENdSA+WOZeVBZ2vqKbEI1cdP/RhU7hEpUvHL+A3qnDoM0HqcCDFNjtCUlxQZPen5d0Ce76OMpY7ooTJHX8uClBn8xphWdjlrGdD7uPsU2CA9yHr42s0O9cVfblsGzqSUh8alWBbn0zPvX5DrqYUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=cJlhQ5Dd; arc=none smtp.client-ip=74.125.224.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="cJlhQ5Dd"
Received: by mail-yx1-f67.google.com with SMTP id 956f58d0204a3-65c396d3b36so1654117d50.0
        for <git@vger.kernel.org>; Sun, 03 May 2026 17:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1777853476; x=1778458276; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B0O9ZuiQTlFf4PoryHsePJQfaYK3o9E/0BYEqZin3bk=;
        b=cJlhQ5DdLl6fzMeFE83Rv7OeNox55OVoGQw/PhdB5bWWW2QNxAE93Pc68M7XoVEI61
         XwUsOYcFOdpMouRdaqmDfLhnL9MSWU49hSXatlm64RxwDietTrjRF/8anzQFHUmAjr4t
         rfpfJp9dnklXdxnaLDVl4tr8jYHA8qhrAUfbauwPZCACe/nbAWB89C8+tvlsKpIGQkPg
         tbMkCEAUSyvUIpwQuWzvCyn13NNljJPM3t/XBmMWu1HjUKdYmX04agscd0AhzOv/b3lS
         nxDDDbzq899qell8reDtrrJJIcundlszLbTwvm0+pUKibYijQU+mIlQMvF57v+KcnKY+
         cdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777853476; x=1778458276;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B0O9ZuiQTlFf4PoryHsePJQfaYK3o9E/0BYEqZin3bk=;
        b=fpGfnFOuizkPaI+hEWaLfMSV21QKlZVE3+1DOAj2k8kYpR2jZ1ouExgNY69Z2XMPhW
         XekOcnX+Rly99djDhNWhJ3wVo0IJqAczyu4uNzRQfhbf/176zwqoY1KbjiVXH5SKMtaq
         n1B7WMl4yX109jyRVR0SMUWFGk0YkNq9YEDvTXViApFsapznsfs4SaTJSbSHtz5rIhWG
         HtQTzz/TRo3AkHmTtjJ2ckG8n+74wZMXuDXyrmLbVloD6DVK9zDGpWzg7xIqPPTuY2JW
         JM3Gl9ln9ZUC/+72JW7vt0ai1WRXvVgANJR8cf9anJqf+3GxK5p/8GewKJQnCAtxsZbJ
         SMIA==
X-Gm-Message-State: AOJu0YyPXFRIkXaYvuvp/VfDuqpaoJfOK5vh0TwvIf9fM1ecCTRqli7q
	RxqHHXo8JAsqsfn+/NEhvAe7ED5n6tD+A1POlAWoA97SgOZVZ5y1sqcGvMHDwnocYswbERdpHLX
	Hibbz/qy023Eb
X-Gm-Gg: AeBDieuRMKr2kRzPknRYsLfpW5Ob6Issg4xPdItpc/Vv4rePUlRx+paqcgbfl4pZU/l
	+QXCjxY4EGiS2XQ81QSVK9BCjwJrAO5Db9qS9/UttgzDzOU7Jc/N69ikcZolQjMDtKHZKfU/m42
	K8PImzS4rHIiQqzJH0bquMWlGkiw1lZ8f3xyoew6hc6foPBmRzMCz7zqtjyxZLGOveSxlR4C3cT
	fQW4iftOKDSpMy/m1OFf+laIjMiCr0WEIH+LzOd4bCs7piA3e6oAhv0UpRySmePOt1GbC+h2VzZ
	1b/jwdduW25roq557oZ/rfa14VQBweijSLKYW3+m5vY6fGGoQpvhlDuCJjveH7UKMAGi+9WhtCq
	pMg0cm812lb52hxkB94v1ioh65CqKHwkI7zdoSTU5fiNZX/PZFPPl+3GVq6EL3hIJKAFZXOdcEO
	hukyV+7wuin0CJy82h9a8/7hkggolJh88a7y7iHkoHjOJVNB5NDnWHsiojskP9KsQjHgJjoKEUA
	yHdtd61U6SefgPZK4nmUXQOVBo4/xXVBdYta5tdmdCVQT2BYJtLCfmEHvI+jzBW1F3NZLcs/o8d
	X6rSf108Aqfd9WvR+cHmmJA+LvA=
X-Received: by 2002:a05:690c:660c:b0:7ba:f3a2:5535 with SMTP id 00721157ae682-7bd7710423cmr76139337b3.31.1777853475827;
        Sun, 03 May 2026 17:11:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6652742csm41797927b3.9.2026.05.03.17.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 17:11:15 -0700 (PDT)
Date: Sun, 3 May 2026 20:11:11 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Derrick Stolee <stolee@gmail.com>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 0/7] pack-bitmap: resolve various `--path-walk`
 incompatibilities
Message-ID: <cover.1777853408.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

(Note to the maintainer, this is built on top of 'ds/path-walk-filters').

Between other tasks, I have been working on trying to integrate
`--path-walk` within GitHub's infrastructure. In order to do this,
`--path-walk` must work with features that GitHub depends on, such as
reachability bitmaps and delta-islands (along with filters, shallow,
etc., though more on that below).

I had been sitting on these patches for a few days in my fork before
Stolee sent his series in [1] which resolves incompatibilities between
the `--path-walk` option and various filter types. Since I figured that
others are working in this area I wanted to send a reworked version of
my series for a couple of reasons:

 1. Since reviewers are already looking at this area as a consequence of
    Stolee's series, this topic should be slightly easier to review
    while the area is fresh.

 2. In case Stolee (or others) are working on resolving the
    incompatibility between `--path-walk` and either delta-islands or
    reachability bitmaps, this series can either combine with those (if
    any) or serve as inspiration (if others are in the process of
    writing such series).

When writing this originally, I had borrowed the same filter-application
mechanism from bitmaps, which supports trivial filters (e.g., blob:none,
tree:0, and combinations therein). Stolee's series is a strict
improvement on that approach supporting sparse:<oid> filters as well, so
I reworked my filtering-related patches based on that.

The patches surrounding bitmaps and delta-islands are largely
unchanged from when I had originally written them:

 * Supporting bitmaps with `--path-walk` is mostly straightforward, and
   boils down to ensuring that the path-walk-specific object callback
   indexes any commit(s) it sees for bitmapping.

 * Supporting delta-islands with `--path-walk` required a bit more
   surgery, and involves propagating island marks for commits in the
   path-walk-specific callback, as well as recording tree depth
   information in the same spot.

I'm submitting these patches as an RFC, since (a) I haven't thought
deeply about the approach taken here and could very well be on the wrong
track, and (b) in case Stolee or others want to combine forces here
and/or coordinate around each other.

Thanks in advance for your review!

[1]: https://lore.kernel.org/git/pull.2101.git.1777731354.gitgitgadget@gmail.com/

Taylor Blau (7):
  pack-objects: update `--path-walk`'s existing incompatibilities
  path-walk: support `tree:0` filter
  path-walk: support `object:type` filter
  path-walk: support `combine` filter
  pack-objects: support reachability bitmaps with `--path-walk`
  pack-objects: extract `record_tree_depth()` helper
  pack-objects: support `--delta-islands` with `--path-walk`

 Documentation/git-pack-objects.adoc |  10 +-
 builtin/pack-objects.c              |  62 ++++++---
 path-walk.c                         |  63 +++++++--
 t/t5310-pack-bitmaps.sh             |  36 +++++
 t/t5320-delta-islands.sh            |  29 ++++
 t/t6601-path-walk.sh                | 196 ++++++++++++++++++++++++++++
 6 files changed, 365 insertions(+), 31 deletions(-)


base-commit: 465ceb37112ddfc6338727887f4431e755bf1831
-- 
2.54.0.4.g6aa0d38a4ec
