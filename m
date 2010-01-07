From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [StGit PATCH 2/2] Pass the --in-reply-to and --no-thread options to
	git send-email
Date: Thu, 07 Jan 2010 16:09:38 +0000
Message-ID: <20100107160937.3226.14811.stgit@pc1117.cambridge.arm.com>
References: <20100107160932.3226.95737.stgit@pc1117.cambridge.arm.com>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 17:09:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSuvs-0007q6-6i
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 17:09:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753187Ab0AGQJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 11:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753170Ab0AGQJm
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 11:09:42 -0500
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:54441 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752910Ab0AGQJl (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jan 2010 11:09:41 -0500
Received: from cam-owa1.Emea.Arm.com (cam-owa1.emea.arm.com [10.1.255.62])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id o07G9ceI016713;
	Thu, 7 Jan 2010 16:09:38 GMT
Received: from pc1117.cambridge.arm.com ([10.1.255.212]) by cam-owa1.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
	 Thu, 7 Jan 2010 16:09:38 +0000
In-Reply-To: <20100107160932.3226.95737.stgit@pc1117.cambridge.arm.com>
User-Agent: StGit/0.15-33-g331e
X-OriginalArrivalTime: 07 Jan 2010 16:09:38.0390 (UTC) FILETIME=[CFEE4F60:01CA8FB3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136352>

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---
 stgit/commands/mail.py |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index a78c9d2..b6f5d8d 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -241,6 +241,10 @@ def __send_message_git(msg, options):
     cmd.append("--suppress-cc=self")
     if not options.auto:
         cmd.append("--suppress-cc=body")
+    if options.in_reply_to:
+        cmd.append("--in-reply-to %s" % options.in_reply_to)
+    if options.no_thread:
+        cmd.append("--no-thread")
 
     # We only support To/Cc/Bcc in git send-email for now.
     for x in ['to', 'cc', 'bcc']:
