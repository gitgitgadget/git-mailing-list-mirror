From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 28/36] rebase: cherry-pick: fix status messages
Date: Sun,  9 Jun 2013 14:24:42 -0500
Message-ID: <1370805890-3453-29-git-send-email-felipe.contreras@gmail.com>
References: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 21:28:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UllHm-0003yF-8U
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473Ab3FIT2K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 15:28:10 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:62132 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457Ab3FIT2F (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:28:05 -0400
Received: by mail-ob0-f180.google.com with SMTP id eh20so8868204obb.39
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 12:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=331G0X2B8CWYEfIyHWoyi9GxkLMKeaB/taAJEl6Lgic=;
        b=XiCzYz9+Sc+4LX47yMgzOYdOjLS+nDigvo/l3Gz1DkqN1B1iJPl+JuEsxoWwxeT8Wd
         g5h41kBbHmEAJ4V9xicaFhlGQZQgCeJOWofvpVDGuzUmUYmg2Z0X+E1WVUVE6XlVwl6C
         wlKyDOho/jQpOBqa5Qa3XQsPL9WpktYgMOPoPcm1tJC6QTC+68Zkqrgd53FIaUqLblFY
         PNqd50DfYoYGWiCCBqqZ9MB2QeHxiS3tfTRtaF94J8wjJOYU+1JMffxl0k/TTuliqG3H
         0NBjRX33VlFZuzCQfRtuzmByzooxSFucT40QKgwsMKBz372wfzAsSTeeflOopiaqhOay
         MIUw==
X-Received: by 10.60.51.105 with SMTP id j9mr5762710oeo.22.1370806084863;
        Sun, 09 Jun 2013 12:28:04 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id w7sm15975396obx.9.2013.06.09.12.28.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 12:28:04 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227136>

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
