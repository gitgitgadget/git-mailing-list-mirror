From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] contrib: related: print the amount of involvement
Date: Fri,  7 Jun 2013 17:07:44 -0500
Message-ID: <1370642864-32544-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 08 00:09:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul4qp-000503-Ce
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 00:09:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756680Ab3FGWJf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 18:09:35 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:51036 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756051Ab3FGWJe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 18:09:34 -0400
Received: by mail-ob0-f180.google.com with SMTP id eh20so7429701obb.11
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 15:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=Sc5z/Z1PCqeN+BUwZ8qWcvzCk1nQyPRmhshMyuNPhcM=;
        b=OzmBi7VVoECDB+fspaw+MumZItJgxx/j0sBnPuEu5cgO/z/K874OWicSNmPd1TGJaK
         dz/cnPg2j3t819IqieyM9YP5xs/FkqaFBpmO5FSNBZEC//dm89jS7bpVsVwtY3MI+vXM
         /6JDyis1C9AgZvRggf04bnXwYf+G3MPYCqk/acZdfP4vkMwB0CSa1AnxXwdXbUubufdT
         dHAUPjPiHUgI1jzAI83mysj3epa1XWulByfavUeMCYc46GN0itPm+Xg0ZkdFn+DGwalc
         +JkqBgwNNUx7TlHr21/IahWnLwcax2asYtXaWNfr3WHbLmGT6DzrmH7EWVODkqXb85SF
         05tQ==
X-Received: by 10.182.237.50 with SMTP id uz18mr484108obc.51.1370642974082;
        Fri, 07 Jun 2013 15:09:34 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id zn5sm870306obc.10.2013.06.07.15.09.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 15:09:33 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226750>

100% means the person was involved in all the commits, in one way or the
other.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

It's barely useful for me without this.

This sits on top of the last git-related series.

 contrib/related/git-related | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/related/git-related b/contrib/related/git-related
index bded6f6..f0bda55 100755
--- a/contrib/related/git-related
+++ b/contrib/related/git-related
@@ -168,5 +168,5 @@ end
 count_per_person.each do |person, count|
   percent = count.to_f * 100 / commits.size
   next if percent < $min_percent
-  puts person
+  puts '%s (involved: %u%%)' % [person, percent]
 end
-- 
1.8.3.698.g079b096
