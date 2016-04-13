From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Move test-* to t/helper/ subdirectory
Date: Wed, 13 Apr 2016 20:22:42 +0700
Message-ID: <1460553762-12419-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 15:23:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKlZ-0008Rz-LI
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 15:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760634AbcDMNWs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2016 09:22:48 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33835 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760510AbcDMNWp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 09:22:45 -0400
Received: by mail-pf0-f194.google.com with SMTP id d184so4117106pfc.1
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 06:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LgIb5JkaCfSZBz28rB1e/ukxG8eAvamche5Ohmn7IyU=;
        b=xNj6dniEQSoPt1XLIz1vPJ9z0uUKOrZGDKjnTJMbRHjwuJg/4YjUurWUoZGm72L+Cs
         /wCn98WEQhEFGFxSqFSIsrjzLnYw2iQeDyf2ooyb56NVM/0WWx7+dqDTCqHJw0S/A+3N
         dop4orWZPYmqkU+hhLDxl44ZILL1UzUqhT97qg6+FkDLvM4iV7Fbg5/apRmVIHNr2ONq
         +KE0kZmpVHzTVYkuyshnSjnpd4cUg/1xaDDi3Sh/YjX2o22gf1zpj4ooPXlBWIRr4YUf
         zlojwmVt7RsK3N2QzO/JXSKo3BfSqZwdVIicIlP7nMwZj5BqnQL0HM0XQJQ+mqPCdEd9
         QUrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LgIb5JkaCfSZBz28rB1e/ukxG8eAvamche5Ohmn7IyU=;
        b=bsdd1KpJzjcz118HGjwF8qgIhxWwV2DNCSQ471ZC4zZsc6Kma9KGAtp/YDYIw5aYFQ
         fQ9cis/wlV/D04VBEZBd00R8lxUmMlGAUPpjqjgSpItgzNwi9qWqn1LKT4/wz5U3LQVs
         /3eAYY50a4W1+px+S2HpLuOVhDLWm2tgREg+Bo6s/Cr0Jdly8WqasVPLf1ttIjX/cb4Y
         j8AtTj+EspvAKUkX2bC1BdSLPBf1HSKIcWkfHheZQg96xejKmOOyULRkRx0/JKp2GVtn
         PKYuufmjhSoBUxBOHe9i1nw4yV4ZHn/Oh8254TLBnSaGShTfmIi4TnHu5BJrI0Nesqyx
         taUw==
X-Gm-Message-State: AOPr4FUYzyrWU39QrezlLjqTEK40jdAd7Q3TCiVNVQ1haVQXJYta/xfo9v8yuy8VEfPb2A==
X-Received: by 10.98.86.146 with SMTP id h18mr12850694pfj.9.1460553765164;
        Wed, 13 Apr 2016 06:22:45 -0700 (PDT)
Received: from lanh ([115.76.233.41])
        by smtp.gmail.com with ESMTPSA id s66sm51240206pfi.3.2016.04.13.06.22.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 06:22:43 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Apr 2016 20:22:50 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291447>

This keeps top dir a bit less crowded. And because these programs are
for testing purposes, it makes sense that they stay somewhere in t/

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 This patch will break any patches that add new test programs.
 Luckily, none in 'next' or 'pu' does that. I know lmdb backend adds
 test-lmdb-backend, so a manual move and some .gitignore fixup is
 required there.

 .gitignore                                         | 33 --------------=
--------
 Makefile                                           | 24 ++++++++------=
--
 t/helper/.gitignore (new)                          | 33 ++++++++++++++=
++++++++
 test-chmtime.c =3D> t/helper/test-chmtime.c          |  0
 test-config.c =3D> t/helper/test-config.c            |  0
 test-ctype.c =3D> t/helper/test-ctype.c              |  0
 test-date.c =3D> t/helper/test-date.c                |  0
 test-delta.c =3D> t/helper/test-delta.c              |  0
 .../helper/test-dump-cache-tree.c                  |  0
 .../helper/test-dump-split-index.c                 |  0
 .../helper/test-dump-untracked-cache.c             |  0
 test-fake-ssh.c =3D> t/helper/test-fake-ssh.c        |  0
 test-genrandom.c =3D> t/helper/test-genrandom.c      |  0
 test-hashmap.c =3D> t/helper/test-hashmap.c          |  0
 .../helper/test-index-version.c                    |  0
 test-line-buffer.c =3D> t/helper/test-line-buffer.c  |  0
 test-match-trees.c =3D> t/helper/test-match-trees.c  |  0
 test-mergesort.c =3D> t/helper/test-mergesort.c      |  0
 test-mktemp.c =3D> t/helper/test-mktemp.c            |  0
 .../helper/test-parse-options.c                    |  0
 test-path-utils.c =3D> t/helper/test-path-utils.c    |  0
 test-prio-queue.c =3D> t/helper/test-prio-queue.c    |  0
 test-read-cache.c =3D> t/helper/test-read-cache.c    |  0
 test-regex.c =3D> t/helper/test-regex.c              |  0
 .../helper/test-revision-walking.c                 |  0
 test-run-command.c =3D> t/helper/test-run-command.c  |  0
 .../helper/test-scrap-cache-tree.c                 |  0
 test-sha1-array.c =3D> t/helper/test-sha1-array.c    |  0
 test-sha1.c =3D> t/helper/test-sha1.c                |  0
 test-sha1.sh =3D> t/helper/test-sha1.sh              |  4 +--
 test-sigchain.c =3D> t/helper/test-sigchain.c        |  0
 test-string-list.c =3D> t/helper/test-string-list.c  |  0
 .../helper/test-submodule-config.c                 |  0
 test-subprocess.c =3D> t/helper/test-subprocess.c    |  0
 test-svn-fe.c =3D> t/helper/test-svn-fe.c            |  0
 .../helper/test-urlmatch-normalization.c           |  0
 test-wildmatch.c =3D> t/helper/test-wildmatch.c      |  0
 t/t5601-clone.sh                                   |  2 +-
 t/test-lib.sh                                      |  4 +--
 39 files changed, 50 insertions(+), 50 deletions(-)
 create mode 100644 t/helper/.gitignore
 rename test-chmtime.c =3D> t/helper/test-chmtime.c (100%)
 rename test-config.c =3D> t/helper/test-config.c (100%)
 rename test-ctype.c =3D> t/helper/test-ctype.c (100%)
 rename test-date.c =3D> t/helper/test-date.c (100%)
 rename test-delta.c =3D> t/helper/test-delta.c (100%)
 rename test-dump-cache-tree.c =3D> t/helper/test-dump-cache-tree.c (10=
0%)
 rename test-dump-split-index.c =3D> t/helper/test-dump-split-index.c (=
100%)
 rename test-dump-untracked-cache.c =3D> t/helper/test-dump-untracked-c=
ache.c (100%)
 rename test-fake-ssh.c =3D> t/helper/test-fake-ssh.c (100%)
 rename test-genrandom.c =3D> t/helper/test-genrandom.c (100%)
 rename test-hashmap.c =3D> t/helper/test-hashmap.c (100%)
 rename test-index-version.c =3D> t/helper/test-index-version.c (100%)
 rename test-line-buffer.c =3D> t/helper/test-line-buffer.c (100%)
 rename test-match-trees.c =3D> t/helper/test-match-trees.c (100%)
 rename test-mergesort.c =3D> t/helper/test-mergesort.c (100%)
 rename test-mktemp.c =3D> t/helper/test-mktemp.c (100%)
 rename test-parse-options.c =3D> t/helper/test-parse-options.c (100%)
 rename test-path-utils.c =3D> t/helper/test-path-utils.c (100%)
 rename test-prio-queue.c =3D> t/helper/test-prio-queue.c (100%)
 rename test-read-cache.c =3D> t/helper/test-read-cache.c (100%)
 rename test-regex.c =3D> t/helper/test-regex.c (100%)
 rename test-revision-walking.c =3D> t/helper/test-revision-walking.c (=
100%)
 rename test-run-command.c =3D> t/helper/test-run-command.c (100%)
 rename test-scrap-cache-tree.c =3D> t/helper/test-scrap-cache-tree.c (=
100%)
 rename test-sha1-array.c =3D> t/helper/test-sha1-array.c (100%)
 rename test-sha1.c =3D> t/helper/test-sha1.c (100%)
 rename test-sha1.sh =3D> t/helper/test-sha1.sh (96%)
 rename test-sigchain.c =3D> t/helper/test-sigchain.c (100%)
 rename test-string-list.c =3D> t/helper/test-string-list.c (100%)
 rename test-submodule-config.c =3D> t/helper/test-submodule-config.c (=
100%)
 rename test-subprocess.c =3D> t/helper/test-subprocess.c (100%)
 rename test-svn-fe.c =3D> t/helper/test-svn-fe.c (100%)
 rename test-urlmatch-normalization.c =3D> t/helper/test-urlmatch-norma=
lization.c (100%)
 rename test-wildmatch.c =3D> t/helper/test-wildmatch.c (100%)

diff --git a/.gitignore b/.gitignore
index 5087ce1..05cb58a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -179,39 +179,6 @@
 /gitweb/gitweb.cgi
 /gitweb/static/gitweb.js
 /gitweb/static/gitweb.min.*
-/test-chmtime
-/test-ctype
-/test-config
-/test-date
-/test-delta
-/test-dump-cache-tree
-/test-dump-split-index
-/test-dump-untracked-cache
-/test-fake-ssh
-/test-scrap-cache-tree
-/test-genrandom
-/test-hashmap
-/test-index-version
-/test-line-buffer
-/test-match-trees
-/test-mergesort
-/test-mktemp
-/test-parse-options
-/test-path-utils
-/test-prio-queue
-/test-read-cache
-/test-regex
-/test-revision-walking
-/test-run-command
-/test-sha1
-/test-sha1-array
-/test-sigchain
-/test-string-list
-/test-submodule-config
-/test-subprocess
-/test-svn-fe
-/test-urlmatch-normalization
-/test-wildmatch
 /common-cmds.h
 *.tar.gz
 *.dsc
diff --git a/Makefile b/Makefile
index 2742a69..0a5fb9d 100644
--- a/Makefile
+++ b/Makefile
@@ -624,7 +624,7 @@ TEST_PROGRAMS_NEED_X +=3D test-svn-fe
 TEST_PROGRAMS_NEED_X +=3D test-urlmatch-normalization
 TEST_PROGRAMS_NEED_X +=3D test-wildmatch
=20
-TEST_PROGRAMS =3D $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))
+TEST_PROGRAMS =3D $(patsubst %,t/helper/%$X,$(TEST_PROGRAMS_NEED_X))
=20
 # List built-in command $C whose implementation cmd_$C() is not in
 # builtin/$C.o but is linked in as part of some other command.
@@ -1904,7 +1904,7 @@ VCSSVN_OBJS +=3D vcs-svn/fast_export.o
 VCSSVN_OBJS +=3D vcs-svn/svndiff.o
 VCSSVN_OBJS +=3D vcs-svn/svndump.o
=20
-TEST_OBJS :=3D $(patsubst test-%$X,test-%.o,$(TEST_PROGRAMS))
+TEST_OBJS :=3D $(patsubst %$X,%.o,$(TEST_PROGRAMS))
 OBJECTS :=3D $(LIB_OBJS) $(BUILTIN_OBJS) $(PROGRAM_OBJS) $(TEST_OBJS) =
\
 	$(XDIFF_OBJS) \
 	$(VCSSVN_OBJS) \
@@ -2211,7 +2211,7 @@ bin-wrappers/%: wrap-for-bin.sh
 	@mkdir -p bin-wrappers
 	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	     -e 's|@@BUILD_DIR@@|$(shell pwd)|' \
-	     -e 's|@@PROG@@|$(@F)|' < $< > $@ && \
+	     -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%,$(@F))|' < $< >=
 $@ && \
 	chmod +x $@
=20
 # GNU make supports exporting all variables by "export" without parame=
ters.
@@ -2231,25 +2231,25 @@ perf: all
=20
 .PHONY: test perf
=20
-test-ctype$X: ctype.o
+t/helper/test-ctype$X: ctype.o
=20
-test-date$X: date.o ctype.o
+t/helper/test-date$X: date.o ctype.o
=20
-test-delta$X: diff-delta.o patch-delta.o
+t/helper/test-delta$X: diff-delta.o patch-delta.o
=20
-test-line-buffer$X: vcs-svn/lib.a
+t/helper/test-line-buffer$X: vcs-svn/lib.a
=20
-test-parse-options$X: parse-options.o parse-options-cb.o
+t/helper/test-parse-options$X: parse-options.o parse-options-cb.o
=20
-test-svn-fe$X: vcs-svn/lib.a
+t/helper/test-svn-fe$X: vcs-svn/lib.a
=20
 .PRECIOUS: $(TEST_OBJS)
=20
-test-%$X: test-%.o GIT-LDFLAGS $(GITLIBS)
+t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^=
) $(filter %.a,$^) $(LIBS)
=20
-check-sha1:: test-sha1$X
-	./test-sha1.sh
+check-sha1:: t/helper/test-sha1$X
+	t/helper/test-sha1.sh
=20
 SP_OBJ =3D $(patsubst %.o,%.sp,$(C_OBJ))
=20
diff --git a/t/helper/.gitignore b/t/helper/.gitignore
new file mode 100644
index 0000000..d6e8b36
--- /dev/null
+++ b/t/helper/.gitignore
@@ -0,0 +1,33 @@
+/test-chmtime
+/test-ctype
+/test-config
+/test-date
+/test-delta
+/test-dump-cache-tree
+/test-dump-split-index
+/test-dump-untracked-cache
+/test-fake-ssh
+/test-scrap-cache-tree
+/test-genrandom
+/test-hashmap
+/test-index-version
+/test-line-buffer
+/test-match-trees
+/test-mergesort
+/test-mktemp
+/test-parse-options
+/test-path-utils
+/test-prio-queue
+/test-read-cache
+/test-regex
+/test-revision-walking
+/test-run-command
+/test-sha1
+/test-sha1-array
+/test-sigchain
+/test-string-list
+/test-submodule-config
+/test-subprocess
+/test-svn-fe
+/test-urlmatch-normalization
+/test-wildmatch
diff --git a/test-chmtime.c b/t/helper/test-chmtime.c
similarity index 100%
rename from test-chmtime.c
rename to t/helper/test-chmtime.c
diff --git a/test-config.c b/t/helper/test-config.c
similarity index 100%
rename from test-config.c
rename to t/helper/test-config.c
diff --git a/test-ctype.c b/t/helper/test-ctype.c
similarity index 100%
rename from test-ctype.c
rename to t/helper/test-ctype.c
diff --git a/test-date.c b/t/helper/test-date.c
similarity index 100%
rename from test-date.c
rename to t/helper/test-date.c
diff --git a/test-delta.c b/t/helper/test-delta.c
similarity index 100%
rename from test-delta.c
rename to t/helper/test-delta.c
diff --git a/test-dump-cache-tree.c b/t/helper/test-dump-cache-tree.c
similarity index 100%
rename from test-dump-cache-tree.c
rename to t/helper/test-dump-cache-tree.c
diff --git a/test-dump-split-index.c b/t/helper/test-dump-split-index.c
similarity index 100%
rename from test-dump-split-index.c
rename to t/helper/test-dump-split-index.c
diff --git a/test-dump-untracked-cache.c b/t/helper/test-dump-untracked=
-cache.c
similarity index 100%
rename from test-dump-untracked-cache.c
rename to t/helper/test-dump-untracked-cache.c
diff --git a/test-fake-ssh.c b/t/helper/test-fake-ssh.c
similarity index 100%
rename from test-fake-ssh.c
rename to t/helper/test-fake-ssh.c
diff --git a/test-genrandom.c b/t/helper/test-genrandom.c
similarity index 100%
rename from test-genrandom.c
rename to t/helper/test-genrandom.c
diff --git a/test-hashmap.c b/t/helper/test-hashmap.c
similarity index 100%
rename from test-hashmap.c
rename to t/helper/test-hashmap.c
diff --git a/test-index-version.c b/t/helper/test-index-version.c
similarity index 100%
rename from test-index-version.c
rename to t/helper/test-index-version.c
diff --git a/test-line-buffer.c b/t/helper/test-line-buffer.c
similarity index 100%
rename from test-line-buffer.c
rename to t/helper/test-line-buffer.c
diff --git a/test-match-trees.c b/t/helper/test-match-trees.c
similarity index 100%
rename from test-match-trees.c
rename to t/helper/test-match-trees.c
diff --git a/test-mergesort.c b/t/helper/test-mergesort.c
similarity index 100%
rename from test-mergesort.c
rename to t/helper/test-mergesort.c
diff --git a/test-mktemp.c b/t/helper/test-mktemp.c
similarity index 100%
rename from test-mktemp.c
rename to t/helper/test-mktemp.c
diff --git a/test-parse-options.c b/t/helper/test-parse-options.c
similarity index 100%
rename from test-parse-options.c
rename to t/helper/test-parse-options.c
diff --git a/test-path-utils.c b/t/helper/test-path-utils.c
similarity index 100%
rename from test-path-utils.c
rename to t/helper/test-path-utils.c
diff --git a/test-prio-queue.c b/t/helper/test-prio-queue.c
similarity index 100%
rename from test-prio-queue.c
rename to t/helper/test-prio-queue.c
diff --git a/test-read-cache.c b/t/helper/test-read-cache.c
similarity index 100%
rename from test-read-cache.c
rename to t/helper/test-read-cache.c
diff --git a/test-regex.c b/t/helper/test-regex.c
similarity index 100%
rename from test-regex.c
rename to t/helper/test-regex.c
diff --git a/test-revision-walking.c b/t/helper/test-revision-walking.c
similarity index 100%
rename from test-revision-walking.c
rename to t/helper/test-revision-walking.c
diff --git a/test-run-command.c b/t/helper/test-run-command.c
similarity index 100%
rename from test-run-command.c
rename to t/helper/test-run-command.c
diff --git a/test-scrap-cache-tree.c b/t/helper/test-scrap-cache-tree.c
similarity index 100%
rename from test-scrap-cache-tree.c
rename to t/helper/test-scrap-cache-tree.c
diff --git a/test-sha1-array.c b/t/helper/test-sha1-array.c
similarity index 100%
rename from test-sha1-array.c
rename to t/helper/test-sha1-array.c
diff --git a/test-sha1.c b/t/helper/test-sha1.c
similarity index 100%
rename from test-sha1.c
rename to t/helper/test-sha1.c
diff --git a/test-sha1.sh b/t/helper/test-sha1.sh
similarity index 96%
rename from test-sha1.sh
rename to t/helper/test-sha1.sh
index cef4bcc..750b95a 100755
--- a/test-sha1.sh
+++ b/t/helper/test-sha1.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
=20
 dd if=3D/dev/zero bs=3D1048576 count=3D100 2>/dev/null |
-/usr/bin/time ./test-sha1 >/dev/null
+/usr/bin/time t/helper/test-sha1 >/dev/null
=20
 while read expect cnt pfx
 do
@@ -11,7 +11,7 @@ do
 			test -z "$pfx" || echo "$pfx"
 			dd if=3D/dev/zero bs=3D1048576 count=3D$cnt 2>/dev/null |
 			perl -pe 'y/\000/g/'
-		} | ./test-sha1 $cnt
+		} | ./t/helper/test-sha1 $cnt
 	)
 	if test "$expect" =3D "$actual"
 	then
diff --git a/test-sigchain.c b/t/helper/test-sigchain.c
similarity index 100%
rename from test-sigchain.c
rename to t/helper/test-sigchain.c
diff --git a/test-string-list.c b/t/helper/test-string-list.c
similarity index 100%
rename from test-string-list.c
rename to t/helper/test-string-list.c
diff --git a/test-submodule-config.c b/t/helper/test-submodule-config.c
similarity index 100%
rename from test-submodule-config.c
rename to t/helper/test-submodule-config.c
diff --git a/test-subprocess.c b/t/helper/test-subprocess.c
similarity index 100%
rename from test-subprocess.c
rename to t/helper/test-subprocess.c
diff --git a/test-svn-fe.c b/t/helper/test-svn-fe.c
similarity index 100%
rename from test-svn-fe.c
rename to t/helper/test-svn-fe.c
diff --git a/test-urlmatch-normalization.c b/t/helper/test-urlmatch-nor=
malization.c
similarity index 100%
rename from test-urlmatch-normalization.c
rename to t/helper/test-urlmatch-normalization.c
diff --git a/test-wildmatch.c b/t/helper/test-wildmatch.c
similarity index 100%
rename from test-wildmatch.c
rename to t/helper/test-wildmatch.c
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index c1efb8e..150aeaf 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -308,7 +308,7 @@ test_expect_success 'clone checking out a tag' '
=20
 setup_ssh_wrapper () {
 	test_expect_success 'setup ssh wrapper' '
-		cp "$GIT_BUILD_DIR/test-fake-ssh$X" \
+		cp "$GIT_BUILD_DIR/t/helper/test-fake-ssh$X" \
 			"$TRASH_DIRECTORY/ssh-wrapper$X" &&
 		GIT_SSH=3D"$TRASH_DIRECTORY/ssh-wrapper$X" &&
 		export GIT_SSH &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0b47eb6..cd0ecd4 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -854,10 +854,10 @@ test -d "$GIT_BUILD_DIR"/templates/blt || {
 	error "You haven't built things yet, have you?"
 }
=20
-if ! test -x "$GIT_BUILD_DIR"/test-chmtime
+if ! test -x "$GIT_BUILD_DIR"/t/helper/test-chmtime
 then
 	echo >&2 'You need to build test-chmtime:'
-	echo >&2 'Run "make test-chmtime" in the source (toplevel) directory'
+	echo >&2 'Run "make t/helper/test-chmtime" in the source (toplevel) d=
irectory'
 	exit 1
 fi
=20
--=20
2.8.0.rc0.210.gd302cd2
