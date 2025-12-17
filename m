Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEE9366563
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 14:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765981131; cv=none; b=fM8CfsMGgArlNfO6YvU7r36w7JAhkVeUNsOYnZz/BjukTZVo99Q1HEacGDVSAlwojJBxT6rz+IL5hdL/UOAm8J2arb9ZxHKjr3aj6QU7qLE1pvJBtuSqasMsuaGJOXyZdcIeb3NwAIbqmVnN+qCVambIhY2LvkkrS4ocJRTrULk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765981131; c=relaxed/simple;
	bh=aYqwYI6xm/L1UUqZDqQ1jbpYB/XUS7Zr/ZWZCbKkMqE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jNYsGwkg9VY209wLK69AzoarOEbs7WuVymh+54qlJQEFFY6CT9UiCwdyCXJ47ji8HFzH55W+JJoC/IUTAbthYlO4ohaCAXjnjwozz4iyZ7HlHeGfZc5SyjvjAWtPY/URxRc13H+sGUYTpSgfTybmwb5BT92J61NieYVKWsU9DE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/MMfRgj; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/MMfRgj"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-3ec41466a30so525124fac.0
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 06:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765981128; x=1766585928; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbor7xugcrZYAj6xj4bt2y4TuIvHm79sduO1ZeNSm1c=;
        b=H/MMfRgjhLIJj+H5yky9nz+DpO5RfCb2WHFV7h48FJ6dB0CDeavJ1h4ehcUijXCITL
         0HNx9yCTVEy3nsaIqnKNIvMqjWfg4X86FC5GuIKQYwmD360T84gBfPS+bC205H5Vm3Jp
         WnpCx449si13oLxfBHUeZxs4z5FEo31wxDhsIxvKa/yTHhTMhZqcQHEHNClQuBrFiQ8k
         /DEnmu3AxbXycoMRjqrUT6H/EK7T1UgsSKSWF4B1J50iK5yhIBuRYeyz3boZPinD21Rl
         Q7z//ElDCImlj1TPeP9cVzmdHT3CvDpCdOK3Giu3t5lq7P5Ktno3j9I3rSobelItO2ft
         k3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765981128; x=1766585928;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fbor7xugcrZYAj6xj4bt2y4TuIvHm79sduO1ZeNSm1c=;
        b=lK+050M2+8nhiNqCdvW5GI96b23WlngqjfJs/su6N8TIaWDjTMEH9U6bFcfaBM05cm
         q9Ztic2v0Gs06LOpIMvBcFOXKhkV/3Ieqq8jR1sE2XDLIMWmIQsny1mAkEtvHMTiL45r
         tMQh0A0pYJ2hSwYWkBslMZ7j9faHyL2eRgVu0bMelnSg7xXkgJgkyMqX2HYFH81oTdOo
         BhFjAHtEOpUyuZAP1ostHA4hJKMkowSZCFsHJvDfPiIsSbQYflm78UDAw9mQxV2D6kGo
         VG/pUmxz1aaxYCplHZPU674yd9u9+A2ZAAUkZ7V+LMEp035zcfDuFFq1VK19BRjTknMr
         ZDBQ==
X-Gm-Message-State: AOJu0YwN4HFPjBYviqVa31pMht6J6OwzxTKQ/PTS+GkvdtkrkClZrBTj
	gWgwCE9myde3SkrVqYbcXDPm2JHhcWK2naAhSO2hzfWw9bgeNbJobMRQrFxUJyc6
X-Gm-Gg: AY/fxX6evEDjLFvkyl6FCxBI6O8LHMnYIIZE9DLtq11Gh1gDA5a4Nfqp1K7BqhwB1BL
	UuD73TXxXTdXdmHe0fY41OcvqV0wmBBAZ7UeF7ZnhhDMWsJh4+oLJhE6dSj6JkmxfiAxR8Fg6IV
	AwiFGfnumi1ExwGvrTHBEvJBouc4If3f7PUznr0n32RJyM/6XCG4mbGFxkOb0I8utqOlRuYBayj
	TTuTMfoqidkBNdGLfrCgj+Wb4r/pbR2G7nzC6TytN0xdq5vQ+1ryWhhmf1wmxpjENFxLFqX5MZ0
	DpZ5IM6m2NXC8lt533rkqsQhgFcM8sjlOqBd9/bJGRJ/tGaM4DlxyCrtrh16pIHeipX0KVyNZEy
	olJ3BmFmkAQFV0oEMCks1uiW2v+1ymwC7pOgjBpnRHF+DQVIgAqoHajdVEQq8qWfO+FL8xafp+k
	l0BDq9/2Kr+z2l
X-Google-Smtp-Source: AGHT+IEzInrL5h2h+1glLRzgwgCUo2iPa/7H/oCZI0RgLNT9oUv5KT+5oZVVvQlg08vhsUOnOEj3Sw==
X-Received: by 2002:a05:6870:a0ad:b0:3f5:4ef1:44b8 with SMTP id 586e51a60fabf-3f5dfa3e622mr11994042fac.12.1765981128242;
        Wed, 17 Dec 2025 06:18:48 -0800 (PST)
Received: from [127.0.0.1] ([135.119.38.57])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f614beda5asm8299568fac.8.2025.12.17.06.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 06:18:47 -0800 (PST)
Message-Id: <pull.2009.v4.git.1765981126.gitgitgadget@gmail.com>
In-Reply-To: <pull.2009.v3.git.1765885577.gitgitgadget@gmail.com>
References: <pull.2009.v3.git.1765885577.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Dec 2025 14:18:36 +0000
Subject: [PATCH v4 00/10] Prepare Git's test suite for symbolic link support on Windows
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

Git for Windows has supported symbolic links for quite some time: In
https://github.com/git-for-windows/git/pull/156, this support was introduced
already into Git for Windows v2.4.2.windows.1 in May 2015.

However, the Git for Windows CI never ran the test suite with symbolic link
support because the MSYS2 runtime (i.e. the POSIX emulation layer required
to run Git's test suite because the latter is written in Unix shell script)
does not support symbolic links right out of the box. This is for historical
reasons: Symbolic link support was introduced in Windows 7, where these
links could only be created by administrators by default, and it took until
Windows 10 Build 14972 that at least in Developer Mode, non-administrators
would be permitted to create them.

The MSYS2 runtime does have some sort of support for symbolic links,
although with caveats: seeing as it expects the inputs as Unix-like paths,
but the outputs need to be Win32 symbolic links pointing to Win32 paths,
some normalization has to be performed in the process. This leads to
sometimes surprising behavior e.g. when a link target like a/b/.. is
normalized to a.

It has been a minute or three since the time when Windows versions without
symbolic link support were common, therefore there are plans to turn on that
support in the MSYS2 runtime on these Windows versions by default, see
https://github.com/msys2/msys2-runtime/pull/114 for more details about this.

To prepare for this, I am working toward upstreaming Git for Windows' own
support for symbolic links. And to prepare for that, in turn, I am hereby
contributing preemptively the fixes required to eventually let Git's test
suite pass when both MSYS2 runtime and Git support symbolic links.

As a bonus, this patch series also contains fixes for the Perl tests (which
were broken for a few years, unnoticed because the CI runs need to save on
runtime and therefore skip the Perl tests because the consume a lot of
time).

Changes since v3:

 * Re-added the credits to Patrick's research that was accidentally dropped
   from the commit message of "t0600: fix incomplete prerequisite for a test
   case"

Changes since v2:

 * Polished commit messages.

Changes since v1:

 * Fixed a grammar issue.
 * Using cmp rather than skipping the comparison (thanks Junio).
 * Extended a commit message to explain that it covers all the cases where
   core.preferSymlinkRefs needs special care.

Johannes Schindelin (10):
  t9700: accommodate for Windows paths
  apply: symbolic links lack a "trustable executable bit"
  mingw: special-case `open(symlink, O_CREAT | O_EXCL)`
  t0001: handle `diff --no-index` gracefully
  t0301: another fix for Windows compatibility
  t0600: fix incomplete prerequisite for a test case
  t1006: accommodate for symlink support in MSYS2
  t1305: skip symlink tests that do not apply to Windows
  t6423: introduce Windows-specific handling for symlinking to /dev/null
  t7800: work around the MSYS path conversion on Windows

 apply.c                             |  2 +-
 compat/mingw.c                      | 14 ++++++++++++++
 t/t0001-init.sh                     |  6 +++++-
 t/t0301-credential-cache.sh         |  3 ++-
 t/t0600-reffiles-backend.sh         |  2 +-
 t/t1006-cat-file.sh                 | 24 +++++++++++++++++-------
 t/t1305-config-include.sh           |  4 ++--
 t/t6423-merge-rename-directories.sh |  9 +++++++--
 t/t7800-difftool.sh                 |  8 ++++----
 t/t9700/test.pl                     |  9 +++++++--
 10 files changed, 60 insertions(+), 21 deletions(-)


base-commit: 9a2fb147f2c61d0cab52c883e7e26f5b7948e3ed
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2009%2Fdscho%2Fprepare-the-test-suite-for-symlink-support-on-windows-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2009/dscho/prepare-the-test-suite-for-symlink-support-on-windows-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/2009

Range-diff vs v3:

  1:  2d329837e3 =  1:  2d329837e3 t9700: accommodate for Windows paths
  2:  b97afa9a5c =  2:  b97afa9a5c apply: symbolic links lack a "trustable executable bit"
  3:  f42a2f14bc =  3:  f42a2f14bc mingw: special-case `open(symlink, O_CREAT | O_EXCL)`
  4:  70237394c6 =  4:  70237394c6 t0001: handle `diff --no-index` gracefully
  5:  0d371ee552 =  5:  0d371ee552 t0301: another fix for Windows compatibility
  6:  91bd72062c !  6:  7b233c2d40 t0600: fix incomplete prerequisite for a test case
     @@ Commit message
          However, the `preferSymlinkRefs` feature is not supported on Windows,
          therefore this test case needs the `MINGW` prerequisite, too.
      
     +    There's a couple more cases where we set this config key:
     +
     +      - In a subsequent test in t0600, but there we explicitly set it to
     +        "false". So this would naturally be supported by Windows.
     +
     +      - In t7201 we set the value to `yes`, but we never verify that the
     +        written reference is a symbolic link in the first place. I guess
     +        that we could rather remove setting the configuration value here, as
     +        we are about to deprecate support for symrefs via symbolic links in
     +        the first place. But that's certainly outside of the scope of this
     +        patch.
     +
     +      - In t9903 we do the same, but likewise, we don't check whether the
     +        written file is a symbolic link.
     +
     +    Therefore this seems to be the only instance where the tests actually
     +    need to be adapted.
     +
     +    Helped-by: Patrick Steinhardt <ps@pks.im>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## t/t0600-reffiles-backend.sh ##
  7:  c2d3212f11 =  7:  31ed59481c t1006: accommodate for symlink support in MSYS2
  8:  03ff6d756d =  8:  37f9614ef5 t1305: skip symlink tests that do not apply to Windows
  9:  4ab6aaf2cf =  9:  e604ace822 t6423: introduce Windows-specific handling for symlinking to /dev/null
 10:  5f056902df = 10:  6caf8bf0b1 t7800: work around the MSYS path conversion on Windows

-- 
gitgitgadget
