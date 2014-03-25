From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 075/144] t5601-clone.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:25:20 -0700
Message-ID: <1395735989-3396-76-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:28:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMiX-0008K0-TQ
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:28:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753913AbaCYI2E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:28:04 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:40839 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753905AbaCYI2A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:28:00 -0400
Received: by mail-pb0-f47.google.com with SMTP id up15so133899pbc.6
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=4qeTwsaXcWEQfPlRMmPtG5qEPxjYkUuhaoueUNtvq9w=;
        b=FL/t6a6fYA7BsCbuoy+35uabbO3Rgd+4r1GYluOVPzMafCWAo/Za6vjOHTp/DY5Xub
         APVKdAtdtXrq8UDN2ymCrRk8btTnfawZDgpwAY0s6+WBvrlZBT9E7oJdVYAC2BFFjZsf
         ljr1XZddea+kAIn6q+d+l/R+UjVMzCby46VCjUYPIOcndNGR80LtVTrrLDbPHfHjbjiL
         pFh0vApwzhAtZuR96ta1aarw669njCMZMtLz5KOL3R6rWg/cxdnpUWBmSHSpRqZK6Pma
         F/jMvsMYx3pAeN9KklNwaVYxS19IS2zqrr2U27smFbWMHMgOIOzYbXwImmwknnjGG1g2
         fYDg==
X-Received: by 10.66.226.145 with SMTP id rs17mr8520029pac.144.1395736079921;
        Tue, 25 Mar 2014 01:27:59 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.58
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244929>

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
 t/t5601-clone.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 5e67035..fbe83a1 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -221,7 +221,7 @@ test_expect_success 'clone separate gitdir' '
 '
=20
 test_expect_success 'clone separate gitdir: output' '
-	echo "gitdir: `pwd`/realgitdir" >expected &&
+	echo "gitdir: $(pwd)/realgitdir" >expected &&
 	test_cmp expected dst/.git
 '
=20
--=20
1.7.10.4
