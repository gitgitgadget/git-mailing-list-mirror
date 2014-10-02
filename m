From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH/RFC 4/5] document the new "unset.variable" variable
Date: Thu,  2 Oct 2014 06:24:51 -0700
Message-ID: <1412256292-4286-5-git-send-email-tanayabh@gmail.com>
References: <1412256292-4286-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 02 15:26:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZgOY-0006Ru-H7
	for gcvg-git-2@plane.gmane.org; Thu, 02 Oct 2014 15:26:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752947AbaJBN0G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2014 09:26:06 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:37257 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445AbaJBN0E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2014 09:26:04 -0400
Received: by mail-pa0-f54.google.com with SMTP id ey11so2435382pad.13
        for <git@vger.kernel.org>; Thu, 02 Oct 2014 06:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VeWAmtdtXOLSlMkgnbPOrEISSt6cvypibZ7xDQfhOlw=;
        b=DTPWvrb+UyeQ7gwQgz0weh5PFoxhb8kV94xOeGkzRdHg7BiujJV0k/SS/gLfZ8iUWN
         F0z6f5nOXOPZqf+GCIa/zLMU70Vd71UPVs2p4mWjcwt/hZH0bWaZX8G8dfxRUEewssuQ
         u5dDdqcnVEQd1g4FhJIRguXJ0BfhwjEV+2rH0rFkPtyZ6WimBz/dAICDTx3omFJfM4uP
         mnW95gmMdh/aSDYvR5EAJITvmSQu0QU9a9Gblnz+m8E/wMsnTU+DWcrHVlxmZ34kzSyM
         9MO4S6ESQ8EzimcFPp/TUkG5eob86aDJN5bJREmC5C9DU5unREK1ltDXGMTdmChVhdK+
         z/fQ==
X-Received: by 10.69.31.138 with SMTP id km10mr69285009pbd.67.1412256364187;
        Thu, 02 Oct 2014 06:26:04 -0700 (PDT)
Received: from localhost.localdomain ([182.67.148.232])
        by mx.google.com with ESMTPSA id qp9sm3612065pbc.31.2014.10.02.06.26.01
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 02 Oct 2014 06:26:03 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1412256292-4286-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257804>

Helped-by: Matthieu Moy <Matthieu.Moy@imag.fr>
Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 Documentation/config.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3b5b24a..7f36d35 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2382,6 +2382,18 @@ transfer.unpackLimit::
 	not set, the value of this variable is used instead.
 	The default value is 100.
 
+unset.variable::
+	This variable can be used to unset previously set variables
+	which had been already declared in files of lower priority
+	or declared before in the same file. It does not unset
+	matching variables declared after its position in the file
+	or in files of higher priority. It can be used to unset
+	pesky variables declared in files which the user might not
+	be able to open due to not having the required security
+	privileges, for example, system wide configuration file
+	`/etc/gitconfig` which may be accessible to the system
+	administrator only.
+
 uploadarchive.allowUnreachable::
 	If true, allow clients to use `git archive --remote` to request
 	any tree, whether reachable from the ref tips or not. See the
-- 
1.9.0.GIT
