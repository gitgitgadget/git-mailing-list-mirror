Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE2281F51C
	for <e@80x24.org>; Sun, 20 May 2018 18:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752552AbeETSlK (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 14:41:10 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:42109 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751292AbeETSk0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 14:40:26 -0400
Received: by mail-lf0-f65.google.com with SMTP id b18-v6so20771108lfa.9
        for <git@vger.kernel.org>; Sun, 20 May 2018 11:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8tV2YYJzOHNVASeJsiWYCYh2+4Banhnp7gK9EOcBFM4=;
        b=Ez4pr+rfprhxS3WjzhHuEzI7dNS/+XK3rIMF8uovqbJE7U2+tMiCooRiIeD6uZg3Vu
         ARDYXLNy4dRU4gLLTV4CeNS2bSAnHTzKu6x4R3QxZZvmBbx/UP0eJ7RMDM8Y+9IHaMiS
         j8Gp1LiufxPZyliAefNV4uIvo0Bn6w9eNgIKXTTkuOrZ83argU+5SU5Wdn8gqoMWLabp
         DsN9q24QBXb9GzWFt7+XlhhIfPaOk3IFhJz60hi07rSUp/C9aKWP/LYXxu89j2ItDV3x
         9swGYqpAGAZdNRPufXu2vghqqK+XM70kxMHTAIh3rgxNupVNwJG41ao3v+7YDB6m+4sC
         lnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8tV2YYJzOHNVASeJsiWYCYh2+4Banhnp7gK9EOcBFM4=;
        b=sAoC1GggJ/Uygb2iuV/qWS+UD4yAtuIdCRruHoSXMT/DTJtQJo9Q5Z2Rx5ljSE9/68
         GY/kHIRzmMw8bNov04h+GyDg19BcE35d/rPOgvcFxJvjNXrnyCK+9VISQZfCVllBipXf
         TPKDDDjhHz93R6iWIF221HOdVEEkZbXnSuBuQR7VUGjtms2usAvjWnq3Xc0HyCTr5eMH
         ekOxx7mugQg/hYIh6V8cAHPsCR1rieNRRjZq71Mk+Gf64cX44REWVznTy9P38yJSnfzO
         8Ta4FtwvphBuVxt/fXBHVnyqA7LAb3Uz0x9dRa/IvUQp9cPS1jjlAS310F/UJonRNa69
         up5A==
X-Gm-Message-State: ALKqPwfSYFeAg2Ej/AoV4gWVUb11zodwGMlfTKHePyIfpT7rcS+flVxW
        O8jWcBPRKt4lO4IqlE3cwoBAfw==
X-Google-Smtp-Source: AB8JxZpAM0sg7R1hisuQFqJQq2ZMiRJkyPDIPWVteUfUbWAIbe3a31qrlDKG5EqA6UA8vRVLUDtwXA==
X-Received: by 2002:a19:8f8a:: with SMTP id s10-v6mr26886144lfk.47.1526841624982;
        Sun, 20 May 2018 11:40:24 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id k5-v6sm2176906lji.39.2018.05.20.11.40.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 May 2018 11:40:24 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 04/17] Remove common-cmds.h
Date:   Sun, 20 May 2018 20:39:56 +0200
Message-Id: <20180520184009.976-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180520184009.976-1-pclouds@gmail.com>
References: <20180519042752.8666-1-pclouds@gmail.com>
 <20180520184009.976-1-pclouds@gmail.com>
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

