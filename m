Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3838BE6C
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 06:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748846692; cv=none; b=Xv2piQamo40mzXM72lpl64ChUIYVwp+pFQtxQ1iV/2ouN7A48Gbqj9ID8ZnbvshYNnW8QHJU0OdU7B9BsZXZzpyxMl8PTEzsraXhfkM/rxuK5YzvlV+KVLyfrqrjuhgety4V1J7lqQ1f07oCxGrrMvjUsOqNpSenRXvcIeD/sDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748846692; c=relaxed/simple;
	bh=a3MyuACRdAo5oF43zso+uuSrsDLDVheUdaA/rvtYIGM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=eBfgjtE5j9OlfNfTUhcDThyY8aHt4VRQ2WegrBQPpmJ7OC7axSN8JDyBwbH0k4+ZFExKhhMOC/F9qrQ72ucWAbYNSWnazWgaoWIsEG4gKXsXgUB7vnxWnNNfrzxn/nc50dEdNfAnV4XMyMhLqMkmtJNriMLs1d0T0nO8OiYHeyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pGxLkCjo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HJ0CvqXm; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pGxLkCjo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HJ0CvqXm"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BE0EB25400B4;
	Mon,  2 Jun 2025 02:44:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 02 Jun 2025 02:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748846688;
	 x=1748933088; bh=S3wsCXkx2BiA1c+Ov18vBVRuaMB6oigHELjGHcRc16w=; b=
	pGxLkCjogt21b5begqBPkPT4Y7jPKaKKeF0E+jmtzuKgr25UyWjsPp2wp7XFTeMJ
	fXf5F55B3j2vxO3JhrInoKi7R/CzEYI79OzFydyf0fcmhQ4i8/RtW2DxD1PoGve5
	2IMzKzQu2NcN3Ki4KFLihowv12iVlAqDf2/ls6TMsaK44z/sYJoNYbgf6hq1U/oQ
	UT2b12yze4roIeL7XxmDvxpt17eYH4H8boR5oEt6Jun880AnkyTQlssINXsn4YVu
	vxoMJQ6GGJ3WQlvSElo/E3sXtUo52YoSRNvo3ElvsSWDmdYe6wN+psSEzZJshYbr
	hAWQErN3CIitBPtcReYw5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748846688; x=
	1748933088; bh=S3wsCXkx2BiA1c+Ov18vBVRuaMB6oigHELjGHcRc16w=; b=H
	J0CvqXmWOwbUVAwIndertmFFUkrFTibA1mBeC6SBgoUwsuLbEdFbisRdgFJcX2pk
	8KAUNBX1jSNAZOkJHxP52wfmmoy+A/1PHaZQUDoYFLz11ewVjnwTJhPWkV3J72Bu
	bcFfAhJwG4bdmzt30/RLuF7BgD6dYuczk2fGZrZ4Pzy3/YzxeYT3IkZaBb4SvS3a
	rJerS71569HEfukPhetKTA0r0tMA42/EFfiDWXOYEckrllCP4fQdkSzzRoevqTY0
	6q6sNqn6ClS67IQGMU97SD6PEFCieHTj0qUC4xh9nMbGGyU/Owscvumngx3ew2/R
	EQ/OHbDS1/IBTokwLpIxg==
X-ME-Sender: <xms:YEg9aIQN6rAZiEoGofekzjMSWQPTykfsCTuL9oVh0CyoWUXk4EeLig>
    <xme:YEg9aFx1ctEGWqkLbHn2xYAwIe2Hw-GMJ4o__OPkJ30Ck1JSGT7Ag4VRZrR5N2Uq8
    bWsEejIvKBr59hfNw>
X-ME-Received: <xmr:YEg9aF34XPN0aPyEZOfcACEcBJ_1AEWPzhJHJqOHf16esABfTbx0uvVMJlsMMRdpDYPF_Sh1PnyL5-HUSw0HJYQMiMi2aIIFVlRcGZI7PxfODA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefieelleculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfg
    jghfvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdeivdekjeekkeeu
    ffdttdehudeutddtjeehffdvfedtleffgefftdejteegfefhnecuffhomhgrihhnpehkvg
    hrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoh
    epkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohgu
    uddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjh
    honhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhm
    rghilhdrtghomhdprhgtphhtthhopehtmhiisehpohgsohigrdgtohhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhord
    horhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:YEg9aMC5WAZsh2PPZUtET0GHqQNw7zcxIk8oLm_IInOHHOq6Go1wKg>
    <xmx:YEg9aBhb7WPgKtFiLlnqCSXPWorpg4i7doj01_uEWVmLiNkiGsT6Ig>
    <xmx:YEg9aIr17RatNbqz961JeNa6Idl9G20qpvjb1V5vZX5z_tyLJDaxOQ>
    <xmx:YEg9aEgZwQdUFcksmTT8o5Ug4YkHTM97kvL-pvCagVPNjICG8Wvz0g>
    <xmx:YEg9aF3UcnM8VC3lPS8FxNmBVqwngg7PmPkgeHziDiD-KO3gxXZN-G0w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 02:44:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5fe2f697 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 2 Jun 2025 06:44:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 00/10] meson: parse TAP output generated by our tests
Date: Mon, 02 Jun 2025 08:44:40 +0200
Message-Id: <20250602-pks-meson-tap-v4-0-052dfde0818a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFlIPWgC/13Myw6CMBCF4VchXVvTTm/iyvcwLkYYpDFc0hKiI
 by7BRODLM9Mvn9ikYKnyM7ZxAKNPvquTUMfMlbU2D6I+zJtBgKM0JDz/hl5Q7Fr+YA9l0SlFRo
 FoGLJ9IEq/1p711vatY9DF95rfpTL9Vsywu5Ko+SCG0S8Q64BdXFJ/6Nv2JIZYUPB7SkkiqSsq
 JxzJ0t/VG2oEnuqErXOVoa0rID0j87z/AFy/HltHQEAAA==
X-Change-ID: 20250429-pks-meson-tap-1eed604a02a3
In-Reply-To: <20250506-pks-meson-tap-v1-0-5aaab2942a4c@pks.im>
References: <20250506-pks-meson-tap-v1-0-5aaab2942a4c@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Todd Zullinger <tmz@pobox.com>, 
 Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: b4 0.14.2

Hi,

this patch series starts to parse TAP output generated by our tests when
executing them via Meson. This has the benefit that Meson starts to
understand skipped tests and reports how many subtests have been
executed:

    ```
    $ meson test t002*
    ninja: Entering directory `/home/pks/Development/git/build'
     1/10 t0024-crlf-archive                  OK              0.17s   2 subtests passed
     2/10 t0022-crlf-rename                   OK              0.18s   2 subtests passed
     3/10 t0029-core-unsetenvvars             SKIP            0.15s
     4/10 t0023-crlf-am                       OK              0.18s   2 subtests passed
     5/10 t0025-crlf-renormalize              OK              0.21s   3 subtests passed
     6/10 t0026-eol-config                    OK              0.25s   5 subtests passed
     7/10 t0020-crlf                          OK              0.81s   36 subtests passed
     8/10 t0028-working-tree-encoding         OK              0.85s   22 subtests passed
     9/10 t0021-conversion                    OK              3.45s   38 subtests passed
    10/10 t0027-auto-crlf                     OK             26.35s   2600 subtests passed
    
    Ok:                9
    Fail:              0
    Skipped:           1
    ```

This new feature is only enabled with Meson 1.8 and newer, which
contains a bugfix that we have upstreamed [1] to make the TAP parser
work in `meson test --interactive` mode.

Despite the changes to Meson itself, this patch series also contains a
couple of fixes for our test suite that caused us to not generate proper
TAP output.

Changes in v2:
  - Add a patch to fix an unexpectedly passing test on macOS.
  - A couple more fixes for broken TAP output.
  - Link to v1: https://lore.kernel.org/r/20250506-pks-meson-tap-v1-0-5aaab2942a4c@pks.im

Changes in v3:
  - Split up the patch that silences output into multiple patches and
    rework them a bit.
  - Remove redirect that was retained by accident from an earlier
    version.
  - Slight rewording of a commit message.
  - Treat unexpected passes as failure in prove(1) and when executing
    the test directly.
  - Link to v2: https://lore.kernel.org/r/20250527-pks-meson-tap-v2-0-ae360f77786e@pks.im

Changes in v4:
  - Fix references to git-p4(1), which was mistyped as git-b4(1).
  - A couple of commit message improvements.
  - Avoid duplicate test names in t4041.
  - Link to v3: https://lore.kernel.org/r/20250530-pks-meson-tap-v3-0-676f5e41f2e4@pks.im

Thanks!

Patrick

[1]: https://github.com/mesonbuild/meson/pull/13980

---
Patrick Steinhardt (10):
      t: stop announcing prereqs
      t: silence output from `test_create_repo()`
      t9822: use prereq to check for ISO-8859-1 support
      t983*: use prereq to check for Python-specific git-p4(1) support
      t/test-lib: don't print shell traces to stdout
      t/test-lib: fix TAP format for BASH_XTRACEFD warning
      t7815: fix unexpectedly passing test on macOS
      test-lib: fail on unexpectedly passing tests
      meson: introduce kwargs variable for tests
      meson: parse TAP output generated by our tests

 contrib/credential/netrc/meson.build         |  2 +-
 contrib/subtree/meson.build                  |  2 +-
 meson.build                                  | 12 +++++++++
 t/meson.build                                |  6 ++---
 t/t0000-basic.sh                             | 39 +++++++++++++++-------------
 t/t0050-filesystem.sh                        | 30 +++++----------------
 t/t1007-hash-object.sh                       |  2 +-
 t/t3600-rm.sh                                |  5 ----
 t/t4000-diff-format.sh                       |  2 +-
 t/t4041-diff-submodule-option.sh             | 22 +++++++++-------
 t/t4060-diff-submodule-option-diff-format.sh |  9 ++++---
 t/t7401-submodule-summary.sh                 | 18 ++++++++-----
 t/t7815-grep-binary.sh                       |  2 +-
 t/t9500-gitweb-standalone-no-errors.sh       | 16 +++++-------
 t/t9822-git-p4-path-encoding.sh              | 13 +++++++---
 t/t9835-git-p4-metadata-encoding-python2.sh  | 24 +++++++++--------
 t/t9836-git-p4-metadata-encoding-python3.sh  | 24 +++++++++--------
 t/t9903-bash-prompt.sh                       |  4 ---
 t/test-lib.sh                                | 18 ++++++++++---
 19 files changed, 133 insertions(+), 117 deletions(-)

Range-diff versus v3:

 1:  0e9aac3c63f =  1:  05d16d9d7ac t: stop announcing prereqs
 2:  2c3bd12eb5d !  2:  ed6a8b205f0 t: silence output from `test_create_repo()`
    @@ t/t4041-diff-submodule-option.sh: test_expect_success 'typechanged submodule(sub
     -test_create_repo sm1 &&
     -head6=$(add_file sm1 foo6 foo7)
     -fullhead6=$(cd sm1; git rev-parse --verify HEAD)
    -+test_expect_success 'setup submodule' '
    ++test_expect_success 'setup submodule anew' '
     +	rm -f sm1 &&
     +	git init sm1 &&
     +	head6=$(add_file sm1 foo6 foo7) &&
 3:  c659a0ce551 =  3:  cf05118aeae t9822: use prereq to check for ISO-8859-1 support
 4:  e7141b15b56 !  4:  4d41989afe6 t983*: use prereq to check for Python-specific git-b4(1) support
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    t983*: use prereq to check for Python-specific git-b4(1) support
    +    t983*: use prereq to check for Python-specific git-p4(1) support
     
    -    The tests in t9835 and t9836 verify that git-b4(1) works with both
    +    The tests in t9835 and t9836 verify that git-p4(1) works with both
         Python 2 and 3, respectively. To determine whether we have those Python
         versions in the first place we create a wrapper script that directly
    -    executes the git-b4(1) script with `python2` or `python3` binaries. We
    +    executes the git-p4(1) script with `python2` or `python3` binaries. We
         then condition the execution of tests on whether that wrapper script can
         be executed successfully.
     
 5:  71b76db40e4 =  5:  b3f5f4e0d4d t/test-lib: don't print shell traces to stdout
 6:  b60daf5ac69 !  6:  78ab5b1d331 t/test-lib: fix TAP format for BASH_XTRACEFD warning
    @@ Commit message
         t/test-lib: fix TAP format for BASH_XTRACEFD warning
     
         When the Bash version is too old to support BASH_XTRACEFD we print a
    -    warning to stderr. This warning breaks the TAP format because it is not
    -    prefixed with a "#". Fix this.
    +    warning to stderr. This warning is not prefixed with "#", which causes
    +    TAP parsers to (wrongly) interpret the warning as part of the protocol.
    +
    +    Fix this issue by prefixing the warning with a "#" so that it is treated
    +    as comment.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
 7:  ce55bee9a12 !  7:  61b8b7640b7 t7815: fix unexpectedly passing test on macOS
    @@ Commit message
     
         The test passes if '.' matches a NUL byte, which we expect to only
         happen on Cygwin. The upcoming changes to support parsing TAP output in
    -    Meson surface that this test is also unexpectedly passing on macOS
    -    though.
    +    Meson surface that this test, surprisingly, passes on macOS as well.
     
         It is unclear how long the test has been passing on macOS already.
         064eed36c7f (config.mak.uname: only set NO_REGEX on cygwin for v1.7,
    -    2025-04-17) mentions that the test started to pass for Cygwin once it
    -    has imported a newer implementation of regcomp(3p) et all, which was
    +    2025-04-17) mentions that the test started to pass for Cygwin. This was
    +    attributed to a new implementation of regcomp(3p) and friends, which was
         inherited from FreeBSD. Given the BSD lineage of macOS it is feasible
         that it also inherited similar code eventually that made the test pass
         now.
    @@ Commit message
         same in this edge case and mark the new behaviour as expected.
     
         This change is outside of the scope of this patch series, which only
    -    introduce support for TAP. So instead of fixing the bigger issue, ignore
    -    the test on Darwin like we already do for Cygwin.
    +    introduces support for TAP. So instead of fixing the bigger issue,
    +    ignore the test on Darwin like we already do for Cygwin.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
 8:  80dcf1d5979 =  8:  02011b7017c test-lib: fail on unexpectedly passing tests
 9:  dca5730ab18 =  9:  540741acc80 meson: introduce kwargs variable for tests
10:  60393aa4af9 = 10:  8417d0ed94c meson: parse TAP output generated by our tests

---
base-commit: 845c48a16a7f7b2c44d8cb137b16a4a1f0140229
change-id: 20250429-pks-meson-tap-1eed604a02a3

