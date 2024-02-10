Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6C33C30
	for <git@vger.kernel.org>; Sat, 10 Feb 2024 04:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707540556; cv=none; b=uLNLFxO2Fwvp/ZhAmtnv1lflW0kpMwcRnPV/Wtk3UczqlkRc5YE8rnuQbFlsHIQoiZJCyQKMoSZj+Syl+HiDENQlqWfjKHeWuOSCs5RJfIFzkPW0/kacbW+CSgRTK8C+lQSTLaxydLg2iM1ZRVZQXX5IcsuT+N6o0cW1ZxnyOLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707540556; c=relaxed/simple;
	bh=F6AkGdKxVtKhVRDnRBmwPm0yN3sVp4fhfwMBRVZ7h2E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=oZl0U+Mx/rZLeoXY+8SQW0YkBzS00u2XQx/OhZVVwFmHzCR4nvMTmqxpZM5XNalFftbx+fBFb9eJZU14tTS55xqe4Yu56mLscvlEDnEsDo2vqM20klo8E+0uyX8dLd5EWCS0WQf8pQqRVqbEb5SkHJAO9hnwcvv1IpJP1PnqtVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HST3+3Ol; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HST3+3Ol"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d07ffa0a9cso16026971fa.2
        for <git@vger.kernel.org>; Fri, 09 Feb 2024 20:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707540552; x=1708145352; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F6AkGdKxVtKhVRDnRBmwPm0yN3sVp4fhfwMBRVZ7h2E=;
        b=HST3+3Ol1lzyUYvaMv5E26qzeNZz/pbfRjoQrJQc2YNNz94Lxh95nbT3rSiPUl/K2j
         4E6FomtTBx0v9iunPIdp2mHKROqMgxjxo8K8f8RnlxWt0QT1kJBolc3i9+YBCwgop/Q0
         ONGXu3oJpNl6HvV4mL2sjAap+yBHULzd5JFuFfs3Yy2rqJY9JEovxUOpq7n5Un+cwOB8
         MaAfohLbcBnAdS+tgt/133oNCKoxVHZNcyx25YnYLB64l01rWzfIh9Hl7MzZ0Kn+FHSE
         QRTu2YP3kl5cbaAHJqw9nqM9Oyev+Sqdi6KNX+cmWF5Q1B8NyihkvJxf+q1A/PN9giEh
         vQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707540552; x=1708145352;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F6AkGdKxVtKhVRDnRBmwPm0yN3sVp4fhfwMBRVZ7h2E=;
        b=WA0xpoFoT88infjU4LG+3eieXSuaK3sFuj3TgzxBvEesLi9CKzGJ49M//7t3VqqiV/
         z1gxF83TWAFlZi983PlzEywyg1br8H55VTYKh5oxk923snwhlIRwcOuo5znG31w+bNUf
         Aw53LsMw49E/J5hs2tinzXVvbbMnvqrfPrGdlok4qeKeKK09nAeTTrzXTUeuBvVH8dp2
         6+HVIVEB8FBTRvQJJIJKYBhdqJEu+vqlTNRvcsQy789hF4L4nh/FvsrdoFWWpwXTVdPB
         iCLAqNrKzvDoL06O65nD6OFnw9kfVbkKQskKUAc0d+75nnIifNfuBeGFT+cItZfiDtRW
         S6mg==
X-Gm-Message-State: AOJu0Ywqo8Ll4ya8ZqGqs1OEtmp+ZyAZZTIYfKC3kDGIJMh5flcadcch
	+xlEvVTHN2zy5z7EqaWZgF3vjnKcaHDz9tQje5zcWqIHaY/s528/sPsfOvKKW36YC8KphUheMds
	QjpNDLBhaC+UHgwim1fQLrVwoMF/2zvut79Iqzw==
X-Google-Smtp-Source: AGHT+IGj+zyhHIhzU0w8t1o27GfUkRwT1udGyVSjXZQD4sBqxSxdNeoN1hxKVMjrMS9RJvyEQ0xehvt4JvgqHlLfkBQ=
X-Received: by 2002:a2e:9096:0:b0:2d0:dfa5:666e with SMTP id
 l22-20020a2e9096000000b002d0dfa5666emr535710ljg.16.1707540552197; Fri, 09 Feb
 2024 20:49:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Vijay Raghavan Aravamudhan <avijayr@gmail.com>
Date: Sat, 10 Feb 2024 10:19:00 +0530
Message-ID: <CAK7MZG1MeeS5QNPog9oS+MbdKpkDXu61eVOszsC20Q=ik+Ng=g@mail.gmail.com>
Subject: git status became very slow after upgrading git
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
1. brew update which pulled in latest version of git
2. git status in a repository (without submodules)

What did you expect to happen? (Expected behavior)
git status should have been fast

What happened instead? (Actual behavior)
git status takes almost 5s to complete.

What's different between what you expected and what actually happened?
Time for the status reporting

Anything else you want to add:
i have the `status.submoduleSummary` set to `true` in my global git config

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.43.1
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 23.4.0 Darwin Kernel Version 23.4.0: Sat Jan 27 14:29:57
PST 2024; root:xnu-10063.100.633~14/RELEASE_ARM64_T8112 arm64
compiler info: clang: 15.0.0 (clang-1500.1.0.2.5)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]
