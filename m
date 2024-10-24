Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC531D5170
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 12:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729773606; cv=none; b=VkzxGJA10pU80tLUTcqufcZYeOc9AI/rUJHHeLW1TIh2pKUuybTWYP8q4ebl8K0tChV1q746I1RQNhEGaWZUxDu4w7x1Qv4aIHwyDhrs8N8GPPOvzYncWF2CYk2UFHPlYemcPcbb/MpJdPpbLtGvpGr4HtJtq4+BFDmxjHBRhp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729773606; c=relaxed/simple;
	bh=usbrutmtG3pJ7egN9sAioPr2aOUHEVom1qQiusu0540=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k86tArhSw4EZgsljnXBBffRiGEGHoZBqpjM61hL0Ps7gyP8ql6fWh2BcKQAu4s8u/Z6aNYj5lvbyWCE8ch3ArsTG0LFv70KpVmDOfUZkHJG5KIqTmxEMETkqfd8Z6mUlde+rcmjXRqF+j+C842rxNdELWcM6O7aGvMFoFLmGMbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nmzXTqXH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YPaa5rUM; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nmzXTqXH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YPaa5rUM"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 096C32540114;
	Thu, 24 Oct 2024 08:40:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 24 Oct 2024 08:40:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729773600; x=1729860000; bh=zvri8oT7Hr
	Bq8uRYyS2zeLlil4zyDbrd6/YPJPgZBT8=; b=nmzXTqXHiO5Dx4gpIba2yGxORD
	F6ik2SvFabbIs5jRQ/tkVkNFRVS/bb1tQQQIR+TgUM2ZlEgELi0C4MdanPinzb4+
	3J/RZpbnGPfJduiQIb2abOSGs2GkRF+p7Izj9On+cpMWw/T2LeRl7mNn1ZcDA3Cm
	dIs1G73Jav5DoioRd/NXIM3fYLAvVlH+55Xg/xYm7mLJQvi6pjdapDmWV2UPDoZV
	GfdKZJJUt768hvdmRYMa3UnU49ha/Kxhu7BSjmh4QYtgFsNvO1lcmz/2XvXGjJIy
	fbHJf2zn4/7VnmKZ7Gjz9xKZUOutHHyumyAlEXLSrKXpEoH9jxaHLnPL6f6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729773600; x=1729860000; bh=zvri8oT7HrBq8uRYyS2zeLlil4zy
	Dbrd6/YPJPgZBT8=; b=YPaa5rUMRE73lodc87oeO5HHgPeFaBrIiHunk6DgtytC
	NBh3myMCgmFcqMOZeF7BvIPWMr68bw0CdpfmSPdw4fhsVCihKTdZtu2Vr165XswN
	mS7JU5UBYwhjqyjMR0KE4SYFS3nJ5xZHkp1N9NA74jA8WpHud7Sk09fUnM72Ocms
	0tC6o9Q/MEXwzfjU48XmvgUA8x3uKcIaQ6hFZ3oWBJnwHT1Kul2Ta8Om4mfSSXxM
	9mVlk1h/656933EPKYrho0V0oNQx6G9utqCfPRVtTyCAErNJEedsdpIe5BOitLXF
	ALh8fbPsuGURH7V5N8iDONGtESQiqq2DF/iVDniuFQ==
X-ME-Sender: <xms:IEAaZzacYSFrU9MAalxOuUyTrUsDnGZCTJS9NO_Q7yZa3AGVBuigUA>
    <xme:IEAaZyYjpgafZySXw4eRqPjhRQShqKw40D60SE4SFMK0cqp80D47XBOO5eIFdfqAT
    AazDUL3ZcWnmW8Fsw>
X-ME-Received: <xmr:IEAaZ19zuWp0PpcU5ZDy0gu8EmwN3v0JhBZ0yqBCimdWZgi4iFT2BdKzHpOpyzQ1jhTZjc950NyBfK-qiL0-fPUYRG4EvdAE9-8SSMdkCYYNjBb_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejtddgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    phhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehrrg
    hmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepvghs
    tghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:IEAaZ5rlFBH3shuKNb1mta8BhSHawBVFOvaAkMwmLykl-ixtCu4PzQ>
    <xmx:IEAaZ-riaX6jLqCmyIrMrUJtCIzOm8_RjcgLTnbyDQCF0DRXvkZj-w>
    <xmx:IEAaZ_R1kpFskiTANrVXVakTVogD5F1d8NPUTV5c4cxbnqYSwaujsw>
    <xmx:IEAaZ2oC41hyA0KyEPB1_-za_J2ckq_0b6LBBS5QrXnFELS3gX3SFQ>
    <xmx:IEAaZ-LCFhyowUs9oTXT2QW6nyPuwHkrq1ibQOC5tFsAD6SEv_NQpnQT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Oct 2024 08:39:59 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 92dc952a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 24 Oct 2024 12:40:02 +0000 (UTC)
Date: Thu, 24 Oct 2024 14:39:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [RFC PATCH v4 04/19] Makefile: extract script to massage Perl scripts
Message-ID: <50b607a412afea051a7839b9f3f1b4519b58721a.1729771605.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1729771605.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729771605.git.ps@pks.im>

Extract the script to inject various build-time parameters into our Perl
scripts into a standalone script. This is done such that we can reuse it
in other build systems.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile                            | 12 ++----------
 contrib/buildsystems/CMakeLists.txt | 20 +++++++++++++++-----
 generate-perl.sh                    | 26 ++++++++++++++++++++++++++
 3 files changed, 43 insertions(+), 15 deletions(-)
 create mode 100755 generate-perl.sh

diff --git a/Makefile b/Makefile
index 22ed53f39e7..e04a381e8f0 100644
--- a/Makefile
+++ b/Makefile
@@ -2604,16 +2604,8 @@ endif
 
 PERL_DEFINES += $(gitexecdir) $(perllibdir) $(localedir)
 
-$(SCRIPT_PERL_GEN): % : %.perl GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VERSION-FILE
-	$(QUIET_GEN) \
-	sed -e '1{' \
-	    -e '	s|#!.*perl|#!$(PERL_PATH_SQ)|' \
-	    -e '	r GIT-PERL-HEADER' \
-	    -e '	G' \
-	    -e '}' \
-	    -e 's/@GIT_VERSION@/$(GIT_VERSION)/g' \
-	    $< >$@+ && \
-	chmod +x $@+ && \
+$(SCRIPT_PERL_GEN): % : %.perl generate-perl.sh GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VERSION-FILE
+	$(QUIET_GEN)$(SHELL_PATH) generate-perl.sh ./GIT-BUILD-OPTIONS $(GIT_VERSION) GIT-PERL-HEADER "$<" "$@+" && \
 	mv $@+ $@
 
 PERL_DEFINES := $(subst $(space),:,$(PERL_DEFINES))
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 608ad9714d4..7fb6a149f21 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -848,19 +848,29 @@ foreach(script ${git_shell_scripts})
 endforeach()
 
 #perl scripts
-parse_makefile_for_scripts(git_perl_scripts "SCRIPT_PERL" ".perl")
+parse_makefile_for_scripts(git_perl_scripts "SCRIPT_PERL" "")
 
 #create perl header
 file(STRINGS ${CMAKE_SOURCE_DIR}/perl/header_templates/fixed_prefix.template.pl perl_header )
 string(REPLACE "@PATHSEP@" ":" perl_header "${perl_header}")
 string(REPLACE "@INSTLIBDIR@" "${INSTLIBDIR}" perl_header "${perl_header}")
+file(WRITE ${CMAKE_BINARY_DIR}/PERL-HEADER ${perl_header})
 
 foreach(script ${git_perl_scripts})
-	file(STRINGS ${CMAKE_SOURCE_DIR}/${script}.perl content NEWLINE_CONSUME)
-	string(REPLACE "#!/usr/bin/perl" "#!/usr/bin/perl\n${perl_header}\n" content "${content}")
-	string(REPLACE "@GIT_VERSION@" "${PROJECT_VERSION}" content "${content}")
-	file(WRITE ${CMAKE_BINARY_DIR}/${script} ${content})
+	string(REPLACE ".perl" "" perl_gen_path "${script}")
+
+	add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/${perl_gen_path}
+		COMMAND ${CMAKE_SOURCE_DIR}/generate-perl.sh
+			${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS
+			${PROJECT_VERSION}
+			${CMAKE_BINARY_DIR}/PERL-HEADER
+			${CMAKE_SOURCE_DIR}/${script}
+			${CMAKE_BINARY_DIR}/${perl_gen_path}
+		DEPENDS ${CMAKE_SOURCE_DIR}/generate-perl.sh
+			${CMAKE_SOURCE_DIR}/${script})
+	list(APPEND perl_gen ${CMAKE_BINARY_DIR}/${perl_gen_path})
 endforeach()
+add_custom_target(perl-gen ALL DEPENDS ${perl_gen})
 
 #python script
 file(STRINGS ${CMAKE_SOURCE_DIR}/git-p4.py content NEWLINE_CONSUME)
diff --git a/generate-perl.sh b/generate-perl.sh
new file mode 100755
index 00000000000..12e116b76e5
--- /dev/null
+++ b/generate-perl.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+
+set -e
+
+if test $# -ne 5
+then
+	echo "USAGE: $0 <GIT_BUILD_OPTIONS> <GIT_VERSION> <PERL_HEADER> <INPUT> <OUTPUT>" >&2
+	exit 1
+fi
+
+GIT_BUILD_OPTIONS="$1"
+GIT_VERSION="$2"
+PERL_HEADER="$3"
+INPUT="$4"
+OUTPUT="$5"
+
+. "$GIT_BUILD_OPTIONS"
+
+sed -e '1{' \
+    -e "	s|#!.*perl|#!$PERL_PATH|" \
+    -e "	r $PERL_HEADER" \
+    -e '	G' \
+    -e '}' \
+    -e "s/@GIT_VERSION@/$GIT_VERSION/g" \
+    "$INPUT" >"$OUTPUT"
+chmod a+x "$OUTPUT"
-- 
2.47.0.118.gfd3785337b.dirty

