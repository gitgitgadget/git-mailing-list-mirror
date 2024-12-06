Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32ABE20766E
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 13:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733491525; cv=none; b=LYmVzrhzplhLYip9LvYt269Kru5rot1Vnu0MvQ7mYyQ1HtL7qoXEp5tnXZqREARvXV3H8Om1/QWDl+lSSKD/AV5y2G6eYlqdFN+jIAtdX6QETxrndst+DOwIzvQxVpmgmTkMahSuyvC7XIQC5stdIZfxLQefrhKP63uR6WZ7ShE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733491525; c=relaxed/simple;
	bh=9ntivs/NmfrEXieRxnPOpIYzFz24xo5jUSLZ4SgPpBU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=iW1Mr7kQGqnXtM/eXmGsGk4sEzglrXHbyx4YDbDIgggfc22ULYl5r0wpMTMrual0Zn/9ZgRp0aIkoFFrJFYlZIn5UPJu+n27EEvfSmraU50aQHmbeV5OCWWFChPZIOqIOeigDozgIB7vgtxxkeKElOON/EGIDlG21Ex5QjCzXSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZWVaMXa1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=z/z3mxnQ; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZWVaMXa1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="z/z3mxnQ"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 090122540169;
	Fri,  6 Dec 2024 08:25:20 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 06 Dec 2024 08:25:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733491519;
	 x=1733577919; bh=aKBfeBiQl1U5j/bchnj7HCtY0Li3cxgIpX3ybgDioB8=; b=
	ZWVaMXa1AuhYnhVqh5NXNz63pRxK2mIeHU+UEh3pSK94R1igR+sRldh4QajqfuC2
	okyL8a6aM+RJCBOx9eZlOJahyuH8QtEIBK7bgQIGmVbA99xvw8XZ1S12K1jhDITC
	zc8NDhEmNfYC6/0CAyjCPlGYTjgyQQnRskMt1CPqbm7w+CVc058rAmts6aFcP3vy
	IcdPi389NG8v0zmfUbqjECixMANROVgCoatVgbhTBe1T+dn1IDeEKOxm4eokGZWJ
	vBTtW8v/gxuLVT4/18YGKp7s2blDYIrrpgbWPyLrykLC/2LCgu8gmv1yqH/xV0VF
	vi86xwulayJazK5pNwj9ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733491519; x=
	1733577919; bh=aKBfeBiQl1U5j/bchnj7HCtY0Li3cxgIpX3ybgDioB8=; b=z
	/z3mxnQVB/7x+QmJaIp87l7H1BSmYYd3Xb/cpjO5IvRcL087nq5maBlQQeVILfUV
	D0jd1eJRIgLBPPe0bVCvfFafvIJkuNqPGwdV23OW20pcHLQo5MXjkwZu1xBSNW5f
	buSYriCt642dA5+WFhP97ymBarIeTgCiByWyLrEBqMtGBrozqxmxHgjpl7tfCfE0
	HZydVYU2GaYEcTppBHPyilSrstJlObYq4Jj7s05Re68huJw193Uq67l17SuQctC9
	JEQZoAC3yLnphTs71f+82WTju2RGVP2zoG0dHFfBfyfsEosxgPidH/F4kH613I7H
	KfcWQXByXcW+XgX6FZEdg==
X-ME-Sender: <xms:PvtSZ8F1AqAhphdLC8_0cb2YgOm8E2dsD3zQ_QoAE6tSuZhRtUPNBQ>
    <xme:PvtSZ1WluYq0w2PI43ikH5N_qolBQvjvYyegsHaTvYISGpj0pd3xX2_mWRydYCCEo
    -uv96i0M4kG6pK86w>
X-ME-Received: <xmr:PvtSZ2IbUvP82k_M-P6PkYh4A8pSvEf4mfH2kHN51CCsau5806co6HBjamv_cassXIrwTh5e0zBgIX9CbcMS2S0AgE4LWmqPEYRD4wKMxQRqoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhufffkfggtgfgjghfvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveegffefgeetfedtveehudefudfgheefiefhfeetkeel
    hfefffekkeekffekfffgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdptghonhhfrd
    hinhdprhgsrdhinhdprhgtrdhinhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeduuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghm
    ihhlhidrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsuhhnshhhihhn
    vgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplh
    hushdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohep
    jheitheskhgusghgrdhorhhg
X-ME-Proxy: <xmx:PvtSZ-Egy93ZtnG4c4QmCzbDeMe6l6XtRsAj1b2OURTteDhDcebWRg>
    <xmx:PvtSZyXqtpidVBPtVNto6K3VHXCfynaxx77V3PwKns30gzmks_z9Xg>
    <xmx:PvtSZxOMQc0t_NQ1xAAmAuayIiA222oh9WFpjlKZTve8CKdu71y03g>
    <xmx:PvtSZ51H41ZuLgAPdDOutjws5ArQp10_xTmpnMoCGRBFT1mpek7YgQ>
    <xmx:P_tSZ5PJ7nfmq8aW3ILk1RdHFEt_VmU5ZsWlmdhkjnU7npRm5Sx9oqRP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 08:25:16 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id de84336f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Dec 2024 13:23:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v11 00/26] Modernize the build system
Date: Fri, 06 Dec 2024 14:24:35 +0100
Message-Id: <20241206-pks-meson-v11-0-525ed4792b88@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABP7UmcC/23SzU7EIBDA8VfZcLbNDJ+DJ9/DeCgIu8RsW8vaa
 Db77rLVGDA9Qv6/ISFzZTksKWT2eLiyJawpp2ksB8SHA/OnYTyGLr2WC8aBS0Tk3fyWu3PI09h
 Z5bRWHiiCZqWflxDT5zbs+aWcTylfpuVrm73i/Zb5aQ1Lj4YbIkQt+2O69HN+KkP7dGZ3tfK2J
 EkKhd0rRVtariQY2Cvlv9IY1KD2StWUAoVQVtBeqbdy519W3UGnJTkB1mripmGmZqpmpjBpgkf
 rDIHjDaOa2ZpRYQTWRRNB8igaZivGm9dsYei1j1zyQUVsGELtqHYIBRo7iOjAOzHoP3j72YElv
 H+UPbr8LsLt9g26DXCYZQIAAA==
X-Change-ID: 20241112-pks-meson-95b665c08f06
In-Reply-To: <cover.1727881164.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>, 
 David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>, 
 Johannes Sixt <j6t@kdbg.org>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Hi,

this patch series modernizes our build infrasturcture. It refactors
various parts of it to make it possible to perform out-of-tree builds in
theory.

The series then continues to wire up Meson as a proposed alternative as
a modern replacement for our current build systems. It provides better
integration into IDEs than our Makefiles, better usability than our
Makefiles and CMake, better configuration and discoverability thereof
than autoconf and CMake (which is of course my personal opinion).

The intent is to have Meson replace autoconf, which is mostly unused and
broken. Eventually, the plan is to also replace CMake and our Makefiles
in case we figure out that this replacement is indeed a net benefit for
the project, but all of this would happen over the course of multiple
releases.

Changes in v11:

  - The patch series is now based on e66fd72e97 (The fourteenth batch,
    2024-12-06) with junio/ps/reftable-detach at 988e7f5e95
    (reftable/system: provide thin wrapper for lockfile subsystem,
    2024-11-18) and junio/cw/worktree-extension at 2037ca85ad (worktree:
    refactor `repair_worktree_after_gitdir_move()`, 2024-11-29) merged
    into it. This is done to fix semantic merge conflicts.

  - Fix an issue on macOS where we started to pull in `libcharset` for
    `locale_charset()` instead of using `nl_langinfo()` provided by
    libc. This was discovered while wiring up a follow-up patch series
    that introduces Meson into our CI.

  - Introduce a couple of fallbacks so that we can compile with an older
    version of Meson. We now support Meson 0.64.0 and newer, where we
    only support 1.3.0 and newer before.

  - Adapt bin-wrappers such that we inject the full @PATH@. This was
    done to drop one usage of `fs.relative_to()`.

  - Drop the C standard option. We don't use it in our Makefile, either,

  - Massage Python scripts via a new `generate_python.sh` script. This
    makes both Meson and CMake replace the shebang correctly.

  - Link to v10: https://lore.kernel.org/r/20241128-pks-meson-v10-0-79a3fb0cb3a6@pks.im

As before, the tip of this patch series catches up with what is
happening in "seen" and should thus not be merged to "next". If you want
to test it without topics in "seen" you have to revert it.

Thanks!

Patrick

---
Patrick Steinhardt (26):
      Makefile: use common template for GIT-BUILD-OPTIONS
      Makefile: consistently use @PLACEHOLDER@ to substitute
      Makefile: refactor GIT-VERSION-GEN to be reusable
      Makefile: propagate Git version via generated header
      Makefile: generate "git.rc" via GIT-VERSION-GEN
      Makefile: generate doc versions via GIT-VERSION-GEN
      Makefile: consistently use PERL_PATH
      Makefile: extract script to massage Perl scripts
      Makefile: use "generate-perl.sh" to massage Perl library
      Makefile: extract script to massage Shell scripts
      Makefile: extract script to massage Python scripts
      Makefile: extract script to generate gitweb.cgi
      Makefile: extract script to generate gitweb.js
      Makefile: refactor generators to be PWD-independent
      Makefile: allow "bin-wrappers/" directory to exist
      Makefile: write absolute program path into bin-wrappers
      Makefile: simplify building of templates
      Documentation: allow sourcing generated includes from separate dir
      Documentation: teach "cmd-list.perl" about out-of-tree builds
      Documentation: extract script to generate a list of mergetools
      t: better support for out-of-tree builds
      t: allow overriding build dir
      Documentation: add comparison of build systems
      Introduce support for the Meson build system
      meson: fix conflicts with in-flight topics
      Revert "meson: fix conflicts with in-flight topics"

 .gitignore                                         |    3 +-
 Documentation/.gitignore                           |    2 +
 Documentation/CodingGuidelines                     |    2 +-
 Documentation/Makefile                             |   53 +-
 Documentation/{asciidoc.conf => asciidoc.conf.in}  |    3 +
 ...-extensions.rb => asciidoctor-extensions.rb.in} |    8 +-
 Documentation/build-docdep.perl                    |    2 +
 Documentation/cmd-list.perl                        |   23 +-
 Documentation/config/diff.txt                      |    2 +-
 Documentation/config/merge.txt                     |    2 +-
 Documentation/generate-mergetool-list.sh           |   17 +
 Documentation/git.txt                              |   24 +-
 Documentation/meson.build                          |  324 ++++
 Documentation/technical/build-systems.txt          |  224 +++
 GIT-BUILD-OPTIONS.in                               |   47 +
 GIT-VERSION-FILE.in                                |    1 +
 GIT-VERSION-GEN                                    |   74 +-
 Makefile                                           |  249 ++-
 bin-wrappers/.gitignore                            |    9 +
 bin-wrappers/meson.build                           |   28 +
 bin-wrappers/wrap-for-bin.sh                       |   37 +
 ci/test-documentation.sh                           |    2 +-
 configure.ac                                       |    2 +-
 contrib/buildsystems/CMakeLists.txt                |  302 ++--
 contrib/buildsystems/git-version.in                |    1 +
 contrib/completion/meson.build                     |   16 +
 contrib/meson.build                                |    1 +
 generate-cmdlist.sh                                |   42 +-
 generate-configlist.sh                             |   20 +-
 generate-hooklist.sh                               |   15 +-
 generate-perl.sh                                   |   37 +
 generate-python.sh                                 |   20 +
 generate-script.sh                                 |   34 +
 git-cvsserver.perl                                 |    2 +-
 git-instaweb.sh                                    |    8 +-
 git-request-pull.sh                                |    2 +-
 git-send-email.perl                                |    2 +-
 git-sh-i18n.sh                                     |    6 +-
 git-sh-setup.sh                                    |    6 +-
 git-svn.perl                                       |    2 +-
 git.rc => git.rc.in                                |    6 +-
 gitweb/GITWEB-BUILD-OPTIONS.in                     |   24 +
 gitweb/Makefile                                    |   62 +-
 gitweb/generate-gitweb-cgi.sh                      |   47 +
 gitweb/generate-gitweb-js.sh                       |   12 +
 gitweb/gitweb.perl                                 |   44 +-
 gitweb/meson.build                                 |   89 +
 meson.build                                        | 1901 ++++++++++++++++++++
 meson_options.txt                                  |   81 +
 perl/FromCPAN/Mail/meson.build                     |    7 +
 perl/FromCPAN/meson.build                          |    9 +
 perl/Git/I18N.pm                                   |    6 +-
 perl/Git/LoadCPAN.pm                               |    6 +-
 perl/Git/LoadCPAN/Mail/meson.build                 |    7 +
 perl/Git/LoadCPAN/meson.build                      |    9 +
 perl/Git/SVN/Memoize/meson.build                   |    7 +
 perl/Git/SVN/meson.build                           |   20 +
 perl/Git/meson.build                               |   18 +
 perl/header_templates/fixed_prefix.template.pl     |    2 +-
 perl/header_templates/runtime_prefix.template.pl   |    8 +-
 perl/meson.build                                   |   12 +
 po/meson.build                                     |   27 +
 subprojects/.gitignore                             |    1 +
 subprojects/curl.wrap                              |   13 +
 subprojects/expat.wrap                             |   13 +
 subprojects/openssl.wrap                           |   15 +
 subprojects/pcre2.wrap                             |   16 +
 subprojects/zlib.wrap                              |   13 +
 t/helper/meson.build                               |   91 +
 t/lib-gettext.sh                                   |    4 +-
 t/meson.build                                      | 1114 ++++++++++++
 t/t7609-mergetool--lib.sh                          |    2 +-
 t/test-lib.sh                                      |   31 +-
 templates/Makefile                                 |   39 +-
 templates/branches--                               |    1 -
 templates/{this--description => description}       |    0
 .../applypatch-msg.sample}                         |    0
 .../commit-msg.sample}                             |    0
 .../fsmonitor-watchman.sample}                     |    0
 templates/hooks/meson.build                        |   26 +
 .../post-update.sample}                            |    0
 .../pre-applypatch.sample}                         |    0
 .../pre-commit.sample}                             |    0
 .../pre-merge-commit.sample}                       |    0
 .../pre-push.sample}                               |    0
 .../pre-rebase.sample}                             |    0
 .../pre-receive.sample}                            |    0
 .../prepare-commit-msg.sample}                     |    0
 .../push-to-checkout.sample}                       |    0
 .../sendemail-validate.sample}                     |    0
 .../{hooks--update.sample => hooks/update.sample}  |    0
 templates/{info--exclude => info/exclude}          |    0
 templates/info/meson.build                         |    7 +
 templates/meson.build                              |   15 +
 unimplemented.sh                                   |    2 +-
 version-def.h.in                                   |    8 +
 version.c                                          |    1 +
 wrap-for-bin.sh                                    |   36 -
 98 files changed, 4995 insertions(+), 511 deletions(-)

Range-diff versus v10:

 1:  7a33c0685f =  1:  4d68af4c11 Makefile: use common template for GIT-BUILD-OPTIONS
 2:  ea7d458802 =  2:  7767a7aee1 Makefile: consistently use @PLACEHOLDER@ to substitute
 3:  b845f92c62 =  3:  03b526488e Makefile: refactor GIT-VERSION-GEN to be reusable
 4:  6db891f835 =  4:  6291479642 Makefile: propagate Git version via generated header
 5:  66865f3dd0 =  5:  39c4fbfd15 Makefile: generate "git.rc" via GIT-VERSION-GEN
 6:  d24acc74a7 !  6:  c5be33f77a Makefile: generate doc versions via GIT-VERSION-GEN
    @@ Documentation/Makefile: technical/api-index.txt: technical/api-index-skel.txt \
      	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) $*.txt
      
      SubmittingPatches.txt: SubmittingPatches
    +@@ Documentation/Makefile: $(patsubst %.txt,%.texi,$(MAN_TXT)): %.texi : %.xml
    + howto-index.txt: howto-index.sh $(HOWTO_TXT)
    + 	$(QUIET_GEN)'$(SHELL_PATH_SQ)' ./howto-index.sh $(sort $(HOWTO_TXT)) >$@
    + 
    +-$(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt
    ++$(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt $(ASCIIDOC_DEPS)
    + 	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) $*.txt
    + 
    + WEBDOC_DEST = /pub/software/scm/git/docs
    + 
    + howto/%.html: ASCIIDOC_EXTRA += -a git-relative-html-prefix=../
    +-$(patsubst %.txt,%.html,$(HOWTO_TXT)): %.html : %.txt GIT-ASCIIDOCFLAGS
    ++$(patsubst %.txt,%.html,$(HOWTO_TXT)): %.html : %.txt $(ASCIIDOC_DEPS)
    + 	$(QUIET_ASCIIDOC) \
    + 	sed -e '1,/^$$/d' $< | \
    + 	$(TXT_TO_HTML) - >$@
     
      ## Documentation/asciidoc.conf => Documentation/asciidoc.conf.in ##
     @@ Documentation/asciidoc.conf.in: tilde=&#126;
 7:  cbac1c334a =  7:  4f785adbfa Makefile: consistently use PERL_PATH
 8:  055831a146 =  8:  79b087821a Makefile: extract script to massage Perl scripts
 9:  d8b0047981 =  9:  7c93d8d2fe Makefile: use "generate-perl.sh" to massage Perl library
10:  5d9e5ed89f = 10:  17e203b4ee Makefile: extract script to massage Shell scripts
 -:  ---------- > 11:  52b294f78d Makefile: extract script to massage Python scripts
11:  6eed6d43c1 = 12:  e14816f6d1 Makefile: extract script to generate gitweb.cgi
12:  6cedddb117 = 13:  0ad32eeb2a Makefile: extract script to generate gitweb.js
13:  7eb985e35d = 14:  df5ea3f507 Makefile: refactor generators to be PWD-independent
14:  5153718ee1 = 15:  d54dd05a74 Makefile: allow "bin-wrappers/" directory to exist
 -:  ---------- > 16:  486b781ed6 Makefile: write absolute program path into bin-wrappers
15:  978d732272 ! 17:  2cdc2917a8 Makefile: simplify building of templates
    @@ contrib/buildsystems/CMakeLists.txt: elseif(UNIX)
      
      list(TRANSFORM git_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
      add_executable(git ${CMAKE_SOURCE_DIR}/git.c ${git_SOURCES})
    -@@ contrib/buildsystems/CMakeLists.txt: file(STRINGS ${CMAKE_SOURCE_DIR}/git-p4.py content NEWLINE_CONSUME)
    - string(REPLACE "#!/usr/bin/env python" "#!/usr/bin/python" content "${content}")
    - file(WRITE ${CMAKE_BINARY_DIR}/git-p4 ${content})
    +@@ contrib/buildsystems/CMakeLists.txt: add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/git-p4"
    + 	VERBATIM)
    + add_custom_target(python-gen ALL DEPENDS "${CMAKE_BINARY_DIR}/git-p4")
      
     -#templates
     -file(GLOB templates "${CMAKE_SOURCE_DIR}/templates/*")
16:  c6638309d5 ! 18:  cce9066332 Documentation: allow sourcing generated includes from separate dir
    @@ Documentation/build-docdep.perl
      	}
     
      ## Documentation/config/diff.txt ##
    -@@ Documentation/config/diff.txt: diff.<driver>.cachetextconv::
    - 	Set this option to true to make the diff driver cache the text
    +@@ Documentation/config/diff.txt: endif::git-diff[]
    + 	Set this option to `true` to make the diff driver cache the text
      	conversion outputs.  See linkgit:gitattributes[5] for details.
      
     -include::../mergetools-diff.txt[]
     +include::{build_dir}/mergetools-diff.txt[]
      
    - diff.indentHeuristic::
    + `diff.indentHeuristic`::
      	Set this option to `false` to disable the default heuristics
     
      ## Documentation/config/merge.txt ##
17:  2fe7d3df33 = 19:  36007aaec7 Documentation: teach "cmd-list.perl" about out-of-tree builds
18:  b2a334716c = 20:  7e1188316f Documentation: extract script to generate a list of mergetools
19:  77b1d45cf5 ! 21:  3ae68bfcb6 t: better support for out-of-tree builds
    @@ Makefile: all:: $(TEST_PROGRAMS) $(test_bindir_programs) $(UNIT_TEST_PROGS) $(CL
     +	     -e 's|@GITPERLLIB@|$(shell pwd)/perl/build/lib|' \
     +	     -e 's|@MERGE_TOOLS_DIR@|$(shell pwd)/mergetools|' \
     +	     -e 's|@TEMPLATE_DIR@|$(shell pwd)/templates/blt|' \
    - 	     -e 's|@PROG@|$(patsubst test-%,t/helper/test-%,$(@F))$(if $(filter-out $(BINDIR_PROGRAMS_NO_X),$(@F)),$(X),)|' < $< > $@ && \
    + 	     -e 's|@PROG@|$(shell pwd)/$(patsubst test-%,t/helper/test-%,$(@F))$(if $(filter-out $(BINDIR_PROGRAMS_NO_X),$(@F)),$(X),)|' < $< > $@ && \
      	chmod +x $@
      
     
    @@ contrib/buildsystems/CMakeLists.txt: endforeach()
     +string(REPLACE "@GIT_TEXTDOMAINDIR@" "${CMAKE_BINARY_DIR}/po/build/locale" content "${content}")
     +string(REPLACE "@GITPERLLIB@" "${CMAKE_BINARY_DIR}/perl/build/lib" content "${content}")
     +string(REPLACE "@MERGE_TOOLS_DIR@" "${CMAKE_SOURCE_DIR}/mergetools" content "${content}")
    - string(REPLACE "@PROG@" "git-cvsserver" content "${content}")
    + string(REPLACE "@PROG@" "${CMAKE_BINARY_DIR}/git-cvsserver" content "${content}")
      file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/git-cvsserver ${content})
      
     @@ contrib/buildsystems/CMakeLists.txt: string(REPLACE "@GIT_PERF_MAKE_COMMAND@" "" git_build_options "${git_build_optio
    @@ t/lib-gettext.sh
      if test -n "$GIT_TEST_INSTALLED"
     
      ## t/t7609-mergetool--lib.sh ##
    -@@ t/t7609-mergetool--lib.sh: TEST_PASSES_SANITIZE_LEAK=true
    +@@ t/t7609-mergetool--lib.sh: Testing basic merge tools options'
      . ./test-lib.sh
      
      test_expect_success 'mergetool --tool=vimdiff creates the expected layout' '
20:  9de1c8c8e7 = 22:  98db2ae158 t: allow overriding build dir
21:  d0374d6d52 = 23:  78919a351a Documentation: add comparison of build systems
22:  77529b002c ! 24:  934594206e Introduce support for the Meson build system
    @@ bin-wrappers/meson.build (new)
     +foreach executable : bin_wrappers
     +  executable_config = configuration_data()
     +  executable_config.merge_from(bin_wrappers_config)
    -+  executable_config.set('PROG', fs.relative_to(executable.full_path(), meson.project_build_root()))
    ++  executable_config.set('PROG', executable.full_path())
     +
     +  configure_file(
     +    input: 'wrap-for-bin.sh',
    @@ contrib/completion/meson.build (new)
     +  'git-completion.zsh',
     +  'git-prompt.sh'
     +]
    -+  test_dependencies += fs.copyfile(script)
    ++  if meson.version().version_compare('>=1.3.0')
    ++    test_dependencies += fs.copyfile(script)
    ++  else
    ++    configure_file(
    ++      input: script,
    ++      output: script,
    ++      copy: true,
    ++    )
    ++  endif
     +endforeach
     
      ## contrib/meson.build (new) ##
    @@ gitweb/meson.build (new)
     +  'static/git-logo.png',
     +  'static/gitweb.css',
     +]
    -+  fs.copyfile(asset,
    -+    install: true,
    -+    install_dir: get_option('datadir') / 'gitweb' / fs.parent(asset),
    -+  )
    ++  if meson.version().version_compare('>=1.3.0')
    ++    fs.copyfile(asset,
    ++      install: true,
    ++      install_dir: get_option('datadir') / 'gitweb' / fs.parent(asset),
    ++    )
    ++  else
    ++    configure_file(
    ++      input: asset,
    ++      output: fs.stem(asset),
    ++      copy: true,
    ++      install: true,
    ++      install_dir: get_option('datadir') / 'gitweb' / fs.parent(asset),
    ++    )
    ++  endif
     +endforeach
     
      ## meson.build (new) ##
    @@ meson.build (new)
     +# with the `--wrap-mode nofallback` option.
     +
     +project('git', 'c',
    -+  meson_version: '>=1.3.0',
    -+  # MSVC does not support GNU99, and C99 does not define __STDC_VERSION__
    -+  # on MSVC. So we instead fall back to C11 there.
    -+  default_options: ['c_std=gnu99,c11'],
    ++  meson_version: '>=0.61.0',
     +  version: 'v2.47.GIT',
     +)
     +
    @@ meson.build (new)
     +  'reftable/reader.c',
     +  'reftable/record.c',
     +  'reftable/stack.c',
    ++  'reftable/system.c',
     +  'reftable/tree.c',
     +  'reftable/writer.c',
     +  'remote.c',
    @@ meson.build (new)
     +  libgit_dependencies += intl
     +  build_options_config.set('NO_GETTEXT', '')
     +  build_options_config.set('USE_GETTEXT_SCHEME', '')
    ++
    ++  # POSIX nowadays requires `nl_langinfo()`, but some systems still don't have
    ++  # the function available. On such systems we instead fall back to libcharset.
    ++  # On native Windows systems we use our own emulation.
    ++  if host_machine.system() != 'windows' and not compiler.has_function('nl_langinfo')
    ++    libcharset = compiler.find_library('charset', required: true)
    ++    libgit_dependencies += libcharset
    ++    libgit_c_args += '-DHAVE_LIBCHARSET_H'
    ++  endif
     +else
     +  libgit_c_args += '-DNO_GETTEXT'
     +  build_options_config.set('NO_GETTEXT', '1')
    @@ meson.build (new)
     +  libgit_c_args += '-DNO_INTTYPES_H'
     +endif
     +
    -+if compiler.has_header('libcharset.h')
    -+  libcharset = compiler.find_library('charset')
    -+
    -+  if compiler.has_function('locale_charset',
    -+    prefix: '#include <libcharset.h>',
    -+    dependencies: iconv,
    -+  )
    -+    libgit_c_args += '-DHAVE_LIBCHARSET_H'
    -+  elif compiler.has_function('locale_charset',
    -+    prefix: '#include <libcharset.h>',
    -+    dependencies: libcharset,
    -+  )
    -+    libgit_c_args += '-DHAVE_LIBCHARSET_H'
    -+  endif
    -+endif
    -+
     +if compiler.has_header('alloca.h')
     +  libgit_c_args += '-DHAVE_ALLOCA_H'
     +endif
    @@ meson.build (new)
     +
     +  install_symlink(alias + executable_suffix,
     +    install_dir: get_option('libexecdir') / 'git-core',
    -+    pointing_to: 'git-remote-http',
    ++    pointing_to: 'git',
     +  )
     +endforeach
     +
    @@ meson.build (new)
     +  'git-upload-pack',
     +  'scalar',
     +]
    ++  if meson.version().version_compare('>=1.3.0')
    ++    pointing_to = fs.relative_to(get_option('libexecdir') / 'git-core' / symlink, get_option('bindir'))
    ++  else
    ++    pointing_to = '../libexec/git-core' / symlink
    ++  endif
    ++
     +  install_symlink(symlink,
     +    install_dir: get_option('bindir'),
    -+    pointing_to: fs.relative_to(get_option('libexecdir') / 'git-core' / symlink, get_option('bindir')),
    ++    pointing_to: pointing_to,
     +  )
     +endforeach
     +
    @@ meson.build (new)
     +    if script == 'git-cvsserver.perl'
     +      bin_wrappers += generated_script
     +
    ++      if meson.version().version_compare('>=1.3.0')
    ++        pointing_to = fs.relative_to(get_option('libexecdir') / 'git-core' / fs.stem(script), get_option('bindir'))
    ++      else
    ++        pointing_to = '../libexec/git-core' / fs.stem(script)
    ++      endif
    ++
     +      install_symlink(fs.stem(script),
     +        install_dir: get_option('bindir'),
    -+        pointing_to: fs.relative_to(get_option('libexecdir') / 'git-core' / fs.stem(script), get_option('bindir')),
    ++        pointing_to: pointing_to,
     +      )
     +    endif
     +  endforeach
    @@ meson.build (new)
     +  ]
     +
     +  foreach script : scripts_python
    -+    fs.copyfile(script, fs.stem(script),
    ++    generated_python = custom_target(
    ++      input: script,
    ++      output: fs.stem(script),
    ++      command: [
    ++        shell,
    ++        meson.project_source_root() / 'generate-python.sh',
    ++        meson.project_build_root() / 'GIT-BUILD-OPTIONS',
    ++        '@INPUT@',
    ++        '@OUTPUT@',
    ++      ],
     +      install: true,
     +      install_dir: get_option('libexecdir') / 'git-core',
     +    )
    ++    test_dependencies += generated_python
     +  endforeach
     +endif
     +
    @@ t/meson.build (new)
     +  't2405-worktree-submodule.sh',
     +  't2406-worktree-repair.sh',
     +  't2407-worktree-heads.sh',
    -+  't2408-worktree-relative.sh',
     +  't2500-untracked-overwriting.sh',
     +  't2501-cwd-empty.sh',
     +  't3000-ls-files-others.sh',
    @@ templates/hooks/meson.build (new)
     +    output: hook,
     +    configuration: template_config,
     +    install: true,
    -+    install_dir: get_option('datadir') / 'git-core/templates',
    ++    install_dir: get_option('datadir') / 'git-core/templates/hooks',
     +  )
     +endforeach
     
    @@ templates/info/meson.build (new)
     +  output: 'exclude',
     +  configuration: template_config,
     +  install: true,
    -+  install_dir: get_option('datadir') / 'git-core/templates',
    ++  install_dir: get_option('datadir') / 'git-core/templates/info',
     +)
     
      ## templates/meson.build (new) ##
23:  3fc4c85635 ! 25:  f5e9b17ebc meson: fix conflicts with in-flight topics
    @@ Commit message
           - ds/path-walk-1 adds t6601 as well as "path-walk.c" and
             "test-path-walk.c".
     
    -      - ps/reftable-detach adds "reftable/system.c".
    -
           - js/libgit-rust adds "common-exit.c" and "common-init.c".
     
    -      - ds/full-name-hash adds "t/helper/test-name-hash.c".
    -
    -      - cw/worktree-extension deletes t2408.
    +      - ds/name-hash-tweaks adds "t/helper/test-name-hash.c".
     
         This is somewhat painful in the current state where Meson is not yet
         part of the main tree, but we'll have to live with that for the time
    @@ meson.build: libgit_sources = [
        'path.c',
        'pathspec.c',
        'pkt-line.c',
    -@@ meson.build: libgit_sources = [
    -   'reftable/reader.c',
    -   'reftable/record.c',
    -   'reftable/stack.c',
    -+  'reftable/system.c',
    -   'reftable/tree.c',
    -   'reftable/writer.c',
    -   'remote.c',
    -@@ meson.build: foreach alias : [ 'git-receive-pack', 'git-upload-archive', 'git-upload-pack' ]
    - 
    -   install_symlink(alias + executable_suffix,
    -     install_dir: get_option('libexecdir') / 'git-core',
    --    pointing_to: 'git-remote-http',
    -+    pointing_to: 'git',
    -   )
    - endforeach
    - 
     
      ## t/helper/meson.build ##
     @@ t/helper/meson.build: test_tool_sources = [
    @@ t/meson.build: integration_tests = [
        't1020-subdirectory.sh',
        't1021-rerere-in-workdir.sh',
        't1022-read-tree-partial-clone.sh',
    -@@ t/meson.build: integration_tests = [
    -   't2405-worktree-submodule.sh',
    -   't2406-worktree-repair.sh',
    -   't2407-worktree-heads.sh',
    --  't2408-worktree-relative.sh',
    -   't2500-untracked-overwriting.sh',
    -   't2501-cwd-empty.sh',
    -   't3000-ls-files-others.sh',
     @@ t/meson.build: integration_tests = [
        't6500-gc.sh',
        't6501-freshen-objects.sh',
    @@ t/meson.build: integration_tests = [
        't6700-tree-depth.sh',
        't7001-mv.sh',
        't7002-mv-sparse-checkout.sh',
    -
    - ## templates/hooks/meson.build ##
    -@@ templates/hooks/meson.build: foreach hook : hooks
    -     output: hook,
    -     configuration: template_config,
    -     install: true,
    --    install_dir: get_option('datadir') / 'git-core/templates',
    -+    install_dir: get_option('datadir') / 'git-core/templates/hooks',
    -   )
    - endforeach
    -
    - ## templates/info/meson.build ##
    -@@ templates/info/meson.build: configure_file(
    -   output: 'exclude',
    -   configuration: template_config,
    -   install: true,
    --  install_dir: get_option('datadir') / 'git-core/templates',
    -+  install_dir: get_option('datadir') / 'git-core/templates/info',
    - )
 -:  ---------- > 26:  c03e0c8c98 Revert "meson: fix conflicts with in-flight topics"

---
base-commit: ca19fa60fe4a7f23d7b8303f68ca82d19839f287
change-id: 20241112-pks-meson-95b665c08f06

