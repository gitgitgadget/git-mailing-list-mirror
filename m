Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0597F1F51C
	for <e@80x24.org>; Sat, 19 May 2018 04:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750713AbeESE2S (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 May 2018 00:28:18 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:40488 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750785AbeESE2D (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 May 2018 00:28:03 -0400
Received: by mail-lf0-f68.google.com with SMTP id u140-v6so4486854lff.7
        for <git@vger.kernel.org>; Fri, 18 May 2018 21:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8tV2YYJzOHNVASeJsiWYCYh2+4Banhnp7gK9EOcBFM4=;
        b=MtPrfv9/QqzypCTd6jhF0937VmxMfpxdWiyLivgvdb7t99c5+ZJCeVjiXAkEo4fQR7
         bBlFXdUT/EnypgMWmJBIBg5Wu6y4dnZrA8c7VBiV20F8XClypZp12kvfIXwNlbW5Hw1X
         wR9HvQJJ/dOevT9P2PHhUydXJZf0+25QF+H4raRqqMjvWxXflvJKGMzk9koeIawdV4ID
         2NEYSoJX2C8S8rZ7Sp20og1uu/a6LFXESRATOkxoa5i7p8L7vAd+0qEbvS43KoAzyT0M
         MCBnfVXics7UMdMLXoBQzvp7lB1u/RvCE3MHLR+dbwabMcIX6gAip34v+dtMn7OnpnMD
         FraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8tV2YYJzOHNVASeJsiWYCYh2+4Banhnp7gK9EOcBFM4=;
        b=b99J9OwrEY8MBHAI5QMGRVTYXr6L0EN2/fUksmjNKFBk3diH+uvfP96yBwxVmQXog/
         DXmWcKvkeg1I9R7yOOfwlksZhBE2+O0Zye3kU/OUxnOqM2lxR5h28cpBbWVYYZoelEvd
         rWikTJvvvOQVgpw84tT+5wqEomtizWofKMZzYZPs9PIzijlRa8QHDQA0qgTLXqeV7DoM
         ioRDubzoXwNxoapQR+qmhmsoQdbERarFDTfbFTTqdodCcKU+PiQH0qua89q3QKDRUrS/
         u2U3quDG6ElR5juuEarJDWRfn0Ssnv2B0FzVT/5Otz9QvDRrxHPHSkADSTIWc0bTmxuW
         8xAQ==
X-Gm-Message-State: ALKqPwcS1S3bSWDa4Z7WM2sqf9o6wUdvC1qQdr+lCZWeDTal2ZrrAVzs
        fOtgJKR7ngJQUSQG1ILNFRNMdQ==
X-Google-Smtp-Source: AB8JxZpn/hZPXBTBo6UI1K4Xf4KVZTTJFoIHtQZ6FgyxBGzLUK5Pc0dlgETHfNHK4QeS0lTpkcQVeg==
X-Received: by 2002:a19:dd5d:: with SMTP id u90-v6mr23613050lfg.23.1526704081573;
        Fri, 18 May 2018 21:28:01 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o11-v6sm1960309lfi.14.2018.05.18.21.28.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 May 2018 21:28:00 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 04/14] Remove common-cmds.h
Date:   Sat, 19 May 2018 06:27:42 +0200
Message-Id: <20180519042752.8666-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180519042752.8666-1-pclouds@gmail.com>
References: <20180519042752.8666-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After the last patch, common-cmds.h is no longer used (and it was
actually broken). Remove all related code. command-list.h will take
its place from now on.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 .gitignore          |  1 -
 Makefile            | 17 ++++++-----------
 generate-cmdlist.sh | 46 +++------------------------------------------
 3 files changed, 9 insertions(+), 55 deletions(-)

diff --git a/.gitignore b/.gitignore
index d4c3914167..0836083992 100644
--- a/.gitignore
+++ b/.gitignore
@@ -179,7 +179,6 @@
 /gitweb/gitweb.cgi
 /gitweb/static/gitweb.js
 /gitweb/static/gitweb.min.*
-/common-cmds.h
 /command-list.h
 *.tar.gz
 *.dsc
diff --git a/Makefile b/Makefile
index 5c58b0b692..a60a78ee67 100644
--- a/Makefile
+++ b/Makefile
@@ -757,7 +757,7 @@ LIB_FILE = libgit.a
 XDIFF_LIB = xdiff/lib.a
 VCSSVN_LIB = vcs-svn/lib.a
 
-GENERATED_H += common-cmds.h command-list.h
+GENERATED_H += command-list.h
 
 LIB_H = $(shell $(FIND) . \
 	-name .git -prune -o \
@@ -1914,9 +1914,9 @@ git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
 		$(filter %.o,$^) $(LIBS)
 
-help.sp help.s help.o: common-cmds.h command-list.h
+help.sp help.s help.o: command-list.h
 
-builtin/help.sp builtin/help.s builtin/help.o: common-cmds.h command-list.h GIT-PREFIX
+builtin/help.sp builtin/help.s builtin/help.o: command-list.h GIT-PREFIX
 builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
 	'-DGIT_HTML_PATH="$(htmldir_relative_SQ)"' \
 	'-DGIT_MAN_PATH="$(mandir_relative_SQ)"' \
@@ -1935,11 +1935,6 @@ $(BUILT_INS): git$X
 	ln -s $< $@ 2>/dev/null || \
 	cp $< $@
 
-common-cmds.h: generate-cmdlist.sh command-list.txt
-
-common-cmds.h: $(wildcard Documentation/git-*.txt)
-	$(QUIET_GEN)$(SHELL_PATH) ./generate-cmdlist.sh command-list.txt COMMON >$@+ && mv $@+ $@
-
 command-list.h: generate-cmdlist.sh command-list.txt
 
 command-list.h: $(wildcard Documentation/git-*.txt)
@@ -2153,7 +2148,7 @@ else
 # Dependencies on header files, for platforms that do not support
 # the gcc -MMD option.
 #
-# Dependencies on automatically generated headers such as common-cmds.h or command-list.h
+# Dependencies on automatically generated headers such as command-list.h
 # should _not_ be included here, since they are necessary even when
 # building an object for the first time.
 
@@ -2532,7 +2527,7 @@ sparse: $(SP_OBJ)
 style:
 	git clang-format --style file --diff --extensions c,h
 
-check: common-cmds.h command-list.h
+check: command-list.h
 	@if sparse; \
 	then \
 		echo >&2 "Use 'make sparse' instead"; \
@@ -2780,7 +2775,7 @@ clean: profile-clean coverage-clean
 	$(RM) $(TEST_PROGRAMS) $(NO_INSTALL)
 	$(RM) -r bin-wrappers $(dep_dirs)
 	$(RM) -r po/build/
-	$(RM) *.pyc *.pyo */*.pyc */*.pyo common-cmds.h command-list.h $(ETAGS_TARGET) tags cscope*
+	$(RM) *.pyc *.pyo */*.pyc */*.pyo command-list.h $(ETAGS_TARGET) tags cscope*
 	$(RM) -r $(GIT_TARNAME) .doc-tmp-dir
 	$(RM) $(GIT_TARNAME).tar.gz git-core_$(GIT_VERSION)-*.tar.gz
 	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 9eb22c4ef1..3bcc1ee57d 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -68,46 +68,6 @@ struct cmdname_help {
 	uint32_t category;
 };
 "
-if test -z "$2"
-then
-	define_categories "$1"
-	echo
-	print_command_list "$1"
-	exit 0
-fi
-
-echo "static const char *common_cmd_groups[] = {"
-
-grps=grps$$.tmp
-match=match$$.tmp
-trap "rm -f '$grps' '$match'" 0 1 2 3 15
-
-sed -n '
-	1,/^### common groups/b
-	/^### command list/q
-	/^#/b
-	/^[ 	]*$/b
-	h;s/^[^ 	][^ 	]*[ 	][ 	]*\(.*\)/	N_("\1"),/p
-	g;s/^\([^ 	][^ 	]*\)[ 	].*/\1/w '$grps'
-	' "$1"
-printf '};\n\n'
-
-n=0
-substnum=
-while read grp
-do
-	echo "^git-..*[ 	]$grp"
-	substnum="$substnum${substnum:+;}s/[ 	]$grp/$n/"
-	n=$(($n+1))
-done <"$grps" >"$match"
-
-printf 'static struct cmdname_help common_cmds[] = {\n'
-grep -f "$match" "$1" |
-sed 's/^git-//' |
-sort |
-while read cmd tags
-do
-	tag=$(echo "$tags" | sed "$substnum; s/[^0-9]//g")
-	echo "	{\"$cmd\", $(get_synopsis git-$cmd), $tag},"
-done
-echo "};"
+define_categories "$1"
+echo
+print_command_list "$1"
-- 
2.17.0.705.g3525833791

