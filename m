From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 3/3] tests: do not pass iso8859-1 encoded parameter
Date: Tue, 15 Jul 2014 15:43:17 +0200
Message-ID: <1405431797-20899-4-git-send-email-kasal@ucw.cz>
References: <20140712075035.GA12400@ucw.cz>
 <1405431797-20899-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GIT Mailing-list <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Stepan Kasal <kasal@ucw.cz>
To: Karsten Blees <karsten.blees@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
X-From: msysgit+bncBCU63DXMWULRB767SSPAKGQEKNW2XJI@googlegroups.com Tue Jul 15 15:43:28 2014
Return-path: <msysgit+bncBCU63DXMWULRB767SSPAKGQEKNW2XJI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f187.google.com ([209.85.212.187])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRB767SSPAKGQEKNW2XJI@googlegroups.com>)
	id 1X730y-00077O-5i
	for gcvm-msysgit@m.gmane.org; Tue, 15 Jul 2014 15:43:28 +0200
Received: by mail-wi0-f187.google.com with SMTP id ho1sf433463wib.24
        for <gcvm-msysgit@m.gmane.org>; Tue, 15 Jul 2014 06:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=+N96om9g0fDzvTkmULPGH+KngqFoWESneiUSB6B69nU=;
        b=h5rkEVdwYhiqltVWebi47c6VXnydY27W3sDJJUlFr5if0GoFDutI4oVs9dUUVNWsHu
         CK9RW9kzMOcszQUMDC+iFhmkyn/pnUDQzT3tfiXmV2AKRCrEXXwfuLqOu7ruNVAFan83
         PQyD9AJgZX9oMQgTuc1l8jCPm+85Ld8LD54+7njwEWX9HFrYV8XQ/z30VkKKCv2BHO7V
         oTjT1JBJblBPnKFqKT7wjUFKbWEr2C0TxIT8QxXa4ptmbPuLSZli59riycl3ciBq4Zs5
         gJU7hGghoAAfApKik8Xqlxnz9B2UqMOJotSpEfwQbx921oeX3m8/ZL8RcXo9zNPnMHWq
         XhrA==
X-Received: by 10.180.182.4 with SMTP id ea4mr18800wic.16.1405431807918;
        Tue, 15 Jul 2014 06:43:27 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.12.240 with SMTP id b16ls542153wic.34.canary; Tue, 15 Jul
 2014 06:43:26 -0700 (PDT)
X-Received: by 10.194.103.133 with SMTP id fw5mr2121992wjb.3.1405431806789;
        Tue, 15 Jul 2014 06:43:26 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id r13si650346wib.0.2014.07.15.06.43.26
        for <msysgit@googlegroups.com>;
        Tue, 15 Jul 2014 06:43:26 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id 8F2251C0153; Tue, 15 Jul 2014 15:43:26 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1405431797-20899-1-git-send-email-kasal@ucw.cz>
X-Original-Sender: kasal@ucw.cz
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: kasal@ucw.cz does not designate permitted sender hosts) smtp.mail=kasal@ucw.cz
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253557>

From: Pat Thoyts <patthoyts@users.sourceforge.net>
Date: Mon, 2 Sep 2013 15:44:54 +0100

git commit -m with some iso8859-1 encoded stuff is doomed to fail in MinGW,
because Windows don't let you pass encoded bytes to a process (CreateProcessW
always takes a UTF-16LE encoded string).

It is safe to pass the iso8859-1 message using a file or a pipe.

Thanks-to: Karsten Blees <blees@dcon.de>
Author: Stepan Kasal <kasal@ucw.cz>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 t/t4041-diff-submodule-option.sh | 6 ++++--
 t/t4205-log-pretty-formats.sh    | 2 +-
 t/t6006-rev-list-format.sh       | 4 ++--
 t/t7102-reset.sh                 | 8 ++++++--
 4 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index 463d63b..e432896 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -26,8 +26,10 @@ add_file () {
 			echo "$name" >"$name" &&
 			git add "$name" &&
 			test_tick &&
-			msg_added_iso88591=$(echo "Add $name ($added $name)" | iconv -f utf-8 -t $test_encoding) &&
-			git -c "i18n.commitEncoding=$test_encoding" commit -m "$msg_added_iso88591"
+			# "git commit -m" would break MinGW, as Windows refuse to pass
+			# $test_encoding encoded parameter to git.
+			echo "Add $name ($added $name)" | iconv -f utf-8 -t $test_encoding |
+			git -c "i18n.commitEncoding=$test_encoding" commit -F -
 		done >/dev/null &&
 		git rev-parse --short --verify HEAD
 	)
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index c84ec9a..349c531 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -31,7 +31,7 @@ test_expect_success 'set up basic repos' '
 	git add foo &&
 	test_tick &&
 	git config i18n.commitEncoding $test_encoding &&
-	git commit -m "$(commit_msg $test_encoding)" &&
+	commit_msg $test_encoding | git commit -F - &&
 	git add bar &&
 	test_tick &&
 	git commit -m "add bar" &&
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 88ed319..a02a45a 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -35,13 +35,13 @@ test_expect_success 'setup' '
 	: >foo &&
 	git add foo &&
 	git config i18n.commitEncoding $test_encoding &&
-	git commit -m "$added_iso88591" &&
+	echo "$added_iso88591" | git commit -F - &&
 	head1=$(git rev-parse --verify HEAD) &&
 	head1_short=$(git rev-parse --verify --short $head1) &&
 	tree1=$(git rev-parse --verify HEAD:) &&
 	tree1_short=$(git rev-parse --verify --short $tree1) &&
 	echo "$changed" > foo &&
-	git commit -a -m "$changed_iso88591" &&
+	echo "$changed_iso88591" | git commit -a -F - &&
 	head2=$(git rev-parse --verify HEAD) &&
 	head2_short=$(git rev-parse --verify --short $head2) &&
 	tree2=$(git rev-parse --verify HEAD:) &&
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index ee703be..98bcfe2 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -44,7 +44,9 @@ test_expect_success 'creating initial files and commits' '
 
 	echo "1st line 2nd file" >secondfile &&
 	echo "2nd line 2nd file" >>secondfile &&
-	git -c "i18n.commitEncoding=$test_encoding" commit -a -m "$(commit_msg $test_encoding)" &&
+	# "git commit -m" would break MinGW, as Windows refuse to pass
+	# $test_encoding encoded parameter to git.
+	commit_msg $test_encoding | git -c "i18n.commitEncoding=$test_encoding" commit -a -F - &&
 	head5=$(git rev-parse --verify HEAD)
 '
 # git log --pretty=oneline # to see those SHA1 involved
@@ -334,7 +336,9 @@ test_expect_success 'redoing the last two commits should succeed' '
 
 	echo "1st line 2nd file" >secondfile &&
 	echo "2nd line 2nd file" >>secondfile &&
-	git -c "i18n.commitEncoding=$test_encoding" commit -a -m "$(commit_msg $test_encoding)" &&
+	# "git commit -m" would break MinGW, as Windows refuse to pass
+	# $test_encoding encoded parameter to git.
+	commit_msg $test_encoding | git -c "i18n.commitEncoding=$test_encoding" commit -a -F - &&
 	check_changes $head5
 '
 
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
