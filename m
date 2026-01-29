Received: from mail-244122.protonmail.ch (mail-244122.protonmail.ch [109.224.244.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362172E764D
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 08:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769675504; cv=none; b=uf8tXSZfiXqnsyxZiKJqR2DOpacg5tz81XSyWQ54mYjkY16w5hzj0mo0u9lF33aUHDarlQxeYxZMAWXYMz012WrsZ7nn5QrHnaUydryaE+Z7rx16plMUsYwOjbjjZNZrayBHdwNeN2kr5qnzeZeudjK/eqnGvC6bSUWcmaRZT7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769675504; c=relaxed/simple;
	bh=RpInzi4wPUdbmIGlk/cbJ99A34X+QwJ/n8ExhlFaICY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d+bdhNwyvZM7lh1AUFcjSqNCTj9W7q9kgCKHPv1ulO6A7WRQx/O5OS8VA+mtSjjGbJ/ek8/I1eGR+c1OfDcNOmkIGwteH3Z+XbrlsRLWb5LQ6P8mpyg09M+x+yUIh+VdVUScidNimUnandmKrSm8wCXY7euGn75t4go0klrwS94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=haxKsPyr; arc=none smtp.client-ip=109.224.244.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="haxKsPyr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1769675490; x=1769934690;
	bh=RpInzi4wPUdbmIGlk/cbJ99A34X+QwJ/n8ExhlFaICY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=haxKsPyrvE3nHqrMOi6gSsOyIu+Vz2mkVIxYO8K4QMk5rCYdbbruuRu+qK7PV0Uz1
	 ZV57WqZdb7z55BIGMtzaoKXJRdF9aGH8GMSv2wX1gvFZuk+6zYlKzdY0n0K48nrn2/
	 0GDKjHgEYaxeciEVIm7NAKUxyOcrUL1yGugvb/U5fNTYX+1g1GRUJBcxSG4jLdGxKv
	 OeCwMyR36BNP5rF0gqYZ+cK9S2GdGbqM9KavX6LarmSty4Vdq7N/Lz7tk/nyGhhV1l
	 fqPuJ2GraU4kQ0uWM+g6gkSht1bOLeFbW1sKfNoDlZe2qlV5w/PEVR/VTJfXUHD1q6
	 7a5TmmTEIpovg==
Date: Thu, 29 Jan 2026 08:31:24 +0000
To: Junio C Hamano <gitster@pobox.com>
From: GitHub Chris Idema <github_chris_idema@proton.me>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org, Michael Lutz <michi@icosahedron.de>, Pat Thoyts <patthoyts@users.sourceforge.net>, Chris Idema via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH/RFC v2 2/2] diff.tcl: call "apply_tab_size 1" to fix alignment instead of spaces.
Message-ID: <AXTzN5mRXdWYZx55ARuBbRgndXW5zA51_wcnAV4KaUpk3kz6t8ZYfOk0Du5rg6zKhz0_O-4ZSkLNX6WkhTp4fjDFDMfCZAsTRCoBMH_IpMU=@proton.me>
In-Reply-To: <xmqqv7glcmee.fsf@gitster.g>
References: <pull.2179.git.git.1769424301394.gitgitgadget@gmail.com> <pull.2179.v2.git.git.1769545996.gitgitgadget@gmail.com> <e11aa6d811dcf868fd0f91b74cdceb8bc3f4229e.1769545996.git.gitgitgadget@gmail.com> <xmqqsebqem1n.fsf@gitster.g> <xmqqfr7qeixq.fsf@gitster.g> <71494127-c17d-4fd9-a69d-1f547205ac8f@kdbg.org> <xmqqv7glcmee.fsf@gitster.g>
Feedback-ID: 177675452:user:proton
X-Pm-Message-ID: 42a187b64477184aab6b6b2d79e48719ad901362
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> From: Junio C Hamano <gitster@pobox.com>
>
> calling it a "show stopper" and "unreadable" is a great
> exaggeration, I must say.

We use clang-format to format most of our code.
But we don't have that always available.
So it's good to review indentation changes prior to commit.
And we use either git diff or Git Gui for that.
For many file changes I prefer Git Gui as you don't need to scroll.

For git diff there is a way to configure tab size to 4:
git config --global core.pager 'less -x1,5'
source: https://stackoverflow.com/a/10584237/15307950

For Git Gui and Gitk there is also a tab setting.
But only in Git Gui it didn't work as expected.
So with show stopper I meant that it's the only odd one.
And since the code already uses apply_tab_size it makes sense to just=20
apply it correctly in all scenarios.

My latest commit was tested for:
- "Modified, not staged"
- "Staged for commit"
- "Requires merge resolution"
- "Untracked, not staged"
- "Missing"
- "Staged for removal"

And it worked on my side.=20
@@@ needs apply_tab_size 2
@@ needs apply_tab_size 1
the rest was already handled correctly

> From: Junio C Hamano <gitster@pobox.com>
>
> I noticed that gitk has code to deal with octopus merges

I would love to know how such a merge can be replicated.
Is it also possible to have such a merge visible in Git Gui?

-- Chris
