From: Elijah Newren <newren@gmail.com>
Subject: [RFC PATCHv2 09/16] t4026 (color): add missing &&
Date: Fri, 24 Sep 2010 16:22:49 -0600
Message-ID: <1285366976-22216-10-git-send-email-newren@gmail.com>
References: <1285366976-22216-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 25 00:22:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzGen-0000n6-Tz
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 00:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758270Ab0IXWVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 18:21:37 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:54878 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758264Ab0IXWVf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 18:21:35 -0400
Received: by gxk9 with SMTP id 9so1130112gxk.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 15:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=MXhm6ZwouWKeCnj69BbSt0cmyJt12t+l7zbTjQrmsPc=;
        b=KscZtP6+WaeUtX9F/Xmg9K4Wr/i7CVOmaMuNHtIghABkeblDtWzxrQPLctW1oSYOsJ
         cGaZw8Us9/JMyPhWdNsuTXv3ijGKxXmv5gC0/DatRyz7td7hA8/es0jthj8tt0NgD0FD
         Ykck/i6IWcfi2e56ZiqbM9sYeIXUOqg+ZDlIg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FHeA2N5VNJ9IzyZbCxxO4l4wHt6dVuTrWYEvwvqK2vN1aDeZDPRTh/HKcLsWhZlkZs
         8i2KeWT8doOOHQEDbMHLRnt5t4Tf6man7X9NL4hB16JojeiKP+Zne8v6fvCyKhKUG/kr
         lyohQMBalsW4hi4y2qCcjz6PkvaFOs0NZkzJI=
Received: by 10.220.121.222 with SMTP id i30mr866974vcr.15.1285366894856;
        Fri, 24 Sep 2010 15:21:34 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id r35sm1865945vbw.17.2010.09.24.15.21.32
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 15:21:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.95.g14291
In-Reply-To: <1285366976-22216-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157083>

FIXME: Is it intended that this git config --unset fail?  I had to add a
test_might_fail as well.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t4026-color.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t4026-color.sh b/t/t4026-color.sh
index d5ccdd0..156f6da 100755
--- a/t/t4026-color.sh
+++ b/t/t4026-color.sh
@@ -74,7 +74,7 @@ test_expect_success 'extra character after attribute' '
 '
 
 test_expect_success 'unknown color slots are ignored (diff)' '
-	git config --unset diff.color.new
+	test_might_fail git config --unset diff.color.new &&
 	git config color.diff.nosuchslotwilleverbedefined white &&
 	git diff --color
 '
-- 
1.7.3.95.g14291
