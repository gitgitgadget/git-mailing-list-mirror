Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D1A13C80D
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 03:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732850072; cv=none; b=J1K8fEZl8p4oHtrQ8zDKu2uFegamZsv2tSqnmKY5YbVOAp+/eZ+xt5EZhIjoyk2SuH42p5NtQ4SocrZO0hTAHu3qRQqj8d1vfa3/2vtFKp+/lC3q4oVy7IBAIvCWCZLHINp4LVMOcd0DfaRjsPtMdeHF6+QOnSTR5ugDafMtzAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732850072; c=relaxed/simple;
	bh=PCQrC+p/lOn3EhqrjTvn5XNqiVp1D8mLiF+BX53ve58=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UWx/5TqbIcmjKne0h1wiV2DS05KC1xEGdGesNE8RBIl6tabn74PPo05d/YXu62IhhAw5OOaXAvt8XE/AWL8njYSJx0Fsk2bqNVPZ8rZFQmVFWciaxGTW5kxNvWjOtnggagjMdTwfsd5m38fGHRE48rAkF3YW7HPgB6La3T1ycjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nW1CdhEi; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nW1CdhEi"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0AD6D114015C;
	Thu, 28 Nov 2024 22:14:29 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 28 Nov 2024 22:14:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732850069; x=
	1732936469; bh=MPH49D5Q6yI3LBOK6NAdXkULoo13pJfFIfARwmG/vCo=; b=n
	W1CdhEitl8QhAPSRO9Ww0z3ZkJJex/hnh0p6yrezgzTnYX4wUcAttBTMw4WrBFZ/
	YA288+/Olrc+s0NdRtEWCIti98J7uJ+BOV9M4ixh501n0fd3dJSJYwq3fgC6rh9C
	bq9K4SmOy3CjPYRqWd6goPGnvHB6FhfDByHLcVm7HobBT1DN29JYErB0rtjlhXti
	d19gTw5URVVLneh3/7LYASYUiFdcEuwtU+6miG+Oqvkp7wIxgvT5PzqeSKhi+nYu
	m29w0B2jedpAcQYnWopqQrXJp6fJ6k0USVkMu/Ijz4r59ekZVpUgR3otXucxirzb
	LJzBOr44avhLFr7Vf691A==
X-ME-Sender: <xms:lDFJZ51bdJqbozsl_rlMcIgeEw5OOBWLX0Hn9F3mdGc4uDDP_uc76g>
    <xme:lDFJZwEsjDC-R8Ryy8HyueVQrjIJJIJU7gEuI8TFAMU_eShgVrlYzARhpSvZd4iBE
    GEvGsodQXhnN46jQg>
X-ME-Received: <xmr:lDFJZ576gwGxYeQd-D9ylN6SclGpaIMQsmX-PS8CyOzB_8y7uOgamNlgSYlCOywKDXy3n9q_hfVAaKjFFrquWkDW01noQuU3XN59qiE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedvgdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeen
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfekfeeh
    iefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptggufihhihhtvgefse
    hpmhdrmhgvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:lDFJZ20V54rDSy5CWiazlBJ3XAidlHruPJmhcwo7cbfY3RSOWwnlPg>
    <xmx:lDFJZ8HRY0Rbey0qRnTshAD2sj_EVWKTjc4ugxNAyjxQ-xUuhfOGXw>
    <xmx:lDFJZ39RxgkNXpNghn_9qJ3auKi_1Fz-dGovbDtuEGjfMMEzdSLmSw>
    <xmx:lDFJZ5leWgxtpJxrnRJB0ydx5tN2Y9HSCbqYRlpWMcflErvuqLXpKg>
    <xmx:lTFJZwDIMf1AEUTm6v1uX36UzJjnkPfbknv0i0l9XYyHrGADxwtv0VFA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Nov 2024 22:14:28 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/2] Ensure unique worktree ids across repositories
In-Reply-To: <20241128-wt_unique_ids-v1-0-30345d010e43@pm.me> (Caleb White's
	message of "Fri, 29 Nov 2024 02:44:24 +0000")
References: <20241128-wt_unique_ids-v1-0-30345d010e43@pm.me>
Date: Fri, 29 Nov 2024 12:14:27 +0900
Message-ID: <xmqqr06un33g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Caleb White <cdwhite3@pm.me> writes:

> The `es/worktree-repair-copied` topic added support for repairing a
> worktree from a copy scenario. I noted[1,2] that the topic added the
> ability for a repository to "take over" a worktree from another
> repository if the worktree_id matched a worktree inside the current
> repository which can happen if two repositories use the same worktree name.

Problem worth solving.  Another would be to fail if the worktree ID
proposed to be used is already in use, but the ID is supposed to be
almost invisible (unless the user is doing some adiministrative work
on the repository), generating a unique ID is a good approach.

> This series teaches Git to create worktrees with a unique suffix so
> that the worktree_id is unique across all repositories even if they have
> the same name. For example creating a worktree `develop` would look like:
>
>     foo/
>     ├── .git/worktrees/develop-5445874156/
>     └── develop/
>     bar/
>     ├── .git/worktrees/develop-1549518426/
>     └── develop/
>
> The actual worktree directory name is still `develop`, but the
> worktree_id is unique and prevents the "take over" scenario. The suffix
> is given by the `git_rand()` function, but I'm open to suggestions if
> there's a better random or hashing function to use.

I do not think it matters much what hash/rand algorithm is chosen.
What is important is what you do when the suffix suggested by that
chosen algorithm collides with an existing worktree ID.  IOW, there
is no way a "random" can guarantee uniqueness.  Attempt to create and
if you find a collision, retry from the generation of another suffix,
or something like that, is necessary.

And as long as that "make sure it is unique" part is done right, it
does not even have to be random.  Just generating a sequence number
and using the first one that is available would work as well.

Thanks.
