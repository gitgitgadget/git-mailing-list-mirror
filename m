From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 2/9] remote-hg: remove extra check
Date: Fri, 26 Apr 2013 16:12:32 -0500
Message-ID: <1367010759-17928-3-git-send-email-felipe.contreras@gmail.com>
References: <1367010759-17928-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 23:14:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVpy9-0007H1-LO
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 23:14:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757427Ab3DZVOD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 17:14:03 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:32895 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754987Ab3DZVOC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 17:14:02 -0400
Received: by mail-oa0-f44.google.com with SMTP id h1so4448677oag.3
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 14:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=RdafLDl0DdIqCjxo/ljXSMJAXshSoDjH5DcSTZzDDms=;
        b=Mw2aTCMCDlt8ibEK5ddzPa1r2NiEyYqi93FDmKTK0r2gomVfaqlgU/+6ey4KMzThSk
         F3u1gYc2v6brE7h+SUwVJ2jGrJyk0ilKFBXsosr3N9rEuC+nJgHZuODEPb4t3MEI+nWl
         riCzZtX5F1k3tuw7VJtWf7l4+Csoxu3j/JoNs4ftuRIGEmUSkZHXHUtIPIgECU9/u0dI
         DsTlZJbCB4scMv68IVdM4UEDiDfCzDgFcDUgb47pH8L4Y/i+rB8/YEqccGLzKJHdI5Jv
         tahQdApZIQ7pYZ5PsS4vXUE5wMQOlPyeVm5EXVEnM41xhhii/gc7iOlABSwQXElQ7P2Q
         Opig==
X-Received: by 10.60.135.103 with SMTP id pr7mr18889366oeb.142.1367010841570;
        Fri, 26 Apr 2013 14:14:01 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id rn6sm6195956oeb.0.2013.04.26.14.13.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 26 Apr 2013 14:14:00 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.1031.g2ee5873
In-Reply-To: <1367010759-17928-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222585>

Not needed since we use xrange ourselves.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index cfa96c1..80b3606 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -373,10 +373,6 @@ def export_ref(repo, name, kind, head):
     ename = '%s/%s' % (kind, name)
     tip = marks.get_tip(ename)
 
-    # mercurial takes too much time checking this
-    if tip and tip == head.rev():
-        # nothing to do
-        return
     revs = xrange(tip, head.rev() + 1)
     count = 0
 
-- 
1.8.2.1.1031.g2ee5873
