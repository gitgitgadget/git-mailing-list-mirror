From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/6] completion: add common options for blame
Date: Sun,  2 Jun 2013 19:33:39 +0530
Message-ID: <1370181822-23450-4-git-send-email-artagnon@gmail.com>
References: <1370181822-23450-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 02 16:06:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uj8vI-0000ue-Ec
	for gcvg-git-2@plane.gmane.org; Sun, 02 Jun 2013 16:06:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752943Ab3FBOGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jun 2013 10:06:10 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:36487 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752627Ab3FBOGF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jun 2013 10:06:05 -0400
Received: by mail-pd0-f174.google.com with SMTP id 3so4469627pdj.19
        for <git@vger.kernel.org>; Sun, 02 Jun 2013 07:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=qGE/2qc9fTuKxBmfkmkIElgat3C3n9r+d8uqes97f0k=;
        b=Pit7hUXhAEVH8oMpSx7tzDLGaqDIBA06ExSRjlZYxmvpc7Nd0t7OULqEYYrhG7mZJB
         ThmmI6wScM1pRBcPwJwUE2UQ0C7OvPg+EYz+yk19Bls9ryOPYeFXqJlzzojag476pV3h
         KT3m8IzaxQF5AKZIKCUlAuIgDPtUzJmqFIS0A6La+UsOIqH9AaZM97JojpD9cy6u53LF
         1pZ4u69smZ6Lsx+3w7UDhQpR3XFT/TE2CKrhuq7bRMoWcLA/GUzrFFq/cab2+zXHwia7
         EOmNReE5FllEDycyOcwqyS52pZY2pLuHiBYWfNK/oPT3cb4jLWpLsYpNZ6uzcgbYbx8M
         jhGQ==
X-Received: by 10.68.196.231 with SMTP id ip7mr20027730pbc.61.1370181965263;
        Sun, 02 Jun 2013 07:06:05 -0700 (PDT)
Received: from localhost.localdomain ([122.164.162.188])
        by mx.google.com with ESMTPSA id aj2sm55150689pbc.1.2013.06.02.07.06.03
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 02 Jun 2013 07:06:04 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.457.g2410d5e
In-Reply-To: <1370181822-23450-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226154>

Add support for completing 'git blame'.  List only the common short
options.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 contrib/completion/git-completion.bash | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 139f48e..a003b81 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1034,6 +1034,17 @@ _git_bisect ()
 	esac
 }
 
+_git_blame ()
+{
+	__git_has_doubledash && return
+
+	case "$cur" in
+	-*)
+		__gitcomp "-M -C -L -s -w"
+	esac
+	__git_complete_revlist_file
+}
+
 _git_branch ()
 {
 	local i c=1 only_local_ref="n" has_r="n"
-- 
1.8.3.457.g2410d5e
