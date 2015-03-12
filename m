From: Sveinung Kvilhaugsvik <sveinung84@users.sourceforge.net>
Subject: [PATCH] git-completion: add stashes for gitk
Date: Thu, 12 Mar 2015 01:42:41 +0100
Message-ID: <1426120961-2273-1-git-send-email-sveinung84@users.sourceforge.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sveinung Kvilhaugsvik <sveinung84@users.sourceforge.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 12 01:44:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVrEH-0007sW-QP
	for gcvg-git-2@plane.gmane.org; Thu, 12 Mar 2015 01:44:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752186AbbCLAnS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2015 20:43:18 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:45995 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbbCLAnP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2015 20:43:15 -0400
Received: by lamq1 with SMTP id q1so12448177lam.12
        for <git@vger.kernel.org>; Wed, 11 Mar 2015 17:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=+Eo6nPFCaPV4lXsyaS+MdS47F4OEiAH4GPPSplkB5Jc=;
        b=0tg1tv6ZqDcOTR4uTIpd7HVtG2Ec8F71LwKrlxQN2kide/KRFCNADLTFsW4AqRmbRs
         2bS/ilddNk6fuUmsUdU+O57e1KIrt8N+ALEdEaMRUWR7HJ6yZYA2suh7a5Ur/aH01MO4
         6zFY2bomXy52iDm7H4ZpdjNtoVijltLv5BGlt32gWYROgFSNs5W7H3IyRi78VdgxhYjT
         PwTlSwBlQGmtI7CKcpWdrJJzNv/qz1sESX7o+D/FrfYwE2+LVoT0YvcdJHa432O4IfIR
         i+9FD5yG3LcdeqseLJ1xy0U4Q/PCMb1FLZ4D0zMzfK2o8S04ZBq8eV91t9ocRktkfOY0
         X2DQ==
X-Received: by 10.112.154.163 with SMTP id vp3mr12488653lbb.93.1426120993814;
        Wed, 11 Mar 2015 17:43:13 -0700 (PDT)
Received: from mini.iad.ventelo.no ([217.118.50.150])
        by mx.google.com with ESMTPSA id cf1sm872682lbb.19.2015.03.11.17.43.11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Mar 2015 17:43:11 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265348>

Auto complete stashed modifications for gitk. This makes them easier to
discover and faster to view.

Signed-off-by: Sveinung Kvilhaugsvik <sveinung84@users.sourceforge.net>
---
 contrib/completion/git-completion.bash | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c21190d..3a23abb 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2644,6 +2644,8 @@ __gitk_main ()
 		;;
 	esac
 	__git_complete_revlist
+	__gitcomp_nl_append "$(git --git-dir="$(__gitdir)" stash list \
+			| sed -n -e 's/:.*//p')"
 }
 
 if [[ -n ${ZSH_VERSION-} ]]; then
-- 
2.1.4
