Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 794AB200B9
	for <e@80x24.org>; Mon,  7 May 2018 17:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752352AbeEGRxI (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 13:53:08 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40026 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752719AbeEGRxG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 13:53:06 -0400
Received: by mail-lf0-f65.google.com with SMTP id p85-v6so6481847lfg.7
        for <git@vger.kernel.org>; Mon, 07 May 2018 10:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QUBHi8IEX/ZBYvMUA5MRrfudSqsbwHJTWIx83KWzCl0=;
        b=EKNIJ9jhvOpnkMagg4za3657mN0hhcYQSWb49JLAEAnq/FhTqLtCuEngB/O0AY0/6m
         XIWdQ/XAGFELJSwllEMDvVSjbvfBSbcS5Wvssi1x/4hHM30XQHP2T7B6nT/npDQEsRbE
         BSngcJZJA7ntAAeapi9Wuq6l6Wfqq4qqtrtByCW4BYy0XI7ZSDPom5kGk2d3PgHYfn/c
         zcs9eEYdm/sx5X40MF5qMddHCmY7YdHDmhJx73FlYcBadmmvKhmTDuR26E4vnGQ9/Vte
         9a4baHUe3X8nniL3LJ0Okd6wc9YsyLFdt4Up3wpWwEhST416dwgGVNttWWEkwqhF7Xxx
         AakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QUBHi8IEX/ZBYvMUA5MRrfudSqsbwHJTWIx83KWzCl0=;
        b=j9G+Utvycv/SnhEM4dnk37K26cLrVcpaTxUsHd+Rz44DEax1Gkw4FVYVI7O6zs9Dnm
         j97JjJQtVw7qyRi3b2BI7CDk56Ub2P9mqws3QH9FMOt/dpzz80mrMKUBf1RBA4g/3aKP
         kmIIm2DEW1NRNZoue2eAbkGmD4kHakBY3BnaGqm+q82AeSU1I4SMnAa2jt6ppIDLJvtG
         FBLQrT/YGwbEHm5/54SLVvFSfMmH+0mBDdf6s3yeEpQnlBVcoVbbwa922R7ZLTQY/kto
         /BGklcZbJ7MU757KbhYgQUKzY1TNUpJXvwAFvnGKcV1UXpqXlJDNNzvr0MtfNN3owzyh
         qSjQ==
X-Gm-Message-State: ALQs6tBtQjOlkmLimTdRyXzJ4g/vgsurTibfDDjXpvDCJXmbsAHoa40c
        ZiRg81vBfvetOFP6+5VKx8U=
X-Google-Smtp-Source: AB8JxZpKImN1t8kUR9qBvaNtSXHTI7bvNEy3MvEuZbrjZdCdUYNEmDmXxWqH5CMqJQ/qproF52ZNQg==
X-Received: by 2002:a2e:9706:: with SMTP id r6-v6mr24534965lji.5.1525715585139;
        Mon, 07 May 2018 10:53:05 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id v6-v6sm4376865ljk.83.2018.05.07.10.53.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 May 2018 10:53:04 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v6 04/13] Remove common-cmds.h
Date:   Mon,  7 May 2018 19:52:13 +0200
Message-Id: <20180507175222.12114-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180507175222.12114-1-pclouds@gmail.com>
References: <20180429181844.21325-1-pclouds@gmail.com>
 <20180507175222.12114-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After the last patch, common-cmds.h is no longer used (and it was
actually broken). Remove all related code. command-list.h will take
its place from now on.
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
2.17.0.705.g3525833791

