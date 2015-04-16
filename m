From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH] test-lib-functions.sh: fix the second argument to some helper functions
Date: Thu, 16 Apr 2015 07:12:07 -0700
Message-ID: <1429193527-1528-1-git-send-email-gitter.spiros@gmail.com>
Cc: Matthieu.Moy@imag.fr, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 16 16:12:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YikWq-0000Sh-LF
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 16:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757272AbbDPOMY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 10:12:24 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:35833 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754180AbbDPOMV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 10:12:21 -0400
Received: by pdbqd1 with SMTP id qd1so93414119pdb.2
        for <git@vger.kernel.org>; Thu, 16 Apr 2015 07:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Po26fpBGaROCAmn5PqzskggGWh7Zfwtk4WhD8b64UKw=;
        b=Hd6KDqWQbWdYJlCsDBthkC8hchDJkgCaW2xPx0gAYOaTTXCNJg2Iu6QrL73L2hy00W
         vcrld2tZsn3pL8UMYlZM0NNqqdUrwSN61op9em5tNiMhAC1P21Q6Fw4U/L1sTyzx5T+S
         MJXwSy4171DIsb7LHdjOlsrDjQRt4XZMovDqTsR8AYE0TUMIk6bGYT2h/0yI8KP63JJa
         WTsJFhjPZn+/tHO5cpYyI2lFGHVJZbwmdqhuqNAXPNXMgZjLHeMUL2yZQIiOjLkUCIOg
         AOTKak9uzYFEQKtZz+SzynJu4QmYVtOkCm6ZNoTPfKn6974jrPL5APoVNkmn/JTTViKm
         shtA==
X-Received: by 10.70.0.98 with SMTP id 2mr57243332pdd.55.1429193541218;
        Thu, 16 Apr 2015 07:12:21 -0700 (PDT)
Received: from ubuntu14.nephoscale.com (141.195.207.67.nephoscale.net. [67.207.195.141])
        by mx.google.com with ESMTPSA id sf6sm7284243pbb.82.2015.04.16.07.12.19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Apr 2015 07:12:20 -0700 (PDT)
X-Mailer: git-send-email 2.1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267289>

The second argument to test_path_is_file and test_path_is_dir
must be $2 and not $*, which instead would repeat the file
name in the error message.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 t/test-lib-functions.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 0698ce7..8f8858a 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -478,7 +478,7 @@ test_external_without_stderr () {
 test_path_is_file () {
 	if ! test -f "$1"
 	then
-		echo "File $1 doesn't exist. $*"
+		echo "File $1 doesn't exist. $2"
 		false
 	fi
 }
@@ -486,7 +486,7 @@ test_path_is_file () {
 test_path_is_dir () {
 	if ! test -d "$1"
 	then
-		echo "Directory $1 doesn't exist. $*"
+		echo "Directory $1 doesn't exist. $2"
 		false
 	fi
 }
-- 
2.1.0
