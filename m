Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971CE57323
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 21:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722893868; cv=none; b=I18ootyFUa1cQ9sdl87lkQAwJ1yCV9BkDmkg63+4YXi8KaA+PB1xs7Iuv2SRBMYjGzWk1SKk5+o1H+duIZ1iQJuEc+VHz7r096fqHHm+9ctLRF1PEFnxXpJWXLjxG80BN4rmEOV/Sq1rYLjVADv34r1d/5np/Vs9QAM279Pdts0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722893868; c=relaxed/simple;
	bh=Icp/W2fQB+qtTQ/EC7Nk119RzGPuVV3NNdOoAk6FwTc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Cft3v9C9k0nLJBfKtUxXKx1vubPe3/WFh/H8lOyzcb100mtd9BqctKAsC1Xvpr2jMGd1kOG+0O89d7gLiCA86RPyKRt9jANOiTAT+qNh6gZvXa406jo3ezLTFf+lPkKiYpUFCv3ZdLehHnFyUgywu4t04aokigDFCgwId9UOpgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6yvc1u0; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6yvc1u0"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7a81bd549eso3476466b.3
        for <git@vger.kernel.org>; Mon, 05 Aug 2024 14:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722893865; x=1723498665; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Icp/W2fQB+qtTQ/EC7Nk119RzGPuVV3NNdOoAk6FwTc=;
        b=P6yvc1u03fTirNf5OilxEmE5DF9hXTiQ7mTn1Yd9/YOL3mhlkBcD0XWoWZZieoBJF5
         igLq2lnvqZpbSFeEG5X0GqnOikcWy4d8pr1sqRb8f27wq2zao8DAcYGKNHJbTkwuINvE
         XrJOnZ27XqHuL31+rqDjovbtt0wuXGyk+cBdRRuigxjOAFa4q1jgbjrJuumYwU0Hcq2L
         IiDPAwrXkT+h16+Q40K9bl0sa9rQb3bEE+wi6Ij+tCyp0eAY22+fqjy1x3ek3ALJ66Bj
         wFY026/9+qflF1HYoj/eLqEJzvnrYox7ucxcXJ+GMPUkB6dyPMLLXzYxoVt6Nz5+tcqW
         reEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722893865; x=1723498665;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Icp/W2fQB+qtTQ/EC7Nk119RzGPuVV3NNdOoAk6FwTc=;
        b=tDZfbmhTq94J51RrnQBXDt2gZvnsUcRYnKDOYNKgEf68KSXjhGt9zDptCp7w5ClpHC
         +8tEb8DQJRJMHVXBGPSyE0B3M+D2o5G7z8fgunLN10bytu1qtNZXfN113tcjBCTakM4I
         NKMJJaw8WfMj2EWSiXIvNkvWeDy2bj2aAa/zgrjoMA1TiVWbYlyE7Odzid+4BoULVULH
         6y53rnJOvLtujGkYpBkWgF0YGoLTshvDlUSMPk3o0DF90mKbtv24Jx8n7XqfV0/nrLWL
         nthWVMTNNW/c9YjV1hhaoJVtK5yllabIDt/xUfQQfGCmG8G1o3YOxdMba6V0g4DOma1e
         VZZg==
X-Gm-Message-State: AOJu0YzykA99xcp/3tnVBA96h2jIZ9Nc72gBGolizYacSgY6+GfNCFJf
	Wam+CsRHq+4fafbg2O7MRIow6DRsHQ2dF8qI/MJlQO9PuMEOXZRa61ZK0qLRfWQzeaz+oGyXumr
	g3jRgnVXkooEY8Z1QdnLP0ZvyKaevT9oI
X-Google-Smtp-Source: AGHT+IH8ebzl1qst79CkxqRz8eFkFU5CTzWulSNCDqdIXH+c/HiuMRUsmRHmzIDzIYCnogwCnDuAmTyiUt5gJW5A700=
X-Received: by 2002:a17:907:7fab:b0:a7a:a801:12b3 with SMTP id
 a640c23a62f3a-a7dc5000653mr1063422666b.40.1722893864620; Mon, 05 Aug 2024
 14:37:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Han Jiang <jhcarl0814@gmail.com>
Date: Tue, 6 Aug 2024 09:37:33 +1200
Message-ID: <CANrWfmR2sB8abN3tjuavu-sDwuENMh3DPdFKS9fXan_1kYURPA@mail.gmail.com>
Subject: git clone --reference=<repository> (without --dissociate), forgets to
 copy/get_pack_of objects from <repository> when "--no-local"/"file://" is present
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

(repo7 and repo8 should behave similar to repo5 and repo6, i.e. setup
".git/objects/info/alternates" && copy/get_pack_of objects;)
(repo7 and repo8 shouldn't: forget to copy/get_pack_of objects.)
(The problem only surfaces after "./client/mirror.git/" is removed:
repo7 and repo8 should have the original objects (so git log shouldn't
give error) but they don't have.)

cd '/'; cd '/'; rm --force --recursive -- './test_git'; mkdir "$_"; cd "$_";
mkdir --parents -- './server' './client';

git -C './server' init --bare './repo.git'
git --git-dir='./server/repo.git' --work-tree='.' commit --allow-empty
-m "$((++number))"
find './server/repo.git/objects' -printf '%p %n\n'

git -C './client' clone --shared '../server/repo.git' './repo1'
find './server/repo.git/objects' -printf '%p %n\n'

git -C './client' clone --shared --local '../server/repo.git' './repo2'
find './server/repo.git/objects' -printf '%p %n\n'

git -C './client' clone --shared --no-local '../server/repo.git' './repo3'
find './server/repo.git/objects' -printf '%p %n\n'

git -C './client' clone --shared 'file://'"$(realpath
'./server/repo.git')" './repo4'
find './server/repo.git/objects' -printf '%p %n\n'

cp --recursive --no-target-directory -- './server/repo.git'
'./client/mirror.git/'

git -C './client' clone --reference='./mirror.git'
'../server/repo.git' './repo5'
find './server/repo.git/objects' -printf '%p %n\n'

git -C './client' clone --reference='./mirror.git' --local
'../server/repo.git' './repo6'
find './server/repo.git/objects' -printf '%p %n\n'

git -C './client' clone --reference='./mirror.git' --no-local
'../server/repo.git' './repo7'
find './server/repo.git/objects' -printf '%p %n\n'

git -C './client' clone --reference='./mirror.git'
'file://'"$(realpath './server/repo.git')" './repo8'
find './server/repo.git/objects' -printf '%p %n\n'

git -C './client' clone --reference='./mirror.git' --dissociate
'../server/repo.git' './repo9'
find './server/repo.git/objects' -printf '%p %n\n'

git -C './client' clone --reference='./mirror.git' --dissociate
--local '../server/repo.git' './repo10'
find './server/repo.git/objects' -printf '%p %n\n'

git -C './client' clone --reference='./mirror.git' --dissociate
--no-local '../server/repo.git' './repo11'
find './server/repo.git/objects' -printf '%p %n\n'

git -C './client' clone --reference='./mirror.git' --dissociate
'file://'"$(realpath './server/repo.git')" './repo12'
find './server/repo.git/objects' -printf '%p %n\n'

tree './client/repo1/.git/objects'
tree './client/repo2/.git/objects'
tree './client/repo3/.git/objects'
tree './client/repo4/.git/objects'
tree './client/repo5/.git/objects'
tree './client/repo6/.git/objects'
tree './client/repo7/.git/objects'
tree './client/repo8/.git/objects'
tree './client/repo9/.git/objects'
tree './client/repo10/.git/objects'
tree './client/repo11/.git/objects'
tree './client/repo12/.git/objects'

git -C './client/repo1' log
git -C './client/repo2' log
git -C './client/repo3' log
git -C './client/repo4' log
git -C './client/repo5' log
git -C './client/repo6' log
git -C './client/repo7' log
git -C './client/repo8' log
git -C './client/repo9' log
git -C './client/repo10' log
git -C './client/repo11' log
git -C './client/repo12' log

git -C './server/repo.git' cat-file --batch-check --batch-all-objects
git --git-dir='./server/repo.git' --work-tree='.' commit --amend
--allow-empty -m "$((++number))"
git -C './server/repo.git' cat-file --batch-check --batch-all-objects
git -C './server/repo.git' -c 'gc.pruneExpire=now' -c
'gc.reflogExpireUnreachable=now' gc
git -C './server/repo.git' cat-file --batch-check --batch-all-objects
git -C './client/repo1' log
git -C './client/repo2' log
git -C './client/repo3' log
git -C './client/repo4' log
git -C './client/repo5' log
git -C './client/repo6' log
git -C './client/repo7' log
git -C './client/repo8' log
git -C './client/repo9' log
git -C './client/repo10' log
git -C './client/repo11' log
git -C './client/repo12' log

rm --force --recursive -- './client/mirror.git/'
cp --recursive --no-target-directory -- './server/repo.git'
'./client/mirror.git/'
git -C './client/repo1' log
git -C './client/repo2' log
git -C './client/repo3' log
git -C './client/repo4' log
git -C './client/repo5' log
git -C './client/repo6' log
git -C './client/repo7' log
git -C './client/repo8' log
git -C './client/repo9' log
git -C './client/repo10' log
git -C './client/repo11' log
git -C './client/repo12' log

rm --force --recursive -- './client/mirror.git/'
git -C './client/repo1' log
git -C './client/repo2' log
git -C './client/repo3' log
git -C './client/repo4' log
git -C './client/repo5' log
git -C './client/repo6' log
git -C './client/repo7' log
git -C './client/repo8' log
git -C './client/repo9' log
git -C './client/repo10' log
git -C './client/repo11' log
git -C './client/repo12' log


What did you expect to happen? (Expected behavior)

repo7 and repo8 should behave similar to repo5 and repo6, i.e. setup
".git/objects/info/alternates" && copy/get_pack_of objects;
repo7 and repo8 shouldn't: forget to copy/get_pack_of objects.
The problem only surfaces after "./client/mirror.git/" is removed:
repo7 and repo8 should have the original objects (so git log shouldn't
give error) but they don't have.
BTW, --shared (setup ".git/objects/info/alternates") / --local
(hard_link) / --no-hardlinks (copy) / --no-local (use the regular Git
transport, gives a pack) should be mutually exclusive.

What happened instead? (Actual behavior)

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
