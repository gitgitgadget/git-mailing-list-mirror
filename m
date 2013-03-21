From: Dan Bornstein <danfuzz@milk.com>
Subject: [PATCH] Correct the docs about GIT_SSH.
Date: Thu, 21 Mar 2013 23:06:40 +0000
Message-ID: <1363907200-12850-1-git-send-email-danfuzz@milk.com>
Cc: Dan Bornstein <danfuzz@milk.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 22 00:07:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIoZu-0003BY-3M
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 00:07:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754047Ab3CUXGy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 19:06:54 -0400
Received: from mail-vb0-f50.google.com ([209.85.212.50]:57868 "EHLO
	mail-vb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754037Ab3CUXGx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 19:06:53 -0400
Received: by mail-vb0-f50.google.com with SMTP id ft2so2309792vbb.9
        for <git@vger.kernel.org>; Thu, 21 Mar 2013 16:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=MsUyNakPHiZOrFOfWmbJul1XuFITrOP7B5oYlDIu8j0=;
        b=fGrLiVZ/bDOe9840+IHaCq+5syiHhMEFLKdY43k19qUO0Q1mTwP/tnPczL8o/MchS9
         nVR8Zy9GDB/36Kjy4XjE+u3vWIj9/PcRajSzXonFFZKVz7zw8TV4LPyfw0sCXK3PXik3
         +fu7jFDSVIcMoQ8mMoV/5LBEFhFMfXTQAKHXqA8N4llWy6/vFESlW+7CYD+lYQw9034J
         pQsGQQOztWEolfVDos9YWU2XXIEjuwzYu7iQZAR3PDAnCKB8SgwU5Q/X4+/fzsSpFq6u
         Qd1fakLifDRqDC8//gxc3w39mQmAgrp/TurdGHqfskGvipJ10n97Nc+aAChcW0Dmb6Pr
         NMHQ==
X-Received: by 10.52.93.20 with SMTP id cq20mr13731264vdb.38.1363907212532;
        Thu, 21 Mar 2013 16:06:52 -0700 (PDT)
Received: from localhost.localdomain (postham.org. [107.20.239.204])
        by mx.google.com with ESMTPS id l18sm43932602vdh.10.2013.03.21.16.06.51
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 21 Mar 2013 16:06:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218772>

In particular, it can get called with four arguments if you happen to
be referring to a repo using the ssh:// scheme with a non-default port
number.

Signed-off-by: Dan Bornstein <danfuzz@milk.com>
---
 Documentation/git.txt |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 7efaa59..4307d62 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -774,9 +774,12 @@ other
 	If this environment variable is set then 'git fetch'
 	and 'git push' will use this command instead
 	of 'ssh' when they need to connect to a remote system.
-	The '$GIT_SSH' command will be given exactly two arguments:
-	the 'username@host' (or just 'host') from the URL and the
-	shell command to execute on that remote system.
+	The '$GIT_SSH' command will be given exactly two or
+	four arguments: the 'username@host' (or just 'host')
+	from the URL and the shell command to execute on that
+	remote system, optionally preceded by '-p' (literally) and
+	the 'port' from the URL when it specifies something other
+	than the default SSH port.
 +
 To pass options to the program that you want to list in GIT_SSH
 you will need to wrap the program and options into a shell script,
-- 
1.7.4.5
