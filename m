Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6291D79A9
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 07:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739864779; cv=none; b=fNJxsjACqKCpvYejqdK30AK8tFWM+fya+4huE+LZ7z8fW5d7AowDkYlsLVlY/WfaNRoR+eXGhhjHPVoxj9u/DCTH1m8cMgO28mL8LZXke4H6yvYEeWdmHjIJD4A2e9XqN9LyF6PDziErIjPOCJQDXWionbK5gUAgVLVAEq5L0RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739864779; c=relaxed/simple;
	bh=UCyGOLWcxEZz3FREqBU/HY4EuaOY6eUVKanqJx4P3LM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UG/lCkPLdnfp2CdwuQAi6NN1IBs/NwY78MRqAkXc/EJQuMNDG5SVFOXGVVwO4Uxdhbf/HBpIjUODHLef8ReBDDi+oTIWu/3E0vo6Oa+WeL17wOkrPmJ3ynJN5wkXHza3GPi9ScArcxR0NC8ws89WDK2HOll7jpMljpYfpFGwmeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e5KBSX7T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QH1XPFVx; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e5KBSX7T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QH1XPFVx"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 3F9C11380A33;
	Tue, 18 Feb 2025 02:46:17 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 18 Feb 2025 02:46:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739864777;
	 x=1739951177; bh=8qJVE1wuayywVks7MM9lL5vUp8HvipH4/qUnDTa5Js0=; b=
	e5KBSX7TKfDmCxpucjRCNKuneZONEUlb80IJKQauFWUx8AgJk1eowSuLlkEKDls+
	bHKizyiUv1//96qeJpNrNKvl9OrAVdu7V94eK6yieaC9f4X4c3tcybbIItwL+me7
	yilpK9IW5NdfcZlFWvYGH4KwFebp1l+nVWQq3oEJoBpMIBN7P+HpXOct7ltDsbCY
	PXtU0JsolhiucWsLstacdzs97vZ1S+7o1ilbQ9PBXlokY4WMJEXSCPJhtYO0060+
	STylF1LeQyJsLfjnm/E6ZqcqON88eCkjIAvBYIfgreCzNT45BaZ2oZUkAmIcKPqN
	R8uenbIY+LuWXoTe87HhrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739864777; x=
	1739951177; bh=8qJVE1wuayywVks7MM9lL5vUp8HvipH4/qUnDTa5Js0=; b=Q
	H1XPFVxO6K1lsQMCjZ/v27AcmHSMdJJhtfoHNmiOhKBlMz+YUG866E0GmK8C5kc/
	uM9HEblZN4KxkfUXWNr2dycIDOc9RHaFBhYkIN1dNCtRX3ge1gysjKeGan65SG1T
	/JctLFbzmcOssCBwagivMvFj8a5PWnV2OI47BR6qgNHZ9U5aISM6as6gof5urraa
	CvxcJYZyYL9fCHTkIWX/kyg6k9dJ/0lJfIlaOxKrWEpq2eXTKT2pKjHX43/ONfEZ
	C1IDJkTmdknwCrcdFc+dkmp6GuUl1vnEbzLVymwG46afCOl9BVwm5hnZGfOIrE2o
	LG0ICkGZYGoEF9BrW+0dQ==
X-ME-Sender: <xms:yTq0Z4CTy_vPWSI9_YQZZmvCM1eZBB5aZ5oH0N_9p52ekgcZPGOeYA>
    <xme:yTq0Z6jpKF5MpcRmMNs1E-uPdYrdRdEGS4yf_jKLW138WQUCVdpVmqKWbdAAUwPMr
    QJo6QkPeD6y6wMt_g>
X-ME-Received: <xmr:yTq0Z7nEmOfF46JxXliES0fr0NCjmUd_aTT6-f0IMIvfMlatmtrEG0orvCmFx4KNR9TF1WQhL1b5AIWB7y0EXStKy52wb8NASGmuLpHPUSmW2i29>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdejvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehmihhrthhhrdhhihgtkhhfohhrugesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:yTq0Z-xkOeqHIz4A7ftkua5pbO3mRwU52TbHEzgocb1I3C8lNmCRrA>
    <xmx:yTq0Z9TE7zhl_GEcp-g-Daz4jRnJwUGdY6bP8NKAOa0z9RTHstJRlA>
    <xmx:yTq0Z5biQ3U9OcHMdd8esy88Rb9MKT46cZTWiARs5hQfxZd1QeZGOA>
    <xmx:yTq0Z2TPX1Q8mm5gVKeadJHt0EzFq6FenG6SF5KfnENC3XUNUYF-Ug>
    <xmx:yTq0Z4cYlx1V2SysPlqdTI-fp1w9dCnDLcNAJi7UWvlARedDCtEFUQ44>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 02:46:16 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9800e0c9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Feb 2025 07:46:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 18 Feb 2025 08:46:00 +0100
Subject: [PATCH 12/12] ci: exercise credential helpers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-b4-pks-meson-contrib-v1-12-c3edd292beb8@pks.im>
References: <20250218-b4-pks-meson-contrib-v1-0-c3edd292beb8@pks.im>
In-Reply-To: <20250218-b4-pks-meson-contrib-v1-0-c3edd292beb8@pks.im>
To: git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>
X-Mailer: b4 0.14.2

Wire up credential helpers in our CI runs so that we can rest assured
that they compile and (if tests are available) function correctly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml | 2 +-
 .gitlab-ci.yml             | 2 +-
 ci/install-dependencies.sh | 2 +-
 ci/lib.sh                  | 6 ++++++
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 5f756dfc2e2..9959b61ece2 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -265,7 +265,7 @@ jobs:
       run: pip install meson ninja
     - name: Setup
       shell: pwsh
-      run: meson setup build -Dperl=disabled
+      run: meson setup build -Dperl=disabled -Dcredential_helpers=wincred
     - name: Compile
       shell: pwsh
       run: meson compile -C build
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 3f29181708f..bb7d0c9ef1c 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -164,7 +164,7 @@ build:msvc-meson:
   extends: .msvc-meson
   stage: build
   script:
-    - meson setup build -Dperl=disabled
+    - meson setup build -Dperl=disabled -Dcredential_helpers=wincred
     - meson compile -C build
   artifacts:
     paths:
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 332ba960039..0df74610d06 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -58,7 +58,7 @@ ubuntu-*|i386/ubuntu-*|debian-*)
 		make libssl-dev libcurl4-openssl-dev libexpat-dev wget sudo default-jre \
 		tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl \
 		libemail-valid-perl libio-pty-perl libio-socket-ssl-perl libnet-smtp-ssl-perl libdbd-sqlite3-perl libcgi-pm-perl \
-		libpcre2-dev meson ninja-build pkg-config \
+		libsecret-1-dev libpcre2-dev meson ninja-build pkg-config \
 		${CC_PACKAGE:-${CC:-gcc}} $PYTHON_PACKAGE
 
 	case "$distro" in
diff --git a/ci/lib.sh b/ci/lib.sh
index 84d11452650..f561884d401 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -348,6 +348,9 @@ case "$jobname" in
 linux32)
 	CC=gcc
 	;;
+linux-meson)
+	MESONFLAGS="$MESONFLAGS -Dcredential_helpers=libsecret,netrc"
+	;;
 linux-musl-meson)
 	MESONFLAGS="$MESONFLAGS -Dtest_utf8_locale=C.UTF-8"
 	;;
@@ -359,6 +362,9 @@ linux-asan-ubsan)
 	export NO_SVN_TESTS=LetsSaveSomeTime
 	MAKEFLAGS="$MAKEFLAGS NO_PYTHON=YepBecauseP4FlakesTooOften"
 	;;
+osx-meson)
+	MESONFLAGS="$MESONFLAGS -Dcredential_helpers=osxkeychain"
+	;;
 esac
 
 MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"

-- 
2.48.1.666.gff9fcf71b7.dirty

