Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BE24430
	for <git@vger.kernel.org>; Sun,  1 Dec 2024 04:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733027897; cv=none; b=RsnVCgseXcT48go9kbPVxgp9gOuNEwk3bl56whNQVQcCPVc2Je1Xs1l53LJd1PbYnQ3YCREpWPr7hyFdc0ECWC0FKLTFZy3PlVB6mDTlcWF42saAS0X3XPFNlQNtZ4iVkVcSHTBIUrVU0H9a9RD44Sm+gZcisewSnQYGXIv0fp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733027897; c=relaxed/simple;
	bh=pAiI+uhz9akgEPMV08bK58hGVaQHk6ZRZsBN+1wIj/c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fD/ymTcti0PsjSYYiuYWbHtnkctpp06f4zL4ubCC17JaqHRG0Zqyw+8K6XR/sZXYuSb2m5mVLp1a/SFhw1Gz9hfho6FZULP2pB6yUInoFWDSANwSGe36rmvLGRjkGYdgmJUTamydzgz2r8tOI9T2X+Sznd5XBKeLSgtjbBdh2p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=z93pvOqn; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="z93pvOqn"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 9C59B1140108;
	Sat, 30 Nov 2024 23:38:12 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Sat, 30 Nov 2024 23:38:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733027892; x=1733114292; bh=hhJP99EPq5qM5zWSUFlWHIkn0iDM/vWXHsH
	FStFZnQE=; b=z93pvOqnGaMWmRHMUCZUe7VCBwuphZqGl7l1Nm73k+xcFJ48SZh
	Mc379LCHJyUN2QKw32DkRURuC3zm+wjUvACded+nu+Xvn2omhEXfcGcuDUgEQ3+Y
	9cK0zvTItLlOmrYnjUamm5ZrEMHoQynof08PffLGYnvWqU0p1K/jI7TeZKlbkcfs
	t9KTH7dSEBQOWtwrUh70UcQSXnXn4mca0It6qOEQJ9hlfsSv9uLEoxqGtAzdK3vR
	ZZWWyxl239+gbUISYZJ3e/C/n0EOBe+4ADMwxSo1QAiVFxHQMqPO6MYKF+W5IGgD
	Zi7R4j3jtkhCSznM4MpGdNKvvDm+C1TPQ4A==
X-ME-Sender: <xms:NOhLZ4KpuHRk7Xb8Nau8AgZWTkxXo-hFzIYZFRVitI_pMPZVXvH78g>
    <xme:NOhLZ4IUueKTA5PBmQUFtc5Ha9iMCNKhkwgEHDJU7gO_EwASoqgLWkGlTnl6FY_vO
    J-PwzZ4tdD3sjeOuw>
X-ME-Received: <xmr:NOhLZ4vfcmzc0_ulKwSrcRyu8pSik8MwAFHyXf1pOlDLjfLOUac2CY2T4i4Q1b4rjG4wgI3J44Qf7--Ei2Z8mRmEZedAj5VMQfnTjGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheeigdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtugifhhhithgvfeesph
    hmrdhmvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:NOhLZ1Z8x0S6jCz69N2_epTHrWuIdflpsXAZogDFYVd_PmU3tEhfzg>
    <xmx:NOhLZ_b4MPJ1eXYdltAe1pDlhEEJPVsqV-pGVO5TJzcMfyVvJ24uJA>
    <xmx:NOhLZxChNXZoFuVfozyx7NjM2qjaJ567emV8a9uuq7rRzs6cyw--IQ>
    <xmx:NOhLZ1aF51D8e-L3meOPygPzUSy0wcow4YNSsKid4UoCtPmIcfsZRA>
    <xmx:NOhLZ7EY66jrwXmz0iwIQ6N6Cj23tR69_x9kjhBVJ49T2_AmvDwtkTP5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 30 Nov 2024 23:38:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/2] Ensure unique worktree ids across repositories
In-Reply-To: <D5YCFP1AV64F.36B116IUDDEE2@pm.me> (Caleb White's message of
	"Fri, 29 Nov 2024 03:31:09 +0000")
References: <20241128-wt_unique_ids-v1-0-30345d010e43@pm.me>
	<xmqqr06un33g.fsf@gitster.g> <D5YCFP1AV64F.36B116IUDDEE2@pm.me>
Date: Sun, 01 Dec 2024 13:38:10 +0900
Message-ID: <xmqq34j8m30t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Caleb White <cdwhite3@pm.me> writes:

> On Thu Nov 28, 2024 at 9:14 PM CST, Junio C Hamano wrote:
>> Caleb White <cdwhite3@pm.me> writes:
>>
>>> The `es/worktree-repair-copied` topic added support for repairing a
>>> worktree from a copy scenario. I noted[1,2] that the topic added the
>>> ability for a repository to "take over" a worktree from another
>>> repository if the worktree_id matched a worktree inside the current
>>> repository which can happen if two repositories use the same worktree name.
>>
>> Problem worth solving.  Another would be to fail if the worktree ID
>> proposed to be used is already in use, but the ID is supposed to be
>> almost invisible (unless the user is doing some adiministrative work
>> on the repository), generating a unique ID is a good approach.
>
> There's already a `while` loop that tries incrementing the proposed id
> (e.g., `develop1` if `develop` is taken). However, this is on
> a per-repository basis, so there's no way to know what's already in use
> in another repository.

Usually repositories on a single host are not aware of each other,
so I am not sure if it is a sensible goal to begin with, to try to
ensure a worktree ID is unique "across repositories".

> The problem arises when trying to run `worktree
> repair` on a worktree that has a matching id (like `develop`) from
> another repository. The goal here is that the same worktree name can be
> created in different repositories and the id will be (effectively)
> unique.

OK, but wouldn't that change the problem we need to solve greatly?

The problem is very much simplified, in fact.  When we are adding to
.git/worktrees/ of a single repository, we need a unique worktree ID
given to the new worktree.  And the ID like `develop` taken from
another repository may or may not be already in use here.

In a repository, a directory ../foo/develop may already be
registered as its worktree, and the user may try to add yet another
directory ../bar/develop as a new worktree.  The first one has been
using 'develop' as its ID, and the "worktree add" command to create
the new one needs to tweak the basename 'develop' to make it unique
within this single repository.  Shouldn't `repair` that tries to
bring in an orphaned worktree that used to be given a worktree ID by
a potentially different repository (or it could be initially created
in this repository and then forgotten, and in the meantime there
could have been many iterations of `develop` worktrees created for
the repository and while it was missing, its ID plus serial number
may have already taken) follow the same pattern?  Whatever worktree
ID that the other repository gave it is invalid in the context of
this repository, anyway.

So I am not sure why we need to complicate the system by adding
random number, which does not help in ensuring uniqueness (it may
make it less likely to collide, but that is different from
guaranteeing uniqueness), while misleading readers that somehow
these numbers after the worktree IDs are serving some purpose.

Am I missing something?

Thanks.
