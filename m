From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH v2] t5000, t5003: do not use test_cmp to compare
 binary files
Date: Wed, 4 Jun 2014 17:57:52 +0200
Organization: <)><
Message-ID: <20140604155752.GA23226@camelia.ucw.cz>
References: <20140604114252.GA22250@camelia.ucw.cz> <538F0D78.3020708@virtuell-zuhause.de> <20140604124257.GA22415@camelia.ucw.cz> <538F1840.7010803@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Braun <thomas.braun@virtuell-zuhause.de>, msysgit@googlegroups.com
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRBAMEXWOAKGQECOETYXY@googlegroups.com Wed Jun 04 17:58:04 2014
Return-path: <msysgit+bncBCU63DXMWULRBAMEXWOAKGQECOETYXY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f56.google.com ([209.85.215.56])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBAMEXWOAKGQECOETYXY@googlegroups.com>)
	id 1WsDZa-00007y-DT
	for gcvm-msysgit@m.gmane.org; Wed, 04 Jun 2014 17:57:54 +0200
Received: by mail-la0-f56.google.com with SMTP id mc6sf734118lab.1
        for <gcvm-msysgit@m.gmane.org>; Wed, 04 Jun 2014 08:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:organization:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=LnkbfKzMim5G2o0SKtSAXn/pLRI0/m8+FyY7TRV5lzU=;
        b=KSBvMmgPdRF/NfSmy0bC92HL9TF0KkWQvmC4hS+8lErO3BZQY/P8dpzHE2ZPEyim4/
         Q/X/b0Fov9abSi9hiSitQkoMCBMlITU7U1eof6OpexI0+YO89JTkSVJocvQ2DIFD0z1K
         ZPWH101aji4Uuj6B1T/iF1Q6UjNkNcNIGh7+5X7gOQ64IHiWuDQGnZI6OPPR68hNgkwZ
         ltOtMANIdf9FraFSFkGOQTbZLCFVYBWoMzm0BF0g68oUmsBdfvYdKa4t5pR62pBK2vRm
         smcEg4yCf2XB10/25Oz3rsIum7pnxp9L+6nAqYc6ltX4TTQJB+EnXr3XKmv269vA+y1H
         4wAA==
X-Received: by 10.180.75.178 with SMTP id d18mr15436wiw.13.1401897474177;
        Wed, 04 Jun 2014 08:57:54 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.100.163 with SMTP id ez3ls310491wib.6.gmail; Wed, 04 Jun
 2014 08:57:53 -0700 (PDT)
X-Received: by 10.14.127.6 with SMTP id c6mr1834672eei.0.1401897473238;
        Wed, 04 Jun 2014 08:57:53 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id el3si1213238wib.0.2014.06.04.08.57.53
        for <msysgit@googlegroups.com>;
        Wed, 04 Jun 2014 08:57:53 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id D8FAE1C00A0;
	Wed,  4 Jun 2014 17:57:52 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s54FvqsF023299;
	Wed, 4 Jun 2014 17:57:52 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s54Fvq99023298;
	Wed, 4 Jun 2014 17:57:52 +0200
In-Reply-To: <538F1840.7010803@virtuell-zuhause.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250744>

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

Hi Thomas,
On Wed, Jun 04, 2014 at 02:59:44PM +0200, Thomas Braun wrote:
> Using test_cmp_bin instead of cmp would result in then four assertions
> for comparing arbitrary data
> test_cmp
> test_i18ncmp
> test_cmp_text
> test_cmp_bin
> where I think the purpose of each function is clear from its name.

[test_cmp_text does not exist (yet)]

OK, I agree, hence this modified version of the patch.

Stepan

 t/t5000-tar-tree.sh             | 34 +++++++++++++++++-----------------
 t/t5001-archive-attr.sh         |  2 +-
 t/t5003-archive-zip.sh          |  6 +++---
 t/t5004-archive-corner-cases.sh |  2 +-
 t/test-lib-functions.sh         |  6 ++++++
 5 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 1cf0a4e..4efaf8c 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -164,7 +164,7 @@ check_tar with_olde-prefix olde-
 test_expect_success 'git archive on large files' '
     test_config core.bigfilethreshold 1 &&
     git archive HEAD >b3.tar &&
-    test_cmp b.tar b3.tar
+    test_cmp_bin b.tar b3.tar
 '
 
 test_expect_success \
@@ -173,15 +173,15 @@ test_expect_success \
 
 test_expect_success \
     'git archive vs. the same in a bare repo' \
-    'test_cmp b.tar b3.tar'
+    'test_cmp_bin b.tar b3.tar'
 
 test_expect_success 'git archive with --output' \
     'git archive --output=b4.tar HEAD &&
-    test_cmp b.tar b4.tar'
+    test_cmp_bin b.tar b4.tar'
 
 test_expect_success 'git archive --remote' \
     'git archive --remote=. HEAD >b5.tar &&
-    test_cmp b.tar b5.tar'
+    test_cmp_bin b.tar b5.tar'
 
 test_expect_success \
     'validate file modification time' \
@@ -198,7 +198,7 @@ test_expect_success \
 
 test_expect_success 'git archive with --output, override inferred format' '
 	git archive --format=tar --output=d4.zip HEAD &&
-	test_cmp b.tar d4.zip
+	test_cmp_bin b.tar d4.zip
 '
 
 test_expect_success \
@@ -244,34 +244,34 @@ test_expect_success 'archive --list shows only enabled remote filters' '
 test_expect_success 'invoke tar filter by format' '
 	git archive --format=tar.foo HEAD >config.tar.foo &&
 	tr ab ba <config.tar.foo >config.tar &&
-	test_cmp b.tar config.tar &&
+	test_cmp_bin b.tar config.tar &&
 	git archive --format=bar HEAD >config.bar &&
 	tr ab ba <config.bar >config.tar &&
-	test_cmp b.tar config.tar
+	test_cmp_bin b.tar config.tar
 '
 
 test_expect_success 'invoke tar filter by extension' '
 	git archive -o config-implicit.tar.foo HEAD &&
-	test_cmp config.tar.foo config-implicit.tar.foo &&
+	test_cmp_bin config.tar.foo config-implicit.tar.foo &&
 	git archive -o config-implicit.bar HEAD &&
-	test_cmp config.tar.foo config-implicit.bar
+	test_cmp_bin config.tar.foo config-implicit.bar
 '
 
 test_expect_success 'default output format remains tar' '
 	git archive -o config-implicit.baz HEAD &&
-	test_cmp b.tar config-implicit.baz
+	test_cmp_bin b.tar config-implicit.baz
 '
 
 test_expect_success 'extension matching requires dot' '
 	git archive -o config-implicittar.foo HEAD &&
-	test_cmp b.tar config-implicittar.foo
+	test_cmp_bin b.tar config-implicittar.foo
 '
 
 test_expect_success 'only enabled filters are available remotely' '
 	test_must_fail git archive --remote=. --format=tar.foo HEAD \
 		>remote.tar.foo &&
 	git archive --remote=. --format=bar >remote.bar HEAD &&
-	test_cmp remote.bar config.bar
+	test_cmp_bin remote.bar config.bar
 '
 
 test_expect_success GZIP 'git archive --format=tgz' '
@@ -280,27 +280,27 @@ test_expect_success GZIP 'git archive --format=tgz' '
 
 test_expect_success GZIP 'git archive --format=tar.gz' '
 	git archive --format=tar.gz HEAD >j1.tar.gz &&
-	test_cmp j.tgz j1.tar.gz
+	test_cmp_bin j.tgz j1.tar.gz
 '
 
 test_expect_success GZIP 'infer tgz from .tgz filename' '
 	git archive --output=j2.tgz HEAD &&
-	test_cmp j.tgz j2.tgz
+	test_cmp_bin j.tgz j2.tgz
 '
 
 test_expect_success GZIP 'infer tgz from .tar.gz filename' '
 	git archive --output=j3.tar.gz HEAD &&
-	test_cmp j.tgz j3.tar.gz
+	test_cmp_bin j.tgz j3.tar.gz
 '
 
 test_expect_success GZIP 'extract tgz file' '
 	gzip -d -c <j.tgz >j.tar &&
-	test_cmp b.tar j.tar
+	test_cmp_bin b.tar j.tar
 '
 
 test_expect_success GZIP 'remote tar.gz is allowed by default' '
 	git archive --remote=. --format=tar.gz HEAD >remote.tar.gz &&
-	test_cmp j.tgz remote.tar.gz
+	test_cmp_bin j.tgz remote.tar.gz
 '
 
 test_expect_success GZIP 'remote tar.gz can be disabled' '
diff --git a/t/t5001-archive-attr.sh b/t/t5001-archive-attr.sh
index 51dedab..b04d955 100755
--- a/t/t5001-archive-attr.sh
+++ b/t/t5001-archive-attr.sh
@@ -68,7 +68,7 @@ test_expect_missing	worktree2/ignored-by-worktree
 
 test_expect_success 'git archive vs. bare' '
 	(cd bare && git archive HEAD) >bare-archive.tar &&
-	test_cmp archive.tar bare-archive.tar
+	test_cmp_bin archive.tar bare-archive.tar
 '
 
 test_expect_success 'git archive with worktree attributes, bare' '
diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
index c72f71e..21a5c93 100755
--- a/t/t5003-archive-zip.sh
+++ b/t/t5003-archive-zip.sh
@@ -97,15 +97,15 @@ test_expect_success \
 
 test_expect_success \
     'git archive --format=zip vs. the same in a bare repo' \
-    'test_cmp d.zip d1.zip'
+    'test_cmp_bin d.zip d1.zip'
 
 test_expect_success 'git archive --format=zip with --output' \
     'git archive --format=zip --output=d2.zip HEAD &&
-    test_cmp d.zip d2.zip'
+    test_cmp_bin d.zip d2.zip'
 
 test_expect_success 'git archive with --output, inferring format' '
 	git archive --output=d3.zip HEAD &&
-	test_cmp d.zip d3.zip
+	test_cmp_bin d.zip d3.zip
 '
 
 test_expect_success \
diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-cases.sh
index 67f3b54..305bcac 100755
--- a/t/t5004-archive-corner-cases.sh
+++ b/t/t5004-archive-corner-cases.sh
@@ -45,7 +45,7 @@ test_expect_success HEADER_ONLY_TAR_OK 'tar archive of commit with empty tree' '
 test_expect_success 'tar archive of empty tree is empty' '
 	git archive --format=tar HEAD: >empty.tar &&
 	perl -e "print \"\\0\" x 10240" >10knuls.tar &&
-	test_cmp 10knuls.tar empty.tar
+	test_cmp_bin 10knuls.tar empty.tar
 '
 
 test_expect_success 'tar archive of empty tree with prefix' '
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 158e10a..cf7b41f 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -617,6 +617,12 @@ test_cmp() {
 	$GIT_TEST_CMP "$@"
 }
 
+# test_cmp_bin - helper to compare binary files
+
+test_cmp_bin() {
+	cmp "$@"
+}
+
 # Check if the file expected to be empty is indeed empty, and barfs
 # otherwise.
 
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
