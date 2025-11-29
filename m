Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0F630FF39
	for <git@vger.kernel.org>; Sat, 29 Nov 2025 18:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764440912; cv=none; b=ckZvqnQp3EN63+lMdkxLzJye9fAjd+x6SWwyucJAtfhVyzNseVClXxsuON45CYB6127LVAA1N/qAoj5O8eOqAhDJWXy9clH8qAiDbQNZbD57LD8TG/yePLCJ8vF+J9SWf7BsH6juYVatIqYut4XcH+z1IhmKeXR3gZBfN112RlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764440912; c=relaxed/simple;
	bh=Pj8oqcotboq+exBOr77lE7ozBR1Q8It01xB73FC6/JA=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=XXrzJn/l+fqM/FuBCByrS2n/GWeW4f0LtmWHgh5zVrouSVRh3GifZBzQDATBfGR9OJfsq4OgPlzHUKA+Ir6UTm2a+5MTaeppLIzVfoLzRJzaJf+DXKjUAOfnUQoIfX/cNU7M+0pgT23CEn5MDlAJiwUGdvg+ou56g0bm3c9Dmnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wj2slXy4; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wj2slXy4"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8b31a665ba5so253662485a.2
        for <git@vger.kernel.org>; Sat, 29 Nov 2025 10:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764440909; x=1765045709; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pUkzKhDX0dfo8LQPYUzF7UtBBQWWkK6PESwErDauZko=;
        b=Wj2slXy4lZeC00FZzpWeYMlDPJrwfCSXdzsDVLXAFhma3ynV85lXy03uXXGSm/W/LX
         Y9yAx1v07Vky9bQ+w6OhNwUrFnmqvhCqNrdPcX1037JgpGmc3GtS66M/cVb+8mAhi654
         USFTVK70I596sOs7CxFCHyr8k8uvUqIsyCzvF46mLABvf1f8X1X9ZNBRP/E3h2pkReX7
         OA9JFO+kaXz2S75Ci0xRYOWZEalXua8uqu8z5P3ttvfp1GYLfLZHOGLqaUcKOGDB6w9P
         njOjABP1Wa+0QGCvXX/18zXqV1uzewNhZ5522ss/rhKLDeGnxuyMUoV9bMim7KxH+kT7
         WRnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764440909; x=1765045709;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUkzKhDX0dfo8LQPYUzF7UtBBQWWkK6PESwErDauZko=;
        b=ZAzJCD5/NsjoI6zpChwYUwrX6g87DqvHR0fc2PTl0V21xc3KHIPjx++/xkmi6h/AAf
         Scva4n2wl9d54Oquc9ppGEOxnl9784iZU2ao7mB2PIHr8mGvyK/ZbGpdnotJunZLevrt
         9ZDUURyibjAICs9a8JcTYB6CUaNgpwMbqpY8vkyTEqP//Mbzh7s+J090jP3PjmQB0vUI
         NbBXkZnhTIl0creW4Xo0U/XhTkyk7Q/ko/C2soMVTIJmCXp0EE+8RJqismWcHag4Cwze
         GU37Nkw+CWgxTt516m8Vfm7gJWBQwpLoe6Zvs6rMQlKIaqqmPPehnBFsQ1/L5LPzvtjy
         h0IA==
X-Gm-Message-State: AOJu0YxD1VDQLTxR2shXwxhsSMgDbdHheZr8aMnLaef240gLanMeDIv7
	6jnzixBYYJCdhRLhPcvxjaVc3e63OjT/v9UkIwkCE+wXpo03bwZJCxTP9y+AXA==
X-Gm-Gg: ASbGncu8pTDOJIatXpZ3OH/EsYC+9BwF/kilHV2JHH5rF7IG4ghVqsVt1l02iRdg12j
	hAZ3qXL8VxrJyIhMptCWM8qGlLmaQhD6ah6JTJQnL4qLdfZ3+ox3OY8glxcbaUba6BcikPgC1xM
	Q2kR1xXKvQqvRPmDB0TBAWqms1vfZXfZJ1NvGkzD+E4XLrbqUCcUZ/jZ2+Wg+oQ3u4y0fNlLyYh
	TNZSGuv1ZtzgzrF1KCV/Y2W4LbY9q9LhMpPwwpT49g3oNldslse1C1TgMqFOl4jG1wZ/wI//oo6
	rvcJ6ftQ1nwWHN9IriuqqHuK6gv/pwru6tTZXyyMENJGbgm4Tc7DYWBMD1RtFJgZeXH0Syet39h
	i8PzC1RGNZv69vQTiIH3kjmNPehzhVzXTnyt9VU6JjfEhyGJG1UFSyNVlzo10XZjwd6/5+majMQ
	NK+pVlxwpfOKdE
X-Google-Smtp-Source: AGHT+IEqRxaNkP8jB5YjG2PGOeSgjkDdH3huWMZHh08hAWUB3QqeWMlfbY+CaJRnzuRwDuuYRgZ4nQ==
X-Received: by 2002:a05:620a:3f85:b0:890:1cd0:efde with SMTP id af79cd13be357-8b4ebdbdbf4mr3199217685a.64.1764440908858;
        Sat, 29 Nov 2025 10:28:28 -0800 (PST)
Received: from [127.0.0.1] ([20.97.198.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b529a9c030sm543584385a.21.2025.11.29.10.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 10:28:27 -0800 (PST)
Message-Id: <pull.2009.git.1764440906.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 29 Nov 2025 18:28:16 +0000
Subject: [PATCH 00/10] Prepare Git's test suite for symbolic link support on Windows
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
 t/t0001-init.sh                     |  5 ++++-
 t/t0301-credential-cache.sh         |  3 ++-
 t/t0600-reffiles-backend.sh         |  2 +-
 t/t1006-cat-file.sh                 | 24 +++++++++++++++++-------
 t/t1305-config-include.sh           |  4 ++--
 t/t6423-merge-rename-directories.sh |  9 +++++++--
 t/t7800-difftool.sh                 |  8 ++++----
 t/t9700/test.pl                     |  9 +++++++--
 10 files changed, 59 insertions(+), 21 deletions(-)


base-commit: 9a2fb147f2c61d0cab52c883e7e26f5b7948e3ed
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2009%2Fdscho%2Fprepare-the-test-suite-for-symlink-support-on-windows-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2009/dscho/prepare-the-test-suite-for-symlink-support-on-windows-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2009
-- 
gitgitgadget
