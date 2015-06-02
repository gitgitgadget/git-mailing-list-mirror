From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH/RFC v3 1/4] git-am.sh: fix initialization of the threeway variable
Date: Tue,  2 Jun 2015 19:34:03 +0200
Message-ID: <1433266446-2845-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Cc: Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 19:34:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yzq54-0006az-Sl
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 19:34:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759890AbbFBReV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 13:34:21 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:48557 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754320AbbFBReP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Jun 2015 13:34:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 663A027BC;
	Tue,  2 Jun 2015 19:34:12 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hAlOtle9yqPp; Tue,  2 Jun 2015 19:34:12 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 54B7F27A4;
	Tue,  2 Jun 2015 19:34:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 4978220E4;
	Tue,  2 Jun 2015 19:34:12 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rZHbSXGwvaW7; Tue,  2 Jun 2015 19:34:12 +0200 (CEST)
Received: from Groseille.grenet.fr (wificampus-030200.grenet.fr [130.190.30.200])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id DC9C620DD;
	Tue,  2 Jun 2015 19:34:11 +0200 (CEST)
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270568>

Initialization for the threeway variable was missing. This caused
a behavior change for command lines like:

	threeway=t git am ...

This commit fixes the bug.

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
