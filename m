From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 014/144] t0030-stripspace.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:19 -0700
Message-ID: <1395735989-3396-15-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:37:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMrn-0002pj-HX
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:37:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754159AbaCYIhp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:37:45 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:43452 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753667AbaCYI0z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:26:55 -0400
Received: by mail-pb0-f53.google.com with SMTP id rp16so129693pbb.26
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=/gagaOMDSDLcWTevbsjI7mO53c9KOzKJpKAIjJvuH7Y=;
        b=XlUalAyMBBJ2SzHheR/Yq5bm7/son7Mpr2qxj9/7HrDjE/3EyWazZ0Hha19FDQXhQt
         xi/v9jhO9n2GYJ7k1aQ4b2aKf0IfkCdoWzYOL1If+7Hup/nToiYt5U+KVwZl2zWTuQRn
         sgqtopoOiG6atz1BpxA6VX+yZSRgzCIY+Hvi49K4syNIbn4QVVmB64AaFTufb/JEA4UJ
         xH304e8sE2HCto8VYRlHpc3vItgRdbOUZTzLdZVo3SEdv2s7Lb4zG7/bj/zYWMq7HnrK
         L800b3PvOZfWTK/5AWKZswgVGL5odZxq/di6w25BYiEaSaD+8DrQUmeMg5cHQosYAOSZ
         5qQw==
X-Received: by 10.68.244.229 with SMTP id xj5mr78737779pbc.108.1395736014480;
        Tue, 25 Mar 2014 01:26:54 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.26.53
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:26:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245009>

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
 t/t0030-stripspace.sh |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/t/t0030-stripspace.sh b/t/t0030-stripspace.sh
index a8e84d8..0333dd9 100755
--- a/t/t0030-stripspace.sh
+++ b/t/t0030-stripspace.sh
@@ -225,22 +225,22 @@ test_expect_success \
=20
 test_expect_success \
     'text without newline at end should end with newline' '
-    test `printf "$ttt" | git stripspace | wc -l` -gt 0 &&
-    test `printf "$ttt$ttt" | git stripspace | wc -l` -gt 0 &&
-    test `printf "$ttt$ttt$ttt" | git stripspace | wc -l` -gt 0 &&
-    test `printf "$ttt$ttt$ttt$ttt" | git stripspace | wc -l` -gt 0
+    test $(printf "$ttt" | git stripspace | wc -l) -gt 0 &&
+    test $(printf "$ttt$ttt" | git stripspace | wc -l) -gt 0 &&
+    test $(printf "$ttt$ttt$ttt" | git stripspace | wc -l) -gt 0 &&
+    test $(printf "$ttt$ttt$ttt$ttt" | git stripspace | wc -l) -gt 0
 '
=20
 # text plus spaces at the end:
=20
 test_expect_success \
     'text plus spaces without newline at end should end with newline' =
'
-    test `printf "$ttt$sss" | git stripspace | wc -l` -gt 0 &&
-    test `printf "$ttt$ttt$sss" | git stripspace | wc -l` -gt 0 &&
-    test `printf "$ttt$ttt$ttt$sss" | git stripspace | wc -l` -gt 0 &&
-    test `printf "$ttt$sss$sss" | git stripspace | wc -l` -gt 0 &&
-    test `printf "$ttt$ttt$sss$sss" | git stripspace | wc -l` -gt 0 &&
-    test `printf "$ttt$sss$sss$sss" | git stripspace | wc -l` -gt 0
+    test $(printf "$ttt$sss" | git stripspace | wc -l) -gt 0 &&
+    test $(printf "$ttt$ttt$sss" | git stripspace | wc -l) -gt 0 &&
+    test $(printf "$ttt$ttt$ttt$sss" | git stripspace | wc -l) -gt 0 &=
&
+    test $(printf "$ttt$sss$sss" | git stripspace | wc -l) -gt 0 &&
+    test $(printf "$ttt$ttt$sss$sss" | git stripspace | wc -l) -gt 0 &=
&
+    test $(printf "$ttt$sss$sss$sss" | git stripspace | wc -l) -gt 0
 '
=20
 test_expect_success \
--=20
1.7.10.4
