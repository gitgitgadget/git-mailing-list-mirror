Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5084E1BFDEC
	for <git@vger.kernel.org>; Thu, 28 Nov 2024 16:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732810355; cv=none; b=B/iepF0FVZQXc3yn718M0gdTdq525Zs6TuZRuoIZx0T/IktBGzJEZVs7hlIx8v27nT8R/4yuNGQgzCwS59mX+KTcLep8R1Xkz0/FWpriyq7XVZVpYQTP2BGPpS/wlJVaxUxHVx7D40bWwH1mJ7WTL8H8A7s7ususFfx5VA/7ViE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732810355; c=relaxed/simple;
	bh=XikIfnRt7OC6v+34yD31fVlFR0imTTrTbsvu+VPPoQA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZJWI/iwWpv4FA5ZNLZPN5vMqdw2ViMAjrV+VnRsivxMJDFTtB98OdINXvk//x6/SFo3WtxghB+M3LRxP+no0MHgHJDrb6gHTCMfvse5WLNQOtq6kROwtGhIRcRg/9GCsAqZR67EbzBFXIby0KvASbDvPU8l9XpVFNf5j8Fl0k8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vdVKFxl6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=24b+X/qe; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vdVKFxl6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="24b+X/qe"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8CD8B1140126;
	Thu, 28 Nov 2024 11:12:32 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 28 Nov 2024 11:12:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732810352;
	 x=1732896752; bh=4J7O2bKvVPcHKoMhrkWEVQVWLG4WzppIHmwmmadSqFs=; b=
	vdVKFxl6nmQBhIKoa1n4zmJ8SjZmImIE5jxU5EXKlqkHkYgBIqsYUvT6xzlykpRC
	/qQ/rrDL3IjgGd3qUVkjMhwTRFTaJCFG6KbeA6NOveMaCdbB3fD36KMKKQHRkl2z
	ZzjriqgI7bdqCGQwh6Gu/QnCek1gJaQKZ/9jh9LXJ5CpCV9wN9+bwFu3HrcAnC03
	0AivLkbswh1kO5OAhWV7DjgHsLpAC+RofBSpWH7CV2m7rBbe/0SlgTIm90Iw/l3w
	DmmBKQdHF+RZz56eVLNGznStm5hAhAJ1I8ysb7g62K5kI0+q5udcDRNTEhL/TB0O
	OnJBCpx2WRF7F++dRWyaYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732810352; x=
	1732896752; bh=4J7O2bKvVPcHKoMhrkWEVQVWLG4WzppIHmwmmadSqFs=; b=2
	4b+X/qe9OwmAiLd/bpJiwS2cnW6tkB4PwL+wCucfZhtdj/Yex9LQ3CNL6l0DZIId
	RXI8QIbl3nirgFV834fMiZl1nKQHaVEn/hqgEijBejF+7XStmXSeo6iVdpKCcBSE
	iy/Ux5plgdHQ1SiSC2pGPv12W2sxUPTcKdYEZU3dLpvbf3fCiD6OKQxL6Y+DWeyv
	B5A7eahVMJv7TvdWnJ7eqXCVL9IU9+/hx/0mm00hAs31SAlCVQSwZRw5b3PpyQL/
	o7Y49HlPLxeq69Mmb+bgYjxdWl1Mx97oh274ubw4EFFPHHhpqCHlj26vTbsnB1x3
	33DoIqK2PfHq4WSfmitkQ==
X-ME-Sender: <xms:cJZIZ3vjuZoIm18RbTAO3S52-qNTvOt9QY77vZ3qAD1MjsT4go_ZBg>
    <xme:cJZIZ4d54Io2HPaULhKPbijb-J7hAE414S_11fo2R2dsUrwHDszBwg_OEp1SpcViU
    TSaFt3HcKW9Wmqi6Q>
X-ME-Received: <xmr:cJZIZ6xgl-AZja86pkZ5Lvc2hysbvJrgs55Q90h0jagOAcl3fCq4aIxWqzjNZBqElmUIFBVoXC_9aTA6ECnoWO5plKQw64xnDyhC1xVIeHS1nQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedugdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnheptdeuvdegkeevuedtleelveelgfehgfdvheevuefhueeg
    jeefleejhfdvkeehudetnecuffhomhgrihhnpehrtgdrihhnnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvvhhiug
    esghhmrghilhdrtghomhdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgv
    shdrphhluhhsrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprh
    gtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopegvshgthhifrghrthii
    sehgvghnthhoohdrohhrghdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmh
    hilhihrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:cJZIZ2MdwiyUBiS_7FwjehF_5rMXpLheyH6oITaiiTVaGt_acJsgdw>
    <xmx:cJZIZ385laJdGdyRg8dZiVQKvmGXX-g5pou0iiJZZhgHx3yvHKWv-A>
    <xmx:cJZIZ2UxLO8iU3tzyAJsHxyQ96WIQUZXYGa3LQQ2VJUT8XqDNI3MKw>
    <xmx:cJZIZ4dX6xtzaOPj5laFjXZtXSj2RT4Zmt__azxnLCCNvBJFHdCzKg>
    <xmx:cJZIZ2Vn9ZJtETqhSV4DOQ5UdopxkxRFd-NtoMBs_DdozZaoiBixmi70>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Nov 2024 11:12:30 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dd235dc8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Nov 2024 16:11:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 28 Nov 2024 17:12:06 +0100
Subject: [PATCH v10 05/23] Makefile: generate "git.rc" via GIT-VERSION-GEN
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241128-pks-meson-v10-5-79a3fb0cb3a6@pks.im>
References: <20241128-pks-meson-v10-0-79a3fb0cb3a6@pks.im>
In-Reply-To: <20241128-pks-meson-v10-0-79a3fb0cb3a6@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>, 
 David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>, 
 Johannes Sixt <j6t@kdbg.org>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

The "git.rc" is used on Windows to embed information like the project
name and version into the resulting executables. As such we need to
inject the version information, which we do by using preprocessor
defines. The logic to do so is non-trivial and needs to be kept in sync
with the different build systems.

Refactor the logic so that we generate "git.rc" via `GIT-VERSION-GEN`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitignore                          |  1 +
 GIT-VERSION-GEN                     |  8 ++++++--
 Makefile                            | 13 +++++++------
 contrib/buildsystems/CMakeLists.txt | 19 +++++++++++++------
 git.rc => git.rc.in                 |  6 +++---
 5 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/.gitignore b/.gitignore
index e17963e84252fa094c10f5e84c0e3724153c819c..d3be460040c6120d862a25dff1abd325b93b37fd 100644
--- a/.gitignore
+++ b/.gitignore
@@ -199,6 +199,7 @@
 *.tar.gz
 *.dsc
 *.deb
+/git.rc
 /git.spec
 *.exe
 *.[aos]
diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index c18f24e515436b71ef40120b88b6fbb0b5621c01..a1c8146f05cfa7fbc6c47804aec5fb848e67c69c 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -58,14 +58,18 @@ then
 	GIT_USER_AGENT="git/$GIT_VERSION"
 fi
 
-read GIT_MAJOR_VERSION GIT_MINOR_VERSION GIT_MICRO_VERSION trailing <<EOF
-$(echo "$GIT_VERSION" 0 0 0 | tr '.a-zA-Z-' ' ')
+# While released Git versions only have three numbers, development builds also
+# have a fourth number that corresponds to the number of patches since the last
+# release.
+read GIT_MAJOR_VERSION GIT_MINOR_VERSION GIT_MICRO_VERSION GIT_PATCH_LEVEL trailing <<EOF
+$(echo "$GIT_VERSION" 0 0 0 0 | tr '.a-zA-Z-' ' ')
 EOF
 
 sed -e "s|@GIT_VERSION@|$GIT_VERSION|" \
 	-e "s|@GIT_MAJOR_VERSION@|$GIT_MAJOR_VERSION|" \
 	-e "s|@GIT_MINOR_VERSION@|$GIT_MINOR_VERSION|" \
 	-e "s|@GIT_MICRO_VERSION@|$GIT_MICRO_VERSION|" \
+	-e "s|@GIT_PATCH_LEVEL@|$GIT_PATCH_LEVEL|" \
 	-e "s|@GIT_BUILT_FROM_COMMIT@|$GIT_BUILT_FROM_COMMIT|" \
 	-e "s|@GIT_USER_AGENT@|$GIT_USER_AGENT|" \
 	"$INPUT" >"$OUTPUT"+
diff --git a/Makefile b/Makefile
index 7150ffc39c1b444a2c4775382f943c603490d54e..1255d222c2dec9a034dee2621192bf97afe905ee 100644
--- a/Makefile
+++ b/Makefile
@@ -2568,11 +2568,12 @@ $(SCRIPT_LIB) : % : %.sh GIT-SCRIPT-DEFINES
 	$(QUIET_GEN)$(cmd_munge_script) && \
 	mv $@+ $@
 
-git.res: git.rc GIT-VERSION-FILE GIT-PREFIX
-	$(QUIET_RC)$(RC) \
-	  $(join -DMAJOR= -DMINOR= -DMICRO= -DPATCHLEVEL=, $(wordlist 1, 4, \
-	    $(shell echo $(GIT_VERSION) 0 0 0 0 | tr '.a-zA-Z-' ' '))) \
-	  -DGIT_VERSION="\\\"$(GIT_VERSION)\\\"" -i $< -o $@
+git.rc: git.rc.in GIT-VERSION-GEN GIT-VERSION-FILE
+	$(QUIET_GEN)$(SHELL_PATH) ./GIT-VERSION-GEN "$(shell pwd)" $< $@+
+	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
+
+git.res: git.rc GIT-PREFIX
+	$(QUIET_RC)$(RC) -i $< -o $@
 
 # This makes sure we depend on the NO_PERL setting itself.
 $(SCRIPT_PERL_GEN): GIT-BUILD-OPTIONS
@@ -3717,7 +3718,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) -r .build $(UNIT_TEST_BIN)
 	$(RM) GIT-TEST-SUITES
 	$(RM) po/git.pot po/git-core.pot
-	$(RM) git.res
+	$(RM) git.rc git.res
 	$(RM) $(OBJECTS)
 	$(RM) headless-git.o
 	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB)
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 3cc5e318190292dd66981aa8593e7bd2739eea1d..865b3af9fb2c1e7bdc1e7cecd0f021ee460971dd 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -691,18 +691,25 @@ list(TRANSFORM reftable_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
 add_library(reftable STATIC ${reftable_SOURCES})
 
 if(WIN32)
+	add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/git.rc
+			COMMAND "${SH_EXE}" "${CMAKE_SOURCE_DIR}/GIT-VERSION-GEN"
+				"${CMAKE_SOURCE_DIR}"
+				"${CMAKE_SOURCE_DIR}/git.rc.in"
+				"${CMAKE_BINARY_DIR}/git.rc"
+			DEPENDS "${CMAKE_SOURCE_DIR}/GIT-VERSION-GEN"
+				"${CMAKE_SOURCE_DIR}/git.rc.in"
+			VERBATIM)
+
 	if(NOT MSVC)#use windres when compiling with gcc and clang
 		add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/git.res
-				COMMAND ${WINDRES_EXE} -O coff -DMAJOR=${PROJECT_VERSION_MAJOR} -DMINOR=${PROJECT_VERSION_MINOR}
-					-DMICRO=${PROJECT_VERSION_PATCH} -DPATCHLEVEL=0 -DGIT_VERSION="\\\"${PROJECT_VERSION}.GIT\\\""
-					-i ${CMAKE_SOURCE_DIR}/git.rc -o ${CMAKE_BINARY_DIR}/git.res
+				COMMAND ${WINDRES_EXE} -O coff -i ${CMAKE_BINARY_DIR}/git.rc -o ${CMAKE_BINARY_DIR}/git.res
+				DEPENDS "${CMAKE_BINARY_DIR}/git.rc"
 				WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
 				VERBATIM)
 	else()#MSVC use rc
 		add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/git.res
-				COMMAND ${CMAKE_RC_COMPILER} /d MAJOR=${PROJECT_VERSION_MAJOR} /d MINOR=${PROJECT_VERSION_MINOR}
-					/d MICRO=${PROJECT_VERSION_PATCH} /d PATCHLEVEL=0 /d GIT_VERSION="${PROJECT_VERSION}.GIT"
-					/fo ${CMAKE_BINARY_DIR}/git.res ${CMAKE_SOURCE_DIR}/git.rc
+				COMMAND ${CMAKE_RC_COMPILER} /fo ${CMAKE_BINARY_DIR}/git.res ${CMAKE_BINARY_DIR}/git.rc
+				DEPENDS "${CMAKE_BINARY_DIR}/git.rc"
 				WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
 				VERBATIM)
 	endif()
diff --git a/git.rc b/git.rc.in
similarity index 67%
rename from git.rc
rename to git.rc.in
index cc3fdc6cc6cb83b084eebe2ad49f3c78c981789b..e69444eef3f0c558707e067d52820668d2116308 100644
--- a/git.rc
+++ b/git.rc.in
@@ -1,6 +1,6 @@
 1 VERSIONINFO
-FILEVERSION     MAJOR,MINOR,MICRO,PATCHLEVEL
-PRODUCTVERSION  MAJOR,MINOR,MICRO,PATCHLEVEL
+FILEVERSION     @GIT_MAJOR_VERSION@,@GIT_MINOR_VERSION@,@GIT_MICRO_VERSION@,@GIT_PATCH_LEVEL@
+PRODUCTVERSION  @GIT_MAJOR_VERSION@,@GIT_MINOR_VERSION@,@GIT_MICRO_VERSION@,@GIT_PATCH_LEVEL@
 BEGIN
   BLOCK "StringFileInfo"
   BEGIN
@@ -11,7 +11,7 @@ BEGIN
       VALUE "InternalName", "git\0"
       VALUE "OriginalFilename", "git.exe\0"
       VALUE "ProductName", "Git\0"
-      VALUE "ProductVersion", GIT_VERSION "\0"
+      VALUE "ProductVersion", "@GIT_VERSION@\0"
     END
   END
 

-- 
2.47.0.366.g5daf58cba8.dirty

