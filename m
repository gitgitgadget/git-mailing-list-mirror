From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 2/4] t6302: normalize names and descriptions of signed tags
Date: Sun,  6 Mar 2016 19:10:25 -0500
Message-ID: <1457309427-30124-3-git-send-email-sunshine@sunshineco.com>
References: <1457309427-30124-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 07 01:11:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acilS-00082O-IR
	for gcvg-git-2@plane.gmane.org; Mon, 07 Mar 2016 01:11:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbcCGALG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2016 19:11:06 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:35861 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054AbcCGALA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2016 19:11:00 -0500
Received: by mail-io0-f195.google.com with SMTP id m184so9596604iof.3
        for <git@vger.kernel.org>; Sun, 06 Mar 2016 16:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dH+YHe7e+VgulDORVdmv0XozrbutIVMTFwcLtvV3vK0=;
        b=FAuY3GsEdWCRt/qrJ5Y9dkJxxh4pxCL1KPluTzOT9EtkKzZFQiVNChyyr9kB/RWZh2
         b0skShh9YZi0xttZOqcE+jtUiuds5kav1AAi+cVJnTX1kmY739ldcv9vIck2RpGxdllC
         wkx6Aa7dI0nX2UxnBWRnIzk9XXUSZO/NJxuXWTHEctleUaqEL5p2dE0F4mLRmME8Nth0
         jWXewesr07x4y5kbvJ5KNyO+0PkBtPyj/g6EcK2/dJyMbVOSAZMlqOVxHH7s/huDkA2+
         1EzVGyyNDV7ZBFd3Z2FfKj65v1i/Radp2I+GhMyjLlCqxu2FKi+GHTYVKe7McBCH+6lh
         Bihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=dH+YHe7e+VgulDORVdmv0XozrbutIVMTFwcLtvV3vK0=;
        b=You0LB0ZiQJ/dkztpKYKBx35VEAK0Aw7alz1VFwED3Aw0R98ZS7S8sfHQt3It5TRSW
         jXQSKLRuGz6fgwLzkplScwsWmYcev8BBum3fzqfwToNfuUGXzQMnzFe6UkTh08xGlqw5
         +29LqeZ1P2h4pmHpR7S5x4Xitpzs0/5gaQ/Xx6OOKFfA1jxIrfamfZjbxa3L1JVdSnZ0
         QW2dt1tila2OVs2UZPAGrEGJjUIS6PxE2IQIuBiuXjhpmWjPhmXvBtqpoqDQEDqtGesX
         IxPBXVbQXpOTMxPW12onD4xfNluGP9yw3k4AUb3I5vswmhD52woGCWeBaq1yroEfPwbi
         Dtxg==
X-Gm-Message-State: AD7BkJKgQ3wFnVMN+WJRlif5XI/9sOnn3WHuP1MlN3uQ6Bwc2b8RUIUY9ekbARjDxb+9xQ==
X-Received: by 10.107.34.139 with SMTP id i133mr16642603ioi.108.1457309458929;
        Sun, 06 Mar 2016 16:10:58 -0800 (PST)
Received: from localhost.localdomain (user-12l3c5v.cable.mindspring.com. [69.81.176.191])
        by smtp.gmail.com with ESMTPSA id t62sm1337418ioi.41.2016.03.06.16.10.58
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 06 Mar 2016 16:10:58 -0800 (PST)
X-Mailer: git-send-email 2.8.0.rc1.175.g19dcece
In-Reply-To: <1457309427-30124-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288368>

An upcoming patch will increase test coverage by testing annotated but
not signed tags, as well, so normalize names and descriptions of signed
tags to make it easy to give the upcoming unsigned tags similarly
patterned names and descriptions.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t6302-for-each-ref-filter.sh | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index bcf472b..54a7387 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -17,8 +17,8 @@ test_expect_success 'setup some history and refs' '
 	test_commit three &&
 	git checkout -b side &&
 	test_commit four &&
-	git tag -s -m "A signed tag message" signed-tag &&
-	git tag -s -m "Annonated doubly" double-tag signed-tag &&
+	git tag -s -m "A signed tag" signed-tag &&
+	git tag -s -m "Signed doubly" doubly-signed-tag signed-tag &&
 	git checkout master &&
 	git update-ref refs/odd/spot master
 '
@@ -58,7 +58,7 @@ test_expect_success 'filtering with --merged' '
 test_expect_success 'filtering with --no-merged' '
 	cat >expect <<-\EOF &&
 	refs/heads/side
-	refs/tags/double-tag
+	refs/tags/doubly-signed-tag
 	refs/tags/four
 	refs/tags/signed-tag
 	EOF
@@ -71,7 +71,7 @@ test_expect_success 'filtering with --contains' '
 	refs/heads/master
 	refs/heads/side
 	refs/odd/spot
-	refs/tags/double-tag
+	refs/tags/doubly-signed-tag
 	refs/tags/four
 	refs/tags/signed-tag
 	refs/tags/three
@@ -90,7 +90,7 @@ test_expect_success 'left alignment is default' '
 	refname is refs/heads/master  |refs/heads/master
 	refname is refs/heads/side    |refs/heads/side
 	refname is refs/odd/spot      |refs/odd/spot
-	refname is refs/tags/double-tag|refs/tags/double-tag
+	refname is refs/tags/doubly-signed-tag|refs/tags/doubly-signed-tag
 	refname is refs/tags/four     |refs/tags/four
 	refname is refs/tags/one      |refs/tags/one
 	refname is refs/tags/signed-tag|refs/tags/signed-tag
@@ -106,7 +106,7 @@ test_expect_success 'middle alignment' '
 	| refname is refs/heads/master |refs/heads/master
 	|  refname is refs/heads/side  |refs/heads/side
 	|   refname is refs/odd/spot   |refs/odd/spot
-	|refname is refs/tags/double-tag|refs/tags/double-tag
+	|refname is refs/tags/doubly-signed-tag|refs/tags/doubly-signed-tag
 	|  refname is refs/tags/four   |refs/tags/four
 	|   refname is refs/tags/one   |refs/tags/one
 	|refname is refs/tags/signed-tag|refs/tags/signed-tag
@@ -122,7 +122,7 @@ test_expect_success 'right alignment' '
 	|  refname is refs/heads/master|refs/heads/master
 	|    refname is refs/heads/side|refs/heads/side
 	|      refname is refs/odd/spot|refs/odd/spot
-	|refname is refs/tags/double-tag|refs/tags/double-tag
+	|refname is refs/tags/doubly-signed-tag|refs/tags/doubly-signed-tag
 	|     refname is refs/tags/four|refs/tags/four
 	|      refname is refs/tags/one|refs/tags/one
 	|refname is refs/tags/signed-tag|refs/tags/signed-tag
@@ -137,7 +137,7 @@ cat >expect <<-\EOF
 |       refname is refs/heads/master       |refs/heads/master
 |        refname is refs/heads/side        |refs/heads/side
 |         refname is refs/odd/spot         |refs/odd/spot
-|     refname is refs/tags/double-tag      |refs/tags/double-tag
+|  refname is refs/tags/doubly-signed-tag  |refs/tags/doubly-signed-tag
 |        refname is refs/tags/four         |refs/tags/four
 |         refname is refs/tags/one         |refs/tags/one
 |     refname is refs/tags/signed-tag      |refs/tags/signed-tag
@@ -182,7 +182,7 @@ test_expect_success 'alignment with format quote' "
 	|'      '\''master| A U Thor'\''      '|
 	|'       '\''side| A U Thor'\''       '|
 	|'     '\''odd/spot| A U Thor'\''     '|
-	|'        '\''double-tag| '\''        '|
+	|'    '\''doubly-signed-tag| '\''     '|
 	|'       '\''four| A U Thor'\''       '|
 	|'       '\''one| A U Thor'\''        '|
 	|'        '\''signed-tag| '\''        '|
@@ -198,7 +198,7 @@ test_expect_success 'nested alignment with quote formatting' "
 	|'         master               '|
 	|'           side               '|
 	|'       odd/spot               '|
-	|'     double-tag               '|
+	|'doubly-signed-tag             '|
 	|'           four               '|
 	|'            one               '|
 	|'     signed-tag               '|
@@ -214,10 +214,10 @@ test_expect_success 'check `%(contents:lines=1)`' '
 	master |three
 	side |four
 	odd/spot |three
-	double-tag |Annonated doubly
+	doubly-signed-tag |Signed doubly
 	four |four
 	one |one
-	signed-tag |A signed tag message
+	signed-tag |A signed tag
 	three |three
 	two |two
 	EOF
@@ -230,7 +230,7 @@ test_expect_success 'check `%(contents:lines=0)`' '
 	master |
 	side |
 	odd/spot |
-	double-tag |
+	doubly-signed-tag |
 	four |
 	one |
 	signed-tag |
@@ -246,10 +246,10 @@ test_expect_success 'check `%(contents:lines=99999)`' '
 	master |three
 	side |four
 	odd/spot |three
-	double-tag |Annonated doubly
+	doubly-signed-tag |Signed doubly
 	four |four
 	one |one
-	signed-tag |A signed tag message
+	signed-tag |A signed tag
 	three |three
 	two |two
 	EOF
-- 
2.8.0.rc1.175.g19dcece
