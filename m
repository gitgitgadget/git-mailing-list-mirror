Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0947E78C6E
	for <git@vger.kernel.org>; Wed, 22 May 2024 06:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716359252; cv=none; b=Grb+Q6Hbulr1YVTkew2I9bcGLy79Y+BsXGXRLIP4ayQ8Qbjsv8ah4zBLyQYwMJGa0r85ZTmgPlhN5imAEXVQXjSYC8GGQNaLDXegEHTcA91C9gtbavXFREUK2L/IpUsa+eaiR3cFLChT0gU/qDdp/MMj7kQ509rud4t2RSGH+Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716359252; c=relaxed/simple;
	bh=dEQBgJ3wt7Cc8ffPNSiIwQ03v326rdZzmAq6t6zddVA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=XWrBw9ZeQpbXtux7RReJvgitQmTWdMggJz3D+VxzT6n7BeXXqsLecFOoBoufY1OFn/kzRW296YRO1IW6uEGQZbxp3GnrxUyf8TPDHV+N9+9WzMCyP2LLKiM5VWRpJCknZCDZSmulCoHdymxp3OYJyTUMW5j3SH+CCIeYo4MKNg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qd5O0WEO; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qd5O0WEO"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ac9b225a91so1790560a91.2
        for <git@vger.kernel.org>; Tue, 21 May 2024 23:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716359250; x=1716964050; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zDBZZze7VB7OBzSyn66rUZTBObLJC0HQRJKwU5OWskk=;
        b=Qd5O0WEOt1OPkgCf66wiS5x5z+lrAAvwCjeZI/0rX7EyECDcIDp26cQ4XzI5s8xNyt
         kLeQaM69ik8sm4T16SUteQUSERMnHS96t2UK/ZWWwmX0lV5PcrUHkpgXe8iS9r6kfyZ4
         mDX5zZ7vMM698eXPrwGIE8gp8BwK56QC2gi0p+nk0vvFGWVZSCaMMzZZEx4o9brwxA3m
         gB4nD+W0Tw2KsaW/Bd5dbPikOoMjzL3gehlDa7SlitLAZZradW/gKDbta3882nVPfDFu
         o/vVzsrZ7K4YMlDtughOGU5Khas/Pmmd+1CsT05Bl+MgOcu5w2NpiL4eYRL+WY64PDHi
         vOIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716359250; x=1716964050;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zDBZZze7VB7OBzSyn66rUZTBObLJC0HQRJKwU5OWskk=;
        b=d0iZk5aFnGyj/2r3X2UExn3TvNKdVTu7ATNnppKHkiAz0Tli3A1Qcs3M6uKKruSXxh
         U0k5mGoUWJLcgSE57hmkfMIJ+XhYtHcP3aVmLPIHibYBJpQFWVKqogL1oCKekmKh/k6Z
         DaFfXl8vKMWkEDuiuSqaMj6aNdV+zFbUwTga7K1tJYT2dNd502eQj1zXEmwAy+g81qjI
         uDNwRqqtHkpXC+PNZaxKTuyzUV09UYIPhgCq9hYiqJySYSRxDqRETOrzvmBjN8FZqvuR
         21sG86IHJNXVbX51pWtFB8U5H7O/AQXTRZsJsNyum/sgqLK+A4oThms4seUo8961hJ0K
         wudQ==
X-Gm-Message-State: AOJu0YzIDY+xZABXvSNncTCRPE7gPNnRo6xmETzB+sivWtpY6dxfThrf
	gBiFt4sKo9Ldrtm2Xuv0FNiv4qSzvPLlWkEYOsPz3w7dCjpdy2SqwKOj8KwIYfwY8Fe+Zs7nKSz
	Gn7fZ3ov3NnoubiT4KrIdBFGg4KNnk/wH
X-Google-Smtp-Source: AGHT+IEzJL5xVFd1I9KbKLLh6Kd/i69KcpCEmnJE0QfXjliSIyyov3cIJrK0ElA1WSG69derwq/T3cnfbaUUdfuX/b8=
X-Received: by 2002:a17:90b:494:b0:2bd:9032:5934 with SMTP id
 98e67ed59e1d1-2bd9f5d276bmr1120755a91.49.1716359250180; Tue, 21 May 2024
 23:27:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Zopolis4 <creatorsmithmdt@gmail.com>
Date: Wed, 22 May 2024 16:27:19 +1000
Message-ID: <CAEYL+X_R_0wfaP3UR2eDaBkaGXDAi_wSo=t9xK2DgiCm3+T6HQ@mail.gmail.com>
Subject: Unable to shallow fetch repository when using a object database
 populated by shallow fetches.
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

What did you do before the bug happened? (Steps to reproduce your issue)
Create cache directory:
cd /tmp
mkdir cache
cd cache
git init --bare
git config --local receive.shallowUpdate true
export GIT_ALTERNATE_OBJECT_DIRECTORIES=/tmp/cache/objects

Populate cache with shallow repository:
cd /tmp
mkdir repo1
cd repo1
git init
git fetch --depth 1 https://github.com/crystal-lang/crystal
git checkout FETCH_HEAD
git push /tmp/cache HEAD:refs/heads/crystal

Attempt to shallow fetch other unrelated repository:
cd /tmp
mkdir broken
cd broken
git init
git fetch --depth 1 https://github.com/mint-lang/mint

What did you expect to happen? (Expected behavior)
The mint repository to successfully fetch.

What happened instead? (Actual behavior)

Initialized empty Git repository in /tmp/broken/.git/
error: Could not read 2ac4b3fb4325328d347344ae738bb38d4675b82e
remote: Enumerating objects: 1759, done.
remote: Counting objects: 100% (1759/1759), done.
remote: Compressing objects: 100% (1325/1325), done.
remote: Total 1759 (delta 645), reused 833 (delta 416), pack-reused 0
Receiving objects: 100% (1759/1759), 678.36 KiB | 6.22 MiB/s, done.
Resolving deltas: 100% (645/645), done.
error: Could not read 2ac4b3fb4325328d347344ae738bb38d4675b82e
fatal: Failed to traverse parents of commit
b563cbacb3ab1af88f4ba48c1877eb3823f3a69d
error: remote did not send all necessary objects

What's different between what you expected and what actually happened?

Fetching the mint repository failed rather than succeeding.

Anything else you want to add:

If the final command is replaced with 'git fetch
https://github.com/mint-lang/mint', errors are thrown but the fetch
completes successfully.
Initialized empty Git repository in /tmp/broken/.git/
error: Could not read 2ac4b3fb4325328d347344ae738bb38d4675b82e
remote: Enumerating objects: 19928, done.
remote: Counting objects: 100% (5185/5185), done.
remote: Compressing objects: 100% (1519/1519), done.
remote: Total 19928 (delta 4223), reused 3674 (delta 3666), pack-reused 14743
Receiving objects: 100% (19928/19928), 4.17 MiB | 4.54 MiB/s, done.
Resolving deltas: 100% (14600/14600), done.
From https://github.com/mint-lang/mint
 * branch              HEAD       -> FETCH_HEAD

Also, when the command to fetch the crystal repository is replaced
with 'git fetch https://github.com/crystal-lang/crystal', everything
works without issue.

Presumably, this means the issue lies in shallow fetching when using a
shallow object database, as making either of these non-shallow means
the fetch completes successfully. (Admittedly, errors are still thrown
if a non-shallow fetch is performed using a shallow object database)

I was also able to reproduce the issue on git 2.45.1, but using the
satmandu/crewbuild:amd64 docker container as I do not have access to
git 2.45.1 on debian sid.


[System Info]
git version:
git version 2.43.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.8.9-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.8.9-1
(2024-05-15) x86_64
compiler info: gnuc: 13.2
libc info: glibc: 2.38
$SHELL (typically, interactive shell): /usr/bin/fish


[Enabled Hooks]
