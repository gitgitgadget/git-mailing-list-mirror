From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 28/45] rebase: cherry-pick: fix status messages
Date: Sun,  9 Jun 2013 11:40:40 -0500
Message-ID: <1370796057-25312-29-git-send-email-felipe.contreras@gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 18:44:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulij1-00074a-5X
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 18:44:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752239Ab3FIQoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 12:44:12 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:47135 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362Ab3FIQoK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 12:44:10 -0400
Received: by mail-ob0-f173.google.com with SMTP id wc20so8973362obb.18
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 09:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=331G0X2B8CWYEfIyHWoyi9GxkLMKeaB/taAJEl6Lgic=;
        b=LraGIuF+XullE2/SmeCIhIvIq9rVzpeOS2rMBLZqMjMOw9sP34jhuaHrLV0A1hO35s
         Vx496e1tunBKY+ENMnOfANlYjIGaDU1z4e7AmpLt+yvAEceYuEovOgMBR2b17guRZ+RE
         P6Kl28bGrBqiRGxCT9QFjdAepzUiY0el1mM+qqbJWjkNB4X3Ue8XiCFTA/I8+tbmHRag
         0b21zYlhlwZExct3EXmfgPvNLcMYhXgUmsq/l2O/FTVWV+cjYvhh/dx13RiZrJH8By1Y
         /TXicQ4/J9OzuUcA+lq3Hyjow6pdoaj/KAbPzWPBphGpPYuuweZroHl1J7VcdtbrgzCG
         O8uA==
X-Received: by 10.60.124.18 with SMTP id me18mr5278839oeb.100.1370796250193;
        Sun, 09 Jun 2013 09:44:10 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id c10sm15206631oej.1.2013.06.09.09.44.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 09:44:09 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226994>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-rebase--cherrypick.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/git-rebase--cherrypick.sh b/git-rebase--cherrypick.sh
index e9ecccc..be17ec4 100644
--- a/git-rebase--cherrypick.sh
+++ b/git-rebase--cherrypick.sh
@@ -3,6 +3,9 @@
 # Copyright (c) 2010 Junio C Hamano.
 #
 
+GIT_CHERRY_PICK_HELP="$resolvemsg"
+export GIT_CHERRY_PICK_HELP
+
 case "$action" in
 continue)
 	git cherry-pick --continue &&
-- 
1.8.3.698.g079b096
