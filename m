Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48B9396DAF
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 14:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765980540; cv=none; b=QobK5hfTm899KI8i3b6hvYyuP7ZhORMgCINF7j5zBCs82AWrfJpSbceeiKhD7qHkbKbX3Z22ybpnRb49IttS1pTOY+ANUMobecE8TbXA/4glRA3ip/SaZvwaY4GkqaJWiydoV3hIkq+2dMjV6Ms+qoT9FajA8rYwpw48sm+NSgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765980540; c=relaxed/simple;
	bh=cl3ViytIKWCmUq+HjuRF09O+9RCAg8DMo5/FJ0c++3g=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Aup7hx3s2BHwiMuTUB6rj6mRVmoxaepa5hTgl3GlKcmzuM9HZV+OpdfriVI3tmnBYKCm3eAlfN5eNU0oyw29q6L566rIjxvbeFnsBrvTC1j1nVr8ckqzjl5iaiZDChLDV7wdszoZP9jEIAClxdE+nQJzgw+yq5WCVL//oacuyC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ks15W024; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ks15W024"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ee1879e6d9so68119821cf.1
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 06:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765980537; x=1766585337; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RZComgySZP9yokB0Um4W1PzWsTJh6eCnMZ3qMeMTXZ4=;
        b=Ks15W024bYfAxLUiUhbafciPLiXyZ0G64KMhxpaPcrt0wc9gNcQl5G9IbMstGaEGeG
         OlFUOF37ViREMZ9UKyNCxjU3BaF2TOeu4hkWKQTPxJVNRM/aCBoL88NJv1Shny+t9oxK
         qkOf7nPuuisQlVuwutOSI9MbTIJCO2uD6Jnzamcsd4+SLsK/Oh2gtN/q78GiFMqa1x5E
         q1Cfy93qQ6QY2mfPn+7aT9owVmtDslmK9eF5WYPR+NpGJipFRWJw4nyazx8C+2tsgDT6
         SDz6ZUO74S4qQaQR82vr/spE/qncKLtUQgWllPpt+F3qtqoQmwvuYwZu5EEG2zP2qdMK
         Jqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765980537; x=1766585337;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZComgySZP9yokB0Um4W1PzWsTJh6eCnMZ3qMeMTXZ4=;
        b=nxgUOb8i9TPgcYGpxP+Vik/wun55M5gtsZ8iXu/ObKgNe7YOJxvTEU/XVBN1uLfIIg
         B9c2o83RtOr4d9DG3nF4BEdN5jY9dX2GM3GS03XRklzaNe4vBHeiWUllGPaTiEUpZKeC
         um3QXfMW2wM2t7Ajn/fsuMNSNtlUYflgw5OEnXM/utUBzP3xjUgtx6ACbWXyfFtHFVme
         OnFFJrKsVWMnxO+CV1Xm8O7hxP5ewpMZObB3Fd2U/oT9galX1P1iQ868+VxjB1shWXbM
         FOUh8DSHczI9jjG1juoq8PuUOLK6qz9rDlqc4NMArb31dOXEte5DXOE6MuyMC/6GGjgw
         xeXw==
X-Gm-Message-State: AOJu0YxZ1aHVqLp9xcU8v0xpX1X/SklPtY+1dkVzTsz/vbWCHWnmJqSS
	dpxhIjTzqyJJ1+ToGarvYQCZ3bPovq3bvXC71qp97eFMdJGb207Kalgs+65q+kOO
X-Gm-Gg: AY/fxX4KgKGonCL3BUDw3+ELdR7aHcSDTfdl9sA2QZ6fsSIzfTbsXg4l+LhcqP7mxL8
	MKnxMLv4MH0QyqVAannGDPkWMxShoXBTOjVmU0paElUoHzEimQ3+brxlm4vdAChPFWs9tDOdAsY
	0uZ6bomYG9MO3pGocR+YVywWxSmFhmV9xAj9v/fF6PON5pmlXFRDX5hDp6d4p5uJzpA0hdCewq4
	GKZSDIn6OOGC5e+eLqZS0XhMKZMJmPPAtW/grLhHv8xFbXja/MdMhDpP7Jqb9s3EpRw8+vFG4hJ
	qOulD363Po7tXnVLQek1IKn3qD+5HiIZdsURiHZ1veAK4+07EZvS/jGZ26nTk0BEoibOkO0knTb
	JNoPfEPLEgMGAuHBDM+XN8A3ULqQF1vdDLSmVNBPq8pLq7GHvh5OevdH8ENzGofFbhPGysJn6YA
	nbWSLxdAcpJj8=
X-Google-Smtp-Source: AGHT+IGehcyoXjMw5gZzSRdbTWq3A6fEC9zExL1retRWsrtmRrNP9W3qjikDqU10hmmdbJwzyKORrg==
X-Received: by 2002:a05:622a:1455:b0:4f1:cbdc:28 with SMTP id d75a77b69052e-4f1d05aed11mr241305121cf.52.1765980536973;
        Wed, 17 Dec 2025 06:08:56 -0800 (PST)
Received: from [127.0.0.1] ([48.214.53.69])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f345c52c49sm35592921cf.24.2025.12.17.06.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 06:08:56 -0800 (PST)
Message-Id: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Dec 2025 14:08:37 +0000
Subject: [PATCH 00/18] Support symbolic links on Windows
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>

This finally upstreams Git for Windows' support for Windows' branch of
symbolic links, which has been maturing since 2015. It is based off of
js/prep-symlink-windows.

Bill Zissimopoulos (1):
  mingw: compute the correct size for symlinks in `mingw_lstat()`

Johannes Schindelin (3):
  mingw: try to create symlinks without elevated permissions
  mingw: emulate `stat()` a little more faithfully
  mingw: special-case index entries for symlinks with buggy size

Karsten Blees (14):
  mingw: don't call `GetFileAttributes()` twice in `mingw_lstat()`
  mingw: implement `stat()` with symlink support
  mingw: drop the separate `do_lstat()` function
  mingw: let `mingw_lstat()` error early upon problems with reparse
    points
  mingw: teach dirent about symlinks
  mingw: factor out the retry logic
  mingw: change default of `core.symlinks` to false
  mingw: add symlink-specific error codes
  mingw: handle symlinks to directories in `mingw_unlink()`
  mingw: support renaming symlinks
  mingw: allow `mingw_chdir()` to change to symlink-resolved directories
  mingw: implement `readlink()`
  mingw: implement basic `symlink()` functionality (file symlinks only)
  mingw: add support for symlinks to directories

 compat/mingw-posix.h  |   6 +-
 compat/mingw.c        | 635 ++++++++++++++++++++++++++++++++----------
 compat/win32.h        |   6 +-
 compat/win32/dirent.c |   5 +-
 read-cache.c          |  11 +
 5 files changed, 507 insertions(+), 156 deletions(-)


base-commit: 6f6fe02f5fe587ec9788f8a5a34281949d7b2ca1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2018%2Fdscho%2Fsymlinks-next-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2018/dscho/symlinks-next-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2018
-- 
gitgitgadget
