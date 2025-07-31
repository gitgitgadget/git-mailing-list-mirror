Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9E829E0FF
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 08:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753949274; cv=none; b=ugIbRkrYJQcH8Pj+jZs+oc/fzkfNGfwBgrM0nYDqzLmt9v/I40c342wPk2YGq9W1LF6QlSHfhLoPBEnB5226rIcA6F7UgZct7yBR28lIEqhsJL+ITvXQNetyyPzFRcgeHffv1oBNmEdXPlwrn0wtE2qPb/pwCMwQEjtfQc6fAMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753949274; c=relaxed/simple;
	bh=BoNdETEYWal6pgoJw5lBAWi6J6g/H2VXTyGK8ceWowc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IMFzLTUozDMupL0kmiOZ0R+jfL59GjXceWgsD29LeYUBDj0pZJ99iujBrbeGsUmtJcwA4anFbO2HkL9Ga4xWFyXXkHLc2dKQNleDqKs3DIUkLlcrbeNvQ46mm7qvKtPI878XEtLF6n3h7V2Aw21K0i6DUNhY6RM5V1AqRX89nms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ym64mrrK; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ym64mrrK"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24049d16515so6366525ad.1
        for <git@vger.kernel.org>; Thu, 31 Jul 2025 01:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753949272; x=1754554072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OV9RWbzg7J2UduWNKSWzdBm1/GXvvLh1YsTLtmspf7w=;
        b=Ym64mrrKaMgeQ3Hia+tPzylTogQX1dlMO8I3W6fKe1/NALWTo7gees6rVGlrmPJe2W
         zzATSqibTMX0e0sBzXkZY53GSWkt2D5S/lIGObp5atPiroYiiExrRYfpju1ffz0TitHs
         4YLOzyTc+malZIChIbqqws2PKXDLGQbvTcbTtDbf6Z6UIzz8FBwQBcirxrAawRjgOEJf
         NNxO0s4JX8HbTQZo3Y5NMd9SDD2aPIXKkjoFw5IXKJFtVhRv7nQ5tqYmRUQttMwNd7Fa
         Nlz0rn3uupWep74+/57aQ9Yf87k6/r+PQmN9/2CeU4znfRb5DFtNqkrIncxL0nKc3M2I
         2sgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753949272; x=1754554072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OV9RWbzg7J2UduWNKSWzdBm1/GXvvLh1YsTLtmspf7w=;
        b=iaSAYYiQK8Uv1IkeLnLxnKGSJwe1svxmmj/u3g/zp9xNR+OSVJRbV2rYs62jkDJUvN
         z9fhjNVvk5NGP1YZWbmUznAxyyEXGpdhniYAUtzveGcoCXbtqD/iL3XCOV6w7JdU9WFQ
         w0BZcqb0GQVUuCrEA94O4kQJmDrAxhNmnkGTiOmyciIakxe3Sok3aZN3V+1/PbDbMnFZ
         4onpQ+d4G6RWAZyIMQ6fD3/CX3L3fC6WH88M6U3aOdYG9eSMXFMES7c9/PAxzhK/eG9R
         pSUXbmRpsF9C8Vn3dHvrLsUTUriXDG7JZsocInzW310ZRY0Bq3uqFtlN7PhlS+nzWxDu
         eRNQ==
X-Gm-Message-State: AOJu0Yx8OS9f0lODP8FZCqaTB0Eu4I93QBJ0myHgvF5/9bTZ8pDzBnrj
	TwXvh8GLXxLotE56fj6QSiLn7l5uTr28AzkDsjfgDc1164npd9VaZZJchBPTvA==
X-Gm-Gg: ASbGncuqm+NNhZViaHuWpSikEG0D8Omc9DhBJtPhG9DSgguXIrIy8zb5cMkSWpkwVVt
	QrKXr3Kn5a7JQ4Jpq26t+XAv052iIc7tkAgoENcpkP6eHJvhUw6j7xKJFZqyLQNd2FEHvF8De7Y
	l8wZJPud2ZjcIdrnZap/gQIbqqdauyqfs45Vm4vTEWzFuYgUBudgBv4D69CATTTlS18ylXhdm1d
	MPXVbogVPv2aFPP8W2bgQL5AaFeATvhbOruf51gt/C3jS0vdou9v2gkPUMu1kwVXjyGxRXIdhGV
	U0kJTVb6opBDaToVYcxa8Q8bxS3DFvguDxWzErngLIJ2wzvdfK7sdgOjPT2LvoteneOpaH+qi9G
	LGtjhpj4GIC6Dy1rFsp97mKrB+U128RfUO0iFdEvapa5bqm3WGxmnjtKr/Q9z1YtX7nGXjtoz6b
	aJswhT/+8=
X-Google-Smtp-Source: AGHT+IGKL9437Atei7I/w15p6rQuGada+/doR8kJFJ8EScfDIeUKDKy4oXjmcb5+lTAG9kbJF60iKw==
X-Received: by 2002:a17:902:e809:b0:234:f4da:7ecf with SMTP id d9443c01a7336-24096ac57b3mr74306835ad.8.1753949272037;
        Thu, 31 Jul 2025 01:07:52 -0700 (PDT)
Received: from localhost.localdomain (c-73-70-17-6.hsd1.ca.comcast.net. [73.70.17.6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3207eba6b69sm1237309a91.2.2025.07.31.01.07.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 31 Jul 2025 01:07:51 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
To: git@vger.kernel.org
Cc: j6t@kdbg.org,
	johannes.schindelin@gmx.de,
	mlevedahl@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Subject: [PATCH v2 4/5] git-gui: honor TCLTK_PATH in git-gui--askpass
Date: Thu, 31 Jul 2025 01:06:27 -0700
Message-ID: <20250731080628.27917-5-carenas@gmail.com>
X-Mailer: git-send-email 2.50.1.475.ge15fa7359c
In-Reply-To: <20250731080628.27917-1-carenas@gmail.com>
References: <20250730164052.15371-1-carenas@gmail.com>
 <20250731080628.27917-1-carenas@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since its introduction in 8c76212 (git-gui: Add a simple implementation
of SSH_ASKPASS., 2008-10-15), git-gui--askpass has been calling whatever
wish interpreter is in the path, unlike git-gui.

Correct that by turning it into a script that would be processed at build
time.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 .gitignore                              |  1 +
 Makefile                                |  7 +++++--
 generate-script.sh                      | 22 ++++++++++++++++++++++
 git-gui--askpass => git-gui--askpass.sh |  0
 meson.build                             | 22 ++++++++++++++--------
 5 files changed, 42 insertions(+), 10 deletions(-)
 create mode 100755 generate-script.sh
 rename git-gui--askpass => git-gui--askpass.sh (100%)

diff --git a/.gitignore b/.gitignore
index ba845f3..5130b4f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -4,4 +4,5 @@ git-gui.tcl
 GIT-GUI-BUILD-OPTIONS
 GIT-VERSION-FILE
 git-gui
+git-gui--askpass
 lib/tclIndex
diff --git a/Makefile b/Makefile
index 2ac5f44..2cd160b 100644
--- a/Makefile
+++ b/Makefile
@@ -173,10 +173,13 @@ GIT-GUI-BUILD-OPTIONS: FORCE
 	@if grep -q '^[A-Z][A-Z_]*=@.*@$$' $@+; then echo "Unsubstituted build options in $@" >&2 && exit 1; fi
 	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
 
+git-gui--askpass: git-gui--askpass.sh GIT-GUI-BUILD-OPTIONS generate-script.sh
+	$(QUIET_GEN)$(SHELL_PATH) generate-script.sh $@ $< ./GIT-GUI-BUILD-OPTIONS
+
 ifdef GITGUI_WINDOWS_WRAPPER
 all:: git-gui
 endif
-all:: $(GITGUI_MAIN) lib/tclIndex $(ALL_MSGFILES)
+all:: $(GITGUI_MAIN) git-gui--askpass lib/tclIndex $(ALL_MSGFILES)
 
 install: all
 	$(QUIET)$(INSTALL_D0)'$(DESTDIR_SQ)$(gitexecdir_SQ)' $(INSTALL_D1)
@@ -215,7 +218,7 @@ dist-version: GIT-VERSION-FILE
 	@sed 's|^GITGUI_VERSION=||' <GIT-VERSION-FILE  >$(TARDIR)/version
 
 clean::
-	$(RM_RF) $(GITGUI_MAIN) lib/tclIndex po/*.msg $(PO_TEMPLATE)
+	$(RM_RF) $(GITGUI_MAIN) git-gui--askpass lib/tclIndex po/*.msg $(PO_TEMPLATE)
 	$(RM_RF) GIT-VERSION-FILE GIT-GUI-BUILD-OPTIONS
 ifdef GITGUI_WINDOWS_WRAPPER
 	$(RM_RF) git-gui
diff --git a/generate-script.sh b/generate-script.sh
new file mode 100755
index 0000000..0dd2da9
--- /dev/null
+++ b/generate-script.sh
@@ -0,0 +1,22 @@
+#!/bin/sh
+
+set -e
+
+if test $# -ne 3
+then
+	echo >&2 "USAGE: $0 <OUTPUT> <INPUT> <GIT-GUI-BUILD-OPTIONS>"
+	exit 1
+fi
+
+OUTPUT="$1"
+INPUT="$2"
+BUILD_OPTIONS="$3"
+
+. "$BUILD_OPTIONS"
+
+sed \
+	-e "1s|#!.*/sh|#!$SHELL_PATH|" \
+	-e "1,3s|^exec wish|exec '$TCLTK_PATH'|" \
+	"$INPUT" >"$OUTPUT"
+
+chmod a+x "$OUTPUT"
diff --git a/git-gui--askpass b/git-gui--askpass.sh
similarity index 100%
rename from git-gui--askpass
rename to git-gui--askpass.sh
diff --git a/meson.build b/meson.build
index 1cedc82..320ba09 100644
--- a/meson.build
+++ b/meson.build
@@ -38,14 +38,6 @@ version_file = custom_target(
   build_always_stale: true,
 )
 
-configure_file(
-  input: 'git-gui--askpass',
-  output: 'git-gui--askpass',
-  copy: true,
-  install: true,
-  install_dir: get_option('libexecdir') / 'git-core',
-)
-
 gitgui_main = 'git-gui'
 gitgui_main_install_dir = get_option('libexecdir') / 'git-core'
 
@@ -61,6 +53,20 @@ if target_machine.system() == 'windows'
   )
 endif
 
+custom_target(
+  output: 'git-gui--askpass',
+  input: 'git-gui--askpass.sh',
+  command: [
+    shell,
+    meson.current_source_dir() / 'generate-script.sh',
+    '@OUTPUT@',
+    '@INPUT@',
+    meson.current_build_dir() / 'GIT-GUI-BUILD-OPTIONS',
+  ],
+  install: true,
+  install_dir: get_option('libexecdir') / 'git-core',
+)
+
 custom_target(
   input: 'git-gui.sh',
   output: gitgui_main,
-- 
2.50.1.475.ge15fa7359c

