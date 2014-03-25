From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 077/144] t5710-info-alternate.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:25:22 -0700
Message-ID: <1395735989-3396-78-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:31:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMll-0003p6-MY
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:31:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753961AbaCYIaj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:30:39 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:50975 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752920AbaCYI2C (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:28:02 -0400
Received: by mail-pa0-f54.google.com with SMTP id lf10so123550pab.41
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=fOxzRMeFSu6unmFL2JjMsHSO0CJYcfphTQ7nnBPS6vI=;
        b=QYmvv0k+iCkuv+iOu2qQgcSuC7bxX6id3oPDu6xM0vvVPzSn4bqxFy+sygjHo8Wryo
         z3FQG4Z0bSEf+6/ayq8Ny9V/eK8Y0eGLq05HRWnXmXnYMgCTlduObw84Z6DhsGVWQXqa
         LB5fD8+5lQ6KLuAE88gu1kpPvswuhWYpr3B87Cm0rPpihHEuW6q7LMFQ6SFvxCKjGtPt
         dyFp5mPpNOggYKvyTf/l1hjp/LH2fwIXXRnND5olJRLXi6Gz6rEI0bmrAJZZauAoqqcO
         W1drMNiGA2ZsnYeTS/aDiKIUvF0/Aeqh3fSfMeKeMOKYdv3FNVOEzaWNFl4E47hKZJMo
         32Kg==
X-Received: by 10.68.197.36 with SMTP id ir4mr75922272pbc.46.1395736081919;
        Tue, 25 Mar 2014 01:28:01 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.28.01
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:28:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244963>

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
 t/t5710-info-alternate.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5710-info-alternate.sh b/t/t5710-info-alternate.sh
index 5a6e49d..9cd2626 100755
--- a/t/t5710-info-alternate.sh
+++ b/t/t5710-info-alternate.sh
@@ -21,7 +21,7 @@ test_valid_repo() {
 	test_line_count =3D 0 fsck.log
 }
=20
-base_dir=3D`pwd`
+base_dir=3D$(pwd)
=20
 test_expect_success 'preparing first repository' \
 'test_create_repo A && cd A &&
--=20
1.7.10.4
