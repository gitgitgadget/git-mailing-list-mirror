Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE4F18C035
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 07:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731655306; cv=none; b=qBzlnFw3YZ3yevu8tpFtkCOQhI49CWaMQoMgq4eRP812DlU5hcGviQ1hSv9Xr16/IQlfv/fF/ABIsJ59aOSuufznO4y8klvUNq5h3Nyf8YKJIeFs+IGCHVASLVYZcaPeO6GudG79UVSNnWjOMan7HCP/gTbR42eQEpL3q8k1Es8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731655306; c=relaxed/simple;
	bh=lB7tmYRgsR7VebVvCz/VoTGadodDVEHP5QVrxPsyJIU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yr0csgopwsC0O+A2R3kyITm8snc26XFd2not45pVX3tckFyj096tWHHKNEBuctymS2BcQG9bruMMSM6l5k9zZkYmK1aTZ8/gqknPoJkgKyORMFE9TcnFkknZati3gorEc7welkx6DBemhTbAVPTSCdsZqez4w9hLttP6DMvHQOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LaVuFeym; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JcK5Roi6; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LaVuFeym";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JcK5Roi6"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 07ADF1380650;
	Fri, 15 Nov 2024 02:21:43 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 15 Nov 2024 02:21:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731655303;
	 x=1731741703; bh=8/NO79TVPfIvg0Whsyt6B5q9584oluGB39p9UmWGpwk=; b=
	LaVuFeymeEGa4XSW9qJdNPgYvr0p9CnIjVD2Eb3TvFbG1hKHxKNlMXiByiVl/TNH
	fOS43Y4XYu4va1W8H48Qu7xhqdaaUZHWMCZKAOuGdVOSenqiZmey+e+eh5C0huR0
	vL3A2ArG2YvsE4TUQgK5Vd2J5YyK+7kgpKkANcOfF3SIAEfhBMNymy+Tib/aqPyp
	PV0O9UHbIFPrhUIVcuY3UiXkSa6wy2yFMFmJr/iCh28QIdnRTzGUO4i6O3xkEX3X
	XaXdQNYbhkCSPZPF1kuWZdmXnD+YJ+0J7EMKp81/9GVRORNgl40E5V6i2COvYqhK
	skGcfzrui3ax205xzKu2gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731655303; x=
	1731741703; bh=8/NO79TVPfIvg0Whsyt6B5q9584oluGB39p9UmWGpwk=; b=J
	cK5Roi6JPrrXoYMxLpxPFS/Am5WyP9cruyCN4NTELUInwuEA57vDvPF2B1Lgyw9p
	65shuXXiq4X9juydvWzX0vJxksa7ljlGd7Djqjf3yhULubG8UOZucIAQFWry2CUm
	Jjb4mjFt6x8mqtcKx35kQmyvqsjsSGIdfFTjts9tu5tVLcBm6eUuWHrXVeo5+q2t
	70uLZBBTZJlhwo2omsnRLF1hoFpzSC15y18troMzuni4kPO/TgWMw/Uee6aFC3pK
	FNZoisoAG9VMRBclSMBItcXQR8iKaN/4rwq6rnuES1GeNrtky3z0xSTwbAegcR+c
	SFE6Wrey8BvEnXTNL8TXg==
X-ME-Sender: <xms:hvY2Z2UMrpQqXL40nb7fWXEwp5gwjKvzSIbcI_CKmKGQYJZhtLNwqw>
    <xme:hvY2ZykhUPhAEnigK8j6X0jQQCRrHR0sLZZrLUDJ9uG06BoQy8lNgV4zJeqBW1qsk
    wbYOPv0gHinS-p7Yg>
X-ME-Received: <xmr:hvY2Z6ZMFc8-PXE5NfwSAfRVWuXAEzSJKEKYRrezGF7pm_RuK0-j8bVabizx2E8pxLvscfyImST8lh1dd1FH0U_gluM36CuB_smeFD8uriZcky7oGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdefgddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedtuedvgeekveeutdelleevlefghefgvdehveeuhfeu
    geejfeeljefhvdekheduteenucffohhmrghinheprhgtrdhinhenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggp
    rhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrg
    ihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopegthhhrihhs
    tghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepvghstghhfigrrhhtii
    esghgvnhhtohhordhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgt
    phhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepshhunhhshhhinh
    gvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhrtghpthhtohepuggrvhhvihgusehgmhgrihhlrdgtohhmpdhrtghpth
    htohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:hvY2Z9Uy2jAyGfuKL46GChKLN4WO6EuoZTfUTUdX731fQS6EWMQuYA>
    <xmx:hvY2ZwnHMqWzMXeexJrN5r2IXtmTDgF1GNNPSeUsSiLftDEuvWYE1A>
    <xmx:hvY2Zydxo8AmnqoaquMdqDZ4lwrb152iA9iF7lZdqBAZolAD6fp5Yw>
    <xmx:hvY2ZyHJ0XHdTN6oCVeghn8ABpP62OxCwCnztDYR6jHDbSsH7Bc7MA>
    <xmx:h_Y2Z5ct7XcuJjYvmla9Ofgxm18Lzk3pAKV9PSv6tkjWZovfGNvT9hPD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Nov 2024 02:21:41 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 11e1b792 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 15 Nov 2024 07:20:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 15 Nov 2024 08:21:21 +0100
Subject: [PATCH RFC v7 09/22] Makefile: extract script to massage Shell
 scripts
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-pks-meson-v7-9-47ec19b780b2@pks.im>
References: <20241115-pks-meson-v7-0-47ec19b780b2@pks.im>
In-Reply-To: <20241115-pks-meson-v7-0-47ec19b780b2@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>, 
 David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Same as in the preceding commits, extract a script that allows us to
unify how we massage shell scripts.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 GIT-BUILD-OPTIONS.in                |  4 ++++
 Makefile                            | 34 ++++++++++------------------------
 contrib/buildsystems/CMakeLists.txt | 31 ++++++++++++++++++++-----------
 generate-script.sh                  | 34 ++++++++++++++++++++++++++++++++++
 4 files changed, 68 insertions(+), 35 deletions(-)

diff --git a/GIT-BUILD-OPTIONS.in b/GIT-BUILD-OPTIONS.in
index 050432f9fc49f93d0f6ed98c1307405c52761be0..9b95a6b3eee334b6f691702696ca9d92201b6bac 100644
--- a/GIT-BUILD-OPTIONS.in
+++ b/GIT-BUILD-OPTIONS.in
@@ -36,3 +36,7 @@ GIT_INTEROP_MAKE_OPTS=@GIT_INTEROP_MAKE_OPTS@
 GIT_TEST_INDEX_VERSION=@GIT_TEST_INDEX_VERSION@
 GIT_TEST_PERL_FATAL_WARNINGS=@GIT_TEST_PERL_FATAL_WARNINGS@
 RUNTIME_PREFIX=@RUNTIME_PREFIX@
+GITWEBDIR=@GITWEBDIR@
+USE_GETTEXT_SCHEME=@USE_GETTEXT_SCHEME@
+LOCALEDIR=@LOCALEDIR@
+BROKEN_PATH_FIX=@BROKEN_PATH_FIX@
diff --git a/Makefile b/Makefile
index 8aaa5bbfe2bd11aa88b7578e17b9839b1b9b0a0b..d921c4d8e2c362b2f6f95984fca4a11a02c9967a 100644
--- a/Makefile
+++ b/Makefile
@@ -1558,10 +1558,10 @@ endif
 
 ifdef SANE_TOOL_PATH
 SANE_TOOL_PATH_SQ = $(subst ','\'',$(SANE_TOOL_PATH))
-BROKEN_PATH_FIX = 's|^\# @BROKEN_PATH_FIX@$$|git_broken_path_fix "$(SANE_TOOL_PATH_SQ)"|'
+BROKEN_PATH_FIX = s|^\# @BROKEN_PATH_FIX@$$|git_broken_path_fix "$(SANE_TOOL_PATH_SQ)"|
 PATH := $(SANE_TOOL_PATH):${PATH}
 else
-BROKEN_PATH_FIX = '/^\# @BROKEN_PATH_FIX@$$/d'
+BROKEN_PATH_FIX = /^\# @BROKEN_PATH_FIX@$$/d
 endif
 
 ifeq (,$(HOST_CPU))
@@ -2546,26 +2546,8 @@ GIT-SCRIPT-DEFINES: FORCE
 		echo "$$FLAGS" >$@; \
             fi
 
-define cmd_munge_script
-sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
-    -e 's|@SHELL_PATH@|$(SHELL_PATH_SQ)|' \
-    -e 's|@DIFF@|$(DIFF_SQ)|' \
-    -e 's|@LOCALEDIR@|$(localedir_SQ)|g' \
-    -e 's/@USE_GETTEXT_SCHEME@/$(USE_GETTEXT_SCHEME)/g' \
-    -e $(BROKEN_PATH_FIX) \
-    -e 's|@GITWEBDIR@|$(gitwebdir_SQ)|g' \
-    -e 's|@PERL_PATH@|$(PERL_PATH_SQ)|g' \
-    -e 's|@PAGER_ENV@|$(PAGER_ENV_SQ)|g' \
-    $@.sh >$@+
-endef
-
-$(SCRIPT_SH_GEN) : % : %.sh GIT-SCRIPT-DEFINES
-	$(QUIET_GEN)$(cmd_munge_script) && \
-	chmod +x $@+ && \
-	mv $@+ $@
-
-$(SCRIPT_LIB) : % : %.sh GIT-SCRIPT-DEFINES
-	$(QUIET_GEN)$(cmd_munge_script) && \
+$(SCRIPT_SH_GEN) $(SCRIPT_LIB) : % : %.sh generate-script.sh GIT-BUILD-OPTIONS GIT-SCRIPT-DEFINES
+	$(QUIET_GEN)./generate-script.sh "$<" "$@+" ./GIT-BUILD-OPTIONS && \
 	mv $@+ $@
 
 git.rc: git.rc.in GIT-VERSION-GEN GIT-VERSION-FILE
@@ -2635,8 +2617,8 @@ GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES Makefile
 perllibdir:
 	@echo '$(perllibdir_SQ)'
 
-git-instaweb: git-instaweb.sh GIT-SCRIPT-DEFINES
-	$(QUIET_GEN)$(cmd_munge_script) && \
+git-instaweb: git-instaweb.sh generate-script.sh GIT-BUILD-OPTIONS GIT-SCRIPT-DEFINES
+	$(QUIET_GEN)./generate-script.sh "$<" "$@+" ./GIT-BUILD-OPTIONS && \
 	chmod +x $@+ && \
 	mv $@+ $@
 else # NO_PERL
@@ -3193,6 +3175,10 @@ GIT-BUILD-OPTIONS: FORCE
 		-e "s|@GIT_TEST_INDEX_VERSION@|\'$(GIT_TEST_INDEX_VERSION)\'|" \
 		-e "s|@GIT_TEST_PERL_FATAL_WARNINGS@|\'$(GIT_TEST_PERL_FATAL_WARNINGS)\'|" \
 		-e "s|@RUNTIME_PREFIX@|\'$(RUNTIME_PREFIX)\'|" \
+		-e "s|@GITWEBDIR@|\'$(gitwebdir_SQ)\'|" \
+		-e "s|@USE_GETTEXT_SCHEME@|\'$(USE_GETTEXT_SCHEME)\'|" \
+		-e "s|@LOCALEDIR@|\'$(localedir_SQ)\'|" \
+		-e "s|@BROKEN_PATH_FIX@|\'$(BROKEN_PATH_FIX)\'|" \
 		GIT-BUILD-OPTIONS.in >$@+
 	@if grep -q '^[A-Z][A-Z_]*=@.*@$$' $@+; then echo "Unsubstituted build options in $@" >&2 && exit 1; fi
 	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 0f9180937e76cad4ad831d34877ea276413e76c9..7121fdfbc2ba50b4c7afb3f2b45fdaa5b9909a60 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -838,18 +838,23 @@ set(git_shell_scripts
 	${git_sh_scripts} ${git_shlib_scripts} git-instaweb)
 
 foreach(script ${git_shell_scripts})
-	file(STRINGS ${CMAKE_SOURCE_DIR}/${script}.sh content NEWLINE_CONSUME)
-	string(REPLACE "@SHELL_PATH@" "${SHELL_PATH}" content "${content}")
-	string(REPLACE "@DIFF@" "diff" content "${content}")
-	string(REPLACE "@LOCALEDIR@" "${LOCALEDIR}" content "${content}")
-	string(REPLACE "@GITWEBDIR@" "${GITWEBDIR}" content "${content}")
-	string(REPLACE "@NO_CURL@" "" content "${content}")
-	string(REPLACE "@USE_GETTEXT_SCHEME@" "" content "${content}")
-	string(REPLACE "# @BROKEN_PATH_FIX@" "" content "${content}")
-	string(REPLACE "@PERL_PATH@" "${PERL_PATH}" content "${content}")
-	string(REPLACE "@PAGER_ENV@" "LESS=FRX LV=-c" content "${content}")
-	file(WRITE ${CMAKE_BINARY_DIR}/${script} ${content})
+	if ("${script}" IN_LIST git_sh_scripts)
+		string(REPLACE ".sh" "" shell_gen_path "${script}")
+	else()
+		set(shell_gen_path "${script}")
+	endif()
+
+	add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/${shell_gen_path}"
+		COMMAND "${SH_EXE}" "${CMAKE_SOURCE_DIR}/generate-script.sh"
+			"${CMAKE_SOURCE_DIR}/${script}.sh"
+			"${CMAKE_BINARY_DIR}/${shell_gen_path}"
+			"${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS"
+		DEPENDS "${CMAKE_SOURCE_DIR}/generate-script.sh"
+			"${CMAKE_SOURCE_DIR}/${script}.sh"
+		VERBATIM)
+	list(APPEND shell_gen ${CMAKE_BINARY_DIR}/${shell_gen_path})
 endforeach()
+add_custom_target(shell-gen ALL DEPENDS ${shell_gen})
 
 #perl scripts
 parse_makefile_for_scripts(git_perl_scripts "SCRIPT_PERL" "")
@@ -1175,6 +1180,10 @@ string(REPLACE "@GIT_INTEROP_MAKE_OPTS@" "" git_build_options "${git_build_optio
 string(REPLACE "@GIT_TEST_INDEX_VERSION@" "" git_build_options "${git_build_options}")
 string(REPLACE "@GIT_TEST_PERL_FATAL_WARNINGS@" "" git_build_options "${git_build_options}")
 string(REPLACE "@RUNTIME_PREFIX@" "'${RUNTIME_PREFIX}'" git_build_options "${git_build_options}")
+string(REPLACE "@GITWEBDIR@" "'${GITWEBDIR}'" git_build_options "${git_build_options}")
+string(REPLACE "@USE_GETTEXT_SCHEME@" "" git_build_options "${git_build_options}")
+string(REPLACE "@LOCALEDIR@" "'${LOCALEDIR}'" git_build_options "${git_build_options}")
+string(REPLACE "@BROKEN_PATH_FIX@" "" git_build_options "${git_build_options}")
 if(USE_VCPKG)
 	string(APPEND git_build_options "PATH=\"$PATH:$TEST_DIRECTORY/../compat/vcbuild/vcpkg/installed/x64-windows/bin\"\n")
 endif()
diff --git a/generate-script.sh b/generate-script.sh
new file mode 100755
index 0000000000000000000000000000000000000000..d001e43d7bf1c4d72f41f805128ae42330a54558
--- /dev/null
+++ b/generate-script.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+
+set -e
+
+if test $# -ne 3
+then
+	echo "USAGE: $0 <INPUT> <OUTPUT> <GIT-BUILD-OPTIONS>" >&2
+	exit 1
+fi
+
+INPUT="$1"
+OUTPUT="$2"
+BUILD_OPTIONS="$3"
+
+. "$BUILD_OPTIONS"
+
+sed -e "1s|#!.*/sh|#!$SHELL_PATH|" \
+    -e "s|@SHELL_PATH@|$SHELL_PATH|" \
+    -e "s|@DIFF@|$DIFF|" \
+    -e "s|@LOCALEDIR@|$LOCALEDIR|g" \
+    -e "s/@USE_GETTEXT_SCHEME@/$USE_GETTEXT_SCHEME/g" \
+    -e "$BROKEN_PATH_FIX" \
+    -e "s|@GITWEBDIR@|$GITWEBDIR|g" \
+    -e "s|@PERL_PATH@|$PERL_PATH|g" \
+    -e "s|@PAGER_ENV@|$PAGER_ENV|g" \
+    "$INPUT" >"$OUTPUT"
+
+case "$(basename "$INPUT")" in
+git-mergetool--lib.sh|git-sh-i18n.sh|git-sh-setup.sh)
+	;;
+*)
+	chmod a+x "$OUTPUT"
+	;;
+esac

-- 
2.47.0.251.gb31fb630c0.dirty

