From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 093/144] t7504-commit-msg-hook.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:25:38 -0700
Message-ID: <1395735989-3396-94-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:28:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMij-00008U-ES
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:28:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753955AbaCYI2U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:28:20 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:59542 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbaCYI2S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:28:18 -0400
Received: by mail-pa0-f42.google.com with SMTP id fb1so130806pad.15
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=6zNJ5jb24tzx7iAYn5m+F4bhaPidjapwAs7ONAbD1hI=;
        b=a3dDlmVm0aw3MyEt8XInXknIBYJ0GkMnUeGnKcYqs45Lxncsy1AOQpfG2mtJLd14HP
         ztXZ5QsdPgislFsrTMFibRyYKHsbi6JpP+4rleCiNjx2/RU9NVAOqQwh5XH0gkhM+O4x
         ze7PNkhIcgJ4VPBaLDTOLYD2qChpjr5dfHZV8qr+PUyShPS7o41EF0A7Kc19tuqUh0HT
         9yBCCkj7kp1t9HvIoikRSFo6qFV3j4k+TXgPEfuv4bJsUNq2OX4/Mdd1SOVvLG8cJkR5
         /8Z86hCW0rdqXLF6gACkhtU1mwUc4e2coG9CFskEuG2+IHeW4eDJgpAiQxoss8lDhMB0
         Hpew==
X-Received: by 10.66.121.164 with SMTP id ll4mr14236694pab.129.1395736098342;
        Tue, 25 Mar 2014 01:28:18 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.28.17
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:28:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244933>

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
 t/t7504-commit-msg-hook.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7504-commit-msg-hook.sh b/t/t7504-commit-msg-hook.sh
index 1f53ea8..8728db6 100755
--- a/t/t7504-commit-msg-hook.sh
+++ b/t/t7504-commit-msg-hook.sh
@@ -179,7 +179,7 @@ EOF
 chmod +x "$HOOK"
=20
 commit_msg_is () {
-	test "`git log --pretty=3Dformat:%s%b -1`" =3D "$1"
+	test "$(git log --pretty=3Dformat:%s%b -1)" =3D "$1"
 }
=20
 test_expect_success 'hook edits commit message' '
--=20
1.7.10.4
