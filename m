Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6EE34D4F4
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 11:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765885582; cv=none; b=KWzj/bTUAO8uhg/UI0vqYsj7nxv8CgnNKmw1F5f3RNa78BojdChFrLkJtLQhqvWt7l1TuzmGKvZGgXMJ96aBQl1Mh7a8GaR77p3gd1WxfaS4bOJ+8xBd0kuHZRKybIiOyP8c/LEk0lRE/MW5ZUAPnrwkE+1W8ifKcQ76aw8BMCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765885582; c=relaxed/simple;
	bh=ncWVcg/lMW0Zlu5SM0bIMnSSvQHJc5V5thRNv6/soTc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NHCEtOqeLP6zEPXaL+/ACn2rM/flWmPWv5e7iNqMeUdBR0hl7kbiIUJJmPkOFA4pfDaulLs8PNUjFpiKvGVFUI3MFPXUFqWkhrl6Uedu393J62UbCGiI/AuEQDxFLGsf1+LRCGaHb34NhWkVJO++fiQiLyXgDNAGbCMu8/PClSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+XgMnIH; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+XgMnIH"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2ae29ddaed9so2179255eec.0
        for <git@vger.kernel.org>; Tue, 16 Dec 2025 03:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765885579; x=1766490379; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMJydhhvbFQ9CFsTDkfkSJ1GKp6Y1EEZxx9Bmlcwh2I=;
        b=D+XgMnIH3HX5Fgr+TNjoIQ/owlxo+u3eNxqcnO57uRQmRHJZLyrc3TUkVHmdN6DxZe
         JzZTIlMYJth2uP27qSMyYB3AZp6YOnhJsarN8NZNbZE7gCDGRow7YX9enxFOsxVTD+Uw
         0gcGAAEu94Qy70yo7WxpIpGiwbFZ7uC2Wxf3AMjbuKNIgT+d9JiNPD58Sgz7gku2NPVn
         +/90oOmti5Nl0y2fOPEKgP/gptm3d5N3PN0qlK4WcliNQ7M0kAxkMj9eKewCXPq7ne9n
         Tyjk+Alw+BFLlP157WAI+HeBxSx8FzSZI8GOZz9beHYTvlto+2r5SnraEJXarum8q1aA
         N9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765885579; x=1766490379;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yMJydhhvbFQ9CFsTDkfkSJ1GKp6Y1EEZxx9Bmlcwh2I=;
        b=TgUxWqUgKAjvb3R9ZcdiCT5beWtquBESRIbTBfjJVK4Zt+RF2WBGzCjkey6h+6N6du
         QyGJEXlGJ+25mPnqPqM8xJORbQtFZNVzzyFpcss6fK4AVMenUe5j9hxasNR0d5Vij4bA
         o3rpQrPpGCmo8aoaGvzBeb5gwDzEgvd5ALwt1ZGej08BM+ZWyhLEp5EPTfI5oAWqn28a
         vtJfpRjC5aa/YmW9ttsg+mnWaCSINrYVvzzwlOmJ2WfKx9Nm7YJw/FQU5YF6z0/uX4R0
         prQAk3DG8vJNso5w/GZNSjw+c86a7tymYJx10pIrig6D3bgOwqFtR8lT6O6My6RpGaT9
         5BhQ==
X-Gm-Message-State: AOJu0YxOqchg2tTuf4I7gVHSMNYC03BqbNzOLxHcZwpLDBech9PsBMzd
	nS3Hoj283zFO/tGTYGEeFXGFtf25Ts4WFK6O2vR6vn/UdWNv5oQCmzVcT0vU1Q==
X-Gm-Gg: AY/fxX5w5WSOfTp+wTmDw0p23W6gDKGPHfRQX7jRDem53Kif175CBZvq2hzu/pO9NqH
	H6og6kmFTIc+SbnEXd03MIqsYJOTjeRhE6csjxBkAPBD4mI93+/9a1W+TkVQ58mnn//Bfe5dNLJ
	UMZK9uKexfglu1J+pRimWX0fF/yUKdzEPlr+yZTPpkb9Y0RGo9hHlw7BbrAd6fwMbMranhTCEhc
	9bR9nnhFvHmRhfrKNvcvJo9ztgm4JI/+jMRFXZDOQ/GCvW09HO8okgTStDialiT/CnnQrjt/xGC
	7KXbaBK2PZslAmhgJScBKIIqamSBa/cr14A0P/VPP0DiZPET8YskMTgjvIG+sJkU/EQQb8exDt5
	jWjlOZwpDvK9CjmJI7/Ft2zvmqSrfDoNefKx6bvSoQvWb9sHs1MQG8TRhBGbKUa2fG4zdbPZSW5
	ZLoN9hD/hWG3Yh5NJmzoUCdns=
X-Google-Smtp-Source: AGHT+IHXTgmbghPXmdXbYDBOvR54kEZOBQRWGG63qPze+1MxNp1tbpfuIO/GKS2RvIiWrpzaO1n5qw==
X-Received: by 2002:a05:7022:e806:b0:119:e569:f86a with SMTP id a92af1059eb24-11f34c29cefmr8829528c88.7.1765885578781;
        Tue, 16 Dec 2025 03:46:18 -0800 (PST)
Received: from [127.0.0.1] ([52.161.69.165])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e30497fsm53496154c88.15.2025.12.16.03.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 03:46:18 -0800 (PST)
Message-Id: <pull.2009.v3.git.1765885577.gitgitgadget@gmail.com>
In-Reply-To: <pull.2009.v2.git.1764946945.gitgitgadget@gmail.com>
References: <pull.2009.v2.git.1764946945.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 16 Dec 2025 11:46:07 +0000
Subject: [PATCH v3 00/10] Prepare Git's test suite for symbolic link support on Windows
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

Changes since v2:

 * Polished commit messages.
 * 

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
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2009%2Fdscho%2Fprepare-the-test-suite-for-symlink-support-on-windows-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2009/dscho/prepare-the-test-suite-for-symlink-support-on-windows-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2009

Range-diff vs v2:

  1:  2d329837e3 =  1:  2d329837e3 t9700: accommodate for Windows paths
  2:  b97afa9a5c =  2:  b97afa9a5c apply: symbolic links lack a "trustable executable bit"
  3:  96e279f50e !  3:  f42a2f14bc mingw: special-case `open(symlink, O_CREAT | O_EXCL)`
     @@ Commit message
          non-existent file and create it when given above-mentioned flags.
      
          Git expects the `open()` call to fail, though. So let's add yet another
     -    work-around to pretend that Windows behaves like Linux.
     +    work-around to pretend that Windows behaves according to POSIX, see:
     +    https://pubs.opengroup.org/onlinepubs/007904875/functions/open.html#:~:text=If%20O_CREAT%20and%20O_EXCL%20are,set%2C%20the%20result%20is%20undefined.
      
          This is required to let t4115.8(--reject removes .rej symlink if it
          exists) pass on Windows when enabling the MSYS2 runtime's symbolic link
  4:  9639e04ac6 =  4:  70237394c6 t0001: handle `diff --no-index` gracefully
  5:  3db0599d91 !  5:  0d371ee552 t0301: another fix for Windows compatibility
     @@ Commit message
      
          Just like 0fdcfa2f9f5 (t0301: fixes for windows compatibility,
          2021-09-14) explained, we should not call `mkdir -m<mode>` in the test
     -    suite because that would fail on Windows (because Windows has a much
     -    more powerful permission system that cannot be mapped into the simpler
     -    user/group/other read/write/execute model).
     +    suite because that would fail on Windows.
      
          There was one forgotten instance of this which was hidden by a `SYMLINK`
          prerequisite. Currently, this prevents this test case from being
  6:  f2da7d4d50 !  6:  91bd72062c t0600: fix incomplete prerequisite for a test case
     @@ Commit message
          However, the `preferSymlinkRefs` feature is not supported on Windows,
          therefore this test case needs the `MINGW` prerequisite, too.
      
     -    There's a couple more cases where we set this config key:
     -
     -      - In a subsequent test in t0600, but there we explicitly set it to
     -        "false". So this would naturally be supported by Windows.
     -
     -      - In t7201 we set the value to `yes`, but we never verify that the
     -        written reference is a symbolic link in the first place. I guess
     -        that we could rather remove setting the configuration value here, as
     -        we are about to deprecate support for symrefs via symbolic links in
     -        the first place. But that's certainly outside of the scope of this
     -        patch.
     -
     -      - In t9903 we do the same, but likewise, we don't check whether the
     -        written file is a symbolic link.
     -
     -    Therefore this seems to be the only instance where the tests actually
     -    need to be adapted.
     -
     -    Helped-by: Patrick Steinhardt <ps@pks.im>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## t/t0600-reffiles-backend.sh ##
  7:  ea74e678f9 =  7:  c2d3212f11 t1006: accommodate for symlink support in MSYS2
  8:  1619ea4a3b =  8:  03ff6d756d t1305: skip symlink tests that do not apply to Windows
  9:  807bb679cd =  9:  4ab6aaf2cf t6423: introduce Windows-specific handling for symlinking to /dev/null
 10:  945306b5d4 = 10:  5f056902df t7800: work around the MSYS path conversion on Windows

-- 
gitgitgadget
