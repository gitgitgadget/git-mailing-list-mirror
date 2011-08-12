From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 13/56] t6022: Remove unnecessary untracked files to make test cleaner
Date: Thu, 11 Aug 2011 23:19:46 -0600
Message-ID: <1313126429-17368-14-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:21:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkBO-0004nj-D5
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:21:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752636Ab1HLFVD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:21:03 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:39648 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752422Ab1HLFVA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:21:00 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so835125iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=hK+0e3m4q1M+yEhSH03K10hp4CeTgQmvs35e13DcP5g=;
        b=QnBqA+yE2zhyPW9xNpRjgnfnZga5AoYLbTrVILffHzN2nfxA72s+sfa5heCYv8b3xL
         syPjZ9MTFB1Sb+adFauVq8kcL4SeGCosN0wJkHK5UoR8/Feyfykz1WIuFocErLjdm3At
         QybYJ33aOtgl6ajYOXYUwTnyYi3VLopGMFnLA=
Received: by 10.42.144.68 with SMTP id a4mr473291icv.427.1313126459868;
        Thu, 11 Aug 2011 22:20:59 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.20.56
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:20:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179171>

Since this test later does a git add -A, we should clean out unnecessary
untracked files as part of our cleanup.

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
No changes since v1.

 t/t6022-merge-rename.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index 1ed259d..1d1b32e 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -252,6 +252,7 @@ test_expect_success 'setup for rename + d/f conflicts' '
 	git reset --hard &&
 	git checkout --orphan dir-in-way &&
 	git rm -rf . &&
+	git clean -fdqx &&
 
 	mkdir sub &&
 	mkdir dir &&
-- 
1.7.6.100.gac5c1
