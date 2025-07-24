Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D82B25A623
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 09:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753351198; cv=none; b=cwET5XnLsLxYPzo0K39H4ZOcW4d0RmekrUfGDx0hiIMWr3wH5US9JnoPQ+zl4AaxuxahMqJj9b1cYnZoXcepmtMVCXBMvhb1Oi29Z3MfhxxA2FYWqfpiztS6ejw1yxZvNev9sbWEgUuUN3xgiKepah1rRO64ZV/CMlaUyn3kCk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753351198; c=relaxed/simple;
	bh=1Hg6CZY34cr39rNVRmnx4HNeARWMchtF+OMZ1s3Aiik=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=BWcxGHxX3RowM+CSAAfU5wbuNS5Ycf+GrRYSpshoSuz51qsH8/4yRMR3DTwVg8hnGGm19lObxTdoz2J1EmIUfyNL2FyXZw8XRQcQ9BoNDMK6bpB+aLHIQ2sT39ryWTkld34rvTuAkXbUa+gPuYaAAG6KFrdXAaMEoVmetiqUevU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKstAQ5w; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKstAQ5w"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e75668006b9so719997276.3
        for <git@vger.kernel.org>; Thu, 24 Jul 2025 02:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753351196; x=1753955996; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1Hg6CZY34cr39rNVRmnx4HNeARWMchtF+OMZ1s3Aiik=;
        b=MKstAQ5wfDEfKRc/8qqEZrFc5QS5daSlENx+/TtOh+CFdjoAzybRu5NIuM/FAcw/mB
         81vfV1aR0Pa4SYTk6H8/5yrOjWcixYK58mpG8GVNDv94oSwdmpgF0qRKWzbN80BDSUPq
         WQzuN3Qh50evHSc+IjNCFvI3YEfgvgDBoqkg8TzViFh5FAqTbJZMiYcUFyk1kmJrloha
         iVd2Ag43FDWK+0KSvn6ipMAh/xYxG+4bKU00SKWaF1d13o0joh4k+LOw6naGHfieBRO5
         agO9xtpSlzi+N9QSwN9QmxZPXrI6RY+gl/4tPhXzwWrdIu6cjN+26AoZ7VG8v2pURbJI
         9Mpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753351196; x=1753955996;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Hg6CZY34cr39rNVRmnx4HNeARWMchtF+OMZ1s3Aiik=;
        b=qGhJNrbEVQ2Yt98XXNUUEfh4cf59RaMP5uxY6PZ77Wl8KACZzE4NSQ9DUhT8g4Tftk
         CuxaKnldGfVX/SZNbZ3zoCLMi5oohEMzkqhtpWNodHmbEXcLFfo3PSYxnsTVTs4jrs7J
         faJBpceHG5vsNdgG7AMb1D/pKfY6a6znUC7ONOBaTU3etFV+7WWewqJxo2BdhLywoJJC
         mZnNFknZ4NyflnszzTwWR4ul3jDPW3OPUzdKRxKbxUutXWWl6KvP2KK4XTh0y01fDFNS
         RAjtXyRcmZETJBaX5XQTaggfsQcRrmLypByMN7lseSz60kwY17o6RrH9FSPVrCT68N2o
         jj7A==
X-Gm-Message-State: AOJu0YzjUN40jDNH+M0OKu1RZo75IwcjMSCDPXsSAMQ6HX88ahq0KnPv
	1cOUxqsk4Y636uIuEck/dmjQI8ylEj2xnh4/W0bHp3uBd6IHsj3sBdHbKRU8Eah6DjS2fMJuiQQ
	vz5Vac0oxNrc8GWsswQSAEwg1/c61mfbVRZS87Ts=
X-Gm-Gg: ASbGnctgd/0zAi13KO2VPhYEiq5brnbl8a7arEKc/AlD3ih5vA9oYQFtcYAybCwYQGX
	sfulU9NwzHasihwTy1T64V37/RdFQQe+51mj3AHaxZIQ2i5hwoPmljPBqHgROoLHLRLLJuUdke0
	vkPscKMrI4qbt9TwQ4ZHPebtCrz3J7Fy0voMeM+Uxl2d5zTYPI6pp5lgrSDMfPp1WHSFN5ZYUaL
	fJ5bxHMZuAeyDdXm/OkSCD2BDXwQTRnWNGExTFe
X-Google-Smtp-Source: AGHT+IEc10B3ePB+4YLC4vq4W5UemLQZq4228lndKqtyjP8oqiZPCuOjs+1dqlWYoE3yHirUbJnq8Qf3kWegkC0f//o=
X-Received: by 2002:a05:6902:2006:b0:e8d:9a0e:967a with SMTP id
 3f1490d57ef6-e8dc5a17c03mr8087816276.24.1753351196008; Thu, 24 Jul 2025
 02:59:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Han Jiang <jhcarl0814@gmail.com>
Date: Thu, 24 Jul 2025 21:59:45 +1200
X-Gm-Features: Ac12FXwOzD_V5Tva5FqzTEJyIKq_Q1vQnDQWpdB7sHCB_LYNrzzv7iV9BXfyaIM
Message-ID: <CANrWfmQWa=RJnm7d3C7ogRX6Tth2eeuGwvwrNmzS2gr+eP0OpA@mail.gmail.com>
Subject: `git remote rename` does not work when `refs/remotes/server/HEAD` is
 unborn (when right after `git remote add -m`)
To: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

What did you do before the bug happened? (Steps to reproduce your issue)

mkdir --parents -- './server' './client';
git -C './server' init --bare './repo.git'
branch_default_name="$(git -C './server/repo.git' branch
--show-current)"; echo "$branch_default_name"
git --git-dir='./server/repo.git' --work-tree='.' commit
--message="$((++number))" --allow-empty
git -C './client' init './repo'
cd './client/repo'
git remote add -m "$branch_default_name" server 'file://'"$(realpath
'../../server/repo.git')"
git remote --verbose
git config list --local --show-scope --show-origin
git symbolic-ref 'refs/remotes/server/HEAD'
git remote rename server server2
git config list --local --show-scope --show-origin
git symbolic-ref 'refs/remotes/server2/HEAD'
git symbolic-ref 'refs/remotes/server/HEAD'

What did you expect to happen? (Expected behavior)

`git symbolic-ref 'refs/remotes/server/HEAD'` outputs
"refs/remotes/server/master";
`git symbolic-ref 'refs/remotes/server2/HEAD'` outputs
"refs/remotes/server2/master".

What happened instead? (Actual behavior)

`git symbolic-ref 'refs/remotes/server/HEAD'` outputs
"refs/remotes/server/master";
`git symbolic-ref 'refs/remotes/server2/HEAD'` outputs "fatal: ref
refs/remotes/server2/HEAD is not a symbolic ref".
`git symbolic-ref 'refs/remotes/server/HEAD'` outputs
"refs/remotes/server/master".

What's different between what you expected and what actually happened?

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.50.1.windows.1
cpu: x86_64
built from commit: 4d32d83913170b86f9753fca10e75cdb2223d1cc
sizeof-long: 4
sizeof-size_t: 8
shell-path: D:/git-sdk-64/usr/bin/sh
feature: fsmonitor--daemon
libcurl: 8.14.1
OpenSSL: OpenSSL 3.2.4 11 Feb 2025
zlib: 1.3.1
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
uname: Windows 10.0 26100
compiler info: gnuc: 15.1
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.exe


[Enabled Hooks]
not run from a git repository - no hooks to show
