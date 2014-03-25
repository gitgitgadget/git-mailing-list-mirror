From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 052/144] t5003-archive-zip.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:57 -0700
Message-ID: <1395735989-3396-53-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:33:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMnq-0006NB-8W
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:33:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754037AbaCYIde convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:33:34 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:44668 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753779AbaCYI1f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:35 -0400
Received: by mail-pd0-f169.google.com with SMTP id fp1so130768pdb.28
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Ttn4rXawI6I/rj0JhLwZ15/nNYKH9MvdWZGZ4W0MmOQ=;
        b=knv0ZgCnLZ/wcbb9T6UZ1VVvA1IhLOot5J1fm5NdUmF77hHRjMlmDXe92BeKpCQVtV
         +cxH6jb0NZD5LpSwk3zZPkBEn2U5LTRMX+req6NMUmAkZa2o+6vScQDJj1TBt5qIJlzf
         maUogqEFD0YFzZlmg8pb0wqzdymXHxAhL2QzLTWzuo86Kuyfe+LMCJUrCEd9SR0nLT8Q
         rGj9BqqEmf3CWQ5G1RNZBU5MZOw7T9v12rGb3CvdunFeuQvhEXDhTgynjd18Mi0oPHpZ
         uBEScm1m5zfm1Uehn1wMeUtxfgpLKRKZhWER2ninWm5ko5byMjyO8nun1Aa8xviTcI0D
         /yUg==
X-Received: by 10.68.136.133 with SMTP id qa5mr76813078pbb.63.1395736055092;
        Tue, 25 Mar 2014 01:27:35 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.34
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244978>

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
 t/t5003-archive-zip.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
index c72f71e..8f04a56 100755
--- a/t/t5003-archive-zip.sh
+++ b/t/t5003-archive-zip.sh
@@ -65,7 +65,7 @@ test_expect_success \
     'add files to repository' \
     'find a -type f | xargs git update-index --add &&
      find a -type l | xargs git update-index --add &&
-     treeid=3D`git write-tree` &&
+     treeid=3D$(git write-tree) &&
      echo $treeid >treeid &&
      git update-ref HEAD $(TZ=3DGMT GIT_COMMITTER_DATE=3D"2005-05-27 2=
2:00:00" \
      git commit-tree $treeid </dev/null)'
--=20
1.7.10.4
