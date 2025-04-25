Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E248136351
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 07:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745566532; cv=none; b=Vm8yPaOnLICbVyaHyTU4dJDs4AN0Kk8KsLvHaK193MBlKsxVKKV3T747ybOEhKd5TarOxX3DO77xAG2dGfvmwvUt5EsL4B6iMiWCslT6Mzxgf1Hx35rA2n8rn8rW4jFuHcwcAMqkn/lpfbRHE9dSsuEyGd9oO263CqDtzaBAkGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745566532; c=relaxed/simple;
	bh=fbY8/ovKv3kOkkEo2vSvHc8xcVf1PNNxruSecc5ZBHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=srgmO/j/clPLdchb9zh58svFFWxd0vnY0XT1/Czc+ZA8GGsb5IuxyTUC++M80E5hHDsQRmyVnif0Ih5Mbn43PmMIPnCuc9qidyKMWotsVjkJdIWz1zlMFDP5mz7eXEVEgUSJ6IkQBjr31j16Iege1FaD2BPYyK4gkjPXezLxPE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COPTYIpu; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COPTYIpu"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6feb229b716so18815037b3.3
        for <git@vger.kernel.org>; Fri, 25 Apr 2025 00:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745566529; x=1746171329; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ChdrfZ2XR2tvurh2eUDd98TMsoGqvrKUPTx/JlQnJds=;
        b=COPTYIpuVhJf6wQcapd/Ci39IeYjf0Neq/4Vp6++lPPpNaBgJmcnatTDLrJo9sBOWa
         3GlNij+nJjUQYrHvrAOWKPIayzNqZsH1A/6yp43ttPuXhuUyUnUv1Ee9f5PsUiAB/w45
         S1pzoFAmp+OEHhPui81CYmZjQeRW4yYyfWD/VsEgmRPQDyelgi2xuM0dryJVLaPi4gAk
         zlVnmqjKcMoUog+LcsrpjXg2/FHzUfBPI/0o9zx3HKHWJSj3myeFQtebCgHYLogpHGLz
         UoQzVHGFoGEqxTBIFt9kYuNhB63KbGiajQa0euh8pTjMFba83dhXqFuj91D3jhQV1xfF
         UUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745566529; x=1746171329;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ChdrfZ2XR2tvurh2eUDd98TMsoGqvrKUPTx/JlQnJds=;
        b=vQU4dh+Xr3Xw90oPugaQ6ZYXJ3LOfQhpeMhLOIvKWUefLobZVXHt3Yh3GjiOuCULm7
         RqThkfOpWyjq68mWJNJro5XE5wcRfWOhrRNHHGSe3yP8NJWr9YGUF7MUqa/l4yDQI16x
         5Bl50Arc07kns36iuI3E1tmt/yYBtn2QLe+wymb1SIavK3gr+mjTTFCcoIfcMZV+tbvY
         tFh94v7Smrljq3TuPuyUBvtpVFODRXp8SlN5B2QmrseJFDRY66orur6K11LKj9Ezuh0k
         Kswm8pHbwZjMjhhag0yUpdvlprD7xW5Kr3Q+m+UCuuq4ESO19iq5/m39+TLQJFiimBY5
         WwYA==
X-Gm-Message-State: AOJu0YyKLyUBp4VR3Zhy/V4yW6UxhgaeJbdeP1y/wVGJyRaXdabI6Qdx
	lsdz9cp2CaX/OEGNMlTL/6xJGLi6rwwbc2uFdlBPUsSxn/sWNVnYBJsjvPTAnQ/T2ASssqhu2pp
	49C08C/cCH5paFe1TJOzSYS7+KA4t1Ylk
X-Gm-Gg: ASbGncsaqCPjZWU7Pw+uvv1tNbwQhbJVEkAV8mFTsxChQZoZyUnblUJ4OSpNVVQrcaB
	sNlVon02YxtvRDAzMMVFV6Ccx5kRUNBeeyzClAhJI/fxNIWmz2XvlQ0seqZn3QMZ4o2dSyf/A4L
	A+DrQH3EMt9f1RdsNpe7cwTAkGv4wtyxpZpSt1eRgs3cfJz1P54IfQ9BEc
X-Google-Smtp-Source: AGHT+IFvH5F29Qx9V7cTfbLEcVPb6qlNSuxn9qJ8y98eqsiDgn0nt70kTotUOs606OkoQ62h6ucb562DGsRqqEsQbHo=
X-Received: by 2002:a05:690c:6485:b0:708:3532:ec9a with SMTP id
 00721157ae682-70854202f58mr14569447b3.34.1745566529176; Fri, 25 Apr 2025
 00:35:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALDohY2O1fbSDR8kTdpQCnZp5Cbc6QYKmT+LhbbaExgAqxaWoQ@mail.gmail.com>
In-Reply-To: <CALDohY2O1fbSDR8kTdpQCnZp5Cbc6QYKmT+LhbbaExgAqxaWoQ@mail.gmail.com>
Reply-To: justingolden21@gmail.com
From: Justin Golden <justingolden21@gmail.com>
Date: Fri, 25 Apr 2025 00:35:17 -0700
X-Gm-Features: ATxdqUEwmbICTBZPhQ0sS5CTbm1fIu0CwNefF67qVRzyi4AxJixLiHv4vPAUBDw
Message-ID: <CALDohY0gaMLviB-HRvwFWr5uRjfhpidQiMaFGgqmGQhj-XWaxQ@mail.gmail.com>
Subject: Re: Git Bug Report - Weird file behavior and unable to change
 branches with no changes
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tried closing all programs, restarting the computer, running command
prompt as admin, running garbage collector, and it still fails to
allow me to run "git checkout -- ." It always says Unlock of file
failed. I think my git instance has been entirely broken. I have no
idea why. Definitely feels like a bug. Thanks in advance. I've been on
this for many hours and can't use git or change branches or anything.
Been using git fine for close to a decade.

On Thu, Apr 24, 2025 at 10:50=E2=80=AFPM Justin Golden <justingolden21@gmai=
l.com> wrote:
>
> What did you do before the bug happened? (Steps to reproduce your issue)
>
> I have two component files, Button and Tabs
>
> There was a casing issue (button vs Button) before that I thought I
> resolved, but it failed when I built in dev
>
> So because git doesn't track casing changes, I did the correct thing
> and deleted Button, committed my change that I deleted, then added it
> back, and committed that.
>
> I ran git config core.ignorecase and it said it was true, so I set it
> to false and then checked and it said it's false.
>
> Now for some reason, it shows that I'm CREATING TABS as a new file in
> my working changes. AND, when I check the pull request, tabs is there
> but button is missing
>
> So I clear the git cache with git rm --cached -r . and then run git
> add . to add every file.
>
> And it shows 3 file changes: 1) deleting Tabs, 2) changing another
> unrelated file which has no changes shown, 3) Also changing another
> unrelated file which has no changes shown
>
> So I push it and locally I have tabs and button and in the pull
> request I have tabs and button locally. So now I have no working
> changes, everything is good, and I try changing branches from design
> to dev.
>
> It won't let me because I have changes. I check and it says I have no cha=
nges.
>
>
> C:\Users\User\Documents\GitHub\desktopclock>git status
> On branch design-system
> Your branch is up to date with 'origin/design-system'.
>
> nothing to commit, working tree clean
>
> C:\Users\User\Documents\GitHub\desktopclock>git checkout dev
> error: The following untracked working tree files would be overwritten
> by checkout:
>         src/lib/components/UI/Tabs.svelte
>         Please move or remove them before you switch branches.
>         Aborting
>
>
> What did you expect to happen? (Expected behavior)
>
> The file changes to be tracked. No working changes.
>
> What happened instead? (Actual behavior)
>
> What I mentioned above. Random files were changed, no changes shown.
> At minimum, after status says tree clean, it shouldn't stop me from
> changing branches because I have working files.
>
> What's different between what you expected and what actually happened?
>
> As I explained above, the entire thing is unintuitive and seems buggy
> to me. I love (and trust) git, but this definitely seems like a bug. I
> know that no changes shown can still have line endings and that git
> doesn't track casing unless you tell it to. Still, all of the other
> behaviors I experienced seem like bugs. I wish I had repro steps or
> anything else for you.
>
> Anything else you want to add:
>
> Thank you for working on git!
>
> [System Info]
> git version:
> git version 2.36.1.windows.1
> cpu: x86_64
> built from commit: e2ff68a2d1426758c78d023f863bfa1e03cbc768
> sizeof-long: 4
> sizeof-size_t: 8
> shell-path: /bin/sh
> feature: fsmonitor--daemon
> uname: Windows 10.0 19045
> compiler info: gnuc: 11.3
> libc info: no libc information available
> $SHELL (typically, interactive shell): <unset>
>
> ---
>
> git clean -fdx
>
> This deleted almost every file in node_modules. It's gitignored.
> Here's the gitignore:
>
>
> # Mac
> .DS_Store
>
> # Packages
> node_modules
>
> # Build
> /build
> /.svelte-kit
> /package
> /.netlify
> coverage
> vite.config.js.timestamp-*.mjs
>
>
> I know this is because of the -x flag now. But even after that, when I
> ran git status, it was clean, then git checkout dev failed:
>
>
> C:\Users\User\Documents\GitHub\desktopclock>git status
> On branch design-system
> Your branch is up to date with 'origin/design-system'.
>
> nothing to commit, working tree clean
>
> C:\Users\User\Documents\GitHub\desktopclock>git branch dev
> fatal: a branch named 'dev' already exists
>
> C:\Users\User\Documents\GitHub\desktopclock>git checkout dev
> error: The following untracked working tree files would be overwritten
> by checkout:
>         src/lib/components/UI/Tabs.svelte
> Please move or remove them before you switch branches.
> Aborting
>
> ---
>
> Currently unable to switch branches:
>
>
> C:\Users\User\Documents\GitHub\desktopclock>git status
> On branch design-system
> Your branch is up to date with 'origin/design-system'.
>
> nothing to commit, working tree clean
>
> C:\Users\User\Documents\GitHub\desktopclock>git branch dev
> fatal: a branch named 'dev' already exists
>
> C:\Users\User\Documents\GitHub\desktopclock>git checkout dev
> error: The following untracked working tree files would be overwritten
> by checkout:
>         src/lib/components/UI/Tabs.svelte
> Please move or remove them before you switch branches.
> Aborting
>
> C:\Users\User\Documents\GitHub\desktopclock>git checkout -b temp
> Switched to a new branch 'temp'
>
> C:\Users\User\Documents\GitHub\desktopclock>git checkout dev
> error: The following untracked working tree files would be overwritten
> by checkout:
>         src/lib/components/UI/Tabs.svelte
> Please move or remove them before you switch branches.
> Aborting
>
> C:\Users\User\Documents\GitHub\desktopclock>git status
> On branch temp
> nothing to commit, working tree clean
>
> C:\Users\User\Documents\GitHub\desktopclock>git add .
>
> C:\Users\User\Documents\GitHub\desktopclock>git status
> On branch temp
> nothing to commit, working tree clean
>
> C:\Users\User\Documents\GitHub\desktopclock>git checkout dev
> error: The following untracked working tree files would be overwritten
> by checkout:
>         src/lib/components/UI/Tabs.svelte
> Please move or remove them before you switch branches.
> Aborting
>
>
> Also:
>
>
> C:\Users\User\Documents\GitHub\desktopclock>git checkout dev
> error: The following untracked working tree files would be overwritten
> by checkout:
>         src/lib/components/UI/Tabs.svelte
> Please move or remove them before you switch branches.
> Aborting
>
> C:\Users\User\Documents\GitHub\desktopclock>del .git\index
>
> C:\Users\User\Documents\GitHub\desktopclock>git reset --hard HEAD
> HEAD is now at 98c4b5c4 Fix file casing issue and re add components
>
> C:\Users\User\Documents\GitHub\desktopclock>git checkout dev
> error: The following untracked working tree files would be overwritten
> by checkout:
>         src/lib/components/UI/Tabs.svelte
> Please move or remove them before you switch branches.
> Aborting
>
> C:\Users\User\Documents\GitHub\desktopclock>git status
> On branch temp
> nothing to commit, working tree clean
>
> C:\Users\User\Documents\GitHub\desktopclock>git checkout dev
> error: The following untracked working tree files would be overwritten
> by checkout:
>         src/lib/components/UI/Tabs.svelte
> Please move or remove them before you switch branches.
> Aborting
>
> C:\Users\User\Documents\GitHub\desktopclock>
>
> ---
>
> Fixed by manually deleting the file via windows explorer:
>
>
> C:\Users\User\Documents\GitHub\desktopclock>git status
> On branch temp
> Changes not staged for commit:
>   (use "git add/rm <file>..." to update what will be committed)
>   (use "git restore <file>..." to discard changes in working directory)
>         deleted:    src/lib/components/ui/Tabs.svelte
>
> no changes added to commit (use "git add" and/or "git commit -a")
>
> C:\Users\User\Documents\GitHub\desktopclock>git checkout dev
> Switched to branch 'dev'
> Your branch is up to date with 'origin/dev'.
>
> C:\Users\User\Documents\GitHub\desktopclock>git status
> On branch dev
> Your branch is up to date with 'origin/dev'.
>
> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
>         src/lib/components/ui/Tabs.svelte
>
> nothing added to commit but untracked files present (use "git add" to tra=
ck)
>
> C:\Users\User\Documents\GitHub\desktopclock>
>
>
> It showed I deleted the file from temp branch, then when changing to
> dev that I am adding the file.
>
> Git certainly seems like it's in a broken state and I'm completely
> unable to fix it.
>
> Thank you in advance!



--=20
Justin Golden
contact@justingolden.me
https://justingolden.me
