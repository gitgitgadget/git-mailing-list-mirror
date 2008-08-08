From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH] tg.sh: it's info/attributes not info/gitattributes
Date: Fri,  8 Aug 2008 08:43:17 +0200
Message-ID: <1218177797-21589-1-git-send-email-bert.wesarg@googlemail.com>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Aug 08 08:44:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRLi5-0005V6-Cr
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 08:44:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753077AbYHHGnY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 02:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752937AbYHHGnY
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 02:43:24 -0400
Received: from mu-out-0910.google.com ([209.85.134.187]:9869 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854AbYHHGnX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 02:43:23 -0400
Received: by mu-out-0910.google.com with SMTP id w8so1282347mue.1
        for <git@vger.kernel.org>; Thu, 07 Aug 2008 23:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Mqctw+Z6JMVt6dGvXz78E8Fl4Mlxcsf9EIF1dPabbw0=;
        b=EDMJ4zN3JnGftlZyaycUzBo7BK3kA/Q2OjZozXjeCnJP41a/tsTjKX7kffY3Am875r
         9kZJ3aqsy2IbGCD9LAqWZBflj2b6HQygPMMcMIIL96pGC8dt8xB2hcc3KTKMU3HrxAwl
         eCVkhPnIDJFUsGjEzD4IrAmsx1LmtJC4j/o1w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=KN5jfVgYEI+UEGMdv4Qr3UliiERmLdR4r5S1igNA1NAqB/c56joDY6ehotmfqXDga/
         Qp1NlyNQ76Z74llw5Wip5x2Vb0gr4PxaIxrs5bHklhDHo0iG8l+mLMLIA1KqfmwQIorc
         zBQPa0D847CUwOZaigudykggKPQQcjb6LQOGE=
Received: by 10.103.243.7 with SMTP id v7mr2778771mur.118.1218177800091;
        Thu, 07 Aug 2008 23:43:20 -0700 (PDT)
Received: from localhost ( [91.15.79.52])
        by mx.google.com with ESMTPS id s10sm1001783muh.10.2008.08.07.23.43.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 07 Aug 2008 23:43:19 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91626>

The merge attribute hasn't any effect, because the wrong attribute file was
used.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 tg.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tg.sh b/tg.sh
index 03a392b..209b69e 100644
--- a/tg.sh
+++ b/tg.sh
@@ -45,11 +45,11 @@ setup_hook()
 # setup_ours (no arguments)
 setup_ours()
 {
-	if [ ! -s "$git_dir/info/gitattributes" ] || ! grep -q topmsg "$git_dir/info/gitattributes"; then
+	if [ ! -s "$git_dir/info/attributes" ] || ! grep -q topmsg "$git_dir/info/attributes"; then
 		{
 			echo -e ".topmsg\tmerge=ours"
 			echo -e ".topdeps\tmerge=ours"
-		} >>"$git_dir/info/gitattributes"
+		} >>"$git_dir/info/attributes"
 	fi
 	if ! git config merge.ours.driver >/dev/null; then
 		git config merge.ours.name '"always keep ours" merge driver'
-- 
tg: (e311d15..) t/its-info-attributes (depends on: master)
