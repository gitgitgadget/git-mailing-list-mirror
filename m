From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 092/144] t7408-submodule-reference.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:25:37 -0700
Message-ID: <1395735989-3396-93-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:29:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMjt-0001VT-P3
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:29:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753119AbaCYI3a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:29:30 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:50354 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753947AbaCYI2R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:28:17 -0400
Received: by mail-pa0-f53.google.com with SMTP id ld10so124198pab.40
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=lUXfR+rKDokd8QgM1fytccO+Oz/eWGRd98+Lph6ts10=;
        b=t5LV0gMdGMRJ7hcKRJz7yr/MdGQkrz5Va4RtSFmeu+ZkCar4qz1IC+SzU8Qsi8FhM5
         sWaL2r3sXZhQS54I2rY0XQb19hp9TroQA+ULKzRPrYM6fF539+6GNcVRuRkItqMlM5gU
         wFbG1M10Gk1N7UYof9MB1GcnSwaW+NIE47HySyLm0AN73L43lyGIhgu047TMQe8zf/mR
         CyrVWmlFGtSQYG5FJlUjrA91LBY3zjZZUtAjB9Xq6KAJArlZYlwymgJZgFwpHAafRXLh
         q725I/gUJHNsOWLNhV2BMQvq7179AAGL6Qu4bAjacmfigyXFQtNnEafXkUe1G8rHskih
         sqtg==
X-Received: by 10.68.231.196 with SMTP id ti4mr44123482pbc.48.1395736097450;
        Tue, 25 Mar 2014 01:28:17 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.28.16
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:28:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244948>

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
 t/t7408-submodule-reference.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7408-submodule-reference.sh b/t/t7408-submodule-referen=
ce.sh
index b770b2f..eaea19b 100755
--- a/t/t7408-submodule-reference.sh
+++ b/t/t7408-submodule-reference.sh
@@ -6,7 +6,7 @@
 test_description=3D'test clone --reference'
 . ./test-lib.sh
=20
-base_dir=3D`pwd`
+base_dir=3D$(pwd)
=20
 U=3D$base_dir/UPLOAD_LOG
=20
--=20
1.7.10.4
