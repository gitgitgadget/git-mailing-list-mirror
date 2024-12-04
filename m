Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B52A624
	for <git@vger.kernel.org>; Wed,  4 Dec 2024 00:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733271334; cv=none; b=XjeJkIQ+ONEEewfOrboVzrpjK9IV5ccV/PKdbjBTikoQzeQYXorxFviVAl3baN7iR9FdTdppvQiaREKRdWrPLoeE1LneNapuSjLDI4SmYLg/HCyaxua4ydZsPQiNNlGLgOVEtKTi+RvkKklNczdL0mNgUyhLn+owoB8KvHpiMHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733271334; c=relaxed/simple;
	bh=sQzUQ9ET2J9awNvPMqoGILGoyKRmtayfpnL1xED8r6Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kLWuzl409FlPre9T+TfKbVGT+LDdtdQ7luwCzJo4/PZMuafr6R3HEo1u28x/xhgxZ/E2kMk9UYR38D03sdkOfNbUzPPrHO0RKm99uI+FTH1ZUKvsrqsOFouNx7FTBD55jl43Em/rLnWr9MGTSIfQH1wwDXAHjPRwb4+UnI2K8i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1kJ6b1b1; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1kJ6b1b1"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EEBDE1140205;
	Tue,  3 Dec 2024 19:15:30 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Tue, 03 Dec 2024 19:15:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733271330; x=1733357730; bh=aPUdYzhqk7kTJ/yXIYLiCWyV9Z8hv1Py8YV
	eNoAEhds=; b=1kJ6b1b1TI6iCvrWlT1PGAaAMQg4YOQ7P5xeazdfGXvYhM9upl6
	j0MZbyCeo10ku9XJA3mE5kWkCEAfthlcye/OiNBb8Vmlxgm0Z3ZIgqENuxpkOZCY
	wdR0IqS+kwTeb0mEI/7VD53bhiSdWaMbsddHIbwpIhdIVUJjD4Y6kArkJHq6PJ9z
	4uqDGFf3rlhBGkxc4faU5/9T3umtDMdPqTFFuj4wTjyMOzJEdWj8HdjSCoiKVI6u
	1HiuwoG6rjr89HlHeyWlcz4BsY1Gbfnujbl19D2EcRalsaEycHNid2RAVDlCQPZJ
	GxqP8nfmGsWTv7GfpK7/aaG0DzvbQGjFjAg==
X-ME-Sender: <xms:Ip9PZw0C7BwmsIrr-MBx4lB9KuBnQP73fGYGVi0zny700wyhAre-jA>
    <xme:Ip9PZ7GpRswKly2W3MQBkGixqZd6jw9iQLMndwCRyFWbFsyMDqfh57ek4cZNTIW5I
    _Hh-fWgOafM-8gFMA>
X-ME-Received: <xmr:Ip9PZ46eF1tEhP_TgNlr_xYdeWNOVDf3LbJmiXp6qESNyVfcNe5Wi-q_X5ypHx-97YzTwbFGci6vNjPuC9WlrUYEx013ooL1cobn-E0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieeggddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrd
    hnvghtpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhs
    hhhinhgvtghordgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhope
    hkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Ip9PZ52CTZVyrLiHt61SIvtOLEWHxnqCLX8GqBCGGGj7BLR_6G2h-w>
    <xmx:Ip9PZzFvWQCr38mqGUrVywZb8gRQY7aX10l62dq5DeYwTARTTEgsww>
    <xmx:Ip9PZy_6DACXh7c2V-1PI06oTu01ta4G821_S-vPOaE-bWtEFazwag>
    <xmx:Ip9PZ4lRPoZLmJtj71q31pXP9BD-oetUWHaTBDhYxwnsEUDz5ZNxHw>
    <xmx:Ip9PZ5ZGQ6DizpzbQvG0u2bflTedSPEcY_kgAJSqRc2iTAaFlrJ1Abbv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Dec 2024 19:15:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Elijah Newren <newren@gmail.com>,  Elijah Newren via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Eric Sunshine
 <sunshine@sunshineco.com>,  Patrick Steinhardt <ps@pks.im>,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH 2/1] t9300: test verification of renamed paths
In-Reply-To: <20241203210652.GA1413195@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 3 Dec 2024 16:06:52 -0500")
References: <pull.1832.git.1732740464398.gitgitgadget@gmail.com>
	<pull.1832.v2.git.1732928970059.gitgitgadget@gmail.com>
	<20241201214014.GC145938@coredump.intra.peff.net>
	<CABPp-BGP8zrSzxcacTzLY-EuYAQW5EwyDGNAMh196udGN18fmg@mail.gmail.com>
	<20241203210652.GA1413195@coredump.intra.peff.net>
Date: Wed, 04 Dec 2024 09:15:28 +0900
Message-ID: <xmqqed2o717j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

>> I would say yes, but since this patch too has made it to next and is
>> marked for master, I'm kinda tempted to just leave it as-is...
>
> Is is tempting. :) I wrote this up, though, which can just go on top (of
> en/fast-import-verify-path).

Thanks, queued.

> -- >8 --
> Subject: [PATCH] t9300: test verification of renamed paths
>
> Commit da91a90c2f (fast-import: disallow more path components,
> 2024-11-30) added two separate verify_path() calls (one for
> added/modified files, and one for renames/copies). But our tests only
> exercise the first one. Let's protect ourselves against regressions by
> tweaking one of the tests to rename into the bad path. There are
> adjacent tests that will stay as additions, so now both calls are
> covered.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t9300-fast-import.sh | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
> index e2b1db6bc2..fd01a2353c 100755
> --- a/t/t9300-fast-import.sh
> +++ b/t/t9300-fast-import.sh
> @@ -553,9 +553,16 @@ test_expect_success 'B: fail on invalid file path of .' '
>  	commit refs/heads/badpath
>  	committer Name <email> $GIT_COMMITTER_DATE
>  	data <<COMMIT
> -	Commit Message
> +	Good path
> +	COMMIT
> +	M 100644 :1 ok-path
> +
> +	commit refs/heads/badpath
> +	committer Name <email> $GIT_COMMITTER_DATE
> +	data <<COMMIT
> +	Bad path
>  	COMMIT
> -	M 100644 :1 ./invalid-path
> +	R ok-path ./invalid-path
>  	INPUT_END
>  
>  	test_when_finished "git update-ref -d refs/heads/badpath" &&
