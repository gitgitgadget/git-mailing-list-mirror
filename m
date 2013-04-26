From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 2/9] remote-hg: remove extra check
Date: Thu, 25 Apr 2013 19:08:15 -0500
Message-ID: <1366934902-18704-3-git-send-email-felipe.contreras@gmail.com>
References: <1366934902-18704-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 02:09:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVWEY-0003aH-7N
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 02:09:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360Ab3DZAJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 20:09:45 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:65479 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932256Ab3DZAJo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 20:09:44 -0400
Received: by mail-ob0-f171.google.com with SMTP id er7so3053785obc.16
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 17:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=qt99CvBUS18MGzMupacMSYg71WxjkWtS8zHTXgJw2Y0=;
        b=o97GdkGhS7ZIDmkFlajVbYMVXcAuKMhyAPFm08pa76Vx9wzxJQLNgSNkmk/8wKA2wu
         uirGvHuk/YG6nx9QmlQzfqt9mzTHGb5nH2EpXCN4mWR6VUJs8Dm8GOn/QKV0YPGbDeaf
         awoqj6LhwAJLAIMhjNQOQvUtdieVw4a0QnMolqtcNbSWr9YlhDOnY0scBaSajSBzWxBW
         jOZ0o+0KF4nbWiCoHYr/skAI9dYxwcWaIknHUpkk0ORXOQezzzZseZkiLEGt6Gp/O+Li
         2v1DIa8Z8d5Azg6gJ1Ibac8qhbiBxfNRQiQayYWDi5eeR7bnmnbP27rlXIa/MsPJAdgv
         vNVw==
X-Received: by 10.182.125.200 with SMTP id ms8mr16209493obb.67.1366934984363;
        Thu, 25 Apr 2013 17:09:44 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id ns4sm5650456obc.2.2013.04.25.17.09.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 17:09:43 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.884.g3532a8d
In-Reply-To: <1366934902-18704-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222471>

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
1.8.2.1.884.g3532a8d
