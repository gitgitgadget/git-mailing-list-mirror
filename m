Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E4A23236D
	for <git@vger.kernel.org>; Fri, 11 Apr 2025 18:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744395812; cv=none; b=AX1iL0STRqTlKnhasTOsdpTcrj9s4/tm95C8mGo72wOm/xRyC3aZH0R7D8HTUv+gFzpISzVAnssmARzFP3BvspBr78tTIq2PbLKU0lQh7x+dZjPJEQ/deQp/ZCr5WS7AZqT2N0y4SSQz9vqYznCDEo0vtPbn6EPuq36DpYE+cEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744395812; c=relaxed/simple;
	bh=bcoE4BqzMP6mn4GHfn+4XNqNrffVKZhDkMt7NbNwdXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ri8n7bHLGUb1hmXZBWp3IJ1xO/ISoLzWMTQCC4Ui6i9C8Kal+fMBT4x5aGMwyhTiWgQBQS0Bq7RArGFMQ1seWSYuuPtpFH4x5PzOFGEpbuGe6y0CPMPVMFOsC4ypJ5aj0aA153sfWQ6yqX3ltbEzy51Zq95JmJ60eFnqjOBAQyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1jJ8aid; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1jJ8aid"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e614da8615so4646338a12.1
        for <git@vger.kernel.org>; Fri, 11 Apr 2025 11:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744395809; x=1745000609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcoE4BqzMP6mn4GHfn+4XNqNrffVKZhDkMt7NbNwdXE=;
        b=e1jJ8aidkUFEMvGeWmdVU3y8/VH4wKsml9M1/eGPI4IJEMDMYWHwxkTqn9QAu/+ZPO
         0MrcNUURkS6ZL6WhrE3dg8osWj+3C828wkmuFSv09CGaNv4/9kucmsp87sgwDq4u8AJs
         hg109ZVJIdXV4eW5Zh4rMl4nM4tjNAkaq8IHBlfZf+v2cAcUgVDDz3v1FeQgjcRMeqHs
         7dzwDmRHfMmYrXiAu4Dfij2q+2FGfG0GopeoxBi4nceUbxiAK2oLnl5yl4R34oTOewj2
         XeB+i311shq4U84XWeayRCIzbGsLLLRcQ40YQus9+dss/IdZCWFeJLxIye4PQvuAxMuc
         ke6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744395809; x=1745000609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bcoE4BqzMP6mn4GHfn+4XNqNrffVKZhDkMt7NbNwdXE=;
        b=NKjRgFWWzFmc1gtq64NrvVQpWVJ9wymUJvyVnITLituAHtVhCPeE4QI3odzxl3Tcis
         k/DEkSPiIbCSvWgNF5Qfjmo7lkR7qnF4kK0TyT12m3OEk0Efp+bOH9Fh0/w1akpw2PWu
         gKYY83Ahh5p/FmLZgDiSryxSvw5nLIBw0qi70d6+WxLym/PFi64ViZ/zzUw6nCFIkrJB
         u9sxPMlYyWUjceZPkVqSO1vKOgVgNPGqpQBqVvAE7hODbTlBZndY1XgNikHsOp8wIFhG
         eW10Lg8mxKxrU8fRihEZ+2efeRlWZEpl2wMgYMyyo/YebwqbnzE9/2EgOcYjm/7UZwgZ
         0Prw==
X-Gm-Message-State: AOJu0YzcC9TDytFJQekExmhYiGWNhDv79AcznbxncU9SrBYOAOvO70qf
	G+sYPxso5m1KWDgz2CnipNV03QOTT2h9Z3MecxhlclVM6jnJt1RAqw0fWXNf+0dcF17XYn7IgB/
	Xw2TMlLX7fF7jXH4YqPqjcGeMOKTHAVRR
X-Gm-Gg: ASbGncvSvDEu3pPhNTcBA+YulwxA1VPAkf7kLxEN3/jPqugkYesJFewN39kyUKjBplg
	OKr4hdnM22MpNjQWH+9gFEdHj4PglYzMy9D8P2y+Z340iGXVZz4X9mG5vpUuLLTeiGDMjYVE/VE
	dOvTMFBTIMEH+NmHaKjoj5j2Ne5ktXeKOnUFzkS+0dQbXpJXqMNbv/GA3l
X-Google-Smtp-Source: AGHT+IEcjlLIg45rld5eIMacXw1L/lmcZtZJl5QYVw5kyGIySKDc+UeOpNVI3pDtC3UR6SlTqj71iNBYBR/ZkmjQjac=
X-Received: by 2002:a05:6402:909:b0:5ed:17d9:91d4 with SMTP id
 4fb4d7f45d1cf-5f329fc2346mr6496042a12.8.1744395809057; Fri, 11 Apr 2025
 11:23:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <76edd34d-3fd1-437e-b8d3-7e64e99644a2@gmail.com>
In-Reply-To: <76edd34d-3fd1-437e-b8d3-7e64e99644a2@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 11 Apr 2025 14:23:18 -0400
X-Gm-Features: ATxdqUHMXfg4Xl-dbsreT3bUjyyzHO7E6ct4_6qs6L6wxMKnKSlfDotLBFwyK1s
Message-ID: <CALnO6CCbzqez9-BvbuV3NRRMvFLHSv57Tfwj3ibadUAMKznWrw@mail.gmail.com>
Subject: Re: Bug: being stuck in rebase mode when accidently typing `git am`
To: Ludo Pulles <ludo.pulles@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 10:35=E2=80=AFAM Ludo Pulles <ludo.pulles@gmail.com=
> wrote:
>
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
>
> 1. Run `git init` in an empty directory, and commit once.
> 2. Run `git am` and press Ctrl-C.

Doesn't `git am` print a warning about how it's reading from stdin?
Pressing C-d at this point to send EOF just exits "normally."

> 3. Run `git status`. It will say: 'You are currently rebasing. (all
> conflicts fixed: run "git rebase --continue")'.

Yes, this is odd: my shell prompt (using the contrib script) says
"AM/REBASE", so I know better: git am --abort does the trick.

This seems like a failure of git-status more than anything; I wonder
if there's some difference in how the prompt script checks for
in-progress am vs. how git-status does it?

> 4. Run `git rebase --continue`
>
> What did you expect to happen? (Expected behavior)
> I expected to go out of the rebase mode such that `git status` would
> say: "nothing to commit, working tree clean"
>
> What happened instead? (Actual behavior)
> It outputs: "warning: could not read '.git/rebase-apply/head-name': File
> does not exist."
> Moreover, you are in rebase mode forever, and you cannot escape from it!
>
> What's different between what you expected and what actually happened?
> Instead of going out of rebase mode (expected), you are still in rebase
> mode and you cannot escape it (actual).
>
> Anything else you want to add:
> `rmdir .git/rebase-apply` fixes the issue
>
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
>
>
> [System Info]
> git version:
> git version 2.49.0
> cpu: x86_64
> built from commit: 683c54c999c301c2cd6f715c411407c413b1d84e
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> libcurl: 8.12.1
> OpenSSL: OpenSSL 3.4.1 11 Feb 2025
> zlib: 1.3.1
> uname: Linux 6.12.22-1-lts #1 SMP PREEMPT_DYNAMIC Tue, 08 Apr 2025
> 06:20:12 +0000 x86_64
> compiler info: gnuc: 14.2
> libc info: glibc: 2.41
> $SHELL (typically, interactive shell): /bin/bash
>
>
> [Enabled Hooks]
>
>


--=20
D. Ben Knoble
