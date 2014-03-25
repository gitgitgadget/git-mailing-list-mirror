From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 065/144] t5516-fetch-push.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:25:10 -0700
Message-ID: <1395735989-3396-66-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:32:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMmX-0004mh-Cz
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:32:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753455AbaCYIcS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:32:18 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:40319 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753848AbaCYI1t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:49 -0400
Received: by mail-pa0-f44.google.com with SMTP id bj1so126404pad.31
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=3iRejGDhRmQmgAiM930OjVpaZj10Hg5KWQbuOjEWqFs=;
        b=Uq8TB558KdjGMSLeN+52uH+fCHcXAmRs0nymCWyunWhuLs+Aub194AYYlG60ez6IxE
         AdJ7pxP2dx+vXSVi3WoRjtUET2sRzichKYoczFaByZPnYxe7Y540ylvjV/WIx4xHJpLD
         qX5EnG0pUvL02b+FuuUShNu1uH28r2jBDvA43VpPZA0fkeBB0gHFzdQdWOVHO8zhnZU2
         91CC4ag/+6QAyY2vkhE2UBS762An2XqyRCZD4iXY+r/t8GUAMOp40KMHW2+Ii9MYcBnh
         T8tWpFOv0xvudR5HybSMrrR84vjKTfsaHAISY5ehT1yhMqFbcU26ssV14z+aXwqo+piY
         zpAA==
X-Received: by 10.68.12.10 with SMTP id u10mr76626046pbb.39.1395736069103;
        Tue, 25 Mar 2014 01:27:49 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.48
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244969>

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
 t/t5516-fetch-push.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 67e0ab3..a9ed84e 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -15,7 +15,7 @@ This test checks the following functionality:
=20
 . ./test-lib.sh
=20
-D=3D`pwd`
+D=3D$(pwd)
=20
 mk_empty () {
 	repo_name=3D"$1"
@@ -421,7 +421,7 @@ test_expect_success 'push tag with non-existent, in=
complete dest' '
 test_expect_success 'push sha1 with non-existent, incomplete dest' '
=20
 	mk_test testrepo &&
-	test_must_fail git push testrepo `git rev-parse master`:foo
+	test_must_fail git push testrepo $(git rev-parse master):foo
=20
 '
=20
--=20
1.7.10.4
