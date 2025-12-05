Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317E7263899
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 15:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764946957; cv=none; b=GT9GBfsWJZSKkgwj3Y9BR4h/wOlKUS4fUfjCsr8VLfdhCeDcXgCQACbrVcQYj7RLwdyk0mjEVb0kSQJVhCKGQ+0P2uHA0V4r5Bjd64BJORD7NCaVqSwoSQItXR+vgz7rpJSpo3lKB6DXPw9rSG/PSSYqBAGwuQIyTixXdpjksmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764946957; c=relaxed/simple;
	bh=oHvVz1lA/VgtdQRr5J50gXO2erOlmJiD0RWdKppak+Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cCMGl1H1GfHw4yiwZqhZxGxTzoEMRSwLJGtFMUWuXM7zRMndJYUDB5h1qp1bkhj8Rnez9Fb+nHDRS3NumHBBsC2F34ilMmk46vzjQSfE1JvwVjna5MW1wTfj6zY7flunD+bI5kcLVn/CXSZJ+NcJWwphWM9c2xzwB7TPp+T/vo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OcghKbls; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcghKbls"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8b2ed01b95dso182100185a.0
        for <git@vger.kernel.org>; Fri, 05 Dec 2025 07:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764946947; x=1765551747; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AeM5E88cUg7cVaStX7FppE1VA8dc0fAHdqyEO0TkWNo=;
        b=OcghKblsjGGAUN7NS8AJyZRT12IxJVhYVzXAv9frQkMj6e+6QaOTjmz22Sz8nWTuNO
         BtTAx45zs+t9PLgW4bNLoAXsa0vq8QZv8gZr7X2FDpVDqGFu8Lf6Ep6p+0/FT6SnFrWd
         cZaP+K60KCqx2OsUut2Bq0agyK/XAiheuX32rmt8UemadVeW1KECN6OnmeAWNRNyOqgl
         eanWbAhJ3LVuSG2/6ssSBVU2IqjB2PQTkwNiNWVR+OZEmeI1UiwIKbvx1s9zJGpGmJgO
         2p/UDWIapvfwwYUqdEIPskXjVsbbgjzPS74YfbOQIc09PjOvnsqhgY0JfEZfFpZRly4S
         PJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764946947; x=1765551747;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AeM5E88cUg7cVaStX7FppE1VA8dc0fAHdqyEO0TkWNo=;
        b=NRSkfAV+h1NXNG3ZCK1gbZm3A7ch45seWDKZuGUAep00AJQAypaamuOWmjBXbo6VCS
         MTsF+GTUx8H9woVDytGtseTjEPB8+2+AydmtDDH3+C14MLZKAMrEQfvE4XnDK7uNVozB
         hw8x8/L/zuk5yM/GhPjBryOdTJyuxu7bbplHFhAmxC01EaRf4edIhwXEuq4XmYZxCOpS
         KOCpv0kTB6JMiJJUnAP/vR9d+pnyuPC3FUTnzS/h9rCYEdx3FO+e31PMqS1UcdEo/HOv
         tk/vEW+rHq9LXoCI9MepM2gRCCi2baydCPs68jMN7tzTWX5iqP4Yc4xAK2vHkE6Mz6YY
         1EUQ==
X-Gm-Message-State: AOJu0YyDvLW6ItprESTxBdf20K18Y/sclHKd6HEcyIUySreA6BY7sune
	oAcIGRrkUvnDBRmi4Wa6ratTM0uKi1P2JSmp4Ju9JFBwrMX+1aBFqvKkqmqUaA==
X-Gm-Gg: ASbGncvux2jJnvnWfWAxVYGyoe+ef9QIYXlxFkPzFPPSmCW8fIy75JGX0OD2ozxuxAH
	tqUeG8mAT5qQPjl6Vbeddb3Kq2k50SYW+4OFltbacvW+TTCSzsNvBoeNEzwpLTfor45kr5a7pjV
	6eis8z5LgipED1haIl+jI2KOjHxz9nuXkPoLaCEFOdkoMPQLd/oPnWcLoFJwkbpzP36x4AGUgri
	k0gEtWOOsC/9EQnEy6Vj44bfzD9Ut6g6VE0bNCinTM41HTh9yysN56NAscpM+R911fcN/yLr+J8
	4tB2heI1s1ZdzXQYVgfc1IUzzIw7nkKryfsHmkD7xoyi8Id8mNNNR4d/OfiQUbgXpM5iAf3++tC
	Q0SdW6XAUQZS2Aaq/ZOaCxzIeYlLcnaA2y9XdkEnZb6Au01iG9wwxpbMeAG3KlLa/zjduUtM+Y1
	8OQpTb2hBu/XPI
X-Google-Smtp-Source: AGHT+IG3lf5yjzeFGx5FwFva7tBfTj+suzAc2fXmFPyH8dnR9YViPaVPJCCX5DKPkjqKarC5Jvk/dA==
X-Received: by 2002:a05:620a:4009:b0:8b2:eb2:54e2 with SMTP id af79cd13be357-8b5e6a903b3mr1486691685a.47.1764946946688;
        Fri, 05 Dec 2025 07:02:26 -0800 (PST)
Received: from [127.0.0.1] ([48.214.53.115])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b627a79ce1sm405843085a.31.2025.12.05.07.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 07:02:26 -0800 (PST)
Message-Id: <pull.2009.v2.git.1764946945.gitgitgadget@gmail.com>
In-Reply-To: <pull.2009.git.1764440906.gitgitgadget@gmail.com>
References: <pull.2009.git.1764440906.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 05 Dec 2025 15:02:15 +0000
Subject: [PATCH v2 00/10] Prepare Git's test suite for symbolic link support on Windows
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
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2009%2Fdscho%2Fprepare-the-test-suite-for-symlink-support-on-windows-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2009/dscho/prepare-the-test-suite-for-symlink-support-on-windows-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2009

Range-diff vs v1:

  1:  2d329837e3 =  1:  2d329837e3 t9700: accommodate for Windows paths
  2:  b97afa9a5c =  2:  b97afa9a5c apply: symbolic links lack a "trustable executable bit"
  3:  96e279f50e =  3:  96e279f50e mingw: special-case `open(symlink, O_CREAT | O_EXCL)`
  4:  3be9594e80 !  4:  9639e04ac6 t0001: handle `diff --no-index` gracefully
     @@ Commit message
          file mode of 120000). That is totally unexpected by the test case, which
          as a consequence fails, meaning that it's a bug in the test case itself.
      
     +    Co-authored-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## t/t0001-init.sh ##
     @@ t/t0001-init.sh: test_expect_success SYMLINKS 're-init to move gitdir symlink' '
       	echo "gitdir: $(pwd)/realgitdir" >expected &&
      -	test_cmp expected newdir/.git &&
      +	case "$GIT_TEST_CMP" in
     -+	*--no-index*) ;; # git diff --no-index does not resolve symlinks
     ++	# `git diff --no-index` does not resolve symlinks
     ++	*--no-index*) cmp expected newdir/.git;;
      +	*) test_cmp expected newdir/.git;;
      +	esac &&
       	test_cmp expected newdir/here &&
  5:  c59a5f2478 =  5:  3db0599d91 t0301: another fix for Windows compatibility
  6:  0866db0a17 !  6:  f2da7d4d50 t0600: fix incomplete prerequisite for a test case
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
  7:  8a7c68b629 =  7:  ea74e678f9 t1006: accommodate for symlink support in MSYS2
  8:  930828c693 =  8:  1619ea4a3b t1305: skip symlink tests that do not apply to Windows
  9:  b622ff822c =  9:  807bb679cd t6423: introduce Windows-specific handling for symlinking to /dev/null
 10:  f7f1e91cef ! 10:  945306b5d4 t7800: work around the MSYS path conversion on Windows
     @@ Commit message
      
          One instance of this problem can be observed in the 'difftool --dir-diff
          handles modified symlinks' test case in `t7800-difftool.sh`, which
     -    assumes that that all absolute paths start with a forward slash. That
     +    assumes that all absolute paths start with a forward slash. That
          assumption is incorrect in general, e.g. on Windows, where absolute
          paths have many shapes and forms, none of which starts with a forward
          slash.

-- 
gitgitgadget
