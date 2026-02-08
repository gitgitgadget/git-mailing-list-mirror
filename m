Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE692C11D5
	for <git@vger.kernel.org>; Sun,  8 Feb 2026 06:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770530893; cv=none; b=Aez3IPEPSsXXUyOcTQ+vA6ADLEvMg5DBCO4r1Q2rAIk6tPIlchYWgj9wVRPvnEeCVe6aiRpsG3+Ue0X7TlqG6Y1WiEsrQxHc/knsuE37Tx5WuGd5e54HSHbF5PYhgl9NWh6UimOd9GsQZC/xdxfJ6a1HQ4GdYgExwMnMrUEjJx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770530893; c=relaxed/simple;
	bh=o0sgx2RKxUDQssamxyBMac0BDXb1eCg2X1gwMpNqk5E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Yf+36qp4491XMAbcxy6I2Wu/4Dd6k03BRWOZPaWqfUwlfqNjiaabGTLp/7ILhSznmcUAlTRXI8R/VbmHHEB0xHGFPbZHjUjMlgWIHuqF08B5yB+VkucjmY6EE3++rlI9pV0449hU15qoLGsx0cIy+5uzcPkgtTSTde/1HOSSplg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Sn3ukxHg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wi6hxcB/; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Sn3ukxHg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wi6hxcB/"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6BF417A00CD;
	Sun,  8 Feb 2026 01:08:11 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Sun, 08 Feb 2026 01:08:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770530891; x=1770617291; bh=HBa5SsgQo2
	PiXwQmbgiK5uhB9Eg7BobD/O4kOYKUd+Y=; b=Sn3ukxHgqORgtwIPNAJHko9y/Q
	YrYu5CJxXeqSUKYAp0ZjedhFVFBK+JP5jLcJkENlcF3Om6Phk7YiweWgDmFo3xc3
	1ftkP7QzO7jlf9s+eOMH2arL5eugKWWFv423pnAD2yQ0v0tSANNPONQorWfOKvVM
	Pg6itv/qN4OEP3685X4214YxFSA0b7GWmD5FOlhgGTuJ4f6f/iSnFK9zH6OPBYPI
	oVl/FbLPwqL4uKCgLtrBvW0iv1DAIRir7jQPQwmoY+hpb8gh/yBpxlqBlN4RWPQo
	z4rIMLPAoLuzuI7m8kQIyhwDv5qAvQeLycr5NnvRJqEyGVwYHVW9fZCxhZGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770530891; x=1770617291; bh=HBa5SsgQo2PiXwQmbgiK5uhB9Eg7BobD/O4
	kOYKUd+Y=; b=Wi6hxcB/6wDEGg5KwQ4gwzsvewqCSVSSpqv5QhHkKPXRmUL79DB
	V/VptKFFGReTlnkORVXAByPjDe8rYZEnEvLHcwvf5OzfyjDYSJQC0+Tsm+jp8Io2
	GsQmhlolSpmUjscAOo2yWg/H0DZ/woJ6t28SrIejbjIxKqYCiWR1RYEUl/94T8UY
	Qb4zOmmtPrUnD5Lmn2vDbwBqEJIvZtqI8Kr01v8sSjU6MJliAxsnih6YIK1h+zPU
	e86USakOVzv28nxS2B0j0ZS7xts+hCSOoQa/yW+PZo/lJTn84h6ul3Obprx2CBFy
	fah2O8+T6KaYlCXmSnG2Hs3Lh2qFemBGaiw==
X-ME-Sender: <xms:SyiIaXOFhwWdT2_jsBm2Mh259vp9n3_SVHAcW3fW74y0QQb-h9MMJQ>
    <xme:SyiIaY0Kyvf8NblXxmrSTEIITS05bIVQ7OGbHuXH9oGTZU-YRO10aH4ptT9Dh7hbQ
    IfLGrqVBMvSkokvoRWEP-UR9iASjXcFjHV5EdYCK0OA_JZFosltyw>
X-ME-Received: <xmr:SyiIaem-j6mEn3NyVGYWJgSeiJmkg7M2H_ujSqewOuLJmsHyskt3-vgF_BX1h3gbTYTeSjphC6MsbpBp4XGCnFj6bfLdcEOMCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleefudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhhrvgih
    rghnshhhphgrlhhifigrlhgtmhhsmhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddu
    keeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfe
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:SyiIaXXJJupfaIifuOh38AGsew-uK4EtOUjwULtHbyBQDHOaDzp6iA>
    <xmx:SyiIacuhdO5QuRzQtVvy9-wgdh0apc06lG_5g4EcVEa9CebGAQyXFQ>
    <xmx:SyiIaSafJYYHTZX3yScey--acMHcLKENZDZe4kmTvxHR0qh2d9HQKQ>
    <xmx:SyiIaTUvQuzjysjRgX5bAwVR74j3TNOZRkRClO0m9yGyUPyEb8p4_g>
    <xmx:SyiIaemvftEHWPD79k-TMUDw04W7sSqd7fm78BvytgH-AbZSR9Q950Ud>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Feb 2026 01:08:10 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org,  karthik.188@gmail.com,  phillip.wood123@gmail.com
Subject: Re: [PATCH V2 2/3] wt-status: pass struct repository and wt_status
 through function parameters
In-Reply-To: <20260208044450.34444-1-shreyanshpaliwalcmsmn@gmail.com>
	(Shreyansh Paliwal's message of "Sun, 8 Feb 2026 10:14:14 +0530")
References: <xmqqtsvs9gij.fsf@gitster.g>
	<20260208044450.34444-1-shreyanshpaliwalcmsmn@gmail.com>
Date: Sat, 07 Feb 2026 22:08:09 -0800
Message-ID: <xmqq4inrahti.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:

>> Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:
>> 
>> > -int wt_status_check_rebase(const struct worktree *wt,
>> > -			   struct wt_status_state *state)
>> > +int wt_status_check_rebase(struct repository *r,
>> > +	 			const struct worktree *wt,
>> > +			    struct wt_status_state *state)
>> 
>> Funny indentation.
>
> my bad, will fix it.
>
>> 
>> Besides, should we adding a yet another repository parameter to the
>> function?  The worktree wt knows what repository it belongs to.
>> 
>> > -int wt_status_check_bisect(const struct worktree *wt,
>> > +int wt_status_check_bisect(struct repository *r, 
>> > +			   struct worktree *wt,
>> >  			   struct wt_status_state *state)
>> 
>> Same comment about "r" vs "wt->repo" applies here.
>
> Actually adding another repository parameter to both of these functions
> is needed because of the calls like wt_status_check_rebase(NULL, state)
> and wt_status_check_bisect(NULL, state) from wt_status_get_state().
> In the case where wt is NULL, accessing wt->repo can lead to issues.

But stopping thought at that point is not a reasonable thing to do,
immediately after you notice that wt is sometimes NULL.  It merely
means that unconditionally dereferencing wt->repo without thinking
is not good enough, doesn't it?

And what is the case where worktree is NULL?  What are we doing with
worktree set to NULL?  Is it when secondary worktrees do not come
into the picture at all and you can safely use the_repository?

    ... goes and looks ...

Ahh, I think the real culprit that needs cleaning up is the worktree
API, where they pass NULL to mean "the primary worktree that has its
.git/ directory at its natural place".  So it may not necessarily be
the_repository we are dealing with.  There is *no* such client code
right now, but we could imagine that a program that starts in a
repository visits the primary worktree of another repository and
asks the worktree status there, and once such a client code appears,
we need to be able to say "we are dealing with the primary worktree
for this repository".

In the longer run, I think we should fix the worktree API so that
even for the primary worktree we will always have a non-NULL "struct
worktree" object, perhaps with its .id member set to NULL to signal
that it is the primary worktree, so that we do not have to have this
strange "we must pass repository redundantly even though we are
passing worktree" API elsewhere.  Not just this code you are making
worse, path.c:worktree_git_path() already is a victim of this
misdesign of the worktree API.  It has "if wt is given, then the r
parameter should be the same as wt->repo" nonsense, which we
wouldn't have had to have if we had a worktree object even for the
primary worktree,  Look at how ugly that code is, and weep X-<.

And the same misdesign of the worktree API has caused your [1/3] to
pass 'r' but yet still depend on the_repository, which you had to
fix in [2/3], in this function.

So, I dunno.  If you are ambitious, you may want to clean up the
worktree API before this series.  Alternatively you may be able to
punt on the parts of the wt-status that interact with worktree API,
and move the rest of wt-status less dependent on the_repository, but
I am not sure.

Thanks.
