From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 064/144] t5515-fetch-merge-logic.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:25:09 -0700
Message-ID: <1395735989-3396-65-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:28:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMiH-0007wX-0g
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:28:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753898AbaCYI1x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:27:53 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:48408 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499AbaCYI1s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:48 -0400
Received: by mail-pb0-f49.google.com with SMTP id jt11so131966pbb.36
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=SidB10io0rBoJ4RbnZHj10LGcgmkfWd7h3ODi3dyQrw=;
        b=KhPeEtG7bXS65yvDvB5g6EHzuN0QqyptIpy7JywVRp4H400VvZQbYzqz1fKIBP7pSK
         rIefkh0mkwcCQ487xO2E/hUGSYF218tppWWN0eKo8mD2iEvNMNM5smMqFuCcveFALReS
         Vvxu74tbZwv1sOKF5PypxA3Mrpysh2idf6gw3OCrSZ0YumF7mGJLsw7aAim5zMP/OqO3
         2gvY1ARYswkpVS/fencYZMEGkSwT48dXQIeh0who78a5Bk07OyRnx8n/XDY3iUg4p7Pb
         b/u390du6QyqDctZrXck5Rwx8RnTTcDxhAMgZQxxlwbJTwpNvOBQ7vEpaoH+7erfZ535
         Xwdw==
X-Received: by 10.66.227.193 with SMTP id sc1mr76385840pac.102.1395736068189;
        Tue, 25 Mar 2014 01:27:48 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.47
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244927>

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
 t/t5515-fetch-merge-logic.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5515-fetch-merge-logic.sh b/t/t5515-fetch-merge-logic.s=
h
index dbb927d..36b0dbc 100755
--- a/t/t5515-fetch-merge-logic.sh
+++ b/t/t5515-fetch-merge-logic.sh
@@ -128,8 +128,8 @@ do
 	case "$cmd" in
 	'' | '#'*) continue ;;
 	esac
-	test=3D`echo "$cmd" | sed -e 's|[/ ][/ ]*|_|g'`
-	pfx=3D`printf "%04d" $test_count`
+	test=3D$(echo "$cmd" | sed -e 's|[/ ][/ ]*|_|g')
+	pfx=3D$(printf "%04d" $test_count)
 	expect_f=3D"$TEST_DIRECTORY/t5515/fetch.$test"
 	actual_f=3D"$pfx-fetch.$test"
 	expect_r=3D"$TEST_DIRECTORY/t5515/refs.$test"
--=20
1.7.10.4
