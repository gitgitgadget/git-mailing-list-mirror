Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB654CE67F
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 14:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790605657; cv=pass; b=mV+6hOfbhuYheNZwvzioZA7F6T4whTXUotAMmej8UAZlfDiSkg/8nQGK0MVzE6bZZCy5l7FC0TSb5IDO3UwYmJdoour6M/Qg0RsT+67k7NZ+TV1YD/tv/QGU7G2iHlEjGyu2qZu6mV4GPbIiwCyepB3ZMOpsrM6nP8QZWdf2+Cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790605657; c=relaxed/simple;
	bh=VGcmwdgJLCzG1rHMBf5EzX803HCZD1cceO6EZEMewPU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=mj9LB3mO8KxMxKR0TU8IaulMJVOJXBSH49akOeDbI9Ujuk1HVmMyDp0zmclC8yIhGINc534Zpc6/5LmJhnwh0k5KgwTwNJ65mzLLE0E3LfVJlJefMHs1dMQUba2zVt1L3DFZ3Hg+7AOv35lO0qMqOMQ6uSanc9f1pUZH6OQwMpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T73Lss/G; arc=pass smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T73Lss/G"
Received: by mail-yx2-f40.google.com with SMTP id 00721157ae682-8a894197c96so21902077b3.3
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 07:27:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790605655; cv=none;
        d=google.com; s=arc-20260327;
        b=IQ9zWGlKwniZEOCRxrRXggdCe7LpU+EMcwVolknJ6tXRstSDEIafxvMB3Ti5wcF+LJ
         +OQG2xsuU3z2t4RgiCOb9+e7KWQUTPeBRI5NnWA9BX3bh21nZm6faeL8p6xYRwF5rvqT
         qGXvmsUln/C31vEdWZP6e+hYZWR7791NtPtIqc/fxQgF8qLLq2RCho9a09Xfjz1AUPNk
         mXIeJ8gYmkQd73uEbFnV66WgM49mT6eTTKAoe5EGAkN56ZyuN0+Rb9fMTz8vygcPWrEN
         PHCxZLiqwirDbJJ08RPIg278JiAmB349zDSFPzbCU/kZxPyHoA/E9nD/3QMOOA6Ed1Lx
         VaLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=8CJggjtPIqaPxHhpEPFDHo9m5xnilcyjAY8XKmwHjAM=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=DZb3JmD5VqDh2o7fp2vpfWPvDi+OoLfoMXsKQ3kK8xdQTycI/j9Cs/WI/BdMwBWroD
         wBJOr7Q41Y12UAUAH6aXE6s+0MSFsd0GmtmwF5cC3eCEhjPZ4x3jFCdDYs9LPURckFzs
         NtbUfMuGg2c4f2tWSqpICmTpyeplCsxI1j1oPepQndArrYzNCWqXxr5PreR8+or9eq8D
         vSkike6aB5qpIpyM5jLz1fNYdOk9poYK8mOyrrxFOCmE7iasvT34+7NfoAFaEVYBWLK2
         O6bZ29wCz8mXG0MdCTXJwZTCwFd4IRm7AwY5jZdPoTOnW8zvKIyy4UvOK89dxI+YwIfh
         yICg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790605655; x=1791210455; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8CJggjtPIqaPxHhpEPFDHo9m5xnilcyjAY8XKmwHjAM=;
        b=T73Lss/GLb8+WJfbGHaTMOFDuiyWgy+gw590atzqqNdLNh1ft312skjPFBjJNuYy9k
         m3GLCL5mA+CBLM74BSJhzpdMdPhDXTMhhbl3WRs9PJAoFqLnhkfM6yxl5Oa0yOpnF+95
         y8oEWzL/Tz/sC+qoieGHutCwmElx0lpx2TM5Dpcu0Wenl0ktvA1I23FD3ClS7yfppzkd
         sPCnfNDQ3kZs4mvHkwfavC2rZHO+T7ecYg5/X8gHcI3O30F0WE6/3FGqI4oEMNryOlc3
         /1e9KaioKkY/tqB+dXBfc+Y/KjwZnCyT6GFONyUIL1tC8zgVz56yAWIl5llWK1oceK7B
         OKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790605655; x=1791210455;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8CJggjtPIqaPxHhpEPFDHo9m5xnilcyjAY8XKmwHjAM=;
        b=bII+WSSoJ0UGJimoyif4+eidtF7FJSA+IERv6ernpyURz+liz6aY+I1qaL0gaRWgvP
         przEDQ+WSW5obEPdYXbjbMA2EIRpsVUqrGvDZRfXsMuyhuCWZ5FsUBqwYNwNr+uGXpua
         DtXlC3ckYaAl/Jkgttd8kftrhl6KRoQrjnIQNqouIfUlbym5hrjAN4IlKEoRElHIC/cy
         0VESRo1VNR2iyShttz3cwMYKVh9f4WHvmOFspjdaQAFtSaKpg+Co2aazXbl4uwfLQi/s
         kXdWRusiShCzbqyE9W+XTBrWdwcOpif+eXif0p3YsXvUrv8AhJk9XKtlUyh3LMQL85fB
         kHpw==
X-Gm-Message-State: AFq9FYLwGJdi6wEJXzItZlX2FyKLqhY9CEun6Lk/aiml1hFU6UFkYTMI
	HEJVxJKvskU/VozkeeNEiKZBaF5EfjslX8SPXfsgsuFjweob3NTa3lGWuq73XYmXLfqGu3tWlzH
	GgmXBTvJp7HfHPuZJCPqjxof+/Z1FVhKl1ERkBKGB5A==
X-Gm-Gg: AYBFou32urpzPTPiyVbKKW9FXnsKzT/AuNrbT3EIa09mSm2IjJoEsX39xWcdHvjUBts
	Npfc7kpGPNdrN4sKkUlQkwkGHdbCxcSRJxbQOcqveIN83O5U3KY8eNQDXf4Dq6kGCLyC94lWXdb
	BZqv5MVzES5UiyvStjzeLn/2LnfoA2bxV2PKhxb8L7tdmezVvdPScHvr3J3nKTRzFDj9iy3j76Q
	ijnIlIoIFTHBEnZZeDKzojv0GvGnxpNbcbifz/Kyo8EDwQJf6ZsKNdlULKbJLqEYmVJuA2DACkc
	Nu4M2/+qa1lPVmiaVO/AOiUIv/KaljEWQ+4cE5VcXWiXPnS2qDxEyOc2
X-Received: by 2002:a05:690c:3481:b0:8a8:6aca:ca6c with SMTP id
 00721157ae682-8a86acad1edmr32893557b3.28.1790605654847; Mon, 28 Sep 2026
 07:27:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hanan Arshad <hananarshad619@gmail.com>
Date: Mon, 28 Sep 2026 19:27:23 +0500
X-Gm-Features: AclHuK_7MvvnWwiUZa1JyrErgXjYxPU65yOQHTzJiLGalVK37d-GwouKs-uer9o
Message-ID: <CAKPibBw2XxjGpE_DZrWLZmMHs7kAyvOaP8504kfoh61c4UkGyg@mail.gmail.com>
Subject: [RFC] git stash: add porcelain for sharing stashes through remotes
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I'd like to propose adding a small porcelain workflow for sharing
stashes through a Git remote.

git stash export and git stash import already provide a transportable
representation of stashes. I tested the following workflow using
existing commands:

Alice:
  git stash export --print stash@{0}
  git push origin <export-tip>:refs/stashes/alice/wip

Bob:
  git fetch origin refs/stashes/alice/wip:refs/shared-stashes/origin/alice/wip
  git stash import refs/shared-stashes/origin/alice/wip
The imported stash is a normal local stash and retains the original
stash object ID. Removing the remote ref afterward does not affect
Bob's imported stash.

I'd like to add porcelain around this existing mechanism for four operations:

1- publish a selected stash to a remote
2- list available shared stashes
3- get a shared stash as a normal local stash
4- remove a shared stash from the remote

This would not introduce a new stash object format, server-side
service, or synchronization model. It would essentially compose the
existing export/import mechanism with normal push/fetch operations.
Before working on an implementation, I'd appreciate feedback on a few
design points:
1- What remote ref namespace would be appropriate?
2- Should shared stashes use an explicit user-provided name or an
object-derived identifier?
3- Should listing only inspect remote refs, or fetch the export
commits so stash messages can also be displayed?
4- What command naming would fit best with the existing git stash interface?

If the general direction seems reasonable, I can follow up with a more
concrete interface and implementation.

Thanks,
Hanan Arshad
