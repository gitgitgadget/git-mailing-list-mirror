From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH V2 1/2] git-p4: Make rename test case runnable under dash
Date: Sat, 28 Mar 2015 00:03:02 +0000
Message-ID: <1427500983-8802-2-git-send-email-vitor.hda@gmail.com>
References: <1427500983-8802-1-git-send-email-vitor.hda@gmail.com>
Cc: Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 28 01:03:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbeDz-0002eT-Vp
	for gcvg-git-2@plane.gmane.org; Sat, 28 Mar 2015 01:03:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752719AbbC1ADg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2015 20:03:36 -0400
Received: from mail-wg0-f50.google.com ([74.125.82.50]:34405 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239AbbC1ADf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2015 20:03:35 -0400
Received: by wgbdm7 with SMTP id dm7so8957876wgb.1
        for <git@vger.kernel.org>; Fri, 27 Mar 2015 17:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GiWxq/zPWrG2RWYwfhS+3P6MTb1oBI5UTN5eMgnFOV0=;
        b=i+CxNc+HszYNMzjx1txUJ5fuo13/evimH8YxTVM+byHKXa+gxpr9BjXObqHuve37aW
         TnAuk0J7mxsAFHIwpoclUH0FFfP8Es0RTLufMS8VepWtoqYIDw8FrnlrKRut+FC1FWmr
         cpLBowigylLkojWSuW4MCoUOqUluQr9wozsIkCZu32qW6bKksU17BGaD2oDgYL1IstU2
         F/Q8fYgu1BCG5Eujdw2vSNCzjoJtJl+aUIA1ytLx3WUgT6ah+4Bt9oRwp+DkS2yGxW9b
         r5bZq6clh64rR2+XIweR+IarxNSwK/WB+7RBQkpf/1dFlombCQ64DCOxXi6djvozhDZp
         q+Sw==
X-Received: by 10.180.96.197 with SMTP id du5mr2106469wib.68.1427501014303;
        Fri, 27 Mar 2015 17:03:34 -0700 (PDT)
Received: from localhost.localdomain (88.41.108.93.rev.vodafone.pt. [93.108.41.88])
        by mx.google.com with ESMTPSA id hn8sm4879409wib.18.2015.03.27.17.03.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Mar 2015 17:03:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1427500983-8802-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266406>


Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
---
 t/t9814-git-p4-rename.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9814-git-p4-rename.sh b/t/t9814-git-p4-rename.sh
index 95f4421..efae143 100755
--- a/t/t9814-git-p4-rename.sh
+++ b/t/t9814-git-p4-rename.sh
@@ -180,7 +180,7 @@ test_expect_success 'detect copies' '
 		case "$src" in
 		file10 | file11) : ;; # happy
 		*) false ;; # not
-		&&
+		esac &&
 		git config git-p4.detectCopies $(($level + 2)) &&
 		git p4 submit &&
 		p4 filelog //depot/file12 &&
@@ -197,7 +197,7 @@ test_expect_success 'detect copies' '
 		case "$src" in
 		file10 | file11 | file12) : ;; # happy
 		*) false ;; # not
-		&&
+		esac &&
 		git config git-p4.detectCopies $(($level - 2)) &&
 		git p4 submit &&
 		p4 filelog //depot/file13 &&
-- 
1.7.10.4
