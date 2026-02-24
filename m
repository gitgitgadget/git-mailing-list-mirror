Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7013803DE
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 14:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771944025; cv=none; b=GyY4cP/EsIGThDQR9j2QZhTzWuHYYDZ6yRaUHGQkf9dyYMdGjL586rMCoGPbG0dd866qTmi7Lyi/09MmxlvGZd/WnklB998Ul12OaGlbX6kAaaVKvM4d+syaP3kYmxuFGqYZ8/iYx6XB5zqixcjyYGjmqyu8bp2aKJNgPM9lDZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771944025; c=relaxed/simple;
	bh=LZgvOO2CEkqbHA5kMw4UlPoejHdgvI23ORGbnSrcM4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WU25jGWaJcacvyqku5iV9UUchdimjJ4CzbwWdNAcHqscof+/W7eIZ0vH7zsP0CeNN/jvks2g0j0F9ZDpl7gBBtkYAQx1Bq6A4Aw+AIAsX4oZ8/CVLjR8buV/JSm46LDi8tPM687XPnyZab0zHjA3f7Gc1uJSGT9CApsQ425LNo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENOqHz3k; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENOqHz3k"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-794719afcd4so57625367b3.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 06:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771944022; x=1772548822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWmIIs3+ydWvhF/iIWtZ2EgtDN30/WnGjLK3qA2o5Vw=;
        b=ENOqHz3k3WDgxoyjX1H5qKuLlWpxRuehOmdpmYpcGIDWn2sAVmsqPgwf5W3eclnlv6
         26cYIrSR9n668mHySdrzJ+wLSc5pFnoa4+8Tlpxud4Vr2yrSAdRFb1kM2RCJgCpyQ+M4
         XnZ75hNUDt6CHSSRlrBT3sWGVXqZOh4y4B/aIkoBvNlBaMk1oD+xZ28hRXvroYZG8BeL
         L1FnlmQ+c62DfNGoBYh0tWzvpoFWcz2r9WRx9nLYgCINHfEvFBSAXFpdm4uazbu/6FNl
         VvCO4QYTeEHOL+KI3OEq4Lm7FPs2qOpOYBcTfrG9ZF+4MWOe4oY69yrQceZ5RTCVTXzd
         WLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771944022; x=1772548822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FWmIIs3+ydWvhF/iIWtZ2EgtDN30/WnGjLK3qA2o5Vw=;
        b=u+56Y2PIa+/c+Vh0XvghXjUgVSAwZOJ43xzDmUYOJEP4IEPdzZXJw9Z55oYKCe5A39
         RXMe4/1XdUjcEjLMzNzeKoCYUAcmlHVK6beyg3xD1qCdfTcgCTUyf+Vc2m8WJez8sQ/G
         OGbJkTCrTJVDfWLSdWk/GnO1UnK6PzT9fVSae1CNigQ0qGdcF+8luynCV19Hgp/MsCy6
         8vR0qf7wmdQuM9v6G/2gfpoLMaqnebrNA1crRwZ0Cwr5ldkRlj68otq1Wsrqt0tKe5qM
         cobujkZMy8NN86F0oqSapuWIqCbZm/NTQ+tRfUR6NqVE1JMuDpJbxjgCag1igpL/8c0d
         TLYw==
X-Gm-Message-State: AOJu0YyVbYC6xcAGadd5lp4nVHCiY1CvNN1a6gY61pt6eaI3Fk3rrxGu
	lqctX/Ep36F8GFfiD+DNa8f7CRB9ll+Fg0cPpHNxx8hI/Bj9OanFU/noENqwJq3O
X-Gm-Gg: ATEYQzxKCN10PMpzNY+Ux+7Yrqf4n/6bD+obECqZnUr5zFlrVf49S7wmYiH8ZpN/jKR
	/rGk+1aJPxkKh5MEwYiCKYCdXHNUk4zxUGYLAIaGAVoWHXAOZmngGuv6bnzzlJc2EOPbPmGlrzR
	zOHYIbYD+NR2Pc2qJCG2reUWDRYp2hYyxIZIoCvmg/YNPlfEzZWasOqBuTePUELbs6gib/smDCs
	RgvzeyW0IroATvvXXhtrbKg7db+ZTWuuWIvS50gXfd/tuMpW5Ta+QBCQTWSDElrFI3VTHxR5Jqk
	jSL995ZnySWyjDDp0PgF6tqwUn7Eydp2l12w5D3Ly8XbEbPRswF65P/+ftcJDZ0GPg+8cvG8i9D
	XSstrRU3fLlhx+vl0ahDVfDaXrZBKfSiocYU0ksf+MC+kwv45Qhtdl81o9/1XDsY/PbIsWjmd5O
	M9lwWDZeTKx+EtXkkQnjfWcChcT6n4CbTARhYdCixKVhfNmUdONpmDxdhafce8euTTRFidBNSDM
	zfr9oV8WUb9PbRM
X-Received: by 2002:a05:690c:9d:b0:796:6c4b:294c with SMTP id 00721157ae682-7982916355fmr99343807b3.56.1771944021637;
        Tue, 24 Feb 2026 06:40:21 -0800 (PST)
Received: from localhost.localdomain ([2605:a601:90eb:5600::9])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982db8f922sm45167707b3.3.2026.02.24.06.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 06:40:21 -0800 (PST)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Patrick Steinhardt <ps@pks.im>,
	Marc Branchaud <marcnarc@xiplink.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
	Evan Martin <evan.martin@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v7] build: regenerate config-list.h when Documentation changes
Date: Tue, 24 Feb 2026 09:39:44 -0500
Message-ID: <4ef96c6bbf698a08df1df87b7cb053b6d0d00822.1771943954.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.53.0.537.g7ffbde5f8a.dirty
In-Reply-To: <5dcd4e9308100a25603c50fecb36447c0ee4df62.1771682788.git.ben.knoble+github@gmail.com>
References: <5dcd4e9308100a25603c50fecb36447c0ee4df62.1771682788.git.ben.knoble+github@gmail.com>
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
Meson build. We honor the undocumented GCC/Clang contract of outputting
empty targets for all the dependencies (like they do with -MP). That is,
generate lines like

    build/config-list.h: $SOURCE_DIR/Documentation/config.adoc
    $SOURCE_DIR/Documentation/config.adoc:

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
    Changes from v6 (<5dcd4e9308100a25603c50fecb36447c0ee4df62.1771682788.git.ben.knoble+github@gmail.com>):
    
    • Fix Make-based builds when a dependency is removed by generating the
      expected empty targets. (Thanks to a report from Szeder Gábor.)

 Makefile               |  5 +++--
 generate-configlist.sh | 16 +++++++++++++++-
 meson.build            |  5 ++++-
 3 files changed, 22 insertions(+), 4 deletions(-)

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
index 75c39ade20..e28054f9e0 100755
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
 
@@ -36,3 +37,16 @@ print_config_list () {
 	echo
 	print_config_list
 } >"$OUTPUT"
+
+if test -n "$DEPFILE"
+then
+	QUOTED_OUTPUT="$(printf '%s\n' "$OUTPUT" | sed 's,[&/\],\\&,g')"
+	{
+		printf '%s\n' "$SOURCE_DIR"/Documentation/*config.adoc \
+			"$SOURCE_DIR"/Documentation/config/*.adoc |
+			sed -e 's/[# ]/\\&/g' -e "s/^/$QUOTED_OUTPUT: /"
+		printf '%s:\n' "$SOURCE_DIR"/Documentation/*config.adoc \
+			"$SOURCE_DIR"/Documentation/config/*.adoc |
+			sed -e 's/[# ]/\\&/g'
+	} >"$DEPFILE"
+fi
diff --git a/meson.build b/meson.build
index 6f155beafa..4b536e0124 100644
--- a/meson.build
+++ b/meson.build
@@ -722,11 +722,14 @@ endif
 
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

Diff-intervalle contre v6 :
1:  7ffbde5f8a ! 1:  4ef96c6bbf build: regenerate config-list.h when Documentation changes
    @@ Commit message
         Since Meson does not have (or want) builtin support for globbing like
         Make, teach generate-configlist.sh to also generate a list of
         Documentation files its output depends on, and incorporate that into the
    -    Meson build.
    +    Meson build. We honor the undocumented GCC/Clang contract of outputting
    +    empty targets for all the dependencies (like they do with -MP). That is,
    +    generate lines like
    +
    +        build/config-list.h: $SOURCE_DIR/Documentation/config.adoc
    +        $SOURCE_DIR/Documentation/config.adoc:
     
         We assume that if a user adds a new file under
         Documentation/config then they will also edit one of the existing files
    @@ Commit message
     
     
      ## Notes (benknoble/commits) ##
    -    Changes from v5 (<611a94cd988e3795bc63dba2f1b270aa0d058bd2.1771425395.git.ben.knoble+github@gmail.com>):
    +    Changes from v6 (<5dcd4e9308100a25603c50fecb36447c0ee4df62.1771682788.git.ben.knoble+github@gmail.com>):
     
    -    • Reword a confusing sentence in the commit message
    +    • Fix Make-based builds when a dependency is removed by generating the
    +      expected empty targets. (Thanks to a report from Szeder Gábor.)
     
      ## Makefile ##
     @@ Makefile: $(BUILT_INS): git$X
    @@ generate-configlist.sh: print_config_list () {
     +if test -n "$DEPFILE"
     +then
     +	QUOTED_OUTPUT="$(printf '%s\n' "$OUTPUT" | sed 's,[&/\],\\&,g')"
    -+	printf '%s\n' "$SOURCE_DIR"/Documentation/*config.adoc \
    -+		"$SOURCE_DIR"/Documentation/config/*.adoc |
    -+		sed -e 's/[# ]/\\&/g' -e "s/^/$QUOTED_OUTPUT: /" >"$DEPFILE"
    ++	{
    ++		printf '%s\n' "$SOURCE_DIR"/Documentation/*config.adoc \
    ++			"$SOURCE_DIR"/Documentation/config/*.adoc |
    ++			sed -e 's/[# ]/\\&/g' -e "s/^/$QUOTED_OUTPUT: /"
    ++		printf '%s:\n' "$SOURCE_DIR"/Documentation/*config.adoc \
    ++			"$SOURCE_DIR"/Documentation/config/*.adoc |
    ++			sed -e 's/[# ]/\\&/g'
    ++	} >"$DEPFILE"
     +fi
     
      ## meson.build ##

base-commit: 309c995771be952610fdcff99f7fea96934ce045
-- 
2.53.0.537.g7ffbde5f8a.dirty

