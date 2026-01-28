Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140861C3F36
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 19:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769626992; cv=none; b=WgktyrUf0H52hNkYw5CfweeiDwlPJAQOOhq1ohTOTtN3rjvfkqYL9tP9WeU2e1xVxE94f5KH4QEAmeWF03tvuvWYfDvVQDZCJAOKaZwZJoY4c0T8hdaj76SP/t33EVgXqDBvzYecjyVQeWBtK3BhJksA9lPzVSSDvI4L2cGNqfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769626992; c=relaxed/simple;
	bh=5fzXKGX92ipThlg+Uqe3CvV6nPyV7QEVTD1+wRztWro=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uW1aBt6ddQtCsY7z+oBMxaBHlfn8bYqG6FmROHxkIo58BPXvQW6j0PC63ExXGqvswoZy6tVxYS/y9gINAttbt90jf1PsT62X/rqaDIq8bi6dVgd8gKGGfXn9Devl240Ny87QHal28eaKvwwWgtL3o1a+nw4Wm+DnQib8WZ0BQao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=U8TRLik8; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="U8TRLik8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1769626980; x=1769886180;
	bh=5fzXKGX92ipThlg+Uqe3CvV6nPyV7QEVTD1+wRztWro=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=U8TRLik8sGO529x+JX7s4pwryA5EtOj/aOArMJdEa2jNOnpwqb/EnOcFtVWTjOdqc
	 Zg0Rtx2BfXgDLioZVJVfrTkXpvpfp9fPIVX7Bq/BJtFGxyuZEwfBW00vwgd/H7MLm3
	 RoftOhUKoRMJo79tYGyNTMlO1N4NJonvnfBFBfTnQPS26wF0joiO3RRq6sabx6KBGy
	 2xhIce6CwciX2Xzmdkeoc2IY7yMMDdIoWHyRbPpKjhdDCAHUDAiO4CxZua8dQEw5cI
	 oEEZ63ytJY98UskSBlw1/ABAnxpBGE2UfsfWR5cEh8fFw6rqT8V7I8q2oGoOpHjI3u
	 /AaJFzSSfXT6A==
Date: Wed, 28 Jan 2026 19:02:56 +0000
To: Johannes Sixt <j6t@kdbg.org>
From: GitHub Chris Idema <github_chris_idema@proton.me>
Cc: Junio C Hamano <gitster@pobox.com>, Chris Idema via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH/RFC v3] diff.tcl: made alignment of tabs in git-gui diff consistent with gitk
Message-ID: <ltvoMavyjgCl1Axuv1HV0rBdQPT2AcZQi4z9mo50OHYwoJ6pjCqEmdWfTmv2YHVSQjYxk2HSdxBXjTTKysBJ2CkdPotiOUIkUSnOMyOvLPU=@proton.me>
In-Reply-To: <547d261c-a716-4c57-8b93-09cf7d8fb176@kdbg.org>
References: <pull.2179.v2.git.git.1769545996.gitgitgadget@gmail.com> <pull.2179.v3.git.git.1769595640008.gitgitgadget@gmail.com> <547d261c-a716-4c57-8b93-09cf7d8fb176@kdbg.org>
Feedback-ID: 177675452:user:proton
X-Pm-Message-ID: 05338aa7dbf70ea51958574f66d05f54bcff00b9
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> This is a patch for Git GUI. Please use the subject prefix "git-gui:".
The file name need not be mentioned.

Thank you.

>If you look at commit a43c5f51a4b1, you will notice that it intended to
apply "magic" tabstops only to 3-way-diffs

I see it now.
I was able to test:
- "Modified, not staged", needs "apply_tab_size 1"
- "Staged for commit", needs "apply_tab_size 1"
- "Requires merge resolution", doesn't work and needs "apply_tab_size 2"
- "Untracked, not staged", handled somewhere else, works
- "Missing", needs "apply_tab_size 1"
- "Staged for removal", needs "apply_tab_size 1"

So I need to make some changes.

-- Chris
