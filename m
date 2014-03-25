From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 081/144] t6015-rev-list-show-all-parents.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:25:26 -0700
Message-ID: <1395735989-3396-82-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:30:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMkk-0002Yo-9m
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:30:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753285AbaCYIa2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:30:28 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:47101 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753915AbaCYI2G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:28:06 -0400
Received: by mail-pd0-f176.google.com with SMTP id r10so129501pdi.35
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=u6x04JRjeLUw+gmMamscVCrFVELqxrBnF9Zb+rF3kFI=;
        b=Oq/cviku4px92OLbWAoO5gK6E0YAqy86h9CMEHXLSNYAFSkQ9cgiTEqGBr/tUYraMS
         pYHDuXOKLVYScSDvx7vOC4ffPbJN8c0qY3QGfofTgCgdt9BUp6WSJx04UA8/2QOoPd5A
         F6ymlR0Z2YVy6oPHyws+TLfFC55+vyuzTakhyKJlV4rVjCbRuGHx716b9rLQ4WNV1JXQ
         EcZKHXqA+zFjJReiKXxUO64jEiB4m8pU4jn+W2LfBJXH0NRow5tY5A9o3CAkFaR3IEOH
         bbjnkZEd9y7bIXwkJJWHX0Tqc6Sv6P5Tt0WUPn/HCb/3IZBdoArtm6UlgaWE9AphPf+z
         OKJQ==
X-Received: by 10.68.4.8 with SMTP id g8mr14080770pbg.133.1395736086270;
        Tue, 25 Mar 2014 01:28:06 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.28.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:28:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244957>

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
 t/t6015-rev-list-show-all-parents.sh |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t6015-rev-list-show-all-parents.sh b/t/t6015-rev-list-sh=
ow-all-parents.sh
index 8b146fb..3c73c93 100755
--- a/t/t6015-rev-list-show-all-parents.sh
+++ b/t/t6015-rev-list-show-all-parents.sh
@@ -6,11 +6,11 @@ test_description=3D'--show-all --parents does not rew=
rite TREESAME commits'
=20
 test_expect_success 'set up --show-all --parents test' '
 	test_commit one foo.txt &&
-	commit1=3D`git rev-list -1 HEAD` &&
+	commit1=3D$(git rev-list -1 HEAD) &&
 	test_commit two bar.txt &&
-	commit2=3D`git rev-list -1 HEAD` &&
+	commit2=3D$(git rev-list -1 HEAD) &&
 	test_commit three foo.txt &&
-	commit3=3D`git rev-list -1 HEAD`
+	commit3=3D$(git rev-list -1 HEAD)
 	'
=20
 test_expect_success '--parents rewrites TREESAME parents correctly' '
--=20
1.7.10.4
