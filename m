Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F87C10FD
	for <git@vger.kernel.org>; Sat, 21 Feb 2026 14:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771682852; cv=none; b=F0MOCVT1iLD1MRKFR3ddiW84+mQuw7MigqbbqZZG9gEvUXDTck3R/UZmvGP4ZOHEEvfEFiRLmckr/+w9GKo99aS8pxOF4PXJUUOZJFZTnh13OVDaL1ktL1NoC2LZw9XkcCciTgws25UWCjbxz6L4Myjpv0Xnz5pgO1Wnn+EhpU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771682852; c=relaxed/simple;
	bh=IiFDJKAI1zjf2kXa2FDatTdDX2aqMhnsUOdeBMVFkEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LsK4gG0O+EI96qpb7h1UJmLpoLPANXQsT0TIYFdNwPWwkVtek7nQfrnl694BFc6PW1toqNODts6VruhwaWo8z6MWoHzU72IVCRaoFS+CT3c33srtu0Pi/A8lKwE2cMAzcU6h5727mi0kCWvY2k3FysQ1tuVDZCsZRmX+b4i3uRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4VDD2RC; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4VDD2RC"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-79827d28feaso9283977b3.3
        for <git@vger.kernel.org>; Sat, 21 Feb 2026 06:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771682850; x=1772287650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s02UO1avsTEnvFgDYmJr6iXuvLrni41wjWmkzuWvdGQ=;
        b=G4VDD2RCCHYOELWEWJzRU8e2nSIqpXZDz9nRx6WjHDGSc6fFTBc3TslDq7pt01G/jO
         DbHZRbjzd8Igo5Fw2GFUB9ZjZLWSoruJReR+cZQ6zakdzAwltPVRddrzWFHtRp0O9jem
         uo3TRIukM8A+n0c6y1xSKOfLaaPgp9UzV93Isx5rIttQOcKcrG12fVc5BwC2sv9swUAf
         EcNmF0txSOabx83iHAODWUpdrTv+B0qB6y9kHo1P112CjY+QPEPNcZw1ZtEU3jH1DMDa
         UpEA61hIdFnxWiSooRfpHm9CoPgZgacu4hFwNgr19t7fxYWepYWfwAv8niYsezgE7B4V
         PTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771682850; x=1772287650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s02UO1avsTEnvFgDYmJr6iXuvLrni41wjWmkzuWvdGQ=;
        b=GahHWTu0rjsVi9FpCGXFJMPC6Ro7kbICXWpAm1ONXSqXu4WYW3JRcKBNrgZ0OXpxqk
         IG1hO2+Z10ZckbPe3yxviM0YOIPODmFyOWYrjPWZWZoGDfmEqw4yp9qjHTKNIlQ8yqNb
         xp60QRU7bXrSbuyNcQIEal6lm385OkVJJ6Ue0EAabsjsnop0Obn+vKxJuWVBrX2zTi7O
         eXmjNaU0h/7+IetkCUB3VYmne6MmCImuajzW7gMDHx3yx+rASLQBNuTzALboabCoigRe
         kipN6ZMcZsHvf95Pts/mLKCwUhR9x+4CBN4TRFEuFZi8l6xcgfxL+VbStN8Gg/uOy3Da
         0TTg==
X-Gm-Message-State: AOJu0YylphRqLc2YdKTLm51pR+BhpLBnW+wTvm29dXZUxJRVq0SP1qkX
	ShHOIbBnOhfifdcbghUiGtcW96SwdhZfhq7aZ+Wj1xbQ6nZf+g3JJYTGaLyxiPK3
X-Gm-Gg: AZuq6aJJZkox+DKYHRffqJ8EFWDAY+bYBrQQReGE0x8qBlwg3PoX0GJr6CK7pyxCD5E
	XZeniCktvJ8ARx6sLCvSjpQljR2X6drqNOj2nm8j8buzkVP0LlC2u8MVmosw2afG/+1+G/4cnaz
	LWrOLKFN0rR+wFyqRwEKw/Bz87KCnwM31um/n1aYfMsa75r0Jb3oE2Pr5C9dSneZlaXuvlfnuP4
	NRKZLenRCsg9ttcN2vQ4wW69w9rABOVl0xAEpldqaCBbdLUYw+urD8hp5dOWfEEWxNfp2a80+Bo
	Yf+Kf4Uu+V+THB3TIvN2VJNzTnP8J86QD2jF7U+pxojDB+magakaIdVnmGu+DHm6wj0oU5lXdmm
	PlR2pSaKhUtbzDruvhFcWiyIeIEgom1RtDLnuV4ur8+45nUJbNC3zfx8RbAFB9ghhiH/1eFUEZN
	OXys0K51HKPl4ESk6RiKzFFSdZlVNJLL80uv91dbGyj0ZL7tnmko9wPC53HwScylnsQcAFVL/zb
	Eor4vCor22xGAhfTFjqXAlUrOyX5YSUBlC46s2Ssh2oKjwc
X-Received: by 2002:a05:690c:c4fa:b0:794:e348:fc4b with SMTP id 00721157ae682-79828cf3ef4mr28021837b3.13.1771682849932;
        Sat, 21 Feb 2026 06:07:29 -0800 (PST)
Received: from macaroon.lan ([2605:a601:90eb:5600:bd86:3f2a:ab6:399a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982db94290sm9939717b3.1.2026.02.21.06.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 06:07:29 -0800 (PST)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Patrick Steinhardt <ps@pks.im>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Evan Martin <evan.martin@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6] build: regenerate config-list.h when Documentation changes
Date: Sat, 21 Feb 2026 09:07:17 -0500
Message-ID: <5dcd4e9308100a25603c50fecb36447c0ee4df62.1771682788.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <611a94cd988e3795bc63dba2f1b270aa0d058bd2.1771425395.git.ben.knoble+github@gmail.com>
References: <611a94cd988e3795bc63dba2f1b270aa0d058bd2.1771425395.git.ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Meson-based build doesn't know when to rebuild config-list.h, so the
header is sometimes stale.

For example, an old build directory might have config-list.h from before
4173df5187 (submodule: introduce extensions.submodulePathConfig,
2026-01-12), which added submodule.<name>.gitdir to the list. Without
it, t9902-completion.sh fails. Regenerating the config-list.h artifact
from sources fixes the artifact and the test.

Since Meson does not have (or want) builtin support for globbing like
Make, teach generate-configlist.sh to also generate a list of
Documentation files its output depends on, and incorporate that into the
Meson build.

We assume that if a user adds a new file under
Documentation/config then they will also edit one of the existing files
to include that new file, and that will trigger a rebuild. Also mark the
generator script as a dependency.

While we're at it, teach the Makefile to use the same "the script knows
it's dependencies" logic.

For Meson, combining the following commands helps debug dependencies:

    ninja -C <builddir> -t deps config-list.h
    ninja -C <builddir> -t browse config-list.h

The former lists all the dependencies discovered from our output ".d"
file (the config documentation) and the latter shows the dependency on
the script itself, among other useful edges in the dependency graph.

Helped-by: Patrick Steinhardt <ps@pks.im>
Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---

Notes (benknoble/commits):
    Changes from v5 (<611a94cd988e3795bc63dba2f1b270aa0d058bd2.1771425395.git.ben.knoble+github@gmail.com>):
    
    • Reword a confusing sentence in the commit message

 Makefile               |  5 +++--
 generate-configlist.sh | 11 ++++++++++-
 meson.build            |  5 ++++-
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 7f37ad8f58..6f926ffb1f 100644
--- a/Makefile
+++ b/Makefile
@@ -2688,9 +2688,10 @@ $(BUILT_INS): git$X
 	cp $< $@
 
 config-list.h: generate-configlist.sh
+	@mkdir -p .depend
+	$(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh . $@ .depend/config-list.h.d
 
-config-list.h: Documentation/*config.adoc Documentation/config/*.adoc
-	$(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh . $@
+-include .depend/config-list.h.d
 
 command-list.h: generate-cmdlist.sh command-list.txt
 
diff --git a/generate-configlist.sh b/generate-configlist.sh
index 75c39ade20..39ac8845ab 100755
--- a/generate-configlist.sh
+++ b/generate-configlist.sh
@@ -2,10 +2,11 @@
 
 SOURCE_DIR="$1"
 OUTPUT="$2"
+DEPFILE="$3"
 
 if test -z "$SOURCE_DIR" || ! test -d "$SOURCE_DIR" || test -z "$OUTPUT"
 then
-	echo >&2 "USAGE: $0 <SOURCE_DIR> <OUTPUT>"
+	echo >&2 "USAGE: $0 <SOURCE_DIR> <OUTPUT> [<DEPFILE>]"
 	exit 1
 fi
 
@@ -36,3 +37,11 @@ print_config_list () {
 	echo
 	print_config_list
 } >"$OUTPUT"
+
+if test -n "$DEPFILE"
+then
+	QUOTED_OUTPUT="$(printf '%s\n' "$OUTPUT" | sed 's,[&/\],\\&,g')"
+	printf '%s\n' "$SOURCE_DIR"/Documentation/*config.adoc \
+		"$SOURCE_DIR"/Documentation/config/*.adoc |
+		sed -e 's/[# ]/\\&/g' -e "s/^/$QUOTED_OUTPUT: /" >"$DEPFILE"
+fi
diff --git a/meson.build b/meson.build
index 762e2d0fc0..74b459b004 100644
--- a/meson.build
+++ b/meson.build
@@ -720,11 +720,14 @@ endif
 
 builtin_sources += custom_target(
   output: 'config-list.h',
+  depfile: 'config-list.h.d',
+  depend_files: [ 'generate-configlist.sh' ],
   command: [
     shell,
-    meson.current_source_dir() + '/generate-configlist.sh',
+    meson.current_source_dir() / 'generate-configlist.sh',
     meson.current_source_dir(),
     '@OUTPUT@',
+    '@DEPFILE@',
   ],
   env: script_environment,
 )

Diff-intervalle contre v5 :
1:  611a94cd98 ! 1:  5dcd4e9308 build: regenerate config-list.h when Documentation changes
    @@ Commit message
         it, t9902-completion.sh fails. Regenerating the config-list.h artifact
         from sources fixes the artifact and the test.
     
    -    Teach the meson build to depend on the Documentation files that
    -    generate-configlist.sh reads by having it an additional output as a list
    -    of dependency files, since Meson does not have (or want) builtin support
    -    for globbing like Make. We assume that if a user adds a new file under
    +    Since Meson does not have (or want) builtin support for globbing like
    +    Make, teach generate-configlist.sh to also generate a list of
    +    Documentation files its output depends on, and incorporate that into the
    +    Meson build.
    +
    +    We assume that if a user adds a new file under
         Documentation/config then they will also edit one of the existing files
         to include that new file, and that will trigger a rebuild. Also mark the
         generator script as a dependency.
    @@ Commit message
     
     
      ## Notes (benknoble/commits) ##
    -    Changes from v4 (<9cdcc9de04f0f8fff657f0474b31c063466ed808.1771280837.git.ben.knoble+github@gmail.com>):
    +    Changes from v5 (<611a94cd988e3795bc63dba2f1b270aa0d058bd2.1771425395.git.ben.knoble+github@gmail.com>):
     
    -    • Include Patrick's suggested Makefile changes. Note there's no quiet
    -      equivalent for mdkir that isn't for the current target's containing
    -      directory…
    -    • Make depfile output efficient again, thanks to Phillip.
    -
    -    I've kept printf instead of echo (from Patrick/Junio) because I think it
    -    is easier to reason about ("it works" vs. "did I use this in a way that
    -    might cause problems").
    -
    -    Junio asked about other problematic bytes: the other one I could think
    -    of (since all the inputs should be paths, anyway) is newlines. I gave
    -    meson's depfile.py a glance [1], and it looks like they don't handle
    -    newlines in paths. Other whitespace doesn't appear to be an issue (see
    -    "elif c in {' ', '\n'}"); I think _most_ characters are just added to
    -    the filename.
    -
    -    [1]: https://github.com/mesonbuild/meson/blob/master/mesonbuild/depfile.py
    +    • Reword a confusing sentence in the commit message
     
      ## Makefile ##
     @@ Makefile: $(BUILT_INS): git$X

base-commit: 4a7958ca1415077ce9b1d0a38223ede55da779d9
-- 
2.53.0

