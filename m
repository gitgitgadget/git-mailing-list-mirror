From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 073/144] t5551-http-fetch-smart.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:25:18 -0700
Message-ID: <1395735989-3396-74-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:31:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMlS-0003Pq-0m
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:31:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753990AbaCYIan convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:30:43 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:47054 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753903AbaCYI16 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:58 -0400
Received: by mail-pa0-f42.google.com with SMTP id fb1so130521pad.15
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=nVBULub6QcI8S/QNt4bpbnoxGq0hmafX6LnvsqIBIDg=;
        b=0QsOMsslqsezgtt/rliHmKS3eR2sJiDukwAOVPeurVpRericWe7MlreU9Dkr/ia9XH
         1BBgXPNCyw9pdzwxkt4VV+4ojIZdobrqWAnrlwPbdKglHg2DIROM4ZrAtKh8ypgbqUVX
         4zZModHLd7jKy5Re1IT8QOPPnhWMnGITQUt3e7eHrE+9DZQ0RczURA/rMtv5qFYf3GR5
         focB3j3IjkNADM/zKM4ik/FsfT50G5vMOTjM9ZzQhGe2JG4bG1EkVgF92sXgFOCx0SDO
         CNyYD1zg45/VqHisQ9OGrVXDoq8uq0UnWai5g/rX4s63q2GjTQRqdIc0oQ+SKeOVDhP/
         qmrg==
X-Received: by 10.68.88.193 with SMTP id bi1mr14470744pbb.129.1395736077802;
        Tue, 25 Mar 2014 01:27:57 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.56
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244962>

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
 t/t5551-http-fetch-smart.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index e07eaf3..232c5ac 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -218,7 +218,7 @@ test -n "$GIT_TEST_LONG" && test_set_prereq EXPENSI=
VE
 test_expect_success EXPENSIVE 'create 50,000 tags in the repo' '
 	(
 	cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
-	for i in `test_seq 50000`
+	for i in $(test_seq 50000)
 	do
 		echo "commit refs/heads/too-many-refs"
 		echo "mark :$i"
--=20
1.7.10.4
