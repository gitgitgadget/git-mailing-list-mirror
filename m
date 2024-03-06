Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DF112D75D
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 12:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709728609; cv=none; b=WRp5b/S97HS1WI+6ycyRG6Nxw8vdnkSVWd3b6BHKGz3jU81S99b8iPWZHYIlhIHGl/TThvLPQ+hzZ4l1F6h4v57JaVjjkAPR4mEuGaKOYTVc1Suc60yLQtsz+Ztc98Z64Fw0yviaqgjz7Wozkvt8Bs8qJQTOptueeGkVSjx1r0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709728609; c=relaxed/simple;
	bh=Hb4QQfg0UI1jViO168xV//ecVhElC4dERqNnGRauQcg=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=rLV2jEcs0H4cFGPV3SRqYm+qPsvTkHFnw3tQs0dwcBNDzzm0SqjB0yiPd6nKoAd6hRxG5axwmVZbThwHOoVIW3wiWLxHU1SlfT4HZ/EJUXUgTp/WDgZ1U+cixy53Ez+dkPA8q0RFkxyK69XeSXuecWUuz9vr8HAKTmRnj2WiOwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=mqiwRRD8; arc=none smtp.client-ip=185.70.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="mqiwRRD8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1709728600; x=1709987800;
	bh=Hb4QQfg0UI1jViO168xV//ecVhElC4dERqNnGRauQcg=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=mqiwRRD8JDY1OfK2OZdEb7sfEtF/81pVBg+FeyXIaz0q7jdNnZZJGl7qiT/Drdiyl
	 2gwuOENqr0lXCxRjh2YKabd7BQNY9E03g5DmV/ZcX0BN7VdILARqp6IfODe8ntvpc4
	 wqjF7fPJ0uC8F0FlFMHHeNiXyKceqNzKWpN/Te3Rik6EdA7roRlc43WKBDrPy++ZNo
	 VjaATqiEJWwNHxlfJvcFVv7Pfqq94crqW/aPBH5/a3fU1pvNzoNpbnoJDD7Cbqg+yF
	 uuMCLlYjKTcWUxjOjDex5PvSS6xwUgrY88cdV5ncj1nadTYhG9zlJqGOLdW1btD7TH
	 02x8+XpvHzk9Q==
Date: Wed, 06 Mar 2024 12:36:25 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: =?utf-8?Q?Emilis_Ki=C5=A1kis?= <emiliskiskis@protonmail.com>
Subject: (No Subject)
Message-ID: <q2mAMynyz1lQ9uQagsJCz_D3UvT1gc3kaFiyiyU9dCcHfENOLNstff35j0RS8tKZ9kza2yUvVPZxoIllSR5I9AaBk6H0yN16gaYVcnq7p-Y=@protonmail.com>
Feedback-ID: 64844658:user:proton
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

What did you do before the bug happened? (Steps to reproduce your issue)

1. Create a new worktree with `git worktree add new-worktree`
2. Modify files in the new worktree
3. Move new worktree back to main working tree (i.e. master)

What did you expect to happen? (Expected behavior)

I expected uncommited changes from `new-worktree` to merge with changes fro=
m `master`

What happened instead? (Actual behavior)

The changes from `new-worktree` were lost

What's different between what you expected and what actually happened?

The uncommited changes were lost instead of preserved

Anything else you want to add:

I lost 4 hours of work :(((

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.39.3 (Apple Git-145)
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 23.3.0 Darwin Kernel Version 23.3.0: Wed Dec 20 21:30:44 PST =
2023; root:xnu-10002.81.5~7/RELEASE_ARM64_T6000 arm64
compiler info: clang: 15.0.0 (clang-1500.1.0.2.5)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]
pre-push
