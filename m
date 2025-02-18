Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056401D5AD8
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 07:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739864770; cv=none; b=mrm3PJ5nrZ6qpzpLvhziLszr8FbqpB2Rv8+R5fR2bOR1oaWH/jhARUSqrE1EV7T4+SD0TUw2NAjg0zHBziaK5fhZ9jP6UFfqJ+sbzqr6tMYgP/YwsjyYP0m7lPIBffgbN8llRuMc3oijR9t6jGwVj4IYz7gYRjNkCM1uSxBSzuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739864770; c=relaxed/simple;
	bh=iWZqjK283cUk1D1PynhkY2hxXTJbJrNqsV0uSn0KWhk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mLsxnuqFkFWvBcrZ3jPe7wpdAN4qTUBiNSlw3RYWJ+jvdI77g6TAuEY6DOXiIRKpjuSkWUKG3pKnUTc5zZjpf+6g7oXoYm4AFNsuCUoq0s0al0oLTyRlmCnEtVqhpyXgYt/HXgYaYNPQ9VQExp9OSc8bPhu0MLCrWJfP51FJcis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iU2Qp9gO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c6pdgpXP; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iU2Qp9gO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c6pdgpXP"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CB58D1140254;
	Tue, 18 Feb 2025 02:46:06 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 18 Feb 2025 02:46:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1739864766; x=1739951166; bh=Ghn22WZX72
	QCtSJAcIjNMXS3B5B9BbktdXGr5PfT5RY=; b=iU2Qp9gO5I2T4Qbc4P0rf4NhAi
	NItQMaS4eSurpxiSDnbaJNtMv8/OqiiVCfdjD+T8A/W4BgMNNPEqSF9UOPG08u0I
	41hWfB1/CO8b2sv0kH+Iu0itc9t3iYIYZlQdUhY9+U7lD1oVXVDFW2RtzW7cXuC4
	SUhmsZt9j2vvSIkxxY+30pkCK4odqVurxVk6Q4l5pfxLe6fL9mrf7BdiHI1obqMC
	nN9KnnJ0/sznn+gdR8JWnQhsP+23IZTnNHFxGcvNPi8nZq5PhIOS0LLi5+i+SNeF
	qrqzkP17DLQh752nutCDLdM8mjxUKukFFiRmsmG7GNBeN9RbXomxZMUoZ2ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1739864766; x=1739951166; bh=Ghn22WZX72QCtSJAcIjNMXS3B5B9
	BbktdXGr5PfT5RY=; b=c6pdgpXPu2KhKhytH02r2N0git0zp8HnghzkexM1XhPm
	TRjRHLgvN1jMOOlDeWyeVLbZcCmP+Iv/aeFj7OyTHvMVlw/nj1NGJJummd5ciE3v
	fcFYacDlqO1xufafpvlsqSuoJEhvV4gzjcxfQGwEuRG5EKR5wf4V1drXYECpZiUn
	waGGwEF99h0nYDN9ttqaxJkLRDYCoSp+A0xmEbxYUycyENfrkKXcmj1urI0HpkFC
	Dac1U9ZAEcdfblARQR/4KXwwPRdY3zPVeOBalMA0B6PYq6m+AMge7F7vBFkAQ8L1
	UZqFY17sKiMM04ucCdbNFbZnSHR9sVafhGDhIDABzA==
X-ME-Sender: <xms:vjq0Z0lODf9HQei9jnBI5Lz5zu9Xg0eRxFi8ErETPlsNq2kzSTQxsA>
    <xme:vjq0Zz0HQk5fjpWvtOkQBX-qgTI3DDjWb3khpV8PEtWmxy07zfWNPydxuodkouQXa
    y0nWoLSK-S5dRSljw>
X-ME-Received: <xmr:vjq0Zyo7Oi6sGBja2qLrcv78JwkX0JhCiPEYrjKQZvjwL_lTwtAhyddJLakSGaG4_XnAGOvRf0xa2_bshlIKaWrBL0H1LKkHFEfV25JsSx-w4fMy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdejfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveeugeektdetieegjeeuheeuudfgveelfeevheeuhefg
    teffffevhfeuhfeukeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehmihhrthhhrdhhihgtkhhfohhrugesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:vjq0ZwlZjjsai2ru2TNVCG7pOVOERdhXWk60dOz1eEvrfS8wmzxlIA>
    <xmx:vjq0Zy3DKV5BrCi8O_7k7jIB6x7AzO7p-fu3heA7Abij1Ln6LDCr7g>
    <xmx:vjq0Z3skhRHZREp1VAJhnI4mjonow3BKfBwEyGTwglhpZjWrQdZP7Q>
    <xmx:vjq0Z-WbeNIk7bWFiN_11P_JTxHNr1qOFgEKjTsNVSL1phkqDbPwZA>
    <xmx:vjq0ZwAp5_jceY4ANYl3OVf95VszcLWioT1kiZxESVaB-lBu33GS9MZa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 02:46:05 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dcae1912 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Feb 2025 07:46:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/12] meson: wire up bits and pieces from "contrib/"
Date: Tue, 18 Feb 2025 08:45:48 +0100
Message-Id: <20250218-b4-pks-meson-contrib-v1-0-c3edd292beb8@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKw6tGcC/x3MQQqEMAxA0atI1gYy1co4VxEX1kYNg600IoJ4d
 4vLt/j/AuUkrPArLkh8iEoMGZ+ygHEZwswoPhsMGUuGGnQ1bn/FlTUGHGPYkzi0vnXVYD19K4K
 cboknOd9t19/3A6xW9RhmAAAA
X-Change-ID: 20250206-b4-pks-meson-contrib-5d9b3a5d0830
To: git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>
X-Mailer: b4 0.14.2

Hi,

this patch series wires up a couple more bits and pieces, mostly from
"contrib/". Included are:

  - The "libsecret", "netrc", "osxkeychain" and "wincred" credential
    helpers.

  - The git-contact(1) script.

  - Coccinelle via a new "coccicheck" target that generates the semantic
    check.

  - The "gitk" graphical repository browser.

Not a lot of stuff is missing after this small patch series, as far as I
am aware. Omissions that I know of include "git-gui", "sparse" and perf
tests.

This patch series supersedes Mirth's patch series at [1]. I have picked
the compilation fix for MSVC from that series and retained authorship,
but with an amended commit message. I've also forged the SOB -- Mirth,
please let me know whether you're okay with this.

Thanks!

Patrick

[1]: <pull.1859.git.1739471859.gitgitgadget@gmail.com>

---
M Hickford (1):
      contrib/credential: fix compilation of wincred helper with MSVC

Patrick Steinhardt (11):
      GIT-BUILD-OPTIONS: propagate project's source directory
      contrib/credential: fix "netrc" tests with out-of-tree builds
      contrib/credential: fix compiling "libsecret" helper
      contrib/credential: fix compilation of "osxkeychain" helper
      meson: wire up credential helpers
      meson: wire up git-contacts(1)
      meson: wire up static analysis via Coccinelle
      gitk: extract script to build Gitk
      meson: wire up Gitk
      ci: fix propagating UTF-8 test locale in musl-based Meson job
      ci: exercise credential helpers

 .github/workflows/main.yml                         |  2 +-
 .gitlab-ci.yml                                     |  2 +-
 GIT-BUILD-OPTIONS.in                               |  3 +-
 Makefile                                           |  3 +-
 ci/install-dependencies.sh                         |  2 +-
 ci/lib.sh                                          | 10 ++-
 contrib/buildsystems/CMakeLists.txt                |  3 +-
 contrib/coccinelle/meson.build                     | 89 ++++++++++++++++++++++
 contrib/contacts/meson.build                       | 55 +++++++++++++
 .../libsecret/git-credential-libsecret.c           | 10 +--
 contrib/credential/libsecret/meson.build           |  9 +++
 contrib/credential/meson.build                     |  3 +
 contrib/credential/netrc/meson.build               | 20 +++++
 contrib/credential/netrc/t-git-credential-netrc.sh |  2 +-
 contrib/credential/netrc/test.pl                   |  7 +-
 .../osxkeychain/git-credential-osxkeychain.c       |  2 +-
 contrib/credential/osxkeychain/meson.build         |  9 +++
 .../credential/wincred/git-credential-wincred.c    |  2 +
 contrib/credential/wincred/meson.build             |  5 ++
 contrib/meson.build                                |  3 +
 gitk-git/Makefile                                  |  7 +-
 gitk-git/generate-tcl.sh                           | 11 +++
 gitk-git/meson.build                               | 28 +++++++
 gitk-git/po/meson.build                            | 19 +++++
 meson.build                                        |  7 +-
 meson_options.txt                                  |  8 +-
 t/lib-gettext.sh                                   |  2 +-
 t/t7609-mergetool--lib.sh                          |  2 +-
 28 files changed, 294 insertions(+), 31 deletions(-)


---
base-commit: 03944513488db4a81fdb4c21c3b515e4cb260b05
change-id: 20250206-b4-pks-meson-contrib-5d9b3a5d0830

