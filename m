From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 033/144] t3210-pack-refs.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:38 -0700
Message-ID: <1395735989-3396-34-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:36:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMqH-0000yg-Fl
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:36:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754095AbaCYIfZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:35:25 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:56338 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753088AbaCYI1P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:15 -0400
Received: by mail-pa0-f43.google.com with SMTP id bj1so124855pad.30
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=CEju4glDCVS9nlUGCYLxLCSK+GhB/B1LAGfNtOwCxPc=;
        b=YjtNkMkMY/sm1vwvMh205kLdBQYnID75Hf1Q/K71AgntAOtNcWIfKdvJPMEKh/vLKp
         4o/A+oCWskpmEJ0HTsKr7cXblcIKaDej+Szfa77ms+/29toDH4p5HIhTG7VlD29ujC2O
         7STsUOrXNLJAy3ir4DpgKE8VpUI1XOIn0xFxvyN6k3RwBO7cHjUOGFCDeI/DN20ItUsQ
         LPWpnWFKgpNPqRvMwaxUK5hh7DFH3GRorLGF7SquBDfqqI9I/TB4DecCk266/9LQ0t/y
         traCWo8CBVmzHDG9WjgqXZ+squS7HE2s5/yAXnrqLDjWEcETjbLHrAEsVuT0CMjgdxdp
         54Mg==
X-Received: by 10.66.27.48 with SMTP id q16mr77853106pag.9.1395736035077;
        Tue, 25 Mar 2014 01:27:15 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.14
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244993>

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
 t/t3210-pack-refs.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index 1a2080e..b0eaf22 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -25,7 +25,7 @@ SHA1=3D
 test_expect_success \
     'see if git show-ref works as expected' \
     'git branch a &&
-     SHA1=3D`cat .git/refs/heads/a` &&
+     SHA1=3D$(cat .git/refs/heads/a) &&
      echo "$SHA1 refs/heads/a" >expect &&
      git show-ref a >result &&
      test_cmp expect result'
--=20
1.7.10.4
