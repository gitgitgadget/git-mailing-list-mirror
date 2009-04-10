From: "Daniel Cheng (aka SDiZ)" <j16sdiz+freenet@gmail.com>
Subject: [DOC PATCH] State the effect of filter-branch on graft explicitly
Date: Fri, 10 Apr 2009 14:26:49 +0800
Message-ID: <1239344809-4451-1-git-send-email-j16sdiz+freenet@gmail.com>
Cc: git@vger.kernel.org,
	"Daniel Cheng (aka SDiZ)" <j16sdiz+freenet@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Apr 10 08:28:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsAE9-00049l-QY
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 08:28:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937949AbZDJG1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2009 02:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936604AbZDJG1D
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 02:27:03 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:24550 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937942AbZDJG07 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Apr 2009 02:26:59 -0400
Received: by wf-out-1314.google.com with SMTP id 29so968396wff.4
        for <git@vger.kernel.org>; Thu, 09 Apr 2009 23:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=GGRR8pJj+bA8XRBG/PGp9hY3glQ5KZ5+L7wGZ7OA3Xk=;
        b=FjY79wAaZ0OEVby43OEIaZrHuRfr83ez/1m6hF8Lrj+n2F2f6d9KP197GBpt34WWmM
         lGAjzMJRXBVbsvgvh6yHglS6f8hN0SSapZZq1cZ5vaLWymrXYBa6DHjJUK4BbHhjCPPk
         2Kf5Z+FvTqhBtt9d1LCqhPObZxTGGivYu2BOw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=Ru0CFIvKQIDSv8qkU/E7if7cXz06FRsgBM5liKJDJcXn2P+HJOGxeIDO0AjqFjbai0
         STlbXwiyuNVFXX/7nEN4n63rYautFVMFMWfmAh4AQKi9hspKeXx594nbRdzbdowgG3AN
         lJRE9Kd+/HgzOsMqsQ7+BBCsnp4zoXlaNZxds=
Received: by 10.142.193.10 with SMTP id q10mr1183373wff.48.1239344815682;
        Thu, 09 Apr 2009 23:26:55 -0700 (PDT)
Received: from localhost.localdomain (n1164956087.netvigator.com [116.49.56.87])
        by mx.google.com with ESMTPS id 28sm2799703wfd.25.2009.04.09.23.26.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Apr 2009 23:26:55 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116240>


Signed-off-by: Daniel Cheng (aka SDiZ) <j16sdiz+freenet@gmail.com>
---

The documentation state nothing about effect of graft in filter-branch.
The only (implicit) reference is the "simplier" method in the example
section.

This patch make the reference explicit.


 Documentation/git-filter-branch.txt |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 237f85e..e281290 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -31,6 +31,9 @@ changes, which would normally have no effect.  Nevertheless, this may be
 useful in the future for compensating for some git bugs or such,
 therefore such a usage is permitted.
 
+*NOTE*: This command honor `.git/info/grafts`. If you have any grafts
+defined, running this command will make them permanent.
+
 *WARNING*! The rewritten history will have different object names for all
 the objects and will not converge with the original branch.  You will not
 be able to easily push and distribute the rewritten branch on top of the
-- 
1.6.2.1
