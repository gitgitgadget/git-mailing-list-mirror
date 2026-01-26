Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C3B33A9F0
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 13:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769435972; cv=none; b=QBGHXduH1Kx9yAvki8jyROivT4KKYo0TMjqdwt8p3j0VvRvhc9OA5P13TKvb86Hb5+d+WsqoV2EupKO+35FI5I7LwXPzYGH11S3sB90btT1zA3UYU+aq85Y9h25GnzCgo/kkLQ3RmgmOfE7UCmyTrqdkTh9Og9NZpDcunwHIvO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769435972; c=relaxed/simple;
	bh=ZXZxhntjxyCcWqBWbQHKmVRa0B8Kf6h1F6/kHkx45No=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nAV2KDk8BpV3gyo2YuvfGWExX2usKV1U71lwMMtGeL9ojuIVKno76pbb+u0IoosGRaPzsAsYPP1ysddWHYexD+EVEPT3GjrC0YA0wMzCh1e47Gh4UiM9piz8yZrq9gLAZGiEMpH4xvYrjaUPSJWaMdZqQpN+IvOUq7SvE8zucWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4f09Bd54TXzRnlV;
	Mon, 26 Jan 2026 14:59:21 +0100 (CET)
Message-ID: <07014d88-67ed-498a-8cc1-423c77972fd7@kdbg.org>
Date: Mon, 26 Jan 2026 14:59:21 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] diff.tcl: fixed alignment of tabs in git-gui diff by
 using spaces
Content-Language: en-US
To: GitHub Chris Idema <github_chris_idema@proton.me>
Cc: git@vger.kernel.org, Chris Idema via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.2179.git.git.1769424301394.gitgitgadget@gmail.com>
 <01d0faaf-99fb-42a4-befd-bb7f359809bc@kdbg.org>
 <Lj9kojJwK1ZAtvE5nj6rTq5EXf1-QhsRlmBDM9YntbYeWb3J07mlbM-njNco2XT1pSPXsNVbo9Uc5kJOHihb11odjthYN4YtuhVdNwxSIqk=@proton.me>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <Lj9kojJwK1ZAtvE5nj6rTq5EXf1-QhsRlmBDM9YntbYeWb3J07mlbM-njNco2XT1pSPXsNVbo9Uc5kJOHihb11odjthYN4YtuhVdNwxSIqk=@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 26.01.26 um 14:32 schrieb GitHub Chris Idema:
> Here is how you can reproduce the problem:
> mkdir test_tabs
> cd test_tabs
> git init
> echo "" > test.c
> git add .
> git commit -m "initial commit"
> echo -e "int test1\t= 5;\nint test11\t= 6;\nint test111\t= 6;\n" > test.c
> git gui

So, you mean that if the tab width is set to 4, then the tab stops are
not aligned anymore?

>> Do "Stage Line/Hunk for Commit" still work after this conversion?
> I'm sorry but I don't know what this means.

These are commands in the context menu of the diff panel. They extract
the text from the widget and massage it into a patch. My suspicion is
that the patch text does not match the actual file contents, and so the
commands fail.

-- Hannes

