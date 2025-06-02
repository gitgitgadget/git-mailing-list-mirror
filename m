Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3732C22257E
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 15:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748876568; cv=none; b=bZ8dP+bbEOUWb0/YSnFP3fzkl3Wb2ckXSGxRhg+uVkqwGqv8W4Woi+x8rcYNn1cVUhTOTvSQ48F9dvD0ua04ZYmC7V84pQZhSsOeDScCzpJAKcAGfMcJY0E6qmwU9FArZ14R1ARzpiECGE3ig85wxXpxcEBbkMJbQACW6wqcwPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748876568; c=relaxed/simple;
	bh=kxpU94e0j4eKZTCH9LYM5XOPJjeE2AQ5rb8SfAthJHs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=SDHPhuGgp6I8NcYthgCeIBBXTi7sv6w014o1QsMNXHe3nPABOyRXwUqFNAc2BYOVAvXskvu29aSZdMMsXiCLC8Uqz8Qe1P9pc5W0FGnckxFlAxrXe1U2GnjfFQGSTtZIbf+WjTwsGHyO4fln/I4cJUMYbBcD+U1k3aZ686FMelw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=TvP21IfQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NsNe5+BE; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="TvP21IfQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NsNe5+BE"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0C5C1114012B;
	Mon,  2 Jun 2025 11:02:45 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Mon, 02 Jun 2025 11:02:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1748876565; x=1748962965; bh=ivhGKsZpXUOD3l15Wb2hJYAupWzBBHmY
	Ty6MdNDirvQ=; b=TvP21IfQ1U2JjKpjlTdlyHYX1VHhbHiV/JZFHfl+i4Jiwn/p
	H+ZkJpK01wGr6MzIsaCBjOsUEAb0RAu3+Vzr4yJxfocFtWO9MHYauHw4GrTe++cM
	Or/DhkYIvtfGVT/9QXhjC3NtCh8vkzAIO3Ie+Em6zLDQM9n3LiaVKNL6xeOoE5NH
	bHRXVnCrnd1GcogdGRnz8Nyugh6nsxrUeKESlgLZ3Qu11VxywYkGBJJyy7+WLrfw
	BWTib+Ash5egwivQ9jfeTqhXgr1L4SiN1pSCAY3vb4l6epLUgREnjbwTo+RjiXVI
	8fr+HIDsF5rT8gWUEV1efo8yP72NJ+rS4Onk1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748876565; x=
	1748962965; bh=ivhGKsZpXUOD3l15Wb2hJYAupWzBBHmYTy6MdNDirvQ=; b=N
	sNe5+BESIMzm13Pq1kYDAEgNripTAQMWLdX2AzALhYTzSE40AZbvC0o8KAjYSfnb
	j71iY2Hf9Ycr8aBF079a5aPbliPSkWwmIWjbmjyvx9+RSc4T7dLYF3YBOErOTFen
	v3+6MS9IRx4CT1aGCaB0OBRAq83YuSIuDZO6XNlmXCUUs9l9DcieozVFRZwSa7XR
	U0wsotk/hhZEao5xau03nFnOrLPpIWJMTIPtxSowuFwlG2500DQk6UCBRhR+5uMs
	1+dxKvrvAtXjcFA+bxQHRCfc8q9saBje/XAasdiXDsReZMV4HzXGviM/6TiksgUk
	AoADW+v4durEh0DRMKd0g==
X-ME-Sender: <xms:FL09aPWA-nw0UV8Du3an_KqstljqnqeF8iUyJ6uqWq6c3KmnsbGjeqo>
    <xme:FL09aHkiV-ZHPz-L7u-DZSwrlOWBVdRROaTQmoy-LIIARA_y-ACDgStloTh3ryUCR
    fKtxE125aWpOXr9Fw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefjeelkeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefk
    jghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruh
    hgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffr
    rghtthgvrhhnpeetkeefudehhfelfefgueeivdelledvjeegudejgfehjedttdevlefgle
    ekieevveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdpnhgspghrtghpthhtohepjedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghi
    lhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphht
    thhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:FL09aLa7_gj9c-g0aWTYM-JaXcJkiscAQszNyRw3IA_uvgPkmM7dvQ>
    <xmx:FL09aKXcxtWCxz-QtxWghBCiBfBY43mHvwtqZ4hT4x5PoqIkJZZNnA>
    <xmx:FL09aJn0R2qXpnb__FT2qeFN6dnXpcdWcIyw6lTO9h42K2NED2038A>
    <xmx:FL09aHc3V5I5PUZnnzWfE_O8bWWrveF4r1gXoPOnOXrIJTb3a4EJNQ>
    <xmx:Fb09aJJ-amwmRBm0TYD8750xBxFQ9aZodV1JkrVVGPkcc80JHiiCCX1S>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 40FF61EA0062; Mon,  2 Jun 2025 11:02:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T9e54919956c4dcd1
Date: Mon, 02 Jun 2025 17:01:44 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org
Cc: "Patrick Steinhardt" <ps@pks.im>, "Karthik Nayak" <karthik.188@gmail.com>,
 "Eric Sunshine" <sunshine@sunshineco.com>,
 "Junio C Hamano" <gitster@pobox.com>,
 "Phillip Wood" <phillip.wood123@gmail.com>
Message-Id: <d7265bca-ac47-4610-834d-da91042ccdf0@app.fastmail.com>
In-Reply-To: <aD23w6-szFjKQGSj@ArchLinux>
References: <aD2mhOlwl1LSYnpe@ArchLinux> <aD23w6-szFjKQGSj@ArchLinux>
Subject: Re: [PATCH v3 0/1] [BUG] refs: verify does not work if there are v2.43.0 or
 older worktrees w/o wt. refs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Jun 2, 2025, at 16:40, shejialuo wrote:
> [snip]
>
> Range-diff against v2:
> 1:  d949a8a646 ! 1:  e4c32971da fsck: ignore missing "refs" directory
> for linked worktrees
>     @@ t/t0602-reffiles-fsck.sh: test_expect_success 'ref name check
> should be adapted
>      +		test_commit initial &&
>      +		git worktree add --detach ./worktree &&
>      +
>     -+		cd worktree &&
>     -+		worktree_refdir="$(git rev-parse --git-dir)/refs" &&
>     -+		# Simulate old directory layout
>     -+		rmdir "$worktree_refdir" &&
>     -+		git refs verify 2>err &&
>     -+		test_must_be_empty err
>     ++		(
>     ++			cd worktree &&
>     ++			worktree_refdir="$(git rev-parse --git-dir)/refs" &&
>     ++			# Simulate old directory layout
>     ++			rmdir "$worktree_refdir" &&
>     ++			git refs verify 2>err &&
>     ++			test_must_be_empty err
>     ++		)
>      +	)
>      +'
>      +
> --
> 2.49.0

This version works as well.  Thanks!

    $ git range-diff --no-color --no-notes --inter-hunk-context=1 --ignore-all-space <range>
    1:  ddbf0f8cf4c ! 1:  ce802ef6698 fsck: ignore missing "refs" directory for linked worktrees
        @@ t/t0602-reffiles-fsck.sh: test_expect_success 'ref name check should be adapted
         +          test_commit initial &&
         +          git worktree add --detach ./worktree &&
         +
        ++          (
         +                  cd worktree &&
         +                  worktree_refdir="$(git rev-parse --git-dir)/refs" &&
         +                  # Simulate old directory layout
         +                  rmdir "$worktree_refdir" &&
         +                  git refs verify 2>err &&
         +                  test_must_be_empty err
         +          )
        ++  )
         +'
         +
          test_expect_success 'ref name check should work for multiple worktrees' '
