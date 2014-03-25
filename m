From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 083/144] t6034-merge-rename-nocruft.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:25:28 -0700
Message-ID: <1395735989-3396-84-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:30:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMkN-00025e-QR
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:30:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753407AbaCYIaC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:30:02 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:60297 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753412AbaCYI2I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:28:08 -0400
Received: by mail-pa0-f50.google.com with SMTP id kq14so128709pab.23
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=DGSAF2IsJgGgCNliJqtVQitAT1kRB7RLpLuIfE3uRdQ=;
        b=l2n5i1MnZjGMyBRe/g9bmH9KwO6+BqM8pd9tbMJEgqVUfM9nI2832TmsL02o1HIT/J
         ApRYd5O0IBUm7LRmy381X8yrn2QqFJGQkJjUQXUWZDD31y6Xldrqn0lZ6IActw1tMQGZ
         UzJS6NYT+6TLRZjS/n47EOjbPMOUjouNVY7JfMTbYwGVW2eVp+3iW3k8bV+iDoeSM4J5
         F+bo46bPWoBwoGxlA0E0vYjY/EHN6pW66WkZvRJn8bdJuvtNS+8dY0CZAAR6w8yHFR4y
         RuBEBr1I3Edk3muSwjCZnqvCPy1bcagWlLAqktl4aLkW8c7I/2L5SUZD395GaMAiaOe8
         OjfA==
X-Received: by 10.68.178.131 with SMTP id cy3mr9250132pbc.146.1395736088210;
        Tue, 25 Mar 2014 01:28:08 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.28.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:28:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244954>

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
 t/t6034-merge-rename-nocruft.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t6034-merge-rename-nocruft.sh b/t/t6034-merge-rename-noc=
ruft.sh
index 65be95f..34f17be 100755
--- a/t/t6034-merge-rename-nocruft.sh
+++ b/t/t6034-merge-rename-nocruft.sh
@@ -117,7 +117,7 @@ test_expect_success 'merge blue into white (A->B, m=
od A, A untracked)' \
 		echo "BAD: A does not exist in working directory"
 		return 1
 	}
-	test `cat A` =3D dirty || {
+	test $(cat A) =3D dirty || {
 		echo "BAD: A content is wrong"
 		return 1
 	}
--=20
1.7.10.4
