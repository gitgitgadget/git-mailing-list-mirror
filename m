Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F00E13A868
	for <git@vger.kernel.org>; Mon, 16 Dec 2024 15:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734361763; cv=none; b=gcBbeHjlcOdr2zjX0tVFhj3XIg4GeUrUYIyKVnx+yBGobNu++0zKQrtfiP/+GjRHKccObwdE1PJSNsNM0Hk8y0HrHPDTuZWao5hOA0ch0dFR9M91Py0A5BbCYOy27jL5cwmWtYUTjSZFz+vAVG2dlkPyUCtadThBb1fznDa76Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734361763; c=relaxed/simple;
	bh=grHowsS7eKcEmRzjIXzeyEa0+cBXVz2r2xuWMoiPhss=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=r4MrJ7uMfSDecp6yOuvNdPHGA79yLZOGInfdWVTyll2okbYnXUrQmzC61Lg3I3wg5XSa6Uf5F61RpfW+VYPbA2XcXFvzxLclWQRzHLV1pfqIg6UoTumEJzQ8N5yn6qge+NmhpLD4Z3abIJnaQnzz7uDd50T6oO2ljASbqIa30Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=akorzy.net; spf=pass smtp.mailfrom=akorzy.net; dkim=pass (2048-bit key) header.d=akorzy-net.20230601.gappssmtp.com header.i=@akorzy-net.20230601.gappssmtp.com header.b=iPQpgkzn; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=akorzy.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akorzy.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akorzy-net.20230601.gappssmtp.com header.i=@akorzy-net.20230601.gappssmtp.com header.b="iPQpgkzn"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2efa856e4a4so3000291a91.0
        for <git@vger.kernel.org>; Mon, 16 Dec 2024 07:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=akorzy-net.20230601.gappssmtp.com; s=20230601; t=1734361759; x=1734966559; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=grHowsS7eKcEmRzjIXzeyEa0+cBXVz2r2xuWMoiPhss=;
        b=iPQpgkznPK8f3CFG9LM095IxQUQt8+uy8XQORLNYAGxdOKG93mYX4FIeABnxa2nJUN
         VhK4VUYhlVkcEO8WSO1C7/aDgvKhjuEzbfjrQ5/qxB+KOF9DUyS6Gxk+cTsMrJec+GbJ
         5xMOydAKu3I96KPo4XnhzTyn7tBzwlFhBlJJzCrUCC2D6byDoowxnfsRUh/8goSiDKdo
         JY8vdGUQsU1GJrehowfT1ltJLlKXhnznsO8A3U/vO85pfbKGSxIm/zH1VUwco18OnB2c
         4WXWZNKD1sEleAEgjivWdVd1EYmEBEZODX3w2uBlax9dS7XoQJNKeStItvivwx5FhSWU
         xT6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734361759; x=1734966559;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=grHowsS7eKcEmRzjIXzeyEa0+cBXVz2r2xuWMoiPhss=;
        b=JCOKs9+FgenWJXdnqQUV3TEs9pGUhAMI8aY7LymuIY7PNtB4UbU3RGEJWfudm9q8Vf
         jRvKqDtJ5OfzZ14+8o5g0in3jH5EhZcYXxHUEkWOKMpGjhL5OZmw2CbNpxeVA1t8i/bj
         4UN/G7ddAzrhA+kUx0/9qbg/eS1t0CsP85LeL6QipHlr+frcu+OL9QtDxYyf5cHX6y4l
         Ibd4m+KP4i8H44hJBFuSt9sGQFZwj8p5bsENzbyXmrd8Wq+6bt72WumZMFWw4nJl7AEq
         kmTBdnAL4don1BqKHvNZYl8W1AclKi0OE99dVZ508Sh6rFi+BUVqnWC1t18/Wh7C2RoL
         dKOw==
X-Gm-Message-State: AOJu0Yz915Fs29uqjREe5r0M02ClxoR8N/9I/MLfblC+OaZVCyv5QT/S
	9dkBo9PZTeoV/KL8SGhaeLTT58TmFJ8mUaUDulyAOygh5/01BaRENX80KfmTqzP/QStsLpfuar2
	lX18PKOzslb3BbK/I63je1Ds8Nz6+D+/kGvSc48ZA14FII/qtyck+kOSPTu4=
X-Gm-Gg: ASbGncvA/40vWHIk5c3REZM7TznZj3hVHXVw+0FXvpfu+nme+wBg962cW2QCgEjYj1n
	hUR7SGhFeF/LYUJqwarE9iqasqQQGgPEiDMYyug==
X-Google-Smtp-Source: AGHT+IHR46u17a410bdDpT7nTd+Ax/nR2Tk0K9KVC4YSFQgX8n5fhSF/5088E1sUx2wH403kTG/XhxeoViN9BAhKnJc=
X-Received: by 2002:a17:90a:c2c6:b0:2ee:f076:20f1 with SMTP id
 98e67ed59e1d1-2f28f869282mr20869392a91.0.1734361759341; Mon, 16 Dec 2024
 07:09:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Aleksander_Korzy=C5=84ski?= <ak@akorzy.net>
Date: Mon, 16 Dec 2024 16:09:07 +0100
Message-ID: <CAEtHj8AXKrQfyAW9FSv6yC-8GF1AkPixMFjSye+B51pJ4fOtWA@mail.gmail.com>
Subject: [Bug] --simplify-by-decoration prints undecorated commit
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

In the following scenario, --simplify-by-decoration prints an
undecorated commit, which seems to be a bug.

> What did you do before the bug happened? (Steps to reproduce your issue)

# Clone this repo
$ git clone https://github.com/bitnami/charts.git

# Test --simplify-by-decoration with -1, which should display the
first decorated commit
$ git log -1 --simplify-by-decoration --oneline f137d2178d
f137d2178d (HEAD -> main, tag: gitea/3.1.2, origin/main, origin/HEAD)
[bitnami/gitea] Release 3.1.2 (#31031)
# The above output makes sense: the commit is decorated.

# Now, let's try --simplify-by-decoration on another commit
$ git log -1 --simplify-by-decoration --oneline 1e3ef455cc
025a87d9db Merge branch 'master' into master
# The above output seems incorrect, because the commit isn't decorated

# Let's confirm if the above commit is decorated
$ git show-ref --tags --heads | grep 025a87d9db
$
# No output, so the commit isn't decorated. That seems to confirm the bug.

> What did you expect to happen? (Expected behavior)

I expected --simplify-by-decoration to display decorated commits.

> What happened instead? (Actual behavior)

Git printed commit 025a87d9db, which isn't decorated.

> What's different between what you expected and what actually happened?

Commit 025a87d9db isn't decorated, but the --simplify-by-decoration
command prints it.

> Anything else you want to add:

No


[System Info]
git version:
git version 2.47.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
libcurl: 8.4.0
zlib: 1.2.12
uname: Darwin 23.6.0 Darwin Kernel Version 23.6.0: Mon Jul 29 21:13:00
PDT 2024; root:xnu-10063.141.2~1/RELEASE_X86_64 x86_64
compiler info: clang: 15.0.0 (clang-1500.3.9.4)
libc info: no libc information available
$SHELL (typically, interactive shell): /usr/local/bin/bash


[Enabled Hooks]

--
Best regards,
Aleksander Korzynski
