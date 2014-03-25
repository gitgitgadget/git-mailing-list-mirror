From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 105/144] t9110-git-svn-use-svm-props.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:25:50 -0700
Message-ID: <1395735989-3396-106-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:28:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMiz-0000Pe-DM
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:28:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753982AbaCYI2e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:28:34 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:41798 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbaCYI2b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:28:31 -0400
Received: by mail-pa0-f52.google.com with SMTP id rd3so133704pab.11
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=i8bosdqh00yEd0+A3FtMedUvRGGykotAStAE8g4bn3k=;
        b=bm5WY+T0viUA/OvPvEU0PtJLbtTOYEYc/fnIcMAt6zNaa6uuUEyc5fGJWKV0fIOt4J
         Y6gVo7k1EcOPByB6/Z7AdgJc00Cgrv0g4fzzTmlREpkiyuPLH+zRLgnUq/RPpiyeu0bf
         /YbPMbbEcfwxxMfEZwLW3mConbb6ie70ijS/D2OQ+9YI4qHkYoUOS1zLM+QAtvcefV2e
         4s6wAFHMmq6NZbJYb0B2jDLCPxFnUxUA0qCnouOYZ3NXhaYl5hgSZeys09uFHAp3bRLt
         pqSXcf4lyLle41u7u9zeqdH+TXip1Jgg0q/b8Jxxq3SufcHHKyHgD65y9OaN6yWFDbUh
         vy2g==
X-Received: by 10.68.202.8 with SMTP id ke8mr78013683pbc.86.1395736111453;
        Tue, 25 Mar 2014 01:28:31 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.28.30
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:28:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244940>

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
 t/t9110-git-svn-use-svm-props.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9110-git-svn-use-svm-props.sh b/t/t9110-git-svn-use-svm=
-props.sh
index a06e4c5..29fbdfd 100755
--- a/t/t9110-git-svn-use-svm-props.sh
+++ b/t/t9110-git-svn-use-svm-props.sh
@@ -51,7 +51,7 @@ test_expect_success 'verify metadata for /dir' "
=20
 test_expect_success 'find commit based on SVN revision number' "
         git svn find-rev r12 |
-	    grep `git rev-parse HEAD`
+	    grep $(git rev-parse HEAD)
         "
=20
 test_expect_success 'empty rebase' "
--=20
1.7.10.4
