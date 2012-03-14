From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 1/5 v2] contrib/diffall: comment actual reason for 'cdup'
Date: Wed, 14 Mar 2012 12:38:02 -0400
Message-ID: <1331743086-32304-2-git-send-email-tim.henigan@gmail.com>
References: <1331743086-32304-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Mar 14 17:39:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7rEi-0004Nl-Kp
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 17:39:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759450Ab2CNQjc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 12:39:32 -0400
Received: from mail-fa0-f46.google.com ([209.85.161.46]:48428 "EHLO
	mail-fa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753018Ab2CNQja (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 12:39:30 -0400
Received: by faas1 with SMTP id s1so430530faa.19
        for <git@vger.kernel.org>; Wed, 14 Mar 2012 09:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=10Tk6JDD54UOtsyxiAS0cl4pZBDOOh4ji7U+ePEte50=;
        b=cstSWKveKdBjZTte7Z/2I2LmIHvwNDPBH00n9bB4ekHr4cXc1GH6sMA1r8/LWuBsuy
         UEC21cTHoVlRYGuHv00UleVQhv3I0O6clW0ob5zwcQ4++vGgMxIf69BEdpqAJ9eOH85Z
         FvnSHvJaZBin/Z1POomHzWlIuMkSMFCbno08GMthlOC9rMRTDyJCNG40xIqJxoqpW0Fw
         1QvKAkzJESshjijHn83mWUj1gr2Tupvw4Fya4KMe8Q1N0b9J/dw8jMlRIgQU2C8T043B
         0yRcNXDpOgtD2bnnXrMqvThr5shR9RncXengMAG7DicY2l3CHKoiKulxtBVZWLGV86yl
         5gKg==
Received: by 10.224.106.131 with SMTP id x3mr3899338qao.23.1331743169006;
        Wed, 14 Mar 2012 09:39:29 -0700 (PDT)
Received: from localhost ([99.38.69.118])
        by mx.google.com with ESMTPS id cw5sm9608998qab.20.2012.03.14.09.39.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Mar 2012 09:39:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc0
In-Reply-To: <1331743086-32304-1-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193127>

The comment from an earlier commit did not reflect the actual reason this
operation is needed.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---

v2 did not affect this patch.


 contrib/diffall/git-diffall |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/contrib/diffall/git-diffall b/contrib/diffall/git-diffall
index 9bbd27f..d706a6d 100755
--- a/contrib/diffall/git-diffall
+++ b/contrib/diffall/git-diffall
@@ -36,7 +36,9 @@ fi
 
 start_dir=$(pwd)
 
-# needed to access tar utility
+# All the file paths returned by the diff command are relative to the root
+# of the working copy. So if the script is called from a subdirectory, it
+# must switch to the root of working copy before trying to use those paths.
 cdup=$(git rev-parse --show-cdup) &&
 cd "$cdup" || {
 	echo >&2 "Cannot chdir to $cdup, the toplevel of the working tree"
-- 
1.7.10.rc0
