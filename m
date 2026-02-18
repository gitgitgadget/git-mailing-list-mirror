Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B5B328263
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 14:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771425506; cv=none; b=uQp/8/mmIIiAoAWBNKK2DgIU4N9gD2XY3TnfDOOPJYmhbMuGZOsGZjxpo0xxTdf2BwLP+kzWqjX6zx6NDsrB3+1ujeeoSCgpt1yHbl3xOPMb/RvGqcAyW6xdQi0iOhCqQOezOIfwPofsMQJIMKwIIJSM2dIK8myUEsv7mGaEIDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771425506; c=relaxed/simple;
	bh=aAQMUNzfiiLobmohVP+zpjABy7I2u+wf5lEa2cgYxQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f+utIahWOK+9Gv/H7MaWXSOdHscj8kR0SsdhsM/9Od6M+SIgSVnx5FrYaeu4aVfh2lNL0L6qFmCUr9roY0MURjnHxOCxzQyRzvAA+9GMyp2AKcX2SMEZRsY1g/h8w7VPXy8IfTgh/VcmH3KLb7EgCDP3ILZkITDOEywOb6Wkxus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WDosrf+m; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDosrf+m"
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-7945838691aso11770857b3.0
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 06:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771425504; x=1772030304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bL87VCXQd+0zPV9+PmeBtEnjXxAKrRC+DJqdK5IY6E=;
        b=WDosrf+m5nmE7RApBmZqPks+gJXVCyePYmOfAh4U60Z7fBB9Kamo46dfXKqCMfYw6W
         tLnWKUfWpu0/3BA0QwKxD7eLpISJrTt3Pkucw55rTd7+uspBOU/AoF8fs+mvNJejtgEq
         rZ/8qRaHYFOvooVFAchsAJyeuKibcZvpw8dnVMlThDzkoup99h/a60F6eUdikchvIy5z
         VfBCp5+fbbhQtiHx29N6bTh6CP6ORJFeTeCaGR1Fv2SWXAwuiWsy7WepKgQb5arDE0SL
         YuaRsWd6EFTfF2f6KPGok4YdoWkzzuwQgtZi5z1O0CO6On51K9q16yWkeiSukiOw0oGv
         I+5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771425504; x=1772030304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2bL87VCXQd+0zPV9+PmeBtEnjXxAKrRC+DJqdK5IY6E=;
        b=qSjAbhPBmIDA1LsnYHqPMY6clkKk4Jw+4aXJ/TZ45qRsl8ER2xds7fROt1p3TNmruc
         Y1tCRZJx6VSXrsVjjnRALUCiYP2+7kGqJ7Du+lC1nVL+VCRfF7UuWq2zOX/+Zeh/8EN7
         6+QGk5fRl5rttBzz6Rl40IMxSNsPnM2Z9b5Wd0Mcv5H0e/5MZ/uoE+TA/+VVunF0q/l6
         /Y3Z6AhZOsDlWzv+j/Fv+LYa85x/AO/uzcpwVGbkWNWXWfTFnYPBEJMzELzR61Hbb1P/
         tH5ofWCBaCOMQMrE0GKILiBa6wdL4JugdM7g5G6w6JZ5PHhBn0RxiaOY2gnvPOvEUrB8
         jIxQ==
X-Gm-Message-State: AOJu0Ywj7tvfndOcTTHvXpdfzmKmlDrnNkEUZqctAPaUL8sYMKxrDGAP
	xSHCGZdx5QHXxU3QnIFR58ZBsDRGk7t4bgsn1h8Em70+n6uG8Hndl0JrVupT5dDL
X-Gm-Gg: AZuq6aJt+xEduZRQsD4flV3p2hund3nxRtSu1uEBwLWWlnWNTH8S13UkVNvdUWyW3RQ
	5cIPCT6gdbo7M/rD2KmwBkUWGxD5onpj/zQfY4QpfaU2qYpkab2tTOT8JBMUJaUBO4+YA1zP8Nm
	WtH81ELEUaPNFQwH4nylJmPoTGSjXRgdb5vxSs0VRTxbrQ3ltH7fOXiBVDz3LDituL5JyBEC+6W
	aogWn+a/X0LL+tv3vKOqPtGbFsXWDoe4tfrIlbRRxfnP8AEZpCH4+IuEsXPJBqK+PZhB8ecdpeg
	wAaT0KbNiyrFfKKBOcbv2+EBn/snC1jrT7kWsHaHbSAv76s9nXnmQLEDa150GsdElPxPxr9qBZq
	1m6kcwo09zZ8sGjCw4yuseJppH1yQrfawyJhGN/uLrmHFWiAryECZPUj/jI8WMAkgyqw7d9Im/Y
	9gzGKvBp1X0O8UfvdPSK7Wbz6uZOBWUAaskX0m5r4JCbodfCQpc+yLPO0Oi5Es13xtroifxLsys
	HJr5VpKvQm8h4HoI9RY/8m9PmmuVzW4aHCWN4oxMLG/OjW7
X-Received: by 2002:a05:690e:1c0e:b0:64a:d6b4:948a with SMTP id 956f58d0204a3-64c557eac80mr1351737d50.7.1771425503942;
        Wed, 18 Feb 2026 06:38:23 -0800 (PST)
Received: from macaroon.lan ([2605:a601:90eb:5600:bd86:3f2a:ab6:399a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64c22e6f005sm6062807d50.3.2026.02.18.06.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 06:38:23 -0800 (PST)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Evan Martin <evan.martin@gmail.com>
Subject: [PATCH v5] build: regenerate config-list.h when Documentation changes
Date: Wed, 18 Feb 2026 09:37:59 -0500
Message-ID: <611a94cd988e3795bc63dba2f1b270aa0d058bd2.1771425395.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <9cdcc9de04f0f8fff657f0474b31c063466ed808.1771280837.git.ben.knoble+github@gmail.com>
References: <9cdcc9de04f0f8fff657f0474b31c063466ed808.1771280837.git.ben.knoble+github@gmail.com>
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

Teach the meson build to depend on the Documentation files that
generate-configlist.sh reads by having it an additional output as a list
of dependency files, since Meson does not have (or want) builtin support
for globbing like Make. We assume that if a user adds a new file under
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
    Changes from v4 (<9cdcc9de04f0f8fff657f0474b31c063466ed808.1771280837.git.ben.knoble+github@gmail.com>):
    
    • Include Patrick's suggested Makefile changes. Note there's no quiet
      equivalent for mdkir that isn't for the current target's containing
      directory…
    • Make depfile output efficient again, thanks to Phillip.
    
    I've kept printf instead of echo (from Patrick/Junio) because I think it
    is easier to reason about ("it works" vs. "did I use this in a way that
    might cause problems").
    
    Junio asked about other problematic bytes: the other one I could think
    of (since all the inputs should be paths, anyway) is newlines. I gave
    meson's depfile.py a glance [1], and it looks like they don't handle
    newlines in paths. Other whitespace doesn't appear to be an issue (see
    "elif c in {' ', '\n'}"); I think _most_ characters are just added to
    the filename.
    
    [1]: https://github.com/mesonbuild/meson/blob/master/mesonbuild/depfile.py

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

Diff-intervalle contre v4 :
1:  e2f4e1f9ba < -:  ---------- completion: add stash import, export
2:  9cdcc9de04 ! 1:  611a94cd98 meson: regenerate config-list.h when Documentation changes
    @@ Metadata
     Author: D. Ben Knoble <ben.knoble+github@gmail.com>
     
      ## Commit message ##
    -    meson: regenerate config-list.h when Documentation changes
    +    build: regenerate config-list.h when Documentation changes
     
         The Meson-based build doesn't know when to rebuild config-list.h, so the
         header is sometimes stale.
    @@ Commit message
         of dependency files, since Meson does not have (or want) builtin support
         for globbing like Make. We assume that if a user adds a new file under
         Documentation/config then they will also edit one of the existing files
    -    to include that new file, and that will trigger a rebuild.
    +    to include that new file, and that will trigger a rebuild. Also mark the
    +    generator script as a dependency.
     
    -    Also mark the generator script as a dependency.
    +    While we're at it, teach the Makefile to use the same "the script knows
    +    it's dependencies" logic.
     
    -    Combining the following commands helps debug dependencies:
    +    For Meson, combining the following commands helps debug dependencies:
     
             ninja -C <builddir> -t deps config-list.h
             ninja -C <builddir> -t browse config-list.h
    @@ Commit message
     
     
      ## Notes (benknoble/commits) ##
    -    Changes from v3 (<0a344f1f3ee4a5d95c6f46df030b9936db4354a1.1770853297.git.ben.knoble+github@gmail.com>):
    +    Changes from v4 (<9cdcc9de04f0f8fff657f0474b31c063466ed808.1771280837.git.ben.knoble+github@gmail.com>):
     
    -    • Include the script itself as a dependency via depfile
    -    • Fix output path escaping (spaces, octothorpes; drop backslashes) for
    -      Ninja (I've used a loop because I couldn't find a portable construct
    -      that could escape only the remainder of the lines in the way I
    -      wanted).
    -    • Mention our assumptions about Documentation updates triggering
    -      rebuilds
    -    • Also include some debugging information in the commit message
    +    • Include Patrick's suggested Makefile changes. Note there's no quiet
    +      equivalent for mdkir that isn't for the current target's containing
    +      directory…
    +    • Make depfile output efficient again, thanks to Phillip.
    +
    +    I've kept printf instead of echo (from Patrick/Junio) because I think it
    +    is easier to reason about ("it works" vs. "did I use this in a way that
    +    might cause problems").
    +
    +    Junio asked about other problematic bytes: the other one I could think
    +    of (since all the inputs should be paths, anyway) is newlines. I gave
    +    meson's depfile.py a glance [1], and it looks like they don't handle
    +    newlines in paths. Other whitespace doesn't appear to be an issue (see
    +    "elif c in {' ', '\n'}"); I think _most_ characters are just added to
    +    the filename.
    +
    +    [1]: https://github.com/mesonbuild/meson/blob/master/mesonbuild/depfile.py
    +
    + ## Makefile ##
    +@@ Makefile: $(BUILT_INS): git$X
    + 	cp $< $@
    + 
    + config-list.h: generate-configlist.sh
    ++	@mkdir -p .depend
    ++	$(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh . $@ .depend/config-list.h.d
    + 
    +-config-list.h: Documentation/*config.adoc Documentation/config/*.adoc
    +-	$(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh . $@
    ++-include .depend/config-list.h.d
    + 
    + command-list.h: generate-cmdlist.sh command-list.txt
    + 
     
      ## generate-configlist.sh ##
     @@
    @@ generate-configlist.sh: print_config_list () {
     +
     +if test -n "$DEPFILE"
     +then
    -+	for doc in "$SOURCE_DIR"/Documentation/*config.adoc \
    -+		"$SOURCE_DIR"/Documentation/config/*.adoc
    -+	do
    -+		printf "$OUTPUT: %s\n" "$(printf '%s\n' "$doc" | sed 's/[# ]/\\&/g')"
    -+	done >"$DEPFILE"
    ++	QUOTED_OUTPUT="$(printf '%s\n' "$OUTPUT" | sed 's,[&/\],\\&,g')"
    ++	printf '%s\n' "$SOURCE_DIR"/Documentation/*config.adoc \
    ++		"$SOURCE_DIR"/Documentation/config/*.adoc |
    ++		sed -e 's/[# ]/\\&/g' -e "s/^/$QUOTED_OUTPUT: /" >"$DEPFILE"
     +fi
     
      ## meson.build ##

base-commit: f7e9f6c205466443107228e036b20acb7baa8c50
-- 
2.53.0

