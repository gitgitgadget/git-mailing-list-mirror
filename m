From: Elijah Newren <newren@gmail.com>
Subject: [RFC PATCHv2 13/16] t7001 (mv): add missing &&
Date: Fri, 24 Sep 2010 16:22:53 -0600
Message-ID: <1285366976-22216-14-git-send-email-newren@gmail.com>
References: <1285366976-22216-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 25 00:22:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzGeq-0000n6-3I
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 00:22:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758283Ab0IXWVr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 18:21:47 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:45492 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758264Ab0IXWVo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 18:21:44 -0400
Received: by mail-qy0-f181.google.com with SMTP id 33so4608692qyk.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 15:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=GJFRQIJsHF0AAW8pBfij0vvclwX76RDa4KB6S3WoyLU=;
        b=OArB2PzCXfnjwPGq2bhW1fmvPxYvGuJN6vTqyA798h1f7eOcghAeqDlnp53E8aYc2g
         xQKnXLn5n/C2LYcd5P3QAsj65AuQc0CMiFZRH8f3X6Bb1xOMyiN09nc92LhiHQigQ9Im
         ttmn6RbVp9SPoOgyXeYfhrwh4eEKgkKMvTbog=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=NNvvoS42stTMAsVwpZYrIxEnzwYmxym6IxiK22v8z9MnFs27sVrvO+/sOQnetS618S
         kYJVR5bGQYlZ2OxTRWe/Yta5jepPM4oN1v+weQpabE/rTZ5WBfjZ28jK8yavdjgdSVwP
         neHJ70HNt/terBBygQ/PL0EjXeE1gV5siWLzs=
Received: by 10.220.121.146 with SMTP id h18mr568107vcr.193.1285366903943;
        Fri, 24 Sep 2010 15:21:43 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id r35sm1865945vbw.17.2010.09.24.15.21.41
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 15:21:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.95.g14291
In-Reply-To: <1285366976-22216-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157087>

FIXME: I believe the mv was meant to fail here so I added a test_must_fail;
was that the right change?

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t7001-mv.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 65a35d9..624e6d2 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -61,7 +61,7 @@ test_expect_success \
 test_expect_success \
     'checking -f on untracked file with existing target' \
     'touch path0/untracked1 &&
-     git mv -f untracked1 path0
+     test_must_fail git mv -f untracked1 path0 &&
      test ! -f .git/index.lock &&
      test -f untracked1 &&
      test -f path0/untracked1'
-- 
1.7.3.95.g14291
