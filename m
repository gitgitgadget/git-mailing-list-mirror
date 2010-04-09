From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2] branch: say "Reset to" in reflog entries for 'git branch -f' operations
Date: Fri,  9 Apr 2010 20:38:18 +0800
Message-ID: <1270816698-3464-1-git-send-email-rctay89@gmail.com>
References: <1270799112-4308-1-git-send-email-rctay89@gmail.com>
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Johannes Sixt <j.sixt@viscovery.net>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 09 14:38:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0DTq-00078H-LN
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 14:38:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752115Ab0DIMib (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 08:38:31 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:62491 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917Ab0DIMib (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 08:38:31 -0400
Received: by qyk9 with SMTP id 9so1269669qyk.1
        for <git@vger.kernel.org>; Fri, 09 Apr 2010 05:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=3OqaXKh783BxQsQy+bwKqpFkexILDmldIgK3QKk3J4g=;
        b=pWGoRJEITwgn1qBHKieebTxG1M2yXYT1FyUQZldG1lgoRhb0KktZMPn9wfCVfZ3ai6
         2nV3dDG8ayrlIw9favtf+BrLQsiCvzN1aUuHrmeXET4MHx/C4mUgfz8t6ysg97TELUXB
         jj51ocBNyeRiSYZgfDlBmPL1IdFD1NZEuypiU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=YiJn5eqklvZOHUMjmLlSCnWZJlHDDmJWHUHE08Oduxp1lCd9qRoTdza/3ziR/tPiQg
         LrZdbbr0GVaGz9wxLBvzsnKDe2chKVcDKCoRcDLk2Hko+t+U3+67lwWw3BDfYkU25BOa
         IVG4RFfrbXYbuMUpD+1IMw22auoEReKWW9ldI=
Received: by 10.229.221.14 with SMTP id ia14mr2545634qcb.8.1270816710117;
        Fri, 09 Apr 2010 05:38:30 -0700 (PDT)
Received: from localhost.localdomain ([116.87.153.46])
        by mx.google.com with ESMTPS id v37sm1737126qce.18.2010.04.09.05.38.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Apr 2010 05:38:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc0.240.gba75f
In-Reply-To: <1270799112-4308-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144430>

In 5f856dd (fix reflog entries for "git-branch"), it is mentioned that
'git branch -f' is intended to be equivalent to 'git reset'. Since we
usually say "reset to <commit>" in the git-reset Documentation and
elsewhere, it would make sense to say "Reset to" here as well, instead
of "Reset from" previously.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

Changed from v1:
 - Mention old reflog message in patch message, as suggested by
   Michael J Gruber.

 branch.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/branch.c b/branch.c
index 9e1f63e..2ab42aa 100644
--- a/branch.c
+++ b/branch.c
@@ -198,7 +198,7 @@ void create_branch(const char *head,
 		log_all_ref_updates = 1;

 	if (forcing)
-		snprintf(msg, sizeof msg, "branch: Reset from %s",
+		snprintf(msg, sizeof msg, "branch: Reset to %s",
 			 start_name);
 	else if (!dont_change_ref)
 		snprintf(msg, sizeof msg, "branch: Created from %s",
--
1.7.1.rc0.240.gba75f
