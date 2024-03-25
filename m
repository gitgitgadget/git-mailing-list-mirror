Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3373C6F520
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 21:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711403937; cv=none; b=JFvA9WQUS9YwNtiEF5a7ApbIuLUQvLbiO/LKPxPWw/5v+SsHbLLpnhEiVfFR8Ufl/lCaTgn652rpSv+5OXpI+8US7VQ9jutLDQN3Uj1CDxsu6k5KybTTsLAHCuyfR+hzGeUBNidpUe9+YR1Oh9Q+MAJusxoYWBJPVqfKTJD6K2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711403937; c=relaxed/simple;
	bh=KYZK1T5OugGr5z9ntzIyJVWlJSA8PZ1dkkamlRzofws=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aWr9OplHx9AGXwsuomaRu1Dm8MDMkwGtAVeLc8E2F89hcTuNQk47lO5q9JGr1gMvtE6QoujdN3yE2oA3nA/Vis6G4+G/GKEcIXS6UY6rsuVcyJcdySx3UttzBrNBf4N/qbvHhg1yZnFktA8s9G6eHeeTdBsPqtPzt6nT6R/p8U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=iWxsnIPs; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iWxsnIPs"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 148FE1E936B;
	Mon, 25 Mar 2024 17:58:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=KYZK1T5OugGr5z9ntzIyJVWlJSA8PZ1dkkamlR
	zofws=; b=iWxsnIPsq2a+BeVsbX7YHPQqojN+NX8GooZCcL5VufQTS+PrNaZafE
	hVaop8zuNS3gQzyHMig5cG0bb6DZr9S+7Lo5Dmtit5vngH4pJ5MtOWlGlyzCjuZs
	wpQAbeYt6prlf9p2UYI+pgkchSvssJJigSMmrgvYTf+VZPr05XrKg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0B0431E936A;
	Mon, 25 Mar 2024 17:58:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 72C6B1E9369;
	Mon, 25 Mar 2024 17:58:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: vk <g@vkabc.me>,  git@vger.kernel.org
Subject: Re: [GSoC] Microproject help
In-Reply-To: <CAPig+cQAoK1UkgADFrnJfY4xw0kP6BypPAPe3aLoeFFGT_r2fQ@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 25 Mar 2024 17:37:25 -0400")
References: <51647635a10e31e800f87e8bd4a2e62c@vkabc.me>
	<CAPig+cRLUra6RObK82nvm1S_goK8q2CXe3A7EeCFA7xqhJCdMg@mail.gmail.com>
	<xmqq1q7yhupa.fsf@gitster.g>
	<CAPig+cQAoK1UkgADFrnJfY4xw0kP6BypPAPe3aLoeFFGT_r2fQ@mail.gmail.com>
Date: Mon, 25 Mar 2024 14:58:53 -0700
Message-ID: <xmqqv85aezxe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DF538376-EAF2-11EE-8B3F-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

> Since the purpose of a GSoC microproject is to familiarize the
> candidate with the project's mailing-list workflow and to give the
> GSoC mentors a feel for how the candidate interacts, perhaps the
> easiest suggestion would be the old fallback of having the candidate
> look for a single test script which still uses `test -f` or `test -e`
> or such, and converting that to use one of the test_path_foo()
> functions from t/test-lib-functions.sh.

During today's discussion, we came up another interesting one.

    Follow one of our three tutorial documents to the letter to see
    if they need adjusting, and come up with a set of patches to
    adjust them.

This kills a few birds with a stone.

 - The student has to be familiar with the codebase and MyFirst
   tutorials are meant as a gentle "dip your toes in the water"
   introduction.  Following the examples and copy-pasting code
   snippet and trying to build would be useful exercise for GSoC
   candidates by itself.

 - These tutorials, unfortunately, haven't been maintained as well
   as they should have been, and some do not compile any longer due
   to API changes, header shuffling, etc.  Identifying such breakages
   and reporting them as bugs is already useful by itself, even if
   the student does not manage to fix them.

 - But if the GSoC student can learn to address such a bug (which
   requires use of "git log" and "git blame" to spelunk where the
   breakage happened, after which it would be obvious what the right
   fix would be), that is valuable exercise by itself, even if it
   does not reach the "patch submission" stage.

 - And of course, the result of such a work can go through the usual
   patch review cycle, which would serve as a microproject.

Hmm?

