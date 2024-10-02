Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F4D1CF7D3
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 15:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882144; cv=none; b=G0Rx175moE4PLb9bi3GBcQRvRnmqTOjuXDhw+w9Hp9NTA0oW0wf0J3gkNWPIWcgar0N+NNM5/su7v7/i8ImS4BcdPSsoJoiHVmPmP98PpNqTzv2kOfmlOUz/WSf0lOTrzHB9kITfyAR9lToPaJqwjFGrxoac1sXignw6KWVD+Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882144; c=relaxed/simple;
	bh=jEj6BS0rq4jxlbfMdxZBesDNUiMh1sDh9OzImyzRiOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c59Im9PhmZXsnQ51E42fe6uqjr96pbqA6orc+t0mZc+Lfd69VI1o7R+RjZ/MN6HZBriMFVncv7v1Xa9EuwNH1iib2+UcvgSQFz5KM1Qg0F4hzyfqIyru5va4VBCXyX4CdK6N27YeUgk5K4ugzSaXfXpy6ufZ/1B9Hk4NtICMK0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZZMXgf6c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gzFSoV4E; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZZMXgf6c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gzFSoV4E"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E83451140170;
	Wed,  2 Oct 2024 11:15:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 02 Oct 2024 11:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727882140; x=1727968540; bh=RsZRRwbYHz
	wK1iFLUsGExCVro0zySn2+uAq44i8Sa9M=; b=ZZMXgf6c8z063584CMDTW20Fgb
	vhGUtSnFxtIT/CuZjPgpCizAmEQEYnN0xeGFpxd4AYsOoQpTUzDCx6cKwa9b9wep
	rYlttf822gnvk4gJTXXS1fjDH/9EeXBALfyISJ9zyM/bkzZLwaDNxEL/K7hUaY+a
	qfhoWunjtYyOS9NR+uN4nyBdjMN+NxSOqJywbQVPLujB0NkDc6F++BR2KTdW7b9I
	hE56L4Qiw4wrxlV1xdANCBnTiuuI54RXif/WWavcmnDrxm0/kPlFj4gXDqdSphNS
	CLeg68SvWTfvEJtXmVzFBRCjS4YdVh4o0qryV0LAeEqgti7GOoAxsta4cD1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727882140; x=1727968540; bh=RsZRRwbYHzwK1iFLUsGExCVro0zy
	Sn2+uAq44i8Sa9M=; b=gzFSoV4E05Iet7ymbX7hSqVG+tJbPlQRkYeTSeclT/P7
	i93F6P8fluJPZbLm1noa4er3uyBMCN63PdOLv2r9Oock5r+wNDI/sThLhDXV0gSk
	zHbWvs67gVa6tBB1U7kKrfahLjfEAnFoYuKdxRaP8ApsAxBIl1HImdnivTwHqTpm
	4t/OkYrny5UmWWfA+IQX6exLzxwWsN2dPt0srVilvu3TL3jsEd0xqyFBqj3ev0U3
	P6SOwrfdKorKVVrVlKhMvkLkBgzvxY/TOekUVTGr8kMeGgBmzGqfNnDuZW9YRMn/
	WJZL/2/IWMQBmQ7dhOgTRc3yIJfwrROTB/4HafbHfQ==
X-ME-Sender: <xms:nGP9Zq5G5LHZbGWDfbT_EOlspKTQsCrKKgQrUcp0zZjBEi4nfP-M_Q>
    <xme:nGP9Zj6IECqFUcBZQQpZriR3W2m7n9OplKBuzWWxLWg_WgiNA0Ik-0-nC2Q-EwXu5
    xsHG0rAUZA7_9W0LA>
X-ME-Received: <xmr:nGP9ZpcO-hdHFFf2Vc0xH8EOsZuJ_7fOO3fr7PrpkGhstGoTxTOmrYCQJqLEZkZteUolgKqbsM1jAesKuLI9kJYAF-_BOtv3VHmii0KTSxD6k75b>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveefffdtgfekhfdttdejhefgffffjedtfeelueetgfeh
    heehudeihffgjedvkeegnecuffhomhgrihhnpehtgihtrdgruhhtohenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhn
    sggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegvshgthh
    ifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:nGP9ZnJMq4jwjFzs53kganPNy3NWoRp1iVev2iUCJGxdywY_IIliNg>
    <xmx:nGP9ZuK8-aidefnOyFoSBGfzXScEdI2XP20IVFsUpTqxI2VaP-WoUg>
    <xmx:nGP9ZowUR--4uoWAEOn8qzGrUMzz1i1xbUszXHOcc3pJP4coTuACWg>
    <xmx:nGP9ZiIZZ4lLPGssV4-TQOCa6ACJ6KToG8f7v6fO9DXlIEzG9_uWWw>
    <xmx:nGP9ZlXE9ku-VSTXAyAwZntuNCHf1SEODce75dXMAyjOSmLKfLPyc7oN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 11:15:39 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 67df1324 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 15:14:48 +0000 (UTC)
Date: Wed, 2 Oct 2024 17:15:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>
Subject: [RFC PATCH 01/21] Documentation: add comparison of build systems
Message-ID: <508e3783d284fd2d3bd4840907ed0bdc20bc1b23.1727881164.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727881164.git.ps@pks.im>

We're contemplating whether to eventually replace our build systems with
a build system that is easier to use. Add a comparison of build systems
to our technical documentation as a baseline for discussion.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/Makefile                    |   1 +
 Documentation/technical/build-systems.txt | 164 ++++++++++++++++++++++
 2 files changed, 165 insertions(+)
 create mode 100644 Documentation/technical/build-systems.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 0f55baa252..e23cffb5f9 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -111,6 +111,7 @@ TECH_DOCS += MyFirstObjectWalk
 TECH_DOCS += SubmittingPatches
 TECH_DOCS += ToolsForGit
 TECH_DOCS += technical/bitmap-format
+TECH_DOCS += technical/build-systems
 TECH_DOCS += technical/bundle-uri
 TECH_DOCS += technical/hash-function-transition
 TECH_DOCS += technical/long-running-process-protocol
diff --git a/Documentation/technical/build-systems.txt b/Documentation/technical/build-systems.txt
new file mode 100644
index 0000000000..8fac36ce1d
--- /dev/null
+++ b/Documentation/technical/build-systems.txt
@@ -0,0 +1,164 @@
+= Build Systems
+
+The build system is the primary way for both developers and system integrators
+to interact with the Git project. As such, we consider it important to pick a
+build system that fulfills our requirements while being easy to use and extend.
+
+This document outlines the different requirements that we have for the build
+system and then compares available build systems using these criteria.
+
+== Requirements
+
+The following subsections prevent a list of requirements that we have for any
+potential build system. Sections are sorted by decreasing priority, even though
+these priorities will naturally differ between users.
+
+=== Platform support
+
+The most important criterium is whether the build system supports all of the
+platforms that Git supports. The most important platforms include:
+
+  - Linux
+  - macOS
+  - Windows
+  - FreeBSD
+  - OpenBSD
+  - NetBSD
+
+The platforms which must be supported by the tool should be aligned with our
+[platform support policy](platform-support.txt).
+
+=== Auto-detection of supported features
+
+The build system MUST support auto-detection of features which are or aren't
+available on the current platform. Platform maintainers should not be required
+to manually configure the complete build.
+
+Auto-detection of the following items is considered to be important:
+
+  - Check for the existence of headers.
+  - Check for the existence of libraries.
+  - Check for the existence of exectuables.
+  - Check for the runtime behavior of specific functions.
+
+=== Ease of use
+
+The build system SHOULD be both easy to use and easy to extend. While this is
+naturally a subjective metric it is likely not controversial to say that some
+build systems are considerably harder to use than others.
+
+=== IDE support
+
+The build system SHOULD integrate with well-known IDEs. Well-known IDEs include:
+
+  - Microsoft Visual Studio
+  - Visual Studio Code
+  - Xcode
+
+There are four levels of support:
+
+  - Native integration into the IDE.
+  - Integration into the IDE via a plugin.
+  - Integration into the IDE via generating a project description with the build
+    system.
+  - No integration.
+
+Native integration is preferable, but integration via either a plugin or by
+generating a project description via the build system are considered feasible
+alternatives.
+
+Another important distinction is the level of integration. There are two
+features that one generally wants to have:
+
+  - Integration of build targets.
+  - Automatic setup of features like code completion with detected build
+    dependencies.
+
+The first bullet point is the bare minimum, but is not sufficient to be
+considered proper integration.
+
+=== Out-of-tree builds
+
+The build system SHOULD support out-of-tree builds. Out-of-tree builds allow a
+developer to configure multiple different build directories with different
+configuration, e.g. one "debug" build and one "release" build.
+
+=== Rust support
+
+Many long-time Git contributors are nowadays in favor of adopting Rust as a
+second language next to C. The build system SHOULD thus support Rust such that
+we do not have to reopen the discussion once we decide to pick up Rust.
+
+== Comparison
+
+The following list of build systems are considered:
+
+- GNU Make
+- autoconf
+- CMake
+- Meson
+
+=== GNU Make
+
+- Platform support: ubitquitous on all platforms, but not well-integrated into Windows.
+- Auto-detection: no built-in support for auto-detection of features.
+- Ease of use: easy to use, but discovering available options is hard. Makefile
+  rules can quickly get out of hand once reaching a certain scope.
+- IDE support: execution of Makefile targets is supported by many IDEs
+- Out-of-tree builds: supported in theory, not wired up in practice.
+- Rust: can be added.
+
+=== autoconf
+
+- Platform support: ubiquitous on all platforms, but not well-integrated into Windows.
+- Auto-detection: supported.
+- Ease of use: easy to use, discovering available options is comparatively
+  easy. The autoconf syntax is prohibitively hard to extend though due to its
+  complex set of interacting files and the hard-to-understand M4 language.
+- IDE support: no integration into IDEs at generation time. The generated
+  Makefiles have the same level of support as GNU Make.
+- Out-of-tree builds: supported in theory, not wired up in practice.
+- Rust: not supported.
+
+=== CMake
+
+- Platform support: not as extensive as GNU Make or autoconf, but all major
+  platforms are supported.
+  - AIX
+  - Cygwin
+  - FreeBSD
+  - Linux
+  - OpenBSD
+  - Solaris
+  - Windows
+  - macOS
+- Ease of use: easy to use, discovering available options is not always
+  trivial. The scripting language used by CMake is somewhat cumbersome to use,
+  but extending CMake build instructions is doable.
+- IDE support: natively integrated into Microsoft Visual Studio. Can generate
+  project descriptions for Xcode. An extension is available for Visual Studio
+  Code. Many other IDEs have plugins for CMake.
+- Out-of-tree builds: supported.
+- Rust: not supported.
+
+=== Meson
+
+- Platform: not as extensive as GNU Make or autoconf, but all major platforms
+  and some smaller ones are supported.
+  - AIX
+  - Cygwin
+  - DragonflyBSD
+  - FreeBSD
+  - Haiku
+  - Linux
+  - NetBSD
+  - OpenBSD
+  - Solaris
+  - Windows
+  - macOS
+- Ease of use: easy to use, discovering available options is easy. The
+  scripting language is straight-forward to use.
+- IDE support: Supports generating build instructions for Xcode and Microsoft
+  Visual Studio, a plugin exists for Visual Studio Code.
+- Out-of-tree builds: supported.
+- Rust: supported.
-- 
2.47.0.rc0.dirty

