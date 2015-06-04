From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH v5 1/3] git-am.sh: fix initialization of the threeway variable
Date: Fri,  5 Jun 2015 01:24:42 +0200
Message-ID: <1433460284-20240-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Cc: Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 05 01:25:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0eVX-00006S-Ew
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 01:25:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753672AbbFDXY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 19:24:58 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:54820 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753518AbbFDXY5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Jun 2015 19:24:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 4133725E8;
	Fri,  5 Jun 2015 01:24:54 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XSVUtqVMR8di; Fri,  5 Jun 2015 01:24:54 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr (zm-smtpauth-1.grenet.fr [130.190.244.122])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 306D120FE;
	Fri,  5 Jun 2015 01:24:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTP id 28A4020DC;
	Fri,  5 Jun 2015 01:24:54 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MDoO74U3cw87; Fri,  5 Jun 2015 01:24:54 +0200 (CEST)
Received: from Groseille.home (AGrenoble-652-1-407-223.w90-42.abo.wanadoo.fr [90.42.42.223])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTPSA id 29CF420D4;
	Fri,  5 Jun 2015 01:24:53 +0200 (CEST)
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270806>

Initialization for the threeway variable was missing. This caused
a behavior change for command lines like:

	threeway=t git am ...

This commit adds initialization for this variable.

Signed-off-by: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
---
 git-am.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-am.sh b/git-am.sh
index 761befb..c460dd0 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -378,6 +378,7 @@ committer_date_is_author_date=
 ignore_date=
 allow_rerere_autoupdate=
 gpg_sign_opt=
+threeway=
 
 if test "$(git config --bool --get am.messageid)" = true
 then
-- 
1.9.1
