Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C79231F428
	for <e@80x24.org>; Sun, 29 Apr 2018 18:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754113AbeD2ST3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Apr 2018 14:19:29 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:44202 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754017AbeD2STH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Apr 2018 14:19:07 -0400
Received: by mail-lf0-f66.google.com with SMTP id h197-v6so9349932lfg.11
        for <git@vger.kernel.org>; Sun, 29 Apr 2018 11:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XxsHWoHKhR/GH6hxJ+ZT0OSU0hS7Lb5MhVkXDzt0sOc=;
        b=qN8FaXkTW3OegBI6R0Q+Z5MfyAkJgs8bGhfjVDt9VERbusp0syuchosaMg+N/ZkDQq
         LCIMvY38K3MmzrvgA/KvbwvHA4wQFU6Dnk9Hv3p6pI4RcvA28doSyVaOYukPmoBrzXYN
         yKzRWSPqYPiNumKz8x1Utv2ESlswwu//TSbyphZl4ZlkifF3q5TggokULcSmigA+Xd3b
         RhVZZLNgFD9RGlgzME3sEQfsP6hVhmV9DV7TKTHpV2xBY3iMa4Xur3ay5VdrGZTrgckr
         xshRykkjmmre395dgqWWLfyF+zTytHxJBnoUaBibmt25jtB2FTZnnCXu0uErfUiPZflW
         7TlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XxsHWoHKhR/GH6hxJ+ZT0OSU0hS7Lb5MhVkXDzt0sOc=;
        b=o5C7QbeN95sNiInpM9ixVpDFDtL9rtitl9sVmamx2OD9IEQw37OMCvxaxqXVLTRo25
         G0rnekBQkSpv+hfbDF6q16gQ2lZzdJSFHn+6gqBxQV3zkrP8IVuTCGV9O4kSlQa/B+HK
         6t5DaGFTnD4IXgx0aAHJJI0iVpFMtjwUBtWvSeJFURhMiLM3bOic6XJQUQSY1VJp8aq7
         j0duopQtgZb9nlDfsByzIRvb1NcL2Y0KCVwgyBbj/vREDwPVHjdNe6GU6DyQM9Rr//tk
         mdPhv+4PJ0Cih208zdmoNKaw1DSSv73rMKZwcjTiNBubTe1RguW21AVHYpDhBTXg1unS
         ++dw==
X-Gm-Message-State: ALQs6tDNuJqhiQdIpXXCBZxGXROjTlLdHJPO1+/3UOMo9hdr6NzjggCE
        oqs22NsLs3zPWVB6s8r0mW0=
X-Google-Smtp-Source: AB8JxZot5YEdaNU6CTd7zITG5PoVbG8S8XpUd/TXk3b6hCYS9Vkg8mKquXmLfZHKThYWh5MH/pHbBg==
X-Received: by 2002:a19:f106:: with SMTP id p6-v6mr5050201lfh.118.1525025946337;
        Sun, 29 Apr 2018 11:19:06 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id r78-v6sm975376ljb.20.2018.04.29.11.19.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Apr 2018 11:19:05 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v5 04/10] Remove common-cmds.h
Date:   Sun, 29 Apr 2018 20:18:38 +0200
Message-Id: <20180429181844.21325-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.664.g8924eee37a
In-Reply-To: <20180429181844.21325-1-pclouds@gmail.com>
References: <20180421165414.30051-1-pclouds@gmail.com>
 <20180429181844.21325-1-pclouds@gmail.com>
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
index ab67150e68..71b5b594cd 100644
--- a/Makefile
+++ b/Makefile
@@ -757,7 +757,7 @@ LIB_FILE = libgit.a
 XDIFF_LIB = xdiff/lib.a
 VCSSVN_LIB = vcs-svn/lib.a
 
-GENERATED_H += common-cmds.h command-list.h
+GENERATED_H += command-list.h
 
 LIB_H = $(shell $(FIND) . \
 	-name .git -prune -o \
@@ -1916,9 +1916,9 @@ git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
 		$(filter %.o,$^) $(LIBS)
 
-help.sp help.s help.o: common-cmds.h command-list.h
+help.sp help.s help.o: command-list.h
 
-builtin/help.sp builtin/help.s builtin/help.o: common-cmds.h command-list.h GIT-PREFIX
+builtin/help.sp builtin/help.s builtin/help.o: command-list.h GIT-PREFIX
 builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
 	'-DGIT_HTML_PATH="$(htmldir_relative_SQ)"' \
 	'-DGIT_MAN_PATH="$(mandir_relative_SQ)"' \
@@ -1937,11 +1937,6 @@ $(BUILT_INS): git$X
 	ln -s $< $@ 2>/dev/null || \
 	cp $< $@
 
-common-cmds.h: generate-cmdlist.sh command-list.txt
-
-common-cmds.h: $(wildcard Documentation/git-*.txt)
-	$(QUIET_GEN)$(SHELL_PATH) ./generate-cmdlist.sh command-list.txt COMMON >$@+ && mv $@+ $@
-
 command-list.h: generate-cmdlist.sh command-list.txt
 
 command-list.h: $(wildcard Documentation/git-*.txt)
@@ -2155,7 +2150,7 @@ else
 # Dependencies on header files, for platforms that do not support
 # the gcc -MMD option.
 #
-# Dependencies on automatically generated headers such as common-cmds.h or command-list.h
+# Dependencies on automatically generated headers such as command-list.h
 # should _not_ be included here, since they are necessary even when
 # building an object for the first time.
 
@@ -2534,7 +2529,7 @@ sparse: $(SP_OBJ)
 style:
 	git clang-format --style file --diff --extensions c,h
 
-check: common-cmds.h command-list.h
+check: command-list.h
 	@if sparse; \
 	then \
 		echo >&2 "Use 'make sparse' instead"; \
@@ -2782,7 +2777,7 @@ clean: profile-clean coverage-clean
 	$(RM) $(TEST_PROGRAMS) $(NO_INSTALL)
 	$(RM) -r bin-wrappers $(dep_dirs)
 	$(RM) -r po/build/
-	$(RM) *.pyc *.pyo */*.pyc */*.pyo common-cmds.h command-list.h $(ETAGS_TARGET) tags cscope*
+	$(RM) *.pyc *.pyo */*.pyc */*.pyo command-list.h $(ETAGS_TARGET) tags cscope*
 	$(RM) -r $(GIT_TARNAME) .doc-tmp-dir
 	$(RM) $(GIT_TARNAME).tar.gz git-core_$(GIT_VERSION)-*.tar.gz
 	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 93de8e8f59..015eef2804 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -68,46 +68,6 @@ struct cmdname_help {
 	uint32_t category;
 };
 "
-if [ -z "$2" ]
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
2.17.0.664.g8924eee37a

