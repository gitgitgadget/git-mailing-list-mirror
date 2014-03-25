From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 031/144] t3100-ls-tree-restrict.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:36 -0700
Message-ID: <1395735989-3396-32-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:35:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMpZ-000060-4L
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:35:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753751AbaCYI1O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:27:14 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:64482 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753088AbaCYI1N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:13 -0400
Received: by mail-pa0-f53.google.com with SMTP id ld10so123183pab.40
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=cd/9rq4qLprCmOf0PEyXv6rvUcLUMDk2uu4oo8ThE+c=;
        b=ASTg9CoZCLnf+EhQ/sjs20n5wMciI/3EUWZ3A8apW4z5dh5CHRQvKwhjtnptIpW/wG
         /t+1Y+TPvMazT8WQJvLxXgltp9u9AyZ9C/nWnegYqfIm3mcVsCQKHqPPOsN8WrNjmdsh
         Xa/W8qDkhzryXnsbiPu9UcizGViZ0IN5YYZ5lmBXzHh/IMhlGDNx2mjr086yVcxsenMd
         mOY6+4D+9zD8mAcUbABKFwNylsWLTZxFJQnbBpcUgtT2PxV7prraNSYKsJSvhg7gGWET
         iXGf5JlPsvu+tSJWkyQETual1R1bOew8hYWdKPoeqh5tA+fyfuGR5lKglMeO8X/Qfp99
         5a5Q==
X-Received: by 10.68.202.8 with SMTP id ke8mr78007646pbc.86.1395736033147;
        Tue, 25 Mar 2014 01:27:13 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.12
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244991>

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
 t/t3100-ls-tree-restrict.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3100-ls-tree-restrict.sh b/t/t3100-ls-tree-restrict.sh
index eb73c06..325114f 100755
--- a/t/t3100-ls-tree-restrict.sh
+++ b/t/t3100-ls-tree-restrict.sh
@@ -28,7 +28,7 @@ test_expect_success \
      echo Mi >path2/baz/b &&
      find path? \( -type f -o -type l \) -print |
      xargs git update-index --add &&
-     tree=3D`git write-tree` &&
+     tree=3D$(git write-tree) &&
      echo $tree'
=20
 test_output () {
--=20
1.7.10.4
