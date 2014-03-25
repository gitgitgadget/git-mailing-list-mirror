From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 082/144] t6032-merge-large-rename.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:25:27 -0700
Message-ID: <1395735989-3396-83-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:30:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMkS-0002F5-Jo
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:30:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753563AbaCYIaF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:30:05 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:48955 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753917AbaCYI2H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:28:07 -0400
Received: by mail-pb0-f54.google.com with SMTP id ma3so129134pbc.41
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=6PEHdSvFLCeA/xlpXz662NahDh0qVrJDmQ5FVMJotrk=;
        b=XQSS5+GmwsqbB1dojDfDyGgVdyITSBrDs5cn8kRyDF6IlO+dA3R2ZaP0xuElLEqZ6u
         MNxv8vqNUF/kwe+xCBSzI32kBD9qEs765j8eW99OgLXBagLlAClmVq36ycJdJGqxBrjM
         jAXi6RiPwZYnTKwoGlFmm3EFezBSMJMtp+5FlgkgeJkdLEnORKYYu6yX9p5ZJ8WgCeQb
         gB08VWLnkiUiHyf1bjmAtzbeXg2L9nAMDIddcyYWaDB5pzCaO3hCeNKro+OG9SVo0fKM
         KgyJxV0NWeDdaWDW/Di3LBRSdQ3oMOEEIyM+jxh84+giVZStSmCm4clb+1kI6CZGX6ZN
         rUVw==
X-Received: by 10.69.26.103 with SMTP id ix7mr77822961pbd.41.1395736087267;
        Tue, 25 Mar 2014 01:28:07 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.28.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:28:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244955>

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
 t/t6032-merge-large-rename.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t6032-merge-large-rename.sh b/t/t6032-merge-large-rename=
=2Esh
index 15beecc..36019df 100755
--- a/t/t6032-merge-large-rename.sh
+++ b/t/t6032-merge-large-rename.sh
@@ -20,7 +20,7 @@ test_expect_success 'setup (initial)' '
=20
 make_text() {
 	echo $1: $2
-	for i in `count 20`; do
+	for i in $(count 20); do
 		echo $1: $i
 	done
 	echo $1: $3
--=20
1.7.10.4
