From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 099/144] t9101-git-svn-props.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:25:44 -0700
Message-ID: <1395735989-3396-100-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:28:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMiy-0000Pe-CQ
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:28:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753968AbaCYI22 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:28:28 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:52572 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbaCYI2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:28:25 -0400
Received: by mail-pb0-f42.google.com with SMTP id rr13so138281pbb.1
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=prhE0NgmJA1SU3m6Xwt78yOzkzXlpj8XcdTWlIPs5BM=;
        b=KKXnEkKTZlzbkz8u3UmqWwKbRQknN9cbO6wCRZbSMW4+huQos6d8gIf64nQURwI7Nj
         KzxJBFcASkTZ5Tz8mS3gLzIyDJHZ1XphNDvRL5S8M0CW1mBt8k/IcQG2XyrADmTWhRC7
         09I/OCDF3MJ6lBVidOG+zy3FUl6n6hZ+ss4qk8Rd4HC9XoIoZxwTavj7ol5ye9dfSLSe
         kfzzvagPb+ZLj/FJOmX6SfnLQIVuo5SZ59n5suls8g5Cwa8LFPeZDmDgIZn/arbd3zqS
         ZaRIH80P3149OBZaJZmezq3p5F9yux2IjfezJpUmLejaQmJmvyrWv0VdrQv234JMWrKt
         iV8g==
X-Received: by 10.68.110.165 with SMTP id ib5mr77037519pbb.61.1395736104780;
        Tue, 25 Mar 2014 01:28:24 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.28.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:28:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244937>

The Git CodingGuidelines prefer the $( ... ) construct for command
substitution instead of using the back-quotes, or grave accents (`..`).

The backquoted form is the historical method for command substitution,
and is supported by POSIX. However,all but the simplest uses become
complicated quickly. In particular,embedded command substitutions
and/or the use of double quotes require careful escaping with the backs=
lash
character. Because of this the POSIX shell adopted the $(=E2=80=A6) fea=
ture from
the Korn shell.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 t/t9101-git-svn-props.sh |   30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/t/t9101-git-svn-props.sh b/t/t9101-git-svn-props.sh
index 8869f50..e8173d5 100755
--- a/t/t9101-git-svn-props.sh
+++ b/t/t9101-git-svn-props.sh
@@ -26,27 +26,27 @@ cd import
 EOF
=20
 	printf "Hello\r\nWorld\r\n" > crlf
-	a_crlf=3D`git hash-object -w crlf`
+	a_crlf=3D$(git hash-object -w crlf)
 	printf "Hello\rWorld\r" > cr
-	a_cr=3D`git hash-object -w cr`
+	a_cr=3D$(git hash-object -w cr)
 	printf "Hello\nWorld\n" > lf
-	a_lf=3D`git hash-object -w lf`
+	a_lf=3D$(git hash-object -w lf)
=20
 	printf "Hello\r\nWorld" > ne_crlf
-	a_ne_crlf=3D`git hash-object -w ne_crlf`
+	a_ne_crlf=3D$(git hash-object -w ne_crlf)
 	printf "Hello\nWorld" > ne_lf
-	a_ne_lf=3D`git hash-object -w ne_lf`
+	a_ne_lf=3D$(git hash-object -w ne_lf)
 	printf "Hello\rWorld" > ne_cr
-	a_ne_cr=3D`git hash-object -w ne_cr`
+	a_ne_cr=3D$(git hash-object -w ne_cr)
=20
 	touch empty
-	a_empty=3D`git hash-object -w empty`
+	a_empty=3D$(git hash-object -w empty)
 	printf "\n" > empty_lf
-	a_empty_lf=3D`git hash-object -w empty_lf`
+	a_empty_lf=3D$(git hash-object -w empty_lf)
 	printf "\r" > empty_cr
-	a_empty_cr=3D`git hash-object -w empty_cr`
+	a_empty_cr=3D$(git hash-object -w empty_cr)
 	printf "\r\n" > empty_crlf
-	a_empty_crlf=3D`git hash-object -w empty_crlf`
+	a_empty_crlf=3D$(git hash-object -w empty_crlf)
=20
 	svn_cmd import --no-auto-props -m 'import for git svn' . "$svnrepo" >=
/dev/null
 cd ..
@@ -80,7 +80,7 @@ test_expect_success "$name" \
 	git pull . ${remotes_git_svn}'
=20
 expect=3D'/* $Id$ */'
-got=3D"`sed -ne 2p kw.c`"
+got=3D"$(sed -ne 2p kw.c)"
 test_expect_success 'raw $Id$ found in kw.c' "test '$expect' =3D '$got=
'"
=20
 test_expect_success "propset CR on crlf files" '
@@ -107,8 +107,8 @@ done
 cd test_wc
 	printf '$Id$\rHello\rWorld\r' > cr
 	printf '$Id$\rHello\rWorld' > ne_cr
-	a_cr=3D`printf '$Id$\r\nHello\r\nWorld\r\n' | git hash-object --stdin=
`
-	a_ne_cr=3D`printf '$Id$\r\nHello\r\nWorld' | git hash-object --stdin`
+	a_cr=3D$(printf '$Id$\r\nHello\r\nWorld\r\n' | git hash-object --stdi=
n)
+	a_ne_cr=3D$(printf '$Id$\r\nHello\r\nWorld' | git hash-object --stdin=
)
 	test_expect_success 'Set CRLF on cr files' \
 	'svn_cmd propset svn:eol-style CRLF cr &&
 	 svn_cmd propset svn:eol-style CRLF ne_cr &&
@@ -119,8 +119,8 @@ cd ..
 test_expect_success 'fetch and pull latest from svn' \
 	'git svn fetch && git pull . ${remotes_git_svn}'
=20
-b_cr=3D"`git hash-object cr`"
-b_ne_cr=3D"`git hash-object ne_cr`"
+b_cr=3D"$(git hash-object cr)"
+b_ne_cr=3D"$(git hash-object ne_cr)"
=20
 test_expect_success 'CRLF + $Id$' "test '$a_cr' =3D '$b_cr'"
 test_expect_success 'CRLF + $Id$ (no newline)' "test '$a_ne_cr' =3D '$=
b_ne_cr'"
--=20
1.7.10.4
