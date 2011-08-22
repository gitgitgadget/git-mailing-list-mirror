From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH v3 5/5] git-p4: Process detectCopiesHarder with --bool
Date: Mon, 22 Aug 2011 09:33:09 +0100
Message-ID: <1314001989-29017-6-git-send-email-vitor.hda@gmail.com>
References: <1314001989-29017-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Tor Arvid Lund <torarvid@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 22 10:34:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvPxp-0001Q3-U6
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 10:34:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754957Ab1HVIe1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 04:34:27 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:58449 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754802Ab1HVIeX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 04:34:23 -0400
Received: by mail-ww0-f44.google.com with SMTP id 5so4968962wwf.1
        for <git@vger.kernel.org>; Mon, 22 Aug 2011 01:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=SJBLBDXDN7ym8EamhOoMdYmySyhRdG59PmR4vYQKabM=;
        b=E6dTlAQySq6f/LsPTwDOPtw9ymXJwAtJJ0KOM65Toug/ZZUisAJSek/tFeqjJp1jOv
         zaNcw5bm/yLCGNp0aeKt/a7cd40kZvwAClZbkl9PG3l4I9hrHKzraqb1KDtYJ42P4TP+
         W10PtnMPTdiTb0HOC6zUbhcsfy931GDSgGsIk=
Received: by 10.217.6.11 with SMTP id x11mr1726832wes.77.1314002062371;
        Mon, 22 Aug 2011 01:34:22 -0700 (PDT)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id e44sm3284981wed.41.2011.08.22.01.34.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 22 Aug 2011 01:34:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1314001989-29017-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179849>

Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
---
 contrib/fast-import/git-p4 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 29a5390f..0db3e72 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -789,7 +789,7 @@ class P4Submit(Command, P4UserMap):
         elif detectCopies != "" and detectCopies.lower() != "false":
             diffOpts += " -C%s" % detectCopies
 
-        if gitConfig("git-p4.detectCopiesHarder").lower() == "true":
+        if gitConfig("git-p4.detectCopiesHarder", "--bool") == "true":
             diffOpts += " --find-copies-harder"
 
         diff = read_pipe_lines("git diff-tree -r %s \"%s^\" \"%s\"" % (diffOpts, id, id))
-- 
1.7.5.4
