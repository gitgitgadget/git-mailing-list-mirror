Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA9D61F597
	for <e@80x24.org>; Mon, 23 Jul 2018 13:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388096AbeGWOyN (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 10:54:13 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:41912 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387940AbeGWOyM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 10:54:12 -0400
Received: by mail-pg1-f181.google.com with SMTP id z8-v6so439883pgu.8
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 06:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jrs26rMaWdi9XBPEQetlHu0MSJyGnq6en2tjj/T0SGo=;
        b=WRLAmcf7mLZn1t10fLVzl0p7Kf2l6BL9Uz4Q2ITfvO5MySh8snxbfpUKs3AtM3nucc
         FVvFjWoch6MP5c223F8f2Q3kkIw7+saAvZMuOQMzYU8eHkQM5TijCa/eIxu8PokpR6wS
         dxLyaa8gBtqtCZEf0SjErQ1sAE/QqN7uefrXkM/6dp14iHi+HIc/go953d7lMpi0tbOD
         BbWqSbDMwJ56o+I3YDP99HX1cNyaSRgYCW2TPY14I/eVL9D3x7TzHB8+qCkSJDJQt1wz
         ZDJn4OrlIsBP8jREAlX7FMWx5u3E2WROf2jzLvZC7F6DWmaZUnW8bDWoadw0V3qK8l7R
         bVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jrs26rMaWdi9XBPEQetlHu0MSJyGnq6en2tjj/T0SGo=;
        b=Al8AFECFWLQngs4e7DkeRESF/iAjitK74lPZ2LDpuIUSdSwgb8eNmkMKXHJwf0sGQy
         iFL3osyGuP1mVF573wYOhKNeRAIc23E4VCScdTvNsF8yDxU+NLROthX+kEA3ROBOLMR6
         cwTewnZC3tRWARKQ0u2V+M2umkZb6mwroKvcpaaurSFrEIuOhjJX3PgqrlYEkFW8hQ3a
         oeIA96z+JS78nsL6JTj9vLplWxT2zjRFMxAL54Tgqor0EIQBSZ+kIWmYSQqyGj/gPulm
         IeQCwe6igrTiF/BNabj7AtLIuJxfyhLryBMeeuVGIQqJvrhkPtIjgDYig1tjsZ04d0mb
         9iXA==
X-Gm-Message-State: AOUpUlEKMMvqAKc9dCdwCBs9Orib1mfsV3SPwf+NNputdmrivnIbjB/a
        WtN76BYEVlxhll7HBJclzTp6AOud
X-Google-Smtp-Source: AAOMgpfok5gfEVmEbZ/8blDhqjHV459m56QTPdXjXW/BZIOmZNaWKFPsTuk+O4dzqYZcWp3Ljl2j1A==
X-Received: by 2002:a62:6283:: with SMTP id w125-v6mr9392821pfb.108.1532353969993;
        Mon, 23 Jul 2018 06:52:49 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id l71-v6sm12676174pgd.70.2018.07.23.06.52.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 06:52:49 -0700 (PDT)
Date:   Mon, 23 Jul 2018 06:52:49 -0700 (PDT)
X-Google-Original-Date: Mon, 23 Jul 2018 13:52:37 GMT
Message-Id: <e2e449a00385531d326d6811a871dde59624b818.1532353966.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2.git.gitgitgadget@gmail.com>
References: <pull.2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/9] contrib: add a script to initialize VS Code configuration
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

VS Code is a lightweight but powerful source code editor which runs on
your desktop and is available for Windows, macOS and Linux. Among other
languages, it has support for C/C++ via an extension.

To start developing Git with VS Code, simply run the Unix shell script
contrib/vscode/init.sh, which creates the configuration files in
.vscode/ that VS Code consumes.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .gitignore                    |   1 +
 contrib/vscode/.gitattributes |   1 +
 contrib/vscode/README.md      |  14 +++
 contrib/vscode/init.sh        | 165 ++++++++++++++++++++++++++++++++++
 4 files changed, 181 insertions(+)
 create mode 100644 contrib/vscode/.gitattributes
 create mode 100644 contrib/vscode/README.md
 create mode 100755 contrib/vscode/init.sh

diff --git a/.gitignore b/.gitignore
index 388cc4bee..592e8f879 100644
--- a/.gitignore
+++ b/.gitignore
@@ -206,6 +206,7 @@
 /config.mak.autogen
 /config.mak.append
 /configure
+/.vscode/
 /tags
 /TAGS
 /cscope*
diff --git a/contrib/vscode/.gitattributes b/contrib/vscode/.gitattributes
new file mode 100644
index 000000000..e89f2236e
--- /dev/null
+++ b/contrib/vscode/.gitattributes
@@ -0,0 +1 @@
+init.sh whitespace=-indent-with-non-tab
diff --git a/contrib/vscode/README.md b/contrib/vscode/README.md
new file mode 100644
index 000000000..8202d6203
--- /dev/null
+++ b/contrib/vscode/README.md
@@ -0,0 +1,14 @@
+Configuration for VS Code
+=========================
+
+[VS Code](https://code.visualstudio.com/) is a lightweight but powerful source
+code editor which runs on your desktop and is available for
+[Windows](https://code.visualstudio.com/docs/setup/windows),
+[macOS](https://code.visualstudio.com/docs/setup/mac) and
+[Linux](https://code.visualstudio.com/docs/setup/linux). Among other languages,
+it has [support for C/C++ via an extension](https://github.com/Microsoft/vscode-cpptools).
+
+To start developing Git with VS Code, simply run the Unix shell script called
+`init.sh` in this directory, which creates the configuration files in
+`.vscode/` that VS Code consumes. `init.sh` needs access to `make` and `gcc`,
+so run the script in a Git SDK shell if you are using Windows.
diff --git a/contrib/vscode/init.sh b/contrib/vscode/init.sh
new file mode 100755
index 000000000..3cc93243f
--- /dev/null
+++ b/contrib/vscode/init.sh
@@ -0,0 +1,165 @@
+#!/bin/sh
+
+die () {
+	echo "$*" >&2
+	exit 1
+}
+
+cd "$(dirname "$0")"/../.. ||
+die "Could not cd to top-level directory"
+
+mkdir -p .vscode ||
+die "Could not create .vscode/"
+
+# General settings
+
+cat >.vscode/settings.json <<\EOF ||
+{
+    "C_Cpp.intelliSenseEngine": "Default",
+    "C_Cpp.intelliSenseEngineFallback": "Disabled",
+    "files.associations": {
+        "*.h": "c",
+        "*.c": "c"
+    }
+}
+EOF
+die "Could not write settings.json"
+
+# Infer some setup-specific locations/names
+
+GCCPATH="$(which gcc)"
+GDBPATH="$(which gdb)"
+MAKECOMMAND="make -j5 DEVELOPER=1"
+OSNAME=
+X=
+case "$(uname -s)" in
+MINGW*)
+	GCCPATH="$(cygpath -am "$GCCPATH")"
+	GDBPATH="$(cygpath -am "$GDBPATH")"
+	MAKE_BASH="$(cygpath -am /git-cmd.exe) --command=usr\\\\bin\\\\bash.exe"
+	MAKECOMMAND="$MAKE_BASH -lc \\\"$MAKECOMMAND\\\""
+	OSNAME=Win32
+	X=.exe
+	;;
+Linux)
+	OSNAME=Linux
+	;;
+Darwin)
+	OSNAME=macOS
+	;;
+esac
+
+# Default build task
+
+cat >.vscode/tasks.json <<EOF ||
+{
+    // See https://go.microsoft.com/fwlink/?LinkId=733558
+    // for the documentation about the tasks.json format
+    "version": "2.0.0",
+    "tasks": [
+        {
+            "label": "make",
+            "type": "shell",
+            "command": "$MAKECOMMAND",
+            "group": {
+                "kind": "build",
+                "isDefault": true
+            }
+        }
+    ]
+}
+EOF
+die "Could not install default build task"
+
+# Debugger settings
+
+cat >.vscode/launch.json <<EOF ||
+{
+    // Use IntelliSense to learn about possible attributes.
+    // Hover to view descriptions of existing attributes.
+    // For more information, visit:
+    // https://go.microsoft.com/fwlink/?linkid=830387
+    "version": "0.2.0",
+    "configurations": [
+        {
+            "name": "(gdb) Launch",
+            "type": "cppdbg",
+            "request": "launch",
+            "program": "\${workspaceFolder}/git$X",
+            "args": [],
+            "stopAtEntry": false,
+            "cwd": "\${workspaceFolder}",
+            "environment": [],
+            "externalConsole": true,
+            "MIMode": "gdb",
+            "miDebuggerPath": "$GDBPATH",
+            "setupCommands": [
+                {
+                    "description": "Enable pretty-printing for gdb",
+                    "text": "-enable-pretty-printing",
+                    "ignoreFailures": true
+                }
+            ]
+        }
+    ]
+}
+EOF
+die "Could not write launch configuration"
+
+# C/C++ extension settings
+
+make -f - OSNAME=$OSNAME GCCPATH="$GCCPATH" vscode-init \
+	>.vscode/c_cpp_properties.json <<\EOF ||
+include Makefile
+
+vscode-init:
+	@mkdir -p .vscode && \
+	incs= && defs= && \
+	for e in $(ALL_CFLAGS); do \
+		case "$$e" in \
+		-I.) \
+			incs="$$(printf '% 16s"$${workspaceRoot}",\n%s' \
+				"" "$$incs")" \
+			;; \
+		-I/*) \
+			incs="$$(printf '% 16s"%s",\n%s' \
+				"" "$${e#-I}" "$$incs")" \
+			;; \
+		-I*) \
+			incs="$$(printf '% 16s"$${workspaceRoot}/%s",\n%s' \
+				"" "$${e#-I}" "$$incs")" \
+			;; \
+		-D*) \
+			defs="$$(printf '% 16s"%s",\n%s' \
+				"" "$$(echo "$${e#-D}" | sed 's/"/\\&/g')" \
+				"$$defs")" \
+			;; \
+		esac; \
+	done && \
+	echo '{' && \
+	echo '    "configurations": [' && \
+	echo '        {' && \
+	echo '            "name": "$(OSNAME)",' && \
+	echo '            "intelliSenseMode": "clang-x64",' && \
+	echo '            "includePath": [' && \
+	echo "$$incs" | sort | sed '$$s/,$$//' && \
+	echo '            ],' && \
+	echo '            "defines": [' && \
+	echo "$$defs" | sort | sed '$$s/,$$//' && \
+	echo '            ],' && \
+	echo '            "browse": {' && \
+	echo '                "limitSymbolsToIncludedHeaders": true,' && \
+	echo '                "databaseFilename": "",' && \
+	echo '                "path": [' && \
+	echo '                    "$${workspaceRoot}"' && \
+	echo '                ]' && \
+	echo '            },' && \
+	echo '            "cStandard": "c11",' && \
+	echo '            "cppStandard": "c++17",' && \
+	echo '            "compilerPath": "$(GCCPATH)"' && \
+	echo '        }' && \
+	echo '    ],' && \
+	echo '    "version": 4' && \
+	echo '}'
+EOF
+die "Could not write settings for the C/C++ extension"
-- 
gitgitgadget

