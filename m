From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 13/48] t6022: Remove unnecessary untracked files to make test cleaner
Date: Wed,  8 Jun 2011 01:30:43 -0600
Message-ID: <1307518278-23814-14-git-send-email-newren@gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
Cc: jgfouca@sandia.gov, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 09:32:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUDFU-0007JK-UW
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 09:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755346Ab1FHHbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 03:31:50 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:35036 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754789Ab1FHH3V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 03:29:21 -0400
Received: by mail-pw0-f46.google.com with SMTP id 15so118980pwi.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=Go7wZHsT6v7BUNCIF8hvUd1NenXznSJB0TLFXr5Mtq4=;
        b=m/SxQcIJx1P6H43pwW2k1DZL/qlQb8lWWZgtVOqtlEqVDUd6UqZxnlv1Pp/dgpB9ch
         QotwJx54Dyhm+5BphHJ5nB8FfNAk8q6cHYDzxy1GzSl8GYr6gKlK+DFH3bVltokoa5rI
         GVISUQKZw555wlxpTdwy9EUFoRrMos6Lva1G8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ffKe2ZskT4utUGBIquMFS0R3jpEWIJE991NMtFZaQMQ0kR0GO61kO/bfONF3IgEUQw
         J5AskOcRH8peBcX1GA47x5SmLfzQc43lbdWt76s1ESlq4UnpQYn1b8lIkt05I8rercCN
         oqgQg5CiukfP7OkjAaDUZaPILj2dtVIb/62Z8=
Received: by 10.68.21.231 with SMTP id y7mr591816pbe.493.1307518160900;
        Wed, 08 Jun 2011 00:29:20 -0700 (PDT)
Received: from localhost.localdomain ([216.222.84.34])
        by mx.google.com with ESMTPS id k4sm296286pbl.59.2011.06.08.00.29.18
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 00:29:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.62.g2d69f
In-Reply-To: <1307518278-23814-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175339>

Since this test later does a git add -A, we should clean out unnecessary
untracked files as part of our cleanup.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
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
1.7.6.rc0.62.g2d69f
