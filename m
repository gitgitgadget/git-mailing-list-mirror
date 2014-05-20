From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 03/19] contrib/examples/git-commit.sh: convert test -a/-o to && and ||
Date: Tue, 20 May 2014 06:50:16 -0700
Message-ID: <1400593832-6510-4-git-send-email-gitter.spiros@gmail.com>
References: <1400593832-6510-1-git-send-email-gitter.spiros@gmail.com>
Cc: jrnieder@gmail.com, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 20 15:51:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmkSF-0000yw-9f
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 15:51:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753730AbaETNvi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 09:51:38 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34298 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753536AbaETNum (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 09:50:42 -0400
Received: by mail-pa0-f46.google.com with SMTP id kq14so342501pab.19
        for <git@vger.kernel.org>; Tue, 20 May 2014 06:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tPG8nQS6+rCUxqeC87GoMrLn0FiOY20jncqk80pMWYQ=;
        b=GHGnyHuo0ZI5+DEJAbLDQMSMwzRv99CueFoS1WEP5MxDVrGsyE+qBSGrS0yINPNOqb
         KKc87M4DQi94hkrA4CU3VxR9j+9pBbZqgBzAwnRE38ubjWVAhPZIx2qnH7yjWGSuifyM
         AyXqP5wNyZUm/K0wgPCMX+pDjrvRFeTLgJB9KqExtXJe80jusM0QET+QGd3fYKMV2HOX
         gBVn4XaTwRUmMdrW2oopV8XUevx0cHPrbUFa39FVpv4V+4gyg4/WP3M9yMtqi86iBytD
         Med4k3a+5pukvB5ur1gEIYcJdqf+eSkgEsKre+8wpG5LhDcjfGIriY9M3xyHFUeUgSXf
         NJuQ==
X-Received: by 10.69.17.230 with SMTP id gh6mr51059777pbd.0.1400593842277;
        Tue, 20 May 2014 06:50:42 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id oe4sm3317286pbb.33.2014.05.20.06.50.41
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 20 May 2014 06:50:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1400593832-6510-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249680>

The interaction with unary operators and operator precedence
for && and || are better known than -a and -o, and for that
reason we prefer them. Replace all existing instances
of -a and -o to save readers from the burden of thinking
about such things.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 contrib/examples/git-commit.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/examples/git-commit.sh b/contrib/examples/git-commit.sh
index 5cafe2e..934505b 100755
--- a/contrib/examples/git-commit.sh
+++ b/contrib/examples/git-commit.sh
@@ -51,7 +51,7 @@ run_status () {
 		export GIT_INDEX_FILE
 	fi
 
-	if test "$status_only" = "t" -o "$use_status_color" = "t"; then
+	if test "$status_only" = "t" || test "$use_status_color" = "t"; then
 		color=
 	else
 		color=--nocolor
@@ -296,7 +296,7 @@ t,,,[1-9]*)
 	die "No paths with -i does not make sense." ;;
 esac
 
-if test ! -z "$templatefile" -a -z "$log_given"
+if test ! -z "$templatefile" && test -z "$log_given"
 then
 	if test ! -f "$templatefile"
 	then
-- 
1.7.10.4
