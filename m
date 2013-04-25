From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/9] remote-hg: remove extra check
Date: Thu, 25 Apr 2013 06:20:42 -0500
Message-ID: <1366888849-19607-3-git-send-email-felipe.contreras@gmail.com>
References: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 25 13:22:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVKFs-0003yK-Rk
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 13:22:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758098Ab3DYLWV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 07:22:21 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:36456 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757999Ab3DYLWU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 07:22:20 -0400
Received: by mail-oa0-f50.google.com with SMTP id j6so2677405oag.37
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 04:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=Kq9K5gBKaK+lq+U9t2OxU3aymXh7MXEmDjISclkFPjw=;
        b=0T+0VfgM8983RzKk6G7nbFWb4OHOwFPTziYK3++Go0NQ+k9ROv4LccP3GHdFmcFAyN
         fzgOjn9bWKdum3FcHdpJeroduJC1NEDSzVkWuzGl6Pjk7X1XWIy0SxjS6TMbg7J7PwLc
         wFRG9WZjefuKfm6gd00+L9JXv42P4BQtEmE/c5VzS8S2wxUAnZN+9KO8PIACTSe/VYrt
         AzaiZnYJlkvj3DRVwg/UcCmgdu00q9CK74e0sa0Eywte485VqEMjRlUGnPSa78q6cS7B
         dnC0iC9LT+EVdx4z2gBmQF3x3eTD9/gS5B3Jh4fd2iA17qbyakHNt3veL4RHHZ4oPXSQ
         X17Q==
X-Received: by 10.60.142.230 with SMTP id rz6mr20945081oeb.22.1366888939618;
        Thu, 25 Apr 2013 04:22:19 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id qj8sm3194079oeb.2.2013.04.25.04.22.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 04:22:18 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222370>

Not needed since we use xrange ourselves.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 5481331..0b7c81f 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -332,10 +332,6 @@ def export_ref(repo, name, kind, head):
     ename = '%s/%s' % (kind, name)
     tip = marks.get_tip(ename)
 
-    # mercurial takes too much time checking this
-    if tip and tip == head.rev():
-        # nothing to do
-        return
     revs = xrange(tip, head.rev() + 1)
     count = 0
 
-- 
1.8.2.1
