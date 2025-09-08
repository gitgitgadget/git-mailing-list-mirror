Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB27B2EBDF4
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 14:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757340151; cv=pass; b=grdZ2xSR3g04R7+oXKkxYVIo4yMswB+O7hlnfpvAM+aNt5APvzpVeitRcQo7x3Eq8vdA8EbBmodICFT0kid8VP8qhd7Nkg2LQrwqFeAHx5eJHpmC8Jv9QQfTNSJ6YEw5fEuAAg8j3EIHTyS6/38QcJauQIxoRqC7M8/g8pD32Qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757340151; c=relaxed/simple;
	bh=siIeJkg59ZZFrKPNM09ZizslBHBwilsX9ElHu41s3c0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CIlagbGfHHAfdmVbR82C0hcOTjgmCoynhXWrOvOXrOlf/9mWJRa2WRw1CsTL8sSPenOU/08+Q3qpdRbPO3ylLUfHzqHHtHCaWbL48TYGU6mdzqFDr6arbYN64jGlE1NhOoJhCjB14sDtZ41QJsomt1aftjc+hkpQyOfL0n2gcHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=K//oPufu; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="K//oPufu"
ARC-Seal: i=1; a=rsa-sha256; t=1757340117; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GdyI7CM9y++xXzx7Q6fHpInqkvTIu51xYUytaI9O4hl9TeG11NyCR597c6exM8ioMBv+im0Wo9Ucv5MZ/IAAFuqH+wlwq6I1QbjanrpdMpCaWrxoy183hzvv941X9NX42RcKYB7jRLT2GJnBmyi7fXWkmUSVh8GvBxykvpX+QnI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757340117; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ypRO40zqNY6iMC9ku8H8hUAFMn04y/HIsyIPZfPUOWM=; 
	b=mkSVw9n0yimlL9uFcJc6IJ/pA7Q6OFSatGsPVnFZWJtF15W5XE2k0A0fHQVyzPK+BgefYZE0BnIXuVOK1eEaWelr6P6WUFW7MPLoZV3e8Y6ID/+lpmmhNt6VPy8z3B++AtI21zuH8LFvAfaK29MdY23u2ypY4tXgnfKssGR+CMQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757340117;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ypRO40zqNY6iMC9ku8H8hUAFMn04y/HIsyIPZfPUOWM=;
	b=K//oPufu/S8tUZdhHol4uLWyNA2VjNJE5wX03MHN/VhzqrMGXzw0kVjqVG3upNZg
	ck4ywwcZgdAbW6bqyBffP630Y6NXjZ05VZMbVyw0ciUZWNAzKRBC+JVM4WZVneUfpK2
	o9q0O13a1qMWhwU/k/FoX8Rnh6vIEz52fBgbwXvo=
Received: by mx.zohomail.com with SMTPS id 1757340112449113.7249980416816;
	Mon, 8 Sep 2025 07:01:52 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v2 00/10] Encode submodule gitdir names to avoid conflicts
Date: Mon,  8 Sep 2025 17:01:07 +0300
Message-ID: <20250908140117.262205-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.GIT
In-Reply-To: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hello all,

This is v2 of the submodule encoding topic which fixes filesystem conflicts
due to plain-text module name clashes (nested dirs, case insensitive FS).

This is based on the master branch and I've merged and ensured all CI passes
with both next and seen branches, with all combinations (linux, win, osx, meson
makefile, etc).

Changes between v1 -> v2:
* Added test name prefixes to commits modifying tests (eg "t7454: modify ...")
* Fixed all GitHub CI failures, including Win+Linux+Mac for both make and meson
* Test branch names now use main, which also fixes linux-breaking-changes (Junio)
* Replaced seq with test_seq for portability (Junio)
* Moved submod_gitdir_path variable declaration inside if block (Josh)
* Clarify FS existence check inside lib-verify-submodule-gitdir-path.sh (Josh)
* Replaced (cd submod && git config) with test_config -C submod (Josh)
* Document the new submodule--helper gitdir path option (Josh)
* Replaced grep -> test_grep (Josh)
* Reworded commit messages to use the proper commit reference format (Ben)
* Removed claim this fixes the Windows reserved file names (Mark)
* Split NAME_MAX logic into separate commit & added compat stub for pathconf (Peff)

Many thanks to all who have reviewed v1.

Adrian Ratiu (10):
  submodule--helper: use submodule_name_to_gitdir in add_submodule
  submodule: create new gitdirs under submodules path
  submodule: add gitdir path config override
  t7425: add basic mixed submodule gitdir path tests
  strbuf: bring back is_rfc3986_unreserved
  submodule: encode gitdir paths to avoid conflicts
  submodule: error out if gitdir name is too long
  submodule: remove validate_submodule_git_dir()
  t7450: move nested gitdir tests to t7425
  t7425: add gitdir encoding tests

 Documentation/config/submodule.adoc        |   4 +
 Documentation/fetch-options.adoc           |   2 +-
 Documentation/git-fetch.adoc               |   2 +-
 Documentation/git-submodule.adoc           |   2 +-
 Documentation/gitsubmodules.adoc           |   8 +-
 Makefile                                   |   5 +
 builtin/credential-store.c                 |   6 -
 builtin/submodule--helper.c                |  51 +++---
 compat/pathconf.c                          |  10 +
 compat/posix.h                             |   8 +
 config.mak.uname                           |   2 +
 meson.build                                |   1 +
 setup.c                                    |   2 +-
 strbuf.c                                   |   6 +
 strbuf.h                                   |   2 +
 submodule.c                                | 162 ++++++++---------
 submodule.h                                |   5 -
 t/lib-submodule-update.sh                  |  50 ++---
 t/lib-verify-submodule-gitdir-path.sh      |  20 ++
 t/meson.build                              |   1 +
 t/t0035-safe-bare-repository.sh            |   4 +-
 t/t1600-index.sh                           |   4 +-
 t/t2405-worktree-submodule.sh              |   8 +-
 t/t2501-cwd-empty.sh                       |   2 +-
 t/t3600-rm.sh                              |   8 +-
 t/t5526-fetch-submodules.sh                |   2 +-
 t/t5619-clone-local-ambiguous-transport.sh |   4 +-
 t/t6120-describe.sh                        |   4 +-
 t/t7001-mv.sh                              |   4 +-
 t/t7400-submodule-basic.sh                 |  27 ++-
 t/t7406-submodule-update.sh                |  14 +-
 t/t7407-submodule-foreach.sh               |   6 +-
 t/t7408-submodule-reference.sh             |  22 +--
 t/t7412-submodule-absorbgitdirs.sh         |  22 +--
 t/t7423-submodule-symlinks.sh              |   8 +-
 t/t7425-submodule-mixed-gitdir-paths.sh    | 202 +++++++++++++++++++++
 t/t7450-bad-git-dotfiles.sh                |  73 +-------
 t/t7527-builtin-fsmonitor.sh               |   4 +-
 t/t9902-completion.sh                      |   1 +
 39 files changed, 481 insertions(+), 287 deletions(-)
 create mode 100644 compat/pathconf.c
 create mode 100644 t/lib-verify-submodule-gitdir-path.sh
 create mode 100755 t/t7425-submodule-mixed-gitdir-paths.sh

-- 
2.51.GIT

