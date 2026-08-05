Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E313F6600
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 09:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785920787; cv=pass; b=ZFuZEg/XfVjO180fnLZXYAwUU270J9pnkzOoKb7XkRyCOkXZcF1pq/NQeNjNJRcDwfoEJoHBSvOKtoIRrGXDKdF5eTqodYgh1bEhE304MsmStWFEo9fPq07LG2jvk77XPcFFXn0WppWuRmmZjgMDMsH0PnqjKm21MhKvnkSWgWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785920787; c=relaxed/simple;
	bh=k3HOr9YOide4pHL6q+kXXpOk98Qr8uazTCz/dXRD+zM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=iqUUpPBADx8rFqeeOspGPOwlrc8x9+Ss3I8S58yQH0B1dKPNY8htUTiNhXwrCUViNKnnFURXT1MlBwjQegY7DFhkpwXylE2cpQZLxP5RhCcgazfXrsjP2j5HqErBC+Rj4V5iRK+FweYRIzotqmVoxH0hKSMPN9egxywaJPSWxQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1zV7dDh; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1zV7dDh"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a097f5ab95so1041288a12.2
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 02:06:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785920777; cv=none;
        d=google.com; s=arc-20260327;
        b=QLsJXcPkp+u0bU7OdWf1Wd98vHFSgUbYy9wQ8w/UwwbKQTvfHcKJk1lEcEAoyrNlBz
         EXqR/f2KDkun/WzLqJyR/sFv/zm7B1lu1R2MBAQ9zJDA11g+dac9iajJaPzZjqLSSJc/
         JfXRPBgiHDp7UnWfp8bO5C/0im3o70NK6AJtXnAhxdaJ5YBGOQXtMdxk/SI3q9QHBHPT
         wPAcxreTsV5ErZIqY0l3HiFE5XY2yqfzYHeFPE710+10CPFxMVKL9b/zMVxwiMPrF2G5
         sr+4VnfUpPA5ghMhOgr7mdy7oIm8Xe2eKgZjUIwqr3WBtkAMYLZWIqubfE5y7TVUEO8z
         jRpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=k3HOr9YOide4pHL6q+kXXpOk98Qr8uazTCz/dXRD+zM=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=dvaVHCVEWAcyO8Cfe3JgrJw5lpR5TtKcGLuZxnlb1fD94dFqu4AKl+EgOedyL8zsOm
         c0PRYcz23sZwvmE+MA5uZ47iFununnstCwnu6BIiy9Z9jBlY+LVUqjN4njJrfo7tLf5y
         hgW4SCtNsIvmgNhiqZXVWqsQ5oZAe6tEyjTv1ItF2Vw4e3mp90f0f+5ThjGEuBHcexW0
         kCJ3GGr0aIbvd0xTENNqVSETHvs3KdIukB2X5CboNrSgOwQtJcfLzg93wyTQOZNgRXpR
         D19cHUT6nZV9KuoL6TEQ40tc8ErgdDUJYarTSnojg0NLj2oBpqHzqlB2Xt9jnnJ+qxtF
         Lf2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785920777; x=1786525577; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=k3HOr9YOide4pHL6q+kXXpOk98Qr8uazTCz/dXRD+zM=;
        b=J1zV7dDhM/GT8PK3/8AH5oEArLF7vDh1A+FAJU/kM7JpjyUxNP5Yzzar3e/VRrE7NG
         hg5dSNSFMtqLjECpHYuo3mXJDijdzMfYA8YfBnTsh8TVcmtRwv87rPfDPTfNHCVRRj2H
         AIwTs8ybfxsxbikMUEZpGAMJwkwqqRVJIh/JEw0Gt+if30GtB8p3mbLBi2NenPpXCPdC
         RJXSVLlVCph2JwkX/sF5LpWwoNl3OMvc8y8NX5ke0HeZp/PEjCWJrWgdPbWNfwyLfjoI
         yec3KTp3CO0l0Gs68UOZVzzdfgO+TIjD0jzJKBmYvI7luwuhMZe5ReR26UQP9BiQYzT2
         /Jhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785920777; x=1786525577;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k3HOr9YOide4pHL6q+kXXpOk98Qr8uazTCz/dXRD+zM=;
        b=gx1xn730orXZTYxMKZXddM/H8BBU4X3hXh9rT0bkOCix5gsk0ip8lozvw103K5zK0S
         ZPGfUXrYh9ZnVqIKlaMRauJeV9KNN51GNHJrEaxvOISaweFgZQLMmWsEf6Q6Ysz+51fC
         RMir0kbovNn7zbjZT3jR4xHs/ax+J5z0a+xTfWnr6kQD6TUzL67K7NsdynfxKLm+LnWg
         yYmzX6VwtnM/0dvWF7bcChQSyShIt62XSEQPoBaF/1cIn/duiQ9m0V1XSsenKUqHeOmc
         TmSVO8kCieh4UXqSFZKimWrCzRf/6SBwxg0LHmxaxTFCfE2B5a62tVAHnCYc+BahjZqZ
         JZsA==
X-Gm-Message-State: AOJu0YyBTEZqpmXo+D0wew12FB3XJFZMqkWCUpX4wAtPoHgR9HwLZGaV
	4ap0i5TQzQp9UcEUNafwSY4j9lNlROgZU6mtvwRy4BpfSkMSyXnIQuJcDScz1LsJHczTeb+8MjH
	y3enJndEJMbRAEhyPBObnOMHWQ+95ANfTJ4utTKo=
X-Gm-Gg: AR+sD12zro0O5uxgK8KxNYl/LoEw0YTxx1tFRnWI8ep7uPLqx0YCoR43q7Jq2L/IlI8
	ddKmgraButQ+s3M0jrc3Q18Vve/fL0o1KFACJO3E7AP+/3s849kiIJgyAcVkt8JQ/FFq1whvetc
	GYxtR+N7w1GTgc5BKRaioej1rOIwz8HZKtH2Uo2zwE2e1+tDpemjvxaRUixxYiXLOSbE0MNrcJT
	tvUHy/Bh8lTN0yEDt2GDJ1x2vyDgDOCc8Nn+t0/p6dW5usTYEZ0VdR2wirnTMaOUExm9D4pKYJJ
	ntShBfB/9cPF7Y37lSVWPXkTK/GpN6dmsKWgQn5ZMwjF
X-Received: by 2002:a17:906:eec4:b0:c1c:2ee9:5e6d with SMTP id
 a640c23a62f3a-c2039c39717mr256553566b.17.1785920776873; Wed, 05 Aug 2026
 02:06:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Adien Akhmad <adien.akhmad@gmail.com>
Date: Wed, 5 Aug 2026 16:06:05 +0700
X-Gm-Features: AUfX_mzIUZp8AYlqtIBuzHXCNyw7GUj-Ox0c0OOdICvt2Rc_9zAeqM6dq9C4xQo
Message-ID: <CADoNwcscDrx+YcfbcW4YKONDZZQgnPiwEOxL4QYV_C7_=FOFcg@mail.gmail.com>
Subject: bug: git credentials helper strips wwwauth[] on HTTP redirect
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

Ran `git push` to a remote whose URL 301-redirects to a new path before the
server responds 401 with a WWW-Authenticate header.

What did you expect to happen? (Expected behavior)

wwwauth[] to be passed to my credential helper, as it is when pushing to the
same server without a redirect.

What happened instead? (Actual behavior)

wwwauth[] was empty, so the helper couldn't detect the auth scheme.

What's different between what you expected and what actually happened?

The redirect causes wwwauth[] to be dropped

Anything else you want to add:

The credential helper in context is
https://github.com/hickford/git-credential-oauth
The server is a self hosted forgejo https://forgejo.org/

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.55.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
rust: disabled
feature: fsmonitor--daemon
gettext: enabled
libcurl: 8.15.0
OpenSSL: OpenSSL 3.5.7 9 Jun 2026
zlib-ng: 2.3.3
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Linux 7.1.5-101.fc43.x86_64 #1 SMP PREEMPT_DYNAMIC Tue Jul 28
14:24:13 UTC 2026 x86_64
compiler info: gnuc: 15.2
libc info: glibc: 2.42
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
not run from a git repository - no hooks to show
