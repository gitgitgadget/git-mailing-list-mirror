Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F68B1D014A
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 15:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882145; cv=none; b=LwE/YTjpBa19qMRdBkJYt9pHRBhjEUuoakd0x50IN103gnkMFVanRW8+64feaV/i+nBqyMKuFsPlBJtWRv1MxpeP/8zym+Lw+j3gsP+UUYjY66kY+4e9wYbdHuYLNqExQWBzUF3ycSf00waV+KLj4kpcZgTJDPAEMtdsDKcnotk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882145; c=relaxed/simple;
	bh=cDlL05L8lHlVpcdkErogB1Vc33vjBKlDRtAWktIUHAE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TYEPGzxFAv1e6jQEcV+NVc3npC/EANAu4X4KFedDFIVNVi54NYhR8Yo8lT/SJCHV4I2J9HqB2/o0ArYXHAcVDZ2UeAXMxssmfuvYZbL8GQYBw2UGkE2DcSLNOkiL9x/y1dZU/RK30JjJWu1j8qtjRY1hV8WJZf5qxHKpIGAtRt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=s+1489u2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RTn8unn9; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="s+1489u2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RTn8unn9"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 59DF91140111;
	Wed,  2 Oct 2024 11:15:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 02 Oct 2024 11:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1727882140; x=1727968540; bh=rK+eoJtbJTjMSyhi8yvJCiYAXC/lYZEy
	tHb2keOs0vM=; b=s+1489u2v+ZR8Sji16+UGZwaHLXDIzCCEi7Wp0cZeyYDmQh9
	YNU6rxo7gMvMvQSkcTX2vklGcKSDdN7YS6mfICsd4tHW+b+Y32ZUtmTH2R7MFtoJ
	mRXddCoC56H7Ktccm/hybHxeaPVZkK3TJRxhzi/9KFjNLcgxyrBUl8r43f7Rkd2F
	y/fszLBiPTbc8v9wOHZVnGjhEGCJk6xNLMshSMNvZtWBGBnLciqaP8ur8ftVjY0n
	Rk9urEF5fftQNrSIN8mWp0nyrRzdWE5b5du01aHe9vtJrISGv4jxpudGQ1x6dUO6
	bJPZiUPmkaiZB8I0H6Fqom06ZxgeEdG7o/KFbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1727882140; x=1727968540; bh=rK+eoJtbJTjMSyhi8yvJCiYAXC/lYZEytHb
	2keOs0vM=; b=RTn8unn9ntQ9ZGb9wNbo/y66NpkzrN/xnoartyjM68mJWLA2s/h
	M14m5WyPd0bi7eJK49RLM0jRaISOE/QX/9klnO6QTuxEv7yfvq4s7gCGb3nR/f4K
	LRcZuwxuASItfrzW6Ery/XzkKYgKdi3rCLimRy2JcT9o9E49x7mTnRrx6xVfchxB
	jy9QYKJGjMbcSAsG5yn0a4s6tQh3gSL4ue4p8hpEJbH0iYQ51CHtLfBl0Jdyrsjn
	eZtu1VGTwzE1n/nwXbMlz18hWVlkvnRRbqGyXGT7ZR7j2CnPXxYxzS/wWTZAQAHU
	FTcA9OrxqERTc6dD4zXINvey5JXTPRSokkA==
X-ME-Sender: <xms:m2P9Zt9WipTurD7AOYboM8gADk1TCARkrF6TRiwrYLkRpPOYo7_iAw>
    <xme:m2P9ZhtzfUiT_E6hmmPh5EG2ZsAiIQ9_EWWQBiNuZzEQxAbGSLzNa5NSXIzh9T1bg
    bzyI_H8_VieYoMSRg>
X-ME-Received: <xmr:m2P9ZrCcGBGjFqWnfcCOq25P1SF7k7EV0T8Kg1gGsDf-btdj3VusDGDuPzgUDuox_WJvCjwDjeev5E0Fa58d_p7f13r1vtZ8ZRQ5MZHEZkhbl9AW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkgggtugesthdtredttddtvdenucfh
    rhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqne
    cuggftrfgrthhtvghrnheptdetkeejffdvleeiteeiveeftefhfefgueehueeuveehkeef
    hfeiffejgfdvhfeinecuffhomhgrihhnpegtuddtqdhmvghsohhnrdgsuhhilhgunecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:nGP9ZhdDZLtvLAJr71KM7OOZD0Ka2T6svLi02gV2cGNnAwXx82L_HA>
    <xmx:nGP9ZiP_buUrxGMCF4xUbHkK5M8w0-EEWipNRv-RWBbhjGVWr_S-bg>
    <xmx:nGP9Zjmwpngyp5RB6cPcf8nOP6KHMry74Zrw8uPSafCHnE0JR8ZKAQ>
    <xmx:nGP9ZsvPdXYrehLjxdeuzo8GezfNEaS9rVSkFVzmHxWdMV_Do_wLQQ>
    <xmx:nGP9Zratn92VWWlw4GWw5YMdhWkZdtAKH-vw2fC7BYei4bYoARJ-xTBg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 11:15:39 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1fd035e2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 15:14:45 +0000 (UTC)
Date: Wed, 2 Oct 2024 17:15:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>
Subject: [RFC PATCH 00/21] Modernize the build system
Message-ID: <cover.1727881164.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

this patch series wires up support for the Meson build system. It is
intended as a request for comments and acts based on the feedback I've
got during the Git contributor's summit and the discussion in [1].

The aim of the patch series is to modernize our build system and set us
up such that we can eventually replace the autoconf- and Makefile-based
build system that we have right now with a more modern alternative. As a
result I'm hoping for the build system to become easier to hack on and
use, have better integration and be faster.

This patch series is rather large. It is structured as follows:

  - Patch 1 introduces a comparison of viable build systems. In its
    current form, the document is of course rather biased because I am
    its author. I am very happy to receive feedback on it to add factors
    that I didn't mention yet.

  - Patches 2 to 9 fix various different bugs I have found while working
    on many different platforms. They can likely go into the tree
    separately, and I'm happy to split these out into a separate patch
    series if we want to.

  - Patches 10 to 20 refactor parts of our preexisting build systems and
    testing infrastructure to provide better support for out-of-tree
    builds. While we already have CMake build instructions in our tree,
    they do not currently have "proper" out-of-tree builds as they still
    end up writing data into the source directory. So while these
    patches are written with Meson in mind, they should also help CMake.
    As a result of these patches, Meson builds and test runs are fully
    self-contained.

  - Patch 21 implements support for Meson. This is a big change, but
    more than half of the lines can be attributed to file listings. I
    have tested the build instructions on Linux, FreeBSD, macOS and
    Windows. Not all of the platforms pass all of the tests, and I did
    not yet get to integrating all of this with MSVC on Windows. Windows
    is quite foreign to me, and I spent the last two days ripping my
    hair out trying to get everything set up there, so this port is
    still a bit more on the rough side. In any case, if we decide that
    Meson might be a viable build system for us I will address those
    shortcomings, but in the RFC phase I didn't want perfect to be the
    enemy of good.

As I've said multiple times, I am strongly in favor of Meson over CMake,
and that's why I invested as much time as I did to wire it up this
extensively. But it goes without saying that this of course doesn't mean
that the project cannot come to a different conclusion than I did.

The patch series is built on top of e9356ba3ea (another batch after
2.47-rc0, 2024-09-30).

Thanks!

[1]: <GV1PR02MB848925A79A9DD733848182D58D662@GV1PR02MB8489.eurprd02.prod.outlook.com>

Patrick Steinhardt (21):
  Documentation: add comparison of build systems
  t/test-lib: fix quoting of TEST_RESULTS_SAN_FILE
  t/lib-gitweb: test against the build version of gitweb
  t/lib-gpg: fix setup of GNUPGHOME in MinGW
  t3404: work around platform-specific behaviour on macOS 10.15
  t/unit-tests: update clar unit test framework
  t/clar: simplify how the clar derives `struct stat`
  builtin/credential-cache: fix missing parameter for stub function
  http: fix build error on FreeBSD
  Makefile: extract script to generate clar declarations
  Makefile: extract script to massage Perl scripts
  Makefile: refactor GIT-VERSION-GEN to be reusable
  Makefile: refactor generators to be PWD-independent
  Makefile: use common template for GIT-BUILD-OPTIONS
  Makefile: consistently use @PLACEHOLDER@ to substitute
  Makefile: consistently use PERL_PATH
  Makefile: allow "bin-wrappers/" directory to exist
  Makefile: simplify building of templates
  t: better support for out-of-tree builds
  t: allow overriding build dir
  Introduce support for the Meson build system

 .gitignore                                    |    1 -
 Documentation/CodingGuidelines                |    2 +-
 Documentation/Makefile                        |    1 +
 Documentation/technical/build-systems.txt     |  164 ++
 GIT-BUILD-OPTIONS.in                          |   40 +
 GIT-VERSION-GEN                               |   12 +-
 Makefile                                      |  186 +-
 bin-wrappers/.gitignore                       |    9 +
 bin-wrappers/meson.build                      |   28 +
 bin-wrappers/wrap-for-bin.sh                  |   37 +
 builtin/credential-cache.c                    |    3 +-
 configure.ac                                  |    2 +-
 contrib/buildsystems/CMakeLists.txt           |  129 +-
 contrib/completion/meson.build                |    8 +
 contrib/meson.build                           |    1 +
 generate-cmdlist.sh                           |   42 +-
 generate-configlist.sh                        |   20 +-
 generate-hooklist.sh                          |   15 +-
 generate-perl.sh                              |   22 +
 git-cvsserver.perl                            |    2 +-
 git-instaweb.sh                               |    8 +-
 git-request-pull.sh                           |    2 +-
 git-send-email.perl                           |    2 +-
 git-sh-i18n.sh                                |    6 +-
 git-sh-setup.sh                               |    6 +-
 git-svn.perl                                  |    2 +-
 gitk-git/po/vi.po                             |    2 +-
 gitweb/Makefile                               |   44 +-
 gitweb/gitweb.perl                            |   44 +-
 gitweb/meson.build                            |   32 +
 gitweb/static/meson.build                     |   28 +
 http.c                                        |   10 +-
 meson.build                                   | 1567 +++++++++++++++++
 meson_options.txt                             |   67 +
 perl/FromCPAN/Mail/meson.build                |    7 +
 perl/FromCPAN/meson.build                     |    9 +
 perl/Git/I18N.pm                              |    6 +-
 perl/Git/LoadCPAN.pm                          |    6 +-
 perl/Git/LoadCPAN/Mail/meson.build            |    7 +
 perl/Git/LoadCPAN/meson.build                 |    9 +
 perl/Git/SVN/Memoize/meson.build              |    7 +
 perl/Git/SVN/meson.build                      |   20 +
 perl/Git/meson.build                          |   18 +
 .../header_templates/fixed_prefix.template.pl |    2 +-
 .../runtime_prefix.template.pl                |    8 +-
 perl/meson.build                              |   18 +
 po/meson.build                                |   28 +
 t/helper/meson.build                          |   91 +
 t/lib-gettext.sh                              |    4 +-
 t/lib-gitweb.sh                               |    2 +-
 t/lib-gpg.sh                                  |    2 +-
 t/meson.build                                 | 1107 ++++++++++++
 t/t3404-rebase-interactive.sh                 |   38 +-
 t/t7609-mergetool--lib.sh                     |    2 +-
 t/test-lib.sh                                 |   24 +-
 t/unit-tests/clar/.editorconfig               |   13 +
 t/unit-tests/clar/.github/workflows/ci.yml    |   20 +-
 t/unit-tests/clar/.gitignore                  |    1 +
 t/unit-tests/clar/CMakeLists.txt              |   28 +
 t/unit-tests/clar/clar.c                      |  111 +-
 t/unit-tests/clar/clar/print.h                |   11 +-
 t/unit-tests/clar/clar/sandbox.h              |   17 +-
 t/unit-tests/clar/clar/summary.h              |   14 +-
 t/unit-tests/clar/test/.gitignore             |    4 -
 t/unit-tests/clar/test/CMakeLists.txt         |   41 +
 t/unit-tests/clar/test/Makefile               |   39 -
 t/unit-tests/generate-clar-decls.sh           |   16 +
 templates/Makefile                            |   38 +-
 templates/branches--                          |    1 -
 templates/{this--description => description}  |    0
 .../applypatch-msg.sample}                    |    0
 .../commit-msg.sample}                        |    0
 .../fsmonitor-watchman.sample}                |    0
 templates/hooks/meson.build                   |   24 +
 .../post-update.sample}                       |    0
 .../pre-applypatch.sample}                    |    0
 .../pre-commit.sample}                        |    0
 .../pre-merge-commit.sample}                  |    0
 .../pre-push.sample}                          |    0
 .../pre-rebase.sample}                        |    0
 .../pre-receive.sample}                       |    0
 .../prepare-commit-msg.sample}                |    0
 .../push-to-checkout.sample}                  |    0
 .../sendemail-validate.sample}                |    0
 .../update.sample}                            |    0
 templates/{info--exclude => info/exclude}     |    0
 templates/info/meson.build                    |    5 +
 templates/meson.build                         |    8 +
 unimplemented.sh                              |    2 +-
 wrap-for-bin.sh                               |   36 -
 90 files changed, 3901 insertions(+), 487 deletions(-)
 create mode 100644 Documentation/technical/build-systems.txt
 create mode 100644 GIT-BUILD-OPTIONS.in
 create mode 100644 bin-wrappers/.gitignore
 create mode 100644 bin-wrappers/meson.build
 create mode 100755 bin-wrappers/wrap-for-bin.sh
 create mode 100644 contrib/completion/meson.build
 create mode 100644 contrib/meson.build
 create mode 100755 generate-perl.sh
 create mode 100644 gitweb/meson.build
 create mode 100644 gitweb/static/meson.build
 create mode 100644 meson.build
 create mode 100644 meson_options.txt
 create mode 100644 perl/FromCPAN/Mail/meson.build
 create mode 100644 perl/FromCPAN/meson.build
 create mode 100644 perl/Git/LoadCPAN/Mail/meson.build
 create mode 100644 perl/Git/LoadCPAN/meson.build
 create mode 100644 perl/Git/SVN/Memoize/meson.build
 create mode 100644 perl/Git/SVN/meson.build
 create mode 100644 perl/Git/meson.build
 create mode 100644 perl/meson.build
 create mode 100644 po/meson.build
 create mode 100644 t/helper/meson.build
 create mode 100644 t/meson.build
 create mode 100644 t/unit-tests/clar/.editorconfig
 create mode 100644 t/unit-tests/clar/.gitignore
 create mode 100644 t/unit-tests/clar/CMakeLists.txt
 delete mode 100644 t/unit-tests/clar/test/.gitignore
 create mode 100644 t/unit-tests/clar/test/CMakeLists.txt
 delete mode 100644 t/unit-tests/clar/test/Makefile
 create mode 100755 t/unit-tests/generate-clar-decls.sh
 delete mode 100644 templates/branches--
 rename templates/{this--description => description} (100%)
 rename templates/{hooks--applypatch-msg.sample => hooks/applypatch-msg.sample} (100%)
 rename templates/{hooks--commit-msg.sample => hooks/commit-msg.sample} (100%)
 rename templates/{hooks--fsmonitor-watchman.sample => hooks/fsmonitor-watchman.sample} (100%)
 create mode 100644 templates/hooks/meson.build
 rename templates/{hooks--post-update.sample => hooks/post-update.sample} (100%)
 rename templates/{hooks--pre-applypatch.sample => hooks/pre-applypatch.sample} (100%)
 rename templates/{hooks--pre-commit.sample => hooks/pre-commit.sample} (100%)
 rename templates/{hooks--pre-merge-commit.sample => hooks/pre-merge-commit.sample} (100%)
 rename templates/{hooks--pre-push.sample => hooks/pre-push.sample} (100%)
 rename templates/{hooks--pre-rebase.sample => hooks/pre-rebase.sample} (100%)
 rename templates/{hooks--pre-receive.sample => hooks/pre-receive.sample} (100%)
 rename templates/{hooks--prepare-commit-msg.sample => hooks/prepare-commit-msg.sample} (100%)
 rename templates/{hooks--push-to-checkout.sample => hooks/push-to-checkout.sample} (100%)
 rename templates/{hooks--sendemail-validate.sample => hooks/sendemail-validate.sample} (100%)
 rename templates/{hooks--update.sample => hooks/update.sample} (100%)
 rename templates/{info--exclude => info/exclude} (100%)
 create mode 100644 templates/info/meson.build
 create mode 100644 templates/meson.build
 delete mode 100644 wrap-for-bin.sh

-- 
2.47.0.rc0.dirty

