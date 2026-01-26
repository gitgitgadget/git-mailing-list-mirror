Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547F031195A
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 13:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769434367; cv=none; b=qAFBzEKke/aRD0kFxyl/r5srDcCtDgLXGTauGq0cz9bAx5+EwRxglihqmWfN5o87VjMjW1k+PvjjK6aj5VgPRov8ZIgUOn2u8uCC6svxhggI8RP6JRkjAMDQn5ZU4F44fPlK/rlilzs8eKf00JSOnQeLHJ4uFiAQHH8LHwONTn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769434367; c=relaxed/simple;
	bh=+brcYcXvJEwaqB7IINZfQ5X2s8MXcedyx3yEnrHAAMY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q1iw7P4RgsnNdF1MBYV5qLDF6+loqXpvm89chEEl8jFfMiuAJa19r5+CA2FGMeFpuEbcbHG43+VFL0b0f39cKzJm1iohMz/rVCzsOFiyVTfEOto4M9txoQlwqAscwGfBvj3Gx1M2GjcPFqURq2dpRBg2LnUrX+Y3xsjHeT0b/Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=CYdtdVaT; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="CYdtdVaT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1769434353; x=1769693553;
	bh=+brcYcXvJEwaqB7IINZfQ5X2s8MXcedyx3yEnrHAAMY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=CYdtdVaTur3kqYQMrc7VT1HmarFBg/yqgaYIvOziImyBD2OBY1F+SDD3UnR2NX1q+
	 KKt201lBTgk0+iW0IXsZdveFxBPlULmPUqZlfUir7TdOwB/giAO6tnr1hmz/V1UlXi
	 1wjrY7gyqt3K1wPZdF1r+NTQPVSC6V6nMkrU56dWDT0+C5kPNSJZGt5DPASsJCSobG
	 spWRrgDfvyAi5/jibC2IM+z6wTPqJ4oimqEjJE8mOre1Rl+ysCqfW6pDp8iIpGHhI3
	 +ol69QQoCYJIx173gnnxMH216M//TPi2bQaPsY8GEndDCv9InGvKtKkJ0y6u437U0F
	 5stqRkt5A5gVg==
Date: Mon, 26 Jan 2026 13:32:28 +0000
To: Johannes Sixt <j6t@kdbg.org>
From: GitHub Chris Idema <github_chris_idema@proton.me>
Cc: git@vger.kernel.org, Chris Idema via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH] diff.tcl: fixed alignment of tabs in git-gui diff by using spaces
Message-ID: <Lj9kojJwK1ZAtvE5nj6rTq5EXf1-QhsRlmBDM9YntbYeWb3J07mlbM-njNco2XT1pSPXsNVbo9Uc5kJOHihb11odjthYN4YtuhVdNwxSIqk=@proton.me>
In-Reply-To: <01d0faaf-99fb-42a4-befd-bb7f359809bc@kdbg.org>
References: <pull.2179.git.git.1769424301394.gitgitgadget@gmail.com> <01d0faaf-99fb-42a4-befd-bb7f359809bc@kdbg.org>
Feedback-ID: 177675452:user:proton
X-Pm-Message-ID: f5899f5a17ed8c74eb6061317f092960543b68e0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> Sorry, I cannot reproduce what I read into this sentence. When I change
the "Tab spacing" option in the Options dialog, the display changes to
the specified tab width. I'm using Tcl/Tk 8.6.

I use git for Windows version "2.52.0.windows.1" on Windows 11.

Here is how you can reproduce the problem:
mkdir test_tabs
cd test_tabs
git init
echo "" > test.c
git add .
git commit -m "initial commit"
echo -e "int test1\t=3D 5;\nint test11\t=3D 6;\nint test111\t=3D 6;\n" > te=
st.c
git gui

> Do "Stage Line/Hunk for Commit" still work after this conversion?
I'm sorry but I don't know what this means.

-- Chris

-------- Original Message --------
On Monday, 01/26/26 at 13:15 Johannes Sixt <j6t@kdbg.org> wrote:
Am 26.01.26 um 11:45 schrieb Chris Idema via GitGitGadget:
> From: Chris Idema <github_chris_idema@proton.me>
>
> Tabs were not properly rendered in TK regardless of tab width settings.

Sorry, I cannot reproduce what I read into this sentence. When I change
the "Tab spacing" option in the Options dialog, the display changes to
the specified tab width. I'm using Tcl/Tk 8.6.

> Converting tab alignment to spaces before rendering in TK fixes this.

Do "Stage Line/Hunk for Commit" still work after this conversion?

-- Hannes


