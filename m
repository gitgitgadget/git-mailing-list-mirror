From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 030/144] t3030-merge-recursive.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:35 -0700
Message-ID: <1395735989-3396-31-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:27:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMhh-0007JX-Uw
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:27:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753756AbaCYI1Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:27:16 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:39690 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753067AbaCYI1M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:12 -0400
Received: by mail-pa0-f43.google.com with SMTP id bj1so133183pad.2
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=3BBi5xSyC4CVjDN2EcQQisJqaV8suMEDBm72wWLp1H0=;
        b=h1Gx7dMR1uBhCgtkmwW8aOI2KhFSOU4WN2BZjD0GIsz5BsSl1c+ssLAHR5kgDAoh8k
         LkZVpth4aFyabJqzc97Jyagaok51k/JiKTjbCcrmGQa2aljc960LF0tepXUM2xNa8hRg
         3t4kWCmeNWO4KEzYLdXZ2ZQsWBiPX+PrklQlh4eDUxU9acUtkqkfNQ6PenekV/+HSH5c
         mxkVGOVb9/Syq3H2xEDHXuKGRzk8JxsA+Wqy3eSS1ixWXIRSGHodCcKjyk7q3vlzOzaK
         /eIf2GO1eK7UJDl5nm8O0vbnK4PFdSLShPrzy2jrRLy2rWWPrIXfG4yVaNiI/lK0h+Ez
         T80w==
X-Received: by 10.68.7.66 with SMTP id h2mr76403908pba.91.1395736032233;
        Tue, 25 Mar 2014 01:27:12 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.11
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244917>

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
 t/t3030-merge-recursive.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index 82e1854..e9757c4 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -263,7 +263,7 @@ test_expect_success 'setup 8' '
 	test_ln_s_add e a &&
 	test_tick &&
 	git commit -m "rename a->e, symlink a->e" &&
-	oln=3D`printf e | git hash-object --stdin`
+	oln=3D$(printf e | git hash-object --stdin)
 '
=20
 test_expect_success 'setup 9' '
--=20
1.7.10.4
