From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH] t5000, t5003: do not use test_cmp to compare binary files
Date: Wed, 4 Jun 2014 13:42:52 +0200
Organization: <)><
Message-ID: <20140604114252.GA22250@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Braun <thomas.braun@virtuell-zuhause.de>, msysgit@googlegroups.com
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRBP4MXSOAKGQENB47VPA@googlegroups.com Wed Jun 04 13:42:57 2014
Return-path: <msysgit+bncBCU63DXMWULRBP4MXSOAKGQENB47VPA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f192.google.com ([209.85.212.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBP4MXSOAKGQENB47VPA@googlegroups.com>)
	id 1Ws9aq-0005Sy-SM
	for gcvm-msysgit@m.gmane.org; Wed, 04 Jun 2014 13:42:56 +0200
Received: by mail-wi0-f192.google.com with SMTP id z2sf85654wiv.9
        for <gcvm-msysgit@m.gmane.org>; Wed, 04 Jun 2014 04:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:mime-version:organization
         :user-agent:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type
         :content-disposition;
        bh=TqYEk5oYjQj7XJt56d4Q95MF+G6Bfh4oU5uzlAmuK1U=;
        b=E5mTgasJ01vOxN1wdFBYi6O8GCwq2/9jzM0JfJhudCY3JzsYSclzSKVd1djhcUxLPx
         OIahFwsMiegvlMpM462ZHLKf2fO0UxnVtw4zeZVe/wg0DiJ9qI4JqKj19/oeglBUYrLb
         9wvscQ0Mcjj1LKyx9wnpHGFaqd7uJ/CH14BYgKvjramDlEqQxfWPx8zMlWjaS0n85RW+
         2r+T9w8bC+cyb5C9tC0ge7qgvwvTGydOzCfNlMM5cuY/0nWUknxHShpFzn7SRbKC7m8u
         TPPqy0XAQZTiw176YM8swnp/jllKM8jbys8mY0WAEFZOwuo2TLE/D0lRZ3fjJ+8DthFQ
         Q8pw==
X-Received: by 10.180.14.5 with SMTP id l5mr8332wic.12.1401882176455;
        Wed, 04 Jun 2014 04:42:56 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.86.98 with SMTP id o2ls255945wiz.46.gmail; Wed, 04 Jun
 2014 04:42:55 -0700 (PDT)
X-Received: by 10.180.14.129 with SMTP id p1mr497604wic.0.1401882175377;
        Wed, 04 Jun 2014 04:42:55 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id se3si1122994wic.3.2014.06.04.04.42.54
        for <msysgit@googlegroups.com>;
        Wed, 04 Jun 2014 04:42:54 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id BD3131C0076;
	Wed,  4 Jun 2014 13:42:53 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s54BgrXl022258;
	Wed, 4 Jun 2014 13:42:53 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s54BgqSe022256;
	Wed, 4 Jun 2014 13:42:52 +0200
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Original-Sender: kasal@ucw.cz
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: kasal@ucw.cz does not designate permitted sender hosts) smtp.mail=kasal@ucw.cz
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250722>

test_cmp() is primarily meant to compare text files (and display the
difference for debug purposes).

Raw "cmp" is better suited to compare binary files (tar, zip, etc.).

On MinGW, test_cmp is a shell function mingw_test_cmp that tries to
read both files into environment, stripping CR characters (introduced
in commit 4d715ac0).

This function usually speeds things up, as fork is extremly slow on
Windows.  But no wonder that this function is extremely slow and
sometimes even crashes when comparing large tar or zip files.

Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 t/t5000-tar-tree.sh             | 34 +++++++++++++++++-----------------
 t/t5001-archive-attr.sh         |  2 +-
 t/t5003-archive-zip.sh          |  6 +++---
 t/t5004-archive-corner-cases.sh |  2 +-
 4 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 1cf0a4e..31b1fd1 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -164,7 +164,7 @@ check_tar with_olde-prefix olde-
 test_expect_success 'git archive on large files' '
     test_config core.bigfilethreshold 1 &&
     git archive HEAD >b3.tar &&
-    test_cmp b.tar b3.tar
+    cmp b.tar b3.tar
 '
 
 test_expect_success \
@@ -173,15 +173,15 @@ test_expect_success \
 
 test_expect_success \
     'git archive vs. the same in a bare repo' \
-    'test_cmp b.tar b3.tar'
+    'cmp b.tar b3.tar'
 
 test_expect_success 'git archive with --output' \
     'git archive --output=b4.tar HEAD &&
-    test_cmp b.tar b4.tar'
+    cmp b.tar b4.tar'
 
 test_expect_success 'git archive --remote' \
     'git archive --remote=. HEAD >b5.tar &&
-    test_cmp b.tar b5.tar'
+    cmp b.tar b5.tar'
 
 test_expect_success \
     'validate file modification time' \
@@ -198,7 +198,7 @@ test_expect_success \
 
 test_expect_success 'git archive with --output, override inferred format' '
 	git archive --format=tar --output=d4.zip HEAD &&
-	test_cmp b.tar d4.zip
+	cmp b.tar d4.zip
 '
 
 test_expect_success \
@@ -244,34 +244,34 @@ test_expect_success 'archive --list shows only enabled remote filters' '
 test_expect_success 'invoke tar filter by format' '
 	git archive --format=tar.foo HEAD >config.tar.foo &&
 	tr ab ba <config.tar.foo >config.tar &&
-	test_cmp b.tar config.tar &&
+	cmp b.tar config.tar &&
 	git archive --format=bar HEAD >config.bar &&
 	tr ab ba <config.bar >config.tar &&
-	test_cmp b.tar config.tar
+	cmp b.tar config.tar
 '
 
 test_expect_success 'invoke tar filter by extension' '
 	git archive -o config-implicit.tar.foo HEAD &&
-	test_cmp config.tar.foo config-implicit.tar.foo &&
+	cmp config.tar.foo config-implicit.tar.foo &&
 	git archive -o config-implicit.bar HEAD &&
-	test_cmp config.tar.foo config-implicit.bar
+	cmp config.tar.foo config-implicit.bar
 '
 
 test_expect_success 'default output format remains tar' '
 	git archive -o config-implicit.baz HEAD &&
-	test_cmp b.tar config-implicit.baz
+	cmp b.tar config-implicit.baz
 '
 
 test_expect_success 'extension matching requires dot' '
 	git archive -o config-implicittar.foo HEAD &&
-	test_cmp b.tar config-implicittar.foo
+	cmp b.tar config-implicittar.foo
 '
 
 test_expect_success 'only enabled filters are available remotely' '
 	test_must_fail git archive --remote=. --format=tar.foo HEAD \
 		>remote.tar.foo &&
 	git archive --remote=. --format=bar >remote.bar HEAD &&
-	test_cmp remote.bar config.bar
+	cmp remote.bar config.bar
 '
 
 test_expect_success GZIP 'git archive --format=tgz' '
@@ -280,27 +280,27 @@ test_expect_success GZIP 'git archive --format=tgz' '
 
 test_expect_success GZIP 'git archive --format=tar.gz' '
 	git archive --format=tar.gz HEAD >j1.tar.gz &&
-	test_cmp j.tgz j1.tar.gz
+	cmp j.tgz j1.tar.gz
 '
 
 test_expect_success GZIP 'infer tgz from .tgz filename' '
 	git archive --output=j2.tgz HEAD &&
-	test_cmp j.tgz j2.tgz
+	cmp j.tgz j2.tgz
 '
 
 test_expect_success GZIP 'infer tgz from .tar.gz filename' '
 	git archive --output=j3.tar.gz HEAD &&
-	test_cmp j.tgz j3.tar.gz
+	cmp j.tgz j3.tar.gz
 '
 
 test_expect_success GZIP 'extract tgz file' '
 	gzip -d -c <j.tgz >j.tar &&
-	test_cmp b.tar j.tar
+	cmp b.tar j.tar
 '
 
 test_expect_success GZIP 'remote tar.gz is allowed by default' '
 	git archive --remote=. --format=tar.gz HEAD >remote.tar.gz &&
-	test_cmp j.tgz remote.tar.gz
+	cmp j.tgz remote.tar.gz
 '
 
 test_expect_success GZIP 'remote tar.gz can be disabled' '
diff --git a/t/t5001-archive-attr.sh b/t/t5001-archive-attr.sh
index 51dedab..dfc35b3 100755
--- a/t/t5001-archive-attr.sh
+++ b/t/t5001-archive-attr.sh
@@ -68,7 +68,7 @@ test_expect_missing	worktree2/ignored-by-worktree
 
 test_expect_success 'git archive vs. bare' '
 	(cd bare && git archive HEAD) >bare-archive.tar &&
-	test_cmp archive.tar bare-archive.tar
+	cmp archive.tar bare-archive.tar
 '
 
 test_expect_success 'git archive with worktree attributes, bare' '
diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
index c72f71e..aa096f6 100755
--- a/t/t5003-archive-zip.sh
+++ b/t/t5003-archive-zip.sh
@@ -97,15 +97,15 @@ test_expect_success \
 
 test_expect_success \
     'git archive --format=zip vs. the same in a bare repo' \
-    'test_cmp d.zip d1.zip'
+    'cmp d.zip d1.zip'
 
 test_expect_success 'git archive --format=zip with --output' \
     'git archive --format=zip --output=d2.zip HEAD &&
-    test_cmp d.zip d2.zip'
+    cmp d.zip d2.zip'
 
 test_expect_success 'git archive with --output, inferring format' '
 	git archive --output=d3.zip HEAD &&
-	test_cmp d.zip d3.zip
+	cmp d.zip d3.zip
 '
 
 test_expect_success \
diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-cases.sh
index 67f3b54..a980b10 100755
--- a/t/t5004-archive-corner-cases.sh
+++ b/t/t5004-archive-corner-cases.sh
@@ -45,7 +45,7 @@ test_expect_success HEADER_ONLY_TAR_OK 'tar archive of commit with empty tree' '
 test_expect_success 'tar archive of empty tree is empty' '
 	git archive --format=tar HEAD: >empty.tar &&
 	perl -e "print \"\\0\" x 10240" >10knuls.tar &&
-	test_cmp 10knuls.tar empty.tar
+	cmp 10knuls.tar empty.tar
 '
 
 test_expect_success 'tar archive of empty tree with prefix' '
-- 
2.0.0.9635.g0be03cb

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
