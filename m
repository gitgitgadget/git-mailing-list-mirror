Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CA8309F1D
	for <git@vger.kernel.org>; Thu, 28 May 2026 21:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780002224; cv=pass; b=cloem+j9qPh+KhaynFTeA8TkSOP3UReOvhJT1YshoUA896lMNZ1ZoX1OK7VK+SP01i4ePCgWxnYEUV3I9KinsiYc6+bYbDrs712Z2Na3Te8Nbfj47ADV4O1oVxJUrL0MFWJ3mDcOf5aTwOxq6y9JgIb11CjpAFVao0JswBaEy9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780002224; c=relaxed/simple;
	bh=bFAfx31z4rYUdi7omcMoTsHKY9+fvta5PEQA62zdoO8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=OIoThh0WoKiBdJn9N/BhzHlGKRTNTy7eqixZ+qyRrvcJJT8OtMq07gQxXNImrHSjilFx1LwhquYC4qYosa2XPXkbWL3r93e5Nb5aJjKpdeiQ2pwUAe87z6gs+PS6nVuzrwtv2CF2ANu+zuaL1mdMm4acnR8am8K7VzCO35Qhj7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9ouiTvg; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9ouiTvg"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39394e1e8f3so120674661fa.1
        for <git@vger.kernel.org>; Thu, 28 May 2026 14:03:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780002221; cv=none;
        d=google.com; s=arc-20240605;
        b=f37eXOstj9lk4JFvqsFF1CmJWlITibhbARjraFzZMIYSLv7KYftMXERqwhkSbUMzIV
         k5ybRVdSviWdyCbYGHx3ixD+uEbZ9cKGqYuKvf5pZgxgsxaVf+YpJM4KN5AOdbgnnsKI
         xwRmLynUyMaWL8bVsnyBiD6plaRXFpmOOKV19DikMFQofjOcH5YdqfH+dZ1I/ZbmTf+S
         gfrdWBDLLwZPhGBnuneE2FsT2qcManCSAk8oDd05A8+2P+k/0/t6T2srR5mXDASjj+Eu
         DMJbJNavb+5O0eiwrMcYfJxUgwa+2EMTAdOIBxT+v/jLRRjBEHmdM9h6jRManUuABuX+
         nNQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=vNYX7l6uAxZenmeMZkfWz1O00fDzptxv2nj+RTA312I=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=bmDf6HcgZawxQE218lqQUYOBfq3VGdwNiMvOVpGd/eaYVqlmX1dwRVqMnH9gkmFqjf
         qK1UovM4lUQpDtDKO6rspTE0mwoyKZLo8dc2rh8Bj5f/HqgbYAJXgpyRoYfFMUHoj+9X
         QkEJeKjmnx8WStTk+OAGYQQlhW6u8VHUDUP5bz+RFVvFL6D0qvmuonCPa9AFBfmbBpDV
         U5Qnuu99U6PYzhYTr4G0AANXvB+mYwysHtu7GBHTi9alQlcsbVVwupl5kpALsG97bplQ
         ByrblTVBHdW0ip+I0l7VQCTb+QcOwoocb0QmX74TN0utKiJQSwk4jG8va85Ryp04MAO0
         SHhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780002221; x=1780607021; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vNYX7l6uAxZenmeMZkfWz1O00fDzptxv2nj+RTA312I=;
        b=K9ouiTvgBhdVR0qtw4anG6xtu3uXLrsbu5Xtm1RERIWsoDR+3oiX1HU+uIBaC2Gnjx
         eiR6SKGMCjVANT74LJrYA8MTIW6X3fbg/NU2amGTR5MK3a7uzJ02vUw/7tLj9L/5FS9b
         LelDQFTB/rW4HHvzQ0P9maL2X7J0paVMuKIb0N8MSJcAcZFw4Dyeyip8N4hQRaTeBqoj
         MbZNSMtfUmqLeCjR4f1sSaqlt27GDVyxcSLdlyG6aCh4Ih42ITmoLgItJC9Kj2RXF0HR
         HlM4Jh+R1RRTCA76ae65Tr54ubfak2yq2GGJyjz/JY0+hqFo9Cx0qWvQ2O9y6HBQPrBP
         HTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780002221; x=1780607021;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vNYX7l6uAxZenmeMZkfWz1O00fDzptxv2nj+RTA312I=;
        b=A4jchuYiwL5cPorEgKu03exMd2BWBOY/FbeS3TY1aFB+HGwnryh/1lNhTddyvC4YlA
         P+/57EuimLQab8Kq8iEx4P+pDnwjWspdAnyYdXChIm9HtbBooQVckDkzP0+Wu58bs7BF
         v0poS4Hr8jrkwT4vwtsRBAMtuPpQ8wcd63vpX5kZWwk66c8UE74Ca2idMy8qtq7cPaj1
         u3nmmd1+4QDszhttZ+k1sLlML1CppI3ocZHgDqRmrJkR1n5FAVlvbTWgt9BP2FiYAoNk
         oK+g+GJzpO6VPCwvI8AObSu9k80GeNKbbEClYSZA7Lw/Cx8X6UG1ay3XZb1SulD9RaiL
         EJow==
X-Gm-Message-State: AOJu0Yw0f2mmKPP3XF51E7Rw4v2o8L54BBB1eaTaWenFDe8vbg0LpVYb
	80SUHv0kUSFy4KP91CGoecxJQsLOqygGVKlKYJI8gNidXAEwzd/UKcb/6RSJkzNZbg/Elvz2ums
	hFLtk1BWg+/273MTr/libC2G3rnhif0S/bNYojos=
X-Gm-Gg: Acq92OEgIaRCYuQqRiCHnUburPss/5ENZwZz3dYoRGdUUTaAqTC0hfV/IiR9kj1PdeB
	zm8OQ9KtiivcOYWyGRuORd3oNQ4yQZVmyZfVXZBfxysbz9uK5ZSUQ3+vvOEyVIrq97gQlmQNSXV
	OeRbvNQcwAa1it4qGddaAkHNp1PaxIf4K5BeTDtm1Y5K1+Ir/8CSn0cBM7EnwmkCpgPfXo02U0Z
	w12Rb4nH7rFsnNcv6u638IABWVQFmrPtLC2uD9dvVGl4ljZEI3E5kcCoJbLzQ92+qd6eDbI7aP6
	DR5g4u2y5b4scCLTQDhAIJPcuMVFibHSC+cxOIYdWMylmbzc9A==
X-Received: by 2002:a2e:bc81:0:b0:395:6c09:f490 with SMTP id
 38308e7fff4ca-396536972eemr72931fa.9.1780002220612; Thu, 28 May 2026 14:03:40
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Baptiste Jean-Louis <baptiste.geek98@gmail.com>
Date: Thu, 28 May 2026 23:03:29 +0200
X-Gm-Features: AVHnY4IO48E5dTG0gzxVDJTSLRSsp9lqGnKKVKEeuPdwiPVB54-xkob90_mOGmg
Message-ID: <CAOtV6-95tzd-iBW+DcUHBTXvQF0TU+-pimATw1aYyo7nhDEofA@mail.gmail.com>
Subject: [BUG] broken behaviour when running cd in a hook in a secondary worktree
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,
Thank you for your great work
here is a bug I encountered

What did you do before the bug happened? (Steps to reproduce your issue)
#!/bin/bash

mkdir topfolder
cd topfolder
mkdir main-worktree
cd main-worktree
git init
mkdir dir
touch file-a dir/file-b
git add .
git commit -m "Initial commit":

cat >.git/hooks/cd-bug << EOF
#!/bin/bash

echo -e "\n\nrunning cd-bug hook"
# Redirect output to stderr.
exec 1>&2

echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
git describe
echo pwd : $(pwd)
echo pwd_var : $PWD
echo git_prefix: $GIT_PREFIX
echo git_dir: $GIT_DIR
echo git_work_tree: $GIT_WORK_TREE
git status
echo "========================================================"
cd dir
echo pwd : $(pwd)
echo pwd_var : $PWD
echo git_prefix: $GIT_PREFIX
echo git_dir: $GIT_DIR
echo git_work_tree: $GIT_WORK_TREE
git status
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
echo -e "cd-bug hook done\n\n"

EOF
chmod u+x .git/hooks/cd-bug

# behave as expected
git hook run cd-bug

git branch branch_b
git worktree add ../second-worktree branch_b
cd ../second-worktree

# broken behaviour here
git hook run cd-bug

# end of script



What did you expect to happen? (Expected behavior)
On branch branch_b
nothing to commit, working tree clean


What happened instead? (Actual behavior)
On branch branch_b
Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        deleted:    dir/file-b
        deleted:    file-a

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        file-b


What's different between what you expected and what actually happened?
-> Running `git status` after `cd` in a pre-commit hook lists all
repo's tracked file as deleted.
   However when running the hook from the main-worktree, I have no issue.

   In my final use case, I'm doing something that goes like below
   cd subfolder
   `git stash --keep-index`
   `./update-generated-files` which updates some files in subfolder
and subfolder/*/
   `git stash pop`



[System Info]
git version:
git version 2.51.1.windows.1
cpu: x86_64
built from commit: 1454f0a9c4a3a22fb3fd7cc33f76f88cd65ced41
sizeof-long: 4
sizeof-size_t: 8
shell-path: D:/git-sdk-64-build-installers/usr/bin/sh
feature: fsmonitor--daemon
zlib: 1.3.1
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Windows 10.0 22631
compiler info: gnuc: 15.2
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/bash



[System Info 2]
git version:
git version 2.47.3
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
zlib: 1.3.1
uname: Linux 6.12.74+deb13+1-amd64 #1 SMP PREEMPT_DYNAMIC Debian
6.12.74-2 (2026-03-08) x86_64
compiler info: gnuc: 14.2
libc info: glibc: 2.41
$SHELL (typically, interactive shell): /bin/bash

[System Info 3]
Ubuntu 20.04LTS
git version : 2.25.1



[Enabled Hooks]
yes , see reproduction script

Best Regards,
Baptiste JEAN-LOUIS
