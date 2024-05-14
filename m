Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEA317F38E
	for <git@vger.kernel.org>; Tue, 14 May 2024 17:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715707067; cv=none; b=OKOib+5JfujEvmKFAokgs+AjtRPW8HaWS0DI5bYw+byRxidlpJrbQeebxG1xhwZnoPM9nM3yx+v/cjNAN2EarFF1XCAe7gk94C4eO58Db3o2fzbelgOrwvqJLe2s0esfS12SZYUCWve9KdWnIXLZu+69DcVXxbTeSAPh8n5YD18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715707067; c=relaxed/simple;
	bh=Z2D7BXXfjzRuQPt5D1il3Is/xQQ+jcsRg7jbWLw+C80=;
	h=Date:From:To:Subject:MIME-Version:Content-Type:Message-ID; b=cI2uAW3fnH6bvXRoY7Rd9zmBdZDF4WN+oL5P5nhcDUBe4UpQ2/zrvvoGgozlMHh93Ek/9LMY9u0wsq4KLt/DfmMC7OaBwn6WBcvMMzDj4fY0iZhS02TWRbjlgpVspxJkxrJOrVJLZyMB03CD+bKsGTgL83mXKy95WMggDlNOeaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=c6e3qUWK; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="c6e3qUWK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1715707062; x=1716311862;
	i=johannes.schindelin@gmx.de;
	bh=qik8Sc1Yl2BxvCHzPG3c6/72KxZEvQ29sew+3+cOHvY=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=c6e3qUWKVSi/XdU78wOA7duNKjVgkjonq4UkxI/Hnfhv4B6cKQzsC1hA6BulGM4a
	 OemVG+WooQBt5swpv8FFLWFxpfJ7L6ej4v4ROeK4P65YL/TDqCqAq9/Tj+hPVcNqa
	 INKTbX/fwmQw4ZTfJ+s8GSk0FeqM4iP7mEbCYltn/pSzMrUiiONqgo7/lJCIrLUAv
	 VKULgXvYO9dxQSmi5+F41ksTJHesbN3KGgzXtQm0s7GQEl8mzty9jEtZct6j5qyGm
	 N0uoDblsdB+89xQkLV/O8HORbOvrxIO/ovU7UWX/fjD0MAON1oEuo1V0iBwH4fGz3
	 wGnKjSBRu/z2f7zIKw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.216.58]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTABZ-1s0hSb1MCt-00UeAt; Tue, 14
 May 2024 19:17:42 +0200
Date: Tue, 14 May 2024 19:17:40 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git-for-windows@googlegroups.com, git@vger.kernel.org, 
    git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.45.1 (security bug-fix release)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <1Mxm3Q-1sVaAa1Xp8-00zG2E@mail.gmx.net>
X-Provags-ID: V03:K1:W2IcN6OhXBzrhY8CNxoQ65E6uPhi571Nf+FKnIXJez04qKmfy09
 PaUT9r2Gg+foS9k83F7cJRmwEt6MTvyUFB8WvBsaxM4mRpDjvELlY0OWFXiLmb1A4L/3tRD
 TL5iVsOpjdR4+gwqMsHqLxKQSUa7B8KLHWtvVuZbzUL53Tc7B3A45POxS1Xmppq4Pxx3To4
 lEwsIPpT+z4Zpr27AMzkA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:toOF4mH5nNs=;IGfkvXOjRKz1yUsW3gWa/4Dd1PU
 H2wmDgokn6AA9vKs1V8JNC8+iud6zcwX6/6o1p4G3zBwlI1/P/DixaYBk9XU+JJwTGbWJahD9
 lA+JEoyxpfA+MaDAfQCSOp7ie4ofsTRbRImKlywJklNjlDgNo/tlLnKfsp/v80ldXps6yNQDN
 3mFhJFYzquFXbxByUmBOfD0mjDQShUNevTHs2JvIP6GFLSg+JaEwAzP0GvR7ScJ0N6RzLWDQR
 i9wdWVYbYPhk0xok/zudw6SegurgvaGLm8UKwlJNOL1Ar+8fUrHOFIHpjmXKF4d9d+FEdb8/l
 duPL3YEE5dL3J/2VrRvdOnjiedxtSfPJzgLdvAU9mfeIwaZIEVVIkO/3h0N0JpIINTX1xCHLG
 1J4xZZXpa2i7IMRKWrRjvLV7KwAUsMYw8JelnNvWkoXAIRpVr/DSSNNRPt4232b3TCgzGAsU9
 sjsapCtzYYM1suq7r2v3uO7rb03nvkfYbnxHxyBRG1JWuCq6v5bjEB6U8CkBpxtq98+ouAoAZ
 R4FT6/bWcaJJpucIVnxqLeXTXiJEnKtY9m68qQnLOXHMKoPri6BxspCC2jOvGu8Q+H3D2GhXT
 x0W8JS7X/AwFMFSToojktNB2Gw51UoItgYtET014lbne8LjY1aszq299l2Zwu8lrY5aNgWK0U
 4YktSJO58p4iwz2Dn7bmUj6ZRu5Fmte0TgLx59sRl8H0hIO21oFF+CPYWj6DrsiS6kfPbHFcO
 PnvlQTkb9T+7esWJ4+l3jQFNWyi/AouHncGi4/qLUfwGqk72Xp6ygZwx9PA8cGEtyzPKoFbjc
 iqWXSGjC+1G7Z9aom+P2YMpPuVUrHjn2vo4jtd5gO8cTg=

Dear Git users,

I hereby announce that Git for Windows 2.45.1 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.45.0 (April 29th 2024):

Git for Windows for Windows v2.45 is the last version to support for
Windows 7 and for Windows 8, see MSYS2's corresponding deprecation
announcement (Git for Windows relies on MSYS2 for components such as
Bash and Perl).

Please also note that the 32-bit variant of Git for Windows is
deprecated; Its last official release is planned for 2025.

Note: the defense-in-depth protection in this update causes a regression
when cloning repositories enabled with Git LFS. The clone will fail with
an error message. The remedy is to call `git lfs pull` in the fresh clone.

New Features

  * Comes with Git v2.45.1.

Bug Fixes

  * CVE-2024-32002: Recursive clones on case-insensitive filesystems
    that support symbolic links are susceptible to case confusion that
    can be exploited to execute just-cloned code during the clone
    operation.
  * CVE-2024-32004: Repositories can be configured to execute arbitrary
    code during local clones. To address this, the ownership checks
    introduced in v2.30.3 are now extended to cover cloning local
    repositories.
  * CVE-2024-32020: Local clones may end up hardlinking files into the
    target repository's object database when source and target
    repository reside on the same disk. If the source repository is
    owned by a different user, then those hardlinked files may be
    rewritten at any point in time by the untrusted user.
  * CVE-2024-32021: When cloning a local source repository that
    contains symlinks via the filesystem, Git may create hardlinks to
    arbitrary user-readable files on the same filesystem as the target
    repository in the objects/ directory.
  * CVE-2024-32465: It is supposed to be safe to clone untrusted
    repositories, even those unpacked from zip archives or tarballs
    originating from untrusted sources, but Git can be tricked to run
    arbitrary code as part of the clone.
  * Defense-in-depth: submodule: require the submodule path to contain
    directories only.
  * Defense-in-depth: clone: when symbolic links collide with
    directories, keep the latter.
  * Defense-in-depth: clone: prevent hooks from running during a clone.
  * Defense-in-depth: core.hooksPath: add some protection while
    cloning.
  * Defense-in-depth: fsck: warn about symlink pointing inside a
    gitdir.
  * Various fix-ups on HTTP tests.
  * HTTP Header redaction code has been adjusted for a newer version of
    cURL library that shows its traces differently from earlier
    versions.
  * Fix was added to work around a regression in libcURL 8.7.0 (which
    has already been fixed in their tip of the tree).
  * Replace macos-12 used at GitHub CI with macos-13.
  * ci(linux-asan/linux-ubsan): let's save some time
  * Tests with LSan from time to time seem to emit harmless message
    that makes our tests unnecessarily flakey; we work it around by
    filtering the uninteresting output.
  * Update GitHub Actions jobs to avoid warnings against using
    deprecated version of Node.js.

Git-2.45.1-64-bit.exe | 1b2b58fb516495feb70353aa91da230be0a2b4aa01acc3bc047ee1fe4846bc4e
Git-2.45.1-32-bit.exe | f46c2f013b6767fc5da15783643d7243f037cbdf6e0b2779ad157ab0741318ca
PortableGit-2.45.1-64-bit.7z.exe | f4be1f923e9cc1ee0cb09e99f0e90cf254b530bb622d12064361563307e2f505
PortableGit-2.45.1-32-bit.7z.exe | 43d0f03af3d5a12a60cab82a02f386896ed2d61af93496fa8110f2dac83ebee1
MinGit-2.45.1-64-bit.zip | f7ba0e2acdc603cf8893b446f6871c869b7644b88a1116b00d6b30fb30f18c74
MinGit-2.45.1-32-bit.zip | 9c1089f13f5873190ac9473375126ba697df6773188f01ca2d6a0cf920c44287
MinGit-2.45.1-busybox-64-bit.zip | b9151e9ff31d4cbf0b45c5dad1d45e115c3942bdf3822cf0729efe54d42d909f
MinGit-2.45.1-busybox-32-bit.zip | 44c61ff4706c8db83009670bd6a67036f6ea5e0dc3c901bc1d37d7649879ece4
Git-2.45.1-64-bit.tar.bz2 | 3314914e47c080e80ddcbc543e374890bdfe4d60e9cd7d0faa996d3d0a174a05
Git-2.45.1-32-bit.tar.bz2 | e5d04b0228fda44f50f9d52730b72c2ad5773faebe12b54b009e3952f5b19f2b

Ciao,
Johannes
