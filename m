From: David Cowden <dcow90@gmail.com>
Subject: [PATCH] Clarify pre-push hook documentation
Date: Sun, 23 Mar 2014 12:08:29 -0700
Message-ID: <1395601709-78479-1-git-send-email-dcow90@gmail.com>
References: <1395601267-78377-1-git-send-email-dcow90@gmail.com>
Cc: David Cowden <dcow90@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 23 20:22:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WRnyg-0007sA-De
	for gcvg-git-2@plane.gmane.org; Sun, 23 Mar 2014 20:22:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752924AbaCWTW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2014 15:22:28 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:63179 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414AbaCWTI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2014 15:08:59 -0400
Received: by mail-pb0-f43.google.com with SMTP id um1so4508327pbc.16
        for <git@vger.kernel.org>; Sun, 23 Mar 2014 12:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z2rsxLxv1nblQsvZnxQpktfPy3sLEQx/wdxHcuvsIB8=;
        b=Y/LFeTjZVw57tTyIJrcCiwsZPEvkzXFdmGDZpl0Ie2t9xhjteU4QBlNLaulV7n9OCh
         /ToFSFZ3Yof12VLTEpxrcX3kVqnnnLbYUkvqJxlBuULUOIDGzJMp+9bPZQ1n4rUPlbaw
         kByy5YrbV6WHQEevhHgUreFHWUjk8sYU1x+hqayKQX3bD6q4Cm5RG8dKDQaZerzwFL6o
         m45MFtW7VdoU9YnyD1VmTBb+9hVKiiPDLOjF93JlQHsHXbNM6fiiGQoALF850wLG7C60
         uBSCJdUX9plhuQWoKYCNlUgR/WgbMd+lqRxVu0WeYYgELJNWbbkylnvRFhgNrsipga+L
         zoQg==
X-Received: by 10.68.254.103 with SMTP id ah7mr2797011pbd.159.1395601738742;
        Sun, 23 Mar 2014 12:08:58 -0700 (PDT)
Received: from localhost.localdomain (99-119-66-90.lightspeed.sntcca.sbcglobal.net. [99.119.66.90])
        by mx.google.com with ESMTPSA id hc4sm26562065pbc.29.2014.03.23.12.08.57
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 23 Mar 2014 12:08:58 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1395601267-78377-1-git-send-email-dcow90@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244801>

The documentation as-is does not mention that the pre-push hook is
executed even when there is nothing to push.  This can lead a new
reader to beilieve there will always be lines fed to the script's
standerd input and cause minor confusion as to what is happening
when there are no lines provided to the pre-push script.

Signed-off-by: David Cowden <dcow90@gmail.com>
---

Notes:
    c.f. http://stackoverflow.com/questions/22585091/git-hooks-pre-push-script-does-not-receive-input-via-stdin

 Documentation/githooks.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index d954bf6..a28f6f7 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -203,6 +203,10 @@ SHA-1>` will be 40 `0`.  If the local commit was specified by something other
 than a name which could be expanded (such as `HEAD~`, or a SHA-1) it will be
 supplied as it was originally given.
 
+The hook is executed regardless of whether there are changes to push or not.
+In the event that there are no changes, no data will be provided on the
+script's standard input.
+
 If this hook exits with a non-zero status, 'git push' will abort without
 pushing anything.  Information about why the push is rejected may be sent
 to the user by writing to standard error.
-- 
1.9.1
