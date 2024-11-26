Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A85F4C8E
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 06:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732601916; cv=none; b=eJy4LnAbVz3L+JfQe9K1GnFcbsILo+uRTiFAFXgZQDfWk47lIM3Pi5sPNFPJyQkmzLuUXDMiyooPjNgYtwcbxewP+foNc+U76jz7ZG57pd9sn3wkBxTZxjJnrOc58YM4Qq0f5zLESRo43HMwUW8nqPK2uoSW0B8Lr6x7IiAyMUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732601916; c=relaxed/simple;
	bh=wNdGtqNaCMHz9p4zPUoNd1k80aqCWUnw5tnozTChOs8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mVrxWkBEe+Vwk3T0DX6tGa4TdZVBSN8zScX+IO7rr+la4CjJ2yz5LoXwydHPZA3mnPdED7MzfAHTHnF4G8Y/CqLXXugbiVWCHUpnOsjwrK8D+C/pu7tBx1JWtUDJ7IVIvAjgSnGC0y7pYNqcDF302jLZDuBDy3cntm9+rBfLs3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HTKfE+H0; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HTKfE+H0"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 063C013803AF;
	Tue, 26 Nov 2024 01:18:33 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 26 Nov 2024 01:18:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732601913; x=1732688313; bh=tnKO8s1uP63B7O2jsCPtokD7Xjb5wIngkQ2
	o6lUcq3E=; b=HTKfE+H0spt4NqI4l5+wWriKHgCa3tFljyKfpW8NPxmtCNg/ubc
	FYD0mQAgzPEAYf8W8uhKaPb3ZeS3X9M5B7QuuA2hipYgkBLQAK4LWehjQi+7AR/9
	YxzqGIqMeNVxsUMdJDaVeETynJC8YOe6Ruga4ATVjlwQanEWD4Vy3/7TFpDCdps1
	JJVmAFwGx2ZzLtDEosoxjv5oGZQbix6tYbbAkKx+Bc58Ub/V196p6KAgV3PDKNgE
	Fyfb+4ZF2wwS5gGL1cQpDykAT1gqjftzHXqTDOerEpcR5AuKGxRvGdhIst2gDQ+4
	kNvoFw5LgXDSkqwYTbp4oMFdMeDGZAEhHTg==
X-ME-Sender: <xms:OGhFZ051Abmf-zLTtX21PGXC2HUPYRnHHd1HIyoUrfyjQoUwwgOyMw>
    <xme:OGhFZ14i4SQjHDEXZ-m0454DJ4LMg9kB-QDk319r7zYVl4_CxMB9AXC86Zn5Z7V9k
    2y5b5HDVju1LkXL9w>
X-ME-Received: <xmr:OGhFZzduxCKhGsiS2beTAccG2wyIGbpmLQAxO-UMDqo68BELYGhF_PnXLayBRHZNes1XYlBRmbGJBGxrjVqAIBsMyNsFnCI2xv7LEzc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeigdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtugifhhhithgvfeesph
    hmrdhmvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehphhhilhhlihhprd
    ifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehs
    uhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:OGhFZ5LDP9pj67J1aeEne4vZ5kkvjJQ5a2jsPFUwU8rJZ34Fuy2wTA>
    <xmx:OGhFZ4I1t1lV363BAPoH_h9zvLYaY48vOf7vQaEaV4yJi0JGXPosCg>
    <xmx:OGhFZ6ww011HszOAzQrgbUq60LJCueayb-_V6XzQzy-7CKq7_vFIuw>
    <xmx:OGhFZ8LS0ymrf-fpfPEieBEdsvAVyEy0rqDOc1Fz4yRfEFJ7gfDtiA>
    <xmx:OGhFZw_KDg-8O5xXVTQaJNrmaHSn9hM8zup1hdJeNy60-16ABtqY0f6o>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Nov 2024 01:18:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 0/8] Allow relative worktree linking to be configured
 by the user
In-Reply-To: <20241125-wt_relative_options-v5-0-356d122ff3db@pm.me> (Caleb
	White's message of "Tue, 26 Nov 2024 01:51:31 +0000")
References: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me>
	<20241125-wt_relative_options-v5-0-356d122ff3db@pm.me>
Date: Tue, 26 Nov 2024 15:18:30 +0900
Message-ID: <xmqqv7wazfex.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Caleb White <cdwhite3@pm.me> writes:

> Changes in v5:
> - Added docs to `--relative-paths` option.

You already had doc on this, but the default was not described at
all.

 --[no-]relative-paths::
+       Link worktrees using relative paths or absolute paths (default).

> - Added test coverage for `repair_worktrees()` and relative paths.
> - Move `strbuf_reset` call in `infer_backlink()`.

This was more like "revert the change in v4 that moved it
unnecessarily", no?

> - Cleaned up tests.

Yup, there truely a lot of test changes between v4 and v5.  Many
tests now use existing test helpers, which is good.


> - Slight stylistic changes.

I saw many changes like these (the diff is between v4 and v5)

 static void repair_gitfile(struct worktree *wt,
-                          worktree_repair_fn fn,
-                          void *cb_data,
+                          worktree_repair_fn fn, void *cb_data,
                           int use_relative_paths)

which looked good (the original had fn and cb_data defined on the
same line).

> - Tweaked commit messages.

Updates to the proposed log message for `repair` step [7/8] did not
really "clarify", other than helping readers to see how messy things
are.  It said:

    +    To simplify things, both linking files are written when one of the files
    +    needs to be repaired. In some cases, this fixes the other file before it
    +    is checked, in other cases this results in a correct file being written
    +    with the same contents.

which may describe what the code happens to do correctly, but does
not quite help building the confidence in what it does is correct.

Suppose that the directory X has a repository, and the repository
thinks that the directory W is its worktree.  But the worktree at
the directory W thinks that its repository is not X but Y, and there
indeed is a repository at the directory Y.  That repository thinks W
belongs to it.

If we examine X first, would we end up updating W to point at X
(because X thinks W is its worktree)?

Or do we make W to point at Y (because Y thinks W is its, and W
thinks it is Y's)"?

Either way, I think the comment is trying to say that, if we decide
to make X and W belong to each other, we'd overwrite links from X to
W and also W to X, even though the link from X was already pointing
at W and the minimum fix we needed to make was to update the link
from W to point at X.  Overwriting a link from X to W with a new
link from X to W is a no-op, so it does not seem to help greatly,
since `repair` is not at all performance critical.  The correctness
is a lot more important.


> - Updated base to 090d24e9af.

This made it harder than necessary to compare the two iterations, by
the way.


Thanks.
