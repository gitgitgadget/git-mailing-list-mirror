From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv3 08/16] t4026 (color): add missing &&
Date: Sat, 25 Sep 2010 13:06:59 -0600
Message-ID: <1285441627-28233-9-git-send-email-newren@gmail.com>
References: <1285441627-28233-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 25 21:06:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oza4s-0005Xq-M0
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 21:06:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756652Ab0IYTFp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 15:05:45 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54740 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968Ab0IYTFo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 15:05:44 -0400
Received: by mail-pz0-f46.google.com with SMTP id 34so891416pzk.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 12:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=6wShRmU3MBsmqYBq9HO2HX0tkMXJvbzzfuEV9X8fgn0=;
        b=a6yjX2msfwW18WNqbka8YgMD+ncw7MhDpOBV9xpKtSO7siCmgIPSr4sTqms6EW/c9L
         n6amHfY4ewWFDRGpkwLIN+QpoAxgYbMmkM7JL1oSI1LPi+qM11cHxW4xDda/CyugD3De
         GzhfjoH8+6zGRkb6a7JB/AOPC9cmZ+Wvkf9Bs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=g+4fag6etsabUPqAWUvTLe117DT/i0xDDl/Lh3yjZRJoysIIjEm3OdbGh6ESHhy8ir
         A6wIMqYJGODTLBPJEPEcWnYjlFsmCq0wcE6cRUHXQ+cZDCBPlBrnzYOowixBT5s1WWw6
         7HboSIjwA2BmRvyY8SSdF4Tg1ePUUQ3WnglZ8=
Received: by 10.114.89.15 with SMTP id m15mr5651780wab.106.1285441543774;
        Sat, 25 Sep 2010 12:05:43 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id o17sm6338669wal.21.2010.09.25.12.05.41
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 25 Sep 2010 12:05:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.95.g14291
In-Reply-To: <1285441627-28233-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157178>

Ever since 8b12413 (color: allow multiple attributes 2010-02-27),
diff.color.new has been unused in t4026, so also remove the final unsetting
of that value to make the third to last test pass with appropriate
chaining.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t4026-color.sh |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/t/t4026-color.sh b/t/t4026-color.sh
index d5ccdd0..3726a0e 100755
--- a/t/t4026-color.sh
+++ b/t/t4026-color.sh
@@ -74,7 +74,6 @@ test_expect_success 'extra character after attribute' '
 '
 
 test_expect_success 'unknown color slots are ignored (diff)' '
-	git config --unset diff.color.new
 	git config color.diff.nosuchslotwilleverbedefined white &&
 	git diff --color
 '
-- 
1.7.3.95.g14291
