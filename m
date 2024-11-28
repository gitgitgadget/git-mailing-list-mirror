Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93F31F92A
	for <git@vger.kernel.org>; Thu, 28 Nov 2024 21:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732830037; cv=none; b=nx/G3FQ/a/NgQ4lMBOtslr3M+Ulyyit/Rebka0erOv6/YdkzHAcg4E9EHNlRMa//SrlWmgQa6cW1VPPspA/svKBmU0i2Dz32QeFIDxmN6YdvR+tbyUoKAt/+r4iajFHOIBXWIbClNnRvgotNatHebcFvX5UAockSRNNn6AtnruY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732830037; c=relaxed/simple;
	bh=mTZKHno6eTf9muiZ3Riw2+tQjlU9B3jAyPsSXQCGkR8=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=pxVmA7/MdyV3/HtRvkrnBGk6R6wTv8CGaOw0yOreWR1+PJQNbWo3fJHNNeHvLFydo0bWtjzomptj6qY2URmZSIFkpwjAs++hjjpIPEChwJ6ppux0KDOeJVkKb0oGMHzq/6xbBLHXEPlOYEuad+Ijbnh4GbF4eW+swEvtreXjzaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=YcW1s61V; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="YcW1s61V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732830032; x=1733089232;
	bh=ZUA7SXKIFvB8eDeZoM286g4L88otcFHqD3vZSLveRrc=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=YcW1s61VBNjR/aVaNz6Gwalovq97wgyqmCP8mQsEMoGnHnoBFL6vy5IWqL6swETHp
	 vc0QW93GXi8We5F+sVerB0FwQ4gs/pHSMyc+aUSmc4GEZNU2TN754emySww/2HECZg
	 sNcMpCMEKgGu1/PxPMeoekuZGY6gOnt25o9Q1b7PDUAPLeo3/y03aa6a1jnqooIhKL
	 VOgMNtp8MmlZSc/GUGudD1FUuVYhx9bCFQTT0uhGbP6iHUGoV8+iW/FM84+sh8VPFK
	 dlkYPwyAm5iQYSY+rkPG6c4SLwNsAFNNK07qgXQrDZ2Qz+RninaqbAI3rLlR88NZWW
	 qRU4c9Bv4sxYA==
Date: Thu, 28 Nov 2024 21:40:28 +0000
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Subject: Re: What's cooking in git.git (Nov 2024, #10; Thu, 28)
Message-ID: <D5Y4Z7I3PJW2.C2AE3WAKRLLH@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: afc91aaefc02c266c0b7c64eed737c5451ef856a
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Nov 27, 2024 at 11:35 PM CST, Junio C Hamano wrote:
> * cw/worktree-extension (2024-11-26) 8 commits
>  - worktree: refactor `repair_worktree_after_gitdir_move()`
>  - worktree: add relative cli/config options to `repair` command
>  - worktree: add relative cli/config options to `move` command
>  - worktree: add relative cli/config options to `add` command
>  - worktree: add `write_worktree_linking_files()` function
>  - worktree: refactor infer_backlink return
>  - worktree: add `relativeWorktrees` extension
>  - setup: correctly reinitialize repository version
>
>  Introduce a new repository extension to prevent older Git versions
>  from mis-interpreting worktrees created with relative paths.
>
>  Will merge to 'next'?
>  source: <20241125-wt_relative_options-v5-0-356d122ff3db@pm.me>

There is one test that I've updated (added a check that was accidentally
removed). I can send that as a reroll if you'd like, otherwise I think
this is ready to go.

Best,

Caleb

