From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 4/7] remote-bzr: update working tree
Date: Sun, 11 Nov 2012 15:19:55 +0100
Message-ID: <1352643598-8500-5-git-send-email-felipe.contreras@gmail.com>
References: <1352643598-8500-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 15:20:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXYOy-0007nI-8G
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 15:20:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752843Ab2KKOU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 09:20:29 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:47320 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752171Ab2KKOU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 09:20:28 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so2064575bkc.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 06:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Tj1pggz5HAKKUokSe2j6ZWUP2ve9FMT4QjnibiG0nd4=;
        b=1GRCE0wPy0Z7WtF5FPvPxoOH+8JovQA3rdiW3GSLgwVSBrjz6NTu8ASv9I38x7r+1M
         7ocydR6GaFvUwGYqdrxZ0waOw4n5Ms+Yw4pbySnWsXZPHouTeB26s7n/51pSkjp+YZfl
         0+YL2ESoBPTHFHpM2Q+JcvNV1ibTixgY0lUFjErvWQS35dWvUaUKv1i3QbLfR8dD9Hjf
         aGo4zPlyR0thdbrGpGdzaZabZ493synAv7ROFxs/TDlQ1hKfw+df6ZdgQ8md/q6t5QAB
         3EhPKxFG8u4xJ4jx6zHv/EKeH/YqgEGronN1dvcmVmmmzcfIOIOCp2iYtUWSnoeHFpRS
         BOjw==
Received: by 10.204.156.81 with SMTP id v17mr5929137bkw.49.1352643627469;
        Sun, 11 Nov 2012 06:20:27 -0800 (PST)
Received: from localhost (ip-109-43-0-127.web.vodafone.de. [109.43.0.127])
        by mx.google.com with ESMTPS id 9sm1502295bkq.13.2012.11.11.06.20.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 06:20:26 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352643598-8500-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209379>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 2c05f35..5b89a05 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -571,6 +571,8 @@ def do_export(parser):
             repo.generate_revision_history(revid, marks.get_tip('master'))
             revno, revid = repo.last_revision_info()
             peer.import_last_revision_info_and_tags(repo, revno, revid)
+            wt = peer.bzrdir.open_workingtree()
+            wt.update()
         print "ok %s" % ref
     print
 
-- 
1.8.0
