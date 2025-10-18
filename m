Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BF6146D45
	for <git@vger.kernel.org>; Sat, 18 Oct 2025 20:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760818044; cv=none; b=guxFNz98PgBzuddKI2KcrcFUa1ZQHcY8A1/GP0/WrIh0ujlh863a9+cD1QGhjLOp2gUw1lctUzDV2gwhervVDqHcn2qhxvVQycZkQiOps2ShxTYitb6JEML9Ifm3T+/tAP57tDLTvTUrI2cQQoCXlRleY+IKGTYFgjcya4zo1n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760818044; c=relaxed/simple;
	bh=6V0hhCUobdZicR8Kno4KyDX68+tJdk3RQTMT69SjlH8=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=onb3scPIbuS0D03KBf0cZcUcBdibTLW+MV5LrCgjN9ooplgNt17b2Tf4/9MduZ3bn+J0A3+05MKqC867nngC18xaRs1tQtZhobODVYR40Ve4Y3uEHi940m9yurp70T7pkcqVylquaWuPe8K8krAhll9cn1wjs6si7l9+e0OMi84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zma61B+G; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zma61B+G"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-781997d195aso2360760b3a.3
        for <git@vger.kernel.org>; Sat, 18 Oct 2025 13:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760818041; x=1761422841; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6+tm8AD+3Lai5ZDYRRvwSWKtcXypgTX8EJROebXuD4o=;
        b=Zma61B+GalATFry+jj5mmPbWdmqQSSKlLYsEEySzdzN1WH//Yhr/eeKipqr4lOBLpJ
         nzigw++Bgb8j+yVwn9uyMOWi8pnDeOvMUaHxPslz7rP84WmY/84oBw9mWmx9gVnFKkzW
         JfyVlA1F0TWL1UoPEvyZCe7rdgEpa0+ejXn5KbxCxx318PqJV4dLAP0CHZPpQqZ7ji7q
         ZmivwWwvq0yamJ97HmWwIMU7EzZt8Fxkon3aFV9arVDQ/I1YMjy/EWlXazp1daG6TCK7
         dhCW2kArDZYMJmF1hWRzk0qB2NImAGmKfF/qp8gJ5yBwHYYZDvVQFCATaSgVYIsP220v
         LkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760818041; x=1761422841;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6+tm8AD+3Lai5ZDYRRvwSWKtcXypgTX8EJROebXuD4o=;
        b=DRzG3FWuhyHsroRajoea5Fa1olP9EWgcAD5eR9vS5Qdxxy2FDf/GDTQkGwzQNfGbzp
         vZr6z1xSd38CJJN1MyU1HbGvAFuQ93i+SxdzYRoiHQ9uye4ck6j9wUcmHxHkM9RpElJ/
         iWa0AandamBCfDaT/x6lOji6bNzqm4hQ0jvRw6FlQ+htUC2vQtFMUFiyM+A9gPnrZBQB
         1FAhEWRxNW2b9N4aIaa2cakD0AjJcG8Y6q6BUySxRtXk5GMR0ZHcns5YXAJCxgwE1MuD
         0f99UQzef0Ba50E0mVl4J09p9Jb8LfkyLKZb+CvGK/Cr/50fdHnusnhCDw1/6BTQQRC5
         fUmg==
X-Gm-Message-State: AOJu0YyfbHYQU2gpmO3aIaRNKvm5G1zvaYR3T7G/B3EegRnKsEk99aHe
	vsnT9kaI788RF5br8Wl4m9g9AIAc2/ZLvt0L1AeCrXGRvwPFYCqXSjV892uPtQ==
X-Gm-Gg: ASbGncvskcy0cOxSWI62hcJh+1kbnstjORHnTa6co8MmGa1CJjc1mhO4L7mZ8ymwUpd
	GXWOKv50hIywEyNtC5oZTYrmsb3MpDKQp89tmjJ/BttxpB0ECO4pvY4auV3WXaL7Itx+ZyRqYzi
	WTSwhHkHK0z+fHN+EE4+OjVpTQdhMYD61bXixgjs73w+FGF8rEmSb9c6zWGwvdd7+pRgSHgnWaW
	0unjmd58M3biMf70+GnY6tHJSwwfohi3eKdZqRBC0wjXM7N0trpUVAqeBGZYPcISIZ2WpO7QDin
	BP8cnP415QPE8Qa/bfCrlmOSFKhlymHiCG1dLxGthEeI9LCb78cWartZNXgc6UoCh3sUPDsdGNF
	BMJu1VJLikFr6h8SJs9Trffbwjb+0D+sZhMD5uaUrZV8bMxsSMP3iuSvMqQUnb3ApMmlBHMC8zH
	eTgvY=
X-Google-Smtp-Source: AGHT+IFeqkRXFmw+vLgUsmJqRFe24Nn5izKny9V75+4A+ZUoovgz7h756QwDQP87fuiEufdBoyQIwA==
X-Received: by 2002:a17:902:8e84:b0:290:c07f:e8ee with SMTP id d9443c01a7336-290cb27af18mr76641955ad.43.1760818040875;
        Sat, 18 Oct 2025 13:07:20 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.211.85])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d5612sm33208665ad.65.2025.10.18.13.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 13:07:20 -0700 (PDT)
Message-Id: <pull.1987.git.1760818039.gitgitgadget@gmail.com>
From: "Claus Schneider via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 18 Oct 2025 20:07:14 +0000
Subject: [PATCH 0/5] git-add : Respect submodule ignore=all and only add changes with --force
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason <avarab@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Brandon Williams <bmwill@google.com>,
    Claus Schneider <claus.schneider@eficode.com>

The feature of configuring a submodule to "ignore=all" is nicely respected
in commands "status" and "diff". However the "add" command does not respect
the configuration the same way. The behavior is problematic for the logic
between status/diff and add. Secondly it makes it problematic to track
branches in the submodule configuration as developers unintentionally keeps
add submodule updates and get conflicts for no intentional reason. Both adds
unnecessary friction to the usage of submodules.

The patches implement the same logical behavior for ignore=all submodules as
regular ignored files. The status now does not show any diff - nor will the
add command update the reference submodule reference. If you add the
submodule path which is ignore=all then you are presented with a message
that you need to use the --force option. The branch=, ignore=all (and
update=none) now works great with update --remote, but developers does not
have to consider changes in the updates of the submodule sha1. The
implementation removes a friction of working with submodules and can be used
like the repo tool with branches configured. The submodule status report
could be used for build/release documentation for reproduction of a setup.

A few tests used the adding of submodules without --force, hence they have
been updated to use the --force option.

Claus Schneider(Eficode) (5):
  read-cache: update add_files_to_cache to take param
    ignored_too(--force)
  read-cache: let read-cache respect submodule ignore=all and --force
  tests: add new t2206-add-submodule-ignored.sh to test ignore=all
    scenario
  tests: fix existing tests when add an ignore=all submodule
  Documentation: update add --force and submodule ignore=all config

 Documentation/git-add.adoc       |   4 +-
 Documentation/gitmodules.adoc    |   5 +-
 builtin/add.c                    |   2 +-
 builtin/checkout.c               |   2 +-
 builtin/commit.c                 |   2 +-
 read-cache-ll.h                  |   2 +-
 read-cache.c                     |  54 ++++++++++++-
 t/lib-submodule-update.sh        |   6 +-
 t/meson.build                    |   1 +
 t/t2206-add-submodule-ignored.sh | 134 +++++++++++++++++++++++++++++++
 t/t7508-status.sh                |   2 +-
 11 files changed, 202 insertions(+), 12 deletions(-)
 create mode 100755 t/t2206-add-submodule-ignored.sh


base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1987%2FPraqma%2Frespect-submodule-ignore-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1987/Praqma/respect-submodule-ignore-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1987
-- 
gitgitgadget
