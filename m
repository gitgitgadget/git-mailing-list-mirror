Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BFB71F51C
	for <e@80x24.org>; Sat, 19 May 2018 04:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750813AbeESE2F (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 May 2018 00:28:05 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34555 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbeESE2B (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 May 2018 00:28:01 -0400
Received: by mail-lf0-f67.google.com with SMTP id x145-v6so4754482lff.1
        for <git@vger.kernel.org>; Fri, 18 May 2018 21:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m/TQivCADNkzSKBNmAbQyowixRVndUXhqtCX/0LG4dE=;
        b=TJqYyYz3PKJ9U0u/SnpFM1Oa5lrtvCpOTo0gu96uXZnK7n/TZl/ROtLWIN1CeHWIDS
         h81QKaYV5AtSpjbeFNkqZR4L5S96v+VgoG782EXjxE1q9KUHs9MPHKcWZSAbRQ6ZsAE4
         Fg6VYLAc3Ua/6TxZa2hG8J1UdROoKBzH5zulZ2e6PNyExrD32Zm7x/bTRewZ0E3QgkVd
         DmOMXukhwgdr0PvfI1lwxzbPg4ixmjQqKAyPtZFQXhOR9g87QBpkOW+RyW3e6HBmOi0W
         sI9nFLi6tYe8F1YSdBwgcHrmHSdMMFqowynIivcoL1zlAhCUi1W1jm9drgBKKrodoOKr
         eE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m/TQivCADNkzSKBNmAbQyowixRVndUXhqtCX/0LG4dE=;
        b=brX/V28QBO04NwW3QbRmUAveQyHsGQANXVu22xAFBkBW4K/D1c+NsvzGxZEvha+mKv
         Z/d1cg23E+C8aZMxGqRujKxpvcynZdwj3ffWlMZG9f3zrAaMB6kDJ9rVhM96VSlZdciV
         fXIFTZCvS9VsP4wXQQmJAVq0ZSnf6eIhQX3sLYgs/JnHDvlgKzQ9JHgVg6tY/d25L/zy
         iaJpW+/2tUEEk7wKypsHFscdzEuyGUPXeEbhcm2zc4Ux7Yaw13cp05+KEBbAYHG39C83
         9E6hKV7FL86gQJZxsGIUZIxmm7qrGhBnCLD3TTANLBObxI1A5fcXhPbbNlcHxaAgIdfi
         tQEQ==
X-Gm-Message-State: ALKqPwf+6PzCOlka5PfKm+qfcI9oPRHERNM98zfeIwjx2SWZxtXll13D
        4B1j6pfYD516AIzUOGipqz7clA==
X-Google-Smtp-Source: AB8JxZpWSttNoyhBNYrEaP2hkRr1Xpgx236xwf24ry5yEkKytF1XIZ+u7fgWpJaXsqQrcLEkkwBY/g==
X-Received: by 2002:a2e:650a:: with SMTP id z10-v6mr7594498ljb.41.1526704079407;
        Fri, 18 May 2018 21:27:59 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o11-v6sm1960309lfi.14.2018.05.18.21.27.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 May 2018 21:27:58 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 02/14] generate-cmds.sh: export all commands to command-list.h
Date:   Sat, 19 May 2018 06:27:40 +0200
Message-Id: <20180519042752.8666-3-pclouds@gmail.com>
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

The current generate-cmds.sh generates just enough to print "git help"
output. That is, it only extracts help text for common commands.

The script is now updated to extract help text for all commands and
keep command classification a new file, command-list.h. This will be
useful later:

- "git help -a" could print a short summary of all commands instead of
  just the common ones.

- "git" could produce a list of commands of one or more category. One
  of its use is to reduce another command classification embedded in
  git-completion.bash.

The new file can be generated but is not used anywhere yet. The plan
is we migrate away from common-cmds.h. Then we can kill off
common-cmds.h build rules and generation code (and also delete
duplicate content in command-list.h which we keep for now to not mess
generate-cmds.sh up too much).

PS. The new fixed column requirement on command-list.txt is
technically not needed. But it helps simplify the code a bit at this
stage. We could lift this restriction later if we want to.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 .gitignore          |  1 +
 Makefile            | 13 ++++++---
 command-list.txt    |  4 +--
 generate-cmdlist.sh | 67 ++++++++++++++++++++++++++++++++++++++++++---
 4 files changed, 75 insertions(+), 10 deletions(-)

diff --git a/.gitignore b/.gitignore
index 833ef3b0b7..d4c3914167 100644
--- a/.gitignore
+++ b/.gitignore
@@ -180,6 +180,7 @@
 /gitweb/static/gitweb.js
 /gitweb/static/gitweb.min.*
 /common-cmds.h
+/command-list.h
 *.tar.gz
 *.dsc
 *.deb
diff --git a/Makefile b/Makefile
index f181687250..2a8913ea21 100644
--- a/Makefile
+++ b/Makefile
@@ -757,7 +757,7 @@ LIB_FILE = libgit.a
 XDIFF_LIB = xdiff/lib.a
 VCSSVN_LIB = vcs-svn/lib.a
 
-GENERATED_H += common-cmds.h
+GENERATED_H += common-cmds.h command-list.h
 
 LIB_H = $(shell $(FIND) . \
 	-name .git -prune -o \
@@ -1938,6 +1938,11 @@ $(BUILT_INS): git$X
 common-cmds.h: generate-cmdlist.sh command-list.txt
 
 common-cmds.h: $(wildcard Documentation/git-*.txt)
+	$(QUIET_GEN)$(SHELL_PATH) ./generate-cmdlist.sh command-list.txt COMMON >$@+ && mv $@+ $@
+
+command-list.h: generate-cmdlist.sh command-list.txt
+
+command-list.h: $(wildcard Documentation/git-*.txt)
 	$(QUIET_GEN)$(SHELL_PATH) ./generate-cmdlist.sh command-list.txt >$@+ && mv $@+ $@
 
 SCRIPT_DEFINES = $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
@@ -2148,7 +2153,7 @@ else
 # Dependencies on header files, for platforms that do not support
 # the gcc -MMD option.
 #
-# Dependencies on automatically generated headers such as common-cmds.h
+# Dependencies on automatically generated headers such as common-cmds.h or command-list.h
 # should _not_ be included here, since they are necessary even when
 # building an object for the first time.
 
@@ -2527,7 +2532,7 @@ sparse: $(SP_OBJ)
 style:
 	git clang-format --style file --diff --extensions c,h
 
-check: common-cmds.h
+check: common-cmds.h command-list.h
 	@if sparse; \
 	then \
 		echo >&2 "Use 'make sparse' instead"; \
@@ -2775,7 +2780,7 @@ clean: profile-clean coverage-clean
 	$(RM) $(TEST_PROGRAMS) $(NO_INSTALL)
 	$(RM) -r bin-wrappers $(dep_dirs)
 	$(RM) -r po/build/
-	$(RM) *.pyc *.pyo */*.pyc */*.pyo common-cmds.h $(ETAGS_TARGET) tags cscope*
+	$(RM) *.pyc *.pyo */*.pyc */*.pyo common-cmds.h command-list.h $(ETAGS_TARGET) tags cscope*
 	$(RM) -r $(GIT_TARNAME) .doc-tmp-dir
 	$(RM) $(GIT_TARNAME).tar.gz git-core_$(GIT_VERSION)-*.tar.gz
 	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
diff --git a/command-list.txt b/command-list.txt
index a1fad28fd8..786536aba0 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -8,8 +8,8 @@ info         examine the history and state (see also: git help revisions)
 history      grow, mark and tweak your common history
 remote       collaborate (see also: git help workflows)
 
-### command list (do not change this line)
-# command name                          category [deprecated] [common]
+### command list (do not change this line, also do not change alignment)
+# command name                          category [category] [category]
 git-add                                 mainporcelain           worktree
 git-am                                  mainporcelain
 git-annotate                            ancillaryinterrogators
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 31b6d886cb..870d3b626a 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -1,5 +1,27 @@
 #!/bin/sh
 
+die () {
+	echo "$@" >&2
+	exit 1
+}
+
+command_list () {
+	sed '1,/^### command list/d;/^#/d' "$1"
+}
+
+get_categories () {
+	tr ' ' '\n'|
+	grep -v '^$' |
+	sort |
+	uniq
+}
+
+category_list () {
+	command_list "$1" |
+	cut -c 40- |
+	get_categories
+}
+
 get_synopsis () {
 	sed -n '
 		/^NAME/,/'"$1"'/H
@@ -10,14 +32,51 @@ get_synopsis () {
 		}' "Documentation/$1.txt"
 }
 
+define_categories () {
+	echo
+	echo "/* Command categories */"
+	bit=0
+	category_list "$1" |
+	while read cat
+	do
+		echo "#define CAT_$cat (1UL << $bit)"
+		bit=$(($bit+1))
+	done
+	test "$bit" -gt 32 && die "Urgh.. too many categories?"
+}
+
+print_command_list () {
+	echo "static struct cmdname_help command_list[] = {"
+
+	command_list "$1" |
+	while read cmd rest
+	do
+		printf "	{ \"$cmd\", $(get_synopsis $cmd), 0"
+		for cat in $(echo "$rest" | get_categories)
+		do
+			printf " | CAT_$cat"
+		done
+		echo " },"
+	done
+	echo "};"
+}
+
 echo "/* Automatically generated by generate-cmdlist.sh */
 struct cmdname_help {
-	char name[16];
-	char help[80];
-	unsigned char group;
+	const char *name;
+	const char *help;
+	uint32_t group;
 };
+"
+if test -z "$2"
+then
+	define_categories "$1"
+	echo
+	print_command_list "$1"
+	exit 0
+fi
 
-static const char *common_cmd_groups[] = {"
+echo "static const char *common_cmd_groups[] = {"
 
 grps=grps$$.tmp
 match=match$$.tmp
-- 
2.17.0.705.g3525833791

