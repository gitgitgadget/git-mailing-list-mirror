From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 0/5] difftool: Use symlinks in dir-diff mode
Date: Sun, 22 Jul 2012 20:57:06 -0700
Message-ID: <1343015831-17498-1-git-send-email-davvid@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 05:57:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1St9mM-0000L6-Tm
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 05:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370Ab2GWD5H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jul 2012 23:57:07 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:56934 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752976Ab2GWD5G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2012 23:57:06 -0400
Received: by pbbrp8 with SMTP id rp8so10168206pbb.19
        for <git@vger.kernel.org>; Sun, 22 Jul 2012 20:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=rCc2q5oAW1MWDq4QhPLY2CER8iSlPM1Y4W7Id3UnZHo=;
        b=M6kbnhIgWIkS//lByn0gn4Zwx+PfBNcD9ADlNemAlHFphvTg6IySZ49puCsu7gyxMw
         qUSVwHOoeS1lCMkBFsTDVIlb3iODkOYXIbeCedrYRaS4YXoTlIK/mYFqO2cfn23zlRFm
         n2oEBfU7+5yHSpo/HsJkmScJ9xaFdYeH3jB3MMQzh+9mSH0XxsBshaePEa1iAVk9JKlm
         rq5K5naRCcMuGyCjC0+D+hGhhY5QcYJaOBOoPVS2Jik5mz2Q8pN+lI8uxdPIpTi+l7Yj
         flLy9fQPKgCuhM8ccJ9hQpKFrghwyKPHpH8ban6QPe2Z8B/ncHSYLvFWD04QV5jPXgOf
         /ILg==
Received: by 10.68.218.7 with SMTP id pc7mr31753960pbc.88.1343015825524;
        Sun, 22 Jul 2012 20:57:05 -0700 (PDT)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id iw10sm8485543pbc.55.2012.07.22.20.57.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 22 Jul 2012 20:57:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.2.255.g5f133da
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201886>

Teach the difftool script to use symlinks when doing
directory diffs in --dir-diff mode.

This is v2 of the patch because I had a typo in one of the
commit messages and gmail ate 4/5 in the last round.

David Aguilar (5):
  difftool: Simplify print_tool_help()
  difftool: Eliminate global variables
  difftool: Move option values into a hash
  difftool: Call the temp directory "git-difftool"
  difftool: Use symlinks when diffing against the worktree

 Documentation/git-difftool.txt |   8 ++
 git-difftool.perl              | 184 ++++++++++++++++++++++++-----------------
 2 files changed, 115 insertions(+), 77 deletions(-)

-- 
1.7.11.2.255.g5f133da
