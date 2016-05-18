From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH 09/21] i18n: rebase: fix marked string to use eval_gettext variant
Date: Wed, 18 May 2016 15:27:42 +0000
Message-ID: <1463585274-9027-10-git-send-email-vascomalmeida@sapo.pt>
References: <1463585274-9027-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 18 17:30:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b33QH-00015O-KU
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 17:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbcERPaC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 11:30:02 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:58583 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932198AbcERPaB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 11:30:01 -0400
Received: (qmail 20477 invoked from network); 18 May 2016 15:29:59 -0000
Received: (qmail 21191 invoked from network); 18 May 2016 15:29:59 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 18 May 2016 15:29:54 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1463585274-9027-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294952>

The string message marked for translation should use eval_gettext
variant instead of the gettext one, since we want to dollar-substitute
$head_name in the result.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 git-rebase.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 44ede36..1fadc04 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -154,7 +154,7 @@ move_to_original_branch () {
 		git symbolic-ref \
 			-m "rebase finished: returning to $head_name" \
 			HEAD $head_name ||
-		die "$(gettext "Could not move back to $head_name")"
+		die "$(eval_gettext "Could not move back to \$head_name")"
 		;;
 	esac
 }
-- 
2.7.3
