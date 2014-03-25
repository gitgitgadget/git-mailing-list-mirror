From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 032/144] t3101-ls-tree-dirname.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:37 -0700
Message-ID: <1395735989-3396-33-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:35:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMpZ-000060-Lw
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:35:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754102AbaCYIf0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:35:26 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:63868 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753747AbaCYI1O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:14 -0400
Received: by mail-pa0-f45.google.com with SMTP id kl14so128629pab.18
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=DF0Krkes8Lz8gO3/xqqWMwt+yLoEY6YWfl4ntq61Q3w=;
        b=zg90lvA73sCxddqlyqVmjKXsJ0k4pBo5dJ4Uc0F01wTProE9PMTtO9hDUpje/KbTuK
         DBV1aN58eA6utjuwYvuQ2teVtb06+n/624ubPC3dcnrv/h8UPZtGfDh0pitrukBsh2Xg
         S/3M7qiIkjBoASw/0EF/AHQsSCwLzZuK+zN6M1O9WRYAfcm+VcElkuiw2Q8CsNkA4nX/
         P6JvnxQQgw6LbbHPP7KsGUlIHUOvwFMJj8gMxkqIubF4wuPAhF9ugD0aqeeSLg2H1Ili
         njpMF6UTfujFa4NmpG9qbnMoAqk4CgUVT01KUKyYDIrIAmmk+Bhp8o2/Lsjbbudgnpgb
         809A==
X-Received: by 10.66.218.170 with SMTP id ph10mr76593837pac.53.1395736034125;
        Tue, 25 Mar 2014 01:27:14 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.13
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244992>

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
 t/t3101-ls-tree-dirname.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3101-ls-tree-dirname.sh b/t/t3101-ls-tree-dirname.sh
index 026f9f8..425d858 100755
--- a/t/t3101-ls-tree-dirname.sh
+++ b/t/t3101-ls-tree-dirname.sh
@@ -35,7 +35,7 @@ test_expect_success 'setup' '
 	echo 222 >path3/2.txt &&
 	find *.txt path* \( -type f -o -type l \) -print |
 	xargs git update-index --add &&
-	tree=3D`git write-tree` &&
+	tree=3D$(git write-tree) &&
 	echo $tree
 '
=20
--=20
1.7.10.4
