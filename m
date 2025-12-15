Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305DF33EB13
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 23:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765842639; cv=none; b=SG1osCG/NedpilIlSQ+rnODZWJwnnbtG5ZJXIPDE5odhutorTn1W/t82727RdQUf5/D2QgEEEg9wogFP6cbe9sUEBzXO5GyAM5dE6mJCmbTCW/8i3rSrmTzNGLwSNdLfajPxK4Gsj/WEDNP2aSxkP+FZlC12JvK8vE+7BHDHBX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765842639; c=relaxed/simple;
	bh=sfLfyG2I/lsFcQl8Du+zITqanWb/19fWDm9IP/jaoCA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QNOjpmvtni48PAQWMhdeWNz+SIBHgGJyX0kAOfJ9BktAwT5RsNOrcSMK5I0JOoQpmqWYxr4sKsgpsJA0JyTKqd3KJpgx4I5DbwPqWa20I8l3YIgmAbGIBIc2ypvWs5ET66AoV0e9/4yDOOc1Fjm1Mimk4xLwgOEZmoeGyc0O+Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AIqwjLfo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JD4XjT+Y; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AIqwjLfo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JD4XjT+Y"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 606897A020C;
	Mon, 15 Dec 2025 18:50:36 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 15 Dec 2025 18:50:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765842636; x=1765929036; bh=ej+CIImt7S
	ef8skWG/F0/TFhTz63dFGAEOoYfZLOSFg=; b=AIqwjLfo7ChAXq4W6ZRXJYyRv4
	qTVxz3AuUX+U0uFVrTBRCEgjNE4irvpseRD4ObOOlURvOf0hod6LCiwYmTvmbpB0
	6Wqq/n3JCx5rimV7Z3QSaOklifIysIBJuJTmsi09JeYEb1afplYBphOMy9CIbiwE
	Jky9yBHmcbXmDO+K42RFwUh1JMEidaGc2wmEHAdfp+yZe0VdjuVkouK5W+qJ9Z7g
	S3Bj0iB/x40re7ub6glYUW5yLMG9DXaQYKaJfv7Nd71fv4xwwXkmBHaoxGCH1ueL
	BtTqDXCRFPGE888d0T+RaJGCbtE3z4d+eaBvjGGEtBAQt3bx+b7CuzngP/fQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765842636; x=1765929036; bh=ej+CIImt7Sef8skWG/F0/TFhTz63dFGAEOo
	YfZLOSFg=; b=JD4XjT+YyvMdzvCtSXIlc+p+akRy/K56mRluffqhrSIjjC7Jtas
	zgaaDRuDI1SFUbAWLDgZLgGK8q13nPMaN5FyXze3BW1yQsj0WcyGynUX8B9GeD72
	o2VHfTuinAiP4GYXqKF4XByYISXVMQZLL4GiSz8YsxaFXIkXS/Rb1wX/wC2+HOeW
	ym9hg0iq8/7G2p2Hgxpci/3NqjqmptRUwsErgTHUrhICuqQQKuwVYXGhFsD+tAhi
	29gyeGl4tgI2DJnR+4fSR0lZ5VfiyXIIRPrQkRk4C/+OMuzybvS3Cf7ebtIWwtHv
	eeVLezEf/Loc6YhlqUIA43Ozk+UAolOVlzA==
X-ME-Sender: <xms:zJ5AaffDLRAdwKgxjaSJhTHdrVO86dwH6EsUJ-6mLhUOM_9F13rQ1g>
    <xme:zJ5AafxnKkmGA-EAp_NCW_yJFQkSRQDpxxH9NasvUYnZVsK4ByVuc_fjRwtZw5Scs
    SWBS5TQvwCnXPQ3Avl0RebhrQLZwDHHUGgtTAVhPIhy6KPWip7DMgU>
X-ME-Received: <xmr:zJ5AaVG86n3Be5G2gZa4Md6u4H5x33D9wlYmJrPzGBxv-5phfd0_LRU2bscPEX5au4WmQ-fvxrsebECd23E2dEvNfvCaPuJftQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefkedukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:zJ5AaTwqEAj_BmtQgtTPOh4OdqQv-cfXQksLj9FndRIjuw3nG8bMBA>
    <xmx:zJ5AaWsxujoyM7aSgjQQ73INWonyMPbcXrEumGqt8hKu-sVLgvzxCA>
    <xmx:zJ5AaQ1APCqKgoL1qSM-eP2bRWtpRie7e1uQcPZy9uOgsqPfx9HxEQ>
    <xmx:zJ5AaR_aW4oTPdyD3GeNIfX5szzFkERuQxFh16ssPcQ9d0-0uAhqpg>
    <xmx:zJ5AaVsZcQkyMXmle0fLcJfHYBziAdQy_jDTOCDrwC2z7Bho_SLBH3r2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Dec 2025 18:50:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2] replay: drop commits that become empty
In-Reply-To: <9a81644a0ec670261a85c155fa32e5a1f4576ef4.1765793254.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Mon, 15 Dec 2025 10:07:37 +0000")
References: <8a2a1215306452147cc7b803530ab2429bf57f15.1764260150.git.phillip.wood@dunelm.org.uk>
	<9a81644a0ec670261a85c155fa32e5a1f4576ef4.1765793254.git.phillip.wood@dunelm.org.uk>
Date: Tue, 16 Dec 2025 08:50:34 +0900
Message-ID: <xmqqpl8f719x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> If the changes in a commit being replayed are already in the branch
> that the commits are being replayed onto then "git replay" creates an
> empty commit. This is confusing because the commit message no longer
> matches the contents of the commit. Drop the commit instead. Commits
> that start off empty are not dropped. This matches the behavior of
> "git rebase --reapply-cherry-pick --empty=drop" and "git cherry-pick
> --empty-drop".

OK.  Maybe it is just me but "onto then" -> "onto," would flow the
sentence better?

> If a branch points to a commit that is dropped it will be updated to
> point to the last commit that was not dropped. This can been seen

If one thinks about it, it is the only natural behaviour to use the
last surviving commit to point the branch at.  Thanks for spelling
it out so clearly.

BTW, "can been seen" -> "can be seen" (will amend locally).

> in the new test where "topic1" is updated to point to the rebased
> "C" as "F" is dropped because it is already upstream. While this is
> a breaking change "git replay" is marked as experimental to allow
> improvements like this that change the behavior.

Again maybe it is just me, but I'd prefer to see a comma after "a
breaking change" to flow the sentence better.

> Helped-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
> ...
> diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
> index dcb26e8a8e8..96a3a557bf3 100644
> --- a/Documentation/git-replay.adoc
> +++ b/Documentation/git-replay.adoc
> @@ -59,7 +59,9 @@ The default mode can be configured via the `replay.refAction` configuration vari
>  	be passed, but in `--advance <branch>` mode, they should have
>  	a single tip, so that it's clear where <branch> should point
>  	to. See "Specifying Ranges" in linkgit:git-rev-parse[1] and the
> -	"Commit Limiting" options below.
> +	"Commit Limiting" options below. Any commits in the range whose
> +	changes are already present in the branch the commits are being
> +	replayed onto will be dropped.

OK.

> diff --git a/replay.c b/replay.c
> index 13983dbc566..2864c213993 100644
> --- a/replay.c
> +++ b/replay.c
> @@ -88,12 +88,12 @@ struct commit *replay_pick_regular_commit(struct repository *repo,
>  					  struct merge_result *result)
>  {
>  	struct commit *base, *replayed_base;
> -	struct tree *pickme_tree, *base_tree;
> +	struct tree *pickme_tree, *base_tree, *replayed_base_tree;
>  
>  	base = pickme->parents->item;
>  	replayed_base = mapped_commit(replayed_commits, base, onto);
>  
> -	result->tree = repo_get_commit_tree(repo, replayed_base);
> +	replayed_base_tree = repo_get_commit_tree(repo, replayed_base);
>  	pickme_tree = repo_get_commit_tree(repo, pickme);
>  	base_tree = repo_get_commit_tree(repo, base);
>  
> @@ -103,13 +103,17 @@ struct commit *replay_pick_regular_commit(struct repository *repo,
>  
>  	merge_incore_nonrecursive(merge_opt,
>  				  base_tree,
> -				  result->tree,
> +				  replayed_base_tree,
>  				  pickme_tree,
>  				  result);
>  
>  	free((char*)merge_opt->ancestor);
>  	merge_opt->ancestor = NULL;
>  	if (!result->clean)
>  		return NULL;
> +	/* Drop commits that become empty */
> +	if (oideq(&replayed_base_tree->object.oid, &result->tree->object.oid) &&
> +	    !oideq(&pickme_tree->object.oid, &base_tree->object.oid))
> +		return replayed_base;
>  	return replay_create_commit(repo, result->tree, pickme, replayed_base);
>  }

OK, that is straight-forward.  Instead of overriding the
result->tree upfront, we try the same using a temporary
replayed_base_tree, and that allows us to see if the resulting tree
computed by merge_incore matches.  Only when it made a non-empty
change, we proceed to create a new commit.

> diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
> index cf3aacf3551..9d4b0dd1a77 100755
> --- a/t/t3650-replay-basics.sh
> +++ b/t/t3650-replay-basics.sh
> @@ -25,6 +25,8 @@ test_expect_success 'setup' '
>  	git switch -c topic3 &&
>  	test_commit G &&
>  	test_commit H &&
> +	git switch -c empty &&
> +	git commit --allow-empty --only -m empty &&

The use of "--only" here is a bit curious.  As there is no change
between the index and the commit our "empty" branch points at,
wouldn't it be unnecessary?  The option, together with --allow-empty,
would only matter if you did

	git switch -c empty &&
	modify blah &&
	git add blah &&
	git commit --allow-empty --only -m empty

because without --only, the changes to blah will be taken.
