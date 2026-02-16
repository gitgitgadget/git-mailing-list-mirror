Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55D9242D89
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 06:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771225008; cv=none; b=Ydx2+i91CcRgnRYoMbEWEDMzLQiRFO/uz7yMYZhi+UHVGi7Ywfmvm4F2/Z7zJw5C3de3ljirDIsrkrQyPoAbhL/qLc6jz9nP3zAqiPyrXumw0PE5uiBZHoJCFsoMoc0qKLcXJwyCY0UQbhsZbRu8WSOZqqA8t6xXix3c2Lvd90I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771225008; c=relaxed/simple;
	bh=vAGTvp+WM/1PtYDgT10UyBuHveZEIDYnxnsAXbgY3Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1sts9Ym2GgyqeP5Gm6UWnea+JUXyOgn7DQz8IaaBheos7G1351ocgbE4u2mph9jzFklFYpfcEGVaD9Hm3Oh81Kcrw3bnP0Iw94cTU2+RtGH54XjXV+TzxVQvehtJA1/0UB9Wt7XAUQVVhydmiQPUq6Vl5Wtz9DHg9f+JbhLE4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IUqIXrCK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ca8uFAnd; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IUqIXrCK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ca8uFAnd"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2CF3B7A00B1;
	Mon, 16 Feb 2026 01:56:46 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 16 Feb 2026 01:56:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771225005; x=1771311405; bh=blqMbcRfzs
	0V7iFTybZEmM3WckAcdY9ONzs9ehhrQb4=; b=IUqIXrCKH8LU/O09HjT6dQJfq5
	L3S1GkSGYQGBXYqwm6HCK1mArYREyY1yECBL6gUK4D1Pbsq51HjdrcS4L6k2GroE
	BF04wDmlZ1Ctq4jAg/LLzAz6Mav08QVEryiEyelB8IAq/Ass/9/FeIEC83aHspax
	1UxVLaw4SgNwobBBnC3pDyU1F78LqXpiuVNN5Hd0Jsf8IIOnRNqKNTW4xLGrhgJe
	9+Tu/s0U+ranuhdFgbfvx3FLb5zVtO/N4Qot1ET/v7RPqq2mkG7Lq9tD8G4X4skF
	1J4RzGG/xa8MakQcMGUkxOL7WNGKzLAUsiZhqZdjNUjcLOJGIvoYuhLcKE9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771225005; x=1771311405; bh=blqMbcRfzs0V7iFTybZEmM3WckAcdY9ONzs
	9ehhrQb4=; b=ca8uFAnd3g1pDRl/ZY7mPhR9VQVaVQR99pYOCEDntsdw8k3odfL
	HYjGNPRTVf0GVii4L2XFnf2AgG5xx9e7Yf6+ptocLGAOaNPK52ILu2Q3P7wNgYJN
	Xt7fFthoQNtJ+H8PLljtVofdKCLSOPDTNoMY7FuxtVFGhwsdkSOq1vv9ZHosQYZj
	IvXlwxK+ENKycJHMrJX896cHz4kBaWCSvsZwNqrOC5wGldv5V7eCuCXVUYCr4V4F
	VBY2+/40mWOQf3QubPciec96UvY4uy6ZIH1hESTLBjQdFBmPOKAcpdnnyUytrCIC
	dTqJwNlAvNDUoJ0rOPhdc34nwg5RSneDcJA==
X-ME-Sender: <xms:rb-SaSy7goZzHNdms7vQVI0pfarNldRnaNV0DpQER7eaZW0ND3u66A>
    <xme:rb-SaUTZ9kbsQIbk5vJk5i04t4TDuyFM6kA2FGXhBhzazPSQDSBSPXO-7b1bmJVu2
    sPjgj25AfpNUqTl9hyhZOUVA7SrOiHLtkmfuH_o24i3zWhzCLez_4I>
X-ME-Received: <xmr:rb-SaR-QRnWsQaFQilalQXoU_rLxsbmNK5odfUxZUBTn2W7a6mf3oFF7Kb6g-jMfoC9LaqeOIwjuNbbG1dGo_845BpMrIatUxAoRzj0VGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudeivdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeegtdekieekteekteejtdeljeeuudehjeekue
    fhveelgffhiefhtdegveelteeikeenucffohhmrghinhepmhgvrhhgvggurdhpshdpghho
    rdhpshdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:rb-SaTqA9Toh8yLvY036nADqAUTZQE_2gjYK3Ui0Up5mZBbx4eeTUw>
    <xmx:rb-SaWky-hYFJqMOXwlfd69CPZdcNOkWk1QMgGW0mv4x9i_SziBObA>
    <xmx:rb-SaSK4NbbT2zDQyY2i-k-pe3DVUCr7LDob9itevsBmvCIP7tcgjw>
    <xmx:rb-SaTylOu-dl6h6P8ZWYFB0W06RGpFMeENxoSMl64sBsgFCfSjQdg>
    <xmx:rb-SaWLPkKRqSTKTPyGWdayQ2eZJaU5y01tB7lE3n-YYNXg1JIBtFKS6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Feb 2026 01:56:44 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5343b63a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Feb 2026 06:56:43 +0000 (UTC)
Date: Mon, 16 Feb 2026 07:56:40 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2026, #05)
Message-ID: <aZK_qHzKslgb_P_O@pks.im>
References: <xmqq4inkhymy.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4inkhymy.fsf@gitster.g>

On Fri, Feb 13, 2026 at 06:01:09PM -0800, Junio C Hamano wrote:
> * ps/pack-concat-wo-backfill (2026-02-11) 1 commit
>  - builtin/pack-objects: don't fetch objects when merging packs
> 
>  "git pack-objects --stdin-packs" with "--exclude-promisor-objects"
>  fetched objects that are promised, which was not wanted.  This has
>  been fixed.
> 
>  Will merge to 'next'?
>  source: <20260211-pks-pack-objects-stdin-skip-backfill-fetch-v1-1-870cad56d8ae@pks.im>

Yeah, all the reviews have been favorable here, so I think this is ready
for next.

> * jc/doc-cg-needswork (2026-02-12) 1 commit
>  - CodingGuidelines: document NEEDSWORK comments
> 
>  A CodingGuidelines update.
> 
>  Will merge to 'next'?
>  source: <xmqqldgxmzbj.fsf@gitster.g>

There's still the one grammar issue pointed out in [1], but once that's
fixed I think it can be merged.

> * ps/history-ergonomics-updates (2026-02-13) 5 commits
>  - Documentation/git-history: document default for "--update-refs="
>  - builtin/history: rename "--ref-action=" to "--update-refs="
>  - builtin/history: replace "--ref-action=print" with "--dry-run"
>  - builtin/history: check for merges before asking for user input
>  - builtin/history: perform revwalk checks before asking for user input
> 
>  UI improvements for "git history reword".
> 
>  Will merge to 'next'?
>  source: <20260213-b4-pks-history-dry-run-v2-0-756ac376e9e5@pks.im>

I've sent out v3 to fix up a small typo here.

> * ps/meson-gitk-git-gui (2026-02-04) 1 commit
>  - meson: wire up gitk and git-gui
> 
>  Plumb gitk/git-gui build and install procedure in meson based
>  builds.
> 
>  Expecting a pull request for gitk.
>  source: <20260204-b4-pks-meson-tcl-tk-v2-1-5bc3ccf3a8ce@pks.im>

That PR for gitk has been merged now. The build for git-gui still has
some issues (e.g. no askyesno helper), and fixes for this are in review
upstream [2]. I think it's fine to merge this regardless as it won't
cause builds to fail, but I'm also happy to wait for the git-gui bits to
settle first.

> * jc/checkout-switch-restore (2026-01-29) 2 commits
>  - checkout: tell "parse_remote_branch" which command is calling it
>  - checkout: pass program-readable token to unified "main"
> 
>  "git switch <name>", in an attempt to create a local branch <name>
>  after a remote tracking branch of the same name gave an advise
>  message to disambiguate using "git checkout", which has been
>  updated to use "git switch".
> 
>  Will merge to 'next'?
>  source: <20260129190616.645471-1-gitster@pobox.com>

I think this is good to go.

> * ps/for-each-ref-in-fixes (2026-02-05) 4 commits
>  - bisect: simplify string_list memory handling
>  - bisect: fix misuse of `refs_for_each_ref_in()`
>  - pack-bitmap: fix bug with exact ref match in "pack.preferBitmapTips"
>  - pack-bitmap: deduplicate logic to iterate over preferred bitmap tips
> 
>  A handful of places used refs_for_each_ref_in() API incorrectly,
>  which has been corrected.
> 
>  Will merge to 'next'?
>  cf. <aYmleK3kGqzLXyJe@pks.im>
>  source: <20260206-b4-pks-fix-for-each-ref-in-misuse-v3-0-1e050c3d6a50@pks.im>

This has been cooking for a while, and the latest version did address
all feedback. So maybe it's time to merge this down now.

> * ps/object-info-bits-cleanup (2026-02-11) 5 commits
>  - odb: convert `odb_has_object()` flags into an enum
>  - odb: convert object info flags into an enum
>  - odb: drop gaps in object info flag values
>  - builtin/fsck: fix flags passed to `odb_has_object()`
>  - builtin/backfill: fix flags passed to `odb_has_object()`
> 
>  A couple of bugs in use of flag bits around odb API has been
>  corrected, and the flag bits reordered.
> 
>  Will merge to 'next'?
>  source: <20260212-b4-pks-read-object-info-flags-v2-0-3bfa9bb149ef@pks.im>

Fine with me.

> * ps/odb-for-each-object (2026-01-26) 16 commits
>  - odb: drop unused `for_each_{loose,packed}_object()` functions
>  - reachable: convert to use `odb_for_each_object()`
>  - builtin/pack-objects: use `packfile_store_for_each_object()`
>  - odb: introduce mtime fields for object info requests
>  - treewide: drop uses of `for_each_{loose,packed}_object()`
>  - treewide: enumerate promisor objects via `odb_for_each_object()`
>  - builtin/fsck: refactor to use `odb_for_each_object()`
>  - odb: introduce `odb_for_each_object()`
>  - packfile: introduce function to iterate through objects
>  - packfile: extract function to iterate through objects of a store
>  - object-file: introduce function to iterate through objects
>  - object-file: extract function to read object info from path
>  - odb: fix flags parameter to be unsigned
>  - odb: rename `FOR_EACH_OBJECT_*` flags
>  - Merge branch 'ps/packfile-store-in-odb-source' into ps/odb-for-each-object
>  - Merge branch 'ps/read-object-info-improvements' into ps/odb-for-each-object
> 
>  Revamp object enumeration API around odb.
> 
>  Will merge to 'next'?
>  cf. <aXk2FjTUMMThs5Kp@nand.local>
>  source: <20260126-pks-odb-for-each-object-v4-0-5a64a038c791@pks.im>

Same here, this has been cooking for a long time by now, and the
discussion around mtime has stalled after I clarified intentions and
future plans to evolve it further. So I'd love to see this merged.

Thanks!

Patrick

[1]: <aZBMQGQPiE3cJBUq@ugly.lan> 
[2]: https://github.com/j6t/git-gui/pull/31
