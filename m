From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 017/144] t1000-read-tree-m-3way.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:22 -0700
Message-ID: <1395735989-3396-18-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:37:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMr4-0001y4-Jv
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:37:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753721AbaCYI1H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:27:07 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:47095 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753664AbaCYI07 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:26:59 -0400
Received: by mail-pa0-f49.google.com with SMTP id lj1so123716pab.36
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Fyk07yiagHuNkWirZ5C2/i6GOe73/BeALfX3erIGgC8=;
        b=XhRLn5ywmiXc3hIRPbLgNKUgp6HGbisotiWATXLnzmPCdHCkUGhCLUd6Fi5nfePAXj
         az6/BmWosJuppkvh0vN3Dqx+qTADN9KvLVuVHO21pO75D2eZKlWEBtuD0ex8wY2Lhwe+
         Np8KuwHkvHDH+OSCKwBl/rrTVEdoq+5sY0rN6tiNR72lxWK2aJ55Al0TiJmA2oWQysP6
         3ZG4AKyRtcFICcayvG1pZUf4BODZm3ro2LqJGpsizrxuDUbXKkY5x34pRD71vCLsq/Ry
         foFUVkPlAW0iRvk/sECOHDD6mjPgZJSMc/4D81If8/etDq9Dc1JrRHOUvudp7xl7VPnR
         nYmQ==
X-Received: by 10.68.196.226 with SMTP id ip2mr76423522pbc.106.1395736018849;
        Tue, 25 Mar 2014 01:26:58 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.26.57
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:26:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245001>

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
 t/t1000-read-tree-m-3way.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1000-read-tree-m-3way.sh b/t/t1000-read-tree-m-3way.sh
index babcdd2..a0b79b4 100755
--- a/t/t1000-read-tree-m-3way.sh
+++ b/t/t1000-read-tree-m-3way.sh
@@ -519,10 +519,10 @@ test_expect_success \
     'rm -f .git/index F16 &&
     echo F16 >F16 &&
     git update-index --add F16 &&
-    tree0=3D`git write-tree` &&
+    tree0=3D$(git write-tree) &&
     echo E16 >F16 &&
     git update-index F16 &&
-    tree1=3D`git write-tree` &&
+    tree1=3D$(git write-tree) &&
     read_tree_must_succeed -m $tree0 $tree1 $tree1 $tree0 &&
     git ls-files --stage'
=20
--=20
1.7.10.4
