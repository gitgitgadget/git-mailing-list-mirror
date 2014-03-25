From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 045/144] t4036-format-patch-signer-mime.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:50 -0700
Message-ID: <1395735989-3396-46-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:34:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMoR-00075z-T1
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:34:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753588AbaCYIeN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:34:13 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:64927 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753771AbaCYI12 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:28 -0400
Received: by mail-pb0-f43.google.com with SMTP id um1so131763pbc.16
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Jg5AJrRyvpL7r8tEV/knplYCJcJ+O5OicG8bpnBOQms=;
        b=ZL5PNJuCjFruqHv6BYnNREDgYcocecmIxHJM34OLlLzhmZRqAvZEweJLyjKJRJG+zc
         HNrsm8EGWrkn3hXXBF4O11YeTWfrfBlc4+8USw9up8lKhRf6DvKLqaqOHJ9YZKYnsKig
         UTC/fWLWoD36DklUYvvFUUqUTL3VkXHrPpy+iQ6/0rot5Uk58esgiiz4EkUHKrvxYr6j
         Z51GVj/jmUh6OlLXXsqlvzKi8bBgcTpGGXc2QGtlFtaRJgSOkjJa+cef5NKj1iFfodP1
         u06HRMd8JyZwTQnQ/Ud0ia/CnJ1/GSuptYWhyLh38YeFtmqIZcHf+Djrz8Gr9wXli3+Y
         js5Q==
X-Received: by 10.66.27.48 with SMTP id q16mr77854185pag.9.1395736047983;
        Tue, 25 Mar 2014 01:27:27 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.27
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244985>

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
 t/t4036-format-patch-signer-mime.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4036-format-patch-signer-mime.sh b/t/t4036-format-patch=
-signer-mime.sh
index ba43f18..98d9713 100755
--- a/t/t4036-format-patch-signer-mime.sh
+++ b/t/t4036-format-patch-signer-mime.sh
@@ -42,7 +42,7 @@ test_expect_success 'attach and signoff do not duplic=
ate mime headers' '
=20
 	GIT_COMMITTER_NAME=3D"=E3=81=AF=E3=81=BE=E3=81=AE =E3=81=B5=E3=81=AB=E3=
=81=8A=E3=81=86" \
 	git format-patch -s --stdout -1 --attach >output &&
-	test `grep -ci ^MIME-Version: output` =3D 1
+	test $(grep -ci ^MIME-Version: output) =3D 1
=20
 '
=20
--=20
1.7.10.4
