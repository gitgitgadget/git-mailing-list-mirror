Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2D520E6
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 04:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725511109; cv=none; b=TXz3orYgT/xaGa5nvBFTKgWydOtnFVcJ6tu7Ymx+Cm8EEuxR3dxTOs9jtf/3qbAGBQ5NRlrP1GGG13n2uBdhuSSiYivh6r2WUeiCM46k6QP3eelSiFmWCCN+Bi/tdxZ6Dq9vJlOOnCXzA6TFt6VpQmJopnUM1ISzGNo3zyLPdHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725511109; c=relaxed/simple;
	bh=ND8Wbshk7hjxECQr7VQl0mN6upMkUVW62fJE5l1jWBo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=FcH42OBUsZlzXdkuA0D0uUUvwfWMhm+BodHfaEkjK1QMwvnvLexOu3DVyB4FYoIMpgP27VNBz67nenGh973CpVc/iCYD/NuRp+Tc0NbsvmpTIWRzyNMN6+xq17DXzBJrr6RUhvHBfnmPrc6WL6K/BYIdQQlUpGvRGaiqGcvTOF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOkxocVP; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOkxocVP"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a869f6ce2b9so55466066b.2
        for <git@vger.kernel.org>; Wed, 04 Sep 2024 21:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725511105; x=1726115905; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ND8Wbshk7hjxECQr7VQl0mN6upMkUVW62fJE5l1jWBo=;
        b=XOkxocVPlFJ0EUIXk0jIqnmfBF+e4ePbaBLNUQjmNohzRArJI6jtA+5/Lf1AJ1hP9O
         1O8w2nOnilQGXMhsdugUAXCJrMRAceS28ZP/FWp4Ml17n6fPD3Yz4nllTW0BqsbviJgV
         wqBlWyGDZEuLJdnwNwG8WSxLDoOuPde57CewLkMLyyqAEFbmkU5LB5GG3GiS5p71padE
         dHZ1VgpYfH4qPrv4vfppWMrcelNnf8RDr2FR0CjScNvyVqXmkCTaQyv0/yD6lBvVXjX8
         SR5ahYhe/v4dBbhbXj92R9eYCtkU78jB6Zj9ARG76XTZRp8NoPd0bpvyFhAzDKVlLtqM
         Urjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725511105; x=1726115905;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ND8Wbshk7hjxECQr7VQl0mN6upMkUVW62fJE5l1jWBo=;
        b=d3exNoA3m6nV5TNCabjzobOLGfVfl62+2v0MRSzj62vY0SvxXfNOENi36Ues5C5aoN
         R+3nIHwD21RicERP7y1weO6IPqlRu6fHtuZB1GzJB6PVVG84HqhcaKOIVCl9d1bj3QhT
         TIJ8OJDsekuHRozCwUkhi5ReuH0yGGwUK1NBKNpEmT9q4veDaxEfEbwyE3p8zGtt0R3m
         nUhx1eQAhJIgKTP5gFfTlKRHOif5lwGZDKSw+WSI3/jrPETBCw6uH+tv7qUa+WABkfxo
         yeY5wqzwBWHUEgci9gDz3ailVxLZP61nhjdN9BN/di5GYbDKyhQGu9za4mGfu+IRfy6B
         vn7Q==
X-Gm-Message-State: AOJu0Yym1APtG/uRd6J/hOEdVgtophRPjEahWnyN5r+ey3+Qz/NMMY+P
	CnGVgpVgKXN5YpAuaP3D9jOs5yoDUL3bSoWB4FickqyCuVhPejvihX1UWylLluXtBz/u0YX6bSf
	nOf1QuaJOSGbqeOODlDsSGEXAJ69WBMhC
X-Google-Smtp-Source: AGHT+IGehFRWu4bRAksks1qEzC5dQ8LJasUzwIGZ879R7qyiO3GfdL4n3+MuAR4nor4uRcvCUAF2E7cNgyshq3fcao4=
X-Received: by 2002:a17:907:7e88:b0:a86:af28:fc2b with SMTP id
 a640c23a62f3a-a8a32fa103emr559232866b.54.1725511105326; Wed, 04 Sep 2024
 21:38:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Han Jiang <jhcarl0814@gmail.com>
Date: Thu, 5 Sep 2024 16:38:15 +1200
Message-ID: <CANrWfmSxmGFKG4e8yumhgyRWmDikZA39JQVLvK8Q8CqMCpPUvw@mail.gmail.com>
Subject: =?UTF-8?Q?=60git_fetch_=3Cremote=3E_=3Crefspec=3E=E2=80=A6=60_=3Crefspec_=28without_?=
	=?UTF-8?Q?dst=29=3Es_are_mapped_by_other_=3Crefspec_=28with_dst=29=3E_resulting_in?=
	=?UTF-8?Q?_extra_remote_tracking_branches?=
To: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

cd '/'; cd '/'; rm --force --recursive -- './test_git2'; mkdir "$_"; cd "$_";
mkdir --parents -- './server' './client';

git -C './server' init --bare './repo.git'

git -C './client' init './repo'
git -C './client/repo' remote add server 'file://'"$(realpath
'./server/repo.git')"
git -C './client/repo' config set --local 'remote.server.fetch'
'+refs/heads/*:refs/remotes/server/*2'
git -C './client/repo' remote --verbose
git -C './client/repo' config list --local --show-scope --show-origin

git --git-dir='./server/repo.git' --work-tree='.' commit --allow-empty
-m "$((++number))"; git -C './server/repo.git' branch --force branch1;
git -C './server/repo.git' branch --force branch2
git -C './client/repo' fetch server 'branch1'
git -C './client/repo' log --all

git --git-dir='./server/repo.git' --work-tree='.' commit --allow-empty
-m "$((++number))"; git -C './server/repo.git' branch --force branch1;
git -C './server/repo.git' branch --force branch2
git -C './client/repo' fetch server
'+refs/heads/branch*:refs/remotes/server/branch*3'
'+refs/heads/branch*:refs/remotes/server/branch*4'
git -C './client/repo' log --all

git --git-dir='./server/repo.git' --work-tree='.' commit --allow-empty
-m "$((++number))"; git -C './server/repo.git' branch --force branch1;
git -C './server/repo.git' branch --force branch2
git -C './client/repo' fetch server
'+refs/heads/branch*:refs/remotes/server/branch*3'
'+refs/heads/branch*:refs/remotes/server/branch*4' 'branch1'
git -C './client/repo' log --all

git --git-dir='./server/repo.git' --work-tree='.' commit --allow-empty
-m "$((++number))"; git -C './server/repo.git' branch --force branch1;
git -C './server/repo.git' branch --force branch2
git -C './client/repo' fetch server
--refmap='+refs/heads/*:refs/remotes/server/*5'
--refmap='+refs/heads/*:refs/remotes/server/*6' 'branch1'
git -C './client/repo' log --all

git --git-dir='./server/repo.git' --work-tree='.' commit --allow-empty
-m "$((++number))"; git -C './server/repo.git' branch --force branch1;
git -C './server/repo.git' branch --force branch2
git -C './client/repo' fetch server
--refmap='+refs/heads/*:refs/remotes/server/*5'
--refmap='+refs/heads/*:refs/remotes/server/*6'
'+refs/heads/branch*:refs/remotes/server/branch*7'
git -C './client/repo' log --all

git --git-dir='./server/repo.git' --work-tree='.' commit --allow-empty
-m "$((++number))"; git -C './server/repo.git' branch --force branch1;
git -C './server/repo.git' branch --force branch2
git -C './client/repo' fetch server
--refmap='+refs/heads/*:refs/remotes/server/*5'
--refmap='+refs/heads/*:refs/remotes/server/*6'
'+refs/heads/branch*:refs/remotes/server/branch*7'
'+refs/heads/branch*:refs/remotes/server/branch*8' 'branch1'
git -C './client/repo' log --all

What did you expect to happen? (Expected behavior)

`git fetch server '+refs/heads/branch*:refs/remotes/server/branch*3'
'+refs/heads/branch*:refs/remotes/server/branch*4' 'branch1'` results
in:
server/branch13
server/branch23
server/branch14
server/branch24
server/branch12

`git fetch server --refmap='+refs/heads/*:refs/remotes/server/*5'
--refmap='+refs/heads/*:refs/remotes/server/*6'
'+refs/heads/branch*:refs/remotes/server/branch*7'
'+refs/heads/branch*:refs/remotes/server/branch*8' 'branch1'` results
in:
server/branch17
server/branch27
server/branch18
server/branch28
server/branch15
server/branch16
or:
server/branch17
server/branch27
server/branch18
server/branch28
server/branch12
server/branch15
server/branch16

What happened instead? (Actual behavior)

`git fetch server '+refs/heads/branch*:refs/remotes/server/branch*3'
'+refs/heads/branch*:refs/remotes/server/branch*4' 'branch1'` results
in:
server/branch13
server/branch23
server/branch14
server/branch24
server/branch12
server/branch22

`git fetch server --refmap='+refs/heads/*:refs/remotes/server/*5'
--refmap='+refs/heads/*:refs/remotes/server/*6'
'+refs/heads/branch*:refs/remotes/server/branch*7'
'+refs/heads/branch*:refs/remotes/server/branch*8' 'branch1'` results
in:
server/branch17
server/branch27
server/branch18
server/branch28
server/branch15
server/branch25
server/branch16
server/branch26

What's different between what you expected and what actually happened?

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.46.0.windows.1
cpu: x86_64
built from commit: 2e6a859ffc0471f60f79c1256f766042b0d5d17d
sizeof-long: 4
sizeof-size_t: 8
shell-path: D:/git-sdk-64-build-installers/usr/bin/sh
feature: fsmonitor--daemon
libcurl: 8.9.0
OpenSSL: OpenSSL 3.2.2 4 Jun 2024
zlib: 1.3.1
uname: Windows 10.0 22631
compiler info: gnuc: 14.1
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.exe


[Enabled Hooks]
not run from a git repository - no hooks to show
