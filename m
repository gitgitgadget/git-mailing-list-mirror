From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 020/144] t1003-read-tree-prefix.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:25 -0700
Message-ID: <1395735989-3396-21-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:37:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMrH-0002Cz-1o
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:37:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753717AbaCYI1G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:27:06 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:62259 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753695AbaCYI1C (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:02 -0400
Received: by mail-pb0-f50.google.com with SMTP id md12so133900pbc.9
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=l68gWTl5NZHbxRYQCREuSTexo4S7GbYDJZ+2K3yy21Q=;
        b=i4CuaauI3L/E5QfI9MHs6loTyvRFliu/99S2paZB+PThX9ne82FuBY+To9uS2Prk4/
         UdylqlCzkKDk8LFHJCBTlcC3yluIGWqFbeDL1M+4ATSkUMULnqkPRxQ+urqcY46X4P+Z
         S5/bATUryJxSkF2pkVXLq9/oTjUmEPfWZJ3FlQI6L+O2zZoPEhiU3H6Voqwa7BtPo/3T
         kOg5eeMWL/ov9VNTarLCHdqC7jWtWpDJsT8UJhaAnMW9f3WVFMJR2aw4w+ClAXRP0/WR
         PzDO/oKy0LFGazDpl+ZgZEMuPZFKFdJ7vYSvBzcWqAbIwVyraxaGmQwDxzmgS1lyxEDe
         copQ==
X-Received: by 10.66.122.72 with SMTP id lq8mr78397236pab.69.1395736021870;
        Tue, 25 Mar 2014 01:27:01 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.00
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245003>

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
 t/t1003-read-tree-prefix.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1003-read-tree-prefix.sh b/t/t1003-read-tree-prefix.sh
index 8c6d67e..b6111cd 100755
--- a/t/t1003-read-tree-prefix.sh
+++ b/t/t1003-read-tree-prefix.sh
@@ -11,7 +11,7 @@ test_description=3D'git read-tree --prefix test.
 test_expect_success setup '
 	echo hello >one &&
 	git update-index --add one &&
-	tree=3D`git write-tree` &&
+	tree=3D$(git write-tree) &&
 	echo tree is $tree
 '
=20
--=20
1.7.10.4
