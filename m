Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870F538759F
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 09:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768297778; cv=pass; b=SctgahomT/M1nZFwZHr+3cXT5XLd8doHsxha+27K5Oyuegf+S0J1JEKQqTTSVlMVtW0y6KdJOJdlMuYir4GlmQE3BySG4fzCXjXhkDFXfH/70TjTbWsNdluIG/0a1Okr+kzK4vYx8HEGwaK7fMxaT59mm+o7YT7Zp/aZfW8BR2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768297778; c=relaxed/simple;
	bh=+Hw3lGoWLvQt9B67xwqb45Hg6ni1qo4hzEv1MCUQ4lE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BPrJbkVT797Doih4ZPwrfUSdGUVy8moLGfbNu5LYorBPuw6uBkpDA3/Q0w+Zvkr5Hrph/WHiswuPiOc91AHk5wkN7H0vYhF17+jbSyed9oC7INX5mj9QF0KRSr5LgMJ1CznrspESIMPOA1VK+H94nMrA7LifQmGx3Udhz6GOJ+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=LEiq8eqK; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="LEiq8eqK"
ARC-Seal: i=1; a=rsa-sha256; t=1768297760; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fdL/BldcubQQMSHfien9a4BF+YUemxlE6v8cAzaXImLH307Fg9kK5379SinuW7fDwNH0lXGXJUgNk9fa9/wCtngUAEye9B9TDAa7IMWSOPGRm2n3Vo3+g+LDKnmDSy/e8249vOlIT4sIuLx1UG4/fYDmEgdeNUMNlT/X8N3hEVM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768297760; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7HuiD7+s6cVgC847twjsLVrmuqSVh2trDlFjvAvFr7Q=; 
	b=HhwD9VISSrN1bzkF43j+CSZC9Sl1gOYY3YTToFxv22CeguVH4CMqKrsex9/FT1TG+dl0C9ftpqhICIO+iwP7HyXV2gc8OXLG42X2ldeX9logxjoHxjJt4G6gW2aWwX4yVgjvbfonPBHBlSMTLJO3KHabImTogYuqABF2dYnc4/M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768297760;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=7HuiD7+s6cVgC847twjsLVrmuqSVh2trDlFjvAvFr7Q=;
	b=LEiq8eqKT5IKnfR53+1Th+VMGiA/sRq28dPakmO72GXjEQ1yiGxJs5Gr5shkAFB3
	Ct6ZJ/WRECgwgisv3ITwz00nC5yyvQlfXmYroAWq8lwnU9QMCxNdgZsIzWEO4+FB5bq
	hT89n8sGxpJvfLoI01t+NwuOzEXhzKQA9JioFCHo=
Received: by mx.zohomail.com with SMTPS id 1768297758027287.7379833509633;
	Tue, 13 Jan 2026 01:49:18 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Chris Darroch <chrisd@apache.org>, git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, Chris Darroch
 <chrisd8088@github.com>
Subject: Re: pre-push hooks and stdout regression
In-Reply-To: <ab578804-891e-edcc-12a6-8b1030d1bacb@apache.org>
References: <ab578804-891e-edcc-12a6-8b1030d1bacb@apache.org>
Date: Tue, 13 Jan 2026 11:49:14 +0200
Message-ID: <87y0m1onad.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Mon, 12 Jan 2026, Chris Darroch <chrisd@apache.org> wrote:
> Hello --
>
>    I'm one of the current maintainers of the Git LFS project, and we
> happened to notice that a recent change in Git's "master" branch has
> introduced a regression in our test suite.
>
>    Specifically, with commit 3e2836a742d8b2b2da25ca06e9d0ac3a539bd966
> ("transport: convert pre-push to hook API") from the "ar/run-command-hook"
> merged last week, it appears that when a pre-push hook such as our
> git-lfs-pre-push program runs, messages it writes to its standard output
> are now delivered to the user's standard error stream instead of
> their standard output stream.
>
>    I suspect this is because the pick_next_hook() function in hook.c
> sets the stdout_to_stderr flag for its "cb" child_process argument,
> and that function is now used to run the pre-push hook.
>
>    Arguably, the Git LFS pre-push hook program should write its
> progress meter messages to stderr, but since at least 2017 it appears
> we have used stdout for this purpose:
>
> https://github.com/git-lfs/git-lfs/commit/d665f7d725150761fe3b196da2c2d4448f7d2c61
> https://github.com/git-lfs/git-lfs/pull/2732
>
>    We can certainly work around this change in the Git LFS test suite,
> since our progress messages are still output by Git, just to stderr
> instead of stdout.
>
>    However, I think there remains the larger concern that users who
> depend on the existing Git pre-push behaviour in some way may also
> encounter regressions, perhaps because they expect (as our test suite
> does) to see certain messages either output or not output to stderr
> during a Git push operation.
>
>    Please do let me know your thoughts on this subject!  If the
> consensus is that the new behaviour is correct, we'll adjust our test
> suite to match it, but I'll wait to hear the outcome of any discussion
> before making that change.
>
>    Thank you again and all the best,

Thank you for reporting this, it's exactly the kind of regressions I'm
looking for and the reason I did the "Extending git without breaking it"
presentation during the mini-summit a few months ago (video should be
online).

I tend to agree with Brian that going back to the previous behavior is
best for now, maybe schedule a breaking change or extension to make
hooks to print to stderr instead of stdout.

I will test this on my parallel config based hooks topic towards which
this conversion is building up to and send a patch or report back ASAP.

Of course I will also run the git LFS test suite to confirm the
regression and the fix.
