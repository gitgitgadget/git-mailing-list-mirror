From: Elijah Newren <newren@gmail.com>
Subject: [RFC PATCHv2 12/16] t6050 (replace): add missing &&
Date: Fri, 24 Sep 2010 16:22:52 -0600
Message-ID: <1285366976-22216-13-git-send-email-newren@gmail.com>
References: <1285366976-22216-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 25 00:22:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzGep-0000n6-0E
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 00:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758276Ab0IXWVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 18:21:43 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:45160 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758264Ab0IXWVm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 18:21:42 -0400
Received: by gyd8 with SMTP id 8so1138845gyd.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 15:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=hHGkoU7vmODcCHHFHnyfmGsCO60ii2xWIckfZzbkrzk=;
        b=QyzIif08kkg/rcP4f/bRXaHry4tnS0JhDNdrCr8R7YRXLIqeN4JlwIBxBIBkq6Ku/z
         ogF4WntOEL7eoyEw7qQ719hYExq+Xx5eUbXXMDUQIOganxq3M0RJn19puXPxWUeck5B+
         3bBIwQJOuJSeH/I75WApXVLmmQX+fgdWScjKg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Zr4XlOHtTwILhcJWEwh9L8yopELag9LgLqVd+ynHdoziZcjoAVs4JnHCD5fWRVfHzu
         yNOcxxNIEhTVCHbIecEpZ/LEi7GhrGPZtvbYkpKcecqNZSp/CnAEkVbe9CaDvaVUgC/u
         BcCP4iiVNehVcTaVC/NwnLZufhX5lnxaXNc5I=
Received: by 10.220.125.3 with SMTP id w3mr722004vcr.118.1285366901484;
        Fri, 24 Sep 2010 15:21:41 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id r35sm1865945vbw.17.2010.09.24.15.21.39
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 15:21:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.95.g14291
In-Reply-To: <1285366976-22216-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157082>

FIXME: Is the grep really meant to fail?

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6050-replace.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index c907523..b0d47bc 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -205,8 +205,8 @@ test_expect_success 'fetch branch with replacement' '
      git branch tofetch $HASH6 &&
      (
 	  cd clone_dir &&
-	  git fetch origin refs/heads/tofetch:refs/heads/parallel3
-	  git log --pretty=oneline parallel3 | grep $PARA3
+	  git fetch origin refs/heads/tofetch:refs/heads/parallel3 &&
+	  git log --pretty=oneline parallel3 | test_must_fail grep $PARA3 &&
 	  git show $PARA3 | grep "A U Thor"
      )
 '
-- 
1.7.3.95.g14291
