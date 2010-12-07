From: "Alan Raison" <alan@theraisons.me.uk>
Subject: [PATCH] Corrected return values in post-receive-email.prep_for_email
Date: Tue, 7 Dec 2010 16:32:43 -0000
Message-ID: <002501cb962c$5fa3aa40$1eeafec0$@me.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <alan@theraisons.me.uk>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 07 17:48:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ0i2-0003tv-Hm
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 17:48:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752629Ab0LGQsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 11:48:05 -0500
Received: from gateway.bjss.co.uk ([77.86.30.29]:53513 "EHLO
	gateway.bjss.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521Ab0LGQsE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 11:48:04 -0500
X-Greylist: delayed 913 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Dec 2010 11:48:04 EST
Received: from exchange.bjss.co.uk ([172.22.32.28]) by gateway.bjss.co.uk with Microsoft SMTPSVC(6.0.3790.4675);
	 Tue, 7 Dec 2010 16:32:44 +0000
Received: from kitkat ([172.22.33.188]) by exchange.bjss.co.uk with Microsoft SMTPSVC(6.0.3790.4675);
	 Tue, 7 Dec 2010 16:32:43 +0000
X-Mailer: Microsoft Office Outlook 12.0
thread-index: AcuWLF+N6XHzcA4lQSi4mAEcV8q5gw==
Content-Language: en-gb
X-OriginalArrivalTime: 07 Dec 2010 16:32:43.0602 (UTC) FILETIME=[5F8D6320:01CB962C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163089>

---
 contrib/hooks/post-receive-email |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/hooks/post-receive-email
b/contrib/hooks/post-receive-email
index 85724bf..020536d 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -150,7 +150,7 @@ prep_for_email()
 			# Anything else (is there anything else?)
 			echo >&2 "*** Unknown type of update to $refname
($rev_type)"
 			echo >&2 "***  - no email generated"
-			return 0
+			return 1
 			;;
 	esac
 
@@ -166,10 +166,10 @@ prep_for_email()
 		esac
 		echo >&2 "*** $config_name is not set so no email will be
sent"
 		echo >&2 "*** for $refname update $oldrev->$newrev"
-		return 0
+		return 1
 	fi
 
-	return 1
+	return 0
 }
 
 #
-- 
1.7.3.1.msysgit.0
