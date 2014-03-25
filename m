From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 040/144] t4006-diff-mode.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:45 -0700
Message-ID: <1395735989-3396-41-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:27:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMi1-0007gS-OF
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:27:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753819AbaCYI1b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:27:31 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:58192 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753779AbaCYI1X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:23 -0400
Received: by mail-pa0-f43.google.com with SMTP id bj1so129206pad.16
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=qWJtS521euiXDxuUS30P9K5xNzQfA0FRoEB03aY2ncs=;
        b=YKCRifvpMUppvShaaOe6yRwq8huIB+RUEN/KaMPs9sYtPqcmjTrFe7aTXQqWy7chKr
         ORM4ahHwC3LLIC8OonVVDmAlAwS1PgnT1DJWKkGe9CyA7LGammUlEB0C/GFDqiMFEEmX
         /3E9w12X6sb4ZJvy0sMzFmHkBUA/x38OAalOXI39pinkPVGFgJv6KrfbKhicTdWlsfqG
         ektTzRentevmglERWuQJ4YGKzFWVZTyp84eLfCKLTCw5pP1F7Dv4AJAPTZ8lAsbtKeHx
         yVAxvWvNdgrYWoYNkuIU0ZLtEEca3S5MIMRjiHu2aISGwU3BjPjSubBe4PDNvsxkuFDg
         I19w==
X-Received: by 10.68.242.68 with SMTP id wo4mr77778695pbc.32.1395736042978;
        Tue, 25 Mar 2014 01:27:22 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244921>

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
 t/t4006-diff-mode.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4006-diff-mode.sh b/t/t4006-diff-mode.sh
index 0591149..76f643b 100755
--- a/t/t4006-diff-mode.sh
+++ b/t/t4006-diff-mode.sh
@@ -13,7 +13,7 @@ sed_script=3D's/\(:100644 100755\) \('"$_x40"'\) \2 /=
\1 X X /'
 test_expect_success 'setup' '
 	echo frotz >rezrov &&
 	git update-index --add rezrov &&
-	tree=3D`git write-tree` &&
+	tree=3D$(git write-tree) &&
 	echo $tree
 '
=20
--=20
1.7.10.4
