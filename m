From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 088/144] t7004-tag.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:25:33 -0700
Message-ID: <1395735989-3396-89-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:29:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMkA-0001rL-MX
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:29:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753402AbaCYI3u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:29:50 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:41775 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752955AbaCYI2N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:28:13 -0400
Received: by mail-pb0-f53.google.com with SMTP id rp16so136249pbb.12
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=GdKoCUQD8b1LtBUW3UHWkw0AyB59SNAlfYb6xMaFI+A=;
        b=UNcytghRPSwUILJ6kLLt6lj2v+9tUlWHMUTv0nFerPLr6UIF8u9kM77FwHFzgranwk
         QslncMp6EhMY7MtAGB4lGconwHGxJ1vi6ztyRAjqQqqp3A+QdavgwrYk6FVKc/ErljKr
         EGXzESSc63klbQV8ZPE47sH6yBdQFPbZiRlpB2/mnxh5vWV3Pvit00XocLwYINVxsc+D
         9NW76Yl+ZTo0GB9ivlpdpN/jYxlvWrtaBQ8T5vqqxhrVsmI0BBwD1Ixk4CKjftn4dVkp
         Jm9aUd17tOLn+SCvfaVmAbG7gNTTwjttmXhn4C3vlt0lFqEen0Wx+A1McMqLGsRK7BZN
         Xy0w==
X-Received: by 10.66.156.4 with SMTP id wa4mr77772566pab.49.1395736093451;
        Tue, 25 Mar 2014 01:28:13 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.28.12
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:28:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244952>

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
 t/t7004-tag.sh |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 143a8ea..2ed8fc0 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -23,8 +23,8 @@ test_expect_success 'listing all tags in an empty tre=
e should succeed' '
 '
=20
 test_expect_success 'listing all tags in an empty tree should output n=
othing' '
-	test `git tag -l | wc -l` -eq 0 &&
-	test `git tag | wc -l` -eq 0
+	test $(git tag -l | wc -l) -eq 0 &&
+	test $(git tag | wc -l) -eq 0
 '
=20
 test_expect_success 'looking for a tag in an empty tree should fail' \
@@ -60,8 +60,8 @@ test_expect_success 'listing all tags if one exists s=
hould succeed' '
 '
=20
 test_expect_success 'listing all tags if one exists should output that=
 tag' '
-	test `git tag -l` =3D mytag &&
-	test `git tag` =3D mytag
+	test $(git tag -l) =3D mytag &&
+	test $(git tag) =3D mytag
 '
=20
 # pattern matching:
@@ -71,7 +71,7 @@ test_expect_success 'listing a tag using a matching p=
attern should succeed' \
=20
 test_expect_success \
 	'listing a tag using a matching pattern should output that tag' \
-	'test `git tag -l mytag` =3D mytag'
+	'test $(git tag -l mytag) =3D mytag'
=20
 # todo: git tag -l now returns always zero, when fixed, change this te=
st
 test_expect_success \
@@ -80,7 +80,7 @@ test_expect_success \
=20
 test_expect_success \
 	'listing tags using a non-matching pattern should output nothing' \
-	'test `git tag -l xxx | wc -l` -eq 0'
+	'test $(git tag -l xxx | wc -l) -eq 0'
=20
 # special cases for creating tags:
=20
@@ -90,13 +90,13 @@ test_expect_success \
=20
 test_expect_success \
 	'trying to create a tag with a non-valid name should fail' '
-	test `git tag -l | wc -l` -eq 1 &&
+	test $(git tag -l | wc -l) -eq 1 &&
 	test_must_fail git tag "" &&
 	test_must_fail git tag .othertag &&
 	test_must_fail git tag "other tag" &&
 	test_must_fail git tag "othertag^" &&
 	test_must_fail git tag "other~tag" &&
-	test `git tag -l | wc -l` -eq 1
+	test $(git tag -l | wc -l) -eq 1
 '
=20
 test_expect_success 'creating a tag using HEAD directly should succeed=
' '
--=20
1.7.10.4
