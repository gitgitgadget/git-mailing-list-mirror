From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 084/144] t6111-rev-list-treesame.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:25:29 -0700
Message-ID: <1395735989-3396-85-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:28:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMii-00008U-Ap
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:28:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753417AbaCYI2P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:28:15 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:62679 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbaCYI2J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:28:09 -0400
Received: by mail-pb0-f44.google.com with SMTP id rp16so131504pbb.31
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=qSwXCl1ceBF/fpJabfSvwB9RjQTOkstLwJfduukC6tk=;
        b=e+NVcj4LFTaj0Lu7/T1hVht7AVoyvQvzb7AFw0Sr74XCvV5LSvC2lbw4d2R2sh+YpB
         lYl85L44Vi/k5WxWS1AloH0i/w7Ynbj0mAtXGN8rgveGqoGs/PPlzcC/AxuXFuyz8oYO
         iSONw6rPTewIi6kEnloLl4L2WQbeEoOKWkRl4FfxX95tqLeeeBLCLbLEsmMNhrpmrY+7
         itzo5l76bIo7zJQ3wWJMqHYBNJmGTKaeetp/bSt/IZn2oDbRbW2Ccw3AGTwXp6CD20ng
         NabaI1zqvSYPu/F7GI1L9LlBV/OIMBG+B6+s+zdJUE12LQfd/MjNU43mZ5AUuAR1PP/m
         uASw==
X-Received: by 10.68.136.133 with SMTP id qa5mr76815760pbb.63.1395736089172;
        Tue, 25 Mar 2014 01:28:09 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.28.08
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:28:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244932>

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
 t/t6111-rev-list-treesame.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t6111-rev-list-treesame.sh b/t/t6111-rev-list-treesame.s=
h
index 88b84df..3971c31 100755
--- a/t/t6111-rev-list-treesame.sh
+++ b/t/t6111-rev-list-treesame.sh
@@ -4,7 +4,7 @@
 #       /        \ /             \*
 # *A--*B---D--*F-*G---------K-*L-*M
 #   \     /*       \       /
-#    `-C-'          `-*I-*J
+#    $(-C-'          )-*I-*J
 #
 # A creates "file", B and F change it.
 # Odd merge G takes the old version from B.
--=20
1.7.10.4
